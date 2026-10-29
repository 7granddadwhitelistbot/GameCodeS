local Players_1 = game:GetService("Players")
local ReplicatedStorage_upv_1 = game:GetService("ReplicatedStorage")
local RunService_upv_1 = game:GetService("RunService")
local Workspace_upv_1 = game:GetService("Workspace")
local Shared_1 = ReplicatedStorage_upv_1:WaitForChild("Shared")
local Camera_upv_1 = require(Shared_1:WaitForChild("Camera"))
local resetState = require(Shared_1:WaitForChild("Camera"):WaitForChild("Spring"))
local Combat_upv_1 = require(Shared_1:WaitForChild("Combat"))
local Sfx_upv_1 = require(Shared_1:WaitForChild("Sfx"))
local BladeClips_upv_1 = require(script.Parent:WaitForChild("BladeClips"))
local BladeSmear_upv_1 = require(script.Parent:WaitForChild("BladeSmear"))
local ItemClips_upv_1 = require(script.Parent:WaitForChild("ItemClips"))
local ViewFx_upv_1 = require(script.Parent:WaitForChild("ViewFx"))
local tbl_upv_1 = {}
local LocalPlayer_upv_1 = Players_1.LocalPlayer
local tbl_upv_2 = {}
tbl_upv_2.fovRef = 70
tbl_upv_2.hand = Vector3.new(0.3199999928474426, -0.28999999165534973, -0.6000000238418579)
tbl_upv_2.touchHand = Vector3.new(-0.05999999865889549, 0.05000000074505806, 0)
tbl_upv_2.poseHz = 7
tbl_upv_2.poseDamp = 0.82
tbl_upv_2.idleHz = 0.3
tbl_upv_2.idlePos = 0.005
tbl_upv_2.idleRot = 1
tbl_upv_2.bobX = 0.03
tbl_upv_2.bobY = 0.045
tbl_upv_2.bobRoll = 4
tbl_upv_2.bobPitch = 2.6
tbl_upv_2.airK = 0.0024
tbl_upv_2.airMax = 0.07
tbl_upv_2.airTiltK = 0.3
tbl_upv_2.airTiltMax = 9
tbl_upv_2.airHz = 2.6
tbl_upv_2.airDamp = 0.55
tbl_upv_2.landK = 0.05
tbl_upv_2.landMax = 1.8
tbl_upv_2.landHz = 5
tbl_upv_2.landDamp = 0.42
tbl_upv_2.landDist = 0.07
tbl_upv_2.swayK = 0.35
tbl_upv_2.swayMax = 9
tbl_upv_2.swayHz = 5
tbl_upv_2.swayDamp = 0.75
tbl_upv_2.swayShift = 0.15
tbl_upv_2.mvX = 0.0016
tbl_upv_2.mvZ = 8e-04
tbl_upv_2.mvRoll = 0.2
tbl_upv_2.mvYaw = 0.1
tbl_upv_2.mvPitch = 0.08
tbl_upv_2.mvMax = 1.4
tbl_upv_2.mvRun = 21
tbl_upv_2.mvHz = 4
tbl_upv_2.mvDamp = 0.55
tbl_upv_2.mvAimed = 0.35
tbl_upv_2.kickHz = 9
tbl_upv_2.kickDamp = 0.5
tbl_upv_2.equipHz = 4.2
tbl_upv_2.equipDamp = 0.52
tbl_upv_2.equipDrop = 0.42
tbl_upv_2.equipTilt = 55
tbl_upv_2.dropTime = 0.14
tbl_upv_2.slidePos = Vector3.new(-0.019999999552965164, -0.07999999821186066, 0.029999999329447746)
tbl_upv_2.slideRot = Vector3.new(8, 4, 16)
tbl_upv_2.slideShake = 0.004
tbl_upv_2.wallMin = 0.78
tbl_upv_2.wallMargin = 0.16
tbl_upv_2.wallPos = Vector3.new(0.019999999552965164, -0.14000000059604645, 0.05000000074505806)
tbl_upv_2.wallRotMax = 70
tbl_upv_2.hurtRot = 40
tbl_upv_2.hurtPos = 0.35
tbl_upv_2.retHz = 4.6
tbl_upv_2.retDamp = 0.74
tbl_upv_2.smearLen = 0.055
tbl_upv_2.smear = {
    Sword = {{at = 0.56, alpha = 0.6, width = 0.82, color = Color3.fromRGB(200, 212, 230)}, {at = 0.9, alpha = 0.28, width = 0.2, color = Color3.fromRGB(226, 233, 243)}},
    Dagger = {{at = 0.56, alpha = 0.58, width = 0.82, color = Color3.fromRGB(176, 222, 236)}, {at = 0.9, alpha = 0.26, width = 0.22, color = Color3.fromRGB(206, 238, 246)}},
    Axe = {{at = 0.62, alpha = 0.62, width = 0.6, color = Color3.fromRGB(196, 204, 218)}, {at = 0.88, alpha = 0.5, width = 0.26, color = Color3.fromRGB(214, 196, 150)}},
    Club = {{at = 0.66, alpha = 0.64, width = 0.56, color = Color3.fromRGB(196, 182, 160)}, {at = 0.88, alpha = 0.5, width = 0.26, color = Color3.fromRGB(200, 182, 150)}},
    Knives = {{at = 0.6, alpha = 0.6, width = 0.8, color = Color3.fromRGB(170, 180, 194)}},
    Javelin = {{at = 0.85, alpha = 0.55, width = 0.3, color = Color3.fromRGB(176, 172, 160)}},
    Bomb = {{at = 0.5, alpha = 0.6, width = 0.9, color = Color3.fromRGB(196, 166, 128)}},
    Scythe = {{at = 0.34, alpha = 0.62, width = 0.62, color = Color3.fromRGB(186, 194, 210)}, {at = 0.6, alpha = 0.45, width = 0.18, color = Color3.fromRGB(210, 216, 228)}},
    Katana = {{at = 0.58, alpha = 0.6, width = 0.8, color = Color3.fromRGB(178, 204, 230)}, {at = 0.9, alpha = 0.28, width = 0.2, color = Color3.fromRGB(204, 224, 242)}}
}
tbl_upv_2.smearAlong = {Scythe = {root = 0.97}}
tbl_upv_2.smearItem = {bolas = {{at = 0.85, alpha = 0.6, width = 0.25, color = Color3.fromRGB(150, 116, 80)}}, chakram = {{at = 0.7, alpha = 0.5, width = 0.5, color = Color3.fromRGB(170, 176, 186)}}}
local tbl_upv_3 = {}
tbl_upv_3.Sword = {act = "slash", len = 0.62, rot = Vector3.new(-26, 6, -4), pos = Vector3.new(0.029999999329447746, 0, 0), blockFrame = {tip = Vector3.new(-0.8199999928474426, 0.3799999952316284, -0.41999998688697815), edge = Vector3.new(0.10000000149011612, 0.30000001192092896, -1), pos = Vector3.new(0.30000001192092896, -0.27000001072883606, -0.550000011920929)}}
tbl_upv_3.Shield = {act = "stab", len = 0.355, rot = Vector3.new(0, 18, 4), pos = Vector3.new(-0.019999999552965164, -0.05999999865889549, 0.019999999552965164), block = {Vector3.new(-0.30000001192092896, 0.052000001072883606, 0.23999999463558197), Vector3.new(2, -16, -11)}}
tbl_upv_3.Dagger = {len = 0.33, rot = Vector3.new(-18, 8, 18), act = "stab", pos = Vector3.new(0.019999999552965164, 0.019999999552965164, 0.019999999552965164)}
tbl_upv_3.Axe = {act = "chop", len = 0.55, rot = Vector3.new(-26, 14, 14), pos = Vector3.new(0, 0, 0), charge = {Vector3.new(0.05999999865889549, 0.14000000059604645, 0.019999999552965164), Vector3.new(42, -6, -30)}}
tbl_upv_3.Club = {act = "smash", len = 0.3, rot = Vector3.new(-26, 14, 24), pos = Vector3.new(0.019999999552965164, -0.019999999552965164, 0), charge = {Vector3.new(0.019999999552965164, 0.03999999910593033, 0.019999999552965164), Vector3.new(36, 0, 12)}}
tbl_upv_3.Gauntlets = {len = 0.24, rot = Vector3.new(62, 14, 24), act = "stab", pos = Vector3.new(0.009999999776482582, -0.05000000074505806, 0.019999999552965164)}
tbl_upv_3.Katana = {len = 0.68, rot = Vector3.new(-26, 6, 4), act = "slash", pos = Vector3.new(0.029999999329447746, 0, 0)}
tbl_upv_3.Hatchets = {len = 0.34, rot = Vector3.new(-24, 12, 16), act = "chop", pos = Vector3.new(0.019999999552965164, -0.019999999552965164, 0.019999999552965164)}
tbl_upv_3.Scythe = {act = "chop", len = 0.95, rot = Vector3.new(-18, 93, -24), chargeIn = 0.15, pos = Vector3.new(0.03999999910593033, -0.05999999865889549, 0.03999999910593033), charge = {Vector3.new(0.09000000357627869, 0.019999999552965164, 0.05000000074505806), Vector3.new(0, -12, -37)}}
tbl_upv_3.Spear = {act = "thrust", len = 0.9, rot = Vector3.new(-72, 4, -4), pos = Vector3.new(0.019999999552965164, -0.03999999910593033, 0.019999999552965164), charge = {Vector3.new(0.019999999552965164, 0, 0.20000000298023224), Vector3.new(-6, 0, 0)}}
tbl_upv_3.Bow = {
    act = "bow",
    aimPos = Vector3.new(-0.1599999964237213, 0.05000000074505806, 0.029999999329447746),
    rot = Vector3.new(0, 55, 18),
    len = 0.54,
    aimRot = Vector3.new(0, 6, -6),
    pos = Vector3.new(0, -0.019999999552965164, 0),
    draw = {Vector3.new(-0.12999999523162842, 0.05999999865889549, 0.05000000074505806), Vector3.new(0, 10, -24)},
    drawFrame = {tip = Vector3.new(0.4699999988079071, 0.8799999952316284, 0.03999999910593033), edge = Vector3.new(-0.04500000178813934, 0.04500000178813934, -1), pos = Vector3.new(0.1599999964237213, -0.1599999964237213, -0.5199999809265137)},
    stock = {kick = 1.5, aimPos = Vector3.new(-0.18000000715255737, 0.10000000149011612, 0.03999999910593033), drawFrame = false, len = 0.68, rot = Vector3.new(-6, 6, 0), aimRot = Vector3.new(2, 0, -4), pos = Vector3.new(0, 0, 0.019999999552965164), draw = {Vector3.new(-0.14000000059604645, 0.05999999865889549, 0.11999999731779099), Vector3.new(5, -4, -10)}}
}
tbl_upv_3.Crossbow = {kick = 1, aimPos = Vector3.new(-0.25999999046325684, 0.03999999910593033, 0.03999999910593033), act = "gun", len = 0.48, rot = Vector3.new(8, 8, -6), aimRot = Vector3.new(-8, -8, 4), pos = Vector3.new(-0.009999999776482582, 0, 0)}
tbl_upv_3.Musket = {kick = 1.3, aimPos = Vector3.new(-0.25999999046325684, 0.07000000029802322, 0.03999999910593033), act = "gun", len = 0.82, rot = Vector3.new(2, 6, 0), aimRot = Vector3.new(0, -6, 0), pos = Vector3.new(-0.009999999776482582, 0, 0.019999999552965164)}
tbl_upv_3.Pistol = {kick = 1, aimPos = Vector3.new(-0.2800000011920929, 0.019999999552965164, 0.03999999910593033), act = "gun", len = 0.6, rot = Vector3.new(2, 6, 0), aimRot = Vector3.new(0, -6, 0), pos = Vector3.new(-0.029999999329447746, 0.029999999329447746, 0)}
tbl_upv_3.Blunderbuss = {kick = 1.4, aimPos = Vector3.new(-0.25999999046325684, 0.07000000029802322, 0.03999999910593033), act = "gun", len = 0.6, rot = Vector3.new(2, 6, 0), aimRot = Vector3.new(0, -6, 0), pos = Vector3.new(-0.009999999776482582, 0, 0.019999999552965164)}
tbl_upv_3.Knives = {aimPos = Vector3.new(-0.11999999731779099, 0.03999999910593033, 0.03999999910593033), act = "throw", len = 0.3, rot = Vector3.new(-40, 10, -10), aimRot = Vector3.new(0, 0, 0), pos = Vector3.new(0.019999999552965164, 0, 0), windup = {Vector3.new(0.05000000074505806, 0.10000000149011612, 0.1599999964237213), Vector3.new(70, 0, 16)}}
tbl_upv_3.Javelin = {act = "throw", len = 0.74, rot = Vector3.new(-80, 6, 0), pos = Vector3.new(0.019999999552965164, 0.019999999552965164, 0.03999999910593033), windup = {Vector3.new(0.10000000149011612, 0.2199999988079071, 0.10000000149011612), Vector3.new(-5, 14, 10)}}
tbl_upv_3.Sling = {aimPos = Vector3.new(-0.11999999731779099, 0.03999999910593033, 0.03999999910593033), act = "throw", len = 0.66, rot = Vector3.new(0, 14, 38), aimRot = Vector3.new(0, 0, 0), pos = Vector3.new(-0.03999999910593033, 0.2800000011920929, 0.019999999552965164), windup = {Vector3.new(0.05000000074505806, 0.10000000149011612, 0.1599999964237213), Vector3.new(40, 0, 16)}}
tbl_upv_3.Bomb = {act = "throw", len = 0.28, rot = Vector3.new(-10, 20, 0), pos = Vector3.new(0.019999999552965164, 0.019999999552965164, 0), windup = {Vector3.new(0.11999999731779099, 0.2800000011920929, 0.05000000074505806), Vector3.new(35, -10, 20)}}
tbl_upv_3.Herbs = {act = "eat", len = 0.25, rot = Vector3.new(-10, 25, 0), pos = Vector3.new(0.019999999552965164, 0.019999999552965164, 0), use = {Vector3.new(-0.2199999988079071, 0.08500000089406967, 0.17000000178813934), Vector3.new(-28, 30, 10)}}
tbl_upv_3.Trap = {len = 0.38, rot = Vector3.new(58, 24, 8), act = "trap", pos = Vector3.new(-0.019999999552965164, 0, 0)}
tbl_upv_3.Horn = {act = "eat", len = 0.4, rot = Vector3.new(-10, 25, 0), pos = Vector3.new(0.019999999552965164, 0.019999999552965164, 0), use = {Vector3.new(-0.2199999988079071, 0, 0.20000000298023224), Vector3.new(-35, -15, -30)}}
local tbl_upv_4 = {}
tbl_upv_4.crossbow = {barrel = Vector3.new(0, 0, 1)}
tbl_upv_4.beehive = {len = 0.2, pos = Vector3.new(0.029999999329447746, -0.009999999776482582, 0), windup = {Vector3.new(0.2199999988079071, 0.30000001192092896, 0.05000000074505806), Vector3.new(35, -10, 24)}}
tbl_upv_4.flintlock = {pan = Vector3.new(0.5325999855995178, 0.38659998774528503, 0.1979999989271164), barrel = Vector3.new(0.9272000193595886, -0.37459999322891235, 0)}
tbl_upv_4.musket = {pan = Vector3.new(0.3840000033378601, 0.38199999928474426, 0.1899999976158142)}
tbl_upv_4.blunderbuss = {muzzle = Vector3.new(0, 0.25699999928474426, 1.774999976158142), barrel = Vector3.new(0, 0, 1), pan = Vector3.new(-0.11999999731779099, 0.47999998927116394, 0.1120000034570694)}
tbl_upv_4.bolas = {len = 0.37, rot = Vector3.new(30, 0, 0), pos = Vector3.new(-0.029999999329447746, 0.23999999463558197, 0)}
tbl_upv_4.javelins = {len = 1.17, pos = Vector3.new(0, 0, 0.05000000074505806)}
tbl_upv_4.harpoon = {len = 0.8}
tbl_upv_4.healing_tonic = {pos = Vector3.new(0.029999999329447746, -0.05999999865889549, 0.029999999329447746), use = {Vector3.new(-0.2199999988079071, 0.08500000089406967, 0.20999999344348907), Vector3.new(-28, 30, 10)}}
tbl_upv_4.bandage = {use = {Vector3.new(-0.2199999988079071, 0.18000000715255737, 0.18000000715255737), Vector3.new(-35, 20, 25)}}
tbl_upv_4.war_horn = {use = {Vector3.new(-0.30000001192092896, 0, 0.23000000417232513), Vector3.new(-35, -15, -18)}}
tbl_upv_4.chakram = {rot = Vector3.new(20, 35, 18), pos = Vector3.new(-0.07999999821186066, -0.029999999329447746, 0.019999999552965164)}
tbl_upv_4.palisade = {len = 0.36, rot = Vector3.new(-58, 0, -10), pos = Vector3.new(0, 0.05999999865889549, 0)}
tbl_upv_4.smoke_bomb = {windup = {Vector3.new(0.1599999964237213, 0.2800000011920929, 0.05000000074505806), Vector3.new(35, -10, 20)}}
tbl_upv_4.healing_flask = {windup = {Vector3.new(0.11999999731779099, 0.2800000011920929, 0.05000000074505806), Vector3.new(12, -10, 20)}}
local tbl_upv_5 = {}
tbl_upv_5.stab = {dur = 0.2, keys = {{0, Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)}, {0.25, Vector3.new(0.009999999776482582, 0.009999999776482582, 0.05000000074505806), Vector3.new(8, 0, 0)}, {0.5, Vector3.new(-0.05000000074505806, 0.019999999552965164, -0.18000000715255737), Vector3.new(-40, 0, -6)}, {1, Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)}}}
tbl_upv_5.chop = {dur = 0.4, keys = {{0, Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)}, {0.24, Vector3.new(0.019999999552965164, 0.10000000149011612, 0.05999999865889549), Vector3.new(44, 0, 10)}, {0.52, Vector3.new(-0.05000000074505806, -0.12999999523162842, -0.09000000357627869), Vector3.new(-64, 6, -10)}, {1, Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)}}}
tbl_upv_5.smash = {dur = 0.46, keys = {{0, Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)}, {0.28, Vector3.new(0.019999999552965164, 0.11999999731779099, 0.07000000029802322), Vector3.new(52, 0, 6)}, {0.55, Vector3.new(-0.05999999865889549, -0.1599999964237213, -0.07999999821186066), Vector3.new(-74, 4, -6)}, {1, Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)}}}
tbl_upv_5.heavy = {dur = 0.5, keys = {{0, Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)}, {0.3, Vector3.new(-0.05999999865889549, -0.20000000298023224, -0.11999999731779099), Vector3.new(-90, 6, -8)}, {0.55, Vector3.new(-0.05000000074505806, -0.17000000178813934, -0.10000000149011612), Vector3.new(-80, 6, -8)}, {1, Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)}}}
tbl_upv_5.thrust = {dur = 0.34, keys = {{0, Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)}, {0.25, Vector3.new(0.009999999776482582, 0.009999999776482582, 0.10000000149011612), Vector3.new(4, 0, 0)}, {0.48, Vector3.new(-0.05999999865889549, 0.029999999329447746, -0.30000001192092896), Vector3.new(-4, 0, 0)}, {1, Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)}}}
tbl_upv_5.lunge = {dur = 0.6, keys = {{0, Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)}, {0.15, Vector3.new(-0.07999999821186066, 0.03999999910593033, -0.4000000059604645), Vector3.new(-4, 0, 0)}, {0.62, Vector3.new(-0.07999999821186066, 0.03999999910593033, -0.3799999952316284), Vector3.new(-4, 0, 0)}, {1, Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)}}}
tbl_upv_5.throw = {dur = 0.34, keys = {{0, Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)}, {0.4, Vector3.new(-0.05999999865889549, 0.019999999552965164, -0.3400000035762787), Vector3.new(-60, 0, -8)}, {1, Vector3.new(-0.05999999865889549, -0.10000000149011612, -0.30000001192092896), Vector3.new(-70, 0, -8)}}}
tbl_upv_5.place = {dur = 0.36, keys = {{0, Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)}, {0.5, Vector3.new(-0.03999999910593033, -0.2199999988079071, -0.1599999964237213), Vector3.new(-40, 0, 0)}, {1, Vector3.new(-0.03999999910593033, -0.30000001192092896, -0.20000000298023224), Vector3.new(-50, 0, 0)}}}
local tbl_upv_6 = {}
local u1 = nil
local u2 = nil
local function cfgFor(a1)
    --[[
      name: cfgFor
      line: 412
      upvalues:
        tbl_upv_3 (copy, index: 1)
    ]]
    return tbl_upv_3[a1]
end
local function withStock(a1)
    --[[
      name: withStock
      line: 506
    ]]
    local stock_1 = a1.stock
    if not stock_1 then
        return a1
    end
    local v1 = table.clone(a1)
    for key_1, value_1 in stock_1 do
        v1[key_1] = value_1
    end
    v1.stock = nil
    return v1
end
local function rodOf(a1, a2, a3)
    --[[
      name: rodOf
      line: 539
    ]]
    local v2 = a1:FindFirstChild("Ramrod", true)
    if v2 and v2:IsA("BasePart") and a3 then
        v2.Size = Vector3.new(v2.Size.X, v2.Size.Y * 1.4, v2.Size.Z * 1.4)
        local tbl_7 = {}
        tbl_7.part = v2
        tbl_7.rest = a2.CFrame:ToObjectSpace(v2.CFrame)
        tbl_7.len = v2.Size.X
        tbl_7.fwd = a2.CFrame:VectorToObjectSpace(v2.CFrame.XVector).Unit
        tbl_7.up = a2.CFrame:VectorToObjectSpace(v2.CFrame.YVector).Unit
        tbl_7.muzzle = a2.CFrame:PointToObjectSpace(a3.WorldPosition)
        return tbl_7
    end
    return nil
end
local function mirrorX(a1)
    --[[
      name: mirrorX
      line: 578
    ]]
    local v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14 = a1:GetComponents()
    return CFrame.new(-v3, v4, v5, v6, -v7, -v8, -v9, v10, v11, -v12, v13, v14)
end
local function hammerOf(a1, a2, a3, a4, a5)
    --[[
      name: hammerOf
      line: 522
    ]]
    local v15 = a1:FindFirstChild(a3 or "Hammer", true)
    local v16 = a2:FindFirstChild(a4 or "HammerPivot")
    if v15 and v15:IsA("BasePart") and v16 and v16:IsA("Attachment") then
        local tbl_8 = {}
        tbl_8.part = v15
        tbl_8.rest = a2.CFrame:ToObjectSpace(v15.CFrame)
        tbl_8.pivot = a2.CFrame:PointToObjectSpace(v16.WorldPosition)
        tbl_8.axis = a2.CFrame:VectorToObjectSpace(v16.WorldAxis).Unit
        tbl_8.fired = tonumber(v15:GetAttribute(a5 or "Fired")) or 35
        return tbl_8
    end
    return nil
