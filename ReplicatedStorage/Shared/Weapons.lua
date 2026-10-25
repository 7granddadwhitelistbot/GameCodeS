local RunService_1 = game:GetService("RunService")
local Config_1 = require(script.Parent.Config)
local tbl_upv_1 = {}
local v1 = RunService_1:IsStudio() or (game.PlaceId == Config_1.STAGING_PLACE_ID)
tbl_upv_1.BUDGET = 12
tbl_upv_1.MAX_ITEMS = 6
tbl_upv_1.MAX_AMMO_BUNDLES = 3
tbl_upv_1.DEFAULT_AMMO_BUNDLES = 2
tbl_upv_1.AMMO_TYPES = {"arrows", "shot"}
local tbl_2 = {}
tbl_2.arrows = table.freeze({name = "Arrows", id = "arrows", points = 1, description = "12 arrows for bows and crossbows.", perBundle = 12})
tbl_2.shot = table.freeze({name = "Bullets", id = "shot", points = 1, description = "6 bullets for the musket, flintlock and blunderbuss.", perBundle = 6})
tbl_2.fire_arrows = table.freeze({description = "6 burning arrows for bows and crossbows, fired before your plain arrows. A hit sets the target on fire.", id = "fire_arrows", unlock = true, perBundle = 6, role = "Burning", name = "Fire Arrows", as = "arrows", points = 2, burn = table.freeze({interval = 0.5, ticks = 3, damage = 5}), patch = table.freeze({duration = 1.5, radius = 3.5})})
table.insert(tbl_upv_1.AMMO_TYPES, "fire_arrows")
tbl_upv_1.AMMO = table.freeze(tbl_2)
local tbl_3 = {}
for _, value_1 in tbl_upv_1.AMMO_TYPES do
    local v2 = tbl_upv_1.AMMO[value_1]
    if v2.as then
        tbl_3[v2.as] = tbl_3[v2.as] or {}
        table.insert(tbl_3[v2.as], value_1)
    end
end
local u1 = table.freeze({})
function tbl_upv_1.AltAmmo(a1)
    --[[
      name: AltAmmo
      line: 130
      upvalues:
        u1 (copy, index: 2)
    ]]
    return u1
end
local tbl_upv_4 = {}
for _, value_2 in tbl_upv_1.AMMO_TYPES do
    if tbl_upv_1.AMMO[value_2].unlock then
        table.insert(tbl_upv_4, value_2)
    end
end
table.freeze(tbl_upv_4)
function tbl_upv_1.UnlockAmmo()
    --[[
      name: UnlockAmmo
      line: 143
      upvalues:
        tbl_upv_4 (copy, index: 1)
    ]]
    return tbl_upv_4
