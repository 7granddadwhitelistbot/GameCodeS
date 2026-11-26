local runService = game:GetService("RunService")
local Config = require(script.Parent.Config)
local v3 = {}
local v4 = runService:IsStudio() or game.PlaceId == Config.STAGING_PLACE_ID
v3.BUDGET = 12
v3.MAX_ITEMS = 6
v3.MAX_AMMO_BUNDLES = 3
v3.DEFAULT_AMMO_BUNDLES = 2
v3.AMMO_TYPES = {"arrows", "shot"}
local v5 = {
    arrows = table.freeze({id = "arrows", name = "Arrows", perBundle = 12, points = 1, description = "12 arrows for bows and crossbows."}),
    shot = table.freeze({id = "shot", name = "Bullets", perBundle = 5, points = 1, description = "5 bullets for the musket, flintlock and blunderbuss."}),
    fire_arrows = table.freeze({id = "fire_arrows", name = "Fire Arrows", perBundle = 6, points = 2, description = "6 burning arrows for bows and crossbows, fired before your plain arrows. A hit sets the target on fire.", as = "arrows", unlock = true, role = "Burning", burn = table.freeze({damage = 5, ticks = 3, interval = 0.5}), patch = table.freeze({radius = 3.5, duration = 1.5})})
}
table.insert(v3.AMMO_TYPES, "fire_arrows")
v3.AMMO = table.freeze(v5)
local v6 = {}

for _, ammoType in v3.AMMO_TYPES do
    local v9 = v3.AMMO[ammoType]

    if v9.as then
        v6[v9.as] = v6[v9.as] or {}
        table.insert(v6[v9.as], ammoType)
    end
end

local v10 = table.freeze({})

function v3.AltAmmo(key)
    --[[
      name: AltAmmo
      line: 131
      upvalues:
        v6 (copy, index: 1)
        v10 (copy, index: 2)
    ]]
    return type(key) == "string" and v6[key] or v10
end

local v12 = {}

for _, ammoType in v3.AMMO_TYPES do
    if v3.AMMO[ammoType].unlock then
        table.insert(v12, ammoType)
    end
end

table.freeze(v12)

function v3.UnlockAmmo()
    --[[
      name: UnlockAmmo
      line: 144
      upvalues:
        v12 (copy, index: 1)
    ]]
    return v12
end

