local Players_upv_1 = game:GetService("Players")
local RunService_upv_1 = game:GetService("RunService")
local Workspace_upv_1 = game:GetService("Workspace")
local Inputs_upv_1 = require(script:WaitForChild("Inputs"))
local WriteGuard_upv_1 = require(script:WaitForChild("WriteGuard"))
local Combat_upv_1 = require(script.Parent:WaitForChild("Combat"))
local tbl_upv_1 = {}
tbl_upv_1.Inputs = Inputs_upv_1
local function frames(a1)
    --[[
      name: frames
      line: 73
    ]]
    return (math.max(1, math.floor((a1 * 60) + 0.5)))
end
tbl_upv_1.BASE_SPEED = 21
tbl_upv_1.JUMP_HEIGHT = 7.4
local BASE_SPEED_upv_1 = tbl_upv_1.BASE_SPEED
local JUMP_HEIGHT_upv_1 = tbl_upv_1.JUMP_HEIGHT
local u1 = 39
local u2 = 48
local u3 = 15
local u4 = 13
local u5 = 11
local u6 = 45
local tbl_upv_2 = {"HumanoidRootPart", "Head", "UpperTorso", "LowerTorso"}
local u7 = 8
local u8 = 9
local u9 = 7
local u10 = 18
tbl_upv_1.SLIDE_TIME = 0.65
tbl_upv_1.SLIDE_START = 36
local tbl_upv_3 = {"SSpeed", "SSlide", "SSlideDir", "SSlideCD", "SSlideBuf", "SSlideIn", "SSlope", "SLift", "SJumpIn", "SJumpBuf", "SAir", "SJumped", "SJumping", "SGround", "SBoost", "SKb", "SKbF", "SKbN", "SDashV", "SDashF", "SDashCD", "SDashB", "SCharge", "SChargeRel", "SLungeIn", "SHipBase", "SHip", "SFrozen", "SSlow", "SNoJump", "STp", "SWade", "SWet"}
local u11 = RunService_upv_1:IsServer()
local u13 = (function()
    --[[
      name: detectClientAuthority
      line: 221
      upvalues:
        u11 (copy, index: 1)
        Workspace_upv_1 (copy, index: 2)
    ]]
    if u11 then
        local u12 = Instance.new("Part")
        u12.Name = "TribesAuthorityProbe"
        u12.Size = Vector3.new(1, 1, 1)
        u12.Transparency = 1
        u12.CanCollide = false
        u12.CanQuery = false
        u12.CanTouch = false
        u12.CFrame = CFrame.new(0, 4000, 0)
        u12.Parent = Workspace_upv_1
        local success_1 = pcall(
            function()
                --[[
                  line: 230
                  upvalues:
                    u12 (copy, index: 1)
                ]]
                u12:SetNetworkOwner(nil)
            end
        )
        u12:Destroy()
        Workspace_upv_1:SetAttribute("TribesAuthority", (success_1 and "Client") or "Server")
        return success_1
    else
        local v1 = Workspace_upv_1:GetAttribute("TribesAuthority")
        local v2 = os.clock()
        while v1 == nil do
            if os.clock() - v2 < 15 then
                task.wait()
                v1 = Workspace_upv_1:GetAttribute("TribesAuthority")
                continue
            else
                break
            end
        end
        return v1 == "Client"
    end
end)()
local v3 = u11
local u14
if v3 then
    u14 = not u13
else
    u14 = v3
end
local u15 = u11 and u13
tbl_upv_1.ClientAuthority = u13
tbl_upv_1.Authority = (u13 and "Client") or "Server"
local u16 = RunService_upv_1:IsStudio() and (Workspace_upv_1:GetAttribute("WaterSimOff") == true)
local u17 = RunService_upv_1:IsStudio() and (Workspace_upv_1:GetAttribute("SimAuditOff") == true)
local tbl_upv_4 = {}
local tbl_upv_5 = {}
local function rebuildList()
    --[[
      name: rebuildList
      line: 260
      upvalues:
        tbl_upv_5 (copy, index: 1)
        tbl_upv_4 (copy, index: 2)
    ]]
    table.clear(tbl_upv_5)
    for _, value_1 in tbl_upv_4 do
        table.insert(tbl_upv_5, value_1)
    end
end
local function q(a1, a2)
    --[[
      name: q
      line: 267
    ]]
    return math.floor((a1 / a2) + 0.5) * a2
end
local function flat(a1)
    --[[
      name: flat
      line: 271
    ]]
    return (Vector3.new(a1.X, 0, a1.Z))
end
local tbl_upv_6 = {STp = true, SNoJump = true, SFrozen = true, SSlow = true}
local function save(a1)
    --[[
      name: save
      line: 299
      upvalues:
        u13 (copy, index: 1)
        tbl_upv_3 (copy, index: 2)
        tbl_upv_6 (copy, index: 3)
    ]]
    local s_1 = a1.s
    local prev_1 = a1.prev
    local root_1 = a1.root
    if u13 then
        for _, value_2 in tbl_upv_3 do
            if tbl_upv_6[value_2] then
                continue
            end
            local v4 = s_1[value_2]
            if root_1:GetAttribute(value_2) ~= v4 then
                root_1:SetAttribute(value_2, v4)
            end
        end
    else
        for _, value_3 in tbl_upv_3 do
            local v5 = s_1[value_3]
            if v5 ~= prev_1[value_3] then
                root_1:SetAttribute(value_3, v5)
            end
        end
    end
end
local tbl_upv_7 = {}
local tbl_upv_8 = {Facing = true, Look = true}
local function actionState(a1, a2)
    --[[
      name: actionState
      line: 330
      upvalues:
        u13 (copy, index: 1)
        u11 (copy, index: 2)
        tbl_upv_8 (copy, index: 3)
        tbl_upv_7 (copy, index: 4)
    ]]
    if u13 and not (u11) and tbl_upv_8[a2] then
        return tbl_upv_7[a2]
    end
    local v6 = a1.actions[a2]
    if v6 then
        return v6:GetState()
    end
    return nil
end
local function held(a1, a2)
    --[[
      name: held
      line: 341
      upvalues:
        u13 (copy, index: 1)
        u11 (copy, index: 2)
        tbl_upv_8 (copy, index: 3)
        tbl_upv_7 (copy, index: 4)
    ]]
    local v7
    if u13 and not u11 and tbl_upv_8[a2] then
        v7 = tbl_upv_7[a2]
    else
        local v8 = a1.actions[a2]
        if v8 then
            v7 = v8:GetState()
        else
            v7 = nil
        end
    end
    local v9
    if v7 == true then
        v9 = true
    else
        v9 = false
    end
    return v9
end
local function finite2(a1)
    --[[
      name: finite2
      line: 345
    ]]
    local v10 = (typeof(a1) == "Vector2") and ((a1.X == a1.X) and ((a1.Y == a1.Y) and ((math.abs(a1.X) < 1e+06) and (math.abs(a1.Y) < 1e+06))))
    return v10
end
local function toolInSlot(a1, a2)
    --[[
      name: toolInSlot
      line: 381
    ]]
    local holdTool_1 = a1.holdTool
    local Backpack_1 = a1.player:FindFirstChild("Backpack")
    if a1.holdSlot == a2 and holdTool_1 and (holdTool_1:IsDescendantOf(a1.character) or Backpack_1 ~= nil and holdTool_1:IsDescendantOf(Backpack_1)) and holdTool_1:GetAttribute("SlotIndex") == a2 then
        return holdTool_1
    end
    a1.holdSlot = a2
    a1.holdTool = nil
    if not (a2 <= 0) then
        for _, value_4 in {a1.character, Backpack_1} do
            if not (value_4) then
                continue
            end
            for v1, value_5 in value_4:GetChildren() do
                if value_5:GetAttribute("SlotIndex") ~= a2 or value_5:GetAttribute("WeaponId") == nil then
                    continue
                end
                a1.holdTool = value_5
                return value_5
            end
        end
    end
    return nil
end
local u18 = 45
local function hipTarget(a1, a2)
    --[[
      name: hipTarget
      line: 434
    ]]
    local SHipBase_1 = a1.SHipBase
    if type(SHipBase_1) == "number" then
        local v11, v12 = nil, nil
        if a1.SSlide == nil then
            v11 = SHipBase_1
        else
            v11 = math.max(0.3, SHipBase_1 - 1.4)
            v12 = a1.SLift
            if type(v12) == "number" and v11 < v12 then
                v11 = v12
            end
        end
        if a2 and v11 < a2 then
            v11 = a2
        end
        return v11
    end
    return nil
end
local u19 = RaycastParams.new()
u19.FilterType = Enum.RaycastFilterType.Include
u19.FilterDescendantsInstances = {Workspace_upv_1.Terrain}
u19.IgnoreWater = false
local function probeBank(a1, a2, a3, a4)
    --[[
      name: probeBank
      line: 496
      upvalues:
        Workspace_upv_1 (copy, index: 1)
    ]]
    local v13 = a1.root.Position + a2 * 2
    local v14 = a4 + (a3 * 2) + 2.5
    local v15 = Workspace_upv_1:Raycast(Vector3.new(v13.X, v14, v13.Z), Vector3.new(0, -((v14 - a4) + 1), 0), a1.ray)
    if not v15 then
        return nil
    end
    v13 = v15.Position.Y - a4
    local v16 = a3 + 0.5
    local v17 = math.min(v13, v16) * math.clamp((v16 + 1) - v13, 0, 1)
    if v17 <= 0.01 then
        return nil
    end
    return math.floor(((a3 + v17) / 0.001) + 0.5) * 0.001
end
local function endSlide(a1)
    --[[
      name: endSlide
      line: 513
      upvalues:
        u2 (copy, index: 1)
    ]]
    if a1.SSlide == nil then
        return
    end
    a1.SSlide = nil
    a1.SSlideDir = nil
    a1.SSlope = nil
    a1.SLift = nil
    a1.SSlideCD = u2
    a1.SSpeed = math.max(a1.SSpeed, 17)
end
local function probeGround(a1, a2, a3, a4, a5, a6)
    --[[
      name: probeGround
      line: 550
      upvalues:
        Workspace_upv_1 (copy, index: 1)
    ]]
    local root_2 = a1.root
    local Position_1 = root_2.Position
    local v18 = Workspace_upv_1:Raycast(Position_1, Vector3.new(0, -((a5 + (root_2.Size.Y * 0.5)) + 1.5), 0), a1.ray)
    if not v18 then
        return nil, nil
    end
    local Normal_1 = v18.Normal
    local v19 = ((Normal_1.Y >= 0.5) and (math.clamp(a3 * (((Normal_1.X * a2.X) + (Normal_1.Z * a2.Z)) / Normal_1.Y), -12, 12) * 0.6)) or nil
    local Y_1 = v18.Position.Y
    local v20 = Workspace_upv_1:Raycast(Vector3.new(Position_1.X, Y_1 + 0.25, Position_1.Z), a2 * (((a4 * 0.16) + (((a1.hull) and (a1.hull.Size.Y * 0.5)) or (root_2.Size.Z * 0.5))) + 0.1), a1.ray)
    if v20 and not (v20.Normal.Y > 0.3) then
        local v21 = v20.Position + a2 * 0.3
        local v22 = Workspace_upv_1:Raycast(Vector3.new(v21.X, (Y_1 + a6) + 0.3, v21.Z), Vector3.new(0, -((a6 + 0.3) - 0.25), 0), a1.ray)
        if v22 and not (v22.Normal.Y < 0.7) then
            v21 = v22.Position.Y - Y_1
            if not (v21 < 0.25) and not (a6 < v21) then
                return v19, v21 + 0.35
            end
            return v19, nil
        end
        return v19, nil
    end
    return v19, nil
end
local function resetMotion(a1)
    --[[
      name: resetMotion
      line: 609
      upvalues:
        BASE_SPEED_upv_1 (copy, index: 1)
    ]]
    a1.SSlide = nil
    a1.SSlideDir = nil
    a1.SSlideBuf = nil
    a1.SSlope = nil
    a1.SLift = nil
    a1.SKb = nil
    a1.SKbF = nil
    a1.SKbN = nil
    a1.SDashV = nil
    a1.SDashF = nil
    a1.SDashB = nil
    a1.SBoost = nil
    a1.SJumpBuf = nil
    a1.SSpeed = BASE_SPEED_upv_1
end
local function fin(a1)
    --[[
      name: fin
      line: 625
    ]]
    return (a1 == a1) and ((a1 > -1e+07) and (a1 < 1e+07))
end
local function fin3(a1)
    --[[
      name: fin3
      line: 628
    ]]
    local X_1 = a1.X
    local v23 = (X_1 == X_1) and ((X_1 > -1e+07) and (X_1 < 1e+07))
    if v23 then
        local Y_2 = a1.Y
        v23 = (Y_2 == Y_2) and ((Y_2 > -1e+07) and (Y_2 < 1e+07))
        if v23 then
            local _ = a1.Z
            v23 = a1.Z == a1.Z and a1.Z > -1e+07 and a1.Z < 1e+07
        end
    end
    return v23
end
local tbl_upv_9 = {}
local function sayNaN(a1)
    --[[
      name: sayNaN
      line: 640
      upvalues:
        tbl_upv_9 (copy, index: 1)
        u13 (copy, index: 2)
        u11 (copy, index: 3)
    ]]
    if tbl_upv_9[a1] then
        return
    end
    tbl_upv_9[a1] = true
    warn((("[SimNaN] %* auth=%* side=%*"):format(a1, (u13 and "Client") or "Server", (u11 and "server") or "client")))
end
local function recoverRoot(a1)
    --[[
      name: recoverRoot
      line: 647
      upvalues:
        BASE_SPEED_upv_1 (copy, index: 1)
    ]]
    local root_3 = a1.root
    local s_2 = a1.s
    local push_1 = a1.push
    local align_1 = a1.align
    local gravity_1 = a1.gravity
    if push_1 then
        push_1.PlaneVelocity = Vector2.zero
        push_1.Enabled = false
    end
    if align_1 then
        align_1.Enabled = false
        align_1.CFrame = CFrame.identity
    end
    if gravity_1 then
        gravity_1.Force = Vector3.new(0, 0, 0)
        gravity_1.Enabled = false
    end
    local goodCF_1 = a1.goodCF
    if goodCF_1 then
        root_3.CFrame = goodCF_1
    end
    root_3.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    root_3.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
    s_2.SSlide = nil
    s_2.SSlideDir = nil
    s_2.SSlideBuf = nil
    s_2.SSlope = nil
    s_2.SLift = nil
    s_2.SKb = nil
    s_2.SKbF = nil
    s_2.SKbN = nil
    s_2.SDashV = nil
    s_2.SDashF = nil
    s_2.SDashB = nil
    s_2.SBoost = nil
    s_2.SJumpBuf = nil
    s_2.SSpeed = BASE_SPEED_upv_1