end
tbl_upv_1.CATEGORIES = {"bow", "gun", "melee", "throwable", "utility", "healing", "armor"}
tbl_upv_1.CATEGORY_NAMES = {throwable = "Throwables", melee = "Melee", healing = "Healing", armor = "Armor", gun = "Powder guns", bow = "Bows", utility = "Utility"}
tbl_upv_1.DEFAULT_LOADOUT = table.freeze({armor = "hide_armor", items = table.freeze({"bronze_sword", "short_bow", "bandage"}), ammo = table.freeze({arrows = 3})})
tbl_upv_1.SLOTS = {"primary", "secondary", "melee", "utility"}
tbl_upv_1.SLOT_INDEX = {utility = 4, primary = 1, melee = 3, secondary = 2}
tbl_upv_1.SLOT_NAMES = {utility = "Utility", primary = "Primary", melee = "Melee", secondary = "Secondary"}
tbl_upv_1.STARTER_LOADOUT = table.freeze({utility = "fire_bomb", primary = "short_bow", melee = "bronze_sword", secondary = "throwing_knives"})
tbl_upv_1.STAT_BARS = {{key = "damage", label = "Damage"}, {key = "rate", label = "Speed"}, {key = "range", label = "Range"}}
tbl_upv_1.KINDS = {"Bow", "Crossbow", "Musket", "Pistol", "Blunderbuss", "Knives", "Javelin", "Sling", "Sword", "Axe", "Spear", "Dagger", "Club", "Bomb", "Herbs", "Trap", "Armor", "Horn", "Shield", "Gauntlets", "Scythe", "Katana", "Hatchets"}
local tbl_5 = {"Damage", "40 (70 head)"}
local tbl_6 = {"Draw", "0.5 s"}
local tbl_7 = {"Damage", "72 (144 head)"}
local tbl_8 = {"Draw", "1.1 s"}
local tbl_9 = {description = "Fires a heavy bolt instantly, even while moving. Reloads after every shot. Uses arrows.", slot = "primary", id = "crossbow", unlock = false, role = "Marksman", name = "Crossbow", category = "bow", points = 4, kind = "Crossbow", hotbar = true}
tbl_9.stats = {range = 8, rate = 3.5, damage = 6.5}
tbl_9.details = {{"Damage", "50 (90 head)"}, {"Reload", "1.5 s"}, {"Ammo", "arrows"}}
tbl_9.tuning = {radius = 0.28, aimSpeedMult = 0.85, projectile = "Bolt", ammo = "arrows", range = 500, speedMult = 0.95, magazine = 1, headshotMult = 1.8, gravity = 28, speed = 320, reloadTime = 1.5, fireInterval = 0.2, aimFov = 48, damage = 50}
local tbl_10 = {description = "One fast, heavy shot that crosses the map. Aim to steady it. Slow reload. Uses shot.", slot = "primary", id = "musket", unlock = false, role = "Heavy", name = "Musket", category = "gun", points = 5, kind = "Musket", hotbar = true}
tbl_10.stats = {range = 9.5, rate = 1.5, damage = 9.5}
tbl_10.details = {{"Damage", "85 (136 head)"}, {"Reload", "2.4 s"}, {"Ammo", "shot"}}
tbl_10.tuning = {aimSpeedMult = 0.6, ammo = "shot", range = 600, speed = 900, aimFov = 40, damage = 85, radius = 0.22, projectile = "Ball", reloadSpeedMult = 0.75, shake = 0.5, magazine = 1, climb = 3.25, kick = 11, speedMult = 0.92, spreadAim = 0.25, spreadHip = 3.2, reloadTime = 2.4, headshotMult = 1.6, gravity = 12, fireInterval = 0.3, falloff = {start = 140, minMult = 0.7, finish = 320}}
local tbl_11 = {description = "A wide cone of pellets: lethal point-blank, weak at range. Uses shot.", slot = "primary", id = "blunderbuss", unlock = false, role = "Brawler", name = "Blunderbuss", category = "gun", points = 4, kind = "Blunderbuss", hotbar = true}
tbl_11.stats = {range = 2.5, rate = 3, damage = 9}
tbl_11.details = {{"Damage", "8 \195\151 13"}, {"Reload", "1.5 s"}, {"Ammo", "shot"}}
tbl_11.tuning = {aimSpeedMult = 0.8, ammo = "shot", range = 90, spreadAim = 4.5, spread = 6.5, damage = 13, projectile = "Pellet", radius = 0.3, knockback = 18, shake = 0.6, climb = 3.9, magazine = 1, kick = 13, speedMult = 1, aimFov = 60, headshotMult = 1.5, gravity = 20, reloadTime = 1.5, speed = 420, fireInterval = 0.3, pellets = 8, falloff = {start = 14, minMult = 0.25, finish = 45}}
local tbl_12 = {"Damage", "30 (45 head)"}
local tbl_13 = {"Knives", "5 per round"}
local tbl_14 = {"Damage", "42 (76 head)"}
local tbl_15 = {"Reload", "1.4 s"}
local tbl_16 = {aimSpeedMult = 0.85, ammo = "shot", range = 400, speed = 700, aimFov = 55, damage = 42, radius = 0.25, projectile = "Ball", shake = 0.35, magazine = 1, climb = 1.95, kick = 7, speedMult = 1.05, spreadAim = 0.3, spreadHip = 1.4, reloadTime = 1.4, headshotMult = 1.8, gravity = 20, fireInterval = 0.2}
tbl_16.falloff = {start = 60, minMult = 0.6, finish = 160}
local tbl_17 = {description = "Heavy throwing spears. Wind up for more power; hits knock enemies back. Three per round.", slot = "secondary", id = "javelins", unlock = false, role = "Impact", name = "Javelins", category = "throwable", points = 2, kind = "Javelin", hotbar = true}
tbl_17.stats = {range = 7, rate = 2.5, damage = 8}
tbl_17.details = {{"Damage", "35\226\128\14755 (88 head)"}, {"Javelins", "3 per round"}, {"Kill", "2 body"}}
tbl_17.tuning = {damageMin = 35, charges = 3, drawTime = 0.45, range = 400, gravity = 62, drawSpeedMult = 0.75, speedMax = 175, speedMult = 1, speedMin = 95, knockback = 32, headshotMult = 1.6, projectile = "Javelin", radius = 0.45, cooldown = 0.45, damage = 55}
local tbl_18 = {description = "Lobbed stones that arc over cover. Twelve per round.", slot = "secondary", id = "sling", unlock = false, role = "Harasser", name = "Sling", category = "throwable", points = 1, kind = "Sling", hotbar = true}
tbl_18.stats = {range = 7, rate = 7, damage = 4}
tbl_18.details = {{"Damage", "26 (46 head)"}, {"Stones", "12 per round"}, {"Rate", "0.45 s"}}
tbl_18.tuning = {charges = 12, gravity = 85, range = 350, projectile = "Stone", speedMult = 1.05, headshotMult = 1.75, speed = 150, radius = 0.35, cooldown = 0.45, damage = 26}
local tbl_19 = {description = "A spinning throw that tangles the legs: the enemy it hits is slowed and can't slide. Two per round.", slot = "secondary", id = "bolas", unlock = false, role = "Snare", name = "Bolas", category = "throwable", points = 2, kind = "Knives", hotbar = true}
tbl_19.stats = {range = 4.5, rate = 4, damage = 1.5}
tbl_19.details = {{"Slow", "to 40% for 1.5 s"}, {"Damage", "12"}, {"Bolas", "2 per round"}}
tbl_19.tuning = {charges = 2, gravity = 45, range = 160, projectile = "Bolas", speed = 150, radius = 0.7, headshotMult = 1, fireInterval = 0.7, speedMult = 1.05, damage = 12, slow = {duration = 1.5, mult = 0.4}}
local tbl_20 = {"Damage", "38\226\128\14745 (68 head)"}
local tbl_21 = {"Pull", "11 studs"}
local tbl_22 = {"Wind-up", "0.6 s"}
local tbl_23 = {"Damage", "24 out, 24 back"}
local tbl_24 = {"Reach", "45 studs"}
local tbl_25 = {description = "A fast three-hit combo; the third hit lands hardest. Hold aim to block.", slot = "melee", id = "bronze_sword", unlock = false, role = "Balanced", name = "Iron Sword", category = "melee", points = 3, kind = "Sword", hotbar = true}
tbl_25.stats = {range = 3, rate = 7, damage = 6}
tbl_25.details = {{"Damage", "30 / 30 / 41"}, {"Block", "60% melee, 40% ranged"}, {"Kill", "3-hit combo"}}
tbl_25.tuning = {knockback = 14, maxTargets = 2, comboWindow = 0.95, speedMult = 1.05, arc = 70, range = 9.5, cooldown = 0.42, damage = 30, combo = {1, 1, 1.35}, block = {ranged = 0.4, melee = 0.6, speedMult = 0.6}}
local tbl_26 = {"Damage", "44 / 56 (heavy 80)"}
local tbl_27 = {"Wind-up", "0.7 s"}
local tbl_28 = {knockback = 22, maxTargets = 2, comboWindow = 1.3, arc = 60, speedMult = 0.95, range = 10, cooldown = 0.78, damage = 44}
tbl_28.combo = {1, 1.28}
tbl_28.heavy = {charge = 0.7, speedMult = 0.5, range = 11, knockback = 50, cooldown = 1.2, damage = 80}
local tbl_29 = {description = "The longest reach of any melee weapon. Hold aim to charge a lunge, release to dash forward.", slot = "melee", id = "spear", unlock = false, role = "Reach", name = "Spear", category = "melee", points = 4, kind = "Spear", hotbar = true}
tbl_29.stats = {range = 5, rate = 5, damage = 6.5}
tbl_29.details = {{"Damage", "34 (lunge 55)"}, {"Reach", "13"}, {"Kill", "3 pokes / lunge + 2"}}
tbl_29.tuning = {knockback = 12, maxTargets = 2, comboWindow = 1.1, speedMult = 1, arc = 30, range = 13, cooldown = 0.5, damage = 34, combo = {1, 1}, lunge = {speedMult = 0.55, charge = 0.6, knockback = 38, range = 14, speed = 72, distance = 16, cooldown = 1.5, damage = 55}}
local tbl_30 = {description = "Very fast stabs and a lighter step. Hits from behind deal 2.5\195\151 damage.", slot = "melee", id = "obsidian_dagger", unlock = false, role = "Assassin", name = "Diamond Dagger", category = "melee", points = 2, kind = "Dagger", hotbar = true}
tbl_30.stats = {range = 2, rate = 10, damage = 4.5}
tbl_30.details = {{"Damage", "25 (backstab 62)"}, {"Rate", "0.28 s"}, {"Kill", "4 stabs / 2 backstabs"}}
tbl_30.tuning = {backstabAngle = 70, knockback = 5, maxTargets = 1, comboWindow = 0.7, speedMult = 1.12, arc = 55, backstabMult = 2.5, range = 7.5, cooldown = 0.28, damage = 25, combo = {1, 1}}
local tbl_upv_31 = {
    {
        description = "A quick-drawing bow. Hold to draw, release to shoot; arrows drop over distance. Uses arrows.",
        slot = "primary",
        id = "short_bow",
        unlock = false,
        role = "Skirmisher",
        name = "Wood Bow",
        category = "bow",
        points = 3,
        kind = "Bow",
        hotbar = true,
        stats = {range = 6.5, rate = 8, damage = 4.5},
        details = {tbl_5, tbl_6, {"Ammo", "arrows"}},
        tuning = {damageMin = 8, speedMax = 250, drawTime = 0.5, range = 400, gravity = 55, ammo = "arrows", drawSpeedMult = 0.8, speedMult = 1, tapCooldown = 0.35, speedMin = 120, aimFov = 55, headshotMult = 1.75, projectile = "Arrow", radius = 0.3, cooldown = 0.15, damage = 40}
    },
    {
        description = "A long-range bow with a heavy draw. A fully drawn headshot kills. Aim to zoom. Uses arrows.",
        slot = "primary",
        id = "longbow",
        unlock = false,
        role = "Sniper",
        name = "Headhunter",
        category = "bow",
        points = 5,
        kind = "Bow",
        hotbar = true,
        stats = {range = 10, rate = 3, damage = 8.5},
        details = {tbl_7, tbl_8, {"Ammo", "arrows"}},
        tuning = {damageMin = 10, speedMax = 380, drawTime = 1.1, range = 600, gravity = 32, ammo = "arrows", drawSpeedMult = 0.55, speedMult = 0.95, tapCooldown = 0.6, speedMin = 160, aimFov = 32, headshotMult = 2, projectile = "Arrow", radius = 0.28, cooldown = 0.3, damage = 72}
    },
    tbl_9,
    tbl_10,
    tbl_11,
    {
        description = "Fast, flat throws. Five knives per round.",
        slot = "secondary",
        id = "throwing_knives",
        unlock = false,
        role = "Finisher",
        name = "Throwing Knives",
        category = "throwable",
        points = 2,
        kind = "Knives",
        hotbar = true,
        stats = {range = 5.5, rate = 9, damage = 4},
        details = {tbl_12, tbl_13, {"Rate", "0.28 s"}},
        tuning = {charges = 5, gravity = 30, range = 300, projectile = "Knife", speed = 240, headshotMult = 1.5, fireInterval = 0.28, radius = 0.3, speedMult = 1.05, damage = 30}
    },
    {description = "A single-shot pistol. Hits hard and fast; reloads after every shot. Uses shot.", slot = "secondary", id = "flintlock", unlock = false, role = "Duelist", name = "Flintlock", category = "gun", points = 3, kind = "Pistol", hotbar = true, stats = {range = 6.5, rate = 4.5, damage = 6}, details = {tbl_14, tbl_15, {"Ammo", "shot"}}, tuning = tbl_16},
    tbl_17,
    tbl_18,
    tbl_19,
    {
        description = "Wind it up and hurl it: the enemy it hits is dragged toward you. Slow to ready again. Three per round.",
        slot = "secondary",
        id = "harpoon",
        unlock = false,
        role = "Hook",
        name = "Harpoon",
        category = "throwable",
        points = 4,
        kind = "Javelin",
        hotbar = true,
        stats = {range = 5.5, rate = 2, damage = 5.5},
        details = {tbl_20, tbl_21, tbl_22, {"Harpoons", "3 per round"}},
        tuning = {damageMin = 30, charges = 3, drawTime = 0.6, range = 220, minCharge = 0.5, gravity = 55, drawSpeedMult = 0.7, projectile = "Harpoon", speedMult = 0.95, speedMin = 110, radius = 0.5, headshotMult = 1.5, speedMax = 160, cooldown = 1, damage = 45, pull = {stop = 3.5, distance = 11}}
    },
    {
        description = "A bladed ring that flies out and comes back, cutting on both passes. Catch it to throw again at once; miss the catch and it takes a moment to pick up.",
        slot = "secondary",
        id = "chakram",
        unlock = false,
        role = "Trickshot",
        name = "Chakram",
        category = "throwable",
        points = 2,
        kind = "Knives",
        hotbar = true,
        stats = {range = 4.5, rate = 5, damage = 3.5},
        details = {tbl_23, tbl_24, {"Missed catch", "2 s"}},
        tuning = {charges = 1, gravity = 0, range = 45, projectile = "Chakram", speed = 110, headshotMult = 1, fireInterval = 0.35, radius = 0.9, speedMult = 1.05, damage = 24, returns = {pickup = 2, catch = 4.5, range = 45}}
    },
    tbl_25,
    {description = "Heavy chops. Hold aim to wind up an overhead strike that nearly halves a foe.", slot = "melee", id = "battle_axe", unlock = false, role = "Bruiser", name = "Battle Axe", category = "melee", points = 4, kind = "Axe", hotbar = true, stats = {range = 3.2, rate = 3.5, damage = 9}, details = {tbl_26, tbl_27, {"Kill", "2 chops"}}, tuning = tbl_28},
    tbl_29,
    tbl_30
}
local tbl_32 = {"Damage", "36 / 44"}
local tbl_33 = {"Stagger", "0.45 s"}
local tbl_34 = {knockback = 42, maxTargets = 2, comboWindow = 1.2, arc = 65, speedMult = 1, range = 9.5, cooldown = 0.55, damage = 36}
tbl_34.combo = {1, 1.22}
tbl_34.stagger = {speedMult = 0.45, duration = 0.45}
local tbl_35 = {description = "The fastest melee weapon: a four-punch combo whose last punch staggers. Aim to dash forward with a punch.", slot = "melee", id = "gauntlets", unlock = false, role = "Brawler", name = "Gauntlets", category = "melee", points = 3, kind = "Gauntlets", hotbar = true}
tbl_35.stats = {range = 2, rate = 10, damage = 5.5}
tbl_35.details = {{"Damage", "20 / 20 / 20 / 32"}, {"4th punch", "staggers 0.3 s"}, {"Dash punch", "26, every 2.5 s"}}
tbl_35.tuning = {knockback = 6, maxTargets = 1, comboWindow = 0.6, speedMult = 1.08, arc = 55, range = 7.5, cooldown = 0.22, damage = 20, combo = {1, 1, 1, 1.6}, finisher = {knockback = 24, stagger = {speedMult = 0.5, duration = 0.3}}, lunge = {speedMult = 1, charge = 0, knockback = 20, range = 7, speed = 60, distance = 9, cooldown = 2.5, damage = 26}}
local tbl_36 = {description = "Wide sweeps that cut everyone in front of you. Aim to dash through them with a reaping slash: a kill brings the dash back at once.", slot = "melee", id = "scythe", unlock = false, role = "Reaper", name = "Scythe", category = "melee", points = 4, kind = "Scythe", hotbar = true}
tbl_36.stats = {range = 4.2, rate = 3, damage = 8}
tbl_36.details = {{"Damage", "40 / 46, up to 3 at once"}, {"Reaping dash", "15 studs, 45 to each"}, {"Kill", "the dash is back"}}
tbl_36.tuning = {knockback = 10, maxTargets = 3, comboWindow = 1.4, speedMult = 0.96, arc = 80, range = 11.5, cooldown = 0.85, damage = 40, combo = {1, 1.15}, lunge = {charge = 0, brake = true, distance = 15, range = 8, refreshOnKill = true, through = true, speedMult = 1, arc = 70, speed = 75, knockback = 16, cooldown = 5, damage = 35}}
local tbl_37 = {description = "Fast, clean cuts. Hold aim to parry: the next arrow flies back at its shooter, the next sword that hits you is staggered.", slot = "melee", id = "katana", unlock = false, role = "Duelist", name = "Katana", category = "melee", points = 4, kind = "Katana", hotbar = true}
tbl_37.stats = {range = 3.2, rate = 8, damage = 5.5}
tbl_37.details = {{"Damage", "24 / 24 / 24 / 36"}, {"Parry", "up to 1.5 s, then 5 s"}, {"Kill", "4 cuts"}}
tbl_37.tuning = {knockback = 8, maxTargets = 1, comboWindow = 0.8, arc = 55, speedMult = 1.06, range = 9, cooldown = 0.29, damage = 24, combo = {1, 1, 1, 1.5}, parry = {maxHold = 1.5, grace = 0.1, arc = 150, cooldown = 5, speedMult = 0.7, stagger = {speedMult = 0.4, duration = 0.5}}}
local tbl_38 = {"Damage", "24 / 24 / 24 / 34"}
local tbl_39 = {"Kill", "4 chops"}
local tbl_40 = {"Throw", "45 (head 68)"}
local tbl_41 = {knockback = 6, maxTargets = 1, comboWindow = 0.7, speedMult = 1.06, arc = 60, range = 7.5, cooldown = 0.27, damage = 24}
tbl_41.combo = {1, 1, 1, 1.4}
tbl_41.oneHanded = {cooldown = 0.34, combo = {1, 1}}
tbl_41.throw = {radius = 0.75, gravity = 40, range = 170, returnTime = 5, pickup = 8, headshotMult = 1.5, speed = 150, knockback = 8, cooldown = 2, damage = 45}
local tbl_42 = {description = "Hold aim to raise it: nothing shot or thrown gets through from the front, and most of a melee hit is stopped. It wears down as it blocks and breaks if it takes too much; it mends when it isn't hit. Click to bash. Slow while raised; blasts go around it.", slot = "melee", id = "shield", unlock = false, role = "Bulwark", name = "Shield", category = "melee", points = 3, kind = "Shield", hotbar = true}
tbl_42.stats = {range = 2.5, rate = 3, damage = 2}
tbl_42.details = {{"Block", "all shots, 60% melee"}, {"Durability", "200, breaks for 5 s"}, {"Covers", "100\194\176 in front"}, {"Bash", "18 + knockback"}}
tbl_42.tuning = {knockback = 26, maxTargets = 1, comboWindow = 0.5, speedMult = 0.98, arc = 80, range = 8, cooldown = 1.2, damage = 18, combo = {1}, block = {ranged = 1, melee = 0.6, arc = 100, swapDelay = 0.5, explosion = 0, speedMult = 0.7, durability = {max = 200, brokenFor = 5, regen = 40, regenDelay = 2.5}}}
local tbl_43 = {description = "Bursts into flames on impact: splash damage, burning, and burning ground for 3 s.", slot = "utility", id = "fire_bomb", unlock = false, role = "Area", name = "Fireball", category = "utility", points = 2, kind = "Bomb", hotbar = true}
tbl_43.stats = {range = 5, rate = 2, damage = 5}
tbl_43.details = {{"Damage", "38 + burn 15"}, {"Fire", "3 s"}, {"Charges", "2 per round"}}
tbl_43.tuning = {charges = 2, drawTime = 0.35, gravity = 100, speedMult = 1, speedMax = 110, speedMin = 60, projectile = "FireBomb", radius = 0.5, cooldown = 0.6, selfDamage = false, splash = {minMult = 0.4, radius = 11, knockback = 30, damage = 38}, burn = {interval = 0.5, ticks = 3, damage = 5}, fireZone = {duration = 3, radius = 9}}
local tbl_44 = {description = "Bursts into a thick cloud that blocks sight for everyone.", slot = "utility", id = "smoke_bomb", unlock = false, role = "Cover", name = "Smoke Bomb", category = "utility", points = 1, kind = "Bomb", hotbar = true}
tbl_44.stats = {range = 5, rate = 2, damage = 0}
tbl_44.details = {{"Cloud", "13 studs, 7 s"}, {"Charges", "2 per round"}}
tbl_44.tuning = {charges = 2, drawTime = 0.3, gravity = 100, speedMin = 55, speedMult = 1, projectile = "SmokeBomb", radius = 0.5, cooldown = 0.6, speedMax = 105, smoke = {duration = 7, radius = 13}}
local tbl_45 = {description = "Quick first aid: +35 health at once. Two per round; taking a hit interrupts it.", slot = "utility", id = "bandage", unlock = false, role = "First aid", name = "Bandage", category = "healing", points = 1, kind = "Herbs", hotbar = true}
tbl_45.stats = {range = 0, rate = 6, damage = 0}
tbl_45.details = {{"Heal", "+35 at once"}, {"Use", "0.6 s"}, {"Charges", "2 per round"}}
tbl_45.tuning = {useSpeedMult = 0.55, charges = 2, heal = 35, interruptible = true, useTime = 0.6, speedMult = 1, healTime = 0}
local tbl_46 = {"Heal", "50 over 2 s"}
local tbl_47 = {"Use", "0.5 s"}
local tbl_48 = {"Heal", "to full, at once"}
local tbl_49 = {"Armor", "+30 for 8 s"}
local tbl_50 = {"Use", "0.8 s"}
local tbl_51 = {charges = 1, heal = 100, interruptible = true, useSpeedMult = 0.5, useTime = 0.8, speedMult = 1, healTime = 0}
tbl_51.bonusArmor = {duration = 8, amount = 30}
local tbl_52 = {description = "Throw it to splash a healing pool: you and your allies inside regain 50 health over 2 seconds. One per round.", slot = "utility", id = "healing_flask", unlock = false, role = "Medic", name = "Healing Flask", category = "healing", points = 3, kind = "Bomb", hotbar = true}
tbl_52.stats = {range = 4, rate = 1.5, damage = 0}
tbl_52.details = {{"Heal", "50 over 2 s, allies too"}, {"Pool", "10 studs"}, {"Charges", "1 per round"}}
tbl_52.tuning = {charges = 1, drawTime = 0.3, gravity = 100, speedMin = 55, speedMult = 1, projectile = "Flask", radius = 0.5, cooldown = 0.6, speedMax = 105, healSplash = {radius = 10, time = 2, amount = 50}}
local tbl_53 = {description = "Set a hidden trap. The first enemy to step in is hurt and rooted in place.", slot = "utility", id = "bear_trap", unlock = false, role = "Ambush", name = "Snap Trap", category = "utility", points = 1, kind = "Trap", hotbar = true}
tbl_53.stats = {range = 1.5, rate = 2, damage = 4}
tbl_53.details = {{"Damage", "40 + root 2 s"}, {"Hidden", "past 15 studs"}, {"Charges", "2 per round"}}
tbl_53.tuning = {rootTime = 2, charges = 2, maxActive = 2, placeRange = 7, useTime = 0.45, hiddenBeyond = 15, triggerRadius = 3.2, armTime = 0.8, speedMult = 1, damage = 40}
local tbl_54 = {description = "Toss a bag of iron spikes: they scatter into a patch that hurts and slows any enemy who walks in for 15 seconds. Everyone can see them; jump over them. Two per round.", slot = "utility", id = "caltrops", hidden = true, role = "Denial", name = "Caltrops", category = "utility", unlock = false, points = 1, kind = "Bomb", hotbar = true}
tbl_54.stats = {range = 4.5, rate = 2, damage = 2}
tbl_54.details = {{"Patch", "7 studs, 15 s"}, {"Inside", "5 per 0.5 s, 50% slow"}, {"Charges", "2 per round"}}
tbl_54.tuning = {charges = 2, drawTime = 0.3, gravity = 100, speedMin = 50, speedMult = 1, speedMax = 95, projectile = "Caltrops", radius = 0.5, cooldown = 0.6, caltrops = {radius = 3.5, linger = 0.35, maxActive = 2, interval = 0.5, duration = 15, slow = 0.5, damage = 5}}
local tbl_55 = {description = "Throw a beehive: the swarm chases the nearest enemy it can see for a few seconds and stings. Run, or break its line of sight. Two per round.", slot = "utility", id = "beehive", unlock = false, role = "Harass", name = "Beehive", category = "utility", points = 2, kind = "Bomb", hotbar = true}
tbl_55.stats = {range = 6, rate = 2, damage = 3}
tbl_55.details = {{"Swarm", "4.5 s, chases"}, {"Stings", "4 per 0.4 s"}, {"Charges", "2 per round"}}
tbl_55.tuning = {charges = 2, drawTime = 0.3, gravity = 100, speedMin = 50, speedMult = 1, projectile = "Beehive", radius = 0.5, cooldown = 0.6, speedMax = 95, bees = {maxActive = 2, interval = 0.4, lose = 0.6, reach = 4, speed = 18, duration = 4.5, seek = 32, damage = 4}}
tbl_upv_31[17], tbl_upv_31[18], tbl_upv_31[19], tbl_upv_31[20], tbl_upv_31[21], tbl_upv_31[22], tbl_upv_31[23], tbl_upv_31[24], tbl_upv_31[25], tbl_upv_31[26], tbl_upv_31[27], tbl_upv_31[28], tbl_upv_31[29], tbl_upv_31[30], tbl_upv_31[31], tbl_upv_31[32] = {
    description = "Every hit knocks enemies back and staggers them (never twice in a row).",
    slot = "melee",
    id = "war_club",
    unlock = false,
    role = "Enforcer",
    name = "Hammer",
    category = "melee",
    points = 3,
    kind = "Club",
    hotbar = true,
    stats = {range = 3, rate = 5, damage = 7.5},
    details = {tbl_32, tbl_33, {"Kill", "3 hits (1.1 s)"}},
    tuning = tbl_34
}, tbl_35, tbl_36, tbl_37, {description = "Fast chops with a hatchet in each hand. Aim to throw one for 45, then walk over it to pick it back up (it flies back by itself after 5 s).", slot = "melee", id = "twin_hatchets", unlock = false, role = "Skirmisher", name = "Twin Hatchets", category = "melee", points = 3, kind = "Hatchets", hotbar = true, stats = {range = 6, rate = 9, damage = 5.5}, details = {tbl_38, tbl_39, tbl_40, {"Pick up", "walk over it, or 5 s"}}, tuning = tbl_41}, tbl_42, tbl_43,
    tbl_44, tbl_45, {description = "Eat to heal 50 over 2 seconds while you keep fighting. Two per round.", slot = "utility", id = "healing_herbs", unlock = false, role = "Sustain", name = "Apple", category = "healing", points = 2, kind = "Herbs", hotbar = true, stats = {range = 0, rate = 4, damage = 0}, details = {tbl_46, tbl_47, {"Charges", "2 per round"}}, tuning = {useSpeedMult = 0.6, charges = 2, heal = 50, interruptible = true, useTime = 0.5, speedMult = 1, healTime = 2}},
    {description = "Heals you to full at once and adds 30 golden armor for 8 seconds. One per round.", slot = "utility", id = "healing_tonic", unlock = false, role = "Recovery", name = "Golden Apple", category = "healing", points = 3, kind = "Herbs", hotbar = true, stats = {range = 0, rate = 2, damage = 0}, details = {tbl_48, tbl_49, tbl_50, {"Charges", "1 per round"}}, tuning = tbl_51}, tbl_52, tbl_53, tbl_54, tbl_55,
    {
        description = "Plant a wall of stakes where you look: it stops arrows, shot and anyone in the way until it is chopped down or falls. One per round.",
        slot = "utility",
        id = "palisade",
        unlock = false,
        role = "Cover",
        name = "Palisade",
        category = "utility",
        points = 2,
        kind = "Trap",
        hotbar = true,
        stats = {range = 2, rate = 1, damage = 0},
        details = {{"Wall", "6 wide, 6.5 tall"}, {"Health", "150, 20 s"}, {"Charges", "1 per round"}},
        tuning = {charges = 1, placeRange = 8, useTime = 0.45, speedMult = 1, wall = {height = 6.5, duration = 20, health = 150, width = 6}}
    }
