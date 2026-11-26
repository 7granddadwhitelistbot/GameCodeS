local players = game:GetService("Players")
local runService = game:GetService("RunService")
local workspace2 = game:GetService("Workspace")
local parent = script.Parent
local Inputs = require(script:WaitForChild("Inputs"))
local WriteGuard = require(script:WaitForChild("WriteGuard"))
local childName = "Combat"
local child = require(parent:WaitForChild(childName))
local v9 = {Inputs = Inputs}

local function frames(a11)
    --[[
      name: frames
      line: 73
    ]]
    return (math.max(1, (math.floor((a11 * 60) + 0.5))))
end

v9.BASE_SPEED = 21
v9.JUMP_HEIGHT = 7.4
local baseSpeed = v9.BASE_SPEED
local jumpHeight = v9.JUMP_HEIGHT
local moveClassic = runService:IsStudio() and workspace2:GetAttribute("MoveClassic") == true
local v15 = moveClassic and 1 or 0.82
local v16 = moveClassic and 1 or 0.6
local fallGravityMult = moveClassic and 1.3 or 1.1
v9.FALL_GRAVITY_MULT = fallGravityMult
local v18 = 39
local sSlideCd = 48
local sSlideBuf = 15
local sBoost2 = 13
local v22 = 11
local sWet = 45
local childNames = {"HumanoidRootPart", "Head", "UpperTorso", "LowerTorso"}
local v25 = 8
local v26 = 9
local v27 = 7
local v28 = 18
v9.SLIDE_TIME = 0.65
v9.SLIDE_START = 36
local v29 = {"SSpeed", "SSlide", "SSlideDir", "SSlideCD", "SSlideBuf", "SSlideIn", "SSlope", "SLift", "SJumpIn", "SJumpBuf", "SAir", "SJumped", "SJumping", "SGround", "SBoost", "SKb", "SKbF", "SKbN", "SDashV", "SDashF", "SDashCD", "SDashB", "SCharge", "SChargeRel", "SLungeIn", "SHipBase", "SHip", "SFrozen", "SSlow", "SNoJump", "SVel", "SFloat", "STp", "SWade", "SWet", "SPushRise"}
local isServer = runService:IsServer()
local clientAuthority = (function()
    --[[
      name: detectClientAuthority
      line: 271
      upvalues:
        isServer (copy, index: 1)
        workspace2 (copy, index: 2)
    ]]
    if not isServer then
        local tribesAuthority = workspace2:GetAttribute("TribesAuthority")
        local timestamp = os.clock()

        while tribesAuthority == nil and os.clock() - timestamp < 15 do
            task.wait()
            tribesAuthority = workspace2:GetAttribute("TribesAuthority")
        end

        local v34 = tribesAuthority == "Client"
        return v34
    end

    local tribesAuthority
    local tribesAuthorityProbe = Instance.new("Part")
    tribesAuthorityProbe.Name = "TribesAuthorityProbe"
    tribesAuthorityProbe.Size = Vector3.new(1, 1, 1)
    tribesAuthorityProbe.Transparency = 1
    tribesAuthorityProbe.CanCollide = false
    tribesAuthorityProbe.CanQuery = false
    tribesAuthorityProbe.CanTouch = false
    tribesAuthorityProbe.CFrame = CFrame.new(0, 4000, 0)
    tribesAuthorityProbe.Parent = workspace2
    local success = pcall(
        function()
            --[[
              line: 280
              upvalues:
                tribesAuthorityProbe (copy, index: 1)
            ]]
            tribesAuthorityProbe:SetNetworkOwner(nil)
        end
    )
    tribesAuthorityProbe:Destroy()

    if success then
        tribesAuthority = "Client"
    else
        tribesAuthority = "Server"
    end

    workspace2:SetAttribute("TribesAuthority", tribesAuthority)

    return success
end)()
local v38 = isServer and not clientAuthority
local v39 = isServer and clientAuthority
local v40 = not isServer and clientAuthority
v9.JUMP_POWER_MARK = 0
local v41 = nil

function v9.OnForeignWrite(a42)
    --[[
      name: OnForeignWrite
      line: 308
      upvalues:
        v41 (ref, index: 1)
    ]]
    v41 = a42
end

v9.ClientAuthority = clientAuthority
v9.Authority = clientAuthority and "Client" or "Server"
local waterSimOff = runService:IsStudio() and workspace2:GetAttribute("WaterSimOff") == true
local simAuditOff = runService:IsStudio() and workspace2:GetAttribute("SimAuditOff") == true
local v45 = {}
local v46 = {}

local function rebuildList()
    --[[
      name: rebuildList
      line: 323
      upvalues:
        v46 (copy, index: 1)
        v45 (copy, index: 2)
    ]]
    table.clear(v46)

    for _, v49 in v45 do
        table.insert(v46, v49)
    end
end

local function q(a51, a52)
    --[[
      name: q
      line: 330
    ]]
    return math.floor((a51 / a52) + 0.5) * a52
end

local function flat(a54)
    --[[
      name: flat
      line: 334
    ]]
    return (Vector3.new(a54.X, 0, a54.Z))
end

local function approach(a56, a57, a58)
    --[[
      name: approach
      line: 339
    ]]
    local v59 = a57 - a56
    local magnitude = v59.Magnitude

    if magnitude <= a58 then
        return a57
    end

    return a56 + (v59 * (a58 / magnitude))
end

local function jumpProp(a62, gravity: number)
    --[[
      name: jumpProp
      line: 350
      upvalues:
        v16 (copy, index: 1)
        v15 (copy, index: 2)
        clientAuthority (copy, index: 3)
        moveClassic (copy, index: 4)
    ]]
    local v64 = 100 / ((v16 * 2) * gravity)
    local v65 = if a62 <= v64 then math.sqrt(((v16 * 2) * gravity) * a62) else math.sqrt(((v15 * 2) * gravity * (a62 - v64)) + 100)

    if clientAuthority and not moveClassic then
        v65 += ((1 - v15) * gravity) * 0.016666666666666666
    end

    return v65 * v65 / (gravity * 2)
end

local v66 = {SFrozen = true, SSlow = true, SNoJump = true, STp = true}

local function load(a68)
    --[[
      name: load
      line: 369
      upvalues:
        clientAuthority (copy, index: 1)
        v66 (copy, index: 2)
        v29 (copy, index: 3)
    ]]
    local s = a68.s
    local prev = a68.prev
    local root = a68.root

    if clientAuthority then
        for v72 in v66 do
            s[v72] = root:GetAttribute(v72)
        end

        return
    end

    for _, v74 in v29 do
        local v75 = root:GetAttribute(v74)
        s[v74] = v75
        prev[v74] = v75
    end
end

local function save(a77)
    --[[
      name: save
      line: 387
      upvalues:
        clientAuthority (copy, index: 1)
        v29 (copy, index: 2)
        v66 (copy, index: 3)
    ]]
    local s = a77.s
    local prev = a77.prev
    local root = a77.root

    if not clientAuthority then
        for _, v82 in v29 do
            local v83 = s[v82]

            if v83 ~= prev[v82] then
                root:SetAttribute(v82, v83)
            end
        end

        return
    end

    for _, v85 in v29 do
        if not v66[v85] then
            local v86 = s[v85]

            if root:GetAttribute(v85) == v86 then
                continue
            end

            root:SetAttribute(v85, v86)
        end
    end
end

local v87 = {}
local v88 = {Look = true, Facing = true}

local function actionState(a90, actionKey)
    --[[
      name: actionState
      line: 418
      upvalues:
        clientAuthority (copy, index: 1)
        isServer (copy, index: 2)
        v88 (copy, index: 3)
        v87 (copy, index: 4)
    ]]
    if clientAuthority and not isServer and v88[actionKey] then
        return v87[actionKey]
    end

    local action = a90.actions[actionKey]
    if not action then
        return nil
    end

    return action:GetState()
end

local function held(a94, actionKey)
    --[[
      name: held
      line: 429
      upvalues:
        clientAuthority (copy, index: 1)
        isServer (copy, index: 2)
        v88 (copy, index: 3)
        v87 (copy, index: 4)
    ]]
    local v96

    if clientAuthority and not isServer and v88[actionKey] then
        v96 = v87[actionKey]
    else
        v96 = if const action = a94.actions[actionKey] then action:GetState() else nil
    end

    return v96 == true
end

local function finite2(a99)
    --[[
      name: finite2
      line: 433
    ]]
    return typeof(a99) == "Vector2"
        and a99.X == a99.X
        and a99.Y == a99.Y
        and math.abs(a99.X) < 1e+06
        and math.abs(a99.Y) < 1e+06
end

local function lookMove(a101)
    --[[
      name: lookMove
      line: 440
      upvalues:
        clientAuthority (copy, index: 1)
        isServer (copy, index: 2)
        v88 (copy, index: 3)
        v87 (copy, index: 4)
        finite2 (copy, index: 5)
    ]]
    local v102

    if not a101.move then
        return nil
    end

    if clientAuthority and not isServer and v88.Look then
        v102 = v87.Look
    else
        v102 = if const look = a101.actions.Look then look:GetState() else nil
    end

    local v104 = finite2(v102)

    if not v104 or v102.Magnitude < 0.5 or 1.5 < v102.Magnitude then
        return nil
    end

    local v105 = if a101.move then a101.move:GetState() else nil

    if not finite2(v105) then
        return Vector3.new(0, 0, 0)
    end

    local unit = v102.Unit
    local vector3 = Vector3.new((unit.X * v105.Y) - (unit.Y * v105.X), 0, unit.Y * v105.Y + (unit.X * v105.X))

    if 1 < vector3.Magnitude then
        vector3 = vector3.Unit
    end

    return vector3
end

local function toolInSlot(a109, holdSlot: number)
    --[[
      name: toolInSlot
      line: 469
    ]]
    local holdTool = a109.holdTool
    local backpack = a109.player:FindFirstChild("Backpack")

    if a109.holdSlot == holdSlot
        and holdTool
        and (holdTool:IsDescendantOf(a109.character) or backpack ~= nil and holdTool:IsDescendantOf(backpack))
        and holdTool:GetAttribute("SlotIndex") == holdSlot
    then
        return holdTool
    end

    a109.holdSlot = holdSlot
    a109.holdTool = nil

    if holdSlot <= 0 then
        return nil
    end

    for _, v114 in {a109.character, backpack} do
        if v114 then
            for _, holdTool2 in v114:GetChildren() do
                if holdTool2:GetAttribute("SlotIndex") == holdSlot and holdTool2:GetAttribute("WeaponId") ~= nil then
                    a109.holdTool = holdTool2
                    return holdTool2
                end
            end
        end
    end

    return nil
end

local v117 = 45

local function heldWeapon(a119)
    --[[
      name: heldWeapon
      line: 499
      upvalues:
        clientAuthority (copy, index: 1)
        isServer (copy, index: 2)
        v88 (copy, index: 3)
        v87 (copy, index: 4)
        Inputs (copy, index: 5)
        toolInSlot (copy, index: 6)
        v38 (copy, index: 7)
        v117 (copy, index: 8)
    ]]
    local v120
    local v121
    local tool = a119.character:FindFirstChildWhichIsA("Tool")

    if a119.actions.Hold then
        if clientAuthority and not isServer and v88.Hold then
            v120 = v87.Hold
        else
            v120 = if const hold = a119.actions.Hold then hold:GetState() else nil
        end
    else
        v120 = nil
    end

    if type(v120) ~= "number" then
        v121 = tool
    elseif v120 ~= v120 then
        v121 = tool
    else
        local clampedValue = math.clamp(math.floor((v120 * Inputs.HOLD_SCALE) + 0.5), 0, Inputs.HOLD_SLOTS)
        local v125 = toolInSlot(a119, clampedValue)
        v121 = v125

        if v38 then
            if v125 == tool then
                a119.holdBad = 0
            else
                a119.holdBad += 1

                if v117 < a119.holdBad then
                    v121 = tool
                end
            end
        end
    end

    local v126 = if v121 then v121:GetAttribute("WeaponId") else nil

    if type(v126) ~= "string" then
        return nil
    end

    return v126
end

local function hipTarget(a128, a129)
    --[[
      name: hipTarget
      line: 522
    ]]
    local sHipBase = a128.SHipBase

    if type(sHipBase) ~= "number" then
        return nil
    end

    local v131

    if a128.SSlide == nil then
        v131 = sHipBase
    else
        v131 = math.max(0.3, sHipBase - 1.4)
        local sLift = a128.SLift

        if type(sLift) == "number" and v131 < sLift then
            v131 = sLift
        end
    end

    if a129 then
        if v131 < a129 then
            return a129
        end
    end

    return v131
end

local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Include
raycastParams.FilterDescendantsInstances = {workspace2.Terrain}
raycastParams.IgnoreWater = false

local function probeWater(a135, a136)
    --[[
      name: probeWater
      line: 552
      upvalues:
        waterSimOff (copy, index: 1)
        workspace2 (copy, index: 2)
        raycastParams (copy, index: 3)
    ]]
    if waterSimOff then
        return 0, nil, nil, nil
    end

    local root = a135.root
    local position = root.Position
    local v139 = root.Size.Y * 0.5
    local raycastResult = workspace2:Raycast(Vector3.new(position.X, position.Y + 16, position.Z), Vector3.new(0, -(((a136 + 16) + v139) + 0.5), 0), raycastParams)

    if not raycastResult or raycastResult.Material ~= Enum.Material.Water then
        return 0, nil, nil, nil
    end

    local v141
    local y = raycastResult.Position.Y
    local raycastResult2 = workspace2:Raycast(position, Vector3.new(0, -40, 0), a135.ray)
    if not raycastResult2 then
        return 1, nil, nil, nil
    end

    local y2 = raycastResult2.Position.Y
    local v145 = y - y2
    local v146 = a136 + v139 + 0.6
    local clampedValue = math.clamp((v145 - 0.4) / (v146 - 0.4), 0, 1)
    local v148 = (y - 0.6) - y2 - v139
    local v149 = math.floor((clampedValue / 0.01) + 0.5) * 0.01

    if a136 < v148 then
        v141 = math.floor((v148 / 0.001) + 0.5) * 0.001
    else
        v141 = nil
    end

    return v149, v141, y2, y - 0.6
end

