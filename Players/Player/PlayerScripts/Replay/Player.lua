local Players_1 = game:GetService("Players")
local ReplicatedStorage_1 = game:GetService("ReplicatedStorage")
local RunService_upv_1 = game:GetService("RunService")
local Workspace_upv_1 = game:GetService("Workspace")
local Shared_upv_1 = ReplicatedStorage_1:WaitForChild("Shared")
local ReplayCodec_upv_1 = require(Shared_upv_1:WaitForChild("ReplayCodec"))
local Combat_upv_1 = require(Shared_upv_1:WaitForChild("Combat"))
local Ballistics_upv_1 = require(Shared_upv_1.Combat:WaitForChild("Ballistics"))
local Clip_upv_1 = require(script.Parent.Clip)
local Puppets_upv_1 = require(script.Parent.Puppets)
local Locomotion_upv_1 = require(script.Parent.Locomotion)
local Director_upv_1 = require(script.Parent.Director)
local Overlay_upv_1 = require(script.Parent.Overlay)
local Stage_upv_1 = require(script.Parent.Stage)
local PoseTrace_upv_1 = require(script.Parent.PoseTrace)
local Hud_upv_1 = require(script.Parent.Hud)
local View_upv_1 = require(script.Parent.View)
local Diag_upv_1 = require(script.Parent.Diag)
local tbl_upv_1 = {}
local LocalPlayer_upv_1 = Players_1.LocalPlayer
local Parent_upv_1 = script.Parent.Parent
local tbl_upv_2 = {}
local tbl_upv_3 = {}
task.spawn(
    function()
        --[[
          line: 71
          upvalues:
            Parent_upv_1 (copy, index: 1)
            tbl_upv_3 (copy, index: 2)
        ]]
        local v1 = Parent_upv_1:WaitForChild("Character", 15)
        local v2 = v1 and (v1:WaitForChild("Procedural", 15))
        if not v2 then
            return
        end
        if v2:IsA("ModuleScript") then
            local success_1, v3 = pcall(require, v2)
            if not success_1 or type(v3) ~= "table" then
                return
            end
            tbl_upv_3.Procedural = v3
        end
    end
)
local u1 = nil
task.spawn(
    function()
        --[[
          line: 83
          upvalues:
            Shared_upv_1 (copy, index: 1)
            u1 (ref,  index: 2)
        ]]
        local v4 = Shared_upv_1:WaitForChild("Sfx", 15)
        if not v4 then
            return
        end
        if v4:IsA("ModuleScript") then
            local success_2, v5 = pcall(require, v4)
            if not success_2 or type(v5) ~= "table" then
                return
            end
            u1 = v5
        end
    end
)
local u2 = nil
local u3 = 0
local tbl_upv_4 = {}
local tbl_upv_5 = {}
local function holdFor(a1)
    --[[
      name: holdFor
      line: 127
      upvalues:
        tbl_upv_2 (copy, index: 1)
        Combat_upv_1 (copy, index: 2)
    ]]
    local Presentation_1 = tbl_upv_2.Presentation
    if a1 and Presentation_1 then
        local success_3, v6 = pcall(Presentation_1.For, a1, Combat_upv_1.Kind(a1))
        if success_3 and type(v6) == "table" and type(v6.hold) == "string" then
            return v6.hold
        end
        return nil
    end
    return nil
