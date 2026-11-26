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
      line: 19
      upvalues:
        Class (copy, index: 1)
    ]]
    local v9 = setmetatable({}, Class)
    v9.ctx = ctx
    v9.tuning = ctx.tuning
    v9.preset = ctx.preset
    v9.drawing = false
    v9.drawStart = 0
    v9.lastShot = -math.huge
    v9.aiming = false
    v9.full = false
    v9.drawSound = nil
    v9.m1Down = false
    v9.bufferedAt = nil
    return v9
end

function Class.SyncPool(self)
    --[[
      name: SyncPool
      line: 35
      upvalues:
        Hud (copy, index: 1)
        Util (copy, index: 2)
    ]]
    if const ammo = self.tuning.ammo then
        Hud.SetAmmoCount(Util.AmmoShown(self.ctx.char, ammo))
    end
end

function Class.OutOfAmmo(self)
    --[[
      name: OutOfAmmo
      line: 43
      upvalues:
        Util (copy, index: 1)
        Hud (copy, index: 2)
    ]]
    local ammo = self.tuning.ammo

    if not ammo or 1 <= Util.AmmoLeft(self.ctx.char, ammo) then
        return false
    end

    local timestamp = os.clock()

    if 0.4 < timestamp - (self.lastDry or 0) then
        self.lastDry = timestamp
        Util.Sound("Dry_Fire", self.ctx.root)
        Hud.Toast((Util.AMMO_OUT[ammo] or "OUT OF AMMO"), Color3.fromRGB(255, 110, 90), 1)
    end

    return true
end

function Class.Equip(self)
    --[[
      name: Equip
      line: 57
      upvalues:
        Hud (copy, index: 1)
        Util (copy, index: 2)
    ]]
    Hud.SetStyle("Bow")
    Hud.SetPips(0, 0)
    Util.PlayAnim(self.ctx.animator, self.preset.hold, 1, 0.2)

    if not Util.InFirstPerson() then
        Util.Sound((self.preset.equip or "Equip_Bow"), self.ctx.root)
    end

    local ammo = self.tuning.ammo

    if ammo and self.ctx.char then
        self:SyncPool()
        self.poolConns = Util.WatchAmmo(
            self.ctx.char,
            ammo,
            function()
                --[[
                  line: 67
                  upvalues:
                    self (copy, index: 1)
                ]]
                self:SyncPool()
            end
        )
    end
end

function Class.Unequip(self)
    --[[
      name: Unequip
      line: 73
      upvalues:
        Util (copy, index: 1)
        Effects (copy, index: 2)
        Hud (copy, index: 3)
    ]]
    local ctx = self.ctx

    if self.drawing then
        self:CancelDraw()
    end

    if self.aiming then
        self.aiming = false
        Util.SetAiming(false)
        ctx.setSpeed("Aim", nil)
    end

    Util.StopAnim(ctx.animator, self.preset.hold, 0.15)
    Util.StopAnim(ctx.animator, self.preset.aim, 0.15)
    Effects.ChargeGlow(ctx.tool, 0)
    Util.SetCameraModifier("CombatDraw", nil)
    self.bufferedAt = nil

    if self.poolConns then
        for _, poolConn in self.poolConns do
            poolConn:Disconnect()
        end

        self.poolConns = nil
    end

    Hud.SetAmmoCount(nil)
end

function Class.Charge(self)
    --[[
      name: Charge
      line: 97
    ]]
    if not self.drawing then
        return 0
    end

    return (math.clamp((os.clock() - self.drawStart) / (self.tuning.drawTime or 1), 0, 1))
end

function Class.StartDraw(self)
    --[[
      name: StartDraw
      line: 104
      upvalues:
        Util (copy, index: 1)
    ]]
    local ctx = self.ctx
    local timestamp = os.clock()

    if not self.drawing then
        local v25 = timestamp - self.lastShot
        local v26 = self.nextCd or self.tuning.cooldown or 0.25

        if not (v25 < v26) and Util.CanAct() and not (0 < Util.GuardRecovery(ctx.tool)) then
            if self:OutOfAmmo() then
                self.bufferedAt = nil
                return false
            end

            self.bufferedAt = nil
            Util.SetCameraModifier("CombatDraw", {fov = -6, pivot = Vector3.new(0.30000001192092896, 0, 0)})
            self.drawing = true
            self.full = false
            self.drawStart = timestamp
            ctx.send("Charge", {kind = "Draw", on = true, tool = ctx.tool})
            ctx.emit("Draw", {on = true, time = self.tuning.drawTime or 1, arrow = Util.ShotKind(ctx.char, self.tuning.ammo, (self.tuning.projectile
                or "Arrow"))})
            Util.FaceCamera()
            local v27 = 0.88 / math.max(0.3, self.tuning.drawTime or 1)
            Util.PlayHold(ctx.animator, self.preset.draw, v27)
            self.drawSound = Util.Sound((self.preset.drawSound or "Bow_Draw"), ctx.root, {PlaybackSpeed = math.clamp(v27, 0.7, 1.3)})
            local drawSpeedMult = self.tuning.drawSpeedMult or 0.7
            local v29 = Util.ProbeValues()
            local v30 = ctx.setSpeed("Draw", drawSpeedMult)
            local v31 = v29 and v29.k * (drawSpeedMult or 1)

            if v30 ~= v31 then
                Util.Hooked()
            end

            return true
        end
    end

    return false
end

