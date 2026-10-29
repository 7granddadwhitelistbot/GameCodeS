local ReplicatedStorage_1 = game:GetService("ReplicatedStorage")
local Parent_1 = script.Parent.Parent
local Util_upv_1 = require(Parent_1.Util)
local Hud_upv_1 = require(Parent_1.Hud)
local Effects_upv_1 = require(Parent_1.Effects)
local Poses_upv_1 = require(Parent_1.Poses)
local Combat_upv_1 = require(ReplicatedStorage_1:WaitForChild("Shared"):WaitForChild("Combat"))
local tbl_upv_1 = {}
tbl_upv_1.__index = tbl_upv_1
function tbl_upv_1.new(a1)
    --[[
      name: new
      line: 24
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v1 = setmetatable({}, tbl_upv_1)
    v1.ctx = a1
    v1.tuning = a1.tuning
    v1.preset = a1.preset
    v1.kind = a1.kind
    v1.magazine = a1.tuning.magazine or 1
    v1.ammo = v1.magazine
    v1.reloading = false
    v1.reloadToken = 0
    v1.lastShot = -math.huge
    v1.holding = false
    v1.aiming = false
    v1.aimStart = 0
    v1.spreadNow = 0
    v1.conns = {}
    v1.bufferedAt = nil
    return v1
end
function tbl_upv_1.SyncAmmo(a1)
    --[[
      name: SyncAmmo
      line: 44
      upvalues:
        Hud_upv_1 (copy, index: 1)
    ]]
    local tool_1 = a1.ctx.tool
    local v2 = tool_1 and (tool_1:GetAttribute("Ammo"))
    if type(v2) == "number" then
        a1.ammo = v2
    end
    Hud_upv_1.SetPips(a1.ammo, a1.magazine)
end
function tbl_upv_1.SyncPool(a1)
    --[[
      name: SyncPool
      line: 53
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
      line: 61
      upvalues:
        Util_upv_1 (copy, index: 1)
        Hud_upv_1 (copy, index: 2)
    ]]
    local ammo_2 = a1.tuning.ammo
    if ammo_2 and not (Util_upv_1.AmmoLeft(a1.ctx.char, ammo_2) >= 1) then
        local v3 = os.clock()
        if v3 - (a1.lastDry or 0) > 0.4 then
            a1.lastDry = v3
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
      line: 75
      upvalues:
        Hud_upv_1 (copy, index: 1)
        Util_upv_1 (copy, index: 2)
    ]]
    local ctx_upv_1 = a1.ctx
    Hud_upv_1.SetStyle(a1.preset.crosshair or "Gun")
    a1:SyncAmmo()
    local ammo_3 = a1.tuning.ammo
    if ammo_3 and ctx_upv_1.char then
        a1:SyncPool()
        a1.poolConns = Util_upv_1.WatchAmmo(
            ctx_upv_1.char,
            ammo_3,
            function()
                --[[
                  line: 82
                  upvalues:
                    a1 (copy, index: 1)
                ]]
                a1:SyncPool()
            end
        )
    end
    a1.spreadNow = a1:TargetSpread()
    Util_upv_1.PlayAnim(ctx_upv_1.animator, a1.preset.hold, 1, 0.2)
    if not (Util_upv_1.InFirstPerson()) then
        Util_upv_1.Sound(a1.preset.equip or "Equip_Crossbow", ctx_upv_1.root)
    end
    local tool_upv_2 = ctx_upv_1.tool
    table.insert(
        a1.conns,
        tool_upv_2:GetAttributeChangedSignal("Ammo"):Connect(
            function()
                --[[
                  line: 93
                  upvalues:
                    a1 (copy, index: 1)
                    Util_upv_1 (copy, index: 2)
                    ctx_upv_1 (copy, index: 3)
                ]]
                a1:SyncAmmo()
                if not (a1.magazine <= a1.ammo) or not a1.reloading then
                    return
                end
                a1:FinishReload()
                if not a1.preset.reloadDoneSound or (Util_upv_1.InFirstPerson()) then
                    return
                end
                Util_upv_1.Sound(a1.preset.reloadDoneSound, ctx_upv_1.root)
            end
        )
    )
    table.insert(
        a1.conns,
        tool_upv_2:GetAttributeChangedSignal("Reloading"):Connect(
            function()
                --[[
                  line: 103
                  upvalues:
                    tool_upv_2 (copy, index: 1)
                    a1 (copy, index: 2)
                ]]
                if tool_upv_2:GetAttribute("Reloading") ~= true or (a1.reloading) then
                    return
                end
                a1:LocalReload()
            end
        )
    )
    if not (a1.ammo <= 0) and tool_upv_2:GetAttribute("Reloading") ~= true then
        return
    end
    a1:LocalReload()
