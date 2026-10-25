local Weapons_upv_1 = require(script.Parent.Weapons)
local tbl_upv_1 = {}
tbl_upv_1.DASH_GAP = 0.3
tbl_upv_1.Ballistics = require(script.Ballistics)
tbl_upv_1.FISTS_ID = "fists"
tbl_upv_1.FISTS = table.freeze({knockback = 8, maxTargets = 1, comboWindow = 0.8, arc = 60, speedMult = 1, range = 6.5, cooldown = 0.38, damage = 10, combo = {1, 1, 1.3}})
local tbl_upv_2 = {Fists = true, Axe = true, Shield = true, Sword = true, Spear = true, Club = true, Gauntlets = true, Dagger = true, Scythe = true, Katana = true, Hatchets = true}
local tbl_upv_3 = {Crossbow = true, Musket = true, Blunderbuss = true, Pistol = true}
local tbl_upv_4 = {Bomb = true, Bow = true, Javelin = true}
local tbl_upv_5 = {Crossbow = true, Musket = true, Bomb = true, Pistol = true, Knives = true, Sling = true, Blunderbuss = true, Bow = true, Javelin = true}
function tbl_upv_1.Tuning(a1)
    --[[
      name: Tuning
      line: 49
      upvalues:
        tbl_upv_1 (copy, index: 1)
        Weapons_upv_1 (copy, index: 2)
    ]]
    if a1 ~= nil and a1 ~= tbl_upv_1.FISTS_ID then
        local v1 = Weapons_upv_1.Get(a1)
        if v1 then
            return v1.tuning
        end
        return tbl_upv_1.FISTS
    end
    return tbl_upv_1.FISTS
end
function tbl_upv_1.Kind(a1)
    --[[
      name: Kind
      line: 57
      upvalues:
        tbl_upv_1 (copy, index: 1)
        Weapons_upv_1 (copy, index: 2)
    ]]
    if a1 ~= nil and a1 ~= tbl_upv_1.FISTS_ID then
        local v2 = Weapons_upv_1.Get(a1)
        return (v2 and (v2.kind)) or nil
    end
    return "Fists"
