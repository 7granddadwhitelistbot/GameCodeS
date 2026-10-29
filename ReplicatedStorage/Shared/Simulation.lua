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
local u1 = RunService_upv_1:IsStudio() and (Workspace_upv_1:GetAttribute("MoveClassic") == true)
local u2
if u1 then
    u2 = 1
else
    u2 = 0.82
end
local u3 = (u1 and 1) or 0.6
local u4 = (u1 and 1.3) or 1.1
tbl_upv_1.FALL_GRAVITY_MULT = u4
local u5 = 39
local u6 = 48
local u7 = 15
local u8 = 13
local u9 = 11
local u10 = 45
local tbl_upv_2 = {"HumanoidRootPart", "Head", "UpperTorso", "LowerTorso"}
local u11 = 8
local u12 = 9
local u13 = 7
local u14 = 18
tbl_upv_1.SLIDE_TIME = 0.65
tbl_upv_1.SLIDE_START = 36
local tbl_upv_3 = {"SSpeed", "SSlide", "SSlideDir", "SSlideCD", "SSlideBuf", "SSlideIn", "SSlope", "SLift", "SJumpIn", "SJumpBuf", "SAir", "SJumped", "SJumping", "SGround", "SBoost", "SKb", "SKbF", "SKbN", "SDashV", "SDashF", "SDashCD", "SDashB", "SCharge", "SChargeRel", "SLungeIn", "SHipBase", "SHip", "SFrozen", "SSlow", "SNoJump", "SVel", "SFloat", "STp", "SWade", "SWet"}
local u15 = RunService_upv_1:IsServer()
local u17 = (function()
    --[[
      name: detectClientAuthority
      line: 261
      upvalues:
        u15 (copy, index: 1)
        Workspace_upv_1 (copy, index: 2)
    ]]
    if u15 then
        local u16 = Instance.new("Part")
        u16.Name = "TribesAuthorityProbe"
        u16.Size = Vector3.new(1, 1, 1)
        u16.Transparency = 1
        u16.CanCollide = false
        u16.CanQuery = false
        u16.CanTouch = false
        u16.CFrame = CFrame.new(0, 4000, 0)
        u16.Parent = Workspace_upv_1
        local success_1 = pcall(
            function()
                --[[
                  line: 270
                  upvalues:
                    u16 (copy, index: 1)
                ]]
                u16:SetNetworkOwner(nil)
            end
        )
        u16:Destroy()
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
local v3 = u15
local u18
if v3 then
    u18 = not u17
else
    u18 = v3
end
local u19 = u15 and u17
local u20 = not u15 and u17
tbl_upv_1.JUMP_POWER_MARK = 0
local u21 = nil
function tbl_upv_1.OnForeignWrite(a1)
    --[[
      name: OnForeignWrite
      line: 298
      upvalues:
        u21 (ref, index: 1)
    ]]
    u21 = a1
end
tbl_upv_1.ClientAuthority = u17
tbl_upv_1.Authority = (u17 and "Client") or "Server"
local u22 = RunService_upv_1:IsStudio() and (Workspace_upv_1:GetAttribute("WaterSimOff") == true)
local u23 = RunService_upv_1:IsStudio() and (Workspace_upv_1:GetAttribute("SimAuditOff") == true)
local tbl_upv_4 = {}
local tbl_upv_5 = {}
local function rebuildList()
    --[[
      name: rebuildList
      line: 313
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
      line: 320
    ]]
    return math.floor((a1 / a2) + 0.5) * a2
end
local function flat(a1)
    --[[
      name: flat
      line: 324
    ]]
    return (Vector3.new(a1.X, 0, a1.Z))
end
local function approach(a1, a2, a3)
    --[[
      name: approach
      line: 329
    ]]
    local v4 = a2 - a1
    local Magnitude_1 = v4.Magnitude
    if Magnitude_1 <= a3 then
        return a2
    end
    return a1 + (v4 * (a3 / Magnitude_1))
end
local tbl_upv_6 = {STp = true, SNoJump = true, SFrozen = true, SSlow = true}
local function save(a1)
    --[[
      name: save
      line: 377
      upvalues:
        u17 (copy, index: 1)
        tbl_upv_3 (copy, index: 2)
        tbl_upv_6 (copy, index: 3)
    ]]
    local s_1 = a1.s
    local prev_1 = a1.prev
    local root_1 = a1.root
    if u17 then
        for _, value_2 in tbl_upv_3 do
            if tbl_upv_6[value_2] then
                continue
            end
            local v5 = s_1[value_2]
            if root_1:GetAttribute(value_2) ~= v5 then
                root_1:SetAttribute(value_2, v5)
            end
        end
    else
        for _, value_3 in tbl_upv_3 do
            local v6 = s_1[value_3]
            if v6 ~= prev_1[value_3] then
                root_1:SetAttribute(value_3, v6)
            end
        end
    end
end
local tbl_upv_7 = {}
local tbl_upv_8 = {Facing = true, Look = true}
local function actionState(a1, a2)
    --[[
      name: actionState
      line: 408
      upvalues:
        u17 (copy, index: 1)
        u15 (copy, index: 2)
        tbl_upv_8 (copy, index: 3)
        tbl_upv_7 (copy, index: 4)
    ]]
    if u17 and not (u15) and tbl_upv_8[a2] then
        return tbl_upv_7[a2]
    end
    local v7 = a1.actions[a2]
    if v7 then
        return v7:GetState()
    end
    return nil
end
local function held(a1, a2)
    --[[
      name: held
      line: 419
      upvalues:
        u17 (copy, index: 1)
        u15 (copy, index: 2)
        tbl_upv_8 (copy, index: 3)
        tbl_upv_7 (copy, index: 4)
    ]]
    local v8
    if u17 and not u15 and tbl_upv_8[a2] then
        v8 = tbl_upv_7[a2]
    else
        local v9 = a1.actions[a2]
        if v9 then
            v8 = v9:GetState()
        else
            v8 = nil
        end
    end
    local v10
    if v8 == true then
        v10 = true
    else
        v10 = false
    end
    return v10
end
local function finite2(a1)
    --[[
      name: finite2
      line: 423
    ]]
    local v11 = (typeof(a1) == "Vector2") and ((a1.X == a1.X) and ((a1.Y == a1.Y) and ((math.abs(a1.X) < 1e+06) and (math.abs(a1.Y) < 1e+06))))
    return v11
end
local function toolInSlot(a1, a2)
    --[[
      name: toolInSlot
      line: 459
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
local u24 = 45
local function hipTarget(a1, a2)
    --[[
      name: hipTarget
      line: 512
    ]]
    local SHipBase_1 = a1.SHipBase
    if type(SHipBase_1) == "number" then
        local v12, v13 = nil, nil
        if a1.SSlide == nil then
            v12 = SHipBase_1
        else
            v12 = math.max(0.3, SHipBase_1 - 1.4)
            v13 = a1.SLift
            if type(v13) == "number" and v12 < v13 then
                v12 = v13
            end
        end
        if a2 and v12 < a2 then
            v12 = a2
        end
        return v12
    end
    return nil
end
local u25 = RaycastParams.new()
u25.FilterType = Enum.RaycastFilterType.Include
u25.FilterDescendantsInstances = {Workspace_upv_1.Terrain}
u25.IgnoreWater = false
local function probeBank(a1, a2, a3, a4)
    --[[
      name: probeBank
      line: 574
      upvalues:
        Workspace_upv_1 (copy, index: 1)
    ]]
    local v14 = a1.root.Position + a2 * 2
    local v15 = a4 + (a3 * 2) + 2.5
    local v16 = Workspace_upv_1:Raycast(Vector3.new(v14.X, v15, v14.Z), Vector3.new(0, -((v15 - a4) + 1), 0), a1.ray)
    if not v16 then
        return nil
    end
    v14 = v16.Position.Y - a4
    local v17 = a3 + 0.5
    local v18 = math.min(v14, v17) * math.clamp((v17 + 1) - v14, 0, 1)
    if v18 <= 0.01 then
        return nil
    end
    return math.floor(((a3 + v18) / 0.001) + 0.5) * 0.001
end
local function endSlide(a1)
    --[[
      name: endSlide
      line: 591
      upvalues:
        u6 (copy, index: 1)
    ]]
    if a1.SSlide == nil then
        return
    end
    a1.SSlide = nil
    a1.SSlideDir = nil
    a1.SSlope = nil
    a1.SLift = nil
    a1.SSlideCD = u6
    a1.SSpeed = math.max(a1.SSpeed, 17)
end
local function probeGround(a1, a2, a3, a4, a5, a6)
    --[[
      name: probeGround
      line: 628
      upvalues:
        Workspace_upv_1 (copy, index: 1)
    ]]
    local root_2 = a1.root
    local Position_1 = root_2.Position
    local v19 = Workspace_upv_1:Raycast(Position_1, Vector3.new(0, -((a5 + (root_2.Size.Y * 0.5)) + 1.5), 0), a1.ray)
    if not v19 then
        return nil, nil
    end
    local Normal_1 = v19.Normal
    local v20 = ((Normal_1.Y >= 0.5) and (math.clamp(a3 * (((Normal_1.X * a2.X) + (Normal_1.Z * a2.Z)) / Normal_1.Y), -12, 12) * 0.6)) or nil
    local Y_1 = v19.Position.Y
    local v21 = Workspace_upv_1:Raycast(Vector3.new(Position_1.X, Y_1 + 0.25, Position_1.Z), a2 * (((a4 * 0.16) + (((a1.hull) and (a1.hull.Size.Y * 0.5)) or (root_2.Size.Z * 0.5))) + 0.1), a1.ray)
    if v21 and not (v21.Normal.Y > 0.3) then
        local v22 = v21.Position + a2 * 0.3
        local v23 = Workspace_upv_1:Raycast(Vector3.new(v22.X, (Y_1 + a6) + 0.3, v22.Z), Vector3.new(0, -((a6 + 0.3) - 0.25), 0), a1.ray)
        if v23 and not (v23.Normal.Y < 0.7) then
            v22 = v23.Position.Y - Y_1
            if not (v22 < 0.25) and not (a6 < v22) then
                return v20, v22 + 0.35
            end
            return v20, nil
        end
        return v20, nil
    end
    return v20, nil
end
local function resetMotion(a1)
    --[[
      name: resetMotion
      line: 687
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
    a1.SVel = nil
    a1.SFloat = nil
    a1.SSpeed = BASE_SPEED_upv_1
end
local function fin(a1)
    --[[
      name: fin
      line: 704
    ]]
    return (a1 == a1) and ((a1 > -1e+07) and (a1 < 1e+07))
end
local function fin3(a1)
    --[[
      name: fin3
      line: 707
    ]]
    local X_1 = a1.X
    local v24 = (X_1 == X_1) and ((X_1 > -1e+07) and (X_1 < 1e+07))
    if v24 then
        local Y_2 = a1.Y
        v24 = (Y_2 == Y_2) and ((Y_2 > -1e+07) and (Y_2 < 1e+07))
        if v24 then
            local _ = a1.Z
            v24 = a1.Z == a1.Z and a1.Z > -1e+07 and a1.Z < 1e+07
        end
    end
    return v24
end
local tbl_upv_9 = {}
local function sayNaN(a1)
    --[[
      name: sayNaN
      line: 719
      upvalues:
        tbl_upv_9 (copy, index: 1)
        u17 (copy, index: 2)
        u15 (copy, index: 3)
    ]]
    if tbl_upv_9[a1] then
        return
    end
    tbl_upv_9[a1] = true
    warn((("[SimNaN] %* auth=%* side=%*"):format(a1, (u17 and "Client") or "Server", (u15 and "server") or "client")))
end
local function recoverRoot(a1)
    --[[
      name: recoverRoot
      line: 726
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
    s_2.SVel = nil
    s_2.SFloat = nil
    s_2.SSpeed = BASE_SPEED_upv_1
end
local function startKnockback(a1, a2, a3)
    --[[
      name: startKnockback
      line: 786
      upvalues:
        tbl_upv_9 (copy, index: 1)
        u17 (copy, index: 2)
        u15 (copy, index: 3)
        u6 (copy, index: 4)
    ]]
    local humanoid_1 = a1.humanoid
    local root_4 = a1.root
    local s_3 = a1.s
    local X_2 = a2.X
    local v25 = (X_2 == X_2) and ((X_2 > -1e+07) and (X_2 < 1e+07))
    if v25 then
        local Y_3 = a2.Y
        v25 = (Y_3 == Y_3) and ((Y_3 > -1e+07) and (Y_3 < 1e+07))
        if v25 then
            local _ = a2.Z
            v25 = a2.Z == a2.Z and a2.Z > -1e+07 and a2.Z < 1e+07
        end
    end
    if v25 then
        if a3 ~= nil and (a3 ~= a3 or not (a3 > -1e+07) or not (a3 < 1e+07)) then
            a3 = nil
        end
        v25 = Vector3.new(a2.X, 0, a2.Z)
        local v26 = ((v25.Magnitude > 90) and (v25.Unit * 90)) or v25
        if v26.Magnitude >= 1 then
            if s_3.SSlide ~= nil then
                s_3.SSlide = nil
                s_3.SSlideDir = nil
                s_3.SSlope = nil
                s_3.SLift = nil
                s_3.SSlideCD = u6
                s_3.SSpeed = math.max(s_3.SSpeed, 17)
            end
            local v27 = math.max(1, math.floor((math.clamp(a3 or 0.35, 0.05, 1) * 60) + 0.5))
            s_3.SKb = v26
            s_3.SKbF = v27
            s_3.SKbN = v27
            s_3.SDashV = nil
            s_3.SDashF = nil
        end
        if a2.Y > 8 then
            v25 = root_4.AssemblyLinearVelocity
            root_4.AssemblyLinearVelocity = Vector3.new(v25.X, math.max(v25.Y, math.min(a2.Y, 40) * 0.8), v25.Z)
            humanoid_1:ChangeState(Enum.HumanoidStateType.Freefall)
        end
    elseif not tbl_upv_9.knockback then
        tbl_upv_9.knockback = true
        warn((("[SimNaN] knockback auth=%* side=%*"):format((u17 and "Client") or "Server", (u15 and "server") or "client")))
    end
end
local function stepCollisions(a1, a2)
    --[[
      name: stepCollisions
      line: 751
      upvalues:
        u23 (copy, index: 1)
    ]]
    local hull_1 = a1.hull
    if not hull_1 or u23 then
        return
    end
    if a2 then
        local body_1 = a1.body
        for n_1 = 1, #body_1 do
            local v28 = body_1[n_1]
            if v28.CanCollide then
                v28.CanCollide = false
            end
        end
        if hull_1.CanCollide then
            return
        end
        hull_1.CanCollide = true
    else
        local corpse_1 = a1.corpse
        for n_2 = 1, #corpse_1 do
            local v29 = corpse_1[n_2]
            if not (v29.CanCollide) then
                v29.CanCollide = true
            end
        end
        if hull_1.CanCollide then
            hull_1.CanCollide = false
        end
    end
end
local function jumpProp(a1, a2)
    --[[
      name: jumpProp
      line: 340
      upvalues:
        u3 (copy, index: 1)
        u2 (copy, index: 2)
        u17 (copy, index: 3)
        u1 (copy, index: 4)
    ]]
    local v30 = 100 / ((u3 * 2) * a2)
    local v31
    if a1 <= v30 then
        v31 = math.sqrt(((u3 * 2) * a2) * a1)
    else
        v31 = math.sqrt((((u2 * 2) * a2) * (a1 - v30)) + 100)
    end
    if u17 then
        v31 = (u1) or v31 + ((1 - u2) * a2) * 0.016666666666666666
    end
    return (v31 * v31) / (a2 * 2)
end
local function lookMove(a1)
    --[[
      name: lookMove
      line: 430
      upvalues:
        u17 (copy, index: 1)
        u15 (copy, index: 2)
        tbl_upv_8 (copy, index: 3)
        tbl_upv_7 (copy, index: 4)
    ]]
    if not a1.move then
        return nil
    end
    local v32
    if u17 and not u15 and tbl_upv_8.Look then
        v32 = tbl_upv_7.Look
    else
        local Look_1 = a1.actions.Look
        if Look_1 then
            v32 = Look_1:GetState()
        else
            v32 = nil
        end
    end
    local v33 = false
    if typeof(v32) == "Vector2" then
        v33 = (v32.X == v32.X) and ((v32.Y == v32.Y) and ((math.abs(v32.X) < 1e+06) and (math.abs(v32.Y) < 1e+06)))
    end
    if v33 and not (v32.Magnitude < 0.5) and not (v32.Magnitude > 1.5) then
        if a1.move then
            v33 = a1.move:GetState()
        else
            v33 = nil
        end
        local Unit_1 = false
        if typeof(v33) == "Vector2" then
            Unit_1 = (v33.X == v33.X) and ((v33.Y == v33.Y) and ((math.abs(v33.X) < 1e+06) and (math.abs(v33.Y) < 1e+06)))
        end
        if not Unit_1 then
            return Vector3.new(0, 0, 0)
        end
        Unit_1 = v32.Unit
        v32 = Vector3.new((Unit_1.X * v33.Y) - (Unit_1.Y * v33.X), 0, (Unit_1.Y * v33.Y) + (Unit_1.X * v33.X))
        if v32.Magnitude > 1 then
            v32 = v32.Unit
        end
        return v32
    end
    return nil
end
local function probeWater(a1, a2)
    --[[
      name: probeWater
      line: 542
      upvalues:
        u22 (copy, index: 1)
        Workspace_upv_1 (copy, index: 2)
        u25 (copy, index: 3)
    ]]
    if u22 then
        return 0, nil, nil, nil
    end
    local root_5 = a1.root
    local Position_2 = root_5.Position
    local v34 = root_5.Size.Y * 0.5
    local v35 = Workspace_upv_1:Raycast(Vector3.new(Position_2.X, Position_2.Y + 16, Position_2.Z), Vector3.new(0, -(((a2 + 16) + v34) + 0.5), 0), u25)
    if v35 and v35.Material == Enum.Material.Water then
        local Y_4 = v35.Position.Y
        local v36 = Workspace_upv_1:Raycast(Position_2, Vector3.new(0, -40, 0), a1.ray)
        if not v36 then
            return 1, nil, nil, nil
        end
        local Y_5 = v36.Position.Y
        local v37 = (Y_4 - 0.6) - Y_5 - v34
        local v38 = math.floor((math.clamp(((Y_4 - Y_5) - 0.4) / (((a2 + v34) + 0.6) - 0.4), 0, 1) / 0.01) + 0.5) * 0.01
        local v39 = ((a2 < v37) and (math.floor((v37 / 0.001) + 0.5) * 0.001)) or nil
        return v38, v39, Y_5, Y_4 - 0.6
    end
    return 0, nil, nil, nil
end
local function slideCushion(a1, a2, a3, a4)
    --[[
      name: slideCushion
      line: 668
      upvalues:
        Workspace_upv_1 (copy, index: 1)
    ]]
    if a2 >= -12 then
        return nil
    end
    local root_6 = a1.root
    local Position_3 = root_6.Position
    local v40 = a3 + root_6.Size.Y * 0.5
    local v41 = Workspace_upv_1:Raycast(Position_3, Vector3.new(0, -(v40 + (a4 or 2.5)), 0), a1.ray)
    if v41 and not (v41.Normal.Y < 0.5) then
        v40 = ((a2 * a2) - 144) / (math.max(((Position_3.Y - v41.Position.Y) - v40) - 0.5, 0.05) * 2)
        if v40 < 350 then
            return nil
        end
        return (math.min(v40, 900))
    end
    return nil
end
local function load(a1)
    --[[
      name: load
      line: 359
      upvalues:
        u17 (copy, index: 1)
        tbl_upv_6 (copy, index: 2)
        tbl_upv_3 (copy, index: 3)
    ]]
    local s_4 = a1.s
    local prev_2 = a1.prev
    local root_7 = a1.root
    if u17 then
        for key_1 in tbl_upv_6 do
            s_4[key_1] = root_7:GetAttribute(key_1)
        end
    else
        for _, value_6 in tbl_upv_3 do
            local v42 = root_7:GetAttribute(value_6)
            s_4[value_6] = v42
            prev_2[value_6] = v42
        end
    end
end
local function tryStartSlide(a1, a2, a3, a4, a5)
    --[[
      name: tryStartSlide
      line: 603
    ]]
    if a1.SSlide == nil and a1.SSlideCD == nil and a5 then
        if not (Vector3.new(a4.X, 0, a4.Z).Magnitude < 11) and not (a3.Magnitude < 0.2) then
            local Unit_2 = Vector3.new(a3.X, 0, a3.Z).Unit
            a1.SSlide = 0
            a1.SSlideDir = Vector3.new(math.floor((Unit_2.X / 1e-04) + 0.5) * 1e-04, 0, math.floor((Unit_2.Z / 1e-04) + 0.5) * 1e-04)
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
local function heldWeapon(a1)
    --[[
      name: heldWeapon
      line: 489
      upvalues:
        u17 (copy, index: 1)
        u15 (copy, index: 2)
        tbl_upv_8 (copy, index: 3)
        tbl_upv_7 (copy, index: 4)
        Inputs_upv_1 (copy, index: 5)
        toolInSlot (copy, index: 6)
        u18 (copy, index: 7)
        u24 (copy, index: 8)
    ]]
    local v43 = a1.character:FindFirstChildWhichIsA("Tool")
    local v44, v45 = nil, nil
    if a1.actions.Hold then
        if u17 and not u15 and tbl_upv_8.Hold then
            v45 = tbl_upv_7.Hold
        else
            v44 = a1.actions.Hold
            if v44 then
                v45 = v44:GetState()
            else
                v45 = nil
            end
        end
    else
        v45 = nil
    end
    local v46
    if type(v45) == "number" and v45 == v45 then
        local v47 = toolInSlot(a1, math.clamp(math.floor((v45 * Inputs_upv_1.HOLD_SCALE) + 0.5), 0, Inputs_upv_1.HOLD_SLOTS))
        if u18 then
            if v47 == v43 then
                a1.holdBad = 0
                v46 = v47
            else
                a1.holdBad = a1.holdBad + 1
                if u24 < a1.holdBad then
                    v46 = v43
                else
                    v46 = v47
                end
            end
        else
            v46 = v47
        end
    else
        v46 = v43
    end
    local v48
    if v46 then
        v48 = v46:GetAttribute("WeaponId")
    else
        v48 = nil
    end
    if type(v48) ~= "string" then
        return nil
    end
    return v48
end
local function finCF(a1)
    --[[
      name: finCF
      line: 713
    ]]
    local Position_4 = a1.Position
    local v49 = false
    local _
    if Position_4.X == Position_4.X then
        _ = false
        if Position_4.Y == Position_4.Y then
            _ = false
            if Position_4.Z == Position_4.Z then
                _ = false
                if math.abs(Position_4.X) < 2e+05 then
                    _ = false
                    if math.abs(Position_4.Y) < 2e+05 then
                        _ = false
                        if math.abs(Position_4.Z) < 2e+05 then
                            local LookVector_1 = a1.LookVector
                            local v50 = a1.LookVector.X
                            v49 = a1.LookVector.X == a1.LookVector.X and a1.LookVector.X > -1e+07 and a1.LookVector.X < 1e+07
                            if v49 then
                                local Y_6 = LookVector_1.Y
                                v49 = (Y_6 == Y_6) and ((Y_6 > -1e+07) and (Y_6 < 1e+07))
                                if v49 then
                                    local v51 = LookVector_1.Z
                                    v49 = LookVector_1.Z == LookVector_1.Z and LookVector_1.Z > -1e+07 and LookVector_1.Z < 1e+07
                                end
                            end
                            v49 = v49 and a1.UpVector.X == a1.UpVector.X and a1.UpVector.X > -1e+07 and a1.UpVector.X < 1e+07 and a1.UpVector.Y == a1.UpVector.Y and a1.UpVector.Y > -1e+07 and a1.UpVector.Y < 1e+07 and a1.UpVector.Z == a1.UpVector.Z and a1.UpVector.Z > -1e+07 and a1.UpVector.Z < 1e+07
                        end
                    end
                end
            end
        end
    end
    return v49
end
local function stepChar(a1, a2)
    --[[
      name: stepChar
      line: 855
      upvalues:
        load (copy, index: 1)
        finCF (copy, index: 2)
        tbl_upv_9 (copy, index: 3)
        u17 (copy, index: 4)
        u15 (copy, index: 5)
        BASE_SPEED_upv_1 (copy, index: 6)
        save (copy, index: 7)
        stepCollisions (copy, index: 8)
        u18 (copy, index: 9)
        startKnockback (copy, index: 10)
        u20 (copy, index: 11)
        u21 (ref,  index: 12)
        tbl_upv_1 (copy, index: 13)
        u22 (copy, index: 14)
        tbl_upv_8 (copy, index: 15)
        tbl_upv_7 (copy, index: 16)
        u23 (copy, index: 17)
        lookMove (copy, index: 18)
        heldWeapon (copy, index: 19)
        Combat_upv_1 (copy, index: 20)
        probeWater (copy, index: 21)
        probeBank (copy, index: 22)
        u10 (copy, index: 23)
        u12 (copy, index: 24)
        u13 (copy, index: 25)
        u14 (copy, index: 26)
        u6 (copy, index: 27)
        u8 (copy, index: 28)
        tryStartSlide (copy, index: 29)
        u7 (copy, index: 30)
        u5 (copy, index: 31)
        probeGround (copy, index: 32)
        u9 (copy, index: 33)
        u1 (copy, index: 34)
        jumpProp (copy, index: 35)
        JUMP_HEIGHT_upv_1 (copy, index: 36)
        Workspace_upv_1 (copy, index: 37)
        u11 (copy, index: 38)
        u2 (copy, index: 39)
        u3 (copy, index: 40)
        u4 (copy, index: 41)
        slideCushion (copy, index: 42)
    ]]
    local humanoid_2 = a1.humanoid
    local root_8 = a1.root
    local s_5 = a1.s
    load(a1)
    local CFrame_1 = root_8.CFrame
    local v50, v51, v52 = nil, nil, nil
    if finCF(CFrame_1) then
        a1.goodCF = CFrame_1
        local v53 = humanoid_2:GetState()
        v50 = v53 ~= Enum.HumanoidStateType.Dead
        stepCollisions(a1, v50)
        local v54 = nil
        if u18 then
            s_5.SFrozen = ((a1.frozen) and true) or nil
            s_5.SSlow = a1.slow ~= 1 and math.floor((a1.slow / 0.001) + 0.5) * 0.001 or nil
            s_5.SNoJump = ((a1.noJump) and true) or nil
            v54 = a1.pending
            if v54.tp then
                local tp_1 = v54.tp
                v54.tp = nil
                a1.character:PivotTo(tp_1)
                root_8.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
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
                s_5.SVel = nil
                s_5.SFloat = nil
                s_5.SSpeed = BASE_SPEED_upv_1
                local v56 = ((type(s_5.STp) ~= "number") and 0) or (s_5.STp)
                s_5.STp = v56 + 1
            end
            if v54.kb and v50 then
                startKnockback(a1, v54.kb, v54.kbDur)
            end
            v54.kb = nil
            v54.kbDur = nil
        else
            local v57, v58 = nil, nil
            if u17 then
                v57 = s_5.STp
                if v57 ~= a1.tpSeen then
                    a1.tpSeen = v57
                    v51 = root_8:GetAttribute("STpCF")
                    if typeof(v51) == "CFrame" and finCF(v51) and (root_8.Position - v51.Position).Magnitude > 30 then
                        a1.character:PivotTo(v51)
                    end
                    root_8.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
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
                    s_5.SVel = nil
                    s_5.SFloat = nil
                    s_5.SSpeed = BASE_SPEED_upv_1
                end
                v58 = root_8:GetAttribute("NKbSeq")
                if v58 ~= a1.kbSeen then
                    a1.kbSeen = v58
                    v51 = root_8:GetAttribute("NKb")
                    if v50 and typeof(v51) == "Vector3" then
                        local v59 = nil
                        if v51 == v51 then
                            v59 = root_8:GetAttribute("NKbDur")
                            local v60
                            if type(v59) ~= "number" then
                                v60 = nil
                            else
                                v60 = v59
                            end
                            startKnockback(a1, v51, v60)
                        end
                    end
                end
            end
        end
        local v61 = u20 and (a1.watchFrom <= os.clock())
        if v61 and u21 and (humanoid_2.UseJumpPower or humanoid_2.JumpPower ~= tbl_upv_1.JUMP_POWER_MARK) then
            u21(((humanoid_2.UseJumpPower) and "UseJumpPower") or "JumpPower")
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
        if humanoid_2:GetStateEnabled(Enum.HumanoidStateType.Swimming) ~= u22 then
            humanoid_2:SetStateEnabled(Enum.HumanoidStateType.Swimming, u22)
        end
        local v62, v63, v64, v65, v66, v67, v68, v69, v70, v71, v72, v73, v74, v75, v76, v77 = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
        if v50 then
            v50 = s_5.SFrozen == true
            v51 = ((type(s_5.SSlow) ~= "number") and 1) or (s_5.SSlow)
            local v78 = true
            if s_5.SNoJump ~= true then
                v78 = v51 <= 0.001
            end
            local v79
            if type(s_5.SSpeed) ~= "number" then
                v79 = BASE_SPEED_upv_1
            else
                v79 = s_5.SSpeed
            end
            local v80
            if u17 and not u15 and tbl_upv_8.Slide then
                v80 = tbl_upv_7.Slide
            else
                v62 = a1.actions.Slide
                if v62 then
                    v80 = v62:GetState()
                else
                    v80 = nil
                end
            end
            local v81
            if v80 == true then
                v81 = true
            else
                v81 = false
            end
            local v82
            if u17 and not u15 and tbl_upv_8.Jump then
                v82 = tbl_upv_7.Jump
            else
                v63 = a1.actions.Jump
                if v63 then
                    v82 = v63:GetState()
                else
                    v82 = nil
                end
            end
            if v82 == true then
                v80 = true
            else
                v80 = false
            end
            local v83
            if u17 and not u15 and tbl_upv_8.Aim then
                v83 = tbl_upv_7.Aim
            else
                v64 = a1.actions.Aim
                if v64 then
                    v83 = v64:GetState()
                else
                    v83 = nil
                end
            end
            if v83 == true then
                v82 = true
            else
                v82 = false
            end
            if u17 and not u15 and tbl_upv_8.Charge then
                v83 = tbl_upv_7.Charge
            else
                v65 = a1.actions.Charge
                if v65 then
                    v83 = v65:GetState()
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
            if u17 and not u15 and tbl_upv_8.Block then
                v83 = tbl_upv_7.Block
            else
                v66 = a1.actions.Block
                if v66 then
                    v83 = v66:GetState()
                else
                    v83 = nil
                end
            end
            local v85
            if v83 == true then
                v85 = true
            else
                v85 = false
            end
            if u17 and not u15 and tbl_upv_8.Reload then
                v83 = tbl_upv_7.Reload
            else
                v67 = a1.actions.Reload
                if v67 then
                    v83 = v67:GetState()
                else
                    v83 = nil
                end
            end
            local v86
            if v83 == true then
                v86 = true
            else
                v86 = false
            end
            if u17 and not u15 and tbl_upv_8.Use then
                v83 = tbl_upv_7.Use
            else
                v68 = a1.actions.Use
                if v68 then
                    v83 = v68:GetState()
                else
                    v83 = nil
                end
            end
            local v87
            if v83 == true then
                v87 = true
            else
                v87 = false
            end
            local v88
            if u17 and not u15 and tbl_upv_8.Lunge then
                v88 = tbl_upv_7.Lunge
            else
                v69 = a1.actions.Lunge
                if v69 then
                    v88 = v69:GetState()
                else
                    v88 = nil
                end
            end
            if v88 == true then
                v83 = true
            else
                v83 = false
            end
            local v89 = nil
            local v90
            if u17 and not u15 and tbl_upv_8.Facing then
                v90 = tbl_upv_7.Facing
            else
                v70 = a1.actions.Facing
                if v70 then
                    v90 = v70:GetState()
                else
                    v90 = nil
                end
            end
            if typeof(v90) == "Vector2" and v90.X == v90.X and v90.Y == v90.Y and v90.Magnitude > 0.5 and v90.Magnitude < 1.5 then
                v88 = v90.Unit
            else
                v88 = v89
            end
            local MoveDirection_1 = humanoid_2.MoveDirection
            local v91 = u23 or lookMove(a1)
            if v91 then
                humanoid_2:Move(v91, false)
                v90 = v91
            elseif (a1.moveWrote) and ((MoveDirection_1 - a1.moveWrote).Magnitude < 1e-04) then
                v90 = a1.moveIntent
            else
                a1.moveIntent = MoveDirection_1
                v90 = MoveDirection_1
            end
            v70 = heldWeapon(a1)
            local v92 = nil
            local v94 = nil
            if u23 then
                v92 = a1.character:FindFirstChildWhichIsA("Tool")
                if v92 then
                    v94 = v92:GetAttribute("WeaponId")
                else
                    v94 = nil
                end
                if type(v94) ~= "string" then
                    v70 = nil
                else
                    v70 = v94
                end
            end
            local v95
            v95, v94 = Combat_upv_1.MoveSpeed(v70, v82, v84, v85, v86, v87)
            if not (u23) then
                if type(s_5.SHipBase) == "number" then
                    if (u15 or u17) and a1.hipWritten and math.abs(humanoid_2.HipHeight - a1.hipWritten) > 0.002 then
                        s_5.SHipBase = math.floor((humanoid_2.HipHeight / 0.001) + 0.5) * 0.001
                        s_5.SHip = nil
                    end
                else
                    s_5.SHipBase = math.floor((humanoid_2.HipHeight / 0.001) + 0.5) * 0.001
                end
            end
            if type(s_5.SHipBase) ~= "number" then
                v87 = humanoid_2.HipHeight
            else
                v87 = s_5.SHipBase
            end
            local v96, v97
            local v98
            v71, v98, v96, v97 = probeWater(a1, v87)
            local v99
            if v71 > 0 then
                v99 = v71
            else
                v99 = nil
            end
            s_5.SWade = v99
            local v100 = v95 * v51 * (1 - (v71 * 0.4))
            v94 = ((v51 <= 0.42) and true) or ((v71 > 0.3) and true) or v94
            v95 = humanoid_2.FloorMaterial ~= Enum.Material.Air
            local AssemblyLinearVelocity_1 = root_8.AssemblyLinearVelocity
            v72 = not v95
            if v72 then
                v82 = v72
            else
                local v101 = true
                if v53 == Enum.HumanoidStateType.Jumping then
                    v82 = v101
                else
                    v82 = v53 == Enum.HumanoidStateType.Freefall
                end
            end
            if v82 then
                local v102 = true
                if v53 == Enum.HumanoidStateType.Jumping then
                    v99 = v102
                else
                    v99 = AssemblyLinearVelocity_1.Y > 0
                end
            else
                v99 = v82
            end
            if v98 and (v99 or v82 and v97 + 0.05 < root_8.Position.Y) then
                v98 = nil
            end
            if v96 then
                if v82 then
                    v99 = v98
                else
                    local v103 = nil
                    if s_5.SSlide ~= nil then
                        v99 = v98
                    else
                        v103 = Vector3.new(v90.X, 0, v90.Z)
                        local v104 = nil
                        if v103.Magnitude > 0.3 then
                            v104 = probeBank(a1, v103.Unit, v87, v96)
                            if v104 and (v98 == nil or v98 < v104) then
                                v99 = v104
                            else
                                v99 = v98
                            end
                        else
                            v99 = v98
                        end
                    end
                end
            else
                v99 = v98
            end
            if v99 then
                s_5.SWet = u10
                if type(s_5.SHipBase) ~= "number" then
                    s_5.SHipBase = math.floor((humanoid_2.HipHeight / 0.001) + 0.5) * 0.001
                end
            elseif s_5.SWet ~= nil then
                s_5.SWet = ((s_5.SWet > 1) and (s_5.SWet - 1)) or nil
            end
            v96 = v95 and (s_5.SGround ~= true)
            s_5.SGround = (v95 and true) or nil
            v87 = (v95 and 0) or (math.min((s_5.SAir or 0) + 1, 600))
            local v105
            if v87 > 0 then
                v105 = v87
            else
                v105 = nil
            end
            s_5.SAir = v105
            v105 = v53 == Enum.HumanoidStateType.Jumping
            v77 = v105 and (s_5.SJumping ~= true)
            s_5.SJumping = (v105 and true) or nil
            if v105 then
                s_5.SJumped = true
            elseif v95 then
                s_5.SJumped = nil
            end
            if type(s_5.SFloat) ~= "number" then
                if s_5.SFloat ~= nil and v95 and (AssemblyLinearVelocity_1.Y < 1 or v96) then
                    s_5.SFloat = nil
                end
            elseif AssemblyLinearVelocity_1.Y > 5 or not (v95) then
                s_5.SFloat = true
            elseif s_5.SFloat >= 4 then
                s_5.SFloat = nil
            else
                s_5.SFloat = s_5.SFloat + 1
            end
            s_5.SSlideCD = (((s_5.SSlideCD or 0) > 1) and (s_5.SSlideCD - 1)) or nil
            s_5.SSlideBuf = (((s_5.SSlideBuf or 0) > 1) and (s_5.SSlideBuf - 1)) or nil
            s_5.SDashCD = (((s_5.SDashCD or 0) > 1) and (s_5.SDashCD - 1)) or nil
            v73 = a1.dashCd
            if v73 then
                for key_2, value_7 in v73 do
                    v73[key_2] = ((value_7 > 1) and (value_7 - 1)) or nil
                end
            end
            local v106 = math.max((s_5.SJumpBuf or 0) - 1, 0)
            if v80 then
                if s_5.SJumpIn == true then
                    v105 = v106
                else
                    v105 = u12
                end
            else
                v105 = v106
            end
            if v96 and v105 > 0 then
                v105 = math.max(v105, u13)
            end
            s_5.SJumpIn = (v80 and true) or nil
            if v84 then
                s_5.SCharge = math.min((s_5.SCharge or 0) + 1, 600)
                s_5.SChargeRel = nil
            else
                local v107 = nil
                if s_5.SCharge then
                    v107 = (s_5.SChargeRel or 0) + 1
                    if u14 < v107 then
                        s_5.SCharge = nil
                        s_5.SChargeRel = nil
                    else
                        s_5.SChargeRel = v107
                    end
                end
            end
            if v77 then
                local v108 = 0
                if s_5.SSlide == nil then
                    v105 = v108
                else
                    if s_5.SSlide ~= nil then
                        s_5.SSlide = nil
                        s_5.SSlideDir = nil
                        s_5.SSlope = nil
                        s_5.SLift = nil
                        s_5.SSlideCD = u6
                        s_5.SSpeed = math.max(s_5.SSpeed, 17)
                    end
                    local v109 = math.max(s_5.SSpeed, 27)
                    s_5.SBoost = u8
                    v79, v105 = v109, v108
                end
            end
            s_5.SSpeed = v79
            v77 = s_5.SDashF or 0
            if v83 then
                local v110 = nil
                if s_5.SLungeIn ~= true then
                    v110 = Combat_upv_1.Tuning(v70).lunge
                    if type(v110) == "table" and s_5.SDashCD == nil and (not (a1.dashCd) or not (a1.dashCd[v70])) and not v50 and v51 > 0.001 and (v110.charge or 0.6) * 0.65 <= (s_5.SCharge or 0) * 0.016666666666666666 then
                        if v88 then
                            v84 = Vector3.new(v88.X, 0, v88.Y)
                        else
                            local v154 = root_8.CFrame.LookVector
                            v84 = Vector3.new(root_8.CFrame.LookVector.X, 0, root_8.CFrame.LookVector.Z)
                        end
                        if v84.Magnitude > 0.05 then
                            v63 = v84.Unit
                            local v111 = v110.speed or 70
                            v77 = math.max(1, math.floor((math.clamp((v110.distance or 16) / v111, 0.12, 0.35) * 60) + 0.5))
                            s_5.SDashV = Vector3.new(math.floor(((v63.X * v111) / 0.01) + 0.5) * 0.01, 0, math.floor(((v63.Z * v111) / 0.01) + 0.5) * 0.01)
                            s_5.SDashB = ((v110.brake) and 2) or nil
                            s_5.SDashCD = math.max(1, math.floor(((Combat_upv_1.DASH_GAP * 0.85) * 60) + 0.5))
                            a1.dashCd = a1.dashCd or {}
                            local dashCd_1 = a1.dashCd
                            local v112
                            if v110.refreshOnKill then
                                v112 = math.min(v110.cooldown or 1, 0.6)
                            else
                                v112 = v110.cooldown or 1
                            end
                            dashCd_1[v70] = math.max(1, math.floor(((v112 * 0.85) * 60) + 0.5))
                            s_5.SCharge = nil
                            s_5.SChargeRel = nil
                            if s_5.SSlide ~= nil then
                                s_5.SSlide = nil
                                s_5.SSlideDir = nil
                                s_5.SSlope = nil
                                s_5.SLift = nil
                                s_5.SSlideCD = u6
                                s_5.SSpeed = math.max(s_5.SSpeed, 17)
                            end
                        end
                    end
                end
            end
            s_5.SLungeIn = (v83 and true) or nil
            v74 = not v50
            local v113 = nil
            if v74 then
                v113 = not v94
                if v113 then
                    local v114 = false
                    if v51 > 0.001 then
                        local v115 = false
                        if s_5.SDashV ~= nil then
                            v70 = v115
                        else
                            v70 = v95
                        end
                    else
                        v70 = v114
                    end
                else
                    v70 = v113
                end
            else
                v70 = v74
            end
            if not (v81) or s_5.SSlideIn == true then
                if s_5.SSlide == nil and (v96 and v81 or s_5.SSlideBuf ~= nil) and v90.Magnitude > 0.2 then
                    tryStartSlide(s_5, humanoid_2, v90, AssemblyLinearVelocity_1, v70)
                end
            elseif not (tryStartSlide(s_5, humanoid_2, v90, AssemblyLinearVelocity_1, v70)) then
                s_5.SSlideBuf = u7
            end
            s_5.SSlideIn = (v81 and true) or nil
            v96 = nil
            local v116, v117 = nil, nil
            local v107
            if s_5.SSlide == nil then
                local v118 = BASE_SPEED_upv_1
                v116 = s_5.SBoost or 0
                if v116 > 0 then
                    local v119 = math.max(v118, s_5.SSpeed)
                    s_5.SBoost = ((v116 > 1) and (v116 - 1)) or nil
                    v118 = v119
                end
                local v120 = (v95 and 8) or 1.6
                local v121 = s_5.SSpeed
                if v121 < v118 then
                    v121 = v118
                else
                    v121 = v121 + (v118 - v121) * (1 - math.exp(-v120 * a2))
                    if math.abs(v121 - v118) < 0.03 then
                        v121 = v118
                    end
                end
                s_5.SSpeed = v121
                v107 = v121 * v100
            else
                local v122 = s_5.SSlide + ((v95 and 1) or 0)
                s_5.SSlide = v122
                v83 = math.clamp(v122 / u5, 0, 1)
                v81 = (v83 * -19) * v83 + 36
                v51 = s_5.SSlideDir
                v51 = v51 or Vector3.new(root_8.CFrame.LookVector.X, 0, root_8.CFrame.LookVector.Z)
                v117 = Vector3.new(v90.X, 0, v90.Z)
                local v123 = nil
                if v117.Magnitude > 0.3 then
                    v117 = v117.Unit
                    v123 = math.acos(math.clamp(v51:Dot(v117), -1, 1))
                    if v123 > 0.001 and v123 < 2.0943951023931953 then
                        v51 = v51:Lerp(v117, math.min(1, (a2 * 1.6580627893946132) / v123)).Unit
                    end
                end
                v51 = Vector3.new(math.floor((v51.X / 1e-04) + 0.5) * 1e-04, 0, math.floor((v51.Z / 1e-04) + 0.5) * 1e-04)
                s_5.SSlideDir = v51
                if type(s_5.SSlope) ~= "number" then
                    v117 = 0
                else
                    v117 = s_5.SSlope
                end
                local v124 = nil
                if v95 then
                    local v125
                    if type(s_5.SHip) == "number" then
                        v125 = s_5.SHip
                    elseif u23 then
                        v125 = humanoid_2.HipHeight
                    else
                        v125 = s_5.SHipBase
                    end
                    local v126
                    if type(s_5.SHipBase) ~= "number" then
                        v126 = v125
                    else
                        v126 = s_5.SHipBase
                    end
                    local v127
                    local v128
                    v128, v127 = probeGround(a1, v51, v81, Vector3.new(AssemblyLinearVelocity_1.X, 0, AssemblyLinearVelocity_1.Z).Magnitude, v125, v126)
                    v124 = v127
                    v117 = v128 and math.floor((v117 + math.clamp(v128 - v117, -(a2 * 40), a2 * 40)) / 0.01 + 0.5) * 0.01
                end
                local v125
                if v117 == 0 then
                    v125 = nil
                else
                    v125 = v117
                end
                s_5.SSlope = v125
                v125 = (v124 and (math.floor((v124 / 0.01) + 0.5) * 0.01)) or nil
                s_5.SLift = v125
                v81 = v81 + v117
                s_5.SSpeed = v81
                v107 = v81 * v100
                humanoid_2:Move(v51, false)
                local Magnitude_2 = Vector3.new(AssemblyLinearVelocity_1.X, 0, AssemblyLinearVelocity_1.Z).Magnitude
                if v95 or not (u9 < v87) then
                    if v83 >= 1 or v122 * 0.016666666666666666 > 0.2 and Magnitude_2 < 6 or v50 or v94 then
                        if s_5.SSlide ~= nil then
                            s_5.SSlide = nil
                            s_5.SSlideDir = nil
                            s_5.SSlope = nil
                            s_5.SLift = nil
                            s_5.SSlideCD = u6
                            s_5.SSpeed = math.max(s_5.SSpeed, 17)
                        end
                        v107, v96 = v107, v51
                        s_5.SSpeed = math.floor((s_5.SSpeed / 0.001) + 0.5) * 0.001
                        if v50 then
                            v107 = 0
                            s_5.SSpeed = BASE_SPEED_upv_1
                        end
                        v107 = math.floor((v107 / 0.01) + 0.5) * 0.01
                        if v107 ~= v107 or not (v107 > -1e+07) or not (v107 < 1e+07) then
                            if not (tbl_upv_9["walk speed"]) then
                                tbl_upv_9["walk speed"] = true
                                local v130 = (u17 and "Client") or "Server"
                                warn((("[SimNaN] walk speed auth=%* side=%*"):format(v130, (u15 and "server") or "client")))
                            end
                            s_5.SSpeed = BASE_SPEED_upv_1
                            v107 = BASE_SPEED_upv_1
                        end
                        v94 = Vector3.new(v90.X, 0, v90.Z) * v107
                        if not u1 and not u23 then
                            if s_5.SSlide == nil then
                                local v131, v132, v133 = nil, nil, nil
                                if v107 <= 0 then
                                    v94 = Vector3.new(0, 0, 0)
                                else
                                    v86 = typeof(s_5.SVel) ~= "Vector3" and Vector3.new(0, 0, 0) or s_5.SVel
                                    if not (v82) then
                                        v117 = Vector3.new(AssemblyLinearVelocity_1.X, 0, AssemblyLinearVelocity_1.Z).Magnitude + 16
                                        v86 = ((v117 < v86.Magnitude) and (v86.Unit * v117)) or v86
                                    end
                                    v117 = Vector3.new(v90.X, 0, v90.Z)
                                    local v134 = v117 * v107
                                    local v135
                                    if v82 then
                                        v135 = ((v117.Magnitude > 0.05) and 160) or 50
                                    else
                                        v135 = ((v117.Magnitude <= 0.05) and 200) or (((v134:Dot(v86) < 0) and 500) or 300)
                                    end
                                    v131 = v135 * a2
                                    v117 = v134 - v86
                                    v132 = v117.Magnitude
                                    if v132 <= v131 then
                                        v94 = v134
                                    else
                                        v94 = v86 + v117 * (v131 / v132)
                                    end
                                    v133 = v94.Magnitude
                                    if v133 < 0.05 then
                                        v94 = Vector3.new(0, 0, 0)
                                        humanoid_2:Move(Vector3.new(0, 0, 0), false)
                                    else
                                        local X_3 = v94.X
                                        local v130 = (X_3 == X_3) and ((X_3 > -1e+07) and (X_3 < 1e+07))
                                        if v130 then
                                            local Y_7 = v94.Y
                                            v130 = (Y_7 == Y_7) and ((Y_7 > -1e+07) and (Y_7 < 1e+07))
                                            if v130 then
                                                local v155 = v94.Z
                                                v130 = v94.Z == v94.Z and v94.Z > -1e+07 and v94.Z < 1e+07
                                            end
                                        end
                                        if v130 then
                                            humanoid_2:Move(v94 / v133, false)
                                            v107 = math.floor((v133 / 0.01) + 0.5) * 0.01
                                        else
                                            v94 = Vector3.new(0, 0, 0)
                                            humanoid_2:Move(Vector3.new(0, 0, 0), false)
                                        end
                                    end
                                    a1.moveWrote = humanoid_2.MoveDirection
                                end
                            else
                                v117 = s_5.SSlideDir or (Vector3.new(v90.X, 0, v90.Z))
                                v94 = v117 * v107
                                a1.moveWrote = humanoid_2.MoveDirection
                            end
                            if v94.Magnitude >= 0.05 then
                                v117 = Vector3.new(math.floor((v94.X / 0.001) + 0.5) * 0.001, 0, math.floor((v94.Z / 0.001) + 0.5) * 0.001)
                            else
                                v117 = nil
                            end
                            s_5.SVel = v117
                        end
                        if v61 and u21 and a1.wsWrote ~= nil and humanoid_2.WalkSpeed ~= a1.wsWrote then
                            u21("WalkSpeed")
                        end
                        if humanoid_2.WalkSpeed ~= v107 then
                            humanoid_2.WalkSpeed = v107
                        end
                        a1.wsWrote = humanoid_2.WalkSpeed
                        v75 = s_5.SHipBase
                        if type(v75) == "number" then
                            local v136, v137 = nil, nil
                            if s_5.SSlide == nil then
                                v136 = v75
                            else
                                v136 = math.max(0.3, v75 - 1.4)
                                v137 = s_5.SLift
                                if type(v137) == "number" and v136 < v137 then
                                    v136 = v137
                                end
                            end
                            if v99 and v136 < v99 then
                                v136 = v99
                            end
                            v107 = v136
                        else
                            v107 = nil
                        end
                        if v107 then
                            if type(s_5.SHip) ~= "number" then
                                v117 = (u23 and (math.floor((humanoid_2.HipHeight / 0.001) + 0.5) * 0.001)) or (s_5.SHipBase)
                            else
                                v117 = s_5.SHip
                            end
                            if (v98) and v107 == v98 then
                                v117 = v107
                            elseif s_5.SWet ~= nil and s_5.SSlide == nil and v107 < v117 then
                                if not v82 and math.abs(v117 - v107) > 0.01 then
                                    v117 = math.floor(((v117 + ((v107 - v117) * (1 - math.exp(-(((v107 < v117) and 30) or (((s_5.SLift ~= nil) and 45) or ((v99 and 30) or 14))) * a2)))) / 0.001) + 0.5) * 0.001
                                else
                                    v117 = v107
                                end
                            elseif math.abs(v117 - v107) > 0.01 then
                                v117 = math.floor(((v117 + ((v107 - v117) * (1 - math.exp(-(((v107 < v117) and 30) or (((s_5.SLift ~= nil) and 45) or ((v99 and 30) or 14))) * a2)))) / 0.001) + 0.5) * 0.001
                            else
                                v117 = v107
                            end
                            if s_5.SSlide == nil and s_5.SWet == nil and v117 == v107 then
                                s_5.SHip = nil
                                if u23 then
                                    s_5.SHipBase = nil
                                end
                            else
                                s_5.SHip = v117
                            end
                            if v117 ~= v117 or not (v117 > -1e+07) or not (v117 < 1e+07) then
                                if not (tbl_upv_9["hip height"]) then
                                    tbl_upv_9["hip height"] = true
                                    local v138 = (u17 and "Client") or "Server"
                                    warn((("[SimNaN] hip height auth=%* side=%*"):format(v138, (u15 and "server") or "client")))
                                end
                                local v139 = nil
                                if type(s_5.SHipBase) ~= "number" then
                                    v117 = humanoid_2.HipHeight
                                else
                                    v139 = s_5.SHipBase
                                    if (v139 == v139) and ((v139 > -1e+07) and (v139 < 1e+07)) then
                                        v117 = s_5.SHipBase
                                    else
                                        v117 = humanoid_2.HipHeight
                                    end
                                end
                                s_5.SHip = nil
                            end
                            if humanoid_2.HipHeight ~= v117 then
                                humanoid_2.HipHeight = v117
                            end
                            a1.hipWritten = v117
                        end
                        v107 = not v50 and (not v78 and (humanoid_2.SeatPart == nil))
                        if v107 then
                            v99 = math.floor((jumpProp(JUMP_HEIGHT_upv_1 * (1 - (v71 * 0.45)), Workspace_upv_1.Gravity) / 0.01) + 0.5) * 0.01
                        else
                            v99 = 0
                        end
                        if v61 and u21 and a1.jhWrote ~= nil and humanoid_2.JumpHeight ~= a1.jhWrote then
                            u21("JumpHeight")
                        end
                        if humanoid_2.JumpHeight ~= v99 then
                            humanoid_2.JumpHeight = v99
                        end
                        a1.jhWrote = humanoid_2.JumpHeight
                        v99 = false
                        v98 = false
                        if v107 then
                            if v95 then
                                v117 = v80 or v105 > 0
                                v99 = v117
                            elseif s_5.SJumped ~= true and v87 <= u11 and AssemblyLinearVelocity_1.Y <= 1 and v105 > 0 then
                                s_5.SJumped = true
                                local v140 = 0
                                humanoid_2:ChangeState(Enum.HumanoidStateType.Jumping)
                                v98, v105 = true, v140
                            end
                        end
                        humanoid_2.Jump = v99
                        if v99 and s_5.SFloat == nil then
                            v98 = true
                        end
                        if v98 and not (u1) then
                            s_5.SFloat = 1
                        end
                        if v105 > 0 then
                            v117 = v105
                        else
                            v117 = nil
                        end
                        s_5.SJumpBuf = v117
                        v107 = a1.gravity
                        v99 = v82 and (v53 ~= Enum.HumanoidStateType.Climbing) and (not v95 and (AssemblyLinearVelocity_1.Y < 0))
                        v105 = (s_5.SFloat ~= nil) and ((s_5.SKb == nil) and (v53 ~= Enum.HumanoidStateType.Climbing))
                        local v141 = 1
                        local v142
                        if v105 and (v98 or type(s_5.SFloat) == "number") then
                            v142 = u2
                        elseif v99 then
                            if v105 and not u1 and AssemblyLinearVelocity_1.Y > -10 then
                                v142 = u3
                            elseif s_5.SSlide == nil then
                                v142 = u4
                            else
                                v142 = 1.3
                            end
                        elseif v105 and AssemblyLinearVelocity_1.Y >= 0 then
                            if AssemblyLinearVelocity_1.Y < 10 then
                                v142 = u3
                            else
                                v142 = u2
                            end
                        else
                            v142 = v141
                        end
                        v105 = v99 or (v142 ~= 1)
                        if v107 then
                            if v105 then
                                v98 = Workspace_upv_1.Gravity * (1 - v142)
                                if (v99) and s_5.SSlide ~= nil then
                                    v95 = slideCushion(a1, AssemblyLinearVelocity_1.Y, humanoid_2.HipHeight)
                                    v98 = (v95 and (v95 + Workspace_upv_1.Gravity)) or v98
                                elseif v99 and v98 then
                                    local v143 = slideCushion(a1, AssemblyLinearVelocity_1.Y, v98, 4)
                                    v98 = (v143 and (v143 + Workspace_upv_1.Gravity)) or v98
                                end
                                local v144 = v98 * root_8.AssemblyMass
                                if v144 ~= v144 or not (v144 > -1e+07) or not (v144 < 1e+07) then
                                    if not (tbl_upv_9["fall force"]) then
                                        tbl_upv_9["fall force"] = true
                                        local v130 = (u17 and "Client") or "Server"
                                        warn((("[SimNaN] fall force auth=%* side=%*"):format(v130, (u15 and "server") or "client")))
                                    end
                                    v144 = 0
                                end
                                v107.Force = Vector3.new(0, v144, 0)
                            end
                            if v107.Enabled ~= v105 then
                                v107.Enabled = v105
                            end
                        end
                        v107 = nil
                        v76 = s_5.SKbF or 0
                        if v76 > 0 and s_5.SKb then
                            local v145 = v76 / math.max(s_5.SKbN or v76, 1)
                            v107 = s_5.SKb * v145 + v94 * (1 - v145)
                            v76 = v76 - 1
                            if v76 <= 0 then
                                s_5.SKb = nil
                                s_5.SKbF = nil
                                s_5.SKbN = nil
                            else
                                s_5.SKbF = v76
                            end
                        end
                        if (v77 > 0) and (s_5.SDashV) then
                            local SDashV_1 = s_5.SDashV
                            if v107 then
                                v107 = v107 + SDashV_1
                            else
                                v107 = SDashV_1
                            end
                            v96 = Vector3.new(SDashV_1.X, 0, SDashV_1.Z).Unit
                            v77 = v77 - 1
                        elseif s_5.SDashB then
                            v107 = v107 or v94
                            s_5.SDashB = ((s_5.SDashB > 1) and (s_5.SDashB - 1)) or nil
                        end
                        if v77 <= 0 then
                            s_5.SDashV = nil
                            s_5.SDashF = nil
                        else
                            s_5.SDashF = v77
                        end
                        if v107 then
                            local X_4 = v107.X
                            v117 = (X_4 == X_4) and ((X_4 > -1e+07) and (X_4 < 1e+07))
                            if v117 then
                                local Y_8 = v107.Y
                                v117 = (Y_8 == Y_8) and ((Y_8 > -1e+07) and (Y_8 < 1e+07))
                                if v117 then
                                    local v156 = v107.Z
                                    v117 = v107.Z == v107.Z and v107.Z > -1e+07 and v107.Z < 1e+07
                                end
                            end
                            if not (v117) then
                                v117 = s_5.SKb ~= nil and "push (knockback)" or s_5.SDashV == nil and "push" or "push (dash)"
                                if not (tbl_upv_9[v117]) then
                                    tbl_upv_9[v117] = true
                                    local v128 = (u17 and "Client") or "Server"
                                    warn((("[SimNaN] %* auth=%* side=%*"):format(v117, v128, (u15 and "server") or "client")))
                                end
                                v107 = nil
                                s_5.SKb = nil
                                s_5.SKbF = nil
                                s_5.SKbN = nil
                                s_5.SDashV = nil
                                s_5.SDashF = nil
                            end
                        end
                        v77 = a1.push
                        if v77 then
                            if v107 then
                                v77.PlaneVelocity = Vector2.new(v107.X, v107.Z)
                            end
                            v99 = v107 ~= nil
                            if v77.Enabled ~= v99 then
                                v77.Enabled = v99
                            end
                        end
                        if not (v96) and v88 and not (v50) and humanoid_2.SeatPart == nil then
                            v96 = Vector3.new(v88.X, 0, v88.Y)
                        end
                        v107 = a1.align
                        if v96 then
                            local X_5 = v96.X
                            v117 = (X_5 == X_5) and ((X_5 > -1e+07) and (X_5 < 1e+07))
                            if v117 then
                                local Y_9 = v96.Y
                                v117 = (Y_9 == Y_9) and ((Y_9 > -1e+07) and (Y_9 < 1e+07))
                                if v117 then
                                    local v157 = v96.Z
                                    v117 = v96.Z == v96.Z and v96.Z > -1e+07 and v96.Z < 1e+07
                                end
                            end
                            if not (v117) then
                                if not (tbl_upv_9.facing) then
                                    tbl_upv_9.facing = true
                                    local v130 = (u17 and "Client") or "Server"
                                    warn((("[SimNaN] facing auth=%* side=%*"):format(v130, (u15 and "server") or "client")))
                                end
                                v96 = nil
                            end
                        end
                        if v96 and v107 then
                            local v146 = nil
                            if v96.Magnitude > 0.1 then
                                if humanoid_2.AutoRotate then
                                    humanoid_2.AutoRotate = false
                                end
                                v77 = v96.Unit
                                v146 = CFrame.lookAt(Vector3.new(0, 0, 0), Vector3.new(math.floor((v77.X / 1e-04) + 0.5) * 1e-04, 0, math.floor((v77.Z / 1e-04) + 0.5) * 1e-04))
                                if v107.CFrame ~= v146 then
                                    v107.CFrame = v146
                                end
                                if not (v107.Enabled) then
                                    v107.Enabled = true
                                end
                            else
                                if v107 and v107.Enabled then
                                    v107.Enabled = false
                                end
                                if not (humanoid_2.AutoRotate) then
                                    humanoid_2.AutoRotate = true
                                end
                            end
                        else
                            if v107 and v107.Enabled then
                                v107.Enabled = false
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
                        s_5.SSlideCD = u6
                        s_5.SSpeed = math.max(s_5.SSpeed, 17)
                    end
                    s_5.SSpeed = math.max(s_5.SSpeed, v81)
                    s_5.SBoost = u8
                end
                v107, v96 = v107, v51
            end
            s_5.SSpeed = math.floor((s_5.SSpeed / 0.001) + 0.5) * 0.001
            if v50 then
                v107 = 0
                s_5.SSpeed = BASE_SPEED_upv_1
            end
            v107 = math.floor((v107 / 0.01) + 0.5) * 0.01
            if v107 ~= v107 or not (v107 > -1e+07) or not (v107 < 1e+07) then
                if not (tbl_upv_9["walk speed"]) then
                    tbl_upv_9["walk speed"] = true
                    local v130 = (u17 and "Client") or "Server"
                    warn((("[SimNaN] walk speed auth=%* side=%*"):format(v130, (u15 and "server") or "client")))
                end
                s_5.SSpeed = BASE_SPEED_upv_1
                v107 = BASE_SPEED_upv_1
            end
            v94 = Vector3.new(v90.X, 0, v90.Z) * v107
            if not u1 and not u23 then
                local v150 = nil
                if s_5.SSlide == nil then
                    local v131, v132, v133 = nil, nil, nil
                    if v107 <= 0 then
                        v94 = Vector3.new(0, 0, 0)
                    else
                        v86 = typeof(s_5.SVel) ~= "Vector3" and Vector3.new(0, 0, 0) or s_5.SVel
                        if not (v82) then
                            v150 = Vector3.new(AssemblyLinearVelocity_1.X, 0, AssemblyLinearVelocity_1.Z).Magnitude + 16
                            v86 = ((v150 < v86.Magnitude) and (v86.Unit * v150)) or v86
                        end
                        v150 = Vector3.new(v90.X, 0, v90.Z)
                        local v134 = v150 * v107
                        local v135
                        if v82 then
                            v135 = ((v150.Magnitude > 0.05) and 160) or 50
                        else
                            v135 = ((v150.Magnitude <= 0.05) and 200) or (((v134:Dot(v86) < 0) and 500) or 300)
                        end
                        v131 = v135 * a2
                        v150 = v134 - v86
                        v132 = v150.Magnitude
                        if v132 <= v131 then
                            v94 = v134
                        else
                            v94 = v86 + v150 * (v131 / v132)
                        end
                        v133 = v94.Magnitude
                        if v133 < 0.05 then
                            v94 = Vector3.new(0, 0, 0)
                            humanoid_2:Move(Vector3.new(0, 0, 0), false)
                        else
                            local X_3 = v94.X
                            local v130 = (X_3 == X_3) and ((X_3 > -1e+07) and (X_3 < 1e+07))
                            if v130 then
                                local Y_7 = v94.Y
                                v130 = (Y_7 == Y_7) and ((Y_7 > -1e+07) and (Y_7 < 1e+07))
                                if v130 then
                                    local v155 = v94.Z
                                    v130 = v94.Z == v94.Z and v94.Z > -1e+07 and v94.Z < 1e+07
                                end
                            end
                            if v130 then
                                humanoid_2:Move(v94 / v133, false)
                                v107 = math.floor((v133 / 0.01) + 0.5) * 0.01
                            else
                                v94 = Vector3.new(0, 0, 0)
                                humanoid_2:Move(Vector3.new(0, 0, 0), false)
                            end
                        end
                        a1.moveWrote = humanoid_2.MoveDirection
                    end
                else
                    v117 = s_5.SSlideDir or (Vector3.new(v90.X, 0, v90.Z))
                    v94 = v117 * v107
                    a1.moveWrote = humanoid_2.MoveDirection
                end
                if v94.Magnitude >= 0.05 then
                    v150 = Vector3.new(math.floor((v94.X / 0.001) + 0.5) * 0.001, 0, math.floor((v94.Z / 0.001) + 0.5) * 0.001)
                else
                    v150 = nil
                end
                s_5.SVel = v150
            end
            if v61 and u21 and a1.wsWrote ~= nil and humanoid_2.WalkSpeed ~= a1.wsWrote then
                u21("WalkSpeed")
            end
            if humanoid_2.WalkSpeed ~= v107 then
                humanoid_2.WalkSpeed = v107
            end
            a1.wsWrote = humanoid_2.WalkSpeed
            v75 = s_5.SHipBase
            if type(v75) == "number" then
                local v136, v137 = nil, nil
                if s_5.SSlide == nil then
                    v136 = v75
                else
                    v136 = math.max(0.3, v75 - 1.4)
                    v137 = s_5.SLift
                    if type(v137) == "number" and v136 < v137 then
                        v136 = v137
                    end
                end
                if v99 and v136 < v99 then
                    v136 = v99
                end
                v107 = v136
            else
                v107 = nil
            end
            if v107 then
                local v151
                if type(s_5.SHip) ~= "number" then
                    v151 = (u23 and (math.floor((humanoid_2.HipHeight / 0.001) + 0.5) * 0.001)) or (s_5.SHipBase)
                else
                    v151 = s_5.SHip
                end
                if (v98) and v107 == v98 then
                    v151 = v107
                elseif s_5.SWet ~= nil and s_5.SSlide == nil and v107 < v151 then
                    if not v82 and math.abs(v151 - v107) > 0.01 then
                        v151 = math.floor(((v151 + ((v107 - v151) * (1 - math.exp(-(((v107 < v151) and 30) or (((s_5.SLift ~= nil) and 45) or ((v99 and 30) or 14))) * a2)))) / 0.001) + 0.5) * 0.001
                    else
                        v151 = v107
                    end
                elseif math.abs(v151 - v107) > 0.01 then
                    v151 = math.floor(((v151 + ((v107 - v151) * (1 - math.exp(-(((v107 < v151) and 30) or (((s_5.SLift ~= nil) and 45) or ((v99 and 30) or 14))) * a2)))) / 0.001) + 0.5) * 0.001
                else
                    v151 = v107
                end
                if s_5.SSlide == nil and s_5.SWet == nil and v151 == v107 then
                    s_5.SHip = nil
                    if u23 then
                        s_5.SHipBase = nil
                    end
                else
                    s_5.SHip = v151
                end
                if v151 ~= v151 or not (v151 > -1e+07) or not (v151 < 1e+07) then
                    if not (tbl_upv_9["hip height"]) then
                        tbl_upv_9["hip height"] = true
                        local v138 = (u17 and "Client") or "Server"
                        warn((("[SimNaN] hip height auth=%* side=%*"):format(v138, (u15 and "server") or "client")))
                    end
                    local v139 = nil
                    if type(s_5.SHipBase) ~= "number" then
                        v151 = humanoid_2.HipHeight
                    else
                        v139 = s_5.SHipBase
                        if (v139 == v139) and ((v139 > -1e+07) and (v139 < 1e+07)) then
                            v151 = s_5.SHipBase
                        else
                            v151 = humanoid_2.HipHeight
                        end
                    end
                    s_5.SHip = nil
                end
                if humanoid_2.HipHeight ~= v151 then
                    humanoid_2.HipHeight = v151
                end
                a1.hipWritten = v151
            end
            v107 = not v50 and (not v78 and (humanoid_2.SeatPart == nil))
            if v107 then
                v99 = math.floor((jumpProp(JUMP_HEIGHT_upv_1 * (1 - (v71 * 0.45)), Workspace_upv_1.Gravity) / 0.01) + 0.5) * 0.01
            else
                v99 = 0
            end
            if v61 and u21 and a1.jhWrote ~= nil and humanoid_2.JumpHeight ~= a1.jhWrote then
                u21("JumpHeight")
            end
            if humanoid_2.JumpHeight ~= v99 then
                humanoid_2.JumpHeight = v99
            end
            a1.jhWrote = humanoid_2.JumpHeight
            v99 = false
            v98 = false
            if v107 then
                if v95 then
                    v99 = v80 or v105 > 0
                elseif s_5.SJumped ~= true and v87 <= u11 and AssemblyLinearVelocity_1.Y <= 1 and v105 > 0 then
                    s_5.SJumped = true
                    local v140 = 0
                    humanoid_2:ChangeState(Enum.HumanoidStateType.Jumping)
                    v98, v105 = true, v140
                end
            end
            humanoid_2.Jump = v99
            if v99 and s_5.SFloat == nil then
                v98 = true
            end
            if v98 and not (u1) then
                s_5.SFloat = 1
            end
            local v153
            if v105 > 0 then
                v153 = v105
            else
                v153 = nil
            end
            s_5.SJumpBuf = v117
            v107 = a1.gravity
            v99 = v82 and (v53 ~= Enum.HumanoidStateType.Climbing) and (not v95 and (AssemblyLinearVelocity_1.Y < 0))
            v105 = (s_5.SFloat ~= nil) and ((s_5.SKb == nil) and (v53 ~= Enum.HumanoidStateType.Climbing))
            local v141 = 1
            local v142
            if v105 and (v98 or type(s_5.SFloat) == "number") then
                v142 = u2
            elseif v99 then
                if v105 and not u1 and AssemblyLinearVelocity_1.Y > -10 then
                    v142 = u3
                elseif s_5.SSlide == nil then
                    v142 = u4
                else
                    v142 = 1.3
                end
            elseif v105 and AssemblyLinearVelocity_1.Y >= 0 then
                if AssemblyLinearVelocity_1.Y < 10 then
                    v142 = u3
                else
                    v142 = u2
                end
            else
                v142 = v141
            end
            v105 = v99 or (v142 ~= 1)
            if v107 then
                if v105 then
                    v98 = Workspace_upv_1.Gravity * (1 - v142)
                    if (v99) and s_5.SSlide ~= nil then
                        v95 = slideCushion(a1, AssemblyLinearVelocity_1.Y, humanoid_2.HipHeight)
                        v98 = (v95 and (v95 + Workspace_upv_1.Gravity)) or v98
                    elseif v99 and v98 then
                        local v143 = slideCushion(a1, AssemblyLinearVelocity_1.Y, v98, 4)
                        v98 = (v143 and (v143 + Workspace_upv_1.Gravity)) or v98
                    end
                    local v144 = v98 * root_8.AssemblyMass
                    if v144 ~= v144 or not (v144 > -1e+07) or not (v144 < 1e+07) then
                        if not (tbl_upv_9["fall force"]) then
                            tbl_upv_9["fall force"] = true
                            local v130 = (u17 and "Client") or "Server"
                            warn((("[SimNaN] fall force auth=%* side=%*"):format(v130, (u15 and "server") or "client")))
                        end
                        v144 = 0
                    end
                    v107.Force = Vector3.new(0, v144, 0)
                end
                if v107.Enabled ~= v105 then
                    v107.Enabled = v105
                end
            end
            v107 = nil
            v76 = s_5.SKbF or 0
            if v76 > 0 and s_5.SKb then
                local v145 = v76 / math.max(s_5.SKbN or v76, 1)
                v107 = s_5.SKb * v145 + v94 * (1 - v145)
                v76 = v76 - 1
                if v76 <= 0 then
                    s_5.SKb = nil
                    s_5.SKbF = nil
                    s_5.SKbN = nil
                else
                    s_5.SKbF = v76
                end
            end
            if (v77 > 0) and (s_5.SDashV) then
                local SDashV_1 = s_5.SDashV
                if v107 then
                    v107 = v107 + SDashV_1
                else
                    v107 = SDashV_1
                end
                v96 = Vector3.new(SDashV_1.X, 0, SDashV_1.Z).Unit
                v77 = v77 - 1
            elseif s_5.SDashB then
                v107 = v107 or v94
                s_5.SDashB = ((s_5.SDashB > 1) and (s_5.SDashB - 1)) or nil
            end
            if v77 <= 0 then
                s_5.SDashV = nil
                s_5.SDashF = nil
            else
                s_5.SDashF = v77
            end
            if v107 then
                local X_4 = v107.X
                v153 = (X_4 == X_4) and ((X_4 > -1e+07) and (X_4 < 1e+07))
                if v153 then
                    local Y_8 = v107.Y
                    v153 = (Y_8 == Y_8) and ((Y_8 > -1e+07) and (Y_8 < 1e+07))
                    if v153 then
                        local v156 = v107.Z
                        v153 = v107.Z == v107.Z and v107.Z > -1e+07 and v107.Z < 1e+07
                    end
                end
                if not (v153) then
                    v153 = s_5.SKb ~= nil and "push (knockback)" or s_5.SDashV == nil and "push" or "push (dash)"
                    if not (tbl_upv_9[v153]) then
                        tbl_upv_9[v153] = true
                        local v128 = (u17 and "Client") or "Server"
                        warn((("[SimNaN] %* auth=%* side=%*"):format(v153, v128, (u15 and "server") or "client")))
                    end
                    v107 = nil
                    s_5.SKb = nil
                    s_5.SKbF = nil
                    s_5.SKbN = nil
                    s_5.SDashV = nil
                    s_5.SDashF = nil
                end
            end
            v77 = a1.push
            if v77 then
                if v107 then
                    v77.PlaneVelocity = Vector2.new(v107.X, v107.Z)
                end
                v99 = v107 ~= nil
                if v77.Enabled ~= v99 then
                    v77.Enabled = v99
                end
            end
            if not (v96) and v88 and not (v50) and humanoid_2.SeatPart == nil then
                v96 = Vector3.new(v88.X, 0, v88.Y)
            end
            v107 = a1.align
            if v96 then
                local X_5 = v96.X
                v153 = (X_5 == X_5) and ((X_5 > -1e+07) and (X_5 < 1e+07))
                if v153 then
                    local Y_9 = v96.Y
                    v153 = (Y_9 == Y_9) and ((Y_9 > -1e+07) and (Y_9 < 1e+07))
                    if v153 then
                        local v157 = v96.Z
                        v153 = v96.Z == v96.Z and v96.Z > -1e+07 and v96.Z < 1e+07
                    end
                end
                if not (v153) then
                    if not (tbl_upv_9.facing) then
                        tbl_upv_9.facing = true
                        local v130 = (u17 and "Client") or "Server"
                        warn((("[SimNaN] facing auth=%* side=%*"):format(v130, (u15 and "server") or "client")))
                    end
                    v96 = nil
                end
            end
            if v96 and v107 then
                local v146 = nil
                if v96.Magnitude > 0.1 then
                    if humanoid_2.AutoRotate then
                        humanoid_2.AutoRotate = false
                    end
                    v77 = v96.Unit
                    v146 = CFrame.lookAt(Vector3.new(0, 0, 0), Vector3.new(math.floor((v77.X / 1e-04) + 0.5) * 1e-04, 0, math.floor((v77.Z / 1e-04) + 0.5) * 1e-04))
                    if v107.CFrame ~= v146 then
                        v107.CFrame = v146
                    end
                    if not (v107.Enabled) then
                        v107.Enabled = true
                    end
                else
                    if v107 and v107.Enabled then
                        v107.Enabled = false
                    end
                    if not (humanoid_2.AutoRotate) then
                        humanoid_2.AutoRotate = true
                    end
                end
            else
                if v107 and v107.Enabled then
                    v107.Enabled = false
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
            s_5.SVel = nil
            s_5.SFloat = nil
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
        v50 = ((a1.goodCF) and "root") or "root (no last place)"
        if not (tbl_upv_9[v50]) then
            tbl_upv_9[v50] = true
            warn((("[SimNaN] %* auth=%* side=%*"):format(v50, (u17 and "Client") or "Server", (u15 and "server") or "client")))
        end
        local root_9 = a1.root
        local s_6 = a1.s
        v51 = a1.push
        local align_2 = a1.align
        local gravity_2 = a1.gravity
        if v51 then
            v51.PlaneVelocity = Vector2.zero
            v51.Enabled = false
        end
        if align_2 then
            align_2.Enabled = false
            align_2.CFrame = CFrame.identity
        end
        if gravity_2 then
            gravity_2.Force = Vector3.new(0, 0, 0)
            gravity_2.Enabled = false
        end
        v52 = a1.goodCF
        if v52 then
            root_9.CFrame = v52
        end
        root_9.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        root_9.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
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
        s_6.SVel = nil
        s_6.SFloat = nil
        s_6.SSpeed = BASE_SPEED_upv_1
    end
    save(a1)
end
local tbl_upv_10 = {steps = 0, chars = 0, time = 0, maxStep = 0}
function tbl_upv_1.DebugStats()
    --[[
      name: DebugStats
      line: 1510
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
local u26 = Vector3.new(0, 0, 0)
local u27 = nil
local u28 = Vector3.new(0, 0, 0)
local u29 = nil
local u30 = nil
local u31 = false
local function trackCorrection(a1)
    --[[
      name: trackCorrection
      line: 1536
      upvalues:
        RunService_upv_1 (copy, index: 1)
        u31 (ref,  index: 2)
        tbl_upv_5 (copy, index: 3)
        u27 (ref,  index: 4)
        u29 (ref,  index: 5)
        u30 (ref,  index: 6)
        u28 (ref,  index: 7)
        u26 (ref,  index: 8)
    ]]
    if RunService_upv_1:IsResimulating() then
        u31 = true
    else
        local v154 = tbl_upv_5[1]
        if v154 then
            local root_10 = v154.root
            local Position_5 = root_10.Position
            local AssemblyLinearVelocity_2 = root_10.AssemblyLinearVelocity
            local v155 = root_10:GetAttribute("STp")
            if u31 and u27 and root_10 == u29 and v155 == u30 then
                local v156 = Position_5 - (u27 + (((u28 + AssemblyLinearVelocity_2) * 0.5) * a1))
                local Magnitude_3 = v156.Magnitude
                if Magnitude_3 > 0.02 and Magnitude_3 < 20 then
                    u26 = u26 + v156
                end
            end
            u27 = Position_5
            u28 = AssemblyLinearVelocity_2
            u29 = root_10
            u30 = v155
        else
            u27 = nil
            u29 = nil
        end
        u31 = false
    end
end
function tbl_upv_1.TakeCorrection()
    --[[
      name: TakeCorrection
      line: 1561
      upvalues:
        u26 (ref, index: 1)
    ]]
    local v157 = u26
    u26 = Vector3.new(0, 0, 0)
    return v157
end
function tbl_upv_1.RebaseCorrection()
    --[[
      name: RebaseCorrection
      line: 1570
      upvalues:
        tbl_upv_5 (copy, index: 1)
        u15 (copy, index: 2)
        u27 (ref,  index: 3)
        u28 (ref,  index: 4)
        u29 (ref,  index: 5)
        u30 (ref,  index: 6)
        u31 (ref,  index: 7)
    ]]
    local v158 = tbl_upv_5[1]
    if (u15) or not v158 then
        return
    end
    local root_11 = v158.root
    local AssemblyLinearVelocity_3 = root_11.AssemblyLinearVelocity
    local v159 = root_11:GetAttribute("STp")
    u27 = root_11.Position - (AssemblyLinearVelocity_3 * 0.016666666666666666)
    u28 = AssemblyLinearVelocity_3
    u29 = root_11
    u30 = v159
    u31 = false
end
local function stepRelay(a1, a2)
    --[[
      name: stepRelay
      line: 816
      upvalues:
        stepCollisions (copy, index: 1)
    ]]
    local humanoid_3 = a1.humanoid
    local root_12 = a1.root
    local v160 = (humanoid_3:GetState() ~= Enum.HumanoidStateType.Dead) and (humanoid_3.Health > 0)
    stepCollisions(a1, v160)
    local v161 = ((a1.frozen) and true) or nil
    if root_12:GetAttribute("SFrozen") ~= v161 then
        root_12:SetAttribute("SFrozen", v161)
    end
    local v162 = ((a1.slow ~= 1) and (math.floor((a1.slow / 0.001) + 0.5) * 0.001)) or nil
    if root_12:GetAttribute("SSlow") ~= v162 then
        root_12:SetAttribute("SSlow", v162)
    end
    local v163 = ((a1.noJump) and true) or nil
    if root_12:GetAttribute("SNoJump") ~= v163 then
        root_12:SetAttribute("SNoJump", v163)
    end
    local pending_1 = a1.pending
    local v164 = nil
    if pending_1.tp then
        local tp_2 = pending_1.tp
        pending_1.tp = nil
        a1.character:PivotTo(tp_2)
        root_12:SetAttribute("STpCF", tp_2)
        v164 = root_12:GetAttribute("STp")
        local v165
        if type(v164) ~= "number" then
            v165 = 0
        else
            v165 = v164
        end
        root_12:SetAttribute("STp", v165 + 1)
    end
    if pending_1.kb and v160 then
        local v166 = root_12:GetAttribute("NKbSeq")
        root_12:SetAttribute("NKb", pending_1.kb)
        root_12:SetAttribute("NKbDur", pending_1.kbDur)
        local v165
        if type(v166) ~= "number" then
            v165 = 0
        else
            v165 = v166
        end
        root_12:SetAttribute("NKbSeq", v165 + 1)
    end
    pending_1.kb = nil
    pending_1.kbDur = nil
end
local function unregister(a1)
    --[[
      name: unregister
      line: 1606
      upvalues:
        tbl_upv_4 (copy, index: 1)
        tbl_upv_5 (copy, index: 2)
    ]]
    local v167 = tbl_upv_4[a1]
    if not v167 then
        return
    end
    tbl_upv_4[a1] = nil
    for _, value_8 in v167.conns do
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
      line: 1635
    ]]
    local v168 = a1:FindFirstChild("InputContexts") or (a1:WaitForChild("InputContexts", a2))
    local v169 = v168 and (v168:FindFirstChild("CharacterContext") or (v168:WaitForChild("CharacterContext", 5)))
    local v170 = v169 and (v169:FindFirstChild("MoveAction") or (v169:WaitForChild("MoveAction", 5)))
    if v170 and v170:IsA("InputAction") then
        return v170
    end
    warn("[Simulation] no InputContexts.CharacterContext.MoveAction: walking falls back to the PlayerModule")
    return nil
end
local function ensureConstraints(a1)
    --[[
      name: ensureConstraints
      line: 1660
    ]]
    local RootAttachment_1 = a1:FindFirstChild("RootAttachment")
    if RootAttachment_1 and RootAttachment_1:IsA("Attachment") then
        local v171 = a1:FindFirstChild("TribesKnockback")
        local v172 = nil
        if not (v171) then
            v172 = Instance.new("LinearVelocity")
            v172.Name = "TribesKnockback"
            v172.Attachment0 = RootAttachment_1
            v172.RelativeTo = Enum.ActuatorRelativeTo.World
            v172.VelocityConstraintMode = Enum.VelocityConstraintMode.Plane
            v172.PrimaryTangentAxis = Vector3.new(1, 0, 0)
            v172.SecondaryTangentAxis = Vector3.new(0, 0, 1)
            v172.ForceLimitMode = Enum.ForceLimitMode.Magnitude
            v172.MaxForce = 1e+06
            v172.Enabled = false
            v172.Parent = a1
            v171 = v172
        end
        v172 = a1:FindFirstChild("TribesFallGravity")
        local v173 = nil
        if not (v172) then
            v173 = Instance.new("VectorForce")
            v173.Name = "TribesFallGravity"
            v173.Attachment0 = RootAttachment_1
            v173.RelativeTo = Enum.ActuatorRelativeTo.World
            v173.ApplyAtCenterOfMass = true
            v173.Force = Vector3.new(0, 0, 0)
            v173.Enabled = false
            v173.Parent = a1
            v172 = v173
        end
        v173 = a1:FindFirstChild("TribesFacing")
        if not (v173) then
            local v174 = Instance.new("AlignOrientation")
            v174.Name = "TribesFacing"
            v174.Mode = Enum.OrientationAlignmentMode.OneAttachment
            v174.Attachment0 = RootAttachment_1
            v174.RigidityEnabled = true
            v174.MaxTorque = math.huge
            v174.MaxAngularVelocity = math.huge
            v174.Enabled = false
            v174.Parent = a1
            v173 = v174
        end
        local v174 = not (v171) or not (v171:IsA("LinearVelocity")) or v171
        local v175 = not (v172) or not (v172:IsA("VectorForce")) or v172
        if v173 and v173:IsA("AlignOrientation") then
            return v174, v175, v173
        end
        return v174, v175, nil
    end
    return nil, nil, nil
end
local function corpseParts(a1)
    --[[
      name: corpseParts
      line: 1740
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    local tbl_12 = {}
    for _, value_10 in tbl_upv_2 do
        local v176 = a1:FindFirstChild(value_10)
        if not (v176) then
            continue
        end
        if v176:IsA("BasePart") then
            table.insert(tbl_12, v176)
        end
    end
    return tbl_12
end
local function actionsOf(a1, a2)
    --[[
      name: actionsOf
      line: 1618
      upvalues:
        Inputs_upv_1 (copy, index: 1)
    ]]
    local tbl_13 = {}
    local v177 = a1:FindFirstChild(Inputs_upv_1.CONTEXT) or (a1:WaitForChild(Inputs_upv_1.CONTEXT, a2))
    if v177 then
        for _, value_11 in Inputs_upv_1.ACTIONS do
            local v178 = v177:FindFirstChild(value_11.name) or (v177:WaitForChild(value_11.name, 5))
            if not (v178) then
                continue
            end
            if v178:IsA("InputAction") then
                tbl_13[value_11.name] = v178
            end
        end
    end
    return tbl_13
end
local function ensureHull(a1)
    --[[
      name: ensureHull
      line: 1711
      upvalues:
        u23 (copy, index: 1)
    ]]
    local TribesHull_1 = a1:FindFirstChild("TribesHull")
    if TribesHull_1 and TribesHull_1:IsA("BasePart") then
        return TribesHull_1
    end
    if u23 then
        return nil
    end
    local Size_1 = a1.Size
    local v179 = Instance.new("Part")
    v179.Name = "TribesHull"
    v179.Shape = Enum.PartType.Cylinder
    v179.Size = Vector3.new(Size_1.Y * 1.4, Size_1.X * 0.9, Size_1.X * 0.9)
    v179.Transparency = 1
    v179.CastShadow = false
    v179.Massless = true
    v179.CanCollide = true
    v179.CanQuery = false
    v179.CanTouch = false
    v179.CollisionGroup = a1.CollisionGroup
    v179.CFrame = a1.CFrame * CFrame.new(0, Size_1.Y * 0.2, 0) * CFrame.Angles(0, 0, 1.5707963267948966)
    Size_1 = Instance.new("WeldConstraint")
    Size_1.Part0 = a1
    Size_1.Part1 = v179
    Size_1.Parent = v179
    v179.Parent = a1
    return v179
end
local function recomputeMirrors(a1)
    --[[
      name: recomputeMirrors
      line: 1647
    ]]
    local humanoid_4 = a1.humanoid
    local v180 = 1
    for key_3, value_12 in humanoid_4:GetAttributes() do
        if typeof(value_12) ~= "number" or string.sub(key_3, 1, 9) ~= "SpeedMult" then
            continue
        end
        if value_12 == value_12 then
            v180 = v180 * math.clamp(value_12, 0, 3)
        end
    end
    a1.slow = v180
    a1.frozen = a1.player:GetAttribute("Frozen") == true
    local v182 = true
    local v183
    if humanoid_4:GetAttribute("NoJump") == true then
        v183 = v182
    else
        v183 = true
        if a1.character:GetAttribute("NoJump") ~= true then
            v183 = a1.character:GetAttribute("Rooted") == true
        end
    end
    a1.noJump = v183
end
local function bodyParts(a1)
    --[[
      name: bodyParts
      line: 1751
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
      line: 1761
      upvalues:
        tbl_upv_4 (copy, index: 1)
        tbl_upv_5 (copy, index: 2)
        u15 (copy, index: 3)
        tbl_upv_1 (copy, index: 4)
        JUMP_HEIGHT_upv_1 (copy, index: 5)
        BASE_SPEED_upv_1 (copy, index: 6)
        u22 (copy, index: 7)
        ensureConstraints (copy, index: 8)
        ensureHull (copy, index: 9)
        u17 (copy, index: 10)
        RunService_upv_1 (copy, index: 11)
        u23 (copy, index: 12)
        u19 (copy, index: 13)
        actionsOf (copy, index: 14)
        moveActionOf (copy, index: 15)
        bodyParts (copy, index: 16)
        corpseParts (copy, index: 17)
        recomputeMirrors (copy, index: 18)
    ]]
    local v184 = tbl_upv_4[a2]
    if v184 then
        tbl_upv_4[a2] = nil
        for _, value_14 in v184.conns do
            value_14:Disconnect()
        end
        table.clear(tbl_upv_5)
        for _, value_15 in tbl_upv_4 do
            table.insert(tbl_upv_5, value_15)
        end
    end
    local v185 = a2:WaitForChild("Humanoid", 10)
    local u32 = a2:WaitForChild("HumanoidRootPart", 10)
    if not v185 or not v185:IsA("Humanoid") or not u32 or not u32:IsA("BasePart") or a1.Character ~= a2 then
        return
    end
    local v186, v187, v188, v189, v190 = nil, nil, nil, nil, nil
    if u15 then
        v185.UseJumpPower = false
        v185.JumpPower = tbl_upv_1.JUMP_POWER_MARK
        v185.JumpHeight = JUMP_HEIGHT_upv_1
        v185.WalkSpeed = BASE_SPEED_upv_1
        v185:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        v185:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        v185:SetStateEnabled(Enum.HumanoidStateType.Swimming, u22)
        local _, v197, v198 = ensureConstraints(u32)
        local v191 = ensureHull(u32)
        if u17 then
            pcall(
                function()
                    --[[
                      line: 1787
                      upvalues:
                        u32 (copy, index: 1)
                        a1 (copy, index: 2)
                    ]]
                    u32:SetNetworkOwner(a1)
                end
            )
        end
        v186 = v191
    else
        pcall(
            function()
                --[[
                  line: 1793
                  upvalues:
                    RunService_upv_1 (copy, index: 1)
                    u32 (copy, index: 2)
                ]]
                RunService_upv_1:SetPredictionMode(u32, Enum.PredictionMode.On)
            end
        )
        v185:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        v185:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        v185:SetStateEnabled(Enum.HumanoidStateType.Swimming, u22)
        v190 = u32:WaitForChild("TribesKnockback", 10)
        local v192 = u32:WaitForChild("TribesFallGravity", 10)
        local v193 = u32:WaitForChild("TribesFacing", 10)
        v187 = not (v190) or not (v190:IsA("LinearVelocity")) or v190
        v188 = not (v192) or not (v192:IsA("VectorForce")) or v192
        v189 = not (v193) or not (v193:IsA("AlignOrientation")) or v193
        v193 = u23 or u32:WaitForChild("TribesHull", 10)
        v186 = not (v193) or not (v193:IsA("BasePart")) or v193
    end
    local v194 = (u19 and {}) or (actionsOf(a1, 20))
    local v195 = u17 or moveActionOf(a1, 10)
    if a1.Character ~= a2 or not a2.Parent then
        return
    end
    local v196 = RaycastParams.new()
    v196.FilterType = Enum.RaycastFilterType.Exclude
    v196.FilterDescendantsInstances = {a2}
    v196.RespectCanCollide = true
    v196.IgnoreWater = true
    local tbl_upv_15 = {moveIntent = Vector3.new(0, 0, 0), noJump = false, holdSlot = -1, slow = 1, failed = false, holdBad = 0, frozen = false}
    tbl_upv_15.player = a1
    tbl_upv_15.character = a2
    tbl_upv_15.humanoid = v185
    tbl_upv_15.root = u32
    tbl_upv_15.push = v187
    tbl_upv_15.gravity = v188
    tbl_upv_15.align = v189
    tbl_upv_15.actions = v194
    tbl_upv_15.move = v195
    tbl_upv_15.hull = v186
    tbl_upv_15.body = bodyParts(a2)
    tbl_upv_15.corpse = corpseParts(a2)
    tbl_upv_15.ray = v196
    tbl_upv_15.s = {}
    tbl_upv_15.prev = {}
    tbl_upv_15.tpSeen = u32:GetAttribute("STp")
    tbl_upv_15.kbSeen = u32:GetAttribute("NKbSeq")
    tbl_upv_15.pending = {}
    tbl_upv_15.conns = {}
    tbl_upv_15.watchFrom = os.clock() + 8
    if u15 then
        recomputeMirrors(tbl_upv_15)
        local function refresh_1()
            --[[
              name: refresh
              line: 1856
              upvalues:
                recomputeMirrors (copy, index: 1)
                tbl_upv_15 (copy, index: 2)
            ]]
            recomputeMirrors(tbl_upv_15)
        end
        table.insert(tbl_upv_15.conns, v185.AttributeChanged:Connect(refresh_1))
        table.insert(tbl_upv_15.conns, a2.AttributeChanged:Connect(refresh_1))
        table.insert(tbl_upv_15.conns, a1:GetAttributeChangedSignal("Frozen"):Connect(refresh_1))
    end
    table.insert(
        tbl_upv_15.conns,
        a2.AncestryChanged:Connect(
            function()
                --[[
                  line: 1863
                  upvalues:
                    a2 (copy, index: 1)
                    tbl_upv_4 (copy, index: 2)
                    tbl_upv_5 (copy, index: 3)
                ]]
                if a2:IsDescendantOf(game) then
                    return
                end
                local v197 = a2
                local v198 = tbl_upv_4[v197]
                if not v198 then
                    return
                end
                tbl_upv_4[v197] = nil
                for _, value_16 in v198.conns do
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
      line: 1891
      upvalues:
        tbl_upv_4 (copy, index: 1)
        u15 (copy, index: 2)
    ]]
    local v199 = tbl_upv_4[a1]
    if v199 and u15 and typeof(a2) == "Vector3" and a2 == a2 then
        local pending_2 = v199.pending
        local v200
        if pending_2.kb then
            v200 = pending_2.kb + a2
        else
            v200 = a2
        end
        pending_2.kb = v200
        pending_2.kbDur = a3
        return true
    end
    return false
end
function tbl_upv_1.Teleport(a1, a2)
    --[[
      name: Teleport
      line: 1906
      upvalues:
        tbl_upv_4 (copy, index: 1)
        u15 (copy, index: 2)
        finCF (copy, index: 3)
    ]]
    local v201 = tbl_upv_4[a1]
    if v201 and u15 and typeof(a2) == "CFrame" and finCF(a2) then
        v201.pending.tp = a2
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
      line: 1922
      upvalues:
        tbl_upv_16 (copy, index: 1)
        tbl_upv_7 (copy, index: 2)
        tbl_upv_17 (copy, index: 3)
        u17 (copy, index: 4)
        tbl_upv_8 (copy, index: 5)
    ]]
    local u33 = tbl_upv_16[a1]
    local u34 = tbl_upv_7[a1]
    if not u33 or u34 == nil or tbl_upv_17[a1] == u34 then
        return
    end
    if not u17 or not tbl_upv_8[a1] then
        if pcall(
            function()
                --[[
                  line: 1931
                  upvalues:
                    u33 (copy, index: 1)
                    u34 (copy, index: 2)
                ]]
                u33:Fire(u34)
            end
        ) then
            tbl_upv_17[a1] = u34
        end
        return
    end
end
function tbl_upv_1.SetInput(a1, a2)
    --[[
      name: SetInput
      line: 1940
      upvalues:
        u15 (copy, index: 1)
        tbl_upv_18 (copy, index: 2)
        tbl_upv_7 (copy, index: 3)
        fire (copy, index: 4)
    ]]
    if u15 then
        return
    end
    tbl_upv_18[a1] = (tbl_upv_18[a1] or 0) + 1
    tbl_upv_7[a1] = a2
    fire(a1)
end
function tbl_upv_1.Pulse(a1, a2)
    --[[
      name: Pulse
      line: 1950
      upvalues:
        tbl_upv_1 (copy, index: 1)
        tbl_upv_18 (copy, index: 2)
    ]]
    tbl_upv_1.SetInput(a1, true)
    local u35 = tbl_upv_18[a1]
    task.delay(
        a2 or 0.12,
        function()
            --[[
              line: 1953
              upvalues:
                tbl_upv_18 (copy, index: 1)
                a1 (copy, index: 2)
                u35 (copy, index: 3)
                tbl_upv_1 (copy, index: 4)
            ]]
            if tbl_upv_18[a1] ~= u35 then
                return
            end
            tbl_upv_1.SetInput(a1, false)
        end
    )
end
function tbl_upv_1.SetFacing(a1)
    --[[
      name: SetFacing
      line: 1961
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
      line: 1971
      upvalues:
        u15 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    if (u15) or type(a1) ~= "number" or a1 ~= a1 then
        return
    end
    tbl_upv_1.SetInput("Look", Vector2.new(math.floor((-math.sin(a1) / 0.001) + 0.5) * 0.001, math.floor((-math.cos(a1) / 0.001) + 0.5) * 0.001))
end
function tbl_upv_1.WriteGuardStats()
    --[[
      name: WriteGuardStats
      line: 2009
      upvalues:
        WriteGuard_upv_1 (copy, index: 1)
    ]]
    return WriteGuard_upv_1.Stats()
end
function tbl_upv_1.WriteGuardReset()
    --[[
      name: WriteGuardReset
      line: 2013
      upvalues:
        WriteGuard_upv_1 (copy, index: 1)
    ]]
    WriteGuard_upv_1.Reset()
end
function tbl_upv_1.IsSliding(a1)
    --[[
      name: IsSliding
      line: 2018
    ]]
    local v202 = a1 and (a1:FindFirstChild("HumanoidRootPart"))
    local v203 = false
    if v202 ~= nil then
        v203 = v202:GetAttribute("SSlide") ~= nil
    end
    return v203
end
function tbl_upv_1.IsDashing(a1)
    --[[
      name: IsDashing
      line: 2023
    ]]
    local v204 = a1 and (a1:FindFirstChild("HumanoidRootPart"))
    local v205 = false
    if v204 ~= nil then
        v205 = v204:GetAttribute("SDashF") ~= nil
    end
    return v205
end
local tbl_upv_19 = {}
local u36 = false
local function startFallback()
    --[[
      name: startFallback
      line: 2040
      upvalues:
        u36 (ref,  index: 1)
        RunService_upv_1 (copy, index: 2)
    ]]
    if u36 then
        return
    end
    u36 = true
    local _ = 0
    RunService_upv_1.PreSimulation:Connect(function() end)
end
function tbl_upv_1.BindStep(a1, a2)
    --[[
      name: BindStep
      line: 2059
      upvalues:
        tbl_upv_19 (copy, index: 1)
        RunService_upv_1 (copy, index: 2)
        u17 (copy, index: 3)
        u36 (ref,  index: 4)
    ]]
    local tbl_upv_20 = {fallback = false, calls = 0}
    tbl_upv_20.fn = a1
    tbl_upv_20.priority = a2
    table.insert(tbl_upv_19, tbl_upv_20)
    table.sort(
        tbl_upv_19,
        function(a3, a4)
            --[[
              line: 2062
            ]]
            return a3.priority < a4.priority
        end
    )
    local success_upv_2, u37 = pcall(
        function()
            --[[
              line: 2065
              upvalues:
                RunService_upv_1 (copy, index: 1)
                tbl_upv_20 (copy, index: 2)
                a1 (copy, index: 3)
                a2 (copy, index: 4)
            ]]
            RunService_upv_1:BindToSimulation(
                function(a5)
                    --[[
                      line: 2066
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
    if success_upv_2 and not u17 then
        return
    end
    task.delay(
        (success_upv_2 and 1.5) or 0,
        function()
            --[[
              line: 2075
              upvalues:
                tbl_upv_20 (copy, index: 1)
                u36 (ref,  index: 2)
                RunService_upv_1 (copy, index: 3)
                tbl_upv_19 (copy, index: 4)
                a2 (copy, index: 5)
                success_upv_2 (copy, index: 6)
                u37 (copy, index: 7)
            ]]
            if tbl_upv_20.calls ~= 0 then
                return
            end
            tbl_upv_20.fallback = true
            if not (u36) then
                u36 = true
                local u38 = 0
                RunService_upv_1.PreSimulation:Connect(
                    function(a6)
                        --[[
                          line: 2046
                          upvalues:
                            u38 (ref,  index: 1)
                            tbl_upv_19 (copy, index: 2)
                        ]]
                        u38 = math.min(u38 + a6, 0.06666666666666667)
                        while u38 >= 0.016666666666666666 do
                            u38 = u38 - 0.016666666666666666
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
                local v206 = (success_upv_2 and "never called") or (tostring(u37))
                warn((("[Simulation] BindToSimulation isn't running the priority-%* step (%*): stepping it from PreSimulation at 60 Hz"):format(a2, v206)))
            end
        end
    )
end
function tbl_upv_1.StepSource()
    --[[
      name: StepSource
      line: 2087
      upvalues:
        tbl_upv_19 (copy, index: 1)
    ]]
    local v207 = false
    local v209 = false
    for _, value_20 in tbl_upv_19 do
        local v210 = v207 or (value_20.calls > 0)
        v210 = v209 or (value_20.fallback)
        v207 = v210
    end
    if v209 then
        return "fallback"
    elseif v207 then
        return "engine"
    else
        return "waiting"
    end
end
local function startRemoteCollisionGuard(a1, a2)
    --[[
      name: startRemoteCollisionGuard
      line: 2143
      upvalues:
        RunService_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    local u39 = 0
    local u40 = nil
    local u41 = {}
    local u42 = 0.25
    RunService_upv_1.Heartbeat:Connect(
        function(a3)
            --[[
              line: 2148
              upvalues:
                u42 (ref,  index: 1)
                a1 (copy, index: 2)
                u40 (ref,  index: 3)
                a2 (copy, index: 4)
                u41 (ref,  index: 5)
            ]]
            u42 = u42 + a3
            if u42 < 0.25 then
                return
            end
            u42 = 0
            local Character_1 = a1.Character
            local v211 = Character_1 and (Character_1:FindFirstChild("HumanoidRootPart"))
            local v212 = not (v211) or not (v211:IsA("BasePart")) or v211
            u40 = v212
            local tbl_21 = {}
            if u40 then
                local Position_6 = u40.Position
                for key_4 in a2 do
                    local HumanoidRootPart_1 = key_4:FindFirstChild("HumanoidRootPart")
                    if key_4 == Character_1 or not (HumanoidRootPart_1) or not (HumanoidRootPart_1:IsA("BasePart")) or (HumanoidRootPart_1.Position - Position_6).Magnitude > 70 then
                        continue
                    end
                    local v213 = key_4:FindFirstChildOfClass("Humanoid")
                    if not (v213) or v213.Health <= 0 or not (HumanoidRootPart_1:FindFirstChild("TribesHull")) then
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
            u41 = tbl_21
        end
    )
    tbl_upv_1.BindStep(
        function()
            --[[
              line: 2180
              upvalues:
                u40 (ref, index: 1)
                u41 (ref, index: 2)
                u39 (ref, index: 3)
            ]]
            if not u40 then
                return
            end
            local Position_7 = u40.Position
            for _, value_22 in u41 do
                if (value_22.root.Position - Position_7).Magnitude > 40 then
                    continue
                end
                local parts_1 = value_22.parts
                for n_3 = 1, #parts_1 do
                    local v214 = parts_1[n_3]
                    if v214.CanCollide then
                        v214.CanCollide = false
                        u39 = u39 + 1
                    end
                end
            end
        end,
        1
    )
    tbl_upv_1.RemoteCollisionFixes = function()
        --[[
          line: 2200
          upvalues:
            u39 (ref, index: 1)
        ]]
        return u39
    end
end
local function predictionOff(a1, a2, a3)
    --[[
      name: predictionOff
      line: 2104
      upvalues:
        RunService_upv_1 (copy, index: 1)
    ]]
    local tbl_upv_23 = {}
    local u43 = a3 or (Enum.PredictionMode.Off)
    for _, value_upv_23 in a1:GetDescendants() do
        local v215 = value_upv_23:IsA("BasePart")
        if v215 then
            pcall(
                function()
                    --[[
                      line: 2109
                      upvalues:
                        RunService_upv_1 (copy, index: 1)
                        value_upv_23 (copy, index: 2)
                        u43 (copy, index: 3)
                    ]]
                    RunService_upv_1:SetPredictionMode(value_upv_23, u43)
                end
            )
        end
    end
    local function off_1(a4)
        --[[
          name: off
          line: 2107
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
                  line: 2118
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
      line: 2277
      upvalues:
        RunService_upv_1 (copy, index: 1)
        Workspace_upv_1 (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
    ]]
    local u44 = RaycastParams.new()
    u44.FilterType = Enum.RaycastFilterType.Exclude
    u44.RespectCanCollide = true
    u44.IgnoreWater = true
    local u45 = nil
    local u46 = nil
    local u47 = false
    local u48 = 0
    local u49 = nil
    local u50 = 0
    local u51 = 0
    local function release_1()
        --[[
          name: release
          line: 2287
          upvalues:
            u49 (ref, index: 1)
        ]]
        u49 = nil
        if not u49 or not u49.Parent or not u49.Anchored then
            return
        end
        u49.Anchored = false
    end
    RunService_upv_1.PreSimulation:Connect(
        function(a2)
            --[[
              line: 2294
              upvalues:
                a1 (copy, index: 1)
                u45 (ref,  index: 2)
                u46 (ref,  index: 3)
                u47 (ref,  index: 4)
                u49 (ref,  index: 5)
                u48 (ref,  index: 6)
                u44 (copy, index: 7)
                Workspace_upv_1 (copy, index: 8)
                u50 (ref,  index: 9)
                u51 (ref,  index: 10)
            ]]
            local Character_2 = a1.Character
            local v216 = Character_2 and (Character_2:FindFirstChild("HumanoidRootPart"))
            if Character_2 and v216 and v216:IsA("BasePart") then
                local Position_8 = v216.Position
                local v217 = v216 ~= u45
                if not (v217) and u46 then
                    v217 = (Position_8 - u46 - (Character_2.AssemblyLinearVelocity * a2)).Magnitude > 20
                end
                if v217 then
                    if u49 and u49 ~= Character_2 then
                        u49 = nil
                    end
                    u47 = true
                    u48 = 0
                end
                u45 = Character_2
                u46 = Position_8
                if not u47 then
                    return
                end
                u48 = u48 + a2
                v217 = Character_2:FindFirstChildOfClass("Humanoid")
                if v217 then
                    local v218 = nil
                    if not (v217.Health <= 0) then
                        u44.FilterDescendantsInstances = {Character_2}
                        v217 = Workspace_upv_1:Raycast(Position_8, Vector3.new(0, -80, 0), u44)
                        local _ = false
                        if (v217 == nil or not (Position_8.Y - v217.Position.Y <= 12)) and (v217 == nil or not (u48 >= 6)) and not (u48 >= 12) then
                            if not (Character_2.Anchored) then
                                Character_2.Anchored = true
                                u49 = Character_2
                                u50 = u50 + 1
                            end
                            if u49 == Character_2 then
                                u51 = u51 + a2
                            end
                            return
                        end
                        u47 = false
                        v218 = u49
                        u49 = nil
                        if v218 and v218.Parent and v218.Anchored then
                            v218.Anchored = false
                        end
                        return
                    end
                end
                u47 = false
                local v219 = u49
                u49 = nil
                if v219 and v219.Parent and v219.Anchored then
                    v219.Anchored = false
                end
                return
            end
            u45 = nil
            u46 = nil
            u47 = false
            u49 = nil
        end
    )
    tbl_upv_1.ArrivalHolds = function()
        --[[
          line: 2342
          upvalues:
            u50 (ref, index: 1)
            u51 (ref, index: 2)
        ]]
        return u50, u51
    end
end
local u52 = false
local function onPlayer(a1)
    --[[
      name: onPlayer
      line: 1872
      upvalues:
        u15 (copy, index: 1)
        Inputs_upv_1 (copy, index: 2)
        register (copy, index: 3)
        unregister (copy, index: 4)
    ]]
    if u15 then
        Inputs_upv_1.Build(a1)
    end
    a1.CharacterAdded:Connect(
        function(a2)
            --[[
              line: 1876
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
      line: 2205
      upvalues:
        predictionOff (copy, index: 1)
        RunService_upv_1 (copy, index: 2)
        Players_upv_1 (copy, index: 3)
        startRemoteCollisionGuard (copy, index: 4)
    ]]
    local CollectionService_1 = game:GetService("CollectionService")
    local u53 = setmetatable({}, {__mode = "k"})
    local u54 = nil
    local v220 = RunService_upv_1:IsStudio()
    local v221 = nil
    if v220 then
        v221 = workspace:GetAttribute("BotPredictionMode")
        if v221 == "On" then
            u54 = Enum.PredictionMode.On
        elseif v221 == "Automatic" then
            u54 = Enum.PredictionMode.Automatic
        end
    end
    local function applyTagged_1(a2)
        --[[
          name: applyTagged
          line: 2228
          upvalues:
            Players_upv_1 (copy, index: 1)
            u54 (ref,  index: 2)
            u53 (copy, index: 3)
            predictionOff (copy, index: 4)
        ]]
        if not a2:IsA("Model") then
            return
        end
        if Players_upv_1:GetPlayerFromCharacter(a2) == nil then
            local v222 = u54
            if not a2:IsA("Model") or (u53[a2]) then
                return
            end
            u53[a2] = true
            predictionOff(a2, function() end, v222)
        end
    end
    for _, value_25 in {"Combatant", "Bot"} do
        CollectionService_1:GetInstanceAddedSignal(value_25):Connect(applyTagged_1)
        for v224, value_26 in CollectionService_1:GetTagged(value_25) do
            if not (value_26:IsA("Model")) or Players_upv_1:GetPlayerFromCharacter(value_26) ~= nil then
                continue
            end
            local v223 = u54
            if not (value_26:IsA("Model")) then
                continue
            end
            if not (u53[value_26]) then
                u53[value_26] = true
                predictionOff(value_26, function() end, v223)
            end
        end
    end
    local function apply_upv_1(a3, a4)
        --[[
          name: apply
          line: 2208
          upvalues:
            u53 (copy, index: 1)
            predictionOff (copy, index: 2)
        ]]
        if not a3:IsA("Model") or (u53[a3]) then
            return
        end
        u53[a3] = true
        predictionOff(a3, function() end, a4)
    end
    local function watchPlayer_1(a5)
        --[[
          name: watchPlayer
          line: 2239
          upvalues:
            a1 (copy, index: 1)
            apply_upv_1 (copy, index: 2)
            u53 (copy, index: 3)
            predictionOff (copy, index: 4)
        ]]
        if a5 == a1 then
            return
        end
        a5.CharacterAdded:Connect(apply_upv_1)
        if a5.Character then
            local Character_3 = a5.Character
            if Character_3:IsA("Model") and not (u53[Character_3]) then
                u53[Character_3] = true
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
        if not (u53[Character_upv_4]) then
            u53[Character_upv_4] = true
            predictionOff(
                Character_upv_4,
                function()
                    --[[
                      line: 2211
                      upvalues:
                        u53 (copy, index: 1)
                        Character_upv_4 (copy, index: 2)
                    ]]
                    u53[Character_upv_4] = nil
                end,
                nil
            )
        end
    end
    if (RunService_upv_1:IsStudio()) and workspace:GetAttribute("RemoteCollideGuardOff") == true then
        return
    end
    startRemoteCollisionGuard(a1, u53)
end
local function watchHold(a1)
    --[[
      name: watchHold
      line: 1980
      upvalues:
        Inputs_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    local tbl_upv_24 = {}
    local function update_upv_1(a2)
        --[[
          name: update
          line: 1982
          upvalues:
            Inputs_upv_1 (copy, index: 1)
            tbl_upv_1 (copy, index: 2)
        ]]
        local v224 = a2:FindFirstChildWhichIsA("Tool")
        local v225
        if v224 then
            v225 = v224:GetAttribute("SlotIndex")
        else
            v225 = nil
        end
        if type(v225) == "number" and v225 == v225 then
            v224 = math.clamp(math.floor(v225 + 0.5), 0, Inputs_upv_1.HOLD_SLOTS)
        else
            v224 = 0
        end
        tbl_upv_1.SetInput("Hold", v224 / Inputs_upv_1.HOLD_SCALE)
    end
    local function onCharacter_1(a3)
        --[[
          name: onCharacter
          line: 1988
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
              line: 1993
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
      line: 1580
      upvalues:
        u15 (copy, index: 1)
        trackCorrection (copy, index: 2)
        u19 (copy, index: 3)
        stepRelay (copy, index: 4)
        stepChar (copy, index: 5)
        tbl_upv_5 (copy, index: 6)
        tbl_upv_10 (copy, index: 7)
    ]]
    local v226 = os.clock()
    if not (u15) then
        trackCorrection(a1)
    end
    local v227
    if u19 then
        v227 = stepRelay
    else
        v227 = stepChar
    end
    for _, value_29 in tbl_upv_5 do
        if value_29.failed then
            continue
        end
        local success_3, v228 = pcall(v227, value_29, a1)
        if not (success_3) then
            value_29.failed = true
            warn((("[Simulation] step failed for %*: %*"):format(value_29.character.Name, v228)))
        end
    end
    local v229 = os.clock() - v226
    tbl_upv_10.steps = tbl_upv_10.steps + 1
    tbl_upv_10.time = tbl_upv_10.time + v229
    if not (tbl_upv_10.maxStep < v229) then
        return
    end
    tbl_upv_10.maxStep = v229
end
function tbl_upv_1.Initialize()
    --[[
      name: Initialize
      line: 2351
      upvalues:
        u52 (ref,  index: 1)
        u15 (copy, index: 2)
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
        u17 (copy, index: 15)
        startArrivalGuard (copy, index: 16)
        WriteGuard_upv_1 (copy, index: 17)
        step (copy, index: 18)
    ]]
    if u52 then
        return
    end
    u52 = true
    if u15 then
        for _, value_30 in Players_upv_1:GetPlayers() do
            onPlayer(value_30)
        end
        Players_upv_1.PlayerAdded:Connect(onPlayer)
        Players_upv_1.PlayerRemoving:Connect(
            function(a1)
                --[[
                  line: 2361
                  upvalues:
                    tbl_upv_4 (copy, index: 1)
                    tbl_upv_5 (copy, index: 2)
                ]]
                if not a1.Character then
                    return
                end
                local Character_5 = a1.Character
                local v230 = tbl_upv_4[Character_5]
                if not v230 then
                    return
                end
                tbl_upv_4[Character_5] = nil
                for _, value_31 in v230.conns do
                    value_31:Disconnect()
                end
                table.clear(tbl_upv_5)
                for _, value_32 in tbl_upv_4 do
                    table.insert(tbl_upv_5, value_32)
                end
            end
        )
        if RunService_upv_1:IsStudio() then
            local v231 = Instance.new("BindableFunction")
            v231.Name = "SimulationDebug"
            v231.OnInvoke = function(a2, a3, a4)
                --[[
                  line: 2370
                  upvalues:
                    tbl_upv_4 (copy, index: 1)
                    tbl_upv_3 (copy, index: 2)
                    tbl_upv_1 (copy, index: 3)
                    tbl_upv_5 (copy, index: 4)
                ]]
                local v232 = a3 and (a3.Character and (tbl_upv_4[a3.Character]))
                if a2 == "state" and v232 then
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
            v231.Parent = game:GetService("ServerStorage")
        end
    else
        local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
        task.spawn(
            function()
                --[[
                  line: 2395
                  upvalues:
                    LocalPlayer_upv_1 (copy, index: 1)
                    Inputs_upv_1 (copy, index: 2)
                    tbl_upv_16 (copy, index: 3)
                    fire (copy, index: 4)
                ]]
                local v233 = LocalPlayer_upv_1:WaitForChild(Inputs_upv_1.CONTEXT, 60)
                if v233 then
                    for _, value_34 in Inputs_upv_1.ACTIONS do
                        local v234 = v233:WaitForChild(value_34.name, 10)
                        local v235 = v234 and (v234:WaitForChild("Script", 10))
                        if not (v235) then
                            continue
                        end
                        if v235:IsA("InputBinding") then
                            tbl_upv_16[value_34.name] = v235
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
        if u17 then
            startArrivalGuard(LocalPlayer_upv_1)
        end
        if RunService_upv_1:IsStudio() and not (u17) then
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