local function probeBank(a151, unit: Vector3, a153, a154)
    --[[
      name: probeBank
      line: 584
      upvalues:
        workspace2 (copy, index: 1)
    ]]
    local v155 = a151.root.Position + unit * 2
    local y = a154 + (a153 * 2) + 2.5
    local raycastResult = workspace2:Raycast(Vector3.new(v155.X, y, v155.Z), Vector3.new(0, -((y - a154) + 1), 0), a151.ray)
    if not raycastResult then
        return nil
    end

    local v158 = raycastResult.Position.Y - a154
    local v159 = a153 + 0.5
    local v160 = math.min(v158, v159) * math.clamp((v159 + 1) - v158, 0, 1)

    if not (v160 <= 0.01) then
        return math.floor(((a153 + v160) / 0.001) + 0.5) * 0.001
    end

    return nil
end

local function endSlide(a162)
    --[[
      name: endSlide
      line: 601
      upvalues:
        sSlideCd (copy, index: 1)
    ]]
    if a162.SSlide == nil then
        return
    end

    a162.SSlide = nil
    a162.SSlideDir = nil
    a162.SSlope = nil
    a162.SLift = nil
    a162.SSlideCD = sSlideCd
    a162.SSpeed = math.max(a162.SSpeed, 17)
end

local function tryStartSlide(s, humanoid, a166, assemblyLinearVelocity, isNotAir: boolean)
    --[[
      name: tryStartSlide
      line: 613
    ]]
    if s.SSlide ~= nil or s.SSlideCD ~= nil or not isNotAir then
        return false
    end
    if Vector3.new(assemblyLinearVelocity.X, 0, assemblyLinearVelocity.Z).Magnitude < 11
        or a166.Magnitude < 0.2
    then
        return false
    end

    local unit = Vector3.new(a166.X, 0, a166.Z).Unit
    s.SSlide = 0
    s.SSlideDir = Vector3.new(math.floor((unit.X / 1e-04) + 0.5) * 1e-04, 0, math.floor((unit.Z / 1e-04) + 0.5) * 1e-04)
    s.SSlideBuf = nil
    s.SSpeed = 36

    if type(s.SHipBase) ~= "number" then
        s.SHipBase = math.floor((humanoid.HipHeight / 0.001) + 0.5) * 0.001
    end

    return true
end

local function probeGround(a171, vector3: Vector3, a173, magnitude: number, a175, a176)
    --[[
      name: probeGround
      line: 638
      upvalues:
        workspace2 (copy, index: 1)
    ]]
    local root = a171.root
    local position = root.Position
    local raycastResult = workspace2:Raycast(position, Vector3.new(0, -((a175 + (root.Size.Y * 0.5)) + 1.5), 0), a171.ray)
    if not raycastResult then
        return nil, nil
    end

    local v180 = nil
    local normal = raycastResult.Normal

    if 0.5 <= normal.Y then
        v180 = math.clamp(a173 * ((normal.X * vector3.X + (normal.Z * vector3.Z)) / normal.Y), -12, 12) * 0.6
    end

    local y = raycastResult.Position.Y
    local v183 = if a171.hull then a171.hull.Size.Y * 0.5 else root.Size.Z * 0.5
    local v184 = (magnitude * 0.16) + v183 + 0.1

    if const raycastResult2 = workspace2:Raycast(Vector3.new(position.X, y + 0.25, position.Z), vector3 * v184, a171.ray) then
        if not (0.3 < raycastResult2.Normal.Y) then
            local v186 = raycastResult2.Position + vector3 * 0.3
            local raycastResult3 = workspace2:Raycast(Vector3.new(v186.X, (y + a176) + 0.3, v186.Z), Vector3.new(0, -((a176 + 0.3) - 0.25), 0), a171.ray)

            if not raycastResult3 or raycastResult3.Normal.Y < 0.7 then
                return v180, nil
            end

            local v188 = raycastResult3.Position.Y - y

            if v188 < 0.25 or a176 < v188 then
                return v180, nil
            end

            return v180, v188 + 0.35
        end
    end

    return v180, nil
end

local function slideCushion(a190, y, a192, a193: number?)
    --[[
      name: slideCushion
      line: 678
      upvalues:
        workspace2 (copy, index: 1)
    ]]
    if -12 <= y then
        return nil
    end

    local root = a190.root
    local position = root.Position
    local v196 = a192 + root.Size.Y * 0.5
    local raycastResult = workspace2:Raycast(position, Vector3.new(0, -(v196 + (a193 or 2.5)), 0), a190.ray)

    if not raycastResult or raycastResult.Normal.Y < 0.5 then
        return nil
    end

    local v198 = math.max(((position.Y - raycastResult.Position.Y) - v196) - 0.5, 0.05)
    local v199 = ((y * y) - 144) / (v198 * 2)

    if not (v199 < 350) then
        return (math.min(v199, 900))
    end

    return nil
end

local function resetMotion(a201)
    --[[
      name: resetMotion
      line: 697
      upvalues:
        baseSpeed (copy, index: 1)
    ]]
    a201.SSlide = nil
    a201.SSlideDir = nil
    a201.SSlideBuf = nil
    a201.SSlope = nil
    a201.SLift = nil
    a201.SKb = nil
    a201.SKbF = nil
    a201.SKbN = nil
    a201.SDashV = nil
    a201.SDashF = nil
    a201.SDashB = nil
    a201.SPushRise = nil
    a201.SBoost = nil
    a201.SJumpBuf = nil
    a201.SVel = nil
    a201.SFloat = nil
    a201.SSpeed = baseSpeed
end

local function fin(a203)
    --[[
      name: fin
      line: 715
    ]]
    return a203 == a203 and -1e+07 < a203 and (a203 < 1e+07)
end

local function fin3(a205)
    --[[
      name: fin3
      line: 718
    ]]
    local x = a205.X
    local v207 = x == x and -1e+07 < x and x < 1e+07
    if v207 then
        local y = a205.Y
        v207 = y == y and -1e+07 < y and y < 1e+07

        if v207 then
            local z = a205.Z
            return z == z and -1e+07 < z and z < 1e+07
        end
    end

    return v207
end

local function finCF(a211)
    --[[
      name: finCF
      line: 724
    ]]
    local position = a211.Position
    local v213 = false

    if position.X == position.X then
        v213 = false

        if position.Y == position.Y then
            v213 = false

            if position.Z == position.Z then
                v213 = false

                if math.abs(position.X) < 2e+05 then
                    v213 = false

                    if math.abs(position.Y) < 2e+05 then
                        v213 = false

                        if math.abs(position.Z) < 2e+05 then
                            local lookVector = a211.LookVector
                            local x = lookVector.X
                            v213 = x == x and -1e+07 < x and x < 1e+07

                            if v213 then
                                local y = lookVector.Y
                                v213 = y == y and -1e+07 < y and y < 1e+07

                                if v213 then
                                    local z = lookVector.Z
                                    v213 = z == z and -1e+07 < z and z < 1e+07
                                end
                            end

                            if v213 then
                                local upVector = a211.UpVector
                                local x2 = upVector.X
                                v213 = x2 == x2 and -1e+07 < x2 and x2 < 1e+07

                                if v213 then
                                    local y = upVector.Y
                                    v213 = y == y and -1e+07 < y and y < 1e+07

                                    if v213 then
                                        local z = upVector.Z
                                        return z == z and -1e+07 < z and z < 1e+07
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    return v213
end

local v222 = {}

local function sayNaN(key)
    --[[
      name: sayNaN
      line: 730
      upvalues:
        v222 (copy, index: 1)
        clientAuthority (copy, index: 2)
        isServer (copy, index: 3)
    ]]
    if v222[key] then
        return
    end

    v222[key] = true
    local warn = warn
    local v226 = clientAuthority and "Client" or "Server"
    local v227 = isServer and "server" or "client"
    warn((`[SimNaN] {key} auth={v226} side={v227}`))
end

local function recoverRoot(a229)
    --[[
      name: recoverRoot
      line: 737
      upvalues:
        baseSpeed (copy, index: 1)
    ]]
    local root = a229.root
    local s = a229.s
    local push = a229.push
    local align = a229.align
    local gravity = a229.gravity

    if push then
        push.PlaneVelocity = Vector2.zero
        push.Enabled = false
    end

    if align then
        align.Enabled = false
        align.CFrame = CFrame.identity
    end

    if gravity then
        gravity.Force = Vector3.new(0, 0, 0)
        gravity.Enabled = false
    end

    if const goodCf = a229.goodCF then
        root.CFrame = goodCf
    end

    root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
    s.SSlide = nil
    s.SSlideDir = nil
    s.SSlideBuf = nil
    s.SSlope = nil
    s.SLift = nil
    s.SKb = nil
    s.SKbF = nil
    s.SKbN = nil
    s.SDashV = nil
    s.SDashF = nil
    s.SDashB = nil
    s.SPushRise = nil
    s.SBoost = nil
    s.SJumpBuf = nil
    s.SVel = nil
    s.SFloat = nil
    s.SSpeed = baseSpeed
end

local function stepCollisions(a237, a238: boolean)
    --[[
      name: stepCollisions
      line: 762
      upvalues:
        simAuditOff (copy, index: 1)
    ]]
    local hull = a237.hull

    if not hull or simAuditOff then
        return
    end

    if a238 then
        local body = a237.body

        for index = 1, #body do
            local v242 = body[index]

            if v242.CanCollide then
                v242.CanCollide = false
            end
        end

        if not hull.CanCollide then
            hull.CanCollide = true
        end
    else
        local corpse = a237.corpse

        for index = 1, #corpse do
            local v245 = corpse[index]

            if not v245.CanCollide then
                v245.CanCollide = true
            end
        end

        if hull.CanCollide then
            hull.CanCollide = false
        end
    end
end

local function startKnockback(a247, a248, a249)
    --[[
      name: startKnockback
      line: 797
      upvalues:
        v222 (copy, index: 1)
        clientAuthority (copy, index: 2)
        isServer (copy, index: 3)
        sSlideCd (copy, index: 4)
    ]]
    local humanoid = a247.humanoid
    local root = a247.root
    local s = a247.s
    local x = a248.X
    local v254 = x == x and -1e+07 < x and x < 1e+07
    if v254 then
        local y = a248.Y
        v254 = y == y and -1e+07 < y and y < 1e+07

        if v254 then
            local z = a248.Z
            v254 = z == z and -1e+07 < z and z < 1e+07
        end
    end

    if not v254 then
        if v222.knockback then
            return
        end

        v222.knockback = true
        local warn = warn
        local v258 = clientAuthority and "Client" or "Server"
        local v259 = isServer and "server" or "client"
        warn((`[SimNaN] knockback auth={v258} side={v259}`))

        return
    end

    if a249 ~= nil and (a249 ~= a249 or not (-1e+07 < a249) or not (a249 < 1e+07)) then
        a249 = nil
    end

    local sKb = Vector3.new(a248.X, 0, a248.Z)

    if 90 < sKb.Magnitude then
        sKb = sKb.Unit * 90
    end

    if 1 <= sKb.Magnitude then
        if s.SSlide ~= nil then
            s.SSlide = nil
            s.SSlideDir = nil
            s.SSlope = nil
            s.SLift = nil
            s.SSlideCD = sSlideCd
            s.SSpeed = math.max(s.SSpeed, 17)
        end

        local v261 = math.max(1, (math.floor((math.clamp((a249 or 0.35), 0.05, 1) * 60) + 0.5)))
        s.SKb, s.SKbF = sKb, v261
        s.SKbN = v261
        s.SDashV = nil
        s.SDashF = nil
    end

    if 8 < a248.Y then
        local assemblyLinearVelocity = root.AssemblyLinearVelocity
        root.AssemblyLinearVelocity = Vector3.new(assemblyLinearVelocity.X, math.max(assemblyLinearVelocity.Y, math.min(a248.Y, 40) * 0.8), assemblyLinearVelocity.Z)
        humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
    end
end

local function stepRelay(a264, a265)
    --[[
      name: stepRelay
      line: 827
      upvalues:
        stepCollisions (copy, index: 1)
    ]]
    local humanoid = a264.humanoid
    local root = a264.root
    local state = humanoid:GetState()
    local v269 = state ~= Enum.HumanoidStateType.Dead and 0 < humanoid.Health
    stepCollisions(a264, v269)
    local sFrozen = a264.frozen and true or nil

    if root:GetAttribute("SFrozen") ~= sFrozen then
        root:SetAttribute("SFrozen", sFrozen)
    end

    local sSlow = if a264.slow ~= 1 then math.floor((a264.slow / 0.001) + 0.5) * 0.001 else nil

    if root:GetAttribute("SSlow") ~= sSlow then
        root:SetAttribute("SSlow", sSlow)
    end

    local sNoJump = a264.noJump and true or nil

    if root:GetAttribute("SNoJump") ~= sNoJump then
        root:SetAttribute("SNoJump", sNoJump)
    end

    local pending = a264.pending

    if pending.tp then
        local sTp
        local v275 = pending.tp
        pending.tp = nil
        a264.character:PivotTo(v275)
        root:SetAttribute("STpCF", v275)
        local sTp2 = root:GetAttribute("STp")

        if type(sTp2) ~= "number" then
            sTp = 0
        else
            sTp = sTp2
        end

        root:SetAttribute("STp", sTp + 1)
    end

    if pending.kb and v269 then
        local nKbSeq
        local nKbSeq2 = root:GetAttribute("NKbSeq")
        root:SetAttribute("NKb", pending.kb)
        root:SetAttribute("NKbDur", pending.kbDur)

        if type(nKbSeq2) ~= "number" then
            nKbSeq = 0
        else
            nKbSeq = nKbSeq2
        end

        root:SetAttribute("NKbSeq", nKbSeq + 1)
    end

    pending.kb = nil
    pending.kbDur = nil
end

