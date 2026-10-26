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
      line: 20
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v1 = setmetatable({}, tbl_upv_1)
    v1.ctx = a1
    v1.tuning = a1.tuning
    v1.preset = a1.preset
    v1.kind = a1.kind
    local v2 = true
    if a1.kind ~= "Javelin" then
        v2 = a1.kind == "Bomb"
    end
    v1.winds = v2
    v1.winding = false
    v1.start = 0
    v1.lastThrow = -math.huge
    v1.m1Down = false
    v1.preview = false
    v1.charges = 0
    v1.maxCharges = a1.tuning.charges or 0
    v1.bufferedAt = nil
    v1.conns = {}
    v1.stopLoop = nil
    return v1
end
function tbl_upv_1.StopLoop(a1)
    --[[
      name: StopLoop
      line: 40
    ]]
    if not a1.stopLoop then
        return
    end
    a1.stopLoop(0.15)
    a1.stopLoop = nil
end
function tbl_upv_1.StartLoop(a1, a2)
    --[[
      name: StartLoop
      line: 47
      upvalues:
        Util_upv_1 (copy, index: 1)
    ]]
    if not a2 then
        return
    end
    if not (a1.stopLoop) then
        local v3 = a1.ctx.tool and (a1.ctx.tool:FindFirstChild("Handle"))
        a1.stopLoop = Util_upv_1.Loop(a2, v3 or (a1.ctx.root))
    end
end
function tbl_upv_1.Sync(a1)
    --[[
      name: Sync
      line: 55
      upvalues:
        Util_upv_1 (copy, index: 1)
        Hud_upv_1 (copy, index: 2)
    ]]
    local tool_1 = a1.ctx.tool
    local v4 = tool_1:GetAttribute("Charges")
    if type(v4) == "number" then
        if a1.charges < v4 and a1.preset.readySound and a1.ctx.tool.Parent == a1.ctx.char then
            Util_upv_1.Sound(a1.preset.readySound, a1.ctx.root)
        end
        a1.charges = v4
    end
    if a1.maxCharges > 0 then
        Hud_upv_1.SetPips(a1.charges, a1.maxCharges)
    end
    local v5 = tool_1:GetAttribute("NextCharge")
    if type(v5) ~= "number" or not (v5 > 0) then
        return
    end
    if a1.tuning.regen then
        local v6 = v5 - workspace:GetServerTimeNow()
        if not (v6 > 0) then
            return
        end
        Hud_upv_1.SetArc(a1.tuning.regen, Color3.fromRGB(150, 200, 255), a1.tuning.regen - v6)
    end
end
function tbl_upv_1.Equip(a1)
    --[[
      name: Equip
      line: 77
      upvalues:
        Hud_upv_1 (copy, index: 1)
        Util_upv_1 (copy, index: 2)
    ]]
    local ctx_1 = a1.ctx
    Hud_upv_1.SetStyle("Throw")
    Hud_upv_1.SetPips(0, 0)
    a1:Sync()
    Util_upv_1.PlayAnim(ctx_1.animator, a1.preset.hold, 1, 0.2)
    Util_upv_1.Sound(a1.preset.equip or "Equip_Item", ctx_1.root)
    local tool_2 = ctx_1.tool
    table.insert(
        a1.conns,
        tool_2:GetAttributeChangedSignal("Charges"):Connect(
            function()
                --[[
                  line: 85
                  upvalues:
                    a1 (copy, index: 1)
                ]]
                a1:Sync()
            end
        )
    )
    table.insert(
        a1.conns,
        tool_2:GetAttributeChangedSignal("NextCharge"):Connect(
            function()
                --[[
                  line: 88
                  upvalues:
                    a1 (copy, index: 1)
                ]]
                a1:Sync()
            end
        )
    )
end
function tbl_upv_1.Unequip(a1)
    --[[
      name: Unequip
      line: 93
      upvalues:
        Util_upv_1 (copy, index: 1)
        Effects_upv_1 (copy, index: 2)
        Hud_upv_1 (copy, index: 3)
    ]]
    for _, value_1 in a1.conns do
        value_1:Disconnect()
    end
    table.clear(a1.conns)
    if a1.winding then
        a1:Cancel()
    end
    a1:StopLoop()
    if a1.preview then
        a1.preview = false
        Util_upv_1.SetAiming(false)
    end
    Util_upv_1.StopAnim(a1.ctx.animator, a1.preset.hold, 0.15)
    Effects_upv_1.Trajectory(nil)
    Hud_upv_1.SetPips(0, 0)
    Hud_upv_1.SetArc(nil)