end
local function startKnockback(a1, a2, a3)
    --[[
      name: startKnockback
      line: 707
      upvalues:
        tbl_upv_9 (copy, index: 1)
        u13 (copy, index: 2)
        u11 (copy, index: 3)
        u2 (copy, index: 4)
    ]]
    local humanoid_1 = a1.humanoid
    local root_4 = a1.root
    local s_3 = a1.s
    local X_2 = a2.X
    local v24 = (X_2 == X_2) and ((X_2 > -1e+07) and (X_2 < 1e+07))
    if v24 then
        local Y_3 = a2.Y
        v24 = (Y_3 == Y_3) and ((Y_3 > -1e+07) and (Y_3 < 1e+07))
        if v24 then
            local _ = a2.Z
            v24 = a2.Z == a2.Z and a2.Z > -1e+07 and a2.Z < 1e+07
        end
    end
    if v24 then
        if a3 ~= nil and (a3 ~= a3 or not (a3 > -1e+07) or not (a3 < 1e+07)) then
            a3 = nil
        end
        v24 = Vector3.new(a2.X, 0, a2.Z)
        local v25 = ((v24.Magnitude > 90) and (v24.Unit * 90)) or v24
        if v25.Magnitude >= 1 then
            if s_3.SSlide ~= nil then
                s_3.SSlide = nil
                s_3.SSlideDir = nil
                s_3.SSlope = nil
                s_3.SLift = nil
                s_3.SSlideCD = u2
                s_3.SSpeed = math.max(s_3.SSpeed, 17)
            end
            local v26 = math.max(1, math.floor((math.clamp(a3 or 0.35, 0.05, 1) * 60) + 0.5))
            s_3.SKb = v25
            s_3.SKbF = v26
            s_3.SKbN = v26
            s_3.SDashV = nil
            s_3.SDashF = nil
        end
        if a2.Y > 8 then
            v24 = root_4.AssemblyLinearVelocity
            root_4.AssemblyLinearVelocity = Vector3.new(v24.X, math.max(v24.Y, math.min(a2.Y, 40) * 0.8), v24.Z)
            humanoid_1:ChangeState(Enum.HumanoidStateType.Freefall)
        end
    elseif not tbl_upv_9.knockback then
        tbl_upv_9.knockback = true
        warn((("[SimNaN] knockback auth=%* side=%*"):format((u13 and "Client") or "Server", (u11 and "server") or "client")))
    end
end
local function stepCollisions(a1, a2)
    --[[
      name: stepCollisions
      line: 672
      upvalues:
        u17 (copy, index: 1)
    ]]
    local hull_1 = a1.hull
    if not hull_1 or u17 then
        return
    end
    if a2 then
        local body_1 = a1.body
        for n_1 = 1, #body_1 do
            local v27 = body_1[n_1]
            if v27.CanCollide then
                v27.CanCollide = false
            end
        end
        if hull_1.CanCollide then
            return
        end
        hull_1.CanCollide = true
    else
        local corpse_1 = a1.corpse
        for n_2 = 1, #corpse_1 do
            local v28 = corpse_1[n_2]
            if not (v28.CanCollide) then
                v28.CanCollide = true
            end
        end
        if hull_1.CanCollide then
            hull_1.CanCollide = false
        end
    end
end
local function load(a1)
    --[[
      name: load
      line: 281
      upvalues:
        u13 (copy, index: 1)
        tbl_upv_6 (copy, index: 2)
        tbl_upv_3 (copy, index: 3)
    ]]
    local s_4 = a1.s
    local prev_2 = a1.prev
    local root_5 = a1.root
    if u13 then
        for key_1 in tbl_upv_6 do
            s_4[key_1] = root_5:GetAttribute(key_1)
        end
    else
        for _, value_6 in tbl_upv_3 do
            local v29 = root_5:GetAttribute(value_6)
            s_4[value_6] = v29
            prev_2[value_6] = v29
        end
    end
end
local function heldWeapon(a1)
    --[[
      name: heldWeapon
      line: 411
      upvalues:
        u13 (copy, index: 1)
        u11 (copy, index: 2)
        tbl_upv_8 (copy, index: 3)
        tbl_upv_7 (copy, index: 4)
        Inputs_upv_1 (copy, index: 5)
        toolInSlot (copy, index: 6)
        u14 (copy, index: 7)
        u18 (copy, index: 8)
    ]]
    local v30 = a1.character:FindFirstChildWhichIsA("Tool")
    local v31, v32 = nil, nil
    if a1.actions.Hold then
        if u13 and not u11 and tbl_upv_8.Hold then
            v32 = tbl_upv_7.Hold
        else
            v31 = a1.actions.Hold
            if v31 then
                v32 = v31:GetState()
            else
                v32 = nil
            end
        end
    else
        v32 = nil
    end
    local v33
    if type(v32) == "number" and v32 == v32 then
        local v34 = toolInSlot(a1, math.clamp(math.floor((v32 * Inputs_upv_1.HOLD_SCALE) + 0.5), 0, Inputs_upv_1.HOLD_SLOTS))
        if u14 then
            if v34 == v30 then
                a1.holdBad = 0
                v33 = v34
            else
                a1.holdBad = a1.holdBad + 1
                if u18 < a1.holdBad then
                    v33 = v30
                else
                    v33 = v34
                end
            end
        else
            v33 = v34
        end
    else
        v33 = v30
    end
    local v35
    if v33 then
        v35 = v33:GetAttribute("WeaponId")
    else
        v35 = nil
    end
    if type(v35) ~= "string" then
        return nil
    end
    return v35
end
local function tryStartSlide(a1, a2, a3, a4, a5)
    --[[
      name: tryStartSlide
      line: 525
    ]]
    if a1.SSlide == nil and a1.SSlideCD == nil and a5 then
        if not (Vector3.new(a4.X, 0, a4.Z).Magnitude < 11) and not (a3.Magnitude < 0.2) then
            local Unit_1 = Vector3.new(a3.X, 0, a3.Z).Unit
            a1.SSlide = 0
            a1.SSlideDir = Vector3.new(math.floor((Unit_1.X / 1e-04) + 0.5) * 1e-04, 0, math.floor((Unit_1.Z / 1e-04) + 0.5) * 1e-04)
            a1.SSlideBuf = nil
            a1.SSpeed = 36
            if type(a1.SHipBase) ~= "number" then
                a1.SHipBase = math.floor((a2.HipHeight / 0.001) + 0.5) * 0.001
            end
            return true
        end
        return false
    end
    return false
end
local function finCF(a1)
    --[[
      name: finCF
      line: 634
    ]]
    local Position_2 = a1.Position
    local v36 = false
    local _
    if Position_2.X == Position_2.X then
        _ = false
        if Position_2.Y == Position_2.Y then
            _ = false
            if Position_2.Z == Position_2.Z then
                _ = false
                if math.abs(Position_2.X) < 2e+05 then
                    _ = false
                    if math.abs(Position_2.Y) < 2e+05 then
                        _ = false
                        if math.abs(Position_2.Z) < 2e+05 then
                            local LookVector_1 = a1.LookVector
                            local v37 = a1.LookVector.X
                            v36 = a1.LookVector.X == a1.LookVector.X and a1.LookVector.X > -1e+07 and a1.LookVector.X < 1e+07
                            if v36 then
                                local Y_4 = LookVector_1.Y
                                v36 = (Y_4 == Y_4) and ((Y_4 > -1e+07) and (Y_4 < 1e+07))
                                if v36 then
                                    local v38 = LookVector_1.Z
                                    v36 = LookVector_1.Z == LookVector_1.Z and LookVector_1.Z > -1e+07 and LookVector_1.Z < 1e+07
                                end
                            end
                            v36 = v36 and a1.UpVector.X == a1.UpVector.X and a1.UpVector.X > -1e+07 and a1.UpVector.X < 1e+07 and a1.UpVector.Y == a1.UpVector.Y and a1.UpVector.Y > -1e+07 and a1.UpVector.Y < 1e+07 and a1.UpVector.Z == a1.UpVector.Z and a1.UpVector.Z > -1e+07 and a1.UpVector.Z < 1e+07
                        end
                    end
                end
            end
        end
    end
    return v36
end
local function probeWater(a1, a2)
    --[[
      name: probeWater
      line: 464
      upvalues:
        u16 (copy, index: 1)
        Workspace_upv_1 (copy, index: 2)
        u19 (copy, index: 3)
    ]]
    if u16 then
        return 0, nil, nil, nil
    end
    local root_6 = a1.root
    local Position_3 = root_6.Position
    local v37 = root_6.Size.Y * 0.5
    local v38 = Workspace_upv_1:Raycast(Vector3.new(Position_3.X, Position_3.Y + 16, Position_3.Z), Vector3.new(0, -(((a2 + 16) + v37) + 0.5), 0), u19)
    if v38 and v38.Material == Enum.Material.Water then
        local Y_5 = v38.Position.Y
        local v39 = Workspace_upv_1:Raycast(Position_3, Vector3.new(0, -40, 0), a1.ray)
        if not v39 then
            return 1, nil, nil, nil
        end
        local Y_6 = v39.Position.Y
        local v40 = (Y_5 - 0.6) - Y_6 - v37
        local v41 = math.floor((math.clamp(((Y_5 - Y_6) - 0.4) / (((a2 + v37) + 0.6) - 0.4), 0, 1) / 0.01) + 0.5) * 0.01
        local v42 = ((a2 < v40) and (math.floor((v40 / 0.001) + 0.5) * 0.001)) or nil
        return v41, v42, Y_6, Y_5 - 0.6
    end
    return 0, nil, nil, nil
end
local function lookMove(a1)
    --[[
      name: lookMove
      line: 352
      upvalues:
        u13 (copy, index: 1)
        u11 (copy, index: 2)
        tbl_upv_8 (copy, index: 3)
        tbl_upv_7 (copy, index: 4)
    ]]
    if not a1.move then
        return nil
    end
    local v43
    if u13 and not u11 and tbl_upv_8.Look then
        v43 = tbl_upv_7.Look
    else
        local Look_1 = a1.actions.Look
        if Look_1 then
            v43 = Look_1:GetState()
        else
            v43 = nil
        end
    end
    local v44 = false
    if typeof(v43) == "Vector2" then
        v44 = (v43.X == v43.X) and ((v43.Y == v43.Y) and ((math.abs(v43.X) < 1e+06) and (math.abs(v43.Y) < 1e+06)))
    end
    if v44 and not (v43.Magnitude < 0.5) and not (v43.Magnitude > 1.5) then
        if a1.move then
            v44 = a1.move:GetState()
        else
            v44 = nil
        end
        local Unit_2 = false
        if typeof(v44) == "Vector2" then
            Unit_2 = (v44.X == v44.X) and ((v44.Y == v44.Y) and ((math.abs(v44.X) < 1e+06) and (math.abs(v44.Y) < 1e+06)))
        end
        if not Unit_2 then
            return Vector3.new(0, 0, 0)
        end
        Unit_2 = v43.Unit
        v43 = Vector3.new((Unit_2.X * v44.Y) - (Unit_2.Y * v44.X), 0, (Unit_2.Y * v44.Y) + (Unit_2.X * v44.X))
        if v43.Magnitude > 1 then
            v43 = v43.Unit
        end
        return v43
    end
    return nil
end
local function slideCushion(a1, a2, a3, a4)
    --[[
      name: slideCushion
      line: 590
      upvalues:
        Workspace_upv_1 (copy, index: 1)
    ]]
    if a2 >= -12 then
        return nil
    end
    local root_7 = a1.root
    local Position_4 = root_7.Position
    local v45 = a3 + root_7.Size.Y * 0.5
    local v46 = Workspace_upv_1:Raycast(Position_4, Vector3.new(0, -(v45 + (a4 or 2.5)), 0), a1.ray)
    if v46 and not (v46.Normal.Y < 0.5) then
        v45 = ((a2 * a2) - 144) / (math.max(((Position_4.Y - v46.Position.Y) - v45) - 0.5, 0.05) * 2)
        if v45 < 350 then
            return nil
        end
        return (math.min(v45, 900))
    end
    return nil
end
local tbl_upv_10 = {steps = 0, chars = 0, time = 0, maxStep = 0}
function tbl_upv_1.DebugStats()
    --[[
      name: DebugStats
      line: 1338
      upvalues:
        tbl_upv_10 (copy, index: 1)
        tbl_upv_5 (copy, index: 2)
    ]]
    local tbl_11 = {msPerStep = 0, characters = 0, maxStepMs = 0}
    tbl_11.steps = tbl_upv_10.steps
    tbl_11.msPerStep = ((tbl_upv_10.steps > 0) and (tbl_upv_10.time / tbl_upv_10.steps * 1000)) or 0
    tbl_11.maxStepMs = tbl_upv_10.maxStep * 1000
    tbl_11.characters = #tbl_upv_5
    return tbl_11
end
tbl_upv_1.CORRECTION_MAX = 20
local u20 = Vector3.new(0, 0, 0)
local u21 = nil
local u22 = Vector3.new(0, 0, 0)
local u23 = nil
local u24 = nil
local u25 = false
local function trackCorrection(a1)
    --[[
      name: trackCorrection
      line: 1364
      upvalues:
        RunService_upv_1 (copy, index: 1)
        u25 (ref,  index: 2)
        tbl_upv_5 (copy, index: 3)
        u21 (ref,  index: 4)
        u23 (ref,  index: 5)
        u24 (ref,  index: 6)
        u22 (ref,  index: 7)
        u20 (ref,  index: 8)
    ]]
    if RunService_upv_1:IsResimulating() then
        u25 = true
    else
        local v47 = tbl_upv_5[1]
        if v47 then
            local root_8 = v47.root
            local Position_5 = root_8.Position
            local AssemblyLinearVelocity_1 = root_8.AssemblyLinearVelocity
            local v48 = root_8:GetAttribute("STp")
            if u25 and u21 and root_8 == u23 and v48 == u24 then
                local v49 = Position_5 - (u21 + (((u22 + AssemblyLinearVelocity_1) * 0.5) * a1))
                local Magnitude_1 = v49.Magnitude
                if Magnitude_1 > 0.02 and Magnitude_1 < 20 then
                    u20 = u20 + v49
                end
            end
            u21 = Position_5
            u22 = AssemblyLinearVelocity_1
            u23 = root_8
            u24 = v48
        else
            u21 = nil
            u23 = nil
        end
        u25 = false
    end
end
function tbl_upv_1.TakeCorrection()
    --[[
      name: TakeCorrection
      line: 1389
      upvalues:
        u20 (ref, index: 1)
    ]]
    local v50 = u20
    u20 = Vector3.new(0, 0, 0)
    return v50
end
function tbl_upv_1.RebaseCorrection()
    --[[
      name: RebaseCorrection
      line: 1398
      upvalues:
        tbl_upv_5 (copy, index: 1)
        u11 (copy, index: 2)
        u21 (ref,  index: 3)
        u22 (ref,  index: 4)
        u23 (ref,  index: 5)
        u24 (ref,  index: 6)
        u25 (ref,  index: 7)
    ]]
    local v51 = tbl_upv_5[1]
    if (u11) or not v51 then
        return
    end
    local root_9 = v51.root
    local AssemblyLinearVelocity_2 = root_9.AssemblyLinearVelocity
    local v52 = root_9:GetAttribute("STp")
    u21 = root_9.Position - (AssemblyLinearVelocity_2 * 0.016666666666666666)
    u22 = AssemblyLinearVelocity_2
    u23 = root_9
    u24 = v52
    u25 = false
