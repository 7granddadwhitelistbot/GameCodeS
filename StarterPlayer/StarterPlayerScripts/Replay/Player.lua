local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local workspace = game:GetService("Workspace")
local shared = replicatedStorage:WaitForChild("Shared")
local childName = "ReplayCodec"
local child = require(shared:WaitForChild(childName))
local childName2 = "Combat"
local child2 = require(shared:WaitForChild(childName2))
local Ballistics = require(shared.Combat:WaitForChild("Ballistics"))
local Clip = require(script.Parent.Clip)
local Puppets = require(script.Parent.Puppets)
local Locomotion = require(script.Parent.Locomotion)
local Director = require(script.Parent.Director)
local Overlay = require(script.Parent.Overlay)
local Stage = require(script.Parent.Stage)
local PoseTrace = require(script.Parent.PoseTrace)
local Hud = require(script.Parent.Hud)
local View = require(script.Parent.View)
local Diag = require(script.Parent.Diag)
local v21 = {}
local localPlayer = players.LocalPlayer
local parent = script.Parent.Parent
local v24 = {}

local function loadCombat()
    --[[
      name: loadCombat
      line: 48
      upvalues:
        v24 (copy, index: 1)
        parent (copy, index: 2)
    ]]
    if v24.Controller then
        return
    end

    local combat = parent:FindFirstChild("Combat")
    if not combat then
        return
    end

    for _, childName in {"Controller", "Util", "Effects", "Presentation", "Guard", "Poses", "Hud"} do
        if const child = combat:FindFirstChild(childName) then
            if not child:IsA("ModuleScript") then
                continue
            end

            local success, result = pcall(require, child)

            if not success or type(result) ~= "table" then
                warn("[Replay] combat module unavailable:", childName, result)
            else
                v24[childName] = result
            end
        end
    end
end

local v32 = {}

task.spawn(
    function()
        --[[
          line: 71
          upvalues:
            parent (copy, index: 1)
            v32 (copy, index: 2)
        ]]
        local character = parent:WaitForChild("Character", 15)
        local procedural = character and character:WaitForChild("Procedural", 15)

        if procedural and procedural:IsA("ModuleScript") then
            local success, result = pcall(require, procedural)

            if success and type(result) == "table" then
                v32.Procedural = result
            end
        end
    end
)

local result = nil

task.spawn(
    function()
        --[[
          line: 83
          upvalues:
            shared (copy, index: 1)
            result (ref,  index: 2)
        ]]
        local sfx = shared:WaitForChild("Sfx", 15)

        if sfx and sfx:IsA("ModuleScript") then
            local success, result2 = pcall(require, sfx)

            if success and type(result2) == "table" then
                result = result2
            end
        end
    end
)

local v41 = nil
local count = 0
local partList = {}
local cframeList = {}

local function holdFor(a46)
    --[[
      name: holdFor
      line: 127
      upvalues:
        v24 (copy, index: 1)
        child2 (copy, index: 2)
    ]]
    local presentation = v24.Presentation

    if not a46 or not presentation then
        return nil
    end

    local success, result = pcall(presentation.For, a46, child2.Kind(a46))

    if success and type(result) == "table" and type(result.hold) == "string" then
        return result.hold
    end

    return nil
end

local function setItem(item, a52)
    --[[
      name: setItem
      line: 136
      upvalues:
        Puppets (copy, index: 1)
        v24 (copy, index: 2)
        holdFor (copy, index: 3)
    ]]
    local hold = item.hold

    if not Puppets.SetItem(item, a52) then
        return
    end

    local util = v24.Util
    local hold2 = holdFor(a52)

    if util and hold and hold ~= hold2 then
        util.StopAnim(item.animator, hold, 0.15)
    end

    if util and hold2 and item.alive then
        local track = util.GetTrack(item.animator, hold2)

        if track and not track.IsPlaying then
            util.PlayAnim(item.animator, hold2, 1, 0.2)
        end
    end

    item.hold = hold2
end

local function onPuppetDied(puppet)
    --[[
      name: onPuppetDied
      line: 155
      upvalues:
        Locomotion (copy, index: 1)
        v24 (copy, index: 2)
    ]]
    if puppet.loco then
        Locomotion.Stop(puppet.loco)
    end

    for _, playingAnimationTrack in puppet.animator:GetPlayingAnimationTracks() do
        playingAnimationTrack:Stop(0.25)
    end

    if puppet.blocking and v24.Guard then
        pcall(v24.Guard.Set, puppet.model, false)
        puppet.blocking = false
    end
end

local function resolveRefs(a62, data)
    --[[
      name: resolveRefs
      line: 170
      upvalues:
        Puppets (copy, index: 1)
    ]]
    for v64, v65 in data do
        if type(v65) == "table" then
            local puppet
            local fighter = v65.fighter

            if type(fighter) == "number" then
                puppet = a62.puppets[fighter]
            else
                puppet = nil
            end

            if puppet then
                local v68

                if type(v65.part) == "string" then
                    v68 = Puppets.Part(puppet, v65.part)
                else
                    v68 = puppet.model
                end

                data[v64] = v68
            else
                data[v64] = nil
            end
        end
    end
end

local function refIndex(a70)
    --[[
      name: refIndex
      line: 184
    ]]
    if type(a70) == "table" and type(a70.fighter) == "number" then
        return a70.fighter
    end

    return nil
end

local function playAnim(a72, data)
    --[[
      name: playAnim
      line: 188
      upvalues:
        v24 (copy, index: 1)
    ]]
    local fighter
    local attacker = data.attacker

    if type(attacker) == "table" and type(attacker.fighter) == "number" then
        fighter = attacker.fighter
    else
        fighter = nil
    end

    local puppet = fighter and a72.puppets[fighter]
    local util = v24.Util

    if puppet and util and puppet.alive and puppet.visible and type(data.name) == "string" then
        local number = tonumber(data.speed) or 1

        if data.op ~= "Play" then
            if data.op == "Hold" then
                util.PlayHold(puppet.animator, data.name, number)
                return
            end

            if data.op == "Stop" then
                util.StopAnim(puppet.animator, data.name, (tonumber(data.fade)))
            end
        else
            util.PlayAnim(puppet.animator, data.name, number, tonumber(data.fade), (tonumber(data.weight)))
        end
    end
end

local v79 = nil

local function logAction(a81, kind, data, t, fighter2, fighter3, victim)
    --[[
      name: logAction
      line: 224
      upvalues:
        v79 (ref,  index: 1)
        child2 (copy, index: 2)
    ]]
    local v88 = v79

    if not v88 or a81.phase ~= "play" then
        return
    end

    if kind == "Projectile"
        and fighter2 == a81.focus
        and typeof(data.origin) == "Vector3"
        and typeof(data.velocity) == "Vector3"
        and 0.1 < data.velocity.Magnitude
    then
        local text = tostring(data.key)
        local v91 = if const v90 = a81.landed[text] or a81.landed[text .. "/1"] then math.clamp((v90 - data.origin).Magnitude, 8, 400) else 80
        table.insert(v88.pending, {kind = "shot", t = t, point = data.origin + (data.velocity.Unit * v91), victim = a81.landedOn[text]
            or a81.landedOn[text .. "/1"], weapon = data.weaponId})

        return
    end

    if kind == "Hit"
        and fighter3 == a81.focus
        and typeof(data.position) == "Vector3"
        and type(data.weaponId) == "string"
        and child2.IsMelee(child2.Kind(data.weaponId))
    then
        local fighter
        local pending = v88.pending
        local v94 = {kind = "melee", t = t, point = data.position}
        local target = data.target

        if type(target) ~= "table" or type(target.fighter) ~= "number" then
            fighter = nil
            v94.victim = fighter
            v94.weapon = data.weaponId
            v94.killed = data.killed == true
            table.insert(pending, v94)

            return
        end

        fighter = target.fighter
        v94.victim = fighter
        v94.weapon = data.weaponId
        v94.killed = data.killed == true
        table.insert(pending, v94)

        return
    end

    if kind == "Damage" and fighter3 == a81.focus and data.killed == true and victim then
        table.insert(v88.pending, {kind = "kill", t = t, victim = victim, weapon = data.weaponId})
    end