end
function tbl_upv_1.Charge(a1)
    --[[
      name: Charge
      line: 112
    ]]
    if a1.winding then
        return (math.clamp((os.clock() - a1.start) / (a1.tuning.drawTime or 0.5), 0, 1))
    end
    return 0
end
function tbl_upv_1.Launch(a1, a2, a3)
    --[[
      name: Launch
      line: 120
      upvalues:
        Util_upv_1 (copy, index: 1)
        Combat_upv_1 (copy, index: 2)
    ]]
    local ctx_2 = a1.ctx
    local tuning_1 = a1.tuning
    local Unit_1 = true
    if a1.kind ~= "Sling" then
        Unit_1 = ctx_2.weaponId == "bolas"
    end
    local v7
    if (Unit_1) and (Util_upv_1.InFirstPerson()) then
        v7 = Util_upv_1.ShotOrigin(nil)
    else
        v7 = Util_upv_1.ShotOrigin(ctx_2.tool, "Tip")
    end
    Unit_1 = Util_upv_1.AimDirection(v7)
    if a3 and a1.kind ~= "Bomb" then
        Unit_1 = Util_upv_1.AssistDirection(v7, Unit_1, true)
    end
    Unit_1 = (Unit_1 + Vector3.new(0, ((a1.kind == "Bomb") and 0.16) or (((a1.kind == "Sling") and 0.05) or (((a1.kind ~= "Javelin") and 0.01) or 0.04)), 0)).Unit
    local v8
    if a1.winds then
        local _, v9 = Combat_upv_1.DrawnShot(tuning_1, a2)
        v8 = v9
    else
        v8 = Combat_upv_1.ShotSpeed(tuning_1)
    end
    return v7, Unit_1, v8
end
function tbl_upv_1.HasCharge(a1)
    --[[
      name: HasCharge
      line: 144
    ]]
    local v10 = true
    if not (a1.maxCharges <= 0) then
        v10 = a1.charges >= 1
    end
    return v10
end
function tbl_upv_1.NoneLeft(a1)
    --[[
      name: NoneLeft
      line: 149
      upvalues:
        Util_upv_1 (copy, index: 1)
        Hud_upv_1 (copy, index: 2)
    ]]
    local v11 = os.clock()
    if not (v11 - (a1.lastDry or 0) > 0.4) then
        return
    end
    a1.lastDry = v11
    Util_upv_1.Sound("Dry_Fire", a1.ctx.root)
    Hud_upv_1.Toast("NONE LEFT THIS ROUND", Color3.fromRGB(255, 110, 90), 1)
end
function tbl_upv_1.Start(a1)
    --[[
      name: Start
      line: 158
      upvalues:
        Util_upv_1 (copy, index: 1)
    ]]
    local ctx_3 = a1.ctx
    local v12 = os.clock()
    if not (a1.winding) and not (v12 - a1.lastThrow < (a1.tuning.cooldown or 0.5)) and Util_upv_1.CanAct() and not (Util_upv_1.GuardRecovery(ctx_3.tool) > 0) then
        if a1:HasCharge() then
            a1.bufferedAt = nil
            a1.winding = true
            a1.start = v12
            ctx_3.send("Charge", {kind = "Throw", on = true, tool = ctx_3.tool})
            ctx_3.emit("Windup", {on = true, time = a1.tuning.drawTime or 0.5})
            Util_upv_1.PlayHold(ctx_3.animator, a1.preset.windup, 1)
            Util_upv_1.Sound(a1.preset.windupSound or "Throw_Windup", ctx_3.root)
            a1:StartLoop(a1.preset.fuseLoop)
            ctx_3.setSpeed("Throw", a1.tuning.drawSpeedMult or 0.8)
            return true
        end
        a1:NoneLeft()
        return false
    end
    return false