v3.CATEGORIES = {"bow", "gun", "melee", "throwable", "utility", "healing", "armor"}
v3.CATEGORY_NAMES = {bow = "Bows", gun = "Powder guns", melee = "Melee", throwable = "Throwables", utility = "Utility", healing = "Healing", armor = "Armor"}
v3.DEFAULT_LOADOUT = table.freeze({armor = "hide_armor", items = table.freeze({"bronze_sword", "short_bow", "bandage"}), ammo = table.freeze({arrows = 3})})
v3.SLOTS = {"primary", "secondary", "melee", "utility"}
v3.SLOT_INDEX = {primary = 1, secondary = 2, melee = 3, utility = 4}
v3.SLOT_NAMES = {primary = "Primary", secondary = "Secondary", melee = "Melee", utility = "Utility"}
v3.STARTER_LOADOUT = table.freeze({primary = "short_bow", secondary = "throwing_knives", melee = "bronze_sword", utility = "fire_bomb"})
v3.STAT_BARS = {{key = "damage", label = "Damage"}, {key = "rate", label = "Speed"}, {key = "range", label = "Range"}}
v3.KINDS = {"Bow", "Crossbow", "Musket", "Pistol", "Blunderbuss", "Knives", "Javelin", "Sling", "Sword", "Axe", "Spear", "Dagger", "Club", "Bomb", "Herbs", "Trap", "Armor", "Horn", "Shield", "Gauntlets", "Scythe", "Katana", "Hatchets"}
local v15 = {
    {
        id = "short_bow",
        name = "Wood Bow",
        category = "bow",
        points = 3,
        hotbar = true,
        slot = "primary",
        kind = "Bow",
        role = "Skirmisher",
        description = "A quick-drawing bow. Hold to draw, release to shoot; arrows drop over distance. Uses arrows.",
        unlock = false,
        stats = {damage = 4.5, rate = 8, range = 6.5},
        details = {{"Damage", "40 (70 head)"}, {"Draw", "0.5 s"}, {"Ammo", "arrows"}},
        tuning = {ammo = "arrows", damage = 40, damageMin = 8, drawTime = 0.5, speedMin = 120, speedMax = 250, gravity = 55, radius = 0.3, cooldown = 0.15, tapCooldown = 0.35, headshotMult = 1.75, aimFov = 55, drawSpeedMult = 0.8, speedMult = 1, projectile = "Arrow", range = 400}
    },
    {
        id = "longbow",
        name = "Headhunter",
        category = "bow",
        points = 5,
        hotbar = true,
        slot = "primary",
        kind = "Bow",
        role = "Sniper",
        description = "A long-range bow with a heavy draw. A fully drawn headshot kills. Aim to zoom. Uses arrows.",
        unlock = false,
        stats = {damage = 8.5, rate = 3, range = 10},
        details = {{"Damage", "72 (144 head)"}, {"Draw", "1.1 s"}, {"Ammo", "arrows"}},
        tuning = {ammo = "arrows", damage = 72, damageMin = 10, drawTime = 1.1, speedMin = 160, speedMax = 380, gravity = 32, radius = 0.28, cooldown = 0.3, tapCooldown = 0.6, headshotMult = 2, aimFov = 32, drawSpeedMult = 0.55, speedMult = 0.95, projectile = "Arrow", range = 600}
    },
    {
        id = "crossbow",
        name = "Crossbow",
        category = "bow",
        points = 4,
        hotbar = true,
        slot = "primary",
        kind = "Crossbow",
        role = "Marksman",
        description = "Fires a heavy bolt instantly, even while moving. Reloads after every shot. Uses arrows.",
        unlock = false,
        stats = {damage = 6.5, rate = 3.5, range = 8},
        details = {{"Damage", "50 (90 head)"}, {"Reload", "1.5 s"}, {"Ammo", "arrows"}},
        tuning = {ammo = "arrows", damage = 50, magazine = 1, reloadTime = 1.5, fireInterval = 0.2, speed = 320, gravity = 28, radius = 0.28, headshotMult = 1.8, aimFov = 48, speedMult = 0.95, aimSpeedMult = 0.85, projectile = "Bolt", range = 500}
    },
    {
        id = "musket",
        name = "Musket",
        category = "gun",
        points = 5,
        hotbar = true,
        slot = "primary",
        kind = "Musket",
        role = "Heavy",
        description = "One fast, heavy shot that crosses the map. Aim to steady it. Slow reload. Uses shot.",
        unlock = false,
        stats = {damage = 9.2, rate = 1.5, range = 9.5},
        details = {{"Damage", "82 (131 head)"}, {"Reload", "2.4 s"}, {"Ammo", "shot"}},
        tuning = {ammo = "shot", damage = 82, magazine = 1, reloadTime = 2.4, fireInterval = 0.3, speed = 900, gravity = 12, radius = 0.22, headshotMult = 1.6, spreadHip = 3.2, spreadAim = 0.25, aimFov = 40, speedMult = 0.92, aimSpeedMult = 0.6, reloadSpeedMult = 0.75, kick = 11, climb = 3.25, shake = 0.5, projectile = "Ball", range = 600, falloff = {start = 140, finish = 320, minMult = 0.7}}
    },
    {
        id = "blunderbuss",
        name = "Blunderbuss",
        category = "gun",
        points = 4,
        hotbar = true,
        slot = "primary",
        kind = "Blunderbuss",
        role = "Brawler",
        description = "A wide cone of pellets: lethal point-blank, weak at range. Uses shot.",
        unlock = false,
        stats = {damage = 8.5, rate = 3, range = 2.5},
        details = {{"Damage", "8 × 12"}, {"Reload", "1.5 s"}, {"Ammo", "shot"}},
        tuning = {ammo = "shot", damage = 12, pellets = 8, spread = 6.5, spreadAim = 4.5, magazine = 1, reloadTime = 1.5, fireInterval = 0.3, speed = 420, gravity = 20, radius = 0.3, headshotMult = 1.5, aimFov = 60, speedMult = 0.95, aimSpeedMult = 0.8, kick = 13, climb = 3.9, shake = 0.6, knockback = 18, projectile = "Pellet", range = 90, falloff = {start = 14, finish = 45, minMult = 0.25}}
    },
    {
        id = "throwing_knives",
        name = "Throwing Knives",
        category = "throwable",
        points = 2,
        hotbar = true,
        slot = "secondary",
        kind = "Knives",
        role = "Finisher",
        description = "Fast, flat throws. Five knives per round.",
        unlock = false,
        stats = {damage = 4, rate = 9, range = 5.5},
        details = {{"Damage", "30 (45 head)"}, {"Knives", "5 per round"}, {"Rate", "0.28 s"}},
        tuning = {damage = 30, charges = 5, fireInterval = 0.28, speed = 240, gravity = 30, radius = 0.3, headshotMult = 1.5, speedMult = 1.05, projectile = "Knife", range = 300}
    },
    {
        id = "flintlock",
        name = "Flintlock",
        category = "gun",
        points = 3,
        hotbar = true,
        slot = "secondary",
        kind = "Pistol",
        role = "Duelist",
        description = "A single-shot pistol. Hits hard and fast; reloads after every shot. Uses shot.",
        unlock = false,
        stats = {damage = 5.5, rate = 4.5, range = 6.5},
        details = {{"Damage", "38 (68 head)"}, {"Reload", "1.4 s"}, {"Ammo", "shot"}},
        tuning = {ammo = "shot", damage = 38, magazine = 1, reloadTime = 1.4, fireInterval = 0.2, speed = 700, gravity = 20, radius = 0.25, headshotMult = 1.8, spreadHip = 1.4, spreadAim = 0.3, aimFov = 55, speedMult = 1.05, aimSpeedMult = 0.85, kick = 7, climb = 1.95, shake = 0.35, projectile = "Ball", range = 400, falloff = {start = 60, finish = 160, minMult = 0.6}}
    },
    {
        id = "javelins",
        name = "Javelins",
        category = "throwable",
        points = 2,
        hotbar = true,
        slot = "secondary",
        kind = "Javelin",
        role = "Impact",
        description = "Heavy throwing spears. Wind up for more power; hits knock enemies back. Three per round.",
        unlock = false,
        stats = {damage = 8, rate = 2.5, range = 7},
        details = {{"Damage", "35–55 (88 head)"}, {"Javelins", "3 per round"}, {"Kill", "2 body"}},
        tuning = {damage = 55, damageMin = 35, drawTime = 0.45, charges = 3, speedMin = 95, speedMax = 175, gravity = 62, radius = 0.45, cooldown = 0.45, headshotMult = 1.6, knockback = 32, drawSpeedMult = 0.75, speedMult = 1, projectile = "Javelin", range = 400}
    },
    {
        id = "sling",
        name = "Sling",
        category = "throwable",
        points = 1,
        hotbar = true,
        slot = "secondary",
        kind = "Sling",
        role = "Harasser",
        description = "Lobbed stones that arc over cover. Twelve per round.",
        unlock = false,
        stats = {damage = 4, rate = 7, range = 7},
        details = {{"Damage", "26 (46 head)"}, {"Stones", "12 per round"}, {"Rate", "0.45 s"}},
        tuning = {damage = 26, charges = 12, cooldown = 0.45, speed = 150, gravity = 85, radius = 0.35, headshotMult = 1.75, speedMult = 1.05, projectile = "Stone", range = 350}
    },
    {
        id = "bolas",
        name = "Bolas",
        category = "throwable",
        points = 2,
        hotbar = true,
        slot = "secondary",
        kind = "Knives",
        role = "Snare",
        description = "A spinning throw that tangles the legs: the enemy it hits is slowed and can't slide. Two per round.",
        unlock = false,
        stats = {damage = 1.5, rate = 4, range = 4.5},
        details = {{"Slow", "to 40% for 1.5 s"}, {"Damage", "12"}, {"Bolas", "2 per round"}},
        tuning = {damage = 12, charges = 2, fireInterval = 0.7, speed = 150, gravity = 45, radius = 0.7, headshotMult = 1, speedMult = 1.05, projectile = "Bolas", range = 160, slow = {mult = 0.4, duration = 1.5}}
    },
    {
        id = "harpoon",
        name = "Harpoon",
        category = "throwable",
        points = 4,
        hotbar = true,
        slot = "secondary",
        kind = "Javelin",
        role = "Hook",
        description = "Wind it up and hurl it: the enemy it hits is dragged toward you. Slow to ready again. Three per round.",
        unlock = false,
        stats = {damage = 5.5, rate = 2, range = 5.5},
        details = {{"Damage", "38–45 (68 head)"}, {"Pull", "11 studs"}, {"Wind-up", "0.6 s"}, {"Harpoons", "3 per round"}},
        tuning = {damage = 45, damageMin = 30, drawTime = 0.6, minCharge = 0.5, charges = 3, cooldown = 1, speedMin = 110, speedMax = 160, gravity = 55, radius = 0.5, headshotMult = 1.5, drawSpeedMult = 0.7, speedMult = 0.95, projectile = "Harpoon", range = 220, pull = {distance = 11, stop = 3.5}}
    },
    {
        id = "chakram",
        name = "Chakram",
        category = "throwable",
        points = 2,
        hotbar = true,
        slot = "secondary",
        kind = "Knives",
        role = "Trickshot",
        description = "A bladed ring that flies out and comes back, cutting on both passes. Catch it to throw again at once; miss the catch and it takes a moment to pick up.",
        unlock = false,
        stats = {damage = 3.5, rate = 5, range = 4.5},
        details = {{"Damage", "24 out, 24 back"}, {"Reach", "45 studs"}, {"Missed catch", "2 s"}},
        tuning = {damage = 24, charges = 1, fireInterval = 0.35, speed = 110, gravity = 0, radius = 0.9, headshotMult = 1, speedMult = 1.05, projectile = "Chakram", range = 45, returns = {range = 45, catch = 4.5, pickup = 2}}
    },
    {
        id = "bronze_sword",
        name = "Iron Sword",
        category = "melee",
        points = 3,
        hotbar = true,
        slot = "melee",
        kind = "Sword",
        role = "Balanced",
        description = "A fast three-hit combo; the third hit lands hardest. Hold aim to block.",
        unlock = false,
        stats = {damage = 6, rate = 7, range = 3},
        details = {{"Damage", "30 / 30 / 41"}, {"Block", "60% melee, 40% ranged"}, {"Kill", "3-hit combo"}},
        tuning = {damage = 30, cooldown = 0.42, comboWindow = 0.95, range = 9.5, arc = 70, maxTargets = 2, knockback = 14, speedMult = 1.05, combo = {1, 1, 1.35}, block = {melee = 0.6, ranged = 0.4, speedMult = 0.6}}
    },
    {
        id = "battle_axe",
        name = "Battle Axe",
        category = "melee",
        points = 4,
        hotbar = true,
        slot = "melee",
        kind = "Axe",
        role = "Bruiser",
        description = "Heavy chops. Hold aim to wind up an overhead strike that nearly halves a foe.",
        unlock = false,
        stats = {damage = 9, rate = 3.5, range = 3.2},
        details = {{"Damage", "44 / 56 (heavy 80)"}, {"Wind-up", "0.7 s"}, {"Kill", "2 chops"}},
        tuning = {damage = 44, cooldown = 0.78, comboWindow = 1.3, range = 10, arc = 60, maxTargets = 2, knockback = 22, speedMult = 0.95, combo = {1, 1.28}, heavy = {damage = 80, charge = 0.7, cooldown = 1.2, knockback = 50, range = 11, speedMult = 0.5}}
    },
    {
        id = "spear",
        name = "Spear",
        category = "melee",
        points = 4,
        hotbar = true,
        slot = "melee",
        kind = "Spear",
        role = "Reach",
        description = "The longest reach of any melee weapon. Hold aim to charge a lunge, release to dash forward.",
        unlock = false,
        stats = {damage = 6.5, rate = 5, range = 5},
        details = {{"Damage", "34 (lunge 55)"}, {"Reach", "13"}, {"Kill", "3 pokes / lunge + 2"}},
        tuning = {damage = 34, cooldown = 0.5, comboWindow = 1.1, range = 13, arc = 30, maxTargets = 2, knockback = 12, speedMult = 1, combo = {1, 1}, lunge = {damage = 55, charge = 0.6, cooldown = 1.5, speed = 72, distance = 16, range = 14, knockback = 38, speedMult = 0.55}}
    },
    {
        id = "obsidian_dagger",
        name = "Diamond Dagger",
        category = "melee",
        points = 2,
        hotbar = true,
        slot = "melee",
        kind = "Dagger",
        role = "Assassin",
        description = "Very fast stabs and a lighter step. Hits from behind deal 2.5× damage.",
        unlock = false,
        stats = {damage = 4.5, rate = 10, range = 2},
        details = {{"Damage", "25 (backstab 62)"}, {"Rate", "0.28 s"}, {"Kill", "4 stabs / 2 backstabs"}},
        tuning = {damage = 25, cooldown = 0.28, comboWindow = 0.7, range = 7.5, arc = 55, maxTargets = 1, knockback = 5, backstabMult = 2.5, backstabAngle = 70, speedMult = 1.12, combo = {1, 1}}
    },
    {
        id = "war_club",
        name = "Hammer",
        category = "melee",
        points = 3,
        hotbar = true,
        slot = "melee",
        kind = "Club",
        role = "Enforcer",
        description = "Every hit knocks enemies back and staggers them (never twice in a row).",
        unlock = false,
        stats = {damage = 7.5, rate = 5, range = 3},
        details = {{"Damage", "36 / 44"}, {"Stagger", "0.45 s"}, {"Kill", "3 hits (1.1 s)"}},
        tuning = {damage = 36, cooldown = 0.55, comboWindow = 1.2, range = 9.5, arc = 65, maxTargets = 2, knockback = 42, speedMult = 1, combo = {1, 1.22}, stagger = {duration = 0.45, speedMult = 0.45}}
    },
    {
        id = "gauntlets",
        name = "Gauntlets",
        category = "melee",
        points = 3,
        hotbar = true,
        slot = "melee",
        kind = "Gauntlets",
        role = "Brawler",
        description = "The fastest melee weapon: a four-punch combo whose last punch staggers. Aim to dash forward with a punch.",
        unlock = false,
        stats = {damage = 5.5, rate = 10, range = 2},
        details = {{"Damage", "20 / 20 / 20 / 32"}, {"4th punch", "staggers 0.3 s"}, {"Dash punch", "26, every 2.5 s"}},
        tuning = {damage = 20, cooldown = 0.22, comboWindow = 0.6, range = 7.5, arc = 55, maxTargets = 1, knockback = 6, speedMult = 1.08, combo = {1, 1, 1, 1.6}, finisher = {knockback = 24, stagger = {duration = 0.3, speedMult = 0.5}}, lunge = {damage = 26, charge = 0, cooldown = 2.5, speed = 60, distance = 9, range = 7, knockback = 20, speedMult = 1}}
    },
    {
        id = "scythe",
        name = "Scythe",
        category = "melee",
        points = 4,
        hotbar = true,
        slot = "melee",
        kind = "Scythe",
        role = "Reaper",
        description = "Wide sweeps that cut everyone in front of you. Aim to dash through them with a reaping slash: a kill brings the dash back at once.",
        unlock = false,
        stats = {damage = 8, rate = 3, range = 4.2},
        details = {{"Damage", "40 / 46, up to 3 at once"}, {"Reaping dash", "15 studs, 45 to each"}, {"Kill", "the dash is back"}},
        tuning = {damage = 40, cooldown = 0.85, comboWindow = 1.4, range = 11.5, arc = 80, maxTargets = 3, knockback = 10, speedMult = 0.96, combo = {1, 1.15}, lunge = {damage = 35, charge = 0, cooldown = 5, speed = 75, distance = 15, range = 8, arc = 70, knockback = 16, speedMult = 1, through = true, brake = true, refreshOnKill = true}}
    },
    {
        id = "katana",
        name = "Katana",
        category = "melee",
        points = 4,
        hotbar = true,
        slot = "melee",
        kind = "Katana",
        role = "Duelist",
        description = "Fast, clean cuts. Hold aim to parry: the next arrow flies back at its shooter, the next sword that hits you is staggered.",
        unlock = false,
        stats = {damage = 5.5, rate = 8, range = 3.2},
        details = {{"Damage", "24 / 24 / 24 / 36"}, {"Parry", "up to 1.5 s, then 5 s"}, {"Kill", "4 cuts"}},
        tuning = {damage = 24, cooldown = 0.29, comboWindow = 0.8, range = 9, arc = 55, maxTargets = 1, knockback = 8, speedMult = 1.06, combo = {1, 1, 1, 1.5}, parry = {cooldown = 5, maxHold = 1.5, arc = 150, grace = 0.1, speedMult = 0.7, stagger = {duration = 0.5, speedMult = 0.4}}}
    },
    {
        id = "twin_hatchets",
        name = "Twin Hatchets",
        category = "melee",
        points = 3,
        hotbar = true,
        slot = "melee",
        kind = "Hatchets",
        role = "Skirmisher",
        description = "Fast chops with a hatchet in each hand. Aim to throw one for 45, then walk over it to pick it back up (it flies back by itself after 5 s).",
        unlock = false,
        stats = {damage = 5.5, rate = 9, range = 6},
        details = {{"Damage", "24 / 24 / 24 / 34"}, {"Kill", "4 chops"}, {"Throw", "45 (head 68)"}, {"Pick up", "walk over it, or 5 s"}},
        tuning = {damage = 24, cooldown = 0.27, comboWindow = 0.7, range = 7.5, arc = 60, maxTargets = 1, knockback = 6, speedMult = 1.06, combo = {1, 1, 1, 1.4}, oneHanded = {cooldown = 0.34, combo = {1, 1}}, throw = {damage = 45, speed = 150, gravity = 40, radius = 0.75, headshotMult = 1.5, knockback = 8, range = 170, cooldown = 2, returnTime = 5, pickup = 8}}
    },
    {
        id = "shield",
        name = "Shield",
        category = "melee",
        points = 3,
        hotbar = true,
        slot = "melee",
        kind = "Shield",
        role = "Bulwark",
        description = "Hold aim to raise it: nothing shot or thrown gets through from the front, and most of a melee hit is stopped. It wears down as it blocks and breaks if it takes too much; it mends when it isn't hit. Click to bash. Slow while raised; blasts go around it.",
        unlock = false,
        stats = {damage = 2, rate = 3, range = 2.5},
        details = {{"Block", "all shots, 60% melee"}, {"Durability", "200, breaks for 5 s"}, {"Covers", "100° in front"}, {"Bash", "18 + knockback"}},
        tuning = {damage = 18, cooldown = 1.2, comboWindow = 0.5, range = 8, arc = 80, maxTargets = 1, knockback = 26, speedMult = 0.98, combo = {1}, block = {melee = 0.6, ranged = 1, arc = 100, explosion = 0, speedMult = 0.7, swapDelay = 0.5, durability = {max = 200, regen = 40, regenDelay = 2.5, brokenFor = 5}}}
    },
    {
        id = "fire_bomb",
        name = "Fireball",
        category = "utility",
        points = 2,
        hotbar = true,
        slot = "utility",
        kind = "Bomb",
        role = "Area",
        description = "Bursts into flames on impact: splash damage, burning, and burning ground for 3 s.",
        unlock = false,
        stats = {damage = 5, rate = 2, range = 5},
        details = {{"Damage", "38 + burn 15"}, {"Fire", "3 s"}, {"Charges", "2 per round"}},
        tuning = {charges = 2, drawTime = 0.35, speedMin = 60, speedMax = 110, gravity = 100, radius = 0.5, cooldown = 0.6, selfDamage = false, projectile = "FireBomb", speedMult = 1, splash = {damage = 38, radius = 11, minMult = 0.4, knockback = 30}, burn = {damage = 5, ticks = 3, interval = 0.5}, fireZone = {radius = 9, duration = 3}}
    },
    {
        id = "smoke_bomb",
        name = "Smoke Bomb",
        category = "utility",
        points = 1,
        hotbar = true,
        slot = "utility",
        kind = "Bomb",
        role = "Cover",
        description = "Bursts into a thick cloud that blocks sight for everyone.",
        unlock = false,
        stats = {damage = 0, rate = 2, range = 5},
        details = {{"Cloud", "13 studs, 7 s"}, {"Charges", "2 per round"}},
        tuning = {charges = 2, drawTime = 0.3, speedMin = 55, speedMax = 105, gravity = 100, radius = 0.5, cooldown = 0.6, projectile = "SmokeBomb", speedMult = 1, smoke = {radius = 13, duration = 7}}
    },
    {
        id = "bandage",
        name = "Bandage",
        category = "healing",
        points = 1,
        hotbar = true,
        slot = "utility",
        kind = "Herbs",
        role = "First aid",
        description = "Quick first aid: +35 health at once. Two per round; taking a hit interrupts it.",
        unlock = false,
        stats = {damage = 0, rate = 6, range = 0},
        details = {{"Heal", "+35 at once"}, {"Use", "0.6 s"}, {"Charges", "2 per round"}},
        tuning = {charges = 2, useTime = 0.6, heal = 35, healTime = 0, useSpeedMult = 0.55, interruptible = true, speedMult = 1}
    },
    {id = "healing_herbs", name = "Apple", category = "healing", points = 2, hotbar = true, slot = "utility", kind = "Herbs", role = "Sustain", description = "Eat to heal 50 over 2 seconds while you keep fighting. Two per round.", unlock = false, stats = {damage = 0, rate = 4, range = 0}, details = {{"Heal", "50 over 2 s"}, {"Use", "0.5 s"}, {"Charges", "2 per round"}}, tuning = {charges = 2, useTime = 0.5, heal = 50, healTime = 2, useSpeedMult = 0.6, interruptible = true, speedMult = 1}},
    {
        id = "healing_tonic",
        name = "Golden Apple",
        category = "healing",
        points = 3,
        hotbar = true,
        slot = "utility",
        kind = "Herbs",
        role = "Recovery",
        description = "Heals you to full at once and adds 30 golden armor for 8 seconds. One per round.",
        unlock = false,
        stats = {damage = 0, rate = 2, range = 0},
        details = {{"Heal", "to full, at once"}, {"Armor", "+30 for 8 s"}, {"Use", "0.8 s"}, {"Charges", "1 per round"}},
        tuning = {charges = 1, useTime = 0.8, heal = 100, healTime = 0, useSpeedMult = 0.5, interruptible = true, speedMult = 1, bonusArmor = {amount = 30, duration = 8}}
    },
    {
        id = "healing_flask",
        name = "Healing Flask",
        category = "healing",
        points = 3,
        hotbar = true,
        slot = "utility",
        kind = "Bomb",
        role = "Medic",
        description = "Throw it to splash a healing pool: you and your allies inside regain 50 health over 2 seconds. One per round.",
        unlock = false,
        stats = {damage = 0, rate = 1.5, range = 4},
        details = {{"Heal", "50 over 2 s, allies too"}, {"Pool", "10 studs"}, {"Charges", "1 per round"}},
        tuning = {charges = 1, drawTime = 0.3, speedMin = 55, speedMax = 105, gravity = 100, radius = 0.5, cooldown = 0.6, projectile = "Flask", speedMult = 1, healSplash = {amount = 50, time = 2, radius = 10}}
    },
    {
        id = "bear_trap",
        name = "Snap Trap",
        category = "utility",
        points = 1,
        hotbar = true,
        slot = "utility",
        kind = "Trap",
        role = "Ambush",
        description = "Set a hidden trap. The first enemy to step in is hurt and rooted in place.",
        unlock = false,
        stats = {damage = 4, rate = 2, range = 1.5},
        details = {{"Damage", "40 + root 2 s"}, {"Hidden", "past 15 studs"}, {"Charges", "2 per round"}},
        tuning = {charges = 2, useTime = 0.45, damage = 40, rootTime = 2, armTime = 0.8, triggerRadius = 3.2, maxActive = 2, placeRange = 7, hiddenBeyond = 15, speedMult = 1}
    },
    {
        id = "caltrops",
        name = "Caltrops",
        hidden = true,
        category = "utility",
        points = 1,
        hotbar = true,
        slot = "utility",
        kind = "Bomb",
        role = "Denial",
        description = "Toss a bag of iron spikes: they scatter into a patch that hurts and slows any enemy who walks in for 15 seconds. Everyone can see them; jump over them. Two per round.",
        unlock = false,
        stats = {damage = 2, rate = 2, range = 4.5},
        details = {{"Patch", "7 studs, 15 s"}, {"Inside", "5 per 0.5 s, 50% slow"}, {"Charges", "2 per round"}},
        tuning = {charges = 2, drawTime = 0.3, speedMin = 50, speedMax = 95, gravity = 100, radius = 0.5, cooldown = 0.6, projectile = "Caltrops", speedMult = 1, caltrops = {radius = 3.5, duration = 15, damage = 5, interval = 0.5, slow = 0.5, linger = 0.35, maxActive = 2}}
    },
    {
        id = "beehive",
        name = "Beehive",
        category = "utility",
        points = 2,
        hotbar = true,
        slot = "utility",
        kind = "Bomb",
        role = "Harass",
        description = "Throw a beehive: the swarm chases the nearest enemy it can see for a few seconds and stings. Run, or break its line of sight. Two per round.",
        unlock = false,
        stats = {damage = 3, rate = 2, range = 6},
        details = {{"Swarm", "4.5 s, chases"}, {"Stings", "4 per 0.4 s"}, {"Charges", "2 per round"}},
        tuning = {charges = 2, drawTime = 0.3, speedMin = 50, speedMax = 95, gravity = 100, radius = 0.5, cooldown = 0.6, projectile = "Beehive", speedMult = 1, bees = {duration = 4.5, seek = 32, speed = 18, reach = 4, damage = 4, interval = 0.4, lose = 0.6, maxActive = 2}}
    },
    {
        id = "palisade",
        name = "Palisade",
        category = "utility",
        points = 2,
        hotbar = true,
        slot = "utility",
        kind = "Trap",
        role = "Cover",
        description = "Plant a wall of stakes where you look: it stops arrows, shot and anyone in the way until it is chopped down or falls. One per round.",
        unlock = false,
        stats = {damage = 0, rate = 1, range = 2},
        details = {{"Wall", "6 wide, 6.5 tall"}, {"Health", "150, 20 s"}, {"Charges", "1 per round"}},
        tuning = {charges = 1, useTime = 0.45, placeRange = 8, speedMult = 1, wall = {width = 6, height = 6.5, health = 150, duration = 20}}
    },
    {
        id = "war_horn",
        name = "War Horn",
        category = "utility",
        points = 2,
        hotbar = true,
        slot = "utility",
        kind = "Horn",
        role = "Rally",
        description = "Blow it to mark every nearby enemy through walls for your tribe and speed your tribe up. It's loud: the enemy hears where you are. One per round.",
        unlock = false,
        stats = {damage = 0, rate = 1, range = 6},
        details = {{"Marks enemies", "60 studs, 3 s"}, {"Tribe speed", "+10% for 4 s"}, {"Charges", "1 per round"}},
        tuning = {charges = 1, useTime = 0.6, useSpeedMult = 0.8, interruptible = false, speedMult = 1, horn = {range = 60, reveal = 3, speedMult = 1.1, speedTime = 4}}
    },
    {id = "hide_armor", name = "Leather Armor", category = "armor", points = 2, hotbar = false, slot = "armor", kind = "Armor", role = "Light", description = "Light armor: absorbs damage before your health and takes 10% off ranged hits while it holds. Barely slows you.", unlock = false, stats = {damage = 0, rate = 0, range = 0}, details = {{"Armor", "25"}, {"Vs ranged", "−10%"}, {"Knockback", "full"}}, tuning = {armor = 25, speedMult = 0.97, knockbackMult = 1, rangedReduction = 0.1}},
    {id = "bone_armor", name = "Iron Armor", category = "armor", points = 4, hotbar = false, slot = "armor", kind = "Armor", role = "Medium", description = "Medium armor: takes 30% off ranged hits while it holds. A little slower, a little harder to knock back.", unlock = false, stats = {damage = 0, rate = 0, range = 0}, details = {{"Armor", "50"}, {"Vs ranged", "−30%"}, {"Knockback", "−15%"}}, tuning = {armor = 50, speedMult = 0.93, knockbackMult = 0.85, rangedReduction = 0.3}},
    {
        id = "bronze_armor",
        name = "Diamond Armor",
        category = "armor",
        points = 6,
        hotbar = false,
        slot = "armor",
        kind = "Armor",
        role = "Heavy",
        description = "Heavy armor: takes 40% off ranged hits while it holds. Slow, but hard to knock back and it survives a sniper headshot.",
        unlock = false,
        stats = {damage = 0, rate = 0, range = 0},
        details = {{"Armor", "80"}, {"Vs ranged", "−40%"}, {"Knockback", "−30%"}},
        tuning = {armor = 80, speedMult = 0.88, knockbackMult = 0.7, rangedReduction = 0.4}
    }
}
local v16 = {}