end

local function logCamera(a97, frameT, camera: Camera?)
    --[[
      name: logCamera
      line: 241
      upvalues:
        v79 (ref, index: 1)
    ]]
    local v100 = v79

    if not v100 or a97.phase ~= "play" then
        return
    end

    local cFrame = camera.CFrame
    local lookVector = cFrame.LookVector
    local v103 = #v100.t + 1
    v100.t[v103] = frameT
    v100.yaw[v103] = math.atan2(-lookVector.X, -lookVector.Z)
    v100.pitch[v103] = math.asin((math.clamp(lookVector.Y, -1, 1)))
    v100.x[v103], v100.y[v103], v100.z[v103] = cFrame.Position.X, cFrame.Position.Y, cFrame.Position.Z
    v100.fov[v103] = camera.FieldOfView
    v100.startTime = a97.payload.startTime
    v100.focus = a97.clip.fighters[a97.focus].id
    v100.duration = a97.clip.duration

    for _, v105 in v100.pending do
        local function miss(a107)
            --[[
              name: miss
              line: 259
              upvalues:
                cFrame (copy, index: 1)
                lookVector (copy, index: 2)
            ]]
            local v108 = a107 - cFrame.Position
            return (v108 - (lookVector * v108:Dot(lookVector))).Magnitude, (math.deg((math.acos((math.clamp(lookVector:Dot(v108.Unit), -1, 1))))))
        end

        local v109 = {kind = v105.kind, t = v105.t, frameT = frameT, weapon = v105.weapon, killed = v105.killed}

        if v105.point then
            local v110 = v105.point - cFrame.Position
            v109.missStuds, v109.missDeg = (v110 - (lookVector * v110:Dot(lookVector))).Magnitude, math.deg((math.acos((math.clamp(lookVector:Dot(v110.Unit), -1, 1)))))
            v109.dist = (v105.point - cFrame.Position).Magnitude
        end

        local victim = v105.victim
        local state = victim and a97.states[victim]

        if state and state.present then
            local v113 = state.cf.Position + Vector3.new(0, 0.5, 0) - cFrame.Position
            v109.victimMissStuds, v109.victimMissDeg = (v113 - (lookVector * v113:Dot(lookVector))).Magnitude, math.deg((math.acos((math.clamp(lookVector:Dot(v113.Unit), -1, 1)))))
            v109.victim = a97.clip.fighters[victim].id
        end

        table.insert(v100.shots, v109)
    end

    table.clear(v100.pending)
end

local function dispatch(a115, event)
    --[[
      name: dispatch
      line: 281
      upvalues:
        playAnim (copy, index: 1)
        v79 (ref,  index: 2)
        logAction (copy, index: 3)
        resolveRefs (copy, index: 4)
        Hud (copy, index: 5)
        Director (copy, index: 6)
        View (copy, index: 7)
        v24 (copy, index: 8)
        child2 (copy, index: 9)
    ]]
    local fighter
    local fighter2
    local fighter3
    local fighter4
    local fighter5
    local kind = event.kind
    local data = event.data
    local stats = a115.stats
    stats.events += 1
    a115.stats.kinds[kind] = (a115.stats.kinds[kind] or 0) + 1

    if kind == "Phase" then
        return
    end

    if kind == "Anim" then
        playAnim(a115, data)
        return
    end

    local killer = data.killer

    if type(killer) == "table" and type(killer.fighter) == "number" then
        local _ = killer.fighter
    end

    local target = data.target

    if type(target) ~= "table" or type(target.fighter) ~= "number" then
        fighter = nil
    else
        fighter = target.fighter
    end

    local shooter = data.shooter

    if type(shooter) ~= "table" or type(shooter.fighter) ~= "number" then
        fighter2 = nil
    else
        fighter2 = shooter.fighter
    end

    local attacker = data.attacker

    if type(attacker) == "table" and type(attacker.fighter) == "number" then
        fighter3 = attacker.fighter
    else
        fighter3 = nil
    end

    local fighter6 = data.fighter

    if type(fighter6) ~= "table" or type(fighter6.fighter) ~= "number" then
        fighter4 = nil
    else
        fighter4 = fighter6.fighter
    end

    local victim = data.victim

    if type(victim) ~= "table" or type(victim.fighter) ~= "number" then
        fighter5 = nil
    else
        fighter5 = victim.fighter
    end

    if v79 then
        logAction(a115, kind, data, event.t, fighter2, fighter3, fighter5)
    end

    if kind == "Projectile"
        and fighter2 == a115.focus
        and a115.phase == "play"
        and typeof(data.origin) == "Vector3"
        and typeof(data.velocity) == "Vector3"
        and 0.1 < data.velocity.Magnitude
    then
        local text = tostring(data.key)
        local v134 = if const v133 = a115.landed[text] or a115.landed[text .. "/1"] then math.clamp((v133 - data.origin).Magnitude, 8, 400) else 80
        a115.diagShot = data.origin + (data.velocity.Unit * v134)
    end

    resolveRefs(a115, data)

    if kind == "Inv" then
        if fighter4 == a115.focus then
            Hud.OnFighterEvent("Inv", data, event.t)
        end

        return
    end

    if kind == "Damage" then
        local fighters = a115.clip.fighters

        if fighter3 == a115.focus and fighter5 ~= a115.focus then
            local hitConfirm = Hud.HitConfirm
            local v137 = if fighter5 and fighters[fighter5] then fighters[fighter5].id else nil
            hitConfirm(data, v137)

            if data.killed == true then
                Director.OnKill()
                return
            end

            return
        end

        if fighter5 == a115.focus then
            local damageTaken = Hud.DamageTaken
            local v139 = if fighter3 then if fighters[fighter3] then fighters[fighter3].id else nil else nil
            damageTaken(data, v139)

            if data.damageType ~= "Burn" and data.damageType ~= "World" then
                View.Hurt((tonumber(data.amount) or 0), data.blocked == true)
            end
        end

        return
    end

    local v140

    if kind ~= "Hit" then
        v140 = if kind == "ProjectileHit" then data.character else nil
    else
        v140 = data.target
    end

    if typeof(v140) == "Instance" and typeof(data.position) == "Vector3" then
        local humanoidRootPart = v140:FindFirstChild("HumanoidRootPart")

        if humanoidRootPart and humanoidRootPart:IsA("BasePart") then
            local v142 = data.position - humanoidRootPart.Position
            local v143 = math.max(0, Vector3.new(v142.X, 0, v142.Z).Magnitude - 1.5)
            local stats2 = a115.stats
            stats2.hits += 1
            local stats3 = a115.stats
            stats3.hitErrSum += v143
            a115.stats.hitErrMax = math.max(a115.stats.hitErrMax, v143)
        end
    end

    if kind == "Projectile" or kind == "ProjectileHit" then
        data.key = "R|" .. tostring(data.key)
    end

    local v146 = (fighter2 or fighter3) == a115.focus or kind == "Heal" and fighter == a115.focus
    local controller = v24.Controller

    if v146 and kind == "Swing" and Director.InFirstPerson() then
        local util = v24.Util
        local presentation = v24.Presentation

        if util and presentation then
            local success, result = pcall(presentation.For, data.weaponId, (child2.Kind(data.weaponId) or "Fists"))

            if success and type(result) == "table" then
                local v152

                if data.heavy ~= true then
                    if data.lunge ~= true then
                        v152 = result.swingSound
                    else
                        v152 = result.lungeSound or result.swingSound
                    end
                else
                    v152 = result.heavySound or result.swingSound
                end

                pcall(util.Sound, (v152 or "Swing_Sword"))
            end
        end
    elseif controller and type(controller.PlayFX) == "function" then
        controller.PlayFX(kind, data)
    end

    if v146
        and (kind == "Charge"
            or kind == "Projectile"
            or kind == "Swing"
            or kind == "Reload"
            or kind == "Use"
            or kind == "Heal")
    then
        View.OnFighterEvent(kind, data, Hud.ChargeAt(event.t))
        Hud.OnFighterEvent(kind, data, event.t)
    end
