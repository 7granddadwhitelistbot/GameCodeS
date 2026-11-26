local replicatedStorage = game:GetService("ReplicatedStorage")
local parent = script.Parent.Parent
local Util = require(parent.Util)
local Hud = require(parent.Hud)
local Effects = require(parent.Effects)
local Combat = require(replicatedStorage:WaitForChild("Shared"):WaitForChild("Combat"))
local Class = {}
Class.__index = Class

function Class.new(ctx)
    --[[
      name: new
      line: 20
      upvalues:
        Class (copy, index: 1)
    ]]
    local v9 = setmetatable({}, Class)
    v9.ctx = ctx
    v9.tuning = ctx.tuning
    v9.preset = ctx.preset
    v9.kind = ctx.kind
    v9.winds = (ctx.kind == "Javelin") or (ctx.kind == "Bomb")
    v9.winding = false
    v9.start = 0
    v9.lastThrow = -math.huge
    v9.m1Down = false
    v9.preview = false
    v9.charges = 0
    v9.maxCharges = ctx.tuning.charges or 0
    v9.bufferedAt = nil
    v9.conns = {}
    v9.stopLoop = nil
    return v9
end

function Class.StopLoop(self)
    --[[
      name: StopLoop
      line: 40
    ]]
    if self.stopLoop then
        self.stopLoop(0.15)
        self.stopLoop = nil
    end
end

function Class.StartLoop(self, a12)
    --[[
      name: StartLoop
      line: 47
      upvalues:
        Util (copy, index: 1)
    ]]
    if not a12 or self.stopLoop then
        return
    end

    local handle = self.ctx.tool and self.ctx.tool:FindFirstChild("Handle")
    self.stopLoop = Util.Loop(a12, (handle or self.ctx.root))
end

function Class.Sync(self)
    --[[
      name: Sync
      line: 55
      upvalues:
        Util (copy, index: 1)
        Hud (copy, index: 2)
    ]]
    local tool = self.ctx.tool
    local charges = tool:GetAttribute("Charges")

    if type(charges) == "number" then
        if self.charges < charges
            and self.preset.readySound
            and self.ctx.tool.Parent == self.ctx.char
        then
            Util.Sound(self.preset.readySound, self.ctx.root)
        end

        self.charges = charges
    end

    if 0 < self.maxCharges then
        Hud.SetPips(self.charges, self.maxCharges)
    end

    local nextCharge = tool:GetAttribute("NextCharge")

    if type(nextCharge) == "number" and 0 < nextCharge and self.tuning.regen then
        local v18 = nextCharge - workspace:GetServerTimeNow()

        if 0 < v18 then
            Hud.SetArc(self.tuning.regen, Color3.fromRGB(150, 200, 255), self.tuning.regen - v18)
        end
    end
end

function Class.Equip(self)
    --[[
      name: Equip
      line: 77
      upvalues:
        Hud (copy, index: 1)
        Util (copy, index: 2)
    ]]
    local ctx = self.ctx
    Hud.SetStyle("Throw")
    Hud.SetPips(0, 0)
    self:Sync()
    Util.PlayAnim(ctx.animator, self.preset.hold, 1, 0.2)
    Util.Sound((self.preset.equip or "Equip_Item"), ctx.root)
    local tool = ctx.tool
    table.insert(
        self.conns,
        tool:GetAttributeChangedSignal("Charges"):Connect(
            function()
                --[[
                  line: 85
                  upvalues:
                    self (copy, index: 1)
                ]]
                self:Sync()
            end
        )
    )
    table.insert(
        self.conns,
        tool:GetAttributeChangedSignal("NextCharge"):Connect(
            function()
                --[[
                  line: 88
                  upvalues:
                    self (copy, index: 1)
                ]]
                self:Sync()
            end
        )
    )
end

function Class.Unequip(self)
    --[[
      name: Unequip
      line: 93
      upvalues:
        Util (copy, index: 1)
        Effects (copy, index: 2)
        Hud (copy, index: 3)
    ]]
    for _, conn in self.conns do
        conn:Disconnect()
    end

    table.clear(self.conns)

    if self.winding then
        self:Cancel()
    end

    self:StopLoop()

    if self.preview then
        self.preview = false
        Util.SetAiming(false)
    end

    Util.StopAnim(self.ctx.animator, self.preset.hold, 0.15)
    Effects.Trajectory(nil)
    Hud.SetPips(0, 0)
    Hud.SetArc(nil)
end

function Class.Charge(self)
    --[[
      name: Charge
      line: 112
    ]]
    if not self.winding then
        return 0
    end

    return (math.clamp((os.clock() - self.start) / (self.tuning.drawTime or 0.5), 0, 1))
end

