local Parent_1 = script.Parent.Parent
local Simulation_upv_1 = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Simulation"))
local Util_upv_1 = require(Parent_1.Util)
local Hud_upv_1 = require(Parent_1.Hud)
local Effects_upv_1 = require(Parent_1.Effects)
local Guard_upv_1 = require(Parent_1.Guard)
local Combat_upv_1 = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Combat"))
local Touch_upv_1 = require(Parent_1.Touch)
local tbl_upv_1 = {}
tbl_upv_1.__index = tbl_upv_1
function tbl_upv_1.new(a1)
    --[[
      name: new
      line: 25
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v1 = setmetatable({}, tbl_upv_1)
    v1.ctx = a1
    v1.tuning = a1.tuning
    v1.preset = a1.preset
    v1.lastSwing = 0
    v1.combo = 0
    v1.holding = false
    v1.busyUntil = 0
    v1.blocking = false
    v1.blockHeld = false
    v1.guardFirst = false
    v1.strikes = 0
    v1.charging = nil
    v1.chargeStart = 0
    v1.lastSpecial = -math.huge
    v1.bufferedAt = nil
    v1.fullPlayed = false
    v1.lastThrow = -math.huge
    v1.thrownLocalUntil = 0
    v1.parryHeld = false
    v1.parrying = false
    v1.parryReadyAt = 0
    v1.lastParryUp = -math.huge
    v1.parryUpAt = 0
    v1.conns = {}
    return v1
end
function tbl_upv_1.OneHanded(a1)
    --[[
      name: OneHanded
      line: 55
      upvalues:
        Util_upv_1 (copy, index: 1)
    ]]
    local v2 = Util_upv_1.Probe(a1)
    if v2 ~= nil then
        return v2
    end
    if type(a1.tuning.oneHanded) ~= "table" then
        return false
    end
    local tool_1 = a1.ctx.tool
    local v3
    if tool_1 == nil then
        v3 = os.clock() < a1.thrownLocalUntil
    else
        v3 = true
        if tool_1:GetAttribute("Thrown") ~= true then
            v3 = os.clock() < a1.thrownLocalUntil
        end
    end
    return v3
end
function tbl_upv_1.Cooldown(a1)
    --[[
      name: Cooldown
      line: 67
    ]]
    if a1:OneHanded() then
        return a1.tuning.oneHanded.cooldown or 0.45
    end
    return a1.tuning.cooldown or 0.5
end
function tbl_upv_1.Equip(a1)
    --[[
      name: Equip
      line: 74
      upvalues:
        Hud_upv_1 (copy, index: 1)
        Util_upv_1 (copy, index: 2)
        Touch_upv_1 (copy, index: 3)
        Combat_upv_1 (copy, index: 4)
    ]]
    local ctx_upv_1 = a1.ctx
    Hud_upv_1.SetStyle("Melee")
    if a1.preset.hold then
        Util_upv_1.PlayAnim(ctx_upv_1.animator, a1.preset.hold, 1, 0.2)
    end
    if a1.preset.equip and ctx_upv_1.tool then
        Util_upv_1.Sound(a1.preset.equip, ctx_upv_1.root)
    end
    local tool_upv_2 = ctx_upv_1.tool
    local lunge_1 = a1.tuning.lunge
    if tool_upv_2 and type(lunge_1) == "table" and lunge_1.refreshOnKill then
        table.insert(
            a1.conns,
            tool_upv_2:GetAttributeChangedSignal("Refreshed"):Connect(
                function()
                    --[[
                      line: 88
                      upvalues:
                        a1 (copy, index: 1)
                        Hud_upv_1 (copy, index: 2)
                        Util_upv_1 (copy, index: 3)
                        ctx_upv_1 (copy, index: 4)
                    ]]
                    a1.lastSpecial = -math.huge
                    Hud_upv_1.SetArc(0)
                    Util_upv_1.Sound(a1.preset.refreshSound or "Charge_Full", ctx_upv_1.root)
                    ctx_upv_1.emit("Refresh", {})
                end
            )
        )
    end
    if not tool_upv_2 then
        return
    end
    if type(a1.tuning.throw) == "table" then
        local u1 = tool_upv_2:GetAttribute("Thrown") == true
        Touch_upv_1.SetAltDim(u1)
        table.insert(
            a1.conns,
            tool_upv_2:GetAttributeChangedSignal("Thrown"):Connect(
                function()
                    --[[
                      line: 100
                      upvalues:
                        tool_upv_2 (copy, index: 1)
                        u1 (ref,  index: 2)
                        a1 (copy, index: 3)
                        Combat_upv_1 (copy, index: 4)
                        Touch_upv_1 (copy, index: 5)
                        ctx_upv_1 (copy, index: 6)
                        Hud_upv_1 (copy, index: 7)
                    ]]
                    local v4 = tool_upv_2:GetAttribute("Thrown") == true
                    if v4 == u1 then
                        return
                    end
                    u1 = v4
                    a1.thrownLocalUntil = 0
                    Combat_upv_1.ShowOffHand(tool_upv_2, not v4)
                    if v4 then
                        Touch_upv_1.SetAltDim(true)
                    else
                        ctx_upv_1.emit("Catch", {})
                        local v5 = tool_upv_2:GetAttribute("Cooldown")
                        local v6 = ((type(v5) ~= "number") and 0) or (v5 - workspace:GetServerTimeNow())
                        local v7 = a1.tuning.throw.cooldown or 0.45
                        if v6 > 0.05 then
                            Hud_upv_1.SetArc(v7, Color3.fromRGB(214, 170, 120), (math.max(0, v7 - v6)))
                            task.delay(
                                v6,
                                function()
                                    --[[
                                      line: 120
                                      upvalues:
                                        tool_upv_2 (copy, index: 1)
                                        ctx_upv_1 (copy, index: 2)
                                        Touch_upv_1 (copy, index: 3)
                                    ]]
                                    if tool_upv_2.Parent ~= ctx_upv_1.char or tool_upv_2:GetAttribute("Thrown") == true then
                                        return
                                    end
                                    Touch_upv_1.SetAltDim(false)
                                end
                            )
                        else
                            Hud_upv_1.SetArc(0)
                            Touch_upv_1.SetAltDim(false)
                        end
                    end
                end
            )
        )
    end
end
function tbl_upv_1.Unequip(a1)
    --[[
      name: Unequip
      line: 133
      upvalues:
        Touch_upv_1 (copy, index: 1)
        Util_upv_1 (copy, index: 2)
        Hud_upv_1 (copy, index: 3)
    ]]
    local ctx_2 = a1.ctx
    for _, value_1 in a1.conns do
        value_1:Disconnect()
    end
    table.clear(a1.conns)
    a1.holding = false
    a1.bufferedAt = nil
    if a1.blocking then
        a1:SetBlock(false)
    end
    a1.blockHeld = false
    a1.parryHeld = false
    if type(a1.tuning.throw) == "table" then
        Touch_upv_1.SetAltDim(false)
    end
    a1:LowerParry(true, nil, true)
    if a1.charging then
        a1:CancelCharge()
    end
    if a1.preset.hold then
        Util_upv_1.StopAnim(ctx_2.animator, a1.preset.hold, 0.15)
    end
    Hud_upv_1.SetCharge(0)
    Hud_upv_1.SetGuard(nil)
end
function tbl_upv_1.Detect(a1, a2, a3, a4)
    --[[
      name: Detect
      line: 161
      upvalues:
        Util_upv_1 (copy, index: 1)
    ]]
    local v8 = Util_upv_1.Probe(a1, a2)
    if v8 ~= nil then
        return v8
    end
    local ctx_3 = a1.ctx
    local root_1 = ctx_3.root
    local Head_1 = ctx_3.char:FindFirstChild("Head")
    if Head_1 then
        v8 = Head_1.Position
    else
        v8 = root_1.Position
    end
    local v9 = Util_upv_1.GetAimRay()
    local Unit_1 = Vector3.new(v9.Direction.X, 0, v9.Direction.Z)
    if Unit_1.Magnitude < 0.05 then
        Unit_1 = root_1.CFrame.LookVector
    end
    Unit_1 = Unit_1.Unit
    v9 = math.cos(math.rad(a3))
    local tbl_2 = {}
    local v10 = Util_upv_1.Targets()
    local v11 = Util_upv_1.WorldParams(v10)
    local v12 = nil
    for _, value_2 in v10 do
        if Util_upv_1.IsTeammate(value_2) then
            continue
        end
        local v13 = value_2:FindFirstChildOfClass("Humanoid")
        local HumanoidRootPart_1 = value_2:FindFirstChild("HumanoidRootPart")
        if not (v13) or not (HumanoidRootPart_1) or not (v13.Health > 0) then
            continue
        end
        local v14 = HumanoidRootPart_1.Position - root_1.Position
        local Magnitude_1 = v14.Magnitude
        if not (Magnitude_1 <= a2 + 1.2) or not (math.abs(v14.Y) < 8) then
            continue
        end
        local v15 = Vector3.new(v14.X, 0, v14.Z)
        v12 = true
        if not (Magnitude_1 < 3.2) then
            v12 = (v15.Magnitude > 0.05) and (v9 <= v15.Unit:Dot(Unit_1))
        end
        if not (v12) then
            continue
        end
        if not (workspace:Raycast(v8, HumanoidRootPart_1.Position - v8, v11)) then
            table.insert(tbl_2, {model = value_2, dist = Magnitude_1})
        end
    end
    table.sort(
        tbl_2,
        function(a5, a6)
            --[[
              line: 198
            ]]
            return a5.dist < a6.dist
        end
    )
    local tbl_3 = {}
    for n_1 = 1, math.min(#tbl_2, a4) do
        table.insert(tbl_3, tbl_2[n_1].model)
    end
    return tbl_3
end
function tbl_upv_1.Ready(a1)
    --[[
      name: Ready
      line: 238
    ]]
    local v16 = os.clock()
    local v17 = (a1.busyUntil <= v16) and (a1:Cooldown() <= v16 - a1.lastSwing)
    return v17
end
local function predictImpacts(a1, a2, a3, a4, a5, a6)
    --[[
      name: predictImpacts
      line: 212
      upvalues:
        Util_upv_1 (copy, index: 1)
        Effects_upv_1 (copy, index: 2)
    ]]
    a3 = a3 and (a3 * Util_upv_1.ItemBonus(a6))
    local v18 = nil
    local v19 = nil
    for _, value_3 in a1 do
        local v20 = Util_upv_1.CanPredictHit(value_3)
        if not (v20) then
            continue
        end
        local v21 = value_3:FindFirstChild("UpperTorso") or (value_3:FindFirstChild("Torso") or (value_3:FindFirstChild("HumanoidRootPart")))
        if not (v21) then
            continue
        end
        v19 = v21:IsA("BasePart")
        if not (v19) then
            continue
        end
        v18 = false
        local HumanoidRootPart_2 = value_3:FindFirstChild("HumanoidRootPart")
        if not (a3) or not (a4) or not (a4.backstabMult) or not (a5) or not (HumanoidRootPart_2) then
            v19 = a3
            Effects_upv_1.CharacterImpact(v21.Position, nil, false)
            Effects_upv_1.PredictHit(value_3, a2, v21.Position + Vector3.new(0, 1, 0), false, v19, v18)
            continue
        end
        local v22 = HumanoidRootPart_2:IsA("BasePart")
        if not (v22) then
            v19 = a3
            Effects_upv_1.CharacterImpact(v21.Position, nil, false)
            Effects_upv_1.PredictHit(value_3, a2, v21.Position + Vector3.new(0, 1, 0), false, v19, v18)
            continue
        end
        local v23 = (a5.Position - HumanoidRootPart_2.Position) * Vector3.new(1, 0, 1)
        local v24 = -(HumanoidRootPart_2.CFrame.LookVector * Vector3.new(1, 0, 1))
        if not (v23.Magnitude > 0.05) or not (v24.Magnitude > 0.05) then
            v19 = a3
            Effects_upv_1.CharacterImpact(v21.Position, nil, false)
            Effects_upv_1.PredictHit(value_3, a2, v21.Position + Vector3.new(0, 1, 0), false, v19, v18)
            continue
        end
        local v25 = v23.Unit:Dot(v24.Unit)
        if math.cos(math.rad(a4.backstabAngle or 70)) <= v25 then
            v19, v18 = a3 * a4.backstabMult, true
        else
            v19 = a3
        end
        Effects_upv_1.CharacterImpact(v21.Position, nil, false)
        Effects_upv_1.PredictHit(value_3, a2, v21.Position + Vector3.new(0, 1, 0), false, v19, v18)
    end
end
function tbl_upv_1.Swing(a1)
    --[[
      name: Swing
      line: 243
      upvalues:
        Util_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        Effects_upv_1 (copy, index: 3)
        predictImpacts (copy, index: 4)
    ]]
    local ctx_upv_4 = a1.ctx
    local tuning_upv_1 = a1.tuning
    local preset_upv_1 = a1.preset
    local u2 = os.clock()
    if a1:Ready() and Util_upv_1.CanAct() and not (Util_upv_1.GuardRecovery(a1.ctx.tool) > 0) then
        a1.bufferedAt = nil
        local v26 = a1:OneHanded()
        local v27 = Util_upv_1.ProbeValues()
        if v27 and tbl_upv_1.OneHanded(v27.t) ~= v27.t then
            Util_upv_1.Hooked()
        end
        local u3
        if v26 then
            u3 = tuning_upv_1.oneHanded.combo or {1}
        else
            u3 = tuning_upv_1.combo or {1}
        end
        if u2 - a1.lastSwing <= (tuning_upv_1.comboWindow or 1) then
            a1.combo = (a1.combo % #u3) + 1
        else
            a1.combo = 1
        end
        a1.lastSwing = u2
        local combo_upv_1 = a1.combo
        local u4 = (#u3 > 2) and (combo_upv_1 == #u3)
        Util_upv_1.MeleeAssist(tuning_upv_1.range or 8)
        Util_upv_1.FaceCamera()
        local v28
        if v26 then
            v28 = preset_upv_1.oneSwings
        else
            v28 = nil
        end
        v28 = (v28) or preset_upv_1.swings or {}
        local v29 = v28[((combo_upv_1 - 1) % math.max(1, #v28)) + 1]
        Util_upv_1.PlayAnim(ctx_upv_4.animator, v29, (preset_upv_1.swingSpeed or 1) * ((u4 and 0.95) or 1), 0.05)
        ctx_upv_4.emit("Swing", {step = combo_upv_1, finisher = u4, hitDelay = preset_upv_1.hitDelay or 0.1, oneHanded = v26})
        local v30 = preset_upv_1.hitDelay or 0.1
        v28 = ((v30 >= 0.15) and (v30 - 0.04)) or (math.max(0, v30 - 0.1))
        local function whoosh()
            --[[
              name: whoosh
              line: 279
              upvalues:
                Util_upv_1 (copy, index: 1)
                preset_upv_1 (copy, index: 2)
                ctx_upv_4 (copy, index: 3)
                u4 (copy, index: 4)
            ]]
            local Sound_1 = Util_upv_1.Sound
            local root_2 = ctx_upv_4.root
            local tbl_4 = {PlaybackSpeed = 0}
            tbl_4.PlaybackSpeed = (u4 and 0.88) or 1
            Sound_1(preset_upv_1.swingSound or "Swing_Sword", root_2, tbl_4)
        end
        if v28 >= 0.05 then
            task.delay(v28, whoosh)
        else
            local Sound_2 = Util_upv_1.Sound
            local root_3 = ctx_upv_4.root
            local tbl_5 = {PlaybackSpeed = 0}
            tbl_5.PlaybackSpeed = (u4 and 0.88) or 1
            Sound_2(preset_upv_1.swingSound or "Swing_Sword", root_3, tbl_5)
        end
        local v31 = Util_upv_1.InFirstPerson()
        if preset_upv_1.trail and preset_upv_1.trail > 0 and not (v31) then
            Effects_upv_1.Trail(ctx_upv_4.tool, preset_upv_1.trail)
        end
        local v32 = preset_upv_1.hitDelay or 0.1
        a1.strikes = a1.strikes + 1
        if not (preset_upv_1.noSlash) and ctx_upv_4.tool and not (v31) then
            task.delay(
                v32 * 0.6,
                function()
                    --[[
                      line: 294
                      upvalues:
                        Effects_upv_1 (copy, index: 1)
                        ctx_upv_4 (copy, index: 2)
                        combo_upv_1 (copy, index: 3)
                        u4 (copy, index: 4)
                        preset_upv_1 (copy, index: 5)
                        tuning_upv_1 (copy, index: 6)
                    ]]
                    Effects_upv_1.Slash(ctx_upv_4.char, combo_upv_1, u4, preset_upv_1.slashColor, tuning_upv_1.range)
                end
            )
        end
        task.delay(
            v32,
            function()
                --[[
                  line: 298
                  upvalues:
                    a1 (copy, index: 1)
                    ctx_upv_4 (copy, index: 2)
                    Util_upv_1 (copy, index: 3)
                    tbl_upv_1 (copy, index: 4)
                    tuning_upv_1 (copy, index: 5)
                    u2 (copy, index: 6)
                    predictImpacts (copy, index: 7)
                    preset_upv_1 (copy, index: 8)
                    u3 (copy, index: 9)
                    combo_upv_1 (copy, index: 10)
                    u4 (copy, index: 11)
                ]]
                a1.strikes = a1.strikes - 1
                if not ctx_upv_4.alive() then
                    return
                end
                Util_upv_1.FaceCamera()
                local v33 = Util_upv_1.ProbeValues()
                if v33 and tbl_upv_1.Detect(v33.t, 1, 2, 3) ~= v33.t then
                    Util_upv_1.Hooked()
                end
                local v34 = a1:Detect(tuning_upv_1.range or 8, tuning_upv_1.arc or 60, tuning_upv_1.maxTargets or 1)
                ctx_upv_4.send("Swing", {tool = ctx_upv_4.tool, dir = Util_upv_1.GetAimRay().Direction, hits = v34, k = math.floor((os.clock() - u2) * 1000)})
                predictImpacts(v34, preset_upv_1.hitSound or "Hit_Melee", (tuning_upv_1.damage or 10) * (u3[combo_upv_1] or 1), tuning_upv_1, ctx_upv_4.root, ctx_upv_4.weaponId)
                if not (#v34 > 0) then
                    return
                end
                Util_upv_1.Shake((preset_upv_1.shake or 0.18) * ((u4 and 1.4) or 1), 0.14)
                Util_upv_1.Recoil((u4 and 1.4) or 0.7, (math.random() - 0.5) * 0.8)
            end
        )
        return true
    end
    return false
end
local u5 = -math.huge
function tbl_upv_1.CanGuard(a1)
    --[[
      name: CanGuard
      line: 331
      upvalues:
        Util_upv_1 (copy, index: 1)
    ]]
    local v35 = (a1.strikes <= 0) and ((a1.busyUntil <= os.clock()) and (Util_upv_1.CanAct() and (not a1:GuardBroken())))
    return v35
end
function tbl_upv_1.GuardBroken(a1)
    --[[
      name: GuardBroken
      line: 336
      upvalues:
        Combat_upv_1 (copy, index: 1)
    ]]
    local block_1 = a1.tuning.block
    local v36 = (type(block_1) == "table") and ((block_1.durability ~= nil) and (Combat_upv_1.GuardBrokenLeft(a1.ctx.char, workspace:GetServerTimeNow()) > 0))
    return v36
end
function tbl_upv_1.DrawGuard(a1)
    --[[
      name: DrawGuard
      line: 342
      upvalues:
        Combat_upv_1 (copy, index: 1)
        Hud_upv_1 (copy, index: 2)
    ]]
    local block_2 = a1.tuning.block
    local v37 = (type(block_2) == "table") and (block_2.durability)
    if not v37 then
        return
    end
    local v38 = workspace:GetServerTimeNow()
    local v39, v40 = Combat_upv_1.GuardHp(a1.ctx.char, v37, v38)
    v37 = Combat_upv_1.GuardBrokenLeft(a1.ctx.char, v38) > 0
    local SetGuard_1 = Hud_upv_1.SetGuard
    local v41
    if a1.blocking or v37 or v39 < v40 then
        v41 = v39 / v40
    else
        v41 = nil
    end
    SetGuard_1(v41, v37)
end
function tbl_upv_1.SetBlock(a1, a2)
    --[[
      name: SetBlock
      line: 354
      upvalues:
        Util_upv_1 (copy, index: 1)
        Hud_upv_1 (copy, index: 2)
        Guard_upv_1 (copy, index: 3)
        u5 (ref,  index: 4)
    ]]
    local ctx_5 = a1.ctx
    if a1.blocking == a2 then
        return
    end
    a1.blocking = a2
    if a2 then
        a1.bufferedAt = nil
    else
        local block_3 = a1.tuning.block
        local GuardDown_1 = Util_upv_1.GuardDown
        local tool_3 = ctx_5.tool
        local v42 = ((type(block_3) == "table") and (block_3.swapDelay)) or nil
        GuardDown_1(tool_3, v42)
    end
    ctx_5.send("Block", {tool = ctx_5.tool, on = a2})
    ctx_5.emit("Block", {on = a2})
    Hud_upv_1.SetBlocking(a2)
    Guard_upv_1.SetLocal(a2)
    if a2 then
        Util_upv_1.PlayAnim(ctx_5.animator, a1.preset.block, 1, 0.1)
    else
        Util_upv_1.StopAnim(ctx_5.animator, a1.preset.block, 0.12)
    end
    if a2 then
        local v43 = os.clock()
        if v43 - u5 >= 0.5 then
            u5 = v43
            Util_upv_1.Sound("Block_Up", ctx_5.root)
        end
        local v44 = Util_upv_1.ProbeValues()
        if v44 and ctx_5.setSpeed(v44.s, 1) ~= v44.s then
            Util_upv_1.Hooked()
        end
        ctx_5.setSpeed("Block", ((a1.tuning.block) and (a1.tuning.block.speedMult)) or 0.6)
    else
        ctx_5.setSpeed("Block", nil)
    end
end
function tbl_upv_1.SpecialInfo(a1, a2)
    --[[
      name: SpecialInfo
      line: 392
    ]]
    local v45
    if a2 ~= "Heavy" then
        v45 = a1.tuning.lunge
    else
        v45 = a1.tuning.heavy
    end
    if not (v45) then
        v45 = {}
    end
    return v45
end
function tbl_upv_1.SpecialReady(a1, a2, a3)
    --[[
      name: SpecialReady
      line: 400
    ]]
    if a3 - a1.lastSpecial < (a2.cooldown or 1) then
        return false
    end
    local v46 = a1.ctx.tool and (a1.ctx.tool:GetAttribute("Cooldown"))
    local v47 = false
    if type(v46) == "number" then
        v47 = workspace:GetServerTimeNow() < v46
    end
    return not v47
end
function tbl_upv_1.StartCharge(a1, a2)
    --[[
      name: StartCharge
      line: 408
      upvalues:
        Util_upv_1 (copy, index: 1)
    ]]
    local ctx_6 = a1.ctx
    local v48 = os.clock()
    local v49 = a1:SpecialInfo(a2)
    if not a1:SpecialReady(v49, v48) or (v48 < a1.busyUntil) then
        return
    end
    if Util_upv_1.CanAct() then
        a1.charging = a2
        a1.chargeStart = v48
        a1.bufferedAt = nil
        a1.fullPlayed = false
        ctx_6.send("Charge", {on = true, tool = ctx_6.tool, kind = a2})
        ctx_6.emit("Charge", {on = true, kind = a2, time = v49.charge or 0.6})
        local PlayHold_1 = Util_upv_1.PlayHold
        local animator_1 = ctx_6.animator
        local v50
        if a2 ~= "Heavy" then
            v50 = a1.preset.lungeCharge
        else
            v50 = a1.preset.heavyCharge
        end
        PlayHold_1(animator_1, v50, 1)
        Util_upv_1.Sound(a1.preset.chargeSound or "Charge_Up", ctx_6.root)
        ctx_6.setSpeed("Charge", v49.speedMult or 0.55)
    end
end
function tbl_upv_1.CancelCharge(a1)
    --[[
      name: CancelCharge
      line: 426
      upvalues:
        Util_upv_1 (copy, index: 1)
        Hud_upv_1 (copy, index: 2)
    ]]
    local ctx_7 = a1.ctx
    local charging_1 = a1.charging
    a1.charging = nil
    if charging_1 then
        ctx_7.send("Charge", {on = false, tool = ctx_7.tool, kind = charging_1})
        ctx_7.emit("Charge", {on = false, kind = charging_1})
        local StopAnim_1 = Util_upv_1.StopAnim
        local animator_2 = ctx_7.animator
        local v51
        if charging_1 ~= "Heavy" then
            v51 = a1.preset.lungeCharge
        else
            v51 = a1.preset.heavyCharge
        end
        StopAnim_1(animator_2, v51, 0.1)
    end
    ctx_7.setSpeed("Charge", nil)
    Hud_upv_1.SetCharge(0)
end
function tbl_upv_1.Dash(a1)
    --[[
      name: Dash
      line: 441
      upvalues:
        Util_upv_1 (copy, index: 1)
    ]]
    local ctx_8 = a1.ctx
    local v52 = a1:SpecialInfo("Lunge")
    local v53 = os.clock()
    if not a1:SpecialReady(v52, v53) or (v53 < a1.busyUntil) or not Util_upv_1.CanAct() then
        return
    end
    a1.bufferedAt = nil
    ctx_8.send("Charge", {kind = "Lunge", on = true, tool = ctx_8.tool})
    a1.charging = "Lunge"
    a1.chargeStart = v53 - 1
    a1:ReleaseCharge()
end
function tbl_upv_1.ReleaseCharge(a1)
    --[[
      name: ReleaseCharge
      line: 455
      upvalues:
        Util_upv_1 (copy, index: 1)
        Hud_upv_1 (copy, index: 2)
        Effects_upv_1 (copy, index: 3)
        predictImpacts (copy, index: 4)
        Simulation_upv_1 (copy, index: 5)
    ]]
    local ctx_upv_9 = a1.ctx
    local tuning_upv_2 = a1.tuning
    local preset_upv_2 = a1.preset
    local charging_2 = a1.charging
    if not charging_2 then
        return
    end
    local u6 = a1:SpecialInfo(charging_2)
    if os.clock() - a1.chargeStart < (u6.charge or 0.6) then
        a1:CancelCharge()
    else
        a1.charging = nil
        a1.lastSpecial = os.clock()
        local StopAnim_2 = Util_upv_1.StopAnim
        local animator_3 = ctx_upv_9.animator
        local v54
        if charging_2 ~= "Heavy" then
            v54 = preset_upv_2.lungeCharge
        else
            v54 = preset_upv_2.heavyCharge
        end
        StopAnim_2(animator_3, v54, 0.05)
        ctx_upv_9.setSpeed("Charge", nil)
        Hud_upv_1.SetCharge(0)
        Hud_upv_1.SetArc(u6.cooldown or 1, Color3.fromRGB(228, 232, 240))
        local MeleeAssist_1 = Util_upv_1.MeleeAssist
        animator_3 = ((charging_2 ~= "Heavy") and ((u6.range or 12) + (u6.distance or 16) * 0.5)) or (u6.range or ((tuning_upv_2.range or 9) + 1))
        MeleeAssist_1(animator_3, charging_2 ~= "Heavy")
        Util_upv_1.FaceCamera()
        local u7
        if charging_2 ~= "Heavy" then
            a1.busyUntil = os.clock() + 0.45
            local root_4 = ctx_upv_9.root
            local v55 = Util_upv_1.GetAimRay()
            u7 = Vector3.new(v55.Direction.X, 0, v55.Direction.Z)
            if u7.Magnitude > 0.05 then
                u7 = u7.Unit
            else
                u7 = root_4.CFrame.LookVector
            end
            Util_upv_1.PlayAnim(ctx_upv_9.animator, preset_upv_2.lunge or "Spear_Stab", preset_upv_2.lungeAnimSpeed or 0.8, 0.03)
            Util_upv_1.Sound(preset_upv_2.lungeSound or "Lunge", root_4)
            if not (Util_upv_1.InFirstPerson()) then
                Effects_upv_1.Trail(ctx_upv_9.tool, 0.4)
                if preset_upv_2.lungeSlash then
                    task.delay(
                        0.08,
                        function()
                            --[[
                              line: 529
                              upvalues:
                                Effects_upv_1 (copy, index: 1)
                                ctx_upv_9 (copy, index: 2)
                                preset_upv_2 (copy, index: 3)
                                u6 (copy, index: 4)
                            ]]
                            Effects_upv_1.Slash(ctx_upv_9.char, 1, true, preset_upv_2.slashColor, (u6.range or 8) + 2)
                        end
                    )
                end
            end
            Simulation_upv_1.Pulse("Lunge", 0.15)
            v55 = math.clamp((u6.distance or 16) / (u6.speed or 70), 0.12, 0.35)
            Util_upv_1.FovKick(6, 0.05, v55 + 0.05)
            if preset_upv_2.lungeLines and Util_upv_1.InFirstPerson() then
                Effects_upv_1.DashLines(v55 + 0.12)
            end
            ctx_upv_9.emit("Lunge", {time = v55})
            local tbl_upv_7 = {}
            local tbl_upv_8 = {}
            for n_2 = 0, 3 do
                task.delay(
                    (v55 / 3) * n_2,
                    function()
                        --[[
                          line: 546
                          upvalues:
                            a1 (copy, index: 1)
                            u6 (copy, index: 2)
                            tuning_upv_2 (copy, index: 3)
                            tbl_upv_7 (copy, index: 4)
                            tbl_upv_8 (copy, index: 5)
                        ]]
                        for _, value_4 in a1:Detect(u6.range or 12, u6.arc or 35, tuning_upv_2.maxTargets or 2) do
                            if tbl_upv_7[value_4] then
                                continue
                            end
                            if #tbl_upv_8 < (tuning_upv_2.maxTargets or 2) then
                                tbl_upv_7[value_4] = true
                                table.insert(tbl_upv_8, value_4)
                            end
                        end
                    end
                )
            end
            task.delay(
                v55,
                function()
                    --[[
                      line: 555
                      upvalues:
                        ctx_upv_9 (copy, index: 1)
                        u7 (ref,  index: 2)
                        tbl_upv_8 (copy, index: 3)
                        predictImpacts (copy, index: 4)
                        preset_upv_2 (copy, index: 5)
                        u6 (copy, index: 6)
                        Util_upv_1 (copy, index: 7)
                    ]]
                    if not ctx_upv_9.alive() then
                        return
                    end
                    ctx_upv_9.send("Swing", {lunge = true, tool = ctx_upv_9.tool, dir = u7, hits = tbl_upv_8})
                    predictImpacts(tbl_upv_8, preset_upv_2.hitSound or "Hit_Melee_Heavy", u6.damage, nil, ctx_upv_9.root, ctx_upv_9.weaponId)
                    if #tbl_upv_8 > 0 then
                        Util_upv_1.Shake(0.6, 0.15)
                        Util_upv_1.Recoil(2, 0)
                    end
                end
            )
        else
            a1.busyUntil = os.clock() + 0.55
            ctx_upv_9.emit("Heavy", {hitDelay = preset_upv_2.heavyDelay or 0.16})
            Util_upv_1.PlayAnim(ctx_upv_9.animator, preset_upv_2.heavySwing or "Axe_Heavy", 1.15, 0.04)
            Util_upv_1.Sound(preset_upv_2.heavySound or "Swing_Heavy", ctx_upv_9.root)
            local v56 = preset_upv_2.heavyDelay or 0.16
            if not (Util_upv_1.InFirstPerson()) then
                Effects_upv_1.Trail(ctx_upv_9.tool, 0.5)
                task.delay(
                    v56 * 0.6,
                    function()
                        --[[
                          line: 486
                          upvalues:
                            Effects_upv_1 (copy, index: 1)
                            ctx_upv_9 (copy, index: 2)
                            preset_upv_2 (copy, index: 3)
                            u6 (copy, index: 4)
                            tuning_upv_2 (copy, index: 5)
                        ]]
                        Effects_upv_1.Slash(ctx_upv_9.char, 1, true, preset_upv_2.slashColor, u6.range or (tuning_upv_2.range))
                    end
                )
            end
            task.delay(
                v56,
                function()
                    --[[
                      line: 490
                      upvalues:
                        ctx_upv_9 (copy, index: 1)
                        Util_upv_1 (copy, index: 2)
                        a1 (copy, index: 3)
                        u6 (copy, index: 4)
                        tuning_upv_2 (copy, index: 5)
                        predictImpacts (copy, index: 6)
                        preset_upv_2 (copy, index: 7)
                        Effects_upv_1 (copy, index: 8)
                    ]]
                    if not ctx_upv_9.alive() then
                        return
                    end
                    Util_upv_1.FaceCamera()
                    local v57 = a1:Detect(u6.range or ((tuning_upv_2.range or 9) + 1), math.min((tuning_upv_2.arc or 60) + 10, 90), tuning_upv_2.maxTargets or 2)
                    ctx_upv_9.send("Swing", {heavy = true, tool = ctx_upv_9.tool, dir = Util_upv_1.GetAimRay().Direction, hits = v57})
                    predictImpacts(v57, preset_upv_2.hitSound or "Hit_Melee_Heavy", u6.damage, nil, ctx_upv_9.root, ctx_upv_9.weaponId)
                    if preset_upv_2.slam == false then
                        if #v57 > 0 then
                            Util_upv_1.Shake(0.6, 0.15)
                            Util_upv_1.Recoil(1.5, 0)
                        end
                    else
                        Util_upv_1.Shake(((#v57 > 0) and 0.9) or 0.45, 0.25)
                        Util_upv_1.Recoil(((#v57 > 0) and 2.5) or 1.2, 0)
                    end
                    if preset_upv_2.slam ~= false then
                        local v58 = ctx_upv_9.root.CFrame * CFrame.new(0, -2.8, -4)
                        Effects_upv_1.Burst("Ground_Slam", v58)
                        Effects_upv_1.GroundScuff(v58.Position)
                    end
                end
            )
        end
    end
end
function tbl_upv_1.ParryReady(a1)
    --[[
      name: ParryReady
      line: 576
      upvalues:
        Util_upv_1 (copy, index: 1)
    ]]
    local v59 = os.clock()
    if type(a1.tuning.parry) == "table" and not (a1.parrying) and not (v59 < a1.parryReadyAt) and not (v59 - a1.lastParryUp < 0.15) then
        local v60 = a1.ctx.tool and (a1.ctx.tool:GetAttribute("Cooldown"))
        if type(v60) == "number" and workspace:GetServerTimeNow() < v60 then
            return false
        end
        local v61 = (a1.busyUntil <= v59) and ((a1:Cooldown() <= v59 - a1.lastSwing) and (Util_upv_1.CanAct()))
        return v61
    end
    return false
end
function tbl_upv_1.RaiseParry(a1)
    --[[
      name: RaiseParry
      line: 591
      upvalues:
        Util_upv_1 (copy, index: 1)
    ]]
    local ctx_10 = a1.ctx
    local parry_1 = a1.tuning.parry
    if not a1:ParryReady() then
        return
    end
    a1.parrying = true
    a1.lastParryUp = os.clock()
    a1.parryUpAt = a1.lastParryUp
    a1.bufferedAt = nil
    Util_upv_1.FaceCamera()
    ctx_10.send("Parry", {on = true, tool = ctx_10.tool})
    ctx_10.emit("Parry", {on = true})
    Util_upv_1.PlayHold(ctx_10.animator, a1.preset.parryHold or (a1.preset.parry), 1)
    Util_upv_1.Sound(a1.preset.parrySound or "Katana_Flick", ctx_10.root)
    ctx_10.setSpeed("Parry", parry_1.speedMult or 0.7)
end
function tbl_upv_1.LowerParry(a1, a2, a3, a4)
    --[[
      name: LowerParry
      line: 612
      upvalues:
        Hud_upv_1 (copy, index: 1)
        Util_upv_1 (copy, index: 2)
    ]]
    if not a1.parrying then
        return
    end
    local ctx_11 = a1.ctx
    a1.parrying = false
    local parry_2 = a1.tuning.parry
    if not (a3) and type(parry_2) == "table" then
        local v62 = parry_2.cooldown or 1.6
        a1.parryReadyAt = math.max(a1.parryReadyAt, os.clock() + v62)
        if not (a4) then
            Hud_upv_1.SetArc(v62, Color3.fromRGB(150, 196, 236))
        end
    end
    if a2 then
        ctx_11.send("Parry", {on = false, tool = ctx_11.tool})
    end
    if not (a3) then
        ctx_11.emit("Parry", {on = false})
    end
    Util_upv_1.StopAnim(ctx_11.animator, a1.preset.parryHold or (a1.preset.parry), 0.15)
    ctx_11.setSpeed("Parry", nil)
end
function tbl_upv_1.ParryUsed(a1)
    --[[
      name: ParryUsed
      line: 637
      upvalues:
        Hud_upv_1 (copy, index: 1)
    ]]
    local parry_3 = a1.tuning.parry
    if type(parry_3) ~= "table" then
        return
    end
    local v63 = parry_3.cooldown or 1.6
    a1.parryReadyAt = os.clock() + v63
    Hud_upv_1.SetArc(v63, Color3.fromRGB(150, 196, 236))
    a1:LowerParry(false, true)
end
function tbl_upv_1.Hurl(a1)
    --[[
      name: Hurl
      line: 650
      upvalues:
        Util_upv_1 (copy, index: 1)
        Combat_upv_1 (copy, index: 2)
        Effects_upv_1 (copy, index: 3)
        Hud_upv_1 (copy, index: 4)
        Touch_upv_1 (copy, index: 5)
    ]]
    local ctx_upv_12 = a1.ctx
    local throw_1 = a1.tuning.throw
    local v64 = os.clock()
    if type(throw_1) ~= "table" or (a1:OneHanded()) or (v64 - a1.lastThrow < (throw_1.cooldown or 0.45)) or (v64 < a1.busyUntil) then
        return
    end
    if Util_upv_1.CanAct() then
        local v65 = ctx_upv_12.tool and (ctx_upv_12.tool:GetAttribute("Cooldown"))
        if type(v65) == "number" and workspace:GetServerTimeNow() < v65 then
            return
        end
        a1.lastThrow = v64
        a1.thrownLocalUntil = v64 + 0.8
        a1.busyUntil = v64 + 0.2
        a1.bufferedAt = nil
        Util_upv_1.FaceCamera()
        local v66 = Util_upv_1.ShotOrigin(nil)
        local v67 = Util_upv_1.AimPoint(throw_1.range or 170)
        local v68 = Util_upv_1.AssistDirection(v66, Util_upv_1.AimDirection(v66), true)
        local v69 = throw_1.speed or 120
        local v70 = throw_1.gravity or 0
        local Magnitude_2 = (v67 - v66).Magnitude
        if v70 > 0 and Magnitude_2 > 1 then
            local _ = Magnitude_2 / v69
            v68 = (v68 * Magnitude_2 + Vector3.new(0, 0.5 * v70 * (Magnitude_2 / v69) * (Magnitude_2 / v69), 0)).Unit
        end
        local v71 = ctx_upv_12.nextId()
        ctx_upv_12.emit("Hurl", {})
        Util_upv_1.PlayAnim(ctx_upv_12.animator, a1.preset.throw, 1.2, 0.03)
        Util_upv_1.Sound(a1.preset.throwSound or "Hatchet_Throw", ctx_upv_12.root)
        Combat_upv_1.ShowOffHand(ctx_upv_12.tool, false)
        Effects_upv_1.Projectile(Effects_upv_1.MyKey(v71), "Hatchet", v66, v68 * v69, v70, ctx_upv_12.char, {damage = (throw_1.damage or 40) * Util_upv_1.ItemBonus(ctx_upv_12.weaponId), tuning = throw_1})
        ctx_upv_12.send("Hurl", {tool = ctx_upv_12.tool, origin = v66, dir = v68, id = v71})
        Hud_upv_1.SetArc(throw_1.returnTime or 5, Color3.fromRGB(214, 170, 120))
        Touch_upv_1.SetAltDim(true)
        local tool_upv_4 = ctx_upv_12.tool
        task.delay(
            0.85,
            function()
                --[[
                  line: 691
                  upvalues:
                    tool_upv_4 (copy, index: 1)
                    a1 (copy, index: 2)
                    Combat_upv_1 (copy, index: 3)
                    ctx_upv_12 (copy, index: 4)
                    Hud_upv_1 (copy, index: 5)
                    Touch_upv_1 (copy, index: 6)
                ]]
                if not tool_upv_4 or not tool_upv_4.Parent or tool_upv_4:GetAttribute("Thrown") == true or not (a1.thrownLocalUntil <= os.clock()) then
                    return
                end
                Combat_upv_1.ShowOffHand(tool_upv_4, true)
                if tool_upv_4.Parent ~= ctx_upv_12.char then
                    return
                end
                Hud_upv_1.SetArc(0)
                Touch_upv_1.SetAltDim(false)
            end
        )
    end
end
function tbl_upv_1.Input(a1, a2, a3)
    --[[
      name: Input
      line: 704
    ]]
    local tuning_3 = a1.tuning
    if a2 == "Primary" then
        a1.holding = a3
        if not a3 then
            return
        end
        a1.guardFirst = false
        if a1.blocking then
            a1:SetBlock(false)
        end
        if a1.parrying then
            a1:LowerParry(true)
        end
        if (a1.charging) or (a1:Swing()) then
            return
        end
        a1.bufferedAt = os.clock()
    elseif a2 == "Secondary" then
        if tuning_3.parry then
            a1.parryHeld = a3
            if a3 then
                a1:RaiseParry()
            else
                a1:LowerParry(true)
            end
        elseif tuning_3.throw then
            if not a3 then
                return
            end
            a1:Hurl()
        elseif tuning_3.block then
            a1.blockHeld = a3
            if a3 then
                a1.guardFirst = true
                a1.bufferedAt = nil
            end
            local v72 = a3 and (a1:CanGuard())
            a1:SetBlock(v72)
        elseif tuning_3.heavy then
            if a3 then
                a1:StartCharge("Heavy")
            else
                a1:ReleaseCharge()
            end
        else
            if tuning_3.lunge and (tuning_3.lunge.charge or 0.6) <= 0 then
                if a3 then
                    a1:Dash()
                end
                return
            end
            if not tuning_3.lunge then
                return
            end
            if a3 then
                a1:StartCharge("Lunge")
            else
                a1:ReleaseCharge()
            end
        end
    end
end
function tbl_upv_1.Update(a1, a2)
    --[[
      name: Update
      line: 759
      upvalues:
        Util_upv_1 (copy, index: 1)
        Hud_upv_1 (copy, index: 2)
    ]]
    local parry_4 = a1.tuning.parry
    if a1.parrying and type(parry_4) == "table" and type(parry_4.maxHold) == "number" and parry_4.maxHold <= os.clock() - a1.parryUpAt then
        a1:LowerParry(true)
    end
    if a1.parryHeld and not (a1.parrying) and not (a1.holding) and a1:ParryReady() then
        a1:RaiseParry()
    end
    if a1.blockHeld and not (a1.blocking) and not (a1.charging) then
        if a1.bufferedAt or not (a1.guardFirst) and a1.holding or not (a1:CanGuard()) then
            a1:DrawGuard()
            if a1.holding then
                if a1.blocking or a1.charging then
                    if a1.bufferedAt then
                        if os.clock() - a1.bufferedAt > 0.2 or a1.blocking or a1.charging then
                            a1.bufferedAt = nil
                        else
                            a1:Swing()
                        end
                    end
                else
                    a1:Swing()
                end
            elseif a1.bufferedAt then
                if os.clock() - a1.bufferedAt > 0.2 or a1.blocking or a1.charging then
                    a1.bufferedAt = nil
                else
                    a1:Swing()
                end
            end
            if a1.charging then
                local v73 = a1:SpecialInfo(a1.charging)
                local v74 = math.clamp((os.clock() - a1.chargeStart) / (v73.charge or 0.6), 0, 1)
                if v74 >= 1 and not (a1.fullPlayed) then
                    a1.fullPlayed = true
                    Util_upv_1.Sound("Charge_Full", a1.ctx.root)
                end
                Hud_upv_1.SetCharge(v74)
            end
            return
        end
        a1:SetBlock(true)
    end
    a1:DrawGuard()
    if a1.holding then
        if a1.blocking or a1.charging then
            if a1.bufferedAt then
                if os.clock() - a1.bufferedAt > 0.2 or a1.blocking or a1.charging then
                    a1.bufferedAt = nil
                else
                    a1:Swing()
                end
            end
        else
            a1:Swing()
        end
    elseif a1.bufferedAt then
        if os.clock() - a1.bufferedAt > 0.2 or a1.blocking or a1.charging then
            a1.bufferedAt = nil
        else
            a1:Swing()
        end
    end
    if a1.charging then
        local v73 = a1:SpecialInfo(a1.charging)
        local v74 = math.clamp((os.clock() - a1.chargeStart) / (v73.charge or 0.6), 0, 1)
        if v74 >= 1 and not (a1.fullPlayed) then
            a1.fullPlayed = true
            Util_upv_1.Sound("Charge_Full", a1.ctx.root)
        end
        Hud_upv_1.SetCharge(v74)
    end
end
function tbl_upv_1.Interrupt(a1)
    --[[
      name: Interrupt
      line: 798
    ]]
    if a1.blocking then
        a1:SetBlock(false)
    end
    if a1.charging then
        a1:CancelCharge()
    end
    a1:LowerParry(true)
    a1.busyUntil = math.max(a1.busyUntil, os.clock() + 0.2)
end
return tbl_upv_1