end

local function applyPreroll(a154)
    --[[
      name: applyPreroll
      line: 370
      upvalues:
        Hud (copy, index: 1)
        dispatch (copy, index: 2)
        v24 (copy, index: 3)
        Ballistics (copy, index: 4)
    ]]
    local readIndex
    local events = a154.clip.events
    local v157 = {}

    for _, event in events do
        if event.kind == "ProjectileHit" then
            local text = tostring(event.data.key)

            if v157[text] ~= nil then
                continue
            end

            v157[text] = event.t
        end
    end

    local v161 = {}
    readIndex = 1

    while readIndex <= #events and events[readIndex].t < 0 do
        local event = events[readIndex]
        local data = event.data

        if event.kind == "Anim" then
            local fighter
            local attacker = data.attacker

            if type(attacker) ~= "table" or type(attacker.fighter) ~= "number" then
                fighter = nil
            else
                fighter = attacker.fighter
            end

            if fighter and type(data.name) == "string" then
                v161[fighter] = v161[fighter] or {}

                if data.op == "Hold" then
                    v161[fighter][data.name] = tonumber(data.speed) or 1
                elseif data.op == "Stop" then
                    v161[fighter][data.name] = nil
                end
            end
        else
            local text, v167, effects, v169, number, projectile, v172, kind, pos, vel, attacker, shooter, attacker2, fighter
            local model
            local fighter2
            local fighter3
            local fighter4
            local fighter5
            local fighter6
            local v186, v187, v188, v189, v190, v191, v192, v193, v194, v195, v196, v197, v198, v199, v200, v201, v202, v203 = false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false

            if event.kind ~= "Inv" then
                v188 = true
            else
                fighter = data.fighter

                if type(fighter) ~= "table" then
                    v186 = true
                elseif type(fighter.fighter) ~= "number" then
                    v186 = true
                else
                    fighter6 = fighter.fighter
                    v187 = true
                end
            end

            if v186 then
                fighter6 = nil
                v187 = true
            end

            if v187 then
                if fighter6 ~= a154.focus then
                    v188 = true
                else
                    Hud.OnFighterEvent("Inv", data, event.t)
                end
            end

            if v188 then
                if event.kind ~= "Charge" then
                    v191 = true
                else
                    attacker2 = data.attacker

                    if type(attacker2) ~= "table" then
                        v189 = true
                    elseif type(attacker2.fighter) ~= "number" then
                        v189 = true
                    else
                        fighter5 = attacker2.fighter
                        v190 = true
                    end
                end
            end

            if v189 then
                fighter5 = nil
                v190 = true
            end

            if v190 then
                if fighter5 ~= a154.focus then
                    v191 = true
                else
                    Hud.OnFighterEvent("Charge", data, event.t)
                end
            end

            if v191 then
                if event.kind ~= "Projectile" then
                    v194 = true
                else
                    shooter = data.shooter

                    if type(shooter) ~= "table" then
                        v192 = true
                    elseif type(shooter.fighter) ~= "number" then
                        v192 = true
                    else
                        fighter4 = shooter.fighter
                        v193 = true
                    end
                end
            end

            if v192 then
                fighter4 = nil
                v193 = true
            end

            if v193 then
                if fighter4 == a154.focus then
                    v197 = true
                else
                    v194 = true
                end
            end

            if v194 then
                if event.kind ~= "Swing" then
                    v198 = true
                else
                    attacker = data.attacker

                    if type(attacker) ~= "table" then
                        v195 = true
                    elseif type(attacker.fighter) ~= "number" then
                        v195 = true
                    else
                        fighter3 = attacker.fighter
                        v196 = true
                    end
                end
            end

            if v195 then
                fighter3 = nil
                v196 = true
            end

            if v196 then
                if fighter3 ~= a154.focus then
                    v198 = true
                else
                    v197 = true
                end
            end

            if v197 then
                Hud.OnFighterEvent("Charge", {on = false}, event.t)
            end

            if v198 then
                if event.kind == "Smoke" then
                    local duration = (tonumber(data.duration) or 7) + event.t

                    if 0.4 < duration then
                        data.duration = duration
                        dispatch(a154, event)
                    end
                elseif event.kind ~= "Status" then
                    v199 = true
                elseif data.status ~= "Burn" then
                    v199 = true
                else
                    local duration = (tonumber(data.duration) or 1) + event.t

                    if 0.2 < duration then
                        data.duration = duration
                        dispatch(a154, event)
                    end
                end
            end

            if v199 and event.kind == "Projectile" and -2.5 < event.t and not data.pellets then
                text = tostring(data.key)
                v167 = v157[text]
                effects = v24.Effects
                local shooter2 = data.shooter

                if type(shooter2) ~= "table" then
                    v200 = true
                elseif type(shooter2.fighter) ~= "number" then
                    v200 = true
                else
                    fighter2 = shooter2.fighter
                    v201 = true
                end
            end

            if v200 then
                fighter2 = nil
                v201 = true
            end

            if v201 then
                v169 = fighter2
                v169 = v169 and a154.puppets[fighter2]

                if v167 == nil then
                    v202 = true
                elseif 0 <= v167 then
                    v202 = true
                end
            end

            if v202
                and effects
                and typeof(data.origin) == "Vector3"
                and typeof(data.velocity) == "Vector3"
                and type(data.kind) == "string"
            then
                number = tonumber(data.gravity) or 0
                local ballistics = Ballistics.new(data.origin, data.velocity, number, 0)
                Ballistics.Advance(ballistics, -event.t)
                projectile = effects.Projectile
                v172 = "R|" .. text
                kind = data.kind
                pos = ballistics.pos
                vel = ballistics.vel

                if v169 then
                    model = v169.model
                else
                    model = nil
                end

                v203 = true
            end

            if v203 then
                pcall(projectile, v172, kind, pos, vel, number, model)
            end
        end

        readIndex += 1
    end

    a154.nextEvent = readIndex

    if const util = v24.Util then
        for puppetKey, v210 in v161 do
            local puppet = a154.puppets[puppetKey]

            if puppet and puppet.alive then
                for v212, v213 in v210 do
                    util.PlayHold(puppet.animator, v212, v213)
                end
            end
        end
    end