for index = #v15, 1, -1 do
    if v15[index].hidden then
        table.remove(v15, index)
    elseif v15[index].staging then
        v16[v15[index].id] = true

        if not v4 then
            table.remove(v15, index)
        end
    end
end

local v18 = {}
local v19 = {}
local v20 = {}

for v21, category in v3.CATEGORIES do
    v19[category] = {}
    v20[category] = v21
end

local v23 = {primary = {}, secondary = {}, melee = {}, utility = {}}
local v24 = {}

for v25, v26 in v15 do
    v24[v26] = v25
end

table.sort(
    v15,
    function(left, right)
        --[[
          line: 1338
          upvalues:
            v20 (copy, index: 1)
            v24 (copy, index: 2)
        ]]
        local v29 = v20[left.category] or 99
        local v30 = v20[right.category] or 99

        if v29 ~= v30 then
            return v29 < v30
        end

        return v24[left] < v24[right]
    end
)

for _, v32 in v15 do
    assert(v19[v32.category], "unknown category " .. tostring(v32.category) .. " for " .. v32.id)
    local v33 = type(v32.points) == "number" and 0 <= v32.points
    assert(v33, "points for " .. v32.id)
    v32.slotIndex = v3.SLOT_INDEX[v32.slot]
    v18[v32.id] = v32
    table.insert(v19[v32.category], v32)

    if v23[v32.slot] then
        table.insert(v23[v32.slot], v32)
    end

    table.freeze(v32.stats)
    table.freeze(v32.tuning)
    table.freeze(v32)