end
local function stepChar(a1, a2)
    --[[
      name: stepChar
      line: 776
      upvalues:
        load (copy, index: 1)
        finCF (copy, index: 2)
        tbl_upv_9 (copy, index: 3)
        u13 (copy, index: 4)
        u11 (copy, index: 5)
        BASE_SPEED_upv_1 (copy, index: 6)
        save (copy, index: 7)
        stepCollisions (copy, index: 8)
        u14 (copy, index: 9)
        startKnockback (copy, index: 10)
        u16 (copy, index: 11)
        tbl_upv_8 (copy, index: 12)
        tbl_upv_7 (copy, index: 13)
        u17 (copy, index: 14)
        lookMove (copy, index: 15)
        heldWeapon (copy, index: 16)
        Combat_upv_1 (copy, index: 17)
        probeWater (copy, index: 18)
        probeBank (copy, index: 19)
        u6 (copy, index: 20)
        u8 (copy, index: 21)
        u9 (copy, index: 22)
        u10 (copy, index: 23)
        u2 (copy, index: 24)
        u4 (copy, index: 25)
        tryStartSlide (copy, index: 26)
        u3 (copy, index: 27)
        u1 (copy, index: 28)
        probeGround (copy, index: 29)
        u5 (copy, index: 30)
        JUMP_HEIGHT_upv_1 (copy, index: 31)
        u7 (copy, index: 32)
        Workspace_upv_1 (copy, index: 33)
        slideCushion (copy, index: 34)
    ]]
    local humanoid_2 = a1.humanoid
    local root_10 = a1.root
    local s_5 = a1.s
    load(a1)
    local CFrame_1 = root_10.CFrame
    local v53, v54, v55 = nil, nil, nil
    if finCF(CFrame_1) then
        a1.goodCF = CFrame_1
        local v56 = humanoid_2:GetState()
        v53 = v56 ~= Enum.HumanoidStateType.Dead
        stepCollisions(a1, v53)
        local v57 = nil
        if u14 then
            s_5.SFrozen = ((a1.frozen) and true) or nil
            s_5.SSlow = a1.slow ~= 1 and math.floor((a1.slow / 0.001) + 0.5) * 0.001 or nil
            s_5.SNoJump = ((a1.noJump) and true) or nil
            v57 = a1.pending
            if v57.tp then
                local tp_1 = v57.tp
                v57.tp = nil
                a1.character:PivotTo(tp_1)
                root_10.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                s_5.SSlide = nil
                s_5.SSlideDir = nil
                s_5.SSlideBuf = nil
                s_5.SSlope = nil
                s_5.SLift = nil
                s_5.SKb = nil
                s_5.SKbF = nil
                s_5.SKbN = nil
                s_5.SDashV = nil
                s_5.SDashF = nil
                s_5.SDashB = nil
                s_5.SBoost = nil
                s_5.SJumpBuf = nil
                s_5.SSpeed = BASE_SPEED_upv_1
                local v59 = ((type(s_5.STp) ~= "number") and 0) or (s_5.STp)
                s_5.STp = v59 + 1
            end
            if v57.kb and v53 then
                startKnockback(a1, v57.kb, v57.kbDur)
            end
            v57.kb = nil
            v57.kbDur = nil
        else
            local v60, v61 = nil, nil
            if u13 then
                v60 = s_5.STp
                if v60 ~= a1.tpSeen then
                    a1.tpSeen = v60
                    v54 = root_10:GetAttribute("STpCF")
                    if typeof(v54) == "CFrame" and finCF(v54) and (root_10.Position - v54.Position).Magnitude > 30 then
                        a1.character:PivotTo(v54)
                    end
                    root_10.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    s_5.SSlide = nil
                    s_5.SSlideDir = nil
                    s_5.SSlideBuf = nil
                    s_5.SSlope = nil
                    s_5.SLift = nil
                    s_5.SKb = nil
                    s_5.SKbF = nil
                    s_5.SKbN = nil
                    s_5.SDashV = nil
                    s_5.SDashF = nil
                    s_5.SDashB = nil
                    s_5.SBoost = nil
                    s_5.SJumpBuf = nil
                    s_5.SSpeed = BASE_SPEED_upv_1
                end
                v61 = root_10:GetAttribute("NKbSeq")
                if v61 ~= a1.kbSeen then
                    a1.kbSeen = v61
                    v54 = root_10:GetAttribute("NKb")
                    if v53 and typeof(v54) == "Vector3" then
                        local v62 = nil
                        if v54 == v54 then
                            v62 = root_10:GetAttribute("NKbDur")
                            local v63
                            if type(v62) ~= "number" then
                                v63 = nil
                            else
                                v63 = v62
                            end
                            startKnockback(a1, v54, v63)
                        end
                    end
                end
            end
        end
        if humanoid_2.UseJumpPower then
            humanoid_2.UseJumpPower = false
        end
        if humanoid_2:GetStateEnabled(Enum.HumanoidStateType.FallingDown) then
            humanoid_2:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        end
        if humanoid_2:GetStateEnabled(Enum.HumanoidStateType.Ragdoll) then
            humanoid_2:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        end
        if humanoid_2:GetStateEnabled(Enum.HumanoidStateType.Swimming) ~= u16 then
            humanoid_2:SetStateEnabled(Enum.HumanoidStateType.Swimming, u16)
        end
        local v64, v65, v66, v67, v68, v69, v70, v71, v72, v73, v74, v75, v76, v77, v78, v79 = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
        if v53 then
            v53 = s_5.SFrozen == true
            local v80 = ((type(s_5.SSlow) ~= "number") and 1) or (s_5.SSlow)
            local v81 = true
            if s_5.SNoJump ~= true then
                v81 = v80 <= 0.001
            end
            local v82
            if type(s_5.SSpeed) ~= "number" then
                v82 = BASE_SPEED_upv_1
            else
                v82 = s_5.SSpeed
            end
            local v83
            if u13 and not u11 and tbl_upv_8.Slide then
                v83 = tbl_upv_7.Slide
            else
                v64 = a1.actions.Slide
                if v64 then
                    v83 = v64:GetState()
                else
                    v83 = nil
                end
            end
            local v84
            if v83 == true then
                v84 = true
            else
                v84 = false
            end
            local v85
            if u13 and not u11 and tbl_upv_8.Jump then
                v85 = tbl_upv_7.Jump
            else
                v65 = a1.actions.Jump
                if v65 then
                    v85 = v65:GetState()
                else
                    v85 = nil
                end
            end
            if v85 == true then
                v83 = true
            else
                v83 = false
            end
            local v86
            if u13 and not u11 and tbl_upv_8.Aim then
                v86 = tbl_upv_7.Aim
            else
                v66 = a1.actions.Aim
                if v66 then
                    v86 = v66:GetState()
                else
                    v86 = nil
                end
            end
            if v86 == true then
                v85 = true
            else
                v85 = false
            end
            if u13 and not u11 and tbl_upv_8.Charge then
                v86 = tbl_upv_7.Charge
            else
                v67 = a1.actions.Charge
                if v67 then
                    v86 = v67:GetState()
                else
                    v86 = nil
                end
            end
            local v87
            if v86 == true then
                v87 = true
            else
                v87 = false
            end
            if u13 and not u11 and tbl_upv_8.Block then
                v86 = tbl_upv_7.Block
            else
                v68 = a1.actions.Block
                if v68 then
                    v86 = v68:GetState()
                else
                    v86 = nil
                end
            end
            local v88
            if v86 == true then
                v88 = true
            else
                v88 = false
            end
            if u13 and not u11 and tbl_upv_8.Reload then
                v86 = tbl_upv_7.Reload
            else
                v69 = a1.actions.Reload
                if v69 then
                    v86 = v69:GetState()
                else
                    v86 = nil
                end
            end
            local v89
            if v86 == true then
                v89 = true
            else
                v89 = false
            end
            if u13 and not u11 and tbl_upv_8.Use then
                v86 = tbl_upv_7.Use
            else
                v70 = a1.actions.Use
                if v70 then
                    v86 = v70:GetState()
                else
                    v86 = nil
                end
            end
            local v90
            if v86 == true then
                v90 = true
            else
                v90 = false
            end
            local v91
            if u13 and not u11 and tbl_upv_8.Lunge then
                v91 = tbl_upv_7.Lunge
            else
                v71 = a1.actions.Lunge
                if v71 then
                    v91 = v71:GetState()
                else
                    v91 = nil
                end
            end
            if v91 == true then
                v86 = true
            else
                v86 = false
            end
            local v92 = nil
            local v93
            if u13 and not u11 and tbl_upv_8.Facing then
                v93 = tbl_upv_7.Facing
            else
                v72 = a1.actions.Facing
                if v72 then
                    v93 = v72:GetState()
                else
                    v93 = nil
                end
            end
            if typeof(v93) == "Vector2" and v93.X == v93.X and v93.Y == v93.Y and v93.Magnitude > 0.5 and v93.Magnitude < 1.5 then
                v91 = v93.Unit
            else
                v91 = v92
            end
            local MoveDirection_1 = humanoid_2.MoveDirection
            local v94 = u17 or lookMove(a1)
            if v94 then
                humanoid_2:Move(v94, false)
                v93 = v94
            else
                v93 = MoveDirection_1
            end
            v72 = heldWeapon(a1)
            local v95 = nil
            local v97 = nil
            if u17 then
                v95 = a1.character:FindFirstChildWhichIsA("Tool")
                if v95 then
                    v97 = v95:GetAttribute("WeaponId")
                else
                    v97 = nil
                end
                if type(v97) ~= "string" then
                    v72 = nil
                else
                    v72 = v97
                end
            end
            local v98
            v98, v97 = Combat_upv_1.MoveSpeed(v72, v85, v87, v88, v89, v90)
            if not (u17) then
                if type(s_5.SHipBase) == "number" then
                    if (u11 or u13) and a1.hipWritten and math.abs(humanoid_2.HipHeight - a1.hipWritten) > 0.002 then
                        s_5.SHipBase = math.floor((humanoid_2.HipHeight / 0.001) + 0.5) * 0.001
                        s_5.SHip = nil
                    end
                else
                    s_5.SHipBase = math.floor((humanoid_2.HipHeight / 0.001) + 0.5) * 0.001
                end
            end
            if type(s_5.SHipBase) ~= "number" then
                v90 = humanoid_2.HipHeight
            else
                v90 = s_5.SHipBase
            end
            local v99, v100
            local v101
            v73, v101, v99, v100 = probeWater(a1, v90)
            local v102
            if v73 > 0 then
                v102 = v73
            else
                v102 = nil
            end
            s_5.SWade = v102
            local v103 = v98 * v80 * (1 - (v73 * 0.4))
            v97 = ((v80 <= 0.42) and true) or ((v73 > 0.3) and true) or v97
            v98 = humanoid_2.FloorMaterial ~= Enum.Material.Air
            local AssemblyLinearVelocity_3 = root_10.AssemblyLinearVelocity
            v74 = not v98
            if v74 then
                v85 = v74
            else
                local v104 = true
                if v56 == Enum.HumanoidStateType.Jumping then
                    v85 = v104
                else
                    v85 = v56 == Enum.HumanoidStateType.Freefall
                end
            end
            if v85 then
                local v105 = true
                if v56 == Enum.HumanoidStateType.Jumping then
                    v102 = v105
                else
                    v102 = AssemblyLinearVelocity_3.Y > 0
                end
            else
                v102 = v85
            end
            if v101 and (v102 or v85 and v100 + 0.05 < root_10.Position.Y) then
                v101 = nil
            end
            if v99 then
                if v85 then
                    v102 = v101
                else
                    local v106 = nil
                    if s_5.SSlide ~= nil then
                        v102 = v101
                    else
                        v106 = Vector3.new(v93.X, 0, v93.Z)
                        local v107 = nil
                        if v106.Magnitude > 0.3 then
                            v107 = probeBank(a1, v106.Unit, v90, v99)
                            if v107 and (v101 == nil or v101 < v107) then
                                v102 = v107
                            else
                                v102 = v101
                            end
                        else
                            v102 = v101
                        end
                    end
                end
            else
                v102 = v101
            end
            if v102 then
                s_5.SWet = u6
                if type(s_5.SHipBase) ~= "number" then
                    s_5.SHipBase = math.floor((humanoid_2.HipHeight / 0.001) + 0.5) * 0.001
                end
            elseif s_5.SWet ~= nil then
                s_5.SWet = ((s_5.SWet > 1) and (s_5.SWet - 1)) or nil
            end
            v99 = v98 and (s_5.SGround ~= true)
            s_5.SGround = (v98 and true) or nil
            v90 = (v98 and 0) or (math.min((s_5.SAir or 0) + 1, 600))
            local v108
            if v90 > 0 then
                v108 = v90
            else
                v108 = nil
            end
            s_5.SAir = v108
            v108 = v56 == Enum.HumanoidStateType.Jumping
            local v109 = v108 and (s_5.SJumping ~= true)
            s_5.SJumping = (v108 and true) or nil
            if v108 then
                s_5.SJumped = true
            elseif v98 then
                s_5.SJumped = nil
            end
            s_5.SSlideCD = (((s_5.SSlideCD or 0) > 1) and (s_5.SSlideCD - 1)) or nil
            s_5.SSlideBuf = (((s_5.SSlideBuf or 0) > 1) and (s_5.SSlideBuf - 1)) or nil
            s_5.SDashCD = (((s_5.SDashCD or 0) > 1) and (s_5.SDashCD - 1)) or nil
            v75 = a1.dashCd
            if v75 then
                for key_2, value_7 in v75 do
                    v75[key_2] = ((value_7 > 1) and (value_7 - 1)) or nil
                end
            end
            local v110 = math.max((s_5.SJumpBuf or 0) - 1, 0)
            if v83 then
                if s_5.SJumpIn == true then
                    v108 = v110
                else
                    v108 = u8
                end
            else
                v108 = v110
            end
            if v99 and v108 > 0 then
                v108 = math.max(v108, u9)
            end
            s_5.SJumpIn = (v83 and true) or nil
            if v87 then
                s_5.SCharge = math.min((s_5.SCharge or 0) + 1, 600)
                s_5.SChargeRel = nil
            else
                local v111 = nil
                if s_5.SCharge then
                    v111 = (s_5.SChargeRel or 0) + 1
                    if u10 < v111 then
                        s_5.SCharge = nil
                        s_5.SChargeRel = nil
                    else
                        s_5.SChargeRel = v111
                    end
                end
            end
            if v109 then
                local v112 = 0
                if s_5.SSlide == nil then
                    v108 = v112
                else
                    if s_5.SSlide ~= nil then
                        s_5.SSlide = nil
                        s_5.SSlideDir = nil
                        s_5.SSlope = nil
                        s_5.SLift = nil
                        s_5.SSlideCD = u2
                        s_5.SSpeed = math.max(s_5.SSpeed, 17)
                    end
                    local v113 = math.max(s_5.SSpeed, 27)
                    s_5.SBoost = u4
                    v82, v108 = v113, v112
                end
            end
            s_5.SSpeed = v82
            v109 = s_5.SDashF or 0
            if v86 then
                local v114 = nil
                if s_5.SLungeIn ~= true then
                    v114 = Combat_upv_1.Tuning(v72).lunge
                    if type(v114) == "table" and s_5.SDashCD == nil and (not (a1.dashCd) or not (a1.dashCd[v72])) and not v53 and v80 > 0.001 and (v114.charge or 0.6) * 0.65 <= (s_5.SCharge or 0) * 0.016666666666666666 then
                        if v91 then
                            v87 = Vector3.new(v91.X, 0, v91.Y)
                        else
                            local v144 = root_10.CFrame.LookVector
                            v87 = Vector3.new(root_10.CFrame.LookVector.X, 0, root_10.CFrame.LookVector.Z)
                        end
                        if v87.Magnitude > 0.05 then
                            v65 = v87.Unit
                            local v115 = v114.speed or 70
                            v109 = math.max(1, math.floor((math.clamp((v114.distance or 16) / v115, 0.12, 0.35) * 60) + 0.5))
                            s_5.SDashV = Vector3.new(math.floor(((v65.X * v115) / 0.01) + 0.5) * 0.01, 0, math.floor(((v65.Z * v115) / 0.01) + 0.5) * 0.01)
                            s_5.SDashB = ((v114.brake) and 2) or nil
                            s_5.SDashCD = math.max(1, math.floor(((Combat_upv_1.DASH_GAP * 0.85) * 60) + 0.5))
                            a1.dashCd = a1.dashCd or {}
                            local dashCd_1 = a1.dashCd
                            local v116
                            if v114.refreshOnKill then
                                v116 = math.min(v114.cooldown or 1, 0.6)
                            else
                                v116 = v114.cooldown or 1
                            end
                            dashCd_1[v72] = math.max(1, math.floor(((v116 * 0.85) * 60) + 0.5))
                            s_5.SCharge = nil
                            s_5.SChargeRel = nil
                            if s_5.SSlide ~= nil then
                                s_5.SSlide = nil
                                s_5.SSlideDir = nil
                                s_5.SSlope = nil
                                s_5.SLift = nil
                                s_5.SSlideCD = u2
                                s_5.SSpeed = math.max(s_5.SSpeed, 17)
                            end
                        end
                    end
                end
            end
            s_5.SLungeIn = (v86 and true) or nil
            v76 = not v53
            local v117 = nil
            if v76 then
                v117 = not v97
                if v117 then
                    local v118 = false
                    if v80 > 0.001 then
                        local v119 = false
                        if s_5.SDashV ~= nil then
                            v72 = v119
                        else
                            v72 = v98
                        end
                    else
                        v72 = v118
                    end
                else
                    v72 = v117
                end
            else
                v72 = v76
            end
            if not (v84) or s_5.SSlideIn == true then
                if s_5.SSlide == nil and (v99 and v84 or s_5.SSlideBuf ~= nil) and v93.Magnitude > 0.2 then
                    tryStartSlide(s_5, humanoid_2, v93, AssemblyLinearVelocity_3, v72)
                end
            elseif not (tryStartSlide(s_5, humanoid_2, v93, AssemblyLinearVelocity_3, v72)) then
                s_5.SSlideBuf = u3
            end
            s_5.SSlideIn = (v84 and true) or nil
            v99 = nil
            local v120, v145, v121 = nil, nil, nil
            local v111
            if s_5.SSlide == nil then
                local v122 = BASE_SPEED_upv_1
                v120 = s_5.SBoost or 0
                if v120 > 0 then
                    local v123 = math.max(v122, s_5.SSpeed)
                    s_5.SBoost = ((v120 > 1) and (v120 - 1)) or nil
                    v122 = v123
                end
                local v124 = (v98 and 8) or 1.6
                local v125 = s_5.SSpeed
                if v125 < v122 then
                    v125 = v122
                else
                    v125 = v125 + (v122 - v125) * (1 - math.exp(-v124 * a2))
                    if math.abs(v125 - v122) < 0.03 then
                        v125 = v122
                    end
                end
                s_5.SSpeed = v125
                v111 = v125 * v103
            else
                local v126 = s_5.SSlide + ((v98 and 1) or 0)
                s_5.SSlide = v126
                v86 = math.clamp(v126 / u1, 0, 1)
                v84 = (v86 * -19) * v86 + 36
                v80 = s_5.SSlideDir
                v80 = v80 or Vector3.new(root_10.CFrame.LookVector.X, 0, root_10.CFrame.LookVector.Z)
                v121 = Vector3.new(v93.X, 0, v93.Z)
                local v127 = nil
                if v121.Magnitude > 0.3 then
                    v121 = v121.Unit
                    v127 = math.acos(math.clamp(v80:Dot(v121), -1, 1))
                    if v127 > 0.001 and v127 < 2.0943951023931953 then
                        v80 = v80:Lerp(v121, math.min(1, (a2 * 1.6580627893946132) / v127)).Unit
                    end
                end
                v80 = Vector3.new(math.floor((v80.X / 1e-04) + 0.5) * 1e-04, 0, math.floor((v80.Z / 1e-04) + 0.5) * 1e-04)
                s_5.SSlideDir = v80
                if type(s_5.SSlope) ~= "number" then
                    v121 = 0
                else
                    v121 = s_5.SSlope
                end
                local v128 = nil
                if v98 then
                    local v129
                    if type(s_5.SHip) == "number" then
                        v129 = s_5.SHip
                    elseif u17 then
                        v129 = humanoid_2.HipHeight
                    else
                        v129 = s_5.SHipBase
                    end
                    local v130
                    if type(s_5.SHipBase) ~= "number" then
                        v130 = v129
                    else
                        v130 = s_5.SHipBase
                    end
                    local v131
                    local v132
                    v132, v131 = probeGround(a1, v80, v84, Vector3.new(AssemblyLinearVelocity_3.X, 0, AssemblyLinearVelocity_3.Z).Magnitude, v129, v130)
                    v128 = v131
                    v121 = v132 and math.floor((v121 + math.clamp(v132 - v121, -(a2 * 40), a2 * 40)) / 0.01 + 0.5) * 0.01
                end
                local v129
                if v121 == 0 then
                    v129 = nil
                else
                    v129 = v121
                end
                s_5.SSlope = v129
                v129 = (v128 and (math.floor((v128 / 0.01) + 0.5) * 0.01)) or nil
                s_5.SLift = v129
                v84 = v84 + v121
                s_5.SSpeed = v84
                v111 = v84 * v103
                humanoid_2:Move(v80, false)
                local Magnitude_2 = Vector3.new(AssemblyLinearVelocity_3.X, 0, AssemblyLinearVelocity_3.Z).Magnitude
                if v98 or not (u5 < v90) then
                    if v86 >= 1 or v126 * 0.016666666666666666 > 0.2 and Magnitude_2 < 6 or v53 or v97 then
                        if s_5.SSlide ~= nil then
                            s_5.SSlide = nil
                            s_5.SSlideDir = nil
                            s_5.SSlope = nil
                            s_5.SLift = nil
                            s_5.SSlideCD = u2
                            s_5.SSpeed = math.max(s_5.SSpeed, 17)
                        end
                        v111, v99 = v111, v80
                        s_5.SSpeed = math.floor((s_5.SSpeed / 0.001) + 0.5) * 0.001
                        if v53 then
                            v111 = 0
                            s_5.SSpeed = BASE_SPEED_upv_1
                        end
                        v111 = math.floor((v111 / 0.01) + 0.5) * 0.01
                        if v111 ~= v111 or not (v111 > -1e+07) or not (v111 < 1e+07) then
                            if not (tbl_upv_9["walk speed"]) then
                                tbl_upv_9["walk speed"] = true
                                local v134 = (u13 and "Client") or "Server"
                                warn((("[SimNaN] walk speed auth=%* side=%*"):format(v134, (u11 and "server") or "client")))
                            end
                            s_5.SSpeed = BASE_SPEED_upv_1
                            v111 = BASE_SPEED_upv_1
                        end
                        if humanoid_2.WalkSpeed ~= v111 then
                            humanoid_2.WalkSpeed = v111
                        end
                        v77 = s_5.SHipBase
                        if type(v77) == "number" then
                            local v135, v136 = nil, nil
                            if s_5.SSlide == nil then
                                v135 = v77
                            else
                                v135 = math.max(0.3, v77 - 1.4)
                                v136 = s_5.SLift
                                if type(v136) == "number" and v135 < v136 then
                                    v135 = v136
                                end
                            end
                            if v102 and v135 < v102 then
                                v135 = v102
                            end
                            v97 = v135
                        else
                            v97 = nil
                        end
                        if v97 then
                            if type(s_5.SHip) ~= "number" then
                                v121 = (u17 and (math.floor((humanoid_2.HipHeight / 0.001) + 0.5) * 0.001)) or (s_5.SHipBase)
                            else
                                v121 = s_5.SHip
                            end
                            if (v101) and v97 == v101 then
                                v121 = v97
                            elseif s_5.SWet ~= nil and s_5.SSlide == nil and v97 < v121 then
                                if not v85 and math.abs(v121 - v97) > 0.01 then
                                    v121 = math.floor(((v121 + ((v97 - v121) * (1 - math.exp(-(((v97 < v121) and 30) or (((s_5.SLift ~= nil) and 45) or ((v102 and 30) or 14))) * a2)))) / 0.001) + 0.5) * 0.001
                                else
                                    v121 = v97
                                end
                            elseif math.abs(v121 - v97) > 0.01 then
                                v121 = math.floor(((v121 + ((v97 - v121) * (1 - math.exp(-(((v97 < v121) and 30) or (((s_5.SLift ~= nil) and 45) or ((v102 and 30) or 14))) * a2)))) / 0.001) + 0.5) * 0.001
                            else
                                v121 = v97
                            end
                            if s_5.SSlide == nil and s_5.SWet == nil and v121 == v97 then
                                s_5.SHip = nil
                                if u17 then
                                    s_5.SHipBase = nil
                                end
                            else
                                s_5.SHip = v121
                            end
                            if v121 ~= v121 or not (v121 > -1e+07) or not (v121 < 1e+07) then
                                if not (tbl_upv_9["hip height"]) then
                                    tbl_upv_9["hip height"] = true
                                    warn((("[SimNaN] hip height auth=%* side=%*"):format((u13 and "Client") or "Server", (u11 and "server") or "client")))
                                end
                                local v137 = nil
                                if type(s_5.SHipBase) ~= "number" then
                                    v121 = humanoid_2.HipHeight
                                else
                                    v137 = s_5.SHipBase
                                    if (v137 == v137) and ((v137 > -1e+07) and (v137 < 1e+07)) then
                                        v121 = s_5.SHipBase
                                    else
                                        v121 = humanoid_2.HipHeight
                                    end
                                end
                                s_5.SHip = nil
                            end
                            if humanoid_2.HipHeight ~= v121 then
                                humanoid_2.HipHeight = v121
                            end
                            a1.hipWritten = v121
                        end
                        v102 = not v53 and (not v81 and (humanoid_2.SeatPart == nil))
                        if v102 then
                            v101 = math.floor(((JUMP_HEIGHT_upv_1 * (1 - (v73 * 0.45))) / 0.01) + 0.5) * 0.01
                        else
                            v101 = 0
                        end
                        if humanoid_2.JumpHeight ~= v101 then
                            humanoid_2.JumpHeight = v101
                        end
                        v101 = false
                        if v102 then
                            if v98 then
                                v121 = v83 or v108 > 0
                                v101 = v121
                            elseif s_5.SJumped ~= true and v90 <= u7 and AssemblyLinearVelocity_3.Y <= 1 and v108 > 0 then
                                s_5.SJumped = true
                                v108 = 0
                                humanoid_2:ChangeState(Enum.HumanoidStateType.Jumping)
                            end
                        end
                        humanoid_2.Jump = v101
                        if v108 > 0 then
                            v121 = v108
                        else
                            v121 = nil
                        end
                        s_5.SJumpBuf = v121
                        v75 = a1.gravity
                        v102 = not v98 and ((AssemblyLinearVelocity_3.Y < 0) and (v56 ~= Enum.HumanoidStateType.Climbing))
                        if v75 then
                            if v102 then
                                v101 = -Workspace_upv_1.Gravity * 0.30000000000000004
                                if s_5.SSlide == nil then
                                    if v101 then
                                        v97 = slideCushion(a1, AssemblyLinearVelocity_3.Y, v101, 4)
                                        v101 = (v97 and (v97 + Workspace_upv_1.Gravity)) or v101
                                    end
                                else
                                    local v138 = slideCushion(a1, AssemblyLinearVelocity_3.Y, humanoid_2.HipHeight)
                                    v101 = (v138 and (v138 + Workspace_upv_1.Gravity)) or v101
                                end
                                v98 = v101 * root_10.AssemblyMass
                                if v98 ~= v98 or not (v98 > -1e+07) or not (v98 < 1e+07) then
                                    if not (tbl_upv_9["fall force"]) then
                                        tbl_upv_9["fall force"] = true
                                        local v139 = (u13 and "Client") or "Server"
                                        warn((("[SimNaN] fall force auth=%* side=%*"):format(v139, (u11 and "server") or "client")))
                                    end
                                    v98 = 0
                                end
                                v75.Force = Vector3.new(0, v98, 0)
                            end
                            if v75.Enabled ~= v102 then
                                v75.Enabled = v102
                            end
                        end
                        v75 = nil
                        v78 = s_5.SKbF or 0
                        if v78 > 0 and s_5.SKb then
                            local v140 = v78 / math.max(s_5.SKbN or v78, 1)
                            v75 = s_5.SKb * v140 + Vector3.new(v93.X, 0, v93.Z) * v111 * (1 - v140)
                            v78 = v78 - 1
                            if v78 <= 0 then
                                s_5.SKb = nil
                                s_5.SKbF = nil
                                s_5.SKbN = nil
                            else
                                s_5.SKbF = v78
                            end
                        end
                        if (v109 > 0) and (s_5.SDashV) then
                            local SDashV_1 = s_5.SDashV
                            if v75 then
                                v75 = v75 + SDashV_1
                            else
                                v75 = SDashV_1
                            end
                            v99 = Vector3.new(SDashV_1.X, 0, SDashV_1.Z).Unit
                            v109 = v109 - 1
                        elseif s_5.SDashB then
                            v121 = v75 or Vector3.new(v93.X, 0, v93.Z) * v111
                            s_5.SDashB = ((s_5.SDashB > 1) and (s_5.SDashB - 1)) or nil
                            v75 = v121
                        end
                        if v109 <= 0 then
                            s_5.SDashV = nil
                            s_5.SDashF = nil
                        else
                            s_5.SDashF = v109
                        end
                        if v75 then
                            local X_3 = v75.X
                            v121 = (X_3 == X_3) and ((X_3 > -1e+07) and (X_3 < 1e+07))
                            if v121 then
                                local Y_7 = v75.Y
                                v121 = (Y_7 == Y_7) and ((Y_7 > -1e+07) and (Y_7 < 1e+07))
                                if v121 then
                                    local v146 = v75.Z
                                    v121 = v75.Z == v75.Z and v75.Z > -1e+07 and v75.Z < 1e+07
                                end
                            end
                            if not (v121) then
                                v121 = s_5.SKb ~= nil and "push (knockback)" or s_5.SDashV == nil and "push" or "push (dash)"
                                if not (tbl_upv_9[v121]) then
                                    tbl_upv_9[v121] = true
                                    local v132 = (u13 and "Client") or "Server"
                                    warn((("[SimNaN] %* auth=%* side=%*"):format(v121, v132, (u11 and "server") or "client")))
                                end
                                v75 = nil
                                s_5.SKb = nil
                                s_5.SKbF = nil
                                s_5.SKbN = nil
                                s_5.SDashV = nil
                                s_5.SDashF = nil
                            end
                        end
                        v111 = a1.push
                        if v111 then
                            if v75 then
                                v111.PlaneVelocity = Vector2.new(v75.X, v75.Z)
                            end
                            v109 = v75 ~= nil
                            if v111.Enabled ~= v109 then
                                v111.Enabled = v109
                            end
                        end
                        if not (v99) and v91 and not (v53) and humanoid_2.SeatPart == nil then
                            v99 = Vector3.new(v91.X, 0, v91.Y)
                        end
                        v79 = a1.align
                        if v99 then
                            local X_4 = v99.X
                            v121 = (X_4 == X_4) and ((X_4 > -1e+07) and (X_4 < 1e+07))
                            if v121 then
                                local Y_8 = v99.Y
                                v121 = (Y_8 == Y_8) and ((Y_8 > -1e+07) and (Y_8 < 1e+07))
                                if v121 then
                                    local v147 = v99.Z
                                    v121 = v99.Z == v99.Z and v99.Z > -1e+07 and v99.Z < 1e+07
                                end
                            end
                            if not (v121) then
                                if not (tbl_upv_9.facing) then
                                    tbl_upv_9.facing = true
                                    local v141 = (u13 and "Client") or "Server"
                                    warn((("[SimNaN] facing auth=%* side=%*"):format(v141, (u11 and "server") or "client")))
                                end
                                v99 = nil
                            end
                        end
                        if v99 and v79 then
                            local v142 = nil
                            if v99.Magnitude > 0.1 then
                                if humanoid_2.AutoRotate then
                                    humanoid_2.AutoRotate = false
                                end
                                v75 = v99.Unit
                                v142 = CFrame.lookAt(Vector3.new(0, 0, 0), Vector3.new(math.floor((v75.X / 1e-04) + 0.5) * 1e-04, 0, math.floor((v75.Z / 1e-04) + 0.5) * 1e-04))
                                if v79.CFrame ~= v142 then
                                    v79.CFrame = v142
                                end
                                if not (v79.Enabled) then
                                    v79.Enabled = true
                                end
                            else
                                if v79 and v79.Enabled then
                                    v79.Enabled = false
                                end
                                if not (humanoid_2.AutoRotate) then
                                    humanoid_2.AutoRotate = true
                                end
                            end
                        else
                            if v79 and v79.Enabled then
                                v79.Enabled = false
                            end
                            if not (humanoid_2.AutoRotate) then
                                humanoid_2.AutoRotate = true
                            end
                        end
                        save(a1)
                        return
                    end
                else
                    if s_5.SSlide ~= nil then
                        s_5.SSlide = nil
                        s_5.SSlideDir = nil
                        s_5.SSlope = nil
                        s_5.SLift = nil
                        s_5.SSlideCD = u2
                        s_5.SSpeed = math.max(s_5.SSpeed, 17)
                    end
                    s_5.SSpeed = math.max(s_5.SSpeed, v84)
                    s_5.SBoost = u4
                end
                v111, v99 = v111, v80
            end
            s_5.SSpeed = math.floor((s_5.SSpeed / 0.001) + 0.5) * 0.001
            if v53 then
                v111 = 0
                s_5.SSpeed = BASE_SPEED_upv_1
            end
            v111 = math.floor((v111 / 0.01) + 0.5) * 0.01
            if v111 ~= v111 or not (v111 > -1e+07) or not (v111 < 1e+07) then
                if not (tbl_upv_9["walk speed"]) then
                    tbl_upv_9["walk speed"] = true
                    local v134 = (u13 and "Client") or "Server"
                    warn((("[SimNaN] walk speed auth=%* side=%*"):format(v134, (u11 and "server") or "client")))
                end
                s_5.SSpeed = BASE_SPEED_upv_1
                v111 = BASE_SPEED_upv_1
            end
            if humanoid_2.WalkSpeed ~= v111 then
                humanoid_2.WalkSpeed = v111
            end
            v77 = s_5.SHipBase
            if type(v77) == "number" then
                local v135, v136 = nil, nil
                if s_5.SSlide == nil then
                    v135 = v77
                else
                    v135 = math.max(0.3, v77 - 1.4)
                    v136 = s_5.SLift
                    if type(v136) == "number" and v135 < v136 then
                        v135 = v136
                    end
                end
                if v102 and v135 < v102 then
                    v135 = v102
                end
                v97 = v135
            else
                v97 = nil
            end
            if v97 then
                local v143
                if type(s_5.SHip) ~= "number" then
                    v143 = (u17 and (math.floor((humanoid_2.HipHeight / 0.001) + 0.5) * 0.001)) or (s_5.SHipBase)
                else
                    v143 = s_5.SHip
                end
                if (v101) and v97 == v101 then
                    v143 = v97
                elseif s_5.SWet ~= nil and s_5.SSlide == nil and v97 < v143 then
                    if not v85 and math.abs(v143 - v97) > 0.01 then
                        v143 = math.floor(((v143 + ((v97 - v143) * (1 - math.exp(-(((v97 < v143) and 30) or (((s_5.SLift ~= nil) and 45) or ((v102 and 30) or 14))) * a2)))) / 0.001) + 0.5) * 0.001
                    else
                        v143 = v97
                    end
                elseif math.abs(v143 - v97) > 0.01 then
                    v143 = math.floor(((v143 + ((v97 - v143) * (1 - math.exp(-(((v97 < v143) and 30) or (((s_5.SLift ~= nil) and 45) or ((v102 and 30) or 14))) * a2)))) / 0.001) + 0.5) * 0.001
                else
                    v143 = v97
                end
                if s_5.SSlide == nil and s_5.SWet == nil and v143 == v97 then
                    s_5.SHip = nil
                    if u17 then
                        s_5.SHipBase = nil
                    end
                else
                    s_5.SHip = v143
                end
                if v143 ~= v143 or not (v143 > -1e+07) or not (v143 < 1e+07) then
                    if not (tbl_upv_9["hip height"]) then
                        tbl_upv_9["hip height"] = true
                        warn((("[SimNaN] hip height auth=%* side=%*"):format((u13 and "Client") or "Server", (u11 and "server") or "client")))
                    end
                    local v137 = nil
                    if type(s_5.SHipBase) ~= "number" then
                        v143 = humanoid_2.HipHeight
                    else
                        v137 = s_5.SHipBase
                        if (v137 == v137) and ((v137 > -1e+07) and (v137 < 1e+07)) then
                            v143 = s_5.SHipBase
                        else
                            v143 = humanoid_2.HipHeight
                        end
                    end
                    s_5.SHip = nil
                end
                if humanoid_2.HipHeight ~= v143 then
                    humanoid_2.HipHeight = v143
                end
                a1.hipWritten = v143
            end
            v102 = not v53 and (not v81 and (humanoid_2.SeatPart == nil))
            if v102 then
                v101 = math.floor(((JUMP_HEIGHT_upv_1 * (1 - (v73 * 0.45))) / 0.01) + 0.5) * 0.01
            else
                v101 = 0
            end
            if humanoid_2.JumpHeight ~= v101 then
                humanoid_2.JumpHeight = v101
            end
            v101 = false
            if v102 then
                if v98 then
                    local v143 = v83 or v108 > 0
                    v101 = v143
                elseif s_5.SJumped ~= true and v90 <= u7 and AssemblyLinearVelocity_3.Y <= 1 and v108 > 0 then
                    s_5.SJumped = true
                    v108 = 0
                    humanoid_2:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
            humanoid_2.Jump = v101
            local v143
            if v108 > 0 then
                v143 = v108
            else
                v143 = nil
            end
            s_5.SJumpBuf = v121
            v75 = a1.gravity
            v102 = not v98 and ((AssemblyLinearVelocity_3.Y < 0) and (v56 ~= Enum.HumanoidStateType.Climbing))
            if v75 then
                if v102 then
                    v101 = -Workspace_upv_1.Gravity * 0.30000000000000004
                    if s_5.SSlide == nil then
                        if v101 then
                            v97 = slideCushion(a1, AssemblyLinearVelocity_3.Y, v101, 4)
                            v101 = (v97 and (v97 + Workspace_upv_1.Gravity)) or v101
                        end
                    else
                        local v138 = slideCushion(a1, AssemblyLinearVelocity_3.Y, humanoid_2.HipHeight)
                        v101 = (v138 and (v138 + Workspace_upv_1.Gravity)) or v101
                    end
                    v98 = v101 * root_10.AssemblyMass
                    if v98 ~= v98 or not (v98 > -1e+07) or not (v98 < 1e+07) then
                        if not (tbl_upv_9["fall force"]) then
                            tbl_upv_9["fall force"] = true
                            local v139 = (u13 and "Client") or "Server"
                            warn((("[SimNaN] fall force auth=%* side=%*"):format(v139, (u11 and "server") or "client")))
                        end
                        v98 = 0
                    end
                    v108.Force = Vector3.new(0, v98, 0)
                end
                if v108.Enabled ~= v102 then
                    v108.Enabled = v102
                end
            end
            v75 = nil
            v78 = s_5.SKbF or 0
            if v78 > 0 and s_5.SKb then
                local v140 = v78 / math.max(s_5.SKbN or v78, 1)
                v108 = s_5.SKb * v140 + Vector3.new(v93.X, 0, v93.Z) * v111 * (1 - v140)
                v78 = v78 - 1
                if v78 <= 0 then
                    s_5.SKb = nil
                    s_5.SKbF = nil
                    s_5.SKbN = nil
                else
                    s_5.SKbF = v78
                end
            end
            if (v109 > 0) and (s_5.SDashV) then
                local SDashV_1 = s_5.SDashV
                if v108 then
                    v108 = v108 + SDashV_1
                else
                    v108 = SDashV_1
                end
                v99 = Vector3.new(SDashV_1.X, 0, SDashV_1.Z).Unit
                v109 = v109 - 1
            elseif s_5.SDashB then
                v143 = v108 or Vector3.new(v93.X, 0, v93.Z) * v111
                s_5.SDashB = ((s_5.SDashB > 1) and (s_5.SDashB - 1)) or nil
                v108 = v143
            end
            if v109 <= 0 then
                s_5.SDashV = nil
                s_5.SDashF = nil
            else
                s_5.SDashF = v109
            end
            if v75 then
                local X_3 = v108.X
                v143 = (X_3 == X_3) and ((X_3 > -1e+07) and (X_3 < 1e+07))
                if v143 then
                    local Y_7 = v108.Y
                    v143 = (Y_7 == Y_7) and ((Y_7 > -1e+07) and (Y_7 < 1e+07))
                    if v143 then
                        local v146 = v108.Z
                        v143 = v108.Z == v108.Z and v108.Z > -1e+07 and v108.Z < 1e+07
                    end
                end
                if not (v143) then
                    v143 = s_5.SKb ~= nil and "push (knockback)" or s_5.SDashV == nil and "push" or "push (dash)"
                    if not (tbl_upv_9[v143]) then
                        tbl_upv_9[v143] = true
                        local v132 = (u13 and "Client") or "Server"
                        warn((("[SimNaN] %* auth=%* side=%*"):format(v143, v132, (u11 and "server") or "client")))
                    end
                    v108 = nil
                    s_5.SKb = nil
                    s_5.SKbF = nil
                    s_5.SKbN = nil
                    s_5.SDashV = nil
                    s_5.SDashF = nil
                end
            end
            v111 = a1.push
            if v111 then
                if v108 then
                    v111.PlaneVelocity = Vector2.new(v108.X, v108.Z)
                end
                v109 = v108 ~= nil
                if v111.Enabled ~= v109 then
                    v111.Enabled = v109
                end
            end
            if not (v99) and v91 and not (v53) and humanoid_2.SeatPart == nil then
                v99 = Vector3.new(v91.X, 0, v91.Y)
            end
            v79 = a1.align
            if v99 then
                local X_4 = v99.X
                v143 = (X_4 == X_4) and ((X_4 > -1e+07) and (X_4 < 1e+07))
                if v143 then
                    local Y_8 = v99.Y
                    v143 = (Y_8 == Y_8) and ((Y_8 > -1e+07) and (Y_8 < 1e+07))
                    if v143 then
                        local v147 = v99.Z
                        v143 = v99.Z == v99.Z and v99.Z > -1e+07 and v99.Z < 1e+07
                    end
                end
                if not (v143) then
                    if not (tbl_upv_9.facing) then
                        tbl_upv_9.facing = true
                        local v141 = (u13 and "Client") or "Server"
                        warn((("[SimNaN] facing auth=%* side=%*"):format(v141, (u11 and "server") or "client")))
                    end
                    v99 = nil
                end
            end
            if v99 and v111 then
                local v142 = nil
                if v99.Magnitude > 0.1 then
                    if humanoid_2.AutoRotate then
                        humanoid_2.AutoRotate = false
                    end
                    v108 = v99.Unit
                    v142 = CFrame.lookAt(Vector3.new(0, 0, 0), Vector3.new(math.floor((v108.X / 1e-04) + 0.5) * 1e-04, 0, math.floor((v108.Z / 1e-04) + 0.5) * 1e-04))
                    if v111.CFrame ~= v142 then
                        v111.CFrame = v142
                    end
                    if not (v111.Enabled) then
                        v111.Enabled = true
                    end
                else
                    if v111 and v111.Enabled then
                        v111.Enabled = false
                    end
                    if not (humanoid_2.AutoRotate) then
                        humanoid_2.AutoRotate = true
                    end
                end
            else
                if v111 and v111.Enabled then
                    v111.Enabled = false
                end
                if not (humanoid_2.AutoRotate) then
                    humanoid_2.AutoRotate = true
                end
            end
        else
            s_5.SSlide = nil
            s_5.SSlideDir = nil
            s_5.SSlideBuf = nil
            s_5.SSlope = nil
            s_5.SLift = nil
            s_5.SKb = nil
            s_5.SKbF = nil
            s_5.SKbN = nil
            s_5.SDashV = nil
            s_5.SDashF = nil
            s_5.SDashB = nil
            s_5.SBoost = nil
            s_5.SJumpBuf = nil
            s_5.SSpeed = BASE_SPEED_upv_1
            if a1.push and a1.push.Enabled then
                a1.push.Enabled = false
            end
            if a1.align and a1.align.Enabled then
                a1.align.Enabled = false
            end
            if a1.gravity and a1.gravity.Enabled then
                a1.gravity.Enabled = false
            end
        end
    else
        v53 = ((a1.goodCF) and "root") or "root (no last place)"
        if not (tbl_upv_9[v53]) then
            tbl_upv_9[v53] = true
            local v83 = (u13 and "Client") or "Server"
            warn((("[SimNaN] %* auth=%* side=%*"):format(v53, v83, (u11 and "server") or "client")))
        end
        local root_11 = a1.root
        local s_6 = a1.s
        v54 = a1.push
        local align_2 = a1.align
        local gravity_2 = a1.gravity
        if v54 then
            v54.PlaneVelocity = Vector2.zero
            v54.Enabled = false
        end
        if align_2 then
            align_2.Enabled = false
            align_2.CFrame = CFrame.identity
        end
        if gravity_2 then
            gravity_2.Force = Vector3.new(0, 0, 0)
            gravity_2.Enabled = false
        end
        v55 = a1.goodCF
        if v55 then
            root_11.CFrame = v55
        end
        root_11.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        root_11.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        s_6.SSlide = nil
        s_6.SSlideDir = nil
        s_6.SSlideBuf = nil
        s_6.SSlope = nil
        s_6.SLift = nil
        s_6.SKb = nil
        s_6.SKbF = nil
        s_6.SKbN = nil
        s_6.SDashV = nil
        s_6.SDashF = nil
        s_6.SDashB = nil
        s_6.SBoost = nil
        s_6.SJumpBuf = nil
        s_6.SSpeed = BASE_SPEED_upv_1
    end
    save(a1)
