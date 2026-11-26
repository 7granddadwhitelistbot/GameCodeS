local _ = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local workspace = game:GetService("Workspace")
local shared = replicatedStorage:WaitForChild("Shared")
local ReplayCodec = require(shared:WaitForChild("ReplayCodec"))
local Combat = require(shared:WaitForChild("Combat"))
local Weapons = require(shared:WaitForChild("Weapons"))
local HudBridge = require(script.Parent.HudBridge)
local v9 = {}
local parent = script.Parent.Parent
local color3 = Color3.fromRGB(228, 232, 240)
local color32 = Color3.fromRGB(150, 200, 255)
local v13 = {}

local function mod(childName: string)
    --[[
      name: mod
      line: 35
      upvalues:
        v13 (copy, index: 1)
        parent (copy, index: 2)
    ]]
    local v16 = v13[childName]
    if v16 == nil then
        local instance = parent:FindFirstChild("Combat")
        instance = instance and instance:FindFirstChild(childName)
        v16 = false

        if instance and instance:IsA("ModuleScript") then
            local success, result = pcall(require, instance)

            if success and type(result) == "table" then
                v16 = result
            end
        end

        v13[childName] = v16
    end

    return v16 or nil
end

local v20 = {active = false, src = nil, hum = nil, heldId = nil, style = "Dot", charge = nil, aiming = false, blocking = false, hp = -1, armor = -1, ui = false, alive = true, items = {}, slots = {}}

local function now()
    --[[
      name: now
      line: 88
      upvalues:
        workspace (copy, index: 1)
    ]]
    return workspace:GetServerTimeNow()
end

local function presetOf(a23)
    --[[
      name: presetOf
      line: 92
      upvalues:
        mod (copy, index: 1)
        Combat (copy, index: 2)
    ]]
    local v24 = mod("Presentation")
    if not v24 then
        return {}
    end

    local success, result = pcall(v24.For, a23, Combat.Kind(a23))

    if success and type(result) == "table" then
        return result
    end

    return {}
end

local function tuningOf(a28)
    --[[
      name: tuningOf
      line: 101
      upvalues:
        Combat (copy, index: 1)
    ]]
    local success, result = pcall(Combat.Tuning, a28)

    if success and type(result) == "table" then
        return result
    end

    return {}
end

local function heldSlot()
    --[[
      name: heldSlot
      line: 108
      upvalues:
        v20 (copy, index: 1)
    ]]
    for _, slot in v20.slots do
        if slot.id == v20.heldId then
            return slot
        end
    end

    return nil
end

local function refreshPips()
    --[[
      name: refreshPips
      line: 117
      upvalues:
        mod (copy, index: 1)
        v20 (copy, index: 2)
        Combat (copy, index: 3)
        presetOf (copy, index: 4)
        Weapons (copy, index: 5)
    ]]
    local v35 = mod("Hud")

    if not v35 or not v20.src then
        return
    end

    local slot
    local ammo
    local maxAmmo
    local charges
    local maxCharges
    local v41
    local heldId = v20.heldId

    for _, slot2 in v20.slots do
        if slot2.id == v20.heldId then
            slot = slot2
            break
        end
    end

    local v45 = Combat.Kind(heldId) or "Fists"
    local tool = slot and slot.tool

    local function num(a48)
        --[[
          name: num
          line: 126
          upvalues:
            tool (copy, index: 1)
        ]]
        local v49 = tool and tool:GetAttribute(a48)

        if type(v49) ~= "number" then
            return nil
        end

        return v49
    end

    local ammo2 = tool and tool:GetAttribute("Ammo")

    if type(ammo2) ~= "number" then
        ammo = nil
    else
        ammo = ammo2
    end

    local maxAmmo2 = tool and tool:GetAttribute("MaxAmmo")

    if type(maxAmmo2) ~= "number" then
        maxAmmo = nil
    else
        maxAmmo = maxAmmo2
    end

    local charges2 = tool and tool:GetAttribute("Charges")

    if type(charges2) ~= "number" then
        charges = nil
    else
        charges = charges2
    end

    local maxCharges2 = tool and tool:GetAttribute("MaxCharges")

    if type(maxCharges2) ~= "number" then
        maxCharges = nil
    else
        maxCharges = maxCharges2
    end

    if Combat.UsesAmmo(v45) and ammo and maxAmmo then
        v35.SetPips(ammo, maxAmmo)
    elseif not charges or not maxCharges or v45 == "Bow" then
        v35.SetPips(0, 0)
    else
        local setPips = v35.SetPips
        local v55 = if v45 ~= "Herbs" and v45 ~= "Trap" then nil else presetOf(heldId).color
        setPips(charges, maxCharges, v55)
    end

    local text = heldId and Weapons.AmmoOf and Weapons.AmmoOf(heldId)
    local model = v20.src.model

    if type(text) ~= "string" then
        v41 = nil
    else
        v41 = model:GetAttribute("Ammo_" .. text)
    end

    local v58 = mod("Util")

    if type(text) == "string" and v58 and v58.AmmoShown and 0 < v58.AmmoLeft(model, text) then
        v35.SetAmmoCount(v58.AmmoShown(model, text))
        return
    end

    if type(v41) ~= "number" then
        v35.SetAmmoCount(nil)
        return
    end

    local setAmmoCount = v35.SetAmmoCount
    local v60 = v58 and v58.AMMO_NOUN and v58.AMMO_NOUN[text] or string.upper(text)
    setAmmoCount(v41, v60)
