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
local tbl_upv_2 = {}
function tbl_upv_1.new(a1)
    --[[
      name: new
      line: 28
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
      line: 58
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
      line: 70
    ]]
    if a1:OneHanded() then
        return a1.tuning.oneHanded.cooldown or 0.45
    end
    return a1.tuning.cooldown or 0.5
end
function tbl_upv_1.Equip(a1)
    --[[
      name: Equip
      line: 77
      upvalues:
        Hud_upv_1 (copy, index: 1)
        Util_upv_1 (copy, index: 2)
        tbl_upv_2 (copy, index: 3)
        Simulation_upv_1 (copy, index: 4)
        Touch_upv_1 (copy, index: 5)
        Combat_upv_1 (copy, index: 6)
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
    if tool_upv_2 and type(lunge_1) == "table" then
        local v4 = nil
        if lunge_1.refreshOnKill then
            v4 = tool_upv_2:GetAttribute("Refreshed")
            if type(v4) == "number" and tbl_upv_2[ctx_upv_1.weaponId] and tbl_upv_2[ctx_upv_1.weaponId] < v4 then
                Simulation_upv_1.RefreshDash(ctx_upv_1.char, ctx_upv_1.weaponId)
            end
            table.insert(
                a1.conns,
                tool_upv_2:GetAttributeChangedSignal("Refreshed"):Connect(
                    function()
                        --[[
                          line: 96
                          upvalues:
                            Simulation_upv_1 (copy, index: 1)
                            ctx_upv_1 (copy, index: 2)
                            a1 (copy, index: 3)
                            Hud_upv_1 (copy, index: 4)
                            Util_upv_1 (copy, index: 5)
                        ]]
                        Simulation_upv_1.RefreshDash(ctx_upv_1.char, ctx_upv_1.weaponId)
                        a1.lastSpecial = -math.huge
                        Hud_upv_1.SetArc(0)
                        Util_upv_1.Sound(a1.preset.refreshSound or "Charge_Full", ctx_upv_1.root)
                        ctx_upv_1.emit("Refresh", {})
                    end
                )
            )
        end
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
                      line: 109
                      upvalues:
                        tool_upv_2 (copy, index: 1)
                        u1 (ref,  index: 2)
                        a1 (copy, index: 3)
                        Combat_upv_1 (copy, index: 4)
                        Touch_upv_1 (copy, index: 5)
                        ctx_upv_1 (copy, index: 6)
                        Hud_upv_1 (copy, index: 7)
                    ]]
                    local v5 = tool_upv_2:GetAttribute("Thrown") == true
                    if v5 == u1 then
                        return
                    end
                    u1 = v5
                    a1.thrownLocalUntil = 0
                    Combat_upv_1.ShowOffHand(tool_upv_2, not v5)
                    if v5 then
                        Touch_upv_1.SetAltDim(true)
                    else
                        ctx_upv_1.emit("Catch", {})
                        local v6 = tool_upv_2:GetAttribute("Cooldown")
                        local v7 = ((type(v6) ~= "number") and 0) or (v6 - workspace:GetServerTimeNow())
                        local v8 = a1.tuning.throw.cooldown or 0.45
                        if v7 > 0.05 then
                            Hud_upv_1.SetArc(v8, Color3.fromRGB(214, 170, 120), (math.max(0, v8 - v7)))
                            task.delay(
                                v7,
                                function()
                                    --[[
                                      line: 129
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
      line: 142
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
      line: 170
      upvalues:
        Util_upv_1 (copy, index: 1)
    ]]
    local v9 = Util_upv_1.Probe(a1, a2)
    if v9 ~= nil then
        return v9
    end
    local ctx_3 = a1.ctx
    local root_1 = ctx_3.root
    local Head_1 = ctx_3.char:FindFirstChild("Head")
    if Head_1 then
        v9 = Head_1.Position
    else
        v9 = root_1.Position
    end
    local v10 = Util_upv_1.GetAimRay()
    local Unit_1 = Vector3.new(v10.Direction.X, 0, v10.Direction.Z)
    if Unit_1.Magnitude < 0.05 then
        Unit_1 = root_1.CFrame.LookVector
    end
    Unit_1 = Unit_1.Unit
    v10 = math.cos(math.rad(a3))
    local tbl_3 = {}
    local v11 = Util_upv_1.Targets()
    local v12 = Util_upv_1.WorldParams(v11)
    local v13 = nil
    for _, value_2 in v11 do
        if Util_upv_1.IsTeammate(value_2) then
            continue
        end
        local v14 = value_2:FindFirstChildOfClass("Humanoid")
        local HumanoidRootPart_1 = value_2:FindFirstChild("HumanoidRootPart")
        if not (v14) or not (HumanoidRootPart_1) or not (v14.Health > 0) then
            continue
        end
        local v15 = HumanoidRootPart_1.Position - root_1.Position
        local Magnitude_1 = v15.Magnitude
        if not (Magnitude_1 <= a2 + 1.2) or not (math.abs(v15.Y) < 8) then
            continue
        end
        local v16 = Vector3.new(v15.X, 0, v15.Z)
        v13 = true
        if not (Magnitude_1 < 3.2) then
            v13 = (v16.Magnitude > 0.05) and (v10 <= v16.Unit:Dot(Unit_1))
        end
        if not (v13) then
            continue
        end
        if not (workspace:Raycast(v9, HumanoidRootPart_1.Position - v9, v12)) then
            table.insert(tbl_3, {model = value_2, dist = Magnitude_1})
        end
    end
    table.sort(
        tbl_3,
        function(a5, a6)
            --[[
              line: 207
            ]]
            return a5.dist < a6.dist
        end
    )
    local tbl_4 = {}
    for n_1 = 1, math.min(#tbl_3, a4) do
        table.insert(tbl_4, tbl_3[n_1].model)
    end
    return tbl_4
end
function tbl_upv_1.Ready(a1)
    --[[
      name: Ready
      line: 252
    ]]
    local v17 = os.clock()
    local v18 = (a1.busyUntil <= v17) and (a1:Cooldown() <= v17 - a1.lastSwing)
    return v18
end
local function predictImpacts(a1, a2, a3, a4, a5, a6)
    --[[
      name: predictImpacts
      line: 221
      upvalues:
        Util_upv_1 (copy, index: 1)
        Effects_upv_1 (copy, index: 2)
    ]]
    a3 = a3 and (a3 * Util_upv_1.ItemBonus(a6))
    local v19 = nil
    local v20 = nil
    for _, value_3 in a1 do
        local v21 = Util_upv_1.CanPredictHit(value_3)
        if not (v21) then
            continue
        end
        local v22 = value_3:FindFirstChild("UpperTorso") or (value_3:FindFirstChild("Torso") or (value_3:FindFirstChild("HumanoidRootPart")))
        if v22 and v22:IsA("BasePart") and a5 then
            local v23 = Util_upv_1.ParryFacing(value_3, v22.Position - a5.Position)
            if v23 or not (v22) then
                continue
            end
            v20 = v22:IsA("BasePart")
            if not (v20) then
                continue
            end
            v19 = false
            local HumanoidRootPart_2 = value_3:FindFirstChild("HumanoidRootPart")
            if not (a3) or not (a4) or not (a4.backstabMult) or not (a5) or not (HumanoidRootPart_2) then
                v20 = a3
                Effects_upv_1.CharacterImpact(v22.Position, nil, false)
                Effects_upv_1.PredictHit(value_3, a2, v22.Position + Vector3.new(0, 1, 0), false, v20, v19)
                continue
            end
            local v24 = HumanoidRootPart_2:IsA("BasePart")
            if not (v24) then
                v20 = a3
                Effects_upv_1.CharacterImpact(v22.Position, nil, false)
                Effects_upv_1.PredictHit(value_3, a2, v22.Position + Vector3.new(0, 1, 0), false, v20, v19)
                continue
            end
            local v25 = (a5.Position - HumanoidRootPart_2.Position) * Vector3.new(1, 0, 1)
            local v26 = -(HumanoidRootPart_2.CFrame.LookVector * Vector3.new(1, 0, 1))
            if not (v25.Magnitude > 0.05) or not (v26.Magnitude > 0.05) then
                v20 = a3
                Effects_upv_1.CharacterImpact(v22.Position, nil, false)
                Effects_upv_1.PredictHit(value_3, a2, v22.Position + Vector3.new(0, 1, 0), false, v20, v19)
                continue
            end
            local v27 = v25.Unit:Dot(v26.Unit)
            if math.cos(math.rad(a4.backstabAngle or 70)) <= v27 then
                v20, v19 = a3 * a4.backstabMult, true
            else
                v20 = a3
            end
            Effects_upv_1.CharacterImpact(v22.Position, nil, false)
            Effects_upv_1.PredictHit(value_3, a2, v22.Position + Vector3.new(0, 1, 0), false, v20, v19)
        else
            if not (v22) then
                continue
            end
            v20 = v22:IsA("BasePart")
            if not (v20) then
                continue
            end
            v19 = false
            local HumanoidRootPart_2 = value_3:FindFirstChild("HumanoidRootPart")
            if not (a3) or not (a4) or not (a4.backstabMult) or not (a5) or not (HumanoidRootPart_2) then
                v20 = a3
                Effects_upv_1.CharacterImpact(v22.Position, nil, false)
                Effects_upv_1.PredictHit(value_3, a2, v22.Position + Vector3.new(0, 1, 0), false, v20, v19)
                continue
            end
            local v24 = HumanoidRootPart_2:IsA("BasePart")
            if not (v24) then
                v20 = a3
                Effects_upv_1.CharacterImpact(v22.Position, nil, false)
                Effects_upv_1.PredictHit(value_3, a2, v22.Position + Vector3.new(0, 1, 0), false, v20, v19)
                continue
            end
            local v25 = (a5.Position - HumanoidRootPart_2.Position) * Vector3.new(1, 0, 1)
            local v26 = -(HumanoidRootPart_2.CFrame.LookVector * Vector3.new(1, 0, 1))
            if not (v25.Magnitude > 0.05) or not (v26.Magnitude > 0.05) then
                v20 = a3
                Effects_upv_1.CharacterImpact(v22.Position, nil, false)
                Effects_upv_1.PredictHit(value_3, a2, v22.Position + Vector3.new(0, 1, 0), false, v20, v19)
                continue
            end
            local v27 = v25.Unit:Dot(v26.Unit)
            if math.cos(math.rad(a4.backstabAngle or 70)) <= v27 then
                v20, v19 = a3 * a4.backstabMult, true
            else
                v20 = a3
            end
            Effects_upv_1.CharacterImpact(v22.Position, nil, false)
            Effects_upv_1.PredictHit(value_3, a2, v22.Position + Vector3.new(0, 1, 0), false, v20, v19)
        end
    end
end
function tbl_upv_1.Swing(a1)
    --[[
      name: Swing
      line: 257
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
        local v28 = a1:OneHanded()
        local v29 = Util_upv_1.ProbeValues()
        if v29 and tbl_upv_1.OneHanded(v29.t) ~= v29.t then
            Util_upv_1.Hooked()
        end
        local u3
        if v28 then
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
        local v30
        if v28 then
            v30 = preset_upv_1.oneSwings
        else
            v30 = nil
        end
        v30 = (v30) or preset_upv_1.swings or {}
        local v31 = v30[((combo_upv_1 - 1) % math.max(1, #v30)) + 1]
        Util_upv_1.PlayAnim(ctx_upv_4.animator, v31, (preset_upv_1.swingSpeed or 1) * ((u4 and 0.95) or 1), 0.05)
        ctx_upv_4.emit("Swing", {step = combo_upv_1, finisher = u4, hitDelay = preset_upv_1.hitDelay or 0.1, oneHanded = v28})
        local v32 = preset_upv_1.hitDelay or 0.1
        v30 = ((v32 >= 0.15) and (v32 - 0.04)) or (math.max(0, v32 - 0.1))
        local function whoosh()
            --[[
              name: whoosh
              line: 293
              upvalues:
                Util_upv_1 (copy, index: 1)
                preset_upv_1 (copy, index: 2)
                ctx_upv_4 (copy, index: 3)
                u4 (copy, index: 4)
            ]]
            local Sound_1 = Util_upv_1.Sound
            local root_2 = ctx_upv_4.root
            local tbl_5 = {PlaybackSpeed = 0}
            tbl_5.PlaybackSpeed = (u4 and 0.88) or 1
            Sound_1(preset_upv_1.swingSound or "Swing_Sword", root_2, tbl_5)
        end
        if v30 >= 0.05 then
            task.delay(v30, whoosh)
        else
            local Sound_2 = Util_upv_1.Sound
            local root_3 = ctx_upv_4.root
            local tbl_6 = {PlaybackSpeed = 0}
            tbl_6.PlaybackSpeed = (u4 and 0.88) or 1
            Sound_2(preset_upv_1.swingSound or "Swing_Sword", root_3, tbl_6)
        end
        local v33 = Util_upv_1.InFirstPerson()
        if preset_upv_1.trail and preset_upv_1.trail > 0 and not (v33) then
            Effects_upv_1.Trail(ctx_upv_4.tool, preset_upv_1.trail)
        end
        local v34 = preset_upv_1.hitDelay or 0.1
        a1.strikes = a1.strikes + 1
        if not (preset_upv_1.noSlash) and ctx_upv_4.tool and not (v33) then
            task.delay(
                v34 * 0.6,
                function()
                    --[[
                      line: 308
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
            v34,
            function()
                --[[
                  line: 312
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
                local v35 = Util_upv_1.ProbeValues()
                if v35 and tbl_upv_1.Detect(v35.t, 1, 2, 3) ~= v35.t then
                    Util_upv_1.Hooked()
                end
                local v36 = a1:Detect(tuning_upv_1.range or 8, tuning_upv_1.arc or 60, tuning_upv_1.maxTargets or 1)
                ctx_upv_4.send("Swing", {tool = ctx_upv_4.tool, dir = Util_upv_1.GetAimRay().Direction, hits = v36, k = math.floor((os.clock() - u2) * 1000)})
                predictImpacts(v36, preset_upv_1.hitSound or "Hit_Melee", (tuning_upv_1.damage or 10) * (u3[combo_upv_1] or 1), tuning_upv_1, ctx_upv_4.root, ctx_upv_4.weaponId)
                if not (#v36 > 0) then
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
      line: 345
      upvalues:
        Util_upv_1 (copy, index: 1)
    ]]
    local v37 = (a1.strikes <= 0) and ((a1.busyUntil <= os.clock()) and (Util_upv_1.CanAct() and (not a1:GuardBroken())))
    return v37
end
function tbl_upv_1.GuardBroken(a1)
    --[[
      name: GuardBroken
      line: 350
      upvalues:
        Combat_upv_1 (copy, index: 1)
    ]]
    local block_1 = a1.tuning.block
    local v38 = (type(block_1) == "table") and ((block_1.durability ~= nil) and (Combat_upv_1.GuardBrokenLeft(a1.ctx.char, workspace:GetServerTimeNow()) > 0))
    return v38
end
function tbl_upv_1.DrawGuard(a1)
    --[[
      name: DrawGuard
      line: 356
      upvalues:
        Combat_upv_1 (copy, index: 1)
        Hud_upv_1 (copy, index: 2)
    ]]
    local block_2 = a1.tuning.block
    local v39 = (type(block_2) == "table") and (block_2.durability)
    if not v39 then
        return
    end
    local v40 = workspace:GetServerTimeNow()
    local v41, v42 = Combat_upv_1.GuardHp(a1.ctx.char, v39, v40)
    v39 = Combat_upv_1.GuardBrokenLeft(a1.ctx.char, v40) > 0
    local SetGuard_1 = Hud_upv_1.SetGuard
    local v43
    if a1.blocking or v39 or v41 < v42 then
        v43 = v41 / v42
    else
        v43 = nil
    end
    SetGuard_1(v43, v39)
end
function tbl_upv_1.SetBlock(a1, a2)
    --[[
      name: SetBlock
      line: 368
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
        local v44 = ((type(block_3) == "table") and (block_3.swapDelay)) or nil
        GuardDown_1(tool_3, v44)
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
        local v45 = os.clock()
        if v45 - u5 >= 0.5 then
            u5 = v45
            Util_upv_1.Sound("Block_Up", ctx_5.root)
        end
        local v46 = Util_upv_1.ProbeValues()
        if v46 and ctx_5.setSpeed(v46.s, 1) ~= v46.s then
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
      line: 406
    ]]
    local v47
    if a2 ~= "Heavy" then
        v47 = a1.tuning.lunge
    else
        v47 = a1.tuning.heavy
    end
    if not (v47) then
        v47 = {}
    end
    return v47
end
function tbl_upv_1.SpecialReady(a1, a2, a3)
    --[[
      name: SpecialReady
      line: 415
      upvalues:
        Simulation_upv_1 (copy, index: 1)
    ]]
    if a3 - a1.lastSpecial < (a2.cooldown or 1) or a2 == a1.tuning.lunge and not (Simulation_upv_1.DashReady(a1.ctx.char, a1.ctx.weaponId)) then
        return false
    end
    local v48 = a1.ctx.tool and (a1.ctx.tool:GetAttribute("Cooldown"))
    local v49 = false
    if type(v48) == "number" then
        v49 = workspace:GetServerTimeNow() < v48
    end
    return not v49
end
function tbl_upv_1.StartCharge(a1, a2)
    --[[
      name: StartCharge
      line: 426
      upvalues:
        Util_upv_1 (copy, index: 1)
    ]]
    local ctx_6 = a1.ctx
    local v50 = os.clock()
    local v51 = a1:SpecialInfo(a2)
    if not a1:SpecialReady(v51, v50) or (v50 < a1.busyUntil) then
        return
    end
    if Util_upv_1.CanAct() then
        a1.charging = a2
        a1.chargeStart = v50
        a1.bufferedAt = nil
        a1.fullPlayed = false
        ctx_6.send("Charge", {on = true, tool = ctx_6.tool, kind = a2})
        ctx_6.emit("Charge", {on = true, kind = a2, time = v51.charge or 0.6})
        local PlayHold_1 = Util_upv_1.PlayHold
        local animator_1 = ctx_6.animator
        local v52
        if a2 ~= "Heavy" then
            v52 = a1.preset.lungeCharge
        else
            v52 = a1.preset.heavyCharge
        end
        PlayHold_1(animator_1, v52, 1)
        Util_upv_1.Sound(a1.preset.chargeSound or "Charge_Up", ctx_6.root)
        ctx_6.setSpeed("Charge", v51.speedMult or 0.55)
    end
end
function tbl_upv_1.CancelCharge(a1)
    --[[
      name: CancelCharge
      line: 444
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
        local v53
        if charging_1 ~= "Heavy" then
            v53 = a1.preset.lungeCharge
        else
            v53 = a1.preset.heavyCharge
        end
        StopAnim_1(animator_2, v53, 0.1)
    end
    ctx_7.setSpeed("Charge", nil)
    Hud_upv_1.SetCharge(0)
end
function tbl_upv_1.Dash(a1)
    --[[
      name: Dash
      line: 459
      upvalues:
        Util_upv_1 (copy, index: 1)
    ]]
    local ctx_8 = a1.ctx
    local v54 = a1:SpecialInfo("Lunge")
    local v55 = os.clock()
    if not a1:SpecialReady(v54, v55) or (v55 < a1.busyUntil) or not Util_upv_1.CanAct() then
        return
    end
    a1.bufferedAt = nil
    ctx_8.send("Charge", {kind = "Lunge", on = true, tool = ctx_8.tool})
    a1.charging = "Lunge"
    a1.chargeStart = v55 - 1
    a1:ReleaseCharge()
end
function tbl_upv_1.ReleaseCharge(a1)
    --[[
      name: ReleaseCharge
      line: 473
      upvalues:
        Util_upv_1 (copy, index: 1)
        Hud_upv_1 (copy, index: 2)
        Effects_upv_1 (copy, index: 3)
        predictImpacts (copy, index: 4)
        Simulation_upv_1 (copy, index: 5)
        tbl_upv_2 (copy, index: 6)
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
        local v56
        if charging_2 ~= "Heavy" then
            v56 = preset_upv_2.lungeCharge
        else
            v56 = preset_upv_2.heavyCharge
        end
        StopAnim_2(animator_3, v56, 0.05)
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
            local v57 = Util_upv_1.GetAimRay()
            u7 = Vector3.new(v57.Direction.X, 0, v57.Direction.Z)
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
                              line: 547
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
            tbl_upv_2[ctx_upv_9.weaponId] = workspace:GetServerTimeNow()
            v57 = math.clamp((u6.distance or 16) / (u6.speed or 70), 0.12, 0.35)
            Util_upv_1.FovKick(6, 0.05, v57 + 0.05)
            if preset_upv_2.lungeLines and Util_upv_1.InFirstPerson() then
                Effects_upv_1.DashLines(v57 + 0.12)
            end
            ctx_upv_9.emit("Lunge", {time = v57})
            local tbl_upv_8 = {}
            local tbl_upv_9 = {}
            for n_2 = 0, 3 do
                task.delay(
                    (v57 / 3) * n_2,
                    function()
                        --[[
                          line: 565
                          upvalues:
                            a1 (copy, index: 1)
                            u6 (copy, index: 2)
                            tuning_upv_2 (copy, index: 3)
                            tbl_upv_8 (copy, index: 4)
                            tbl_upv_9 (copy, index: 5)
                        ]]
                        for _, value_4 in a1:Detect(u6.range or 12, u6.arc or 35, tuning_upv_2.maxTargets or 2) do
                            if tbl_upv_8[value_4] then
                                continue
                            end
                            if #tbl_upv_9 < (tuning_upv_2.maxTargets or 2) then
                                tbl_upv_8[value_4] = true
                                table.insert(tbl_upv_9, value_4)
                            end
                        end
                    end
                )
            end
            task.delay(
                v57,
                function()
                    --[[
                      line: 574
                      upvalues:
                        ctx_upv_9 (copy, index: 1)
                        u7 (ref,  index: 2)
                        tbl_upv_9 (copy, index: 3)
                        predictImpacts (copy, index: 4)
                        preset_upv_2 (copy, index: 5)
                        u6 (copy, index: 6)
                        Util_upv_1 (copy, index: 7)
                    ]]
                    if not ctx_upv_9.alive() then
                        return
                    end
                    ctx_upv_9.send("Swing", {lunge = true, tool = ctx_upv_9.tool, dir = u7, hits = tbl_upv_9})
                    predictImpacts(tbl_upv_9, preset_upv_2.hitSound or "Hit_Melee_Heavy", u6.damage, nil, ctx_upv_9.root, ctx_upv_9.weaponId)
                    if #tbl_upv_9 > 0 then
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
            local v58 = preset_upv_2.heavyDelay or 0.16
            if not (Util_upv_1.InFirstPerson()) then
                Effects_upv_1.Trail(ctx_upv_9.tool, 0.5)
                task.delay(
                    v58 * 0.6,
                    function()
                        --[[
                          line: 504
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
                v58,
                function()
                    --[[
                      line: 508
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
                    local v59 = a1:Detect(u6.range or ((tuning_upv_2.range or 9) + 1), math.min((tuning_upv_2.arc or 60) + 10, 90), tuning_upv_2.maxTargets or 2)
                    ctx_upv_9.send("Swing", {heavy = true, tool = ctx_upv_9.tool, dir = Util_upv_1.GetAimRay().Direction, hits = v59})
                    predictImpacts(v59, preset_upv_2.hitSound or "Hit_Melee_Heavy", u6.damage, nil, ctx_upv_9.root, ctx_upv_9.weaponId)
                    if preset_upv_2.slam == false then
                        if #v59 > 0 then
                            Util_upv_1.Shake(0.6, 0.15)
                            Util_upv_1.Recoil(1.5, 0)
                        end
                    else
                        Util_upv_1.Shake(((#v59 > 0) and 0.9) or 0.45, 0.25)
                        Util_upv_1.Recoil(((#v59 > 0) and 2.5) or 1.2, 0)
                    end
                    if preset_upv_2.slam ~= false then
                        local v60 = ctx_upv_9.root.CFrame * CFrame.new(0, -2.8, -4)
                        Effects_upv_1.Burst("Ground_Slam", v60)
                        Effects_upv_1.GroundScuff(v60.Position)
                    end
                end
            )
        end
    end
end
function tbl_upv_1.ParryReady(a1)
    --[[
      name: ParryReady
      line: 595
      upvalues:
        Util_upv_1 (copy, index: 1)
    ]]
    local v61 = os.clock()
    if type(a1.tuning.parry) == "table" and not (a1.parrying) and not (v61 < a1.parryReadyAt) and not (v61 - a1.lastParryUp < 0.15) then
        local v62 = a1.ctx.tool and (a1.ctx.tool:GetAttribute("Cooldown"))
        if type(v62) == "number" and workspace:GetServerTimeNow() < v62 then
            return false
        end
        local v63 = (a1.busyUntil <= v61) and ((a1:Cooldown() <= v61 - a1.lastSwing) and (Util_upv_1.CanAct()))
        return v63
    end
    return false
end
function tbl_upv_1.RaiseParry(a1)
    --[[
      name: RaiseParry
      line: 610
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
      line: 631
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
        local v64 = parry_2.cooldown or 1.6
        a1.parryReadyAt = math.max(a1.parryReadyAt, os.clock() + v64)
        if not (a4) then
            Hud_upv_1.SetArc(v64, Color3.fromRGB(150, 196, 236))
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
      line: 656
      upvalues:
        Hud_upv_1 (copy, index: 1)
    ]]
    local parry_3 = a1.tuning.parry
    if type(parry_3) ~= "table" then
        return
    end
    local v65 = parry_3.cooldown or 1.6
    a1.parryReadyAt = os.clock() + v65
    Hud_upv_1.SetArc(v65, Color3.fromRGB(150, 196, 236))
    a1:LowerParry(false, true)
end
function tbl_upv_1.OnDenied(a1, a2)
    --[[
      name: OnDenied
      line: 670
      upvalues:
        Hud_upv_1 (copy, index: 1)
    ]]
    if a2 ~= "ParryRefused" then
        if a2 ~= "NoCharges" then
            return
        end
        Hud_upv_1.Toast("NONE LEFT THIS ROUND", Color3.fromRGB(255, 120, 90))
    elseif a1.parrying then
        a1.parryReadyAt = math.max(a1.parryReadyAt, os.clock() + 0.5)
        a1:LowerParry(false, true)
        a1.ctx.emit("Parry", {on = false})
    end
end
function tbl_upv_1.Hurl(a1)
    --[[
      name: Hurl
      line: 684
      upvalues:
        Util_upv_1 (copy, index: 1)
        Combat_upv_1 (copy, index: 2)
        Effects_upv_1 (copy, index: 3)
        Hud_upv_1 (copy, index: 4)
        Touch_upv_1 (copy, index: 5)
    ]]
    local ctx_upv_12 = a1.ctx
    local throw_1 = a1.tuning.throw
    local v66 = os.clock()
    if type(throw_1) ~= "table" or (a1:OneHanded()) or (v66 - a1.lastThrow < (throw_1.cooldown or 0.45)) or (v66 < a1.busyUntil) then
        return
    end
    if Util_upv_1.CanAct() then
        local v67 = ctx_upv_12.tool and (ctx_upv_12.tool:GetAttribute("Cooldown"))
        if type(v67) == "number" and workspace:GetServerTimeNow() < v67 then
            return
        end
        a1.lastThrow = v66
        a1.thrownLocalUntil = v66 + 0.8
        a1.busyUntil = v66 + 0.2
        a1.bufferedAt = nil
        Util_upv_1.FaceCamera()
        local v68 = Util_upv_1.ShotOrigin(nil)
        local v69 = Util_upv_1.AimPoint(throw_1.range or 170)
        local v70 = Util_upv_1.AssistDirection(v68, Util_upv_1.AimDirection(v68), true)
        local v71 = throw_1.speed or 120
        local v72 = throw_1.gravity or 0
        local Magnitude_2 = (v69 - v68).Magnitude
        if v72 > 0 and Magnitude_2 > 1 then
            local _ = Magnitude_2 / v71
            v70 = (v70 * Magnitude_2 + Vector3.new(0, 0.5 * v72 * (Magnitude_2 / v71) * (Magnitude_2 / v71), 0)).Unit
        end
        local v73 = ctx_upv_12.nextId()
        ctx_upv_12.emit("Hurl", {})
        Util_upv_1.PlayAnim(ctx_upv_12.animator, a1.preset.throw, 1.2, 0.03)
        Util_upv_1.Sound(a1.preset.throwSound or "Hatchet_Throw", ctx_upv_12.root)
        Combat_upv_1.ShowOffHand(ctx_upv_12.tool, false)
        Effects_upv_1.Projectile(Effects_upv_1.MyKey(v73), "Hatchet", v68, v70 * v71, v72, ctx_upv_12.char, {damage = (throw_1.damage or 40) * Util_upv_1.ItemBonus(ctx_upv_12.weaponId), tuning = throw_1})
        ctx_upv_12.send("Hurl", {tool = ctx_upv_12.tool, origin = v68, dir = v70, id = v73})
        Hud_upv_1.SetArc(throw_1.returnTime or 5, Color3.fromRGB(214, 170, 120))
        Touch_upv_1.SetAltDim(true)
        local tool_upv_4 = ctx_upv_12.tool
        task.delay(
            0.85,
            function()
                --[[
                  line: 725
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
      line: 738
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
            local v74 = a3 and (a1:CanGuard())
            a1:SetBlock(v74)
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
      line: 793
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
                local v75 = a1:SpecialInfo(a1.charging)
                local v76 = math.clamp((os.clock() - a1.chargeStart) / (v75.charge or 0.6), 0, 1)
                if v76 >= 1 and not (a1.fullPlayed) then
                    a1.fullPlayed = true
                    Util_upv_1.Sound("Charge_Full", a1.ctx.root)
                end
                Hud_upv_1.SetCharge(v76)
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
        local v75 = a1:SpecialInfo(a1.charging)
        local v76 = math.clamp((os.clock() - a1.chargeStart) / (v75.charge or 0.6), 0, 1)
        if v76 >= 1 and not (a1.fullPlayed) then
            a1.fullPlayed = true
            Util_upv_1.Sound("Charge_Full", a1.ctx.root)
        end
        Hud_upv_1.SetCharge(v76)
    end
end
function tbl_upv_1.Interrupt(a1)
    --[[
      name: Interrupt
      line: 832
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