local replicatedStorage = game:GetService("ReplicatedStorage")
local parent = script.Parent.Parent
local Util = require(parent.Util)
local Hud = require(parent.Hud)
local Effects = require(parent.Effects)
local Poses = require(parent.Poses)
local Combat = require(replicatedStorage:WaitForChild("Shared"):WaitForChild("Combat"))
local Class = {}
Class.__index = Class

function Class.new(ctx)
    --[[
      name: new
      line: 24
      upvalues:
        Class (copy, index: 1)
    ]]
    local v10 = setmetatable({}, Class)
    v10.ctx = ctx
    v10.tuning = ctx.tuning
    v10.preset = ctx.preset
    v10.kind = ctx.kind
    v10.magazine = ctx.tuning.magazine or 1
    v10.ammo = v10.magazine
    v10.reloading = false
    v10.reloadToken = 0
    v10.lastShot = -math.huge
    v10.holding = false
    v10.aiming = false
    v10.aimStart = 0
    v10.spreadNow = 0
    v10.conns = {}
    v10.bufferedAt = nil
    return v10
end

function Class.SyncAmmo(self)
    --[[
      name: SyncAmmo
      line: 44
      upvalues:
        Hud (copy, index: 1)
    ]]
    local v12 = self.ctx.tool
    v12 = v12 and v12:GetAttribute("Ammo")

    if type(v12) == "number" then
        self.ammo = v12
    end

    Hud.SetPips(self.ammo, self.magazine)
end

function Class.SyncPool(self)
    --[[
      name: SyncPool
      line: 53
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
      line: 61
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
      line: 75
      upvalues:
        Hud (copy, index: 1)
        Util (copy, index: 2)
    ]]
    local ctx = self.ctx
    Hud.SetStyle((self.preset.crosshair or "Gun"))
    self:SyncAmmo()
    local ammo = self.tuning.ammo

    if ammo and ctx.char then
        self:SyncPool()
        self.poolConns = Util.WatchAmmo(
            ctx.char,
            ammo,
            function()
                --[[
                  line: 82
                  upvalues:
                    self (copy, index: 1)
                ]]
                self:SyncPool()
            end
        )
    end

    self.spreadNow = self:TargetSpread()
    Util.PlayAnim(ctx.animator, self.preset.hold, 1, 0.2)

    if not Util.InFirstPerson() then
        Util.Sound((self.preset.equip or "Equip_Crossbow"), ctx.root)
    end

    local tool = ctx.tool

    table.insert(
        self.conns,
        tool:GetAttributeChangedSignal("Ammo"):Connect(
            function()
                --[[
                  line: 93
                  upvalues:
                    self (copy, index: 1)
                    Util (copy, index: 2)
                    ctx (copy, index: 3)
                ]]
                self:SyncAmmo()
                local ammo = self.ammo

                if self.magazine <= ammo and self.reloading then
                    self:FinishReload()

                    if self.preset.reloadDoneSound and not Util.InFirstPerson() then
                        Util.Sound(self.preset.reloadDoneSound, ctx.root)
                    end
                end
            end
        )
    )

    table.insert(
        self.conns,
        tool:GetAttributeChangedSignal("Reloading"):Connect(
            function()
                --[[
                  line: 103
                  upvalues:
                    tool (copy, index: 1)
                    self (copy, index: 2)
                ]]
                if tool:GetAttribute("Reloading") == true and not self.reloading then
                    self:LocalReload()
                end
            end
        )
    )

    if self.ammo <= 0 or tool:GetAttribute("Reloading") == true then
        self:LocalReload()
    end
end