end

table.freeze(v15)

for _, v35 in v19 do
    table.freeze(v35)
end

for _, v37 in v23 do
    table.freeze(v37)
end

function v3.Get(key)
    --[[
      name: Get
      line: 1368
      upvalues:
        v18 (copy, index: 1)
    ]]
    if type(key) == "string" then
        return v18[key]
    end

    return nil
end

function v3.All()
    --[[
      name: All
      line: 1375
      upvalues:
        v15 (copy, index: 1)
    ]]
    return v15
end

function v3.IsStagingOnly(key)
    --[[
      name: IsStagingOnly
      line: 1381
      upvalues:
        v16 (copy, index: 1)
    ]]
    return type(key) == "string" and v16[key] == true
end

function v3.ByCategory(key)
    --[[
      name: ByCategory
      line: 1385
      upvalues:
        v19 (copy, index: 1)
    ]]
    return v19[key] or {}
end

function v3.IsValid(key)
    --[[
      name: IsValid
      line: 1389
      upvalues:
        v18 (copy, index: 1)
    ]]
    return type(key) == "string" and v18[key] ~= nil
end

function v3.IsHotbar(key)
    --[[
      name: IsHotbar
      line: 1394
      upvalues:
        v18 (copy, index: 1)
    ]]
    local v43 = type(key) == "string" and v18[key] or nil
    return v43 ~= nil and v43.hotbar