local function stepChar(a280, a281)
    --[[
      name: stepChar
      line: 866
      upvalues:
        load (copy, index: 1)
        finCF (copy, index: 2)
        v222 (copy, index: 3)
        clientAuthority (copy, index: 4)
        isServer (copy, index: 5)
        baseSpeed (copy, index: 6)
        save (copy, index: 7)
        stepCollisions (copy, index: 8)
        v38 (copy, index: 9)
        startKnockback (copy, index: 10)
        v40 (copy, index: 11)
        v41 (ref,  index: 12)
        v9 (copy, index: 13)
        waterSimOff (copy, index: 14)
        v88 (copy, index: 15)
        v87 (copy, index: 16)
        simAuditOff (copy, index: 17)
        lookMove (copy, index: 18)
        heldWeapon (copy, index: 19)
        child (copy, index: 20)
        probeWater (copy, index: 21)
        probeBank (copy, index: 22)
        sWet (copy, index: 23)
        v26 (copy, index: 24)
        v27 (copy, index: 25)
        v28 (copy, index: 26)
        sSlideCd (copy, index: 27)
        sBoost2 (copy, index: 28)
        tryStartSlide (copy, index: 29)
        sSlideBuf (copy, index: 30)
        v18 (copy, index: 31)
        probeGround (copy, index: 32)
        v22 (copy, index: 33)
        moveClassic (copy, index: 34)
        jumpProp (copy, index: 35)
        jumpHeight (copy, index: 36)
        workspace2 (copy, index: 37)
        v25 (copy, index: 38)
        v15 (copy, index: 39)
        v16 (copy, index: 40)
        fallGravityMult (copy, index: 41)
        slideCushion (copy, index: 42)
    ]]
    do
        local humanoid = a280.humanoid
        local root = a280.root
        local s = a280.s
        load(a280)
        local cFrame = root.CFrame

        if not finCF(cFrame) then
            do
                local v286 = a280.goodCF and "root" or "root (no last place)"

                if not v222[v286] then
                    v222[v286] = true

                    local warn = warn
                    local v288 = clientAuthority and "Client" or "Server"
                    local v289 = isServer and "server" or "client"
                    warn((`[SimNaN] {v286} auth={v288} side={v289}`))
                end
            end

            do
                local root2 = a280.root
                local s2 = a280.s
                local push = a280.push
                local align = a280.align
                local gravity = a280.gravity

                if push then
                    push.PlaneVelocity = Vector2.zero
                    push.Enabled = false
                end

                if align then
                    align.Enabled = false
                    align.CFrame = CFrame.identity
                end

                if gravity then
                    gravity.Force = Vector3.new(0, 0, 0)
                    gravity.Enabled = false
                end

                do
                    if const goodCf = a280.goodCF then
                        root2.CFrame = goodCf
                    end
                end

                root2.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                root2.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                s2.SSlide = nil
                s2.SSlideDir = nil
                s2.SSlideBuf = nil
                s2.SSlope = nil
                s2.SLift = nil
                s2.SKb = nil
                s2.SKbF = nil
                s2.SKbN = nil
                s2.SDashV = nil
                s2.SDashF = nil
                s2.SDashB = nil
                s2.SPushRise = nil
                s2.SBoost = nil
                s2.SJumpBuf = nil
                s2.SVel = nil
                s2.SFloat = nil
                s2.SSpeed = baseSpeed
                save(a280)

                return
            end
        end

        a280.goodCF = cFrame

        do
            local state = humanoid:GetState()
            local isNotDead = state ~= Enum.HumanoidStateType.Dead
            stepCollisions(a280, isNotDead)

            if v38 then
                s.SFrozen = a280.frozen and true or nil
                s.SSlow = if a280.slow ~= 1 then math.floor((a280.slow / 0.001) + 0.5) * 0.001 else nil
                s.SNoJump = a280.noJump and true or nil

                local pending = a280.pending

                if pending.tp then
                    local sTp

                    do
                        local tp = pending.tp
                        pending.tp = nil
                        a280.character:PivotTo(tp)
                    end

                    root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    s.SSlide = nil
                    s.SSlideDir = nil
                    s.SSlideBuf = nil
                    s.SSlope = nil
                    s.SLift = nil
                    s.SKb = nil
                    s.SKbF = nil
                    s.SKbN = nil
                    s.SDashV = nil
                    s.SDashF = nil
                    s.SDashB = nil
                    s.SPushRise = nil
                    s.SBoost = nil
                    s.SJumpBuf = nil
                    s.SVel = nil
                    s.SFloat = nil
                    s.SSpeed = baseSpeed

                    if type(s.STp) ~= "number" then
                        sTp = 0
                    else
                        sTp = s.STp
                    end

                    s.STp = sTp + 1
                end

                if pending.kb and isNotDead then
                    startKnockback(a280, pending.kb, pending.kbDur)
                end

                pending.kb = nil
                pending.kbDur = nil
            elseif clientAuthority then
                do
                    local sTp = s.STp

                    if sTp ~= a280.tpSeen then
                        a280.tpSeen = sTp

                        do
                            local sTpCf = root:GetAttribute("STpCF")

                            if typeof(sTpCf) == "CFrame"
                                and finCF(sTpCf)
                                and 30 < (root.Position - sTpCf.Position).Magnitude
                            then
                                a280.character:PivotTo(sTpCf)
                            end
                        end

                        root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                        s.SSlide = nil
                        s.SSlideDir = nil
                        s.SSlideBuf = nil
                        s.SSlope = nil
                        s.SLift = nil
                        s.SKb = nil
                        s.SKbF = nil
                        s.SKbN = nil
                        s.SDashV = nil
                        s.SDashF = nil
                        s.SDashB = nil
                        s.SPushRise = nil
                        s.SBoost = nil
                        s.SJumpBuf = nil
                        s.SVel = nil
                        s.SFloat = nil
                        s.SSpeed = baseSpeed
                    end
                end

                local nKbSeq = root:GetAttribute("NKbSeq")

                if nKbSeq ~= a280.kbSeen then
                    a280.kbSeen = nKbSeq

                    local nKb = root:GetAttribute("NKb")

                    if isNotDead and typeof(nKb) == "Vector3" and nKb == nKb then
                        local nKbDur

                        do
                            local nKbDur2 = root:GetAttribute("NKbDur")

                            if type(nKbDur2) ~= "number" then
                                nKbDur = nil
                            else
                                nKbDur = nKbDur2
                            end
                        end

                        startKnockback(a280, nKb, nKbDur)
                    end
                end
            end

            local v307 = v40 and a280.watchFrom <= os.clock()

            if v307 and v41 and (humanoid.UseJumpPower or humanoid.JumpPower ~= v9.JUMP_POWER_MARK) then
                do
                    do
                        local v308 = v41
                        local v309 = humanoid.UseJumpPower and "UseJumpPower" or "JumpPower"
                        v308(v309)
                    end
                end
            end

            if humanoid.UseJumpPower then
                humanoid.UseJumpPower = false
            end

            if humanoid:GetStateEnabled(Enum.HumanoidStateType.FallingDown) then
                humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
            end

            if humanoid:GetStateEnabled(Enum.HumanoidStateType.Ragdoll) then
                humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
            end

            if humanoid:GetStateEnabled(Enum.HumanoidStateType.Swimming) ~= waterSimOff then
                humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, waterSimOff)
            end

            if not isNotDead then
                s.SSlide = nil
                s.SSlideDir = nil
                s.SSlideBuf = nil
                s.SSlope = nil
                s.SLift = nil
                s.SKb = nil
                s.SKbF = nil
                s.SKbN = nil
                s.SDashV = nil
                s.SDashF = nil
                s.SDashB = nil
                s.SPushRise = nil
                s.SBoost = nil
                s.SJumpBuf = nil
                s.SVel = nil
                s.SFloat = nil
                s.SSpeed = baseSpeed

                if a280.push and a280.push.Enabled then
                    a280.push.Enabled = false
                end

                if a280.align and a280.align.Enabled then
                    a280.align.Enabled = false
                end

                if a280.gravity and a280.gravity.Enabled then
                    a280.gravity.Enabled = false
                end

                save(a280)

                return
            end

            local sSlow
            local v311
            local v312
            local v313
            local v314
            local v315
            local v316
            local v317
            local v318
            local v319
            local v320
            local v321
            local v322, v323
            local v324
            local v325, v326, v327, v328

            do
                local vector3
                local v330
                local v331
                local v332
                local v333

                do
                    local sFrozen = s.SFrozen == true

                    if type(s.SSlow) ~= "number" then
                        sSlow = 1
                    else
                        sSlow = s.SSlow
                    end

                    local v335 = s.SNoJump == true or sSlow <= 0.001

                    if type(s.SSpeed) ~= "number" then
                        v311 = baseSpeed
                    else
                        v311 = s.SSpeed
                    end

                    if clientAuthority and not isServer and v88.Slide then
                        v312 = v87.Slide
                    else
                        v312 = if const slide = a280.actions.Slide then slide:GetState() else nil
                    end

                    local v337 = v312 == true

                    if clientAuthority and not isServer and v88.Jump then
                        v313 = v87.Jump
                    else
                        v313 = if const jump = a280.actions.Jump then jump:GetState() else nil
                    end

                    local v339 = v313 == true

                    if clientAuthority and not isServer and v88.Aim then
                        v314 = v87.Aim
                    else
                        v314 = if const aim = a280.actions.Aim then aim:GetState() else nil
                    end

                    local v341 = v314 == true

                    if clientAuthority and not isServer and v88.Charge then
                        v315 = v87.Charge
                    else
                        v315 = if const charge = a280.actions.Charge then charge:GetState() else nil
                    end

                    local v343 = v315 == true

                    if clientAuthority and not isServer and v88.Block then
                        v316 = v87.Block
                    else
                        v316 = if const block = a280.actions.Block then block:GetState() else nil
                    end

                    local v345 = v316 == true

                    if clientAuthority and not isServer and v88.Reload then
                        v317 = v87.Reload
                    else
                        v317 = if const reload = a280.actions.Reload then reload:GetState() else nil
                    end

                    local v347 = v317 == true

                    if clientAuthority and not isServer and v88.Use then
                        v318 = v87.Use
                    else
                        v318 = if const use = a280.actions.Use then use:GetState() else nil
                    end

                    local v349 = v318 == true

                    if clientAuthority and not isServer and v88.Lunge then
                        v319 = v87.Lunge
                    else
                        v319 = if const lunge = a280.actions.Lunge then lunge:GetState() else nil
                    end

                    local v351 = v319 == true

                    do
                        local v352 = nil

                        if clientAuthority and not isServer and v88.Facing then
                            v320 = v87.Facing
                        else
                            v320 = if const facing = a280.actions.Facing then facing:GetState() else nil
                        end

                        if typeof(v320) ~= "Vector2" then
                            v321 = v352
                        elseif v320.X ~= v320.X then
                            v321 = v352
                        elseif v320.Y ~= v320.Y then
                            v321 = v352
                        elseif not (0.5 < v320.Magnitude) then
                            v321 = v352
                        else
                            v321 = if v320.Magnitude < 1.5 then v320.Unit else v352
                        end
                    end

                    local v354 = humanoid.MoveDirection

                    if const vector32 = if simAuditOff then nil else lookMove(a280) then
                        humanoid:Move(vector32, false)
                        v354 = vector32
                    elseif not a280.moveWrote or not ((v354 - a280.moveWrote).Magnitude < 1e-04) then
                        a280.moveIntent = v354
                    else
                        v354 = a280.moveIntent
                    end

                    local v356 = heldWeapon(a280)

                    if simAuditOff then
                        local v358 = if const tool = a280.character:FindFirstChildWhichIsA("Tool") then tool:GetAttribute("WeaponId") else nil

                        if type(v358) ~= "string" then
                            v356 = nil
                        else
                            v356 = v358
                        end
                    end

                    v322, v323 = child.MoveSpeed(v356, v341, v343, v345, v347, v349)

                    if not simAuditOff then
                        if type(s.SHipBase) == "number" then
                            if (isServer or clientAuthority)
                                and a280.hipWritten
                                and 0.002 < math.abs(humanoid.HipHeight - a280.hipWritten)
                            then
                                s.SHipBase = math.floor((humanoid.HipHeight / 0.001) + 0.5) * 0.001
                                s.SHip = nil
                            end
                        else
                            s.SHipBase = math.floor((humanoid.HipHeight / 0.001) + 0.5) * 0.001
                        end
                    end

                    if type(s.SHipBase) ~= "number" then
                        v324 = humanoid.HipHeight
                    else
                        v324 = s.SHipBase
                    end

                    v325, v326, v327, v328 = probeWater(a280, v324)
                    s.SWade = if 0 < v325 then v325 else nil
                    local v359 = v322 * sSlow * (1 - (v325 * 0.4))

                    if 0.3 < v325 then
                        v323 = true
                    end

                    if sSlow <= 0.42 then
                        v323 = true
                    end

                    local isNotAir = humanoid.FloorMaterial ~= Enum.Material.Air
                    local assemblyLinearVelocity = root.AssemblyLinearVelocity
                    local v362 = not isNotAir
                        or state == Enum.HumanoidStateType.Jumping
                        or state == Enum.HumanoidStateType.Freefall

                    do
                        local v363 = v362
                            and (state == Enum.HumanoidStateType.Jumping or 0 < assemblyLinearVelocity.Y)

                        if v326 then
                            if v363 then
                                v326 = nil
                            elseif v362 then
                                local y = root.Position.Y

                                if v328 + 0.05 < y then
                                    v326 = nil
                                end
                            end
                        end
                    end

                    local v365 = v326

                    if v327 and not v362 and s.SSlide == nil then
                        local vector33 = Vector3.new(v354.X, 0, v354.Z)

                        if 0.3 < vector33.Magnitude then
                            local v367 = probeBank(a280, vector33.Unit, v324, v327)

                            if v367 and (v365 == nil or v365 < v367) then
                                v365 = v367
                            end
                        end
                    end

                    if v365 then
                        s.SWet = sWet

                        if type(s.SHipBase) ~= "number" then
                            s.SHipBase = math.floor((humanoid.HipHeight / 0.001) + 0.5) * 0.001
                        end
                    elseif s.SWet ~= nil then
                        s.SWet = if 1 < s.SWet then s.SWet - 1 else nil
                    end

                    local v368 = isNotAir and s.SGround ~= true
                    s.SGround = isNotAir and true or nil
                    local v369 = isNotAir and 0 or math.min((s.SAir or 0) + 1, 600)
                    s.SAir = if 0 < v369 then v369 else nil
                    local isJumping = state == Enum.HumanoidStateType.Jumping
                    local v371 = isJumping and s.SJumping ~= true
                    s.SJumping = isJumping and true or nil

                    if isJumping then
                        s.SJumped = true
                    elseif isNotAir then
                        s.SJumped = nil
                    end

                    if type(s.SFloat) ~= "number" then
                        if s.SFloat ~= nil and isNotAir and (assemblyLinearVelocity.Y < 1 or v368) then
                            s.SFloat = nil
                        end
                    elseif 5 < assemblyLinearVelocity.Y or not isNotAir then
                        s.SFloat = true
                    elseif not (4 <= s.SFloat) then
                        s.SFloat += 1
                    else
                        s.SFloat = nil
                    end

                    s.SSlideCD = if 1 < (s.SSlideCD or 0) then s.SSlideCD - 1 else nil
                    s.SSlideBuf = if 1 < (s.SSlideBuf or 0) then s.SSlideBuf - 1 else nil
                    s.SDashCD = if 1 < (s.SDashCD or 0) then s.SDashCD - 1 else nil

                    do
                        if const dashCd = a280.dashCd then
                            for v373, v374 in dashCd do
                                dashCd[v373] = if 1 < v374 then v374 - 1 else nil
                            end
                        end
                    end

                    local sJumpBuf = s.SJumpBuf or 0
                    local v376 = math.max(sJumpBuf - 1, 0)

                    if v339 and s.SJumpIn ~= true then
                        v376 = v26
                    end

                    if v368 and 0 < v376 then
                        v376 = math.max(v376, v27)
                    end

                    s.SJumpIn = v339 and true or nil

                    if v343 then
                        do
                            local sCharge = s.SCharge or 0
                            s.SCharge = math.min(sCharge + 1, 600)
                        end

                        s.SChargeRel = nil
                    elseif s.SCharge then
                        local sChargeRel = (s.SChargeRel or 0) + 1

                        if v28 < sChargeRel then
                            s.SCharge = nil
                            s.SChargeRel = nil
                        else
                            s.SChargeRel = sChargeRel
                        end
                    end

                    if v371 then
                        v376 = 0

                        if s.SSlide ~= nil then
                            if s.SSlide ~= nil then
                                s.SSlide = nil
                                s.SSlideDir = nil
                                s.SSlope = nil
                                s.SLift = nil
                                s.SSlideCD = sSlideCd
                                s.SSpeed = math.max(s.SSpeed, 17)
                            end

                            v311 = math.max(s.SSpeed, 27)
                            s.SBoost = sBoost2
                        end
                    end

                    s.SSpeed = v311

                    do
                        local v379 = s.SDashF or 0

                        if v351 and s.SLungeIn ~= true then
                            local lunge = child.Tuning(v356).lunge

                            if type(lunge) == "table"
                                and s.SDashCD == nil
                                and (not a280.dashCd or not a280.dashCd[v356])
                                and not (sFrozen)
                                and 0.001 < sSlow
                            then
                                local v381 = (s.SCharge or 0) * 0.016666666666666666

                                if (lunge.charge or 0.6) * 0.65 <= v381 then
                                    local vector34

                                    if v321 then
                                        vector34 = Vector3.new(v321.X, 0, v321.Y)
                                    else
                                        local lookVector = root.CFrame.LookVector
                                        vector34 = Vector3.new(lookVector.X, 0, lookVector.Z)
                                    end

                                    if 0.05 < vector34.Magnitude then
                                        do
                                            local sDashB

                                            do
                                                local unit = vector34.Unit
                                                local speed = lunge.speed or 70
                                                v379 = math.max(1, (math.floor((math.clamp((lunge.distance or 16) / speed, 0.12, 0.35) * 60) + 0.5)))
                                                s.SDashV = Vector3.new(math.floor(((unit.X * speed) / 0.01) + 0.5) * 0.01, 0, math.floor(((unit.Z * speed) / 0.01) + 0.5) * 0.01)
                                            end

                                            if lunge.brake then
                                                sDashB = 2
                                            else
                                                sDashB = nil
                                            end

                                            s.SDashB = sDashB
                                            s.SDashCD = math.max(1, (math.floor(((child.DASH_GAP * 0.85) * 60) + 0.5)))
                                        end

                                        a280.dashCd = a280.dashCd or {}
                                        a280.dashCd[v356] = math.max(1, (math.floor((((lunge.cooldown or 1) * 0.85) * 60) + 0.5)))
                                        s.SCharge = nil
                                        s.SChargeRel = nil

                                        if s.SSlide ~= nil then
                                            s.SSlide = nil
                                            s.SSlideDir = nil
                                            s.SSlope = nil
                                            s.SLift = nil
                                            s.SSlideCD = sSlideCd
                                            s.SSpeed = math.max(s.SSpeed, 17)
                                        end
                                    end
                                end
                            end
                        end

                        s.SLungeIn = v351 and true or nil

                        do
                            local isNotAir2 = not not (not sFrozen
                                and not v323
                                and 0.001 < sSlow
                                and s.SDashV == nil
                                and isNotAir)

                            if v337 and s.SSlideIn ~= true then
                                if not tryStartSlide(s, humanoid, v354, assemblyLinearVelocity, isNotAir2) then
                                    s.SSlideBuf = sSlideBuf
                                end
                            elseif s.SSlide == nil
                                and (v368 and v337 or s.SSlideBuf ~= nil)
                                and 0.2 < v354.Magnitude
                            then
                                tryStartSlide(s, humanoid, v354, assemblyLinearVelocity, isNotAir2)
                            end
                        end

                        s.SSlideIn = v337 and true or nil

                        if s.SSlide == nil then
                            local v388

                            do
                                local v389 = baseSpeed
                                local sBoost = s.SBoost or 0

                                if not (0 < sBoost) then
                                    v389 = baseSpeed
                                else
                                    local sBoost3

                                    do
                                        local v392 = math.max(baseSpeed, s.SSpeed)

                                        if not (1 < sBoost) then
                                            sBoost3 = nil
                                        else
                                            sBoost3 = sBoost - 1
                                        end

                                        s.SBoost = sBoost3
                                        v389 = v392
                                    end
                                end

                                local v393 = isNotAir and 8 or 1.6

                                do
                                    local sSpeed = s.SSpeed

                                    if sSpeed < v389 then
                                        v388 = v389
                                    else
                                        v388 = sSpeed + (v389 - sSpeed) * (1 - math.exp(-v393 * a281))

                                        if math.abs(v388 - v389) < 0.03 then
                                            v388 = v389
                                        end
                                    end
                                end
                            end

                            s.SSpeed = v388
                            v330 = v388 * v359
                            vector3 = nil
                        else
                            local v395
                            local sSlide = s.SSlide
                            local v397 = isNotAir and 1 or 0

                            do
                                local sSlide2 = sSlide + v397
                                s.SSlide = sSlide2
                                local clampedValue = math.clamp(sSlide2 / v18, 0, 1)
                                local sSpeed = (clampedValue * -19) * clampedValue + 36
                                local v401 = s.SSlideDir
                                if not v401 then
                                    local lookVector = root.CFrame.LookVector
                                    v401 = Vector3.new(lookVector.X, 0, lookVector.Z)
                                end

                                do
                                    local vector35 = Vector3.new(v354.X, 0, v354.Z)

                                    if 0.3 < vector35.Magnitude then
                                        local unit = vector35.Unit
                                        local v405 = math.acos((math.clamp(v401:Dot(unit), -1, 1)))

                                        if 0.001 < v405 and v405 < 2.0943951023931953 then
                                            v401 = v401:Lerp(unit, (math.min(1, (a281 * 1.6580627893946132) / v405))).Unit
                                        end
                                    end
                                end

                                do
                                    local sSlideDir = Vector3.new(math.floor((v401.X / 1e-04) + 0.5) * 1e-04, 0, math.floor((v401.Z / 1e-04) + 0.5) * 1e-04)
                                    s.SSlideDir = sSlideDir

                                    if type(s.SSlope) ~= "number" then
                                        v395 = 0
                                    else
                                        v395 = s.SSlope
                                    end

                                    do
                                        local v407 = nil

                                        if isNotAir then
                                            local v408
                                            local v409

                                            if type(s.SHip) ~= "number" then
                                                v408 = if simAuditOff then humanoid.HipHeight else s.SHipBase
                                            else
                                                v408 = s.SHip
                                            end

                                            if type(s.SHipBase) ~= "number" then
                                                v409 = v408
                                            else
                                                v409 = s.SHipBase
                                            end

                                            do
                                                local v410, v411 = probeGround(a280, sSlideDir, sSpeed, Vector3.new(assemblyLinearVelocity.X, 0, assemblyLinearVelocity.Z).Magnitude, v408, v409)

                                                do
                                                    local v412 = v410
                                                    v407 = v411

                                                    if v412 then
                                                        local maxValue = a281 * 40
                                                        v395 = math.floor(((v395 + math.clamp(v412 - v395, -maxValue, maxValue)) / 0.01) + 0.5) * 0.01
                                                    end
                                                end
                                            end
                                        end

                                        s.SSlope = if v395 ~= 0 then v395 else nil
                                        s.SLift = if v407 then math.floor((v407 / 0.01) + 0.5) * 0.01 else nil
                                    end

                                    sSpeed += v395
                                    s.SSpeed = sSpeed
                                    v330 = sSpeed * v359
                                    humanoid:Move(sSlideDir, false)

                                    do
                                        local magnitude = Vector3.new(assemblyLinearVelocity.X, 0, assemblyLinearVelocity.Z).Magnitude

                                        if not isNotAir and v22 < v369 then
                                            if s.SSlide ~= nil then
                                                s.SSlide = nil
                                                s.SSlideDir = nil
                                                s.SSlope = nil
                                                s.SLift = nil
                                                s.SSlideCD = sSlideCd
                                                s.SSpeed = math.max(s.SSpeed, 17)
                                            end

                                            s.SSpeed = math.max(s.SSpeed, sSpeed)
                                            s.SBoost = sBoost2
                                            vector3 = sSlideDir
                                        elseif 1 <= clampedValue
                                            or 0.2 < sSlide2 * 0.016666666666666666 and magnitude < 6
                                            or sFrozen
                                            or v323
                                        then
                                            if s.SSlide ~= nil then
                                                s.SSlide = nil
                                                s.SSlideDir = nil
                                                s.SSlope = nil
                                                s.SLift = nil
                                                s.SSlideCD = sSlideCd
                                                s.SSpeed = math.max(s.SSpeed, 17)
                                                vector3 = sSlideDir
                                            else
                                                vector3 = sSlideDir
                                            end
                                        else
                                            vector3 = sSlideDir
                                        end
                                    end
                                end
                            end
                        end

                        s.SSpeed = math.floor((s.SSpeed / 0.001) + 0.5) * 0.001

                        if sFrozen then
                            v330 = 0
                            s.SSpeed = baseSpeed
                        end

                        local v415 = math.floor((v330 / 0.01) + 0.5) * 0.01

                        if v415 ~= v415 or not (-1e+07 < v415) or not (v415 < 1e+07) then
                            if not v222["walk speed"] then
                                v222["walk speed"] = true

                                local warn = warn
                                local v417 = clientAuthority and "Client" or "Server"
                                local v418 = isServer and "server" or "client"
                                warn((`[SimNaN] walk speed auth={v417} side={v418}`))
                            end

                            s.SSpeed = baseSpeed
                            v415 = baseSpeed
                        end

                        do
                            local v419 = Vector3.new(v354.X, 0, v354.Z) * v415

                            if not moveClassic and not simAuditOff then
                                if s.SSlide == nil then
                                    if not (v415 <= 0) then
                                        local v420

                                        if typeof(s.SVel) ~= "Vector3" then
                                            v420 = Vector3.new(0, 0, 0)
                                        else
                                            v420 = s.SVel
                                        end

                                        if not v362 then
                                            local v421 = Vector3.new(assemblyLinearVelocity.X, 0, assemblyLinearVelocity.Z).Magnitude + 16

                                            if v421 < v420.Magnitude then
                                                v420 = v420.Unit * v421
                                            end
                                        end

                                        do
                                            local v422

                                            do
                                                local v423

                                                do
                                                    local v424, v425 = false, false

                                                    do
                                                        local v426
                                                        local vector36 = Vector3.new(v354.X, 0, v354.Z)

                                                        do
                                                            local v428 = vector36 * v415

                                                            if v362 then
                                                                if not (0.05 < vector36.Magnitude) then
                                                                    v426 = 50
                                                                else
                                                                    v426 = 160
                                                                end
                                                            else
                                                                v426 = vector36.Magnitude <= 0.05 and 200
                                                                    or v428:Dot(v420) < 0 and 500
                                                                    or 300
                                                            end

                                                            do
                                                                local v429 = v426 * a281
                                                                local v430 = v428 - v420
                                                                local magnitude = v430.Magnitude

                                                                if not (magnitude <= v429) then
                                                                    v419 = v420 + v430 * (v429 / magnitude)
                                                                else
                                                                    v419 = v428
                                                                end
                                                            end
                                                        end
                                                    end

                                                    do
                                                        local magnitude = v419.Magnitude

                                                        if magnitude < 0.05 then
                                                            v425 = true
                                                        else
                                                            do
                                                                local x = v419.X
                                                                v422 = x == x and -1e+07 < x and x < 1e+07
                                                            end

                                                            if v422 then
                                                                do
                                                                    local y = v419.Y
                                                                    v422 = y == y and -1e+07 < y and y < 1e+07
                                                                end

                                                                if v422 then
                                                                    local z = v419.Z
                                                                    v422 = false

                                                                    if z == z then
                                                                        v422 = false

                                                                        if -1e+07 < z then
                                                                            v422 = z < 1e+07
                                                                        end
                                                                    end
                                                                end
                                                            end

                                                            v424 = true
                                                        end

                                                        if v424 then
                                                            if v422 then
                                                                humanoid:Move(v419 / magnitude, false)
                                                                v423 = math.floor((magnitude / 0.01) + 0.5) * 0.01
                                                            else
                                                                v425 = true
                                                            end
                                                        end
                                                    end

                                                    if v425 then
                                                        v419 = Vector3.new(0, 0, 0)
                                                        humanoid:Move(Vector3.new(0, 0, 0), false)
                                                        v423 = v415
                                                    end
                                                end

                                                a280.moveWrote = humanoid.MoveDirection
                                                v415 = v423
                                            end
                                        end
                                    else
                                        v419 = Vector3.new(0, 0, 0)
                                    end
                                else
                                    local v436 = s.SSlideDir or Vector3.new(v354.X, 0, v354.Z)
                                    v419 = v436 * v415
                                    a280.moveWrote = humanoid.MoveDirection
                                end

                                s.SVel = if 0.05 <= v419.Magnitude then Vector3.new(math.floor((v419.X / 0.001) + 0.5) * 0.001, 0, math.floor((v419.Z / 0.001) + 0.5) * 0.001) else nil
                            end

                            if v307 and v41 and a280.wsWrote ~= nil and humanoid.WalkSpeed ~= a280.wsWrote then
                                v41("WalkSpeed")
                            end

                            if humanoid.WalkSpeed ~= v415 then
                                humanoid.WalkSpeed = v415
                            end

                            a280.wsWrote = humanoid.WalkSpeed

                            do
                                local sHipBase = s.SHipBase

                                if type(sHipBase) == "number" then
                                    local v438

                                    if s.SSlide == nil then
                                        v438 = sHipBase
                                    else
                                        v438 = math.max(0.3, sHipBase - 1.4)

                                        local sLift = s.SLift

                                        if type(sLift) == "number" and v438 < sLift then
                                            v438 = sLift
                                        end
                                    end

                                    if v365 and v438 < v365 then
                                        v438 = v365
                                    end

                                    v331 = v438
                                else
                                    v331 = nil
                                end
                            end

                            if v331 then
                                local v440

                                local v441

                                if type(s.SHip) ~= "number" then
                                    v440 = if simAuditOff then math.floor((humanoid.HipHeight / 0.001) + 0.5) * 0.001 else s.SHipBase
                                else
                                    v440 = s.SHip
                                end

                                if v326 and v331 == v326 then
                                    v441 = v331
                                elseif s.SWet ~= nil and s.SSlide == nil and v331 < v440 and v362 then
                                    v441 = v331
                                elseif not (0.01 < math.abs(v440 - v331)) then
                                    v441 = v331
                                else
                                    local v442 = v331 < v440 and 30 or s.SLift == nil and (v365 and 30 or 14) or 45
                                    v441 = math.floor(((v440 + ((v331 - v440) * (1 - math.exp(-v442 * a281)))) / 0.001) + 0.5) * 0.001
                                end

                                if s.SSlide ~= nil or s.SWet ~= nil or v441 ~= v331 then
                                    s.SHip = v441
                                else
                                    s.SHip = nil

                                    if simAuditOff then
                                        s.SHipBase = nil
                                    end
                                end

                                do
                                    local warn2
                                    local v444

                                    do
                                        local v445, v446, v447, v448 = false, false, false, false

                                        if v441 ~= v441 or not (-1e+07 < v441) or not (v441 < 1e+07) then
                                            if v222["hip height"] then
                                                v446 = true
                                            else
                                                v222["hip height"] = true
                                                warn2 = warn

                                                if clientAuthority then
                                                    v444 = "Client"
                                                else
                                                    v444 = "Server"
                                                end

                                                v445 = true
                                            end
                                        end

                                        if v445 then
                                            do
                                                local v449

                                                if isServer then
                                                    v449 = "server"
                                                else
                                                    v449 = "client"
                                                end

                                                warn2((`[SimNaN] hip height auth={v444} side={v449}`))
                                            end

                                            v446 = true
                                        end

                                        if v446 then
                                            if type(s.SHipBase) ~= "number" then
                                                v447 = true
                                            else
                                                local sHipBase = s.SHipBase

                                                if sHipBase == sHipBase and -1e+07 < sHipBase and (sHipBase < 1e+07) then
                                                    v441 = s.SHipBase
                                                    v448 = true
                                                else
                                                    v447 = true
                                                end
                                            end
                                        end

                                        if v447 then
                                            v441 = humanoid.HipHeight
                                            v448 = true
                                        end

                                        if v448 then
                                            s.SHip = nil
                                        end
                                    end
                                end

                                if humanoid.HipHeight ~= v441 then
                                    humanoid.HipHeight = v441
                                end

                                a280.hipWritten = v441
                            end

                            local v451 = not sFrozen and not v335 and humanoid.SeatPart == nil

                            do
                                local jumpHeight2 = not v451 and 0
                                    or math.floor((jumpProp(jumpHeight * (1 - (v325 * 0.45)), workspace2.Gravity) / 0.01) + 0.5) * 0.01

                                if v307 and v41 and a280.jhWrote ~= nil and humanoid.JumpHeight ~= a280.jhWrote then
                                    v41("JumpHeight")
                                end

                                if humanoid.JumpHeight ~= jumpHeight2 then
                                    humanoid.JumpHeight = jumpHeight2
                                end
                            end

                            a280.jhWrote = humanoid.JumpHeight
                            local v453 = false
                            local v454 = false

                            if v451 then
                                if isNotAir then
                                    v453 = v339 or 0 < v376
                                elseif s.SJumped ~= true
                                    and v369 <= v25
                                    and assemblyLinearVelocity.Y <= 1
                                    and 0 < v376
                                then
                                    s.SJumped = true
                                    v376 = 0
                                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                                    v454 = true
                                end
                            end

                            humanoid.Jump = v453

                            if v453 and s.SFloat == nil then
                                v454 = true

                                if clientAuthority
                                    and state ~= Enum.HumanoidStateType.Jumping
                                    and state ~= Enum.HumanoidStateType.Freefall
                                then
                                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                                end
                            end

                            if v454 and not moveClassic then
                                s.SFloat = 1
                            end

                            s.SJumpBuf = if 0 < v376 then v376 else nil

                            do
                                local gravity = a280.gravity
                                local isNotClimbing = v362 and state ~= Enum.HumanoidStateType.Climbing
                                local v457 = isNotClimbing and not isNotAir and assemblyLinearVelocity.Y < 0

                                do
                                    local isNotClimbing2 = s.SFloat ~= nil
                                        and s.SKb == nil
                                        and state ~= Enum.HumanoidStateType.Climbing

                                    do
                                        local v459 = 1

                                        if not isNotClimbing2 or not v454 and type(s.SFloat) ~= "number" then
                                            if v457 then
                                                if isNotClimbing2
                                                    and not moveClassic
                                                    and -10 < assemblyLinearVelocity.Y
                                                then
                                                    v332 = v16
                                                else
                                                    v332 = s.SSlide ~= nil and 1.3 or fallGravityMult
                                                end
                                            elseif isNotClimbing2 then
                                                if not (0 <= assemblyLinearVelocity.Y) then
                                                    v332 = v459
                                                else
                                                    v332 = if assemblyLinearVelocity.Y < 10 then v16 else v15
                                                end
                                            else
                                                v332 = v459
                                            end
                                        else
                                            v332 = v15
                                        end
                                    end
                                end

                                local enabled = v457 or v332 ~= 1

                                if gravity then
                                    if enabled then
                                        local v461 = workspace2.Gravity * (1 - v332)

                                        if v457 and s.SSlide ~= nil then
                                            if const v462 = slideCushion(a280, assemblyLinearVelocity.Y, humanoid.HipHeight) then
                                                v461 = v462 + workspace2.Gravity
                                            end
                                        elseif v457 and v326 then
                                            if const v463 = slideCushion(a280, assemblyLinearVelocity.Y, v326, 4) then
                                                v461 = v463 + workspace2.Gravity
                                            end
                                        end

                                        local y = v461 * root.AssemblyMass

                                        if y ~= y or not (-1e+07 < y) or not (y < 1e+07) then
                                            if not v222["fall force"] then
                                                v222["fall force"] = true

                                                local warn = warn
                                                local v466 = clientAuthority and "Client" or "Server"
                                                local v467 = isServer and "server" or "client"
                                                warn((`[SimNaN] fall force auth={v466} side={v467}`))
                                            end

                                            y = 0
                                        end

                                        gravity.Force = Vector3.new(0, y, 0)
                                    end

                                    if gravity.Enabled ~= enabled then
                                        gravity.Enabled = enabled
                                    end
                                end
                            end

                            do
                                local v468 = nil
                                local v469 = s.SKbF or 0

                                if not (0 < v469) then
                                    v333 = v468
                                elseif s.SKb then
                                    do
                                        local v470 = v469 / math.max(s.SKbN or v469, 1)
                                        v333 = s.SKb * v470 + v419 * (1 - v470)
                                    end

                                    v469 -= 1

                                    if not (v469 <= 0) then
                                        s.SKbF = v469
                                    else
                                        s.SKb = nil
                                        s.SKbF = nil
                                        s.SKbN = nil
                                    end
                                else
                                    v333 = v468
                                end
                            end

                            if 0 < v379 and s.SDashV then
                                local sDashV = s.SDashV
                                local v472 = if v333 then v333 + sDashV else sDashV
                                vector3 = Vector3.new(sDashV.X, 0, sDashV.Z).Unit
                                v379 -= 1
                                v333 = v472
                            elseif s.SDashB then
                                v333 = v333 or v419
                                s.SDashB = if 1 < s.SDashB then s.SDashB - 1 else nil
                            end
                        end

                        if not (v379 <= 0) then
                            s.SDashF = v379
                        else
                            s.SDashV = nil
                            s.SDashF = nil
                        end
                    end

                    if v333 then
                        local x = v333.X

                        local v474 = x == x and -1e+07 < x and x < 1e+07
                        if v474 then
                            do
                                local y = v333.Y
                                v474 = y == y and -1e+07 < y and y < 1e+07
                            end

                            if v474 then
                                local z = v333.Z
                                v474 = z == z and -1e+07 < z and z < 1e+07
                            end
                        end

                        if not v474 then
                            do
                                local v477 = s.SKb == nil and (s.SDashV == nil and "push" or "push (dash)")
                                    or "push (knockback)"

                                if not v222[v477] then
                                    v222[v477] = true

                                    local warn = warn
                                    local v479 = clientAuthority and "Client" or "Server"
                                    local v480 = isServer and "server" or "client"
                                    warn((`[SimNaN] {v477} auth={v479} side={v480}`))
                                end
                            end

                            s.SKb = nil
                            s.SKbF = nil
                            s.SKbN = nil
                            s.SDashV = nil
                            s.SDashF = nil
                            v333 = nil
                        end
                    end

                    if v333 then
                        s.SPushRise = 4
                    elseif s.SPushRise then
                        s.SPushRise = if 1 < s.SPushRise then s.SPushRise - 1 else nil
                    end

                    if v333 or s.SPushRise then
                        local assemblyLinearVelocity2 = root.AssemblyLinearVelocity

                        if 55 < assemblyLinearVelocity2.Y then
                            root.AssemblyLinearVelocity = Vector3.new(assemblyLinearVelocity2.X, 55, assemblyLinearVelocity2.Z)
                        end
                    end

                    do
                        if const push = a280.push then
                            if v333 then
                                push.PlaneVelocity = Vector2.new(v333.X, v333.Z)
                            end

                            local enabled = v333 ~= nil

                            if push.Enabled ~= enabled then
                                push.Enabled = enabled
                            end
                        end
                    end

                    if not vector3 and v321 and not sFrozen and humanoid.SeatPart == nil then
                        vector3 = Vector3.new(v321.X, 0, v321.Y)
                    end
                end

                do
                    local align = a280.align

                    if vector3 then
                        local x = vector3.X

                        local v486 = x == x and -1e+07 < x and x < 1e+07
                        if v486 then
                            do
                                local y = vector3.Y
                                v486 = y == y and -1e+07 < y and y < 1e+07
                            end

                            if v486 then
                                local z = vector3.Z
                                v486 = z == z and -1e+07 < z and z < 1e+07
                            end
                        end

                        if not v486 then
                            if not v222.facing then
                                v222.facing = true

                                local warn = warn
                                local v490 = clientAuthority and "Client" or "Server"
                                local v491 = isServer and "server" or "client"
                                warn((`[SimNaN] facing auth={v490} side={v491}`))
                            end

                            vector3 = nil
                        end
                    end

                    if vector3 and align and 0.1 < vector3.Magnitude then
                        if humanoid.AutoRotate then
                            humanoid.AutoRotate = false
                        end

                        do
                            local unit = vector3.Unit

                            do
                                local cFrame2 = CFrame.lookAt(Vector3.new(0, 0, 0), (Vector3.new(math.floor((unit.X / 1e-04) + 0.5) * 1e-04, 0, math.floor((unit.Z / 1e-04) + 0.5) * 1e-04)))

                                if align.CFrame ~= cFrame2 then
                                    align.CFrame = cFrame2
                                end
                            end
                        end

                        if not align.Enabled then
                            align.Enabled = true
                        end
                    else
                        if align and align.Enabled then
                            align.Enabled = false
                        end

                        if not humanoid.AutoRotate then
                            humanoid.AutoRotate = true
                        end
                    end
                end
            end

            save(a280)
        end
    end