end
function tbl_upv_1.Cancel(a1)
    --[[
      name: Cancel
      line: 182
      upvalues:
        Util_upv_1 (copy, index: 1)
        Hud_upv_1 (copy, index: 2)
        Effects_upv_1 (copy, index: 3)
    ]]
    local ctx_4 = a1.ctx
    a1.winding = false
    ctx_4.send("Charge", {kind = "Throw", on = false, tool = ctx_4.tool})
    ctx_4.emit("Windup", {on = false})
    Util_upv_1.StopAnim(ctx_4.animator, a1.preset.windup, 0.1)
    ctx_4.setSpeed("Throw", nil)
    Hud_upv_1.SetCharge(0)
    Effects_upv_1.Trajectory(nil)
    a1:StopLoop()
end
function tbl_upv_1.Release(a1, a2)
    --[[
      name: Release
      line: 194
      upvalues:
        Util_upv_1 (copy, index: 1)
        Combat_upv_1 (copy, index: 2)
        Effects_upv_1 (copy, index: 3)
        Hud_upv_1 (copy, index: 4)
    ]]
    local ctx_5 = a1.ctx
    local tuning_2 = a1.tuning
    local v13, v14, v15 = a1:Launch(a2, true)
    a1.lastThrow = os.clock()
    ctx_5.emit("Throw", {charge = a2})
    Util_upv_1.FaceCamera()
    if a1.preset.windup then
        Util_upv_1.StopAnim(ctx_5.animator, a1.preset.windup, 0.04)
    end
    Util_upv_1.PlayAnim(ctx_5.animator, a1.preset.throw, a1.preset.throwAnimSpeed or 1.3, 0.03)
    local v16 = ctx_5.nextId()
    local v17 = nil
    if not tuning_2.splash and not tuning_2.smoke and not tuning_2.caltrops then
        local v18
        if a1.winds then
            v18 = Combat_upv_1.DrawnShot(tuning_2, a2)
        else
            v18 = tuning_2.damage
        end
        local tbl_2 = {}
        tbl_2.damage = v18 * Util_upv_1.ItemBonus(ctx_5.weaponId)
        tbl_2.tuning = tuning_2
        v17 = tbl_2
    end
    if type(tuning_2.returns) ~= "table" then
        Effects_upv_1.Projectile(Effects_upv_1.MyKey(v16), tuning_2.projectile or "Javelin", v13, v14 * v15, tuning_2.gravity or 60, ctx_5.char, v17)
    else
        Effects_upv_1.Chakram(Effects_upv_1.MyKey(v16), v13, v14, v15, tuning_2.returns.range or 45, tuning_2.returns.catch or 4.5, ctx_5.char)
    end
    ctx_5.send("Shoot", {tool = ctx_5.tool, origin = v13, dir = v14, id = v16, charge = a2})
    Util_upv_1.Sound(a1.preset.throwSound or "Throw", ctx_5.root)
    if a1.kind == "Bomb" then
        a1:StopLoop()
    end
    Util_upv_1.Recoil(a1.preset.recoil or (((a1.kind ~= "Javelin") and 1) or 2), 0)
    if a1.preset.shake then
        Util_upv_1.Shake(a1.preset.shake, 0.16)
    end
    Hud_upv_1.Kick(((a1.preset.recoil) and 7) or 4)
    if a1.maxCharges > 0 then
        a1.charges = math.max(0, a1.charges - 1)
        Hud_upv_1.SetPips(a1.charges, a1.maxCharges)
    end
    if a1.kind ~= "Bomb" then
        return
    end
    Hud_upv_1.SetArc(tuning_2.cooldown or 0.6, Color3.fromRGB(228, 232, 240))
end
function tbl_upv_1.Quick(a1)
    --[[
      name: Quick
      line: 237
      upvalues:
        Util_upv_1 (copy, index: 1)
    ]]
    local v19 = os.clock()
    if not (v19 - a1.lastThrow < (a1.tuning.fireInterval or (a1.tuning.cooldown or 0.4))) and not (Util_upv_1.GuardRecovery(a1.ctx.tool) > 0) then
        if Util_upv_1.CanAct() then
            if a1:HasCharge() then
                a1.bufferedAt = nil
                a1:Release(1)
                return "fired"
            end
            a1.lastThrow = v19
            a1:NoneLeft()
            return "empty"
        end
        return "frozen"
    end
    return "cooldown"