end

function v3.IsArmor(key)
    --[[
      name: IsArmor
      line: 1399
      upvalues:
        v18 (copy, index: 1)
    ]]
    local v45 = type(key) == "string" and v18[key] or nil
    return v45 ~= nil and v45.category == "armor"
end

function v3.Cost(a46)
    --[[
      name: Cost
      line: 1405
      upvalues:
        v18 (copy, index: 1)
        v3 (copy, index: 2)
    ]]
    if type(a46) ~= "table" then
        return 0
    end

    local v47 = 0

    if type(a46.items) == "table" then
        for _, item in a46.items do
            if const v50 = type(item) == "string" and v18[item] or nil then
                v47 += v50.points
            end
        end
    end

    local v51 = type(a46.armor) == "string" and v18[a46.armor] or nil

    if v51 and v51.category == "armor" then
        v47 += v51.points
    end

    if type(a46.ammo) == "table" then
        for v52, v53 in a46.ammo do
            if const v54 = type(v52) == "string" and v3.AMMO[v52] or nil then
                if type(v53) ~= "number" then
                    continue
                end
                if not (0 < v53) then
                    continue
                end

                v47 += v54.points * math.floor(v53)
            end
        end
    end

    return v47
end

function v3.AmmoOf(key)
    --[[
      name: AmmoOf
      line: 1434
      upvalues:
        v18 (copy, index: 1)
        v3 (copy, index: 2)
    ]]
    local v56 = type(key) == "string" and v18[key] or nil
    local ammo = v56 and v56.tuning.ammo

    if type(ammo) == "string" and v3.AMMO[ammo] then
        return ammo
    end

    return nil