end

local v494 = {steps = 0, time = 0, maxStep = 0, chars = 0}

function v9.DebugStats()
    --[[
      name: DebugStats
      line: 1544
      upvalues:
        v494 (copy, index: 1)
        v46 (copy, index: 2)
    ]]
    local v495 = {steps = v494.steps, msPerStep = if 0 < v494.steps then v494.time / v494.steps * 1000 else 0}
    v495.maxStepMs = v494.maxStep * 1000
    v495.characters = #v46
    return v495
end

v9.CORRECTION_MAX = 20
local v496 = Vector3.new(0, 0, 0)
local v497 = nil
local v498 = Vector3.new(0, 0, 0)
local root = nil
local sTp = nil
local v501 = false

local function trackCorrection(a503)
    --[[
      name: trackCorrection
      line: 1570
      upvalues:
        runService (copy, index: 1)
        v501 (ref,  index: 2)
        v46 (copy, index: 3)
        v497 (ref,  index: 4)
        root (ref,  index: 5)
        sTp (ref,  index: 6)
        v498 (ref,  index: 7)
        v496 (ref,  index: 8)
    ]]
    if runService:IsResimulating() then
        v501 = true
        return
    end

    local v504 = v46[1]
    if not v504 then
        v497 = nil
        root = nil
        v501 = false

        return
    end

    local root2 = v504.root
    local position = root2.Position
    local assemblyLinearVelocity = root2.AssemblyLinearVelocity
    local sTp2 = root2:GetAttribute("STp")

    if v501 and v497 and root2 == root and sTp2 == sTp then
        local v509 = position - (v497 + (((v498 + assemblyLinearVelocity) * 0.5) * a503))
        local magnitude = v509.Magnitude

        if 0.02 < magnitude and magnitude < 20 then
            v496 += v509
        end
    end

    v497 = position
    v498 = assemblyLinearVelocity
    root = root2
    sTp = sTp2
    v501 = false