function Class.Unequip(self)
    --[[
      name: Unequip
      line: 113
      upvalues:
        Hud (copy, index: 1)
        Util (copy, index: 2)
    ]]
    local ctx = self.ctx

    for _, conn in self.conns do
        conn:Disconnect()
    end

    table.clear(self.conns)
    self.holding = false
    self.reloading = false
    self.reloadToken += 1
    Hud.SetArc(nil)
    Hud.SetPips(0, 0)

    if self.aiming then
        self:SetAim(false)
    end

    ctx.setSpeed("Reload", nil)
    Util.StopAnim(ctx.animator, self.preset.hold, 0.15)
    Util.StopAnim(ctx.animator, self.preset.aim, 0.1)
    Util.StopAnim(ctx.animator, self.preset.fire, 0.1)
    Util.StopAnim(ctx.animator, self.preset.reload, 0.1)

    if self.poolConns then
        for _, poolConn in self.poolConns do
            poolConn:Disconnect()
        end

        self.poolConns = nil
    end

    Hud.SetAmmoCount(nil)
end

function Class.Aimed(self)
    --[[
      name: Aimed
      line: 141
    ]]
    return self.aiming and 0.12 <= os.clock() - self.aimStart
end

function Class.TargetSpread(self)
    --[[
      name: TargetSpread
      line: 145
    ]]
    local tuning = self.tuning

    if self.kind ~= "Blunderbuss" then
        if self.kind == "Crossbow" then
            return 0.4
        end
        if self:Aimed() then
            return tuning.spreadAim or 0
        end

        return tuning.spreadHip or 0
    end

    local v32

    if self:Aimed() then
        v32 = tuning.spreadAim

        if not v32 then
            v32 = tuning.spread

            if not v32 then
                return 6
            end
        end
    else
        v32 = tuning.spread or 6
    end

    return v32
end

function Class.FinishReload(self)
    --[[
      name: FinishReload
      line: 155
      upvalues:
        Hud (copy, index: 1)
    ]]
    self.reloading = false
    self.ctx.emit("ReloadEnd", nil)
    self.ctx.setSpeed("Reload", nil)
    Hud.SetArc(nil)
end

function Class.LocalReload(self)
    --[[
      name: LocalReload
      line: 162
      upvalues:
        Hud (copy, index: 1)
        Util (copy, index: 2)
    ]]
    local v35
    local ctx = self.ctx

    if self.reloading then
        return
    end

    self.reloading = true
    self.reloadToken += 1
    local reloadToken = self.reloadToken
    local reloadTime = self.tuning.reloadTime or 1.5
    local tool = ctx.tool
    local reloadEndsAt = tool:GetAttribute("ReloadEndsAt")
    local reloadTime2 = reloadTime

    if type(reloadEndsAt) ~= "number" then
        v35 = reloadTime2
    elseif not (0 < reloadEndsAt) then
        v35 = reloadTime2
    else
        v35 = math.clamp(reloadEndsAt - workspace:GetServerTimeNow(), 0.05, reloadTime)
    end

    Hud.SetArc(reloadTime, Color3.fromRGB(228, 232, 240), reloadTime - v35)
    ctx.emit("Reload", {time = v35, total = reloadTime})
    local reloadSpeedMult = self.tuning.reloadSpeedMult
    local v43 = Util.ProbeValues()
    local v44 = ctx.setSpeed("Reload", reloadSpeedMult)
    local v45 = v43 and v43.k * (reloadSpeedMult or 1)

    if v44 ~= v45 then
        Util.Hooked()
    end

    local v46 = 0.55 - (os.clock() - self.lastShot)

    local function crank()
        --[[
          name: crank
          line: 184
          upvalues:
            self (copy, index: 1)
            reloadToken (copy, index: 2)
            Util (copy, index: 3)
            ctx (copy, index: 4)
            v35 (ref,  index: 5)
            v46 (copy, index: 6)
        ]]
        if self.reloadToken == reloadToken and self.reloading then
            local v48 = Util.PlayAnim(ctx.animator, self.preset.reload, 1, 0.1)
            local v49 = math.max(0.2, v35 - math.max(0, v46))

            if v48 and 0 < v48.Length then
                v48:AdjustSpeed(v48.Length / v49)
            end

            if not Util.InFirstPerson() then
                Util.Sound((self.preset.reloadSound or "Crossbow_Reload"), ctx.root)

                if self.preset.reloadSound2 then
                    Util.Sound(self.preset.reloadSound2, ctx.root)
                end
            end
        end
    end

    if not (0 < v46) then
        crank()
    else
        task.delay(v46, crank)
    end

    task.delay(
        v35 + 0.4,
        function()
            --[[
              line: 206
              upvalues:
                self (copy, index: 1)
                reloadToken (copy, index: 2)
            ]]
            if self.reloadToken == reloadToken and self.reloading then
                self:FinishReload()
                self:SyncAmmo()
            end
        end
    )