end
local function canonical(a1, a2, a3, a4, a5, a6, a7)
    --[[
      name: canonical
      line: 429
    ]]
    if a1 == "Gauntlets" then
        return CFrame.identity, nil
    end
    local function inGrip_1(a8)
        --[[
          name: inGrip
          line: 433
          upvalues:
            a4 (copy, index: 1)
            a3 (copy, index: 2)
        ]]
        return a4:PointToObjectSpace(a3.CFrame:PointToObjectSpace(a8))
    end
    local function axisInGrip_1(a9)
        --[[
          name: axisInGrip
          line: 436
          upvalues:
            a4 (copy, index: 1)
        ]]
        return a4:VectorToObjectSpace(a9)
    end
    local v17 = a3:FindFirstChild("Muzzle", true) or (a3:FindFirstChild("Tip", true))
    local v18 = nil
    local v19 = nil
    local v20 = nil
    if a2 ~= "gun" then
        if a2 ~= "gun" then
            local v21, v22 = nil, nil
            if a1 == "Bow" then
                v21 = {{a5.X, Vector3.new(1, 0, 0)}, {a5.Y, Vector3.new(0, 1, 0)}, {a5.Z, Vector3.new(0, 0, 1)}}
                table.sort(
                    v21,
                    function(a10, a11)
                        --[[
                          line: 456
                        ]]
                        return a11[1] < a10[1]
                    end
                )
                local v23 = v21[1][2]
                v22 = (a4.Position - a6.Position):Dot(v23)
                if v21[1][1] * 0.12 < math.abs(v22) then
                    v20 = "stock"
                    local v24
                    if v22 > 0 then
                        v24 = -v23
                    else
                        v24 = v23
                    end
                    v19 = a4:VectorToObjectSpace(v24)
                    v18 = a4:VectorToObjectSpace(((v23 ~= Vector3.new(0, 1, 0)) and Vector3.new(0, 1, 0)) or (v21[2][2]))
                else
                    v18 = a4:VectorToObjectSpace(v23)
                    v19 = a4:VectorToObjectSpace(v21[2][2])
                    if v18.Y < -0.01 then
                        v18 = -v18
                    end
                    if v19.Z > 0.01 then
                        v19 = -v19
                    end
                end
            elseif a1 ~= "Sling" then
                local v25 = nil
                if a1 ~= "Trap" then
                    v25 = a3:FindFirstChild("Tip", true)
                    if v25 then
                        local v26 = v25:IsA("Attachment")
                        local v27 = nil
                        if v26 then
                            v27 = a4:PointToObjectSpace(a3.CFrame:PointToObjectSpace(v25.WorldPosition))
                            if v27.Magnitude > 0.1 and v27.Unit.Y > 0.2 then
                                v18, v19 = v27.Unit, Vector3.new(0, 0, -1)
                            end
                        end
                    end
                end
            end
        elseif v17 then
            local v28 = nil
            if v17:IsA("Attachment") then
                v28 = a4:PointToObjectSpace(a3.CFrame:PointToObjectSpace(v17.WorldPosition))
                if v28.Magnitude > 0.05 then
                    v19 = v28.Unit
                    v18 = a4:VectorToObjectSpace(Vector3.new(0, 1, 0))
                end
            else
                local v21, v22 = nil, nil
                if a1 == "Bow" then
                    v21 = {{a5.X, Vector3.new(1, 0, 0)}, {a5.Y, Vector3.new(0, 1, 0)}, {a5.Z, Vector3.new(0, 0, 1)}}
                    table.sort(
                        v21,
                        function(a10, a11)
                            --[[
                              line: 456
                            ]]
                            return a11[1] < a10[1]
                        end
                    )
                    local v23 = v21[1][2]
                    v22 = (a4.Position - a6.Position):Dot(v23)
                    if v21[1][1] * 0.12 < math.abs(v22) then
                        v20 = "stock"
                        local v24
                        if v22 > 0 then
                            v24 = -v23
                        else
                            v24 = v23
                        end
                        v19 = a4:VectorToObjectSpace(v24)
                        v18 = a4:VectorToObjectSpace(((v23 ~= Vector3.new(0, 1, 0)) and Vector3.new(0, 1, 0)) or (v21[2][2]))
                    else
                        v18 = a4:VectorToObjectSpace(v23)
                        v19 = a4:VectorToObjectSpace(v21[2][2])
                        if v18.Y < -0.01 then
                            v18 = -v18
                        end
                        if v19.Z > 0.01 then
                            v19 = -v19
                        end
                    end
                elseif a1 ~= "Sling" then
                    local v25 = nil
                    if a1 ~= "Trap" then
                        v25 = a3:FindFirstChild("Tip", true)
                        if v25 then
                            local v26 = v25:IsA("Attachment")
                            local v27 = nil
                            if v26 then
                                v27 = a4:PointToObjectSpace(a3.CFrame:PointToObjectSpace(v25.WorldPosition))
                                if v27.Magnitude > 0.1 and v27.Unit.Y > 0.2 then
                                    v18, v19 = v27.Unit, Vector3.new(0, 0, -1)
                                end
                            end
                        end
                    end
                end
            end
        else
            local v21, v22 = nil, nil
            if a1 == "Bow" then
                v21 = {{a5.X, Vector3.new(1, 0, 0)}, {a5.Y, Vector3.new(0, 1, 0)}, {a5.Z, Vector3.new(0, 0, 1)}}
                table.sort(
                    v21,
                    function(a10, a11)
                        --[[
                          line: 456
                        ]]
                        return a11[1] < a10[1]
                    end
                )
                local v23 = v21[1][2]
                v22 = (a4.Position - a6.Position):Dot(v23)
                if v21[1][1] * 0.12 < math.abs(v22) then
                    v20 = "stock"
                    local v24
                    if v22 > 0 then
                        v24 = -v23
                    else
                        v24 = v23
                    end
                    v19 = a4:VectorToObjectSpace(v24)
                    v18 = a4:VectorToObjectSpace(((v23 ~= Vector3.new(0, 1, 0)) and Vector3.new(0, 1, 0)) or (v21[2][2]))
                else
                    v18 = a4:VectorToObjectSpace(v23)
                    v19 = a4:VectorToObjectSpace(v21[2][2])
                    if v18.Y < -0.01 then
                        v18 = -v18
                    end
                    if v19.Z > 0.01 then
                        v19 = -v19
                    end
                end
            elseif a1 ~= "Sling" then
                local v25 = nil
                if a1 ~= "Trap" then
                    v25 = a3:FindFirstChild("Tip", true)
                    if v25 then
                        local v26 = v25:IsA("Attachment")
                        local v27 = nil
                        if v26 then
                            v27 = a4:PointToObjectSpace(a3.CFrame:PointToObjectSpace(v25.WorldPosition))
                            if v27.Magnitude > 0.1 and v27.Unit.Y > 0.2 then
                                v18, v19 = v27.Unit, Vector3.new(0, 0, -1)
                            end
                        end
                    end
                end
            end
        end
    elseif a7 then
        if a7.Magnitude > 0.05 then
            v19 = a4:VectorToObjectSpace(a7.Unit)
            v18 = a4:VectorToObjectSpace(Vector3.new(0, 1, 0))
        elseif a2 ~= "gun" then
            local v21, v22 = nil, nil
            if a1 == "Bow" then
                v21 = {{a5.X, Vector3.new(1, 0, 0)}, {a5.Y, Vector3.new(0, 1, 0)}, {a5.Z, Vector3.new(0, 0, 1)}}
                table.sort(
                    v21,
                    function(a10, a11)
                        --[[
                          line: 456
                        ]]
                        return a11[1] < a10[1]
                    end
                )
                local v23 = v21[1][2]
                v22 = (a4.Position - a6.Position):Dot(v23)
                if v21[1][1] * 0.12 < math.abs(v22) then
                    v20 = "stock"
                    local v24
                    if v22 > 0 then
                        v24 = -v23
                    else
                        v24 = v23
                    end
                    v19 = a4:VectorToObjectSpace(v24)
                    v18 = a4:VectorToObjectSpace(((v23 ~= Vector3.new(0, 1, 0)) and Vector3.new(0, 1, 0)) or (v21[2][2]))
                else
                    v18 = a4:VectorToObjectSpace(v23)
                    v19 = a4:VectorToObjectSpace(v21[2][2])
                    if v18.Y < -0.01 then
                        v18 = -v18
                    end
                    if v19.Z > 0.01 then
                        v19 = -v19
                    end
                end
            elseif a1 ~= "Sling" then
                local v25 = nil
                if a1 ~= "Trap" then
                    v25 = a3:FindFirstChild("Tip", true)
                    if v25 then
                        local v26 = v25:IsA("Attachment")
                        local v27 = nil
                        if v26 then
                            v27 = a4:PointToObjectSpace(a3.CFrame:PointToObjectSpace(v25.WorldPosition))
                            if v27.Magnitude > 0.1 and v27.Unit.Y > 0.2 then
                                v18, v19 = v27.Unit, Vector3.new(0, 0, -1)
                            end
                        end
                    end
                end
            end
        elseif v17 then
            local v28 = nil
            if v17:IsA("Attachment") then
                v28 = a4:PointToObjectSpace(a3.CFrame:PointToObjectSpace(v17.WorldPosition))
                if v28.Magnitude > 0.05 then
                    v19 = v28.Unit
                    v18 = a4:VectorToObjectSpace(Vector3.new(0, 1, 0))
                end
            else
                local v21, v22 = nil, nil
                if a1 == "Bow" then
                    v21 = {{a5.X, Vector3.new(1, 0, 0)}, {a5.Y, Vector3.new(0, 1, 0)}, {a5.Z, Vector3.new(0, 0, 1)}}
                    table.sort(
                        v21,
                        function(a10, a11)
                            --[[
                              line: 456
                            ]]
                            return a11[1] < a10[1]
                        end
                    )
                    local v23 = v21[1][2]
                    v22 = (a4.Position - a6.Position):Dot(v23)
                    if v21[1][1] * 0.12 < math.abs(v22) then
                        v20 = "stock"
                        local v24
                        if v22 > 0 then
                            v24 = -v23
                        else
                            v24 = v23
                        end
                        v19 = a4:VectorToObjectSpace(v24)
                        v18 = a4:VectorToObjectSpace(((v23 ~= Vector3.new(0, 1, 0)) and Vector3.new(0, 1, 0)) or (v21[2][2]))
                    else
                        v18 = a4:VectorToObjectSpace(v23)
                        v19 = a4:VectorToObjectSpace(v21[2][2])
                        if v18.Y < -0.01 then
                            v18 = -v18
                        end
                        if v19.Z > 0.01 then
                            v19 = -v19
                        end
                    end
                elseif a1 ~= "Sling" then
                    local v25 = nil
                    if a1 ~= "Trap" then
                        v25 = a3:FindFirstChild("Tip", true)
                        if v25 then
                            local v26 = v25:IsA("Attachment")
                            local v27 = nil
                            if v26 then
                                v27 = a4:PointToObjectSpace(a3.CFrame:PointToObjectSpace(v25.WorldPosition))
                                if v27.Magnitude > 0.1 and v27.Unit.Y > 0.2 then
                                    v18, v19 = v27.Unit, Vector3.new(0, 0, -1)
                                end
                            end
                        end
                    end
                end
            end
        else
            local v21, v22 = nil, nil
            if a1 == "Bow" then
                v21 = {{a5.X, Vector3.new(1, 0, 0)}, {a5.Y, Vector3.new(0, 1, 0)}, {a5.Z, Vector3.new(0, 0, 1)}}
                table.sort(
                    v21,
                    function(a10, a11)
                        --[[
                          line: 456
                        ]]
                        return a11[1] < a10[1]
                    end
                )
                local v23 = v21[1][2]
                v22 = (a4.Position - a6.Position):Dot(v23)
                if v21[1][1] * 0.12 < math.abs(v22) then
                    v20 = "stock"
                    local v24
                    if v22 > 0 then
                        v24 = -v23
                    else
                        v24 = v23
                    end
                    v19 = a4:VectorToObjectSpace(v24)
                    v18 = a4:VectorToObjectSpace(((v23 ~= Vector3.new(0, 1, 0)) and Vector3.new(0, 1, 0)) or (v21[2][2]))
                else
                    v18 = a4:VectorToObjectSpace(v23)
                    v19 = a4:VectorToObjectSpace(v21[2][2])
                    if v18.Y < -0.01 then
                        v18 = -v18
                    end
                    if v19.Z > 0.01 then
                        v19 = -v19
                    end
                end
            elseif a1 ~= "Sling" then
                local v25 = nil
                if a1 ~= "Trap" then
                    v25 = a3:FindFirstChild("Tip", true)
                    if v25 then
                        local v26 = v25:IsA("Attachment")
                        local v27 = nil
                        if v26 then
                            v27 = a4:PointToObjectSpace(a3.CFrame:PointToObjectSpace(v25.WorldPosition))
                            if v27.Magnitude > 0.1 and v27.Unit.Y > 0.2 then
                                v18, v19 = v27.Unit, Vector3.new(0, 0, -1)
                            end
                        end
                    end
                end
            end
        end
    elseif a2 ~= "gun" then
        local v21, v22 = nil, nil
        if a1 == "Bow" then
            v21 = {{a5.X, Vector3.new(1, 0, 0)}, {a5.Y, Vector3.new(0, 1, 0)}, {a5.Z, Vector3.new(0, 0, 1)}}
            table.sort(
                v21,
                function(a10, a11)
                    --[[
                      line: 456
                    ]]
                    return a11[1] < a10[1]
                end
            )
            local v23 = v21[1][2]
            v22 = (a4.Position - a6.Position):Dot(v23)
            if v21[1][1] * 0.12 < math.abs(v22) then
                v20 = "stock"
                local v24
                if v22 > 0 then
                    v24 = -v23
                else
                    v24 = v23
                end
                v19 = a4:VectorToObjectSpace(v24)
                v18 = a4:VectorToObjectSpace(((v23 ~= Vector3.new(0, 1, 0)) and Vector3.new(0, 1, 0)) or (v21[2][2]))
            else
                v18 = a4:VectorToObjectSpace(v23)
                v19 = a4:VectorToObjectSpace(v21[2][2])
                if v18.Y < -0.01 then
                    v18 = -v18
                end
                if v19.Z > 0.01 then
                    v19 = -v19
                end
            end
        elseif a1 ~= "Sling" then
            local v25 = nil
            if a1 ~= "Trap" then
                v25 = a3:FindFirstChild("Tip", true)
                if v25 then
                    local v26 = v25:IsA("Attachment")
                    local v27 = nil
                    if v26 then
                        v27 = a4:PointToObjectSpace(a3.CFrame:PointToObjectSpace(v25.WorldPosition))
                        if v27.Magnitude > 0.1 and v27.Unit.Y > 0.2 then
                            v18, v19 = v27.Unit, Vector3.new(0, 0, -1)
                        end
                    end
                end
            end
        end
    elseif v17 then
        local v28 = nil
        if v17:IsA("Attachment") then
            v28 = a4:PointToObjectSpace(a3.CFrame:PointToObjectSpace(v17.WorldPosition))
            if v28.Magnitude > 0.05 then
                v19 = v28.Unit
                v18 = a4:VectorToObjectSpace(Vector3.new(0, 1, 0))
            end
        else
            local v21, v22 = nil, nil
            if a1 == "Bow" then
                v21 = {{a5.X, Vector3.new(1, 0, 0)}, {a5.Y, Vector3.new(0, 1, 0)}, {a5.Z, Vector3.new(0, 0, 1)}}
                table.sort(
                    v21,
                    function(a10, a11)
                        --[[
                          line: 456
                        ]]
                        return a11[1] < a10[1]
                    end
                )
                local v23 = v21[1][2]
                v22 = (a4.Position - a6.Position):Dot(v23)
                if v21[1][1] * 0.12 < math.abs(v22) then
                    v20 = "stock"
                    local v24
                    if v22 > 0 then
                        v24 = -v23
                    else
                        v24 = v23
                    end
                    v19 = a4:VectorToObjectSpace(v24)
                    v18 = a4:VectorToObjectSpace(((v23 ~= Vector3.new(0, 1, 0)) and Vector3.new(0, 1, 0)) or (v21[2][2]))
                else
                    v18 = a4:VectorToObjectSpace(v23)
                    v19 = a4:VectorToObjectSpace(v21[2][2])
                    if v18.Y < -0.01 then
                        v18 = -v18
                    end
                    if v19.Z > 0.01 then
                        v19 = -v19
                    end
                end
            elseif a1 ~= "Sling" then
                local v25 = nil
                if a1 ~= "Trap" then
                    v25 = a3:FindFirstChild("Tip", true)
                    if v25 then
                        local v26 = v25:IsA("Attachment")
                        local v27 = nil
                        if v26 then
                            v27 = a4:PointToObjectSpace(a3.CFrame:PointToObjectSpace(v25.WorldPosition))
                            if v27.Magnitude > 0.1 and v27.Unit.Y > 0.2 then
                                v18, v19 = v27.Unit, Vector3.new(0, 0, -1)
                            end
                        end
                    end
                end
            end
        end
    else
        local v21, v22 = nil, nil
        if a1 == "Bow" then
            v21 = {{a5.X, Vector3.new(1, 0, 0)}, {a5.Y, Vector3.new(0, 1, 0)}, {a5.Z, Vector3.new(0, 0, 1)}}
            table.sort(
                v21,
                function(a10, a11)
                    --[[
                      line: 456
                    ]]
                    return a11[1] < a10[1]
                end
            )
            local v23 = v21[1][2]
            v22 = (a4.Position - a6.Position):Dot(v23)
            if v21[1][1] * 0.12 < math.abs(v22) then
                v20 = "stock"
                local v24
                if v22 > 0 then
                    v24 = -v23
                else
                    v24 = v23
                end
                v19 = a4:VectorToObjectSpace(v24)
                v18 = a4:VectorToObjectSpace(((v23 ~= Vector3.new(0, 1, 0)) and Vector3.new(0, 1, 0)) or (v21[2][2]))
            else
                v18 = a4:VectorToObjectSpace(v23)
                v19 = a4:VectorToObjectSpace(v21[2][2])
                if v18.Y < -0.01 then
                    v18 = -v18
                end
                if v19.Z > 0.01 then
                    v19 = -v19
                end
            end
        elseif a1 ~= "Sling" then
            local v25 = nil
            if a1 ~= "Trap" then
                v25 = a3:FindFirstChild("Tip", true)
                if v25 then
                    local v26 = v25:IsA("Attachment")
                    local v27 = nil
                    if v26 then
                        v27 = a4:PointToObjectSpace(a3.CFrame:PointToObjectSpace(v25.WorldPosition))
                        if v27.Magnitude > 0.1 and v27.Unit.Y > 0.2 then
                            v18, v19 = v27.Unit, Vector3.new(0, 0, -1)
                        end
                    end
                end
            end
        end
    end
    if v18 and v19 then
        v17 = v18.Unit
        v18 = v19 - v17 * v19:Dot(v17)
        if v18.Magnitude < 0.05 then
            return CFrame.identity, v20
        end
        v18 = v18.Unit
        if a2 ~= "gun" and v20 ~= "stock" then
            return CFrame.fromMatrix(Vector3.new(0, 0, 0), v18:Cross(v17), v17, -v18):Inverse(), v20
        end
        local Unit_1 = v19.Unit
        v17 = v17 - Unit_1 * v17:Dot(Unit_1)
        if v17.Magnitude < 0.05 then
            return CFrame.identity, v20
        end
        v17, v18 = v17.Unit, Unit_1
        return CFrame.fromMatrix(Vector3.new(0, 0, 0), v18:Cross(v17), v17, -v18):Inverse(), v20
    end
    return CFrame.identity, v20
end
local function prepare(a1, a2)
    --[[
      name: prepare
      line: 583
      upvalues:
        tbl_upv_6 (copy, index: 1)
        tbl_upv_3 (copy, index: 2)
        u1 (ref,  index: 3)
        u2 (ref,  index: 4)
        tbl_upv_4 (copy, index: 5)
        canonical (copy, index: 6)
        tbl_upv_2 (copy, index: 7)
        BladeClips_upv_1 (copy, index: 8)
        ItemClips_upv_1 (copy, index: 9)
        hammerOf (copy, index: 10)
        rodOf (copy, index: 11)
    ]]
    local v29 = tbl_upv_6[a1]
    if v29 then
        return v29
    end
    local u3 = tbl_upv_3[a2]
    local v30 = u3 and ((u2 and (u2:FindFirstChild(a1))) or (u1 and (u1:FindFirstChild(a1))))
    if not u3 or not v30 or not v30:IsA("Model") then
        return nil
    end
    local v31 = v30:Clone()
    for _, value_2 in v31:GetDescendants() do
        if value_2:IsA("BasePart") then
            value_2.Anchored = true
            value_2.CanCollide = false
            value_2.CanQuery = false
            value_2.CanTouch = false
            value_2.CastShadow = false
            value_2.Massless = true
            continue
        end
        if value_2:IsA("ParticleEmitter") or value_2:IsA("Trail") or value_2:IsA("Beam") or value_2:IsA("Light") then
            value_2.Enabled = false
            continue
        end
        if value_2:IsA("Script") or value_2:IsA("LocalScript") or value_2:IsA("Sound") then
            value_2:Destroy()
        end
    end
    local PrimaryPart_upv_1 = v31.PrimaryPart
    if not (PrimaryPart_upv_1) then
        local _ = v31:FindFirstChild("Handle")
    end
    if PrimaryPart_upv_1 and PrimaryPart_upv_1:IsA("BasePart") then
        v31.PrimaryPart = PrimaryPart_upv_1
        local v32 = tbl_upv_4[a1]
        local u4 = PrimaryPart_upv_1:FindFirstChild("RightGripAttachment", true)
        local function gripRelNow_1()
            --[[
              name: gripRelNow
              line: 617
              upvalues:
                u4 (copy, index: 1)
                PrimaryPart_upv_1 (copy, index: 2)
            ]]
            if u4 and u4:IsA("Attachment") then
                return (PrimaryPart_upv_1.CFrame:ToObjectSpace(u4.WorldCFrame))
            end
            return (CFrame.new())
        end
        local v33 = v31:FindFirstChild("Strip", true)
        local v34
        if v33 then
            v34 = v33.Parent
        else
            v34 = nil
        end
        if v33 then
            v33.Parent = nil
        end
        local u5 = nil
        for _, value_3 in v31:GetChildren() do
            local v35 = value_3:IsA("BasePart")
            if not (v35) then
                continue
            end
            if value_3:GetAttribute("OffHand") == true then
                u5 = value_3
            end
        end
        if u5 then
            u5.Parent = nil
        end
        local v36, v37
        v36, v37 = v31:GetBoundingBox()
        if v33 then
            v33.Parent = v34
        end
        if u5 then
            u5.Parent = v31
        end
        local act_1 = u3.act
        local v38
        if (u4) and (u4:IsA("Attachment")) then
            v38 = PrimaryPart_upv_1.CFrame:ToObjectSpace(u4.WorldCFrame)
        else
            v38 = CFrame.new()
        end
        local tbl_9 = PrimaryPart_upv_1.CFrame:ToObjectSpace(v36)
        local u6, v39 = canonical(a2, act_1, PrimaryPart_upv_1, v38, v37, tbl_9, v32 and (v32.barrel))
        if v39 == "stock" then
            local v40 = u3
            v36 = v40.stock
            if v36 then
                local v41 = table.clone(v40)
                for key_2, value_4 in v36 do
                    v41[key_2] = value_4
                end
                v41.stock = nil
                u3 = v41
            else
                u3 = v40
            end
        end
        if v32 and (v32.pos or v32.use or v32.windup) then
            local v42 = table.clone(u3)
            v42.pos = v42.pos + (v32.pos or Vector3.new(0, 0, 0))
            v42.use = v32.use or (v42.use)
            v42.windup = v32.windup or (v42.windup)
            u3 = v42
        end
        local v43 = math.max(v37.X, v37.Y, v37.Z, 0.05)
        if (v32) and (v32.len) then
            tbl_9 = v32.len
        else
            tbl_9 = u3.len
        end
        v31:ScaleTo((math.clamp(tbl_9 / v43, 0.005, 1)))
        v37 = nil
        local v44 = nil
        if u5 then
            v44 = u5:FindFirstChild("OffHandGrip")
            local tbl_10 = {rel = 0}
            tbl_10.part = u5
            local v45
            if (v44) and (v44:IsA("Attachment")) then
                v45 = v44.CFrame:Inverse()
            else
                v45 = CFrame.identity
            end
            tbl_10.rel = v45
            u5.Parent = nil
        end
        if (u4) and (u4:IsA("Attachment")) then
            u5 = PrimaryPart_upv_1.CFrame:ToObjectSpace(u4.WorldCFrame)
        else
            u5 = CFrame.new()
        end
        if (v32) and (v32.rot) then
            gripRelNow_1 = v32.rot
        else
            gripRelNow_1 = Vector3.new(0, 0, 0)
        end
        local u7 = CFrame.fromEulerAnglesYXZ(u3.rot.X * 0.017453292519943295, u3.rot.Y * 0.017453292519943295, u3.rot.Z * 0.017453292519943295) * CFrame.fromEulerAnglesYXZ(gripRelNow_1.X * 0.017453292519943295, gripRelNow_1.Y * 0.017453292519943295, gripRelNow_1.Z * 0.017453292519943295)
        gripRelNow_1 = u7 * u6
        local v46 = PrimaryPart_upv_1:FindFirstChild("Tip", true)
        local v47 = PrimaryPart_upv_1:FindFirstChild("RightGripAttachment", true)
        local v48
        if v46 and v46:IsA("Attachment") and v47 and v47:IsA("Attachment") then
            v48 = (v46.WorldPosition - v47.WorldPosition).Magnitude
        else
            v48 = u3.len * 0.8
        end
        local tbl_9, v49 = v31:GetBoundingBox()
        local v50 = gripRelNow_1 * u5:Inverse() * PrimaryPart_upv_1.CFrame:ToObjectSpace(tbl_9)
        local v51 = 0
        for _, value_5 in {-0.5, 0.5} do
            for v75, value_6 in {-0.5, 0.5} do
                for v76, value_7 in {-0.5, 0.5} do
                    v51 = math.max(v51, -v50:PointToWorldSpace(Vector3.new(value_5 * v49.X, value_6 * v49.Y, value_7 * v49.Z)).Z)
                end
            end
        end
        local v52 = u6 * u5:Inverse() * PrimaryPart_upv_1.CFrame:ToObjectSpace(tbl_9)
        tbl_9 = {}
        for _, value_8 in {-0.5, 0.5} do
            for v77, value_9 in {-0.5, 0.5} do
                for v78, value_10 in {-0.5, 0.5} do
                    table.insert(tbl_9, v52:PointToWorldSpace(Vector3.new(value_8 * v49.X, value_9 * v49.Y, value_10 * v49.Z)))
                end
            end
        end
        v50 = PrimaryPart_upv_1:FindFirstChild("Muzzle", true)
        local v53 = nil
        local v54 = nil
        if v32 and v32.pan then
            v54 = Instance.new("Attachment")
            v54.Name = "ViewPan"
            local v55 = v32.pan
            local v56 = (v32.len) or (u3.len)
            v54.Position = v55 * (v56 / v43)
            v54.Parent = PrimaryPart_upv_1
        end
        if v32 and v32.muzzle then
            v54 = Instance.new("Attachment")
            v54.Name = "ViewMuzzle"
            local v55 = v32.muzzle
            local v57 = (v32.len) or (u3.len)
            v54.Position = v55 * (v57 / v43)
            v54.Parent = PrimaryPart_upv_1
            v50 = v54
        end
        local v58 = -(tbl_upv_2.hand.Z + u3.pos.Z)
        local function asOffsets_1(a3)
            --[[
              name: asOffsets
              line: 717
              upvalues:
                BladeClips_upv_1 (copy, index: 1)
                u7 (copy, index: 2)
                tbl_upv_2 (copy, index: 3)
                u3 (ref,  index: 4)
            ]]
            if type(a3) ~= "table" then
                return nil, nil
            end
            local v59 = BladeClips_upv_1.Frame(a3.pos, a3.tip, a3.edge)
            local v60, v61, v62 = (v59.Rotation * u7:Inverse()):ToEulerAnglesYXZ()
            return v59.Position - (tbl_upv_2.hand + u3.pos), (Vector3.new(v60, v61, v62))
        end
        local v54, v63 = asOffsets_1(u3.blockFrame)
        local v55, v64 = asOffsets_1(u3.drawFrame)
        local v66 = 0
        for _, value_11 in tbl_9 do
            v66 = math.max(v66, value_11.Z)
        end
        local tbl_11 = {}
        tbl_11.model = v31
        tbl_11.gripInv = u5:Inverse()
        tbl_11.pivotRel = PrimaryPart_upv_1.CFrame:ToObjectSpace(v31:GetPivot())
        tbl_11.kind = a2
        tbl_11.cfg = u3
        tbl_11.id = a1
        tbl_11.style = gripRelNow_1
        tbl_11.styleRot = u7
        tbl_11.norm = u6
        tbl_11.bladeLen = v48
        tbl_11.blockP = v54
        tbl_11.blockR = v63
        tbl_11.drawP = v55
        tbl_11.drawR = v64
        tbl_11.brace = v66
        local v67 = BladeClips_upv_1.SETS[a2] or (ItemClips_upv_1.For(a1, a2))
        tbl_11.clips = v67
        local pt_1 = ItemClips_upv_1.ITEMS[a1]
        tbl_11.drawFrom = (pt_1 and (pt_1.drawFrom)) or (BladeClips_upv_1.DRAW[a2] or (ItemClips_upv_1.DRAW[a2]))
        tbl_11.corners = tbl_9
        if (v50) and (v50:IsA("Attachment")) then
            v67 = v50
        else
            v67 = not (v46) or not (v46:IsA("Attachment")) or v46
        end
        tbl_11.muzzle = v67
        v67 = not (v46) or not (v46:IsA("Attachment")) or v46
        tbl_11.tipAtt = v67
        v67 = not (v47) or not (v47:IsA("Attachment")) or v47
        tbl_11.gripAtt = v67
        tbl_11.pan = v53
        tbl_11.hammer = hammerOf(v31, PrimaryPart_upv_1)
        tbl_11.frizzen = hammerOf(v31, PrimaryPart_upv_1, "Frizzen", "FrizzenPivot", "Open")
        local v68 = not (v50) or not (v50:IsA("Attachment")) or v50
        tbl_11.rod = rodOf(v31, PrimaryPart_upv_1, v68)
        if a1 ~= "longbow" then
            pt_1 = nil
        else
            pt_1 = v31:FindFirstChild("Neon", true)
        end
        if (pt_1) and (pt_1:IsA("BasePart")) then
            v67 = {}
            v67.part = pt_1
            v67.rest = pt_1.Color
        else
            v67 = nil
        end
        tbl_11.inlay = v67
        pt_1 = v31:FindFirstChild("Strip", true)
        if (pt_1) and (pt_1:IsA("BasePart")) then
            pt_1.Transparency = 0
            local tbl_12 = {}
            tbl_12.part = pt_1
            tbl_12.size = pt_1.Size
            tbl_12.rest = PrimaryPart_upv_1.CFrame:ToObjectSpace(pt_1.CFrame)
            v67 = tbl_12
        else
            v67 = nil
        end
        tbl_11.strip = v67
        pt_1 = v31:FindFirstChild("Stone", true)
        v67 = not (pt_1) or not (pt_1:IsA("BasePart")) or pt_1
        tbl_11.stone = v67
        pt_1 = function(a4)
            --[[
              name: pt
              line: 779
              upvalues:
                PrimaryPart_upv_1 (copy, index: 1)
                u6 (copy, index: 2)
                u5 (copy, index: 3)
            ]]
            local v69 = PrimaryPart_upv_1:FindFirstChild(a4)
            if v69 and v69:IsA("Attachment") then
                return ((u6 * u5:Inverse()):PointToWorldSpace(v69.Position))
            end
            return nil
        end
        local NockTop_1 = PrimaryPart_upv_1:FindFirstChild("NockTop")
        local v70 = not (NockTop_1) or not (NockTop_1:IsA("Attachment")) or (u6 * u5:Inverse()):PointToWorldSpace(NockTop_1.Position)
        local NockBottom_1 = PrimaryPart_upv_1:FindFirstChild("NockBottom")
        local v71 = not (NockBottom_1) or not (NockBottom_1:IsA("Attachment")) or (u6 * u5:Inverse()):PointToWorldSpace(NockBottom_1.Position)
        local Brace_1 = PrimaryPart_upv_1:FindFirstChild("Brace")
        local v72 = not (Brace_1) or not (Brace_1:IsA("Attachment")) or (u6 * u5:Inverse()):PointToWorldSpace(Brace_1.Position)
        local NockPoint_1 = PrimaryPart_upv_1:FindFirstChild("NockPoint")
        local v73 = not (NockPoint_1) or not (NockPoint_1:IsA("Attachment")) or (u6 * u5:Inverse()):PointToWorldSpace(NockPoint_1.Position)
        local Rest_1 = PrimaryPart_upv_1:FindFirstChild("Rest")
        local v74 = not (Rest_1) or not (Rest_1:IsA("Attachment")) or (u6 * u5:Inverse()):PointToWorldSpace(Rest_1.Position)
        if v70 and v71 and v72 and v73 and v74 then
            local tbl_13 = {}
            tbl_13.top = v70
            tbl_13.bottom = v71
            tbl_13.brace = v72
            tbl_13.nock = v73
            tbl_13.rest = v74
            v67 = tbl_13
        else
            v67 = nil
        end
        tbl_11.bow = v67
        pt_1 = function(a5)
            --[[
              name: pt
              line: 789
              upvalues:
                PrimaryPart_upv_1 (copy, index: 1)
                u6 (copy, index: 2)
                u5 (copy, index: 3)
            ]]
            local v75 = PrimaryPart_upv_1:FindFirstChild(a5)
            if v75 and v75:IsA("Attachment") then
                return ((u6 * u5:Inverse()):PointToWorldSpace(v75.Position))
            end
            return nil
        end
        local StringLeft_1 = PrimaryPart_upv_1:FindFirstChild("StringLeft")
        v70 = not (StringLeft_1) or not (StringLeft_1:IsA("Attachment")) or (u6 * u5:Inverse()):PointToWorldSpace(StringLeft_1.Position)
        local StringRight_1 = PrimaryPart_upv_1:FindFirstChild("StringRight")
        v71 = not (StringRight_1) or not (StringRight_1:IsA("Attachment")) or (u6 * u5:Inverse()):PointToWorldSpace(StringRight_1.Position)
        local Nut_1 = PrimaryPart_upv_1:FindFirstChild("Nut")
        v72 = not (Nut_1) or not (Nut_1:IsA("Attachment")) or (u6 * u5:Inverse()):PointToWorldSpace(Nut_1.Position)
        local Brace_2 = PrimaryPart_upv_1:FindFirstChild("Brace")
        v73 = not (Brace_2) or not (Brace_2:IsA("Attachment")) or (u6 * u5:Inverse()):PointToWorldSpace(Brace_2.Position)
        if a2 == "Crossbow" and v70 and v71 and v72 and v73 then
            local tbl_14 = {}
            tbl_14.left = v70
            tbl_14.right = v71
            tbl_14.nut = v72
            tbl_14.brace = v73
            v67 = tbl_14
        else
            v67 = nil
        end
        tbl_11.xbow = v67
        v67 = not (v46) or not (v46:IsA("Attachment")) or (u6 * u5:Inverse()):PointToWorldSpace(v46.Position)
        tbl_11.tipCanon = v67
        tbl_11.handle = PrimaryPart_upv_1
        tbl_11.leftFist = v37
        tbl_11.wallDist = (v58 + v51) + tbl_upv_2.wallMargin
        tbl_11.wallRot = math.min(tbl_upv_2.wallRotMax, math.deg(math.asin(math.clamp(v51 / math.max(u3.len, 0.05), 0, 1))) + 12) * 0.017453292519943295
        if v37 then
            v37.part.Parent = v31
        end
        v31.Name = "TribesViewModel_" .. a1
        tbl_upv_6[a1] = tbl_11
        return tbl_11
    end
    v31:Destroy()
    return nil