end
local function stepRelay(a1, a2)
    --[[
      name: stepRelay
      line: 737
      upvalues:
        stepCollisions (copy, index: 1)
    ]]
    local humanoid_3 = a1.humanoid
    local root_12 = a1.root
    local v144 = (humanoid_3:GetState() ~= Enum.HumanoidStateType.Dead) and (humanoid_3.Health > 0)
    stepCollisions(a1, v144)
    local v145 = ((a1.frozen) and true) or nil
    if root_12:GetAttribute("SFrozen") ~= v145 then
        root_12:SetAttribute("SFrozen", v145)
    end
    local v146 = ((a1.slow ~= 1) and (math.floor((a1.slow / 0.001) + 0.5) * 0.001)) or nil
    if root_12:GetAttribute("SSlow") ~= v146 then
        root_12:SetAttribute("SSlow", v146)
    end
    local v147 = ((a1.noJump) and true) or nil
    if root_12:GetAttribute("SNoJump") ~= v147 then
        root_12:SetAttribute("SNoJump", v147)
    end
    local pending_1 = a1.pending
    local v148 = nil
    if pending_1.tp then
        local tp_2 = pending_1.tp
        pending_1.tp = nil
        a1.character:PivotTo(tp_2)
        root_12:SetAttribute("STpCF", tp_2)
        v148 = root_12:GetAttribute("STp")
        local v149
        if type(v148) ~= "number" then
            v149 = 0
        else
            v149 = v148
        end
        root_12:SetAttribute("STp", v149 + 1)
    end
    if pending_1.kb and v144 then
        local v150 = root_12:GetAttribute("NKbSeq")
        root_12:SetAttribute("NKb", pending_1.kb)
        root_12:SetAttribute("NKbDur", pending_1.kbDur)
        local v149
        if type(v150) ~= "number" then
            v149 = 0
        else
            v149 = v150
        end
        root_12:SetAttribute("NKbSeq", v149 + 1)
    end
    pending_1.kb = nil
    pending_1.kbDur = nil