end

function v3.AmmoNeeded(a58)
    --[[
      name: AmmoNeeded
      line: 1442
      upvalues:
        v3 (copy, index: 1)
    ]]
    local v59 = {}

    if type(a58) == "table" and type(a58.items) == "table" then
        for _, item in a58.items do
            if const v62 = v3.AmmoOf(item) then
                v59[v62] = true

                for _, v64 in v3.AltAmmo(v62) do
                    v59[v64] = true
                end
            end
        end
    end

    return v59
end

function v3.MissingAmmo(a65)
    --[[
      name: MissingAmmo
      line: 1459
      upvalues:
        v3 (copy, index: 1)
    ]]
    local v66 = {}
    local v67 = type(a65) == "table" and type(a65.ammo) == "table" and a65.ammo or {}

    local function has(key)
        --[[
          name: has
          line: 1462
          upvalues:
            v67 (copy, index: 1)
        ]]
        return type(v67[key]) == "number" and 1 <= v67[key]
    end

    for _, ammoType in v3.AMMO_TYPES do
        if v3.AMMO[ammoType].as == nil then
            if not v3.AmmoNeeded(a65)[ammoType] then
                continue
            end

            local v72 = type(v67[ammoType]) == "number" and 1 <= v67[ammoType]
            if v72 then
                continue
            end

            local v73 = false

            for _, v75 in v3.AltAmmo(ammoType) do
                local v76 = v73 or type(v67[v75]) == "number" and 1 <= v67[v75]
                v73 = v76
            end

            if v73 then
                continue
            end

            table.insert(v66, ammoType)
        end
    end

    return v66