end
local u8 = resetState.new(Vector3.new(0, 0, 0), tbl_upv_2.poseHz, tbl_upv_2.poseDamp)
local u9 = resetState.new(Vector3.new(0, 0, 0), tbl_upv_2.poseHz, tbl_upv_2.poseDamp)
local u10 = resetState.new(0, tbl_upv_2.airHz, tbl_upv_2.airDamp)
local u11 = resetState.new(0, tbl_upv_2.airHz, tbl_upv_2.airDamp)
local u12 = resetState.new(0, tbl_upv_2.landHz, tbl_upv_2.landDamp)
local u13 = resetState.new(Vector3.new(0, 0, 0), tbl_upv_2.swayHz, tbl_upv_2.swayDamp)
local u14 = resetState.new(Vector3.new(0, 0, 0), tbl_upv_2.mvHz, tbl_upv_2.mvDamp)
local u15 = resetState.new(Vector3.new(0, 0, 0), tbl_upv_2.mvHz, tbl_upv_2.mvDamp)
local u16 = resetState.new(Vector3.new(0, 0, 0), tbl_upv_2.kickHz, tbl_upv_2.kickDamp)
local u17 = resetState.new(Vector3.new(0, 0, 0), tbl_upv_2.kickHz, tbl_upv_2.kickDamp)
local u18 = resetState.new(0, tbl_upv_2.equipHz, tbl_upv_2.equipDamp)
local tbl_upv_15 = {}
tbl_upv_15.shown = nil
tbl_upv_15.wantId = nil
tbl_upv_15.dropAt = nil
tbl_upv_15.hiddenUntil = 0
tbl_upv_15.action = nil
tbl_upv_15.actT0 = 0
tbl_upv_15.actDur = 1
tbl_upv_15.actMirror = 1
tbl_upv_15.block = false
tbl_upv_15.parry = false
tbl_upv_15.charge = false
tbl_upv_15.chargeT0 = 0
tbl_upv_15.chargeTime = 0.6
tbl_upv_15.draw = false
tbl_upv_15.drawT0 = 0
tbl_upv_15.drawTime = 1
tbl_upv_15.wind = false
tbl_upv_15.windT0 = 0
tbl_upv_15.windTime = 0.5
tbl_upv_15.windHold = 0
tbl_upv_15.windK = 0
tbl_upv_15.windHalf = false
tbl_upv_15.throwN = 0
tbl_upv_15.looseAt = nil
tbl_upv_15.nocked = true
tbl_upv_15.nockT0 = -10
tbl_upv_15.shotN = 0
tbl_upv_15.arrowTip = nil
tbl_upv_15.inlayLvl = 0
tbl_upv_15.inlayFrom = Color3.new()
tbl_upv_15.inlayT0 = -10
tbl_upv_15.bite = 0
tbl_upv_15.spinA = 0
tbl_upv_15.spinT0 = -10
tbl_upv_15.stringV = 0
tbl_upv_15.stringT0 = -10
tbl_upv_15.stripV = 0.25
tbl_upv_15.useOutUntil = nil
tbl_upv_15.use = false
tbl_upv_15.useT0 = 0
tbl_upv_15.useTime = 1
tbl_upv_15.reload = false
tbl_upv_15.reloadT0 = 0
tbl_upv_15.reloadTime = 1
tbl_upv_15.grounded = true
tbl_upv_15.minVy = 0
tbl_upv_15.lastYaw = nil
tbl_upv_15.lastPitch = nil
tbl_upv_15.lastRootY = nil
tbl_upv_15.vy = 0
tbl_upv_15.step = 0
tbl_upv_15.now = 0
tbl_upv_15.spent = false
tbl_upv_15.clip = nil
tbl_upv_15.clipT0 = 0
tbl_upv_15.clipFrom = CFrame.identity
tbl_upv_15.clipScale = 1
tbl_upv_15.lastFrame = nil
tbl_upv_15.frame = nil
tbl_upv_15.layerPos = Vector3.new(0, 0, 0)
tbl_upv_15.layerRot = Vector3.new(0, 0, 0)
tbl_upv_15.spark = false
tbl_upv_15.wallPush = 0
tbl_upv_15.restFrame = CFrame.identity
tbl_upv_15.rawVel = nil
tbl_upv_15.clipFromVel = nil
tbl_upv_15.lastFrameT = 0
tbl_upv_15.clipName = nil
tbl_upv_15.clipFx = 1
tbl_upv_15.fxQueue = {}
tbl_upv_15.pendingDraw = nil
tbl_upv_15.vanishAt = nil
tbl_upv_15.shakeUntil = 0
tbl_upv_15.embers = false
tbl_upv_15.fuse = 0
tbl_upv_15.arrowKind = "Arrow"
tbl_upv_15.sim = false
tbl_upv_15.release = nil
tbl_upv_15.releaseT = 0
tbl_upv_15.boltIn = true
tbl_upv_15.boltT0 = -10
tbl_upv_15.drawHold = 0
tbl_upv_15.drawHalf = false
tbl_upv_15.drawFull = false
tbl_upv_15.chargeFull = false
tbl_upv_15.hammerTarget = 0
tbl_upv_15.frizzenTarget = 0
tbl_upv_15.rodV = 0
tbl_upv_15.windFull = false
tbl_upv_15.leftLast = nil
tbl_upv_15.leftFrom = CFrame.identity
tbl_upv_15.leftFromVel = nil
tbl_upv_15.leftVel = nil
tbl_upv_15.leftFrame = nil
tbl_upv_15.leftOut = false
tbl_upv_15.leftVanishAt = nil
tbl_upv_15.leftCatchT = -10
tbl_upv_15.lastLungeT = nil
tbl_upv_15.lastLungeName = nil
tbl_upv_15.refreshGlintAt = nil
tbl_upv_15.refreshFF = nil
tbl_upv_15.leftOutAt = -10
tbl_upv_15.leftSeenOut = false
local u19 = resetState.new(Vector3.new(0, 0, 0), tbl_upv_2.retHz, tbl_upv_2.retDamp)
local u20 = resetState.new(0, 16, 0.45)
local u21 = resetState.new(0, 14, 0.4)
local u22 = resetState.new(Vector3.new(0, 0, 0), tbl_upv_2.retHz, tbl_upv_2.retDamp)
local function startAction(a1, a2, a3)
    --[[
      name: startAction
      line: 955
      upvalues:
        tbl_upv_5 (copy, index: 1)
        tbl_upv_15 (copy, index: 2)
    ]]
    local v76 = tbl_upv_5[a1]
    if not v76 then
        return
    end
    tbl_upv_15.action = a1
    tbl_upv_15.actT0 = tbl_upv_15.now
    tbl_upv_15.actDur = a2 or (v76.dur)
    tbl_upv_15.actMirror = a3 or 1
end
local function rise()
    --[[
      name: rise
      line: 966
      upvalues:
        u18 (copy, index: 1)
    ]]
    u18.value = -1
    u18.velocity = 0
    u18.target = 0
end
local function hasClip(a1)
    --[[
      name: hasClip
      line: 997
      upvalues:
        tbl_upv_15 (copy, index: 1)
    ]]
    local shown_1 = tbl_upv_15.shown
    return (shown_1 ~= nil) and ((shown_1.clips ~= nil) and (shown_1.clips[a1] ~= nil))
end
local function clipTime(a1)
    --[[
      name: clipTime
      line: 1003
      upvalues:
        tbl_upv_15 (copy, index: 1)
    ]]
    return a1 - tbl_upv_15.clipT0
end
local function smooth(a1)
    --[[
      name: smooth
      line: 1010
    ]]
    local v77 = math.clamp(a1, 0, 1)
    return (v77 * v77) * (3 - (v77 * 2))
end
local function startClip(a1, a2, a3, a4)
    --[[
      name: startClip
      line: 972
      upvalues:
        tbl_upv_15 (copy, index: 1)
        u19 (copy, index: 2)
        u22 (copy, index: 3)
    ]]
    local v78
    if tbl_upv_15.shown then
        v78 = tbl_upv_15.shown.clips
    else
        v78 = nil
    end
    local v79
    if v78 then
        v79 = v78[a1]
    else
        v79 = nil
    end
    if not v79 then
        return false
    end
    tbl_upv_15.clip = v79
    tbl_upv_15.clipName = a1
    tbl_upv_15.clipFx = 1
    tbl_upv_15.clipFrom = a3 or (tbl_upv_15.lastFrame or (tbl_upv_15.restFrame))
    tbl_upv_15.clipFromVel = a3 or tbl_upv_15.rawVel
    tbl_upv_15.leftFrom = a3 or (tbl_upv_15.leftLast or (tbl_upv_15.restFrame))
    local v80 = a3 or tbl_upv_15.leftVel
    tbl_upv_15.leftFromVel = v80
    local lastFrameT_1 = tbl_upv_15.lastFrameT
    local v81
    if not a3 and tbl_upv_15.lastFrame and tbl_upv_15.now - lastFrameT_1 >= 0 and tbl_upv_15.now - lastFrameT_1 < 0.1 then
        v81 = lastFrameT_1
    else
        v81 = tbl_upv_15.now
    end
    tbl_upv_15.clipT0 = v81
    if a4 then
        v81 = a4
    elseif a2 and a2 > 0 and v79.contact > 0 then
        v81 = math.clamp(a2 / v79.contact, 0.6, 1.8)
    else
        v81 = 1
    end
    tbl_upv_15.clipScale = v81
    u19:Snap(Vector3.new(0, 0, 0))
    u22:Snap(Vector3.new(0, 0, 0))
    return true
end
local function evalKeys(a1, a2)
    --[[
      name: evalKeys
      line: 1281
    ]]
    local v82 = #a1
    if a2 <= a1[1][1] then
        return a1[1][2], a1[1][3]
    else
        local v83, v84, v85, v86 = nil, nil, nil, nil
        for n_1 = 1, v82 - 1 do
            v83 = a1[n_1]
            v84 = a1[n_1 + 1]
            v85 = v83[1]
            v86 = v84[1]
            if not (a2 <= v86) then
                continue
            end
            local v87 = math.clamp((a2 - v85) / math.max(v86 - v85, 1e-04), 0, 1)
            local v88 = v87 * v87 * (3 - (v87 * 2))
            return v83[2]:Lerp(v84[2], v88), v83[3]:Lerp(v84[3], v88)
        end
        return a1[v82][2], a1[v82][3]
    end
end
local function wrap(a1)
    --[[
      name: wrap
      line: 1297
    ]]
    return ((a1 + math.pi) % math.tau) - math.pi
