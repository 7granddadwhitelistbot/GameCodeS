local Weapons = require(script.Parent.Weapons)
local v2 = {DASH_GAP = 0.3, Ballistics = require(script.Ballistics), FISTS_ID = "fists", FISTS = table.freeze({damage = 10, cooldown = 0.38, comboWindow = 0.8, range = 6.5, arc = 60, maxTargets = 1, knockback = 8, speedMult = 1, combo = {1, 1, 1.3}})}
local v3 = {Sword = true, Axe = true, Spear = true, Dagger = true, Club = true, Fists = true, Shield = true, Gauntlets = true, Scythe = true, Katana = true, Hatchets = true}
local v4 = {Crossbow = true, Musket = true, Pistol = true, Blunderbuss = true}
local v5 = {Bow = true, Javelin = true, Bomb = true}
local v6 = {Bow = true, Crossbow = true, Musket = true, Pistol = true, Blunderbuss = true, Knives = true, Javelin = true, Sling = true, Bomb = true}

function v2.Tuning(a7)
    --[[
      name: Tuning
      line: 49
      upvalues:
        v2 (copy, index: 1)
        Weapons (copy, index: 2)
    ]]
    return if a7 == nil or a7 == v2.FISTS_ID then v2.FISTS elseif const v8 = Weapons.Get(a7) then v8.tuning else v2.FISTS
end

function v2.Kind(a9)
    --[[
      name: Kind
      line: 57
      upvalues:
        v2 (copy, index: 1)
        Weapons (copy, index: 2)
    ]]
    if a9 == nil or a9 == v2.FISTS_ID then
        return "Fists"
    end

    local v10 = Weapons.Get(a9)

    return v10 and v10.kind or nil
end

function v2.IsMelee(key)
    --[[
      name: IsMelee
      line: 65
      upvalues:
        v3 (copy, index: 1)
    ]]
    return (key ~= nil) and (v3[key] == true)
end

function v2.UsesAmmo(key)
    --[[
      name: UsesAmmo
      line: 69
      upvalues:
        v4 (copy, index: 1)
    ]]
    return (key ~= nil) and (v4[key] == true)
end

function v2.IsDrawn(key)
    --[[
      name: IsDrawn
      line: 73
      upvalues:
        v5 (copy, index: 1)
    ]]
    return (key ~= nil) and (v5[key] == true)
end

function v2.FiresProjectile(key)
    --[[
      name: FiresProjectile
      line: 77
      upvalues:
        v6 (copy, index: 1)
    ]]
    return (key ~= nil) and (v6[key] == true)
end

function v2.UsesCharges(a15)
    --[[
      name: UsesCharges
      line: 81
    ]]
    return type(a15.charges) == "number"
end

local v16 = {Fists = "Melee", Sword = "Melee", Axe = "Melee", Spear = "Melee", Dagger = "Melee", Club = "Melee", Shield = "Melee", Gauntlets = "Melee", Scythe = "Melee", Katana = "Melee", Hatchets = "Melee", Bow = "Bow", Crossbow = "Gun", Musket = "Gun", Pistol = "Gun", Blunderbuss = "Gun", Knives = "Throw", Javelin = "Throw", Sling = "Throw", Bomb = "Throw", Herbs = "Use", Trap = "Use", Horn = "Use"}
local v17 = {}

function v2.AddSmoke(pos, radius, a20)
    --[[
      name: AddSmoke
      line: 102
      upvalues:
        v17 (copy, index: 1)
    ]]
    table.insert(v17, {pos = pos, radius = radius, untilT = os.clock() + a20})
end