local tbl_56 = {"Marks enemies", "60 studs, 3 s"}
local tbl_57 = {"Tribe speed", "+10% for 4 s"}
local tbl_58 = {"Armor", "25"}
local tbl_59 = {"Vs ranged", "\226\136\14610%"}
local tbl_60 = {description = "Medium armor: takes 30% off ranged hits while it holds. A little slower, a little harder to knock back.", slot = "armor", id = "bone_armor", unlock = false, role = "Medium", name = "Iron Armor", category = "armor", points = 4, kind = "Armor", hotbar = false}
tbl_60.stats = {range = 0, rate = 0, damage = 0}
tbl_60.details = {{"Armor", "50"}, {"Vs ranged", "\226\136\14630%"}, {"Knockback", "\226\136\14615%"}}
tbl_60.tuning = {armor = 50, knockbackMult = 0.85, speedMult = 0.93, rangedReduction = 0.3}
local tbl_61 = {description = "Heavy armor: takes 40% off ranged hits while it holds. Slow, but hard to knock back and it survives a sniper headshot.", slot = "armor", id = "bronze_armor", unlock = false, role = "Heavy", name = "Diamond Armor", category = "armor", points = 6, kind = "Armor", hotbar = false}
tbl_61.stats = {range = 0, rate = 0, damage = 0}
tbl_61.details = {{"Armor", "80"}, {"Vs ranged", "\226\136\14640%"}, {"Knockback", "\226\136\14630%"}}
tbl_61.tuning = {armor = 80, knockbackMult = 0.7, speedMult = 0.88, rangedReduction = 0.4}
tbl_upv_31[33], tbl_upv_31[34], tbl_upv_31[35], tbl_upv_31[36] = {
    description = "Blow it to mark every nearby enemy through walls for your tribe and speed your tribe up. It's loud: the enemy hears where you are. One per round.",
    slot = "utility",
    id = "war_horn",
    unlock = false,
    role = "Rally",
    name = "War Horn",
    category = "utility",
    points = 2,
    kind = "Horn",
    hotbar = true,
    stats = {range = 6, rate = 1, damage = 0},
    details = {tbl_56, tbl_57, {"Charges", "1 per round"}},
    tuning = {useSpeedMult = 0.8, charges = 1, useTime = 0.6, speedMult = 1, interruptible = false, horn = {speedTime = 4, speedMult = 1.1, range = 60, reveal = 3}}
}, {description = "Light armor: absorbs damage before your health and takes 10% off ranged hits while it holds. Barely slows you.", slot = "armor", id = "hide_armor", unlock = false, role = "Light", name = "Leather Armor", category = "armor", points = 2, kind = "Armor", hotbar = false, stats = {range = 0, rate = 0, damage = 0}, details = {tbl_58, tbl_59, {"Knockback", "full"}}, tuning = {armor = 25, knockbackMult = 1, speedMult = 0.97, rangedReduction = 0.1}}, tbl_60, tbl_61
local tbl_upv_62 = {}
for n_1 = #tbl_upv_31, 1, -1 do
    if tbl_upv_31[n_1].hidden then
        table.remove(tbl_upv_31, n_1)
        continue
    end
    if not (tbl_upv_31[n_1].staging) then
        continue
    end
    tbl_upv_62[tbl_upv_31[n_1].id] = true
    if not (v1) then
        table.remove(tbl_upv_31, n_1)
    end