end

function v9.TakeCorrection()
    --[[
      name: TakeCorrection
      line: 1595
      upvalues:
        v496 (ref, index: 1)
    ]]
    local v511 = v496
    v496 = Vector3.new(0, 0, 0)

    return v511
end

function v9.RebaseCorrection()
    --[[
      name: RebaseCorrection
      line: 1604
      upvalues:
        v46 (copy, index: 1)
        isServer (copy, index: 2)
        v497 (ref,  index: 3)
        v498 (ref,  index: 4)
        root (ref,  index: 5)
        sTp (ref,  index: 6)
        v501 (ref,  index: 7)
    ]]
    local v512 = v46[1]

    if isServer or not v512 then
        return
    end

    local root2 = v512.root
    local assemblyLinearVelocity = root2.AssemblyLinearVelocity
    local v515 = root2.Position - assemblyLinearVelocity * 0.016666666666666666
    local sTp2 = root2:GetAttribute("STp")
    v497 = v515
    v498 = assemblyLinearVelocity
    root = root2
    sTp = sTp2
    v501 = false
end

local function step(a518)
    --[[
      name: step
      line: 1614
      upvalues:
        isServer (copy, index: 1)
        trackCorrection (copy, index: 2)
        v39 (copy, index: 3)
        stepRelay (copy, index: 4)
        stepChar (copy, index: 5)
        v46 (copy, index: 6)
        v494 (copy, index: 7)
    ]]
    local timestamp = os.clock()

    if not isServer then
        trackCorrection(a518)
    end

    local v520 = if v39 then stepRelay else stepChar

    for _, v522 in v46 do
        if not v522.failed then
            local success, result = pcall(v520, v522, a518)
            if success then
                continue
            end

            v522.failed = true
            warn((`[Simulation] step failed for {v522.character.Name}: {result}`))
        end
    end

    local elapsedTime = os.clock() - timestamp
    v494.steps += 1
    v494.time += elapsedTime

    if v494.maxStep < elapsedTime then
        v494.maxStep = elapsedTime
    end