end

local function refreshArc()
    --[[
      name: refreshArc
      line: 155
      upvalues:
        mod (copy, index: 1)
        v20 (copy, index: 2)
        workspace (copy, index: 3)
        Combat (copy, index: 4)
        color3 (copy, index: 5)
        color32 (copy, index: 6)
    ]]
    local slot
    local v63 = mod("Hud")

    for _, slot2 in v20.slots do
        if slot2.id == v20.heldId then
            slot = slot2
            break
        end
    end

    if not v63 or not slot then
        return
    end

    local v66
    local tool = slot.tool
    local serverTimeNow = workspace:GetServerTimeNow()
    local reloadEndsAt = tool:GetAttribute("ReloadEndsAt")

    if tool:GetAttribute("Reloading") == true and type(reloadEndsAt) == "number" then
        if serverTimeNow < reloadEndsAt then
            local v70
            local v71 = false
            local id = slot.id
            local success, result = pcall(Combat.Tuning, id)

            if success then
                if type(result) ~= "table" then
                    v71 = true
                else
                    v70 = result
                end
            else
                v71 = true
            end

            if v71 then
                v70 = {}
            end

            local v75 = v70.reloadTime or reloadEndsAt - serverTimeNow
            v63.SetArc(v75, color3, (math.max(0, v75 - (reloadEndsAt - serverTimeNow))))

            return
        end
    end

    local nextCharge = tool:GetAttribute("NextCharge")
    local id = slot.id
    local success, result = pcall(Combat.Tuning, id)

    if not success or type(result) ~= "table" then
        v66 = {}
    else
        v66 = result
    end

    local regen = v66.regen

    if type(nextCharge) == "number" and serverTimeNow < nextCharge and type(regen) == "number" then
        v63.SetArc(regen, color32, (math.max(0, regen - (nextCharge - serverTimeNow))))
    end
end

local function setHeld(held)
    --[[
      name: setHeld
      line: 176
      upvalues:
        v20 (copy, index: 1)
        mod (copy, index: 2)
        presetOf (copy, index: 3)
        Combat (copy, index: 4)
        refreshPips (copy, index: 5)
        refreshArc (copy, index: 6)
    ]]
    v20.heldId = held
    v20.charge = nil
    local v83 = mod("Hud")

    if const src = v20.src then
        for _, slot in v20.slots do
            local v87 = if slot.id == held then src.character else src.backpack

            if slot.tool.Parent ~= v87 then
                slot.tool.Parent = v87
            end
        end
    end

    if v83 then
        local v88 = held or Combat.FISTS_ID
        local crosshair = presetOf(v88).crosshair or "Dot"
        v20.style = crosshair
        v83.SetStyle(crosshair)
        v83.SetArc(nil)
        v83.SetBlocking(v20.blocking)
    end

    refreshPips()
    refreshArc()
end