end
local tbl_upv_63 = {}
local tbl_upv_64 = {}
local tbl_upv_65 = {}
for key_1, value_3 in tbl_upv_1.CATEGORIES do
    tbl_upv_64[value_3] = {}
    tbl_upv_65[value_3] = key_1
end
local tbl_upv_66 = {}
tbl_upv_66.primary = {}
tbl_upv_66.secondary = {}
tbl_upv_66.melee = {}
tbl_upv_66.utility = {}
local tbl_upv_67 = {}
for key_2, value_4 in tbl_upv_31 do
    tbl_upv_67[value_4] = key_2
end
table.sort(
    tbl_upv_31,
    function(a1, a2)
        --[[
          line: 1331
          upvalues:
            tbl_upv_65 (copy, index: 1)
            tbl_upv_67 (copy, index: 2)
        ]]
        local v3 = tbl_upv_65[a1.category] or 99
        local v4 = tbl_upv_65[a2.category] or 99
        if v3 == v4 then
            return tbl_upv_67[a1] < tbl_upv_67[a2]
        end
        return v3 < v4
    end
)
for _, value_5 in tbl_upv_31 do
    assert(tbl_upv_64[value_5.category], "unknown category " .. tostring(value_5.category) .. " for " .. value_5.id)
    local v5 = (type(value_5.points) == "number") and (value_5.points >= 0)
    assert(v5, "points for " .. value_5.id)
    value_5.slotIndex = tbl_upv_1.SLOT_INDEX[value_5.slot]
    tbl_upv_63[value_5.id] = value_5
    table.insert(tbl_upv_64[value_5.category], value_5)
    if tbl_upv_66[value_5.slot] then
        table.insert(tbl_upv_66[value_5.slot], value_5)
    end
    table.freeze(value_5.stats)
    table.freeze(value_5.tuning)
    table.freeze(value_5)