function v2.SmokeBlocks(a21, a22)
    --[[
      name: SmokeBlocks
      line: 107
      upvalues:
        v17 (copy, index: 1)
    ]]
    if #v17 == 0 then
        return false
    end

    local timestamp = os.clock()
    local v24 = a22 - a21
    local v25 = v24:Dot(v24)
    local v26 = false

    for index = #v17, 1, -1 do
        local v28 = v17[index]

        if v28.untilT <= timestamp then
            table.remove(v17, index)
        elseif not v26 then
            local v29 = not (0 < v25) and 0 or math.clamp((v28.pos - a21):Dot(v24) / v25, 0, 1)

            if (a21 + (v24 * v29) - v28.pos).Magnitude <= v28.radius * 0.85 then
                v26 = true
            end
        end
    end

    return v26
end

function v2.ArmorSpeed(a30)
    --[[
      name: ArmorSpeed
      line: 133
      upvalues:
        Weapons (copy, index: 1)
    ]]
    local v31

    if type(a30) ~= "string" then
        v31 = nil
    else
        v31 = Weapons.Get(a30)
    end

    local speedMult = v31 and v31.category == "armor" and v31.tuning.speedMult

    if type(speedMult) ~= "number" then
        return 1
    end

    return speedMult
end

function v2.GuardHp(a33, a34, a35)
    --[[
      name: GuardHp
      line: 143
    ]]
    local number = tonumber(a34.max) or 100

    if a33 then
        local guardHp = a33:GetAttribute("GuardHp")
        local guardHitAt = a33:GetAttribute("GuardHitAt")

        if type(guardHp) == "number" and type(guardHitAt) == "number" then
            return math.min(number, guardHp + (math.max(0, a35 - guardHitAt - (tonumber(a34.regenDelay) or 2)) * (tonumber(a34.regen)
                or 30))), number
        end
    end

    return number, number
end

function v2.GuardBrokenLeft(a39, a40)
    --[[
      name: GuardBrokenLeft
      line: 158
    ]]
    local guardBroken = a39 and a39:GetAttribute("GuardBroken")

    if type(guardBroken) ~= "number" then
        return 0
    end

    return (math.max(0, guardBroken - a40))
end

function v2.MoveSpeed(a42, a43, a44, a45, a46, a47)
    --[[
      name: MoveSpeed
      line: 163
      upvalues:
        v2 (copy, index: 1)
        v16 (copy, index: 2)
    ]]
    local v48
    local v49 = v2.Tuning(a42)
    local v50 = v16[v2.Kind(a42) or "Fists"] or "Melee"

    if type(v49.speedMult) ~= "number" then
        v48 = 1
    else
        v48 = v49.speedMult
    end

    if v50 == "Bow" then
        if a44 then
            v48 *= v49.drawSpeedMult or 0.7
        end

        if a43 then
            v48 *= 0.8
        end
    elseif v50 == "Throw" then
        if a44 then
            v48 *= v49.drawSpeedMult or 0.8
        end

        if a43 then
            v48 *= 0.85
        end
    elseif v50 == "Gun" then
        if a43 then
            v48 *= v49.aimSpeedMult or 0.8
        end

        if a46 then
            v48 *= v49.reloadSpeedMult or 1
        end
    elseif v50 == "Use" then
        if a47 then
            v48 *= v49.useSpeedMult or 0.6
        end
    else
        if a45 and type(v49.block) == "table" then
            v48 *= v49.block.speedMult or 0.6
        end

        if a44 then
            local speedMult
            local v52 = v49.heavy or v49.lunge

            if type(v52) ~= "table" then
                speedMult = 0.55
            else
                speedMult = v52.speedMult or 0.55
            end

            v48 *= speedMult
        end
    end

    local clampedValue = math.clamp(v48, 0, 2)
    local v54 = a44 or a45 or a46 or a47
    return clampedValue, v54
end