end

function Class.RequestReload(self)
    --[[
      name: RequestReload
      line: 215
    ]]
    if not self.reloading then
        local ammo = self.ammo

        if not (self.magazine <= ammo) and not self:OutOfAmmo() then
            self.ctx.send("Reload", {tool = self.ctx.tool})
            self:LocalReload()
        end
    end
end

function Class.Fire(self)
    --[[
      name: Fire
      line: 227
      upvalues:
        Util (copy, index: 1)
        Hud (copy, index: 2)
        Effects (copy, index: 3)
        Combat (copy, index: 4)
        Poses (copy, index: 5)
    ]]
    local ctx = self.ctx
    local tuning = self.tuning
    local preset = self.preset
    local timestamp = os.clock()

    if self.reloading then
        return "reloading"
    end
    if timestamp - self.lastShot < (tuning.fireInterval or 0.3) or 0 < Util.GuardRecovery(self.ctx.tool) then
        return "cooldown"
    end
    if not Util.CanAct() then
        return "frozen"
    end

    if self:OutOfAmmo() then
        self.lastShot = timestamp
        return "empty"
    end

    if self.ammo <= 0 then
        self.lastShot = timestamp
        Util.Sound((preset.emptySound or "Dry_Fire"), ctx.root)
        self:RequestReload()

        return "empty"
    end

    self.lastShot = timestamp
    self.bufferedAt = nil
    self.ammo -= 1
    Hud.SetPips(self.ammo, self.magazine)
    Util.FaceCamera()
    local v57 = Util.ProbeValues()
    local root = ctx.root

    if v57 and root then
        v57.at = root.Position + v57.o
        local v59 = Util.AimDirection(v57.at)

        if v59 ~= v57.at then
            Util.Hooked()
        end
    end

    local origin = Util.ShotOrigin(ctx.tool, "Muzzle")
    local dir = Util.AssistDirection(origin, Util.AimDirection(origin), false)
    local id = ctx.nextId()
    local v63 = Effects.MyKey(id)
    local v64 = Combat.ShotSpeed(tuning)
    local v65 = Util.ShotKind(ctx.char, tuning.ammo, (tuning.projectile or "Bolt"))
    local aimed = self:Aimed()

    if self.kind ~= "Blunderbuss" then
        local v67 = self.kind == "Crossbow" and 0
            or (if aimed then tuning.spreadAim or 0 else tuning.spreadHip or 0)
        local v68 = Combat.SpreadDir(dir, v67, self:Seed(id), 0)
        Effects.Projectile(v63, v65, origin, v68 * v64, (tuning.gravity or 0), ctx.char, {damage = tuning.damage * Util.ItemBonus(ctx.weaponId), tuning = tuning})
    else
        local v69

        if aimed then
            v69 = tuning.spreadAim or tuning.spread
        else
            v69 = tuning.spread
        end

        Effects.Pellets(v63, v65, origin, dir, v64, (tuning.gravity or 0), (tuning.pellets or 8), (v69 or 6), self:Seed(id), ctx.char, {damage = tuning.damage * Util.ItemBonus(ctx.weaponId), tuning = tuning})
    end

    ctx.send("Shoot", {tool = ctx.tool, origin = origin, dir = dir, id = id})
    Util.PlayAnim(ctx.animator, preset.fire, (preset.fireAnimSpeed or 1.2), 0.02)
    Util.Sound((preset.fireSound or "Crossbow_Fire"), ctx.root)

    if preset.flash or preset.puff then
        local muzzle = Effects.Muzzle
        local cframe = CFrame.lookAt(origin, origin + dir)
        muzzle(cframe, self.kind ~= "Pistol", preset.puff ~= false, Util.InFirstPerson())
    end

    local kick = tuning.kick or preset.kick or 2
    ctx.emit("Fire", {kick = kick, aimed = aimed})
    local climb = tuning.climb

    if type(climb) ~= "number" then
        Util.Recoil(kick, ((math.random() - 0.5) * kick) * 0.5)
    else
        local v74 = tuning.jolt or kick * 0.585
        Util.RecoilSlow(v74, ((math.random() - 0.5) * v74) * 0.25, climb, ((math.random() - 0.5) * climb) * 0.5)
    end

    Util.Shake((tuning.shake or preset.shake or 0.25), 0.14)

    if preset.fovPunch then
        Util.FovKick(-preset.fovPunch, 0.025, 0.22)
    end

    Hud.Kick(kick * 3)
    Poses.Kick(ctx.char, kick * 5)

    if self.ammo <= 0 and (not tuning.ammo or 1 < Util.AmmoLeft(ctx.char, tuning.ammo)) then
        task.delay(
            0.25,
            function()
                --[[
                  line: 307
                  upvalues:
                    ctx (copy, index: 1)
                    self (copy, index: 2)
                ]]
                if ctx.tool and ctx.tool.Parent == ctx.char then
                    self:LocalReload()
                end
            end
        )
    end

    return "fired"