function Class.Launch(self, a27, a28)
    --[[
      name: Launch
      line: 120
      upvalues:
        Util (copy, index: 1)
        Combat (copy, index: 2)
    ]]
    local v29
    local ctx = self.ctx
    local tuning = self.tuning
    local v32 = if ((self.kind == "Sling") or (ctx.weaponId == "bolas")) and Util.InFirstPerson() then Util.ShotOrigin(nil) else Util.ShotOrigin(ctx.tool, "Tip")
    local v33 = Util.AimDirection(v32)

    if a28 and self.kind ~= "Bomb" then
        v33 = Util.AssistDirection(v32, v33, true)
    end

    local unit = (v33 + Vector3.new(0, (self.kind ~= "Bomb"
        and (self.kind ~= "Sling" and (self.kind ~= "Javelin" and 0.01 or 0.04) or 0.05))
        or 0.16, 0)).Unit

    if self.winds then
        local _
        _, v29 = Combat.DrawnShot(tuning, a27)
    else
        v29 = Combat.ShotSpeed(tuning)
    end

    return v32, unit, v29
end

function Class.HasCharge(self)
    --[[
      name: HasCharge
      line: 144
    ]]
    return (self.maxCharges <= 0) or (1 <= self.charges)
end

function Class.NoneLeft(self)
    --[[
      name: NoneLeft
      line: 149
      upvalues:
        Util (copy, index: 1)
        Hud (copy, index: 2)
    ]]
    local timestamp = os.clock()

    if 0.4 < timestamp - (self.lastDry or 0) then
        self.lastDry = timestamp
        Util.Sound("Dry_Fire", self.ctx.root)
        Hud.Toast("NONE LEFT THIS ROUND", Color3.fromRGB(255, 110, 90), 1)
    end
end

function Class.Start(self)
    --[[
      name: Start
      line: 158
      upvalues:
        Util (copy, index: 1)
    ]]
    local ctx = self.ctx
    local timestamp = os.clock()

    if self.winding
        or timestamp - self.lastThrow < (self.tuning.cooldown or 0.5)
        or not Util.CanAct()
        or 0 < Util.GuardRecovery(ctx.tool)
    then
        return false
    end

    if not self:HasCharge() then
        self:NoneLeft()
        return false
    end

    self.bufferedAt = nil
    self.winding = true
    self.start = timestamp
    ctx.send("Charge", {kind = "Throw", on = true, tool = ctx.tool})
    ctx.emit("Windup", {on = true, time = self.tuning.drawTime or 0.5})
    Util.PlayHold(ctx.animator, self.preset.windup, 1)
    Util.Sound((self.preset.windupSound or "Throw_Windup"), ctx.root)
    self:StartLoop(self.preset.fuseLoop)
    local v42 = Util.ProbeValues()
    local drawSpeedMult = self.tuning.drawSpeedMult or 0.8
    local v44 = ctx.setSpeed("Throw", drawSpeedMult)
    local v45 = v42 and v42.k * (drawSpeedMult or 1)

    if v44 ~= v45 then
        Util.Hooked()
    end

    return true
end

function Class.Cancel(self)
    --[[
      name: Cancel
      line: 186
      upvalues:
        Util (copy, index: 1)
        Hud (copy, index: 2)
        Effects (copy, index: 3)
    ]]
    local ctx = self.ctx
    self.winding = false
    ctx.send("Charge", {kind = "Throw", on = false, tool = ctx.tool})
    ctx.emit("Windup", {on = false})
    Util.StopAnim(ctx.animator, self.preset.windup, 0.1)
    ctx.setSpeed("Throw", nil)
    Hud.SetCharge(0)
    Effects.Trajectory(nil)
    self:StopLoop()
end

function Class.Release(self, charge)
    --[[
      name: Release
      line: 198
      upvalues:
        Util (copy, index: 1)
        Combat (copy, index: 2)
        Effects (copy, index: 3)
        Hud (copy, index: 4)
    ]]
    local ctx = self.ctx
    local tuning = self.tuning
    local origin, dir, v54 = self:Launch(charge, true)
    self.lastThrow = os.clock()
    ctx.emit("Throw", {charge = charge})
    Util.FaceCamera()

    if self.preset.windup then
        Util.StopAnim(ctx.animator, self.preset.windup, 0.04)
    end

    Util.PlayAnim(ctx.animator, self.preset.throw, (self.preset.throwAnimSpeed or 1.3), 0.03)
    local id = ctx.nextId()
    local v56 = nil

    if not tuning.splash and not tuning.smoke and not tuning.caltrops then
        local v57 = if self.winds then Combat.DrawnShot(tuning, charge) else tuning.damage
        v56 = {damage = v57 * Util.ItemBonus(ctx.weaponId), tuning = tuning}
    end

    if type(tuning.returns) ~= "table" then
        Effects.Projectile(Effects.MyKey(id), (tuning.projectile or "Javelin"), origin, dir * v54, (tuning.gravity
            or 60), ctx.char, v56)
    else
        Effects.Chakram(Effects.MyKey(id), origin, dir, v54, (tuning.returns.range or 45), (tuning.returns.catch
            or 4.5), ctx.char)
    end

    ctx.send("Shoot", {tool = ctx.tool, origin = origin, dir = dir, id = id, charge = charge})
    Util.Sound((self.preset.throwSound or "Throw"), ctx.root)

    if self.kind == "Bomb" then
        self:StopLoop()
    end

    local recoil = Util.Recoil
    local v59 = self.preset.recoil or self.kind ~= "Javelin" and 1 or 2
    recoil(v59, 0)

    if self.preset.shake then
        Util.Shake(self.preset.shake, 0.16)
    end

    local kick = Hud.Kick
    local v61 = self.preset.recoil and 7 or 4
    kick(v61)

    if 0 < self.maxCharges then
        self.charges = math.max(0, self.charges - 1)
        Hud.SetPips(self.charges, self.maxCharges)
    end

    if self.kind == "Bomb" then
        Hud.SetArc((tuning.cooldown or 0.6), Color3.fromRGB(228, 232, 240))
    end