local function applyInv(a91)
    --[[
      name: applyInv
      line: 202
      upvalues:
        v20 (copy, index: 1)
        workspace (copy, index: 2)
        ReplayCodec (copy, index: 3)
        Weapons (copy, index: 4)
        Combat (copy, index: 5)
        refreshPips (copy, index: 6)
        refreshArc (copy, index: 7)
    ]]
    local src = v20.src
    if not src then
        return
    end

    local items = a91.items
    local serverTimeNow = workspace:GetServerTimeNow()
    local v95 = {}

    if type(items) == "string" then
        for index = 0, (#items // ReplayCodec.INV_BYTES) - 1 do
            local success, result, slotIndex, v100, v101, v102, v103, v104, v105, v106 = pcall(string.unpack, ReplayCodec.INV_FORMAT, items, (index * ReplayCodec.INV_BYTES) + 1)
            if not success then
                break
            end

            local weaponId = v20.items[result]

            if weaponId and not (slotIndex < 1) and not (6 < slotIndex) then
                local v108
                v95[slotIndex] = true
                local slot = v20.slots[slotIndex]

                if not slot or slot.id ~= weaponId then
                    if slot then
                        slot.tool:Destroy()
                    end

                    local tool = Instance.new("Tool")
                    local v111 = Weapons.Get(weaponId)
                    tool.Name = if v111 then v111.name else weaponId
                    tool.RequiresHandle = false
                    tool.CanBeDropped = false
                    tool:SetAttribute("WeaponId", weaponId)
                    tool:SetAttribute("SlotIndex", slotIndex)
                    tool:SetAttribute("Kind", Combat.Kind(weaponId))
                    tool.Parent = if weaponId == v20.heldId then src.character else src.backpack
                    v108 = {tool = tool, id = weaponId}
                    v20.slots[slotIndex] = v108
                else
                    v108 = slot
                end

                local tool = v108.tool

                local function set(a114, a115)
                    --[[
                      name: set
                      line: 240
                      upvalues:
                        tool (copy, index: 1)
                    ]]
                    local v116 = if 0 < a115 then a115 - 1 else nil

                    if tool:GetAttribute(a114) ~= v116 then
                        tool:SetAttribute(a114, v116)
                    end
                end

                local ammo = if 0 < v100 then v100 - 1 else nil

                if tool:GetAttribute("Ammo") ~= ammo then
                    tool:SetAttribute("Ammo", ammo)
                end

                local maxAmmo = if 0 < v101 then v101 - 1 else nil

                if tool:GetAttribute("MaxAmmo") ~= maxAmmo then
                    tool:SetAttribute("MaxAmmo", maxAmmo)
                end

                local charges = if 0 < v102 then v102 - 1 else nil

                if tool:GetAttribute("Charges") ~= charges then
                    tool:SetAttribute("Charges", charges)
                end

                local maxCharges = if 0 < v103 then v103 - 1 else nil

                if tool:GetAttribute("MaxCharges") ~= maxCharges then
                    tool:SetAttribute("MaxCharges", maxCharges)
                end

                tool:SetAttribute("Reloading", 0 < v104)
                local reloadEndsAt = not (0 < v104) and 0 or serverTimeNow + v104 / 100
                tool:SetAttribute("ReloadEndsAt", reloadEndsAt)
                local cooldown = not (0 < v105) and 0 or serverTimeNow + v105 / 100
                tool:SetAttribute("Cooldown", cooldown)
                local nextCharge = not (0 < v106) and 0 or serverTimeNow + v106 / 100
                tool:SetAttribute("NextCharge", nextCharge)
            end
        end
    end

    for slotKey, slot in v20.slots do
        if not v95[slotKey] then
            slot.tool:Destroy()
            v20.slots[slotKey] = nil
        end
    end

    for text, v127 in a91 do
        if type(text) == "string" then
            if string.sub(text, 1, 4) == "Ammo" and type(v127) == "number" then
                src.model:SetAttribute(text, v127)
            end
        end
    end

    if type(a91.maxArmor) == "number" then
        src.model:SetAttribute("MaxArmor", a91.maxArmor)
    end

    refreshPips()
    refreshArc()
end

function v9.Begin(items)
    --[[
      name: Begin
      line: 276
      upvalues:
        v9 (copy, index: 1)
        v20 (copy, index: 2)
        mod (copy, index: 3)
        HudBridge (copy, index: 4)
    ]]
    v9.End()
    v20.active = true
    v20.items = items
    v20.slots = {}
    v20.heldId = nil
    v20.charge = nil
    v20.aiming = false
    v20.blocking = false
    v20.hp = -1
    v20.armor = -1
    v20.alive = true
    local replayHudSource = Instance.new("Model")
    replayHudSource.Name = "ReplayHudSource"

    local hum = Instance.new("Humanoid")
    hum.MaxHealth = 100
    hum.Health = 100
    hum.Parent = replayHudSource
    replayHudSource:SetAttribute("Armor", 0)
    replayHudSource:SetAttribute("MaxArmor", 0)
    local backpack = Instance.new("Folder")
    backpack.Name = "Backpack"
    backpack.Parent = replayHudSource

    local character = Instance.new("Folder")
    character.Name = "Character"
    character.Parent = replayHudSource
    v20.src = {backpack = backpack, character = character, model = replayHudSource}
    v20.hum = hum
    local v133 = mod("Controller")

    if v133 and type(v133.SetReplayHud) == "function" then
        pcall(v133.SetReplayHud, true)
    end

    if const v134 = mod("Hud") then
        v134.SetVisible(true)
        v134.SetStyle("Dot")
        v134.SetPips(0, 0)
        v134.SetArc(nil)
        v134.SetAmmoCount(nil)
        v134.SetFrozen(false)
    end

    v20.ui = false

    if const ui = HudBridge.ui then
        v20.ui = pcall(ui.Enter, v20.src)
    end
end

function v9.Active()
    --[[
      name: Active
      line: 324
      upvalues:
        v20 (copy, index: 1)
    ]]
    return v20.active
end

function v9.UiShown()
    --[[
      name: UiShown
      line: 328
      upvalues:
        v20 (copy, index: 1)
    ]]
    return v20.ui
end

function v9.End()
    --[[
      name: End
      line: 332
      upvalues:
        v20 (copy, index: 1)
        mod (copy, index: 2)
        HudBridge (copy, index: 3)
    ]]
    if not v20.active then
        return
    end

    v20.active = false

    if const v136 = mod("Hud") then
        pcall(v136.StopChannel)
        pcall(v136.SetCharge, 0)
        pcall(v136.SetArc, nil)
        pcall(v136.SetAmmoCount, nil)
        pcall(v136.SetVisible, false)
    end

    local ui = HudBridge.ui

    if v20.ui and ui then
        pcall(ui.Leave)
    end

    v20.ui = false
    local v138 = mod("Controller")

    if v138 and type(v138.SetReplayHud) == "function" then
        pcall(v138.SetReplayHud, false)
    end

    if v20.src then
        v20.src.model:Destroy()
    end

    v20.src = nil
    v20.hum = nil
    v20.slots = {}
end

function v9.Update(a139, held, hp: number, armor, a143: number)
    --[[
      name: Update
      line: 365
      upvalues:
        v20 (copy, index: 1)
        mod (copy, index: 2)
        setHeld (copy, index: 3)
        ReplayCodec (copy, index: 4)
        Combat (copy, index: 5)
    ]]
    if not v20.active then
        return
    end

    local v144 = mod("Hud")
    local hum = v20.hum

    if hum and 0.5 <= math.abs(hp - v20.hp) then
        v20.hp = hp
        hum.Health = math.clamp(hp, 0, 100)
    end

    if v20.src and 0.5 <= math.abs(armor - v20.armor) then
        v20.armor = armor
        v20.src.model:SetAttribute("Armor", armor)
    end

    if held ~= v20.heldId then
        setHeld(held)
    end

    if not v144 then
        return
    end

    local alive = bit32.btest(a143, ReplayCodec.F_ALIVE)

    if alive ~= v20.alive then
        v20.alive = alive
        v144.SetVisible(alive)

        if not alive then
            v144.StopChannel()
            v144.SetCharge(0)
            v20.charge = nil
        end
    end

    local blocking = bit32.btest(a143, ReplayCodec.F_BLOCKING)

    if blocking ~= v20.blocking then
        v20.blocking = blocking
        v144.SetBlocking(blocking)
    end

    v20.aiming = bit32.btest(a143, ReplayCodec.F_AIMING)

    if const charge = v20.charge then
        v144.SetCharge((math.clamp((a139 - charge.start) / math.max(0.05, charge.time), 0, 1)))
    end

    if v20.style == "Gun" or v20.style == "Spread" then
        local v149
        local v150
        local v151 = v20.heldId
        local success, result = pcall(Combat.Tuning, v151)

        if not success or type(result) ~= "table" then
            v149 = {}
        else
            v149 = result
        end

        v151 = Combat.Kind(v20.heldId)

        if v151 ~= "Blunderbuss" then
            v150 = v151 == "Crossbow" and 0.4
                or (if v20.aiming then v149.spreadAim or 0 else v149.spreadHip or 0)
        elseif v20.aiming then
            v150 = v149.spreadAim or v149.spread or 6
        else
            v150 = v149.spread or 6
        end

        v144.SetSpread(v150)
    end
end

function v9.ChargeAt(a154)
    --[[
      name: ChargeAt
      line: 418
      upvalues:
        v20 (copy, index: 1)
    ]]
    return if const charge = v20.charge then (math.clamp((a154 - charge.start) / math.max(0.05, charge.time), 0, 1)) else 1
end

function v9.HeldCharges()
    --[[
      name: HeldCharges
      line: 427
      upvalues:
        v20 (copy, index: 1)
    ]]
    local slot

    for _, slot2 in v20.slots do
        if slot2.id == v20.heldId then
            slot = slot2
            break
        end
    end

    if not slot then
        return nil
    end

    local maxCharges = slot.tool:GetAttribute("MaxCharges")
    local charges = slot.tool:GetAttribute("Charges")

    if type(maxCharges) == "number" and 0 < maxCharges and type(charges) == "number" then
        return charges
    end

    return nil
end

function v9.OnFighterEvent(a161, a162, start)
    --[[
      name: OnFighterEvent
      line: 440
      upvalues:
        v20 (copy, index: 1)
        mod (copy, index: 2)
        applyInv (copy, index: 3)
        Combat (copy, index: 4)
        presetOf (copy, index: 5)
        color3 (copy, index: 6)
    ]]
    if not v20.active then
        return
    end

    local v164 = mod("Hud")

    if a161 == "Inv" then
        applyInv(a162)
        return
    end

    if not v164 then
        return
    end

    if a161 == "Charge" then
        local v165
        local v166
        local v167

        if a162.on ~= true then
            v20.charge = nil
            v164.SetCharge(0)

            return
        end

        if type(a162.weaponId) ~= "string" then
            v165 = v20.heldId
        else
            v165 = a162.weaponId
        end

        local success, result = pcall(Combat.Tuning, v165)

        if not success or type(result) ~= "table" then
            v166 = {}
        else
            v166 = result
        end

        local text = tostring(a162.kind)

        if text == "Heavy" then
            v167 = v166.heavy and v166.heavy.charge or 0.6
        elseif text == "Lunge" then
            v167 = v166.lunge and v166.lunge.charge or 0.6
        else
            v167 = if text == "Throw" then v166.drawTime or 0.5 else v166.drawTime or 1
        end

        v20.charge = {kind = text, start = start, time = v167}

        return
    end

    if a161 == "Projectile" then
        local v171 = Combat.Kind(a162.weaponId)
        local v173 = if const charge = v20.charge then math.clamp((start - charge.start) / math.max(0.05, charge.time), 0, 1) else 1

        if v171 ~= "Bow" then
            if Combat.UsesAmmo(v171) then
                local v174
                local v175 = presetOf(a162.weaponId)
                local kick = v164.Kick
                local weaponId = a162.weaponId
                local success, result = pcall(Combat.Tuning, weaponId)

                if not success or type(result) ~= "table" then
                    v174 = {}
                else
                    v174 = result
                end

                local kick2 = v174.kick or v175.kick or 2
                kick(kick2 * 3)
            else
                local v181
                v164.Kick(4)
                local weaponId = a162.weaponId
                local success, result = pcall(Combat.Tuning, weaponId)

                if not success or type(result) ~= "table" then
                    v181 = {}
                else
                    v181 = result
                end

                local cooldown = v181.cooldown

                if type(cooldown) == "number" and 0.3 <= cooldown then
                    v164.SetArc(cooldown, color3)
                end
            end
        else
            v164.Kick(v173 * 6)
        end

        v20.charge = nil
        v164.SetCharge(0)

        return
    end

    local v186

    if a161 == "Swing" then
        if a162.heavy == true or a162.lunge == true then
            local v187
            local weaponId = a162.weaponId
            local result
            v186, result = pcall(Combat.Tuning, weaponId)

            if not v186 or type(result) ~= "table" then
                v187 = {}
            else
                v187 = result
            end

            local v190 = if a162.heavy == true then v187.heavy else v187.lunge
            v186 = v164.SetArc
            local cooldown = type(v190) == "table" and v190.cooldown or 1
            v186(cooldown, color3)
        end

        v20.charge = nil
        v164.SetCharge(0)

        return
    end

    if a161 == "Reload" then
        local v192 = tonumber(a162.duration)
        if not v192 then
            local v193
            local weaponId = a162.weaponId
            local success, result = pcall(Combat.Tuning, weaponId)

            if not success or type(result) ~= "table" then
                v193 = {}
            else
                v193 = result
            end

            v192 = v193.reloadTime or 1
        end

        v164.SetArc(v192, color3)

        return
    end

    if a161 == "Use" and a162.position == nil then
        local v197 = presetOf(a162.weaponId)
        local number = tonumber(a162.duration)

        if not number or not (0 < number) then
            return
        end

        v164.StartChannel((v197.label or "USING"), number, v197.color)

        return
    end

    if a161 == "Heal" then
        v164.StopChannel()
        v164.Flash(Color3.fromRGB(110, 220, 110), 0.35, 0.4)
    end
end

function v9.HitConfirm(a199, a200)
    --[[
      name: HitConfirm
      line: 508
      upvalues:
        mod (copy, index: 1)
        v20 (copy, index: 2)
    ]]
    local v201 = mod("Controller")

    if not v20.active or not v201 or type(v201.ReplayHitConfirm) ~= "function" then
        return
    end

    local replayHitConfirm = v201.ReplayHitConfirm
    local v203 = {victimId = a200 or "", victim = a199.victim, amount = tonumber(a199.amount) or 0, headshot = a199.headshot == true, crit = a199.crit == true, killed = a199.killed == true, blocked = a199.blocked == true, position = a199.position, weaponId = a199.weaponId, dot = a199.dot == true, armor = tonumber(a199.armor)
        or 0, armorBroken = a199.armorBroken == true}
    replayHitConfirm(v203)
end

function v9.DamageTaken(a204, a205)
    --[[
      name: DamageTaken
      line: 530
      upvalues:
        mod (copy, index: 1)
        v20 (copy, index: 2)
    ]]
    local v206 = mod("Controller")

    if not v20.active or not v206 or type(v206.ReplayDamageTaken) ~= "function" then
        return
    end

    local v207
    local weaponId
    local damageType
    local stagger
    local attacker = a204.attacker
    local v212 = a204.fromPosition

    if typeof(v212) ~= "Vector3" and typeof(attacker) == "Instance" then
        local humanoidRootPart = attacker:FindFirstChild("HumanoidRootPart")
        v212 = if humanoidRootPart and humanoidRootPart:IsA("BasePart") then humanoidRootPart.Position else nil
    end

    local replayDamageTaken = v206.ReplayDamageTaken
    local v215 = {knockback = false, amount = tonumber(a204.amount) or 0}

    if typeof(v212) ~= "Vector3" then
        v207 = false
    else
        v207 = v212
    end

    v215.fromPosition = v207
    v215.attackerId = a205 or ""
    v215.attacker = attacker
    v215.headshot = a204.headshot == true
    v215.killed = a204.killed == true
    v215.blocked = a204.blocked == true

    if type(a204.weaponId) ~= "string" then
        weaponId = false
    else
        weaponId = a204.weaponId
    end

    v215.weaponId = weaponId

    if type(a204.damageType) ~= "string" then
        damageType = false
    else
        damageType = a204.damageType
    end

    v215.damageType = damageType

    if type(a204.stagger) ~= "number" then
        stagger = false
    else
        stagger = a204.stagger
    end

    v215.stagger = stagger
    v215.armor = tonumber(a204.armor) or 0
    v215.armorBroken = a204.armorBroken == true
    v215.interrupted = a204.interrupted == true
    replayDamageTaken(v215)

    if a204.interrupted == true then
        if const v216 = mod("Hud") then
            v216.StopChannel()
        end
    end
end

return v9