end

local function unregister(character: Model)
    --[[
      name: unregister
      line: 1640
      upvalues:
        v45 (copy, index: 1)
        v46 (copy, index: 2)
    ]]
    local v528 = v45[character]
    if not v528 then
        return
    end

    v45[character] = nil

    for _, conn in v528.conns do
        conn:Disconnect()
    end

    table.clear(v46)

    for _, v532 in v45 do
        table.insert(v46, v532)
    end
end

local function actionsOf(player: Player?, timeout: number)
    --[[
      name: actionsOf
      line: 1652
      upvalues:
        Inputs (copy, index: 1)
    ]]
    local v536 = {}
    local child = player:FindFirstChild(Inputs.CONTEXT) or player:WaitForChild(Inputs.CONTEXT, timeout)
    if not child then
        return v536
    end

    for _, action in Inputs.ACTIONS do
        local child2 = child:FindFirstChild(action.name) or child:WaitForChild(action.name, 5)

        if child2 and child2:IsA("InputAction") then
            v536[action.name] = child2
        end
    end

    return v536
end

local function moveActionOf(player: Player?, timeout: number)
    --[[
      name: moveActionOf
      line: 1669
    ]]
    local inputContexts = player:FindFirstChild("InputContexts") or player:WaitForChild("InputContexts", timeout)
    local characterContext = inputContexts
        and (inputContexts:FindFirstChild("CharacterContext") or inputContexts:WaitForChild("CharacterContext", 5))
    local moveAction = characterContext
        and (characterContext:FindFirstChild("MoveAction") or characterContext:WaitForChild("MoveAction", 5))

    if moveAction and moveAction:IsA("InputAction") then
        return moveAction
    end

    warn("[Simulation] no InputContexts.CharacterContext.MoveAction: walking falls back to the PlayerModule")

    return nil
end

local function recomputeMirrors(a548)
    --[[
      name: recomputeMirrors
      line: 1681
    ]]
    local humanoid = a548.humanoid
    local slow = 1

    for text, attribute in humanoid:GetAttributes() do
        if typeof(attribute) == "number" then
            if string.sub(text, 1, 9) == "SpeedMult" and attribute == attribute then
                slow *= math.clamp(attribute, 0, 3)
            end
        end
    end

    a548.slow = slow
    local frozen = a548.player:GetAttribute("Frozen") == true
    a548.frozen = frozen
    local v554 = humanoid:GetAttribute("NoJump") == true
        or a548.character:GetAttribute("NoJump") == true
        or a548.character:GetAttribute("Rooted") == true
    a548.noJump = v554
end

local function ensureConstraints(parent: Instance?)
    --[[
      name: ensureConstraints
      line: 1694
    ]]
    local rootAttachment = parent:FindFirstChild("RootAttachment")

    if not rootAttachment or not rootAttachment:IsA("Attachment") then
        return nil, nil, nil
    end

    local tribesKnockback = parent:FindFirstChild("TribesKnockback")
    if not tribesKnockback then
        tribesKnockback = Instance.new("LinearVelocity")
        tribesKnockback.Name = "TribesKnockback"
        tribesKnockback.Attachment0 = rootAttachment
        tribesKnockback.RelativeTo = Enum.ActuatorRelativeTo.World
        tribesKnockback.VelocityConstraintMode = Enum.VelocityConstraintMode.Plane
        tribesKnockback.PrimaryTangentAxis = Vector3.new(1, 0, 0)
        tribesKnockback.SecondaryTangentAxis = Vector3.new(0, 0, 1)
        tribesKnockback.ForceLimitMode = Enum.ForceLimitMode.Magnitude
        tribesKnockback.MaxForce = 1e+06
        tribesKnockback.Enabled = false
        tribesKnockback.Parent = parent
    end

    local tribesFallGravity = parent:FindFirstChild("TribesFallGravity")
    if not tribesFallGravity then
        tribesFallGravity = Instance.new("VectorForce")
        tribesFallGravity.Name = "TribesFallGravity"
        tribesFallGravity.Attachment0 = rootAttachment
        tribesFallGravity.RelativeTo = Enum.ActuatorRelativeTo.World
        tribesFallGravity.ApplyAtCenterOfMass = true
        tribesFallGravity.Force = Vector3.new(0, 0, 0)
        tribesFallGravity.Enabled = false
        tribesFallGravity.Parent = parent
    end

    local tribesFacing = parent:FindFirstChild("TribesFacing")
    if not tribesFacing then
        tribesFacing = Instance.new("AlignOrientation")
        tribesFacing.Name = "TribesFacing"
        tribesFacing.Mode = Enum.OrientationAlignmentMode.OneAttachment
        tribesFacing.Attachment0 = rootAttachment
        tribesFacing.RigidityEnabled = true
        tribesFacing.MaxTorque = math.huge
        tribesFacing.MaxAngularVelocity = math.huge
        tribesFacing.Enabled = false
        tribesFacing.Parent = parent
    end

    local instance = if tribesKnockback and tribesKnockback:IsA("LinearVelocity") then tribesKnockback else nil
    local instance2 = if tribesFallGravity and tribesFallGravity:IsA("VectorForce") then tribesFallGravity else nil

    if tribesFacing and tribesFacing:IsA("AlignOrientation") then
        return instance, instance2, tribesFacing
    end

    return instance, instance2, nil
end

local function ensureHull(humanoidRootPart)
    --[[
      name: ensureHull
      line: 1745
      upvalues:
        simAuditOff (copy, index: 1)
    ]]
    local tribesHull2 = humanoidRootPart:FindFirstChild("TribesHull")

    if tribesHull2 and tribesHull2:IsA("BasePart") then
        return tribesHull2
    end
    if simAuditOff then
        return nil
    end

    local size = humanoidRootPart.Size
    local tribesHull = Instance.new("Part")
    tribesHull.Name = "TribesHull"
    tribesHull.Shape = Enum.PartType.Cylinder
    tribesHull.Size = Vector3.new(size.Y * 1.4, size.X * 0.9, size.X * 0.9)
    tribesHull.Transparency = 1
    tribesHull.CastShadow = false
    tribesHull.Massless = true
    tribesHull.CanCollide = true
    tribesHull.CanQuery = false
    tribesHull.CanTouch = false
    tribesHull.CollisionGroup = humanoidRootPart.CollisionGroup
    tribesHull.CFrame = humanoidRootPart.CFrame * CFrame.new(0, size.Y * 0.2, 0) * CFrame.Angles(0, 0, 1.5707963267948966)

    local weldConstraint = Instance.new("WeldConstraint")
    weldConstraint.Part0 = humanoidRootPart
    weldConstraint.Part1 = tribesHull
    weldConstraint.Parent = tribesHull
    tribesHull.Parent = humanoidRootPart

    return tribesHull
end

local function corpseParts(character: Model?)
    --[[
      name: corpseParts
      line: 1774
      upvalues:
        childNames (copy, index: 1)
    ]]
    local v571 = {}

    for _, childName in childNames do
        local child = character:FindFirstChild(childName)

        if child and child:IsA("BasePart") then
            table.insert(v571, child)
        end
    end

    return v571
end

local function bodyParts(character: Model?)
    --[[
      name: bodyParts
      line: 1785
    ]]
    local v577 = {}

    for _, child in character:GetChildren() do
        if child:IsA("BasePart") then
            table.insert(v577, child)
        end
    end

    return v577
end

local function register(player: Player?, character: Model?)
    --[[
      name: register
      line: 1795
      upvalues:
        v45 (copy, index: 1)
        v46 (copy, index: 2)
        isServer (copy, index: 3)
        v9 (copy, index: 4)
        jumpHeight (copy, index: 5)
        baseSpeed (copy, index: 6)
        waterSimOff (copy, index: 7)
        ensureConstraints (copy, index: 8)
        ensureHull (copy, index: 9)
        clientAuthority (copy, index: 10)
        runService (copy, index: 11)
        simAuditOff (copy, index: 12)
        v39 (copy, index: 13)
        actionsOf (copy, index: 14)
        moveActionOf (copy, index: 15)
        bodyParts (copy, index: 16)
        corpseParts (copy, index: 17)
        recomputeMirrors (copy, index: 18)
    ]]
    if const v583 = v45[character] then
        v45[character] = nil

        for _, conn in v583.conns do
            conn:Disconnect()
        end

        table.clear(v46)

        for _, v587 in v45 do
            table.insert(v46, v587)
        end
    end

    local humanoid = character:WaitForChild("Humanoid", 10)
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 10)

    if not humanoid or not humanoid:IsA("Humanoid") or not humanoidRootPart or not humanoidRootPart:IsA("BasePart") then
        return
    end

    local instance, v591, v592, v593

    if player.Character ~= character then
        return
    end

    if isServer then
        humanoid.UseJumpPower = false
        humanoid.JumpPower = v9.JUMP_POWER_MARK
        humanoid.JumpHeight = jumpHeight
        humanoid.WalkSpeed = baseSpeed
        humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, waterSimOff)
        local instance2, v595, v596 = ensureConstraints(humanoidRootPart)
        instance = instance2
        v591 = v595
        v592 = v596
        v593 = ensureHull(humanoidRootPart)

        if clientAuthority then
            pcall(
                function()
                    --[[
                      line: 1821
                      upvalues:
                        humanoidRootPart (copy, index: 1)
                        player (copy, index: 2)
                    ]]
                    humanoidRootPart:SetNetworkOwner(player)
                end
            )
        end
    else
        pcall(
            function()
                --[[
                  line: 1827
                  upvalues:
                    runService (copy, index: 1)
                    humanoidRootPart (copy, index: 2)
                ]]
                runService:SetPredictionMode(humanoidRootPart, Enum.PredictionMode.On)
            end
        )
        humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, waterSimOff)
        local tribesKnockback = humanoidRootPart:WaitForChild("TribesKnockback", 10)
        local tribesFallGravity = humanoidRootPart:WaitForChild("TribesFallGravity", 10)
        local tribesFacing = humanoidRootPart:WaitForChild("TribesFacing", 10)

        if not tribesKnockback or not tribesKnockback:IsA("LinearVelocity") then
            instance = nil
        else
            instance = tribesKnockback
        end

        v591 = if tribesFallGravity and tribesFallGravity:IsA("VectorForce") then tribesFallGravity else nil
        v592 = if tribesFacing and tribesFacing:IsA("AlignOrientation") then tribesFacing else nil
        local instance3 = if simAuditOff then nil else humanoidRootPart:WaitForChild("TribesHull", 10)
        v593 = if instance3 and instance3:IsA("BasePart") then instance3 else nil
    end

    local actions = v39 and {} or actionsOf(player, 20)
    local move = if clientAuthority then nil else moveActionOf(player, 10)

    if player.Character ~= character or not character.Parent then
        return
    end

    local ray = RaycastParams.new()
    ray.FilterType = Enum.RaycastFilterType.Exclude
    ray.FilterDescendantsInstances = {character}
    ray.RespectCanCollide = true
    ray.IgnoreWater = true
    local v604 = {
        holdSlot = -1,
        holdTool = nil,
        frozen = false,
        slow = 1,
        noJump = false,
        holdBad = 0,
        hipWritten = nil,
        failed = false,
        wsWrote = nil,
        jhWrote = nil,
        moveWrote = nil,
        moveIntent = Vector3.new(0, 0, 0),
        player = player,
        character = character,
        humanoid = humanoid,
        root = humanoidRootPart,
        push = instance,
        gravity = v591,
        align = v592,
        actions = actions,
        move = move,
        hull = v593,
        body = bodyParts(character),
        corpse = corpseParts(character),
        ray = ray,
        s = {},
        prev = {},
        tpSeen = humanoidRootPart:GetAttribute("STp"),
        kbSeen = humanoidRootPart:GetAttribute("NKbSeq"),
        pending = {},
        conns = {},
        watchFrom = os.clock() + 8
    }

    if isServer then
        recomputeMirrors(v604)

        local function refresh()
            --[[
              name: refresh
              line: 1890
              upvalues:
                recomputeMirrors (copy, index: 1)
                v604 (copy, index: 2)
            ]]
            recomputeMirrors(v604)
        end

        table.insert(v604.conns, humanoid.AttributeChanged:Connect(refresh))
        table.insert(v604.conns, character.AttributeChanged:Connect(refresh))
        table.insert(v604.conns, player:GetAttributeChangedSignal("Frozen"):Connect(refresh))
    end

    table.insert(
        v604.conns,
        character.AncestryChanged:Connect(
            function()
                --[[
                  line: 1897
                  upvalues:
                    character (copy, index: 1)
                    v45 (copy, index: 2)
                    v46 (copy, index: 3)
                ]]
                if not character:IsDescendantOf(game) then
                    local character2 = character
                    local v607 = v45[character2]
                    if not v607 then
                        return
                    end

                    v45[character2] = nil

                    for _, conn in v607.conns do
                        conn:Disconnect()
                    end

                    table.clear(v46)

                    for _, v611 in v45 do
                        table.insert(v46, v611)
                    end
                end
            end
        )
    )

    v45[character] = v604
    table.clear(v46)

    for _, v613 in v45 do
        table.insert(v46, v613)
    end
end

local function onPlayer(player: Player?)
    --[[
      name: onPlayer
      line: 1906
      upvalues:
        isServer (copy, index: 1)
        Inputs (copy, index: 2)
        register (copy, index: 3)
        unregister (copy, index: 4)
    ]]
    if isServer then
        Inputs.Build(player)
    end

    player.CharacterAdded:Connect(
        function(character: Model)
            --[[
              line: 1910
              upvalues:
                register (copy, index: 1)
                player (copy, index: 2)
            ]]
            register(player, character)
        end
    )
    player.CharacterRemoving:Connect(unregister)

    if player.Character then
        task.spawn(register, player, player.Character)
    end
end

function v9.Knockback(key, a618, kbDur)
    --[[
      name: Knockback
      line: 1925
      upvalues:
        v45 (copy, index: 1)
        isServer (copy, index: 2)
    ]]
    local v620 = v45[key]

    if not v620 or not isServer or typeof(a618) ~= "Vector3" or a618 ~= a618 then
        return false
    end

    local pending = v620.pending
    pending.kb = if pending.kb then pending.kb + a618 else a618
    pending.kbDur = kbDur

    return true