end

function Class.Quick(self)
    --[[
      name: Quick
      line: 241
      upvalues:
        Util (copy, index: 1)
    ]]
    local timestamp = os.clock()
    local v64 = self.tuning.fireInterval or self.tuning.cooldown or 0.4

    if timestamp - self.lastThrow < v64 or 0 < Util.GuardRecovery(self.ctx.tool) then
        return "cooldown"
    end
    if not Util.CanAct() then
        return "frozen"
    end

    if not self:HasCharge() then
        self.lastThrow = timestamp
        self:NoneLeft()

        return "empty"
    end

    self.bufferedAt = nil
    self:Release(1)

    return "fired"
end

function Class.Throw(self)
    --[[
      name: Throw
      line: 260
      upvalues:
        Util (copy, index: 1)
        Hud (copy, index: 2)
        Effects (copy, index: 3)
    ]]
    if not self.winding then
        return
    end

    if not Util.CanAct() then
        self:Cancel()
        return
    end

    local v66 = self:Charge()
    local minCharge = self.tuning.minCharge

    if type(minCharge) == "number" and v66 < minCharge then
        self:Cancel()
        local timestamp = os.clock()

        if 1.5 < timestamp - (self.lastShort or 0) then
            self.lastShort = timestamp
            Hud.Toast("HOLD TO WIND UP", Color3.fromRGB(226, 196, 140), 1)
        end
    else
        self.winding = false
        self.ctx.setSpeed("Throw", nil)
        Hud.SetCharge(0)
        Effects.Trajectory(nil)
        self:Release(v66)
    end
end

function Class.Input(self, a70, a71)
    --[[
      name: Input
      line: 287
      upvalues:
        Util (copy, index: 1)
        Effects (copy, index: 2)
    ]]
    if a70 == "Primary" then
        self.m1Down = a71

        if not self.winds then
            if a71 and self:Quick() == "cooldown" then
                self.bufferedAt = os.clock()
            end

            if self.kind == "Sling" then
                if a71 then
                    self:StartLoop(self.preset.whirlLoop)
                else
                    self:StopLoop()
                end
            end

            return
        end

        if not a71 then
            self:Throw()
            return
        end

        if not self:Start() and not self.winding then
            self.bufferedAt = os.clock()
        end
    elseif a70 == "Secondary" then
        if self.winds then
            if a71 and self.winding then
                self:Cancel()
            end
        else
            self.preview = a71
            local setAiming = Util.SetAiming
            local v73 = self.kind ~= "Sling" and 55 or 58
            setAiming(a71, v73)
            local setSpeed = self.ctx.setSpeed
            local v75 = a71 and 0.85 or nil
            setSpeed("Aim", v75)

            if not a71 then
                Effects.Trajectory(nil)
            end
        end
    end
end

function Class.Update(self, a77)
    --[[
      name: Update
      line: 327
      upvalues:
        Hud (copy, index: 1)
        Effects (copy, index: 2)
    ]]
    if self.kind == "Sling" and self.m1Down and not self.bufferedAt then
        self:Quick()
    end

    if self.bufferedAt then
        if self.winds then
            if not self.winding then
                if not self.m1Down and 0.15 < os.clock() - self.bufferedAt then
                    self.bufferedAt = nil
                elseif self:Start() and not self.m1Down then
                    self:Throw()
                end
            end
        elseif not (0.15 < os.clock() - self.bufferedAt) then
            if self:Quick() ~= "cooldown" then
                self.bufferedAt = nil
            end
        else
            self.bufferedAt = nil
        end
    end

    if not self.winding then
        if self.preview and self.kind == "Sling" then
            local v78, v79, v80 = self:Launch(1)
            Effects.Trajectory(v78, v79 * v80, (self.tuning.gravity or 80), Color3.fromRGB(215, 195, 160), 2)
        end

        return
    end

    local v81
    local v82 = self:Charge()
    Hud.SetCharge(v82)
    local v83, v84, v85 = self:Launch(v82)
    local tuning = self.tuning

    if tuning.splash then
        v81 = tuning.splash.radius * 2
    elseif tuning.smoke then
        v81 = tuning.smoke.radius * 1.2
    else
        v81 = not tuning.caltrops and 3 or tuning.caltrops.radius * 2
    end

    local v87 = if tuning.smoke then self.preset.arcSmoke else self.preset.arc
    Effects.Trajectory(v83, v84 * v85, (tuning.gravity or 60), v87, v81)
end

function Class.Interrupt(self)
    --[[
      name: Interrupt
      line: 363
    ]]
    if self.winding then
        self:Cancel()
    end
end

return Class