end

function v3.AmmoRounds(a77, key)
    --[[
      name: AmmoRounds
      line: 1481
      upvalues:
        v3 (copy, index: 1)
    ]]
    local v79 = v3.AMMO[key]
    local v80 = type(a77) == "table" and type(a77.ammo) == "table" and a77.ammo[key] or 0

    if v79 and type(v80) == "number" then
        return math.max(0, (math.floor(v80))) * v79.perBundle
    end

    return 0
end

function v3.FromSlots(targets)
    --[[
      name: FromSlots
      line: 1489
      upvalues:
        v3 (copy, index: 1)
        v18 (copy, index: 2)
    ]]
    local items = {}

    if type(targets) == "table" then
        for _, slot in v3.SLOTS do
            local target = targets[slot]

            if type(target) == "string" then
                if not v18[target] then
                    continue
                end

                if v18[target].hotbar and not table.find(items, target) then
                    table.insert(items, target)
                end
            end
        end
    end

    return {armor = false, ammo = nil, items = items}
end

local function defaultCopy()
    --[[
      name: defaultCopy
      line: 1503
      upvalues:
        v3 (copy, index: 1)
    ]]
    return {items = table.clone(v3.DEFAULT_LOADOUT.items), armor = v3.DEFAULT_LOADOUT.armor, ammo = table.clone(v3.DEFAULT_LOADOUT.ammo)}
end

