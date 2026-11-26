local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local workspace = game:GetService("Workspace")
local shared = replicatedStorage:WaitForChild("Shared")
local Camera = require(shared:WaitForChild("Camera"))
local Spring = require(shared:WaitForChild("Camera"):WaitForChild("Spring"))
local Combat = require(shared:WaitForChild("Combat"))
local Sfx = require(shared:WaitForChild("Sfx"))
local BladeClips = require(script.Parent:WaitForChild("BladeClips"))
local BladeSmear = require(script.Parent:WaitForChild("BladeSmear"))
local ItemClips = require(script.Parent:WaitForChild("ItemClips"))
local ViewFx = require(script.Parent:WaitForChild("ViewFx"))
local v14 = {}
local localPlayer = players.LocalPlayer
local v16 = {
    fovRef = 70,
    hand = Vector3.new(0.3199999928474426, -0.28999999165534973, -0.6000000238418579),
    touchHand = Vector3.new(-0.05999999865889549, 0.05000000074505806, 0),
    poseHz = 7,
    poseDamp = 0.82,
    idleHz = 0.3,
    idlePos = 0.005,
    idleRot = 1,
    bobX = 0.03,
    bobY = 0.045,
    bobRoll = 4,
    bobPitch = 2.6,
    airK = 0.0024,
    airMax = 0.07,
    airTiltK = 0.3,
    airTiltMax = 9,
    airHz = 2.6,
    airDamp = 0.55,
    landK = 0.05,
    landMax = 1.8,
    landHz = 5,
    landDamp = 0.42,
    landDist = 0.07,
    swayK = 0.35,
    swayMax = 9,
    swayHz = 5,
    swayDamp = 0.75,
    swayShift = 0.15,
    mvX = 0.0016,
    mvZ = 8e-04,
    mvRoll = 0.2,
    mvYaw = 0.1,
    mvPitch = 0.08,
    mvMax = 1.4,
    mvRun = 21,
    mvHz = 4,
    mvDamp = 0.55,
    mvAimed = 0.35,
    kickHz = 9,
    kickDamp = 0.5,
    equipHz = 4.2,
    equipDamp = 0.52,
    equipDrop = 0.42,
    equipTilt = 55,
    dropTime = 0.14,
    slidePos = Vector3.new(-0.019999999552965164, -0.07999999821186066, 0.029999999329447746),
    slideRot = Vector3.new(8, 4, 16),
    slideShake = 0.004,
    wallMin = 0.78,
    wallMargin = 0.16,
    wallPos = Vector3.new(0.019999999552965164, -0.14000000059604645, 0.05000000074505806),
    wallRotMax = 70,
    hurtRot = 40,
    hurtPos = 0.35,
    retHz = 4.6,
    retDamp = 0.74,
    smearLen = 0.055,
    smear = {
        Sword = {{at = 0.56, width = 0.82, alpha = 0.6, color = Color3.fromRGB(200, 212, 230)}, {at = 0.9, width = 0.2, alpha = 0.28, color = Color3.fromRGB(226, 233, 243)}},
        Dagger = {{at = 0.56, width = 0.82, alpha = 0.58, color = Color3.fromRGB(176, 222, 236)}, {at = 0.9, width = 0.22, alpha = 0.26, color = Color3.fromRGB(206, 238, 246)}},
        Axe = {{at = 0.62, width = 0.6, alpha = 0.62, color = Color3.fromRGB(196, 204, 218)}, {at = 0.88, width = 0.26, alpha = 0.5, color = Color3.fromRGB(214, 196, 150)}},
        Club = {{at = 0.66, width = 0.56, alpha = 0.64, color = Color3.fromRGB(196, 182, 160)}, {at = 0.88, width = 0.26, alpha = 0.5, color = Color3.fromRGB(200, 182, 150)}},
        Knives = {{at = 0.6, width = 0.8, alpha = 0.6, color = Color3.fromRGB(170, 180, 194)}},
        Javelin = {{at = 0.85, width = 0.3, alpha = 0.55, color = Color3.fromRGB(176, 172, 160)}},
        Bomb = {{at = 0.5, width = 0.9, alpha = 0.6, color = Color3.fromRGB(196, 166, 128)}},
        Scythe = {{at = 0.34, width = 0.62, alpha = 0.62, color = Color3.fromRGB(186, 194, 210)}, {at = 0.6, width = 0.18, alpha = 0.45, color = Color3.fromRGB(210, 216, 228)}},
        Katana = {{at = 0.58, width = 0.8, alpha = 0.6, color = Color3.fromRGB(178, 204, 230)}, {at = 0.9, width = 0.2, alpha = 0.28, color = Color3.fromRGB(204, 224, 242)}}
    },
    smearAlong = {Scythe = {root = 0.97}},
    smearItem = {bolas = {{at = 0.85, width = 0.25, alpha = 0.6, color = Color3.fromRGB(150, 116, 80)}}, chakram = {{at = 0.7, width = 0.5, alpha = 0.5, color = Color3.fromRGB(170, 176, 186)}}}
}
local v17 = {
    Sword = {len = 0.62, pos = Vector3.new(0.029999999329447746, 0, 0), rot = Vector3.new(-26, 6, -4), act = "slash", blockFrame = {pos = Vector3.new(0.30000001192092896, -0.27000001072883606, -0.550000011920929), tip = Vector3.new(-0.8199999928474426, 0.3799999952316284, -0.41999998688697815), edge = Vector3.new(0.10000000149011612, 0.30000001192092896, -1)}},
    Shield = {len = 0.355, pos = Vector3.new(-0.019999999552965164, -0.05999999865889549, 0.019999999552965164), rot = Vector3.new(0, 18, 4), act = "stab", block = {Vector3.new(-0.30000001192092896, 0.052000001072883606, 0.23999999463558197), Vector3.new(2, -16, -11)}},
    Dagger = {len = 0.33, pos = Vector3.new(0.019999999552965164, 0.019999999552965164, 0.019999999552965164), rot = Vector3.new(-18, 8, 18), act = "stab"},
    Axe = {len = 0.55, pos = Vector3.new(0, 0, 0), rot = Vector3.new(-26, 14, 14), act = "chop", charge = {Vector3.new(0.05999999865889549, 0.14000000059604645, 0.019999999552965164), Vector3.new(42, -6, -30)}},
    Club = {len = 0.3, pos = Vector3.new(0.019999999552965164, -0.019999999552965164, 0), rot = Vector3.new(-26, 14, 24), act = "smash", charge = {Vector3.new(0.019999999552965164, 0.03999999910593033, 0.019999999552965164), Vector3.new(36, 0, 12)}},
    Gauntlets = {len = 0.24, pos = Vector3.new(0.009999999776482582, -0.05000000074505806, 0.019999999552965164), rot = Vector3.new(62, 14, 24), act = "stab"},
    Katana = {len = 0.68, pos = Vector3.new(0.029999999329447746, 0, 0), rot = Vector3.new(-26, 6, 4), act = "slash"},
    Hatchets = {len = 0.34, pos = Vector3.new(0.019999999552965164, -0.019999999552965164, 0.019999999552965164), rot = Vector3.new(-24, 12, 16), act = "chop"},
    Scythe = {len = 0.95, pos = Vector3.new(0.03999999910593033, -0.05999999865889549, 0.03999999910593033), rot = Vector3.new(-18, 93, -24), act = "chop", chargeIn = 0.15, charge = {Vector3.new(0.09000000357627869, 0.019999999552965164, 0.05000000074505806), Vector3.new(0, -12, -37)}},
    Spear = {len = 0.9, pos = Vector3.new(0.019999999552965164, -0.03999999910593033, 0.019999999552965164), rot = Vector3.new(-72, 4, -4), act = "thrust", charge = {Vector3.new(0.019999999552965164, 0, 0.20000000298023224), Vector3.new(-6, 0, 0)}},
    Bow = {
        len = 0.54,
        pos = Vector3.new(0, -0.019999999552965164, 0),
        rot = Vector3.new(0, 55, 18),
        act = "bow",
        aimPos = Vector3.new(-0.1599999964237213, 0.05000000074505806, 0.029999999329447746),
        aimRot = Vector3.new(0, 6, -6),
        draw = {Vector3.new(-0.12999999523162842, 0.05999999865889549, 0.05000000074505806), Vector3.new(0, 10, -24)},
        drawFrame = {pos = Vector3.new(0.1599999964237213, -0.1599999964237213, -0.5199999809265137), tip = Vector3.new(0.4699999988079071, 0.8799999952316284, 0.03999999910593033), edge = Vector3.new(-0.04500000178813934, 0.04500000178813934, -1)},
        stock = {len = 0.68, pos = Vector3.new(0, 0, 0.019999999552965164), rot = Vector3.new(-6, 6, 0), kick = 1.5, drawFrame = false, aimPos = Vector3.new(-0.18000000715255737, 0.10000000149011612, 0.03999999910593033), aimRot = Vector3.new(2, 0, -4), draw = {Vector3.new(-0.14000000059604645, 0.05999999865889549, 0.11999999731779099), Vector3.new(5, -4, -10)}}
    },
    Crossbow = {len = 0.48, pos = Vector3.new(-0.009999999776482582, 0, 0), rot = Vector3.new(8, 8, -6), act = "gun", kick = 1, aimPos = Vector3.new(-0.25999999046325684, 0.03999999910593033, 0.03999999910593033), aimRot = Vector3.new(-8, -8, 4)},
    Musket = {len = 0.82, pos = Vector3.new(-0.009999999776482582, 0, 0.019999999552965164), rot = Vector3.new(2, 6, 0), act = "gun", kick = 1.3, aimPos = Vector3.new(-0.25999999046325684, 0.07000000029802322, 0.03999999910593033), aimRot = Vector3.new(0, -6, 0)},
    Pistol = {len = 0.6, pos = Vector3.new(-0.029999999329447746, 0.029999999329447746, 0), rot = Vector3.new(2, 6, 0), act = "gun", kick = 1, aimPos = Vector3.new(-0.2800000011920929, 0.019999999552965164, 0.03999999910593033), aimRot = Vector3.new(0, -6, 0)},
    Blunderbuss = {len = 0.6, pos = Vector3.new(-0.009999999776482582, 0, 0.019999999552965164), rot = Vector3.new(2, 6, 0), act = "gun", kick = 1.4, aimPos = Vector3.new(-0.25999999046325684, 0.07000000029802322, 0.03999999910593033), aimRot = Vector3.new(0, -6, 0)},
    Knives = {len = 0.3, pos = Vector3.new(0.019999999552965164, 0, 0), rot = Vector3.new(-40, 10, -10), act = "throw", aimPos = Vector3.new(-0.11999999731779099, 0.03999999910593033, 0.03999999910593033), aimRot = Vector3.new(0, 0, 0), windup = {Vector3.new(0.05000000074505806, 0.10000000149011612, 0.1599999964237213), Vector3.new(70, 0, 16)}},
    Javelin = {len = 0.74, pos = Vector3.new(0.019999999552965164, 0.019999999552965164, 0.03999999910593033), rot = Vector3.new(-80, 6, 0), act = "throw", windup = {Vector3.new(0.10000000149011612, 0.2199999988079071, 0.10000000149011612), Vector3.new(-5, 14, 10)}},
    Sling = {len = 0.66, pos = Vector3.new(-0.03999999910593033, 0.2800000011920929, 0.019999999552965164), rot = Vector3.new(0, 14, 38), act = "throw", aimPos = Vector3.new(-0.11999999731779099, 0.03999999910593033, 0.03999999910593033), aimRot = Vector3.new(0, 0, 0), windup = {Vector3.new(0.05000000074505806, 0.10000000149011612, 0.1599999964237213), Vector3.new(40, 0, 16)}},
    Bomb = {len = 0.28, pos = Vector3.new(0.019999999552965164, 0.019999999552965164, 0), rot = Vector3.new(-10, 20, 0), act = "throw", windup = {Vector3.new(0.11999999731779099, 0.2800000011920929, 0.05000000074505806), Vector3.new(35, -10, 20)}},
    Herbs = {len = 0.25, pos = Vector3.new(0.019999999552965164, 0.019999999552965164, 0), rot = Vector3.new(-10, 25, 0), act = "eat", use = {Vector3.new(-0.2199999988079071, 0.08500000089406967, 0.17000000178813934), Vector3.new(-28, 30, 10)}},
    Trap = {len = 0.38, pos = Vector3.new(-0.019999999552965164, 0, 0), rot = Vector3.new(58, 24, 8), act = "trap"},
    Horn = {len = 0.4, pos = Vector3.new(0.019999999552965164, 0.019999999552965164, 0), rot = Vector3.new(-10, 25, 0), act = "eat", use = {Vector3.new(-0.2199999988079071, 0, 0.20000000298023224), Vector3.new(-35, -15, -30)}}
}
local v18 = {
    crossbow = {barrel = Vector3.new(0, 0, 1)},
    beehive = {len = 0.2, pos = Vector3.new(0.029999999329447746, -0.009999999776482582, 0), windup = {Vector3.new(0.2199999988079071, 0.30000001192092896, 0.05000000074505806), Vector3.new(35, -10, 24)}},
    flintlock = {barrel = Vector3.new(0.9272000193595886, -0.37459999322891235, 0), pan = Vector3.new(1.0478999614715576, -0.05299999937415123, 0.19140000641345978)},
    musket = {barrel = Vector3.new(0.970300018787384, 0.2418999969959259, 0), pan = Vector3.new(0.5214999914169312, 0.3522000014781952, 0.16539999842643738)},
    blunderbuss = {barrel = Vector3.new(0, 0, 1), muzzle = Vector3.new(0, -0.3034000098705292, 2.4077000617980957), pan = Vector3.new(-0.13500000536441803, -0.2669000029563904, 0.47429999709129333)},
    bolas = {len = 0.37, pos = Vector3.new(-0.029999999329447746, 0.23999999463558197, 0), rot = Vector3.new(30, 0, 0)},
    javelins = {len = 1.17, pos = Vector3.new(0, 0, 0.05000000074505806)},
    harpoon = {len = 0.8},
    healing_tonic = {pos = Vector3.new(0.029999999329447746, -0.05999999865889549, 0.029999999329447746), use = {Vector3.new(-0.2199999988079071, 0.08500000089406967, 0.20999999344348907), Vector3.new(-28, 30, 10)}},
    bandage = {use = {Vector3.new(-0.2199999988079071, 0.18000000715255737, 0.18000000715255737), Vector3.new(-35, 20, 25)}},
    war_horn = {use = {Vector3.new(-0.30000001192092896, 0, 0.23000000417232513), Vector3.new(-35, -15, -18)}},
    chakram = {pos = Vector3.new(-0.07999999821186066, -0.029999999329447746, 0.019999999552965164), rot = Vector3.new(20, 35, 18)},
    palisade = {len = 0.36, pos = Vector3.new(0, 0.05999999865889549, 0), rot = Vector3.new(-58, 0, -10)},
    smoke_bomb = {windup = {Vector3.new(0.1599999964237213, 0.2800000011920929, 0.05000000074505806), Vector3.new(35, -10, 20)}},
    healing_flask = {windup = {Vector3.new(0.11999999731779099, 0.2800000011920929, 0.05000000074505806), Vector3.new(12, -10, 20)}}
}
local v19 = {
    stab = {dur = 0.2, keys = {{0, Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)}, {0.25, Vector3.new(0.009999999776482582, 0.009999999776482582, 0.05000000074505806), Vector3.new(8, 0, 0)}, {0.5, Vector3.new(-0.05000000074505806, 0.019999999552965164, -0.18000000715255737), Vector3.new(-40, 0, -6)}, {1, Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)}}},
    chop = {dur = 0.4, keys = {{0, Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)}, {0.24, Vector3.new(0.019999999552965164, 0.10000000149011612, 0.05999999865889549), Vector3.new(44, 0, 10)}, {0.52, Vector3.new(-0.05000000074505806, -0.12999999523162842, -0.09000000357627869), Vector3.new(-64, 6, -10)}, {1, Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)}}},
    smash = {dur = 0.46, keys = {{0, Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)}, {0.28, Vector3.new(0.019999999552965164, 0.11999999731779099, 0.07000000029802322), Vector3.new(52, 0, 6)}, {0.55, Vector3.new(-0.05999999865889549, -0.1599999964237213, -0.07999999821186066), Vector3.new(-74, 4, -6)}, {1, Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)}}},
    heavy = {dur = 0.5, keys = {{0, Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)}, {0.3, Vector3.new(-0.05999999865889549, -0.20000000298023224, -0.11999999731779099), Vector3.new(-90, 6, -8)}, {0.55, Vector3.new(-0.05000000074505806, -0.17000000178813934, -0.10000000149011612), Vector3.new(-80, 6, -8)}, {1, Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)}}},
    thrust = {dur = 0.34, keys = {{0, Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)}, {0.25, Vector3.new(0.009999999776482582, 0.009999999776482582, 0.10000000149011612), Vector3.new(4, 0, 0)}, {0.48, Vector3.new(-0.05999999865889549, 0.029999999329447746, -0.30000001192092896), Vector3.new(-4, 0, 0)}, {1, Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)}}},
    lunge = {dur = 0.6, keys = {{0, Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)}, {0.15, Vector3.new(-0.07999999821186066, 0.03999999910593033, -0.4000000059604645), Vector3.new(-4, 0, 0)}, {0.62, Vector3.new(-0.07999999821186066, 0.03999999910593033, -0.3799999952316284), Vector3.new(-4, 0, 0)}, {1, Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)}}},
    throw = {dur = 0.34, keys = {{0, Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)}, {0.4, Vector3.new(-0.05999999865889549, 0.019999999552965164, -0.3400000035762787), Vector3.new(-60, 0, -8)}, {1, Vector3.new(-0.05999999865889549, -0.10000000149011612, -0.30000001192092896), Vector3.new(-70, 0, -8)}}},
    place = {dur = 0.36, keys = {{0, Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)}, {0.5, Vector3.new(-0.03999999910593033, -0.2199999988079071, -0.1599999964237213), Vector3.new(-40, 0, 0)}, {1, Vector3.new(-0.03999999910593033, -0.30000001192092896, -0.20000000298023224), Vector3.new(-50, 0, 0)}}}
}
local v20 = {}
local weapons = nil
local viewModels = nil

local function cfgFor(key)
    --[[
      name: cfgFor
      line: 412
      upvalues:
        v17 (copy, index: 1)
    ]]
    return v17[key]
end

