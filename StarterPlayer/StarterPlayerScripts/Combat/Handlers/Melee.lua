local function Ready(self)
    --[[
      name: Ready
      line: 252
    ]]
    local timestamp = os.clock()
    return self.busyUntil <= timestamp and self:Cooldown() <= timestamp - self.lastSwing
end

local parent = script.Parent.Parent
local Simulation = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Simulation"))
local Util = require(parent.Util)
local Hud = require(parent.Hud)
local Effects = require(parent.Effects)
local Guard = require(parent.Guard)
local Combat = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Combat"))
local Touch = require(parent.Touch)
local Class = {}
Class.__index = Class
local v13 = {}

function Class.new(ctx)
    --[[
      name: new
      line: 28
      upvalues:
        Class (copy, index: 1)
    ]]
    local v15 = setmetatable({}, Class)
    v15.ctx = ctx
    v15.tuning = ctx.tuning
    v15.preset = ctx.preset
    v15.lastSwing = 0
    v15.combo = 0
    v15.holding = false
    v15.busyUntil = 0
    v15.blocking = false
    v15.blockHeld = false
    v15.guardFirst = false
    v15.strikes = 0
    v15.charging = nil
    v15.chargeStart = 0
    v15.lastSpecial = -math.huge
    v15.bufferedAt = nil
    v15.fullPlayed = false
    v15.lastThrow = -math.huge
    v15.thrownLocalUntil = 0
    v15.parryHeld = false
    v15.parrying = false
    v15.parryReadyAt = 0
    v15.lastParryUp = -math.huge
    v15.parryUpAt = 0
    v15.conns = {}
    return v15
end

function Class.OneHanded(self)
    --[[
      name: OneHanded
      line: 58
      upvalues:
        Util (copy, index: 1)
    ]]
    local v17 = Util.Probe(self)
    if v17 ~= nil then
        return v17
    end
    if type(self.tuning.oneHanded) ~= "table" then
        return false
    end

    local tool = self.ctx.tool

    return tool ~= nil and tool:GetAttribute("Thrown") == true or os.clock() < self.thrownLocalUntil
end

function Class.Cooldown(self)
    --[[
      name: Cooldown
      line: 70
    ]]
    if self:OneHanded() then
        return self.tuning.oneHanded.cooldown or 0.45
    end

    return self.tuning.cooldown or 0.5
end

function Class.Equip(self)
    --[[
      name: Equip
      line: 77
      upvalues:
        Hud (copy, index: 1)
        Util (copy, index: 2)
        v13 (copy, index: 3)
        Simulation (copy, index: 4)
        Touch (copy, index: 5)
        Combat (copy, index: 6)
    ]]
    local ctx = self.ctx
    Hud.SetStyle("Melee")

    if self.preset.hold then
        Util.PlayAnim(ctx.animator, self.preset.hold, 1, 0.2)
    end

    if self.preset.equip and ctx.tool then
        Util.Sound(self.preset.equip, ctx.root)
    end

    local tool = ctx.tool
    local lunge = self.tuning.lunge

    if tool and type(lunge) == "table" and lunge.refreshOnKill then
        local refreshed = tool:GetAttribute("Refreshed")

        if type(refreshed) == "number" and v13[ctx.weaponId] and v13[ctx.weaponId] < refreshed then
            Simulation.RefreshDash(ctx.char, ctx.weaponId)
        end

        table.insert(
            self.conns,
            tool:GetAttributeChangedSignal("Refreshed"):Connect(
                function()
                    --[[
                      line: 96
                      upvalues:
                        Simulation (copy, index: 1)
                        ctx (copy, index: 2)
                        self (copy, index: 3)
                        Hud (copy, index: 4)
                        Util (copy, index: 5)
                    ]]
                    Simulation.RefreshDash(ctx.char, ctx.weaponId)
                    self.lastSpecial = -math.huge
                    Hud.SetArc(0)
                    Util.Sound((self.preset.refreshSound or "Charge_Full"), ctx.root)
                    ctx.emit("Refresh", {})
                end
            )
        )
    end

    if tool and type(self.tuning.throw) == "table" then
        local thrown

        if tool:GetAttribute("Thrown") == true then
            thrown = true
        else
            thrown = false
        end

        Touch.SetAltDim(thrown)

        table.insert(
            self.conns,
            tool:GetAttributeChangedSignal("Thrown"):Connect(
                function()
                    --[[
                      line: 109
                      upvalues:
                        tool (copy, index: 1)
                        thrown (ref,  index: 2)
                        self (copy, index: 3)
                        Combat (copy, index: 4)
                        Touch (copy, index: 5)
                        ctx (copy, index: 6)
                        Hud (copy, index: 7)
                    ]]
                    local v26
                    local thrown2 = tool:GetAttribute("Thrown") == true

                    if thrown2 == thrown then
                        return
                    end

                    thrown = thrown2
                    self.thrownLocalUntil = 0
                    Combat.ShowOffHand(tool, not thrown2)

                    if thrown2 then
                        Touch.SetAltDim(true)
                        return
                    end

                    ctx.emit("Catch", {})
                    local cooldown = tool:GetAttribute("Cooldown")

                    if type(cooldown) ~= "number" then
                        v26 = 0
                    else
                        v26 = cooldown - workspace:GetServerTimeNow()
                    end

                    local cooldown2 = self.tuning.throw.cooldown or 0.45

                    if 0.05 < v26 then
                        Hud.SetArc(cooldown2, Color3.fromRGB(214, 170, 120), (math.max(0, cooldown2 - v26)))

                        task.delay(
                            v26,
                            function()
                                --[[
                                  line: 129
                                  upvalues:
                                    tool (copy, index: 1)
                                    ctx (copy, index: 2)
                                    Touch (copy, index: 3)
                                ]]
                                if tool.Parent == ctx.char and tool:GetAttribute("Thrown") ~= true then
                                    Touch.SetAltDim(false)
                                end
                            end
                        )

                        return
                    end

                    Hud.SetArc(0)
                    Touch.SetAltDim(false)
                end
            )
        )
    end