end
function tbl_upv_1.Throw(a1)
    --[[
      name: Throw
      line: 256
      upvalues:
        Util_upv_1 (copy, index: 1)
        Hud_upv_1 (copy, index: 2)
        Effects_upv_1 (copy, index: 3)
    ]]
    if not a1.winding then
        return
    end
    if Util_upv_1.CanAct() then
        local v20 = a1:Charge()
        local minCharge_1 = a1.tuning.minCharge
        if type(minCharge_1) == "number" and v20 < minCharge_1 then
            a1:Cancel()
            local v21 = os.clock()
            if v21 - (a1.lastShort or 0) > 1.5 then
                a1.lastShort = v21
                Hud_upv_1.Toast("HOLD TO WIND UP", Color3.fromRGB(226, 196, 140), 1)
            end
            return
        end
        a1.winding = false
        a1.ctx.setSpeed("Throw", nil)
        Hud_upv_1.SetCharge(0)
        Effects_upv_1.Trajectory(nil)
        a1:Release(v20)
    else
        a1:Cancel()
    end
end
function tbl_upv_1.Input(a1, a2, a3)
    --[[
      name: Input
      line: 283
      upvalues:
        Util_upv_1 (copy, index: 1)
        Effects_upv_1 (copy, index: 2)
    ]]
    if a2 == "Primary" then
        a1.m1Down = a3
        if a1.winds then
            if a3 then
                if (a1:Start()) or (a1.winding) then
                    return
                end
                a1.bufferedAt = os.clock()
            else
                a1:Throw()
            end
        else
            if a3 and a1:Quick() == "cooldown" then
                a1.bufferedAt = os.clock()
            end
            if a1.kind == "Sling" then
                if a3 then
                    a1:StartLoop(a1.preset.whirlLoop)
                    return
                end
                a1:StopLoop()
            end
        end
    elseif a2 == "Secondary" then
        if a1.winds then
            if not a3 or not a1.winding then
                return
            end
            a1:Cancel()
        else
            a1.preview = a3
            Util_upv_1.SetAiming(a3, ((a1.kind ~= "Sling") and 55) or 58)
            a1.ctx.setSpeed("Aim", (a3 and 0.85) or nil)
            if (a3) then
                return
            end
            Effects_upv_1.Trajectory(nil)
        end
    end
end
function tbl_upv_1.Update(a1, a2)
    --[[
      name: Update
      line: 323
      upvalues:
        Hud_upv_1 (copy, index: 1)
        Effects_upv_1 (copy, index: 2)
    ]]
    if a1.kind == "Sling" and a1.m1Down and not (a1.bufferedAt) then
        a1:Quick()
    end
    if a1.bufferedAt then
        if a1.winds then
            if not (a1.winding) then
                if a1.m1Down or not (os.clock() - a1.bufferedAt > 0.15) then
                    if a1:Start() and not (a1.m1Down) then
                        a1:Throw()
                    end
                else
                    a1.bufferedAt = nil
                end
            end
        elseif os.clock() - a1.bufferedAt > 0.15 or a1:Quick() ~= "cooldown" then
            a1.bufferedAt = nil
        end
    end
    if a1.winding then
        local tuning_3 = a1:Charge()
        Hud_upv_1.SetCharge(tuning_3)
        local v22, v23, v24 = a1:Launch(tuning_3)
        tuning_3 = a1.tuning
        local v25 = ((tuning_3.splash) and (tuning_3.splash.radius * 2)) or (((tuning_3.smoke) and (tuning_3.smoke.radius * 1.2)) or (((tuning_3.caltrops) and (tuning_3.caltrops.radius * 2)) or 3))
        local v26
        if tuning_3.smoke then
            v26 = a1.preset.arcSmoke
        else
            v26 = a1.preset.arc
        end
        Effects_upv_1.Trajectory(v22, v23 * v24, tuning_3.gravity or 60, v26, v25)
    elseif a1.preview and a1.kind == "Sling" then
        local v27, v28, v29 = a1:Launch(1)
        Effects_upv_1.Trajectory(v27, v28 * v29, a1.tuning.gravity or 80, Color3.fromRGB(215, 195, 160), 2)
    end
end
function tbl_upv_1.Interrupt(a1)
    --[[
      name: Interrupt
      line: 359
    ]]
    if not a1.winding then
        return
    end
    a1:Cancel()
end
return tbl_upv_1