local function canonical(kind, act, a28, a29, a30, a31, barrel)
    --[[
      name: canonical
      line: 429
    ]]
    if kind == "Gauntlets" then
        return CFrame.identity, nil
    end

    local function inGrip(a34)
        --[[
          name: inGrip
          line: 433
          upvalues:
            a29 (copy, index: 1)
            a28 (copy, index: 2)
        ]]
        return a29:PointToObjectSpace(a28.CFrame:PointToObjectSpace(a34))
    end

    local function axisInGrip(a36)
        --[[
          name: axisInGrip
          line: 436
          upvalues:
            a29 (copy, index: 1)
        ]]
        return a29:VectorToObjectSpace(a36)
    end

    local v37 = a28:FindFirstChild("Muzzle", true) or a28:FindFirstChild("Tip", true)
    local v38 = nil
    local v39 = nil
    local v40 = nil

    if act == "gun" and barrel and 0.05 < barrel.Magnitude then
        v39 = a29:VectorToObjectSpace(barrel.Unit)
        v38 = a29:VectorToObjectSpace(Vector3.new(0, 1, 0))
    elseif act == "gun" and v37 and v37:IsA("Attachment") then
        local worldPosition = v37.WorldPosition
        local objectSpaceWorldPosition = a29:PointToObjectSpace(a28.CFrame:PointToObjectSpace(worldPosition))

        if 0.05 < objectSpaceWorldPosition.Magnitude then
            v39 = objectSpaceWorldPosition.Unit
            v38 = a29:VectorToObjectSpace(Vector3.new(0, 1, 0))
        end
    elseif kind == "Bow" then
        local v43 = {{a30.X, Vector3.new(1, 0, 0)}, {a30.Y, Vector3.new(0, 1, 0)}, {a30.Z, Vector3.new(0, 0, 1)}}

        table.sort(
            v43,
            function(left, right)
                --[[
                  line: 456
                ]]
                local v46 = left[1]
                return right[1] < v46
            end
        )

        local vector3 = v43[1][2]
        local v48 = (a29.Position - a31.Position):Dot(vector3)
        local absoluteValue = math.abs(v48)

        if v43[1][1] * 0.12 < absoluteValue then
            v40 = "stock"
            local vector32 = if 0 < v48 then -vector3 else vector3
            v39 = a29:VectorToObjectSpace(vector32)
            local v51 = vector3 ~= Vector3.new(0, 1, 0) and Vector3.new(0, 1, 0) or v43[2][2]
            v38 = a29:VectorToObjectSpace(v51)
        else
            v38 = a29:VectorToObjectSpace(vector3)
            v39 = a29:VectorToObjectSpace(v43[2][2])

            if v38.Y < -0.01 then
                v38 = -v38
            end

            if 0.01 < v39.Z then
                v39 = -v39
            end
        end
    elseif kind ~= "Sling" and kind ~= "Trap" then
        local tip = a28:FindFirstChild("Tip", true)

        if tip and tip:IsA("Attachment") then
            local worldPosition = tip.WorldPosition
            local objectSpaceWorldPosition = a29:PointToObjectSpace(a28.CFrame:PointToObjectSpace(worldPosition))

            if 0.1 < objectSpaceWorldPosition.Magnitude and 0.2 < objectSpaceWorldPosition.Unit.Y then
                v38 = objectSpaceWorldPosition.Unit
                v39 = Vector3.new(0, 0, -1)
            end
        end
    end

    if not v38 or not v39 then
        return CFrame.identity, v40
    end

    local unit = v38.Unit
    local v56 = v39 - unit * v39:Dot(unit)

    if v56.Magnitude < 0.05 then
        return CFrame.identity, v40
    end

    local unit2 = v56.Unit

    if act == "gun" or v40 == "stock" then
        unit2 = v39.Unit
        local v58 = unit - unit2 * unit:Dot(unit2)

        if v58.Magnitude < 0.05 then
            return CFrame.identity, v40
        end

        unit = v58.Unit
    end

    return CFrame.fromMatrix(Vector3.new(0, 0, 0), unit2:Cross(unit), unit, -unit2):Inverse(), v40
end

local function withStock(a60)
    --[[
      name: withStock
      line: 506
    ]]
    local stock = a60.stock
    if not stock then
        return a60
    end

    local values = table.clone(a60)

    for valueKey, v64 in stock do
        values[valueKey] = v64
    end

    values.stock = nil

    return values
end

local function hammerOf(a66, a67, a68: string?, a69: string?, a70: string?)
    --[[
      name: hammerOf
      line: 522
    ]]
    local part = a66:FindFirstChild(a68 or "Hammer", true)
    local v72 = a67:FindFirstChild(a69 or "HammerPivot")

    if part and part:IsA("BasePart") and v72 and v72:IsA("Attachment") then
        return {part = part, rest = a67.CFrame:ToObjectSpace(part.CFrame), pivot = a67.CFrame:PointToObjectSpace(v72.WorldPosition), axis = a67.CFrame:VectorToObjectSpace(v72.WorldAxis).Unit, fired = tonumber(part:GetAttribute(a70
            or "Fired"))
            or 35}
    end

    return nil
end

local function rodOf(a74, a75, a76)
    --[[
      name: rodOf
      line: 539
    ]]
    local ramrod = a74:FindFirstChild("Ramrod", true)

    if not ramrod or not ramrod:IsA("BasePart") or not a76 then
        return nil
    end

    ramrod.Size = Vector3.new(ramrod.Size.X, ramrod.Size.Y * 1.4, ramrod.Size.Z * 1.4)

    return {part = ramrod, rest = a75.CFrame:ToObjectSpace(ramrod.CFrame), len = ramrod.Size.X, fwd = a75.CFrame:VectorToObjectSpace(ramrod.CFrame.XVector).Unit, up = a75.CFrame:VectorToObjectSpace(ramrod.CFrame.YVector).Unit, muzzle = a75.CFrame:PointToObjectSpace(a76.WorldPosition)}
end