end
function tbl_upv_1.Unequip(a1)
    --[[
      name: Unequip
      line: 113
      upvalues:
        Hud_upv_1 (copy, index: 1)
        Util_upv_1 (copy, index: 2)
    ]]
    local ctx_2 = a1.ctx
    for _, value_1 in a1.conns do
        value_1:Disconnect()
    end
    table.clear(a1.conns)
    a1.holding = false
    a1.reloading = false
    a1.reloadToken = a1.reloadToken + 1
    Hud_upv_1.SetArc(nil)
    Hud_upv_1.SetPips(0, 0)
    if a1.aiming then
        a1:SetAim(false)
    end
    ctx_2.setSpeed("Reload", nil)
    Util_upv_1.StopAnim(ctx_2.animator, a1.preset.hold, 0.15)
    Util_upv_1.StopAnim(ctx_2.animator, a1.preset.aim, 0.1)
    Util_upv_1.StopAnim(ctx_2.animator, a1.preset.fire, 0.1)
    Util_upv_1.StopAnim(ctx_2.animator, a1.preset.reload, 0.1)
    if a1.poolConns then
        for _, value_2 in a1.poolConns do
            value_2:Disconnect()
        end
        a1.poolConns = nil
    end
    Hud_upv_1.SetAmmoCount(nil)
end
function tbl_upv_1.Aimed(a1)
    --[[
      name: Aimed
      line: 141
    ]]
    local v4 = a1.aiming and (os.clock() - a1.aimStart >= 0.12)
    return v4
end
function tbl_upv_1.TargetSpread(a1)
    --[[
      name: TargetSpread
      line: 145
    ]]
    local tuning_1 = a1.tuning
    if a1.kind ~= "Blunderbuss" then
        if a1.kind ~= "Crossbow" then
            if a1:Aimed() then
                return tuning_1.spreadAim or 0
            end
            return tuning_1.spreadHip or 0
        end
        return 0.4
    else
        local v5
        if a1:Aimed() then
            v5 = tuning_1.spreadAim
            if not (v5) then
                v5 = tuning_1.spread
                if not v5 then
                    return 6
                end
            end
        else
            v5 = tuning_1.spread or 6
        end
        return v5
    end
end
function tbl_upv_1.FinishReload(a1)
    --[[
      name: FinishReload
      line: 155
      upvalues:
        Hud_upv_1 (copy, index: 1)
    ]]
    a1.reloading = false
    a1.ctx.emit("ReloadEnd", nil)
    a1.ctx.setSpeed("Reload", nil)
    Hud_upv_1.SetArc(nil)
end
function tbl_upv_1.LocalReload(a1)
    --[[
      name: LocalReload
      line: 162
      upvalues:
        Hud_upv_1 (copy, index: 1)
        Util_upv_1 (copy, index: 2)
    ]]
    local ctx_upv_3 = a1.ctx
    if a1.reloading then
        return
    end
    a1.reloading = true
    a1.reloadToken = a1.reloadToken + 1
    local reloadToken_upv_1 = a1.reloadToken
    local v6 = a1.tuning.reloadTime or 1.5
    local v7 = ctx_upv_3.tool:GetAttribute("ReloadEndsAt")
    local u1
    if type(v7) == "number" and v7 > 0 then
        u1 = math.clamp(v7 - workspace:GetServerTimeNow(), 0.05, v6)
    else
        u1 = v6
    end
    Hud_upv_1.SetArc(v6, Color3.fromRGB(228, 232, 240), v6 - u1)
    ctx_upv_3.emit("Reload", {time = u1, total = v6})
    ctx_upv_3.setSpeed("Reload", a1.tuning.reloadSpeedMult)
    local u2 = 0.55 - (os.clock() - a1.lastShot)
    local function crank()
        --[[
          name: crank
          line: 181
          upvalues:
            a1 (copy, index: 1)
            reloadToken_upv_1 (copy, index: 2)
            Util_upv_1 (copy, index: 3)
            ctx_upv_3 (copy, index: 4)
            u1 (ref,  index: 5)
            u2 (copy, index: 6)
        ]]
        if a1.reloadToken ~= reloadToken_upv_1 then
            return
        end
        if a1.reloading then
            local v8 = Util_upv_1.PlayAnim(ctx_upv_3.animator, a1.preset.reload, 1, 0.1)
            local v9 = math.max(0.2, u1 - math.max(0, u2))
            if v8 and v8.Length > 0 then
                v8:AdjustSpeed(v8.Length / v9)
            end
            if not (Util_upv_1.InFirstPerson()) then
                Util_upv_1.Sound(a1.preset.reloadSound or "Crossbow_Reload", ctx_upv_3.root)
                if a1.preset.reloadSound2 then
                    Util_upv_1.Sound(a1.preset.reloadSound2, ctx_upv_3.root)
                end
            end
        end
    end
    if u2 > 0 then
        task.delay(u2, crank)
    else
        crank()
    end
    task.delay(
        u1 + 0.4,
        function()
            --[[
              line: 203
              upvalues:
                a1 (copy, index: 1)
                reloadToken_upv_1 (copy, index: 2)
            ]]
            if a1.reloadToken ~= reloadToken_upv_1 or not a1.reloading then
                return
            end
            a1:FinishReload()
            a1:SyncAmmo()
        end
    )