end
local function evalTrack(a1, a2)
    --[[
      name: evalTrack
      line: 558
    ]]
    if a2 <= a1[1][1] then
        return a1[1][2]
    else
        local v89, v90 = nil, nil
        for n_2 = 2, #a1 do
            v89 = a1[n_2 - 1]
            v90 = a1[n_2]
            if not (a2 <= v90[1]) then
                continue
            end
            local v91 = v89[2] <= 1.5
            if v91 ~= (v90[2] <= 1.5) then
                return v89[2]
            end
            local v92 = (a2 - v89[1]) / math.max(v90[1] - v89[1], 1e-04)
            return v89[2] + ((v90[2] - v89[2]) * ((v92 * v92) * (3 - (v92 * 2))))
        end
        return a1[#a1][2]
    end
end
local u23 = nil
local u24 = RaycastParams.new()
u24.FilterType = Enum.RaycastFilterType.Exclude
u24.RespectCanCollide = true
local u25 = nil
local tbl_upv_16 = {}
local tbl_upv_17 = {}
local tbl_upv_18 = {}
local tbl_upv_19 = {}
local tbl_upv_20 = {}
local tbl_upv_21 = {}
local tbl_upv_22 = {}
local u26 = nil
local function arrowFor(a1, a2)
    --[[
      name: arrowFor
      line: 2008
      upvalues:
        tbl_upv_22 (copy, index: 1)
        ReplicatedStorage_upv_1 (copy, index: 2)
        u2 (ref,  index: 3)
    ]]
    local v93 = a1 .. ":" .. tostring(a2 or 0.36)
    local v94 = tbl_upv_22[v93]
    if v94 then
        return v94
    end
    local Assets_1 = ReplicatedStorage_upv_1:FindFirstChild("Assets")
    local v95 = Assets_1 and (Assets_1:FindFirstChild("VFX"))
    local v96 = v95
    local _ = v96 and (v95:FindFirstChild("Projectiles"))
    if a1 == "ViewArrow" and (u2) then
        v95 = u2:FindFirstChild("Arrow")
    else
        v95 = v96 and (v96:FindFirstChild(a1) or (v96:FindFirstChild("Arrow")))
    end
    if not v95 or not v95:IsA("Model") then
        return nil
    end
    local v97 = v95:Clone()
    for v99, value_12 in v97:GetDescendants() do
        if value_12:IsA("BasePart") then
            value_12.Anchored = true
            value_12.CanCollide = false
            value_12.CanQuery = false
            value_12.CanTouch = false
            value_12.CastShadow = false
            if a1 ~= "Bolt" or not (math.min(value_12.Color.R, value_12.Color.G, value_12.Color.B) > 0.5) then
                continue
            end
            value_12.Color = Color3.fromRGB(120, 124, 130)
            if value_12:IsA("MeshPart") then
                value_12.TextureID = ""
            end
        else
            if value_12:IsA("ParticleEmitter") then
                value_12.LockedToPart = true
                continue
            end
            if value_12:IsA("Trail") or value_12:IsA("Beam") or value_12:IsA("Light") then
                value_12.Enabled = false
                continue
            end
            if value_12:IsA("Script") or value_12:IsA("LocalScript") or value_12:IsA("Sound") then
                value_12:Destroy()
            end
        end
    end
    local v100, v98 = v97:GetBoundingBox()
    v97:ScaleTo((math.clamp((a2 or 0.36) / math.max(v98.X, v98.Y, v98.Z, 0.05), 0.005, 1)))
    v97.Name = "TribesViewArrow_" .. a1
    v98 = v97:GetBoundingBox()
    local tbl_23 = {model = v97, centre = v97:GetPivot():ToObjectSpace(v98)}
    tbl_upv_22[v93] = tbl_23
    return tbl_23
end
local tbl_upv_24 = {ringTime = 0.15, thick = 0.0035, ring = 0.02, ringHz = 18}
tbl_upv_24.color = Color3.fromRGB(196, 180, 140)
local tbl_upv_25 = {}
local function stringPart(a1)
    --[[
      name: stringPart
      line: 2085
      upvalues:
        tbl_upv_25 (copy, index: 1)
        tbl_upv_24 (copy, index: 2)
    ]]
    local v99 = tbl_upv_25[a1]
    if not (v99) then
        v99 = Instance.new("Part")
        v99.Name = "TribesViewString"
        v99.Anchored = true
        v99.CanCollide = false
        v99.CanQuery = false
        v99.CanTouch = false
        v99.CastShadow = false
        v99.Material = Enum.Material.SmoothPlastic
        v99.Color = tbl_upv_24.color
        v99.Size = Vector3.new(tbl_upv_24.thick, tbl_upv_24.thick, 0.1)
        tbl_upv_25[a1] = v99
    end
    return v99
end
local function hideStrings()
    --[[
      name: hideStrings
      line: 2102
      upvalues:
        tbl_upv_25 (copy, index: 1)
    ]]
    for _, value_13 in tbl_upv_25 do
        value_13.Parent = nil
    end
end
local function drawBolt(a1, a2, a3)
    --[[
      name: drawBolt
      line: 2060
      upvalues:
        tbl_upv_15 (copy, index: 1)
        arrowFor (copy, index: 2)
    ]]
    if a3.kind == "Crossbow" and tbl_upv_15.boltIn and tbl_upv_15.frame and a3.muzzle then
        local v100 = arrowFor("Bolt", 0.347)
        if not v100 then
            return nil
        end
        local frame_1 = tbl_upv_15.frame
        local LookVector_1 = frame_1.LookVector
        local v101 = a2:PointToObjectSpace(a3.muzzle.WorldPosition)
        local v102 = math.clamp((tbl_upv_15.now - tbl_upv_15.boltT0) / 0.1, 0, 1)
        local v103 = v101 - LookVector_1 * (0.1735 + (0.24 * (1 - ((v102 * v102) * (3 - (v102 * 2))))))
        v100.model:PivotTo(a2 * (CFrame.lookAt(v103, v103 + LookVector_1, frame_1.UpVector) * v100.centre:Inverse()))
        if v100.model.Parent ~= a1 then
            v100.model.Parent = a1
        end
        return v100.model
    end
    return nil
end
local function drawArrow(a1, a2, a3, a4)
    --[[
      name: drawArrow
      line: 2108
      upvalues:
        tbl_upv_15 (copy, index: 1)
        arrowFor (copy, index: 2)
        u2 (ref,  index: 3)
        drawBolt (copy, index: 4)
        u26 (ref,  index: 5)
        tbl_upv_25 (copy, index: 6)
        tbl_upv_24 (copy, index: 7)
    ]]
    local bow_1 = a4.bow
    local v104
    local v106 = nil
    if (a4.kind == "Bow") and ((a4.cfg.stock ~= nil) and (tbl_upv_15.nocked and (tbl_upv_15.frame ~= nil))) then
        if (u2) and (u2:FindFirstChild("Arrow")) then
            v106 = "ViewArrow"
        else
            v106 = tbl_upv_15.arrowKind
        end
        v104 = arrowFor(v106, 0.36)
    else
        v104 = nil
    end
    if v104 then
        v106 = v104.model
    else
        v106 = drawBolt(a1, a2, a4)
    end
    if v106 ~= u26 then
        if u26 then
            u26.Parent = nil
        end
        u26 = v106
    end
    local frame_2 = tbl_upv_15.frame
    if frame_2 then
        local v107 = CFrame.new(frame_2.X, frame_2.Y, frame_2.Z * a3) * frame_2.Rotation
        local v108 = math.clamp((tbl_upv_15.now - tbl_upv_15.drawT0) / tbl_upv_15.drawTime, 0, 1)
        local v109 = v108 * v108 * (3 - (v108 * 2))
        v108 = nil
        if bow_1 then
            local v110 = nil
            if tbl_upv_15.draw then
                v108 = bow_1.nock + Vector3.new(0, 0, 0.12 * v109)
            else
                v110 = tbl_upv_15.now - tbl_upv_15.drawHold + 0.16
                local v111
                if (v110 >= 0) and (v110 < tbl_upv_24.ringTime) then
                    v111 = tbl_upv_24.ring * math.sin(((v110 * tbl_upv_24.ringHz) * 2) * math.pi) * (1 - (v110 / tbl_upv_24.ringTime))
                else
                    v111 = 0
                end
                v108 = bow_1.brace + Vector3.new(v111, 0, v111 * 0.3)
            end
            local v112 = v107:PointToWorldSpace(v108)
            for key_3, value_14 in {bow_1.top, bow_1.bottom} do
                local v113 = v107:PointToWorldSpace(value_14)
                local v114 = tbl_upv_25[key_3]
                if not (v114) then
                    v114 = Instance.new("Part")
                    v114.Name = "TribesViewString"
                    v114.Anchored = true
                    v114.CanCollide = false
                    v114.CanQuery = false
                    v114.CanTouch = false
                    v114.CastShadow = false
                    v114.Material = Enum.Material.SmoothPlastic
                    v114.Color = tbl_upv_24.color
                    v114.Size = Vector3.new(tbl_upv_24.thick, tbl_upv_24.thick, 0.1)
                    tbl_upv_25[key_3] = v114
                end
                v114.Size = Vector3.new(tbl_upv_24.thick, tbl_upv_24.thick, math.max((v112 - v113).Magnitude, 0.001))
                v114.CFrame = a2 * CFrame.lookAt((v113 + v112) * 0.5, v112)
                if v114.Parent ~= a1 then
                    v114.Parent = a1
                end
            end
        elseif a4.xbow then
            local xbow_1 = a4.xbow
            local v115 = math.clamp(tbl_upv_15.stringV, 0, 1)
            local v116 = tbl_upv_15.now - tbl_upv_15.stringT0
            local v117 = xbow_1.brace - xbow_1.nut
            local v118 = v117:Cross(xbow_1.right - xbow_1.left)
            local v119 = ((not (v118.Magnitude > 1e-06)) and Vector3.new(0, 1, 0)) or (v118.Unit)
            if (v116 >= 0) and (v116 < 0.15) then
                v118 = math.cos(((v116 * 18) * 2) * math.pi) * 0.012 * (1 - (v116 / 0.15))
            else
                v118 = 0
            end
            v119 = v107:PointToWorldSpace((xbow_1.nut + (v117 * v115)) + (v119 * v118))
            for key_4, value_15 in {xbow_1.left, xbow_1.right} do
                v118 = v107:PointToWorldSpace(value_15)
                local v120 = tbl_upv_25[key_4]
                if v120 then
                    v117 = v120
                else
                    local v121 = Instance.new("Part")
                    v121.Name = "TribesViewString"
                    v121.Anchored = true
                    v121.CanCollide = false
                    v121.CanQuery = false
                    v121.CanTouch = false
                    v121.CastShadow = false
                    v121.Material = Enum.Material.SmoothPlastic
                    v121.Color = tbl_upv_24.color
                    v121.Size = Vector3.new(tbl_upv_24.thick, tbl_upv_24.thick, 0.1)
                    tbl_upv_25[key_4] = v121
                    v117 = v121
                end
                local v122 = tbl_upv_24.thick * 1.5
                v117.Size = Vector3.new(v122, v122, math.max((v119 - v118).Magnitude, 0.001))
                v117.CFrame = a2 * CFrame.lookAt((v118 + v119) * 0.5, v119)
                if v117.Parent ~= a1 then
                    v117.Parent = a1
                end
            end
        else
            for _, value_16 in tbl_upv_25 do
                value_16.Parent = nil
            end
        end
        if v104 and v106 then
            local v123 = math.clamp((tbl_upv_15.now - tbl_upv_15.nockT0) / 0.1, 0, 1)
            local v124 = 1 - (v123 * v123) * (3 - (v123 * 2))
            local v111
            if (bow_1) and (v108) then
                local v125 = v107:PointToWorldSpace(v108 + Vector3.new(0, -0.07 * v124, 0))
                v123, v111 = (v107:PointToWorldSpace(bow_1.rest) - v125).Unit, v125
            else
                local v126 = v107 * Vector3.new(-0.012, -0.07 * v124, (a4.brace - 0.005) + (0.12 * v109))
                v123, v111 = frame_2.LookVector, v126
            end
            tbl_upv_15.arrowTip = v111 + (v123 * 0.36)
            if v104.centre.Position.Z < 0 and u2 and u2:FindFirstChild("Arrow") then
                v106:PivotTo(a2 * CFrame.lookAt(v111, v111 + v123, frame_2.UpVector))
            else
                local v127 = v111 + v123 * 0.18
                v106:PivotTo(a2 * (CFrame.lookAt(v127, v127 + v123, frame_2.UpVector) * v104.centre:Inverse()))
            end
            if v106.Parent ~= a1 then
                v106.Parent = a1
            end
            return
        end
    else
        for _, value_17 in tbl_upv_25 do
            value_17.Parent = nil
        end
    end
end
local tbl_upv_26 = {fire_bomb = true}
local tbl_upv_27 = {Hatchets = true, Gauntlets = true, Spear = true}
local function itemPoint(a1, a2, a3)
    --[[
      name: itemPoint
      line: 2208
      upvalues:
        tbl_upv_15 (copy, index: 1)
    ]]
    local v128 = tbl_upv_15.frame or (CFrame.identity)
    local v129
    if a3 ~= "tip" then
        v129 = a2.muzzle
    else
        v129 = a2.tipAtt or (a2.muzzle)
    end
    local v130
    if a2.gripAtt then
        v130 = a2.gripAtt.WorldPosition
    else
        v130 = a2.model:GetPivot().Position
    end
    local v131
    if v129 then
        v131 = v129.WorldPosition
    else
        v131 = v130
    end
    local v132 = a1:PointToObjectSpace(v131)
    local v133
    if a2.cfg.act == "gun" then
        v133 = v128.LookVector
    else
        local v134 = nil
        if a3 ~= "barrel" then
            v134 = a1:PointToObjectSpace(v130)
            if (v132 - v134).Magnitude > 0.001 then
                v133 = (v132 - v134).Unit
            else
                v133 = v128.LookVector
            end
        else
            v133 = v128.LookVector
        end
    end
    return CFrame.lookAt(v132, v132 + v133)
end
local function viewEffects(a1, a2, a3)
    --[[
      name: viewEffects
      line: 2263
      upvalues:
        ViewFx_upv_1 (copy, index: 1)
        tbl_upv_15 (copy, index: 2)
        itemPoint (copy, index: 3)
        tbl_upv_2 (copy, index: 4)
        u26 (ref,  index: 5)
        Sfx_upv_1 (copy, index: 6)
        tbl_upv_26 (copy, index: 7)
    ]]
    ViewFx_upv_1.Follow(a1, a2)
    local fxQueue_1 = tbl_upv_15.fxQueue
    if #fxQueue_1 > 0 then
        local v135, v136, _ = nil, nil, nil
        local v137 = nil
        local v138 = nil
        local v139 = nil
        for v154, value_18 in fxQueue_1 do
            if value_18 == "muzzle" then
                local Play_1 = ViewFx_upv_1.Play
                local v140 = itemPoint(a2, a3, "barrel")
                v137 = {style = 0}
                v137.style = ((a3.kind == "Blunderbuss") and "blunderbuss") or (((a3.kind ~= "Pistol") and "musket") or "pistol")
                Play_1("muzzle", v140, v137)
                continue
            end
            if value_18 == "pan" then
                local v141 = tbl_upv_15.frame or (CFrame.identity)
                if a3.gripAtt then
                    v138 = a2:PointToObjectSpace(a3.gripAtt.WorldPosition)
                else
                    v138 = v141.Position
                end
                local v142 = ((not (a3.pan)) and (v138 + (v141.UpVector * 0.035) + v141.LookVector * 0.05)) or (a2:PointToObjectSpace(a3.pan.WorldPosition))
                ViewFx_upv_1.Play("pan", CFrame.lookAt(v142, v142 + v141.UpVector))
            elseif value_18 == "headglint" then
                local v143 = tbl_upv_15.frame or (CFrame.identity)
                if a3.gripAtt then
                    v138 = a2:PointToObjectSpace(a3.gripAtt.WorldPosition)
                else
                    v138 = v143.Position
                end
                v135 = v138 + v143.UpVector * (((value_18 ~= "headglint") and (a3.cfg.len * 0.8)) or (a3.bladeLen * 0.85))
                v137 = tbl_upv_2.smearAlong[a3.kind]
                if value_18 == "headglint" then
                    v135 = (v137 and (v138 + (v143.UpVector * (a3.bladeLen * v137.root)) + v143.LookVector * (a3.bladeLen * 0.3))) or v135
                end
                local v144 = math.tan(math.rad(a1.FieldOfView) / 2)
                local v145 = a1.ViewportSize.X / math.max(a1.ViewportSize.Y, 1)
                for v155 = 1, 6 do
                    v139 = -v135.Z
                    if not (v139 > 0.05) or not (math.abs(v135.X / ((v139 * v144) * v145)) < 0.9) or not (math.abs(v135.Y / (v139 * v144)) < 0.9) then
                        v135 = v138 + (v135 - v138) * 0.8
                        continue
                    end
                    break
                end
                v135 = v135.Unit * math.min(v135.Magnitude - 0.03, 0.5)
                ViewFx_upv_1.Play(((value_18 ~= "headglint") and "block_spark") or ((v137 and "flare") or "glint"), CFrame.lookAt(v135, v135 + v143.UpVector))
                continue
            elseif value_18 == "rimspark" then
                local v143 = tbl_upv_15.frame or (CFrame.identity)
                if a3.gripAtt then
                    v138 = a2:PointToObjectSpace(a3.gripAtt.WorldPosition)
                else
                    v138 = v143.Position
                end
                v135 = v138 + v143.UpVector * (((value_18 ~= "headglint") and (a3.cfg.len * 0.8)) or (a3.bladeLen * 0.85))
                v137 = tbl_upv_2.smearAlong[a3.kind]
                if value_18 == "headglint" then
                    v135 = (v137 and (v138 + (v143.UpVector * (a3.bladeLen * v137.root)) + v143.LookVector * (a3.bladeLen * 0.3))) or v135
                end
                local v144 = math.tan(math.rad(a1.FieldOfView) / 2)
                local v145 = a1.ViewportSize.X / math.max(a1.ViewportSize.Y, 1)
                for v155 = 1, 6 do
                    v139 = -v135.Z
                    if not (v139 > 0.05) or not (math.abs(v135.X / ((v139 * v144) * v145)) < 0.9) or not (math.abs(v135.Y / (v139 * v144)) < 0.9) then
                        v135 = v138 + (v135 - v138) * 0.8
                        continue
                    end
                    break
                end
                v135 = v135.Unit * math.min(v135.Magnitude - 0.03, 0.5)
                ViewFx_upv_1.Play(((value_18 ~= "headglint") and "block_spark") or ((v137 and "flare") or "glint"), CFrame.lookAt(v135, v135 + v143.UpVector))
            elseif value_18 ~= "fullglint" then
                if value_18 == "bolt" then
                    ViewFx_upv_1.Play("glint", itemPoint(a2, a3, "muzzle"))
                    continue
                end
                if string.sub(value_18, 1, 4) ~= "sfx:" then
                    if value_18 ~= "click" or not (a3.pan) then
                        if value_18 == "twang" then
                            ViewFx_upv_1.Play(value_18, itemPoint(a2, a3, "muzzle"))
                            continue
                        end
                        if value_18 == "snap" then
                            ViewFx_upv_1.Play(value_18, itemPoint(a2, a3, "muzzle"))
                            continue
                        end
                        if value_18 == "powder" then
                            ViewFx_upv_1.Play(value_18, itemPoint(a2, a3, "muzzle"))
                            continue
                        end
                        if value_18 == "puff" then
                            ViewFx_upv_1.Play(value_18, itemPoint(a2, a3, "muzzle"))
                            continue
                        end
                        if value_18 == "click" then
                            ViewFx_upv_1.Play(value_18, itemPoint(a2, a3, "muzzle"))
                            continue
                        end
                        if value_18 == "ring" then
                            ViewFx_upv_1.Play(value_18, itemPoint(a2, a3, "muzzle"))
                            continue
                        end
                        if value_18 == "sparkle" then
                            ViewFx_upv_1.Play(((a3.id ~= "healing_tonic") and "sparkle") or "gold", itemPoint(a2, a3, "tip"))
                            continue
                        end
                        if value_18 ~= "crumbs" or a3.id ~= "healing_tonic" then
                            if value_18 == "knock" then
                                local Position_1 = itemPoint(a2, a3, "tip").Position
                                ViewFx_upv_1.Play("flare", CFrame.new(0, Position_1.Y, Position_1.Z))
                                continue
                            end
                            if value_18 ~= "beat" then
                                ViewFx_upv_1.Play(value_18, itemPoint(a2, a3, "tip"))
                                continue
                            end
                        end
                        ViewFx_upv_1.Play("crumbs", itemPoint(a2, a3, "tip"))
                        tbl_upv_15.bite = tbl_upv_15.bite + 1
                        if tbl_upv_15.bite % 2 == 1 then
                            ViewFx_upv_1.Play("gold", itemPoint(a2, a3, "tip"))
                            continue
                        end
                    end
                    local v146 = a2:PointToObjectSpace(a3.pan.WorldPosition)
                    ViewFx_upv_1.Play("click", CFrame.lookAt(v146, v146 + Vector3.new(0, 1, 0)))
                    continue
                else
                    if tbl_upv_15.sim then
                        continue
                    end
                    local v147, v148 = string.match(value_18, "^sfx:([^@]+)@?(.*)$")
                    local Play_2 = Sfx_upv_1.Play
                    v137 = v147 or (string.sub(value_18, 5))
                    local v149 = nil
                    if tonumber(v148) then
                        v136 = {}
                        v136.pitch = tonumber(v148)
                    else
                        v136 = nil
                    end
                    Play_2(v137, v149, v136)
                end
            else
                local v150 = tbl_upv_15.frame or (CFrame.identity)
                if a3.gripAtt then
                    v138 = a2:PointToObjectSpace(a3.gripAtt.WorldPosition)
                else
                    v138 = v150.Position
                end
                v135 = v138 + v150.LookVector * (((a3.cfg.stock ~= nil) and (0.288 - a3.brace)) or (a3.cfg.len * 0.5))
                if a3.cfg.stock == nil or not (tbl_upv_15.arrowTip) or not (u26) then
                    ViewFx_upv_1.Play("glint", CFrame.lookAt(v135, v135 + v150.LookVector))
                    continue
                end
                if u26.Parent then
                    v135 = tbl_upv_15.arrowTip
                end
                ViewFx_upv_1.Play("glint", CFrame.lookAt(v135, v135 + v150.LookVector))
            end
        end
        table.clear(fxQueue_1)
    end
    if a3.cfg.act == "gun" then
        ViewFx_upv_1.Track("muzzle", itemPoint(a2, a3, "barrel"))
    end
    local v151 = tbl_upv_26[a3.id] == true
    if v151 ~= tbl_upv_15.embers then
        tbl_upv_15.embers = v151
        ViewFx_upv_1.Play("embers", itemPoint(a2, a3, "tip"), {on = v151})
    end
    if v151 then
        ViewFx_upv_1.Track("embers", itemPoint(a2, a3, "tip"))
    end
    local v152 = ((a3.id ~= "smoke_bomb") and 0) or (((tbl_upv_15.wind) and 2) or 1)
    if v152 ~= tbl_upv_15.fuse then
        tbl_upv_15.fuse = v152
        local Play_3 = ViewFx_upv_1.Play
        local v153 = itemPoint(a2, a3, "tip")
        local tbl_28 = {on = 0, rate = 0}
        tbl_28.on = v152 > 0
        tbl_28.rate = v152 * 18
        Play_3("fuse", v153, tbl_28)
    end
    if not (v152 > 0) then
        return
    end
    ViewFx_upv_1.Track("fuse", itemPoint(a2, a3, "tip"))
end
local function drawStreak(a1, a2)
    --[[
      name: drawStreak
      line: 2229
      upvalues:
        tbl_upv_15 (copy, index: 1)
        tbl_upv_27 (copy, index: 2)
        ViewFx_upv_1 (copy, index: 3)
        BladeClips_upv_1 (copy, index: 4)
    ]]
    local clip_upv_1 = tbl_upv_15.clip
    local v154
    if clip_upv_1 then
        v154 = clip_upv_1.smear
    else
        v154 = nil
    end
    if tbl_upv_27[a2.kind] and clip_upv_1 and v154 and a2.tipCanon then
        local clipScale_upv_1 = tbl_upv_15.clipScale
        local v155 = tbl_upv_15.now - tbl_upv_15.clipT0
        if not (v155 < v154[1] * clipScale_upv_1) and not ((v154[2] * clipScale_upv_1) + 0.035 < v155) then
            local u27 = tbl_upv_15.layerPos + Vector3.new(0, 0, tbl_upv_15.wallPush)
            local layerRot_1 = tbl_upv_15.layerRot
            local u28 = CFrame.fromEulerAnglesYXZ(layerRot_1.X, layerRot_1.Y, layerRot_1.Z)
            local leftClip_upv_1 = clip_upv_1.leftClip
            local u29 = (clip_upv_1.smearLeft == true) and ((a2.leftFist ~= nil) and (leftClip_upv_1 ~= nil))
            local v156 = math.min(v155, v154[2] * clipScale_upv_1)
            local v157 = math.max(v154[1] * clipScale_upv_1, v155 - 0.035)
            local Streak_1 = ViewFx_upv_1.Streak
            local function tipAt_1(a3)
                --[[
                  name: tipAt
                  line: 2246
                  upvalues:
                    u29 (copy, index: 1)
                    BladeClips_upv_1 (copy, index: 2)
                    leftClip_upv_1 (copy, index: 3)
                    tbl_upv_15 (copy, index: 4)
                    clipScale_upv_1 (copy, index: 5)
                    u27 (copy, index: 6)
                    a2 (copy, index: 7)
                    a1 (copy, index: 8)
                    u28 (copy, index: 9)
                    clip_upv_1 (copy, index: 10)
                ]]
                if u29 then
                    local v158, v159, v160, v161, v162, v163, v164, v165, v166, v167, v168, v169 = BladeClips_upv_1.Eval(leftClip_upv_1, tbl_upv_15.leftFrom, a3, clipScale_upv_1, tbl_upv_15.restFrame, tbl_upv_15.leftFromVel):GetComponents()
                    local v170 = CFrame.new(-v158, v159, v160, v161, -v162, -v163, -v164, v165, v166, -v167, v168, v169)
                    local v171 = v170.Position + u27
                    local tipCanon_1 = a2.tipCanon
                    return Vector3.new(v171.X, v171.Y, v171.Z * a1) + (u28 * v170.Rotation):VectorToWorldSpace(Vector3.new(-tipCanon_1.X, tipCanon_1.Y, tipCanon_1.Z))
                else
                    local v172 = BladeClips_upv_1.Eval(clip_upv_1, tbl_upv_15.clipFrom, a3, clipScale_upv_1, tbl_upv_15.restFrame, tbl_upv_15.clipFromVel)
                    local v173 = v172.Position + u27
                    return Vector3.new(v173.X, v173.Y, v173.Z * a1) + (u28 * v172.Rotation):VectorToWorldSpace(a2.tipCanon)
                end
            end
            local v174 = tipAt_1(v157)
            local v175 = tipAt_1(v156)
            Streak_1(v174, v175, ((v154[2] * clipScale_upv_1 < v155) and (1 - (v155 - (v154[2] * clipScale_upv_1)) / 0.035)) or 1, ((a2.kind == "Gauntlets") and (a2.cfg.len * 0.2)) or (((a2.kind == "Hatchets") and (a2.cfg.len * 0.45)) or nil))
            return
        end
        ViewFx_upv_1.Streak(nil, nil)
        return
    end
    ViewFx_upv_1.Streak(nil, nil)
end
local function drawBlade(a1, a2, a3, a4)
    --[[
      name: drawBlade
      line: 1934
      upvalues:
        BladeSmear_upv_1 (copy, index: 1)
        tbl_upv_15 (copy, index: 2)
        tbl_upv_2 (copy, index: 3)
        BladeClips_upv_1 (copy, index: 4)
        tbl_upv_19 (copy, index: 5)
        tbl_upv_20 (copy, index: 6)
        tbl_upv_21 (copy, index: 7)
        tbl_upv_16 (copy, index: 8)
        tbl_upv_17 (copy, index: 9)
        tbl_upv_18 (copy, index: 10)
    ]]
    BladeSmear_upv_1.Follow(a2)
    local frame_3 = tbl_upv_15.frame
    if tbl_upv_15.spark then
        tbl_upv_15.spark = false
        if frame_3 then
            BladeSmear_upv_1.Spark(a1, a2, Vector3.new(frame_3.X, frame_3.Y, frame_3.Z * a3) + (frame_3.UpVector * (a4.bladeLen * 0.55)))
        end
    end
    local clip_2 = tbl_upv_15.clip
    local v176
    if clip_2 then
        v176 = clip_2.smear
    else
        v176 = nil
    end
    if clip_2 and v176 then
        local clipScale_2 = tbl_upv_15.clipScale
        local v177 = tbl_upv_15.now - tbl_upv_15.clipT0
        local v178 = v176[2] * clipScale_2
        local v179 = tbl_upv_2.smearLen * clipScale_2
        local v180 = math.min(v177, v178)
        local v181 = math.max(v176[1] * clipScale_2, v177 - v179)
        if v180 - v181 < 0.004 then
            BladeSmear_upv_1.Hide()
        else
            local v182 = ((not (v178 < v177)) and 1) or (math.clamp(1 - ((v177 - v178) / v179), 0, 1))
            local SEGMENTS_1 = BladeSmear_upv_1.SEGMENTS
            local v183 = tbl_upv_15.layerPos + Vector3.new(0, 0, tbl_upv_15.wallPush)
            local layerRot_2 = tbl_upv_15.layerRot
            local v184 = CFrame.fromEulerAnglesYXZ(layerRot_2.X, layerRot_2.Y, layerRot_2.Z)
            local v185 = tbl_upv_2.smearAlong[a4.kind]
            for n_3 = 0, SEGMENTS_1 do
                v177 = BladeClips_upv_1.Eval(clip_2, tbl_upv_15.clipFrom, v181 + (((v180 - v181) * n_3) / SEGMENTS_1), clipScale_2, tbl_upv_15.restFrame, tbl_upv_15.clipFromVel)
                local v186 = v177.Position + v183
                tbl_upv_19[n_3 + 1] = Vector3.new(v186.X, v186.Y, v186.Z * a3)
                if v185 then
                    local v187 = n_3 + 1
                    tbl_upv_19[v187] = tbl_upv_19[v187] + (v184 * v177.UpVector * (a4.bladeLen * v185.root))
                    tbl_upv_20[n_3 + 1] = v184 * v177.LookVector
                else
                    tbl_upv_20[n_3 + 1] = v184 * v177.UpVector
                end
            end
            for key_5, value_19 in tbl_upv_2.smearItem[a4.id] or (tbl_upv_2.smear[a4.kind] or (tbl_upv_2.smear.Sword)) do
                if BladeSmear_upv_1.LAYERS < key_5 then
                    break
                end
                local v188 = a4.bladeLen * value_19.width * (clip_2.smearWidth or 1)
                for n_4 = 1, SEGMENTS_1 + 1 do
                    tbl_upv_21[n_4] = tbl_upv_19[n_4] + (tbl_upv_20[n_4] * (a4.bladeLen * value_19.at))
                end
                for n_5 = 1, SEGMENTS_1 + 1 do
                    local v189 = tbl_upv_21[math.min(SEGMENTS_1 + 1, n_5 + 1)] - tbl_upv_21[math.max(1, n_5 - 1)]
                    local v190 = tbl_upv_20[n_5]
                    v183 = v189 - v190 * v189:Dot(v190)
                    if v183.Magnitude < 1e-05 then
                        v183 = v190:Cross(Vector3.new(0, 0, 1))
                    end
                    tbl_upv_16[n_5] = CFrame.fromMatrix(tbl_upv_21[n_5], v183.Unit, v190)
                    local v191 = (n_5 - 1) / SEGMENTS_1
                    tbl_upv_17[n_5] = v188 * (0.3 + (0.7 * v191))
                    tbl_upv_18[n_5] = 1 - (((1 - value_19.alpha) * (v191 ^ 1.4)) * v182)
                end
                BladeSmear_upv_1.Draw(a1, a2, key_5, tbl_upv_16, tbl_upv_17, tbl_upv_18, value_19.color)
            end
        end
    else
        BladeSmear_upv_1.Hide()
    end
end
local function place(a1, a2, a3, a4, a5, a6)
    --[[
      name: place
      line: 2366
      upvalues:
        u23 (ref,  index: 1)
        BladeSmear_upv_1 (copy, index: 2)
        tbl_upv_25 (copy, index: 3)
        u26 (ref,  index: 4)
        tbl_upv_15 (copy, index: 5)
        ViewFx_upv_1 (copy, index: 6)
        tbl_upv_2 (copy, index: 7)
        u20 (copy, index: 8)
        u21 (copy, index: 9)
        drawBlade (copy, index: 10)
        drawArrow (copy, index: 11)
        viewEffects (copy, index: 12)
        drawStreak (copy, index: 13)
    ]]
    local v192
    if a6 then
        v192 = a6.model
    else
        v192 = nil
    end
    if v192 ~= u23 then
        if u23 then
            u23.Parent = nil
        end
        u23 = v192
    end
    if a6 then
        local v193, v194, v195, v196, v197, v198 = nil, nil, nil, nil, nil, nil
        if v192 then
            local v199 = math.tan((tbl_upv_2.fovRef * 0.5) * 0.017453292519943295) / math.tan((math.clamp(a3, 20, 110) * 0.5) * 0.017453292519943295)
            local frame_4 = tbl_upv_15.frame
            local v200 = (frame_4 and (a2 * CFrame.new(frame_4.X, frame_4.Y, frame_4.Z * v199) * frame_4.Rotation * a6.norm)) or ((a2 * CFrame.new(a4.X, a4.Y, a4.Z * v199)) * CFrame.fromEulerAnglesYXZ(a5.X, a5.Y, a5.Z) * a6.style)
            v192:PivotTo((v200 * a6.gripInv) * a6.pivotRel)
            v193 = a6.leftFist
            local v201 = nil
            if v193 then
                v201 = tbl_upv_15.leftFrame
                if v201 then
                    local v202 = a2 * CFrame.new(v201.X, v201.Y, v201.Z * v199)
                    local v203, v204 = nil, nil
                    local v205, v206, v203, v207, v208, v209, v210, v211, v212, v213, v214, v204 = a6.norm:GetComponents()
                    v193.part.CFrame = (v202 * v201.Rotation) * CFrame.new(-v205, v206, v203, v207, -v208, -v209, -v210, v211, v212, -v213, v214, v204) * v193.rel
                    v193.part.LocalTransparencyModifier = 0
                else
                    v193.part.LocalTransparencyModifier = 1
                end
            end
            v194 = a6.inlay
            if v194 then
                local v215 = ((not (tbl_upv_15.draw)) and 0) or (((tbl_upv_15.drawFull) and 3) or (((tbl_upv_15.drawHalf) and 2) or 1))
                if v215 ~= tbl_upv_15.inlayLvl then
                    tbl_upv_15.inlayFrom = v194.part.Color
                    tbl_upv_15.inlayLvl = v215
                    tbl_upv_15.inlayT0 = tbl_upv_15.now
                end
                v194.part.Color = tbl_upv_15.inlayFrom:Lerp(({[0] = v194.rest, Color3.fromRGB(60, 90, 92), Color3.fromRGB(95, 150, 152), Color3.fromRGB(140, 205, 206)})[v215], math.clamp((tbl_upv_15.now - tbl_upv_15.inlayT0) / 0.05, 0, 1))
            end
            v195 = a6.strip
            if v195 then
                local stripV_1 = tbl_upv_15.stripV
                v195.part.Size = Vector3.new(v195.size.X, v195.size.Y * stripV_1, v195.size.Z)
                v195.part.CFrame = (a6.handle.CFrame * v195.rest) * CFrame.new(0, (-v195.size.Y * (stripV_1 - 1)) / 2, 0)
            end
            if a6.stone then
                local v216 = (tbl_upv_15.looseAt ~= nil) and ((tbl_upv_15.looseAt <= tbl_upv_15.now) and (tbl_upv_15.now < tbl_upv_15.looseAt + 0.38))
                local stone_1 = a6.stone
                local v217
                if v216 then
                    v217 = 1
                else
                    v217 = 0
                end
                stone_1.LocalTransparencyModifier = v217
            end
            v196 = a6.hammer
            if v196 then
                local v218 = math.clamp(u20.value, -0.2, 1.25)
                v196.part.CFrame = ((a6.handle.CFrame * CFrame.new(v196.pivot)) * CFrame.fromAxisAngle(v196.axis, (v218 * v196.fired) * 0.017453292519943295)) * CFrame.new(-v196.pivot) * v196.rest
            end
            v197 = a6.frizzen
            if v197 then
                local v219 = math.clamp(u21.value, -0.1, 1.2)
                v197.part.CFrame = ((a6.handle.CFrame * CFrame.new(v197.pivot)) * CFrame.fromAxisAngle(v197.axis, (v219 * v197.fired) * 0.017453292519943295)) * CFrame.new(-v197.pivot) * v197.rest
            end
            v198 = a6.rod
            local v220 = nil
            if v198 then
                v220 = tbl_upv_15.rodV
                local CFrame_1 = a6.handle.CFrame
                if v220 <= 1.5 then
                    v198.part.CFrame = CFrame_1 * CFrame.new(v198.fwd * (math.min(v220, 1) * 1.3 * v198.len)) * v198.rest
                else
                    v198.part.CFrame = CFrame_1 * CFrame.fromMatrix(v198.muzzle + (v198.fwd * (((v220 - 2) * v198.len) - (v198.len * 0.5))), -v198.fwd, v198.up)
                end
            end
            if v192.Parent ~= a1 then
                v192.Parent = a1
            end
            if tbl_upv_2.smearItem[a6.id] or tbl_upv_2.smear[a6.kind] then
                drawBlade(a1, a2, v199, a6)
            else
                BladeSmear_upv_1.Hide()
            end
            drawArrow(a1, a2, v199, a6)
            viewEffects(a1, a2, a6)
            drawStreak(v199, a6)
            local v221 = nil
            if tbl_upv_15.leftVanishAt and a6.leftFist and tbl_upv_15.leftFrame then
                v221 = a6.leftFist.part.Position
            elseif u26 and u26.Parent then
                if a6.kind ~= "Bow" then
                    if a6.kind ~= "Sling" and a6.id ~= "bolas" or not (a6.tipAtt) then
                        if a6.muzzle then
                            v221 = a6.muzzle.WorldPosition
                        else
                            v221 = v192:GetBoundingBox().Position
                        end
                        local v222 = os.clock()
                        tbl_upv_15.release = v221
                        tbl_upv_15.releaseT = v222
                        return
                    end
                    v221 = a6.tipAtt.WorldPosition
                else
                    local v223, v224 = u26:GetBoundingBox()
                    local Position_2 = v223.Position
                    local v225
                    if tbl_upv_15.frame then
                        v225 = a2:VectorToWorldSpace(tbl_upv_15.frame.LookVector)
                    else
                        v225 = v223.LookVector
                    end
                    v221 = Position_2 + v225 * (v224.Z * 0.5)
                end
            else
                if a6.kind ~= "Sling" and a6.id ~= "bolas" or not (a6.tipAtt) then
                    if a6.muzzle then
                        v221 = a6.muzzle.WorldPosition
                    else
                        v221 = v192:GetBoundingBox().Position
                    end
                    local v222 = os.clock()
                    tbl_upv_15.release = v221
                    tbl_upv_15.releaseT = v222
                    return
                end
                v221 = a6.tipAtt.WorldPosition
            end
            local v222 = os.clock()
            tbl_upv_15.release = v221
            tbl_upv_15.releaseT = v222
            return
        end
    end
    BladeSmear_upv_1.Hide()
    for _, value_20 in tbl_upv_25 do
        value_20.Parent = nil
    end
    if u26 then
        u26.Parent = nil
        u26 = nil
    end
    if tbl_upv_15.embers then
        tbl_upv_15.embers = false
        ViewFx_upv_1.Play("embers", CFrame.identity, {on = false})
    end
    if not (tbl_upv_15.fuse > 0) then
        return
    end
    tbl_upv_15.fuse = 0
    ViewFx_upv_1.Play("fuse", CFrame.identity, {on = false})
end
local function hide()
    --[[
      name: hide
      line: 2489
      upvalues:
        u23 (ref,  index: 1)
        tbl_upv_25 (copy, index: 2)
        u26 (ref,  index: 3)
        BladeSmear_upv_1 (copy, index: 4)
        ViewFx_upv_1 (copy, index: 5)
        tbl_upv_15 (copy, index: 6)
    ]]
    if u23 then
        u23.Parent = nil
        u23 = nil
    end
    for _, value_21 in tbl_upv_25 do
        value_21.Parent = nil
    end
    if u26 then
        u26.Parent = nil
        u26 = nil
    end
    BladeSmear_upv_1.Hide()
    ViewFx_upv_1.Hide()
    tbl_upv_15.embers = false
    tbl_upv_15.fuse = 0
end
local u30 = false
local u31 = false
local UserInputService_upv_1 = game:GetService("UserInputService")
local function touchPreferred()
    --[[
      name: touchPreferred
      line: 2511
    ]]
    local success_1, v226 = pcall(function() end)
    local v227 = success_1 and ((typeof(v226) == "EnumItem") and (v226.Name == "Touch"))
    return v227
end
local function drawnRootY(a1)
    --[[
      name: drawnRootY
      line: 2518
    ]]
    local success_2, v228 = pcall(function() end)
    if success_2 and typeof(v228) == "CFrame" then
        return v228.Position.Y
    end
    return a1.Position.Y
end
local function liveInput(a1)
    --[[
      name: liveInput
      line: 2528
      upvalues:
        Workspace_upv_1 (copy, index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
        Camera_upv_1 (copy, index: 3)
        Combat_upv_1 (copy, index: 4)
        u25 (ref,  index: 5)
        u24 (copy, index: 6)
    ]]
    local CurrentCamera_1 = Workspace_upv_1.CurrentCamera
    local Character_1 = LocalPlayer_upv_1.Character
    local _ = Character_1 and (Character_1:FindFirstChild("HumanoidRootPart"))
    local v229 = Character_1 and (Character_1:FindFirstChildOfClass("Humanoid"))
    if not CurrentCamera_1 or not Character_1 or not Character_1 or not Character_1:IsA("BasePart") or not v229 then
        return nil, CurrentCamera_1
    end
    local v230 = Camera_upv_1.InFirstPerson and (Camera_upv_1.InFirstPerson() == true)
    local v231 = Character_1:FindFirstChildOfClass("Tool")
    local v232 = v231 and (v231:GetAttribute("WeaponId"))
    local v233 = nil
    if type(v232) == "string" then
        local v234 = v231 and (v231:GetAttribute("Kind"))
        if type(v234) ~= "string" then
            v233 = Combat_upv_1.Kind(v231)
        else
            v233 = v234
        end
    end
    local v235 = nil
    if v231 and (tonumber(v231:GetAttribute("MaxCharges")) or 0) > 0 then
        local v234 = tonumber(v231:GetAttribute("Charges"))
    else
        local v234 = v235
    end
    local CFrame_2 = CurrentCamera_1.CFrame
    local v236 = nil
    local v237 = nil
    if v230 then
        if u25 ~= Character_1 then
            u25 = Character_1
            local tbl_29 = {Character_1}
            for v244, value_22 in {"FX", "Projectiles"} do
                local v238 = Workspace_upv_1:FindFirstChild(value_22)
                if v238 then
                    table.insert(tbl_29, v238)
                end
            end
            u24.FilterDescendantsInstances = tbl_29
        end
        v237 = Workspace_upv_1:Spherecast(CFrame_2.Position, 0.15, CFrame_2.LookVector * 1.8, u24)
        if v237 then
            v236 = v237.Distance
        else
            v236 = nil
        end
    end
    local v239 = 0
    local v240 = 0
    if Camera_upv_1.GetViewBob then
        Camera_upv_1.GetViewBob()
    end
    local tbl_30 = {visible = 0, sliding = 0, charges = 0, bobAmount = 0, cam = 0, id = 0, grounded = 0, vel = 0, touch = 0, aiming = 0, rootY = 0, fov = 0, wall = 0, kind = 0, offHandOut = 0, bobPhase = 0}
    tbl_30.dt = a1
    tbl_30.now = os.clock()
    local v241 = v230 and ((Character_1.Health > 0) and (LocalPlayer_upv_1:GetAttribute("ReplayPlaying") ~= true))
    tbl_30.visible = v241
    if type(v231) ~= "string" then
        v241 = nil
    else
        v241 = v231
    end
    tbl_30.id = v241
    tbl_30.kind = v233
    tbl_30.charges = nil
    tbl_30.cam = CFrame_2
    tbl_30.fov = CurrentCamera_1.FieldOfView
    tbl_30.grounded = Character_1.FloorMaterial ~= Enum.Material.Air
    local success_3, v242 = pcall(
        function()
            --[[
              line: 2519
              upvalues:
                Camera_upv_1 (copy, index: 1)
            ]]
            if Camera_upv_1.GetDrawnRoot then
                return (Camera_upv_1.GetDrawnRoot())
            end
            return nil
        end
    )
    if (success_3) and typeof(v242) == "CFrame" then
        v241 = v242.Position.Y
    else
        v241 = Character_1.Position.Y
    end
    tbl_30.rootY = v241
    v241 = Character_1:GetAttribute("Sliding") == true
    tbl_30.sliding = v241
    v241 = Camera_upv_1.IsAiming and (Camera_upv_1.IsAiming() == true)
    tbl_30.aiming = v241
    if v231 then
        v241 = v231:GetAttribute("Thrown") == true
    else
        v241 = nil
    end
    tbl_30.offHandOut = v241
    tbl_30.bobPhase = v239
    tbl_30.bobAmount = v240
    tbl_30.wall = v236
    local success_4, v243 = pcall(function() end)
    v241 = success_4 and ((typeof(v243) == "EnumItem") and (v243.Name == "Touch"))
    tbl_30.touch = v241
    tbl_30.vel = Character_1.AssemblyLinearVelocity
    return tbl_30, CurrentCamera_1
end
local u32 = 0
local u33 = 0
local u34 = 0
local function step(a1)
    --[[
      name: step
      line: 1303
      upvalues:
        tbl_upv_15 (copy, index: 1)
        tbl_upv_3 (copy, index: 2)
        tbl_upv_2 (copy, index: 3)
        prepare (copy, index: 4)
        u19 (copy, index: 5)
        u22 (copy, index: 6)
        ViewFx_upv_1 (copy, index: 7)
        u20 (copy, index: 8)
        u21 (copy, index: 9)
        u18 (copy, index: 10)
        u12 (copy, index: 11)
        u13 (copy, index: 12)
        u16 (copy, index: 13)
        u17 (copy, index: 14)
        u8 (copy, index: 15)
        u9 (copy, index: 16)
        u10 (copy, index: 17)
        u11 (copy, index: 18)
        u14 (copy, index: 19)
        u15 (copy, index: 20)
        tbl_upv_5 (copy, index: 21)
        evalKeys (copy, index: 22)
        startClip (copy, index: 23)
        BladeClips_upv_1 (copy, index: 24)
        evalTrack (copy, index: 25)
    ]]
    local v244 = math.clamp(a1.dt, 0.004166666666666667, 0.1)
    local now_1 = a1.now
    tbl_upv_15.now = now_1
    local v245
    if a1.visible and a1.id and a1.kind and tbl_upv_3[a1.kind] then
        v245 = a1.id
    else
        v245 = nil
    end
    if v245 ~= tbl_upv_15.wantId then
        tbl_upv_15.wantId = v245
        if tbl_upv_15.shown and tbl_upv_15.shown.id ~= v245 and not (tbl_upv_15.dropAt) then
            tbl_upv_15.dropAt = now_1
        end
    end
    if tbl_upv_15.dropAt and tbl_upv_15.shown and tbl_upv_15.shown.id == tbl_upv_15.wantId then
        tbl_upv_15.dropAt = nil
    end
    local v246
    if tbl_upv_15.shown then
        v246 = tbl_upv_15.shown.id
    else
        v246 = nil
    end
    if v246 ~= tbl_upv_15.wantId and (tbl_upv_15.shown == nil or tbl_upv_15.dropAt ~= nil and tbl_upv_2.dropTime <= now_1 - tbl_upv_15.dropAt) then
        tbl_upv_15.dropAt = nil
        local v247
        if tbl_upv_15.wantId then
            v247 = prepare(tbl_upv_15.wantId, a1.kind)
        else
            v247 = nil
        end
        tbl_upv_15.shown = v247
        tbl_upv_15.action = nil
        tbl_upv_15.clip = nil
        tbl_upv_15.lastFrame = nil
        tbl_upv_15.rawVel = nil
        tbl_upv_15.clipName = nil
        u19:Snap(Vector3.new(0, 0, 0))
        u22:Snap(Vector3.new(0, 0, 0))
        tbl_upv_15.block = false
        tbl_upv_15.parry = false
        tbl_upv_15.charge = false
        tbl_upv_15.draw = false
        tbl_upv_15.wind = false
        tbl_upv_15.use = false
        tbl_upv_15.reload = false
        tbl_upv_15.hiddenUntil = 0
        tbl_upv_15.vanishAt = nil
        tbl_upv_15.drawHold = 0
        tbl_upv_15.windHold = 0
        tbl_upv_15.looseAt = nil
        tbl_upv_15.nocked = false
        tbl_upv_15.nockT0 = -10
        tbl_upv_15.stringV = 0
        tbl_upv_15.stringT0 = -10
        table.clear(tbl_upv_15.fxQueue)
        if tbl_upv_15.embers then
            tbl_upv_15.embers = false
            ViewFx_upv_1.Play("embers", CFrame.identity, {on = false})
        end
        if tbl_upv_15.fuse > 0 then
            tbl_upv_15.fuse = 0
            ViewFx_upv_1.Play("fuse", CFrame.identity, {on = false})
        end
        tbl_upv_15.boltIn = true
        tbl_upv_15.boltT0 = -10
        tbl_upv_15.hammerTarget = 0.5
        u20:Snap(0.5)
        tbl_upv_15.frizzenTarget = 0
        u21:Snap(0)
        if tbl_upv_15.shown then
            if tbl_upv_15.shown.drawFrom and tbl_upv_15.shown.clips and tbl_upv_15.shown.clips.draw then
                u18:Snap(0)
                tbl_upv_15.pendingDraw = "draw"
            else
                u18.value = -1
                u18.velocity = 0
                u18.target = 0
            end
        end
    end
    local shown_2 = tbl_upv_15.shown
    if not shown_2 then
        return Vector3.new(0, 0, 0), Vector3.new(0, 0, 0), nil
    end
    local v248 = shown_2.cfg
    if tbl_upv_15.lastRootY and v244 > 0 then
        local v249 = (a1.rootY - tbl_upv_15.lastRootY) / v244
        local v250 = ((math.abs(v249) > 150) and 0) or v249
        local v251 = tbl_upv_15
        v251.vy = v251.vy + ((v250 - tbl_upv_15.vy) * (1 - math.exp(v244 * -14)))
    end
    tbl_upv_15.lastRootY = a1.rootY
    if a1.grounded then
        local v252 = nil
        if not (tbl_upv_15.grounded) then
            v252 = -tbl_upv_15.minVy
            if v252 > 6 then
                u12:Impulse(-math.min(v252 * tbl_upv_2.landK, tbl_upv_2.landMax))
            end
            tbl_upv_15.minVy = 0
        end
    else
        tbl_upv_15.minVy = math.min(tbl_upv_15.minVy, tbl_upv_15.vy)
    end
    tbl_upv_15.grounded = a1.grounded
    local LookVector_2 = a1.cam.LookVector
    local v253 = math.atan2(-LookVector_2.X, -LookVector_2.Z)
    local v254 = math.asin(math.clamp(LookVector_2.Y, -1, 1))
    local v255 = nil
    if tbl_upv_15.lastYaw then
        v255 = ((v253 - tbl_upv_15.lastYaw) + math.pi) % math.tau - math.pi
        local v256 = v254 - tbl_upv_15.lastPitch
        if math.abs(v255) < 1.2 and math.abs(v256) < 1.2 then
            u13.value = u13.value + (Vector3.new(-v256, -v255, -v255 * 0.5) * tbl_upv_2.swayK)
        end
    end
    tbl_upv_15.lastYaw = v253
    tbl_upv_15.lastPitch = v254
    v254 = a1.aiming and (v248.aimPos ~= nil)
    local v257
    if not (a1.touch) or v254 then
        v257 = Vector3.new(0, 0, 0)
    else
        v257 = tbl_upv_2.touchHand
    end
    v253 = tbl_upv_2.hand + v248.pos + v257
    local v258 = Vector3.new(0, 0, 0)
    if v254 then
        v253 = v253 + v248.aimPos
        v258 = v258 + (v248.aimRot or Vector3.new(0, 0, 0)) * 0.017453292519943295
    end
    if tbl_upv_15.block and shown_2.blockP and shown_2.blockR then
        v253 = v253 + shown_2.blockP
        v258 = v258 + shown_2.blockR
    elseif tbl_upv_15.block and v248.block then
        v253 = v253 + (v248.block[1] + Vector3.new(0, math.sin(now_1 * 3) * 0.004, 0))
        v258 = v258 + ((v248.block[2] * 0.017453292519943295) + Vector3.new(0, 0, (math.sin(now_1 * 2.3) * 0.5) * 0.017453292519943295))
    end
    v254 = 0
    local v259 = 0
    if tbl_upv_15.charge and v248.charge then
        local v260 = math.clamp((now_1 - tbl_upv_15.chargeT0) / tbl_upv_15.chargeTime, 0, 1)
        local v261 = math.clamp(v260, 0, 1)
        local v262 = ((v261 * v261) * (3 - (v261 * 2))) * 0.15 + 0.85
        if v248.chargeIn then
            local v263 = math.clamp((now_1 - tbl_upv_15.chargeT0) / v248.chargeIn, 0, 1) - 1
            v262 = v262 * (((((v263 * 3.6) * v263) * v263) + 1) + ((v263 * 2.6) * v263))
        end
        v253 = v253 + v248.charge[1] * v262
        local v264 = v258 + (v248.charge[2] * 0.017453292519943295) * v262
        v254 = v254 + ((v260 * 0.0028) + 0.0012)
        if v260 >= 1 and not tbl_upv_15.chargeFull then
            tbl_upv_15.chargeFull = true
            u16:Impulse(Vector3.new(0, 1.5, 1.2000000476837158))
            table.insert(tbl_upv_15.fxQueue, "headglint")
        end
        v258 = v264
    end
    local v265 = now_1 - (tbl_upv_15.drawHold - 0.16)
    local v266 = not tbl_upv_15.draw
    if v266 then
        v266 = false
        if tbl_upv_15.drawHold > 0 then
            if v265 < 0.36 then
                local _ = true
            else
                local _ = false
            end
        end
    end
    if (tbl_upv_15.draw or v266) and (v248.draw or shown_2.drawP) then
        local v267 = ((not (tbl_upv_15.draw)) and 1) or (math.clamp((now_1 - tbl_upv_15.drawT0) / tbl_upv_15.drawTime, 0, 1))
        local v268
        if tbl_upv_15.draw then
            local v269 = math.clamp((now_1 - tbl_upv_15.drawT0) / 0.14, 0, 1)
            local v270 = math.clamp(v267, 0, 1)
            v268 = ((v269 * v269) * (3 - (v269 * 2))) * 0.7 + ((v270 * v270) * (3 - (v270 * 2))) * 0.3
        else
            local v271 = math.clamp((v265 - 0.16) / 0.2, 0, 1)
            v268 = 1 - (v271 * v271) * (3 - (v271 * 2))
        end
        if (shown_2.drawP) and (shown_2.drawR) then
            v253 = v253 + shown_2.drawP * v268
            v258 = v258 + shown_2.drawR * v268
        elseif v248.draw then
            v253 = v253 + v248.draw[1] * v268
            v258 = v258 + v248.draw[2] * 0.017453292519943295 * v268
        end
        if tbl_upv_15.draw then
            v259 = ((v267 >= 1) and (math.clamp(((now_1 - tbl_upv_15.drawT0) - tbl_upv_15.drawTime) / 0.5, 0.3, 1) * 7e-04)) or v259
            if (shown_2.kind == "Bow") and (v248.stock == nil) and v267 >= 0.5 and not (tbl_upv_15.drawHalf) then
                tbl_upv_15.drawHalf = true
                u16:Impulse(Vector3.new(0, -1.100000023841858, 0.8999999761581421))
                u17:Impulse(Vector3.new(-3.4906585216522217, 0, 0))
                table.insert(tbl_upv_15.fxQueue, "sfx:Gun_Cock")
            end
            if v267 >= 1 and not tbl_upv_15.drawFull then
                tbl_upv_15.drawFull = true
                u16:Impulse(Vector3.new(0, -0.800000011920929, 0.6000000238418579))
                u17:Impulse(Vector3.new(-2.268928050994873, 0, 0))
                table.insert(tbl_upv_15.fxQueue, "fullglint")
            end
        end
    end
    if (tbl_upv_15.wind) and (v248.windup) then
        local v272 = math.clamp((now_1 - tbl_upv_15.windT0) / tbl_upv_15.windTime, 0, 1)
        local v273 = math.clamp((now_1 - tbl_upv_15.windT0) / 0.12, 0, 1)
        local v274 = math.clamp(v272, 0, 1)
        local v275 = ((v273 * v273) * (3 - (v273 * 2))) * 0.75 + ((v274 * v274) * (3 - (v274 * 2))) * 0.25
        v253 = v253 + v248.windup[1] * v275
        local v276 = v258 + (v248.windup[2] * 0.017453292519943295) * v275
        v254 = v254 + ((v272 * 0.003) + 0.001)
        if shown_2.id == "harpoon" and v272 >= 0.5 and not (tbl_upv_15.windHalf) then
            tbl_upv_15.windHalf = true
            u16:Impulse(Vector3.new(0, -0.5, 0.4000000059604645))
            table.insert(tbl_upv_15.fxQueue, "glint")
            table.insert(tbl_upv_15.fxQueue, "sfx:Crossbow_Crank")
        end
        if v272 >= 1 and not tbl_upv_15.windFull then
            tbl_upv_15.windFull = true
            u16:Impulse(Vector3.new(0, -1.600000023841858, 1.2000000476837158))
            u17:Impulse(Vector3.new(-2.7925267219543457, 0, 0))
            table.insert(tbl_upv_15.fxQueue, "glint")
            table.insert(tbl_upv_15.fxQueue, ((shown_2.id == "harpoon") and "sfx:Crossbow_Ready") or (((shown_2.kind ~= "Bomb") and "sfx:Knife_Ready") or "sfx:Equip_Item"))
        end
        v258 = v276
    elseif now_1 < tbl_upv_15.windHold and v248.windup then
        v253 = v253 + v248.windup[1] * tbl_upv_15.windK
        v258 = v258 + v248.windup[2] * 0.017453292519943295 * tbl_upv_15.windK
    end
    local v277 = 0
    if tbl_upv_15.use and v248.use then
        v253 = v253 + v248.use[1]
        local v278 = v258 + v248.use[2] * 0.017453292519943295
        if now_1 - tbl_upv_15.useT0 > 0.15 and (not (shown_2.clips) or not (shown_2.clips.use_loop)) then
            v277 = 1
        end
        if tbl_upv_15.useTime + 0.3 < now_1 - tbl_upv_15.useT0 then
            tbl_upv_15.use = false
        end
        v258 = v278
    end
    local v279 = 0
    local vel_1
    if tbl_upv_15.reload then
        vel_1 = (now_1 - tbl_upv_15.reloadT0) / tbl_upv_15.reloadTime
        if vel_1 >= 1.15 then
            tbl_upv_15.reload = false
            v248 = v279
        else
            local v280 = math.clamp(vel_1 / 0.2, 0, 1)
            local v281 = math.clamp((vel_1 - 0.78) / 0.22, 0, 1)
            local v282 = (v280 * v280) * (3 - (v280 * 2)) * (1 - ((v281 * v281) * (3 - (v281 * 2))))
            v253 = v253 + Vector3.new(-0.03999999910593033, -0.10000000149011612, 0.019999999552965164) * v282
            local v283 = v258 + Vector3.new(0.48869219422340393, 0.41887903213500977, 0.593411922454834) * v282
            if vel_1 > 0.25 then
                v248 = vel_1 < 0.75 and 1 or v279
                v258 = v283
            else
                v258, v248 = v283, v279
            end
        end
    else
        v248 = v279
    end
    if a1.sliding then
        v253 = v253 + tbl_upv_2.slidePos
        v258 = v258 + tbl_upv_2.slideRot * 0.017453292519943295
    end
    local wall_1 = a1.wall
    if wall_1 and wall_1 < shown_2.wallDist then
        local v284 = math.clamp((shown_2.wallDist - wall_1) / math.max(shown_2.wallDist - tbl_upv_2.wallMin, 0.1), 0, 1)
        v253 = v253 + tbl_upv_2.wallPos * v284
        v258 = v258 + Vector3.new(shown_2.wallRot * v284, 0, 0)
    end
    local v285
    if (tbl_upv_15.useOutUntil) and (now_1 < tbl_upv_15.useOutUntil) then
        v285 = 3.2
    else
        v285 = tbl_upv_2.poseHz
    end
    u8.frequency = v285
    u9.frequency = u8.frequency
    u8.target = v253
    u9.target = v258
    u8:Update(v244)
    u9:Update(v244)
    local _ = math.clamp(-tbl_upv_15.vy * tbl_upv_2.airK, -tbl_upv_2.airMax, tbl_upv_2.airMax)
    local v286 = math.clamp(-tbl_upv_15.vy * tbl_upv_2.airTiltK, -tbl_upv_2.airTiltMax, tbl_upv_2.airTiltMax) * 0.017453292519943295
    if a1.grounded then
        vel_1, v286 = 0, 0
    end
    u10.target = vel_1
    u11.target = v286
    u10:Update(v244)
    u11:Update(v244)
    u12:Update(v244)
    u13:Update(v244)
    local value_23 = 0
    local value_24 = 0
    vel_1 = a1.vel
    local v287 = nil
    if vel_1 then
        local RightVector_1 = a1.cam.RightVector
        local LookVector_3 = a1.cam.LookVector
        v287 = Vector3.new(RightVector_1.X, 0, RightVector_1.Z)
        local v288 = Vector3.new(LookVector_3.X, 0, LookVector_3.Z)
        if v287.Magnitude > 0.001 and v288.Magnitude > 0.001 then
            value_23, value_24 = math.clamp(vel_1:Dot(v287.Unit) / tbl_upv_2.mvRun, -tbl_upv_2.mvMax, tbl_upv_2.mvMax), math.clamp(vel_1:Dot(v288.Unit) / tbl_upv_2.mvRun, -tbl_upv_2.mvMax, tbl_upv_2.mvMax)
        end
    end
    vel_1 = (((not (a1.aiming)) and 1) or (tbl_upv_2.mvAimed)) * tbl_upv_2.mvRun
    u14.target = Vector3.new(-value_23 * tbl_upv_2.mvX, 0, math.abs(value_24) * tbl_upv_2.mvZ) * vel_1
    u15.target = (Vector3.new(-value_24 * tbl_upv_2.mvPitch, value_23 * tbl_upv_2.mvYaw, -value_23 * tbl_upv_2.mvRoll) * vel_1) * 0.017453292519943295
    u14:Update(v244)
    u15:Update(v244)
    v258 = u13.value
    v253 = tbl_upv_2.swayMax * 0.017453292519943295
    if v253 < v258.Magnitude then
        u13.value = v258.Unit * v253
    end
    u16:Update(v244)
    u17:Update(v244)
    u18:Update(v244)
    u20.target = tbl_upv_15.hammerTarget
    u20:Update(v244)
    u21.target = tbl_upv_15.frizzenTarget
    u21:Update(v244)
    value_23 = (now_1 * tbl_upv_2.idleHz) * 2 * math.pi
    v258 = u8.value + Vector3.new((math.sin(value_23 * 0.5) * tbl_upv_2.idlePos) * 0.6, math.sin(value_23) * tbl_upv_2.idlePos, 0)
    v253 = u9.value + Vector3.new(math.sin(value_23 + 0.6) * tbl_upv_2.idleRot, 0, (math.sin(value_23 * 0.5) * tbl_upv_2.idleRot) * 0.5) * 0.017453292519943295
    local bobAmount_1 = a1.bobAmount
    if bobAmount_1 > 0 then
        v285 = a1.bobPhase
        local v289 = math.abs(math.cos(v285)) - 0.64
        v258, v253 = v258 + Vector3.new((math.sin(v285) * tbl_upv_2.bobX) * bobAmount_1, (-v289 * tbl_upv_2.bobY) * bobAmount_1, 0), v253 + Vector3.new((v289 * tbl_upv_2.bobPitch) * bobAmount_1, 0, (math.sin(v285) * tbl_upv_2.bobRoll) * bobAmount_1) * 0.017453292519943295
    end
    local v290 = v258 + Vector3.new(0, u10.value + (u12.value * tbl_upv_2.landDist), 0)
    local v291 = v253 + Vector3.new(u11.value + (u12.value * 0.12), 0, 0)
    value_23 = u13.value
    local v292 = v290 + Vector3.new(-value_23.Y * tbl_upv_2.swayShift, value_23.X * tbl_upv_2.swayShift, 0) + u14.value + u16.value
    local v293 = (v291 + value_23) + u15.value + u17.value
    if v254 > 0 then
        v292 = v292 + Vector3.new(math.sin(now_1 * 84) * v254, math.sin((now_1 * 71) + 1) * v254, 0)
    end
    v258 = ((v259 > 0) and (v292 + Vector3.new(math.sin(now_1 * 33) * v259, math.sin((now_1 * 27) + 1) * v259, 0))) or v292
    if a1.sliding then
        local slideShake_1 = tbl_upv_2.slideShake
        local v294 = v258 + Vector3.new(math.sin(now_1 * 53) * slideShake_1, math.sin((now_1 * 71) + 2) * slideShake_1, 0)
        v253, v258 = v293 + Vector3.new(0, 0, (math.sin(now_1 * 39) * 1.6) * 0.017453292519943295), v294
    else
        v253 = v293
    end
    if v248 > 0 then
        local v295 = v253 + Vector3.new(math.sin(now_1 * 42) * 5, 0, math.sin((now_1 * 33) + 1) * 7) * 0.017453292519943295
        v258, v253 = v258 + Vector3.new(0, math.abs(math.sin(now_1 * 21)) * 0.012, 0), v295
    end
    if v277 > 0 then
        local v296 = math.abs(math.sin((now_1 - tbl_upv_15.useT0) * 9))
        v258, v253 = v258 + Vector3.new(0, v296 * 0.022, -v296 * 0.012), v253 + Vector3.new(v296 * 9, 0, 0) * 0.017453292519943295
    end
    local v297 = nil
    if tbl_upv_15.action then
        v297 = tbl_upv_5[tbl_upv_15.action]
        v254 = (now_1 - tbl_upv_15.actT0) / tbl_upv_15.actDur
        if not (v297) or v254 >= 1 then
            tbl_upv_15.action = nil
        else
            local value_24, v299 = evalKeys(v297.keys, v254)
            if v297.mirror and tbl_upv_15.actMirror < 0 then
                value_24, v299 = Vector3.new(-value_24.X, value_24.Y, value_24.Z), Vector3.new(v299.X, -v299.Y, -v299.Z)
            end
            v258, v253 = v258 + value_24, v253 + v299 * 0.017453292519943295
        end
    end
    v248 = u18.value
    local v301 = v258 + Vector3.new(0, v248 * tbl_upv_2.equipDrop, 0)
    local v302 = v253 + Vector3.new((-v248 * tbl_upv_2.equipTilt) * 0.017453292519943295, 0, 0)
    if tbl_upv_15.dropAt then
        local v303 = math.clamp((now_1 - tbl_upv_15.dropAt) / tbl_upv_2.dropTime, 0, 1)
        local v304 = v303 * v303
        local v350 = v301 + Vector3.new(0, -tbl_upv_2.equipDrop * v304, 0)
        local v351 = v302 + Vector3.new((-tbl_upv_2.equipTilt * 0.017453292519943295) * v304, 0, 0)
    end
    if tbl_upv_15.hiddenUntil > 0 and tbl_upv_15.hiddenUntil <= now_1 then
        tbl_upv_15.hiddenUntil = 0
        tbl_upv_15.vanishAt = nil
        if tbl_upv_15.action == "throw" or tbl_upv_15.action == "place" then
            tbl_upv_15.action = nil
        end
        if shown_2.drawFrom and shown_2.clips and (shown_2.clips.redraw or shown_2.clips.draw) then
            tbl_upv_15.clip = nil
            tbl_upv_15.clipName = nil
            tbl_upv_15.pendingDraw = ((shown_2.clips.redraw) and "redraw") or "draw"
        else
            u18.value = -1
            u18.velocity = 0
            u18.target = 0
        end
    end
    tbl_upv_15.frame = nil
    tbl_upv_15.wallPush = 0
    value_24 = u8.value
    local v305 = u9.value
    local v306 = v301 - value_24
    local v307 = v302 - v305
    tbl_upv_15.layerPos = v306
    tbl_upv_15.layerRot = v307
    local v308 = CFrame.new(value_24) * CFrame.fromEulerAnglesYXZ(v305.X, v305.Y, v305.Z) * shown_2.styleRot
    tbl_upv_15.restFrame = v308
    if tbl_upv_15.pendingDraw then
        local pendingDraw_1 = tbl_upv_15.pendingDraw
        tbl_upv_15.pendingDraw = nil
        if shown_2.drawFrom then
            startClip(pendingDraw_1, nil, BladeClips_upv_1.StartFrame(shown_2.drawFrom, v308))
            tbl_upv_15.clipFromVel = {tip = Vector3.new(0, 0, 0), edge = Vector3.new(0, 0, 0), pos = Vector3.new(0, 3.5, 0)}
        end
    end
    if tbl_upv_15.refreshFF then
        if (tbl_upv_15.clip) and ((now_1 - tbl_upv_15.clipT0) / tbl_upv_15.clipScale < tbl_upv_15.refreshFF) then
            tbl_upv_15.clipT0 = tbl_upv_15.clipT0 - (4 * v244)
        else
            tbl_upv_15.refreshFF = nil
            tbl_upv_15.refreshGlintAt = now_1 + 0.05
        end
    end
    if tbl_upv_15.refreshGlintAt and tbl_upv_15.refreshGlintAt <= now_1 then
        tbl_upv_15.refreshGlintAt = nil
        table.insert(tbl_upv_15.fxQueue, "headglint")
        u16:Impulse(Vector3.new(0, 0.6000000238418579, 0))
    end
    local clip_3 = tbl_upv_15.clip
    tbl_upv_15.rodV = 0
    local v309 = nil
    local v322 = nil
    if clip_3 then
        local v310 = now_1 - tbl_upv_15.clipT0
        if clip_3.rod then
            tbl_upv_15.rodV = evalTrack(clip_3.rod, v310 / tbl_upv_15.clipScale)
        end
        if clip_3.string then
            tbl_upv_15.stringV = evalTrack(clip_3.string, v310 / tbl_upv_15.clipScale)
        end
        if clip_3.strip then
            tbl_upv_15.stripV = evalTrack(clip_3.strip, v310 / tbl_upv_15.clipScale)
        end
        v309 = clip_3.fx
        if v309 then
            while tbl_upv_15.clipFx <= #v309 do
                if not (v309[tbl_upv_15.clipFx][1] * tbl_upv_15.clipScale <= v310) then
                    break
                end
                v322 = v309[tbl_upv_15.clipFx]
                v322 = v322[2]
                if v322 == "bolt" then
                    tbl_upv_15.boltIn = true
                    tbl_upv_15.boltT0 = now_1
                elseif v322 == "half" then
                    tbl_upv_15.hammerTarget = 0.5
                elseif v322 == "prime" then
                    tbl_upv_15.frizzenTarget = 0
                elseif v322 == "nock" then
                    tbl_upv_15.nocked = true
                    tbl_upv_15.nockT0 = now_1
                elseif v322 == "click" then
                    tbl_upv_15.hammerTarget = 0
                end
                table.insert(tbl_upv_15.fxQueue, v322)
                if type(v322[3]) == "string" then
                    local fxQueue_2 = tbl_upv_15.fxQueue
                    local v313 = v322[3]
                    local v314 = ((type(v322[4]) ~= "number") and "") or ("@" .. v322[4])
                    table.insert(fxQueue_2, "sfx:" .. v313 .. v314)
                end
                local v315 = tbl_upv_15
                v315.clipFx = v315.clipFx + 1
            end
        end
        local v316 = BladeClips_upv_1.Eval(clip_3, tbl_upv_15.clipFrom, v310, tbl_upv_15.clipScale, v308, tbl_upv_15.clipFromVel)
        if clip_3.release * tbl_upv_15.clipScale <= v310 then
            v322 = true
        else
            v322 = false
        end
        if v322 and not tbl_upv_15.dropAt and tbl_upv_15.use then
            if tbl_upv_15.clipName == "use_in" then
                if startClip("use_loop", nil, v316) then
                    v305 = v316
                elseif v322 and not tbl_upv_15.dropAt and tbl_upv_15.parry then
                    if tbl_upv_15.clipName ~= "parry_in" and tbl_upv_15.clipName ~= "parry_hold" then
                        if v322 or tbl_upv_15.dropAt then
                            u19:Snap(v316.Position - v308.Position)
                            u19.target = Vector3.new(0, 0, 0)
                            local v317, v318 = (v316.Rotation * v308.Rotation:Inverse()):ToAxisAngle()
                            u22:Snap(v317 * v318)
                            u22.target = Vector3.new(0, 0, 0)
                            if not (tbl_upv_15.dropAt) then
                                local v319 = BladeClips_upv_1.Eval(clip_3, tbl_upv_15.clipFrom, math.max(0, v310 - 0.004166666666666667), tbl_upv_15.clipScale, v308, tbl_upv_15.clipFromVel)
                                u19.velocity = ((v316.Position - v319.Position) / 0.004166666666666667) + (clip_3.vel or Vector3.new(0, 0, 0))
                                local v320, v321 = (v316.Rotation * v319.Rotation:Inverse()):ToAxisAngle()
                                u22.velocity = v320 * math.min(v321 / 0.004166666666666667, 20)
                            end
                            tbl_upv_15.clip = nil
                            tbl_upv_15.clipName = nil
                            v305 = v308
                        else
                            v305 = v316
                        end
                    elseif not startClip("parry_hold", nil, v316) and (v322 or tbl_upv_15.dropAt) then
                        u19:Snap(v316.Position - v308.Position)
                        u19.target = Vector3.new(0, 0, 0)
                        local v317, v318 = (v316.Rotation * v308.Rotation:Inverse()):ToAxisAngle()
                        u22:Snap(v317 * v318)
                        u22.target = Vector3.new(0, 0, 0)
                        if not (tbl_upv_15.dropAt) then
                            local v319 = BladeClips_upv_1.Eval(clip_3, tbl_upv_15.clipFrom, math.max(0, v310 - 0.004166666666666667), tbl_upv_15.clipScale, v308, tbl_upv_15.clipFromVel)
                            u19.velocity = ((v316.Position - v319.Position) / 0.004166666666666667) + (clip_3.vel or Vector3.new(0, 0, 0))
                            local v320, v321 = (v316.Rotation * v319.Rotation:Inverse()):ToAxisAngle()
                            u22.velocity = v320 * math.min(v321 / 0.004166666666666667, 20)
                        end
                        tbl_upv_15.clip = nil
                        tbl_upv_15.clipName = nil
                        v305 = v308
                    else
                        v305 = v316
                    end
                elseif v322 or tbl_upv_15.dropAt then
                    u19:Snap(v316.Position - v308.Position)
                    u19.target = Vector3.new(0, 0, 0)
                    local v317, v318 = (v316.Rotation * v308.Rotation:Inverse()):ToAxisAngle()
                    u22:Snap(v317 * v318)
                    u22.target = Vector3.new(0, 0, 0)
                    if not (tbl_upv_15.dropAt) then
                        local v319 = BladeClips_upv_1.Eval(clip_3, tbl_upv_15.clipFrom, math.max(0, v310 - 0.004166666666666667), tbl_upv_15.clipScale, v308, tbl_upv_15.clipFromVel)
                        u19.velocity = ((v316.Position - v319.Position) / 0.004166666666666667) + (clip_3.vel or Vector3.new(0, 0, 0))
                        local v320, v321 = (v316.Rotation * v319.Rotation:Inverse()):ToAxisAngle()
                        u22.velocity = v320 * math.min(v321 / 0.004166666666666667, 20)
                    end
                    tbl_upv_15.clip = nil
                    tbl_upv_15.clipName = nil
                    v305 = v308
                else
                    v305 = v316
                end
            elseif tbl_upv_15.clipName == "use_loop" and startClip("use_loop", nil, v316) then
                v305 = v316
            elseif v322 and not tbl_upv_15.dropAt and tbl_upv_15.parry then
                if tbl_upv_15.clipName ~= "parry_in" and tbl_upv_15.clipName ~= "parry_hold" then
                    if v322 or tbl_upv_15.dropAt then
                        u19:Snap(v316.Position - v308.Position)
                        u19.target = Vector3.new(0, 0, 0)
                        local v317, v318 = (v316.Rotation * v308.Rotation:Inverse()):ToAxisAngle()
                        u22:Snap(v317 * v318)
                        u22.target = Vector3.new(0, 0, 0)
                        if not (tbl_upv_15.dropAt) then
                            local v319 = BladeClips_upv_1.Eval(clip_3, tbl_upv_15.clipFrom, math.max(0, v310 - 0.004166666666666667), tbl_upv_15.clipScale, v308, tbl_upv_15.clipFromVel)
                            u19.velocity = ((v316.Position - v319.Position) / 0.004166666666666667) + (clip_3.vel or Vector3.new(0, 0, 0))
                            local v320, v321 = (v316.Rotation * v319.Rotation:Inverse()):ToAxisAngle()
                            u22.velocity = v320 * math.min(v321 / 0.004166666666666667, 20)
                        end
                        tbl_upv_15.clip = nil
                        tbl_upv_15.clipName = nil
                        v305 = v308
                    else
                        v305 = v316
                    end
                elseif not startClip("parry_hold", nil, v316) and (v322 or tbl_upv_15.dropAt) then
                    u19:Snap(v316.Position - v308.Position)
                    u19.target = Vector3.new(0, 0, 0)
                    local v317, v318 = (v316.Rotation * v308.Rotation:Inverse()):ToAxisAngle()
                    u22:Snap(v317 * v318)
                    u22.target = Vector3.new(0, 0, 0)
                    if not (tbl_upv_15.dropAt) then
                        local v319 = BladeClips_upv_1.Eval(clip_3, tbl_upv_15.clipFrom, math.max(0, v310 - 0.004166666666666667), tbl_upv_15.clipScale, v308, tbl_upv_15.clipFromVel)
                        u19.velocity = ((v316.Position - v319.Position) / 0.004166666666666667) + (clip_3.vel or Vector3.new(0, 0, 0))
                        local v320, v321 = (v316.Rotation * v319.Rotation:Inverse()):ToAxisAngle()
                        u22.velocity = v320 * math.min(v321 / 0.004166666666666667, 20)
                    end
                    tbl_upv_15.clip = nil
                    tbl_upv_15.clipName = nil
                    v305 = v308
                else
                    v305 = v316
                end
            elseif v322 or tbl_upv_15.dropAt then
                u19:Snap(v316.Position - v308.Position)
                u19.target = Vector3.new(0, 0, 0)
                local v317, v318 = (v316.Rotation * v308.Rotation:Inverse()):ToAxisAngle()
                u22:Snap(v317 * v318)
                u22.target = Vector3.new(0, 0, 0)
                if not (tbl_upv_15.dropAt) then
                    local v319 = BladeClips_upv_1.Eval(clip_3, tbl_upv_15.clipFrom, math.max(0, v310 - 0.004166666666666667), tbl_upv_15.clipScale, v308, tbl_upv_15.clipFromVel)
                    u19.velocity = ((v316.Position - v319.Position) / 0.004166666666666667) + (clip_3.vel or Vector3.new(0, 0, 0))
                    local v320, v321 = (v316.Rotation * v319.Rotation:Inverse()):ToAxisAngle()
                    u22.velocity = v320 * math.min(v321 / 0.004166666666666667, 20)
                end
                tbl_upv_15.clip = nil
                tbl_upv_15.clipName = nil
                v305 = v308
            else
                v305 = v316
            end
        elseif v322 and not tbl_upv_15.dropAt and tbl_upv_15.parry then
            if tbl_upv_15.clipName ~= "parry_in" and tbl_upv_15.clipName ~= "parry_hold" then
                if v322 or tbl_upv_15.dropAt then
                    u19:Snap(v316.Position - v308.Position)
                    u19.target = Vector3.new(0, 0, 0)
                    local v317, v318 = (v316.Rotation * v308.Rotation:Inverse()):ToAxisAngle()
                    u22:Snap(v317 * v318)
                    u22.target = Vector3.new(0, 0, 0)
                    if not (tbl_upv_15.dropAt) then
                        local v319 = BladeClips_upv_1.Eval(clip_3, tbl_upv_15.clipFrom, math.max(0, v310 - 0.004166666666666667), tbl_upv_15.clipScale, v308, tbl_upv_15.clipFromVel)
                        u19.velocity = ((v316.Position - v319.Position) / 0.004166666666666667) + (clip_3.vel or Vector3.new(0, 0, 0))
                        local v320, v321 = (v316.Rotation * v319.Rotation:Inverse()):ToAxisAngle()
                        u22.velocity = v320 * math.min(v321 / 0.004166666666666667, 20)
                    end
                    tbl_upv_15.clip = nil
                    tbl_upv_15.clipName = nil
                    v305 = v308
                else
                    v305 = v316
                end
            elseif not startClip("parry_hold", nil, v316) and (v322 or tbl_upv_15.dropAt) then
                u19:Snap(v316.Position - v308.Position)
                u19.target = Vector3.new(0, 0, 0)
                local v317, v318 = (v316.Rotation * v308.Rotation:Inverse()):ToAxisAngle()
                u22:Snap(v317 * v318)
                u22.target = Vector3.new(0, 0, 0)
                if not (tbl_upv_15.dropAt) then
                    local v319 = BladeClips_upv_1.Eval(clip_3, tbl_upv_15.clipFrom, math.max(0, v310 - 0.004166666666666667), tbl_upv_15.clipScale, v308, tbl_upv_15.clipFromVel)
                    u19.velocity = ((v316.Position - v319.Position) / 0.004166666666666667) + (clip_3.vel or Vector3.new(0, 0, 0))
                    local v320, v321 = (v316.Rotation * v319.Rotation:Inverse()):ToAxisAngle()
                    u22.velocity = v320 * math.min(v321 / 0.004166666666666667, 20)
                end
                tbl_upv_15.clip = nil
                tbl_upv_15.clipName = nil
                v305 = v308
            else
                v305 = v316
            end
        elseif v322 or tbl_upv_15.dropAt then
            u19:Snap(v316.Position - v308.Position)
            u19.target = Vector3.new(0, 0, 0)
            local v317, v318 = (v316.Rotation * v308.Rotation:Inverse()):ToAxisAngle()
            u22:Snap(v317 * v318)
            u22.target = Vector3.new(0, 0, 0)
            if not (tbl_upv_15.dropAt) then
                local v319 = BladeClips_upv_1.Eval(clip_3, tbl_upv_15.clipFrom, math.max(0, v310 - 0.004166666666666667), tbl_upv_15.clipScale, v308, tbl_upv_15.clipFromVel)
                u19.velocity = ((v316.Position - v319.Position) / 0.004166666666666667) + (clip_3.vel or Vector3.new(0, 0, 0))
                local v320, v321 = (v316.Rotation * v319.Rotation:Inverse()):ToAxisAngle()
                u22.velocity = v320 * math.min(v321 / 0.004166666666666667, 20)
            end
            tbl_upv_15.clip = nil
            tbl_upv_15.clipName = nil
            v305 = v308
        else
            v305 = v316
        end
    else
        v305 = v308
    end
    if not (tbl_upv_15.clip) then
        u19:Update(v244)
        u22:Update(v244)
        v322 = u19.value
        local value_25 = u22.value
        if v322.Magnitude > 1e-05 or value_25.Magnitude > 1e-05 then
            if value_25.Magnitude > 1e-06 then
                v309 = CFrame.fromAxisAngle(value_25.Unit, value_25.Magnitude)
            else
                v309 = CFrame.identity
            end
            v305 = CFrame.new(v308.Position + v322) * v309 * v308.Rotation
        end
    end
    local lastFrame_1 = tbl_upv_15.lastFrame
    if lastFrame_1 then
        local v323, v324, v325 = nil, nil, nil
        if v244 > 0 then
            local function cap_1(a2, a3)
                --[[
                  name: cap
                  line: 1794
                ]]
                if a3 < a2.Magnitude then
                    return a2.Unit * a3
                end
                return a2
            end
            local tbl_31 = {tip = 0, edge = 0, pos = 0}
            v323 = (v305.Position - lastFrame_1.Position) / v244
            local v326
            if v323.Magnitude > 25 then
                v326 = v323.Unit * 25
            else
                v326 = v323
            end
            tbl_31.pos = v326
            v324 = (v305.UpVector - lastFrame_1.UpVector) / v244
            if v324.Magnitude > 40 then
                v326 = v324.Unit * 40
            else
                v326 = v324
            end
            tbl_31.tip = v326
            v325 = (v305.LookVector - lastFrame_1.LookVector) / v244
            if v325.Magnitude > 40 then
                v326 = v325.Unit * 40
            end
            tbl_31.edge = v325
            tbl_upv_15.rawVel = tbl_31
        end
    end
    tbl_upv_15.lastFrame = v305
    tbl_upv_15.lastFrameT = now_1
    if shown_2.id == "bolas" then
        if (tbl_upv_15.clipName == "draw" or tbl_upv_15.clipName == "redraw") and tbl_upv_15.spinT0 ~= tbl_upv_15.clipT0 then
            tbl_upv_15.spinT0 = tbl_upv_15.clipT0
        end
        if tbl_upv_15.clipName ~= "throw" then
            tbl_upv_15.spinA = 12.566370614359172 * (1 - ((1 - math.clamp((now_1 - tbl_upv_15.spinT0) / 0.7, 0, 1)) ^ 3))
        else
            tbl_upv_15.spinA = (tbl_upv_15.spinA + (((v244 * 2) * math.pi) * 4)) % math.tau
        end
        v305 = v305 * CFrame.Angles(0, tbl_upv_15.spinA, 0)
    end
    local v327 = CFrame.new(v305.Position + v306) * CFrame.fromEulerAnglesYXZ(v307.X, v307.Y, v307.Z) * v305.Rotation
    local wall_2 = a1.wall
    local v328 = nil
    if wall_2 then
        local v312 = 0
        for v352, value_26 in shown_2.corners do
            v312 = math.max(v312, -v327:PointToWorldSpace(value_26).Z)
        end
        v328 = wall_2 - 0.12
        if v328 < v312 then
            tbl_upv_15.wallPush = math.min(v312 - v328, math.max(0, -v327.Position.Z - 0.28))
            v327 = v327 + Vector3.new(0, 0, tbl_upv_15.wallPush)
        end
    end
    tbl_upv_15.frame = v327
    if tbl_upv_15.leftVanishAt and tbl_upv_15.leftVanishAt <= now_1 then
        tbl_upv_15.leftOut = true
        tbl_upv_15.leftVanishAt = nil
        tbl_upv_15.leftOutAt = now_1
    end
    if a1.offHandOut == true then
        tbl_upv_15.leftSeenOut = true
        if not (tbl_upv_15.leftOut) and not (tbl_upv_15.leftVanishAt) then
            tbl_upv_15.leftOut = true
            tbl_upv_15.leftOutAt = now_1
        end
    elseif a1.offHandOut == false and tbl_upv_15.leftOut and (tbl_upv_15.leftSeenOut or now_1 - tbl_upv_15.leftOutAt > 1) then
        tbl_upv_15.leftOut = false
        tbl_upv_15.leftSeenOut = false
        tbl_upv_15.leftCatchT = now_1
    end
    if (shown_2.leftFist) and (tbl_upv_15.leftOut) then
        tbl_upv_15.leftFrame = nil
    else
        local v330 = nil
        if shown_2.leftFist then
            v305 = tbl_upv_15.clip
            if v305 and v305.left then
                local v331 = v305.leftClip
                if not (v331) then
                    local tbl_32 = {keys = v305.left, contact = v305.contact, release = v305.release, eyeRoll = v305.eyeRoll}
                    v305.leftClip = tbl_32
                    v331 = tbl_32
                end
                v327 = BladeClips_upv_1.Eval(v331, tbl_upv_15.leftFrom, now_1 - tbl_upv_15.clipT0, tbl_upv_15.clipScale, v308, tbl_upv_15.leftFromVel)
            end
            v305 = tbl_upv_15.leftLast
            if v305 then
                local v332, v333, v334 = nil, nil, nil
                if v244 > 0 then
                    local function cap_2(a4, a5)
                        --[[
                          name: cap
                          line: 1868
                        ]]
                        if a5 < a4.Magnitude then
                            return a4.Unit * a5
                        end
                        return a4
                    end
                    local tbl_33 = {tip = 0, edge = 0, pos = 0}
                    v332 = (v327.Position - v305.Position) / v244
                    local v335
                    if v332.Magnitude > 25 then
                        v335 = v332.Unit * 25
                    else
                        v335 = v332
                    end
                    tbl_33.pos = v335
                    v333 = (v308.UpVector - v305.UpVector) / v244
                    if v333.Magnitude > 40 then
                        v335 = v333.Unit * 40
                    else
                        v335 = v333
                    end
                    tbl_33.tip = v335
                    v334 = (v308.LookVector - v305.LookVector) / v244
                    if v334.Magnitude > 40 then
                        v335 = v334.Unit * 40
                    end
                    tbl_33.edge = v334
                    tbl_upv_15.leftVel = tbl_33
                end
            end
            tbl_upv_15.leftLast = v308
            v330 = (now_1 - tbl_upv_15.leftCatchT) / 0.3
            if v330 >= 0 and v330 < 1 then
                local v353 = v330 - 1
                local v354 = 1 - (2.70158 * (v330 - 1) * (v330 - 1) * (v330 - 1) + 1 + 1.70158 * (v330 - 1) * (v330 - 1))
                v327 = CFrame.new(v308.Position + Vector3.new(0.05999999865889549, -0.41999998688697815, 0.03999999910593033) * (1 - (2.70158 * (v330 - 1) * (v330 - 1) * (v330 - 1) + 1 + 1.70158 * (v330 - 1) * (v330 - 1)))) * CFrame.fromEulerAnglesYXZ(-0.8726646259971648 * (1 - (2.70158 * (v330 - 1) * (v330 - 1) * (v330 - 1) + 1 + 1.70158 * (v330 - 1) * (v330 - 1))), 0, 0.5235987755982988 * (1 - (2.70158 * (v330 - 1) * (v330 - 1) * (v330 - 1) + 1 + 1.70158 * (v330 - 1) * (v330 - 1))))
                    * v308.Rotation
            else
                v327 = v308
            end
            local v336, v337, v338, v339, v340, v341, v342, v343, v344, v345, v346, v347 = v327:GetComponents()
            local v348 = CFrame.new(-v336, v337, v338, v339, -v340, -v341, -v342, v343, v344, -v345, v346, v347)
            tbl_upv_15.leftFrame = CFrame.new((v348.Position + v306) + Vector3.new(0, 0, tbl_upv_15.wallPush)) * CFrame.fromEulerAnglesYXZ(v307.X, v307.Y, v307.Z) * v348.Rotation
        else
            tbl_upv_15.leftFrame = nil
        end
    end
    if tbl_upv_15.vanishAt then
        v244 = false
        if tbl_upv_15.vanishAt <= now_1 then
            v244 = now_1 < tbl_upv_15.hiddenUntil
        end
    else
        v244 = (now_1 < tbl_upv_15.hiddenUntil) and ((tbl_upv_15.action ~= "throw") and (tbl_upv_15.action ~= "place"))
    end
    if v244 then
        return v301, v302, nil
    end
    if (a1.charges) and (a1.charges <= 0) then
        tbl_upv_15.spent = true
        if not (tbl_upv_15.vanishAt) or not (now_1 < tbl_upv_15.vanishAt) then
            return v301, v302, nil
        end
    elseif tbl_upv_15.spent then
        tbl_upv_15.spent = false
        if shown_2.drawFrom and shown_2.clips and (shown_2.clips.redraw or shown_2.clips.draw) then
            tbl_upv_15.pendingDraw = ((shown_2.clips.redraw) and "redraw") or "draw"
        else
            u18.value = -1
            u18.velocity = 0
            u18.target = 0
        end
    end
    return v301, v302, shown_2
end
local function renderFrame(a1)
    --[[
      name: renderFrame
      line: 2595
      upvalues:
        liveInput (copy, index: 1)
        u23 (ref,  index: 2)
        tbl_upv_25 (copy, index: 3)
        u26 (ref,  index: 4)
        BladeSmear_upv_1 (copy, index: 5)
        ViewFx_upv_1 (copy, index: 6)
        tbl_upv_15 (copy, index: 7)
        step (copy, index: 8)
        place (copy, index: 9)
    ]]
    local v350, v351 = liveInput(a1)
    if v350 and v351 then
        if v350.visible then
            local v352, v353, v354 = step(v350)
            place(v351, v350.cam, v350.fov, v352, v353, v354)
        else
            if tbl_upv_15.shown or u23 then
                tbl_upv_15.shown = nil
                tbl_upv_15.wantId = nil
                tbl_upv_15.dropAt = nil
                if u23 then
                    u23.Parent = nil
                    u23 = nil
                end
                for _, value_27 in tbl_upv_25 do
                    value_27.Parent = nil
                end
                if u26 then
                    u26.Parent = nil
                    u26 = nil
                end
                BladeSmear_upv_1.Hide()
                ViewFx_upv_1.Hide()
                tbl_upv_15.embers = false
                tbl_upv_15.fuse = 0
            end
            tbl_upv_15.lastYaw = nil
            tbl_upv_15.lastPitch = nil
            tbl_upv_15.lastRootY = nil
        end
    else
        if u23 then
            u23.Parent = nil
            u23 = nil
        end
        for _, value_28 in tbl_upv_25 do
            value_28.Parent = nil
        end
        if u26 then
            u26.Parent = nil
            u26 = nil
        end
        BladeSmear_upv_1.Hide()
        ViewFx_upv_1.Hide()
        tbl_upv_15.embers = false
        tbl_upv_15.fuse = 0
    end
end
local function render(a1)
    --[[
      name: render
      line: 2614
      upvalues:
        u30 (ref,  index: 1)
        u31 (ref,  index: 2)
        renderFrame (copy, index: 3)
        u32 (ref,  index: 4)
        u33 (ref,  index: 5)
        u34 (ref,  index: 6)
    ]]
    if (u30) or (u31) then
        return
    end
    local v355 = os.clock()
    renderFrame(a1)
    local v356 = os.clock() - v355
    u32 = u32 + v356
    u33 = u33 + 1
    u34 = math.max(u34, v356)
end
resetState = function()
    --[[
      name: resetState
      line: 917
      upvalues:
        u8 (copy, index: 1)
        u9 (copy, index: 2)
        u10 (copy, index: 3)
        u11 (copy, index: 4)
        u12 (copy, index: 5)
        u13 (copy, index: 6)
        u14 (copy, index: 7)
        u15 (copy, index: 8)
        u16 (copy, index: 9)
        u17 (copy, index: 10)
        u18 (copy, index: 11)
        u19 (copy, index: 12)
        u22 (copy, index: 13)
        tbl_upv_15 (copy, index: 14)
        BladeSmear_upv_1 (copy, index: 15)
        ViewFx_upv_1 (copy, index: 16)
    ]]
    u8:Snap(Vector3.new(0, 0, 0))
    u9:Snap(Vector3.new(0, 0, 0))
    u10:Snap(0)
    u11:Snap(0)
    u12:Snap(0)
    u13:Snap(Vector3.new(0, 0, 0))
    u14:Snap(Vector3.new(0, 0, 0))
    u15:Snap(Vector3.new(0, 0, 0))
    u16:Snap(Vector3.new(0, 0, 0))
    u17:Snap(Vector3.new(0, 0, 0))
    u18:Snap(0)
    u19:Snap(Vector3.new(0, 0, 0))
    u22:Snap(Vector3.new(0, 0, 0))
    tbl_upv_15.action = nil
    tbl_upv_15.clip = nil
    tbl_upv_15.lastFrame = nil
    tbl_upv_15.frame = nil
    tbl_upv_15.spark = false
    tbl_upv_15.rawVel = nil
    tbl_upv_15.leftLast = nil
    tbl_upv_15.leftFromVel = nil
    tbl_upv_15.leftVel = nil
    tbl_upv_15.leftFrame = nil
    tbl_upv_15.leftOut = false
    tbl_upv_15.leftVanishAt = nil
    tbl_upv_15.leftCatchT = -10
    tbl_upv_15.leftOutAt = -10
    tbl_upv_15.leftSeenOut = false
    tbl_upv_15.lastLungeT = nil
    tbl_upv_15.lastLungeName = nil
    tbl_upv_15.refreshGlintAt = nil
    tbl_upv_15.refreshFF = nil
    tbl_upv_15.clipName = nil
    tbl_upv_15.pendingDraw = nil
    tbl_upv_15.vanishAt = nil
    tbl_upv_15.drawHold = 0
    tbl_upv_15.drawHalf = false
    tbl_upv_15.drawFull = false
    tbl_upv_15.nocked = true
    tbl_upv_15.nockT0 = -10
    tbl_upv_15.shotN = 0
    tbl_upv_15.looseAt = nil
    tbl_upv_15.windHold = 0
    tbl_upv_15.windK = 0
    tbl_upv_15.windFull = false
    tbl_upv_15.windHalf = false
    tbl_upv_15.throwN = 0
    tbl_upv_15.bite = 0
    tbl_upv_15.stringV = 0
    tbl_upv_15.stringT0 = -10
    tbl_upv_15.stripV = 0.25
    tbl_upv_15.useOutUntil = nil
    tbl_upv_15.spinA = 0
    tbl_upv_15.spinT0 = -10
    table.clear(tbl_upv_15.fxQueue)
    BladeSmear_upv_1.Hide()
    ViewFx_upv_1.Hide()
    tbl_upv_15.embers = false
    tbl_upv_15.fuse = 0
    tbl_upv_15.block = false
    tbl_upv_15.parry = false
    tbl_upv_15.charge = false
    tbl_upv_15.draw = false
    tbl_upv_15.wind = false
    tbl_upv_15.use = false
    tbl_upv_15.reload = false
    tbl_upv_15.dropAt = nil
    tbl_upv_15.hiddenUntil = 0
    tbl_upv_15.lastYaw = nil
    tbl_upv_15.lastPitch = nil
    tbl_upv_15.lastRootY = nil
    tbl_upv_15.vy = 0
    tbl_upv_15.minVy = 0
    tbl_upv_15.grounded = true
end
function tbl_upv_1.SetExternal(a1)
    --[[
      name: SetExternal
      line: 2636
      upvalues:
        u31 (ref,  index: 1)
        resetState (copy, index: 2)
        tbl_upv_15 (copy, index: 3)
        u23 (ref,  index: 4)
        tbl_upv_25 (copy, index: 5)
        u26 (ref,  index: 6)
        BladeSmear_upv_1 (copy, index: 7)
        ViewFx_upv_1 (copy, index: 8)
    ]]
    if u31 == a1 then
        return
    end
    u31 = a1
    resetState()
    tbl_upv_15.shown = nil
    tbl_upv_15.wantId = nil
    if u23 then
        u23.Parent = nil
        u23 = nil
    end
    for _, value_29 in tbl_upv_25 do
        value_29.Parent = nil
    end
    if u26 then
        u26.Parent = nil
        u26 = nil
    end
    BladeSmear_upv_1.Hide()
    ViewFx_upv_1.Hide()
    tbl_upv_15.embers = false
    tbl_upv_15.fuse = 0
end
function tbl_upv_1.ReleasePoint()
    --[[
      name: ReleasePoint
      line: 2649
      upvalues:
        tbl_upv_15 (copy, index: 1)
    ]]
    if tbl_upv_15.release and os.clock() - tbl_upv_15.releaseT < 0.5 then
        return tbl_upv_15.release
    end
    return nil
end
function tbl_upv_1.ReleaseDelay()
    --[[
      name: ReleaseDelay
      line: 2655
      upvalues:
        tbl_upv_15 (copy, index: 1)
    ]]
    local v357 = tbl_upv_15.vanishAt or (tbl_upv_15.looseAt or (tbl_upv_15.leftVanishAt))
    if v357 then
        return (math.max(0, v357 - os.clock()))
    end
    return 0
end
function tbl_upv_1.IsExternal()
    --[[
      name: IsExternal
      line: 2660
      upvalues:
        u31 (ref, index: 1)
    ]]
    return u31
end
function tbl_upv_1.ExternalFrame(a1)
    --[[
      name: ExternalFrame
      line: 2665
      upvalues:
        u31 (ref,  index: 1)
        Workspace_upv_1 (copy, index: 2)
        tbl_upv_15 (copy, index: 3)
        u23 (ref,  index: 4)
        tbl_upv_25 (copy, index: 5)
        u26 (ref,  index: 6)
        BladeSmear_upv_1 (copy, index: 7)
        ViewFx_upv_1 (copy, index: 8)
        step (copy, index: 9)
        UserInputService_upv_1 (copy, index: 10)
        place (copy, index: 11)
    ]]
    if not u31 then
        return
    end
    local CurrentCamera_2 = Workspace_upv_1.CurrentCamera
    if not CurrentCamera_2 then
        return
    end
    if a1.visible then
        local CFrame_3 = CurrentCamera_2.CFrame
        local tbl_34 = {visible = true, touch = 0}
        tbl_34.dt = a1.dt
        tbl_34.now = os.clock()
        tbl_34.id = a1.id
        tbl_34.kind = a1.kind
        tbl_34.charges = a1.charges
        tbl_34.cam = CFrame_3
        tbl_34.fov = CurrentCamera_2.FieldOfView
        tbl_34.grounded = a1.grounded
        tbl_34.rootY = a1.rootY
        tbl_34.sliding = a1.sliding
        tbl_34.aiming = a1.aiming
        tbl_34.bobPhase = a1.bobPhase
        tbl_34.bobAmount = a1.bobAmount
        tbl_34.wall = a1.wall
        local success_5, v358 = pcall(
            function()
                --[[
                  line: 2512
                  upvalues:
                    UserInputService_upv_1 (copy, index: 1)
                ]]
                return UserInputService_upv_1.PreferredInput
            end
        )
        tbl_34.touch = success_5 and typeof(v358) == "EnumItem" and v358.Name == "Touch"
        local v360, v361, v362 = step(tbl_34)
        place(CurrentCamera_2, CFrame_3, CurrentCamera_2.FieldOfView, v360, v361, v362)
    else
        if tbl_upv_15.shown or u23 then
            tbl_upv_15.shown = nil
            tbl_upv_15.wantId = nil
            tbl_upv_15.dropAt = nil
            if u23 then
                u23.Parent = nil
                u23 = nil
            end
            for _, value_30 in tbl_upv_25 do
                value_30.Parent = nil
            end
            if u26 then
                u26.Parent = nil
                u26 = nil
            end
            BladeSmear_upv_1.Hide()
            ViewFx_upv_1.Hide()
            tbl_upv_15.embers = false
            tbl_upv_15.fuse = 0
        end
        tbl_upv_15.lastYaw = nil
        tbl_upv_15.lastPitch = nil
        tbl_upv_15.lastRootY = nil
    end
end
local function onEvent(a1, a2)
    --[[
      name: onEvent
      line: 1015
      upvalues:
        tbl_upv_15 (copy, index: 1)
        BladeClips_upv_1 (copy, index: 2)
        ItemClips_upv_1 (copy, index: 3)
        startClip (copy, index: 4)
        tbl_upv_5 (copy, index: 5)
        u16 (copy, index: 6)
        u17 (copy, index: 7)
        u20 (copy, index: 8)
        u21 (copy, index: 9)
        tbl_upv_2 (copy, index: 10)
    ]]
    local v363 = a2 or {}
    local shown_3 = tbl_upv_15.shown
    local v364
    if shown_3 then
        v364 = shown_3.kind
    else
        v364 = nil
    end
    if a1 == "Swing" then
        local v365 = tonumber(v363.step) or 1
        local v366 = v363.finisher == true
        local v367
        if v364 == "Sword" or v364 == "Dagger" then
            v367 = BladeClips_upv_1.Pick(v364, v365, v366)
        elseif v364 then
            local Pick_1 = ItemClips_upv_1.Pick
            local v368 = true
            if v363.oneHanded ~= true then
                v368 = tbl_upv_15.leftOut
            end
            v367 = Pick_1(v364, v365, v366, v368)
        else
            v367 = nil
        end
        if v364 == "Shield" and v367 == "bash" then
            tbl_upv_15.shotN = tbl_upv_15.shotN + 1
            if tbl_upv_15.shotN % 2 == 0 then
                local _ = tbl_upv_15.shown
                v367 = tbl_upv_15.shown ~= nil and tbl_upv_15.shown.clips ~= nil and tbl_upv_15.shown.clips.bash2 ~= nil and "bash2" or v367
            end
        end
        if v367 and startClip(v367, tonumber(v363.hitDelay)) then
            return
        end
        local v369 = nil
        if v364 ~= "Shield" then
            local v370 = nil
            if v364 ~= "Axe" then
                local v371 = nil
                if v364 == "Club" then
                    v371 = tbl_upv_5.smash
                    if v371 then
                        tbl_upv_15.action = "smash"
                        tbl_upv_15.actT0 = tbl_upv_15.now
                        tbl_upv_15.actDur = v371.dur
                        tbl_upv_15.actMirror = 1
                    end
                elseif v364 == "Spear" then
                    local thrust_1 = tbl_upv_5.thrust
                    if thrust_1 then
                        tbl_upv_15.action = "thrust"
                        tbl_upv_15.actT0 = tbl_upv_15.now
                        tbl_upv_15.actDur = thrust_1.dur
                        tbl_upv_15.actMirror = 1
                    end
                end
            else
                v370 = tbl_upv_5.chop
                if v370 then
                    tbl_upv_15.action = "chop"
                    tbl_upv_15.actT0 = tbl_upv_15.now
                    tbl_upv_15.actDur = v370.dur
                    tbl_upv_15.actMirror = 1
                end
            end
        else
            v369 = tbl_upv_5.stab
            if v369 then
                tbl_upv_15.action = "stab"
                tbl_upv_15.actT0 = tbl_upv_15.now
                tbl_upv_15.actDur = v369.dur
                tbl_upv_15.actMirror = 1
            end
        end
    elseif a1 == "Parry" then
        local parry_1 = tbl_upv_15.parry
        tbl_upv_15.parry = v363.on == true
        if (not tbl_upv_15.parry or (parry_1)) and parry_1 then
            if (tbl_upv_15.parry) then
                return
            end
            startClip("parry_out")
        end
        startClip("parry_in")
    elseif a1 == "Parried" then
        tbl_upv_15.parry = false
        if (startClip("parry_hit")) then
            return
        end
        u16:Impulse(Vector3.new(0.029999999329447746, -0.03999999910593033, 0.07999999821186066))
    elseif a1 == "Hurl" then
        local v365 = not (shown_3) or not (shown_3.clips) or shown_3.clips.throw
        if v365 and startClip("throw") then
            tbl_upv_15.leftVanishAt = tbl_upv_15.now + ((v365.vanishLeft or 0.06) * tbl_upv_15.clipScale)
        else
            tbl_upv_15.leftOut = true
            tbl_upv_15.leftOutAt = tbl_upv_15.now
        end
    elseif a1 ~= "Catch" then
        if a1 == "Block" then
            local block_1 = tbl_upv_15.block
            tbl_upv_15.block = v363.on == true
            if (not tbl_upv_15.block or (block_1)) and block_1 then
                if (tbl_upv_15.block) then
                    return
                end
                startClip("block_out")
            end
            startClip("block_in")
        elseif a1 == "Charge" then
            tbl_upv_15.charge = v363.on == true
            local v372 = tonumber(v363.time) or 0.6
            tbl_upv_15.chargeT0 = tbl_upv_15.now
            tbl_upv_15.chargeTime = v372
            tbl_upv_15.chargeFull = false
        elseif a1 == "Heavy" then
            tbl_upv_15.charge = false
            if not (startClip("heavy", tonumber(v363.hitDelay))) then
                local heavy_1 = tbl_upv_5.heavy
                if not heavy_1 then
                    return
                end
                tbl_upv_15.action = "heavy"
                tbl_upv_15.actT0 = tbl_upv_15.now
                tbl_upv_15.actDur = heavy_1.dur
                tbl_upv_15.actMirror = 1
            end
        elseif a1 ~= "Lunge" then
            local v373 = nil
            if a1 == "Refresh" then
                v373 = tbl_upv_15.clip
                if v373 and v373.refreshAt and tbl_upv_15.clipScale and (tbl_upv_15.now - tbl_upv_15.clipT0) / tbl_upv_15.clipScale < v373.refreshAt then
                    tbl_upv_15.refreshFF = v373.refreshAt
                    tbl_upv_15.refreshGlintAt = nil
                    return
                end
                tbl_upv_15.refreshGlintAt = tbl_upv_15.now
            elseif a1 == "Draw" then
                tbl_upv_15.draw = v363.on == true
                local v374 = math.max(0.1, tonumber(v363.time) or 1)
                tbl_upv_15.drawT0 = tbl_upv_15.now
                tbl_upv_15.drawTime = v374
                if tbl_upv_15.draw then
                    tbl_upv_15.arrowKind = type(v363.arrow) ~= "string" and "Arrow" or v363.arrow
                    tbl_upv_15.drawHalf = false
                    tbl_upv_15.drawFull = false
                    tbl_upv_15.drawHold = 0
                    if not (tbl_upv_15.nocked) then
                        tbl_upv_15.nocked = true
                        tbl_upv_15.nockT0 = tbl_upv_15.now
                    end
                    startClip("nock")
                end
            elseif a1 == "Release" then
                tbl_upv_15.draw = false
                tbl_upv_15.nocked = false
                tbl_upv_15.drawHold = tbl_upv_15.now + 0.16
                local v376 = math.clamp(tonumber(v363.charge) or 1, 0.2, 1)
                local v377
                if (shown_3) and (shown_3.cfg.kick) then
                    v377 = shown_3.cfg.kick
                else
                    v377 = 1
                end
                local v378 = v376 * v377
                if (startClip("release")) then
                    return
                end
                u16:Impulse(Vector3.new(0, 0.20000000298023224, 1.2000000476837158) * v378)
                u17:Impulse((Vector3.new(120, 0, 0) * v378) * 0.017453292519943295)
            elseif a1 == "Fire" then
                tbl_upv_15.boltIn = false
                local now_2 = tbl_upv_15.now
                tbl_upv_15.stringV = 1
                tbl_upv_15.stringT0 = now_2
                tbl_upv_15.hammerTarget = 1
                u20.velocity = 30
                tbl_upv_15.frizzenTarget = 1
                u21.velocity = 22
                local v379
                if tbl_upv_15.clipName == "draw" then
                    v379 = (tbl_upv_15.clip ~= nil) and (tbl_upv_15.now - tbl_upv_15.clipT0 < (tbl_upv_15.clip.release * tbl_upv_15.clipScale) * 0.7)
                else
                    v379 = false
                    if tbl_upv_15.clipName == "redraw" then
                        v379 = (tbl_upv_15.clip ~= nil) and (tbl_upv_15.now - tbl_upv_15.clipT0 < (tbl_upv_15.clip.release * tbl_upv_15.clipScale) * 0.7)
                    end
                end
                if v379 then
                    table.insert(tbl_upv_15.fxQueue, "muzzle")
                end
                tbl_upv_15.shotN = tbl_upv_15.shotN + 1
                if not (v379) and startClip("fire") then
                    local v380 = ({Crossbow = Vector3.new(130, 50, 90), Musket = Vector3.new(160, 80, 280), Pistol = Vector3.new(340, 60, 220), Blunderbuss = Vector3.new(220, 80, 260)})[v364 or ""] or Vector3.new(150, 60, 150)
                    local v381 = Random.new((tbl_upv_15.shotN * 7919) + 17)
                    u17:Impulse(Vector3.new(v381:NextNumber(-1, 1) * v380.X, v381:NextNumber(-1, 1) * v380.Y, v381:NextNumber(-1, 1) * v380.Z) * 0.017453292519943295)
                    return
                end
                local v382 = (tonumber(v363.kick) or 2) / 3
                local lunge_1
                if (shown_3) and (shown_3.cfg.kick) then
                    lunge_1 = shown_3.cfg.kick
                else
                    lunge_1 = 1
                end
                local v383 = math.min(v382 * lunge_1, 3.5)
                u16:Impulse(Vector3.new(0, 0.5, 3) * v383)
                u17:Impulse((Vector3.new(420, (math.random() - 0.5) * 40, (math.random() - 0.5) * 40) * v383) * 0.017453292519943295)
            elseif a1 == "Reload" then
                local v384 = math.max(0.2, tonumber(v363.time) or 1.2)
                local v366 = not (shown_3) or not (shown_3.clips) or shown_3.clips.reload
                if v366 then
                    startClip("reload", nil, nil, (math.clamp(v384 / (v366.span or (v366.release)), 0.35, 2.5)))
                else
                    tbl_upv_15.reload = true
                    tbl_upv_15.reloadT0 = tbl_upv_15.now
                    tbl_upv_15.reloadTime = v384
                end
            elseif a1 == "ReloadEnd" then
                tbl_upv_15.reload = false
            elseif a1 ~= "Windup" then
                local v385 = nil
                if a1 == "Throw" then
                    tbl_upv_15.throwN = tbl_upv_15.throwN + 1
                    local v386
                    if shown_3 and shown_3.clips and shown_3.clips.throw2 then
                        if tbl_upv_15.throwN % 2 ~= 0 then
                            v386 = "throw"
                        else
                            v386 = "throw2"
                        end
                    else
                        v386 = "throw"
                    end
                    local v366 = not (shown_3) or not (shown_3.clips) or shown_3.clips[v386]
                    if tbl_upv_15.wind then
                        local v387 = math.clamp((tbl_upv_15.now - tbl_upv_15.windT0) / tbl_upv_15.windTime, 0, 1)
                        local v388 = math.clamp((tbl_upv_15.now - tbl_upv_15.windT0) / 0.12, 0, 1)
                        local v389 = math.clamp(v387, 0, 1)
                        tbl_upv_15.windK = (((v388 * v388) * (3 - (v388 * 2))) * 0.75) + (((v389 * v389) * (3 - (v389 * 2))) * 0.25)
                        local now_3 = tbl_upv_15.now
                        if (v366) and (v366.vanish) then
                            v388 = v366.vanish
                        else
                            v388 = 0.07
                        end
                        tbl_upv_15.windHold = (now_3 + v388) + 0.06
                    end
                    tbl_upv_15.wind = false
                    if v366 and startClip(v386) then
                        if v366.vanish then
                            tbl_upv_15.vanishAt = tbl_upv_15.now + (v366.vanish * tbl_upv_15.clipScale)
                            tbl_upv_15.hiddenUntil = tbl_upv_15.vanishAt + (ItemClips_upv_1.HIDE[v364 or ""] or 0.45)
                        elseif v366.loose then
                            tbl_upv_15.looseAt = tbl_upv_15.now + (v366.loose * tbl_upv_15.clipScale)
                        end
                        return
                    end
                    v385 = tbl_upv_5.throw
                    if v385 then
                        tbl_upv_15.action = "throw"
                        tbl_upv_15.actT0 = tbl_upv_15.now
                        tbl_upv_15.actDur = v385.dur
                        tbl_upv_15.actMirror = 1
                    end
                    tbl_upv_15.hiddenUntil = tbl_upv_15.now + 0.5
                elseif a1 ~= "Use" then
                    local v390 = nil
                    if a1 == "Place" then
                        local v365 = not (shown_3) or not (shown_3.clips) or shown_3.clips.place
                        if not v365 or not startClip("place") then
                            v390 = tbl_upv_5.place
                            if v390 then
                                tbl_upv_15.action = "place"
                                tbl_upv_15.actT0 = tbl_upv_15.now
                                tbl_upv_15.actDur = v390.dur
                                tbl_upv_15.actMirror = 1
                            end
                            tbl_upv_15.hiddenUntil = tbl_upv_15.now + 0.6
                            return
                        end
                        tbl_upv_15.vanishAt = tbl_upv_15.now + (v365.vanish or 0.2)
                        tbl_upv_15.hiddenUntil = tbl_upv_15.vanishAt + (ItemClips_upv_1.HIDE[v364 or ""] or 0.5)
                    elseif a1 == "Hurt" then
                        if v363.blocked and tbl_upv_15.block and shown_3 then
                            if shown_3.cfg.blockFrame then
                                tbl_upv_15.spark = true
                            else
                                local shown_4 = tbl_upv_15.shown
                                if (shown_4 ~= nil) and ((shown_4.clips ~= nil) and (shown_4.clips.block_hit ~= nil)) then
                                    startClip("block_hit")
                                    table.insert(tbl_upv_15.fxQueue, "rimspark")
                                end
                            end
                        end
                        local v391 = math.clamp((tonumber(v363.amount) or 10) / 40, 0.2, 1.2)
                        local v392 = v391 * (((v363.blocked) and 0.5) or 1)
                        u17:Impulse(((Vector3.new((math.random() - 0.3) * 2, (math.random() - 0.5) * 2, (math.random() - 0.5) * 2.5) * tbl_upv_2.hurtRot) * v392) * 0.017453292519943295)
                        u16:Impulse(Vector3.new(0, -tbl_upv_2.hurtPos, tbl_upv_2.hurtPos * 0.6) * v392)
                    end
                else
                    local use_1 = tbl_upv_15.use
                    tbl_upv_15.use = v363.on == true
                    local v393 = math.max(0.2, tonumber(v363.time) or 1)
                    tbl_upv_15.useT0 = tbl_upv_15.now
                    tbl_upv_15.useTime = v393
                    if not tbl_upv_15.use or (use_1) then
                        if not (tbl_upv_15.use) and use_1 then
                            tbl_upv_15.useOutUntil = tbl_upv_15.now + 0.45
                            if v363.done then
                                if not startClip("use_done") then
                                    u16:Impulse(Vector3.new(0, 0.5, 0))
                                end
                            else
                                startClip("use_out")
                            end
                            return
                        end
                        if v363.done then
                            u16:Impulse(Vector3.new(0, 0.5, 0))
                        end
                    end
                    tbl_upv_15.bite = 0
                    startClip("use_in")
                end
            else
                tbl_upv_15.wind = v363.on == true
                tbl_upv_15.windFull = false
                tbl_upv_15.windHalf = false
                tbl_upv_15.windHold = 0
                local v394 = math.max(0.1, tonumber(v363.time) or 0.5)
                tbl_upv_15.windT0 = tbl_upv_15.now
                tbl_upv_15.windTime = v394
                if not tbl_upv_15.wind then
                    return
                end
                startClip("windup")
            end
        else
            tbl_upv_15.charge = false
            local v395 = tonumber(v363.time) or 0.25
            local v396 = "lunge"
            local shown_5 = tbl_upv_15.shown
            local v400 = nil
            if (shown_5 ~= nil) and ((shown_5.clips ~= nil) and (shown_5.clips.lunge_b ~= nil)) then
                v400 = tbl_upv_15.now - tbl_upv_15.clipT0
                local v397 = ((tbl_upv_15.lastLungeT) and (tbl_upv_15.now - tbl_upv_15.lastLungeT)) or math.huge
                local v398
                if tbl_upv_15.clipName == "sweep_r" then
                    v398 = true
                    if not (v400 < 0.45) then
                        if tbl_upv_15.clipName == "lunge" then
                            v398 = (v400 > 0.22) and (v400 < 0.34)
                        else
                            local v399 = false
                            if tbl_upv_15.clipName ~= "lunge_c" then
                                v398 = v399
                            else
                                v398 = (v400 > 0.22) and (v400 < 0.34)
                            end
                        end
                    end
                elseif tbl_upv_15.clipName == "lunge" then
                    v398 = (v400 > 0.22) and (v400 < 0.34)
                else
                    local v399 = false
                    if tbl_upv_15.clipName ~= "lunge_c" then
                        v398 = v399
                    else
                        v398 = (v400 > 0.22) and (v400 < 0.34)
                    end
                end
                if v398 then
                    v396 = "lunge_b"
                elseif v397 >= 0 and v397 < 1.5 and tbl_upv_15.lastLungeName == "lunge" then
                    v400 = tbl_upv_15.shown
                    v396 = tbl_upv_15.shown ~= nil and tbl_upv_15.shown.clips ~= nil and tbl_upv_15.shown.clips.lunge_c ~= nil and "lunge_c" or v396
                end
            end
            tbl_upv_15.lastLungeT = tbl_upv_15.now
            tbl_upv_15.lastLungeName = v396
            if tbl_upv_15.shown and tbl_upv_15.shown.clips then
                v400 = tbl_upv_15.shown.clips[v396] and tbl_upv_15.shown.clips[v396].lungeRef or 0.24
            else
                v400 = 0.24
            end
            if tbl_upv_15.refreshGlintAt or tbl_upv_15.refreshFF then
                tbl_upv_15.refreshGlintAt = tbl_upv_15.now
            end
            tbl_upv_15.refreshFF = nil
            if not (startClip(v396, nil, nil, math.clamp(v395 / v400, 0.6, 2))) then
                local lunge_1 = tbl_upv_5.lunge
                if not lunge_1 then
                    return
                end
                tbl_upv_15.action = "lunge"
                tbl_upv_15.actT0 = tbl_upv_15.now
                tbl_upv_15.actDur = (v395 + 0.3) or (lunge_1.dur)
                tbl_upv_15.actMirror = 1
            end
        end
    elseif tbl_upv_15.leftOut or tbl_upv_15.leftVanishAt then
        tbl_upv_15.leftOut = false
        tbl_upv_15.leftVanishAt = nil
        tbl_upv_15.leftSeenOut = false
        tbl_upv_15.leftCatchT = tbl_upv_15.now
    end
end
function tbl_upv_1.ExternalEvent(a1, a2)
    --[[
      name: ExternalEvent
      line: 2692
      upvalues:
        u31 (ref,  index: 1)
        tbl_upv_15 (copy, index: 2)
        onEvent (copy, index: 3)
    ]]
    if not u31 then
        return
    end
    tbl_upv_15.now = os.clock()
    onEvent(a1, a2)
end
local function simulate(a1)
    --[[
      name: simulate
      line: 2706
      upvalues:
        Workspace_upv_1 (copy, index: 1)
        u30 (ref,  index: 2)
        tbl_upv_15 (copy, index: 3)
        resetState (copy, index: 4)
        ViewFx_upv_1 (copy, index: 5)
        onEvent (copy, index: 6)
        step (copy, index: 7)
        Combat_upv_1 (copy, index: 8)
        place (copy, index: 9)
    ]]
    local CurrentCamera_3 = Workspace_upv_1.CurrentCamera
    if not CurrentCamera_3 then
        return {err = "no camera"}
    end
    u30 = true
    tbl_upv_15.sim = true
    resetState()
    ViewFx_upv_1.Freeze(true)
    tbl_upv_15.shown = nil
    tbl_upv_15.wantId = nil
    local id_1 = a1.id
    local CFrame_4 = CurrentCamera_3.CFrame
    local v401 = tonumber(a1.t) or 0
    local v402 = a1.events or {}
    local tbl_35 = {}
    local v403 = tonumber(a1.speed) or 0
    local v404 = 0
    local v405 = 0
    local v406 = Vector3.new(0, 0, 0)
    local v407 = Vector3.new(0, 0, 0)
    local v408 = nil
    local v409 = -0.8
    local v410 = nil
    while v409 <= v401 + 0.004166666666666667 do
        local v411 = true
        v410 = 0
        for _, value_31 in a1.air or {} do
            if value_31[1] <= v409 then
                v410, v411 = value_31[2], value_31[3]
            end
        end
        v405 = v405 + v410 * 0.016666666666666666
        if v409 >= 0 then
            v404 = (v411 and ((v404 + ((((v403 * 0.016666666666666666) / 7) * 2) * math.pi)) % 12.566370614359172)) or v404
        end
        if (v409 >= 0) and (v411) then
            v410 = math.clamp((v403 - 1) / 20, 0, 1.25)
        else
            v410 = 0
        end
        tbl_upv_15.now = v409 + 1000
        if v401 + 0.004166666666666667 < v409 + 0.016666666666666666 then
            table.clear(tbl_upv_15.fxQueue)
        end
        for key_6, value_32 in v402 do
            if tbl_35[key_6] then
                continue
            end
            if value_32[1] <= v409 then
                tbl_35[key_6] = true
                onEvent(value_32[2], value_32[3])
            end
        end
        local switch_1 = a1.switch
        local v412 = nil
        if not (switch_1) or not (switch_1[1] <= v409) then
            v412 = id_1
            local slide_1 = a1.slide
            local v413 = (slide_1 ~= nil) and ((slide_1[1] <= v409) and (v409 < slide_1[2]))
            local tbl_36 = {visible = true, bobAmount = 0, grounded = 0, dt = 0.016666666666666666, aiming = 0, rootY = 0, fov = 0, wall = 0, sliding = 0, bobPhase = 0}
            tbl_36.now = v409 + 1000
            tbl_36.id = v412
            tbl_36.kind = Combat_upv_1.Kind(v412)
            tbl_36.cam = CFrame_4
            local v414 = tonumber(a1.fov) or (CurrentCamera_3.FieldOfView)
            tbl_36.fov = v414
            tbl_36.grounded = v411
            tbl_36.rootY = v405
            tbl_36.sliding = v413
            if a1.aiming ~= true then
                tbl_36.aiming = false
                tbl_36.bobPhase = v404
                tbl_36.bobAmount = v410
                tbl_36.wall = a1.wall
                local v415, v416, v417 = step(tbl_36)
                v409 = v409 + 0.016666666666666666
                v406, v407, v408 = v415, v416, v417
                continue
            end
            tbl_36.aiming = false
            tbl_36.bobPhase = v404
            tbl_36.bobAmount = v410
            tbl_36.wall = a1.wall
            local v415, v416, v417 = step(tbl_36)
            v409 = v409 + 0.016666666666666666
            v406, v407, v408 = v415, v416, v417
        end
        v412 = switch_1[2]
        local slide_1 = a1.slide
        local v413 = (slide_1 ~= nil) and ((slide_1[1] <= v409) and (v409 < slide_1[2]))
        local tbl_36 = {visible = true, bobAmount = 0, grounded = 0, dt = 0.016666666666666666, aiming = 0, rootY = 0, fov = 0, wall = 0, sliding = 0, bobPhase = 0}
        tbl_36.now = v409 + 1000
        tbl_36.id = v412
        tbl_36.kind = Combat_upv_1.Kind(v412)
        tbl_36.cam = CFrame_4
        local v414 = tonumber(a1.fov) or (CurrentCamera_3.FieldOfView)
        tbl_36.fov = v414
        tbl_36.grounded = v411
        tbl_36.rootY = v405
        tbl_36.sliding = v413
        if a1.aiming ~= true or v409 >= 0 or a1.aiming == true and not (v409 >= 0) then
            tbl_36.aiming = false
            tbl_36.bobPhase = v404
            tbl_36.bobAmount = v410
            tbl_36.wall = a1.wall
            local v415, v416, v417 = step(tbl_36)
            v409 = v409 + 0.016666666666666666
            v406, v407, v408 = v415, v416, v417
        end
    end
    local v418 = tonumber(a1.fov) or (CurrentCamera_3.FieldOfView)
    place(CurrentCamera_3, CFrame_4, v418, v406, v407, v408)
    local tbl_37 = {shown = 0, rot = 0, pos = 0}
    tbl_37.shown = v408 ~= nil
    tbl_37.pos = {v406.X, v406.Y, v406.Z}
    tbl_37.rot = {v407.X / 0.017453292519943295, v407.Y / 0.017453292519943295, v407.Z / 0.017453292519943295}
    return tbl_37
end
local u35 = false
function tbl_upv_1.Start()
    --[[
      name: Start
      line: 2776
      upvalues:
        u35 (ref,  index: 1)
        ViewFx_upv_1 (copy, index: 2)
        ReplicatedStorage_upv_1 (copy, index: 3)
        u1 (ref,  index: 4)
        u2 (ref,  index: 5)
        LocalPlayer_upv_1 (copy, index: 6)
        resetState (copy, index: 7)
        tbl_upv_15 (copy, index: 8)
        u23 (ref,  index: 9)
        tbl_upv_25 (copy, index: 10)
        u26 (ref,  index: 11)
        BladeSmear_upv_1 (copy, index: 12)
        tbl_upv_1 (copy, index: 13)
        u30 (ref,  index: 14)
        u31 (ref,  index: 15)
        onEvent (copy, index: 16)
        RunService_upv_1 (copy, index: 17)
        render (copy, index: 18)
        simulate (copy, index: 19)
        tbl_upv_3 (copy, index: 20)
        tbl_upv_4 (copy, index: 21)
        tbl_upv_6 (copy, index: 22)
        BladeClips_upv_1 (copy, index: 23)
        tbl_upv_2 (copy, index: 24)
        u19 (copy, index: 25)
        u22 (copy, index: 26)
        ItemClips_upv_1 (copy, index: 27)
        u33 (ref,  index: 28)
        u32 (ref,  index: 29)
        u34 (ref,  index: 30)
    ]]
    if u35 then
        return
    end
    u35 = true
    ViewFx_upv_1.Preload()
    local v419 = ReplicatedStorage_upv_1:WaitForChild("Assets", 30)
    local v420 = v419 and (v419:WaitForChild("Weapons", 30))
    u1 = v420
    local v421 = v419 and (v419:FindFirstChild("ViewModels"))
    u2 = v421
    task.spawn(
        function()
            --[[
              line: 2786
              upvalues:
                u2 (ref, index: 1)
                u1 (ref, index: 2)
            ]]
            local tbl_upv_38 = {}
            for _, value_33 in {u2, u1} do
                if value_33 then
                    table.insert(tbl_upv_38, value_33)
                end
            end
            pcall(
                function()
                    --[[
                      line: 2793
                      upvalues:
                        tbl_upv_38 (copy, index: 1)
                    ]]
                    game:GetService("ContentProvider"):PreloadAsync(tbl_upv_38)
                end
            )
        end
    )
    LocalPlayer_upv_1.CharacterAdded:Connect(
        function()
            --[[
              line: 2797
              upvalues:
                resetState (copy, index: 1)
                tbl_upv_15 (copy, index: 2)
                u23 (ref,  index: 3)
                tbl_upv_25 (copy, index: 4)
                u26 (ref,  index: 5)
                BladeSmear_upv_1 (copy, index: 6)
                ViewFx_upv_1 (copy, index: 7)
            ]]
            resetState()
            tbl_upv_15.shown = nil
            tbl_upv_15.wantId = nil
            if u23 then
                u23.Parent = nil
                u23 = nil
            end
            for _, value_34 in tbl_upv_25 do
                value_34.Parent = nil
            end
            if u26 then
                u26.Parent = nil
                u26 = nil
            end
            BladeSmear_upv_1.Hide()
            ViewFx_upv_1.Hide()
            tbl_upv_15.embers = false
            tbl_upv_15.fuse = 0
        end
    )
    task.spawn(
        function()
            --[[
              line: 2804
              upvalues:
                LocalPlayer_upv_1 (copy, index: 1)
                tbl_upv_1 (copy, index: 2)
                u30 (ref,  index: 3)
                u31 (ref,  index: 4)
                tbl_upv_15 (copy, index: 5)
                onEvent (copy, index: 6)
            ]]
            local v422 = LocalPlayer_upv_1:WaitForChild("PlayerScripts"):WaitForChild("Combat", 60)
            local _ = v422 and (v422:WaitForChild("Controller", 30))
            local v423 = v422 and (v422:WaitForChild("Effects", 30))
            if v423 then
                local v424 = nil
                if v423:IsA("ModuleScript") then
                    local success_6, v424 = pcall(require, v423)
                    if success_6 and type(v424) == "table" and type(v424.SetViewHandOff) == "function" then
                        v424.SetViewHandOff(tbl_upv_1.ReleasePoint, tbl_upv_1.ReleaseDelay)
                    end
                end
            end
            if not v422 then
                return
            end
            if v422:IsA("ModuleScript") then
                local success_7, v425 = pcall(require, v422)
                if not success_7 or type(v425) ~= "table" or type(v425.OnViewEvent) ~= "function" then
                    return
                end
                v425.OnViewEvent(
                    function(a1, a2)
                        --[[
                          line: 2818
                          upvalues:
                            u30 (ref,  index: 1)
                            u31 (ref,  index: 2)
                            tbl_upv_15 (copy, index: 3)
                            onEvent (copy, index: 4)
                        ]]
                        if (u30) or (u31) then
                            return
                        end
                        tbl_upv_15.now = os.clock()
                        onEvent(a1, a2)
                    end
                )
            end
        end
    )
    RunService_upv_1:BindToRenderStep("TribesViewModel", Enum.RenderPriority.Camera.Value + 2, render)
    if RunService_upv_1:IsStudio() then
        local v426 = Instance.new("BindableFunction")
        v426.Name = "ViewModelDebug"
        v426.OnInvoke = function(a3, a4)
            --[[
              line: 2831
              upvalues:
                simulate (copy, index: 1)
                u30 (ref,  index: 2)
                tbl_upv_15 (copy, index: 3)
                ViewFx_upv_1 (copy, index: 4)
                resetState (copy, index: 5)
                u23 (ref,  index: 6)
                tbl_upv_25 (copy, index: 7)
                u26 (ref,  index: 8)
                BladeSmear_upv_1 (copy, index: 9)
                tbl_upv_3 (copy, index: 10)
                tbl_upv_4 (copy, index: 11)
                tbl_upv_6 (copy, index: 12)
                BladeClips_upv_1 (copy, index: 13)
                tbl_upv_2 (copy, index: 14)
                u19 (copy, index: 15)
                u22 (copy, index: 16)
                ItemClips_upv_1 (copy, index: 17)
                u33 (ref,  index: 18)
                u32 (ref,  index: 19)
                u34 (ref,  index: 20)
            ]]
            local key_7
            if a3 == "Sim" then
                return (simulate(a4))
            elseif a3 == "Live" then
                u30 = false
                tbl_upv_15.sim = false
                ViewFx_upv_1.Freeze(false)
                resetState()
                tbl_upv_15.shown = nil
                tbl_upv_15.wantId = nil
                if u23 then
                    u23.Parent = nil
                    u23 = nil
                end
                for key_7, value_35 in tbl_upv_25 do
                    value_35.Parent = nil
                end
                if u26 then
                    u26.Parent = nil
                    u26 = nil
                end
                BladeSmear_upv_1.Hide()
                ViewFx_upv_1.Hide()
                tbl_upv_15.embers = false
                tbl_upv_15.fuse = 0
                return true
            elseif a3 == "Tune" then
                local v427 = a4 or {}
                local kind_1 = v427.kind
                local v428 = kind_1 and (tbl_upv_3[v427.kind])
                if v428 then
                    if v427.rot then
                        v428.rot = Vector3.new(v427.rot[1], v427.rot[2], v427.rot[3])
                    end
                    if v427.pos then
                        kind_1.pos = Vector3.new(v427.pos[1], v427.pos[2], v427.pos[3])
                    end
                    if v427.len then
                        kind_1.len = v427.len
                    end
                    if v427.aimPos then
                        kind_1.aimPos = Vector3.new(v427.aimPos[1], v427.aimPos[2], v427.aimPos[3])
                    end
                    if v427.aimRot then
                        kind_1.aimRot = Vector3.new(v427.aimRot[1], v427.aimRot[2], v427.aimRot[3])
                    end
                    if type(v427.stock) == "table" then
                        local function v3(a5)
                            --[[
                              name: v3
                              line: 2866
                            ]]
                            if type(a5) == "table" and type(a5[1]) == "number" then
                                return (Vector3.new(a5[1], a5[2], a5[3]))
                            end
                            return a5
                        end
                        key_7 = kind_1.stock or {}
                        local v429 = nil
                        local v430 = nil
                        for key_8, value_36 in v427.stock do
                            if type(value_36) ~= "table" or type(value_36[1]) ~= "table" then
                                if type(value_36) ~= "table" then
                                    v429 = value_36
                                    key_7[key_8] = v429
                                    continue
                                end
                                if type(value_36[1]) ~= "number" then
                                    v429 = value_36
                                else
                                    v429 = Vector3.new(value_36[1], value_36[2], value_36[3])
                                end
                                key_7[key_8] = v429
                            end
                            v429 = {}
                            v430 = value_36[1]
                            if type(v430) ~= "table" or type(v430[1]) ~= "number" then
                                local v431 = value_36[2]
                                if type(v431) ~= "table" then
                                    v430 = v431
                                    v429[2] = v430
                                    key_7[key_8] = v429
                                    continue
                                end
                                if type(v431[1]) ~= "number" then
                                    v430 = v431
                                else
                                    v430 = Vector3.new(v431[1], v431[2], v431[3])
                                end
                                v429[2] = v430
                                key_7[key_8] = v429
                            end
                            local v431 = value_36[2]
                            if type(v431) == "table" and type(v431[1]) == "number" then
                                v430 = Vector3.new(v431[1], v431[2], v431[3])
                            else
                                v430 = v431
                            end
                            v429[2] = v430
                            key_7[key_8] = v429
                        end
                        kind_1.stock = key_7
                    end
                end
                if v427.id then
                    local v432 = tbl_upv_4[v427.id]
                    local id_2 = v427.id
                    local tbl_39 = {len = 0, rot = 0, barrel = 0, pos = 0}
                    local v433
                    if v427.fix then
                        v433 = Vector3.new(v427.fix[1], v427.fix[2], v427.fix[3])
                    else
                        v433 = nil
                    end
                    tbl_39.rot = v433
                    local v434
                    if v427.fixPos then
                        v434 = Vector3.new(v427.fixPos[1], v427.fixPos[2], v427.fixPos[3])
                    else
                        v434 = nil
                    end
                    tbl_39.pos = v434
                    tbl_39.len = v427.fixLen
                    local v435
                    if v427.barrel then
                        v435 = Vector3.new(v427.barrel[1], v427.barrel[2], v427.barrel[3])
                    else
                        v435 = v432 and (v432.barrel)
                    end
                    tbl_39.barrel = v435
                    tbl_upv_4[id_2] = tbl_39
                end
                for key_9, value_37 in tbl_upv_6 do
                    if v427.id and key_9 == v427.id or kind_1 and value_37.kind == v427.kind then
                        value_37.model:Destroy()
                        tbl_upv_6[key_9] = nil
                    end
                end
                return true
            elseif a3 ~= "Clips" then
                local v436 = nil
                if a3 ~= "ItemClip" then
                    if a3 ~= "State" then
                        return nil
                    end
                    local tbl_40 = {want = 0, charge = 0, action = 0, shown = 0, frames = 0, reload = 0, draw = 0, parent = 0, msPerFrame = 0, use = 0, wind = 0, block = 0, maxFrameMs = 0, frozen = 0}
                    tbl_40.shown = tbl_upv_15.shown and (tbl_upv_15.shown.id)
                    tbl_40.want = tbl_upv_15.wantId
                    tbl_40.frozen = u30
                    tbl_40.action = tbl_upv_15.action
                    tbl_40.block = tbl_upv_15.block
                    tbl_40.charge = tbl_upv_15.charge
                    tbl_40.draw = tbl_upv_15.draw
                    tbl_40.wind = tbl_upv_15.wind
                    tbl_40.use = tbl_upv_15.use
                    tbl_40.reload = tbl_upv_15.reload
                    tbl_40.parent = u23 and (u23.Parent and (u23.Parent.Name))
                    tbl_40.msPerFrame = ((u33 > 0) and (u32 / u33 * 1000)) or 0
                    tbl_40.maxFrameMs = u34 * 1000
                    tbl_40.frames = u33
                    return tbl_40
                else
                    local v427 = a4 or {}
                    v436 = ItemClips_upv_1.SETS[v427.kind]
                    if v436 and type(v427.draw) == "table" then
                        ItemClips_upv_1.DRAW[v427.kind] = v427.draw
                        for _, value_38 in tbl_upv_6 do
                            if value_38.kind == v427.kind then
                                value_38.drawFrom = v427.draw
                            end
                        end
                    end
                    if v436 and type(v427.name) == "string" and type(v427.clip) == "table" then
                        v436[v427.name] = v427.clip
                        return true
                    end
                    return v436 ~= nil
                end
            else
                local v427 = a4 or {}
                for _, value_39 in {"SWORD", "DAGGER"} do
                    if type(v427[value_39]) ~= "table" then
                        continue
                    end
                    for key_10, value_40 in v427[value_39] do
                        BladeClips_upv_1[value_39][key_10] = value_40
                    end
                end
                if type(v427.T) == "table" then
                    for key_11, value_41 in v427.T do
                        tbl_upv_2[key_11] = value_41
                    end
                    u19.frequency = tbl_upv_2.retHz
                    u19.damping = tbl_upv_2.retDamp
                    u22.frequency = tbl_upv_2.retHz
                    u22.damping = tbl_upv_2.retDamp
                end
                return true
            end
        end
        v426.Parent = LocalPlayer_upv_1
    end
end
return tbl_upv_1