end

function v9.Teleport(key, tp)
    --[[
      name: Teleport
      line: 1940
      upvalues:
        v45 (copy, index: 1)
        isServer (copy, index: 2)
        finCF (copy, index: 3)
    ]]
    local v624 = v45[key]

    if not v624 or not isServer or typeof(tp) ~= "CFrame" or not finCF(tp) then
        return false
    end

    v624.pending.tp = tp

    return true
end

local v625 = {}
local v626 = {}
local v627 = {}

local function fire(a629)
    --[[
      name: fire
      line: 1956
      upvalues:
        v625 (copy, index: 1)
        v87 (copy, index: 2)
        v626 (copy, index: 3)
        clientAuthority (copy, index: 4)
        v88 (copy, index: 5)
    ]]
    local v630 = v625[a629]
    local v631 = v87[a629]

    if not v630 or v631 == nil or v626[a629] == v631 then
        return
    end
    if clientAuthority and v88[a629] then
        return
    end

    if pcall(
        function()
            --[[
              line: 1965
              upvalues:
                v630 (copy, index: 1)
                v631 (copy, index: 2)
            ]]
            v630:Fire(v631)
        end
    ) then
        v626[a629] = v631
    end
end

function v9.SetInput(key, value)
    --[[
      name: SetInput
      line: 1974
      upvalues:
        isServer (copy, index: 1)
        v627 (copy, index: 2)
        v87 (copy, index: 3)
        fire (copy, index: 4)
    ]]
    if isServer then
        return
    end

    v627[key] = (v627[key] or 0) + 1
    v87[key] = value
    fire(key)
end

function v9.Pulse(key, a635)
    --[[
      name: Pulse
      line: 1984
      upvalues:
        v9 (copy, index: 1)
        v627 (copy, index: 2)
    ]]
    v9.SetInput(key, true)
    local v636 = v627[key]

    task.delay(
        (a635 or 0.12),
        function()
            --[[
              line: 1987
              upvalues:
                v627 (copy, index: 1)
                key (copy, index: 2)
                v636 (copy, index: 3)
                v9 (copy, index: 4)
            ]]
            if v627[key] == v636 then
                v9.SetInput(key, false)
            end
        end
    )
end

function v9.SetFacing(facing: number)
    --[[
      name: SetFacing
      line: 1995
      upvalues:
        v9 (copy, index: 1)
    ]]
    if facing ~= nil and facing == facing then
        v9.SetInput("Facing", Vector2.new(math.floor((-math.sin(facing) / 0.001) + 0.5) * 0.001, math.floor((-math.cos(facing) / 0.001) + 0.5) * 0.001))
        return
    end

    v9.SetInput("Facing", Vector2.zero)
end

function v9.SetLook(look: number)
    --[[
      name: SetLook
      line: 2005
      upvalues:
        isServer (copy, index: 1)
        v9 (copy, index: 2)
    ]]
    if isServer or type(look) ~= "number" or look ~= look then
        return
    end

    v9.SetInput("Look", Vector2.new(math.floor((-math.sin(look) / 0.001) + 0.5) * 0.001, math.floor((-math.cos(look) / 0.001) + 0.5) * 0.001))
end

local function watchHold(localPlayer: Player?)
    --[[
      name: watchHold
      line: 2014
      upvalues:
        Inputs (copy, index: 1)
        v9 (copy, index: 2)
    ]]
    local v641 = {}

    local function update(character: Model?)
        --[[
          name: update
          line: 2016
          upvalues:
            Inputs (copy, index: 1)
            v9 (copy, index: 2)
        ]]
        local clampedValue
        local v646 = if const tool = character:FindFirstChildWhichIsA("Tool") then tool:GetAttribute("SlotIndex") else nil

        if type(v646) ~= "number" or v646 ~= v646 then
            clampedValue = 0
        else
            clampedValue = math.clamp(math.floor(v646 + 0.5), 0, Inputs.HOLD_SLOTS)
        end

        v9.SetInput("Hold", clampedValue / Inputs.HOLD_SCALE)
    end

    local function onCharacter(character: Model?)
        --[[
          name: onCharacter
          line: 2022
          upvalues:
            v641 (copy, index: 1)
            update (copy, index: 2)
        ]]
        for _, v650 in v641 do
            v650:Disconnect()
        end

        table.clear(v641)

        local function changed(child: Instance)
            --[[
              name: changed
              line: 2027
              upvalues:
                update (copy, index: 1)
                character (copy, index: 2)
            ]]
            if child:IsA("Tool") then
                update(character)
            end
        end

        table.insert(v641, character.ChildAdded:Connect(changed))
        table.insert(v641, character.ChildRemoved:Connect(changed))
        update(character)
    end

    localPlayer.CharacterAdded:Connect(onCharacter)

    if localPlayer.Character then
        onCharacter(localPlayer.Character)
    end
end

function v9.WriteGuardStats()
    --[[
      name: WriteGuardStats
      line: 2043
      upvalues:
        WriteGuard (copy, index: 1)
    ]]
    return WriteGuard.Stats()
end

function v9.WriteGuardReset()
    --[[
      name: WriteGuardReset
      line: 2047
      upvalues:
        WriteGuard (copy, index: 1)
    ]]
    WriteGuard.Reset()
end

function v9.IsSliding(a653)
    --[[
      name: IsSliding
      line: 2052
    ]]
    local humanoidRootPart = a653 and a653:FindFirstChild("HumanoidRootPart")
    return humanoidRootPart ~= nil and humanoidRootPart:GetAttribute("SSlide") ~= nil
end

function v9.IsDashing(a655)
    --[[
      name: IsDashing
      line: 2057
    ]]
    local humanoidRootPart = a655 and a655:FindFirstChild("HumanoidRootPart")
    return humanoidRootPart ~= nil and humanoidRootPart:GetAttribute("SDashF") ~= nil
end

function v9.DashReady(key, key2)
    --[[
      name: DashReady
      line: 2064
      upvalues:
        v45 (copy, index: 1)
    ]]
    local v659 = if key then v45[key] else nil
    local v660 = v659 and v659.dashCd and v659.dashCd[key2]

    return not v660
end

function v9.RefreshDash(key, key2)
    --[[
      name: RefreshDash
      line: 2071
      upvalues:
        v45 (copy, index: 1)
    ]]
    local v663 = if key then v45[key] else nil

    if v663 and v663.dashCd then
        v663.dashCd[key2] = nil
    end
end

local v664 = {}
local hasRun = false

local function startFallback()
    --[[
      name: startFallback
      line: 2090
      upvalues:
        hasRun (ref,  index: 1)
        runService (copy, index: 2)
        v664 (copy, index: 3)
    ]]
    if hasRun then
        return
    end

    hasRun = true
    local v667 = 0

    runService.PreSimulation:Connect(
        function(deltaTimeSim: number)
            --[[
              line: 2096
              upvalues:
                v667 (ref,  index: 1)
                v664 (copy, index: 2)
            ]]
            v667 = math.min(v667 + deltaTimeSim, 0.06666666666666667)

            while 0.016666666666666666 <= v667 do
                v667 -= 0.016666666666666666

                for _, v670 in v664 do
                    if v670.fallback then
                        v670.fn(0.016666666666666666)
                    end
                end
            end
        end
    )
end

function v9.BindStep(fn, priority: number?)
    --[[
      name: BindStep
      line: 2109
      upvalues:
        v664 (copy, index: 1)
        runService (copy, index: 2)
        clientAuthority (copy, index: 3)
        hasRun (ref,  index: 4)
    ]]
    local v673 = {calls = 0, fallback = false, fn = fn, priority = priority}
    table.insert(v664, v673)
    table.sort(
        v664,
        function(left, right)
            --[[
              line: 2112
            ]]
            return left.priority < right.priority
        end
    )
    local success, result = pcall(
        function()
            --[[
              line: 2115
              upvalues:
                runService (copy, index: 1)
                v673 (copy, index: 2)
                fn (copy, index: 3)
                priority (copy, index: 4)
            ]]
            runService:BindToSimulation(
                function(a678)
                    --[[
                      line: 2116
                      upvalues:
                        v673 (copy, index: 1)
                        fn (copy, index: 2)
                    ]]
                    v673.calls += 1
                    v673.fallback = false
                    fn(a678)
                end,
                Enum.StepFrequency.Hz60,
                priority
            )
        end
    )

    if success and not clientAuthority then
        return
    end

    local taskDelay = task.delay
    local v680 = success and 1.5 or 0

    taskDelay(
        v680,
        function()
            --[[
              line: 2125
              upvalues:
                v673 (copy, index: 1)
                hasRun (ref,  index: 2)
                runService (copy, index: 3)
                v664 (copy, index: 4)
                priority (copy, index: 5)
                success (copy, index: 6)
                result (copy, index: 7)
            ]]
            if v673.calls == 0 then
                v673.fallback = true

                if not hasRun then
                    hasRun = true
                    local v681 = 0

                    runService.PreSimulation:Connect(
                        function(deltaTimeSim: number)
                            --[[
                              line: 2096
                              upvalues:
                                v681 (ref,  index: 1)
                                v664 (copy, index: 2)
                            ]]
                            v681 = math.min(v681 + deltaTimeSim, 0.06666666666666667)

                            while 0.016666666666666666 <= v681 do
                                v681 -= 0.016666666666666666

                                for _, v684 in v664 do
                                    if v684.fallback then
                                        v684.fn(0.016666666666666666)
                                    end
                                end
                            end
                        end
                    )
                end

                if runService:IsStudio() then
                    local warn = warn
                    local v686 = success and "never called" or tostring(result)
                    warn((`[Simulation] BindToSimulation isn't running the priority-{priority} step ({v686}): stepping it from PreSimulation at 60 Hz`))
                end
            end
        end
    )
end

function v9.StepSource()
    --[[
      name: StepSource
      line: 2137
      upvalues:
        v664 (copy, index: 1)
    ]]
    local v687 = false
    local fallback = false

    for _, v690 in v664 do
        local v691 = v687 or 0 < v690.calls
        local fallback2 = fallback or v690.fallback
        v687, fallback = v691, fallback2
    end

    if fallback then
        return "fallback"
    end
    if v687 then
        return "engine"
    end

    return "waiting"
end

local function predictionOff(a694, callback, a696)
    --[[
      name: predictionOff
      line: 2154
      upvalues:
        runService (copy, index: 1)
    ]]
    local v697 = {}
    local v698 = a696 or Enum.PredictionMode.Off

    for _, context in a694:GetDescendants() do
        if context:IsA("BasePart") then
            pcall(
                function()
                    --[[
                      line: 2159
                      upvalues:
                        runService (copy, index: 1)
                        context (copy, index: 2)
                        v698 (copy, index: 3)
                    ]]
                    runService:SetPredictionMode(context, v698)
                end
            )
        end
    end

    table.insert(
        v697,
        a694.DescendantAdded:Connect(
            function(context: Instance)
                --[[
                  name: off
                  line: 2157
                  upvalues:
                    runService (copy, index: 1)
                    v698 (copy, index: 2)
                ]]
                if context:IsA("BasePart") then
                    pcall(
                        function()
                            --[[
                              line: 2159
                              upvalues:
                                runService (copy, index: 1)
                                context (copy, index: 2)
                                v698 (copy, index: 3)
                            ]]
                            runService:SetPredictionMode(context, v698)
                        end
                    )
                end
            end
        )
    )

    table.insert(
        v697,
        a694.AncestryChanged:Connect(
            function()
                --[[
                  line: 2168
                  upvalues:
                    a694 (copy, index: 1)
                    v697 (copy, index: 2)
                    callback (copy, index: 3)
                ]]
                if not a694:IsDescendantOf(game) then
                    for _, v703 in v697 do
                        v703:Disconnect()
                    end

                    callback()
                end
            end
        )
    )
end

local function startRemoteCollisionGuard(localPlayer: Player?, a706)
    --[[
      name: startRemoteCollisionGuard
      line: 2193
      upvalues:
        runService (copy, index: 1)
        v9 (copy, index: 2)
    ]]
    local count = 0
    local instance = nil
    local v709 = {}
    local v710 = 0.25

    runService.Heartbeat:Connect(
        function(deltaTime: number)
            --[[
              line: 2198
              upvalues:
                v710 (ref,  index: 1)
                localPlayer (copy, index: 2)
                instance (ref,  index: 3)
                a706 (copy, index: 4)
                v709 (ref,  index: 5)
            ]]
            v710 += deltaTime

            if v710 < 0.25 then
                return
            end

            v710 = 0
            local character = localPlayer.Character
            local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
            instance = if humanoidRootPart and humanoidRootPart:IsA("BasePart") then humanoidRootPart else nil
            local v714 = {}

            if instance then
                local position = instance.Position

                for v716 in a706 do
                    local humanoidRootPart2 = v716:FindFirstChild("HumanoidRootPart")

                    if v716 ~= character then
                        if not humanoidRootPart2 then
                            continue
                        end
                        if not humanoidRootPart2:IsA("BasePart") then
                            continue
                        end
                        if 70 < (humanoidRootPart2.Position - position).Magnitude then
                            continue
                        end

                        local humanoid = v716:FindFirstChildOfClass("Humanoid")
                        if not humanoid then
                            continue
                        end

                        if not (humanoid.Health <= 0) and humanoidRootPart2:FindFirstChild("TribesHull") then
                            local parts = {}

                            for _, child in v716:GetChildren() do
                                if child:IsA("BasePart") then
                                    table.insert(parts, child)
                                end
                            end

                            table.insert(v714, {root = humanoidRootPart2, parts = parts})
                        end
                    end
                end
            end

            v709 = v714
        end
    )

    v9.BindStep(
        function()
            --[[
              line: 2230
              upvalues:
                instance (ref, index: 1)
                v709 (ref, index: 2)
                count (ref, index: 3)
            ]]
            local instance2 = instance
            if not instance2 then
                return
            end

            local position = instance2.Position

            for _, v725 in v709 do
                if not (40 < (v725.root.Position - position).Magnitude) then
                    local parts = v725.parts

                    for partKey = 1, #parts do
                        local part = parts[partKey]

                        if part.CanCollide then
                            part.CanCollide = false
                            count += 1
                        end
                    end
                end
            end
        end,
        1
    )

    v9.RemoteCollisionFixes = function()
        --[[
          line: 2250
          upvalues:
            count (ref, index: 1)
        ]]
        return count
    end
end