end
local function unregister(a1)
    --[[
      name: unregister
      line: 1434
      upvalues:
        tbl_upv_4 (copy, index: 1)
        tbl_upv_5 (copy, index: 2)
    ]]
    local v151 = tbl_upv_4[a1]
    if not v151 then
        return
    end
    tbl_upv_4[a1] = nil
    for _, value_8 in v151.conns do
        value_8:Disconnect()
    end
    table.clear(tbl_upv_5)
    for _, value_9 in tbl_upv_4 do
        table.insert(tbl_upv_5, value_9)
    end
end
local function moveActionOf(a1, a2)
    --[[
      name: moveActionOf
      line: 1463
    ]]
    local v152 = a1:FindFirstChild("InputContexts") or (a1:WaitForChild("InputContexts", a2))
    local v153 = v152 and (v152:FindFirstChild("CharacterContext") or (v152:WaitForChild("CharacterContext", 5)))
    local v154 = v153 and (v153:FindFirstChild("MoveAction") or (v153:WaitForChild("MoveAction", 5)))
    if v154 and v154:IsA("InputAction") then
        return v154
    end
    warn("[Simulation] no InputContexts.CharacterContext.MoveAction: walking falls back to the PlayerModule")
    return nil
end
local function ensureConstraints(a1)
    --[[
      name: ensureConstraints
      line: 1488
    ]]
    local RootAttachment_1 = a1:FindFirstChild("RootAttachment")
    if RootAttachment_1 and RootAttachment_1:IsA("Attachment") then
        local v155 = a1:FindFirstChild("TribesKnockback")
        local v156 = nil
        if not (v155) then
            v156 = Instance.new("LinearVelocity")
            v156.Name = "TribesKnockback"
            v156.Attachment0 = RootAttachment_1
            v156.RelativeTo = Enum.ActuatorRelativeTo.World
            v156.VelocityConstraintMode = Enum.VelocityConstraintMode.Plane
            v156.PrimaryTangentAxis = Vector3.new(1, 0, 0)
            v156.SecondaryTangentAxis = Vector3.new(0, 0, 1)
            v156.ForceLimitMode = Enum.ForceLimitMode.Magnitude
            v156.MaxForce = 1e+06
            v156.Enabled = false
            v156.Parent = a1
            v155 = v156
        end
        v156 = a1:FindFirstChild("TribesFallGravity")
        local v157 = nil
        if not (v156) then
            v157 = Instance.new("VectorForce")
            v157.Name = "TribesFallGravity"
            v157.Attachment0 = RootAttachment_1
            v157.RelativeTo = Enum.ActuatorRelativeTo.World
            v157.ApplyAtCenterOfMass = true
            v157.Force = Vector3.new(0, 0, 0)
            v157.Enabled = false
            v157.Parent = a1
            v156 = v157
        end
        v157 = a1:FindFirstChild("TribesFacing")
        if not (v157) then
            local v158 = Instance.new("AlignOrientation")
            v158.Name = "TribesFacing"
            v158.Mode = Enum.OrientationAlignmentMode.OneAttachment
            v158.Attachment0 = RootAttachment_1
            v158.RigidityEnabled = true
            v158.MaxTorque = math.huge
            v158.MaxAngularVelocity = math.huge
            v158.Enabled = false
            v158.Parent = a1
            v157 = v158
        end
        local v158 = not (v155) or not (v155:IsA("LinearVelocity")) or v155
        local v159 = not (v156) or not (v156:IsA("VectorForce")) or v156
        if v157 and v157:IsA("AlignOrientation") then
            return v158, v159, v157
        end
        return v158, v159, nil
    end
    return nil, nil, nil