end
function tbl_upv_1.RequestReload(a1)
    --[[
      name: RequestReload
      line: 212
    ]]
    if (a1.reloading) or (a1.magazine <= a1.ammo) or a1:OutOfAmmo() then
        return
    end
    a1.ctx.send("Reload", {tool = a1.ctx.tool})
    a1:LocalReload()
end
function tbl_upv_1.Fire(a1)
    --[[
      name: Fire
      line: 224
      upvalues:
        Util_upv_1 (copy, index: 1)
        Hud_upv_1 (copy, index: 2)
        Effects_upv_1 (copy, index: 3)
        Combat_upv_1 (copy, index: 4)
        Poses_upv_1 (copy, index: 5)
    ]]
    local ctx_upv_4 = a1.ctx
    local tuning_2 = a1.tuning
    local preset_1 = a1.preset
    local v10 = os.clock()
    if a1.reloading then
        return "reloading"
    end
    if not (v10 - a1.lastShot < (tuning_2.fireInterval or 0.3)) and not (Util_upv_1.GuardRecovery(a1.ctx.tool) > 0) then
        if Util_upv_1.CanAct() then
            if a1:OutOfAmmo() then
                a1.lastShot = v10
                return "empty"
            elseif a1.ammo <= 0 then
                a1.lastShot = v10
                Util_upv_1.Sound(preset_1.emptySound or "Dry_Fire", ctx_upv_4.root)
                a1:RequestReload()
                return "empty"
            else
                a1.lastShot = v10
                a1.bufferedAt = nil
                a1.ammo = a1.ammo - 1
                Hud_upv_1.SetPips(a1.ammo, a1.magazine)
                Util_upv_1.FaceCamera()
                local v11 = Util_upv_1.ShotOrigin(ctx_upv_4.tool, "Muzzle")
                local v12 = Util_upv_1.AssistDirection(v11, Util_upv_1.AimDirection(v11), false)
                local v13 = ctx_upv_4.nextId()
                local v14 = Effects_upv_1.MyKey(v13)
                local v15 = Combat_upv_1.ShotSpeed(tuning_2)
                local v16 = Util_upv_1.ShotKind(ctx_upv_4.char, tuning_2.ammo, tuning_2.projectile or "Bolt")
                local v17 = a1:Aimed()
                if a1.kind ~= "Blunderbuss" then
                    local v18
                    if a1.kind == "Crossbow" then
                        v18 = 0
                    elseif v17 then
                        v18 = tuning_2.spreadAim or 0
                    else
                        v18 = tuning_2.spreadHip or 0
                    end
                    Effects_upv_1.Projectile(v14, v16, v11, Combat_upv_1.SpreadDir(v12, v18, a1:Seed(v13), 0) * v15, tuning_2.gravity or 0, ctx_upv_4.char, {damage = tuning_2.damage * Util_upv_1.ItemBonus(ctx_upv_4.weaponId), tuning = tuning_2})
                else
                    local v18 = v17 and tuning_2.spreadAim or (tuning_2.spread)
                    Effects_upv_1.Pellets(v14, v16, v11, v12, v15, tuning_2.gravity or 0, tuning_2.pellets or 8, v18 or 6, a1:Seed(v13), ctx_upv_4.char, {damage = tuning_2.damage * Util_upv_1.ItemBonus(ctx_upv_4.weaponId), tuning = tuning_2})
                end
                ctx_upv_4.send("Shoot", {tool = ctx_upv_4.tool, origin = v11, dir = v12, id = v13})
                Util_upv_1.PlayAnim(ctx_upv_4.animator, preset_1.fire, preset_1.fireAnimSpeed or 1.2, 0.02)
                Util_upv_1.Sound(preset_1.fireSound or "Crossbow_Fire", ctx_upv_4.root)
                if preset_1.flash or preset_1.puff then
                    local Muzzle_1 = Effects_upv_1.Muzzle
                    local v19 = CFrame.lookAt(v11, v11 + v12)
                    Muzzle_1(v19, a1.kind ~= "Pistol", preset_1.puff ~= false, Util_upv_1.InFirstPerson())
                end
                v16 = tuning_2.kick or (preset_1.kick or 2)
                ctx_upv_4.emit("Fire", {kick = v16, aimed = v17})
                local climb_1 = tuning_2.climb
                if type(climb_1) ~= "number" then
                    Util_upv_1.Recoil(v16, ((math.random() - 0.5) * v16) * 0.5)
                else
                    v15 = tuning_2.jolt or (v16 * 0.585)
                    Util_upv_1.RecoilSlow(v15, ((math.random() - 0.5) * v15) * 0.25, climb_1, ((math.random() - 0.5) * climb_1) * 0.5)
                end
                Util_upv_1.Shake(tuning_2.shake or (preset_1.shake or 0.25), 0.14)
                if preset_1.fovPunch then
                    Util_upv_1.FovKick(-preset_1.fovPunch, 0.025, 0.22)
                end
                Hud_upv_1.Kick(v16 * 3)
                Poses_upv_1.Kick(ctx_upv_4.char, v16 * 5)
                if a1.ammo <= 0 and (not (tuning_2.ammo) or Util_upv_1.AmmoLeft(ctx_upv_4.char, tuning_2.ammo) > 1) then
                    task.delay(
                        0.25,
                        function()
                            --[[
                              line: 297
                              upvalues:
                                ctx_upv_4 (copy, index: 1)
                                a1 (copy, index: 2)
                            ]]
                            if not ctx_upv_4.tool or ctx_upv_4.tool.Parent ~= ctx_upv_4.char then
                                return
                            end
                            a1:LocalReload()
                        end
                    )
                end
                return "fired"
            end
        else
            return "frozen"
        end
    end
    return "cooldown"