end

local function aimSegments(result, focus)
    --[[
      name: aimSegments
      line: 446
    ]]
    local v217 = {}
    local v218 = {}

    for _, event in result.events do
        if event.kind == "ProjectileHit" then
            local fighter

            if typeof(event.data.position) ~= "Vector3" then
                continue
            end

            local text = tostring(event.data.key)

            if v217[text] then
                continue
            end

            v217[text] = event.data.position
            local character = event.data.character

            if type(character) == "table" and type(character.fighter) == "number" then
                fighter = character.fighter
            else
                fighter = nil
            end

            if not fighter then
                continue
            end

            v218[text] = fighter
        end
    end

    local v224 = {}
    local t = nil

    for _, event in result.events do
        local data = event.data

        if event.kind == "Charge" then
            local fighter
            local attacker = data.attacker

            if type(attacker) == "table" then
                if type(attacker.fighter) == "number" then
                    fighter = attacker.fighter
                else
                    fighter = nil
                end
            else
                fighter = nil
            end

            if fighter == focus then
                if data.on == true then
                    t = event.t
                    continue
                end

                t = nil
                continue
            end
        end

        if event.kind == "Projectile" then
            local fighter
            local v232
            local shooter = data.shooter

            if type(shooter) ~= "table" or type(shooter.fighter) ~= "number" then
                fighter = nil
            else
                fighter = shooter.fighter
            end

            if fighter ~= focus then
                continue
            end
            if typeof(data.origin) ~= "Vector3" then
                continue
            end
            if typeof(data.velocity) ~= "Vector3" then
                continue
            end
            if not (0.1 < data.velocity.Magnitude) then
                continue
            end

            local text = tostring(data.key)
            v232 = if const v235 = v217[text] then v235 else v217[text .. "/1"]
            local v236 = not v232 and 80 or math.clamp((v232 - data.origin).Magnitude, 8, 400)
            local v237 = if t and event.t - t < 2.5 then t else event.t - 0.45
            table.insert(v224, {t0 = v237 - 0.05, t1 = event.t + 0.4, shot = event.t, point = data.origin + (data.velocity.Unit * v236)})
            t = nil
        end
    end

    return v224, v217, v218
end

local function startFall(a239, puppet, state, frameT)
    --[[
      name: startFall
      line: 488
      upvalues:
        workspace (copy, index: 1)
    ]]
    local vector3
    local v244
    local at
    local cf = state.cf
    local vector32 = Vector3.new(state.vel.X, 0, state.vel.Z)
    local vector33 = Vector3.new(cf.LookVector.X, 0, cf.LookVector.Z)

    if not (0.05 < vector33.Magnitude) then
        vector3 = Vector3.new(0, 0, -1)
    else
        vector3 = vector33.Unit
    end

    local v249 = if 3 < vector32.Magnitude then vector32.Unit else -vector3
    local y = puppet.hum.HipHeight + puppet.root.Size.Y / 2
    v244 = if const raycastResult = workspace:Raycast(cf.Position + Vector3.new(0, 1, 0), Vector3.new(0, -(y + 8), 0), a239.params) then raycastResult.Position.Y else cf.Position.Y - y
    local vector34 = Vector3.new(cf.Position.X, v244, cf.Position.Z)
    local stand = CFrame.lookAt(vector34 + Vector3.new(0, y, 0), (vector34 + Vector3.new(0, y, 0)) + vector3)
    local fall = {}

    if not (frameT <= 0.05) then
        at = frameT
    else
        at = -10
    end

    fall.at = at
    fall.stand = stand
    fall.pivot = vector34 + Vector3.new(0, 0.550000011920929, 0)
    fall.axis = (Vector3.new(0, 1, 0)):Cross(v249).Unit
    puppet.fall = fall
end

local function fallPose(puppet, frameT)
    --[[
      name: fallPose
      line: 507
    ]]
    local fall = puppet.fall
    local clampedValue = math.clamp((frameT - fall.at) / 0.45, 0, 1)
    local pivot = fall.pivot

    return CFrame.new(pivot) * CFrame.fromAxisAngle(fall.axis, ((clampedValue * clampedValue) * math.pi) / 2) * CFrame.new(-pivot) * fall.stand
end

local function applyState(a262, puppet, state, a265: number, frameT)
    --[[
      name: applyState
      line: 514
      upvalues:
        child (copy, index: 1)
        Puppets (copy, index: 2)
        partList (copy, index: 3)
        cframeList (copy, index: 4)
        fallPose (copy, index: 5)
        onPuppetDied (copy, index: 6)
        startFall (copy, index: 7)
        setItem (copy, index: 8)
        v24 (copy, index: 9)
    ]]
    local v267 = not state.present or not bit32.btest(state.flags, child.F_ALIVE)

    if puppet.fall and v267 then
        Puppets.SetVisible(puppet, true)
        a265 += 1
        partList[a265] = puppet.root
        cframeList[a265] = fallPose(puppet, frameT)

        return a265
    end

    if not state.present then
        Puppets.SetVisible(puppet, false)
        return a265
    end

    Puppets.SetVisible(puppet, true)
    local alive = bit32.btest(state.flags, child.F_ALIVE)

    if alive ~= puppet.alive then
        puppet.alive = alive

        if alive then
            puppet.fall = nil
        else
            onPuppetDied(puppet)
            startFall(a262, puppet, state, frameT)
        end
    end

    a265 += 1
    partList[a265] = puppet.root
    cframeList[a265] = if puppet.fall then fallPose(puppet, frameT) else state.cf

    if alive then
        local v269 = if 0 < state.item then a262.clip.items[state.item] else nil

        if v269 ~= puppet.itemId then
            setItem(puppet, v269)
        end

        local blocking = bit32.btest(state.flags, child.F_BLOCKING)

        if blocking ~= puppet.blocking then
            puppet.blocking = blocking

            if v24.Guard then
                pcall(v24.Guard.Set, puppet.model, blocking)
            end
        end
    end

    return a265
end

local v271 = nil
local v272 = false
local clampedValue = 1

local function clipTime(a275)
    --[[
      name: clipTime
      line: 564
      upvalues:
        clampedValue (ref, index: 1)
        v271 (ref, index: 2)
        v272 (ref, index: 3)
    ]]
    if a275.phase ~= "play" then
        if a275.phase == "intro" then
            return 0
        end

        return a275.lastT
    end

    local v276 = (os.clock() - a275.t0) * clampedValue
    local startTime = a275.payload.startTime

    if not v271 or type(startTime) ~= "number" or not (v271 - startTime <= v276) then
        return v276
    end

    if not v272 then
        v272 = true

        for _, puppet in a275.puppets do
            for _, playingAnimationTrack in puppet.animator:GetPlayingAnimationTracks() do
                playingAnimationTrack:AdjustSpeed(0)
            end
        end
    end

    a275.t0 = os.clock() - ((v271 - startTime) / clampedValue)

    return v271 - startTime