local function evalTrack(a79, a80)
    --[[
      name: evalTrack
      line: 558
    ]]
    if a80 <= a79[1][1] then
        return a79[1][2]
    end

    local v81, v82

    for index = 2, #a79 do
        v81 = a79[index - 1]
        v82 = a79[index]

        if a80 <= v82[1] then
            local v84 = v81[2] <= 1.5

            if v84 ~= (v82[2] <= 1.5) then
                return v81[2]
            end

            local v85 = (a80 - v81[1]) / math.max(v82[1] - v81[1], 1e-04)
            local v86 = v85 * v85 * (3 - (v85 * 2))

            return v81[2] + ((v82[2] - v81[2]) * v86)
        end
    end

    return a79[#a79][2]
end

local function mirrorX(a88)
    --[[
      name: mirrorX
      line: 578
    ]]
    local components, v90, v91, v92, v93, v94, v95, v96, v97, v98, v99, v100 = a88:GetComponents()
    return CFrame.new(-components, v90, v91, v92, -v93, -v94, -v95, v96, v97, -v98, v99, v100)
end

local function prepare(id, kind)
    --[[
      name: prepare
      line: 583
      upvalues:
        v20 (copy, index: 1)
        v17 (copy, index: 2)
        weapons (ref,  index: 3)
        viewModels (ref,  index: 4)
        v18 (copy, index: 5)
        canonical (copy, index: 6)
        v16 (copy, index: 7)
        BladeClips (copy, index: 8)
        ItemClips (copy, index: 9)
        hammerOf (copy, index: 10)
        rodOf (copy, index: 11)
    ]]
    if const v104 = v20[id] then
        return v104
    end

    local cfg = v17[kind]
    local weapons2 = weapons
    local child = cfg and (viewModels and viewModels:FindFirstChild(id) or weapons2 and weapons2:FindFirstChild(id))

    if not cfg or not child or not child:IsA("Model") then
        return nil
    end

    local v108 = child:Clone()

    for _, descendant in v108:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = true
            descendant.CanCollide = false
            descendant.CanQuery = false
            descendant.CanTouch = false
            descendant.CastShadow = false
            descendant.Massless = true
        elseif descendant:IsA("ParticleEmitter")
            or descendant:IsA("Trail")
            or descendant:IsA("Beam")
            or descendant:IsA("Light")
        then
            descendant.Enabled = false
        elseif descendant:IsA("Script") or descendant:IsA("LocalScript") or descendant:IsA("Sound") then
            descendant:Destroy()
        end
    end

    local v111 = v108.PrimaryPart or v108:FindFirstChild("Handle")

    if not v111 or not v111:IsA("BasePart") then
        v108:Destroy()
        return nil
    end

    local part
    local len
    local leftFist
    local drawP
    local pan2
    local blockP, blockR
    local drawR
    local brace3
    local v121
    local strip3
    v108.PrimaryPart = v111
    local v123 = v18[id]
    local rightGripAttachment = v111:FindFirstChild("RightGripAttachment", true)

    local function gripRelNow()
        --[[
          name: gripRelNow
          line: 617
          upvalues:
            rightGripAttachment (copy, index: 1)
            v111 (copy, index: 2)
        ]]
        if rightGripAttachment and rightGripAttachment:IsA("Attachment") then
            return (v111.CFrame:ToObjectSpace(rightGripAttachment.WorldCFrame))
        end

        return (CFrame.new())
    end

    local strip = v108:FindFirstChild("Strip", true)
    local v127 = if strip then strip.Parent else nil

    if strip then
        strip.Parent = nil
    end

    part = nil

    for _, child2 in v108:GetChildren() do
        if child2:IsA("BasePart") then
            if child2:GetAttribute("OffHand") ~= true then
                continue
            end

            part = child2
        end
    end

    if part then
        part.Parent = nil
    end

    local boundingBox, v131 = v108:GetBoundingBox()

    if strip then
        strip.Parent = v127
    end

    if part then
        part.Parent = v108
    end

    local act = cfg.act
    local v133 = if rightGripAttachment and rightGripAttachment:IsA("Attachment") then v111.CFrame:ToObjectSpace(rightGripAttachment.WorldCFrame) else CFrame.new()
    local v134 = v111.CFrame:ToObjectSpace(boundingBox)
    local norm, v136 = canonical(kind, act, v111, v133, v131, v134, (v123 and v123.barrel))

    if v136 == "stock" then
        local v137 = cfg

        if const stock = v137.stock then
            local values = table.clone(v137)

            for valueKey, v141 in stock do
                values[valueKey] = v141
            end

            values.stock = nil
            cfg = values
        else
            cfg = v137
        end
    end

    if v123 and (v123.pos or v123.use or v123.windup) then
        local values = table.clone(cfg)
        values.pos += (v123.pos or Vector3.new(0, 0, 0))
        values.use = v123.use or values.use
        values.windup = v123.windup or values.windup
    end

    local v143 = math.max(v131.X, v131.Y, v131.Z, 0.05)

    if v123 and v123.len then
        len = v123.len
    else
        len = cfg.len
    end

    v108:ScaleTo((math.clamp(len / v143, 0.005, 1)))

    if part then
        local offHandGrip = part:FindFirstChild("OffHandGrip")
        local v145 = {part = part, rel = if offHandGrip and offHandGrip:IsA("Attachment") then offHandGrip.CFrame:Inverse() else CFrame.identity}
        part.Parent = nil
        leftFist = v145
    else
        leftFist = nil
    end

    local v146 = if rightGripAttachment and rightGripAttachment:IsA("Attachment") then v111.CFrame:ToObjectSpace(rightGripAttachment.WorldCFrame) else CFrame.new()
    local v147 = if v123 and v123.rot then v123.rot else Vector3.new(0, 0, 0)
    local styleRot = CFrame.fromEulerAnglesYXZ(cfg.rot.X * 0.017453292519943295, cfg.rot.Y * 0.017453292519943295, cfg.rot.Z * 0.017453292519943295) * CFrame.fromEulerAnglesYXZ(v147.X * 0.017453292519943295, v147.Y * 0.017453292519943295, v147.Z * 0.017453292519943295)
    local style = styleRot * norm
    local tip = v111:FindFirstChild("Tip", true)
    local rightGripAttachment2 = v111:FindFirstChild("RightGripAttachment", true)
    local v152 = if tip and tip:IsA("Attachment") and rightGripAttachment2 and rightGripAttachment2:IsA("Attachment") then (tip.WorldPosition - rightGripAttachment2.WorldPosition).Magnitude else cfg.len * 0.8
    local boundingBox2, v154 = v108:GetBoundingBox()
    local v155 = style * v146:Inverse() * v111.CFrame:ToObjectSpace(boundingBox2)
    local v156 = 0

    for _, v158 in {-0.5, 0.5} do
        for _, v160 in {-0.5, 0.5} do
            for _, v162 in {-0.5, 0.5} do
                v156 = math.max(v156, -v155:PointToWorldSpace((Vector3.new(v158 * v154.X, v160 * v154.Y, v162 * v154.Z))).Z)
            end
        end
    end

    local v163 = norm * v146:Inverse() * v111.CFrame:ToObjectSpace(boundingBox2)
    local corners = {}

    for _, v166 in {-0.5, 0.5} do
        for _, v168 in {-0.5, 0.5} do
            for _, v170 in {-0.5, 0.5} do
                table.insert(corners, v163:PointToWorldSpace((Vector3.new(v166 * v154.X, v168 * v154.Y, v170 * v154.Z))))
            end
        end
    end

    local v171 = v111:FindFirstChild("Muzzle", true)
    local v172 = nil

    if v123 then
        if v123.pan then
            local viewPan = Instance.new("Attachment")
            viewPan.Name = "ViewPan"
            local pan = v123.pan
            local len2 = if v123.len then v123.len else cfg.len
            viewPan.Position = pan * (len2 / v143)
            viewPan.Parent = v111
            pan2 = viewPan
        else
            pan2 = v172
        end
    else
        pan2 = v172
    end

    if v123 and v123.muzzle then
        local viewMuzzle = Instance.new("Attachment")
        viewMuzzle.Name = "ViewMuzzle"
        local muzzle = v123.muzzle
        local len3 = if v123.len then v123.len else cfg.len
        viewMuzzle.Position = muzzle * (len3 / v143)
        viewMuzzle.Parent = v111
        v171 = viewMuzzle
    end

    local v179 = -(v16.hand.Z + cfg.pos.Z)

    local function asOffsets(a181)
        --[[
          name: asOffsets
          line: 717
          upvalues:
            BladeClips (copy, index: 1)
            styleRot (copy, index: 2)
            v16 (copy, index: 3)
            cfg (ref,  index: 4)
        ]]
        if type(a181) ~= "table" then
            return nil, nil
        end

        local v182 = BladeClips.Frame(a181.pos, a181.tip, a181.edge)
        local x, y, z = (v182.Rotation * styleRot:Inverse()):ToEulerAnglesYXZ()

        return v182.Position - (v16.hand + cfg.pos), (Vector3.new(x, y, z))
    end

    blockP, blockR = asOffsets(cfg.blockFrame)
    drawP, drawR = asOffsets(cfg.drawFrame)
    local v186 = 0
    brace3 = v186

    for _, v188 in corners do
        brace3 = math.max(brace3, v188.Z)
    end

    local v189 = {model = v108, gripInv = v146:Inverse(), pivotRel = v111.CFrame:ToObjectSpace(v108:GetPivot()), kind = kind, cfg = cfg, id = id, style = style, styleRot = styleRot, norm = norm, bladeLen = v152, blockP = blockP, blockR = blockR, drawP = drawP, drawR = drawR, brace = brace3}
    local clips = BladeClips.SETS[kind] or ItemClips.For(id, kind)
    v189.clips = clips
    local item = ItemClips.ITEMS[id]
    v189.drawFrom = item and item.drawFrom or BladeClips.DRAW[kind] or ItemClips.DRAW[kind]
    v189.corners = corners

    if v171 and v171:IsA("Attachment") then
        v121 = v171
    else
        v121 = if tip and tip:IsA("Attachment") then tip else nil
    end

    v189.muzzle = v121
    v189.tipAtt = if tip and tip:IsA("Attachment") then tip else nil
    v189.gripAtt = if rightGripAttachment2 and rightGripAttachment2:IsA("Attachment") then rightGripAttachment2 else nil
    v189.pan = pan2
    v189.hammer = hammerOf(v108, v111)
    v189.frizzen = hammerOf(v108, v111, "Frizzen", "FrizzenPivot", "Open")
    local v192 = if v171 and v171:IsA("Attachment") then v171 else nil
    v189.rod = rodOf(v108, v111, v192)
    local v193 = if id == "longbow" then v108:FindFirstChild("Neon", true) else nil
    v189.inlay = v193 and v193:IsA("BasePart") and {part = v193, rest = v193.Color} or nil
    local strip2 = v108:FindFirstChild("Strip", true)

    if strip2 and strip2:IsA("BasePart") then
        strip2.Transparency = 0
        strip3 = {part = strip2, size = strip2.Size, rest = v111.CFrame:ToObjectSpace(strip2.CFrame)}
    else
        strip3 = nil
    end

    v189.strip = strip3
    local stone = v108:FindFirstChild("Stone", true)
    v189.stone = if stone and stone:IsA("BasePart") then stone else nil

    local function pt(a197)
        --[[
          name: pt
          line: 779
          upvalues:
            v111 (copy, index: 1)
            norm (copy, index: 2)
            v146 (copy, index: 3)
        ]]
        local v198 = v111:FindFirstChild(a197)

        if v198 and v198:IsA("Attachment") then
            return ((norm * v146:Inverse()):PointToWorldSpace(v198.Position))
        end

        return nil
    end

    local nockTop = v111:FindFirstChild("NockTop")
    local v200 = if nockTop and nockTop:IsA("Attachment") then (norm * v146:Inverse()):PointToWorldSpace(nockTop.Position) else nil
    local nockBottom = v111:FindFirstChild("NockBottom")
    local v202 = if nockBottom and nockBottom:IsA("Attachment") then (norm * v146:Inverse()):PointToWorldSpace(nockBottom.Position) else nil
    local brace = v111:FindFirstChild("Brace")
    local v204 = if brace and brace:IsA("Attachment") then (norm * v146:Inverse()):PointToWorldSpace(brace.Position) else nil
    local nockPoint = v111:FindFirstChild("NockPoint")
    local v206 = if nockPoint and nockPoint:IsA("Attachment") then (norm * v146:Inverse()):PointToWorldSpace(nockPoint.Position) else nil
    local rest = v111:FindFirstChild("Rest")
    local v208 = if rest and rest:IsA("Attachment") then (norm * v146:Inverse()):PointToWorldSpace(rest.Position) else nil
    v189.bow = v200
        and v202
        and v204
        and v206
        and v208
        and {top = v200, bottom = v202, brace = v204, nock = v206, rest = v208}
        or nil

    local function pt2(a210)
        --[[
          name: pt
          line: 789
          upvalues:
            v111 (copy, index: 1)
            norm (copy, index: 2)
            v146 (copy, index: 3)
        ]]
        local v211 = v111:FindFirstChild(a210)

        if v211 and v211:IsA("Attachment") then
            return ((norm * v146:Inverse()):PointToWorldSpace(v211.Position))
        end

        return nil
    end

    local stringLeft = v111:FindFirstChild("StringLeft")
    local v213 = if stringLeft and stringLeft:IsA("Attachment") then (norm * v146:Inverse()):PointToWorldSpace(stringLeft.Position) else nil
    local stringRight = v111:FindFirstChild("StringRight")
    local v215 = if stringRight and stringRight:IsA("Attachment") then (norm * v146:Inverse()):PointToWorldSpace(stringRight.Position) else nil
    local nut = v111:FindFirstChild("Nut")
    local v217 = if nut and nut:IsA("Attachment") then (norm * v146:Inverse()):PointToWorldSpace(nut.Position) else nil
    local brace2 = v111:FindFirstChild("Brace")
    local v219 = if brace2 and brace2:IsA("Attachment") then (norm * v146:Inverse()):PointToWorldSpace(brace2.Position) else nil
    v189.xbow = kind == "Crossbow"
        and v213
        and v215
        and v217
        and v219
        and {left = v213, right = v215, nut = v217, brace = v219}
        or nil
    v189.tipCanon = if tip and tip:IsA("Attachment") then (norm * v146:Inverse()):PointToWorldSpace(tip.Position) else nil
    v189.handle = v111
    v189.leftFist = leftFist
    v189.wallDist = v179 + v156 + v16.wallMargin
    v189.wallRot = math.min(v16.wallRotMax, math.deg((math.asin((math.clamp(v156 / math.max(cfg.len, 0.05), 0, 1))))) + 12) * 0.017453292519943295

    if leftFist then
        leftFist.part.Parent = v108
    end

    v108.Name = "TribesViewModel_" .. id
    v20[id] = v189

    return v189
end

local spring = Spring.new(Vector3.new(0, 0, 0), v16.poseHz, v16.poseDamp)
local spring2 = Spring.new(Vector3.new(0, 0, 0), v16.poseHz, v16.poseDamp)
local spring3 = Spring.new(0, v16.airHz, v16.airDamp)
local spring4 = Spring.new(0, v16.airHz, v16.airDamp)
local spring5 = Spring.new(0, v16.landHz, v16.landDamp)
local spring6 = Spring.new(Vector3.new(0, 0, 0), v16.swayHz, v16.swayDamp)
local spring7 = Spring.new(Vector3.new(0, 0, 0), v16.mvHz, v16.mvDamp)
local spring8 = Spring.new(Vector3.new(0, 0, 0), v16.mvHz, v16.mvDamp)
local spring9 = Spring.new(Vector3.new(0, 0, 0), v16.kickHz, v16.kickDamp)
local spring10 = Spring.new(Vector3.new(0, 0, 0), v16.kickHz, v16.kickDamp)
local spring11 = Spring.new(0, v16.equipHz, v16.equipDamp)
local v231 = {
    shown = nil,
    wantId = nil,
    dropAt = nil,
    hiddenUntil = 0,
    action = nil,
    actT0 = 0,
    actDur = 1,
    actMirror = 1,
    block = false,
    parry = false,
    charge = false,
    chargeT0 = 0,
    chargeTime = 0.6,
    draw = false,
    drawT0 = 0,
    drawTime = 1,
    wind = false,
    windT0 = 0,
    windTime = 0.5,
    windHold = 0,
    windK = 0,
    windHalf = false,
    throwN = 0,
    looseAt = nil,
    nocked = true,
    nockT0 = -10,
    shotN = 0,
    arrowTip = nil,
    inlayLvl = 0,
    inlayFrom = Color3.new(),
    inlayT0 = -10,
    bite = 0,
    spinA = 0,
    spinT0 = -10,
    stringV = 0,
    stringT0 = -10,
    stripV = 0.25,
    useOutUntil = nil,
    use = false,
    useT0 = 0,
    useTime = 1,
    reload = false,
    reloadT0 = 0,
    reloadTime = 1,
    grounded = true,
    minVy = 0,
    lastYaw = nil,
    lastPitch = nil,
    lastRootY = nil,
    vy = 0,
    step = 0,
    now = 0,
    spent = false,
    clip = nil,
    clipT0 = 0,
    clipFrom = CFrame.identity,
    clipScale = 1,
    lastFrame = nil,
    frame = nil,
    layerPos = Vector3.new(0, 0, 0),
    layerRot = Vector3.new(0, 0, 0),
    spark = false,
    wallPush = 0,
    restFrame = CFrame.identity,
    rawVel = nil,
    clipFromVel = nil,
    lastFrameT = 0,
    clipName = nil,
    clipFx = 1,
    fxQueue = {},
    pendingDraw = nil,
    vanishAt = nil,
    shakeUntil = 0,
    embers = false,
    fuse = 0,
    arrowKind = "Arrow",
    sim = false,
    release = nil,
    releaseT = 0,
    boltIn = true,
    boltT0 = -10,
    drawHold = 0,
    drawHalf = false,
    drawFull = false,
    chargeFull = false,
    hammerTarget = 0,
    frizzenTarget = 0,
    rodV = 0,
    windFull = false,
    leftLast = nil,
    leftFrom = CFrame.identity,
    leftFromVel = nil,
    leftVel = nil,
    leftFrame = nil,
    leftOut = false,
    leftVanishAt = nil,
    leftCatchT = -10,
    lastLungeT = nil,
    lastLungeName = nil,
    refreshGlintAt = nil,
    refreshFF = nil,
    leftOutAt = -10,
    leftSeenOut = false
}
local spring12 = Spring.new(Vector3.new(0, 0, 0), v16.retHz, v16.retDamp)
local spring13 = Spring.new(0, 16, 0.45)
local spring14 = Spring.new(0, 14, 0.4)
local spring15 = Spring.new(Vector3.new(0, 0, 0), v16.retHz, v16.retDamp)

local function resetState()
    --[[
      name: resetState
      line: 917
      upvalues:
        spring (copy, index: 1)
        spring2 (copy, index: 2)
        spring3 (copy, index: 3)
        spring4 (copy, index: 4)
        spring5 (copy, index: 5)
        spring6 (copy, index: 6)
        spring7 (copy, index: 7)
        spring8 (copy, index: 8)
        spring9 (copy, index: 9)
        spring10 (copy, index: 10)
        spring11 (copy, index: 11)
        spring12 (copy, index: 12)
        spring15 (copy, index: 13)
        v231 (copy, index: 14)
        BladeSmear (copy, index: 15)
        ViewFx (copy, index: 16)
    ]]
    spring:Snap(Vector3.new(0, 0, 0))
    spring2:Snap(Vector3.new(0, 0, 0))
    spring3:Snap(0)
    spring4:Snap(0)
    spring5:Snap(0)
    spring6:Snap(Vector3.new(0, 0, 0))
    spring7:Snap(Vector3.new(0, 0, 0))
    spring8:Snap(Vector3.new(0, 0, 0))
    spring9:Snap(Vector3.new(0, 0, 0))
    spring10:Snap(Vector3.new(0, 0, 0))
    spring11:Snap(0)
    spring12:Snap(Vector3.new(0, 0, 0))
    spring15:Snap(Vector3.new(0, 0, 0))
    v231.action = nil
    v231.clip = nil
    v231.lastFrame = nil
    v231.frame = nil
    v231.spark = false
    v231.rawVel = nil
    v231.leftLast = nil
    v231.leftFromVel = nil
    v231.leftVel = nil
    v231.leftFrame = nil
    v231.leftOut = false
    v231.leftVanishAt = nil
    v231.leftCatchT = -10
    v231.leftOutAt = -10
    v231.leftSeenOut = false
    v231.lastLungeT = nil
    v231.lastLungeName = nil
    v231.refreshGlintAt = nil
    v231.refreshFF = nil
    v231.clipName = nil
    v231.pendingDraw = nil
    v231.vanishAt = nil
    v231.drawHold = 0
    v231.drawHalf = false
    v231.drawFull = false
    v231.nocked = true
    v231.nockT0 = -10
    v231.shotN = 0
    v231.looseAt = nil
    v231.windHold = 0
    v231.windK = 0
    v231.windFull = false
    v231.windHalf = false
    v231.throwN = 0
    v231.bite = 0
    v231.stringV = 0
    v231.stringT0 = -10
    v231.stripV = 0.25
    v231.useOutUntil = nil
    v231.spinA = 0
    v231.spinT0 = -10
    table.clear(v231.fxQueue)
    BladeSmear.Hide()
    ViewFx.Hide()
    v231.embers = false
    v231.fuse = 0
    v231.block = false
    v231.parry = false
    v231.charge = false
    v231.draw = false
    v231.wind = false
    v231.use = false
    v231.reload = false
    v231.dropAt = nil
    v231.hiddenUntil = 0
    v231.lastYaw = nil
    v231.lastPitch = nil
    v231.lastRootY = nil
    v231.vy = 0
    v231.minVy = 0
    v231.grounded = true
end

local function startAction(action, a239, a240)
    --[[
      name: startAction
      line: 955
      upvalues:
        v19 (copy, index: 1)
        v231 (copy, index: 2)
    ]]
    local v241 = v19[action]
    if not v241 then
        return
    end

    v231.action = action
    v231.actT0 = v231.now
    v231.actDur = a239 or v241.dur
    v231.actMirror = a240 or 1
end

local function rise()
    --[[
      name: rise
      line: 966
      upvalues:
        spring11 (copy, index: 1)
    ]]
    spring11.value = -1
    spring11.velocity = 0
    spring11.target = 0
end

local function startClip(clipName, a245: number?, a246, a247)
    --[[
      name: startClip
      line: 972
      upvalues:
        v231 (copy, index: 1)
        spring12 (copy, index: 2)
        spring15 (copy, index: 3)
    ]]
    local clip = if const v248 = if v231.shown then v231.shown.clips else nil then v248[clipName] else nil

    if not clip then
        return false
    end

    v231.clip = clip
    v231.clipName = clipName
    v231.clipFx = 1
    v231.clipFrom = a246 or v231.lastFrame or v231.restFrame
    v231.clipFromVel = if a246 then nil else v231.rawVel
    v231.leftFrom = a246 or v231.leftLast or v231.restFrame
    v231.leftFromVel = if a246 then nil else v231.leftVel
    local lastFrameT = v231.lastFrameT
    v231.clipT0 = if not a246 and v231.lastFrame and 0 <= v231.now - lastFrameT and v231.now - lastFrameT < 0.1 then lastFrameT else v231.now
    v231.clipScale = a247
        or (if a245 and 0 < a245 and 0 < clip.contact then math.clamp(a245 / clip.contact, 0.6, 1.8) else 1)
    spring12:Snap(Vector3.new(0, 0, 0))
    spring15:Snap(Vector3.new(0, 0, 0))

    return true
end

local function hasClip(clipKey)
    --[[
      name: hasClip
      line: 997
      upvalues:
        v231 (copy, index: 1)
    ]]
    local shown = v231.shown
    return shown ~= nil and shown.clips ~= nil and (shown.clips[clipKey] ~= nil)
end

local function clipTime(a255)
    --[[
      name: clipTime
      line: 1003
      upvalues:
        v231 (copy, index: 1)
    ]]
    return a255 - v231.clipT0
end

local function smooth(a257: number)
    --[[
      name: smooth
      line: 1010
    ]]
    local clampedValue = math.clamp(a257, 0, 1)
    return clampedValue * clampedValue * (3 - (clampedValue * 2))
end

local function onEvent(a260, options)
    --[[
      name: onEvent
      line: 1015
      upvalues:
        v231 (copy, index: 1)
        BladeClips (copy, index: 2)
        ItemClips (copy, index: 3)
        startClip (copy, index: 4)
        v19 (copy, index: 5)
        spring9 (copy, index: 6)
        spring10 (copy, index: 7)
        spring13 (copy, index: 8)
        spring14 (copy, index: 9)
        v16 (copy, index: 10)
    ]]
    local v262 = options or {}
    local shown = v231.shown
    local v264 = if shown then shown.kind else nil

    if a260 == "Swing" then
        local v265
        local number = tonumber(v262.step) or 1
        local finisher = v262.finisher == true

        if v264 == "Sword" then
            v265 = BladeClips.Pick(v264, number, finisher)
        elseif v264 == "Dagger" then
            v265 = BladeClips.Pick(v264, number, finisher)
        elseif v264 then
            local pick = ItemClips.Pick
            local v269 = v262.oneHanded == true or v231.leftOut
            v265 = pick(v264, number, finisher, v269)
        else
            v265 = nil
        end

        if v264 == "Shield" and v265 == "bash" then
            v231.shotN += 1

            if v231.shotN % 2 == 0 then
                local shown2 = v231.shown

                if shown2 ~= nil and shown2.clips ~= nil and shown2.clips.bash2 ~= nil then
                    v265 = "bash2"
                end
            end
        end

        if v265 and startClip(v265, (tonumber(v262.hitDelay))) then
            return
        end

        if v264 == "Shield" then
            local stab = v19.stab
            if not stab then
                return
            end

            v231.action = "stab"
            v231.actT0 = v231.now
            v231.actDur = stab.dur
            v231.actMirror = 1

            return
        end

        if v264 == "Axe" then
            local chop = v19.chop
            if not chop then
                return
            end

            v231.action = "chop"
            v231.actT0 = v231.now
            v231.actDur = chop.dur
            v231.actMirror = 1

            return
        end

        if v264 == "Club" then
            local smash = v19.smash
            if not smash then
                return
            end

            v231.action = "smash"
            v231.actT0 = v231.now
            v231.actDur = smash.dur
            v231.actMirror = 1

            return
        end

        if v264 == "Spear" then
            local thrust = v19.thrust
            if not thrust then
                return
            end

            v231.action = "thrust"
            v231.actT0 = v231.now
            v231.actDur = thrust.dur
            v231.actMirror = 1
        end
    elseif a260 == "Parry" then
        local parry = v231.parry
        v231.parry = v262.on == true

        if v231.parry and not parry then
            startClip("parry_in")
            return
        end

        if parry and not v231.parry then
            startClip("parry_out")
        end
    elseif a260 == "Parried" then
        v231.parry = false

        if not startClip("parry_hit") then
            spring9:Impulse(Vector3.new(0.029999999329447746, -0.03999999910593033, 0.07999999821186066))
        end
    else
        if a260 == "Hurl" then
            local v276 = if shown and shown.clips then shown.clips.throw else nil

            if v276 and startClip("throw") then
                v231.leftVanishAt = v231.now + ((v276.vanishLeft or 0.06) * v231.clipScale)
                return
            end

            v231.leftOut, v231.leftOutAt = true, v231.now

            return
        end

        if a260 == "Catch" then
            if v231.leftOut or v231.leftVanishAt then
                v231.leftOut = false
                v231.leftVanishAt = nil
                v231.leftSeenOut = false
                v231.leftCatchT = v231.now
            end
        elseif a260 == "Block" then
            local block = v231.block
            v231.block = v262.on == true

            if v231.block and not block then
                startClip("block_in")
                return
            end

            if block and not v231.block then
                startClip("block_out")
            end
        else
            if a260 == "Charge" then
                v231.charge = v262.on == true
                v231.chargeT0, v231.chargeTime = v231.now, tonumber(v262.time) or 0.6
                v231.chargeFull = false

                return
            end

            if a260 == "Heavy" then
                v231.charge = false

                if not startClip("heavy", (tonumber(v262.hitDelay))) then
                    local heavy = v19.heavy
                    if not heavy then
                        return
                    end

                    v231.action = "heavy"
                    v231.actT0 = v231.now
                    v231.actDur = heavy.dur
                    v231.actMirror = 1
                end
            elseif a260 == "Lunge" then
                v231.charge = false
                local number = tonumber(v262.time) or 0.25
                local v280 = "lunge"
                local shown3 = v231.shown

                if shown3 ~= nil and shown3.clips ~= nil and shown3.clips.lunge_b ~= nil then
                    local v282 = v231.now - v231.clipT0
                    local v283 = not v231.lastLungeT and math.huge or v231.now - v231.lastLungeT

                    if v231.clipName == "sweep_r" and v282 < 0.45
                        or ((v231.clipName == "lunge" or v231.clipName == "lunge_c")
                            and 0.22 < v282
                            and v282 < 0.34)
                    then
                        v280 = "lunge_b"
                    elseif 0 <= v283 and v283 < 1.5 and v231.lastLungeName == "lunge" then
                        local shown4 = v231.shown

                        if shown4 ~= nil and shown4.clips ~= nil and shown4.clips.lunge_c ~= nil then
                            v280 = "lunge_c"
                        end
                    end
                end

                v231.lastLungeT = v231.now
                v231.lastLungeName = v280
                local lungeRef = v231.shown
                    and v231.shown.clips
                    and v231.shown.clips[v280]
                    and v231.shown.clips[v280].lungeRef
                    or 0.24

                if v231.refreshGlintAt or v231.refreshFF then
                    v231.refreshGlintAt = v231.now
                end

                v231.refreshFF = nil

                if not startClip(v280, nil, nil, (math.clamp(number / lungeRef, 0.6, 2))) then
                    local v286 = number + 0.3
                    local lunge = v19.lunge
                    if not lunge then
                        return
                    end

                    v231.action = "lunge"
                    v231.actT0 = v231.now
                    v231.actDur = v286 or lunge.dur
                    v231.actMirror = 1
                end
            else
                if a260 == "Refresh" then
                    local clip = v231.clip

                    if not clip
                        or not clip.refreshAt
                        or not v231.clipScale
                        or not ((v231.now - v231.clipT0) / v231.clipScale < clip.refreshAt)
                    then
                        v231.refreshGlintAt = v231.now
                        return
                    end

                    v231.refreshFF = clip.refreshAt
                    v231.refreshGlintAt = nil

                    return
                end

                if a260 == "Draw" then
                    v231.draw = v262.on == true
                    v231.drawT0, v231.drawTime = v231.now, math.max(0.1, (tonumber(v262.time) or 1))

                    if v231.draw then
                        local arrow

                        if type(v262.arrow) ~= "string" then
                            arrow = "Arrow"
                        else
                            arrow = v262.arrow
                        end

                        v231.arrowKind = arrow
                        v231.drawHalf = false
                        v231.drawFull = false
                        v231.drawHold = 0

                        if not v231.nocked then
                            v231.nocked, v231.nockT0 = true, v231.now
                        end

                        startClip("nock")
                    end
                elseif a260 == "Release" then
                    local kick
                    v231.draw = false
                    v231.nocked = false
                    v231.drawHold = v231.now + 0.16
                    local clampedValue = math.clamp((tonumber(v262.charge) or 1), 0.2, 1)

                    if not shown or not shown.cfg.kick then
                        kick = 1
                    else
                        kick = shown.cfg.kick
                    end

                    local v292 = clampedValue * kick

                    if not startClip("release") then
                        spring9:Impulse(Vector3.new(0, 0.20000000298023224, 1.2000000476837158) * v292)
                        spring10:Impulse((Vector3.new(120, 0, 0) * v292) * 0.017453292519943295)
                    end
                else
                    if a260 == "Fire" then
                        v231.boltIn = false
                        v231.stringV, v231.stringT0 = 1, v231.now
                        v231.hammerTarget = 1
                        spring13.velocity = 30
                        v231.frizzenTarget = 1
                        spring14.velocity = 22
                        local v293 = (v231.clipName == "draw" or v231.clipName == "redraw")
                            and v231.clip ~= nil
                            and v231.now - v231.clipT0 < (v231.clip.release * v231.clipScale) * 0.7
                        local kick
                        local v295 = false

                        if v293 then
                            table.insert(v231.fxQueue, "muzzle")
                        end

                        local v296 = v231
                        v296.shotN += 1

                        if not v293 and startClip("fire") then
                            local vector3 = ({Musket = Vector3.new(160, 80, 280), Blunderbuss = Vector3.new(220, 80, 260), Pistol = Vector3.new(340, 60, 220), Crossbow = Vector3.new(130, 50, 90)})[v264
                                or ""]
                                or Vector3.new(150, 60, 150)
                            local random = Random.new((v231.shotN * 7919) + 17)
                            spring10:Impulse(Vector3.new(random:NextNumber(-1, 1) * vector3.X, random:NextNumber(-1, 1) * vector3.Y, random:NextNumber(-1, 1) * vector3.Z) * 0.017453292519943295)

                            return
                        end

                        local v299 = (tonumber(v262.kick) or 2) / 3

                        if shown then
                            if shown.cfg.kick then
                                kick = shown.cfg.kick
                            else
                                v295 = true
                            end
                        else
                            v295 = true
                        end

                        if v295 then
                            kick = 1
                        end

                        local v300 = math.min(v299 * kick, 3.5)
                        spring9:Impulse(Vector3.new(0, 0.5, 3) * v300)
                        spring10:Impulse((Vector3.new(420, (math.random() - 0.5) * 40, (math.random() - 0.5) * 40) * v300) * 0.017453292519943295)

                        return
                    end

                    if a260 == "Reload" then
                        local reload
                        local reloadTime = math.max(0.2, (tonumber(v262.time) or 1.2))

                        if shown then
                            if shown.clips then
                                reload = shown.clips.reload
                            else
                                reload = nil
                            end
                        else
                            reload = nil
                        end

                        if not reload then
                            v231.reload = true
                            v231.reloadT0 = v231.now
                            v231.reloadTime = reloadTime

                            return
                        end

                        local v303 = reload.span or reload.release
                        startClip("reload", nil, nil, (math.clamp(reloadTime / v303, 0.35, 2.5)))

                        return
                    end

                    if a260 == "ReloadEnd" then
                        v231.reload = false
                        return
                    end

                    if a260 ~= "Windup" then
                        if a260 == "Throw" then
                            v231.throwN += 1
                            local clipKey = shown
                                and shown.clips
                                and shown.clips.throw2
                                and v231.throwN % 2 == 0
                                and "throw2"
                                or "throw"
                            local v305 = if shown and shown.clips then shown.clips[clipKey] else nil

                            if v231.wind then
                                local vanish
                                local clampedValue = math.clamp((v231.now - v231.windT0) / v231.windTime, 0, 1)
                                local clampedValue2 = math.clamp((v231.now - v231.windT0) / 0.12, 0, 1)
                                local v309 = clampedValue2 * clampedValue2 * (3 - (clampedValue2 * 2)) * 0.75
                                local clampedValue3 = math.clamp(clampedValue, 0, 1)
                                v231.windK = v309 + ((clampedValue3 * clampedValue3 * (3 - (clampedValue3 * 2))) * 0.25)
                                local now = v231.now

                                if v305 and v305.vanish then
                                    vanish = v305.vanish
                                else
                                    vanish = 0.07
                                end

                                v231.windHold = (now + vanish) + 0.06
                            end

                            v231.wind = false

                            if v305 and startClip(clipKey) then
                                if v305.vanish then
                                    v231.vanishAt = v231.now + (v305.vanish * v231.clipScale)
                                    v231.hiddenUntil = v231.vanishAt + (ItemClips.HIDE[v264 or ""] or 0.45)

                                    return
                                end

                                if v305.loose then
                                    v231.looseAt = v231.now + (v305.loose * v231.clipScale)
                                end
                            else
                                if const throw = v19.throw then
                                    v231.action = "throw"
                                    v231.actT0 = v231.now
                                    v231.actDur = throw.dur
                                    v231.actMirror = 1
                                end

                                v231.hiddenUntil = v231.now + 0.5
                            end
                        elseif a260 ~= "Use" then
                            if a260 == "Place" then
                                local v313 = if shown and shown.clips then shown.clips.place else nil

                                if v313 and startClip("place") then
                                    v231.vanishAt = v231.now + (v313.vanish or 0.2)
                                    v231.hiddenUntil = v231.vanishAt + (ItemClips.HIDE[v264 or ""] or 0.5)

                                    return
                                elseif const place = v19.place then
                                    v231.action = "place"
                                    v231.actT0 = v231.now
                                    v231.actDur = place.dur
                                    v231.actMirror = 1
                                end

                                v231.hiddenUntil = v231.now + 0.6

                                return
                            end

                            if a260 == "Hurt" then
                                local v315

                                if v262.blocked and v231.block and shown then
                                    if shown.cfg.blockFrame then
                                        v231.spark = true
                                    else
                                        local shown5 = v231.shown

                                        if shown5 ~= nil
                                            and shown5.clips ~= nil
                                            and (shown5.clips.block_hit ~= nil)
                                        then
                                            startClip("block_hit")
                                            table.insert(v231.fxQueue, "rimspark")
                                        end
                                    end
                                end

                                local clampedValue = math.clamp((tonumber(v262.amount) or 10) / 40, 0.2, 1.2)

                                if v262.blocked then
                                    v315 = 0.5
                                else
                                    v315 = 1
                                end

                                local v318 = clampedValue * v315
                                spring10:Impulse(((Vector3.new((math.random() - 0.3) * 2, (math.random() - 0.5) * 2, (math.random() - 0.5) * 2.5) * v16.hurtRot) * v318) * 0.017453292519943295)
                                spring9:Impulse(Vector3.new(0, -v16.hurtPos, v16.hurtPos * 0.6) * v318)
                            end
                        else
                            local use = v231.use
                            v231.use = v262.on == true
                            v231.useT0, v231.useTime = v231.now, math.max(0.2, (tonumber(v262.time) or 1))

                            if v231.use and not use then
                                v231.bite = 0
                                startClip("use_in")

                                return
                            end

                            if not v231.use and use then
                                v231.useOutUntil = v231.now + 0.45

                                if not v262.done then
                                    startClip("use_out")
                                    return
                                end

                                if not startClip("use_done") then
                                    spring9:Impulse(Vector3.new(0, 0.5, 0))
                                end
                            elseif v262.done then
                                spring9:Impulse(Vector3.new(0, 0.5, 0))
                            end
                        end
                    else
                        v231.wind = v262.on == true
                        v231.windFull = false
                        v231.windHalf = false
                        v231.windHold = 0
                        v231.windT0, v231.windTime = v231.now, math.max(0.1, (tonumber(v262.time) or 0.5))

                        if v231.wind then
                            startClip("windup")
                        end
                    end
                end
            end
        end
    end
end

local function evalKeys(keys, a322)
    --[[
      name: evalKeys
      line: 1281
    ]]
    local keyKey = #keys

    if a322 <= keys[1][1] then
        return keys[1][2], keys[1][3]
    end

    local key, key2, v326, v327

    for keyKey2 = 1, keyKey - 1 do
        key = keys[keyKey2]
        key2 = keys[keyKey2 + 1]
        v326 = key[1]
        v327 = key2[1]

        if a322 <= v327 then
            local clampedValue = math.clamp((a322 - v326) / math.max(v327 - v326, 1e-04), 0, 1)
            local alpha = clampedValue * clampedValue * (3 - (clampedValue * 2))

            return key[2]:Lerp(key2[2], alpha), key[3]:Lerp(key2[3], alpha)
        end
    end

    return keys[keyKey][2], keys[keyKey][3]
end

local function wrap(a332)
    --[[
      name: wrap
      line: 1297
    ]]
    return ((a332 + math.pi) % math.tau) - math.pi
end

local function step(a334)
    --[[
      name: step
      line: 1303
      upvalues:
        v231 (copy, index: 1)
        v17 (copy, index: 2)
        v16 (copy, index: 3)
        prepare (copy, index: 4)
        spring12 (copy, index: 5)
        spring15 (copy, index: 6)
        ViewFx (copy, index: 7)
        spring13 (copy, index: 8)
        spring14 (copy, index: 9)
        spring11 (copy, index: 10)
        spring5 (copy, index: 11)
        spring6 (copy, index: 12)
        spring9 (copy, index: 13)
        spring10 (copy, index: 14)
        spring (copy, index: 15)
        spring2 (copy, index: 16)
        spring3 (copy, index: 17)
        spring4 (copy, index: 18)
        spring7 (copy, index: 19)
        spring8 (copy, index: 20)
        v19 (copy, index: 21)
        evalKeys (copy, index: 22)
        startClip (copy, index: 23)
        BladeClips (copy, index: 24)
        evalTrack (copy, index: 25)
    ]]
    local id
    local lastFrame2
    local clampedValue = math.clamp(a334.dt, 0.004166666666666667, 0.1)
    local now = a334.now
    v231.now = now

    if not a334.visible or not a334.id or not a334.kind or not v17[a334.kind] then
        id = nil
    else
        id = a334.id
    end

    if id ~= v231.wantId then
        v231.wantId = id

        if v231.shown and v231.shown.id ~= id and not v231.dropAt then
            v231.dropAt = now
        end
    end

    if v231.dropAt and v231.shown and v231.shown.id == v231.wantId then
        v231.dropAt = nil
    end

    do
        local v339 = if v231.shown then v231.shown.id else nil

        do
            local v340, v341 = false, false

            if v339 ~= v231.wantId then
                if v231.shown == nil then
                    v340 = true
                elseif v231.dropAt ~= nil then
                    local v342 = now - v231.dropAt

                    if v16.dropTime <= v342 then
                        v340 = true
                    end
                end
            end

            if v340 then
                do
                    local shown
                    v231.dropAt = nil

                    if v231.wantId then
                        shown = prepare(v231.wantId, a334.kind)
                    else
                        shown = nil
                    end

                    v231.shown = shown
                    v231.action = nil
                    v231.clip = nil
                    v231.lastFrame = nil
                    v231.rawVel = nil
                    v231.clipName = nil
                    spring12:Snap(Vector3.new(0, 0, 0))
                    spring15:Snap(Vector3.new(0, 0, 0))
                    v231.block = false
                    v231.parry = false
                    v231.charge = false
                    v231.draw = false
                    v231.wind = false
                    v231.use = false
                    v231.reload = false
                    v231.hiddenUntil = 0
                    v231.vanishAt = nil
                    v231.drawHold = 0
                    v231.windHold = 0
                    v231.looseAt = nil
                    v231.nocked = false
                    v231.nockT0 = -10
                    v231.stringV = 0
                    v231.stringT0 = -10
                    table.clear(v231.fxQueue)

                    if v231.embers then
                        v231.embers = false
                        ViewFx.Play("embers", CFrame.identity, {on = false})
                    end
                end

                if 0 < v231.fuse then
                    v231.fuse = 0
                    ViewFx.Play("fuse", CFrame.identity, {on = false})
                end

                v231.boltIn = true
                v231.boltT0 = -10
                v231.hammerTarget = 0.5
                spring13:Snap(0.5)
                v231.frizzenTarget = 0
                spring14:Snap(0)

                if v231.shown then
                    if v231.shown.drawFrom then
                        if v231.shown.clips then
                            if v231.shown.clips.draw then
                                spring11:Snap(0)
                                v231.pendingDraw = "draw"
                            else
                                v341 = true
                            end
                        else
                            v341 = true
                        end
                    else
                        v341 = true
                    end
                end
            end

            if v341 then
                spring11.value = -1
                spring11.velocity = 0
                spring11.target = 0
            end
        end
    end

    local shown = v231.shown
    if not shown then
        return Vector3.new(0, 0, 0), Vector3.new(0, 0, 0), nil
    end

    local cfg = shown.cfg

    if v231.lastRootY and 0 < clampedValue then
        local v346 = (a334.rootY - v231.lastRootY) / clampedValue

        if 150 < math.abs(v346) then
            v346 = 0
        end

        do
            local v347 = v231
            v347.vy += ((v346 - v231.vy) * (1 - math.exp(clampedValue * -14)))
        end
    end

    v231.lastRootY = a334.rootY

    if a334.grounded then
        if not v231.grounded then
            do
                local v348 = -v231.minVy

                if 6 < v348 then
                    spring5:Impulse(-math.min(v348 * v16.landK, v16.landMax))
                end
            end

            v231.minVy = 0
        end
    else
        v231.minVy = math.min(v231.minVy, v231.vy)
    end

    v231.grounded = a334.grounded
    local lookVector = a334.cam.LookVector
    local lastYaw = math.atan2(-lookVector.X, -lookVector.Z)
    local lastPitch = math.asin((math.clamp(lookVector.Y, -1, 1)))

    if v231.lastYaw then
        local v352 = ((lastYaw - v231.lastYaw) + math.pi) % math.tau - math.pi
        local v353 = lastPitch - v231.lastPitch

        if math.abs(v352) < 1.2 and math.abs(v353) < 1.2 then
            spring6.value += (Vector3.new(-v353, -v352, -v352 * 0.5) * v16.swayK)
        end
    end

    v231.lastYaw = lastYaw
    v231.lastPitch = lastPitch
    local v354 = a334.aiming and cfg.aimPos ~= nil
    local v355 = v16.hand + cfg.pos
    local v356 = if a334.touch and not v354 then v16.touchHand else Vector3.new(0, 0, 0)
    local target = v355 + v356
    local target2 = Vector3.new(0, 0, 0)

    if v354 then
        target += cfg.aimPos
        target2 += (cfg.aimRot or Vector3.new(0, 0, 0)) * 0.017453292519943295
    end

    if v231.block and shown.blockP and shown.blockR then
        target += shown.blockP
        target2 += shown.blockR
    elseif v231.block and cfg.block then
        target += cfg.block[1] + Vector3.new(0, math.sin(now * 3) * 0.004, 0)
        target2 += cfg.block[2] * 0.017453292519943295 + Vector3.new(0, 0, (math.sin(now * 2.3) * 0.5) * 0.017453292519943295)
    end

    local v359 = 0
    local v360 = 0

    if v231.charge and cfg.charge then
        local clampedValue2 = math.clamp((now - v231.chargeT0) / v231.chargeTime, 0, 1)
        local clampedValue3 = math.clamp(clampedValue2, 0, 1)
        local v363 = (clampedValue3 * clampedValue3 * (3 - (clampedValue3 * 2))) * 0.15 + 0.85

        if cfg.chargeIn then
            local v364 = math.clamp((now - v231.chargeT0) / cfg.chargeIn, 0, 1) - 1
            v363 *= (((v364 * 3.6) * v364) * v364) + 1 + ((v364 * 2.6) * v364)
        end

        target += cfg.charge[1] * v363
        target2 += (cfg.charge[2] * 0.017453292519943295) * v363
        v359 += (clampedValue2 * 0.0028) + 0.0012

        if 1 <= clampedValue2 and not v231.chargeFull then
            v231.chargeFull = true
            spring9:Impulse(Vector3.new(0, 1.5, 1.2000000476837158))
            table.insert(v231.fxQueue, "headglint")
        end
    end

    do
        local v365 = now - (v231.drawHold - 0.16)
        local v366 = not v231.draw and 0 < v231.drawHold and v365 < 0.36

        if (v231.draw or v366) and (cfg.draw or shown.drawP) then
            local v367

            do
                local v368 = not v231.draw and 1 or math.clamp((now - v231.drawT0) / v231.drawTime, 0, 1)

                if v231.draw then
                    local clampedValue4 = math.clamp((now - v231.drawT0) / 0.14, 0, 1)
                    local v370 = clampedValue4 * clampedValue4 * (3 - (clampedValue4 * 2)) * 0.7
                    local clampedValue5 = math.clamp(v368, 0, 1)
                    v367 = v370 + (clampedValue5 * clampedValue5 * (3 - (clampedValue5 * 2))) * 0.3
                else
                    local clampedValue6 = math.clamp((v365 - 0.16) / 0.2, 0, 1)
                    v367 = 1 - clampedValue6 * clampedValue6 * (3 - (clampedValue6 * 2))
                end

                if shown.drawP and shown.drawR then
                    target += shown.drawP * v367
                    target2 += shown.drawR * v367
                elseif cfg.draw then
                    target += cfg.draw[1] * v367
                    target2 += (cfg.draw[2] * 0.017453292519943295) * v367
                end

                if v231.draw then
                    if 1 <= v368 then
                        v360 = math.clamp((now - v231.drawT0 - v231.drawTime) / 0.5, 0.3, 1) * 7e-04
                    end

                    do
                        local v373 = shown.kind == "Bow" and cfg.stock == nil

                        if v373 and 0.5 <= v368 and not v231.drawHalf then
                            v231.drawHalf = true
                            spring9:Impulse(Vector3.new(0, -1.100000023841858, 0.8999999761581421))
                            spring10:Impulse(Vector3.new(-3.4906585216522217, 0, 0))
                            table.insert(v231.fxQueue, "sfx:Gun_Cock")
                        end
                    end

                    if 1 <= v368 and not v231.drawFull then
                        v231.drawFull = true
                        spring9:Impulse(Vector3.new(0, -0.800000011920929, 0.6000000238418579))
                        spring10:Impulse(Vector3.new(-2.268928050994873, 0, 0))
                        table.insert(v231.fxQueue, "fullglint")
                    end
                end
            end
        end
    end

    if v231.wind and cfg.windup then
        local clampedValue7 = math.clamp((now - v231.windT0) / v231.windTime, 0, 1)

        do
            local clampedValue8 = math.clamp((now - v231.windT0) / 0.12, 0, 1)
            local v376 = clampedValue8 * clampedValue8 * (3 - (clampedValue8 * 2)) * 0.75
            local clampedValue9 = math.clamp(clampedValue7, 0, 1)
            local v378 = v376 + (clampedValue9 * clampedValue9 * (3 - (clampedValue9 * 2))) * 0.25
            target += cfg.windup[1] * v378
            target2 += (cfg.windup[2] * 0.017453292519943295) * v378
        end

        v359 += (clampedValue7 * 0.003) + 0.001

        if shown.id == "harpoon" and 0.5 <= clampedValue7 and not v231.windHalf then
            v231.windHalf = true
            spring9:Impulse(Vector3.new(0, -0.5, 0.4000000059604645))
            table.insert(v231.fxQueue, "glint")
            table.insert(v231.fxQueue, "sfx:Crossbow_Crank")
        end

        if 1 <= clampedValue7 and not v231.windFull then
            v231.windFull = true
            spring9:Impulse(Vector3.new(0, -1.600000023841858, 1.2000000476837158))
            spring10:Impulse(Vector3.new(-2.7925267219543457, 0, 0))
            table.insert(v231.fxQueue, "glint")
            table.insert(v231.fxQueue, ((shown.id ~= "harpoon"
                and (shown.kind ~= "Bomb" and "sfx:Knife_Ready" or "sfx:Equip_Item"))
                or "sfx:Crossbow_Ready"))
        end
    elseif now < v231.windHold and cfg.windup then
        target += cfg.windup[1] * v231.windK
        target2 += cfg.windup[2] * 0.017453292519943295 * v231.windK
    end

    local v379 = 0

    if v231.use and cfg.use then
        target += cfg.use[1]
        target2 += cfg.use[2] * 0.017453292519943295

        if 0.15 < now - v231.useT0 and (not shown.clips or not shown.clips.use_loop) then
            v379 = 1
        end

        local v380 = now - v231.useT0

        if v231.useTime + 0.3 < v380 then
            v231.use = false
        end
    end

    local v381 = 0

    if v231.reload then
        local v382 = (now - v231.reloadT0) / v231.reloadTime

        if not (1.15 <= v382) then
            do
                local clampedValue10 = math.clamp(v382 / 0.2, 0, 1)
                local v384 = clampedValue10 * clampedValue10 * (3 - (clampedValue10 * 2))
                local clampedValue11 = math.clamp((v382 - 0.78) / 0.22, 0, 1)
                local v386 = v384 * (1 - (clampedValue11 * clampedValue11 * (3 - (clampedValue11 * 2))))
                target += Vector3.new(-0.03999999910593033, -0.10000000149011612, 0.019999999552965164) * v386
                target2 += Vector3.new(0.48869219422340393, 0.41887903213500977, 0.593411922454834) * v386
            end

            if 0.25 < v382 and v382 < 0.75 then
                v381 = 1
            end
        else
            v231.reload = false
        end
    end

    if a334.sliding then
        target += v16.slidePos
        target2 += v16.slideRot * 0.017453292519943295
    end

    do
        local wall = a334.wall

        if wall and wall < shown.wallDist then
            local clampedValue12 = math.clamp((shown.wallDist - wall) / math.max(shown.wallDist - v16.wallMin, 0.1), 0, 1)
            target += v16.wallPos * clampedValue12
            target2 += Vector3.new(shown.wallRot * clampedValue12, 0, 0)
        end
    end

    spring.frequency = v231.useOutUntil and now < v231.useOutUntil and 3.2 or v16.poseHz
    spring2.frequency = spring.frequency
    spring.target = target
    spring2.target = target2
    spring:Update(clampedValue)
    spring2:Update(clampedValue)

    do
        local target3 = math.clamp(-v231.vy * v16.airK, -v16.airMax, v16.airMax)
        local target4 = math.clamp(-v231.vy * v16.airTiltK, -v16.airTiltMax, v16.airTiltMax) * 0.017453292519943295

        if a334.grounded then
            target3 = 0
            target4 = 0
        end

        spring3.target = target3
        spring4.target = target4
        spring3:Update(clampedValue)
        spring4:Update(clampedValue)
        spring5:Update(clampedValue)
        spring6:Update(clampedValue)
    end

    do
        local clampedValue13 = 0
        local clampedValue14 = 0

        if const vel = a334.vel then
            local rightVector = a334.cam.RightVector
            local lookVector2 = a334.cam.LookVector

            do
                local vector3 = Vector3.new(rightVector.X, 0, rightVector.Z)
                local vector32 = Vector3.new(lookVector2.X, 0, lookVector2.Z)

                if 0.001 < vector3.Magnitude and 0.001 < vector32.Magnitude then
                    clampedValue13 = math.clamp(vel:Dot(vector3.Unit) / v16.mvRun, -v16.mvMax, v16.mvMax)
                    clampedValue14 = math.clamp(vel:Dot(vector32.Unit) / v16.mvRun, -v16.mvMax, v16.mvMax)
                end
            end
        end

        local v398 = not a334.aiming and 1 or v16.mvAimed

        do
            local v399 = v398 * v16.mvRun
            spring7.target = Vector3.new(-clampedValue13 * v16.mvX, 0, math.abs(clampedValue14) * v16.mvZ) * v399
            spring8.target = (Vector3.new(-clampedValue14 * v16.mvPitch, clampedValue13 * v16.mvYaw, -clampedValue13 * v16.mvRoll) * v399) * 0.017453292519943295
        end

        spring7:Update(clampedValue)
        spring8:Update(clampedValue)

        do
            local value = spring6.value
            local v401 = v16.swayMax * 0.017453292519943295

            if v401 < value.Magnitude then
                spring6.value = value.Unit * v401
            end
        end
    end

    spring9:Update(clampedValue)
    spring10:Update(clampedValue)
    spring11:Update(clampedValue)
    spring13.target = v231.hammerTarget
    spring13:Update(clampedValue)
    spring14.target = v231.frizzenTarget
    spring14:Update(clampedValue)
    local value = spring.value
    local value2 = spring2.value
    local v404 = (now * v16.idleHz) * 2 * math.pi
    local v405 = value + Vector3.new((math.sin(v404 * 0.5) * v16.idlePos) * 0.6, math.sin(v404) * v16.idlePos, 0)
    local v406 = value2 + Vector3.new(math.sin(v404 + 0.6) * v16.idleRot, 0, (math.sin(v404 * 0.5) * v16.idleRot) * 0.5) * 0.017453292519943295

    do
        local bobAmount = a334.bobAmount

        if 0 < bobAmount then
            local bobPhase = a334.bobPhase
            local v409 = math.abs((math.cos(bobPhase))) - 0.64
            v405 += Vector3.new((math.sin(bobPhase) * v16.bobX) * bobAmount, (-v409 * v16.bobY) * bobAmount, 0)
            v406 += Vector3.new((v409 * v16.bobPitch) * bobAmount, 0, (math.sin(bobPhase) * v16.bobRoll) * bobAmount) * 0.017453292519943295
        end
    end

    local v410 = v405 + Vector3.new(0, spring3.value + (spring5.value * v16.landDist), 0)
    local v411 = v406 + Vector3.new(spring4.value + (spring5.value * 0.12), 0, 0)
    local value3 = spring6.value
    local v413 = v411 + value3
    local v414 = v410 + Vector3.new(-value3.Y * v16.swayShift, value3.X * v16.swayShift, 0) + spring7.value
    local v415 = v413 + spring8.value
    local v416 = v414 + spring9.value
    local v417 = v415 + spring10.value

    if 0 < v359 then
        v416 += Vector3.new(math.sin(now * 84) * v359, math.sin((now * 71) + 1) * v359, 0)
    end

    if 0 < v360 then
        v416 += Vector3.new(math.sin(now * 33) * v360, math.sin((now * 27) + 1) * v360, 0)
    end

    if a334.sliding then
        do
            local slideShake = v16.slideShake
            v416 += Vector3.new(math.sin(now * 53) * slideShake, math.sin((now * 71) + 2) * slideShake, 0)
        end

        v417 += Vector3.new(0, 0, (math.sin(now * 39) * 1.6) * 0.017453292519943295)
    end

    if 0 < v381 then
        v417 += Vector3.new(math.sin(now * 42) * 5, 0, math.sin((now * 33) + 1) * 7) * 0.017453292519943295
        v416 += Vector3.new(0, math.abs((math.sin(now * 21))) * 0.012, 0)
    end

    if 0 < v379 then
        local absoluteValue = math.abs((math.sin((now - v231.useT0) * 9)))
        v416 += Vector3.new(0, absoluteValue * 0.022, -absoluteValue * 0.012)
        v417 += Vector3.new(absoluteValue * 9, 0, 0) * 0.017453292519943295
    end

    do
        local v420, v421

        do
            local v422, v423 = false, false

            if v231.action then
                local v424 = v19[v231.action]
                local v425 = (now - v231.actT0) / v231.actDur

                if v424 then
                    if not (1 <= v425) then
                        v420, v421 = evalKeys(v424.keys, v425)

                        if v424.mirror and v231.actMirror < 0 then
                            v420 = Vector3.new(-v420.X, v420.Y, v420.Z)
                            v421 = Vector3.new(v421.X, -v421.Y, -v421.Z)
                        end

                        v423 = true
                    else
                        v422 = true
                    end
                else
                    v422 = true
                end
            end

            if v422 then
                v231.action = nil
            end

            if v423 then
                v416 += v420
                v417 += v421 * 0.017453292519943295
            end
        end
    end

    local value4 = spring11.value
    local v427 = v416 + Vector3.new(0, value4 * v16.equipDrop, 0)
    local v428 = v417 + Vector3.new((-value4 * v16.equipTilt) * 0.017453292519943295, 0, 0)

    if v231.dropAt then
        local clampedValue15 = math.clamp((now - v231.dropAt) / v16.dropTime, 0, 1)
        local v430 = clampedValue15 * clampedValue15
        v427 += Vector3.new(0, -v16.equipDrop * v430, 0)
        v428 += Vector3.new((-v16.equipTilt * 0.017453292519943295) * v430, 0, 0)
    end

    if 0 < v231.hiddenUntil and v231.hiddenUntil <= now then
        v231.hiddenUntil = 0
        v231.vanishAt = nil

        if v231.action == "throw" or v231.action == "place" then
            v231.action = nil
        end

        if not shown.drawFrom or not shown.clips or not shown.clips.redraw and not shown.clips.draw then
            spring11.value = -1
            spring11.velocity = 0
            spring11.target = 0
        else
            v231.clip = nil
            v231.clipName = nil
            v231.pendingDraw = shown.clips.redraw and "redraw" or "draw"
        end
    end

    v231.frame = nil
    v231.wallPush = 0
    local value5 = spring.value
    local value6 = spring2.value
    local layerPos = v427 - value5
    local layerRot = v428 - value6
    v231.layerPos, v231.layerRot = layerPos, layerRot
    local restFrame = CFrame.new(value5) * CFrame.fromEulerAnglesYXZ(value6.X, value6.Y, value6.Z) * shown.styleRot
    v231.restFrame = restFrame

    if v231.pendingDraw then
        local pendingDraw = v231.pendingDraw
        v231.pendingDraw = nil

        if shown.drawFrom then
            startClip(pendingDraw, nil, BladeClips.StartFrame(shown.drawFrom, restFrame))
            v231.clipFromVel = {pos = Vector3.new(0, 3.5, 0), tip = Vector3.new(0, 0, 0), edge = Vector3.new(0, 0, 0)}
        end
    end

    if v231.refreshFF then
        if not v231.clip or not ((now - v231.clipT0) / v231.clipScale < v231.refreshFF) then
            v231.refreshFF = nil
            v231.refreshGlintAt = now + 0.05
        else
            local v437 = v231
            v437.clipT0 -= (4 * clampedValue)
        end
    end

    if v231.refreshGlintAt and v231.refreshGlintAt <= now then
        v231.refreshGlintAt = nil
        table.insert(v231.fxQueue, "headglint")
        spring9:Impulse(Vector3.new(0, 0.6000000238418579, 0))
    end

    do
        local clip = v231.clip
        v231.rodV = 0

        if clip then
            local v439 = now - v231.clipT0

            if clip.rod then
                v231.rodV = evalTrack(clip.rod, v439 / v231.clipScale)
            end

            if clip.string then
                v231.stringV = evalTrack(clip.string, v439 / v231.clipScale)
            end

            if clip.strip then
                v231.stripV = evalTrack(clip.strip, v439 / v231.clipScale)
            end

            do
                if const fx = clip.fx then
                    while v231.clipFx <= #fx and fx[v231.clipFx][1] * v231.clipScale <= v439 do
                        do
                            local v441 = fx[v231.clipFx]
                            local v442 = v441[2]

                            if v442 == "bolt" then
                                v231.boltIn = true
                                v231.boltT0 = now
                            elseif v442 == "half" then
                                v231.hammerTarget = 0.5
                            elseif v442 == "prime" then
                                v231.frizzenTarget = 0
                            elseif v442 == "nock" then
                                v231.nocked = true
                                v231.nockT0 = now
                            elseif v442 == "click" then
                                v231.hammerTarget = 0
                            end

                            table.insert(v231.fxQueue, v442)

                            if type(v441[3]) == "string" then
                                local v443

                                do
                                    local fxQueue = v231.fxQueue
                                    local v445 = v441[3]

                                    if type(v441[4]) == "number" then
                                        v443 = "@" .. v441[4]
                                    else
                                        v443 = ""
                                    end

                                    table.insert(fxQueue, "sfx:" .. v445 .. v443)
                                end
                            end
                        end

                        do
                            local v446 = v231
                            v446.clipFx += 1
                        end
                    end
                end
            end

            do
                local v447 = BladeClips.Eval(clip, v231.clipFrom, v439, v231.clipScale, restFrame, v231.clipFromVel)
                local v448 = clip.release * v231.clipScale <= v439

                if v448
                    and not v231.dropAt
                    and v231.use
                    and (v231.clipName == "use_in" or v231.clipName == "use_loop")
                    and startClip("use_loop", nil, v447)
                then
                    lastFrame2 = v447
                elseif v448
                    and not v231.dropAt
                    and v231.parry
                    and (v231.clipName == "parry_in" or v231.clipName == "parry_hold")
                    and startClip("parry_hold", nil, v447)
                then
                    lastFrame2 = v447
                elseif v448 or v231.dropAt then
                    spring12:Snap(v447.Position - restFrame.Position)
                    spring12.target = Vector3.new(0, 0, 0)

                    do
                        local v449, v450 = (v447.Rotation * restFrame.Rotation:Inverse()):ToAxisAngle()
                        spring15:Snap(v449 * v450)
                    end

                    spring15.target = Vector3.new(0, 0, 0)

                    if not v231.dropAt then
                        local v451 = BladeClips.Eval(clip, v231.clipFrom, math.max(0, v439 - 0.004166666666666667), v231.clipScale, restFrame, v231.clipFromVel)
                        spring12.velocity = (v447.Position - v451.Position) / 0.004166666666666667 + (clip.vel
                            or Vector3.new(0, 0, 0))
                        local v452, v453 = (v447.Rotation * v451.Rotation:Inverse()):ToAxisAngle()
                        spring15.velocity = v452 * math.min(v453 / 0.004166666666666667, 20)
                    end

                    v231.clip = nil
                    v231.clipName = nil
                    lastFrame2 = restFrame
                else
                    lastFrame2 = v447
                end
            end
        else
            lastFrame2 = restFrame
        end
    end

    do
        local value7, value8

        do
            local v456 = false

            if not v231.clip then
                spring12:Update(clampedValue)
                spring15:Update(clampedValue)
                value7 = spring12.value
                value8 = spring15.value

                if 1e-05 < value7.Magnitude then
                    v456 = true
                elseif 1e-05 < value8.Magnitude then
                    v456 = true
                end
            end

            if v456 then
                local v457

                if not (1e-06 < value8.Magnitude) then
                    v457 = CFrame.identity
                else
                    v457 = CFrame.fromAxisAngle(value8.Unit, value8.Magnitude)
                end

                lastFrame2 = CFrame.new(restFrame.Position + value7) * v457 * restFrame.Rotation
            end
        end
    end

    do
        local lastFrame = v231.lastFrame

        if lastFrame and 0 < clampedValue then
            do
                local function cap(a460, a461)
                    --[[
                      name: cap
                      line: 1794
                    ]]
                    if a461 < a460.Magnitude then
                        return a460.Unit * a461
                    end

                    return a460
                end
            end

            local rawVel = {}
            local v463 = (lastFrame2.Position - lastFrame.Position) / clampedValue
            rawVel.pos = if 25 < v463.Magnitude then v463.Unit * 25 else v463

            do
                local v464 = (lastFrame2.UpVector - lastFrame.UpVector) / clampedValue
                rawVel.tip = if 40 < v464.Magnitude then v464.Unit * 40 else v464
            end

            do
                local v465 = (lastFrame2.LookVector - lastFrame.LookVector) / clampedValue
                rawVel.edge = if 40 < v465.Magnitude then v465.Unit * 40 else v465
            end

            v231.rawVel = rawVel
        end
    end

    v231.lastFrame = lastFrame2
    v231.lastFrameT = now

    if shown.id == "bolas" then
        if (v231.clipName == "draw" or v231.clipName == "redraw") and v231.spinT0 ~= v231.clipT0 then
            v231.spinT0 = v231.clipT0
        end

        if v231.clipName ~= "throw" then
            v231.spinA = 12.566370614359172 * (1 - ((function(...) return (...) ^ 3 end)(((1 - math.clamp((now - v231.spinT0) / 0.7, 0, 1))))))
        else
            v231.spinA = (v231.spinA + (((clampedValue * 2) * math.pi) * 4)) % math.tau
        end

        lastFrame2 *= CFrame.Angles(0, v231.spinA, 0)
    end

    do
        local frame = CFrame.new(lastFrame2.Position + layerPos) * CFrame.fromEulerAnglesYXZ(layerRot.X, layerRot.Y, layerRot.Z) * lastFrame2.Rotation

        if const wall = a334.wall then
            local v468

            do
                local v469 = 0
                v468 = v469

                for _, corner in shown.corners do
                    v468 = math.max(v468, -frame:PointToWorldSpace(corner).Z)
                end
            end

            do
                local v472 = wall - 0.12

                if v472 < v468 then
                    v231.wallPush = math.min(v468 - v472, (math.max(0, -frame.Position.Z - 0.28)))
                    frame += Vector3.new(0, 0, v231.wallPush)
                end
            end
        end

        v231.frame = frame

        if v231.leftVanishAt and v231.leftVanishAt <= now then
            v231.leftOut = true
            v231.leftVanishAt = nil
            v231.leftOutAt = now
        end
    end

    if a334.offHandOut ~= true then
        if a334.offHandOut == false and v231.leftOut and (v231.leftSeenOut or 1 < now - v231.leftOutAt) then
            v231.leftOut = false
            v231.leftSeenOut = false
            v231.leftCatchT = now
        end
    else
        v231.leftSeenOut = true

        if not v231.leftOut and not v231.leftVanishAt then
            v231.leftOut = true
            v231.leftOutAt = now
        end
    end

    if shown.leftFist and v231.leftOut then
        v231.leftFrame = nil
    elseif shown.leftFist then
        do
            local leftLast2 = restFrame

            do
                local clip = v231.clip

                if clip and clip.left then
                    local v475 = clip.leftClip
                    if not v475 then
                        v475 = {keys = clip.left, contact = clip.contact, release = clip.release, eyeRoll = clip.eyeRoll}
                        clip.leftClip = v475
                    end

                    leftLast2 = BladeClips.Eval(v475, v231.leftFrom, now - v231.clipT0, v231.clipScale, restFrame, v231.leftFromVel)
                end
            end

            do
                local leftLast = v231.leftLast

                if leftLast and 0 < clampedValue then
                    do
                        local function cap(a478, a479)
                            --[[
                              name: cap
                              line: 1868
                            ]]
                            if a479 < a478.Magnitude then
                                return a478.Unit * a479
                            end

                            return a478
                        end
                    end

                    local leftVel = {}
                    local v481 = (leftLast2.Position - leftLast.Position) / clampedValue
                    leftVel.pos = if 25 < v481.Magnitude then v481.Unit * 25 else v481

                    do
                        local v482 = (leftLast2.UpVector - leftLast.UpVector) / clampedValue
                        leftVel.tip = if 40 < v482.Magnitude then v482.Unit * 40 else v482
                    end

                    do
                        local v483 = (leftLast2.LookVector - leftLast.LookVector) / clampedValue
                        leftVel.edge = if 40 < v483.Magnitude then v483.Unit * 40 else v483
                    end

                    v231.leftVel = leftVel
                end
            end

            v231.leftLast = leftLast2

            do
                local v484 = (now - v231.leftCatchT) / 0.3

                if 0 <= v484 and v484 < 1 then
                    local v485 = v484 - 1
                    local v486 = 1 - ((((2.70158 * v485) * v485) * v485) + 1 + ((1.70158 * v485) * v485))
                    leftLast2 = CFrame.new(leftLast2.Position + (Vector3.new(0.05999999865889549, -0.41999998688697815, 0.03999999910593033) * v486)) * CFrame.fromEulerAnglesYXZ(-0.8726646259971648 * v486, 0, 0.5235987755982988 * v486) * leftLast2.Rotation
                end
            end

            do
                local components, v488, v489, v490, v491, v492, v493, v494, v495, v496, v497, v498 = leftLast2:GetComponents()
                local cframe = CFrame.new(-components, v488, v489, v490, -v491, -v492, -v493, v494, v495, -v496, v497, v498)
                v231.leftFrame = CFrame.new(cframe.Position + layerPos + Vector3.new(0, 0, v231.wallPush)) * CFrame.fromEulerAnglesYXZ(layerRot.X, layerRot.Y, layerRot.Z) * cframe.Rotation
            end
        end
    else
        v231.leftFrame = nil
    end

    do
        local v500 = if v231.vanishAt then v231.vanishAt <= now and now < v231.hiddenUntil else now < v231.hiddenUntil
            and v231.action ~= "throw"
            and v231.action ~= "place"

        do
            local v501, v502, v503, v504 = false, false, false, false

            if v500 then
                return v427, v428, nil
            end

            if a334.charges then
                if not (a334.charges <= 0) then
                    v502 = true
                else
                    v231.spent = true

                    if v231.vanishAt then
                        if not (now < v231.vanishAt) then
                            v501 = true
                        end
                    else
                        v501 = true
                    end
                end
            else
                v502 = true
            end

            if v501 then
                return v427, v428, nil
            end

            if v502 and v231.spent then
                v231.spent = false

                if shown.drawFrom then
                    if shown.clips then
                        if shown.clips.redraw then
                            v504 = true
                        elseif shown.clips.draw then
                            v504 = true
                        else
                            v503 = true
                        end
                    else
                        v503 = true
                    end
                else
                    v503 = true
                end
            end

            if v503 then
                spring11.value = -1
                spring11.velocity = 0
                spring11.target = 0
            end

            if v504 then
                local pendingDraw

                if shown.clips.redraw then
                    pendingDraw = "redraw"
                else
                    pendingDraw = "draw"
                end

                v231.pendingDraw = pendingDraw
            end
        end

        return v427, v428, shown
    end
end

local v506 = nil
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Exclude
params.RespectCanCollide = true
local character = nil
local v509 = {}
local v510 = {}
local v511 = {}
local v512 = {}
local v513 = {}
local v514 = {}

local function drawBlade(a516, cframe: CFrame?, a518: number, a519)
    --[[
      name: drawBlade
      line: 1934
      upvalues:
        BladeSmear (copy, index: 1)
        v231 (copy, index: 2)
        v16 (copy, index: 3)
        BladeClips (copy, index: 4)
        v512 (copy, index: 5)
        v513 (copy, index: 6)
        v514 (copy, index: 7)
        v509 (copy, index: 8)
        v510 (copy, index: 9)
        v511 (copy, index: 10)
    ]]
    BladeSmear.Follow(cframe)
    local frame = v231.frame

    if v231.spark then
        v231.spark = false

        if frame then
            BladeSmear.Spark(a516, cframe, Vector3.new(frame.X, frame.Y, frame.Z * a518) + (frame.UpVector * (a519.bladeLen * 0.55)))
        end
    end

    local clip = v231.clip
    local v522 = if clip then clip.smear else nil

    if not clip or not v522 then
        BladeSmear.Hide()
        return
    end

    local clipScale = v231.clipScale
    local v524 = v231.now - v231.clipT0
    local v525 = v522[1] * clipScale
    local v526 = v522[2] * clipScale
    local v527 = v16.smearLen * clipScale
    local v528 = math.min(v524, v526)
    local v529 = math.max(v525, v524 - v527)

    if v528 - v529 < 0.004 then
        BladeSmear.Hide()
        return
    end

    local v530 = not (v526 < v524) and 1 or math.clamp(1 - ((v524 - v526) / v527), 0, 1)
    local segments = BladeSmear.SEGMENTS
    local v532 = v231.layerPos + Vector3.new(0, 0, v231.wallPush)
    local layerRot = v231.layerRot
    local v534 = CFrame.fromEulerAnglesYXZ(layerRot.X, layerRot.Y, layerRot.Z)
    local v535 = v16.smearAlong[a519.kind]

    for index = 0, segments do
        local v537 = BladeClips.Eval(clip, v231.clipFrom, v529 + (((v528 - v529) * index) / segments), clipScale, v231.restFrame, v231.clipFromVel)
        local v538 = v537.Position + v532
        v512[index + 1] = Vector3.new(v538.X, v538.Y, v538.Z * a518)

        if v535 then
            local v539 = index + 1
            v512[v539] += (v534 * v537.UpVector * (a519.bladeLen * v535.root))
            v513[index + 1] = v534 * v537.LookVector
        else
            v513[index + 1] = v534 * v537.UpVector
        end
    end

    local v540 = v16.smearItem[a519.id] or v16.smear[a519.kind] or v16.smear.Sword

    for v541, v542 in v540 do
        if BladeSmear.LAYERS < v541 then
            break
        end

        local v543 = a519.bladeLen * v542.at
        local v544 = a519.bladeLen * v542.width * (clip.smearWidth or 1)

        for index = 1, segments + 1 do
            v514[index] = v512[index] + (v513[index] * v543)
        end

        for index = 1, segments + 1 do
            local v547 = v514[math.min(segments + 1, index + 1)] - v514[math.max(1, index - 1)]
            local v548 = v513[index]
            local v549 = v547 - v548 * v547:Dot(v548)

            if v549.Magnitude < 1e-05 then
                v549 = v548:Cross(Vector3.new(0, 0, 1))
            end

            v509[index] = CFrame.fromMatrix(v514[index], v549.Unit, v548)
            local v550 = (index - 1) / segments
            v510[index] = v544 * (0.3 + (0.7 * v550))
            v511[index] = 1 - (((1 - v542.alpha) * (v550 ^ 1.4)) * v530)
        end

        BladeSmear.Draw(a516, cframe, v541, v509, v510, v511, v542.color)
    end
end

local v551 = {}
local v552 = nil

local function arrowFor(childName, a555: number)
    --[[
      name: arrowFor
      line: 2008
      upvalues:
        v551 (copy, index: 1)
        replicatedStorage (copy, index: 2)
        viewModels (ref,  index: 3)
    ]]
    local v556 = childName .. ":" .. tostring((a555 or 0.36))

    if const v557 = v551[v556] then
        return v557
    end

    local instance
    local assets = replicatedStorage:FindFirstChild("Assets")
    local vfx = assets and assets:FindFirstChild("VFX")
    local projectiles = vfx and vfx:FindFirstChild("Projectiles")

    if childName == "ViewArrow" and viewModels then
        instance = viewModels:FindFirstChild("Arrow")
    else
        instance = projectiles and (projectiles:FindFirstChild(childName) or projectiles:FindFirstChild("Arrow"))
    end

    if not instance or not instance:IsA("Model") then
        return nil
    end

    local instance2 = instance:Clone()

    for _, descendant in instance2:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = true
            descendant.CanCollide = false
            descendant.CanQuery = false
            descendant.CanTouch = false
            descendant.CastShadow = false

            if childName == "Bolt" then
                if not (0.5 < math.min(descendant.Color.R, descendant.Color.G, descendant.Color.B)) then
                    continue
                end

                descendant.Color = Color3.fromRGB(120, 124, 130)

                if not descendant:IsA("MeshPart") then
                    continue
                end

                descendant.TextureID = ""
            end
        elseif descendant:IsA("ParticleEmitter") then
            descendant.LockedToPart = true
        elseif descendant:IsA("Trail") or descendant:IsA("Beam") or descendant:IsA("Light") then
            descendant.Enabled = false
        elseif descendant:IsA("Script") or descendant:IsA("LocalScript") or descendant:IsA("Sound") then
            descendant:Destroy()
        end
    end

    local _, v566
    _, v566 = instance2:GetBoundingBox()
    instance2:ScaleTo((math.clamp((a555 or 0.36) / math.max(v566.X, v566.Y, v566.Z, 0.05), 0.005, 1)))
    instance2.Name = "TribesViewArrow_" .. childName
    v566 = instance2:GetBoundingBox()
    local v567 = {model = instance2, centre = instance2:GetPivot():ToObjectSpace(v566)}
    v551[v556] = v567

    return v567
end

local function drawBolt(parent, cframe: CFrame?, a571)
    --[[
      name: drawBolt
      line: 2060
      upvalues:
        v231 (copy, index: 1)
        arrowFor (copy, index: 2)
    ]]
    if a571.kind ~= "Crossbow" or not v231.boltIn or not v231.frame or not a571.muzzle then
        return nil
    end

    local v572 = arrowFor("Bolt", 0.347)
    if not v572 then
        return nil
    end

    local frame = v231.frame
    local lookVector = frame.LookVector
    local objectSpaceWorldPosition = cframe:PointToObjectSpace(a571.muzzle.WorldPosition)
    local clampedValue = math.clamp((v231.now - v231.boltT0) / 0.1, 0, 1)
    local v577 = objectSpaceWorldPosition - lookVector * (0.1735 + (0.24 * (1 - (clampedValue * clampedValue * (3 - (clampedValue * 2))))))
    v572.model:PivotTo(cframe * (CFrame.lookAt(v577, v577 + lookVector, frame.UpVector) * v572.centre:Inverse()))

    if v572.model.Parent ~= parent then
        v572.model.Parent = parent
    end

    return v572.model
end

local v578 = {thick = 0.0035, ring = 0.02, ringHz = 18, ringTime = 0.15, color = Color3.fromRGB(196, 180, 140)}
local v579 = {}

local function stringPart(key)
    --[[
      name: stringPart
      line: 2085
      upvalues:
        v579 (copy, index: 1)
        v578 (copy, index: 2)
    ]]
    local v582 = v579[key]
    if not v582 then
        v582 = Instance.new("Part")
        v582.Name = "TribesViewString"
        v582.Anchored = true
        v582.CanCollide = false
        v582.CanQuery = false
        v582.CanTouch = false
        v582.CastShadow = false
        v582.Material = Enum.Material.SmoothPlastic
        v582.Color = v578.color
        v582.Size = Vector3.new(v578.thick, v578.thick, 0.1)
        v579[key] = v582
    end

    return v582
end

local function hideStrings()
    --[[
      name: hideStrings
      line: 2102
      upvalues:
        v579 (copy, index: 1)
    ]]
    for _, v585 in v579 do
        v585.Parent = nil
    end
end

local function drawArrow(parent, cframe: CFrame?, a589: number, a590)
    --[[
      name: drawArrow
      line: 2108
      upvalues:
        v231 (copy, index: 1)
        arrowFor (copy, index: 2)
        viewModels (ref,  index: 3)
        drawBolt (copy, index: 4)
        v552 (ref,  index: 5)
        v579 (copy, index: 6)
        v578 (copy, index: 7)
    ]]
    local v591
    local bow = a590.bow
    local v593 = a590.kind == "Bow" and a590.cfg.stock ~= nil and v231.nocked and v231.frame ~= nil

    if v593 then
        local v594 = viewModels and viewModels:FindFirstChild("Arrow") and "ViewArrow" or v231.arrowKind
        v591 = arrowFor(v594, 0.36)
    else
        v591 = nil
    end

    local v595 = if v591 then v591.model else drawBolt(parent, cframe, a590)

    if v595 ~= v552 then
        if v552 then
            v552.Parent = nil
        end

        v552 = v595
    end

    local frame = v231.frame
    if not frame then
        for _, v598 in v579 do
            v598.Parent = nil
        end

        return
    end

    local v599 = CFrame.new(frame.X, frame.Y, frame.Z * a589) * frame.Rotation
    local clampedValue = math.clamp((v231.now - v231.drawT0) / v231.drawTime, 0, 1)
    local v601 = clampedValue * clampedValue * (3 - (clampedValue * 2))
    local v602 = nil

    if bow then
        if v231.draw then
            v602 = bow.nock + Vector3.new(0, 0, 0.12 * v601)
        else
            local v603 = v231.now - v231.drawHold + 0.16
            local x = if 0 <= v603 and v603 < v578.ringTime then v578.ring * math.sin(((v603 * v578.ringHz) * 2) * math.pi) * (1 - (v603 / v578.ringTime)) else 0
            v602 = bow.brace + Vector3.new(x, 0, x * 0.3)
        end

        local worldSpacePoint = v599:PointToWorldSpace(v602)

        for v606, v607 in {bow.top, bow.bottom} do
            local v608
            local worldSpacePoint2 = v599:PointToWorldSpace(v607)

            if const v610 = v579[v606] then
                v608 = v610
            else
                v608 = Instance.new("Part")
                v608.Name = "TribesViewString"
                v608.Anchored = true
                v608.CanCollide = false
                v608.CanQuery = false
                v608.CanTouch = false
                v608.CastShadow = false
                v608.Material = Enum.Material.SmoothPlastic
                v608.Color = v578.color
                v608.Size = Vector3.new(v578.thick, v578.thick, 0.1)
                v579[v606] = v608
            end

            local magnitude = (worldSpacePoint - worldSpacePoint2).Magnitude
            v608.Size = Vector3.new(v578.thick, v578.thick, (math.max(magnitude, 0.001)))
            v608.CFrame = cframe * CFrame.lookAt((worldSpacePoint2 + worldSpacePoint) * 0.5, worldSpacePoint)

            if v608.Parent ~= parent then
                v608.Parent = parent
            end
        end
    elseif a590.xbow then
        local v612
        local xbow = a590.xbow
        local clampedValue2 = math.clamp(v231.stringV, 0, 1)
        local v615 = v231.now - v231.stringT0
        local v616 = xbow.brace - xbow.nut
        local v617 = v616:Cross(xbow.right - xbow.left)

        if not (1e-06 < v617.Magnitude) then
            v612 = Vector3.new(0, 1, 0)
        else
            v612 = v617.Unit
        end

        local v618 = if 0 <= v615 and v615 < 0.15 then math.cos(((v615 * 18) * 2) * math.pi) * 0.012 * (1 - (v615 / 0.15)) else 0
        local worldSpacePoint = v599:PointToWorldSpace(xbow.nut + (v616 * clampedValue2) + (v612 * v618))
        local v620

        for v621, v622 in {xbow.left, xbow.right} do
            local v623
            local worldSpacePoint3 = v599:PointToWorldSpace(v622)
            v620 = v579[v621]

            if v620 then
                v623 = v620
            else
                v623 = Instance.new("Part")
                v623.Name = "TribesViewString"
                v623.Anchored = true
                v623.CanCollide = false
                v623.CanQuery = false
                v623.CanTouch = false
                v623.CastShadow = false
                v623.Material = Enum.Material.SmoothPlastic
                v623.Color = v578.color
                v623.Size = Vector3.new(v578.thick, v578.thick, 0.1)
                v579[v621] = v623
            end

            local magnitude = (worldSpacePoint - worldSpacePoint3).Magnitude
            local v626 = v578.thick * 1.5
            v623.Size = Vector3.new(v626, v626, (math.max(magnitude, 0.001)))
            v623.CFrame = cframe * CFrame.lookAt((worldSpacePoint3 + worldSpacePoint) * 0.5, worldSpacePoint)

            if v623.Parent ~= parent then
                v623.Parent = parent
            end
        end
    else
        for _, v628 in v579 do
            v628.Parent = nil
        end
    end

    if not v591 or not v595 then
        return
    end

    local v629, v630
    local clampedValue3 = math.clamp((v231.now - v231.nockT0) / 0.1, 0, 1)
    local v632 = 1 - clampedValue3 * clampedValue3 * (3 - (clampedValue3 * 2))

    if bow and v602 then
        v629 = v599:PointToWorldSpace(v602 + Vector3.new(0, -0.07 * v632, 0))
        v630 = (v599:PointToWorldSpace(bow.rest) - v629).Unit
    else
        local z = a590.brace - 0.005 + 0.12 * v601
        v629 = v599 * Vector3.new(-0.012, -0.07 * v632, z)
        v630 = frame.LookVector
    end

    v231.arrowTip = v629 + (v630 * 0.36)

    if not (v591.centre.Position.Z < 0) or not viewModels or not viewModels:FindFirstChild("Arrow") then
        local v634 = v629 + v630 * 0.18
        v595:PivotTo(cframe * (CFrame.lookAt(v634, v634 + v630, frame.UpVector) * v591.centre:Inverse()))
    else
        v595:PivotTo(cframe * CFrame.lookAt(v629, v629 + v630, frame.UpVector))
    end

    if v595.Parent ~= parent then
        v595.Parent = parent
    end
end

local v635 = {fire_bomb = true}

local function itemPoint(cframe: CFrame?, a638, a639: string)
    --[[
      name: itemPoint
      line: 2208
      upvalues:
        v231 (copy, index: 1)
    ]]
    local v640
    local v641
    local v642 = v231.frame or CFrame.identity

    if a639 ~= "tip" then
        v640 = a638.muzzle
    else
        v640 = a638.tipAtt or a638.muzzle
    end

    local v643 = if a638.gripAtt then a638.gripAtt.WorldPosition else a638.model:GetPivot().Position
    local v644 = if v640 then v640.WorldPosition else v643
    local objectSpacePoint = cframe:PointToObjectSpace(v644)

    if a638.cfg.act == "gun" or a639 == "barrel" then
        v641 = v642.LookVector
    else
        local objectSpacePoint2 = cframe:PointToObjectSpace(v643)
        v641 = if 0.001 < (objectSpacePoint - objectSpacePoint2).Magnitude then (objectSpacePoint - objectSpacePoint2).Unit else v642.LookVector
    end

    return CFrame.lookAt(objectSpacePoint, objectSpacePoint + v641)
end

local v647 = {Spear = true, Gauntlets = true, Hatchets = true}

local function drawStreak(a649: number, a650)
    --[[
      name: drawStreak
      line: 2229
      upvalues:
        v231 (copy, index: 1)
        v647 (copy, index: 2)
        ViewFx (copy, index: 3)
        BladeClips (copy, index: 4)
    ]]
    local clip = v231.clip
    local v652 = if clip then clip.smear else nil

    if v647[a650.kind] and clip and v652 then
        if a650.tipCanon then
            local clipScale = v231.clipScale
            local v654 = v231.now - v231.clipT0

            if v654 < v652[1] * clipScale or (v652[2] * clipScale) + 0.035 < v654 then
                ViewFx.Streak(nil, nil)
                return
            end

            local v655
            local v656
            local v657 = v231.layerPos + Vector3.new(0, 0, v231.wallPush)
            local layerRot = v231.layerRot
            local v659 = CFrame.fromEulerAnglesYXZ(layerRot.X, layerRot.Y, layerRot.Z)
            local leftClip = clip.leftClip
            local v661 = clip.smearLeft == true and a650.leftFist ~= nil and leftClip ~= nil

            local function tipAt(a663: number)
                --[[
                  name: tipAt
                  line: 2246
                  upvalues:
                    v661 (copy, index: 1)
                    BladeClips (copy, index: 2)
                    leftClip (copy, index: 3)
                    v231 (copy, index: 4)
                    clipScale (copy, index: 5)
                    v657 (copy, index: 6)
                    a650 (copy, index: 7)
                    a649 (copy, index: 8)
                    v659 (copy, index: 9)
                    clip (copy, index: 10)
                ]]
                if v661 then
                    local v664 = BladeClips.Eval(leftClip, v231.leftFrom, a663, clipScale, v231.restFrame, v231.leftFromVel)
                    local components, v666, v667, v668, v669, v670, v671, v672, v673, v674, v675, v676 = v664:GetComponents()
                    local cframe = CFrame.new(-components, v666, v667, v668, -v669, -v670, -v671, v672, v673, -v674, v675, v676)
                    local v678 = cframe.Position + v657
                    local tipCanon = a650.tipCanon

                    return Vector3.new(v678.X, v678.Y, v678.Z * a649) + (v659 * cframe.Rotation):VectorToWorldSpace((Vector3.new(-tipCanon.X, tipCanon.Y, tipCanon.Z)))
                end

                local v680 = BladeClips.Eval(clip, v231.clipFrom, a663, clipScale, v231.restFrame, v231.clipFromVel)
                local v681 = v680.Position + v657

                return Vector3.new(v681.X, v681.Y, v681.Z * a649) + (v659 * v680.Rotation):VectorToWorldSpace(a650.tipCanon)
            end

            local v682 = math.min(v654, v652[2] * clipScale)
            local v683 = math.max(v652[1] * clipScale, v654 - 0.035)
            local streak = ViewFx.Streak
            local v685 = tipAt(v683)
            local v686 = tipAt(v682)

            if v652[2] * clipScale < v654 then
                v655 = 1 - (v654 - (v652[2] * clipScale)) / 0.035
            else
                v655 = 1
            end

            if a650.kind ~= "Gauntlets" then
                v656 = if a650.kind == "Hatchets" then a650.cfg.len * 0.45 else nil
            else
                v656 = a650.cfg.len * 0.2
            end

            streak(v685, v686, v655, v656)

            return
        end
    end

    ViewFx.Streak(nil, nil)
end

local function viewEffects(a688, cframe: CFrame?, a690)
    --[[
      name: viewEffects
      line: 2263
      upvalues:
        ViewFx (copy, index: 1)
        v231 (copy, index: 2)
        itemPoint (copy, index: 3)
        v16 (copy, index: 4)
        v552 (ref,  index: 5)
        Sfx (copy, index: 6)
        v635 (copy, index: 7)
    ]]
    ViewFx.Follow(a688, cframe)
    local fxQueue = v231.fxQueue

    if 0 < #fxQueue then
        local _, _, _

        for _, text in fxQueue do
            if text == "muzzle" then
                local play = ViewFx.Play
                local cframe2 = itemPoint(cframe, a690, "barrel")
                play("muzzle", cframe2, {style = (a690.kind ~= "Blunderbuss"
                    and (a690.kind ~= "Pistol" and "musket" or "pistol"))
                    or "blunderbuss"})
            elseif text ~= "pan" then
                if text == "headglint" or text == "rimspark" then
                    local v699
                    local v700 = v231.frame or CFrame.identity
                    local v701 = if a690.gripAtt then cframe:PointToObjectSpace(a690.gripAtt.WorldPosition) else v700.Position
                    local upVector = v700.UpVector
                    local v703 = if text == "headglint" then a690.bladeLen * 0.85 else a690.cfg.len * 0.8
                    local v704 = v701 + upVector * v703
                    local v705 = v16.smearAlong[a690.kind]

                    if text == "headglint" and v705 then
                        v704 = v701 + (v700.UpVector * (a690.bladeLen * v705.root)) + v700.LookVector * (a690.bladeLen * 0.3)
                    end

                    local v706 = math.tan(math.rad(a688.FieldOfView) / 2)
                    local v707 = a688.ViewportSize.X / math.max(a688.ViewportSize.Y, 1)
                    v699 = v704

                    for _ = 1, 6 do
                        local v709 = -v699.Z

                        if 0.05 < v709
                            and math.abs(v699.X / ((v709 * v706) * v707)) < 0.9
                            and math.abs(v699.Y / (v709 * v706)) < 0.9
                        then
                            break
                        end

                        v699 = v701 + (v699 - v701) * 0.8
                    end

                    local v710 = v699.Unit * math.min(v699.Magnitude - 0.03, 0.5)
                    ViewFx.Play(((text == "headglint" and (v705 and "flare" or "glint")) or "block_spark"), CFrame.lookAt(v710, v710 + v700.UpVector))
                elseif text == "fullglint" then
                    local v711 = v231.frame or CFrame.identity
                    local v712 = if a690.gripAtt then cframe:PointToObjectSpace(a690.gripAtt.WorldPosition) else v711.Position
                    local lookVector = v711.LookVector
                    local v714 = if a690.cfg.stock == nil then a690.cfg.len * 0.5 else 0.288 - a690.brace
                    local v715 = v712 + lookVector * v714

                    if a690.cfg.stock == nil or not v231.arrowTip or not v552 or not v552.Parent then
                        ViewFx.Play("glint", CFrame.lookAt(v715, v715 + v711.LookVector))
                    else
                        v715 = v231.arrowTip
                        ViewFx.Play("glint", CFrame.lookAt(v715, v715 + v711.LookVector))
                    end
                elseif text ~= "bolt" then
                    if string.sub(text, 1, 4) == "sfx:" then
                        if not v231.sim then
                            local v716
                            local v717, v718 = string.match(text, "^sfx:([^@]+)@?(.*)$")
                            local play = Sfx.Play
                            local v720 = v717 or string.sub(text, 5)

                            if tonumber(v718) then
                                v716 = {pitch = tonumber(v718)}
                            else
                                v716 = nil
                            end

                            play(v720, nil, v716)
                        end
                    elseif text == "click" and a690.pan then
                        local objectSpaceWorldPosition = cframe:PointToObjectSpace(a690.pan.WorldPosition)
                        ViewFx.Play("click", CFrame.lookAt(objectSpaceWorldPosition, objectSpaceWorldPosition + Vector3.new(0, 1, 0)))
                    elseif text == "twang"
                        or text == "snap"
                        or text == "powder"
                        or text == "puff"
                        or text == "click"
                        or text == "ring"
                    then
                        ViewFx.Play(text, itemPoint(cframe, a690, "muzzle"))
                    elseif text == "sparkle" then
                        local play = ViewFx.Play
                        local v723 = a690.id ~= "healing_tonic" and "sparkle" or "gold"
                        play(v723, itemPoint(cframe, a690, "tip"))
                    elseif text == "crumbs" and a690.id == "healing_tonic" then
                        ViewFx.Play("crumbs", itemPoint(cframe, a690, "tip"))
                        v231.bite += 1

                        if v231.bite % 2 == 1 then
                            ViewFx.Play("gold", itemPoint(cframe, a690, "tip"))
                        end
                    elseif text == "knock" then
                        local position = itemPoint(cframe, a690, "tip").Position
                        ViewFx.Play("flare", CFrame.new(0, position.Y, position.Z))
                    elseif text ~= "beat" then
                        ViewFx.Play(text, itemPoint(cframe, a690, "tip"))
                    end
                else
                    ViewFx.Play("glint", itemPoint(cframe, a690, "muzzle"))
                end
            else
                local v725 = v231.frame or CFrame.identity
                local v726 = if a690.gripAtt then cframe:PointToObjectSpace(a690.gripAtt.WorldPosition) else v725.Position
                local v727 = if a690.pan then cframe:PointToObjectSpace(a690.pan.WorldPosition) else v726 + (v725.UpVector * 0.035) + v725.LookVector * 0.05
                ViewFx.Play("pan", CFrame.lookAt(v727, v727 + v725.UpVector))
            end
        end

        table.clear(fxQueue)
    end

    if a690.cfg.act == "gun" then
        ViewFx.Track("muzzle", itemPoint(cframe, a690, "barrel"))
    end

    local v728 = v635[a690.id] == true

    if v728 ~= v231.embers then
        v231.embers = v728
        ViewFx.Play("embers", itemPoint(cframe, a690, "tip"), {on = v728})
    end

    if v728 then
        ViewFx.Track("embers", itemPoint(cframe, a690, "tip"))
    end

    local fuse = a690.id ~= "smoke_bomb" and 0 or v231.wind and 2 or 1

    if fuse ~= v231.fuse then
        v231.fuse = fuse
        local play = ViewFx.Play
        local cframe3 = itemPoint(cframe, a690, "tip")
        play("fuse", cframe3, {on = 0 < fuse, rate = fuse * 18})
    end

    if 0 < fuse then
        ViewFx.Track("fuse", itemPoint(cframe, a690, "tip"))
    end
end

local function place(parent, cframe: CFrame?, a735, a736, a737, a738)
    --[[
      name: place
      line: 2366
      upvalues:
        v506 (ref,  index: 1)
        BladeSmear (copy, index: 2)
        v579 (copy, index: 3)
        v552 (ref,  index: 4)
        v231 (copy, index: 5)
        ViewFx (copy, index: 6)
        v16 (copy, index: 7)
        spring13 (copy, index: 8)
        spring14 (copy, index: 9)
        drawBlade (copy, index: 10)
        drawArrow (copy, index: 11)
        viewEffects (copy, index: 12)
        drawStreak (copy, index: 13)
    ]]
    local v739 = if a738 then a738.model else nil

    if v739 ~= v506 then
        if v506 then
            v506.Parent = nil
        end

        v506 = v739
    end

    if a738 and v739 then
        local v740
        local v741 = math.tan((v16.fovRef * 0.5) * 0.017453292519943295) / math.tan((math.clamp(a735, 20, 110) * 0.5) * 0.017453292519943295)
        v740 = if const frame = v231.frame then (cframe * CFrame.new(frame.X, frame.Y, frame.Z * v741)) * frame.Rotation * a738.norm else cframe * CFrame.new(a736.X, a736.Y, a736.Z * v741) * CFrame.fromEulerAnglesYXZ(a737.X, a737.Y, a737.Z) * a738.style
        v739:PivotTo(v740 * a738.gripInv * a738.pivotRel)

        if const leftFist = a738.leftFist then
            if const leftFrame = v231.leftFrame then
                local part = leftFist.part
                local v746 = cframe * CFrame.new(leftFrame.X, leftFrame.Y, leftFrame.Z * v741) * leftFrame.Rotation
                local components, v748, v749, v750, v751, v752, v753, v754, v755, v756, v757, v758 = a738.norm:GetComponents()
                part.CFrame = v746 * CFrame.new(-components, v748, v749, v750, -v751, -v752, -v753, v754, v755, -v756, v757, v758) * leftFist.rel
                leftFist.part.LocalTransparencyModifier = 0
            else
                leftFist.part.LocalTransparencyModifier = 1
            end
        end

        if const inlay = a738.inlay then
            local inlayLvl = v231.draw and (v231.drawFull and 3 or v231.drawHalf and 2 or 1) or 0

            if inlayLvl ~= v231.inlayLvl then
                v231.inlayFrom, v231.inlayLvl, v231.inlayT0 = inlay.part.Color, inlayLvl, v231.now
            end

            local v761 = {[0] = inlay.rest, Color3.fromRGB(60, 90, 92), Color3.fromRGB(95, 150, 152), Color3.fromRGB(140, 205, 206)}
            inlay.part.Color = v231.inlayFrom:Lerp(v761[inlayLvl], (math.clamp((v231.now - v231.inlayT0) / 0.05, 0, 1)))
        end

        if const strip = a738.strip then
            local stripV = v231.stripV
            strip.part.Size = Vector3.new(strip.size.X, strip.size.Y * stripV, strip.size.Z)
            strip.part.CFrame = a738.handle.CFrame * strip.rest * CFrame.new(0, (-strip.size.Y * (stripV - 1)) / 2, 0)
        end

        if a738.stone then
            local v764 = false

            if v231.looseAt ~= nil then
                v764 = false
                local now = v231.now

                if v231.looseAt <= now then
                    v764 = v231.now < v231.looseAt + 0.38
                end
            end

            a738.stone.LocalTransparencyModifier = v764 and 1 or 0
        end

        if const hammer = a738.hammer then
            local v767 = math.clamp(spring13.value, -0.2, 1.25) * hammer.fired * 0.017453292519943295
            local cFrame = a738.handle.CFrame
            hammer.part.CFrame = (cFrame * CFrame.new(hammer.pivot)) * CFrame.fromAxisAngle(hammer.axis, v767) * CFrame.new(-hammer.pivot) * hammer.rest
        end

        if const frizzen = a738.frizzen then
            local v770 = math.clamp(spring14.value, -0.1, 1.2) * frizzen.fired * 0.017453292519943295
            local cFrame = a738.handle.CFrame
            frizzen.part.CFrame = (cFrame * CFrame.new(frizzen.pivot)) * CFrame.fromAxisAngle(frizzen.axis, v770) * CFrame.new(-frizzen.pivot) * frizzen.rest
        end

        local boundingBox, v773, position
        local v775
        local v776
        local v777, v778, v779, v780, v781, v782 = false, false, false, false, false, false

        if const rod = a738.rod then
            local rodV = v231.rodV
            local cFrame = a738.handle.CFrame

            if not (rodV <= 1.5) then
                local v786 = (rodV - 2) * rod.len
                rod.part.CFrame = cFrame * CFrame.fromMatrix(rod.muzzle + (rod.fwd * (v786 - (rod.len * 0.5))), -rod.fwd, rod.up)
            else
                rod.part.CFrame = cFrame * CFrame.new(rod.fwd * (math.min(rodV, 1) * 1.3 * rod.len)) * rod.rest
            end
        end

        if v739.Parent ~= parent then
            v739.Parent = parent
        end

        if v16.smearItem[a738.id] then
            v777 = true
        elseif v16.smear[a738.kind] then
            v777 = true
        else
            BladeSmear.Hide()
        end

        if v777 then
            drawBlade(parent, cframe, v741, a738)
        end

        drawArrow(parent, cframe, v741, a738)
        viewEffects(parent, cframe, a738)
        drawStreak(v741, a738)

        if v231.leftVanishAt then
            if a738.leftFist then
                if v231.leftFrame then
                    v776 = a738.leftFist.part.Position
                else
                    v778 = true
                end
            else
                v778 = true
            end
        else
            v778 = true
        end

        if v778 then
            if v552 then
                if v552.Parent then
                    if a738.kind ~= "Bow" then
                        v780 = true
                    else
                        boundingBox, v773 = v552:GetBoundingBox()
                        position = boundingBox.Position

                        if v231.frame then
                            v775 = cframe:VectorToWorldSpace(v231.frame.LookVector)
                        else
                            v775 = boundingBox.LookVector
                        end

                        v779 = true
                    end
                else
                    v780 = true
                end
            else
                v780 = true
            end
        end

        if v779 then
            v776 = position + v775 * (v773.Z * 0.5)
        end

        if v780 then
            if a738.kind == "Sling" then
                v781 = true
            elseif a738.id ~= "bolas" then
                v782 = true
            else
                v781 = true
            end
        end

        if v781 then
            if a738.tipAtt then
                v776 = a738.tipAtt.WorldPosition
            else
                v782 = true
            end
        end

        if v782 then
            if a738.muzzle then
                v776 = a738.muzzle.WorldPosition
            else
                v776 = v739:GetBoundingBox().Position
            end
        end

        v231.release, v231.releaseT = v776, os.clock()

        return
    end

    BladeSmear.Hide()

    for _, v788 in v579 do
        v788.Parent = nil
    end

    if v552 then
        v552.Parent = nil
        v552 = nil
    end

    if v231.embers then
        v231.embers = false
        ViewFx.Play("embers", CFrame.identity, {on = false})
    end

    if 0 < v231.fuse then
        v231.fuse = 0
        ViewFx.Play("fuse", CFrame.identity, {on = false})
    end
end

local function hide()
    --[[
      name: hide
      line: 2489
      upvalues:
        v506 (ref,  index: 1)
        v579 (copy, index: 2)
        v552 (ref,  index: 3)
        BladeSmear (copy, index: 4)
        ViewFx (copy, index: 5)
        v231 (copy, index: 6)
    ]]
    if v506 then
        v506.Parent = nil
        v506 = nil
    end

    for _, v791 in v579 do
        v791.Parent = nil
    end

    if v552 then
        v552.Parent = nil
        v552 = nil
    end

    BladeSmear.Hide()
    ViewFx.Hide()
    v231.embers = false
    v231.fuse = 0
end

local frozen = false
local v793 = false
local userInputService = game:GetService("UserInputService")

local function touchPreferred()
    --[[
      name: touchPreferred
      line: 2511
      upvalues:
        userInputService (copy, index: 1)
    ]]
    local success, preferredInput = pcall(
        function()
            --[[
              line: 2512
              upvalues:
                userInputService (copy, index: 1)
            ]]
            return userInputService.PreferredInput
        end
    )
    return success and typeof(preferredInput) == "EnumItem" and preferredInput.Name == "Touch"
end

local function drawnRootY(a799)
    --[[
      name: drawnRootY
      line: 2518
      upvalues:
        Camera (copy, index: 1)
    ]]
    local success, result = pcall(
        function()
            --[[
              line: 2519
              upvalues:
                Camera (copy, index: 1)
            ]]
            if Camera.GetDrawnRoot then
                return (Camera.GetDrawnRoot())
            end

            return nil
        end
    )

    if success and typeof(result) == "CFrame" then
        return result.Position.Y
    end

    return a799.Position.Y
end

local function liveInput(dt: number)
    --[[
      name: liveInput
      line: 2528
      upvalues:
        workspace (copy, index: 1)
        localPlayer (copy, index: 2)
        Camera (copy, index: 3)
        Combat (copy, index: 4)
        character (ref,  index: 5)
        params (copy, index: 6)
        userInputService (copy, index: 7)
    ]]
    local camera = workspace.CurrentCamera
    local character2 = localPlayer.Character
    local humanoidRootPart = character2 and character2:FindFirstChild("HumanoidRootPart")
    local humanoid = character2 and character2:FindFirstChildOfClass("Humanoid")

    if not camera or not character2 or not humanoidRootPart or not humanoidRootPart:IsA("BasePart") or not humanoid then
        return nil, camera
    end

    local v808
    local weaponId
    local y
    local v811 = Camera.InFirstPerson and Camera.InFirstPerson() == true
    local tool = character2:FindFirstChildOfClass("Tool")
    local weaponId2 = tool and tool:GetAttribute("WeaponId")
    local v814 = nil

    if type(weaponId2) == "string" then
        local kind = tool and tool:GetAttribute("Kind")

        if type(kind) ~= "string" then
            v814 = Combat.Kind(weaponId2)
        else
            v814 = kind
        end
    end

    local v816 = nil

    if tool then
        local number = tonumber(tool:GetAttribute("MaxCharges")) or 0

        if not (0 < number) then
            v808 = v816
        else
            v808 = tonumber(tool:GetAttribute("Charges"))
        end
    else
        v808 = v816
    end

    local cFrame = camera.CFrame
    local v819 = nil

    if v811 then
        if character ~= character2 then
            character = character2
            local filterDescendantsInstances = {character2}

            for _, childName in {"FX", "Projectiles"} do
                if const child = workspace:FindFirstChild(childName) then
                    table.insert(filterDescendantsInstances, child)
                end
            end

            params.FilterDescendantsInstances = filterDescendantsInstances
        end

        v819 = if const raycastResult = workspace:Spherecast(cFrame.Position, 0.15, cFrame.LookVector * 1.8, params) then raycastResult.Distance else nil
    end

    local bobPhase = 0
    local bobAmount = 0

    if Camera.GetViewBob then
        bobPhase, bobAmount = Camera.GetViewBob()
    end

    local v827 = {dt = dt, now = os.clock()}
    local visible = v811 and 0 < humanoid.Health and localPlayer:GetAttribute("ReplayPlaying") ~= true
    v827.visible = visible

    if type(weaponId2) ~= "string" then
        weaponId = nil
    else
        weaponId = weaponId2
    end

    v827.id = weaponId
    v827.kind = v814
    v827.charges = v808
    v827.cam = cFrame
    v827.fov = camera.FieldOfView
    v827.grounded = humanoid.FloorMaterial ~= Enum.Material.Air

    local success, result = pcall(
        function()
            --[[
              line: 2519
              upvalues:
                Camera (copy, index: 1)
            ]]
            if Camera.GetDrawnRoot then
                return (Camera.GetDrawnRoot())
            end

            return nil
        end
    )

    if success and typeof(result) == "CFrame" then
        y = result.Position.Y
    else
        y = humanoidRootPart.Position.Y
    end

    v827.rootY = y
    local sliding = character2:GetAttribute("Sliding") == true
    v827.sliding = sliding
    local aiming = Camera.IsAiming and Camera.IsAiming() == true
    v827.aiming = aiming
    v827.offHandOut = if tool then tool:GetAttribute("Thrown") == true else nil
    v827.bobPhase = bobPhase
    v827.bobAmount = bobAmount
    v827.wall = v819
    local success2, preferredInput = pcall(
        function()
            --[[
              line: 2512
              upvalues:
                userInputService (copy, index: 1)
            ]]
            return userInputService.PreferredInput
        end
    )
    v827.touch = success2 and typeof(preferredInput) == "EnumItem" and preferredInput.Name == "Touch"
    v827.vel = humanoidRootPart.AssemblyLinearVelocity

    return v827, camera
end

local total = 0
local count = 0
local v837 = 0

local function renderFrame(dt: number)
    --[[
      name: renderFrame
      line: 2595
      upvalues:
        liveInput (copy, index: 1)
        v506 (ref,  index: 2)
        v579 (copy, index: 3)
        v552 (ref,  index: 4)
        BladeSmear (copy, index: 5)
        ViewFx (copy, index: 6)
        v231 (copy, index: 7)
        step (copy, index: 8)
        place (copy, index: 9)
    ]]
    local v840, parent = liveInput(dt)

    if v840 and parent then
        if v840.visible then
            local v842, v843, v844 = step(v840)
            place(parent, v840.cam, v840.fov, v842, v843, v844)

            return
        end

        if not v231.shown and not v506 then
            v231.lastYaw = nil
            v231.lastPitch = nil
            v231.lastRootY = nil

            return
        end

        v231.shown = nil
        v231.wantId = nil
        v231.dropAt = nil

        if v506 then
            v506.Parent = nil
            v506 = nil
        end

        for _, v846 in v579 do
            v846.Parent = nil
        end

        if v552 then
            v552.Parent = nil
            v552 = nil
        end

        BladeSmear.Hide()
        ViewFx.Hide()
        v231.embers = false
        v231.fuse = 0
        v231.lastYaw = nil
        v231.lastPitch = nil
        v231.lastRootY = nil

        return
    end

    if v506 then
        v506.Parent = nil
        v506 = nil
    end

    for _, v848 in v579 do
        v848.Parent = nil
    end

    if v552 then
        v552.Parent = nil
        v552 = nil
    end

    BladeSmear.Hide()
    ViewFx.Hide()
    v231.embers = false
    v231.fuse = 0
end

local function render(deltaTime: number)
    --[[
      name: render
      line: 2614
      upvalues:
        frozen (ref,  index: 1)
        v793 (ref,  index: 2)
        renderFrame (copy, index: 3)
        total (ref,  index: 4)
        count (ref,  index: 5)
        v837 (ref,  index: 6)
    ]]
    if frozen or v793 then
        return
    end

    local timestamp = os.clock()
    renderFrame(deltaTime)
    local elapsedTime = os.clock() - timestamp
    total += elapsedTime
    count += 1
    v837 = math.max(v837, elapsedTime)
end

function v14.SetExternal(external)
    --[[
      name: SetExternal
      line: 2636
      upvalues:
        v793 (ref,  index: 1)
        resetState (copy, index: 2)
        v231 (copy, index: 3)
        v506 (ref,  index: 4)
        v579 (copy, index: 5)
        v552 (ref,  index: 6)
        BladeSmear (copy, index: 7)
        ViewFx (copy, index: 8)
    ]]
    if v793 == external then
        return
    end

    v793 = external
    resetState()
    v231.shown = nil
    v231.wantId = nil

    if v506 then
        v506.Parent = nil
        v506 = nil
    end

    for _, v855 in v579 do
        v855.Parent = nil
    end

    if v552 then
        v552.Parent = nil
        v552 = nil
    end

    BladeSmear.Hide()
    ViewFx.Hide()
    v231.embers = false
    v231.fuse = 0
end

function v14.ReleasePoint()
    --[[
      name: ReleasePoint
      line: 2649
      upvalues:
        v231 (copy, index: 1)
    ]]
    if v231.release and os.clock() - v231.releaseT < 0.5 then
        return v231.release
    end

    return nil
end

function v14.ReleaseDelay()
    --[[
      name: ReleaseDelay
      line: 2655
      upvalues:
        v231 (copy, index: 1)
    ]]
    return if const v856 = v231.vanishAt or v231.looseAt or v231.leftVanishAt then (math.max(0, v856 - os.clock())) else 0
end

function v14.IsExternal()
    --[[
      name: IsExternal
      line: 2660
      upvalues:
        v793 (ref, index: 1)
    ]]
    return v793
end

function v14.ExternalFrame(a857)
    --[[
      name: ExternalFrame
      line: 2665
      upvalues:
        v793 (ref,  index: 1)
        workspace (copy, index: 2)
        v231 (copy, index: 3)
        v506 (ref,  index: 4)
        v579 (copy, index: 5)
        v552 (ref,  index: 6)
        BladeSmear (copy, index: 7)
        ViewFx (copy, index: 8)
        step (copy, index: 9)
        userInputService (copy, index: 10)
        place (copy, index: 11)
    ]]
    if not v793 then
        return
    end

    local camera = workspace.CurrentCamera
    if not camera then
        return
    end

    if a857.visible then
        local cFrame = camera.CFrame
        local v860 = {visible = true, dt = a857.dt, now = os.clock(), id = a857.id, kind = a857.kind, charges = a857.charges, cam = cFrame, fov = camera.FieldOfView, grounded = a857.grounded, rootY = a857.rootY, sliding = a857.sliding, aiming = a857.aiming, bobPhase = a857.bobPhase, bobAmount = a857.bobAmount, wall = a857.wall}
        local success, preferredInput = pcall(
            function()
                --[[
                  line: 2512
                  upvalues:
                    userInputService (copy, index: 1)
                ]]
                return userInputService.PreferredInput
            end
        )
        local touch = success and typeof(preferredInput) == "EnumItem" and preferredInput.Name == "Touch"
        v860.touch = touch
        local v864, v865, v866 = step(v860)
        place(camera, cFrame, camera.FieldOfView, v864, v865, v866)

        return
    end

    if v231.shown or v506 then
        v231.shown = nil
        v231.wantId = nil
        v231.dropAt = nil

        if v506 then
            v506.Parent = nil
            v506 = nil
        end

        for _, v868 in v579 do
            v868.Parent = nil
        end

        if v552 then
            v552.Parent = nil
            v552 = nil
        end

        BladeSmear.Hide()
        ViewFx.Hide()
        v231.embers = false
        v231.fuse = 0
    end

    v231.lastYaw = nil
    v231.lastPitch = nil
    v231.lastRootY = nil
end

function v14.ExternalEvent(a869, options)
    --[[
      name: ExternalEvent
      line: 2692
      upvalues:
        v793 (ref,  index: 1)
        v231 (copy, index: 2)
        onEvent (copy, index: 3)
    ]]
    if v793 then
        v231.now = os.clock()
        onEvent(a869, options)
    end
end

local function simulate(options)
    --[[
      name: simulate
      line: 2706
      upvalues:
        workspace (copy, index: 1)
        frozen (ref,  index: 2)
        v231 (copy, index: 3)
        resetState (copy, index: 4)
        ViewFx (copy, index: 5)
        onEvent (copy, index: 6)
        step (copy, index: 7)
        Combat (copy, index: 8)
        place (copy, index: 9)
    ]]
    local v873
    local camera = workspace.CurrentCamera
    if not camera then
        return {err = "no camera"}
    end

    frozen = true
    v231.sim = true
    resetState()
    ViewFx.Freeze(true)
    v231.shown = nil
    v231.wantId = nil
    local id = options.id
    local cFrame = camera.CFrame
    local number = tonumber(options.t) or 0
    local v878 = options.events or {}
    local v879 = {}
    local number2 = tonumber(options.speed) or 0
    local bobPhase = 0
    local total = 0
    local v883 = Vector3.new(0, 0, 0)
    local v884 = Vector3.new(0, 0, 0)
    local v885 = -0.8
    v873 = nil

    while v885 <= number + 0.004166666666666667 do
        local grounded = true
        local v887 = 0
        local v888 = options.air or {}

        for _, v890 in v888 do
            if v890[1] <= v885 then
                v887 = v890[2]
                grounded = v890[3]
            end
        end

        total += v887 * 0.016666666666666666

        if 0 <= v885 and grounded then
            bobPhase = (bobPhase + ((((number2 * 0.016666666666666666) / 7) * 2) * math.pi)) % 12.566370614359172
        end

        local bobAmount = if 0 <= v885 and grounded then math.clamp((number2 - 1) / 20, 0, 1.25) else 0
        v231.now = v885 + 1000
        local v892 = v885 + 0.016666666666666666

        if number + 0.004166666666666667 < v892 then
            table.clear(v231.fxQueue)
        end

        for v893, v894 in v878 do
            if not v879[v893] and v894[1] <= v885 then
                v879[v893] = true
                onEvent(v894[2], v894[3])
            end
        end

        local switch = options.switch
        local v896 = if switch and switch[1] <= v885 then switch[2] else id
        local slide = options.slide
        local sliding = slide ~= nil and slide[1] <= v885 and v885 < slide[2]
        local v899 = {dt = 0.016666666666666666, visible = true, charges = nil, now = v885 + 1000, id = v896, kind = Combat.Kind(v896), cam = cFrame}
        local v900 = tonumber(options.fov) or camera.FieldOfView
        v899.fov = v900
        v899.grounded = grounded
        v899.rootY = total
        v899.sliding = sliding
        v899.aiming = options.aiming == true and 0 <= v885
        v899.bobPhase = bobPhase
        v899.bobAmount = bobAmount
        v899.wall = options.wall
        local v883, v884, v901 = step(v899)
        v885 += 0.016666666666666666
        v873 = v901
    end

    local v902 = tonumber(options.fov) or camera.FieldOfView
    place(camera, cFrame, v902, v883, v884, v873)

    return {shown = v873 ~= nil, pos = {v883.X, v883.Y, v883.Z}, rot = {v884.X / 0.017453292519943295, v884.Y / 0.017453292519943295, v884.Z / 0.017453292519943295}}
end

local hasRun = false

function v14.Start()
    --[[
      name: Start
      line: 2776
      upvalues:
        hasRun (ref,  index: 1)
        ViewFx (copy, index: 2)
        replicatedStorage (copy, index: 3)
        weapons (ref,  index: 4)
        viewModels (ref,  index: 5)
        localPlayer (copy, index: 6)
        resetState (copy, index: 7)
        v231 (copy, index: 8)
        v506 (ref,  index: 9)
        v579 (copy, index: 10)
        v552 (ref,  index: 11)
        BladeSmear (copy, index: 12)
        v14 (copy, index: 13)
        frozen (ref,  index: 14)
        v793 (ref,  index: 15)
        onEvent (copy, index: 16)
        runService (copy, index: 17)
        render (copy, index: 18)
        simulate (copy, index: 19)
        v17 (copy, index: 20)
        v18 (copy, index: 21)
        v20 (copy, index: 22)
        BladeClips (copy, index: 23)
        v16 (copy, index: 24)
        spring12 (copy, index: 25)
        spring15 (copy, index: 26)
        ItemClips (copy, index: 27)
        count (ref,  index: 28)
        total (ref,  index: 29)
        v837 (ref,  index: 30)
    ]]
    if hasRun then
        return
    end

    hasRun = true
    ViewFx.Preload()
    local assets = replicatedStorage:WaitForChild("Assets", 30)
    weapons = assets and assets:WaitForChild("Weapons", 30)
    viewModels = assets and assets:FindFirstChild("ViewModels")

    task.spawn(
        function()
            --[[
              line: 2786
              upvalues:
                viewModels (ref, index: 1)
                weapons (ref, index: 2)
            ]]
            local contentIdList = {}

            for _, instance in {viewModels, weapons} do
                if instance then
                    table.insert(contentIdList, instance)
                end
            end

            pcall(
                function()
                    --[[
                      line: 2793
                      upvalues:
                        contentIdList (copy, index: 1)
                    ]]
                    game:GetService("ContentProvider"):PreloadAsync(contentIdList)
                end
            )
        end
    )

    localPlayer.CharacterAdded:Connect(
        function()
            --[[
              line: 2797
              upvalues:
                resetState (copy, index: 1)
                v231 (copy, index: 2)
                v506 (ref,  index: 3)
                v579 (copy, index: 4)
                v552 (ref,  index: 5)
                BladeSmear (copy, index: 6)
                ViewFx (copy, index: 7)
            ]]
            resetState()
            v231.shown = nil
            v231.wantId = nil

            if v506 then
                v506.Parent = nil
                v506 = nil
            end

            for _, v909 in v579 do
                v909.Parent = nil
            end

            if v552 then
                v552.Parent = nil
                v552 = nil
            end

            BladeSmear.Hide()
            ViewFx.Hide()
            v231.embers = false
            v231.fuse = 0
        end
    )

    task.spawn(
        function()
            --[[
              line: 2804
              upvalues:
                localPlayer (copy, index: 1)
                v14 (copy, index: 2)
                frozen (ref,  index: 3)
                v793 (ref,  index: 4)
                v231 (copy, index: 5)
                onEvent (copy, index: 6)
            ]]
            local combat = localPlayer:WaitForChild("PlayerScripts"):WaitForChild("Combat", 60)
            local controller = combat and combat:WaitForChild("Controller", 30)
            local effects = combat and combat:WaitForChild("Effects", 30)

            if effects and effects:IsA("ModuleScript") then
                local success, result = pcall(require, effects)

                if success and type(result) == "table" and type(result.SetViewHandOff) == "function" then
                    result.SetViewHandOff(v14.ReleasePoint, v14.ReleaseDelay)
                end
            end

            if controller and controller:IsA("ModuleScript") then
                local success, result = pcall(require, controller)

                if success and type(result) == "table" and type(result.OnViewEvent) == "function" then
                    result.OnViewEvent(
                        function(a917, options)
                            --[[
                              line: 2818
                              upvalues:
                                frozen (ref,  index: 1)
                                v793 (ref,  index: 2)
                                v231 (copy, index: 3)
                                onEvent (copy, index: 4)
                            ]]
                            if not frozen and not v793 then
                                v231.now = os.clock()
                                onEvent(a917, options)
                            end
                        end
                    )
                end
            end
        end
    )

    runService:BindToRenderStep("TribesViewModel", Enum.RenderPriority.Camera.Value + 2, render)

    if runService:IsStudio() then
        local viewModelDebug = Instance.new("BindableFunction")
        viewModelDebug.Name = "ViewModelDebug"

        viewModelDebug.OnInvoke = function(a920, options)
            --[[
              line: 2831
              upvalues:
                simulate (copy, index: 1)
                frozen (ref,  index: 2)
                v231 (copy, index: 3)
                ViewFx (copy, index: 4)
                resetState (copy, index: 5)
                v506 (ref,  index: 6)
                v579 (copy, index: 7)
                v552 (ref,  index: 8)
                BladeSmear (copy, index: 9)
                v17 (copy, index: 10)
                v18 (copy, index: 11)
                v20 (copy, index: 12)
                BladeClips (copy, index: 13)
                v16 (copy, index: 14)
                spring12 (copy, index: 15)
                spring15 (copy, index: 16)
                ItemClips (copy, index: 17)
                count (ref,  index: 18)
                total (ref,  index: 19)
                v837 (ref,  index: 20)
            ]]
            if a920 == "Sim" then
                return (simulate(options))
            end

            if a920 == "Live" then
                frozen = false
                v231.sim = false
                ViewFx.Freeze(false)
                resetState()
                v231.shown = nil
                v231.wantId = nil

                if v506 then
                    v506.Parent = nil
                    v506 = nil
                end

                for _, v923 in v579 do
                    v923.Parent = nil
                end

                if v552 then
                    v552.Parent = nil
                    v552 = nil
                end

                BladeSmear.Hide()
                ViewFx.Hide()
                v231.embers = false
                v231.fuse = 0

                return true
            end

            if a920 ~= "Tune" then
                if a920 == "Clips" then
                    local v924 = options or {}

                    for _, bladeClipName in {"SWORD", "DAGGER"} do
                        if type(v924[bladeClipName]) == "table" then
                            for v927, v928 in v924[bladeClipName] do
                                BladeClips[bladeClipName][v927] = v928
                            end
                        end
                    end

                    if type(v924.T) == "table" then
                        for v929, v930 in v924.T do
                            v16[v929] = v930
                        end

                        spring12.frequency, spring12.damping = v16.retHz, v16.retDamp
                        spring15.frequency, spring15.damping = v16.retHz, v16.retDamp
                    end

                    return true
                end

                if a920 ~= "ItemClip" then
                    local msPerFrame

                    if a920 ~= "State" then
                        return nil
                    end

                    local v932 = {shown = v231.shown and v231.shown.id, want = v231.wantId, frozen = frozen, action = v231.action, block = v231.block, charge = v231.charge, draw = v231.draw, wind = v231.wind, use = v231.use, reload = v231.reload}
                    v932.parent = v506 and v506.Parent and v506.Parent.Name

                    if not (0 < count) then
                        msPerFrame = 0
                    else
                        msPerFrame = total / count * 1000
                    end

                    v932.msPerFrame = msPerFrame
                    v932.maxFrameMs = v837 * 1000
                    v932.frames = count

                    return v932
                end

                local v933 = options or {}
                local set = ItemClips.SETS[v933.kind]

                if set and type(v933.draw) == "table" then
                    ItemClips.DRAW[v933.kind] = v933.draw

                    for _, v936 in v20 do
                        if v936.kind == v933.kind then
                            v936.drawFrom = v933.draw
                        end
                    end
                end

                if set and type(v933.name) == "string" and type(v933.clip) == "table" then
                    set[v933.name] = v933.clip
                    return true
                end

                return set ~= nil
            end

            local v937 = options or {}
            local v938 = v937.kind and v17[v937.kind]
            if v938 then
                if v937.rot then
                    v938.rot = Vector3.new(v937.rot[1], v937.rot[2], v937.rot[3])
                end

                if v937.pos then
                    v938.pos = Vector3.new(v937.pos[1], v937.pos[2], v937.pos[3])
                end

                if v937.len then
                    v938.len = v937.len
                end

                if v937.aimPos then
                    v938.aimPos = Vector3.new(v937.aimPos[1], v937.aimPos[2], v937.aimPos[3])
                end

                if v937.aimRot then
                    v938.aimRot = Vector3.new(v937.aimRot[1], v937.aimRot[2], v937.aimRot[3])
                end

                if type(v937.stock) == "table" then
                    local function v3(a940)
                        --[[
                          name: v3
                          line: 2866
                        ]]
                        if type(a940) == "table" and type(a940[1]) == "number" then
                            return (Vector3.new(a940[1], a940[2], a940[3]))
                        end

                        return a940
                    end

                    local v941 = v938.stock or {}

                    for v942, v943 in v937.stock do
                        local v944

                        if type(v943) ~= "table" or type(v943[1]) ~= "table" then
                            if type(v943) ~= "table" or type(v943[1]) ~= "number" then
                                v944 = v943
                            else
                                v944 = Vector3.new(v943[1], v943[2], v943[3])
                            end
                        else
                            v944 = {}
                            local v945 = v943[1]

                            if type(v945) == "table" and type(v945[1]) == "number" then
                                v945 = Vector3.new(v945[1], v945[2], v945[3])
                            end

                            local v946 = v943[2]

                            if type(v946) == "table" and type(v946[1]) == "number" then
                                v946 = Vector3.new(v946[1], v946[2], v946[3])
                            end

                            v944[1], v944[2] = v945, v946
                        end

                        v941[v942] = v944
                    end

                    v938.stock = v941
                end
            end

            if v937.id then
                local v947 = v18[v937.id]
                local id = v937.id
                local v949 = {rot = if v937.fix then Vector3.new(v937.fix[1], v937.fix[2], v937.fix[3]) else nil, pos = if v937.fixPos then Vector3.new(v937.fixPos[1], v937.fixPos[2], v937.fixPos[3]) else nil}
                v949.len = v937.fixLen

                if v937.barrel then
                    v947 = Vector3.new(v937.barrel[1], v937.barrel[2], v937.barrel[3])
                else
                    v947 = v947 and v947.barrel
                end

                v949.barrel = v947
                v18[id] = v949
            end

            for v950, v951 in v20 do
                if v937.id and v950 == v937.id or v938 and v951.kind == v937.kind then
                    v951.model:Destroy()
                    v20[v950] = nil
                end
            end

            return true
        end

        viewModelDebug.Parent = localPlayer
    end
end

return v14