end
function tbl_upv_1.Seed(a1, a2)
    --[[
      name: Seed
      line: 307
      upvalues:
        Combat_upv_1 (copy, index: 1)
    ]]
    local v20 = a1.ctx.char:GetAttribute("ShotNonce")
    local SeedFor_1 = Combat_upv_1.SeedFor
    local v21
    if type(v20) ~= "number" then
        v21 = 0
    else
        v21 = v20
    end
    return SeedFor_1(a2, v21)
end
function tbl_upv_1.SetAim(a1, a2)
    --[[
      name: SetAim
      line: 312
      upvalues:
        Util_upv_1 (copy, index: 1)
    ]]
    local ctx_5 = a1.ctx
    if a1.aiming == a2 then
        return
    end
    a1.aiming = a2
    a1.aimStart = os.clock()
    a1.aimSent = os.clock()
    Util_upv_1.SetAiming(a2, a1.tuning.aimFov)
    if a2 then
        Util_upv_1.PlayAnim(ctx_5.animator, a1.preset.aim, 1, 0.12)
    else
        Util_upv_1.StopAnim(ctx_5.animator, a1.preset.aim, 0.18)
    end
    ctx_5.send("Aim", {tool = ctx_5.tool, on = a2})
    local setSpeed_1 = ctx_5.setSpeed
    local v22
    if a2 then
        v22 = a1.tuning.aimSpeedMult or 0.8
    else
        v22 = nil
    end
    setSpeed_1("Aim", v22)
end
function tbl_upv_1.Input(a1, a2, a3)
    --[[
      name: Input
      line: 331
    ]]
    if a2 == "Primary" then
        a1.holding = a3
        if not a3 or a1:Fire() ~= "cooldown" then
            return
        end
        a1.bufferedAt = os.clock()
    elseif a2 == "Secondary" then
        a1:SetAim(a3)
    elseif a2 == "Reload" and a3 then
        a1:RequestReload()
    end
end
function tbl_upv_1.Update(a1, a2)
    --[[
      name: Update
      line: 344
      upvalues:
        Hud_upv_1 (copy, index: 1)
    ]]
    if a1.aiming and os.clock() - (a1.aimSent or 0) > 1 then
        a1.aimSent = os.clock()
        a1.ctx.send("Aim", {on = true, tool = a1.ctx.tool})
    end
    if a1.bufferedAt and (os.clock() - a1.bufferedAt > 0.15 or a1:Fire() ~= "cooldown") then
        a1.bufferedAt = nil
    end
    a1.spreadNow = a1.spreadNow + ((a1:TargetSpread() - a1.spreadNow) * math.min(1, a2 * 14))
    Hud_upv_1.SetSpread(a1.spreadNow)
end
function tbl_upv_1.Interrupt(a1)
    --[[
      name: Interrupt
      line: 362
    ]]
end
function tbl_upv_1.OnDenied(a1, a2)
    --[[
      name: OnDenied
      line: 365
    ]]
    if a2 ~= "NoAmmo" then
        return
    end
    a1.lastDry = 0
    a1:OutOfAmmo()
end
return tbl_upv_1