end
local function onPuppetDied(a1)
    --[[
      name: onPuppetDied
      line: 155
      upvalues:
        Locomotion_upv_1 (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
    ]]
    if a1.loco then
        Locomotion_upv_1.Stop(a1.loco)
    end
    for _, value_1 in a1.animator:GetPlayingAnimationTracks() do
        value_1:Stop(0.25)
    end
    if not a1.blocking or not tbl_upv_2.Guard then
        return
    end
    pcall(tbl_upv_2.Guard.Set, a1.model, false)
    a1.blocking = false
end
local function refIndex(a1)
    --[[
      name: refIndex
      line: 184
    ]]
    if type(a1) == "table" and type(a1.fighter) == "number" then
        return a1.fighter
    end
    return nil
end
local tbl_upv_6 = nil
local function logAction(a1, a2, a3, a4, a5, a6, a7)
    --[[
      name: logAction
      line: 224
      upvalues:
        tbl_upv_6 (ref,  index: 1)
        Combat_upv_1 (copy, index: 2)
    ]]
    if not tbl_upv_6 or a1.phase ~= "play" then
        return
    end
    if a2 == "Projectile" and a5 == a1.focus and typeof(a3.origin) == "Vector3" and typeof(a3.velocity) == "Vector3" and a3.velocity.Magnitude > 0.1 then
        local str_1 = tostring(a3.key)
        local v7 = a1.landed[str_1] or (a1.landed[str_1 .. "/1"])
        local v8
        if v7 then
            v8 = math.clamp((v7 - a3.origin).Magnitude, 8, 400)
        else
            v8 = 80
        end
        local pending_1 = tbl_upv_6.pending
        local tbl_7 = {victim = 0, kind = "shot", weapon = 0}
        tbl_7.t = a4
        tbl_7.point = a3.origin + (a3.velocity.Unit * v8)
        tbl_7.victim = a1.landedOn[str_1] or (a1.landedOn[str_1 .. "/1"])
        tbl_7.weapon = a3.weaponId
        table.insert(pending_1, tbl_7)
        return
    end
    if a2 == "Hit" and a6 == a1.focus and typeof(a3.position) == "Vector3" and type(a3.weaponId) == "string" then
        local v9 = nil
        if Combat_upv_1.IsMelee(Combat_upv_1.Kind(a3.weaponId)) then
            local pending_2 = tbl_upv_6.pending
            local tbl_8 = {victim = 0, killed = 0, kind = "melee", weapon = 0}
            tbl_8.t = a4
            tbl_8.point = a3.position
            v9 = a3.target
            local v10
            if type(v9) == "table" and type(v9.fighter) == "number" then
                v10 = v9.fighter
            else
                v10 = nil
            end
            tbl_8.victim = v10
            tbl_8.weapon = a3.weaponId
            tbl_8.killed = a3.killed == true
            table.insert(pending_2, tbl_8)
            return
        end
    end
    if a2 == "Damage" and a6 == a1.focus and a3.killed == true and a7 then
        table.insert(tbl_upv_6.pending, {kind = "kill", t = a4, victim = a7, weapon = a3.weaponId})
    end
end
local function logCamera(a1, a2, a3)
    --[[
      name: logCamera
      line: 241
      upvalues:
        tbl_upv_6 (ref, index: 1)
    ]]
    if not tbl_upv_6 or a1.phase ~= "play" then
        return
    end
    local CFrame_upv_1 = a3.CFrame
    local LookVector_upv_1 = CFrame_upv_1.LookVector
    local v11 = #tbl_upv_6.t + 1
    tbl_upv_6.t[v11] = a2
    tbl_upv_6.yaw[v11] = math.atan2(-LookVector_upv_1.X, -LookVector_upv_1.Z)
    tbl_upv_6.pitch[v11] = math.asin(math.clamp(LookVector_upv_1.Y, -1, 1))
    tbl_upv_6.x[v11] = CFrame_upv_1.Position.X
    tbl_upv_6.y[v11] = CFrame_upv_1.Position.Y
    tbl_upv_6.z[v11] = CFrame_upv_1.Position.Z
    tbl_upv_6.fov[v11] = a3.FieldOfView
    tbl_upv_6.startTime = a1.payload.startTime
    tbl_upv_6.focus = a1.clip.fighters[a1.focus].id
    tbl_upv_6.duration = a1.clip.duration
    for _, value_2 in tbl_upv_6.pending do
        local function miss_1(a4)
            --[[
              name: miss
              line: 259
              upvalues:
                CFrame_upv_1 (copy, index: 1)
                LookVector_upv_1 (copy, index: 2)
            ]]
            local v12 = a4 - CFrame_upv_1.Position
            return (v12 - (LookVector_upv_1 * v12:Dot(LookVector_upv_1))).Magnitude, (math.deg(math.acos(math.clamp(LookVector_upv_1:Dot(v12.Unit), -1, 1))))
        end
        local tbl_9 = {}
        tbl_9.kind = value_2.kind
        tbl_9.t = value_2.t
        tbl_9.frameT = a2
        tbl_9.weapon = value_2.weapon
        tbl_9.killed = value_2.killed
        if value_2.point then
            local v13 = value_2.point - CFrame_upv_1.Position
            local Magnitude_1 = (v13 - (LookVector_upv_1 * v13:Dot(LookVector_upv_1))).Magnitude
            local v14 = math.deg(math.acos(math.clamp(LookVector_upv_1:Dot(v13.Unit), -1, 1)))
            tbl_9.missStuds = Magnitude_1
            tbl_9.missDeg = v14
            tbl_9.dist = (value_2.point - CFrame_upv_1.Position).Magnitude
        end
        local victim_1 = value_2.victim
        local v14 = victim_1 and (a1.states[victim_1])
        if not (v14) then
            table.insert(tbl_upv_6.shots, tbl_9)
            continue
        end
        if v14.present then
            local v15 = v14.cf.Position + Vector3.new(0, 0.5, 0) - CFrame_upv_1.Position
            local Magnitude_2 = (v15 - (LookVector_upv_1 * v15:Dot(LookVector_upv_1))).Magnitude
            local v16 = math.deg(math.acos(math.clamp(LookVector_upv_1:Dot(v15.Unit), -1, 1)))
            tbl_9.victimMissStuds = Magnitude_2
            tbl_9.victimMissDeg = v16
            tbl_9.victim = a1.clip.fighters[victim_1].id
        end
        table.insert(tbl_upv_6.shots, tbl_9)
    end
    table.clear(tbl_upv_6.pending)
end
local function playAnim(a1, a2)
    --[[
      name: playAnim
      line: 188
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    local attacker_1 = a2.attacker
    local v17
    if type(attacker_1) == "table" and type(attacker_1.fighter) == "number" then
        v17 = attacker_1.fighter
    else
        v17 = nil
    end
    local v18 = v17 and (a1.puppets[v17])
    local Util_1 = tbl_upv_2.Util
    if not v18 or not Util_1 or not v18.alive or not v18.visible then
        return
    end
    if type(a2.name) == "string" then
        local v19 = tonumber(a2.speed) or 1
        if a2.op == "Play" then
            Util_1.PlayAnim(v18.animator, a2.name, v19, tonumber(a2.fade), (tonumber(a2.weight)))
        elseif a2.op == "Hold" then
            Util_1.PlayHold(v18.animator, a2.name, v19)
        elseif a2.op == "Stop" then
            Util_1.StopAnim(v18.animator, a2.name, (tonumber(a2.fade)))
        end
    end
end
local function resolveRefs(a1, a2)
    --[[
      name: resolveRefs
      line: 170
      upvalues:
        Puppets_upv_1 (copy, index: 1)
    ]]
    local v20 = nil
    local v21 = nil
    for key_1, value_3 in a2 do
        if type(value_3) ~= "table" then
            continue
        end
        local fighter_1 = value_3.fighter
        if type(fighter_1) ~= "number" then
            v20 = nil
        else
            v20 = a1.puppets[fighter_1]
        end
        if not (v20) then
            a2[key_1] = nil
            continue
        end
        if type(value_3.part) ~= "string" then
            v21 = v20.model
        else
            v21 = Puppets_upv_1.Part(v20, value_3.part)
        end
        a2[key_1] = v21
    end
end
local function dispatch(a1, a2)
    --[[
      name: dispatch
      line: 281
      upvalues:
        playAnim (copy, index: 1)
        tbl_upv_6 (ref,  index: 2)
        logAction (copy, index: 3)
        resolveRefs (copy, index: 4)
        Hud_upv_1 (copy, index: 5)
        Director_upv_1 (copy, index: 6)
        View_upv_1 (copy, index: 7)
        tbl_upv_2 (copy, index: 8)
        Combat_upv_1 (copy, index: 9)
    ]]
    local kind_1 = a2.kind
    local data_1 = a2.data
    local stats_1 = a1.stats
    stats_1.events = stats_1.events + 1
    a1.stats.kinds[kind_1] = (a1.stats.kinds[kind_1] or 0) + 1
    if kind_1 == "Phase" then
        return
    end
    if kind_1 ~= "Anim" then
        local v22 = data_1.killer
        local v23 = data_1.target
        if type(v23) == "table" and type(v23.fighter) == "number" then
            v22 = v23.fighter
        else
            v22 = nil
        end
        local v24 = data_1.shooter
        if type(v24) == "table" and type(v24.fighter) == "number" then
            v23 = v24.fighter
        else
            v23 = nil
        end
        local v25 = data_1.attacker
        if type(v25) == "table" and type(v25.fighter) == "number" then
            v24 = v25.fighter
        else
            v24 = nil
        end
        local v26 = data_1.fighter
        if type(v26) == "table" and type(v26.fighter) == "number" then
            v25 = v26.fighter
        else
            v25 = nil
        end
        local v27 = data_1.victim
        if type(v27) == "table" and type(v27.fighter) == "number" then
            v26 = v27.fighter
        else
            v26 = nil
        end
        if tbl_upv_6 then
            logAction(a1, kind_1, data_1, a2.t, v23, v24, v26)
        end
        if kind_1 == "Projectile" and v23 == a1.focus and a1.phase == "play" and typeof(data_1.origin) == "Vector3" and typeof(data_1.velocity) == "Vector3" and data_1.velocity.Magnitude > 0.1 then
            v27 = tostring(data_1.key)
            local v28 = a1.landed[v27] or (a1.landed[v27 .. "/1"])
            if v28 then
                v27 = math.clamp((v28 - data_1.origin).Magnitude, 8, 400)
            else
                v27 = 80
            end
            a1.diagShot = data_1.origin + (data_1.velocity.Unit * v27)
        end
        resolveRefs(a1, data_1)
        if kind_1 ~= "Inv" then
            if kind_1 ~= "Damage" then
                if kind_1 == "Hit" then
                    v26 = data_1.target
                elseif kind_1 ~= "ProjectileHit" then
                    v26 = nil
                else
                    v26 = data_1.character
                end
                if typeof(v26) == "Instance" and typeof(data_1.position) == "Vector3" then
                    v25 = v26:FindFirstChild("HumanoidRootPart")
                    if v25 and v25:IsA("BasePart") then
                        local v29 = data_1.position - v25.Position
                        local v30 = math.max(0, Vector3.new(v29.X, 0, v29.Z).Magnitude - 1.5)
                        local stats_2 = a1.stats
                        stats_2.hits = stats_2.hits + 1
                        local stats_3 = a1.stats
                        stats_3.hitErrSum = stats_3.hitErrSum + v30
                        a1.stats.hitErrMax = math.max(a1.stats.hitErrMax, v30)
                    end
                end
                if kind_1 == "Projectile" or kind_1 == "ProjectileHit" then
                    data_1.key = "R|" .. tostring(data_1.key)
                end
                v26 = true
                if (v23 or v24) ~= a1.focus then
                    v26 = (kind_1 == "Heal") and (v22 == a1.focus)
                end
                v24 = tbl_upv_2.Controller
                if v26 and kind_1 == "Swing" and Director_upv_1.InFirstPerson() then
                    v23 = tbl_upv_2.Util
                    v22 = tbl_upv_2.Presentation
                    if v23 then
                        local v31 = nil
                        if v22 then
                            local success_4, v31 = pcall(v22.For, data_1.weaponId, Combat_upv_1.Kind(data_1.weaponId) or "Fists")
                            if success_4 and type(v31) == "table" then
                                local v32
                                if data_1.heavy == true then
                                    v32 = v31.heavySound or (v31.swingSound)
                                elseif data_1.lunge ~= true then
                                    v32 = v31.swingSound
                                else
                                    v32 = v31.lungeSound or (v31.swingSound)
                                end
                                pcall(v23.Sound, v32 or "Swing_Sword")
                            end
                        end
                    end
                elseif v24 and type(v24.PlayFX) == "function" then
                    v24.PlayFX(kind_1, data_1)
                end
                if v26 and (kind_1 == "Charge" or kind_1 == "Projectile" or kind_1 == "Swing" or kind_1 == "Reload" or kind_1 == "Use" or kind_1 == "Heal") then
                    View_upv_1.OnFighterEvent(kind_1, data_1, Hud_upv_1.ChargeAt(a2.t))
                    Hud_upv_1.OnFighterEvent(kind_1, data_1, a2.t)
                end
            else
                local fighters_1 = a1.clip.fighters
                if v24 == a1.focus and v26 ~= a1.focus then
                    local HitConfirm_1 = Hud_upv_1.HitConfirm
                    local v33 = not (v26) or not (fighters_1[v26]) or fighters_1[v26].id
                    HitConfirm_1(data_1, v33)
                    if data_1.killed == true then
                        Director_upv_1.OnKill()
                    end
                    return
                end
                if v26 == a1.focus then
                    local DamageTaken_1 = Hud_upv_1.DamageTaken
                    local v33 = not (v24) or not (fighters_1[v24]) or fighters_1[v24].id
                    DamageTaken_1(data_1, v33)
                    if data_1.damageType ~= "Burn" and data_1.damageType ~= "World" then
                        local Hurt_1 = View_upv_1.Hurt
                        local v34 = tonumber(data_1.amount) or 0
                        Hurt_1(v34, data_1.blocked == true)
                    end
                end
            end
        elseif v25 == a1.focus then
            Hud_upv_1.OnFighterEvent("Inv", data_1, a2.t)
        end
    else
        playAnim(a1, data_1)
    end
end
local function aimSegments(a1, a2)
    --[[
      name: aimSegments
      line: 446
    ]]
    local tbl_10 = {}
    local tbl_11 = {}
    local v35 = nil
    for _, value_4 in a1.events do
        if value_4.kind ~= "ProjectileHit" or typeof(value_4.data.position) ~= "Vector3" then
            continue
        end
        local str_2 = tostring(value_4.data.key)
        if tbl_10[str_2] then
            continue
        end
        tbl_10[str_2] = value_4.data.position
        local character_1 = value_4.data.character
        if type(character_1) ~= "table" or type(character_1.fighter) ~= "number" then
            v35 = nil
            if v35 then
                tbl_11[str_2] = v35
                continue
            end
        end
        v35 = character_1.fighter
        if v35 then
            tbl_11[str_2] = v35
        end
    end
    local tbl_12 = {}
    local v36 = nil
    local v37, v37 = nil, nil
    local v38 = nil
    local v39 = nil
    local _ = nil
    for v40, value_5 in a1.events do
        local data_2 = value_5.data
        if value_5.kind == "Charge" then
            v38 = data_2.attacker
            if type(v38) ~= "table" or type(v38.fighter) ~= "number" then
                v39 = nil
                if v39 ~= a2 then
                    if value_5.kind ~= "Projectile" then
                        continue
                    end
                    v38 = data_2.shooter
                    if type(v38) ~= "table" or type(v38.fighter) ~= "number" then
                        v37 = nil
                        if v37 ~= a2 or typeof(data_2.origin) ~= "Vector3" or typeof(data_2.velocity) ~= "Vector3" or not (data_2.velocity.Magnitude > 0.1) then
                            continue
                        end
                        v37 = tostring(data_2.key)
                        v38 = tbl_10[v37] or (tbl_10[v37 .. "/1"])
                        if v38 then
                            v37 = math.clamp((v38 - data_2.origin).Magnitude, 8, 400)
                        else
                            v37 = 80
                        end
                        if not (v36) then
                            v38 = v35.t - 0.45
                            table.insert(tbl_12, {t0 = v38 - 0.05, t1 = v35.t + 0.4, shot = v35.t, point = data_2.origin + (data_2.velocity.Unit * v37)})
                            v36 = nil
                            continue
                        end
                        if value_5.t - v36 < 2.5 then
                            v38, v35 = v36, value_5
                        else
                            v38 = v35.t - 0.45
                        end
                        table.insert(tbl_12, {t0 = v38 - 0.05, t1 = v35.t + 0.4, shot = v35.t, point = data_2.origin + (data_2.velocity.Unit * v37)})
                        v36 = nil
                    end
                    v37 = v38.fighter
                    if v37 ~= a2 or typeof(data_2.origin) ~= "Vector3" or typeof(data_2.velocity) ~= "Vector3" or not (data_2.velocity.Magnitude > 0.1) then
                        continue
                    end
                    v37 = tostring(data_2.key)
                    v38 = tbl_10[v37] or (tbl_10[v37 .. "/1"])
                    if v38 then
                        v37 = math.clamp((v38 - data_2.origin).Magnitude, 8, 400)
                    else
                        v37 = 80
                    end
                    if not (v36) then
                        v38 = v35.t - 0.45
                        table.insert(tbl_12, {t0 = v38 - 0.05, t1 = v35.t + 0.4, shot = v35.t, point = data_2.origin + (data_2.velocity.Unit * v37)})
                        v36 = nil
                        continue
                    end
                    if value_5.t - v36 < 2.5 then
                        v38, v35 = v36, value_5
                    else
                        v38 = v35.t - 0.45
                    end
                    table.insert(tbl_12, {t0 = v38 - 0.05, t1 = v35.t + 0.4, shot = v35.t, point = data_2.origin + (data_2.velocity.Unit * v37)})
                    v36 = nil
                else
                    if data_2.on ~= true then
                        v36 = nil
                    else
                        v36 = value_5.t
                    end
                    continue
                end
                continue
            end
            v39 = v38.fighter
            if v39 ~= a2 then
                if value_5.kind ~= "Projectile" then
                    continue
                end
                v38 = data_2.shooter
                if type(v38) ~= "table" or type(v38.fighter) ~= "number" then
                    v39 = nil
                    if v39 ~= a2 or typeof(data_2.origin) ~= "Vector3" or typeof(data_2.velocity) ~= "Vector3" or not (data_2.velocity.Magnitude > 0.1) then
                        continue
                    end
                    v39 = tostring(data_2.key)
                    v38 = tbl_10[v39] or (tbl_10[v39 .. "/1"])
                    if v38 then
                        v39 = math.clamp((v38 - data_2.origin).Magnitude, 8, 400)
                    else
                        v39 = 80
                    end
                    if not (v36) then
                        v38 = v35.t - 0.45
                        table.insert(tbl_12, {t0 = v38 - 0.05, t1 = v35.t + 0.4, shot = v35.t, point = data_2.origin + (data_2.velocity.Unit * v39)})
                        v36 = nil
                        continue
                    end
                    if value_5.t - v36 < 2.5 then
                        v38, v35 = v36, value_5
                    else
                        v38 = v35.t - 0.45
                    end
                    table.insert(tbl_12, {t0 = v38 - 0.05, t1 = v35.t + 0.4, shot = v35.t, point = data_2.origin + (data_2.velocity.Unit * v39)})
                    v36 = nil
                end
                v39 = v38.fighter
                if v39 ~= a2 or typeof(data_2.origin) ~= "Vector3" or typeof(data_2.velocity) ~= "Vector3" or not (data_2.velocity.Magnitude > 0.1) then
                    continue
                end
                v39 = tostring(data_2.key)
                v38 = tbl_10[v39] or (tbl_10[v39 .. "/1"])
                if v38 then
                    v39 = math.clamp((v38 - data_2.origin).Magnitude, 8, 400)
                else
                    v39 = 80
                end
                if not (v36) then
                    v38 = v35.t - 0.45
                    table.insert(tbl_12, {t0 = v38 - 0.05, t1 = v35.t + 0.4, shot = v35.t, point = data_2.origin + (data_2.velocity.Unit * v39)})
                    v36 = nil
                    continue
                end
                if value_5.t - v36 < 2.5 then
                    v38, v35 = v36, value_5
                else
                    v38 = v35.t - 0.45
                end
                table.insert(tbl_12, {t0 = v38 - 0.05, t1 = v35.t + 0.4, shot = v35.t, point = data_2.origin + (data_2.velocity.Unit * v39)})
                v36 = nil
            elseif data_2.on ~= true then
                v36 = nil
            else
                v36 = value_5.t
            end
        elseif value_5.kind == "Projectile" then
            v38 = data_2.shooter
            if type(v38) ~= "table" or type(v38.fighter) ~= "number" then
                v37 = nil
                if v37 ~= a2 or typeof(data_2.origin) ~= "Vector3" or typeof(data_2.velocity) ~= "Vector3" or not (data_2.velocity.Magnitude > 0.1) then
                    continue
                end
                v39 = tostring(data_2.key)
                v38 = tbl_10[v39] or (tbl_10[v39 .. "/1"])
                if v38 then
                    v39 = math.clamp((v38 - data_2.origin).Magnitude, 8, 400)
                else
                    v39 = 80
                end
                if not (v36) then
                    v38 = v35.t - 0.45
                    table.insert(tbl_12, {t0 = v38 - 0.05, t1 = v35.t + 0.4, shot = v35.t, point = data_2.origin + (data_2.velocity.Unit * v39)})
                    v36 = nil
                    continue
                end
                if value_5.t - v36 < 2.5 then
                    v38, v35 = v36, value_5
                else
                    v38 = v35.t - 0.45
                end
                table.insert(tbl_12, {t0 = v38 - 0.05, t1 = v35.t + 0.4, shot = v35.t, point = data_2.origin + (data_2.velocity.Unit * v39)})
                v36 = nil
            end
            v37 = v38.fighter
            if v37 ~= a2 or typeof(data_2.origin) ~= "Vector3" or typeof(data_2.velocity) ~= "Vector3" or not (data_2.velocity.Magnitude > 0.1) then
                continue
            end
            v39 = tostring(data_2.key)
            v38 = tbl_10[v39] or (tbl_10[v39 .. "/1"])
            if v38 then
                v39 = math.clamp((v38 - data_2.origin).Magnitude, 8, 400)
            else
                v39 = 80
            end
            if not (v36) then
                v38 = v35.t - 0.45
                table.insert(tbl_12, {t0 = v38 - 0.05, t1 = v35.t + 0.4, shot = v35.t, point = data_2.origin + (data_2.velocity.Unit * v39)})
                v36 = nil
                continue
            end
            if value_5.t - v36 < 2.5 then
                v38, v35 = v36, value_5
            else
                v38 = v35.t - 0.45
            end
            table.insert(tbl_12, {t0 = v38 - 0.05, t1 = v35.t + 0.4, shot = v35.t, point = data_2.origin + (data_2.velocity.Unit * v39)})
            v36 = nil
        end
    end
    return tbl_12, tbl_10, tbl_11
end
local function fallPose(a1, a2)
    --[[
      name: fallPose
      line: 507
    ]]
    local fall_1 = a1.fall
    local v40 = math.clamp((a2 - fall_1.at) / 0.45, 0, 1)
    local pivot_1 = fall_1.pivot
    return (CFrame.new(pivot_1) * CFrame.fromAxisAngle(fall_1.axis, ((v40 * v40) * math.pi) / 2)) * CFrame.new(-pivot_1) * fall_1.stand
end
local function startFall(a1, a2, a3, a4)
    --[[
      name: startFall
      line: 488
      upvalues:
        Workspace_upv_1 (copy, index: 1)
    ]]
    local cf_1 = a3.cf
    local v41 = Vector3.new(a3.vel.X, 0, a3.vel.Z)
    local v42 = Vector3.new(cf_1.LookVector.X, 0, cf_1.LookVector.Z)
    local v43 = ((not (v42.Magnitude > 0.05)) and Vector3.new(0, 0, -1)) or (v42.Unit)
    local v44
    if v41.Magnitude > 3 then
        v44 = v41.Unit
    else
        v44 = -v43
    end
    local v45 = a2.hum.HipHeight + a2.root.Size.Y / 2
    local v46 = Workspace_upv_1:Raycast(cf_1.Position + Vector3.new(0, 1, 0), Vector3.new(0, -(v45 + 8), 0), a1.params)
    local v47 = Vector3.new(cf_1.Position.X, ((not v46) and (cf_1.Position.Y - v45)) or (v46.Position.Y), cf_1.Position.Z)
    local v48 = CFrame.lookAt(v47 + Vector3.new(0, v45, 0), (v47 + Vector3.new(0, v45, 0)) + v43)
    local tbl_13 = {at = 0, stand = 0, pivot = 0, axis = 0}
    local v49
    if a4 <= 0.05 then
        v49 = -10
    else
        v49 = a4
    end
    tbl_13.at = v49
    tbl_13.stand = v48
    tbl_13.pivot = v47 + Vector3.new(0, 0.550000011920929, 0)
    tbl_13.axis = (Vector3.new(0, 1, 0)):Cross(v44).Unit
    a2.fall = tbl_13
end
local function setItem(a1, a2)
    --[[
      name: setItem
      line: 136
      upvalues:
        Puppets_upv_1 (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
        holdFor (copy, index: 3)
    ]]
    local hold_1 = a1.hold
    if not Puppets_upv_1.SetItem(a1, a2) then
        return
    end
    local Util_2 = tbl_upv_2.Util
    local v50 = holdFor(a2)
    if Util_2 and hold_1 and hold_1 ~= v50 then
        Util_2.StopAnim(a1.animator, hold_1, 0.15)
    end
    if Util_2 and v50 and a1.alive then
        local v51 = Util_2.GetTrack(a1.animator, v50)
        if v51 and not (v51.IsPlaying) then
            Util_2.PlayAnim(a1.animator, v50, 1, 0.2)
        end
    end
    a1.hold = v50
end
local u4 = nil
local u5 = false
local u6 = 1
local function clipTime(a1)
    --[[
      name: clipTime
      line: 564
      upvalues:
        u6 (ref, index: 1)
        u4 (ref, index: 2)
        u5 (ref, index: 3)
    ]]
    if a1.phase ~= "play" then
        if a1.phase ~= "intro" then
            return a1.lastT
        end
        return 0
    else
        local v52 = (os.clock() - a1.t0) * u6
        local startTime_1 = a1.payload.startTime
        if u4 and type(startTime_1) == "number" and u4 - startTime_1 <= v52 then
            if not (u5) then
                u5 = true
                for _, value_6 in a1.puppets do
                    for v53, value_7 in value_6.animator:GetPlayingAnimationTracks() do
                        value_7:AdjustSpeed(0)
                    end
                end
            end
            a1.t0 = os.clock() - ((u4 - startTime_1) / u6)
            return u4 - startTime_1
        end
        return v52
    end
end
local u7 = nil
local function applyState(a1, a2, a3, a4, a5)
    --[[
      name: applyState
      line: 514
      upvalues:
        ReplayCodec_upv_1 (copy, index: 1)
        Puppets_upv_1 (copy, index: 2)
        tbl_upv_4 (copy, index: 3)
        tbl_upv_5 (copy, index: 4)
        fallPose (copy, index: 5)
        onPuppetDied (copy, index: 6)
        startFall (copy, index: 7)
        setItem (copy, index: 8)
        tbl_upv_2 (copy, index: 9)
    ]]
    local v53 = not a3.present or (not bit32.btest(a3.flags, ReplayCodec_upv_1.F_ALIVE))
    if a2.fall and v53 then
        Puppets_upv_1.SetVisible(a2, true)
        a4 = a4 + 1
        tbl_upv_4[a4] = a2.root
        tbl_upv_5[a4] = fallPose(a2, a5)
        return a4
    end
    if a3.present then
        Puppets_upv_1.SetVisible(a2, true)
        local v54 = bit32.btest(a3.flags, ReplayCodec_upv_1.F_ALIVE)
        if v54 ~= a2.alive then
            a2.alive = v54
            if v54 then
                a2.fall = nil
            else
                onPuppetDied(a2)
                startFall(a1, a2, a3, a5)
            end
        end
        local v55 = a4 + 1
        tbl_upv_4[v55] = a2.root
        local v56
        if a2.fall then
            v56 = fallPose(a2, a5)
        else
            v56 = a3.cf
        end
        tbl_upv_5[v55] = v56
        if v54 then
            local v57
            if a3.item > 0 then
                v57 = a1.clip.items[a3.item]
            else
                v57 = nil
            end
            if v57 ~= a2.itemId then
                setItem(a2, v57)
            end
            local v58 = bit32.btest(a3.flags, ReplayCodec_upv_1.F_BLOCKING)
            if v58 ~= a2.blocking then
                a2.blocking = v58
                if tbl_upv_2.Guard then
                    pcall(tbl_upv_2.Guard.Set, a2.model, v58)
                end
            end
        end
        return v55
    end
    Puppets_upv_1.SetVisible(a2, false)
    return a4
end
local function diagInspect(a1)
    --[[
      name: diagInspect
      line: 589
      upvalues:
        Puppets_upv_1 (copy, index: 1)
        Diag_upv_1 (copy, index: 2)
    ]]
    return Puppets_upv_1.Inspect(a1, Diag_upv_1.FAR)
end
local function step(a1)
    --[[
      name: step
      line: 593
      upvalues:
        u2 (ref,  index: 1)
        u6 (ref,  index: 2)
        clipTime (copy, index: 3)
        dispatch (copy, index: 4)
        Clip_upv_1 (copy, index: 5)
        applyState (copy, index: 6)
        tbl_upv_4 (copy, index: 7)
        tbl_upv_5 (copy, index: 8)
        Hud_upv_1 (copy, index: 9)
        Workspace_upv_1 (copy, index: 10)
        u5 (ref,  index: 11)
        Locomotion_upv_1 (copy, index: 12)
        ReplayCodec_upv_1 (copy, index: 13)
        tbl_upv_2 (copy, index: 14)
        Stage_upv_1 (copy, index: 15)
        PoseTrace_upv_1 (copy, index: 16)
        Director_upv_1 (copy, index: 17)
        View_upv_1 (copy, index: 18)
        Diag_upv_1 (copy, index: 19)
        diagInspect (copy, index: 20)
        RunService_upv_1 (copy, index: 21)
        tbl_upv_6 (ref,  index: 22)
        logCamera (copy, index: 23)
        u7 (ref,  index: 24)
    ]]
    if not u2 then
        return
    end
    a1 = a1 * u6
    local v59 = os.clock()
    local clip_upv_1 = u2.clip
    local u8 = clipTime(u2)
    if u2.phase == "play" then
        u8 = math.min(u8, clip_upv_1.duration)
        local events_1 = clip_upv_1.events
        while u2.nextEvent <= #events_1 and (events_1[u2.nextEvent].t <= u8) do
            local v60 = events_1[u2.nextEvent]
            u2.nextEvent = u2.nextEvent + 1
            local success_5, v61 = pcall(dispatch, u2, v60)
            if success_5 then
                continue
            end
            local stats_4 = u2.stats
            stats_4.fxErrors = stats_4.fxErrors + 1
            if u2.stats.fxErrors <= 3 then
                warn("[Replay] event error:", v60.kind, v61)
            end
        end
    end
    local v62 = 0
    for key_2, value_8 in u2.puppets do
        local v63 = u2.states[key_2]
        Clip_upv_1.Sample(clip_upv_1, clip_upv_1.fighters[key_2], u8, v63)
        v62 = applyState(u2, value_8, v63, v62, u8)
    end
    for n_1 = v62 + 1, #tbl_upv_4 do
        tbl_upv_4[n_1] = nil
        tbl_upv_5[n_1] = nil
    end
    local v64 = nil
    local v66 = nil
    if u2.phase == "play" then
        v64 = u2.states[u2.focus]
        if v64 and v64.present then
            v66 = Hud_upv_1.Update
            local v65
            if v64.item > 0 then
                v65 = clip_upv_1.items[v64.item]
            else
                v65 = nil
            end
            v66(u8, v65, v64.hp, v64.armor, v64.flags)
        end
    end
    if v62 > 0 then
        Workspace_upv_1:BulkMoveTo(tbl_upv_4, tbl_upv_5, Enum.BulkMoveMode.FireCFrameChanged)
    end
    local locoAcc_1 = u2.locoAcc
    if u5 then
        v66 = 0
    else
        v66 = a1
    end
    u2.locoAcc = locoAcc_1 + v66
    if u2.locoAcc >= 0.03333333333333333 then
        v62 = math.min(u2.locoAcc, 0.1)
        u2.locoAcc = 0
        local v67 = os.clock()
        for key_3, value_9 in u2.puppets do
            local v68 = u2.states[key_3]
            if not (value_9.loco) then
                continue
            end
            if value_9.visible then
                Locomotion_upv_1.Step(value_9.loco, v62, v67, v68.vel, bit32.btest(v68.flags, ReplayCodec_upv_1.F_GROUNDED), bit32.btest(v68.flags, ReplayCodec_upv_1.F_SLIDING), value_9.alive)
            end
        end
    end
    local holdAcc_1 = u2.holdAcc
    if u5 then
        v66 = 0
    else
        v66 = a1
    end
    u2.holdAcc = holdAcc_1 + v66
    if u2.holdAcc >= 0.5 then
        u2.holdAcc = 0
        local Util_3 = tbl_upv_2.Util
        for _, value_10 in u2.puppets do
            if not (Util_3) or not (value_10.hold) or not (value_10.alive) or not (value_10.visible) then
                continue
            end
            local v69 = Util_3.GetTrack(value_10.animator, value_10.hold)
            if not (v69) then
                continue
            end
            if not (v69.IsPlaying) then
                Util_3.PlayAnim(value_10.animator, value_10.hold, 1, 0.2)
            end
        end
    end
    Stage_upv_1.Tick()
    local startTime_2 = u2.payload.startTime
    if u2.phase == "play" and type(startTime_2) == "number" and PoseTrace_upv_1.Active() then
        for _, value_11 in u2.puppets do
            if not (value_11.visible) then
                continue
            end
            if value_11.alive then
                PoseTrace_upv_1.Compare(value_11.id, value_11.model, startTime_2 + u8)
            end
        end
    end
    local v70 = u2.puppets[u2.focus]
    local v71 = u2.states[u2.focus]
    local CurrentCamera_1 = Workspace_upv_1.CurrentCamera
    if CurrentCamera_1.CameraType ~= Enum.CameraType.Scriptable then
        CurrentCamera_1.CameraType = Enum.CameraType.Scriptable
    end
    if v71 then
        local v72 = nil
        if v71.present then
            local Position_1 = v71.cf.Position
            local LookVector_2 = v71.cf.LookVector
            v72 = Vector3.new(LookVector_2.X, 0, LookVector_2.Z)
            local v73 = 0
            local v74 = u2.clip.fighters[u2.focus].team
            if v72.Magnitude > 0.1 then
                local Unit_1 = v72.Unit
                LookVector_2 = v73
                for key_4, value_12 in u2.puppets do
                    local v75 = u2.states[key_4]
                    if value_12.team == v74 or not (value_12.visible) or not (value_12.alive) or not (v75.present) then
                        continue
                    end
                    local Magnitude_3 = v75.cf.Position - Position_1
                    local v76 = Vector3.new(Magnitude_3.X, 0, Magnitude_3.Z)
                    Magnitude_3 = v76.Magnitude
                    if not (Magnitude_3 > 0.5) or not (Magnitude_3 < 16) then
                        continue
                    end
                    if v76.Unit:Dot(Unit_1) > 0.2 then
                        LookVector_2 = math.max(LookVector_2, math.clamp(1 - ((Magnitude_3 - 5) / 11), 0, 1))
                    end
                end
                v73 = LookVector_2
            end
            Director_upv_1.SetAction(v73)
            Director_upv_1.SetAimed((bit32.btest(v71.flags, ReplayCodec_upv_1.F_AIMING)))
            if v70 then
                v74 = v70.alive
            else
                v74 = bit32.btest(v71.flags, ReplayCodec_upv_1.F_ALIVE)
            end
            if v70 then
                v72 = v70.model
            else
                v72 = nil
            end
            local v77 = nil
            Director_upv_1.Update(CurrentCamera_1, v77, u8, v71.cf, v74, View_upv_1.Frame(v77, v71, v72, v74))
            local AfterCamera_1 = View_upv_1.AfterCamera
            local v78 = Director_upv_1.InFirstPerson()
            local v79
            if v71.item > 0 then
                v79 = clip_upv_1.items[v71.item]
            else
                v79 = nil
            end
            AfterCamera_1(v77, v71, v72, v74, v78, v79, Hud_upv_1.HeldCharges())
        else
            Director_upv_1.Update(CurrentCamera_1, a1, u8, nil, false)
            if v71 then
                View_upv_1.AfterCamera(a1, v71, nil, false, false, nil, nil)
            end
        end
    else
        Director_upv_1.Update(CurrentCamera_1, a1, u8, nil, false)
        if v71 then
            View_upv_1.AfterCamera(a1, v71, nil, false, false, nil, nil)
        end
    end
    local v80 = nil
    if u2.phase == "play" then
        v80 = u2.diagShot
        if v80 then
            u2.diagShot = nil
            pcall(Diag_upv_1.Shot, CurrentCamera_1, v80)
        end
        u2.diagAcc = u2.diagAcc + a1
        if u2.diagAcc >= 0.1 then
            u2.diagAcc = 0
            pcall(Diag_upv_1.Frame, u2, CurrentCamera_1)
        end
    end
    if u2.phase == "play" then
        local v81 = nil
        if u2.diagStage < 2 then
            v81 = ((u2.diagStage ~= 0) and (clip_upv_1.duration * 0.5)) or 1.5
            if v81 <= u8 then
                u2.diagStage = u2.diagStage + 1
                local Check_1 = Diag_upv_1.Check
                local v82 = ((u2.diagStage ~= 1) and "mid") or "early"
                local success_6, v83 = pcall(
                    Check_1,
                    v82,
                    u2,
                    Director_upv_1.InFirstPerson(),
                    diagInspect,
                    function(a2)
                        --[[
                          line: 730
                          upvalues:
                            Clip_upv_1 (copy, index: 1)
                            clip_upv_1 (copy, index: 2)
                            u8 (ref,  index: 3)
                            u2 (copy, index: 4)
                        ]]
                        Clip_upv_1.Sample(clip_upv_1, clip_upv_1.fighters[a2], u8, u2.states[a2])
                    end
                )
                if not (success_6) and RunService_upv_1:IsStudio() then
                    warn("[Replay] diag failed:", v83)
                end
            end
        end
    end
    if tbl_upv_6 then
        logCamera(u2, u8, CurrentCamera_1)
    end
    local v84 = os.clock() - v59
    local stats_5 = u2.stats
    stats_5.frames = stats_5.frames + 1
    local stats_6 = u2.stats
    stats_6.stepTime = stats_6.stepTime + v84
    u2.stats.maxStep = math.max(u2.stats.maxStep, v84)
    if u2.phase ~= "play" then
        return
    end
    if (clip_upv_1.duration <= u8) and not u5 then
        u7(u2)
    end
end
local function cleanup(a1)
    --[[
      name: cleanup
      line: 751
      upvalues:
        u2 (ref,  index: 1)
        u5 (ref,  index: 2)
        RunService_upv_1 (copy, index: 3)
        Overlay_upv_1 (copy, index: 4)
        tbl_upv_2 (copy, index: 5)
        Workspace_upv_1 (copy, index: 6)
        tbl_upv_3 (copy, index: 7)
        Puppets_upv_1 (copy, index: 8)
        View_upv_1 (copy, index: 9)
        Diag_upv_1 (copy, index: 10)
        Hud_upv_1 (copy, index: 11)
        Stage_upv_1 (copy, index: 12)
    ]]
    if u2 ~= a1 then
        return
    end
    u2 = nil
    u5 = false
    pcall(
        function()
            --[[
              line: 757
              upvalues:
                RunService_upv_1 (copy, index: 1)
            ]]
            RunService_upv_1:UnbindFromRenderStep("TribesReplay")
        end
    )
    Overlay_upv_1.UnbindSkip()
    local Effects_1 = tbl_upv_2.Effects
    if Effects_1 then
        Effects_1.ParamsOverride = nil
    end
    local FX_1 = Workspace_upv_1:FindFirstChild("FX")
    if FX_1 then
        local v85 = nil
        for _, value_13 in FX_1:GetDescendants() do
            if not (value_13:IsA("WeldConstraint")) or value_13.Name ~= "StickWeld" or not (value_13.Part0) or not (value_13.Part0:IsDescendantOf(a1.folder)) then
                continue
            end
            local v86 = value_13.Parent and (value_13.Parent.Parent)
            if (v86) and (v86:IsA("Model")) then
                v85 = v86
            else
                v85 = value_13.Parent
            end
            if not (v85) then
                value_13:Destroy()
                continue
            end
            for v87, value_14 in v85:GetDescendants() do
                if value_14:IsA("BasePart") then
                    value_14.Anchored = true
                    value_14.Transparency = 1
                end
            end
            if v85:IsA("BasePart") then
                v85.Anchored = true
                v85.Transparency = 1
            end
            value_13:Destroy()
        end
    end
    for _, value_15 in a1.puppets do
        if tbl_upv_2.Guard and value_15.blocking then
            pcall(tbl_upv_2.Guard.Set, value_15.model, false)
        end
        local Procedural_1 = tbl_upv_3.Procedural
        if (Procedural_1) and type(Procedural_1.Untrack) == "function" then
            pcall(Procedural_1.Untrack, value_15.model)
        end
        Puppets_upv_1.Destroy(value_15)
    end
    pcall(View_upv_1.End)
    pcall(Diag_upv_1.End)
    a1.folder:Destroy()
    pcall(Hud_upv_1.End)
    Stage_upv_1.Leave()
end
u7 = function(a1)
    --[[
      line: 805
      upvalues:
        u2 (ref,  index: 1)
        clipTime (copy, index: 2)
        Diag_upv_1 (copy, index: 3)
        Overlay_upv_1 (copy, index: 4)
        cleanup (copy, index: 5)
        ReplayCodec_upv_1 (copy, index: 6)
    ]]
    if u2 ~= a1 or a1.phase == "outro" then
        return
    end
    a1.lastT = clipTime(a1)
    a1.phase = "outro"
    pcall(Diag_upv_1.Flush)
    Overlay_upv_1.UnbindSkip()
    Overlay_upv_1.Outro(
        function()
            --[[
              line: 813
              upvalues:
                cleanup (copy, index: 1)
                a1 (copy, index: 2)
            ]]
            cleanup(a1)
        end,
        ReplayCodec_upv_1.OUTRO_TIME
    )
end
function tbl_upv_1.Skip()
    --[[
      name: Skip
      line: 818
      upvalues:
        u2 (ref, index: 1)
        u7 (ref, index: 2)
    ]]
    local v87 = u2
    if not v87 then
        return
    end
    u7(v87)
end
function tbl_upv_1.Stop(a1)
    --[[
      name: Stop
      line: 825
      upvalues:
        u2 (ref,  index: 1)
        Overlay_upv_1 (copy, index: 2)
        cleanup (copy, index: 3)
    ]]
    local v88 = u2
    if not v88 then
        return
    end
    Overlay_upv_1.Hide()
    cleanup(v88)
end
function tbl_upv_1.IsPlaying()
    --[[
      name: IsPlaying
      line: 835
      upvalues:
        u2 (ref, index: 1)
    ]]
    local v89 = u2 ~= nil
    return v89
end
local function outline(a1, a2)
    --[[
      name: outline
      line: 861
    ]]
    local v90 = Instance.new("Highlight")
    v90.Name = "ReplayOutline"
    v90.DepthMode = Enum.HighlightDepthMode.Occluded
    v90.FillTransparency = 1
    v90.OutlineTransparency = 0.35
    v90.OutlineColor = a2
    v90.Adornee = a1
    v90.Parent = a1
end
local function applyPreroll(a1)
    --[[
      name: applyPreroll
      line: 370
      upvalues:
        Hud_upv_1 (copy, index: 1)
        dispatch (copy, index: 2)
        tbl_upv_2 (copy, index: 3)
        Ballistics_upv_1 (copy, index: 4)
    ]]
    local events_2 = a1.clip.events
    local tbl_14 = {}
    for _, value_16 in events_2 do
        if value_16.kind ~= "ProjectileHit" then
            continue
        end
        local str_3 = tostring(value_16.data.key)
        if tbl_14[str_3] == nil then
            tbl_14[str_3] = value_16.t
        end
    end
    local tbl_15 = {}
    local Util_4 = 1
    local v91, v92, v93, v93, v93, v93, v93 = nil, nil, nil, nil, nil, nil, nil
    while Util_4 <= #events_2 do
        local v94, v95, v96, v97, v98, v99, v100, v101, v102 = nil, nil, nil, nil, nil, nil, nil, nil, nil
        if not (events_2[Util_4].t < 0) then
            break
        end
        v94 = events_2[Util_4]
        local data_3 = v94.data
        if v94.kind ~= "Anim" then
            if v94.kind == "Inv" then
                v101 = data_3.fighter
                if type(v101) ~= "table" or type(v101.fighter) ~= "number" then
                    v93 = nil
                    if v93 == a1.focus then
                        Hud_upv_1.OnFighterEvent("Inv", data_3, v94.t)
                        Util_4 = Util_4 + 1
                        continue
                    end
                    if v94.kind == "Charge" then
                        v100 = data_3.attacker
                        if type(v100) ~= "table" or type(v100.fighter) ~= "number" then
                            v93 = nil
                            if v93 == a1.focus then
                                Hud_upv_1.OnFighterEvent("Charge", data_3, v94.t)
                                Util_4 = Util_4 + 1
                                continue
                            end
                            if v94.kind == "Projectile" then
                                v99 = data_3.shooter
                                if type(v99) ~= "table" or type(v99.fighter) ~= "number" then
                                    v93 = nil
                                    if v93 == a1.focus then
                                        Hud_upv_1.OnFighterEvent("Charge", {on = false}, v94.t)
                                        Util_4 = Util_4 + 1
                                        continue
                                    end
                                    if v94.kind == "Swing" then
                                        v98 = data_3.attacker
                                        if type(v98) ~= "table" or type(v98.fighter) ~= "number" then
                                            v93 = nil
                                            if v93 == a1.focus then
                                                Hud_upv_1.OnFighterEvent("Charge", {on = false}, v94.t)
                                                Util_4 = Util_4 + 1
                                                continue
                                            end
                                            if v94.kind ~= "Smoke" then
                                                if v94.kind ~= "Status" or data_3.status ~= "Burn" then
                                                    if v94.kind ~= "Projectile" then
                                                        Util_4 = Util_4 + 1
                                                        continue
                                                    end
                                                    if not (v94.t > -2.5) then
                                                        Util_4 = Util_4 + 1
                                                        continue
                                                    end
                                                    if data_3.pellets then
                                                        Util_4 = Util_4 + 1
                                                        continue
                                                    end
                                                    v96 = tostring(data_3.key)
                                                    local v103 = tbl_14[v96]
                                                    local Effects_2 = tbl_upv_2.Effects
                                                    v95 = data_3.shooter
                                                    if type(v95) ~= "table" or type(v95.fighter) ~= "number" then
                                                        v91 = nil
                                                        if v103 ~= nil and not (v103 >= 0) or not (Effects_2) or typeof(data_3.origin) ~= "Vector3" or typeof(data_3.velocity) ~= "Vector3" or type(data_3.kind) ~= "string" then
                                                            Util_4 = Util_4 + 1
                                                            continue
                                                        end
                                                        v91 = tonumber(data_3.gravity) or 0
                                                        local v104 = Ballistics_upv_1.new(data_3.origin, data_3.velocity, v91, 0)
                                                        Ballistics_upv_1.Advance(v104, -v94.t)
                                                        local Projectile_1 = Effects_2.Projectile
                                                        local v105 = "R|" .. v96
                                                        local kind_2 = data_3.kind
                                                        local pos_1 = v104.pos
                                                        local vel_1 = v104.vel
                                                        if v91 then
                                                            v92 = v91.model
                                                        else
                                                            v92 = nil
                                                        end
                                                        pcall(Projectile_1, v105, kind_2, pos_1, vel_1, v91, v92)
                                                        Util_4 = Util_4 + 1
                                                    end
                                                    local _ = v95.fighter
                                                    if v103 ~= nil and not (v103 >= 0) or not (Effects_2) or typeof(data_3.origin) ~= "Vector3" or typeof(data_3.velocity) ~= "Vector3" or type(data_3.kind) ~= "string" then
                                                        Util_4 = Util_4 + 1
                                                        continue
                                                    end
                                                    v91 = tonumber(data_3.gravity) or 0
                                                    local v104 = Ballistics_upv_1.new(data_3.origin, data_3.velocity, v91, 0)
                                                    Ballistics_upv_1.Advance(v104, -v94.t)
                                                    local Projectile_1 = Effects_2.Projectile
                                                    local v105 = "R|" .. v96
                                                    local kind_2 = data_3.kind
                                                    local pos_1 = v104.pos
                                                    local vel_1 = v104.vel
                                                    if v91 then
                                                        v92 = v91.model
                                                    else
                                                        v92 = nil
                                                    end
                                                    pcall(Projectile_1, v105, kind_2, pos_1, vel_1, v91, v92)
                                                    Util_4 = Util_4 + 1
                                                end
                                                v96 = (tonumber(data_3.duration) or 1) + v94.t
                                                if v96 > 0.2 then
                                                    data_3.duration = v96
                                                    dispatch(a1, v94)
                                                end
                                            else
                                                v97 = (tonumber(data_3.duration) or 7) + v94.t
                                                if v97 > 0.4 then
                                                    data_3.duration = v97
                                                    dispatch(a1, v94)
                                                end
                                            end
                                            Util_4 = Util_4 + 1
                                            continue
                                        end
                                        v93 = v98.fighter
                                        if v93 == a1.focus then
                                            Hud_upv_1.OnFighterEvent("Charge", {on = false}, v94.t)
                                            Util_4 = Util_4 + 1
                                            continue
                                        end
                                    end
                                    if v94.kind ~= "Smoke" then
                                        if v94.kind ~= "Status" or data_3.status ~= "Burn" then
                                            if v94.kind ~= "Projectile" then
                                                Util_4 = Util_4 + 1
                                                continue
                                            end
                                            if not (v94.t > -2.5) then
                                                Util_4 = Util_4 + 1
                                                continue
                                            end
                                            if data_3.pellets then
                                                Util_4 = Util_4 + 1
                                                continue
                                            end
                                            v96 = tostring(data_3.key)
                                            local v103 = tbl_14[v96]
                                            local Effects_2 = tbl_upv_2.Effects
                                            v95 = data_3.shooter
                                            if type(v95) ~= "table" or type(v95.fighter) ~= "number" then
                                                v91 = nil
                                                if v103 ~= nil and not (v103 >= 0) or not (Effects_2) or typeof(data_3.origin) ~= "Vector3" or typeof(data_3.velocity) ~= "Vector3" or type(data_3.kind) ~= "string" then
                                                    Util_4 = Util_4 + 1
                                                    continue
                                                end
                                                v91 = tonumber(data_3.gravity) or 0
                                                local v104 = Ballistics_upv_1.new(data_3.origin, data_3.velocity, v91, 0)
                                                Ballistics_upv_1.Advance(v104, -v94.t)
                                                local Projectile_1 = Effects_2.Projectile
                                                local v105 = "R|" .. v96
                                                local kind_2 = data_3.kind
                                                local pos_1 = v104.pos
                                                local vel_1 = v104.vel
                                                if v91 then
                                                    v92 = v91.model
                                                else
                                                    v92 = nil
                                                end
                                                pcall(Projectile_1, v105, kind_2, pos_1, vel_1, v91, v92)
                                                Util_4 = Util_4 + 1
                                            end
                                            local _ = v95.fighter
                                            if v103 ~= nil and not (v103 >= 0) or not (Effects_2) or typeof(data_3.origin) ~= "Vector3" or typeof(data_3.velocity) ~= "Vector3" or type(data_3.kind) ~= "string" then
                                                Util_4 = Util_4 + 1
                                                continue
                                            end
                                            v91 = tonumber(data_3.gravity) or 0
                                            local v104 = Ballistics_upv_1.new(data_3.origin, data_3.velocity, v91, 0)
                                            Ballistics_upv_1.Advance(v104, -v94.t)
                                            local Projectile_1 = Effects_2.Projectile
                                            local v105 = "R|" .. v96
                                            local kind_2 = data_3.kind
                                            local pos_1 = v104.pos
                                            local vel_1 = v104.vel
                                            if v91 then
                                                v92 = v91.model
                                            else
                                                v92 = nil
                                            end
                                            pcall(Projectile_1, v105, kind_2, pos_1, vel_1, v91, v92)
                                            Util_4 = Util_4 + 1
                                        end
                                        v96 = (tonumber(data_3.duration) or 1) + v94.t
                                        if v96 > 0.2 then
                                            data_3.duration = v96
                                            dispatch(a1, v94)
                                        end
                                    else
                                        v97 = (tonumber(data_3.duration) or 7) + v94.t
                                        if v97 > 0.4 then
                                            data_3.duration = v97
                                            dispatch(a1, v94)
                                        end
                                    end
                                    Util_4 = Util_4 + 1
                                    continue
                                end
                                v93 = v99.fighter
                                if v93 == a1.focus then
                                    Hud_upv_1.OnFighterEvent("Charge", {on = false}, v94.t)
                                    Util_4 = Util_4 + 1
                                    continue
                                end
                            end
                            if v94.kind == "Swing" then
                                v98 = data_3.attacker
                                if type(v98) ~= "table" or type(v98.fighter) ~= "number" then
                                    v93 = nil
                                    if v93 == a1.focus then
                                        Hud_upv_1.OnFighterEvent("Charge", {on = false}, v94.t)
                                        Util_4 = Util_4 + 1
                                        continue
                                    end
                                    if v94.kind ~= "Smoke" then
                                        if v94.kind ~= "Status" or data_3.status ~= "Burn" then
                                            if v94.kind ~= "Projectile" then
                                                Util_4 = Util_4 + 1
                                                continue
                                            end
                                            if not (v94.t > -2.5) then
                                                Util_4 = Util_4 + 1
                                                continue
                                            end
                                            if data_3.pellets then
                                                Util_4 = Util_4 + 1
                                                continue
                                            end
                                            v96 = tostring(data_3.key)
                                            local v103 = tbl_14[v96]
                                            local Effects_2 = tbl_upv_2.Effects
                                            v95 = data_3.shooter
                                            if type(v95) ~= "table" or type(v95.fighter) ~= "number" then
                                                v91 = nil
                                                if v103 ~= nil and not (v103 >= 0) or not (Effects_2) or typeof(data_3.origin) ~= "Vector3" or typeof(data_3.velocity) ~= "Vector3" or type(data_3.kind) ~= "string" then
                                                    Util_4 = Util_4 + 1
                                                    continue
                                                end
                                                v91 = tonumber(data_3.gravity) or 0
                                                local v104 = Ballistics_upv_1.new(data_3.origin, data_3.velocity, v91, 0)
                                                Ballistics_upv_1.Advance(v104, -v94.t)
                                                local Projectile_1 = Effects_2.Projectile
                                                local v105 = "R|" .. v96
                                                local kind_2 = data_3.kind
                                                local pos_1 = v104.pos
                                                local vel_1 = v104.vel
                                                if v91 then
                                                    v92 = v91.model
                                                else
                                                    v92 = nil
                                                end
                                                pcall(Projectile_1, v105, kind_2, pos_1, vel_1, v91, v92)
                                                Util_4 = Util_4 + 1
                                            end
                                            local _ = v95.fighter
                                            if v103 ~= nil and not (v103 >= 0) or not (Effects_2) or typeof(data_3.origin) ~= "Vector3" or typeof(data_3.velocity) ~= "Vector3" or type(data_3.kind) ~= "string" then
                                                Util_4 = Util_4 + 1
                                                continue
                                            end
                                            v91 = tonumber(data_3.gravity) or 0
                                            local v104 = Ballistics_upv_1.new(data_3.origin, data_3.velocity, v91, 0)
                                            Ballistics_upv_1.Advance(v104, -v94.t)
                                            local Projectile_1 = Effects_2.Projectile
                                            local v105 = "R|" .. v96
                                            local kind_2 = data_3.kind
                                            local pos_1 = v104.pos
                                            local vel_1 = v104.vel
                                            if v91 then
                                                v92 = v91.model
                                            else
                                                v92 = nil
                                            end
                                            pcall(Projectile_1, v105, kind_2, pos_1, vel_1, v91, v92)
                                            Util_4 = Util_4 + 1
                                        end
                                        v96 = (tonumber(data_3.duration) or 1) + v94.t
                                        if v96 > 0.2 then
                                            data_3.duration = v96
                                            dispatch(a1, v94)
                                        end
                                    else
                                        v97 = (tonumber(data_3.duration) or 7) + v94.t
                                        if v97 > 0.4 then
                                            data_3.duration = v97
                                            dispatch(a1, v94)
                                        end
                                    end
                                    Util_4 = Util_4 + 1
                                    continue
                                end
                                v93 = v98.fighter
                                if v93 == a1.focus then
                                    Hud_upv_1.OnFighterEvent("Charge", {on = false}, v94.t)
                                    Util_4 = Util_4 + 1
                                    continue
                                end
                            end
                            if v94.kind ~= "Smoke" then
                                if v94.kind ~= "Status" or data_3.status ~= "Burn" then
                                    if v94.kind ~= "Projectile" then
                                        Util_4 = Util_4 + 1
                                        continue
                                    end
                                    if not (v94.t > -2.5) then
                                        Util_4 = Util_4 + 1
                                        continue
                                    end
                                    if data_3.pellets then
                                        Util_4 = Util_4 + 1
                                        continue
                                    end
                                    v96 = tostring(data_3.key)
                                    local v103 = tbl_14[v96]
                                    local Effects_2 = tbl_upv_2.Effects
                                    v95 = data_3.shooter
                                    if type(v95) ~= "table" or type(v95.fighter) ~= "number" then
                                        v91 = nil
                                        if v103 ~= nil and not (v103 >= 0) or not (Effects_2) or typeof(data_3.origin) ~= "Vector3" or typeof(data_3.velocity) ~= "Vector3" or type(data_3.kind) ~= "string" then
                                            Util_4 = Util_4 + 1
                                            continue
                                        end
                                        v91 = tonumber(data_3.gravity) or 0
                                        local v104 = Ballistics_upv_1.new(data_3.origin, data_3.velocity, v91, 0)
                                        Ballistics_upv_1.Advance(v104, -v94.t)
                                        local Projectile_1 = Effects_2.Projectile
                                        local v105 = "R|" .. v96
                                        local kind_2 = data_3.kind
                                        local pos_1 = v104.pos
                                        local vel_1 = v104.vel
                                        if v91 then
                                            v92 = v91.model
                                        else
                                            v92 = nil
                                        end
                                        pcall(Projectile_1, v105, kind_2, pos_1, vel_1, v91, v92)
                                        Util_4 = Util_4 + 1
                                    end
                                    local _ = v95.fighter
                                    if v103 ~= nil and not (v103 >= 0) or not (Effects_2) or typeof(data_3.origin) ~= "Vector3" or typeof(data_3.velocity) ~= "Vector3" or type(data_3.kind) ~= "string" then
                                        Util_4 = Util_4 + 1
                                        continue
                                    end
                                    v91 = tonumber(data_3.gravity) or 0
                                    local v104 = Ballistics_upv_1.new(data_3.origin, data_3.velocity, v91, 0)
                                    Ballistics_upv_1.Advance(v104, -v94.t)
                                    local Projectile_1 = Effects_2.Projectile
                                    local v105 = "R|" .. v96
                                    local kind_2 = data_3.kind
                                    local pos_1 = v104.pos
                                    local vel_1 = v104.vel
                                    if v91 then
                                        v92 = v91.model
                                    else
                                        v92 = nil
                                    end
                                    pcall(Projectile_1, v105, kind_2, pos_1, vel_1, v91, v92)
                                    Util_4 = Util_4 + 1
                                end
                                v96 = (tonumber(data_3.duration) or 1) + v94.t
                                if v96 > 0.2 then
                                    data_3.duration = v96
                                    dispatch(a1, v94)
                                end
                            else
                                v97 = (tonumber(data_3.duration) or 7) + v94.t
                                if v97 > 0.4 then
                                    data_3.duration = v97
                                    dispatch(a1, v94)
                                end
                            end
                            Util_4 = Util_4 + 1
                            continue
                        end
                        v93 = v100.fighter
                        if v93 == a1.focus then
                            Hud_upv_1.OnFighterEvent("Charge", data_3, v94.t)
                            Util_4 = Util_4 + 1
                            continue
                        end
                    end
                    if v94.kind == "Projectile" then
                        v99 = data_3.shooter
                        if type(v99) ~= "table" or type(v99.fighter) ~= "number" then
                            v93 = nil
                            if v93 == a1.focus then
                                Hud_upv_1.OnFighterEvent("Charge", {on = false}, v94.t)
                                Util_4 = Util_4 + 1
                                continue
                            end
                            if v94.kind == "Swing" then
                                v98 = data_3.attacker
                                if type(v98) ~= "table" or type(v98.fighter) ~= "number" then
                                    v93 = nil
                                    if v93 == a1.focus then
                                        Hud_upv_1.OnFighterEvent("Charge", {on = false}, v94.t)
                                        Util_4 = Util_4 + 1
                                        continue
                                    end
                                    if v94.kind ~= "Smoke" then
                                        if v94.kind ~= "Status" or data_3.status ~= "Burn" then
                                            if v94.kind ~= "Projectile" then
                                                Util_4 = Util_4 + 1
                                                continue
                                            end
                                            if not (v94.t > -2.5) then
                                                Util_4 = Util_4 + 1
                                                continue
                                            end
                                            if data_3.pellets then
                                                Util_4 = Util_4 + 1
                                                continue
                                            end
                                            v96 = tostring(data_3.key)
                                            local v103 = tbl_14[v96]
                                            local Effects_2 = tbl_upv_2.Effects
                                            v95 = data_3.shooter
                                            if type(v95) ~= "table" or type(v95.fighter) ~= "number" then
                                                v91 = nil
                                                if v103 ~= nil and not (v103 >= 0) or not (Effects_2) or typeof(data_3.origin) ~= "Vector3" or typeof(data_3.velocity) ~= "Vector3" or type(data_3.kind) ~= "string" then
                                                    Util_4 = Util_4 + 1
                                                    continue
                                                end
                                                v91 = tonumber(data_3.gravity) or 0
                                                local v104 = Ballistics_upv_1.new(data_3.origin, data_3.velocity, v91, 0)
                                                Ballistics_upv_1.Advance(v104, -v94.t)
                                                local Projectile_1 = Effects_2.Projectile
                                                local v105 = "R|" .. v96
                                                local kind_2 = data_3.kind
                                                local pos_1 = v104.pos
                                                local vel_1 = v104.vel
                                                if v91 then
                                                    v92 = v91.model
                                                else
                                                    v92 = nil
                                                end
                                                pcall(Projectile_1, v105, kind_2, pos_1, vel_1, v91, v92)
                                                Util_4 = Util_4 + 1
                                            end
                                            local _ = v95.fighter
                                            if v103 ~= nil and not (v103 >= 0) or not (Effects_2) or typeof(data_3.origin) ~= "Vector3" or typeof(data_3.velocity) ~= "Vector3" or type(data_3.kind) ~= "string" then
                                                Util_4 = Util_4 + 1
                                                continue
                                            end
                                            v91 = tonumber(data_3.gravity) or 0
                                            local v104 = Ballistics_upv_1.new(data_3.origin, data_3.velocity, v91, 0)
                                            Ballistics_upv_1.Advance(v104, -v94.t)
                                            local Projectile_1 = Effects_2.Projectile
                                            local v105 = "R|" .. v96
                                            local kind_2 = data_3.kind
                                            local pos_1 = v104.pos
                                            local vel_1 = v104.vel
                                            if v91 then
                                                v92 = v91.model
                                            else
                                                v92 = nil
                                            end
                                            pcall(Projectile_1, v105, kind_2, pos_1, vel_1, v91, v92)
                                            Util_4 = Util_4 + 1
                                        end
                                        v96 = (tonumber(data_3.duration) or 1) + v94.t
                                        if v96 > 0.2 then
                                            data_3.duration = v96
                                            dispatch(a1, v94)
                                        end
                                    else
                                        v97 = (tonumber(data_3.duration) or 7) + v94.t
                                        if v97 > 0.4 then
                                            data_3.duration = v97
                                            dispatch(a1, v94)
                                        end
                                    end
                                    Util_4 = Util_4 + 1
                                    continue
                                end
                                v93 = v98.fighter
                                if v93 == a1.focus then
                                    Hud_upv_1.OnFighterEvent("Charge", {on = false}, v94.t)
                                    Util_4 = Util_4 + 1
                                    continue
                                end
                            end
                            if v94.kind ~= "Smoke" then
                                if v94.kind ~= "Status" or data_3.status ~= "Burn" then
                                    if v94.kind ~= "Projectile" then
                                        Util_4 = Util_4 + 1
                                        continue
                                    end
                                    if not (v94.t > -2.5) then
                                        Util_4 = Util_4 + 1
                                        continue
                                    end
                                    if data_3.pellets then
                                        Util_4 = Util_4 + 1
                                        continue
                                    end
                                    v96 = tostring(data_3.key)
                                    local v103 = tbl_14[v96]
                                    local Effects_2 = tbl_upv_2.Effects
                                    v95 = data_3.shooter
                                    if type(v95) ~= "table" or type(v95.fighter) ~= "number" then
                                        v91 = nil
                                        if v103 ~= nil and not (v103 >= 0) or not (Effects_2) or typeof(data_3.origin) ~= "Vector3" or typeof(data_3.velocity) ~= "Vector3" or type(data_3.kind) ~= "string" then
                                            Util_4 = Util_4 + 1
                                            continue
                                        end
                                        v91 = tonumber(data_3.gravity) or 0
                                        local v104 = Ballistics_upv_1.new(data_3.origin, data_3.velocity, v91, 0)
                                        Ballistics_upv_1.Advance(v104, -v94.t)
                                        local Projectile_1 = Effects_2.Projectile
                                        local v105 = "R|" .. v96
                                        local kind_2 = data_3.kind
                                        local pos_1 = v104.pos
                                        local vel_1 = v104.vel
                                        if v91 then
                                            v92 = v91.model
                                        else
                                            v92 = nil
                                        end
                                        pcall(Projectile_1, v105, kind_2, pos_1, vel_1, v91, v92)
                                        Util_4 = Util_4 + 1
                                    end
                                    local _ = v95.fighter
                                    if v103 ~= nil and not (v103 >= 0) or not (Effects_2) or typeof(data_3.origin) ~= "Vector3" or typeof(data_3.velocity) ~= "Vector3" or type(data_3.kind) ~= "string" then
                                        Util_4 = Util_4 + 1
                                        continue
                                    end
                                    v91 = tonumber(data_3.gravity) or 0
                                    local v104 = Ballistics_upv_1.new(data_3.origin, data_3.velocity, v91, 0)
                                    Ballistics_upv_1.Advance(v104, -v94.t)
                                    local Projectile_1 = Effects_2.Projectile
                                    local v105 = "R|" .. v96
                                    local kind_2 = data_3.kind
                                    local pos_1 = v104.pos
                                    local vel_1 = v104.vel
                                    if v91 then
                                        v92 = v91.model
                                    else
                                        v92 = nil
                                    end
                                    pcall(Projectile_1, v105, kind_2, pos_1, vel_1, v91, v92)
                                    Util_4 = Util_4 + 1
                                end
                                v96 = (tonumber(data_3.duration) or 1) + v94.t
                                if v96 > 0.2 then
                                    data_3.duration = v96
                                    dispatch(a1, v94)
                                end
                            else
                                v97 = (tonumber(data_3.duration) or 7) + v94.t
                                if v97 > 0.4 then
                                    data_3.duration = v97
                                    dispatch(a1, v94)
                                end
                            end
                            Util_4 = Util_4 + 1
                            continue
                        end
                        v93 = v99.fighter
                        if v93 == a1.focus then
                            Hud_upv_1.OnFighterEvent("Charge", {on = false}, v94.t)
                            Util_4 = Util_4 + 1
                            continue
                        end
                    end
                    if v94.kind == "Swing" then
                        v98 = data_3.attacker
                        if type(v98) ~= "table" or type(v98.fighter) ~= "number" then
                            v93 = nil
                            if v93 == a1.focus then
                                Hud_upv_1.OnFighterEvent("Charge", {on = false}, v94.t)
                                Util_4 = Util_4 + 1
                                continue
                            end
                            if v94.kind ~= "Smoke" then
                                if v94.kind ~= "Status" or data_3.status ~= "Burn" then
                                    if v94.kind ~= "Projectile" then
                                        Util_4 = Util_4 + 1
                                        continue
                                    end
                                    if not (v94.t > -2.5) then
                                        Util_4 = Util_4 + 1
                                        continue
                                    end
                                    if data_3.pellets then
                                        Util_4 = Util_4 + 1
                                        continue
                                    end
                                    v96 = tostring(data_3.key)
                                    local v103 = tbl_14[v96]
                                    local Effects_2 = tbl_upv_2.Effects
                                    v95 = data_3.shooter
                                    if type(v95) ~= "table" or type(v95.fighter) ~= "number" then
                                        v91 = nil
                                        if v103 ~= nil and not (v103 >= 0) or not (Effects_2) or typeof(data_3.origin) ~= "Vector3" or typeof(data_3.velocity) ~= "Vector3" or type(data_3.kind) ~= "string" then
                                            Util_4 = Util_4 + 1
                                            continue
                                        end
                                        v91 = tonumber(data_3.gravity) or 0
                                        local v104 = Ballistics_upv_1.new(data_3.origin, data_3.velocity, v91, 0)
                                        Ballistics_upv_1.Advance(v104, -v94.t)
                                        local Projectile_1 = Effects_2.Projectile
                                        local v105 = "R|" .. v96
                                        local kind_2 = data_3.kind
                                        local pos_1 = v104.pos
                                        local vel_1 = v104.vel
                                        if v91 then
                                            v92 = v91.model
                                        else
                                            v92 = nil
                                        end
                                        pcall(Projectile_1, v105, kind_2, pos_1, vel_1, v91, v92)
                                        Util_4 = Util_4 + 1
                                    end
                                    local _ = v95.fighter
                                    if v103 ~= nil and not (v103 >= 0) or not (Effects_2) or typeof(data_3.origin) ~= "Vector3" or typeof(data_3.velocity) ~= "Vector3" or type(data_3.kind) ~= "string" then
                                        Util_4 = Util_4 + 1
                                        continue
                                    end
                                    v91 = tonumber(data_3.gravity) or 0
                                    local v104 = Ballistics_upv_1.new(data_3.origin, data_3.velocity, v91, 0)
                                    Ballistics_upv_1.Advance(v104, -v94.t)
                                    local Projectile_1 = Effects_2.Projectile
                                    local v105 = "R|" .. v96
                                    local kind_2 = data_3.kind
                                    local pos_1 = v104.pos
                                    local vel_1 = v104.vel
                                    if v91 then
                                        v92 = v91.model
                                    else
                                        v92 = nil
                                    end
                                    pcall(Projectile_1, v105, kind_2, pos_1, vel_1, v91, v92)
                                    Util_4 = Util_4 + 1
                                end
                                v96 = (tonumber(data_3.duration) or 1) + v94.t
                                if v96 > 0.2 then
                                    data_3.duration = v96
                                    dispatch(a1, v94)
                                end
                            else
                                v97 = (tonumber(data_3.duration) or 7) + v94.t
                                if v97 > 0.4 then
                                    data_3.duration = v97
                                    dispatch(a1, v94)
                                end
                            end
                            Util_4 = Util_4 + 1
                            continue
                        end
                        v93 = v98.fighter
                        if v93 == a1.focus then
                            Hud_upv_1.OnFighterEvent("Charge", {on = false}, v94.t)
                            Util_4 = Util_4 + 1
                            continue
                        end
                    end
                    if v94.kind ~= "Smoke" then
                        if v94.kind ~= "Status" or data_3.status ~= "Burn" then
                            if v94.kind ~= "Projectile" then
                                Util_4 = Util_4 + 1
                                continue
                            end
                            if not (v94.t > -2.5) then
                                Util_4 = Util_4 + 1
                                continue
                            end
                            if data_3.pellets then
                                Util_4 = Util_4 + 1
                                continue
                            end
                            v96 = tostring(data_3.key)
                            local v103 = tbl_14[v96]
                            local Effects_2 = tbl_upv_2.Effects
                            v95 = data_3.shooter
                            if type(v95) ~= "table" or type(v95.fighter) ~= "number" then
                                v91 = nil
                                if v103 ~= nil and not (v103 >= 0) or not (Effects_2) or typeof(data_3.origin) ~= "Vector3" or typeof(data_3.velocity) ~= "Vector3" or type(data_3.kind) ~= "string" then
                                    Util_4 = Util_4 + 1
                                    continue
                                end
                                v91 = tonumber(data_3.gravity) or 0
                                local v104 = Ballistics_upv_1.new(data_3.origin, data_3.velocity, v91, 0)
                                Ballistics_upv_1.Advance(v104, -v94.t)
                                local Projectile_1 = Effects_2.Projectile
                                local v105 = "R|" .. v96
                                local kind_2 = data_3.kind
                                local pos_1 = v104.pos
                                local vel_1 = v104.vel
                                if v91 then
                                    v92 = v91.model
                                else
                                    v92 = nil
                                end
                                pcall(Projectile_1, v105, kind_2, pos_1, vel_1, v91, v92)
                                Util_4 = Util_4 + 1
                            end
                            local _ = v95.fighter
                            if v103 ~= nil and not (v103 >= 0) or not (Effects_2) or typeof(data_3.origin) ~= "Vector3" or typeof(data_3.velocity) ~= "Vector3" or type(data_3.kind) ~= "string" then
                                Util_4 = Util_4 + 1
                                continue
                            end
                            v91 = tonumber(data_3.gravity) or 0
                            local v104 = Ballistics_upv_1.new(data_3.origin, data_3.velocity, v91, 0)
                            Ballistics_upv_1.Advance(v104, -v94.t)
                            local Projectile_1 = Effects_2.Projectile
                            local v105 = "R|" .. v96
                            local kind_2 = data_3.kind
                            local pos_1 = v104.pos
                            local vel_1 = v104.vel
                            if v91 then
                                v92 = v91.model
                            else
                                v92 = nil
                            end
                            pcall(Projectile_1, v105, kind_2, pos_1, vel_1, v91, v92)
                            Util_4 = Util_4 + 1
                        end
                        v96 = (tonumber(data_3.duration) or 1) + v94.t
                        if v96 > 0.2 then
                            data_3.duration = v96
                            dispatch(a1, v94)
                        end
                    else
                        v97 = (tonumber(data_3.duration) or 7) + v94.t
                        if v97 > 0.4 then
                            data_3.duration = v97
                            dispatch(a1, v94)
                        end
                    end
                    Util_4 = Util_4 + 1
                    continue
                end
                v93 = v101.fighter
                if v93 == a1.focus then
                    Hud_upv_1.OnFighterEvent("Inv", data_3, v94.t)
                    Util_4 = Util_4 + 1
                    continue
                end
            end
            if v94.kind == "Charge" then
                v100 = data_3.attacker
                if type(v100) ~= "table" or type(v100.fighter) ~= "number" then
                    v93 = nil
                    if v93 == a1.focus then
                        Hud_upv_1.OnFighterEvent("Charge", data_3, v94.t)
                        Util_4 = Util_4 + 1
                        continue
                    end
                    if v94.kind == "Projectile" then
                        v99 = data_3.shooter
                        if type(v99) ~= "table" or type(v99.fighter) ~= "number" then
                            v93 = nil
                            if v93 == a1.focus then
                                Hud_upv_1.OnFighterEvent("Charge", {on = false}, v94.t)
                                Util_4 = Util_4 + 1
                                continue
                            end
                            if v94.kind == "Swing" then
                                v98 = data_3.attacker
                                if type(v98) ~= "table" or type(v98.fighter) ~= "number" then
                                    v93 = nil
                                    if v93 == a1.focus then
                                        Hud_upv_1.OnFighterEvent("Charge", {on = false}, v94.t)
                                        Util_4 = Util_4 + 1
                                        continue
                                    end
                                    if v94.kind ~= "Smoke" then
                                        if v94.kind ~= "Status" or data_3.status ~= "Burn" then
                                            if v94.kind ~= "Projectile" then
                                                Util_4 = Util_4 + 1
                                                continue
                                            end
                                            if not (v94.t > -2.5) then
                                                Util_4 = Util_4 + 1
                                                continue
                                            end
                                            if data_3.pellets then
                                                Util_4 = Util_4 + 1
                                                continue
                                            end
                                            v96 = tostring(data_3.key)
                                            local v103 = tbl_14[v96]
                                            local Effects_2 = tbl_upv_2.Effects
                                            v95 = data_3.shooter
                                            if type(v95) ~= "table" or type(v95.fighter) ~= "number" then
                                                v91 = nil
                                                if v103 ~= nil and not (v103 >= 0) or not (Effects_2) or typeof(data_3.origin) ~= "Vector3" or typeof(data_3.velocity) ~= "Vector3" or type(data_3.kind) ~= "string" then
                                                    Util_4 = Util_4 + 1
                                                    continue
                                                end
                                                v91 = tonumber(data_3.gravity) or 0
                                                local v104 = Ballistics_upv_1.new(data_3.origin, data_3.velocity, v91, 0)
                                                Ballistics_upv_1.Advance(v104, -v94.t)
                                                local Projectile_1 = Effects_2.Projectile
                                                local v105 = "R|" .. v96
                                                local kind_2 = data_3.kind
                                                local pos_1 = v104.pos
                                                local vel_1 = v104.vel
                                                if v91 then
                                                    v92 = v91.model
                                                else
                                                    v92 = nil
                                                end
                                                pcall(Projectile_1, v105, kind_2, pos_1, vel_1, v91, v92)
                                                Util_4 = Util_4 + 1
                                            end
                                            local _ = v95.fighter
                                            if v103 ~= nil and not (v103 >= 0) or not (Effects_2) or typeof(data_3.origin) ~= "Vector3" or typeof(data_3.velocity) ~= "Vector3" or type(data_3.kind) ~= "string" then
                                                Util_4 = Util_4 + 1
                                                continue
                                            end
                                            v91 = tonumber(data_3.gravity) or 0
                                            local v104 = Ballistics_upv_1.new(data_3.origin, data_3.velocity, v91, 0)
                                            Ballistics_upv_1.Advance(v104, -v94.t)
                                            local Projectile_1 = Effects_2.Projectile
                                            local v105 = "R|" .. v96
                                            local kind_2 = data_3.kind
                                            local pos_1 = v104.pos
                                            local vel_1 = v104.vel
                                            if v91 then
                                                v92 = v91.model
                                            else
                                                v92 = nil
                                            end
                                            pcall(Projectile_1, v105, kind_2, pos_1, vel_1, v91, v92)
                                            Util_4 = Util_4 + 1
                                        end
                                        v96 = (tonumber(data_3.duration) or 1) + v94.t
                                        if v96 > 0.2 then
                                            data_3.duration = v96
                                            dispatch(a1, v94)
                                        end
                                    else
                                        v97 = (tonumber(data_3.duration) or 7) + v94.t
                                        if v97 > 0.4 then
                                            data_3.duration = v97
                                            dispatch(a1, v94)
                                        end
                                    end
                                    Util_4 = Util_4 + 1
                                    continue
                                end
                                v93 = v98.fighter
                                if v93 == a1.focus then
                                    Hud_upv_1.OnFighterEvent("Charge", {on = false}, v94.t)
                                    Util_4 = Util_4 + 1
                                    continue
                                end
                            end
                            if v94.kind ~= "Smoke" then
                                if v94.kind ~= "Status" or data_3.status ~= "Burn" then
                                    if v94.kind ~= "Projectile" then
                                        Util_4 = Util_4 + 1
                                        continue
                                    end
                                    if not (v94.t > -2.5) then
                                        Util_4 = Util_4 + 1
                                        continue
                                    end
                                    if data_3.pellets then
                                        Util_4 = Util_4 + 1
                                        continue
                                    end
                                    v96 = tostring(data_3.key)
                                    local v103 = tbl_14[v96]
                                    local Effects_2 = tbl_upv_2.Effects
                                    v95 = data_3.shooter
                                    if type(v95) ~= "table" or type(v95.fighter) ~= "number" then
                                        v91 = nil
                                        if v103 ~= nil and not (v103 >= 0) or not (Effects_2) or typeof(data_3.origin) ~= "Vector3" or typeof(data_3.velocity) ~= "Vector3" or type(data_3.kind) ~= "string" then
                                            Util_4 = Util_4 + 1
                                            continue
                                        end
                                        v91 = tonumber(data_3.gravity) or 0
                                        local v104 = Ballistics_upv_1.new(data_3.origin, data_3.velocity, v91, 0)
                                        Ballistics_upv_1.Advance(v104, -v94.t)
                                        local Projectile_1 = Effects_2.Projectile
                                        local v105 = "R|" .. v96
                                        local kind_2 = data_3.kind
                                        local pos_1 = v104.pos
                                        local vel_1 = v104.vel
                                        if v91 then
                                            v92 = v91.model
                                        else
                                            v92 = nil
                                        end
                                        pcall(Projectile_1, v105, kind_2, pos_1, vel_1, v91, v92)
                                        Util_4 = Util_4 + 1
                                    end
                                    local _ = v95.fighter
                                    if v103 ~= nil and not (v103 >= 0) or not (Effects_2) or typeof(data_3.origin) ~= "Vector3" or typeof(data_3.velocity) ~= "Vector3" or type(data_3.kind) ~= "string" then
                                        Util_4 = Util_4 + 1
                                        continue
                                    end
                                    v91 = tonumber(data_3.gravity) or 0
                                    local v104 = Ballistics_upv_1.new(data_3.origin, data_3.velocity, v91, 0)
                                    Ballistics_upv_1.Advance(v104, -v94.t)
                                    local Projectile_1 = Effects_2.Projectile
                                    local v105 = "R|" .. v96
                                    local kind_2 = data_3.kind
                                    local pos_1 = v104.pos
                                    local vel_1 = v104.vel
                                    if v91 then
                                        v92 = v91.model
                                    else
                                        v92 = nil
                                    end
                                    pcall(Projectile_1, v105, kind_2, pos_1, vel_1, v91, v92)
                                    Util_4 = Util_4 + 1
                                end
                                v96 = (tonumber(data_3.duration) or 1) + v94.t
                                if v96 > 0.2 then
                                    data_3.duration = v96
                                    dispatch(a1, v94)
                                end
                            else
                                v97 = (tonumber(data_3.duration) or 7) + v94.t
                                if v97 > 0.4 then
                                    data_3.duration = v97
                                    dispatch(a1, v94)
                                end
                            end
                            Util_4 = Util_4 + 1
                            continue
                        end
                        v93 = v99.fighter
                        if v93 == a1.focus then
                            Hud_upv_1.OnFighterEvent("Charge", {on = false}, v94.t)
                            Util_4 = Util_4 + 1
                            continue
                        end
                    end
                    if v94.kind == "Swing" then
                        v98 = data_3.attacker
                        if type(v98) ~= "table" or type(v98.fighter) ~= "number" then
                            v93 = nil
                            if v93 == a1.focus then
                                Hud_upv_1.OnFighterEvent("Charge", {on = false}, v94.t)
                                Util_4 = Util_4 + 1
                                continue
                            end
                            if v94.kind ~= "Smoke" then
                                if v94.kind ~= "Status" or data_3.status ~= "Burn" then
                                    if v94.kind ~= "Projectile" then
                                        Util_4 = Util_4 + 1
                                        continue
                                    end
                                    if not (v94.t > -2.5) then
                                        Util_4 = Util_4 + 1
                                        continue
                                    end
                                    if data_3.pellets then
                                        Util_4 = Util_4 + 1
                                        continue
                                    end
                                    v96 = tostring(data_3.key)
                                    local v103 = tbl_14[v96]
                                    local Effects_2 = tbl_upv_2.Effects
                                    v95 = data_3.shooter
                                    if type(v95) ~= "table" or type(v95.fighter) ~= "number" then
                                        v91 = nil
                                        if v103 ~= nil and not (v103 >= 0) or not (Effects_2) or typeof(data_3.origin) ~= "Vector3" or typeof(data_3.velocity) ~= "Vector3" or type(data_3.kind) ~= "string" then
                                            Util_4 = Util_4 + 1
                                            continue
                                        end
                                        v91 = tonumber(data_3.gravity) or 0
                                        local v104 = Ballistics_upv_1.new(data_3.origin, data_3.velocity, v91, 0)
                                        Ballistics_upv_1.Advance(v104, -v94.t)
                                        local Projectile_1 = Effects_2.Projectile
                                        local v105 = "R|" .. v96
                                        local kind_2 = data_3.kind
                                        local pos_1 = v104.pos
                                        local vel_1 = v104.vel
                                        if v91 then
                                            v92 = v91.model
                                        else
                                            v92 = nil
                                        end
                                        pcall(Projectile_1, v105, kind_2, pos_1, vel_1, v91, v92)
                                        Util_4 = Util_4 + 1
                                    end
                                    local _ = v95.fighter
                                    if v103 ~= nil and not (v103 >= 0) or not (Effects_2) or typeof(data_3.origin) ~= "Vector3" or typeof(data_3.velocity) ~= "Vector3" or type(data_3.kind) ~= "string" then
                                        Util_4 = Util_4 + 1
                                        continue
                                    end
                                    v91 = tonumber(data_3.gravity) or 0
                                    local v104 = Ballistics_upv_1.new(data_3.origin, data_3.velocity, v91, 0)
                                    Ballistics_upv_1.Advance(v104, -v94.t)
                                    local Projectile_1 = Effects_2.Projectile
                                    local v105 = "R|" .. v96
                                    local kind_2 = data_3.kind
                                    local pos_1 = v104.pos
                                    local vel_1 = v104.vel
                                    if v91 then
                                        v92 = v91.model
                                    else
                                        v92 = nil
                                    end
                                    pcall(Projectile_1, v105, kind_2, pos_1, vel_1, v91, v92)
                                    Util_4 = Util_4 + 1
                                end
                                v96 = (tonumber(data_3.duration) or 1) + v94.t
                                if v96 > 0.2 then
                                    data_3.duration = v96
                                    dispatch(a1, v94)
                                end
                            else
                                v97 = (tonumber(data_3.duration) or 7) + v94.t
                                if v97 > 0.4 then
                                    data_3.duration = v97
                                    dispatch(a1, v94)
                                end
                            end
                            Util_4 = Util_4 + 1
                            continue
                        end
                        v93 = v98.fighter
                        if v93 == a1.focus then
                            Hud_upv_1.OnFighterEvent("Charge", {on = false}, v94.t)
                            Util_4 = Util_4 + 1
                            continue
                        end
                    end
                    if v94.kind ~= "Smoke" then
                        if v94.kind ~= "Status" or data_3.status ~= "Burn" then
                            if v94.kind ~= "Projectile" then
                                Util_4 = Util_4 + 1
                                continue
                            end
                            if not (v94.t > -2.5) then
                                Util_4 = Util_4 + 1
                                continue
                            end
                            if data_3.pellets then
                                Util_4 = Util_4 + 1
                                continue
                            end
                            v96 = tostring(data_3.key)
                            local v103 = tbl_14[v96]
                            local Effects_2 = tbl_upv_2.Effects
                            v95 = data_3.shooter
                            if type(v95) ~= "table" or type(v95.fighter) ~= "number" then
                                v91 = nil
                                if v103 ~= nil and not (v103 >= 0) or not (Effects_2) or typeof(data_3.origin) ~= "Vector3" or typeof(data_3.velocity) ~= "Vector3" or type(data_3.kind) ~= "string" then
                                    Util_4 = Util_4 + 1
                                    continue
                                end
                                v91 = tonumber(data_3.gravity) or 0
                                local v104 = Ballistics_upv_1.new(data_3.origin, data_3.velocity, v91, 0)
                                Ballistics_upv_1.Advance(v104, -v94.t)
                                local Projectile_1 = Effects_2.Projectile
                                local v105 = "R|" .. v96
                                local kind_2 = data_3.kind
                                local pos_1 = v104.pos
                                local vel_1 = v104.vel
                                if v91 then
                                    v92 = v91.model
                                else
                                    v92 = nil
                                end
                                pcall(Projectile_1, v105, kind_2, pos_1, vel_1, v91, v92)
                                Util_4 = Util_4 + 1
                            end
                            local _ = v95.fighter
                            if v103 ~= nil and not (v103 >= 0) or not (Effects_2) or typeof(data_3.origin) ~= "Vector3" or typeof(data_3.velocity) ~= "Vector3" or type(data_3.kind) ~= "string" then
                                Util_4 = Util_4 + 1
                                continue
                            end
                            v91 = tonumber(data_3.gravity) or 0
                            local v104 = Ballistics_upv_1.new(data_3.origin, data_3.velocity, v91, 0)
                            Ballistics_upv_1.Advance(v104, -v94.t)
                            local Projectile_1 = Effects_2.Projectile
                            local v105 = "R|" .. v96
                            local kind_2 = data_3.kind
                            local pos_1 = v104.pos
                            local vel_1 = v104.vel
                            if v91 then
                                v92 = v91.model
                            else
                                v92 = nil
                            end
                            pcall(Projectile_1, v105, kind_2, pos_1, vel_1, v91, v92)
                            Util_4 = Util_4 + 1
                        end
                        v96 = (tonumber(data_3.duration) or 1) + v94.t
                        if v96 > 0.2 then
                            data_3.duration = v96
                            dispatch(a1, v94)
                        end
                    else
                        v97 = (tonumber(data_3.duration) or 7) + v94.t
                        if v97 > 0.4 then
                            data_3.duration = v97
                            dispatch(a1, v94)
                        end
                    end
                    Util_4 = Util_4 + 1
                    continue
                end
                v93 = v100.fighter
                if v93 == a1.focus then
                    Hud_upv_1.OnFighterEvent("Charge", data_3, v94.t)
                    Util_4 = Util_4 + 1
                    continue
                end
            end
            if v94.kind == "Projectile" then
                v99 = data_3.shooter
                if type(v99) ~= "table" or type(v99.fighter) ~= "number" then
                    v93 = nil
                    if v93 == a1.focus then
                        Hud_upv_1.OnFighterEvent("Charge", {on = false}, v94.t)
                        Util_4 = Util_4 + 1
                        continue
                    end
                    if v94.kind == "Swing" then
                        v98 = data_3.attacker
                        if type(v98) ~= "table" or type(v98.fighter) ~= "number" then
                            v93 = nil
                            if v93 == a1.focus then
                                Hud_upv_1.OnFighterEvent("Charge", {on = false}, v94.t)
                                Util_4 = Util_4 + 1
                                continue
                            end
                            if v94.kind ~= "Smoke" then
                                if v94.kind ~= "Status" or data_3.status ~= "Burn" then
                                    if v94.kind ~= "Projectile" then
                                        Util_4 = Util_4 + 1
                                        continue
                                    end
                                    if not (v94.t > -2.5) then
                                        Util_4 = Util_4 + 1
                                        continue
                                    end
                                    if data_3.pellets then
                                        Util_4 = Util_4 + 1
                                        continue
                                    end
                                    v96 = tostring(data_3.key)
                                    local v103 = tbl_14[v96]
                                    local Effects_2 = tbl_upv_2.Effects
                                    v95 = data_3.shooter
                                    if type(v95) ~= "table" or type(v95.fighter) ~= "number" then
                                        v91 = nil
                                        if v103 ~= nil and not (v103 >= 0) or not (Effects_2) or typeof(data_3.origin) ~= "Vector3" or typeof(data_3.velocity) ~= "Vector3" or type(data_3.kind) ~= "string" then
                                            Util_4 = Util_4 + 1
                                            continue
                                        end
                                        v91 = tonumber(data_3.gravity) or 0
                                        local v104 = Ballistics_upv_1.new(data_3.origin, data_3.velocity, v91, 0)
                                        Ballistics_upv_1.Advance(v104, -v94.t)
                                        local Projectile_1 = Effects_2.Projectile
                                        local v105 = "R|" .. v96
                                        local kind_2 = data_3.kind
                                        local pos_1 = v104.pos
                                        local vel_1 = v104.vel
                                        if v91 then
                                            v92 = v91.model
                                        else
                                            v92 = nil
                                        end
                                        pcall(Projectile_1, v105, kind_2, pos_1, vel_1, v91, v92)
                                        Util_4 = Util_4 + 1
                                    end
                                    local _ = v95.fighter
                                    if v103 ~= nil and not (v103 >= 0) or not (Effects_2) or typeof(data_3.origin) ~= "Vector3" or typeof(data_3.velocity) ~= "Vector3" or type(data_3.kind) ~= "string" then
                                        Util_4 = Util_4 + 1
                                        continue
                                    end
                                    v91 = tonumber(data_3.gravity) or 0
                                    local v104 = Ballistics_upv_1.new(data_3.origin, data_3.velocity, v91, 0)
                                    Ballistics_upv_1.Advance(v104, -v94.t)
                                    local Projectile_1 = Effects_2.Projectile
                                    local v105 = "R|" .. v96
                                    local kind_2 = data_3.kind
                                    local pos_1 = v104.pos
                                    local vel_1 = v104.vel
                                    if v91 then
                                        v92 = v91.model
                                    else
                                        v92 = nil
                                    end
                                    pcall(Projectile_1, v105, kind_2, pos_1, vel_1, v91, v92)
                                    Util_4 = Util_4 + 1
                                end
                                v96 = (tonumber(data_3.duration) or 1) + v94.t
                                if v96 > 0.2 then
                                    data_3.duration = v96
                                    dispatch(a1, v94)
                                end
                            else
                                v97 = (tonumber(data_3.duration) or 7) + v94.t
                                if v97 > 0.4 then
                                    data_3.duration = v97
                                    dispatch(a1, v94)
                                end
                            end
                            Util_4 = Util_4 + 1
                            continue
                        end
                        v93 = v98.fighter
                        if v93 == a1.focus then
                            Hud_upv_1.OnFighterEvent("Charge", {on = false}, v94.t)
                            Util_4 = Util_4 + 1
                            continue
                        end
                    end
                    if v94.kind ~= "Smoke" then
                        if v94.kind ~= "Status" or data_3.status ~= "Burn" then
                            if v94.kind ~= "Projectile" then
                                Util_4 = Util_4 + 1
                                continue
                            end
                            if not (v94.t > -2.5) then
                                Util_4 = Util_4 + 1
                                continue
                            end
                            if data_3.pellets then
                                Util_4 = Util_4 + 1
                                continue
                            end
                            v96 = tostring(data_3.key)
                            local v103 = tbl_14[v96]
                            local Effects_2 = tbl_upv_2.Effects
                            v95 = data_3.shooter
                            if type(v95) ~= "table" or type(v95.fighter) ~= "number" then
                                v91 = nil
                                if v103 ~= nil and not (v103 >= 0) or not (Effects_2) or typeof(data_3.origin) ~= "Vector3" or typeof(data_3.velocity) ~= "Vector3" or type(data_3.kind) ~= "string" then
                                    Util_4 = Util_4 + 1
                                    continue
                                end
                                v91 = tonumber(data_3.gravity) or 0
                                local v104 = Ballistics_upv_1.new(data_3.origin, data_3.velocity, v91, 0)
                                Ballistics_upv_1.Advance(v104, -v94.t)
                                local Projectile_1 = Effects_2.Projectile
                                local v105 = "R|" .. v96
                                local kind_2 = data_3.kind
                                local pos_1 = v104.pos
                                local vel_1 = v104.vel
                                if v91 then
                                    v92 = v91.model
                                else
                                    v92 = nil
                                end
                                pcall(Projectile_1, v105, kind_2, pos_1, vel_1, v91, v92)
                                Util_4 = Util_4 + 1
                            end
                            local _ = v95.fighter
                            if v103 ~= nil and not (v103 >= 0) or not (Effects_2) or typeof(data_3.origin) ~= "Vector3" or typeof(data_3.velocity) ~= "Vector3" or type(data_3.kind) ~= "string" then
                                Util_4 = Util_4 + 1
                                continue
                            end
                            v91 = tonumber(data_3.gravity) or 0
                            local v104 = Ballistics_upv_1.new(data_3.origin, data_3.velocity, v91, 0)
                            Ballistics_upv_1.Advance(v104, -v94.t)
                            local Projectile_1 = Effects_2.Projectile
                            local v105 = "R|" .. v96
                            local kind_2 = data_3.kind
                            local pos_1 = v104.pos
                            local vel_1 = v104.vel
                            if v91 then
                                v92 = v91.model
                            else
                                v92 = nil
                            end
                            pcall(Projectile_1, v105, kind_2, pos_1, vel_1, v91, v92)
                            Util_4 = Util_4 + 1
                        end
                        v96 = (tonumber(data_3.duration) or 1) + v94.t
                        if v96 > 0.2 then
                            data_3.duration = v96
                            dispatch(a1, v94)
                        end
                    else
                        v97 = (tonumber(data_3.duration) or 7) + v94.t
                        if v97 > 0.4 then
                            data_3.duration = v97
                            dispatch(a1, v94)
                        end
                    end
                    Util_4 = Util_4 + 1
                    continue
                end
                v93 = v99.fighter
                if v93 == a1.focus then
                    Hud_upv_1.OnFighterEvent("Charge", {on = false}, v94.t)
                    Util_4 = Util_4 + 1
                    continue
                end
            end
            if v94.kind == "Swing" then
                v98 = data_3.attacker
                if type(v98) ~= "table" or type(v98.fighter) ~= "number" then
                    v93 = nil
                    if v93 == a1.focus then
                        Hud_upv_1.OnFighterEvent("Charge", {on = false}, v94.t)
                        Util_4 = Util_4 + 1
                        continue
                    end
                    if v94.kind ~= "Smoke" then
                        if v94.kind ~= "Status" or data_3.status ~= "Burn" then
                            if v94.kind ~= "Projectile" then
                                Util_4 = Util_4 + 1
                                continue
                            end
                            if not (v94.t > -2.5) then
                                Util_4 = Util_4 + 1
                                continue
                            end
                            if data_3.pellets then
                                Util_4 = Util_4 + 1
                                continue
                            end
                            v96 = tostring(data_3.key)
                            local v103 = tbl_14[v96]
                            local Effects_2 = tbl_upv_2.Effects
                            v95 = data_3.shooter
                            if type(v95) ~= "table" or type(v95.fighter) ~= "number" then
                                v91 = nil
                                if v103 ~= nil and not (v103 >= 0) or not (Effects_2) or typeof(data_3.origin) ~= "Vector3" or typeof(data_3.velocity) ~= "Vector3" or type(data_3.kind) ~= "string" then
                                    Util_4 = Util_4 + 1
                                    continue
                                end
                                v91 = tonumber(data_3.gravity) or 0
                                local v104 = Ballistics_upv_1.new(data_3.origin, data_3.velocity, v91, 0)
                                Ballistics_upv_1.Advance(v104, -v94.t)
                                local Projectile_1 = Effects_2.Projectile
                                local v105 = "R|" .. v96
                                local kind_2 = data_3.kind
                                local pos_1 = v104.pos
                                local vel_1 = v104.vel
                                if v91 then
                                    v92 = v91.model
                                else
                                    v92 = nil
                                end
                                pcall(Projectile_1, v105, kind_2, pos_1, vel_1, v91, v92)
                                Util_4 = Util_4 + 1
                            end
                            local _ = v95.fighter
                            if v103 ~= nil and not (v103 >= 0) or not (Effects_2) or typeof(data_3.origin) ~= "Vector3" or typeof(data_3.velocity) ~= "Vector3" or type(data_3.kind) ~= "string" then
                                Util_4 = Util_4 + 1
                                continue
                            end
                            v91 = tonumber(data_3.gravity) or 0
                            local v104 = Ballistics_upv_1.new(data_3.origin, data_3.velocity, v91, 0)
                            Ballistics_upv_1.Advance(v104, -v94.t)
                            local Projectile_1 = Effects_2.Projectile
                            local v105 = "R|" .. v96
                            local kind_2 = data_3.kind
                            local pos_1 = v104.pos
                            local vel_1 = v104.vel
                            if v91 then
                                v92 = v91.model
                            else
                                v92 = nil
                            end
                            pcall(Projectile_1, v105, kind_2, pos_1, vel_1, v91, v92)
                            Util_4 = Util_4 + 1
                        end
                        v96 = (tonumber(data_3.duration) or 1) + v94.t
                        if v96 > 0.2 then
                            data_3.duration = v96
                            dispatch(a1, v94)
                        end
                    else
                        v97 = (tonumber(data_3.duration) or 7) + v94.t
                        if v97 > 0.4 then
                            data_3.duration = v97
                            dispatch(a1, v94)
                        end
                    end
                    Util_4 = Util_4 + 1
                    continue
                end
                v93 = v98.fighter
                if v93 == a1.focus then
                    Hud_upv_1.OnFighterEvent("Charge", {on = false}, v94.t)
                    Util_4 = Util_4 + 1
                    continue
                end
            end
            if v94.kind ~= "Smoke" then
                if v94.kind ~= "Status" or data_3.status ~= "Burn" then
                    if v94.kind ~= "Projectile" then
                        Util_4 = Util_4 + 1
                        continue
                    end
                    if not (v94.t > -2.5) then
                        Util_4 = Util_4 + 1
                        continue
                    end
                    if data_3.pellets then
                        Util_4 = Util_4 + 1
                        continue
                    end
                    v96 = tostring(data_3.key)
                    local v103 = tbl_14[v96]
                    local Effects_2 = tbl_upv_2.Effects
                    v95 = data_3.shooter
                    if type(v95) ~= "table" or type(v95.fighter) ~= "number" then
                        v91 = nil
                        if v103 ~= nil and not (v103 >= 0) or not (Effects_2) or typeof(data_3.origin) ~= "Vector3" or typeof(data_3.velocity) ~= "Vector3" or type(data_3.kind) ~= "string" then
                            Util_4 = Util_4 + 1
                            continue
                        end
                        v91 = tonumber(data_3.gravity) or 0
                        local v104 = Ballistics_upv_1.new(data_3.origin, data_3.velocity, v91, 0)
                        Ballistics_upv_1.Advance(v104, -v94.t)
                        local Projectile_1 = Effects_2.Projectile
                        local v105 = "R|" .. v96
                        local kind_2 = data_3.kind
                        local pos_1 = v104.pos
                        local vel_1 = v104.vel
                        if v91 then
                            v92 = v91.model
                        else
                            v92 = nil
                        end
                        pcall(Projectile_1, v105, kind_2, pos_1, vel_1, v91, v92)
                        Util_4 = Util_4 + 1
                    end
                    local _ = v95.fighter
                    if v103 ~= nil and not (v103 >= 0) or not (Effects_2) or typeof(data_3.origin) ~= "Vector3" or typeof(data_3.velocity) ~= "Vector3" or type(data_3.kind) ~= "string" then
                        Util_4 = Util_4 + 1
                        continue
                    end
                    v91 = tonumber(data_3.gravity) or 0
                    local v104 = Ballistics_upv_1.new(data_3.origin, data_3.velocity, v91, 0)
                    Ballistics_upv_1.Advance(v104, -v94.t)
                    local Projectile_1 = Effects_2.Projectile
                    local v105 = "R|" .. v96
                    local kind_2 = data_3.kind
                    local pos_1 = v104.pos
                    local vel_1 = v104.vel
                    if v91 then
                        v92 = v91.model
                    else
                        v92 = nil
                    end
                    pcall(Projectile_1, v105, kind_2, pos_1, vel_1, v91, v92)
                    Util_4 = Util_4 + 1
                end
                v96 = (tonumber(data_3.duration) or 1) + v94.t
                if v96 > 0.2 then
                    data_3.duration = v96
                    dispatch(a1, v94)
                end
            else
                v97 = (tonumber(data_3.duration) or 7) + v94.t
                if v97 > 0.4 then
                    data_3.duration = v97
                    dispatch(a1, v94)
                end
            end
        else
            v102 = data_3.attacker
            if type(v102) ~= "table" or type(v102.fighter) ~= "number" then
                v93 = nil
                if not (v93) then
                    Util_4 = Util_4 + 1
                    continue
                end
                if type(data_3.name) ~= "string" then
                    Util_4 = Util_4 + 1
                    continue
                end
                tbl_15[v93] = tbl_15[v93] or {}
                if data_3.op == "Hold" then
                    tbl_15[v93][data_3.name] = tonumber(data_3.speed) or 1
                    Util_4 = Util_4 + 1
                    continue
                end
                if data_3.op == "Stop" then
                    tbl_15[v93][data_3.name] = nil
                end
                Util_4 = Util_4 + 1
            end
            v93 = v102.fighter
            if not (v93) then
                Util_4 = Util_4 + 1
                continue
            end
            if type(data_3.name) ~= "string" then
                Util_4 = Util_4 + 1
                continue
            end
            tbl_15[v93] = tbl_15[v93] or {}
            if data_3.op == "Hold" then
                tbl_15[v93][data_3.name] = tonumber(data_3.speed) or 1
                Util_4 = Util_4 + 1
                continue
            end
            if data_3.op == "Stop" then
                tbl_15[v93][data_3.name] = nil
            end
        end
        Util_4 = Util_4 + 1
    end
    a1.nextEvent = Util_4
    Util_4 = tbl_upv_2.Util
    if not Util_4 then
        return
    end
    for key_5, value_17 in tbl_15 do
        local v106 = a1.puppets[key_5]
        if not (v106) or not (v106.alive) then
            continue
        end
        for key_6, value_18 in value_17 do
            Util_4.PlayHold(v106.animator, key_6, value_18)
        end
    end
end
local function loadCombat()
    --[[
      name: loadCombat
      line: 48
      upvalues:
        tbl_upv_2 (copy, index: 1)
        Parent_upv_1 (copy, index: 2)
    ]]
    if tbl_upv_2.Controller then
        return
    end
    local Combat_2 = Parent_upv_1:FindFirstChild("Combat")
    if not Combat_2 then
        return
    end
    for _, value_19 in {"Controller", "Util", "Effects", "Presentation", "Guard", "Poses", "Hud"} do
        local v107 = Combat_2:FindFirstChild(value_19)
        if not (v107) or not (v107:IsA("ModuleScript")) then
            continue
        end
        local success_7, v108 = pcall(require, v107)
        if (success_7) and type(v108) == "table" then
            tbl_upv_2[value_19] = v108
        else
            warn("[Replay] combat module unavailable:", value_19, v108)
        end
    end
end
local function findMap(a1)
    --[[
      name: findMap
      line: 840
      upvalues:
        Workspace_upv_1 (copy, index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
    ]]
    local Arenas_1 = Workspace_upv_1:FindFirstChild("Arenas")
    if not Arenas_1 then
        return nil
    end
    local v109 = LocalPlayer_upv_1:GetAttribute("MatchId")
    local v110 = (type(v109) == "string") and (Arenas_1:FindFirstChild(v109))
    local v111 = v110 and (v110:FindFirstChild("Map"))
    if v111 then
        return v111
    else
        local v112 = nil
        for _, value_20 in Arenas_1:GetChildren() do
            v112 = value_20:FindFirstChild("Map")
            local v113 = value_20:GetAttribute("RingCenterX")
            local v114 = value_20:GetAttribute("RingCenterZ")
            if not (v112) or type(v113) ~= "number" or type(v114) ~= "number" or not (math.abs(v113 - a1.X) < 5) or not (math.abs(v114 - a1.Z) < 5) then
                continue
            end
            return v112
        end
        return nil
    end
end
function tbl_upv_1.Play(a1)
    --[[
      name: Play
      line: 872
      upvalues:
        u2 (ref,  index: 1)
        tbl_upv_1 (copy, index: 2)
        Clip_upv_1 (copy, index: 3)
        loadCombat (copy, index: 4)
        aimSegments (copy, index: 5)
        Director_upv_1 (copy, index: 6)
        RunService_upv_1 (copy, index: 7)
        Workspace_upv_1 (copy, index: 8)
        u3 (ref,  index: 9)
        findMap (copy, index: 10)
        Locomotion_upv_1 (copy, index: 11)
        Diag_upv_1 (copy, index: 12)
        ReplayCodec_upv_1 (copy, index: 13)
        PoseTrace_upv_1 (copy, index: 14)
        Stage_upv_1 (copy, index: 15)
        View_upv_1 (copy, index: 16)
        tbl_upv_2 (copy, index: 17)
        LocalPlayer_upv_1 (copy, index: 18)
        Puppets_upv_1 (copy, index: 19)
        tbl_upv_3 (copy, index: 20)
        Overlay_upv_1 (copy, index: 21)
        step (copy, index: 22)
        Hud_upv_1 (copy, index: 23)
        applyPreroll (copy, index: 24)
    ]]
    if type(a1) ~= "table" or typeof(a1.clip) ~= "buffer" then
        return
    end
    if u2 then
        tbl_upv_1.Stop("replaced")
    end
    local success_8, u9, v115 = pcall(Clip_upv_1.Decode, a1.clip)
    if success_8 then
        local v116 = nil
        if u9 then
            v116 = u9.fighters[u9.focus]
            if v116 and v116.n ~= 0 then
                loadCombat()
                local v117, v118, v119 = aimSegments(u9, u9.focus)
                Director_upv_1.SetSegments(v117)
                Clip_upv_1.LinearView = RunService_upv_1:IsStudio() and Workspace_upv_1:GetAttribute("ReplayViewLinear") == true
                u3 = u3 + 1
                local u10 = Instance.new("Folder")
                u10.Name = "Replay"
                local v121 = findMap(u9.origin)
                local v122 = RaycastParams.new()
                v122.FilterType = Enum.RaycastFilterType.Include
                v122.IgnoreWater = true
                v122.FilterDescendantsInstances = (v121 and {v121}) or {}
                Director_upv_1.SetWorld((v121 and {v121}) or {})
                Locomotion_upv_1.SetGround((v121 and {v121}) or {})
                local tbl_upv_16 = {t0 = 0, locoAcc = 0, chain = 0, built = false, phase = "intro", diagStage = 0, diagAcc = 0, holdAcc = 0, lastKillT = -math.huge, nextEvent = 1, lastT = 0}
                tbl_upv_16.token = u3
                tbl_upv_16.clip = u9
                tbl_upv_16.payload = a1
                tbl_upv_16.puppets = {}
                tbl_upv_16.states = {}
                tbl_upv_16.folder = u10
                tbl_upv_16.focus = u9.focus
                tbl_upv_16.params = v122
                tbl_upv_16.landed = v118
                tbl_upv_16.landedOn = v119
                tbl_upv_16.healthy = {}
                tbl_upv_16.stats = {missing = 0, frames = 0, hitErrMax = 0, hitErrSum = 0, events = 0, fxErrors = 0, hits = 0, standIns = 0, maxStep = 0, stepTime = 0, kinds = {}}
                u2 = tbl_upv_16
                for key_7 in u9.fighters do
                    tbl_upv_16.states[key_7] = Clip_upv_1.NewState()
                end
                pcall(Diag_upv_1.Begin, u9)
                PoseTrace_upv_1.Reset()
                Stage_upv_1.Enter((ReplayCodec_upv_1.INTRO_TIME + u9.duration) + ReplayCodec_upv_1.OUTRO_TIME)
                pcall(View_upv_1.Begin, v122)
                u10.Parent = Workspace_upv_1
                local Effects_3 = tbl_upv_2.Effects
                if Effects_3 then
                    Effects_3.ParamsOverride = function(a2)
                        --[[
                          line: 943
                          upvalues:
                            u2 (ref,  index: 1)
                            tbl_upv_16 (copy, index: 2)
                        ]]
                        if a2 and a2:GetAttribute("ReplayPuppet") ~= nil and u2 == tbl_upv_16 then
                            return tbl_upv_16.params
                        end
                        return nil
                    end
                end
                local v123 = LocalPlayer_upv_1:GetAttribute("Team")
                local team_upv_1 = v116.team
                local function makePuppet(a3, a4)
                    --[[
                      name: makePuppet
                      line: 952
                      upvalues:
                        u9 (copy, index: 1)
                        tbl_upv_16 (copy, index: 2)
                        Clip_upv_1 (copy, index: 3)
                        Puppets_upv_1 (copy, index: 4)
                        u10 (copy, index: 5)
                        Diag_upv_1 (copy, index: 6)
                        Locomotion_upv_1 (copy, index: 7)
                        tbl_upv_3 (copy, index: 8)
                        ReplayCodec_upv_1 (copy, index: 9)
                        tbl_upv_2 (copy, index: 10)
                        team_upv_1 (copy, index: 11)
                        Overlay_upv_1 (copy, index: 12)
                    ]]
                    local v124 = u9.fighters[a3]
                    if v124.n == 0 or tbl_upv_16.puppets[a3] then
                        return
                    end
                    local v125 = tbl_upv_16.states[a3]
                    Clip_upv_1.Sample(u9, v124, 0, v125)
                    local v126 = nil
                    local v127 = false
                    local v128 = nil
                    local v129 = nil
                    local v130 = nil
                    local v131 = nil
                    local v132 = -1
                    local v133 = nil
                    local v134, v135, v136 = nil, nil, nil
                    for _ = 1, 4 do
                        v134 = nil
                        for key_8, value_21 in tbl_upv_16.puppets do
                            if tbl_upv_16.healthy[key_8] then
                                v134 = value_21.model
                                break
                            end
                        end
                        local v135, v137, v138 = Puppets_upv_1.Build(a3, v124.id, v124.name, v124.team, u10, v128, v134)
                        v133 = v133 or v137
                        local success_9
                        if v135 then
                            v135.root.CFrame = v125.cf
                            Puppets_upv_1.SetVisible(v135, true)
                            v135.root.CFrame = v125.cf
                            local success_9, v139 = pcall(Puppets_upv_1.Inspect, v135, Diag_upv_1.FAR)
                            if success_9 then
                                v136 = Diag_upv_1.Evaluate(v139)
                            else
                                v136 = nil
                            end
                            if v136 ~= nil then
                                if v129 == nil then
                                    v130 = v135.src
                                    if success_9 then
                                        v131 = v139
                                    else
                                        v131 = nil
                                    end
                                end
                                if v126 then
                                    Puppets_upv_1.Destroy(v126)
                                end
                                v128, v126, v132 = v135.src, v135, v138
                            else
                                if v126 then
                                    Puppets_upv_1.Destroy(v126)
                                end
                                v126, v132, v127 = v135, v138, true
                            end
                            break
                        else
                            v132 = v138
                        end
                    end
                    if v129 == nil and v133 then
                        local v140, v141 = string.match(v133, "^(%w+):(%w+)$")
                        v129, v130 = v140, v141
                    end
                    pcall(Diag_upv_1.Built, a3, v126, v129, v130, v131, v132, v127, a4 == true)
                    if v126 then
                        if a4 then
                            local stats_7 = tbl_upv_16.stats
                            stats_7.missing = stats_7.missing - 1
                        end
                        tbl_upv_16.healthy[a3] = v127
                        if v126.standIn then
                            local stats_8 = tbl_upv_16.stats
                            stats_8.standIns = stats_8.standIns + 1
                        end
                        if v126.debugUnparent then
                            v126.model.Parent = nil
                        end
                        v126.loco = Locomotion_upv_1.new(v126.hum, v126.root, v126.animator)
                        v133 = tbl_upv_3.Procedural
                        if v133 and type(v133.Track) == "function" then
                            pcall(
                                v133.Track,
                                v126.model,
                                function()
                                    --[[
                                      line: 1033
                                      upvalues:
                                        tbl_upv_16 (copy, index: 1)
                                        a3 (copy, index: 2)
                                        ReplayCodec_upv_1 (copy, index: 3)
                                    ]]
                                    local v142 = tbl_upv_16.states[a3]
                                    return v142.vel, bit32.btest(v142.flags, ReplayCodec_upv_1.F_GROUNDED), (bit32.btest(v142.flags, ReplayCodec_upv_1.F_SLIDING))
                                end
                            )
                        end
                        v133 = tbl_upv_2.Poses
                        if v133 and type(v133.Watch) == "function" then
                            pcall(v133.Watch, v126.model)
                        end
                        if v124.team ~= team_upv_1 then
                            local model_1 = v126.model
                            local v143 = Instance.new("Highlight")
                            v143.Name = "ReplayOutline"
                            v143.DepthMode = Enum.HighlightDepthMode.Occluded
                            v143.FillTransparency = 1
                            v143.OutlineTransparency = 0.35
                            v143.OutlineColor = Overlay_upv_1.Colors.Enemy
                            v143.Adornee = model_1
                            v143.Parent = model_1
                        end
                        tbl_upv_16.puppets[a3] = v126
                    elseif not (a4) then
                        local stats_9 = tbl_upv_16.stats
                        stats_9.missing = stats_9.missing + 1
                    end
                end
                makePuppet(u9.focus)
                local v144 = tbl_upv_16.puppets[u9.focus]
                local ShowIntro_1 = Overlay_upv_1.ShowIntro
                local tbl_17 = {ally = 0, portrait = 0, name = 0, title = 0}
                tbl_17.name = tostring(a1.name or (v116.name))
                tbl_17.title = tostring(a1.title or (u9.title))
                local v145
                if v144 then
                    v145 = v144.model
                else
                    v145 = nil
                end
                tbl_17.portrait = v145
                tbl_17.ally = v123 == team_upv_1
                ShowIntro_1(tbl_17)
                Overlay_upv_1.BindSkip(tbl_upv_1.Skip)
                Clip_upv_1.Sample(u9, v116, 0, tbl_upv_16.states[u9.focus])
                Director_upv_1.SetShoulderSide(((v116.left) and -1) or 1)
                Director_upv_1.Begin(tbl_upv_16.states[u9.focus].cf, u9.duration)
                RunService_upv_1:BindToRenderStep("TribesReplay", Enum.RenderPriority.Camera.Value + 5, step)
                task.spawn(
                    function()
                        --[[
                          line: 1062
                          upvalues:
                            u9 (copy, index: 1)
                            u2 (ref,  index: 2)
                            tbl_upv_16 (copy, index: 3)
                            makePuppet (copy, index: 4)
                        ]]
                        for key_9 in u9.fighters do
                            if u2 ~= tbl_upv_16 then
                                return
                            end
                            if key_9 == u9.focus then
                                continue
                            end
                            local success_10, v146 = pcall(makePuppet, key_9)
                            if not (success_10) then
                                warn("[Replay] puppet failed:", v146)
                            end
                            task.wait()
                        end
                        for key_10, value_22 in u9.fighters do
                            if u2 ~= tbl_upv_16 then
                                return
                            end
                            if not (value_22.n > 0) then
                                continue
                            end
                            if not (tbl_upv_16.puppets[key_10]) then
                                pcall(makePuppet, key_10, true)
                            end
                        end
                        tbl_upv_16.built = true
                    end
                )
                task.delay(
                    ReplayCodec_upv_1.INTRO_TIME,
                    function()
                        --[[
                          line: 1086
                          upvalues:
                            u2 (ref,  index: 1)
                            tbl_upv_16 (copy, index: 2)
                            Hud_upv_1 (copy, index: 3)
                            u9 (copy, index: 4)
                            applyPreroll (copy, index: 5)
                            Overlay_upv_1 (copy, index: 6)
                        ]]
                        if u2 ~= tbl_upv_16 then
                            return
                        end
                        if tbl_upv_16.phase == "intro" then
                            tbl_upv_16.phase = "play"
                            tbl_upv_16.t0 = os.clock()
                            pcall(Hud_upv_1.Begin, u9.items)
                            local success_11, v147 = pcall(applyPreroll, tbl_upv_16)
                            if not (success_11) then
                                warn("[Replay] preroll failed:", v147)
                            end
                            Overlay_upv_1.Reveal()
                        end
                    end
                )
            else
                warn("[Replay] clip has no samples for its fighter")
            end
        else
            local warn_1 = warn
            local v148
            if success_8 then
                v148 = v115
            else
                v148 = u9
            end
            warn_1("[Replay] bad clip:", v148)
        end
    else
        local warn_1 = warn
        local v148
        if success_8 then
            v148 = v115
        else
            v148 = u9
        end
        warn_1("[Replay] bad clip:", v148)
    end
end
function tbl_upv_1.DebugFreeze(a1)
    --[[
      name: DebugFreeze
      line: 1102
      upvalues:
        u4 (ref, index: 1)
        u5 (ref, index: 2)
    ]]
    u4 = a1
    u5 = false
end
function tbl_upv_1.DebugRate(a1)
    --[[
      name: DebugRate
      line: 1108
      upvalues:
        u6 (ref, index: 1)
    ]]
    local v149
    if type(a1) == "number" and (a1 > 0) then
        v149 = math.clamp(a1, 0.05, 4)
    else
        v149 = 1
    end
    u6 = v149
end
function tbl_upv_1.DebugCamLog(a1)
    --[[
      name: DebugCamLog
      line: 1114
      upvalues:
        tbl_upv_6 (ref,  index: 1)
        Clip_upv_1 (copy, index: 2)
    ]]
    if a1 ~= true then
        if a1 == false then
            tbl_upv_6 = nil
        end
        if not tbl_upv_6 then
            return false
        end
        local tbl_18 = {}
        tbl_18.t = tbl_upv_6.t
        tbl_18.yaw = tbl_upv_6.yaw
        tbl_18.pitch = tbl_upv_6.pitch
        tbl_18.x = tbl_upv_6.x
        tbl_18.y = tbl_upv_6.y
        tbl_18.z = tbl_upv_6.z
        tbl_18.fov = tbl_upv_6.fov
        tbl_18.shots = tbl_upv_6.shots
        tbl_18.startTime = tbl_upv_6.startTime
        tbl_18.focus = tbl_upv_6.focus
        tbl_18.duration = tbl_upv_6.duration
        tbl_18.linear = Clip_upv_1.LinearView
        return tbl_18
    end
    tbl_upv_6 = {t = {}, yaw = {}, pitch = {}, x = {}, y = {}, z = {}, fov = {}, shots = {}, pending = {}}
    return true
end
function tbl_upv_1.DebugPuppet(a1)
    --[[
      name: DebugPuppet
      line: 1129
      upvalues:
        u2 (ref, index: 1)
    ]]
    if u2 then
        for _, value_23 in u2.puppets do
            if value_23.id ~= a1 then
                continue
            end
            return value_23.model
        end
    end
    return nil
end
function tbl_upv_1.DebugAnim()
    --[[
      name: DebugAnim
      line: 1143
      upvalues:
        u2 (ref, index: 1)
    ]]
    if not u2 then
        return {playing = false}
    end
    local tbl_19 = {}
    for _, value_24 in u2.puppets do
        local tbl_20 = {}
        for v152, value_25 in value_24.animator:GetPlayingAnimationTracks() do
            local Animation_1 = value_25.Animation
            table.insert(tbl_20, string.format("%s w%.2f s%.2f t%.2f/%.2f %s", (Animation_1 and (Animation_1.Name)) or "?", value_25.WeightCurrent, value_25.Speed, value_25.TimePosition, value_25.Length, value_25.Priority.Name))
        end
        local tbl_21 = {}
        for v153, value_26 in {"Root", "Waist", "RightShoulder", "LeftHip"} do
            local v150 = value_24.model:FindFirstChild(value_26, true)
            if not (v150) then
                table.insert(tbl_21, value_26 .. " " .. (((not v150) and "missing") or (v150.ClassName)))
                continue
            end
            if v150:IsA("Motor6D") then
                local v154, v151 = v150.Transform:ToAxisAngle()
                table.insert(tbl_21, string.format("%s %s->%s %.1fdeg", value_26, ((v150.Part0) and (v150.Part0.Name)) or "nil", ((v150.Part1) and (v150.Part1.Name)) or "nil", math.deg(v151)))
            else
                table.insert(tbl_21, value_26 .. " " .. (((not v150) and "missing") or (v150.ClassName)))
            end
        end
        tbl_19[value_24.id] = {visible = value_24.visible, alive = value_24.alive, item = value_24.itemId, hold = value_24.hold, tracks = tbl_20, joints = tbl_21}
    end
    return tbl_19
end
function tbl_upv_1.DebugState()
    --[[
      name: DebugState
      line: 1171
      upvalues:
        u2 (ref,  index: 1)
        clipTime (copy, index: 2)
        Director_upv_1 (copy, index: 3)
    ]]
    if not u2 then
        return {playing = false}
    end
    local tbl_22 = {}
    local v152 = nil
    for key_11, value_27 in u2.puppets do
        local v153 = u2.states[key_11]
        local tbl_23 = {playing = 0, pos = 0}
        tbl_23.index = key_11
        tbl_23.id = value_27.id
        tbl_23.visible = value_27.visible
        tbl_23.alive = value_27.alive
        tbl_23.item = value_27.itemId
        tbl_23.hold = value_27.hold
        tbl_23.standIn = value_27.standIn
        tbl_23.src = value_27.src
        tbl_23.liveParts = value_27.liveParts
        if v153.present then
            v152 = v153.cf.Position
        else
            v152 = nil
        end
        tbl_23.pos = v152
        tbl_23.playing = #value_27.animator:GetPlayingAnimationTracks()
        table.insert(tbl_22, tbl_23)
    end
    local tbl_24 = {stepMsMax = 0, stepMsAvg = 0, playing = true}
    tbl_24.phase = u2.phase
    tbl_24.t = clipTime(u2)
    tbl_24.duration = u2.clip.duration
    tbl_24.focus = u2.clip.fighters[u2.focus].id
    tbl_24.focusName = u2.clip.fighters[u2.focus].name
    tbl_24.startTime = u2.payload.startTime
    tbl_24.firstPerson = Director_upv_1.InFirstPerson()
    tbl_24.title = u2.clip.title
    tbl_24.events = #u2.clip.events
    tbl_24.dispatched = u2.nextEvent - 1
    tbl_24.bytes = u2.clip.bytes
    tbl_24.puppets = tbl_22
    tbl_24.stats = u2.stats
    tbl_24.stepMsAvg = ((u2.stats.frames > 0) and (u2.stats.stepTime * 1000 / u2.stats.frames)) or 0
    tbl_24.stepMsMax = u2.stats.maxStep * 1000
    return tbl_24
end
return tbl_upv_1