end
table.freeze(tbl_upv_31)
for _, value_6 in tbl_upv_64 do
    table.freeze(value_6)
end
for _, value_7 in tbl_upv_66 do
    table.freeze(value_7)
end
function tbl_upv_1.Get(a1)
    --[[
      name: Get
      line: 1361
      upvalues:
        tbl_upv_63 (copy, index: 1)
    ]]
    if type(a1) == "string" then
        return tbl_upv_63[a1]
    end
    return nil
end
function tbl_upv_1.All()
    --[[
      name: All
      line: 1368
      upvalues:
        tbl_upv_31 (copy, index: 1)
    ]]
    return tbl_upv_31
end
function tbl_upv_1.IsStagingOnly(a1)
    --[[
      name: IsStagingOnly
      line: 1374
      upvalues:
        tbl_upv_62 (copy, index: 1)
    ]]
    local v6 = (type(a1) == "string") and (tbl_upv_62[a1] == true)
    return v6
end
function tbl_upv_1.ByCategory(a1)
    --[[
      name: ByCategory
      line: 1378
      upvalues:
        tbl_upv_64 (copy, index: 1)
    ]]
    return tbl_upv_64[a1] or {}
end
function tbl_upv_1.IsValid(a1)
    --[[
      name: IsValid
      line: 1382
      upvalues:
        tbl_upv_63 (copy, index: 1)
    ]]
    local v7 = (type(a1) == "string") and (tbl_upv_63[a1] ~= nil)
    return v7
