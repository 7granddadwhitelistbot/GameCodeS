local ReplicatedStorage_1 = game:GetService("ReplicatedStorage")
local Parent_1 = script.Parent.Parent
local Util_upv_1 = require(Parent_1.Util)
local Hud_upv_1 = require(Parent_1.Hud)
local Effects_upv_1 = require(Parent_1.Effects)
local Combat_upv_1 = require(ReplicatedStorage_1:WaitForChild("Shared"):WaitForChild("Combat"))
local tbl_upv_1 = {}
tbl_upv_1.__index = tbl_upv_1
function tbl_upv_1.new(a1)
    --[[
      name: new
      line: 19
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v1 = setmetatable({}, tbl_upv_1)
    v1.ctx = a1
    v1.tuning = a1.tuning
    v1.preset = a1.preset
    v1.drawing = false
    v1.drawStart = 0
    v1.lastShot = -math.huge
    v1.aiming = false
    v1.full = false
    v1.drawSound = nil
    v1.m1Down = false
    v1.bufferedAt = nil
    return v1
end
function tbl_upv_1.SyncPool(a1)
    --[[
      name: SyncPool
      line: 35
      upvalues:
        Hud_upv_1 (copy, index: 1)
        Util_upv_1 (copy, index: 2)
    ]]
    local ammo_1 = a1.tuning.ammo
    if not ammo_1 then
        return
    end
    Hud_upv_1.SetAmmoCount(Util_upv_1.AmmoShown(a1.ctx.char, ammo_1))
end
function tbl_upv_1.OutOfAmmo(a1)
    --[[
      name: OutOfAmmo
      line: 43
      upvalues:
        Util_upv_1 (copy, index: 1)
        Hud_upv_1 (copy, index: 2)
    ]]
    local ammo_2 = a1.tuning.ammo
    if ammo_2 and not (Util_upv_1.AmmoLeft(a1.ctx.char, ammo_2) >= 1) then
        local v2 = os.clock()
        if v2 - (a1.lastDry or 0) > 0.4 then
            a1.lastDry = v2
            Util_upv_1.Sound("Dry_Fire", a1.ctx.root)
            Hud_upv_1.Toast(Util_upv_1.AMMO_OUT[ammo_2] or "OUT OF AMMO", Color3.fromRGB(255, 110, 90), 1)
        end
        return true
    end
    return false
end
function tbl_upv_1.Equip(a1)
    --[[
      name: Equip
      line: 57
      upvalues:
        Hud_upv_1 (copy, index: 1)
        Util_upv_1 (copy, index: 2)
    ]]
    Hud_upv_1.SetStyle("Bow")
    Hud_upv_1.SetPips(0, 0)
    Util_upv_1.PlayAnim(a1.ctx.animator, a1.preset.hold, 1, 0.2)
    if not (Util_upv_1.InFirstPerson()) then
        Util_upv_1.Sound(a1.preset.equip or "Equip_Bow", a1.ctx.root)
    end
    local ammo_3 = a1.tuning.ammo
    if not ammo_3 or not a1.ctx.char then
        return
    end
    a1:SyncPool()
    a1.poolConns = Util_upv_1.WatchAmmo(
        a1.ctx.char,
        ammo_3,
        function()
            --[[
              line: 67
              upvalues:
                a1 (copy, index: 1)
            ]]
            a1:SyncPool()
        end
    )
end
function tbl_upv_1.Unequip(a1)
    --[[
      name: Unequip
      line: 73
      upvalues:
        Util_upv_1 (copy, index: 1)
        Effects_upv_1 (copy, index: 2)
        Hud_upv_1 (copy, index: 3)
    ]]
    local ctx_1 = a1.ctx
    if a1.drawing then
        a1:CancelDraw()
    end
    if a1.aiming then
        a1.aiming = false
        Util_upv_1.SetAiming(false)
        ctx_1.setSpeed("Aim", nil)
    end
    Util_upv_1.StopAnim(ctx_1.animator, a1.preset.hold, 0.15)
    Util_upv_1.StopAnim(ctx_1.animator, a1.preset.aim, 0.15)
    Effects_upv_1.ChargeGlow(ctx_1.tool, 0)
    Util_upv_1.SetCameraModifier("CombatDraw", nil)
    a1.bufferedAt = nil
    if a1.poolConns then
        for _, value_1 in a1.poolConns do
            value_1:Disconnect()
        end
        a1.poolConns = nil
    end
    Hud_upv_1.SetAmmoCount(nil)
end
function tbl_upv_1.Charge(a1)
    --[[
      name: Charge
      line: 97
    ]]
    if a1.drawing then
        return (math.clamp((os.clock() - a1.drawStart) / (a1.tuning.drawTime or 1), 0, 1))
    end
    return 0
end
function tbl_upv_1.StartDraw(a1)
    --[[
      name: StartDraw
      line: 104
      upvalues:
        Util_upv_1 (copy, index: 1)
    ]]
    local ctx_2 = a1.ctx
    local v3 = os.clock()
    if not (a1.drawing) and not (v3 - a1.lastShot < (a1.nextCd or (a1.tuning.cooldown or 0.25))) and Util_upv_1.CanAct() and not (Util_upv_1.GuardRecovery(ctx_2.tool) > 0) then
        if a1:OutOfAmmo() then
            a1.bufferedAt = nil
            return false
        else
            a1.bufferedAt = nil
            Util_upv_1.SetCameraModifier("CombatDraw", {pivot = Vector3.new(0.30000001192092896, 0, 0), fov = -6})
            a1.drawing = true
            a1.full = false
            a1.drawStart = v3
            ctx_2.send("Charge", {kind = "Draw", on = true, tool = ctx_2.tool})
            ctx_2.emit("Draw", {on = true, time = a1.tuning.drawTime or 1, arrow = Util_upv_1.ShotKind(ctx_2.char, a1.tuning.ammo, a1.tuning.projectile or "Arrow")})
            Util_upv_1.FaceCamera()
            local v4 = 0.88 / math.max(0.3, a1.tuning.drawTime or 1)
            Util_upv_1.PlayHold(ctx_2.animator, a1.preset.draw, v4)
            a1.drawSound = Util_upv_1.Sound(a1.preset.drawSound or "Bow_Draw", ctx_2.root, {PlaybackSpeed = math.clamp(v4, 0.7, 1.3)})
            v4 = Util_upv_1.ProbeValues()
            if v4 and ctx_2.setSpeed(v4.s, 1) ~= v4.s then
                Util_upv_1.Hooked()
            end
            ctx_2.setSpeed("Draw", a1.tuning.drawSpeedMult or 0.7)
            return true
        end
    end
    return false
end
function tbl_upv_1.CancelDraw(a1)
    --[[
      name: CancelDraw
      line: 137
      upvalues:
        Util_upv_1 (copy, index: 1)
        Hud_upv_1 (copy, index: 2)
        Effects_upv_1 (copy, index: 3)
    ]]
    local ctx_3 = a1.ctx
    a1.drawing = false
    ctx_3.send("Charge", {kind = "Draw", on = false, tool = ctx_3.tool})
    ctx_3.emit("Draw", {on = false})
    Util_upv_1.StopAnim(ctx_3.animator, a1.preset.draw, 0.12)
    if a1.drawSound then
        a1.drawSound:Stop()
        a1.drawSound = nil
    end
    ctx_3.setSpeed("Draw", nil)
    Hud_upv_1.SetCharge(0)
    Effects_upv_1.ChargeGlow(ctx_3.tool, 0)
    Util_upv_1.SetCameraModifier("CombatDraw", nil)
end
function tbl_upv_1.Fire(a1)
    --[[
      name: Fire
      line: 153
      upvalues:
        Util_upv_1 (copy, index: 1)
        Hud_upv_1 (copy, index: 2)
        Effects_upv_1 (copy, index: 3)
        Combat_upv_1 (copy, index: 4)
    ]]
    local ctx_4 = a1.ctx
    local tuning_1 = a1.tuning
    if not a1.drawing then
        return
    end
    if Util_upv_1.CanAct() then
        local v5 = a1:Charge()
        a1.drawing = false
        a1.lastShot = os.clock()
        ctx_4.emit("Release", {charge = v5})
        local v6 = a1.tuning.cooldown or 0.2
        a1.nextCd = v6 + (((a1.tuning.tapCooldown or (a1.tuning.cooldown or 0.2)) - v6) * (1 - v5))
        if a1.drawSound then
            a1.drawSound:Stop()
            a1.drawSound = nil
        end
        Util_upv_1.StopAnim(ctx_4.animator, a1.preset.draw, 0.05)
        Util_upv_1.PlayAnim(ctx_4.animator, a1.preset.fire, a1.preset.fireAnimSpeed or 1.2, 0.03)
        Util_upv_1.SetCameraModifier("CombatDraw", nil)
        ctx_4.setSpeed("Draw", nil)
        Hud_upv_1.SetCharge(0)
        Effects_upv_1.ChargeGlow(ctx_4.tool, 0)
        local v7 = Util_upv_1.ProbeValues()
        if v7 and Util_upv_1.AimDirection(v7.v) ~= v7.v then
            Util_upv_1.Hooked()
        end
        local v8 = Util_upv_1.ShotOrigin(ctx_4.tool, "Muzzle")
        local v9 = Util_upv_1.AssistDirection(v8, Util_upv_1.AimDirection(v8), true)
        local v10, v11 = Combat_upv_1.DrawnShot(tuning_1, v5)
        local v12 = ctx_4.nextId()
        Effects_upv_1.Projectile(Effects_upv_1.MyKey(v12), Util_upv_1.ShotKind(ctx_4.char, tuning_1.ammo, tuning_1.projectile or "Arrow"), v8, v9 * v11, tuning_1.gravity or 60, ctx_4.char, {damage = v10 * Util_upv_1.ItemBonus(ctx_4.weaponId), tuning = tuning_1})
        ctx_4.send("Shoot", {tool = ctx_4.tool, origin = v8, dir = v9, id = v12, charge = v5})
        Util_upv_1.Sound(a1.preset.fireSound or "Bow_Release", ctx_4.root, {PlaybackSpeed = 0.9 + (0.25 * v5), Volume = 0.6 + (0.4 * v5)})
        Util_upv_1.Recoil(1 + (1.8 * v5), (math.random() - 0.5) * 0.6)
        Util_upv_1.Shake(0.1 + (0.15 * v5), 0.12)
        Hud_upv_1.Kick(6 * v5)
    else
        a1:CancelDraw()
    end
end
function tbl_upv_1.Input(a1, a2, a3)
    --[[
      name: Input
      line: 200
      upvalues:
        Util_upv_1 (copy, index: 1)
    ]]
    if a2 == "Primary" then
        a1.m1Down = a3
        if a3 then
            if (a1:StartDraw()) or (a1.drawing) or (a1:OutOfAmmo()) then
                return
            end
            a1.bufferedAt = os.clock()
        else
            a1:Fire()
        end
    elseif a2 == "Secondary" then
        a1.aiming = a3
        Util_upv_1.SetAiming(a3, a1.tuning.aimFov)
        a1.ctx.setSpeed("Aim", (a3 and 0.8) or nil)
        if a3 then
            Util_upv_1.PlayAnim(a1.ctx.animator, a1.preset.aim, 1, 0.15)
        else
            Util_upv_1.StopAnim(a1.ctx.animator, a1.preset.aim, 0.15)
        end
    end
end
function tbl_upv_1.Update(a1, a2)
    --[[
      name: Update
      line: 222
      upvalues:
        Hud_upv_1 (copy, index: 1)
        Effects_upv_1 (copy, index: 2)
        Util_upv_1 (copy, index: 3)
    ]]
    if a1.bufferedAt and not (a1.drawing) then
        if a1.m1Down or not (os.clock() - a1.bufferedAt > 0.15) then
            if a1:StartDraw() and not (a1.m1Down) then
                a1:Fire()
            end
        else
            a1.bufferedAt = nil
        end
    end
    if a1.drawing then
        local v13 = a1:Charge()
        Hud_upv_1.SetCharge(v13)
        local glow_1 = a1.preset.glow
        Effects_upv_1.ChargeGlow(a1.ctx.tool, v13, glow_1)
        if not (v13 >= 1) or (a1.full) then
            return
        end
        a1.full = true
        Util_upv_1.Sound(a1.preset.fullSound or "Bow_Full", a1.ctx.root)
        Effects_upv_1.ChargePing(a1.ctx.tool, glow_1)
    end
end
function tbl_upv_1.Interrupt(a1)
    --[[
      name: Interrupt
      line: 243
    ]]
    if not a1.drawing then
        return
    end
    a1:CancelDraw()
end
function tbl_upv_1.OnDenied(a1, a2)
    --[[
      name: OnDenied
      line: 250
    ]]
    if a2 ~= "NoAmmo" then
        return
    end
    a1.lastDry = 0
    a1:OutOfAmmo()
end
return tbl_upv_1