end
function tbl_upv_1.IsMelee(a1)
    --[[
      name: IsMelee
      line: 65
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    return (a1 ~= nil) and (tbl_upv_2[a1] == true)
end
function tbl_upv_1.UsesAmmo(a1)
    --[[
      name: UsesAmmo
      line: 69
      upvalues:
        tbl_upv_3 (copy, index: 1)
    ]]
    return (a1 ~= nil) and (tbl_upv_3[a1] == true)
end
function tbl_upv_1.IsDrawn(a1)
    --[[
      name: IsDrawn
      line: 73
      upvalues:
        tbl_upv_4 (copy, index: 1)
    ]]
    return (a1 ~= nil) and (tbl_upv_4[a1] == true)
end
function tbl_upv_1.FiresProjectile(a1)
    --[[
      name: FiresProjectile
      line: 77
      upvalues:
        tbl_upv_5 (copy, index: 1)
    ]]
    return (a1 ~= nil) and (tbl_upv_5[a1] == true)
end
function tbl_upv_1.UsesCharges(a1)
    --[[
      name: UsesCharges
      line: 81
    ]]
    local v3 = type(a1.charges) == "number"
    return v3
end
local tbl_upv_6 = {Crossbow = "Gun", Axe = "Melee", Shield = "Melee", Sword = "Melee", Spear = "Melee", Knives = "Throw", Club = "Melee", Gauntlets = "Melee", Dagger = "Melee", Horn = "Use", Bow = "Bow", Musket = "Gun", Fists = "Melee", Katana = "Melee", Scythe = "Melee", Trap = "Use", Herbs = "Use", Bomb = "Throw", Sling = "Throw", Javelin = "Throw", Blunderbuss = "Gun", Pistol = "Gun", Hatchets = "Melee"}
local tbl_upv_7 = {}
function tbl_upv_1.AddSmoke(a1, a2, a3)
    --[[
      name: AddSmoke
      line: 102
      upvalues:
        tbl_upv_7 (copy, index: 1)
    ]]
    table.insert(tbl_upv_7, {pos = a1, radius = a2, untilT = os.clock() + a3})
end
function tbl_upv_1.SmokeBlocks(a1, a2)
    --[[
      name: SmokeBlocks
      line: 107
      upvalues:
        tbl_upv_7 (copy, index: 1)
    ]]
    if #tbl_upv_7 == 0 then
        return false
    end
    local v4 = os.clock()
    local v5 = a2 - a1
    local v6 = v5:Dot(v5)
    local v7 = false
    for n_1 = #tbl_upv_7, 1, -1 do
        local v8 = tbl_upv_7[n_1]
        if v8.untilT <= v4 then
            table.remove(tbl_upv_7, n_1)
            continue
        end
        if v7 then
            continue
        end
        local v9 = ((not (v6 > 0)) and 0) or (math.clamp((v8.pos - a1):Dot(v5) / v6, 0, 1))
        if ((a1 + (v5 * v9)) - v8.pos).Magnitude <= v8.radius * 0.85 then
            v7 = true
        end
    end
    return v7
end
function tbl_upv_1.ArmorSpeed(a1)
    --[[
      name: ArmorSpeed
      line: 133
      upvalues:
        Weapons_upv_1 (copy, index: 1)
    ]]
    local v10
    if type(a1) ~= "string" then
        v10 = nil
    else
        v10 = Weapons_upv_1.Get(a1)
    end
    local v11 = v10 and ((v10.category == "armor") and (v10.tuning.speedMult))
    if type(v11) ~= "number" then
        return 1
    end
    return v11
end
function tbl_upv_1.GuardHp(a1, a2, a3)
    --[[
      name: GuardHp
      line: 143
    ]]
    local v12 = tonumber(a2.max) or 100
    if not a1 then
        return v12, v12
    end
    local v13 = a1:GetAttribute("GuardHp")
    local v14 = a1:GetAttribute("GuardHitAt")
    if type(v13) == "number" and type(v14) == "number" then
        return math.min(v12, v13 + (math.max(0, (a3 - v14) - (tonumber(a2.regenDelay) or 2)) * (tonumber(a2.regen) or 30))), v12
    end
    return v12, v12
end
function tbl_upv_1.GuardBrokenLeft(a1, a2)
    --[[
      name: GuardBrokenLeft
      line: 158
    ]]
    local v15 = a1 and (a1:GetAttribute("GuardBroken"))
    if type(v15) ~= "number" then
        return 0
    end
    return (math.max(0, v15 - a2))
end
function tbl_upv_1.MoveSpeed(a1, a2, a3, a4, a5, a6)
    --[[
      name: MoveSpeed
      line: 163
      upvalues:
        tbl_upv_1 (copy, index: 1)
        tbl_upv_6 (copy, index: 2)
    ]]
    local v16 = tbl_upv_1.Tuning(a1)
    local v17 = tbl_upv_6[tbl_upv_1.Kind(a1) or "Fists"] or "Melee"
    local v18 = ((type(v16.speedMult) ~= "number") and 1) or (v16.speedMult)
    if v17 == "Bow" then
        v18 = a3 and v18 * (v16.drawSpeedMult or 0.7) or v18
        v18 = a2 and (a3 and v18 * (v16.drawSpeedMult or 0.7) or v18) * 0.8 or a3 and v18 * (v16.drawSpeedMult or 0.7) or v18
    elseif v17 == "Throw" then
        v18 = a3 and v18 * (v16.drawSpeedMult or 0.8) or v18
        v18 = a2 and (a3 and v18 * (v16.drawSpeedMult or 0.8) or v18) * 0.85 or a3 and v18 * (v16.drawSpeedMult or 0.8) or v18
    elseif v17 == "Gun" then
        v18 = a2 and v18 * (v16.aimSpeedMult or 0.8) or v18
        v18 = a5 and (a2 and v18 * (v16.aimSpeedMult or 0.8) or v18) * (v16.reloadSpeedMult or 1) or a2 and v18 * (v16.aimSpeedMult or 0.8) or v18
    elseif v17 ~= "Use" then
        if a4 and type(v16.block) == "table" then
            v18 = v18 * (v16.block.speedMult or 0.6)
        end
        if a3 then
            local v19 = v16.heavy or v16.lunge
            if type(v19) ~= "table" then
                v20 = 0.55
            else
                v20 = v19.speedMult or 0.55
            end
            v18 = v18 * v20
        end
    else
        v18 = (a6 and (v18 * (v16.useSpeedMult or 0.6))) or v18
    end
    local v21 = math.clamp(v18, 0, 2)
    local v20 = a3 or a4 or a5 or a6
    return v21, v20
end
function tbl_upv_1.RunSpeed(a1)
    --[[
      name: RunSpeed
      line: 210
      upvalues:
        tbl_upv_1 (copy, index: 1)
        tbl_upv_6 (copy, index: 2)
    ]]
    local v22 = tbl_upv_1.Tuning(a1)
    local v23 = tbl_upv_1.Kind(a1) or "Fists"
    local v24 = tbl_upv_6[v23] or "Melee"
    local v25 = {}
    if v24 == "Bow" then
        v25 = {{"charge", "drawing"}, {"aim", "aiming"}}
    elseif v24 == "Throw" then
        v25 = ((tbl_upv_1.IsDrawn(v23)) and {{"charge", "winding up"}}) or {{"aim", "aiming"}}
    elseif v24 == "Gun" then
        v25 = {{"aim", "aiming"}, {"reload", "reloading"}}
    elseif v24 == "Use" then
        v25 = ((v23 == "Herbs") and {{"use", "healing"}}) or (((v23 ~= "Horn") and {}) or {{"use", "blowing"}})
    elseif not (v22.parry) and not (v22.throw) then
        local v26 = v22.heavy or (v22.lunge)
        if type(v22.block) == "table" then
            v25 = {{"block", "blocking"}}
        elseif type(v26) == "table" then
            v25 = (((v26.charge or 0.6) > 0) and {{"charge", "charging"}}) or v25
        end
    end
    local v27 = tbl_upv_1.MoveSpeed(a1, false, false, false, false, false)
    local tbl_11 = {}
    for _, value_1 in v25 do
        local v28 = value_1[1]
        local MoveSpeed_1 = tbl_upv_1.MoveSpeed
        local v29 = v28 == "aim"
        local v30 = v28 == "charge"
        local v31 = v28 == "block"
        local v32 = v28 == "reload"
        local v33 = MoveSpeed_1(a1, v29, v30, v31, v32, v28 == "use")
        if math.abs(v33 - v27) > 0.001 then
            table.insert(tbl_11, {move = value_1[2], mult = v33})
        end
    end
    table.sort(
        tbl_11,
        function(a2, a3)
            --[[
              line: 241
            ]]
            return a2.mult < a3.mult
        end
    )
    return v27, tbl_11
end
function tbl_upv_1.BindOffHand(a1, a2)
    --[[
      name: BindOffHand
      line: 250
    ]]
    if not a1 or not a2 then
        return
    end
    for _, value_2 in a1:GetChildren() do
        if not (value_2:IsA("BasePart")) or value_2:GetAttribute("OffHand") ~= true then
            continue
        end
        local OffHandWeld_1 = value_2:FindFirstChild("OffHandWeld")
        local LeftHand_1 = a2:FindFirstChild("LeftHand")
        local v34 = LeftHand_1 and (LeftHand_1:FindFirstChild("LeftGripAttachment"))
        if not (OffHandWeld_1) or not (OffHandWeld_1:IsA("Weld")) or not (LeftHand_1) or not (LeftHand_1:IsA("BasePart")) or not (v34) or not (v34:IsA("Attachment")) then
            continue
        end
        if OffHandWeld_1.Part0 ~= LeftHand_1 then
            OffHandWeld_1.Part0 = LeftHand_1
            OffHandWeld_1.C0 = v34.CFrame
        end
    end
end
function tbl_upv_1.ShowOffHand(a1, a2)
    --[[
      name: ShowOffHand
      line: 269
    ]]
    if not a1 then
        return
    end
    for _, value_3 in a1:GetChildren() do
        if not (value_3:IsA("BasePart")) or value_3:GetAttribute("OffHand") ~= true then
            continue
        end
        value_3.Transparency = (a2 and 0) or 1
        for v1, value_4 in value_3:GetDescendants() do
            if value_4:IsA("BasePart") then
                value_4.Transparency = (a2 and 0) or 1
            end
        end
    end
end
function tbl_upv_1.FindCharacter(a1)
    --[[
      name: FindCharacter
      line: 286
    ]]
    local v35 = a1
    local v36 = nil
    while v35 and v35 ~= workspace do
        if not (v35:IsA("Model")) then
            v35 = v35.Parent
            continue
        end
        v36 = v35:FindFirstChildOfClass("Humanoid")
        if not (v36) then
            v35 = v35.Parent
            continue
        end
        return v35, v36
    end
    return nil, nil
end
function tbl_upv_1.IsHeadPart(a1)
    --[[
      name: IsHeadPart
      line: 301
    ]]
    if not a1 then
        return false
    end
    if a1.Name == "Head" then
        return true
    end
    local Parent_upv_1 = a1.Parent
    local v39 = nil
    if Parent_upv_1 then
        if Parent_upv_1:IsA("Accessory") then
            local success_1, v38 = pcall(
                function()
                    --[[
                      line: 310
                      upvalues:
                        Parent_upv_1 (copy, index: 1)
                    ]]
                    return Parent_upv_1.AccessoryType
                end
            )
            if success_1 and (v38 == Enum.AccessoryType.Hat or v38 == Enum.AccessoryType.Hair or v38 == Enum.AccessoryType.Face) then
                return true
            end
            v39 = Parent_upv_1:FindFirstChild("Handle")
            if v39 and (v39:FindFirstChild("HatAttachment") or v39:FindFirstChild("HairAttachment") or v39:FindFirstChild("FaceFrontAttachment")) then
                return true
            end
        end
    end
    for _, value_5 in a1:GetChildren() do
        if value_5:IsA("WeldConstraint") or value_5:IsA("JointInstance") and not (value_5:IsA("Motor6D")) then
            local Part0_1 = value_5.Part0
            local Part1_1 = value_5.Part1
            if Part0_1 ~= a1 then
                v39 = Part0_1
            else
                v39 = Part1_1
            end
            if not (v39) or v39.Name ~= "Head" or v39.Parent ~= a1.Parent then
                continue
            end
            return true
        end
    end
    return false
end
function tbl_upv_1.SpreadDir(a1, a2, a3, a4)
    --[[
      name: SpreadDir
      line: 339
    ]]
    if a2 <= 0 then
        return a1
    end
    local v40 = Random.new(((math.floor(a3) * 7919) + (a4 * 104729)) % 2147483647)
    local v41 = ((math.abs(a1.Y) > 0.95) and Vector3.new(1, 0, 0)) or Vector3.new(0, 1, 0)
    local Unit_1 = a1:Cross(v41).Unit
    local Unit_2 = Unit_1:Cross(a1).Unit
    local v42 = math.rad(a2) * math.sqrt(v40:NextNumber())
    local v43 = v40:NextNumber() * math.pi * 2
    return CFrame.fromAxisAngle((Unit_1 * math.cos(v43)) + (Unit_2 * math.sin(v43)), v42):VectorToWorldSpace(a1).Unit
end
function tbl_upv_1.SeedFor(a1, a2)
    --[[
      name: SeedFor
      line: 355
    ]]
    return (math.floor(a1) * 40503 + math.floor(a2)) % 2147483647
end
function tbl_upv_1.PelletDirs(a1, a2, a3, a4)
    --[[
      name: PelletDirs
      line: 360
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v44 = table.create(a2)
    v44[1] = a1
    for n_2 = 2, a2 do
        v44[n_2] = tbl_upv_1.SpreadDir(a1, a3, a4, n_2)
    end
    return v44
end
function tbl_upv_1.Falloff(a1, a2)
    --[[
      name: Falloff
      line: 370
    ]]
    local falloff_1 = a1.falloff
    if type(falloff_1) == "table" then
        if a2 <= falloff_1.start then
            return 1
        elseif falloff_1.finish <= a2 then
            return falloff_1.minMult
        else
            return 1 + ((falloff_1.minMult - 1) * ((a2 - falloff_1.start) / (falloff_1.finish - falloff_1.start)))
        end
    end
    return 1
end
function tbl_upv_1.DrawnShot(a1, a2)
    --[[
      name: DrawnShot
      line: 386
    ]]
    local v45 = math.clamp(a2, 0, 1)
    local v46 = a1.damage or 0
    local v47 = a1.damageMin or v46
    local v48 = a1.speedMin or (a1.speed or 100)
    local v49 = a1.speedMax
    if not (v49) then
        v49 = a1.speed
        v49 = v49 or v48
    end
    return v47 + ((v46 - v47) * v45), v48 + ((v49 - v48) * v45)
end
function tbl_upv_1.ShotSpeed(a1)
    --[[
      name: ShotSpeed
      line: 396
    ]]
    return a1.speed or (a1.speedMax or 200)
end
return tbl_upv_1