end

local v282 = nil

local function diagInspect(a284)
    --[[
      name: diagInspect
      line: 589
      upvalues:
        Puppets (copy, index: 1)
        Diag (copy, index: 2)
    ]]
    return Puppets.Inspect(a284, Diag.FAR)
end

local function step(a286)
    --[[
      name: step
      line: 593
      upvalues:
        v41 (ref,  index: 1)
        clampedValue (ref,  index: 2)
        clipTime (copy, index: 3)
        dispatch (copy, index: 4)
        Clip (copy, index: 5)
        applyState (copy, index: 6)
        partList (copy, index: 7)
        cframeList (copy, index: 8)
        Hud (copy, index: 9)
        workspace (copy, index: 10)
        v272 (ref,  index: 11)
        Locomotion (copy, index: 12)
        child (copy, index: 13)
        v24 (copy, index: 14)
        Stage (copy, index: 15)
        PoseTrace (copy, index: 16)
        Director (copy, index: 17)
        View (copy, index: 18)
        Diag (copy, index: 19)
        diagInspect (copy, index: 20)
        runService (copy, index: 21)
        v79 (ref,  index: 22)
        logCamera (copy, index: 23)
        v282 (ref,  index: 24)
    ]]
    local frameT
    local v288 = v41
    if not v288 then
        return
    end

    a286 *= clampedValue
    local timestamp = os.clock()
    local clip = v288.clip
    local v291 = clipTime(v288)

    if v288.phase == "play" then
        v291 = math.min(v291, clip.duration)
        local events = clip.events

        while v288.nextEvent <= #events do
            if not (events[v288.nextEvent].t <= v291) then
                break
            end

            local event = events[v288.nextEvent]
            v288.nextEvent += 1
            local success, result = pcall(dispatch, v288, event)
            if not success then
                local stats = v288.stats
                stats.fxErrors += 1

                if not (v288.stats.fxErrors <= 3) then
                    continue
                end

                warn("[Replay] event error:", event.kind, result)
            end
        end
    end

    local v297 = 0
    frameT = v291

    for v298, puppet in v288.puppets do
        local state = v288.states[v298]
        Clip.Sample(clip, clip.fighters[v298], frameT, state)
        v297 = applyState(v288, puppet, state, v297, frameT)
    end

    for index = v297 + 1, #partList do
        partList[index] = nil
        cframeList[index] = nil
    end

    if v288.phase == "play" then
        local state = v288.states[v288.focus]

        if state and state.present then
            local update = Hud.Update
            local v304 = if 0 < state.item then clip.items[state.item] else nil
            update(frameT, v304, state.hp, state.armor, state.flags)
        end
    end

    if 0 < v297 then
        workspace:BulkMoveTo(partList, cframeList, Enum.BulkMoveMode.FireCFrameChanged)
    end

    local locoAcc = v288.locoAcc
    local v306 = v272 and 0 or a286
    v288.locoAcc = locoAcc + v306

    if 0.03333333333333333 <= v288.locoAcc then
        local v307 = math.min(v288.locoAcc, 0.1)
        v288.locoAcc = 0
        local timestamp2 = os.clock()

        for stateKey, puppet in v288.puppets do
            local state = v288.states[stateKey]

            if puppet.loco and puppet.visible then
                Locomotion.Step(puppet.loco, v307, timestamp2, state.vel, bit32.btest(state.flags, child.F_GROUNDED), bit32.btest(state.flags, child.F_SLIDING), puppet.alive)
            end
        end
    end

    local holdAcc = v288.holdAcc
    local v313 = v272 and 0 or a286
    v288.holdAcc = holdAcc + v313

    if 0.5 <= v288.holdAcc then
        v288.holdAcc = 0
        local util = v24.Util

        for _, puppet in v288.puppets do
            if util then
                if not puppet.hold then
                    continue
                end
                if not puppet.alive then
                    continue
                end
                if not puppet.visible then
                    continue
                end

                local track = util.GetTrack(puppet.animator, puppet.hold)

                if track and not track.IsPlaying then
                    util.PlayAnim(puppet.animator, puppet.hold, 1, 0.2)
                end
            end
        end
    end

    Stage.Tick()
    local startTime = v288.payload.startTime

    if v288.phase == "play" and type(startTime) == "number" and PoseTrace.Active() then
        for _, puppet in v288.puppets do
            if puppet.visible and puppet.alive then
                PoseTrace.Compare(puppet.id, puppet.model, startTime + frameT)
            end
        end
    end

    local puppet = v288.puppets[v288.focus]
    local state = v288.states[v288.focus]
    local camera = workspace.CurrentCamera

    if camera.CameraType ~= Enum.CameraType.Scriptable then
        camera.CameraType = Enum.CameraType.Scriptable
    end

    if state and state.present then
        local v324
        local position = state.cf.Position
        local lookVector = state.cf.LookVector
        local vector3 = Vector3.new(lookVector.X, 0, lookVector.Z)
        local v328 = 0
        local team = v288.clip.fighters[v288.focus].team

        if 0.1 < vector3.Magnitude then
            local v330
            local unit = vector3.Unit
            v330 = v328

            for stateKey, puppet2 in v288.puppets do
                local state2 = v288.states[stateKey]

                if puppet2.team ~= team then
                    if not puppet2.visible then
                        continue
                    end
                    if not puppet2.alive then
                        continue
                    end
                    if not state2.present then
                        continue
                    end

                    local v335 = state2.cf.Position - position
                    local vector32 = Vector3.new(v335.X, 0, v335.Z)
                    local magnitude = vector32.Magnitude

                    if not (0.5 < magnitude) then
                        continue
                    end
                    if not (magnitude < 16) then
                        continue
                    end
                    if not (0.2 < vector32.Unit:Dot(unit)) then
                        continue
                    end

                    v330 = math.max(v330, (math.clamp(1 - ((magnitude - 5) / 11), 0, 1)))
                end
            end

            v328 = v330
        end

        Director.SetAction(v328)
        Director.SetAimed((bit32.btest(state.flags, child.F_AIMING)))

        if puppet then
            v324 = puppet.alive
        else
            v324 = bit32.btest(state.flags, child.F_ALIVE)
        end

        local v338 = if puppet then puppet.model else nil
        Director.Update(camera, a286, frameT, state.cf, v324, View.Frame(a286, state, v338, v324))
        local afterCamera = View.AfterCamera
        local v340 = Director.InFirstPerson()
        local v341 = if 0 < state.item then clip.items[state.item] else nil
        afterCamera(a286, state, v338, v324, v340, v341, Hud.HeldCharges())
    else
        Director.Update(camera, a286, frameT, nil, false)

        if state then
            View.AfterCamera(a286, state, nil, false, false, nil, nil)
        end
    end

    if v288.phase == "play" then
        if const diagShot = v288.diagShot then
            v288.diagShot = nil
            pcall(Diag.Shot, camera, diagShot)
        end

        v288.diagAcc += a286

        if 0.1 <= v288.diagAcc then
            v288.diagAcc = 0
            pcall(Diag.Frame, v288, camera)
        end
    end

    if v288.phase == "play"
        and v288.diagStage < 2
        and ((v288.diagStage == 0 and 1.5) or (clip.duration * 0.5)) <= frameT
    then
        v288.diagStage += 1
        local check = Diag.Check
        local v344 = v288.diagStage ~= 1 and "mid" or "early"
        local success, result = pcall(
            check,
            v344,
            v288,
            Director.InFirstPerson(),
            diagInspect,
            function(a347)
                --[[
                  line: 730
                  upvalues:
                    Clip (copy, index: 1)
                    clip (copy, index: 2)
                    frameT (ref,  index: 3)
                    v288 (copy, index: 4)
                ]]
                Clip.Sample(clip, clip.fighters[a347], frameT, v288.states[a347])
            end
        )

        if not success and runService:IsStudio() then
            warn("[Replay] diag failed:", result)
        end
    end

    if v79 then
        logCamera(v288, frameT, camera)
    end

    local elapsedTime = os.clock() - timestamp
    local stats = v288.stats
    stats.frames += 1
    local stats2 = v288.stats
    stats2.stepTime += elapsedTime
    v288.stats.maxStep = math.max(v288.stats.maxStep, elapsedTime)

    if v288.phase == "play" and clip.duration <= frameT and not v272 then
        v282(v288)
    end