end
function tbl_upv_1.IsHotbar(a1)
    --[[
      name: IsHotbar
      line: 1387
      upvalues:
        tbl_upv_63 (copy, index: 1)
    ]]
    local v8 = ((type(a1) == "string") and (tbl_upv_63[a1])) or nil
    local v9 = false
    if v8 ~= nil then
        v9 = v8.hotbar
    end
    return v9
end
function tbl_upv_1.IsArmor(a1)
    --[[
      name: IsArmor
      line: 1392
      upvalues:
        tbl_upv_63 (copy, index: 1)
    ]]
    local v10 = ((type(a1) == "string") and (tbl_upv_63[a1])) or nil
    local v11 = false
    if v10 ~= nil then
        v11 = v10.category == "armor"
    end
    return v11
end
function tbl_upv_1.Cost(a1)
    --[[
      name: Cost
      line: 1398
      upvalues:
        tbl_upv_63 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    if type(a1) ~= "table" then
        return 0
    end
    local v12 = 0
    if type(a1.items) == "table" then
        for _, value_8 in a1.items do
            local v13 = ((type(value_8) == "string") and (tbl_upv_63[value_8])) or nil
            if v13 then
                v12 = v12 + v13.points
            end
        end
    end
    local v14 = ((type(a1.armor) == "string") and (tbl_upv_63[a1.armor])) or nil
    if v14 and v14.category == "armor" then
        v12 = v12 + v14.points
    end
    if type(a1.ammo) == "table" then
        for key_3, value_9 in a1.ammo do
            local v15 = ((type(key_3) == "string") and (tbl_upv_1.AMMO[key_3])) or nil
            if not (v15) then
                continue
            end
            if type(value_9) == "number" then
                v12 = ((value_9 > 0) and (v12 + v15.points * math.floor(value_9))) or v12
            end
        end
    end
    return v12
end
function tbl_upv_1.AmmoOf(a1)
    --[[
      name: AmmoOf
      line: 1427
      upvalues:
        tbl_upv_63 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    local v16 = ((type(a1) == "string") and (tbl_upv_63[a1])) or nil
    local v17 = v16 and (v16.tuning.ammo)
    if type(v17) == "string" and tbl_upv_1.AMMO[v17] then
        return v17
    end
    return nil
end
function tbl_upv_1.AmmoNeeded(a1)
    --[[
      name: AmmoNeeded
      line: 1435
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local tbl_68 = {}
    if type(a1) == "table" and type(a1.items) == "table" then
        for _, value_10 in a1.items do
            local v18 = tbl_upv_1.AmmoOf(value_10)
            if not (v18) then
                continue
            end
            tbl_68[v18] = true
            for v19, value_11 in tbl_upv_1.AltAmmo(v18) do
                tbl_68[value_11] = true
            end
        end
    end
    return tbl_68
end
function tbl_upv_1.MissingAmmo(a1)
    --[[
      name: MissingAmmo
      line: 1452
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local tbl_69 = {}
    local u2 = ((type(a1) == "table" and type(a1.ammo) == "table") and (a1.ammo)) or {}
    local function has(a2)
        --[[
          name: has
          line: 1455
          upvalues:
            u2 (copy, index: 1)
        ]]
        local v19 = (type(u2[a2]) == "number") and (u2[a2] >= 1)
        return v19
    end
    for _, value_12 in tbl_upv_1.AMMO_TYPES do
        if tbl_upv_1.AMMO[value_12].as ~= nil or not (tbl_upv_1.AmmoNeeded(a1)[value_12]) then
            continue
        end
        local v20 = (type(u2[value_12]) == "number") and (u2[value_12] >= 1)
        if v20 then
            continue
        end
        local v21 = false
        v20 = v21
        for v23, value_13 in tbl_upv_1.AltAmmo(value_12) do
            v20 = v20 or type(u2[value_13]) == "number" and u2[value_13] >= 1
        end
        if not (v20) then
            table.insert(tbl_69, value_12)
        end
    end
    return tbl_69
end
function tbl_upv_1.AmmoRounds(a1, a2)
    --[[
      name: AmmoRounds
      line: 1474
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v23 = tbl_upv_1.AMMO[a2]
    local v24 = ((type(a1) == "table" and type(a1.ammo) == "table") and (a1.ammo[a2])) or 0
    if v23 and type(v24) == "number" then
        return math.max(0, math.floor(v24)) * v23.perBundle
    end
    return 0
end
function tbl_upv_1.FromSlots(a1)
    --[[
      name: FromSlots
      line: 1482
      upvalues:
        tbl_upv_1 (copy, index: 1)
        tbl_upv_63 (copy, index: 2)
    ]]
    local tbl_70 = {}
    if type(a1) == "table" then
        for _, value_14 in tbl_upv_1.SLOTS do
            local v25 = a1[value_14]
            if type(v25) ~= "string" or not (tbl_upv_63[v25]) or not (tbl_upv_63[v25].hotbar) then
                continue
            end
            if not (table.find(tbl_70, v25)) then
                table.insert(tbl_70, v25)
            end
        end
    end
    local tbl_71 = {armor = false}
    tbl_71.items = tbl_70
    return tbl_71
end
local function defaultCopy()
    --[[
      name: defaultCopy
      line: 1496
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local tbl_72 = {}
    tbl_72.items = table.clone(tbl_upv_1.DEFAULT_LOADOUT.items)
    tbl_72.armor = tbl_upv_1.DEFAULT_LOADOUT.armor
    tbl_72.ammo = table.clone(tbl_upv_1.DEFAULT_LOADOUT.ammo)
    return tbl_72
end
function tbl_upv_1.Validate(a1)
    --[[
      name: Validate
      line: 1519
      upvalues:
        defaultCopy (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        tbl_upv_63 (copy, index: 3)
    ]]
    if type(a1) ~= "table" then
        return false, "BadShape", (defaultCopy())
    end
    local u3 = nil
    local function fail(a2)
        --[[
          name: fail
          line: 1524
          upvalues:
            u3 (ref, index: 1)
        ]]
        if (u3) then
            return
        end
        u3 = a2
    end
    local tbl_upv_73
    if type(a1.items) == "table" then
        tbl_upv_73 = a1
    else
        if not (u3) then
            u3 = "BadShape"
        end
        if a1.primary == nil and a1.secondary == nil and a1.melee == nil and a1.utility == nil then
            local tbl_74 = {}
            tbl_74.items = {}
            tbl_74.armor = a1.armor
            tbl_74.ammo = a1.ammo
            tbl_upv_73 = tbl_74
        else
            tbl_upv_73 = tbl_upv_1.FromSlots(a1)
        end
    end
    local tbl_75 = {}
    local over = false
    local armor_1 = tbl_upv_73.armor
    if armor_1 ~= nil and armor_1 ~= false then
        if tbl_upv_1.IsArmor(armor_1) then
            over = armor_1
        elseif not (u3) then
            u3 = "BadArmor"
        end
    end
    for _, value_15 in tbl_upv_73.items do
        local v26 = ((type(value_15) == "string") and (tbl_upv_63[value_15])) or nil
        if v26 then
            if v26.hotbar then
                if table.find(tbl_75, v26.id) then
                    if not (u3) then
                        u3 = "Duplicate"
                    end
                else
                    if not (tbl_upv_1.MAX_ITEMS <= #tbl_75) then
                        table.insert(tbl_75, v26.id)
                        continue
                    end
                    if not (u3) then
                        u3 = "TooManyItems"
                    end
                end
            else
                if not (u3) then
                    u3 = "NotHotbar"
                end
                if v26.category ~= "armor" then
                    continue
                end
                if over == false then
                    over = v26.id
                end
            end
        elseif not (u3) then
            u3 = "UnknownItem"
        end
    end
    if #tbl_75 ~= 0 then
        local tbl_upv_76 = {}
        if type(tbl_upv_73.ammo) ~= "table" then
            local v27 = nil
            if tbl_upv_73.ammo == nil then
                v27 = tbl_upv_1.AmmoNeeded({items = tbl_75})
                if next(v27) then
                    if not (u3) then
                        u3 = "MissingAmmo"
                    end
                    for _, value_16 in tbl_upv_1.AMMO_TYPES do
                        if not (v27[value_16]) then
                            continue
                        end
                        if tbl_upv_1.AMMO[value_16].as == nil then
                            tbl_upv_76[value_16] = tbl_upv_1.DEFAULT_AMMO_BUNDLES
                        end
                    end
                end
            elseif not (u3) then
                u3 = "BadAmmo"
            end
        else
            for key_4, value_17 in tbl_upv_73.ammo do
                if type(key_4) == "string" and (tbl_upv_1.AMMO[key_4]) then
                    if (type(value_17) ~= "number" or value_17 ~= value_17) and not (u3) then
                        u3 = "BadAmmo"
                        continue
                    end
                    local v28 = math.clamp(math.floor(value_17), 0, tbl_upv_1.MAX_AMMO_BUNDLES)
                    if v28 ~= value_17 and not (u3) then
                        u3 = "BadAmmo"
                    end
                    if v28 > 0 then
                        tbl_upv_76[key_4] = v28
                    end
                elseif not (u3) then
                    u3 = "UnknownAmmo"
                end
            end
        end
        tbl_upv_73 = {}
        tbl_upv_73.items = tbl_75
        tbl_upv_73.armor = over
        tbl_upv_73.ammo = tbl_upv_76
        if tbl_upv_1.BUDGET < tbl_upv_1.Cost(tbl_upv_73) then
            if not (u3) then
                u3 = "OverBudget"
            end
            over = function()
                --[[
                  name: over
                  line: 1603
                  upvalues:
                    tbl_upv_1 (copy, index: 1)
                    tbl_upv_73 (copy, index: 2)
                ]]
                local v29 = tbl_upv_1.BUDGET < tbl_upv_1.Cost(tbl_upv_73)
                return v29
            end
            local function dropUnusedAmmo()
                --[[
                  name: dropUnusedAmmo
                  line: 1606
                  upvalues:
                    tbl_upv_1 (copy, index: 1)
                    tbl_upv_73 (copy, index: 2)
                    tbl_upv_76 (copy, index: 3)
                ]]
                local v30 = tbl_upv_1.AmmoNeeded(tbl_upv_73)
                for key_5 in tbl_upv_76 do
                    if not (v30[key_5]) then
                        tbl_upv_76[key_5] = nil
                    end
                end
            end
            local v31 = tbl_upv_1.AmmoNeeded(tbl_upv_73)
            for key_6 in tbl_upv_76 do
                if not (v31[key_6]) then
                    tbl_upv_76[key_6] = nil
                end
            end
            while true do
                tbl_upv_1 = tbl_upv_1.BUDGET < tbl_upv_1.Cost(tbl_upv_73)
                if not (tbl_upv_1) then
                    break
                end
                v31 = nil
                local v32 = 1
                for key_7, value_18 in tbl_upv_76 do
                    if v32 < value_18 then
                        v32, v31 = value_18, key_7
                    end
                end
            end
            while true do
                v31 = tbl_upv_1.BUDGET < tbl_upv_1.Cost(tbl_upv_73)
                if not (v31) or not (#tbl_75 > 1) then
                    break
                end
                table.remove(tbl_75)
                v31 = tbl_upv_1.AmmoNeeded(tbl_upv_73)
                for key_8 in tbl_upv_76 do
                    if not (v31[key_8]) then
                        tbl_upv_76[key_8] = nil
                    end
                end
            end
            v31 = tbl_upv_1.BUDGET < tbl_upv_1.Cost(tbl_upv_73)
            if v31 then
                tbl_upv_73.armor = false
            end
            v31 = tbl_upv_1.BUDGET < tbl_upv_1.Cost(tbl_upv_73)
            if v31 then
                table.clear(tbl_upv_76)
            end
            while true do
                v31 = tbl_upv_1.BUDGET < tbl_upv_1.Cost(tbl_upv_73)
                if not (v31) or not (#tbl_75 > 1) then
                    break
                end
                table.remove(tbl_75)
            end
        end
        local v33 = u3 == nil
        local v34 = u3
        return v33, v34, tbl_upv_73
    else
        if not (u3) then
            u3 = "Empty"
        end
        local v35 = u3
        local v36 = defaultCopy()
        return false, v35, v36
    end
end
function tbl_upv_1.BySlot(a1)
    --[[
      name: BySlot
      line: 1646
      upvalues:
        tbl_upv_66 (copy, index: 1)
    ]]
    return tbl_upv_66[a1] or {}
end
function tbl_upv_1.SlotOf(a1)
    --[[
      name: SlotOf
      line: 1650
      upvalues:
        tbl_upv_63 (copy, index: 1)
    ]]
    local v37 = tbl_upv_63[a1]
    return (v37 and (v37.slot)) or nil
end
function tbl_upv_1.IsStarter(a1)
    --[[
      name: IsStarter
      line: 1656
      upvalues:
        tbl_upv_63 (copy, index: 1)
    ]]
    return tbl_upv_63[a1] ~= nil
end
function tbl_upv_1.SanitizeLoadout(a1)
    --[[
      name: SanitizeLoadout
      line: 1661
      upvalues:
        tbl_upv_1 (copy, index: 1)
        tbl_upv_63 (copy, index: 2)
    ]]
    local v38 = table.clone(tbl_upv_1.STARTER_LOADOUT)
    if type(a1) == "table" then
        for _, value_19 in tbl_upv_1.SLOTS do
            local v39 = a1[value_19]
            local v40 = ((type(v39) == "string") and (tbl_upv_63[v39])) or nil
            if not (v40) then
                continue
            end
            if v40.slot == value_19 then
                v38[value_19] = v39
            end
        end
    end
    return v38
end
return tbl_upv_1