function v2.RunSpeed(a55)
    --[[
      name: RunSpeed
      line: 210
      upvalues:
        v2 (copy, index: 1)
        v16 (copy, index: 2)
    ]]
    local v56
    local v57 = v2.Tuning(a55)
    local v58 = v2.Kind(a55) or "Fists"
    local v59 = v16[v58] or "Melee"
    local v60 = {}

    if v59 == "Bow" then
        v56 = {{"charge", "drawing"}, {"aim", "aiming"}}
    elseif v59 == "Throw" then
        v56 = v2.IsDrawn(v58) and {{"charge", "winding up"}} or {{"aim", "aiming"}}
    elseif v59 == "Gun" then
        v56 = {{"aim", "aiming"}, {"reload", "reloading"}}
    elseif v59 == "Use" then
        v56 = v58 == "Herbs" and {{"use", "healing"}} or v58 ~= "Horn" and {} or {{"use", "blowing"}}
    elseif v57.parry then
        v56 = v60
    elseif v57.throw then
        v56 = v60
    else
        local v61 = v57.heavy or v57.lunge

        if type(v57.block) ~= "table" then
            if type(v61) ~= "table" then
                v56 = v60
            else
                v56 = 0 < (v61.charge or 0.6) and {{"charge", "charging"}} or v60
            end
        else
            v56 = {{"block", "blocking"}}
        end
    end

    local v62 = v2.MoveSpeed(a55, false, false, false, false, false)
    local v63 = {}

    for _, v65 in v56 do
        local v66 = v65[1]
        local moveSpeed = v2.MoveSpeed
        local v68 = v66 == "aim"
        local v69 = v66 == "charge"
        local v70 = v66 == "block"
        local v71 = v66 == "reload"
        local mult = moveSpeed(a55, v68, v69, v70, v71, v66 == "use")

        if 0.001 < math.abs(mult - v62) then
            table.insert(v63, {move = v65[2], mult = mult})
        end
    end

    table.sort(
        v63,
        function(left, right)
            --[[
              line: 241
            ]]
            return left.mult < right.mult
        end
    )

    return v62, v63
end

function v2.BindOffHand(a75, a76)
    --[[
      name: BindOffHand
      line: 250
    ]]
    if not a75 or not a76 then
        return
    end

    for _, child in a75:GetChildren() do
        if child:IsA("BasePart") then
            if child:GetAttribute("OffHand") ~= true then
                continue
            end

            local offHandWeld = child:FindFirstChild("OffHandWeld")
            local leftHand = a76:FindFirstChild("LeftHand")
            local leftGripAttachment = leftHand and leftHand:FindFirstChild("LeftGripAttachment")

            if not offHandWeld then
                continue
            end
            if not offHandWeld:IsA("Weld") then
                continue
            end
            if not leftHand then
                continue
            end
            if not leftHand:IsA("BasePart") then
                continue
            end
            if not leftGripAttachment then
                continue
            end

            if leftGripAttachment:IsA("Attachment") and offHandWeld.Part0 ~= leftHand then
                offHandWeld.Part0 = leftHand
                offHandWeld.C0 = leftGripAttachment.CFrame
            end
        end
    end
end

function v2.ShowOffHand(a82, a83)
    --[[
      name: ShowOffHand
      line: 269
    ]]
    if not a82 then
        return
    end

    for _, child in a82:GetChildren() do
        if child:IsA("BasePart") then
            if child:GetAttribute("OffHand") ~= true then
                continue
            end

            child.Transparency = a83 and 0 or 1

            for _, descendant in child:GetDescendants() do
                if descendant:IsA("BasePart") then
                    descendant.Transparency = a83 and 0 or 1
                end
            end
        end
    end
end

function v2.FindCharacter(a88)
    --[[
      name: FindCharacter
      line: 286
    ]]
    local v89, humanoid
    v89 = a88

    while v89 and v89 ~= workspace do
        if v89:IsA("Model") then
            humanoid = v89:FindFirstChildOfClass("Humanoid")

            if humanoid then
                return v89, humanoid
            end
        end

        v89 = v89.Parent
    end

    return nil, nil
end