function Class.CancelDraw(self)
    --[[
      name: CancelDraw
      line: 137
      upvalues:
        Util (copy, index: 1)
        Hud (copy, index: 2)
        Effects (copy, index: 3)
    ]]
    local ctx = self.ctx
    self.drawing = false
    ctx.send("Charge", {kind = "Draw", on = false, tool = ctx.tool})
    ctx.emit("Draw", {on = false})
    Util.StopAnim(ctx.animator, self.preset.draw, 0.12)

    if self.drawSound then
        self.drawSound:Stop()
        self.drawSound = nil
    end

    ctx.setSpeed("Draw", nil)
    Hud.SetCharge(0)
    Effects.ChargeGlow(ctx.tool, 0)
    Util.SetCameraModifier("CombatDraw", nil)
end

function Class.Fire(self)
    --[[
      name: Fire
      line: 153
      upvalues:
        Util (copy, index: 1)
        Hud (copy, index: 2)
        Effects (copy, index: 3)
        Combat (copy, index: 4)
    ]]
    local ctx = self.ctx
    local tuning = self.tuning

    if not self.drawing then
        return
    end

    if not Util.CanAct() then
        self:CancelDraw()
        return
    end

    local charge = self:Charge()
    self.drawing = false
    self.lastShot = os.clock()
    ctx.emit("Release", {charge = charge})
    local cooldown = self.tuning.cooldown or 0.2
    local v39 = self.tuning.tapCooldown or self.tuning.cooldown or 0.2
    self.nextCd = cooldown + ((v39 - cooldown) * (1 - charge))

    if self.drawSound then
        self.drawSound:Stop()
        self.drawSound = nil
    end

    Util.StopAnim(ctx.animator, self.preset.draw, 0.05)
    Util.PlayAnim(ctx.animator, self.preset.fire, (self.preset.fireAnimSpeed or 1.2), 0.03)
    Util.SetCameraModifier("CombatDraw", nil)
    ctx.setSpeed("Draw", nil)
    Hud.SetCharge(0)
    Effects.ChargeGlow(ctx.tool, 0)
    local v40 = Util.ProbeValues()
    local root = ctx.root

    if v40 and root then
        v40.at = root.Position + v40.o
        local v42 = Util.AimDirection(v40.at)

        if v42 ~= v40.at then
            Util.Hooked()
        end
    end

    local origin = Util.ShotOrigin(ctx.tool, "Muzzle")
    local dir = Util.AssistDirection(origin, Util.AimDirection(origin), true)
    local v45, v46 = Combat.DrawnShot(tuning, charge)
    local id = ctx.nextId()
    Effects.Projectile(Effects.MyKey(id), Util.ShotKind(ctx.char, tuning.ammo, (tuning.projectile or "Arrow")), origin, dir * v46, (tuning.gravity
        or 60), ctx.char, {damage = v45 * Util.ItemBonus(ctx.weaponId), tuning = tuning})
    ctx.send("Shoot", {tool = ctx.tool, origin = origin, dir = dir, id = id, charge = charge})
    Util.Sound((self.preset.fireSound or "Bow_Release"), ctx.root, {PlaybackSpeed = 0.9 + (0.25 * charge), Volume = 0.6 + (0.4 * charge)})
    Util.Recoil(1 + (1.8 * charge), (math.random() - 0.5) * 0.6)
    Util.Shake(0.1 + (0.15 * charge), 0.12)
    Hud.Kick(6 * charge)
end

function Class.Input(self, a49, a50)
    --[[
      name: Input
      line: 204
      upvalues:
        Util (copy, index: 1)
    ]]
    if a49 == "Primary" then
        self.m1Down = a50

        if not a50 then
            self:Fire()
            return
        end

        if not self:StartDraw() and not self.drawing and not self:OutOfAmmo() then
            self.bufferedAt = os.clock()
        end
    elseif a49 == "Secondary" then
        self.aiming = a50
        Util.SetAiming(a50, self.tuning.aimFov)
        local setSpeed = self.ctx.setSpeed
        local v52 = a50 and 0.8 or nil
        setSpeed("Aim", v52)

        if a50 then
            Util.PlayAnim(self.ctx.animator, self.preset.aim, 1, 0.15)
            return
        end

        Util.StopAnim(self.ctx.animator, self.preset.aim, 0.15)
    end
end

function Class.Update(self, a54)
    --[[
      name: Update
      line: 226
      upvalues:
        Hud (copy, index: 1)
        Effects (copy, index: 2)
        Util (copy, index: 3)
    ]]
    if self.bufferedAt and not self.drawing then
        if not self.m1Down and 0.15 < os.clock() - self.bufferedAt then
            self.bufferedAt = nil
        elseif self:StartDraw() and not self.m1Down then
            self:Fire()
        end
    end

    if self.drawing then
        local v55 = self:Charge()
        Hud.SetCharge(v55)
        local glow = self.preset.glow
        Effects.ChargeGlow(self.ctx.tool, v55, glow)

        if 1 <= v55 and not self.full then
            self.full = true
            Util.Sound((self.preset.fullSound or "Bow_Full"), self.ctx.root)
            Effects.ChargePing(self.ctx.tool, glow)
        end
    end
end

function Class.Interrupt(self)
    --[[
      name: Interrupt
      line: 247
    ]]
    if self.drawing then
        self:CancelDraw()
    end
end

function Class.OnDenied(self, a59)
    --[[
      name: OnDenied
      line: 254
    ]]
    if a59 == "NoAmmo" then
        self.lastDry = 0
        self:OutOfAmmo()
    end
end

return Class