end

local function cleanup(a352)
    --[[
      name: cleanup
      line: 751
      upvalues:
        v41 (ref,  index: 1)
        v272 (ref,  index: 2)
        runService (copy, index: 3)
        Overlay (copy, index: 4)
        v24 (copy, index: 5)
        workspace (copy, index: 6)
        v32 (copy, index: 7)
        Puppets (copy, index: 8)
        View (copy, index: 9)
        Diag (copy, index: 10)
        Hud (copy, index: 11)
        Stage (copy, index: 12)
    ]]
    if v41 ~= a352 then
        return
    end

    v41 = nil
    v272 = false
    pcall(
        function()
            --[[
              line: 757
              upvalues:
                runService (copy, index: 1)
            ]]
            runService:UnbindFromRenderStep("TribesReplay")
        end
    )
    Overlay.UnbindSkip()

    if const effects = v24.Effects then
        effects.ParamsOverride = nil
    end

    if const fx = workspace:FindFirstChild("FX") then
        for _, descendant in fx:GetDescendants() do
            if descendant:IsA("WeldConstraint") then
                if descendant.Name ~= "StickWeld" then
                    continue
                end
                if not descendant.Part0 then
                    continue
                end
                if not descendant.Part0:IsDescendantOf(a352.folder) then
                    continue
                end

                local parent = descendant.Parent and descendant.Parent.Parent

                if const parent2 = if parent and parent:IsA("Model") then parent else descendant.Parent then
                    for _, descendant2 in parent2:GetDescendants() do
                        if descendant2:IsA("BasePart") then
                            descendant2.Anchored = true
                            descendant2.Transparency = 1
                        end
                    end

                    if parent2:IsA("BasePart") then
                        parent2.Anchored = true
                        parent2.Transparency = 1
                    end
                end

                descendant:Destroy()
            end
        end
    end

    for _, puppet in a352.puppets do
        if v24.Guard and puppet.blocking then
            pcall(v24.Guard.Set, puppet.model, false)
        end

        local procedural = v32.Procedural

        if not procedural or type(procedural.Untrack) ~= "function" then
            Puppets.Destroy(puppet)
        else
            pcall(procedural.Untrack, puppet.model)
            Puppets.Destroy(puppet)
        end
    end

    pcall(View.End)
    pcall(Diag.End)
    a352.folder:Destroy()
    pcall(Hud.End)
    Stage.Leave()
end

v282 = function(a364)
    --[[
      line: 805
      upvalues:
        v41 (ref,  index: 1)
        clipTime (copy, index: 2)
        Diag (copy, index: 3)
        Overlay (copy, index: 4)
        cleanup (copy, index: 5)
        child (copy, index: 6)
    ]]
    if v41 ~= a364 or a364.phase == "outro" then
        return
    end

    a364.lastT = clipTime(a364)
    a364.phase = "outro"
    pcall(Diag.Flush)
    Overlay.UnbindSkip()
    Overlay.Outro(
        function()
            --[[
              line: 813
              upvalues:
                cleanup (copy, index: 1)
                a364 (copy, index: 2)
            ]]
            cleanup(a364)
        end,
        child.OUTRO_TIME
    )
end

function v21.Skip()
    --[[
      name: Skip
      line: 818
      upvalues:
        v41 (ref, index: 1)
        v282 (ref, index: 2)
    ]]
    if const v365 = v41 then
        v282(v365)
    end
end

function v21.Stop(a366)
    --[[
      name: Stop
      line: 825
      upvalues:
        v41 (ref,  index: 1)
        Overlay (copy, index: 2)
        cleanup (copy, index: 3)
    ]]
    local v367 = v41
    if not v367 then
        return
    end

    Overlay.Hide()
    cleanup(v367)
end

function v21.IsPlaying()
    --[[
      name: IsPlaying
      line: 835
      upvalues:
        v41 (ref, index: 1)
    ]]
    return v41 ~= nil
end

local function findMap(origin)
    --[[
      name: findMap
      line: 840
      upvalues:
        workspace (copy, index: 1)
        localPlayer (copy, index: 2)
    ]]
    local arenas = workspace:FindFirstChild("Arenas")
    if not arenas then
        return nil
    end

    local v371 = localPlayer:GetAttribute("MatchId")
    local child2 = type(v371) == "string" and arenas:FindFirstChild(v371)

    if const map = child2 and child2:FindFirstChild("Map") then
        return map
    end

    local map2

    for _, child in arenas:GetChildren() do
        map2 = child:FindFirstChild("Map")
        local ringCenterX = child:GetAttribute("RingCenterX")
        local ringCenterZ = child:GetAttribute("RingCenterZ")

        if map2
            and type(ringCenterX) == "number"
            and type(ringCenterZ) == "number"
            and math.abs(ringCenterX - origin.X) < 5
            and math.abs(ringCenterZ - origin.Z) < 5
        then
            return map2
        end
    end

    return nil
end

local function outline(instance: Instance?, outlineColor: Color3)
    --[[
      name: outline
      line: 861
    ]]
    local replayOutline = Instance.new("Highlight")
    replayOutline.Name = "ReplayOutline"
    replayOutline.DepthMode = Enum.HighlightDepthMode.Occluded
    replayOutline.FillTransparency = 1
    replayOutline.OutlineTransparency = 0.35
    replayOutline.OutlineColor = outlineColor
    replayOutline.Adornee = instance
    replayOutline.Parent = instance
end