function v3.Validate(a87)
    --[[
      name: Validate
      line: 1526
      upvalues:
        defaultCopy (copy, index: 1)
        v3 (copy, index: 2)
        v18 (copy, index: 3)
    ]]
    if type(a87) ~= "table" then
        return false, "BadShape", (defaultCopy())
    end

    local v88
    local v89 = nil

    local function fail(a91)
        --[[
          name: fail
          line: 1531
          upvalues:
            v89 (ref, index: 1)
        ]]
        v89 = v89 or a91
    end

    if type(a87.items) == "table" then
        v88 = a87
    else
        v89 = v89 or "BadShape"
        v88 = a87.primary == nil
            and a87.secondary == nil
            and a87.melee == nil
            and a87.utility == nil
            and {items = {}, armor = a87.armor, ammo = a87.ammo}
            or v3.FromSlots(a87)
    end

    local items = {}
    local v93 = false
    local armor = v88.armor

    if armor ~= nil and armor ~= false then
        if v3.IsArmor(armor) then
            v93 = armor
        else
            v89 = v89 or "BadArmor"
        end
    end

    for _, item in v88.items do
        if const v97 = type(item) == "string" and v18[item] or nil then
            if v97.hotbar then
                if table.find(items, v97.id) then
                    v89 = v89 or "Duplicate"
                else
                    local itemCount = #items

                    if v3.MAX_ITEMS <= itemCount then
                        v89 = v89 or "TooManyItems"
                    else
                        table.insert(items, v97.id)
                    end
                end
            else
                v89 = v89 or "NotHotbar"

                if v97.category == "armor" then
                    if v93 ~= false then
                        continue
                    end

                    v93 = v97.id
                end
            end
        else
            v89 = v89 or "UnknownItem"
        end
    end

    if #items == 0 then
        v89 = v89 or "Empty"
        local v99 = v89
        local v100 = defaultCopy()

        return false, v99, v100
    end

    local ammo = {}

    if type(v88.ammo) ~= "table" then
        if v88.ammo ~= nil then
            v89 = v89 or "BadAmmo"
        else
            local v102 = v3.AmmoNeeded({items = items})

            if next(v102) then
                v89 = v89 or "MissingAmmo"

                for _, ammoType in v3.AMMO_TYPES do
                    if v102[ammoType] and v3.AMMO[ammoType].as == nil then
                        ammo[ammoType] = v3.DEFAULT_AMMO_BUNDLES
                    end
                end
            end
        end
    else
        for v105, v106 in v88.ammo do
            if type(v105) ~= "string" or not v3.AMMO[v105] then
                v89 = v89 or "UnknownAmmo"
            elseif type(v106) ~= "number" or v106 ~= v106 then
                v89 = v89 or "BadAmmo"
            else
                local clampedValue = math.clamp(math.floor(v106), 0, v3.MAX_AMMO_BUNDLES)

                if clampedValue ~= v106 and not v89 then
                    v89 = "BadAmmo"
                end

                if 0 < clampedValue then
                    ammo[v105] = clampedValue
                end
            end
        end
    end

    local v108 = {items = items, armor = v93, ammo = ammo}
    local v109 = v3.Cost(v108)

    if v3.BUDGET < v109 then
        v89 = v89 or "OverBudget"

        local function over()
            --[[
              name: over
              line: 1610
              upvalues:
                v3 (copy, index: 1)
                v108 (copy, index: 2)
            ]]
            local v111 = v3.Cost(v108)
            return v3.BUDGET < v111
        end

        local function dropUnusedAmmo()
            --[[
              name: dropUnusedAmmo
              line: 1613
              upvalues:
                v3 (copy, index: 1)
                v108 (copy, index: 2)
                ammo (copy, index: 3)
            ]]
            local v113 = v3.AmmoNeeded(v108)

            for v114 in ammo do
                if not v113[v114] then
                    ammo[v114] = nil
                end
            end
        end

        local v115 = v3.AmmoNeeded(v108)

        for v116 in ammo do
            if not v115[v116] then
                ammo[v116] = nil
            end
        end

        while true do
            local v117 = v3.Cost(v108)
            local v118

            if not (v3.BUDGET < v117) then
                break
            end

            local maxValue = 1
            v118 = nil

            for v120, v121 in ammo do
                if maxValue < v121 then
                    maxValue, v118 = v121, v120
                end
            end

            if not v118 then
                break
            end

            ammo[v118] = maxValue - 1
        end

        while true do
            local v122 = v3.Cost(v108)

            if not (v3.BUDGET < v122) then
                break
            end
            if not (1 < #items) then
                break
            end

            table.remove(items)
            local v123 = v3.AmmoNeeded(v108)

            for v124 in ammo do
                if not v123[v124] then
                    ammo[v124] = nil
                end
            end
        end

        local v125 = v3.Cost(v108)
        local v126 = v3.BUDGET < v125
        if v126 then
            v108.armor = false
        end

        local v127 = v3.Cost(v108)

        if v3.BUDGET < v127 then
            table.clear(ammo)
        end

        while true do
            local v128 = v3.Cost(v108)

            if not (v3.BUDGET < v128) then
                break
            end
            if not (1 < #items) then
                break
            end

            table.remove(items)
        end
    end

    local v129 = v89 == nil
    local v130 = v89

    return v129, v130, v108
end

function v3.BySlot(key)
    --[[
      name: BySlot
      line: 1653
      upvalues:
        v23 (copy, index: 1)
    ]]
    return v23[key] or {}
end

function v3.SlotOf(key)
    --[[
      name: SlotOf
      line: 1657
      upvalues:
        v18 (copy, index: 1)
    ]]
    local v133 = v18[key]
    return v133 and v133.slot or nil
end

function v3.IsStarter(key)
    --[[
      name: IsStarter
      line: 1663
      upvalues:
        v18 (copy, index: 1)
    ]]
    return v18[key] ~= nil
end

function v3.SanitizeLoadout(a135)
    --[[
      name: SanitizeLoadout
      line: 1668
      upvalues:
        v3 (copy, index: 1)
        v18 (copy, index: 2)
    ]]
    local values = table.clone(v3.STARTER_LOADOUT)

    if type(a135) == "table" then
        for _, valueKey in v3.SLOTS do
            local v139 = a135[valueKey]
            local v140 = type(v139) == "string" and v18[v139] or nil

            if v140 and v140.slot == valueKey then
                values[valueKey] = v139
            end
        end
    end

    return values
end

return v3