end
local function corpseParts(a1)
    --[[
      name: corpseParts
      line: 1568
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    local tbl_12 = {}
    for _, value_10 in tbl_upv_2 do
        local v160 = a1:FindFirstChild(value_10)
        if not (v160) then
            continue
        end
        if v160:IsA("BasePart") then
            table.insert(tbl_12, v160)
        end
    end
    return tbl_12
end
local function actionsOf(a1, a2)
    --[[
      name: actionsOf
      line: 1446
      upvalues:
        Inputs_upv_1 (copy, index: 1)
    ]]
    local tbl_13 = {}
    local v161 = a1:FindFirstChild(Inputs_upv_1.CONTEXT) or (a1:WaitForChild(Inputs_upv_1.CONTEXT, a2))
    if v161 then
        for _, value_11 in Inputs_upv_1.ACTIONS do
            local v162 = v161:FindFirstChild(value_11.name) or (v161:WaitForChild(value_11.name, 5))
            if not (v162) then
                continue
            end
            if v162:IsA("InputAction") then
                tbl_13[value_11.name] = v162
            end
        end
    end
    return tbl_13
end
local function ensureHull(a1)
    --[[
      name: ensureHull
      line: 1539
      upvalues:
        u17 (copy, index: 1)
    ]]
    local TribesHull_1 = a1:FindFirstChild("TribesHull")
    if TribesHull_1 and TribesHull_1:IsA("BasePart") then
        return TribesHull_1
    end
    if u17 then
        return nil
    end
    local Size_1 = a1.Size
    local v163 = Instance.new("Part")
    v163.Name = "TribesHull"
    v163.Shape = Enum.PartType.Cylinder
    v163.Size = Vector3.new(Size_1.Y * 1.4, Size_1.X * 0.9, Size_1.X * 0.9)
    v163.Transparency = 1
    v163.CastShadow = false
    v163.Massless = true
    v163.CanCollide = true
    v163.CanQuery = false
    v163.CanTouch = false
    v163.CollisionGroup = a1.CollisionGroup
    v163.CFrame = a1.CFrame * CFrame.new(0, Size_1.Y * 0.2, 0) * CFrame.Angles(0, 0, 1.5707963267948966)
    Size_1 = Instance.new("WeldConstraint")
    Size_1.Part0 = a1
    Size_1.Part1 = v163
    Size_1.Parent = v163
    v163.Parent = a1
    return v163
end
local function recomputeMirrors(a1)
    --[[
      name: recomputeMirrors
      line: 1475
    ]]
    local humanoid_4 = a1.humanoid
    local v164 = 1
    for key_3, value_12 in humanoid_4:GetAttributes() do
        if typeof(value_12) ~= "number" or string.sub(key_3, 1, 9) ~= "SpeedMult" then
            continue
        end
        if value_12 == value_12 then
            v164 = v164 * math.clamp(value_12, 0, 3)
        end
    end
    a1.slow = v164
    a1.frozen = a1.player:GetAttribute("Frozen") == true
    local v166 = true
    local v167
    if humanoid_4:GetAttribute("NoJump") == true then
        v167 = v166
    else
        v167 = true
        if a1.character:GetAttribute("NoJump") ~= true then
            v167 = a1.character:GetAttribute("Rooted") == true
        end
    end
    a1.noJump = v167
end
local function bodyParts(a1)
    --[[
      name: bodyParts
      line: 1579
    ]]
    local tbl_14 = {}
    for _, value_13 in a1:GetChildren() do
        if value_13:IsA("BasePart") then
            table.insert(tbl_14, value_13)
        end
    end
    return tbl_14
end
local function register(a1, a2)
    --[[
      name: register
      line: 1589
      upvalues:
        tbl_upv_4 (copy, index: 1)
        tbl_upv_5 (copy, index: 2)
        u11 (copy, index: 3)
        JUMP_HEIGHT_upv_1 (copy, index: 4)
        BASE_SPEED_upv_1 (copy, index: 5)
        u16 (copy, index: 6)
        ensureConstraints (copy, index: 7)
        ensureHull (copy, index: 8)
        u13 (copy, index: 9)
        RunService_upv_1 (copy, index: 10)
        u17 (copy, index: 11)
        u15 (copy, index: 12)
        actionsOf (copy, index: 13)
        moveActionOf (copy, index: 14)
        bodyParts (copy, index: 15)
        corpseParts (copy, index: 16)
        recomputeMirrors (copy, index: 17)
    ]]
    local v168 = tbl_upv_4[a2]
    if v168 then
        tbl_upv_4[a2] = nil
        for _, value_14 in v168.conns do
            value_14:Disconnect()
        end
        table.clear(tbl_upv_5)
        for _, value_15 in tbl_upv_4 do
            table.insert(tbl_upv_5, value_15)
        end
    end
    local v169 = a2:WaitForChild("Humanoid", 10)
    local u26 = a2:WaitForChild("HumanoidRootPart", 10)
    if not v169 or not v169:IsA("Humanoid") or not u26 or not u26:IsA("BasePart") or a1.Character ~= a2 then
        return
    end
    local v170, v171, v172, v173, v174 = nil, nil, nil, nil, nil
    if u11 then
        v169.UseJumpPower = false
        v169.JumpHeight = JUMP_HEIGHT_upv_1
        v169.WalkSpeed = BASE_SPEED_upv_1
        v169:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        v169:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        v169:SetStateEnabled(Enum.HumanoidStateType.Swimming, u16)
        local _, v181, v182 = ensureConstraints(u26)
        local v175 = ensureHull(u26)
        if u13 then
            pcall(
                function()
                    --[[
                      line: 1614
                      upvalues:
                        u26 (copy, index: 1)
                        a1 (copy, index: 2)
                    ]]
                    u26:SetNetworkOwner(a1)
                end
            )
        end
        v170 = v175
    else
        pcall(
            function()
                --[[
                  line: 1620
                  upvalues:
                    RunService_upv_1 (copy, index: 1)
                    u26 (copy, index: 2)
                ]]
                RunService_upv_1:SetPredictionMode(u26, Enum.PredictionMode.On)
            end
        )
        v169:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        v169:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        v169:SetStateEnabled(Enum.HumanoidStateType.Swimming, u16)
        v174 = u26:WaitForChild("TribesKnockback", 10)
        local v176 = u26:WaitForChild("TribesFallGravity", 10)
        local v177 = u26:WaitForChild("TribesFacing", 10)
        v171 = not (v174) or not (v174:IsA("LinearVelocity")) or v174
        v172 = not (v176) or not (v176:IsA("VectorForce")) or v176
        v173 = not (v177) or not (v177:IsA("AlignOrientation")) or v177
        v177 = u17 or u26:WaitForChild("TribesHull", 10)
        v170 = not (v177) or not (v177:IsA("BasePart")) or v177
    end
    local v178 = (u15 and {}) or (actionsOf(a1, 20))
    local v179 = u13 or moveActionOf(a1, 10)
    if a1.Character ~= a2 or not a2.Parent then
        return
    end
    local v180 = RaycastParams.new()
    v180.FilterType = Enum.RaycastFilterType.Exclude
    v180.FilterDescendantsInstances = {a2}
    v180.RespectCanCollide = true
    v180.IgnoreWater = true
    local tbl_upv_15 = {noJump = false, holdSlot = -1, slow = 1, failed = false, holdBad = 0, frozen = false}
    tbl_upv_15.player = a1
    tbl_upv_15.character = a2
    tbl_upv_15.humanoid = v169
    tbl_upv_15.root = u26
    tbl_upv_15.push = v171
    tbl_upv_15.gravity = v172
    tbl_upv_15.align = v173
    tbl_upv_15.actions = v178
    tbl_upv_15.move = v179
    tbl_upv_15.hull = v170
    tbl_upv_15.body = bodyParts(a2)
    tbl_upv_15.corpse = corpseParts(a2)
    tbl_upv_15.ray = v180
    tbl_upv_15.s = {}
    tbl_upv_15.prev = {}
    tbl_upv_15.tpSeen = u26:GetAttribute("STp")
    tbl_upv_15.kbSeen = u26:GetAttribute("NKbSeq")
    tbl_upv_15.pending = {}
    tbl_upv_15.conns = {}
    if u11 then
        recomputeMirrors(tbl_upv_15)
        local function refresh_1()
            --[[
              name: refresh
              line: 1678
              upvalues:
                recomputeMirrors (copy, index: 1)
                tbl_upv_15 (copy, index: 2)
            ]]
            recomputeMirrors(tbl_upv_15)
        end
        table.insert(tbl_upv_15.conns, v169.AttributeChanged:Connect(refresh_1))
        table.insert(tbl_upv_15.conns, a2.AttributeChanged:Connect(refresh_1))
        table.insert(tbl_upv_15.conns, a1:GetAttributeChangedSignal("Frozen"):Connect(refresh_1))
    end
    table.insert(
        tbl_upv_15.conns,
        a2.AncestryChanged:Connect(
            function()
                --[[
                  line: 1685
                  upvalues:
                    a2 (copy, index: 1)
                    tbl_upv_4 (copy, index: 2)
                    tbl_upv_5 (copy, index: 3)
                ]]
                if a2:IsDescendantOf(game) then
                    return
                end
                local v181 = a2
                local v182 = tbl_upv_4[v181]
                if not v182 then
                    return
                end
                tbl_upv_4[v181] = nil
                for _, value_16 in v182.conns do
                    value_16:Disconnect()
                end
                table.clear(tbl_upv_5)
                for _, value_17 in tbl_upv_4 do
                    table.insert(tbl_upv_5, value_17)
                end
            end
        )
    )
    tbl_upv_4[a2] = tbl_upv_15
    table.clear(tbl_upv_5)
    for _, value_18 in tbl_upv_4 do
        table.insert(tbl_upv_5, value_18)
    end
end
function tbl_upv_1.Knockback(a1, a2, a3)
    --[[
      name: Knockback
      line: 1713
      upvalues:
        tbl_upv_4 (copy, index: 1)
        u11 (copy, index: 2)
    ]]
    local v183 = tbl_upv_4[a1]
    if v183 and u11 and typeof(a2) == "Vector3" and a2 == a2 then
        local pending_2 = v183.pending
        local v184
        if pending_2.kb then
            v184 = pending_2.kb + a2
        else
            v184 = a2
        end
        pending_2.kb = v184
        pending_2.kbDur = a3
        return true
    end
    return false
end
function tbl_upv_1.Teleport(a1, a2)
    --[[
      name: Teleport
      line: 1728
      upvalues:
        tbl_upv_4 (copy, index: 1)
        u11 (copy, index: 2)
        finCF (copy, index: 3)
    ]]
    local v185 = tbl_upv_4[a1]
    if v185 and u11 and typeof(a2) == "CFrame" and finCF(a2) then
        v185.pending.tp = a2
        return true
    end
    return false
end
local tbl_upv_16 = {}
local tbl_upv_17 = {}
local tbl_upv_18 = {}
local function fire(a1)
    --[[
      name: fire
      line: 1744
      upvalues:
        tbl_upv_16 (copy, index: 1)
        tbl_upv_7 (copy, index: 2)
        tbl_upv_17 (copy, index: 3)
        u13 (copy, index: 4)
        tbl_upv_8 (copy, index: 5)
    ]]
    local u27 = tbl_upv_16[a1]
    local u28 = tbl_upv_7[a1]
    if not u27 or u28 == nil or tbl_upv_17[a1] == u28 then
        return
    end
    if not u13 or not tbl_upv_8[a1] then
        if pcall(
            function()
                --[[
                  line: 1753
                  upvalues:
                    u27 (copy, index: 1)
                    u28 (copy, index: 2)
                ]]
                u27:Fire(u28)
            end
        ) then
            tbl_upv_17[a1] = u28
        end
        return
    end
end
function tbl_upv_1.SetInput(a1, a2)
    --[[
      name: SetInput
      line: 1762
      upvalues:
        u11 (copy, index: 1)
        tbl_upv_18 (copy, index: 2)
        tbl_upv_7 (copy, index: 3)
        fire (copy, index: 4)
    ]]
    if u11 then
        return
    end
    tbl_upv_18[a1] = (tbl_upv_18[a1] or 0) + 1
    tbl_upv_7[a1] = a2
    fire(a1)
end
function tbl_upv_1.Pulse(a1, a2)
    --[[
      name: Pulse
      line: 1772
      upvalues:
        tbl_upv_1 (copy, index: 1)
        tbl_upv_18 (copy, index: 2)
    ]]
    tbl_upv_1.SetInput(a1, true)
    local u29 = tbl_upv_18[a1]
    task.delay(
        a2 or 0.12,
        function()
            --[[
              line: 1775
              upvalues:
                tbl_upv_18 (copy, index: 1)
                a1 (copy, index: 2)
                u29 (copy, index: 3)
                tbl_upv_1 (copy, index: 4)
            ]]
            if tbl_upv_18[a1] ~= u29 then
                return
            end
            tbl_upv_1.SetInput(a1, false)
        end
    )
end
function tbl_upv_1.SetFacing(a1)
    --[[
      name: SetFacing
      line: 1783
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    if a1 ~= nil and a1 == a1 then
        tbl_upv_1.SetInput("Facing", Vector2.new(math.floor((-math.sin(a1) / 0.001) + 0.5) * 0.001, math.floor((-math.cos(a1) / 0.001) + 0.5) * 0.001))
    else
        tbl_upv_1.SetInput("Facing", Vector2.zero)
    end
end
function tbl_upv_1.SetLook(a1)
    --[[
      name: SetLook
      line: 1793
      upvalues:
        u11 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    if (u11) or type(a1) ~= "number" or a1 ~= a1 then
        return
    end
    tbl_upv_1.SetInput("Look", Vector2.new(math.floor((-math.sin(a1) / 0.001) + 0.5) * 0.001, math.floor((-math.cos(a1) / 0.001) + 0.5) * 0.001))
end
function tbl_upv_1.WriteGuardStats()
    --[[
      name: WriteGuardStats
      line: 1831
      upvalues:
        WriteGuard_upv_1 (copy, index: 1)
    ]]
    return WriteGuard_upv_1.Stats()
end
function tbl_upv_1.WriteGuardReset()
    --[[
      name: WriteGuardReset
      line: 1835
      upvalues:
        WriteGuard_upv_1 (copy, index: 1)
    ]]
    WriteGuard_upv_1.Reset()
end
function tbl_upv_1.IsSliding(a1)
    --[[
      name: IsSliding
      line: 1840
    ]]
    local v186 = a1 and (a1:FindFirstChild("HumanoidRootPart"))
    local v187 = false
    if v186 ~= nil then
        v187 = v186:GetAttribute("SSlide") ~= nil
    end
    return v187
end
function tbl_upv_1.IsDashing(a1)
    --[[
      name: IsDashing
      line: 1845
    ]]
    local v188 = a1 and (a1:FindFirstChild("HumanoidRootPart"))
    local v189 = false
    if v188 ~= nil then
        v189 = v188:GetAttribute("SDashF") ~= nil
    end
    return v189
end
local tbl_upv_19 = {}
local u30 = false
local function startFallback()
    --[[
      name: startFallback
      line: 1862
      upvalues:
        u30 (ref,  index: 1)
        RunService_upv_1 (copy, index: 2)
    ]]
    if u30 then
        return
    end
    u30 = true
    local _ = 0
    RunService_upv_1.PreSimulation:Connect(function() end)
end
function tbl_upv_1.BindStep(a1, a2)
    --[[
      name: BindStep
      line: 1881
      upvalues:
        tbl_upv_19 (copy, index: 1)
        RunService_upv_1 (copy, index: 2)
        u13 (copy, index: 3)
        u30 (ref,  index: 4)
    ]]
    local tbl_upv_20 = {fallback = false, calls = 0}
    tbl_upv_20.fn = a1
    tbl_upv_20.priority = a2
    table.insert(tbl_upv_19, tbl_upv_20)
    table.sort(
        tbl_upv_19,
        function(a3, a4)
            --[[
              line: 1884
            ]]
            return a3.priority < a4.priority
        end
    )
    local success_upv_2, u31 = pcall(
        function()
            --[[
              line: 1887
              upvalues:
                RunService_upv_1 (copy, index: 1)
                tbl_upv_20 (copy, index: 2)
                a1 (copy, index: 3)
                a2 (copy, index: 4)
            ]]
            RunService_upv_1:BindToSimulation(
                function(a5)
                    --[[
                      line: 1888
                      upvalues:
                        tbl_upv_20 (copy, index: 1)
                        a1 (copy, index: 2)
                    ]]
                    tbl_upv_20.calls = tbl_upv_20.calls + 1
                    tbl_upv_20.fallback = false
                    a1(a5)
                end,
                Enum.StepFrequency.Hz60,
                a2
            )
        end
    )
    if success_upv_2 and not u13 then
        return
    end
    task.delay(
        (success_upv_2 and 1.5) or 0,
        function()
            --[[
              line: 1897
              upvalues:
                tbl_upv_20 (copy, index: 1)
                u30 (ref,  index: 2)
                RunService_upv_1 (copy, index: 3)
                tbl_upv_19 (copy, index: 4)
                a2 (copy, index: 5)
                success_upv_2 (copy, index: 6)
                u31 (copy, index: 7)
            ]]
            if tbl_upv_20.calls ~= 0 then
                return
            end
            tbl_upv_20.fallback = true
            if not (u30) then
                u30 = true
                local u32 = 0
                RunService_upv_1.PreSimulation:Connect(
                    function(a6)
                        --[[
                          line: 1868
                          upvalues:
                            u32 (ref,  index: 1)
                            tbl_upv_19 (copy, index: 2)
                        ]]
                        u32 = math.min(u32 + a6, 0.06666666666666667)
                        while u32 >= 0.016666666666666666 do
                            u32 = u32 - 0.016666666666666666
                            for _, value_19 in tbl_upv_19 do
                                if value_19.fallback then
                                    value_19.fn(0.016666666666666666)
                                end
                            end
                        end
                    end
                )
            end
            if RunService_upv_1:IsStudio() then
                local v190 = (success_upv_2 and "never called") or (tostring(u31))
                warn((("[Simulation] BindToSimulation isn't running the priority-%* step (%*): stepping it from PreSimulation at 60 Hz"):format(a2, v190)))
            end
        end
    )
end
function tbl_upv_1.StepSource()
    --[[
      name: StepSource
      line: 1909
      upvalues:
        tbl_upv_19 (copy, index: 1)
    ]]
    local v191 = false
    local v193 = false
    for _, value_20 in tbl_upv_19 do
        local v194 = v191 or (value_20.calls > 0)
        v194 = v193 or (value_20.fallback)
        v191 = v194
    end
    if v193 then
        return "fallback"
    elseif v191 then
        return "engine"
    else
        return "waiting"
    end
end
local function startRemoteCollisionGuard(a1, a2)
    --[[
      name: startRemoteCollisionGuard
      line: 1965
      upvalues:
        RunService_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    local u33 = 0
    local u34 = nil
    local u35 = {}
    local u36 = 0.25
    RunService_upv_1.Heartbeat:Connect(
        function(a3)
            --[[
              line: 1970
              upvalues:
                u36 (ref,  index: 1)
                a1 (copy, index: 2)
                u34 (ref,  index: 3)
                a2 (copy, index: 4)
                u35 (ref,  index: 5)
            ]]
            u36 = u36 + a3
            if u36 < 0.25 then
                return
            end
            u36 = 0
            local Character_1 = a1.Character
            local v195 = Character_1 and (Character_1:FindFirstChild("HumanoidRootPart"))
            local v196 = not (v195) or not (v195:IsA("BasePart")) or v195
            u34 = v196
            local tbl_21 = {}
            if u34 then
                local Position_6 = u34.Position
                for key_4 in a2 do
                    local HumanoidRootPart_1 = key_4:FindFirstChild("HumanoidRootPart")
                    if key_4 == Character_1 or not (HumanoidRootPart_1) or not (HumanoidRootPart_1:IsA("BasePart")) or (HumanoidRootPart_1.Position - Position_6).Magnitude > 70 then
                        continue
                    end
                    local v197 = key_4:FindFirstChildOfClass("Humanoid")
                    if not (v197) or v197.Health <= 0 or not (HumanoidRootPart_1:FindFirstChild("TribesHull")) then
                        continue
                    end
                    local tbl_22 = {}
                    for _, value_21 in key_4:GetChildren() do
                        if value_21:IsA("BasePart") then
                            table.insert(tbl_22, value_21)
                        end
                    end
                    table.insert(tbl_21, {root = HumanoidRootPart_1, parts = tbl_22})
                end
            end
            u35 = tbl_21
        end
    )
    tbl_upv_1.BindStep(
        function()
            --[[
              line: 2002
              upvalues:
                u34 (ref, index: 1)
                u35 (ref, index: 2)
                u33 (ref, index: 3)
            ]]
            if not u34 then
                return
            end
            local Position_7 = u34.Position
            for _, value_22 in u35 do
                if (value_22.root.Position - Position_7).Magnitude > 40 then
                    continue
                end
                local parts_1 = value_22.parts
                for n_3 = 1, #parts_1 do
                    local v198 = parts_1[n_3]
                    if v198.CanCollide then
                        v198.CanCollide = false
                        u33 = u33 + 1
                    end
                end
            end
        end,
        1
    )
    tbl_upv_1.RemoteCollisionFixes = function()
        --[[
          line: 2022
          upvalues:
            u33 (ref, index: 1)
        ]]
        return u33
    end
end
local function predictionOff(a1, a2, a3)
    --[[
      name: predictionOff
      line: 1926
      upvalues:
        RunService_upv_1 (copy, index: 1)
    ]]
    local tbl_upv_23 = {}
    local u37 = a3 or (Enum.PredictionMode.Off)
    for _, value_upv_23 in a1:GetDescendants() do
        local v199 = value_upv_23:IsA("BasePart")
        if v199 then
            pcall(
                function()
                    --[[
                      line: 1931
                      upvalues:
                        RunService_upv_1 (copy, index: 1)
                        value_upv_23 (copy, index: 2)
                        u37 (copy, index: 3)
                    ]]
                    RunService_upv_1:SetPredictionMode(value_upv_23, u37)
                end
            )
        end
    end
    local function off_1(a4)
        --[[
          name: off
          line: 1929
        ]]
        if not a4:IsA("BasePart") then
            return
        end
        pcall(function() end)
    end
    table.insert(tbl_upv_23, a1.DescendantAdded:Connect(off_1))
    table.insert(
        tbl_upv_23,
        a1.AncestryChanged:Connect(
            function()
                --[[
                  line: 1940
                  upvalues:
                    a1 (copy, index: 1)
                    tbl_upv_23 (copy, index: 2)
                    a2 (copy, index: 3)
                ]]
                if (a1:IsDescendantOf(game)) then
                    return
                end
                for _, value_24 in tbl_upv_23 do
                    value_24:Disconnect()
                end
                a2()
            end
        )
    )
end
local function startArrivalGuard(a1)
    --[[
      name: startArrivalGuard
      line: 2099
      upvalues:
        RunService_upv_1 (copy, index: 1)
        Workspace_upv_1 (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
    ]]
    local u38 = RaycastParams.new()
    u38.FilterType = Enum.RaycastFilterType.Exclude
    u38.RespectCanCollide = true
    u38.IgnoreWater = true
    local u39 = nil
    local u40 = nil
    local u41 = false
    local u42 = 0
    local u43 = nil
    local u44 = 0
    local u45 = 0
    local function release_1()
        --[[
          name: release
          line: 2109
          upvalues:
            u43 (ref, index: 1)
        ]]
        u43 = nil
        if not u43 or not u43.Parent or not u43.Anchored then
            return
        end
        u43.Anchored = false
    end
    RunService_upv_1.PreSimulation:Connect(
        function(a2)
            --[[
              line: 2116
              upvalues:
                a1 (copy, index: 1)
                u39 (ref,  index: 2)
                u40 (ref,  index: 3)
                u41 (ref,  index: 4)
                u43 (ref,  index: 5)
                u42 (ref,  index: 6)
                u38 (copy, index: 7)
                Workspace_upv_1 (copy, index: 8)
                u44 (ref,  index: 9)
                u45 (ref,  index: 10)
            ]]
            local Character_2 = a1.Character
            local v200 = Character_2 and (Character_2:FindFirstChild("HumanoidRootPart"))
            if Character_2 and v200 and v200:IsA("BasePart") then
                local Position_8 = v200.Position
                local v201 = v200 ~= u39
                if not (v201) and u40 then
                    v201 = (Position_8 - u40 - (Character_2.AssemblyLinearVelocity * a2)).Magnitude > 20
                end
                if v201 then
                    if u43 and u43 ~= Character_2 then
                        u43 = nil
                    end
                    u41 = true
                    u42 = 0
                end
                u39 = Character_2
                u40 = Position_8
                if not u41 then
                    return
                end
                u42 = u42 + a2
                v201 = Character_2:FindFirstChildOfClass("Humanoid")
                if v201 then
                    local v202 = nil
                    if not (v201.Health <= 0) then
                        u38.FilterDescendantsInstances = {Character_2}
                        v201 = Workspace_upv_1:Raycast(Position_8, Vector3.new(0, -80, 0), u38)
                        local _ = false
                        if (v201 == nil or not (Position_8.Y - v201.Position.Y <= 12)) and (v201 == nil or not (u42 >= 6)) and not (u42 >= 12) then
                            if not (Character_2.Anchored) then
                                Character_2.Anchored = true
                                u43 = Character_2
                                u44 = u44 + 1
                            end
                            if u43 == Character_2 then
                                u45 = u45 + a2
                            end
                            return
                        end
                        u41 = false
                        v202 = u43
                        u43 = nil
                        if v202 and v202.Parent and v202.Anchored then
                            v202.Anchored = false
                        end
                        return
                    end
                end
                u41 = false
                local v203 = u43
                u43 = nil
                if v203 and v203.Parent and v203.Anchored then
                    v203.Anchored = false
                end
                return
            end
            u39 = nil
            u40 = nil
            u41 = false
            u43 = nil
        end
    )
    tbl_upv_1.ArrivalHolds = function()
        --[[
          line: 2164
          upvalues:
            u44 (ref, index: 1)
            u45 (ref, index: 2)
        ]]
        return u44, u45
    end
end
local u46 = false
local function onPlayer(a1)
    --[[
      name: onPlayer
      line: 1694
      upvalues:
        u11 (copy, index: 1)
        Inputs_upv_1 (copy, index: 2)
        register (copy, index: 3)
        unregister (copy, index: 4)
    ]]
    if u11 then
        Inputs_upv_1.Build(a1)
    end
    a1.CharacterAdded:Connect(
        function(a2)
            --[[
              line: 1698
              upvalues:
                register (copy, index: 1)
                a1 (copy, index: 2)
            ]]
            register(a1, a2)
        end
    )
    a1.CharacterRemoving:Connect(unregister)
    if not a1.Character then
        return
    end
    task.spawn(register, a1, a1.Character)
end
local function startPredictionPolicy(a1)
    --[[
      name: startPredictionPolicy
      line: 2027
      upvalues:
        predictionOff (copy, index: 1)
        RunService_upv_1 (copy, index: 2)
        Players_upv_1 (copy, index: 3)
        startRemoteCollisionGuard (copy, index: 4)
    ]]
    local CollectionService_1 = game:GetService("CollectionService")
    local u47 = setmetatable({}, {__mode = "k"})
    local u48 = nil
    local v204 = RunService_upv_1:IsStudio()
    local v205 = nil
    if v204 then
        v205 = workspace:GetAttribute("BotPredictionMode")
        if v205 == "On" then
            u48 = Enum.PredictionMode.On
        elseif v205 == "Automatic" then
            u48 = Enum.PredictionMode.Automatic
        end
    end
    local function applyTagged_1(a2)
        --[[
          name: applyTagged
          line: 2050
          upvalues:
            Players_upv_1 (copy, index: 1)
            u48 (ref,  index: 2)
            u47 (copy, index: 3)
            predictionOff (copy, index: 4)
        ]]
        if not a2:IsA("Model") then
            return
        end
        if Players_upv_1:GetPlayerFromCharacter(a2) == nil then
            local v206 = u48
            if not a2:IsA("Model") or (u47[a2]) then
                return
            end
            u47[a2] = true
            predictionOff(a2, function() end, v206)
        end
    end
    for _, value_25 in {"Combatant", "Bot"} do
        CollectionService_1:GetInstanceAddedSignal(value_25):Connect(applyTagged_1)
        for v208, value_26 in CollectionService_1:GetTagged(value_25) do
            if not (value_26:IsA("Model")) or Players_upv_1:GetPlayerFromCharacter(value_26) ~= nil then
                continue
            end
            local v207 = u48
            if not (value_26:IsA("Model")) then
                continue
            end
            if not (u47[value_26]) then
                u47[value_26] = true
                predictionOff(value_26, function() end, v207)
            end
        end
    end
    local function apply_upv_1(a3, a4)
        --[[
          name: apply
          line: 2030
          upvalues:
            u47 (copy, index: 1)
            predictionOff (copy, index: 2)
        ]]
        if not a3:IsA("Model") or (u47[a3]) then
            return
        end
        u47[a3] = true
        predictionOff(a3, function() end, a4)
    end
    local function watchPlayer_1(a5)
        --[[
          name: watchPlayer
          line: 2061
          upvalues:
            a1 (copy, index: 1)
            apply_upv_1 (copy, index: 2)
            u47 (copy, index: 3)
            predictionOff (copy, index: 4)
        ]]
        if a5 == a1 then
            return
        end
        a5.CharacterAdded:Connect(apply_upv_1)
        if a5.Character then
            local Character_3 = a5.Character
            if Character_3:IsA("Model") and not (u47[Character_3]) then
                u47[Character_3] = true
                predictionOff(Character_3, function() end, nil)
            end
        end
    end
    Players_upv_1.PlayerAdded:Connect(watchPlayer_1)
    for _, value_27 in Players_upv_1:GetPlayers() do
        if value_27 == a1 then
            continue
        end
        value_27.CharacterAdded:Connect(apply_upv_1)
        if not (value_27.Character) then
            continue
        end
        local Character_upv_4 = value_27.Character
        if not (Character_upv_4:IsA("Model")) then
            continue
        end
        if not (u47[Character_upv_4]) then
            u47[Character_upv_4] = true
            predictionOff(
                Character_upv_4,
                function()
                    --[[
                      line: 2033
                      upvalues:
                        u47 (copy, index: 1)
                        Character_upv_4 (copy, index: 2)
                    ]]
                    u47[Character_upv_4] = nil
                end,
                nil
            )
        end
    end
    if (RunService_upv_1:IsStudio()) and workspace:GetAttribute("RemoteCollideGuardOff") == true then
        return
    end
    startRemoteCollisionGuard(a1, u47)
end
local function watchHold(a1)
    --[[
      name: watchHold
      line: 1802
      upvalues:
        Inputs_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    local tbl_upv_24 = {}
    local function update_upv_1(a2)
        --[[
          name: update
          line: 1804
          upvalues:
            Inputs_upv_1 (copy, index: 1)
            tbl_upv_1 (copy, index: 2)
        ]]
        local v208 = a2:FindFirstChildWhichIsA("Tool")
        local v209
        if v208 then
            v209 = v208:GetAttribute("SlotIndex")
        else
            v209 = nil
        end
        if type(v209) == "number" and v209 == v209 then
            v208 = math.clamp(math.floor(v209 + 0.5), 0, Inputs_upv_1.HOLD_SLOTS)
        else
            v208 = 0
        end
        tbl_upv_1.SetInput("Hold", v208 / Inputs_upv_1.HOLD_SCALE)
    end
    local function onCharacter_1(a3)
        --[[
          name: onCharacter
          line: 1810
          upvalues:
            tbl_upv_24 (copy, index: 1)
            update_upv_1 (copy, index: 2)
        ]]
        for _, value_28 in tbl_upv_24 do
            value_28:Disconnect()
        end
        table.clear(tbl_upv_24)
        local function changed_1(a4)
            --[[
              name: changed
              line: 1815
              upvalues:
                update_upv_1 (copy, index: 1)
                a3 (copy, index: 2)
            ]]
            if not a4:IsA("Tool") then
                return
            end
            update_upv_1(a3)
        end
        table.insert(tbl_upv_24, a3.ChildAdded:Connect(changed_1))
        table.insert(tbl_upv_24, a3.ChildRemoved:Connect(changed_1))
        update_upv_1(a3)
    end
    a1.CharacterAdded:Connect(onCharacter_1)
    if not a1.Character then
        return
    end
    onCharacter_1(a1.Character)
end
local function step(a1)
    --[[
      name: step
      line: 1408
      upvalues:
        u11 (copy, index: 1)
        trackCorrection (copy, index: 2)
        u15 (copy, index: 3)
        stepRelay (copy, index: 4)
        stepChar (copy, index: 5)
        tbl_upv_5 (copy, index: 6)
        tbl_upv_10 (copy, index: 7)
    ]]
    local v210 = os.clock()
    if not (u11) then
        trackCorrection(a1)
    end
    local v211
    if u15 then
        v211 = stepRelay
    else
        v211 = stepChar
    end
    for _, value_29 in tbl_upv_5 do
        if value_29.failed then
            continue
        end
        local success_3, v212 = pcall(v211, value_29, a1)
        if not (success_3) then
            value_29.failed = true
            warn((("[Simulation] step failed for %*: %*"):format(value_29.character.Name, v212)))
        end
    end
    local v213 = os.clock() - v210
    tbl_upv_10.steps = tbl_upv_10.steps + 1
    tbl_upv_10.time = tbl_upv_10.time + v213
    if not (tbl_upv_10.maxStep < v213) then
        return
    end
    tbl_upv_10.maxStep = v213
end
function tbl_upv_1.Initialize()
    --[[
      name: Initialize
      line: 2173
      upvalues:
        u46 (ref,  index: 1)
        u11 (copy, index: 2)
        Players_upv_1 (copy, index: 3)
        onPlayer (copy, index: 4)
        tbl_upv_4 (copy, index: 5)
        tbl_upv_5 (copy, index: 6)
        RunService_upv_1 (copy, index: 7)
        tbl_upv_3 (copy, index: 8)
        tbl_upv_1 (copy, index: 9)
        Inputs_upv_1 (copy, index: 10)
        tbl_upv_16 (copy, index: 11)
        fire (copy, index: 12)
        startPredictionPolicy (copy, index: 13)
        watchHold (copy, index: 14)
        u13 (copy, index: 15)
        startArrivalGuard (copy, index: 16)
        WriteGuard_upv_1 (copy, index: 17)
        step (copy, index: 18)
    ]]
    if u46 then
        return
    end
    u46 = true
    if u11 then
        for _, value_30 in Players_upv_1:GetPlayers() do
            onPlayer(value_30)
        end
        Players_upv_1.PlayerAdded:Connect(onPlayer)
        Players_upv_1.PlayerRemoving:Connect(
            function(a1)
                --[[
                  line: 2183
                  upvalues:
                    tbl_upv_4 (copy, index: 1)
                    tbl_upv_5 (copy, index: 2)
                ]]
                if not a1.Character then
                    return
                end
                local Character_5 = a1.Character
                local v214 = tbl_upv_4[Character_5]
                if not v214 then
                    return
                end
                tbl_upv_4[Character_5] = nil
                for _, value_31 in v214.conns do
                    value_31:Disconnect()
                end
                table.clear(tbl_upv_5)
                for _, value_32 in tbl_upv_4 do
                    table.insert(tbl_upv_5, value_32)
                end
            end
        )
        if RunService_upv_1:IsStudio() then
            local v215 = Instance.new("BindableFunction")
            v215.Name = "SimulationDebug"
            v215.OnInvoke = function(a2, a3, a4)
                --[[
                  line: 2192
                  upvalues:
                    tbl_upv_4 (copy, index: 1)
                    tbl_upv_3 (copy, index: 2)
                    tbl_upv_1 (copy, index: 3)
                    tbl_upv_5 (copy, index: 4)
                ]]
                local v216 = a3 and (a3.Character and (tbl_upv_4[a3.Character]))
                if a2 == "state" and v216 then
                    local tbl_25 = {}
                    for _, value_33 in tbl_upv_3 do
                        tbl_25[value_33] = a3.root:GetAttribute(value_33)
                    end
                    tbl_25.walkSpeed = a3.humanoid.WalkSpeed
                    tbl_25.jumpHeight = a3.humanoid.JumpHeight
                    return tbl_25
                end
                if a2 == "knockback" and a3 then
                    return tbl_upv_1.Knockback(a3.character, a4)
                end
                if a2 == "teleport" and a3 then
                    return tbl_upv_1.Teleport(a3.character, a4)
                elseif a2 ~= "count" then
                    if a2 ~= "perf" then
                        return nil
                    end
                    return tbl_upv_1.DebugStats()
                else
                    return #tbl_upv_5
                end
            end
            v215.Parent = game:GetService("ServerStorage")
        end
    else
        local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
        task.spawn(
            function()
                --[[
                  line: 2217
                  upvalues:
                    LocalPlayer_upv_1 (copy, index: 1)
                    Inputs_upv_1 (copy, index: 2)
                    tbl_upv_16 (copy, index: 3)
                    fire (copy, index: 4)
                ]]
                local v217 = LocalPlayer_upv_1:WaitForChild(Inputs_upv_1.CONTEXT, 60)
                if v217 then
                    for _, value_34 in Inputs_upv_1.ACTIONS do
                        local v218 = v217:WaitForChild(value_34.name, 10)
                        local v219 = v218 and (v218:WaitForChild("Script", 10))
                        if not (v219) then
                            continue
                        end
                        if v219:IsA("InputBinding") then
                            tbl_upv_16[value_34.name] = v219
                            fire(value_34.name)
                        end
                    end
                else
                    warn("[Simulation] TribesInputs never arrived")
                end
            end
        )
        onPlayer(LocalPlayer_upv_1)
        startPredictionPolicy(LocalPlayer_upv_1)
        watchHold(LocalPlayer_upv_1)
        if u13 then
            startArrivalGuard(LocalPlayer_upv_1)
        end
        if RunService_upv_1:IsStudio() and not (u13) then
            WriteGuard_upv_1.Start(LocalPlayer_upv_1)
        end
    end
    if RunService_upv_1:IsStudio() and workspace:GetAttribute("SimDisabled") == true then
        warn("[Simulation] disabled by the Studio test knob workspace.SimDisabled (engine-only baseline)")
    else
        tbl_upv_1.BindStep(step, 2100)
    end
end
return tbl_upv_1