function v21.Play(payload)
    --[[
      name: Play
      line: 872
      upvalues:
        v41 (ref,  index: 1)
        v21 (copy, index: 2)
        Clip (copy, index: 3)
        loadCombat (copy, index: 4)
        aimSegments (copy, index: 5)
        Director (copy, index: 6)
        runService (copy, index: 7)
        workspace (copy, index: 8)
        count (ref,  index: 9)
        findMap (copy, index: 10)
        Locomotion (copy, index: 11)
        Diag (copy, index: 12)
        child (copy, index: 13)
        PoseTrace (copy, index: 14)
        Stage (copy, index: 15)
        View (copy, index: 16)
        v24 (copy, index: 17)
        localPlayer (copy, index: 18)
        Puppets (copy, index: 19)
        v32 (copy, index: 20)
        Overlay (copy, index: 21)
        step (copy, index: 22)
        Hud (copy, index: 23)
        applyPreroll (copy, index: 24)
    ]]
    if type(payload) ~= "table" or typeof(payload.clip) ~= "buffer" then
        return
    end

    if v41 then
        v21.Stop("replaced")
    end

    local success, result, v386 = pcall(Clip.Decode, payload.clip)

    if success and result then
        local fighter = result.fighters[result.focus]

        if not fighter or fighter.n == 0 then
            warn("[Replay] clip has no samples for its fighter")
            return
        end

        local filterDescendantsInstances
        local model
        loadCombat()
        local v390, landed, landedOn = aimSegments(result, result.focus)
        Director.SetSegments(v390)
        local replayViewLinear = runService:IsStudio() and workspace:GetAttribute("ReplayViewLinear") == true
        Clip.LinearView = replayViewLinear
        count += 1
        local replay = Instance.new("Folder")
        replay.Name = "Replay"
        local map = findMap(result.origin)
        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Include
        params.IgnoreWater = true

        if map then
            filterDescendantsInstances = {map}
        else
            filterDescendantsInstances = {}
        end

        params.FilterDescendantsInstances = filterDescendantsInstances
        local setWorld = Director.SetWorld
        local v398 = map and {map} or {}
        setWorld(v398)
        local setGround = Locomotion.SetGround
        local v400 = map and {map} or {}
        setGround(v400)
        local v401 = {
            phase = "intro",
            t0 = 0,
            lastT = 0,
            nextEvent = 1,
            locoAcc = 0,
            holdAcc = 0,
            chain = 0,
            lastKillT = -math.huge,
            built = false,
            diagStage = 0,
            diagAcc = 0,
            diagShot = nil,
            token = count,
            clip = result,
            payload = payload,
            puppets = {},
            states = {},
            folder = replay,
            focus = result.focus,
            params = params,
            landed = landed,
            landedOn = landedOn,
            healthy = {},
            stats = {events = 0, fxErrors = 0, frames = 0, stepTime = 0, maxStep = 0, missing = 0, standIns = 0, hits = 0, hitErrSum = 0, hitErrMax = 0, kinds = {}}
        }
        v41 = v401

        for stateKey in result.fighters do
            v401.states[stateKey] = Clip.NewState()
        end

        pcall(Diag.Begin, result)
        local v403 = child.INTRO_TIME + result.duration + child.OUTRO_TIME
        PoseTrace.Reset()
        Stage.Enter(v403)
        pcall(View.Begin, params)
        replay.Parent = workspace

        if const effects = v24.Effects then
            effects.ParamsOverride = function(a405)
                --[[
                  line: 943
                  upvalues:
                    v41 (ref,  index: 1)
                    v401 (copy, index: 2)
                ]]
                if a405 and a405:GetAttribute("ReplayPuppet") ~= nil and v41 == v401 then
                    return v401.params
                end

                return nil
            end
        end

        local team = localPlayer:GetAttribute("Team")
        local team2 = fighter.team

        local function makePuppet(a409, a410: boolean?)
            --[[
              name: makePuppet
              line: 952
              upvalues:
                result (copy, index: 1)
                v401 (copy, index: 2)
                Clip (copy, index: 3)
                Puppets (copy, index: 4)
                replay (copy, index: 5)
                Diag (copy, index: 6)
                Locomotion (copy, index: 7)
                v32 (copy, index: 8)
                child (copy, index: 9)
                v24 (copy, index: 10)
                team2 (copy, index: 11)
                Overlay (copy, index: 12)
            ]]
            local fighter = result.fighters[a409]

            if fighter.n == 0 or v401.puppets[a409] then
                return
            end

            local v412
            local v413
            local text
            local v415, v416
            local state = v401.states[a409]
            Clip.Sample(result, fighter, 0, state)
            local v418 = false
            local v419 = -1
            local src
            src, text, v413, v412, v415, v416 = nil, nil, nil, nil, nil, nil

            for _ = 1, 4 do
                local model
                local v423, v424
                local v425

                for v426, puppet in v401.puppets do
                    if v401.healthy[v426] then
                        model = puppet.model
                        break
                    end
                end

                v423, v424, v419 = Puppets.Build(a409, fighter.id, fighter.name, fighter.team, replay, src, model)
                text = text or v424

                if not v423 then
                    break
                end

                v423.root.CFrame = state.cf
                Puppets.SetVisible(v423, true)
                v423.root.CFrame = state.cf
                local success, result2 = pcall(Puppets.Inspect, v423, Diag.FAR)

                if success then
                    v425 = Diag.Evaluate(result2)
                else
                    v425 = nil
                end

                if v425 == nil then
                    if v412 then
                        Puppets.Destroy(v412)
                    end

                    v418 = true
                    v412 = v423
                    break
                end

                if v413 == nil then
                    v413 = v425
                    v415, v416 = v423.src, if success then result2 else nil
                end

                if v412 then
                    Puppets.Destroy(v412)
                end

                src = v423.src
                v412 = v423
            end

            if v413 == nil and text then
                v413, v415 = string.match(text, "^(%w+):(%w+)$")
            end

            pcall(Diag.Built, a409, v412, v413, v415, v416, v419, v418, a410 == true)

            if v412 then
                if a410 then
                    local stats = v401.stats
                    stats.missing -= 1
                end

                v401.healthy[a409] = v418

                if v412.standIn then
                    local stats = v401.stats
                    stats.standIns += 1
                end

                if v412.debugUnparent then
                    v412.model.Parent = nil
                end

                v412.loco = Locomotion.new(v412.hum, v412.root, v412.animator)
                local procedural = v32.Procedural

                if procedural and type(procedural.Track) == "function" then
                    pcall(
                        procedural.Track,
                        v412.model,
                        function()
                            --[[
                              line: 1033
                              upvalues:
                                v401 (copy, index: 1)
                                a409 (copy, index: 2)
                                child (copy, index: 3)
                            ]]
                            local state = v401.states[a409]
                            return state.vel, bit32.btest(state.flags, child.F_GROUNDED), (bit32.btest(state.flags, child.F_SLIDING))
                        end
                    )
                end

                local poses = v24.Poses

                if poses and type(poses.Watch) == "function" then
                    pcall(poses.Watch, v412.model)
                end

                if fighter.team ~= team2 then
                    local model = v412.model
                    local enemy = Overlay.Colors.Enemy
                    local replayOutline = Instance.new("Highlight")
                    replayOutline.Name = "ReplayOutline"
                    replayOutline.DepthMode = Enum.HighlightDepthMode.Occluded
                    replayOutline.FillTransparency = 1
                    replayOutline.OutlineTransparency = 0.35
                    replayOutline.OutlineColor = enemy
                    replayOutline.Adornee = model
                    replayOutline.Parent = model
                end

                v401.puppets[a409] = v412
            elseif not a410 then
                local stats = v401.stats
                stats.missing += 1
            end
        end

        makePuppet(result.focus)
        local puppet = v401.puppets[result.focus]
        local showIntro = Overlay.ShowIntro
        local v441 = {name = tostring((payload.name or fighter.name)), title = tostring((payload.title
            or result.title))}

        if puppet then
            model = puppet.model
        else
            model = nil
        end

        v441.portrait = model
        v441.ally = team == team2
        showIntro(v441)
        Overlay.BindSkip(v21.Skip)
        Clip.Sample(result, fighter, 0, v401.states[result.focus])
        local setShoulderSide = Director.SetShoulderSide
        local v443 = fighter.left and -1 or 1
        setShoulderSide(v443)
        Director.Begin(v401.states[result.focus].cf, result.duration)
        runService:BindToRenderStep("TribesReplay", Enum.RenderPriority.Camera.Value + 5, step)

        task.spawn(
            function()
                --[[
                  line: 1062
                  upvalues:
                    result (copy, index: 1)
                    v41 (ref,  index: 2)
                    v401 (copy, index: 3)
                    makePuppet (copy, index: 4)
                ]]
                for v444 in result.fighters do
                    if v41 ~= v401 then
                        return
                    end

                    if v444 ~= result.focus then
                        local success, result2 = pcall(makePuppet, v444)
                        if not success then
                            warn("[Replay] puppet failed:", result2)
                        end

                        task.wait()
                    end
                end

                for puppetKey, fighter in result.fighters do
                    if v41 ~= v401 then
                        return
                    end

                    if 0 < fighter.n and not v401.puppets[puppetKey] then
                        pcall(makePuppet, puppetKey, true)
                    end
                end

                v401.built = true
            end
        )

        task.delay(
            child.INTRO_TIME,
            function()
                --[[
                  line: 1086
                  upvalues:
                    v41 (ref,  index: 1)
                    v401 (copy, index: 2)
                    Hud (copy, index: 3)
                    result (copy, index: 4)
                    applyPreroll (copy, index: 5)
                    Overlay (copy, index: 6)
                ]]
                if v41 ~= v401 or v401.phase ~= "intro" then
                    return
                end

                v401.phase = "play"
                v401.t0 = os.clock()
                pcall(Hud.Begin, result.items)
                local success, result2 = pcall(applyPreroll, v401)
                if not success then
                    warn("[Replay] preroll failed:", result2)
                end

                Overlay.Reveal()
            end
        )

        return
    end

    local warn = warn
    local v452 = if success then v386 else result
    warn("[Replay] bad clip:", v452)