end

function Class.Seed(self, a76)
    --[[
      name: Seed
      line: 317
      upvalues:
        Combat (copy, index: 1)
    ]]
    local shotNonce
    local shotNonce2 = self.ctx.char:GetAttribute("ShotNonce")
    local seedFor = Combat.SeedFor

    if type(shotNonce2) ~= "number" then
        shotNonce = 0
    else
        shotNonce = shotNonce2
    end

    return seedFor(a76, shotNonce)
end

function Class.SetAim(self, aim)
    --[[
      name: SetAim
      line: 322
      upvalues:
        Util (copy, index: 1)
    ]]
    local ctx = self.ctx

    if self.aiming == aim then
        return
    end

    self.aiming = aim
    self.aimStart = os.clock()
    self.aimSent = os.clock()
    Util.SetAiming(aim, self.tuning.aimFov)

    if aim then
        Util.PlayAnim(ctx.animator, self.preset.aim, 1, 0.12)
    else
        Util.StopAnim(ctx.animator, self.preset.aim, 0.18)
    end

    ctx.send("Aim", {tool = ctx.tool, on = aim})
    local setSpeed = ctx.setSpeed
    local v84 = if aim then self.tuning.aimSpeedMult or 0.8 else nil
    setSpeed("Aim", v84)
end

function Class.Input(self, a86, holding)
    --[[
      name: Input
      line: 341
    ]]
    if a86 ~= "Primary" then
        if a86 == "Secondary" then
            self:SetAim(holding)
            return
        end

        if a86 == "Reload" and holding then
            self:RequestReload()
        end
    else
        self.holding = holding

        if holding and self:Fire() == "cooldown" then
            self.bufferedAt = os.clock()
        end
    end
end

function Class.Update(self, a89)
    --[[
      name: Update
      line: 354
      upvalues:
        Hud (copy, index: 1)
    ]]
    if self.aiming and 1 < os.clock() - (self.aimSent or 0) then
        self.aimSent = os.clock()
        self.ctx.send("Aim", {on = true, tool = self.ctx.tool})
    end

    if self.bufferedAt then
        if not (0.15 < os.clock() - self.bufferedAt) then
            if self:Fire() ~= "cooldown" then
                self.bufferedAt = nil
            end
        else
            self.bufferedAt = nil
        end
    end

    local v90 = self:TargetSpread()
    self.spreadNow += ((v90 - self.spreadNow) * math.min(1, a89 * 14))
    Hud.SetSpread(self.spreadNow)
end

function Class.Interrupt(a91)
    --[[
      name: Interrupt
      line: 372
    ]]
end

function Class.OnDenied(self, a93)
    --[[
      name: OnDenied
      line: 375
    ]]
    if a93 == "NoAmmo" then
        self.lastDry = 0
        self:OutOfAmmo()
    end
end

return Class