local function startPredictionPolicy(localPlayer: Player?)
    --[[
      name: startPredictionPolicy
      line: 2255
      upvalues:
        predictionOff (copy, index: 1)
        runService (copy, index: 2)
        players (copy, index: 3)
        startRemoteCollisionGuard (copy, index: 4)
    ]]
    local predictionMode
    local collectionService = game:GetService("CollectionService")
    local v733 = setmetatable({}, {__mode = "k"})

    local function apply(character: Model, a736)
        --[[
          name: apply
          line: 2258
          upvalues:
            v733 (copy, index: 1)
            predictionOff (copy, index: 2)
        ]]
        if character:IsA("Model") and not v733[character] then
            v733[character] = true
            predictionOff(
                character,
                function()
                    --[[
                      line: 2261
                      upvalues:
                        v733 (copy, index: 1)
                        character (copy, index: 2)
                    ]]
                    v733[character] = nil
                end,
                a736
            )
        end
    end

    local v737 = nil

    if runService:IsStudio() then
        local botPredictionMode = workspace:GetAttribute("BotPredictionMode")

        if botPredictionMode == "On" then
            predictionMode = Enum.PredictionMode.On
        elseif botPredictionMode == "Automatic" then
            predictionMode = Enum.PredictionMode.Automatic
        else
            predictionMode = v737
        end
    else
        predictionMode = v737
    end

    local function applyTagged(character)
        --[[
          name: applyTagged
          line: 2278
          upvalues:
            players (copy, index: 1)
            predictionMode (ref,  index: 2)
            v733 (copy, index: 3)
            predictionOff (copy, index: 4)
        ]]
        if character:IsA("Model") and players:GetPlayerFromCharacter(character) == nil then
            local predictionMode2 = predictionMode

            if character:IsA("Model") and not v733[character] then
                v733[character] = true
                predictionOff(
                    character,
                    function()
                        --[[
                          line: 2261
                          upvalues:
                            v733 (copy, index: 1)
                            character (copy, index: 2)
                        ]]
                        v733[character] = nil
                    end,
                    predictionMode2
                )
            end
        end
    end

    for _, tag in {"Combatant", "Bot"} do
        collectionService:GetInstanceAddedSignal(tag):Connect(applyTagged)

        for _, character in collectionService:GetTagged(tag) do
            if character:IsA("Model") then
                if players:GetPlayerFromCharacter(character) ~= nil then
                    continue
                end

                local predictionMode2 = predictionMode

                if character:IsA("Model") and not v733[character] then
                    v733[character] = true
                    predictionOff(
                        character,
                        function()
                            --[[
                              line: 2261
                              upvalues:
                                v733 (copy, index: 1)
                                character (copy, index: 2)
                            ]]
                            v733[character] = nil
                        end,
                        predictionMode2
                    )
                end
            end
        end
    end

    players.PlayerAdded:Connect(
        function(player: Player)
            --[[
              name: watchPlayer
              line: 2289
              upvalues:
                localPlayer (copy, index: 1)
                apply (copy, index: 2)
                v733 (copy, index: 3)
                predictionOff (copy, index: 4)
            ]]
            if player == localPlayer then
                return
            end

            player.CharacterAdded:Connect(apply)

            if player.Character then
                local character = player.Character

                if character:IsA("Model") and not v733[character] then
                    v733[character] = true
                    predictionOff(
                        character,
                        function()
                            --[[
                              line: 2261
                              upvalues:
                                v733 (copy, index: 1)
                                character (copy, index: 2)
                            ]]
                            v733[character] = nil
                        end,
                        nil
                    )
                end
            end
        end
    )

    for _, player in players:GetPlayers() do
        if player ~= localPlayer then
            player.CharacterAdded:Connect(apply)

            if not player.Character then
                continue
            end

            local character = player.Character

            if character:IsA("Model") and not v733[character] then
                v733[character] = true
                predictionOff(
                    character,
                    function()
                        --[[
                          line: 2261
                          upvalues:
                            v733 (copy, index: 1)
                            character (copy, index: 2)
                        ]]
                        v733[character] = nil
                    end,
                    nil
                )
            end
        end
    end

    if not runService:IsStudio() or workspace:GetAttribute("RemoteCollideGuardOff") ~= true then
        startRemoteCollisionGuard(localPlayer, v733)
    end
end

local function startRiseGuard(a753)
    --[[
      name: startRiseGuard
      line: 2338
      upvalues:
        workspace2 (copy, index: 1)
        jumpProp (copy, index: 2)
        jumpHeight (copy, index: 3)
        runService (copy, index: 4)
        v45 (copy, index: 5)
    ]]
    local gravity = workspace2.Gravity
    local v755 = math.sqrt((2 * gravity) * jumpProp(jumpHeight, gravity)) + 3

    runService.PostSimulation:Connect(
        function()
            --[[
              line: 2341
              upvalues:
                a753 (copy, index: 1)
                v45 (copy, index: 2)
                v755 (copy, index: 3)
            ]]
            local v756 = a753.Character
            v756 = v756 and v45[v756]

            if not v756 then
                return
            end

            local root = v756.root
            local y = root.AssemblyLinearVelocity.Y

            if y <= 55 and y <= v755 then
                return
            end

            local y2 = 55

            if root:GetAttribute("SFloat") ~= nil and root:GetAttribute("SKb") == nil then
                y2 = math.min(y2, v755)
            end

            if y2 < y then
                local assemblyLinearVelocity = root.AssemblyLinearVelocity
                root.AssemblyLinearVelocity = Vector3.new(assemblyLinearVelocity.X, y2, assemblyLinearVelocity.Z)
            end
        end
    )
end

local function startArrivalGuard(localPlayer: Player?)
    --[[
      name: startArrivalGuard
      line: 2368
      upvalues:
        runService (copy, index: 1)
        workspace2 (copy, index: 2)
        v9 (copy, index: 3)
    ]]
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.RespectCanCollide = true
    raycastParams.IgnoreWater = true
    local humanoidRootPart = nil
    local position = nil
    local v766 = false
    local v767 = 0
    local humanoidRootPart2 = nil
    local count = 0
    local total = 0

    local function release()
        --[[
          name: release
          line: 2378
          upvalues:
            humanoidRootPart2 (ref, index: 1)
        ]]
        local humanoidRootPart = humanoidRootPart2
        humanoidRootPart2 = nil

        if humanoidRootPart and humanoidRootPart.Parent and humanoidRootPart.Anchored then
            humanoidRootPart.Anchored = false
        end
    end

    runService.PreSimulation:Connect(
        function(deltaTimeSim: number)
            --[[
              line: 2385
              upvalues:
                localPlayer (copy, index: 1)
                humanoidRootPart (ref,  index: 2)
                position (ref,  index: 3)
                v766 (ref,  index: 4)
                humanoidRootPart2 (ref,  index: 5)
                v767 (ref,  index: 6)
                raycastParams (copy, index: 7)
                workspace2 (copy, index: 8)
                count (ref,  index: 9)
                total (ref,  index: 10)
            ]]
            local character = localPlayer.Character
            local humanoidRootPart3 = character and character:FindFirstChild("HumanoidRootPart")

            if not character or not humanoidRootPart3 or not humanoidRootPart3:IsA("BasePart") then
                humanoidRootPart = nil
                position = nil
                v766 = false
                humanoidRootPart2 = nil

                return
            end

            local position2 = humanoidRootPart3.Position
            local v777 = humanoidRootPart3 ~= humanoidRootPart

            if not v777 and position then
                v777 = 20 < (position2 - position - (humanoidRootPart3.AssemblyLinearVelocity * deltaTimeSim)).Magnitude
            end

            if v777 then
                if humanoidRootPart2 and humanoidRootPart2 ~= humanoidRootPart3 then
                    humanoidRootPart2 = nil
                end

                v766 = true
                v767 = 0
            end

            humanoidRootPart = humanoidRootPart3
            position = position2

            if not v766 then
                return
            end

            v767 += deltaTimeSim
            local humanoid = character:FindFirstChildOfClass("Humanoid")

            if humanoid and not (humanoid.Health <= 0) then
                raycastParams.FilterDescendantsInstances = {character}
                local raycastResult = workspace2:Raycast(position2, Vector3.new(0, -80, 0), raycastParams)
                local v780 = raycastResult ~= nil and position2.Y - raycastResult.Position.Y <= 12

                if not (v780) and (raycastResult == nil or not (6 <= v767)) and not (12 <= v767) then
                    if not humanoidRootPart3.Anchored then
                        humanoidRootPart3.Anchored = true
                        humanoidRootPart2 = humanoidRootPart3
                        count += 1
                    end

                    if humanoidRootPart2 == humanoidRootPart3 then
                        total += deltaTimeSim
                    end
                else
                    v766 = false
                    local humanoidRootPart4 = humanoidRootPart2
                    humanoidRootPart2 = nil

                    if humanoidRootPart4 and humanoidRootPart4.Parent and humanoidRootPart4.Anchored then
                        humanoidRootPart4.Anchored = false
                    end
                end
            else
                v766 = false
                local humanoidRootPart5 = humanoidRootPart2
                humanoidRootPart2 = nil

                if humanoidRootPart5 and humanoidRootPart5.Parent and humanoidRootPart5.Anchored then
                    humanoidRootPart5.Anchored = false
                end
            end
        end
    )

    v9.ArrivalHolds = function()
        --[[
          line: 2433
          upvalues:
            count (ref, index: 1)
            total (ref, index: 2)
        ]]
        return count, total
    end
end

local hasRun2 = false

function v9.Initialize()
    --[[
      name: Initialize
      line: 2442
      upvalues:
        hasRun2 (ref,  index: 1)
        isServer (copy, index: 2)
        players (copy, index: 3)
        onPlayer (copy, index: 4)
        v45 (copy, index: 5)
        v46 (copy, index: 6)
        runService (copy, index: 7)
        v29 (copy, index: 8)
        v9 (copy, index: 9)
        Inputs (copy, index: 10)
        v625 (copy, index: 11)
        fire (copy, index: 12)
        startPredictionPolicy (copy, index: 13)
        watchHold (copy, index: 14)
        clientAuthority (copy, index: 15)
        startArrivalGuard (copy, index: 16)
        workspace2 (copy, index: 17)
        jumpProp (copy, index: 18)
        jumpHeight (copy, index: 19)
        WriteGuard (copy, index: 20)
        step (copy, index: 21)
    ]]
    if hasRun2 then
        return
    end

    hasRun2 = true

    if isServer then
        for _, player in players:GetPlayers() do
            onPlayer(player)
        end

        players.PlayerAdded:Connect(onPlayer)

        players.PlayerRemoving:Connect(
            function(player: Player)
                --[[
                  line: 2452
                  upvalues:
                    v45 (copy, index: 1)
                    v46 (copy, index: 2)
                ]]
                if player.Character then
                    local character = player.Character
                    local v788 = v45[character]
                    if not v788 then
                        return
                    end

                    v45[character] = nil

                    for _, conn in v788.conns do
                        conn:Disconnect()
                    end

                    table.clear(v46)

                    for _, v792 in v45 do
                        table.insert(v46, v792)
                    end
                end
            end
        )

        if runService:IsStudio() then
            local simulationDebug = Instance.new("BindableFunction")
            simulationDebug.Name = "SimulationDebug"

            simulationDebug.OnInvoke = function(a794, a795, a796)
                --[[
                  line: 2461
                  upvalues:
                    v45 (copy, index: 1)
                    v29 (copy, index: 2)
                    v9 (copy, index: 3)
                    v46 (copy, index: 4)
                ]]
                local v797 = a795 and a795.Character and v45[a795.Character]

                if a794 == "state" and v797 then
                    local v798 = {}

                    for _, v800 in v29 do
                        v798[v800] = v797.root:GetAttribute(v800)
                    end

                    v798.walkSpeed = v797.humanoid.WalkSpeed
                    v798.jumpHeight = v797.humanoid.JumpHeight

                    return v798
                end

                if a794 == "knockback" and v797 then
                    return v9.Knockback(v797.character, a796)
                end
                if a794 == "teleport" and v797 then
                    return v9.Teleport(v797.character, a796)
                end
                if a794 == "count" then
                    return #v46
                end
                if a794 == "perf" then
                    return v9.DebugStats()
                end

                return nil
            end

            simulationDebug.Parent = game:GetService("ServerStorage")
        end
    else
        local localPlayer = players.LocalPlayer

        task.spawn(
            function()
                --[[
                  line: 2486
                  upvalues:
                    localPlayer (copy, index: 1)
                    Inputs (copy, index: 2)
                    v625 (copy, index: 3)
                    fire (copy, index: 4)
                ]]
                local child = localPlayer:WaitForChild(Inputs.CONTEXT, 60)
                if not child then
                    warn("[Simulation] TribesInputs never arrived")
                    return
                end

                for _, action in Inputs.ACTIONS do
                    local instance = child:WaitForChild(action.name, 10)
                    instance = instance and instance:WaitForChild("Script", 10)

                    if instance and instance:IsA("InputBinding") then
                        v625[action.name] = instance
                        fire(action.name)
                    end
                end
            end
        )

        onPlayer(localPlayer)
        startPredictionPolicy(localPlayer)
        watchHold(localPlayer)

        if clientAuthority then
            startArrivalGuard(localPlayer)
            local gravity = workspace2.Gravity
            local v807 = math.sqrt((2 * gravity) * jumpProp(jumpHeight, gravity)) + 3

            runService.PostSimulation:Connect(
                function()
                    --[[
                      line: 2341
                      upvalues:
                        localPlayer (copy, index: 1)
                        v45 (copy, index: 2)
                        v807 (copy, index: 3)
                    ]]
                    local v808 = localPlayer.Character
                    v808 = v808 and v45[v808]

                    if not v808 then
                        return
                    end

                    local root = v808.root
                    local y = root.AssemblyLinearVelocity.Y

                    if y <= 55 and y <= v807 then
                        return
                    end

                    local y2 = 55

                    if root:GetAttribute("SFloat") ~= nil and root:GetAttribute("SKb") == nil then
                        y2 = math.min(y2, v807)
                    end

                    if y2 < y then
                        local assemblyLinearVelocity = root.AssemblyLinearVelocity
                        root.AssemblyLinearVelocity = Vector3.new(assemblyLinearVelocity.X, y2, assemblyLinearVelocity.Z)
                    end
                end
            )
        end

        if runService:IsStudio() and not clientAuthority then
            WriteGuard.Start(localPlayer)
        end
    end

    if runService:IsStudio() and workspace:GetAttribute("SimDisabled") == true then
        warn("[Simulation] disabled by the Studio test knob workspace.SimDisabled (engine-only baseline)")
        return
    end

    v9.BindStep(step, 2100)
end

return v9