function v2.IsHeadPart(a91)
    --[[
      name: IsHeadPart
      line: 301
    ]]
    if not a91 then
        return false
    end
    if a91.Name == "Head" then
        return true
    end

    local v92, v93, v94 = false, false, false
    local parent = a91.Parent

    if parent and parent:IsA("Accessory") then
        local success, accessoryType = pcall(
            function()
                --[[
                  line: 310
                  upvalues:
                    parent (copy, index: 1)
                ]]
                return parent.AccessoryType
            end
        )

        if success then
            if accessoryType ~= Enum.AccessoryType.Hat and accessoryType ~= Enum.AccessoryType.Hair then
                if accessoryType ~= Enum.AccessoryType.Face then
                    v93 = true
                else
                    v92 = true
                end
            else
                v92 = true
            end
        else
            v93 = true
        end
    end

    if v92 then
        return true
    end

    if v93 then
        if const handle = parent:FindFirstChild("Handle") then
            if not handle:FindFirstChild("HatAttachment") and not handle:FindFirstChild("HairAttachment") then
                if handle:FindFirstChild("FaceFrontAttachment") then
                    v94 = true
                end
            else
                v94 = true
            end
        end
    end

    if v94 then
        return true
    end

    for _, child in a91:GetChildren() do
        if not child:IsA("WeldConstraint") then
            if not child:IsA("JointInstance") then
                continue
            end
            if child:IsA("Motor6D") then
                continue
            end
        end

        local v101 = child.Part0
        local part1 = child.Part1

        if v101 == a91 then
            v101 = part1
        end

        if v101 and v101.Name == "Head" and v101.Parent == a91.Parent then
            return true
        end
    end

    return false
end

function v2.SpreadDir(a103, a104: number, a105: number, a106)
    --[[
      name: SpreadDir
      line: 339
    ]]
    local vector3

    if a104 <= 0 then
        return a103
    end

    local random = Random.new((math.floor(a105) * 7919 + (a106 * 104729)) % 2147483647)

    if not (0.95 < math.abs(a103.Y)) then
        vector3 = Vector3.new(0, 1, 0)
    else
        vector3 = Vector3.new(1, 0, 0)
    end

    local unit = a103:Cross(vector3).Unit
    local unit2 = unit:Cross(a103).Unit
    local v111 = math.rad(a104) * math.sqrt((random:NextNumber()))
    local v112 = random:NextNumber() * math.pi * 2
    local v113 = unit * math.cos(v112) + unit2 * math.sin(v112)

    return CFrame.fromAxisAngle(v113, v111):VectorToWorldSpace(a103).Unit
end

function v2.SeedFor(a114: number, a115: number)
    --[[
      name: SeedFor
      line: 355
    ]]
    return (math.floor(a114) * 40503 + math.floor(a115)) % 2147483647
end

function v2.PelletDirs(a116, size: number, a118, a119)
    --[[
      name: PelletDirs
      line: 360
      upvalues:
        v2 (copy, index: 1)
    ]]
    local values = table.create(size)
    values[1] = a116

    for valueKey = 2, size do
        values[valueKey] = v2.SpreadDir(a116, a118, a119, valueKey)
    end

    return values
end

function v2.Falloff(a122, a123)
    --[[
      name: Falloff
      line: 370
    ]]
    local falloff = a122.falloff

    if type(falloff) ~= "table" then
        return 1
    end
    if a123 <= falloff.start then
        return 1
    end
    if falloff.finish <= a123 then
        return falloff.minMult
    end

    local v125 = (a123 - falloff.start) / (falloff.finish - falloff.start)

    return 1 + ((falloff.minMult - 1) * v125)
end

function v2.DrawnShot(options, a127: number)
    --[[
      name: DrawnShot
      line: 386
    ]]
    local clampedValue = math.clamp(a127, 0, 1)
    local damage = options.damage or 0
    local v130 = options.damageMin or damage
    local v131 = options.speedMin or options.speed or 100
    local v132 = options.speedMax or options.speed or v131

    return v130 + ((damage - v130) * clampedValue), v131 + ((v132 - v131) * clampedValue)
end

function v2.ShotSpeed(a133)
    --[[
      name: ShotSpeed
      line: 396
    ]]
    return a133.speed or a133.speedMax or 200
end

return v2