end

function v21.DebugFreeze(a453)
    --[[
      name: DebugFreeze
      line: 1102
      upvalues:
        v271 (ref, index: 1)
        v272 (ref, index: 2)
    ]]
    v271 = a453
    v272 = false
end

function v21.DebugRate(a454: number)
    --[[
      name: DebugRate
      line: 1108
      upvalues:
        clampedValue (ref, index: 1)
    ]]
    if type(a454) ~= "number" or not (0 < a454) then
        clampedValue = 1
    else
        clampedValue = math.clamp(a454, 0.05, 4)
    end
end

function v21.DebugCamLog(a455)
    --[[
      name: DebugCamLog
      line: 1114
      upvalues:
        v79 (ref,  index: 1)
        Clip (copy, index: 2)
    ]]
    local v456 = v79

    if a455 == true then
        v79 = {t = {}, yaw = {}, pitch = {}, x = {}, y = {}, z = {}, fov = {}, shots = {}, pending = {}}
        return true
    end

    if a455 == false then
        v79 = nil
    end

    if not v456 then
        return false
    end

    return {t = v456.t, yaw = v456.yaw, pitch = v456.pitch, x = v456.x, y = v456.y, z = v456.z, fov = v456.fov, shots = v456.shots, startTime = v456.startTime, focus = v456.focus, duration = v456.duration, linear = Clip.LinearView}
end

function v21.DebugPuppet(a457)
    --[[
      name: DebugPuppet
      line: 1129
      upvalues:
        v41 (ref, index: 1)
    ]]
    local v458 = v41
    if not v458 then
        return nil
    end

    for _, puppet in v458.puppets do
        if puppet.id == a457 then
            return puppet.model
        end
    end

    return nil
end

function v21.DebugAnim()
    --[[
      name: DebugAnim
      line: 1143
      upvalues:
        v41 (ref, index: 1)
    ]]
    local v461 = v41
    if not v461 then
        return {playing = false}
    end

    local v462 = {}

    for _, puppet in v461.puppets do
        local tracks = {}

        for _, playingAnimationTrack in puppet.animator:GetPlayingAnimationTracks() do
            local animation = playingAnimationTrack.Animation
            local stringFormat = string.format
            local name = animation and animation.Name or "?"
            table.insert(tracks, stringFormat("%s w%.2f s%.2f t%.2f/%.2f %s", name, playingAnimationTrack.WeightCurrent, playingAnimationTrack.Speed, playingAnimationTrack.TimePosition, playingAnimationTrack.Length, playingAnimationTrack.Priority.Name))
        end

        local joints = {}

        for _, v473 in {"Root", "Waist", "RightShoulder", "LeftHip"} do
            local v474 = puppet.model:FindFirstChild(v473, true)

            if v474 and v474:IsA("Motor6D") then
                local _, v476 = v474.Transform:ToAxisAngle()
                local stringFormat = string.format
                local name = v474.Part0 and v474.Part0.Name or "nil"
                local name2 = v474.Part1 and v474.Part1.Name or "nil"
                table.insert(joints, stringFormat("%s %s->%s %.1fdeg", v473, name, name2, (math.deg(v476))))
            else
                local v480 = not v474 and "missing" or v474.ClassName
                table.insert(joints, v473 .. " " .. v480)
            end
        end

        v462[puppet.id] = {visible = puppet.visible, alive = puppet.alive, item = puppet.itemId, hold = puppet.hold, tracks = tracks, joints = joints}
    end

    return v462
end

function v21.DebugState()
    --[[
      name: DebugState
      line: 1171
      upvalues:
        v41 (ref,  index: 1)
        clipTime (copy, index: 2)
        Director (copy, index: 3)
    ]]
    local v481 = v41
    if not v481 then
        return {playing = false}
    end

    local puppets = {}

    for v483, puppet in v481.puppets do
        local state = v481.states[v483]
        local v486 = {index = v483, id = puppet.id, visible = puppet.visible, alive = puppet.alive, item = puppet.itemId, hold = puppet.hold, standIn = puppet.standIn, src = puppet.src, liveParts = puppet.liveParts, pos = if state.present then state.cf.Position else nil}
        v486.playing = #puppet.animator:GetPlayingAnimationTracks()
        table.insert(puppets, v486)
    end

    local v487 = {
        playing = true,
        phase = v481.phase,
        t = clipTime(v481),
        duration = v481.clip.duration,
        focus = v481.clip.fighters[v481.focus].id,
        focusName = v481.clip.fighters[v481.focus].name,
        startTime = v481.payload.startTime,
        firstPerson = Director.InFirstPerson(),
        title = v481.clip.title,
        events = #v481.clip.events,
        dispatched = v481.nextEvent - 1,
        bytes = v481.clip.bytes,
        puppets = puppets,
        stats = v481.stats,
        stepMsAvg = if 0 < v481.stats.frames then v481.stats.stepTime * 1000 / v481.stats.frames else 0
    }
    v487.stepMsMax = v481.stats.maxStep * 1000
    return v487
end

return v21