end

function Class.Unequip(self)
    --[[
      name: Unequip
      line: 142
      upvalues:
        Touch (copy, index: 1)
        Util (copy, index: 2)
        Hud (copy, index: 3)
    ]]
    local ctx = self.ctx

    for _, conn in self.conns do
        conn:Disconnect()
    end

    table.clear(self.conns)
    self.holding = false
    self.bufferedAt = nil

    if self.blocking then
        self:SetBlock(false)
    end

    self.blockHeld = false
    self.parryHeld = false

    if type(self.tuning.throw) == "table" then
        Touch.SetAltDim(false)
    end

    self:LowerParry(true, nil, true)

    if self.charging then
        self:CancelCharge()
    end

    if self.preset.hold then
        Util.StopAnim(ctx.animator, self.preset.hold, 0.15)
    end

    Hud.SetCharge(0)
    Hud.SetGuard(nil)
end

function Class.Detect(self, a35, a36: number, a37: number)
    --[[
      name: Detect
      line: 170
      upvalues:
        Util (copy, index: 1)
    ]]
    local v38 = Util.Probe(self, a35)
    if v38 ~= nil then
        return v38
    end

    local ctx = self.ctx
    local root = ctx.root
    local position = if const head = ctx.char:FindFirstChild("Head") then head.Position else root.Position
    local aimRay = Util.GetAimRay()
    local v44 = Vector3.new(aimRay.Direction.X, 0, aimRay.Direction.Z)

    if v44.Magnitude < 0.05 then
        v44 = root.CFrame.LookVector
    end

    local unit = v44.Unit
    local v46 = math.cos((math.rad(a36)))
    local v47 = {}
    local v48 = Util.Targets()
    local raycastParams = Util.WorldParams(v48)

    for _, model in v48 do
        if not Util.IsTeammate(model) then
            local humanoid = model:FindFirstChildOfClass("Humanoid")
            local humanoidRootPart = model:FindFirstChild("HumanoidRootPart")

            if not humanoid then
                continue
            end
            if not humanoidRootPart then
                continue
            end
            if not (0 < humanoid.Health) then
                continue
            end

            local v54 = humanoidRootPart.Position - root.Position
            local magnitude = v54.Magnitude

            if magnitude <= a35 + 1.2 and math.abs(v54.Y) < 8 then
                local vector3 = Vector3.new(v54.X, 0, v54.Z)

                if (magnitude < 3.2 or 0.05 < vector3.Magnitude and v46 <= vector3.Unit:Dot(unit))
                    and not workspace:Raycast(position, humanoidRootPart.Position - position, raycastParams)
                then
                    table.insert(v47, {model = model, dist = magnitude})
                end
            end
        end
    end

    table.sort(
        v47,
        function(left, right)
            --[[
              line: 207
            ]]
            return left.dist < right.dist
        end
    )
    local v59 = {}

    for index = 1, math.min(#v47, a37) do
        table.insert(v59, v47[index].model)
    end

    return v59
end

local function predictImpacts(hits, hitSound, a64, a65, root, weaponId)
    --[[
      name: predictImpacts
      line: 221
      upvalues:
        Util (copy, index: 1)
        Effects (copy, index: 2)
    ]]
    a64 = a64 and a64 * Util.ItemBonus(weaponId)

    for _, v69 in hits do
        if Util.CanPredictHit(v69) then
            local v70 = v69:FindFirstChild("UpperTorso")
                or v69:FindFirstChild("Torso")
                or v69:FindFirstChild("HumanoidRootPart")

            if v70 and v70:IsA("BasePart") and root and Util.ParryFacing(v69, v70.Position - root.Position) then
                continue
            end
            if not v70 then
                continue
            end
            if not v70:IsA("BasePart") then
                continue
            end

            local v71 = a64
            local v72 = false
            local humanoidRootPart = v69:FindFirstChild("HumanoidRootPart")

            if v71 and a65 and a65.backstabMult and root and humanoidRootPart and humanoidRootPart:IsA("BasePart") then
                local v74 = (root.Position - humanoidRootPart.Position) * Vector3.new(1, 0, 1)
                local v75 = -(humanoidRootPart.CFrame.LookVector * Vector3.new(1, 0, 1))

                if 0.05 < v74.Magnitude and 0.05 < v75.Magnitude then
                    local v76 = v74.Unit:Dot(v75.Unit)

                    if math.cos((math.rad((a65.backstabAngle or 70)))) <= v76 then
                        v71 *= a65.backstabMult
                        v72 = true
                    end
                end
            end

            Effects.CharacterImpact(v70.Position, nil, false)
            Effects.PredictHit(v69, hitSound, v70.Position + Vector3.new(0, 1, 0), false, v71, v72)
        end
    end
end

Class.Ready = Ready

function Class.Swing(self)
    --[[
      name: Swing
      line: 257
      upvalues:
        Util (copy, index: 1)
        Class (copy, index: 2)
        Effects (copy, index: 3)
        predictImpacts (copy, index: 4)
    ]]
    local ctx = self.ctx
    local tuning = self.tuning
    local preset = self.preset
    local timestamp = os.clock()

    if not self:Ready() or not Util.CanAct() or 0 < Util.GuardRecovery(self.ctx.tool) then
        return false
    end

    local v82
    local v83
    self.bufferedAt = nil
    local oneHanded = self:OneHanded()

    if const v85 = Util.ProbeValues() then
        if v85.m and Class.OneHanded(v85.m) ~= v85.m then
            Util.Hooked()
        end
    end

    if oneHanded then
        v82 = tuning.oneHanded.combo or {1}
    else
        v82 = tuning.combo or {1}
    end

    if timestamp - self.lastSwing <= (tuning.comboWindow or 1) then
        self.combo = (self.combo % #v82) + 1
    else
        self.combo = 1
    end

    self.lastSwing = timestamp
    local combo = self.combo
    local finisher = 2 < #v82 and combo == #v82
    Util.MeleeAssist((tuning.range or 8))
    Util.FaceCamera()
    local v88 = if oneHanded then preset.oneSwings else nil
    v88 = v88 or preset.swings or {}
    local v89 = v88[((combo - 1) % math.max(1, #v88)) + 1]
    local playAnim = Util.PlayAnim
    local animator = ctx.animator
    local swingSpeed = preset.swingSpeed or 1

    if finisher then
        v83 = 0.95
    else
        v83 = 1
    end

    playAnim(animator, v89, swingSpeed * v83, 0.05)
    ctx.emit("Swing", {step = combo, finisher = finisher, hitDelay = preset.hitDelay or 0.1, oneHanded = oneHanded})
    local hitDelay = preset.hitDelay or 0.1
    local v94 = if 0.15 <= hitDelay then hitDelay - 0.04 else math.max(0, hitDelay - 0.1)

    if not (0.05 <= v94) then
        local playbackSpeed
        local sound = Util.Sound
        local swingSound = preset.swingSound or "Swing_Sword"
        local root = ctx.root
        local v99 = {}

        if finisher then
            playbackSpeed = 0.88
        else
            playbackSpeed = 1
        end

        v99.PlaybackSpeed = playbackSpeed
        sound(swingSound, root, v99)
    else
        task.delay(
            v94,
            function()
                --[[
                  name: whoosh
                  line: 293
                  upvalues:
                    Util (copy, index: 1)
                    preset (copy, index: 2)
                    ctx (copy, index: 3)
                    finisher (copy, index: 4)
                ]]
                local playbackSpeed
                local sound = Util.Sound
                local swingSound = preset.swingSound or "Swing_Sword"
                local root = ctx.root
                local v104 = {}

                if finisher then
                    playbackSpeed = 0.88
                else
                    playbackSpeed = 1
                end

                v104.PlaybackSpeed = playbackSpeed
                sound(swingSound, root, v104)
            end
        )
    end

    local v105 = Util.InFirstPerson()

    if preset.trail and 0 < preset.trail and not v105 then
        Effects.Trail(ctx.tool, preset.trail)
    end

    local hitDelay2 = preset.hitDelay or 0.1
    self.strikes += 1

    if not preset.noSlash and ctx.tool and not v105 then
        task.delay(
            hitDelay2 * 0.6,
            function()
                --[[
                  line: 308
                  upvalues:
                    Effects (copy, index: 1)
                    ctx (copy, index: 2)
                    combo (copy, index: 3)
                    finisher (copy, index: 4)
                    preset (copy, index: 5)
                    tuning (copy, index: 6)
                ]]
                Effects.Slash(ctx.char, combo, finisher, preset.slashColor, tuning.range)
            end
        )
    end

    task.delay(
        hitDelay2,
        function()
            --[[
              line: 312
              upvalues:
                self (copy, index: 1)
                ctx (copy, index: 2)
                Util (copy, index: 3)
                Class (copy, index: 4)
                tuning (copy, index: 5)
                timestamp (copy, index: 6)
                predictImpacts (copy, index: 7)
                preset (copy, index: 8)
                v82 (copy, index: 9)
                combo (copy, index: 10)
                finisher (copy, index: 11)
            ]]
            self.strikes -= 1

            if not ctx.alive() then
                return
            end

            Util.FaceCamera()

            if const v107 = Util.ProbeValues() then
                if v107.m and Class.Detect(v107.m, 1, 2, 3) ~= v107.m then
                    Util.Hooked()
                end
            end

            local hits = self:Detect(tuning.range or 8, tuning.arc or 60, tuning.maxTargets or 1)
            ctx.send("Swing", {tool = ctx.tool, dir = Util.GetAimRay().Direction, hits = hits, k = math.floor((os.clock() - timestamp) * 1000)})
            predictImpacts(hits, (preset.hitSound or "Hit_Melee"), (tuning.damage or 10) * (v82[combo] or 1), tuning, ctx.root, ctx.weaponId)

            if 0 < #hits then
                local shake = Util.Shake
                local shake2 = preset.shake or 0.18
                local v111 = finisher and 1.4 or 1
                shake(shake2 * v111, 0.14)
                local recoil = Util.Recoil
                local v113 = finisher and 1.4 or 0.7
                recoil(v113, (math.random() - 0.5) * 0.8)
            end
        end
    )

    return true
end

local timestamp = -math.huge

function Class.CanGuard(self)
    --[[
      name: CanGuard
      line: 345
      upvalues:
        Util (copy, index: 1)
    ]]
    local v116 = false

    if self.strikes <= 0 then
        v116 = false
        local timestamp = os.clock()

        if self.busyUntil <= timestamp then
            return Util.CanAct() and not self:GuardBroken()
        end
    end

    return v116
end

function Class.GuardBroken(self)
    --[[
      name: GuardBroken
      line: 350
      upvalues:
        Combat (copy, index: 1)
    ]]
    local block = self.tuning.block
    return type(block) == "table"
        and block.durability ~= nil
        and 0 < Combat.GuardBrokenLeft(self.ctx.char, workspace:GetServerTimeNow())
end

function Class.DrawGuard(self)
    --[[
      name: DrawGuard
      line: 356
      upvalues:
        Combat (copy, index: 1)
        Hud (copy, index: 2)
    ]]
    local block = self.tuning.block
    local durability = type(block) == "table" and block.durability
    if not durability then
        return
    end

    local serverTimeNow = workspace:GetServerTimeNow()
    local v124, v125 = Combat.GuardHp(self.ctx.char, durability, serverTimeNow)
    local v126 = 0 < Combat.GuardBrokenLeft(self.ctx.char, serverTimeNow)
    local setGuard = Hud.SetGuard
    local v128 = if not self.blocking and not v126 and not (v124 < v125) then nil else v124 / v125
    setGuard(v128, v126)
end

function Class.SetBlock(self, block2)
    --[[
      name: SetBlock
      line: 368
      upvalues:
        Util (copy, index: 1)
        Hud (copy, index: 2)
        Guard (copy, index: 3)
        timestamp (ref,  index: 4)
    ]]
    local ctx = self.ctx

    if self.blocking == block2 then
        return
    end

    self.blocking = block2

    if block2 then
        self.bufferedAt = nil
    else
        local block = self.tuning.block
        local guardDown = Util.GuardDown
        local tool = ctx.tool
        local swapDelay = type(block) == "table" and block.swapDelay or nil
        guardDown(tool, swapDelay)
    end

    ctx.send("Block", {tool = ctx.tool, on = block2})
    ctx.emit("Block", {on = block2})
    Hud.SetBlocking(block2)
    Guard.SetLocal(block2)

    if block2 then
        Util.PlayAnim(ctx.animator, self.preset.block, 1, 0.1)
    else
        Util.StopAnim(ctx.animator, self.preset.block, 0.12)
    end

    if block2 then
        local timestamp2 = os.clock()

        if 0.5 <= timestamp2 - timestamp then
            timestamp = timestamp2
            Util.Sound("Block_Up", ctx.root)
        end

        local v137 = Util.ProbeValues()
        local speedMult = self.tuning.block and self.tuning.block.speedMult or 0.6
        local v139 = ctx.setSpeed("Block", speedMult)
        local v140 = v137 and v137.k * (speedMult or 1)

        if v139 ~= v140 then
            Util.Hooked()
        end
    else
        ctx.setSpeed("Block", nil)
    end
end

function Class.SpecialInfo(self, a142)
    --[[
      name: SpecialInfo
      line: 406
    ]]
    local v143 = if a142 == "Heavy" then self.tuning.heavy else self.tuning.lunge
    return v143 or {}
end

function Class.SpecialReady(self, a145, a146)
    --[[
      name: SpecialReady
      line: 415
      upvalues:
        Simulation (copy, index: 1)
    ]]
    if a146 - self.lastSpecial < (a145.cooldown or 1) then
        return false
    end
    if a145 == self.tuning.lunge and not Simulation.DashReady(self.ctx.char, self.ctx.weaponId) then
        return false
    end

    local cooldown = self.ctx.tool and self.ctx.tool:GetAttribute("Cooldown")
    local v148 = type(cooldown) == "number" and workspace:GetServerTimeNow() < cooldown

    return not v148
end

function Class.StartCharge(self, a150)
    --[[
      name: StartCharge
      line: 426
      upvalues:
        Util (copy, index: 1)
    ]]
    local ctx = self.ctx
    local timestamp = os.clock()
    local v153 = self:SpecialInfo(a150)

    if not self:SpecialReady(v153, timestamp) or timestamp < self.busyUntil or not Util.CanAct() then
        return
    end

    self.charging = a150
    self.chargeStart = timestamp
    self.bufferedAt = nil
    self.fullPlayed = false
    ctx.send("Charge", {on = true, tool = ctx.tool, kind = a150})
    ctx.emit("Charge", {on = true, kind = a150, time = v153.charge or 0.6})
    local playHold = Util.PlayHold
    local animator = ctx.animator
    local v156 = if a150 == "Heavy" then self.preset.heavyCharge else self.preset.lungeCharge
    playHold(animator, v156, 1)
    Util.Sound((self.preset.chargeSound or "Charge_Up"), ctx.root)
    local v157 = Util.ProbeValues()
    local speedMult = v153.speedMult or 0.55
    local v159 = ctx.setSpeed("Charge", speedMult)
    local v160 = v157 and v157.k * (speedMult or 1)

    if v159 ~= v160 then
        Util.Hooked()
    end
end

function Class.CancelCharge(self)
    --[[
      name: CancelCharge
      line: 447
      upvalues:
        Util (copy, index: 1)
        Hud (copy, index: 2)
    ]]
    local ctx = self.ctx
    local charging = self.charging
    self.charging = nil

    if charging then
        ctx.send("Charge", {on = false, tool = ctx.tool, kind = charging})
        ctx.emit("Charge", {on = false, kind = charging})
        local stopAnim = Util.StopAnim
        local animator = ctx.animator
        local v166 = if charging == "Heavy" then self.preset.heavyCharge else self.preset.lungeCharge
        stopAnim(animator, v166, 0.1)
    end

    ctx.setSpeed("Charge", nil)
    Hud.SetCharge(0)
end

function Class.Dash(self)
    --[[
      name: Dash
      line: 462
      upvalues:
        Util (copy, index: 1)
    ]]
    local ctx = self.ctx
    local v169 = self:SpecialInfo("Lunge")
    local timestamp = os.clock()

    if not self:SpecialReady(v169, timestamp) or timestamp < self.busyUntil or not Util.CanAct() then
        return
    end

    self.bufferedAt = nil
    ctx.send("Charge", {kind = "Lunge", on = true, tool = ctx.tool})
    self.charging = "Lunge"
    self.chargeStart = timestamp - 1
    self:ReleaseCharge()
end

function Class.ReleaseCharge(self)
    --[[
      name: ReleaseCharge
      line: 476
      upvalues:
        Util (copy, index: 1)
        Hud (copy, index: 2)
        Effects (copy, index: 3)
        predictImpacts (copy, index: 4)
        Simulation (copy, index: 5)
        v13 (copy, index: 6)
    ]]
    local v172
    local ctx = self.ctx
    local tuning = self.tuning
    local preset = self.preset
    local charging = self.charging
    if not charging then
        return
    end

    local v177 = self:SpecialInfo(charging)

    if os.clock() - self.chargeStart < (v177.charge or 0.6) then
        self:CancelCharge()
        return
    end

    self.charging = nil
    self.lastSpecial = os.clock()
    local stopAnim = Util.StopAnim
    local animator = ctx.animator
    local v180 = if charging == "Heavy" then preset.heavyCharge else preset.lungeCharge
    stopAnim(animator, v180, 0.05)
    ctx.setSpeed("Charge", nil)
    Hud.SetCharge(0)
    Hud.SetArc((v177.cooldown or 1), Color3.fromRGB(228, 232, 240))
    local meleeAssist = Util.MeleeAssist

    if charging ~= "Heavy" then
        v172 = (v177.range or 12) + (v177.distance or 16) * 0.5
    else
        v172 = v177.range or (tuning.range or 9) + 1
    end

    meleeAssist(v172, charging ~= "Heavy")
    Util.FaceCamera()

    if charging == "Heavy" then
        self.busyUntil = os.clock() + 0.55
        ctx.emit("Heavy", {hitDelay = preset.heavyDelay or 0.16})
        Util.PlayAnim(ctx.animator, (preset.heavySwing or "Axe_Heavy"), 1.15, 0.04)
        Util.Sound((preset.heavySound or "Swing_Heavy"), ctx.root)
        local heavyDelay = preset.heavyDelay or 0.16

        if not Util.InFirstPerson() then
            Effects.Trail(ctx.tool, 0.5)
            task.delay(
                heavyDelay * 0.6,
                function()
                    --[[
                      line: 507
                      upvalues:
                        Effects (copy, index: 1)
                        ctx (copy, index: 2)
                        preset (copy, index: 3)
                        v177 (copy, index: 4)
                        tuning (copy, index: 5)
                    ]]
                    Effects.Slash(ctx.char, 1, true, preset.slashColor, (v177.range or tuning.range))
                end
            )
        end

        task.delay(
            heavyDelay,
            function()
                --[[
                  line: 511
                  upvalues:
                    ctx (copy, index: 1)
                    Util (copy, index: 2)
                    self (copy, index: 3)
                    v177 (copy, index: 4)
                    tuning (copy, index: 5)
                    predictImpacts (copy, index: 6)
                    preset (copy, index: 7)
                    Effects (copy, index: 8)
                ]]
                if not ctx.alive() then
                    return
                end

                Util.FaceCamera()
                local v183 = v177.range or (tuning.range or 9) + 1
                local hits = self:Detect(v183, math.min((tuning.arc or 60) + 10, 90), tuning.maxTargets or 2)
                ctx.send("Swing", {heavy = true, tool = ctx.tool, dir = Util.GetAimRay().Direction, hits = hits})
                predictImpacts(hits, (preset.hitSound or "Hit_Melee_Heavy"), v177.damage, nil, ctx.root, ctx.weaponId)

                if preset.slam == false then
                    if 0 < #hits then
                        Util.Shake(0.6, 0.15)
                        Util.Recoil(1.5, 0)
                    end
                else
                    local v185
                    local shake = Util.Shake

                    if not (0 < #hits) then
                        v185 = 0.45
                        v185 = Util
                    else
                        v185 = 0.9
                        v185 = Util
                    end

                    shake(v185, 0.25)
                    local recoil = v185.Recoil
                    local v188 = not (0 < #hits) and 1.2 or 2.5
                    recoil(v188, 0)
                end

                if preset.slam ~= false then
                    local v189 = ctx.root.CFrame * CFrame.new(0, -2.8, -4)
                    Effects.Burst("Ground_Slam", v189)
                    Effects.GroundScuff(v189.Position)
                end
            end
        )

        return
    end

    self.busyUntil = os.clock() + 0.45
    local root = ctx.root
    local aimRay = Util.GetAimRay()
    local v192 = Vector3.new(aimRay.Direction.X, 0, aimRay.Direction.Z)

    if not (0.05 < v192.Magnitude) then
        v192 = root.CFrame.LookVector
    else
        v192 = v192.Unit
    end

    Util.PlayAnim(ctx.animator, (preset.lunge or "Spear_Stab"), (preset.lungeAnimSpeed or 0.8), 0.03)
    Util.Sound((preset.lungeSound or "Lunge"), root)

    if not Util.InFirstPerson() then
        Effects.Trail(ctx.tool, 0.4)

        if preset.lungeSlash then
            task.delay(
                0.08,
                function()
                    --[[
                      line: 550
                      upvalues:
                        Effects (copy, index: 1)
                        ctx (copy, index: 2)
                        preset (copy, index: 3)
                        v177 (copy, index: 4)
                    ]]
                    Effects.Slash(ctx.char, 1, true, preset.slashColor, (v177.range or 8) + 2)
                end
            )
        end
    end

    Simulation.Pulse("Lunge", 0.15)
    v13[ctx.weaponId] = workspace:GetServerTimeNow()
    local time = math.clamp((v177.distance or 16) / (v177.speed or 70), 0.12, 0.35)
    Util.FovKick(6, 0.05, time + 0.05)

    if preset.lungeLines and Util.InFirstPerson() then
        Effects.DashLines(time + 0.12)
    end

    ctx.emit("Lunge", {time = time})
    local v194 = {}
    local hits = {}

    for index = 0, 3 do
        task.delay(
            (time / 3) * index,
            function()
                --[[
                  line: 568
                  upvalues:
                    self (copy, index: 1)
                    v177 (copy, index: 2)
                    tuning (copy, index: 3)
                    v194 (copy, index: 4)
                    hits (copy, index: 5)
                ]]
                for _, v198 in self:Detect(v177.range or 12, v177.arc or 35, tuning.maxTargets or 2) do
                    if not v194[v198] and #hits < (tuning.maxTargets or 2) then
                        v194[v198] = true
                        table.insert(hits, v198)
                    end
                end
            end
        )
    end

    task.delay(
        time,
        function()
            --[[
              line: 577
              upvalues:
                ctx (copy, index: 1)
                v192 (ref,  index: 2)
                hits (copy, index: 3)
                predictImpacts (copy, index: 4)
                preset (copy, index: 5)
                v177 (copy, index: 6)
                Util (copy, index: 7)
            ]]
            if not ctx.alive() then
                return
            end

            ctx.send("Swing", {lunge = true, tool = ctx.tool, dir = v192, hits = hits})
            predictImpacts(hits, (preset.hitSound or "Hit_Melee_Heavy"), v177.damage, nil, ctx.root, ctx.weaponId)

            if 0 < #hits then
                Util.Shake(0.6, 0.15)
                Util.Recoil(2, 0)
            end
        end
    )
end

function Class.ParryReady(self)
    --[[
      name: ParryReady
      line: 598
      upvalues:
        Util (copy, index: 1)
    ]]
    local parry = self.tuning.parry
    local timestamp = os.clock()

    if type(parry) ~= "table"
        or self.parrying
        or timestamp < self.parryReadyAt
        or timestamp - self.lastParryUp < 0.15
    then
        return false
    end

    local cooldown = self.ctx.tool and self.ctx.tool:GetAttribute("Cooldown")

    if type(cooldown) == "number" then
        if workspace:GetServerTimeNow() < cooldown then
            return false
        end
    end

    local canAct = false

    if self.busyUntil <= timestamp then
        canAct = false
        local v204 = timestamp - self.lastSwing

        if self:Cooldown() <= v204 then
            canAct = Util.CanAct()
        end
    end

    return canAct
end

function Class.RaiseParry(self)
    --[[
      name: RaiseParry
      line: 613
      upvalues:
        Util (copy, index: 1)
    ]]
    local ctx = self.ctx
    local parry = self.tuning.parry

    if not self:ParryReady() then
        return
    end

    self.parrying = true
    self.lastParryUp = os.clock()
    self.parryUpAt = self.lastParryUp
    self.bufferedAt = nil
    Util.FaceCamera()
    ctx.send("Parry", {on = true, tool = ctx.tool})
    ctx.emit("Parry", {on = true})
    Util.PlayHold(ctx.animator, (self.preset.parryHold or self.preset.parry), 1)
    Util.Sound((self.preset.parrySound or "Katana_Flick"), ctx.root)
    local speedMult = parry.speedMult or 0.7
    local v209 = Util.ProbeValues()
    local v210 = ctx.setSpeed("Parry", speedMult)
    local v211 = v209 and v209.k * (speedMult or 1)

    if v210 ~= v211 then
        Util.Hooked()
    end
end

function Class.LowerParry(self, a213, a214, a215)
    --[[
      name: LowerParry
      line: 638
      upvalues:
        Hud (copy, index: 1)
        Util (copy, index: 2)
    ]]
    if not self.parrying then
        return
    end

    local ctx = self.ctx
    self.parrying = false
    local parry = self.tuning.parry

    if not a214 and type(parry) == "table" then
        local cooldown = parry.cooldown or 1.6
        self.parryReadyAt = math.max(self.parryReadyAt, os.clock() + cooldown)

        if not a215 then
            Hud.SetArc(cooldown, Color3.fromRGB(150, 196, 236))
        end
    end

    if a213 then
        ctx.send("Parry", {on = false, tool = ctx.tool})
    end

    if not a214 then
        ctx.emit("Parry", {on = false})
    end

    Util.StopAnim(ctx.animator, (self.preset.parryHold or self.preset.parry), 0.15)
    ctx.setSpeed("Parry", nil)
end

function Class.ParryUsed(self)
    --[[
      name: ParryUsed
      line: 663
      upvalues:
        Hud (copy, index: 1)
    ]]
    local parry = self.tuning.parry

    if type(parry) ~= "table" then
        return
    end

    local cooldown = parry.cooldown or 1.6
    self.parryReadyAt = os.clock() + cooldown
    Hud.SetArc(cooldown, Color3.fromRGB(150, 196, 236))
    self:LowerParry(false, true)
end

function Class.OnDenied(self, a223)
    --[[
      name: OnDenied
      line: 677
      upvalues:
        Hud (copy, index: 1)
    ]]
    if a223 == "ParryRefused" then
        if self.parrying then
            self.parryReadyAt = math.max(self.parryReadyAt, os.clock() + 0.5)
            self:LowerParry(false, true)
            self.ctx.emit("Parry", {on = false})
        end
    elseif a223 == "NoCharges" then
        Hud.Toast("NONE LEFT THIS ROUND", Color3.fromRGB(255, 120, 90))
    end
end

function Class.Hurl(self)
    --[[
      name: Hurl
      line: 691
      upvalues:
        Util (copy, index: 1)
        Combat (copy, index: 2)
        Effects (copy, index: 3)
        Hud (copy, index: 4)
        Touch (copy, index: 5)
    ]]
    local ctx = self.ctx
    local tuning = self.tuning
    local throw = tuning.throw
    local timestamp = os.clock()

    if type(throw) ~= "table"
        or self:OneHanded()
        or timestamp - self.lastThrow < (throw.cooldown or 0.45)
        or timestamp < self.busyUntil
        or not Util.CanAct()
    then
        return
    end

    local cooldown = ctx.tool and ctx.tool:GetAttribute("Cooldown")

    if type(cooldown) == "number" then
        if workspace:GetServerTimeNow() < cooldown then
            return
        end
    end

    self.lastThrow = timestamp
    self.thrownLocalUntil = timestamp + 0.8
    self.busyUntil = timestamp + 0.2
    self.bufferedAt = nil
    Util.FaceCamera()
    local origin = Util.ShotOrigin(nil)
    local v231 = Util.AimPoint((throw.range or 170))
    local v232 = Util.AssistDirection(origin, Util.AimDirection(origin), true)
    local speed = throw.speed or 120
    local gravity = throw.gravity or 0
    local magnitude = (v231 - origin).Magnitude

    if 0 < gravity and 1 < magnitude then
        local v236 = magnitude / speed
        v232 = (v232 * magnitude + Vector3.new(0, ((0.5 * gravity) * v236) * v236, 0)).Unit
    end

    local id = ctx.nextId()
    ctx.emit("Hurl", {})
    Util.PlayAnim(ctx.animator, self.preset.throw, 1.2, 0.03)
    Util.Sound((self.preset.throwSound or "Hatchet_Throw"), ctx.root)
    Combat.ShowOffHand(ctx.tool, false)
    Effects.Projectile(Effects.MyKey(id), "Hatchet", origin, v232 * speed, gravity, ctx.char, {damage = (throw.damage
        or 40) * Util.ItemBonus(ctx.weaponId), tuning = throw})
    ctx.send("Hurl", {tool = ctx.tool, origin = origin, dir = v232, id = id})
    Hud.SetArc((throw.returnTime or 5), Color3.fromRGB(214, 170, 120))
    Touch.SetAltDim(true)
    local tool = ctx.tool

    task.delay(
        0.85,
        function()
            --[[
              line: 732
              upvalues:
                tool (copy, index: 1)
                self (copy, index: 2)
                Combat (copy, index: 3)
                ctx (copy, index: 4)
                Hud (copy, index: 5)
                Touch (copy, index: 6)
            ]]
            if tool and tool.Parent and tool:GetAttribute("Thrown") ~= true then
                local timestamp = os.clock()

                if self.thrownLocalUntil <= timestamp then
                    Combat.ShowOffHand(tool, true)

                    if tool.Parent == ctx.char then
                        Hud.SetArc(0)
                        Touch.SetAltDim(false)
                    end
                end
            end
        end
    )
end

function Class.Input(self, a241, a242)
    --[[
      name: Input
      line: 745
    ]]
    local tuning = self.tuning

    if a241 == "Primary" then
        self.holding = a242

        if a242 then
            self.guardFirst = false

            if self.blocking then
                self:SetBlock(false)
            end

            if self.parrying then
                self:LowerParry(true)
            end

            if not self.charging and not self:Swing() then
                self.bufferedAt = os.clock()
            end
        end
    elseif a241 == "Secondary" then
        if tuning.parry then
            self.parryHeld = a242

            if a242 then
                self:RaiseParry()
                return
            end

            self:LowerParry(true)

            return
        end

        if tuning.throw then
            if a242 then
                self:Hurl()
            end
        else
            if tuning.block then
                self.blockHeld = a242

                if a242 then
                    self.guardFirst = true
                    self.bufferedAt = nil
                end

                local block = a242 and self:CanGuard()
                self:SetBlock(block)

                return
            end

            if tuning.heavy then
                if a242 then
                    self:StartCharge("Heavy")
                    return
                end

                self:ReleaseCharge()

                return
            end

            if tuning.lunge and (tuning.lunge.charge or 0.6) <= 0 then
                if a242 then
                    self:Dash()
                end
            elseif tuning.lunge then
                if a242 then
                    self:StartCharge("Lunge")
                    return
                end

                self:ReleaseCharge()
            end
        end
    end
end

function Class.Update(self, a246)
    --[[
      name: Update
      line: 800
      upvalues:
        Util (copy, index: 1)
        Hud (copy, index: 2)
    ]]
    local parry = self.tuning.parry

    if self.parrying and type(parry) == "table" and type(parry.maxHold) == "number" then
        local v248 = os.clock() - self.parryUpAt

        if parry.maxHold <= v248 then
            self:LowerParry(true)
        end
    end

    if self.parryHeld and not self.parrying and not self.holding and self:ParryReady() then
        self:RaiseParry()
    end

    if self.blockHeld
        and not (self.blocking)
        and not (self.charging)
        and not (self.bufferedAt)
        and (self.guardFirst or not self.holding)
        and self:CanGuard()
    then
        self:SetBlock(true)
    end

    self:DrawGuard()

    if self.holding and not self.blocking and not self.charging then
        self:Swing()
    elseif self.bufferedAt then
        if 0.2 < os.clock() - self.bufferedAt or self.blocking or self.charging then
            self.bufferedAt = nil
        else
            self:Swing()
        end
    end

    if self.charging then
        local v249 = self:SpecialInfo(self.charging)
        local clampedValue = math.clamp((os.clock() - self.chargeStart) / (v249.charge or 0.6), 0, 1)

        if 1 <= clampedValue and not self.fullPlayed then
            self.fullPlayed = true
            Util.Sound("Charge_Full", self.ctx.root)
        end

        Hud.SetCharge(clampedValue)
    end
end

function Class.Interrupt(self)
    --[[
      name: Interrupt
      line: 839
    ]]
    if self.blocking then
        self:SetBlock(false)
    end

    if self.charging then
        self:CancelCharge()
    end

    self:LowerParry(true)
    self.busyUntil = math.max(self.busyUntil, os.clock() + 0.2)
end

return Class