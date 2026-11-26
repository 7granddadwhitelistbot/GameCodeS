local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
game:GetService("UserInputService")
local shared = replicatedStorage:WaitForChild("Shared")
local Net = require(shared.Net)
local Simulation = require(shared:WaitForChild("Simulation"))
local Weapons = require(shared.Weapons)
local Combat = require(shared.Combat)
local Keybinds = require(shared:WaitForChild("Keybinds"))
local Loc = require(shared:WaitForChild("Loc"))
local Util = require(script.Parent.Util)
local Hud = require(script.Parent.Hud)
local Effects = require(script.Parent.Effects)
local Presentation = require(script.Parent.Presentation)
local Guard = require(script.Parent.Guard)
local Poses = require(script.Parent.Poses)
local Metrics = require(script.Parent.Metrics)
local Touch = require(script.Parent.Touch)
local Quality = require(script.Parent.Quality)
local World = require(script.Parent.World)
local RankFx = require(script.Parent.RankFx)
local v22 = {Melee = require(script.Parent.Handlers.Melee), Bow = require(script.Parent.Handlers.Bow), Gun = require(script.Parent.Handlers.Gun), Throw = require(script.Parent.Handlers.Throw), Use = require(script.Parent.Handlers.Use)}
local v23 = {Fists = "Melee", Sword = "Melee", Axe = "Melee", Spear = "Melee", Dagger = "Melee", Club = "Melee", Shield = "Melee", Gauntlets = "Melee", Scythe = "Melee", Katana = "Melee", Hatchets = "Melee", Bow = "Bow", Crossbow = "Gun", Musket = "Gun", Pistol = "Gun", Blunderbuss = "Gun", Knives = "Throw", Javelin = "Throw", Sling = "Throw", Bomb = "Throw", Herbs = "Use", Trap = "Use", Horn = "Use"}
local v24 = {}
local localPlayer = players.LocalPlayer
local v26 = nil
local v27 = {char = nil, hum = nil, root = nil, animator = nil, handler = nil, tool = nil, kind = nil, baseSpeed = 1, shotId = 0, lastSpeed = -1, killStreak = 0, lastKillAt = 0, pressed = {}, speed = {}, conns = {}}

local function alive()
    --[[
      name: alive
      line: 112
      upvalues:
        v27 (copy, index: 1)
    ]]
    return v27.hum ~= nil and 0 < v27.hum.Health and v27.char ~= nil and (v27.char.Parent ~= nil)
end

local function combatMode()
    --[[
      name: combatMode
      line: 118
      upvalues:
        localPlayer (copy, index: 1)
    ]]
    local combatMode = localPlayer:GetAttribute("CombatMode")
    if combatMode == nil then
        return localPlayer:GetAttribute("State") == "Match"
    end

    return combatMode == true
end

local v31 = nil
local count = 0
local timestamp = 0
local timestamp2 = 0
local v35 = setmetatable({}, {__mode = "k"})
local v36 = {requests = 0, stale = 0, adopted = 0, resent = 0, reasked = 0, denied = 0}
local timestamp3 = -math.huge
local InputStats = nil

local _ = setmetatable(
    {},
    {
        __index = (function(self, key)
            --[[
              name: __index
              line: 154
              upvalues:
                InputStats (ref,  index: 1)
                v27 (copy, index: 2)
            ]]
            if InputStats then
                InputStats.Note(128)
            end

            return v27[key]
        end),
        __newindex = (function(self, key, value)
            --[[
              name: __newindex
              line: 160
              upvalues:
                InputStats (ref,  index: 1)
                v27 (copy, index: 2)
            ]]
            if InputStats then
                InputStats.Note(128)
            end

            v27[key] = value
        end)
    }
)

local v45 = {}
local v46 = {}
local v47 = {shotId = 0, speed = {[v46] = true}}
local v48 = {shotId = 0, speed = {[v46] = true}}
local v49 = {shotId = 0, speed = {[v46] = true}}
local v50 = {shotId = 0, speed = {[v46] = true}}
local v51 = {shotId = 0, speed = {[v46] = true}}
local v52 = {shotId = 0, speed = {[v46] = true}}
local v53 = {shotId = 0, speed = {[v46] = true}}
local v54 = {shotId = 0, speed = {[v46] = true}}
local v55 = {shotId = 0, speed = {[v46] = true}}
local v56 = {shotId = 0, speed = {[v46] = true}}
local v57 = {shotId = 0, speed = {[v46] = true}}
local v58 = {v55, v50, v57, v53, v47, v51, v54, v56, v48, v52, v49}
local v59 = {shotId = 0}

local function copyDecoy()
    --[[
      name: copyDecoy
      line: 195
      upvalues:
        v45 (copy, index: 1)
        v59 (copy, index: 2)
        v27 (copy, index: 3)
        v58 (copy, index: 4)
        v46 (copy, index: 5)
        InputStats (ref,  index: 6)
    ]]
    local v61 = v45.lastSwing ~= v59.lastSwing or v45.holding ~= v59.holding
    local handler = v27.handler
    v45.lastSwing = if handler then rawget(handler, "lastSwing") else nil
    v45.holding = if handler then rawget(handler, "holding") else nil

    for _, v64 in v58 do
        if v64.handler ~= v59.handler or v64.shotId ~= v59.shotId or v64.speed[v46] ~= true then
            v61 = true
            v64.speed[v46] = true
        end

        v64.handler = if handler then v45 else nil
        v64.shotId = v27.shotId
    end

    if v61 and InputStats then
        InputStats.Note(256)
    end

    v59.handler = if handler then v45 else nil
    v59.shotId = v27.shotId
    v59.lastSwing = v45.lastSwing
    v59.holding = v45.holding
end

local function send(a66, a67)
    --[[
      name: send
      line: 217
      upvalues:
        InputStats (ref,  index: 1)
        v35 (copy, index: 2)
        v26 (ref,  index: 3)
    ]]
    if InputStats then
        InputStats.Caller(8192)
    end

    local tool = a67.tool

    if tool and v35[tool] then
        a67.eq = v35[tool]
    end

    a67.ct = os.clock()
    local dir = a67.dir

    if typeof(dir) == "Vector3" then
        a67.q = (dir.X * 3) + (dir.Y * 5) + (dir.Z * 7)
    end

    v26:FireServer(a66, a67)
end

local function nextId()
    --[[
      name: nextId
      line: 237
      upvalues:
        v27 (copy, index: 1)
    ]]
    v27.shotId += 1
    return v27.shotId
end

local v71 = {Aim = "Aim", Draw = "Charge", Throw = "Charge", Charge = "Charge", Block = "Block", Reload = "Reload", Use = "Use"}

local function applySpeed()
    --[[
      name: applySpeed
      line: 248
      upvalues:
        v27 (copy, index: 1)
        v71 (copy, index: 2)
        Simulation (copy, index: 3)
    ]]
    local v73 = {Aim = false, Charge = false, Block = false, Reload = false, Use = false}

    for v74 in v27.speed do
        if const v75 = v71[v74] then
            v73[v75] = true
        end
    end

    for v76, v77 in v73 do
        Simulation.SetInput(v76, v77)
    end
end

local function setSpeed(key, value)
    --[[
      name: setSpeed
      line: 261
      upvalues:
        Util (copy, index: 1)
        v27 (copy, index: 2)
        applySpeed (copy, index: 3)
    ]]
    local v81 = Util.Probe(key, value)
    if v81 ~= nil then
        return v81
    end

    v27.speed[key] = value
    applySpeed()
    return if const v82 = Util.ProbeValues() then v82.k * (value or 1) else nil
end

local v83 = {}

local function emitView(a85, a86)
    --[[
      name: emitView
      line: 277
      upvalues:
        v83 (copy, index: 1)
    ]]
    for _, v88 in v83 do
        local success, result = pcall(v88, a85, a86)
        if not success then
            warn("[Combat] view event listener error:", result)
        end
    end
end

function v24.OnViewEvent(target)
    --[[
      name: OnViewEvent
      line: 287
      upvalues:
        v83 (copy, index: 1)
    ]]
    table.insert(v83, target)
    return function()
        --[[
          line: 289
          upvalues:
            v83 (copy, index: 1)
            target (copy, index: 2)
        ]]
        if const index = table.find(v83, target) then
            table.remove(v83, index)
        end
    end
end

local function presetFor(a94, a95)
    --[[
      name: presetFor
      line: 297
      upvalues:
        Presentation (copy, index: 1)
    ]]
    return Presentation.For(a95, a94)
end

local function modelOf(a97)
    --[[
      name: modelOf
      line: 301
    ]]
    if typeof(a97) ~= "Instance" then
        return nil
    end
    if a97:IsA("Player") then
        return a97.Character
    end
    if a97:IsA("Model") then
        return a97
    end

    return nil
end

local function rootOf(a99)
    --[[
      name: rootOf
      line: 314
    ]]
    local v100

    if typeof(a99) == "Instance" then
        if a99:IsA("Player") then
            v100 = a99.Character
        else
            v100 = if a99:IsA("Model") then a99 else nil
        end
    else
        v100 = nil
    end

    local humanoidRootPart = v100 and v100:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart and humanoidRootPart:IsA("BasePart") then
        return humanoidRootPart
    end

    return nil
end

local function toolOf(a103)
    --[[
      name: toolOf
      line: 320
    ]]
    return a103 and a103:FindFirstChildOfClass("Tool") or nil
end

local function isFar(a105)
    --[[
      name: isFar
      line: 324
      upvalues:
        Effects (copy, index: 1)
    ]]
    return a105 ~= nil and Effects.NEAR < Effects.CamDistance(a105)
end

local function nameOf(character)
    --[[
      name: nameOf
      line: 328
      upvalues:
        players (copy, index: 1)
    ]]
    if not character then
        return nil
    end

    local displayName = character:GetAttribute("DisplayName")

    return if type(displayName) == "string" and displayName ~= "" then displayName elseif const player = players:GetPlayerFromCharacter(character) then player.DisplayName elseif character:HasTag("TrainingDummy") then "Dummy" else character.Name
end

local function dropHandler()
    --[[
      name: dropHandler
      line: 345
      upvalues:
        v27 (copy, index: 1)
        applySpeed (copy, index: 2)
    ]]
    if const handler = v27.handler then
        v27.handler = nil
        pcall(
            function()
                --[[
                  line: 349
                  upvalues:
                    handler (copy, index: 1)
                ]]
                handler:Unequip()
            end
        )
    end

    table.clear(v27.pressed)
    table.clear(v27.speed)
    applySpeed()
end

local function refreshEquipped()
    --[[
      name: refreshEquipped
      line: 358
      upvalues:
        v27 (copy, index: 1)
        localPlayer (copy, index: 2)
        dropHandler (copy, index: 3)
        Hud (copy, index: 4)
        Touch (copy, index: 5)
        v31 (ref,  index: 6)
        Combat (copy, index: 7)
        Weapons (copy, index: 8)
        applySpeed (copy, index: 9)
        v22 (copy, index: 10)
        v23 (copy, index: 11)
        Presentation (copy, index: 12)
        send (copy, index: 13)
        nextId (copy, index: 14)
        setSpeed (copy, index: 15)
        alive (copy, index: 16)
        emitView (copy, index: 17)
        Util (copy, index: 18)
    ]]
    local char = v27.char

    if char and v27.hum ~= nil and 0 < v27.hum.Health and v27.char ~= nil and v27.char.Parent ~= nil then
        local combatMode = localPlayer:GetAttribute("CombatMode")
        local v115 = if combatMode == nil then localPlayer:GetAttribute("State") == "Match" else combatMode == true
        if v115 then
            local v116 = if v31 and v31.Parent == char then v31 else char:FindFirstChildOfClass("Tool")

            if v116 == v27.tool then
                if v27.handler then
                    return
                end
            end

            dropHandler()
            v27.tool = v116
            local v117 = Combat.FISTS_ID

            if v116 then
                v117 = v116:GetAttribute("WeaponId")

                if type(v117) ~= "string" or not Weapons.Get(v117) then
                    Hud.SetStyle("Dot")
                    return
                end
            end

            local def = Weapons.Get(v117)
            local tuning = Combat.Tuning(v117)
            local kind = Combat.Kind(v117) or "Fists"
            v27.kind = kind
            v27.baseSpeed = tuning.speedMult or 1
            applySpeed()
            local v121 = v22[v23[kind] or ""]
            if not v121 then
                Hud.SetStyle("Dot")
                return
            end

            local v122 = {player = localPlayer, char = char, hum = v27.hum, root = v27.root, animator = v27.animator, tool = v116, weaponId = v117, def = def, tuning = tuning, kind = kind, preset = Presentation.For(v117, kind), send = send, nextId = nextId, setSpeed = setSpeed, alive = alive, emit = emitView}
            local handler = v121.new(v122)
            v27.handler = handler
            Hud.SetPips(0, 0)
            Hud.SetArc(nil)
            local setWeapon = Touch.SetWeapon
            local v125 = if v116 then kind else nil
            setWeapon(v125, tuning)
            local success, result = pcall(
                function()
                    --[[
                      line: 420
                      upvalues:
                        handler (copy, index: 1)
                    ]]
                    handler:Equip()
                end
            )
            if not success then
                warn("[Combat] equip error:", result)
            end

            local v128 = Util.GuardRecovery(v116)

            if 0 < v128 then
                Hud.SetArc(v128, Color3.fromRGB(150, 196, 236))
            end

            return
        end
    end

    v27.baseSpeed = 1
    dropHandler()
    v27.tool = nil
    v27.kind = nil
    Hud.SetStyle("Dot")
    Hud.SetPips(0, 0)
    Hud.SetArc(nil)
    Touch.SetWeapon(nil)
end

local function isWeaponTool(a130)
    --[[
      name: isWeaponTool
      line: 435
    ]]
    return a130 ~= nil and a130:IsA("Tool") and type(a130:GetAttribute("WeaponId")) == "string"
end

local function backpack()
    --[[
      name: backpack
      line: 442
      upvalues:
        localPlayer (copy, index: 1)
    ]]
    local instance
    local combatDrawToken = localPlayer:GetAttribute("CombatDrawToken")

    for _, child in localPlayer:GetChildren() do
        if child:IsA("Backpack") then
            instance = instance or child

            for _, child2 in child:GetChildren() do
                if child2:GetAttribute("DrawToken") == combatDrawToken then
                    return child
                end
            end
        end
    end

    return instance
end

local function acked()
    --[[
      name: acked
      line: 458
      upvalues:
        localPlayer (copy, index: 1)
    ]]
    local equipAck = localPlayer:GetAttribute("EquipAck")

    if type(equipAck) ~= "number" then
        return 0
    end

    return equipAck
end

local function equipPending()
    --[[
      name: equipPending
      line: 464
      upvalues:
        localPlayer (copy, index: 1)
        count (ref,  index: 2)
        timestamp (ref,  index: 3)
    ]]
    local equipAck
    local equipAck2 = localPlayer:GetAttribute("EquipAck")

    if type(equipAck2) ~= "number" then
        equipAck = 0
    else
        equipAck = equipAck2
    end

    return equipAck < count and os.clock() - timestamp < 4
end

local function toolInSlot(equipSlot)
    --[[
      name: toolInSlot
      line: 468
      upvalues:
        v27 (copy, index: 1)
        backpack (copy, index: 2)
    ]]
    local v145 = {v27.char, (backpack())}

    for _, v147 in v145 do
        if v147 then
            for _, child in v147:GetChildren() do
                local v150 = child ~= nil and child:IsA("Tool") and type(child:GetAttribute("WeaponId")) == "string"

                if v150 and child:GetAttribute("SlotIndex") == equipSlot then
                    return child
                end
            end
        end
    end

    return nil
end

local function enforceWant()
    --[[
      name: enforceWant
      line: 482
      upvalues:
        v27 (copy, index: 1)
        v31 (ref,  index: 2)
        backpack (copy, index: 3)
    ]]
    local char = v27.char
    local hum = v27.hum
    local v154 = v31

    if not char or not hum or hum.Health <= 0 or not v154 then
        return
    end

    local parent = backpack()

    if v154.Parent ~= char and v154.Parent ~= parent then
        v31 = nil
        return
    end

    if v154.Parent ~= char then
        hum:EquipTool(v154)
    end

    if parent then
        for _, child in char:GetChildren() do
            if child ~= v154 then
                local v158 = child ~= nil and child:IsA("Tool") and type(child:GetAttribute("WeaponId")) == "string"
                if not v158 then
                    continue
                end

                child.Parent = parent
            end
        end
    end
end

local function sendEquip()
    --[[
      name: sendEquip
      line: 504
      upvalues:
        v31 (ref,  index: 1)
        v26 (ref,  index: 2)
        timestamp2 (ref,  index: 3)
        send (copy, index: 4)
        count (ref,  index: 5)
    ]]
    local v160 = v31

    if v160 and v26 then
        timestamp2 = os.clock()
        send("Equip", {tool = v160, seq = count})
    end
end

local function requestEquip(key)
    --[[
      name: requestEquip
      line: 513
      upvalues:
        v31 (ref,  index: 1)
        count (ref,  index: 2)
        v35 (copy, index: 3)
        timestamp (ref,  index: 4)
        v36 (copy, index: 5)
        enforceWant (copy, index: 6)
        v26 (ref,  index: 7)
        timestamp2 (ref,  index: 8)
        send (copy, index: 9)
    ]]
    v31 = key
    count += 1
    v35[key] = count
    timestamp = os.clock()
    v36.requests += 1
    enforceWant()
    local v163 = v31

    if v163 and v26 then
        timestamp2 = os.clock()
        send("Equip", {tool = v163, seq = count})
    end
end

local function reconcileEquip()
    --[[
      name: reconcileEquip
      line: 524
      upvalues:
        v27 (copy, index: 1)
        backpack (copy, index: 2)
        v31 (ref,  index: 3)
        localPlayer (copy, index: 4)
        count (ref,  index: 5)
        timestamp (ref,  index: 6)
        enforceWant (copy, index: 7)
        toolInSlot (copy, index: 8)
        v36 (copy, index: 9)
        v35 (copy, index: 10)
        timestamp3 (ref,  index: 11)
        v26 (ref,  index: 12)
        timestamp2 (ref,  index: 13)
        send (copy, index: 14)
    ]]
    local char = v27.char
    local hum = v27.hum

    if not char or not hum or hum.Health <= 0 then
        return
    end

    local equipAck
    local v168
    local instance = backpack()

    if v31 and v31.Parent ~= char and v31.Parent ~= instance then
        v31 = nil
    end

    local equipAck2 = localPlayer:GetAttribute("EquipAck")

    if type(equipAck2) ~= "number" then
        equipAck = 0
    else
        equipAck = equipAck2
    end

    if equipAck < count and os.clock() - timestamp < 4 then
        enforceWant()
        return
    end

    local equipSlot = localPlayer:GetAttribute("EquipSlot")

    if type(equipSlot) == "number" and 0 < equipSlot then
        v168 = toolInSlot(equipSlot)
    else
        v168 = nil
    end

    if v168 then
        if v31 ~= v168 then
            if v31 ~= nil then
                v36.adopted += 1
            end

            v31 = v168
            local v172 = v35[v168] or count
            v35[v168] = v172
        end

        enforceWant()

        return
    end

    if v31 and 2 < os.clock() - timestamp3 then
        timestamp3 = os.clock()
        v36.reasked += 1
        local v173 = v31
        v31 = v173
        count += 1
        v35[v173] = count
        timestamp = os.clock()
        v36.requests += 1
        enforceWant()
        local v174 = v31

        if v174 and v26 then
            timestamp2 = os.clock()
            send("Equip", {tool = v174, seq = count})
        end
    end
end

local isBusy = false

local function queueReconcile()
    --[[
      name: queueReconcile
      line: 558
      upvalues:
        isBusy (ref,  index: 1)
        reconcileEquip (copy, index: 2)
        refreshEquipped (copy, index: 3)
    ]]
    if isBusy then
        return
    end

    isBusy = true

    task.defer(
        function()
            --[[
              line: 563
              upvalues:
                isBusy (ref,  index: 1)
                reconcileEquip (copy, index: 2)
                refreshEquipped (copy, index: 3)
            ]]
            isBusy = false
            reconcileEquip()
            refreshEquipped()
        end
    )
end

local function onToolAdded(a178)
    --[[
      name: onToolAdded
      line: 574
      upvalues:
        v31 (ref,  index: 1)
        v27 (copy, index: 2)
        v36 (copy, index: 3)
        isBusy (ref,  index: 4)
        reconcileEquip (copy, index: 5)
        refreshEquipped (copy, index: 6)
    ]]
    if a178 ~= v31 and a178.Parent == v27.char then
        local v179 = a178 ~= nil and a178:IsA("Tool") and type(a178:GetAttribute("WeaponId")) == "string"
        if v179 then
            v36.stale += 1

            if not isBusy then
                isBusy = true

                task.defer(
                    function()
                        --[[
                          line: 563
                          upvalues:
                            isBusy (ref,  index: 1)
                            reconcileEquip (copy, index: 2)
                            refreshEquipped (copy, index: 3)
                        ]]
                        isBusy = false
                        reconcileEquip()
                        refreshEquipped()
                    end
                )
            end
        end
    end
end

function v24.Equip(key)
    --[[
      name: Equip
      line: 584
      upvalues:
        v27 (copy, index: 1)
        backpack (copy, index: 2)
        v31 (ref,  index: 3)
        count (ref,  index: 4)
        v35 (copy, index: 5)
        timestamp (ref,  index: 6)
        v36 (copy, index: 7)
        enforceWant (copy, index: 8)
        v26 (ref,  index: 9)
        timestamp2 (ref,  index: 10)
        send (copy, index: 11)
        refreshEquipped (copy, index: 12)
    ]]
    local char = v27.char
    local hum = v27.hum

    if key and char and hum and not (hum.Health <= 0) then
        local v183 = key ~= nil and key:IsA("Tool") and type(key:GetAttribute("WeaponId")) == "string"
        if v183 then
            local instance = backpack()

            if key.Parent ~= char and key.Parent ~= instance then
                return false
            end

            if key == v31 then
                if key.Parent == char then
                    return true
                end
            end

            v31 = key
            count += 1
            v35[key] = count
            timestamp = os.clock()
            v36.requests += 1
            enforceWant()
            local v185 = v31

            if v185 and v26 then
                timestamp2 = os.clock()
                send("Equip", {tool = v185, seq = count})
            end

            refreshEquipped()

            return true
        end
    end

    return false
end

function v24.Wanted()
    --[[
      name: Wanted
      line: 602
      upvalues:
        v31 (ref, index: 1)
    ]]
    return v31
end

local function onCharacter(char: Model?)
    --[[
      name: onCharacter
      line: 606
      upvalues:
        v27 (copy, index: 1)
        dropHandler (copy, index: 2)
        v31 (ref,  index: 3)
        Util (copy, index: 4)
        Combat (copy, index: 5)
        v26 (ref,  index: 6)
        v36 (copy, index: 7)
        isBusy (ref,  index: 8)
        reconcileEquip (copy, index: 9)
        refreshEquipped (copy, index: 10)
        Hud (copy, index: 11)
        Touch (copy, index: 12)
        applySpeed (copy, index: 13)
    ]]
    for _, conn in v27.conns do
        conn:Disconnect()
    end

    table.clear(v27.conns)
    dropHandler()
    v27.char = char
    v31 = nil
    v27.tool = nil
    v27.lastSpeed = -1
    v27.killStreak = 0
    local humanoid = char:WaitForChild("Humanoid", 10)
    local instance = char:WaitForChild("HumanoidRootPart", 10)

    if not humanoid or not instance then
        return
    end

    v27.hum = humanoid
    v27.root = instance
    local animator = humanoid:FindFirstChildOfClass("Animator") or humanoid:WaitForChild("Animator", 5)
    v27.animator = if animator and animator:IsA("Animator") then animator else nil

    if v27.animator then
        task.spawn(Util.Preload, v27.animator)
    end

    table.insert(
        v27.conns,
        char.ChildAdded:Connect(
            function(child: Instance)
                --[[
                  line: 632
                  upvalues:
                    Combat (copy, index: 1)
                    char (copy, index: 2)
                    v26 (ref,  index: 3)
                    v31 (ref,  index: 4)
                    v27 (copy, index: 5)
                    v36 (copy, index: 6)
                    isBusy (ref,  index: 7)
                    reconcileEquip (copy, index: 8)
                    refreshEquipped (copy, index: 9)
                ]]
                if child:IsA("Tool") then
                    Combat.BindOffHand(child, char)

                    if v26 then
                        local v194 = child ~= nil
                            and child:IsA("Tool")
                            and type(child:GetAttribute("WeaponId")) == "string"

                        if v194 and child ~= v31 and child.Parent == v27.char then
                            local v195 = child ~= nil
                                and child:IsA("Tool")
                                and type(child:GetAttribute("WeaponId")) == "string"
                            if v195 then
                                v36.stale += 1

                                if not isBusy then
                                    isBusy = true

                                    task.defer(
                                        function()
                                            --[[
                                              line: 563
                                              upvalues:
                                                isBusy (ref,  index: 1)
                                                reconcileEquip (copy, index: 2)
                                                refreshEquipped (copy, index: 3)
                                            ]]
                                            isBusy = false
                                            reconcileEquip()
                                            refreshEquipped()
                                        end
                                    )
                                end
                            end
                        end
                    end

                    task.defer(refreshEquipped)
                end
            end
        )
    )

    table.insert(
        v27.conns,
        char.ChildRemoved:Connect(
            function(child: Instance)
                --[[
                  line: 641
                  upvalues:
                    v31 (ref,  index: 1)
                    isBusy (ref,  index: 2)
                    reconcileEquip (copy, index: 3)
                    refreshEquipped (copy, index: 4)
                ]]
                if child:IsA("Tool") then
                    if child == v31 and not isBusy then
                        isBusy = true

                        task.defer(
                            function()
                                --[[
                                  line: 563
                                  upvalues:
                                    isBusy (ref,  index: 1)
                                    reconcileEquip (copy, index: 2)
                                    refreshEquipped (copy, index: 3)
                                ]]
                                isBusy = false
                                reconcileEquip()
                                refreshEquipped()
                            end
                        )
                    end

                    task.defer(refreshEquipped)
                end
            end
        )
    )

    table.insert(
        v27.conns,
        humanoid.Died:Connect(
            function()
                --[[
                  line: 649
                  upvalues:
                    dropHandler (copy, index: 1)
                    Hud (copy, index: 2)
                    Touch (copy, index: 3)
                ]]
                dropHandler()
                Hud.SetStyle("Dot")
                Hud.SetPips(0, 0)
                Hud.SetArc(nil)
                Touch.SetWeapon(nil)
            end
        )
    )

    applySpeed()
    instance = char:FindFirstChildOfClass("Tool")

    if instance and v26 then
        local v197 = instance ~= nil and instance:IsA("Tool") and type(instance:GetAttribute("WeaponId")) == "string"

        if v197 and instance ~= v31 and instance.Parent == v27.char then
            local v198 = instance ~= nil
                and instance:IsA("Tool")
                and type(instance:GetAttribute("WeaponId")) == "string"
            if v198 then
                v36.stale += 1

                if not isBusy then
                    isBusy = true

                    task.defer(
                        function()
                            --[[
                              line: 563
                              upvalues:
                                isBusy (ref,  index: 1)
                                reconcileEquip (copy, index: 2)
                                refreshEquipped (copy, index: 3)
                            ]]
                            isBusy = false
                            reconcileEquip()
                            refreshEquipped()
                        end
                    )
                end
            end
        end
    end

    refreshEquipped()
end

local combatDrawToken = nil

local function drawTool(combatDrawSlot, combatDrawToken)
    --[[
      name: drawTool
      line: 671
      upvalues:
        v27 (copy, index: 1)
        backpack (copy, index: 2)
    ]]
    local child
    local v204 = {v27.char, (backpack())}

    for _, v206 in v204 do
        if v206 then
            for _, child2 in v206:GetChildren() do
                local v209 = child2 ~= nil and child2:IsA("Tool") and type(child2:GetAttribute("WeaponId")) == "string"
                if v209 then
                    if child2:GetAttribute("DrawToken") ~= combatDrawToken then
                        continue
                    end

                    if type(combatDrawSlot) == "string" then
                        if child2:GetAttribute("Slot") == combatDrawSlot then
                            return child2
                        end
                    end

                    if type(combatDrawSlot) == "number" then
                        if child2:GetAttribute("SlotIndex") == combatDrawSlot then
                            return child2
                        end
                    end

                    local slotIndex = child2:GetAttribute("SlotIndex")
                    local slotIndex2 = child and child:GetAttribute("SlotIndex")

                    if child then
                        if type(slotIndex) ~= "number" then
                            continue
                        end

                        if type(slotIndex2) == "number" and slotIndex < slotIndex2 then
                            child = child2
                        end

                        continue
                    end

                    child = child2
                end
            end
        end
    end

    return child
end

local function autoDraw()
    --[[
      name: autoDraw
      line: 696
      upvalues:
        localPlayer (copy, index: 1)
        combatDrawToken (ref,  index: 2)
        v27 (copy, index: 3)
        count (ref,  index: 4)
        timestamp (ref,  index: 5)
        v31 (ref,  index: 6)
        v35 (copy, index: 7)
        v36 (copy, index: 8)
        enforceWant (copy, index: 9)
        v26 (ref,  index: 10)
        timestamp2 (ref,  index: 11)
        send (copy, index: 12)
        drawTool (copy, index: 13)
        v24 (copy, index: 14)
    ]]
    local combatDrawToken2 = localPlayer:GetAttribute("CombatDrawToken")

    if type(combatDrawToken2) ~= "number" or combatDrawToken2 == combatDrawToken then
        return
    end

    combatDrawToken = combatDrawToken2

    task.spawn(
        function()
            --[[
              line: 702
              upvalues:
                localPlayer (copy, index: 1)
                combatDrawToken2 (copy, index: 2)
                v27 (copy, index: 3)
                count (ref,  index: 4)
                timestamp (ref,  index: 5)
                v31 (ref,  index: 6)
                v35 (copy, index: 7)
                v36 (copy, index: 8)
                enforceWant (copy, index: 9)
                v26 (ref,  index: 10)
                timestamp2 (ref,  index: 11)
                send (copy, index: 12)
                drawTool (copy, index: 13)
                v24 (copy, index: 14)
            ]]
            local timestamp3 = os.clock()
            local timestamp4 = -math.huge

            while os.clock() - timestamp3 < 10 do
                if localPlayer:GetAttribute("CombatDrawToken") ~= combatDrawToken2 then
                    return
                end

                local combatDrawSlot = localPlayer:GetAttribute("CombatDrawSlot")

                if combatDrawSlot == 0 then
                    return
                end

                local char = v27.char
                local hum = v27.hum

                if char
                    and hum
                    and 0 < hum.Health
                    and char == localPlayer.Character
                    and char:IsDescendantOf(workspace)
                then
                    local tool = char:FindFirstChildOfClass("Tool")
                    local v220 = false

                    if tool ~= nil then
                        v220 = tool ~= nil and tool:IsA("Tool") and type(tool:GetAttribute("WeaponId")) == "string"
                        v220 = v220 and tool:GetAttribute("DrawToken") == combatDrawToken2
                    end

                    if v220 then
                        local v221 = false
                        local equipAck = localPlayer:GetAttribute("EquipAck")

                        if type(equipAck) ~= "number" then
                            equipAck = 0
                        end

                        if equipAck < count then
                            v221 = os.clock() - timestamp < 4
                        end

                        if not v221 then
                            local equipSlot = localPlayer:GetAttribute("EquipSlot")

                            if type(equipSlot) == "number" then
                                if 0 < equipSlot then
                                    return
                                end
                            end

                            if 0.5 < os.clock() - timestamp4 then
                                local timestamp5 = os.clock()
                                v31 = tool
                                count += 1
                                v35[tool] = count
                                timestamp = os.clock()
                                v36.requests += 1
                                enforceWant()

                                if const v225 = v31 then
                                    if v26 then
                                        timestamp2 = os.clock()
                                        send("Equip", {tool = v225, seq = count})
                                        timestamp4 = timestamp5
                                    else
                                        timestamp4 = timestamp5
                                    end
                                else
                                    timestamp4 = timestamp5
                                end
                            end
                        end
                    end

                    if not v220 then
                        if type(combatDrawSlot) ~= "number" and type(combatDrawSlot) ~= "string" then
                            combatDrawSlot = 1
                        end

                        if const v226 = drawTool(combatDrawSlot, combatDrawToken2) then
                            v24.Equip(v226)
                        end
                    end
                end

                task.wait(0.1)
            end
        end
    )
end

local v227 = {Attack = "Primary", Aim = "Secondary", Reload = "Reload"}

local function mapInput(a229)
    --[[
      name: mapInput
      line: 744
      upvalues:
        Keybinds (copy, index: 1)
        v227 (copy, index: 2)
    ]]
    local v230

    for _, v232 in Keybinds.PadActionsOf(a229) do
        v230 = v227[v232]

        if v230 then
            return v230
        end
    end

    local userInputType = a229.UserInputType

    if userInputType ~= Enum.UserInputType.Keyboard
        and userInputType ~= Enum.UserInputType.MouseButton1
        and userInputType ~= Enum.UserInputType.MouseButton2
    then
        if userInputType ~= Enum.UserInputType.MouseButton3 then
            return nil
        end
    end

    return if const v234 = Keybinds.ActionOf(a229) then v227[v234] else nil
end

local v235 = {n = 0, last = ""}

local function handlerInput(a237, a238)
    --[[
      name: handlerInput
      line: 765
      upvalues:
        v27 (copy, index: 1)
        v235 (copy, index: 2)
    ]]
    local handler = v27.handler
    if not handler then
        return
    end

    v235.n += 1
    local v240 = a238 and "+" or "-"
    v235.last = a237 .. v240
    local success, result = pcall(
        function()
            --[[
              line: 772
              upvalues:
                handler (copy, index: 1)
                a237 (copy, index: 2)
                a238 (copy, index: 3)
            ]]
            handler:Input(a237, a238)
        end
    )
    if not success then
        warn("[Combat] input error:", result)
    end
end

local function onInputBegan(a244, a245)
    --[[
      name: onInputBegan
      line: 780
      upvalues:
        mapInput (copy, index: 1)
        v27 (copy, index: 2)
        Util (copy, index: 3)
        Keybinds (copy, index: 4)
        handlerInput (copy, index: 5)
    ]]
    if a245 then
        return
    end

    local v246 = mapInput(a244)

    if v246
        and v27.handler
        and v27.hum ~= nil
        and 0 < v27.hum.Health
        and v27.char ~= nil
        and (v27.char.Parent ~= nil)
        and not Util.IsMouseUnlocked()
        and (not Keybinds.PadBlocked() or not (0 < #Keybinds.PadActionsOf(a244)))
    then
        v27.pressed[v246] = true
        handlerInput(v246, true)
    end
end

local function onInputEnded(a248, a249)
    --[[
      name: onInputEnded
      line: 795
      upvalues:
        mapInput (copy, index: 1)
        v27 (copy, index: 2)
        handlerInput (copy, index: 3)
    ]]
    local v250 = mapInput(a248)

    if not v250 or not v27.pressed[v250] then
        return
    end

    v27.pressed[v250] = nil
    handlerInput(v250, false)
end

local function dispatch(key, a253)
    --[[
      name: dispatch
      line: 805
      upvalues:
        InputStats (ref,  index: 1)
        v27 (copy, index: 2)
        Util (copy, index: 3)
        handlerInput (copy, index: 4)
    ]]
    local v254 = false

    if InputStats then
        InputStats.Caller(8192)
    end

    if a253 then
        if v27.handler then
            if v27.hum ~= nil
                and 0 < v27.hum.Health
                and v27.char ~= nil
                and (v27.char.Parent ~= nil)
                and not Util.IsMouseUnlocked()
            then
                v27.pressed[key] = true
            else
                v254 = true
            end
        else
            v254 = true
        end
    else
        if not v27.pressed[key] then
            return
        end

        v27.pressed[key] = nil
    end

    if v254 then
        return
    end

    handlerInput(key, a253)
end

v24.Dispatch = dispatch
local v255 = false

local function interrupt()
    --[[
      name: interrupt
      line: 828
      upvalues:
        v255 (ref,  index: 1)
        v27 (copy, index: 2)
    ]]
    if v255 then
        return
    end

    local handler = v27.handler

    if handler and type(handler.Interrupt) == "function" then
        pcall(
            function()
                --[[
                  line: 834
                  upvalues:
                    handler (copy, index: 1)
                ]]
                handler:Interrupt()
            end
        )
    end
end

local timestamp4 = 0

local function onHitConfirm(a260)
    --[[
      name: onHitConfirm
      line: 844
      upvalues:
        Util (copy, index: 1)
        Hud (copy, index: 2)
        Effects (copy, index: 3)
        Combat (copy, index: 4)
        v27 (copy, index: 5)
        nameOf (copy, index: 6)
        Loc (copy, index: 7)
        Presentation (copy, index: 8)
        timestamp4 (ref,  index: 9)
    ]]
    if type(a260) ~= "table" then
        return
    end

    local position

    if typeof(a260.position) ~= "Vector3" then
        position = nil
    else
        position = a260.position
    end

    local number = tonumber(a260.amount) or 0
    local v263 = a260.headshot == true or a260.crit == true
    local victim = a260.victim
    local number2 = tonumber(a260.armor) or 0

    if a260.armorBroken then
        Util.Sound("Shield_Break")
    end

    if position and 0 < number then
        local v266 = a260.dot and "dot"
            or a260.killed and "kill"
            or v263 and "crit"
            or a260.blocked and "blocked"
            or 0 < number2 and (number - number2 < 0.5 and "armor" or "health")
            or "health"
        local v267 = if a260.dot then nil else a260.headshot and "HEADSHOT"
            or a260.crit and "BACKSTAB"
            or a260.blocked and "BLOCKED"
            or a260.armorBroken and "ARMOR BROKEN"
            or nil
        Hud.DamageNumber(position, number, v266, victim, v267)
    end

    if a260.dot then
        return
    end

    local v268 = Effects.ConsumePrediction(victim)
    local timestamp = os.clock()
    local v270 = Combat.Kind(a260.weaponId)
    local isMelee = Combat.IsMelee(v270)

    if a260.killed then
        Hud.Hitmarker("kill")
        local sound = Util.Sound
        local v273 = a260.headshot and "Kill_Confirm_Headshot" or "Kill_Confirm"
        sound(v273)
        v27.killStreak = not (timestamp - v27.lastKillAt <= 4) and 1 or v27.killStreak + 1
        v27.lastKillAt = timestamp
        local v275 = if const text = nameOf(victim) then string.upper(text) else nil

        if not (2 <= v27.killStreak) then
            local killBanner = Hud.KillBanner
            local v277 = not v275 and "ELIMINATED" or `ELIMINATED {v275}`
            local v278 = if a260.headshot then Loc.T("HEADSHOT") else nil
            killBanner(v277, v278)
        else
            local v279
            local v280 = v27.killStreak ~= 2 and "TRIPLE ELIMINATION" or "DOUBLE ELIMINATION"

            if v275 and a260.headshot then
                v279 = `{v275} · {(Loc.T("HEADSHOT"))}`
            else
                v279 = v275 or (if a260.headshot then Loc.T("HEADSHOT") else nil)
            end

            Hud.KillBanner(v280, v279)
        end

        Util.Shake(0.35, 0.18)
    else
        local hitmarker = Hud.Hitmarker
        local v282 = v263 and "crit" or "hit"
        hitmarker(v282)

        if a260.headshot then
            Util.Sound("Hitmarker_Headshot")
        elseif a260.crit then
            local sound = Util.Sound
            local weaponId = a260.weaponId
            sound((Presentation.For(weaponId, v270).critSound or "Hitmarker_Crit"))
        elseif 0.06 < timestamp - timestamp4 then
            timestamp4 = timestamp
            local sound = Util.Sound
            local v286 = isMelee and "Hitmarker" or "Hitmarker_Ranged"
            sound(v286)
        end
    end

    if position and isMelee and not v268 then
        local weaponId = a260.weaponId
        local v288 = Presentation.For(weaponId, v270)
        local sound = Util.Sound
        local hitSound = v288.hitSound or "Hit_Melee"
        sound(hitSound, position)
    end
end

local function onDamageTaken(a292)
    --[[
      name: onDamageTaken
      line: 915
      upvalues:
        Hud (copy, index: 1)
        RankFx (copy, index: 2)
        Util (copy, index: 3)
        v255 (ref,  index: 4)
        v27 (copy, index: 5)
        emitView (copy, index: 6)
        Guard (copy, index: 7)
    ]]
    if type(a292) ~= "table" then
        return
    end

    local number = tonumber(a292.amount) or 0
    local fromPosition = a292.fromPosition

    if a292.damageType == "Burn" then
        Hud.Hurt(0.2, Color3.fromRGB(255, 120, 40))
        return
    end

    if a292.damageType == "World" or a292.weaponId == "ring" then
        Hud.Hurt(0.25, Color3.fromRGB(255, 110, 40))
        return
    end

    if a292.damageType == "Sting" then
        Hud.Hurt(0.18, Color3.fromRGB(220, 160, 40))
        RankFx.Stung()
        Util.Sound("Damage_Receive", nil, {Volume = 0.6, PlaybackSpeed = 1.18})

        if a292.interrupted then
            if not v255 then
                local handler = v27.handler

                if handler and type(handler.Interrupt) == "function" then
                    pcall(
                        function()
                            --[[
                              line: 834
                              upvalues:
                                handler (copy, index: 1)
                            ]]
                            handler:Interrupt()
                        end
                    )
                end
            end

            Hud.Toast("INTERRUPTED", Color3.fromRGB(255, 150, 90), 0.9)
        end

        return
    end

    if typeof(fromPosition) == "Vector3" then
        Hud.DamageFrom(fromPosition, 40 <= number)
    end

    local number2 = tonumber(a292.armor) or 0

    if not v255 then
        emitView("Hurt", {amount = number, blocked = a292.blocked == true})
    end

    if a292.interrupted then
        if not v255 then
            local handler = v27.handler

            if handler and type(handler.Interrupt) == "function" then
                pcall(
                    function()
                        --[[
                          line: 834
                          upvalues:
                            handler (copy, index: 1)
                        ]]
                        handler:Interrupt()
                    end
                )
            end
        end

        Hud.Toast("INTERRUPTED", Color3.fromRGB(255, 150, 90), 0.9)
    end

    if a292.armorBroken then
        Util.Sound("Shield_Break")
        Hud.Toast("ARMOR BROKEN", Color3.fromRGB(200, 210, 225), 1.1)
    end

    if a292.guardBroken then
        if not v255 then
            local handler = v27.handler

            if handler and type(handler.Interrupt) == "function" then
                pcall(
                    function()
                        --[[
                          line: 834
                          upvalues:
                            handler (copy, index: 1)
                        ]]
                        handler:Interrupt()
                    end
                )
            end
        end

        Util.Sound("Shield_Break")
        Hud.Toast("SHIELD BROKEN", Color3.fromRGB(110, 190, 255), 1.3)
    end

    if a292.blocked then
        Hud.Hurt(math.min(0.35, number / 60), Color3.fromRGB(110, 190, 255))
        Hud.BlockPulse()

        if not v255 then
            Guard.Impact(v27.char, true)
        end
    elseif 0 < number2 and number - number2 < 0.5 then
        Hud.Hurt(math.min(0.3, number / 70), Color3.fromRGB(170, 185, 205))
        Util.Shake(math.clamp(number / 70, 0.15, 0.6), 0.2)
        Util.Sound("Impact_Metal")
    else
        local v299
        Hud.Hurt(number / 35, nil)
        Util.Shake(math.clamp(number / 45, 0.2, 1.1), 0.28)
        Util.Recoil(math.clamp(number / 12, 0.5, 4), (math.random() - 0.5) * 3)
        local sound = Util.Sound

        if not (30 <= number) then
            v299 = "Damage_Receive"
        else
            v299 = "Damage_Receive_Heavy"
        end

        sound(v299)
    end

    if type(a292.stagger) == "number" and 0 < a292.stagger then
        if not v255 then
            local handler = v27.handler

            if handler and type(handler.Interrupt) == "function" then
                pcall(
                    function()
                        --[[
                          line: 834
                          upvalues:
                            handler (copy, index: 1)
                        ]]
                        handler:Interrupt()
                    end
                )
            end
        end

        Hud.Toast("STAGGERED", Color3.fromRGB(255, 170, 90), a292.stagger + 0.2)
    end

    if a292.damageType == "Trap" then
        if not v255 then
            local handler = v27.handler

            if handler and type(handler.Interrupt) == "function" then
                pcall(
                    function()
                        --[[
                          line: 834
                          upvalues:
                            handler (copy, index: 1)
                        ]]
                        handler:Interrupt()
                    end
                )
            end
        end

        Hud.Toast("TRAPPED!", Color3.fromRGB(255, 120, 90), 1.4)
    end
end

local v303 = {}
local v304 = {}

task.spawn(
    function()
        --[[
          line: 992
          upvalues:
            v303 (copy, index: 1)
            v304 (copy, index: 2)
        ]]
        while true do
            task.wait(10)

            for v305 in v303 do
                if not v305.Parent then
                    v303[v305] = nil
                end
            end

            for v306 in v304 do
                if not v306.Parent then
                    v304[v306] = nil
                end
            end
        end
    end
)

local function onCombatFX(a308, a309)
    --[[
      name: onCombatFX
      line: 1008
      upvalues:
        v27 (copy, index: 1)
        Effects (copy, index: 2)
        Combat (copy, index: 3)
        Presentation (copy, index: 4)
        Util (copy, index: 5)
        Quality (copy, index: 6)
        Poses (copy, index: 7)
        v303 (copy, index: 8)
        Hud (copy, index: 9)
        RankFx (copy, index: 10)
        v255 (ref,  index: 11)
        emitView (copy, index: 12)
        Guard (copy, index: 13)
        v304 (copy, index: 14)
        v36 (copy, index: 15)
        v31 (ref,  index: 16)
        localPlayer (copy, index: 17)
        count (ref,  index: 18)
        timestamp (ref,  index: 19)
        v35 (copy, index: 20)
        enforceWant (copy, index: 21)
        v26 (ref,  index: 22)
        timestamp2 (ref,  index: 23)
        send (copy, index: 24)
    ]]
    repeat
        if type(a308) ~= "string" or type(a309) ~= "table" then
            return
        end

        do
            local char = v27.char

            if a308 == "Swing" then
                do
                    local v311

                    do
                        local attacker = a309.attacker

                        if typeof(attacker) == "Instance" then
                            if attacker:IsA("Player") then
                                v311 = attacker.Character
                            else
                                v311 = if attacker:IsA("Model") then attacker else nil
                            end
                        else
                            v311 = nil
                        end
                    end

                    if not v311 or v311 == char then
                        return
                    end

                    do
                        local v313
                        local v314

                        if typeof(v311) == "Instance" then
                            if v311:IsA("Player") then
                                v313 = v311.Character
                            else
                                v313 = if v311:IsA("Model") then v311 else nil
                            end
                        else
                            v313 = nil
                        end

                        local humanoidRootPart = v313 and v313:FindFirstChild("HumanoidRootPart")
                        local v316 = if humanoidRootPart and humanoidRootPart:IsA("BasePart") then humanoidRootPart else nil

                        do
                            local v317

                            do
                                local v318, v319 = false, false

                                if v316 then
                                    do
                                        local position = v316.Position
                                        v317 = false

                                        if position ~= nil then
                                            local v321 = Effects.CamDistance(position)
                                            v317 = Effects.NEAR < v321
                                        end
                                    end

                                    v318 = true
                                else
                                    v319 = true
                                end

                                if v318 and v317 then
                                    v319 = true
                                end

                                if v319 then
                                    return
                                end
                            end
                        end

                        local v322 = Combat.Kind(a309.weaponId) or "Fists"
                        local weaponId = a309.weaponId

                        do
                            local v324 = Presentation.For(weaponId, v322)

                            if a309.heavy ~= true then
                                if a309.lunge ~= true then
                                    v314 = v324.swingSound
                                else
                                    v314 = v324.lungeSound or v324.swingSound
                                end
                            else
                                v314 = v324.heavySound or v324.swingSound
                            end

                            Util.Sound(v314 or "Swing_Sword", v316)

                            if v324.trail and 0 < v324.trail and Quality.layers then
                                do
                                    do
                                        local trail = Effects.Trail
                                        local tool = v311 and v311:FindFirstChildOfClass("Tool") or nil
                                        trail(tool, v324.trail)
                                    end
                                end
                            end

                            if not v324.noSlash then
                                Effects.Slash(v311, (tonumber(a309.step) or 1), a309.heavy == true, v324.slashColor)

                                if a309.heavy == true then
                                    Effects.GroundScuff(v316.Position + (v316.CFrame.LookVector * 4) - Vector3.new(0, 2.799999952316284, 0))
                                    return
                                end
                            end
                        end
                    end
                end
            elseif a308 == "Projectile" then
                do
                    local v327

                    do
                        local shooter = a309.shooter

                        if typeof(shooter) == "Instance" then
                            if shooter:IsA("Player") then
                                v327 = shooter.Character
                            else
                                v327 = if shooter:IsA("Model") then shooter else nil
                            end
                        else
                            v327 = nil
                        end
                    end

                    do
                        do
                            local v329

                            do
                                local v330, v331, v332, v333 = false, false, false, false

                                if v327 and v327 == char and a309.deflected ~= true then
                                    return
                                end
                                if typeof(a309.origin) ~= "Vector3"
                                    or typeof(a309.velocity) ~= "Vector3"
                                    or type(a309.key) ~= "string"
                                then
                                    return
                                end

                                do
                                    local number = tonumber(a309.gravity) or 0

                                    if const number2 = tonumber(a309.pellets) then
                                        if not (1 < number2) then
                                            v330 = true
                                        else
                                            local velocity = a309.velocity
                                            Effects.Pellets(a309.key, a309.kind, a309.origin, velocity.Unit, velocity.Magnitude, number, number2, (tonumber(a309.spread)
                                                or 6), (tonumber(a309.seed) or 0), v327)
                                        end
                                    else
                                        v330 = true
                                    end

                                    if v330 then
                                        Effects.Projectile(a309.key, a309.kind, a309.origin, a309.velocity, number, v327)
                                    end
                                end

                                local v337 = Combat.Kind(a309.weaponId)
                                local weaponId = a309.weaponId

                                do
                                    local v339 = Presentation.For(weaponId, v337 or "Bow")
                                    local origin = a309.origin
                                    local v341 = false

                                    if origin ~= nil then
                                        local v342 = Effects.CamDistance(origin)
                                        v341 = Effects.NEAR < v342
                                    end

                                    do
                                        local v343 = not v341
                                        if v343 then
                                            if v339.flash then
                                                v331 = true
                                            elseif v339.puff then
                                                v331 = true
                                            end
                                        end

                                        if v331 then
                                            local muzzle = Effects.Muzzle
                                            local cframe = CFrame.lookAt(a309.origin, a309.origin + a309.velocity)
                                            local v346 = v337 ~= "Pistol"
                                            muzzle(cframe, v346, v339.puff ~= false)
                                        end

                                        if v327 and v339.kick then
                                            Poses.Kick(v327, v339.kick * 5)
                                        end

                                        do
                                            local timestamp3 = os.clock()
                                            local v348 = v327 or workspace

                                            if 0.08 < timestamp3 - (v303[v348] or 0) then
                                                v303[v348] = timestamp3
                                                v329 = v339.fireSound

                                                if not v329 then
                                                    v329 = v339.throwSound
                                                    v329 = v329 or "Bow_Release"
                                                end

                                                v332 = true
                                            end
                                        end

                                        if v332 then
                                            if v343 then
                                                v333 = true
                                            elseif v339.flash then
                                                v333 = true
                                            end
                                        end
                                    end
                                end

                                if v333 then
                                    Util.Sound(v329, a309.origin)
                                    return
                                end
                            end
                        end
                    end
                end
            else
                if a308 == "ProjectileHit" then
                    Effects.ResolveProjectile(a309)
                    return
                end

                if a308 == "Explosion" then
                    if typeof(a309.position) == "Vector3" then
                        Effects.Explosion(a309.position, (tonumber(a309.radius) or 10), tonumber(a309.zoneRadius), (tonumber(a309.zoneTime)))
                        return
                    end
                elseif a308 == "Smoke" then
                    if typeof(a309.position) == "Vector3" then
                        do
                            local number = tonumber(a309.duration) or 7
                            Effects.SmokeCloud(a309.position, (tonumber(a309.radius) or 13), number)

                            if a309.hiss == true then
                                do
                                    local smokeHiss = Instance.new("Part")
                                    smokeHiss.Name = "SmokeHiss"
                                    smokeHiss.Anchored = true
                                    smokeHiss.CanCollide = false
                                    smokeHiss.CanQuery = false
                                    smokeHiss.CanTouch = false
                                    smokeHiss.Transparency = 1
                                    smokeHiss.Size = Vector3.new(1, 1, 1)
                                    smokeHiss.CFrame = CFrame.new(a309.position)
                                    smokeHiss.Parent = workspace
                                    local v351 = Util.Loop("Smoke_Hiss_Loop", smokeHiss)

                                    task.delay(
                                        number,
                                        function()
                                            --[[
                                              line: 1093
                                              upvalues:
                                                v351 (copy, index: 1)
                                                smokeHiss (copy, index: 2)
                                            ]]
                                            pcall(v351, 1)
                                            task.delay(
                                                1.2,
                                                function()
                                                    --[[
                                                      line: 1095
                                                      upvalues:
                                                        smokeHiss (copy, index: 1)
                                                    ]]
                                                    smokeHiss:Destroy()
                                                end
                                            )
                                        end
                                    )
                                end

                                return
                            end
                        end
                    end
                elseif a308 == "Horn" then
                    do
                        local v352
                        local position

                        do
                            local attacker = a309.attacker

                            if typeof(attacker) == "Instance" then
                                if attacker:IsA("Player") then
                                    v352 = attacker.Character
                                else
                                    v352 = if attacker:IsA("Model") then attacker else nil
                                end
                            else
                                v352 = nil
                            end
                        end

                        if typeof(a309.position) ~= "Vector3" then
                            position = nil
                        else
                            position = a309.position
                        end

                        if not position then
                            return
                        end

                        Util.Sound("War_Horn", position)
                        Effects.HornBlast(position)

                        if v352 ~= nil and (v352 == char or Util.IsTeammate(v352)) then
                            if type(a309.enemies) == "table" then
                                for _, enemy in a309.enemies do
                                    do
                                        local v357

                                        if typeof(enemy) == "Instance" then
                                            if enemy:IsA("Player") then
                                                v357 = enemy.Character
                                            else
                                                v357 = if enemy:IsA("Model") then enemy else nil
                                            end
                                        else
                                            v357 = nil
                                        end

                                        if v357 then
                                            Effects.Reveal(v357, (tonumber(a309.reveal) or 3))
                                        end
                                    end
                                end
                            end

                            if Util.InMatch() then
                                Hud.Toast("TRIBE RALLIED", Color3.fromRGB(226, 190, 110), 1.6)
                                return
                            end

                            return
                        end

                        if v352 ~= nil and char ~= nil and Util.IsEnemy(v352) then
                            Hud.DamageFrom(position, true, Color3.fromRGB(240, 180, 70), (tonumber(a309.reveal) or 3))
                            Hud.Toast("ENEMY HORN", Color3.fromRGB(240, 180, 70), 1.6)

                            return
                        end
                    end
                elseif a308 == "Chakram" then
                    do
                        local v358

                        do
                            local shooter = a309.shooter

                            if typeof(shooter) == "Instance" then
                                if shooter:IsA("Player") then
                                    v358 = shooter.Character
                                else
                                    v358 = if shooter:IsA("Model") then shooter else nil
                                end
                            else
                                v358 = nil
                            end
                        end

                        if v358 == char
                            or typeof(a309.origin) ~= "Vector3"
                            or typeof(a309.dir) ~= "Vector3"
                            or type(a309.key) ~= "string"
                        then
                            return
                        end

                        do
                            Effects.Chakram(a309.key, a309.origin, a309.dir, (tonumber(a309.speed) or 110), (tonumber(a309.range)
                                or 45), (tonumber(a309.catch) or 4.5), v358)
                            local origin = a309.origin
                            local v361 = origin ~= nil and Effects.NEAR < Effects.CamDistance(origin)
                            if not v361 then
                                Util.Sound("Knife_Throw", a309.origin)
                                return
                            end
                        end
                    end
                elseif a308 == "ChakramTurn" then
                    if type(a309.key) == "string" and typeof(a309.position) == "Vector3" then
                        Effects.ChakramTurn(a309.key, a309.position)
                        return
                    end
                elseif a308 == "ChakramEnd" then
                    if type(a309.key) == "string" then
                        do
                            local position

                            do
                                local chakramEnd = Effects.ChakramEnd
                                local key = a309.key
                                local caught = a309.caught == true

                                if typeof(a309.position) ~= "Vector3" then
                                    position = nil
                                else
                                    position = a309.position
                                end

                                chakramEnd(key, caught, position)

                                return
                            end
                        end
                    end
                elseif a308 == "FirePatch" then
                    if typeof(a309.position) == "Vector3" then
                        Effects.FirePatch(a309.position, (tonumber(a309.radius) or 3.5), (tonumber(a309.duration)
                            or 1.5))
                        return
                    end
                elseif a308 == "Wall" then
                    if typeof(a309.position) == "Vector3" then
                        Effects.Wall(a309.position, tostring(a309.op), (tonumber(a309.width) or 6), (tonumber(a309.height)
                            or 5))
                        return
                    end
                elseif a308 == "HealPool" then
                    if typeof(a309.position) == "Vector3" then
                        Effects.HealPool(a309.position, (tonumber(a309.radius) or 10), (tonumber(a309.duration) or 3))
                        return
                    end
                else
                    if a308 == "Caltrops" then
                        Effects.Caltrops(a309)
                        return
                    end

                    if a308 ~= "CaltropsEnd" then
                        if a308 == "Swarm" then
                            RankFx.Swarm(a309)
                            return
                        end

                        if a308 == "SwarmTarget" then
                            RankFx.SwarmTarget(a309)
                            return
                        end

                        if a308 == "SwarmSync" then
                            RankFx.SwarmSync(a309)
                            return
                        end

                        if a308 == "SwarmEnd" then
                            RankFx.SwarmEnd(a309)
                            return
                        end

                        if a308 == "HatchetDrop" then
                            RankFx.HatchetDrop(a309)
                            return
                        end

                        if a308 == "HatchetEnd" then
                            RankFx.HatchetEnd(a309)
                            return
                        end

                        if a308 == "ParryStart" then
                            RankFx.ParryStart(a309)
                            return
                        end

                        if a308 == "Parry" then
                            local v366

                            do
                                local v367
                                RankFx.Parried(a309)

                                do
                                    local target = a309.target

                                    if typeof(target) == "Instance" then
                                        if target:IsA("Player") then
                                            v366 = target.Character
                                        else
                                            v366 = if target:IsA("Model") then target else nil
                                        end
                                    else
                                        v366 = nil
                                    end
                                end

                                do
                                    local attacker = a309.attacker

                                    if typeof(attacker) == "Instance" then
                                        if attacker:IsA("Player") then
                                            v367 = attacker.Character
                                        else
                                            v367 = if attacker:IsA("Model") then attacker else nil
                                        end
                                    else
                                        v367 = nil
                                    end
                                end

                                if v366 ~= nil and v366 == char and not v255 then
                                    do
                                        Hud.Flash(Color3.fromRGB(150, 196, 236), 0.5, 0.25)

                                        do
                                            local toast = Hud.Toast
                                            local v371 = a309.ranged and "DEFLECTED" or "PARRIED"
                                            toast(v371, Color3.fromRGB(170, 214, 245), 0.9)
                                            Util.Shake(0.25, 0.12)
                                        end

                                        emitView("Parried", {ranged = a309.ranged == true})

                                        do
                                            local handler = v27.handler

                                            if not handler or type(handler.ParryUsed) ~= "function" then
                                                return
                                            end

                                            pcall(
                                                function()
                                                    --[[
                                                      line: 1194
                                                      upvalues:
                                                        handler (copy, index: 1)
                                                    ]]
                                                    handler:ParryUsed()
                                                end
                                            )

                                            return
                                        end
                                    end
                                end

                                if v367 ~= nil and v367 == char and not v255 then
                                    if not a309.staggered then
                                        Hud.Toast("PARRIED", Color3.fromRGB(255, 170, 90), 0.9)
                                        return
                                    end

                                    if not v255 then
                                        do
                                            local handler = v27.handler

                                            if handler and type(handler.Interrupt) == "function" then
                                                pcall(
                                                    function()
                                                        --[[
                                                          line: 834
                                                          upvalues:
                                                            handler (copy, index: 1)
                                                        ]]
                                                        handler:Interrupt()
                                                    end
                                                )
                                            end
                                        end
                                    end

                                    Hud.Toast("PARRIED · STAGGERED", Color3.fromRGB(255, 170, 90), (tonumber(a309.stagger)
                                        or 0.5) + 0.3)
                                    Util.Shake(0.4, 0.18)

                                    return
                                end
                            end
                        elseif a308 == "TrapSnap" then
                            if typeof(a309.position) == "Vector3" then
                                Effects.TrapSnap(a309.position)
                                return
                            end
                        elseif a308 == "Hit" then
                            do
                                local v374
                                local position
                                local v376

                                do
                                    local target = a309.target

                                    if typeof(target) == "Instance" then
                                        if target:IsA("Player") then
                                            v374 = target.Character
                                        else
                                            v374 = if target:IsA("Model") then target else nil
                                        end
                                    else
                                        v374 = nil
                                    end
                                end

                                if typeof(a309.position) ~= "Vector3" then
                                    position = nil
                                else
                                    position = a309.position
                                end

                                do
                                    local attacker = a309.attacker

                                    if typeof(attacker) == "Instance" then
                                        if attacker:IsA("Player") then
                                            v376 = attacker.Character
                                        else
                                            v376 = if attacker:IsA("Model") then attacker else nil
                                        end
                                    else
                                        v376 = nil
                                    end
                                end

                                if (v376 == nil or v376 ~= char) and (v374 == nil or v374 ~= char) then
                                    do
                                        local v379 = position ~= nil
                                            and Effects.NEAR < Effects.CamDistance(position)
                                        if v379 then
                                            return
                                        end
                                    end
                                end

                                if a309.damageType ~= "Burn" and v374 ~= char then
                                    do
                                        do
                                            local hitFlash = Effects.HitFlash
                                            local color3 = if a309.blocked then Color3.fromRGB(110, 190, 255) else nil
                                            hitFlash(v374, color3)
                                        end
                                    end
                                end

                                if position and a309.damageType ~= "Burn" then
                                    local unit

                                    if typeof(a309.source) ~= "Vector3"
                                        or not (0.1 < (position - a309.source).Magnitude)
                                    then
                                        unit = nil
                                    else
                                        unit = (position - a309.source).Unit
                                    end

                                    do
                                        local v383 = a309.blocked and "blocked"
                                            or a309.headshot and "headshot"
                                            or a309.crit and "headshot"
                                            or "health"
                                        Effects.CharacterImpact(position, unit, ((a309.headshot == true)
                                            or (a309.killed == true)), v383)
                                    end
                                end

                                if a309.blocked and v374 and v374 ~= char then
                                    Guard.Impact(v374, false)

                                    if a309.guardBroken and position then
                                        Util.Sound("Shield_Break", position)
                                    end
                                end

                                if position and a309.armor then
                                    Effects.ArmorHit(position, a309.armorBroken == true)
                                end

                                if position and v376 ~= char and v374 ~= char and a309.damageType == "Melee" then
                                    do
                                        local v384 = Combat.Kind(a309.weaponId) or "Sword"
                                        local weaponId = a309.weaponId
                                        local v386 = Presentation.For(weaponId, v384)
                                        Util.Sound((v386.hitSound or "Hit_Melee"), position)
                                    end

                                    return
                                end
                            end
                        elseif a308 == "Death" then
                            if typeof(a309.position) == "Vector3" then
                                local v387

                                do
                                    local weaponId

                                    do
                                        local death = Effects.Death
                                        local position = a309.position
                                        local killer = a309.killer

                                        if typeof(killer) == "Instance" then
                                            if killer:IsA("Player") then
                                                v387 = killer.Character
                                            else
                                                v387 = if killer:IsA("Model") then killer else nil
                                            end
                                        else
                                            v387 = nil
                                        end

                                        do
                                            local v392 = v387 == char and char ~= nil

                                            if type(a309.weaponId) ~= "string" then
                                                weaponId = nil
                                            else
                                                weaponId = a309.weaponId
                                            end

                                            death(position, v392, weaponId, a309.headshot == true)

                                            return
                                        end
                                    end
                                end
                            end
                        else
                            if a308 == "Heal" then
                                do
                                    local v393
                                    local v394

                                    do
                                        local target = a309.target

                                        if typeof(target) == "Instance" then
                                            if target:IsA("Player") then
                                                v393 = target.Character
                                            else
                                                v393 = if target:IsA("Model") then target else nil
                                            end
                                        else
                                            v393 = nil
                                        end
                                    end

                                    if typeof(v393) == "Instance" then
                                        if v393:IsA("Player") then
                                            v394 = v393.Character
                                        else
                                            v394 = if v393:IsA("Model") then v393 else nil
                                        end
                                    else
                                        v394 = nil
                                    end

                                    do
                                        local humanoidRootPart = v394 and v394:FindFirstChild("HumanoidRootPart")
                                        local v397 = if humanoidRootPart and humanoidRootPart:IsA("BasePart") then humanoidRootPart else nil
                                        local v398

                                        do
                                            local v399, v400 = false, false

                                            if v393 ~= char then
                                                if v397 then
                                                    do
                                                        local position = v397.Position
                                                        v398 = false

                                                        if position ~= nil then
                                                            local v402 = Effects.CamDistance(position)
                                                            v398 = Effects.NEAR < v402
                                                        end
                                                    end

                                                    v399 = true
                                                else
                                                    v400 = true
                                                end
                                            end

                                            if v399 and v398 then
                                                v400 = true
                                            end

                                            if v400 then
                                                return
                                            end
                                        end
                                    end

                                    Effects.Heal(v393, (tonumber(a309.duration) or 3))

                                    return
                                end
                            end

                            if a308 == "Status" then
                                do
                                    local v403
                                    local v404

                                    do
                                        local target = a309.target

                                        if typeof(target) == "Instance" then
                                            if target:IsA("Player") then
                                                v403 = target.Character
                                            else
                                                v403 = if target:IsA("Model") then target else nil
                                            end
                                        else
                                            v403 = nil
                                        end
                                    end

                                    if typeof(v403) == "Instance" then
                                        if v403:IsA("Player") then
                                            v404 = v403.Character
                                        else
                                            v404 = if v403:IsA("Model") then v403 else nil
                                        end
                                    else
                                        v404 = nil
                                    end

                                    do
                                        local humanoidRootPart = v404 and v404:FindFirstChild("HumanoidRootPart")
                                        local v407 = if humanoidRootPart and humanoidRootPart:IsA("BasePart") then humanoidRootPart else nil

                                        if v403 ~= char then
                                            if not v407 then
                                                break
                                            end

                                            do
                                                local position = v407.Position
                                                local v409 = position ~= nil
                                                    and Effects.NEAR < Effects.CamDistance(position)
                                                if v409 then
                                                    break
                                                end
                                            end
                                        end
                                    end

                                    if a309.status == "Caltrops" then
                                        if v403 and v403:IsA("Model") then
                                            Effects.CaltropStep(v403)
                                        end

                                        if v403 == char then
                                            Hud.Toast("CALTROPS", Color3.fromRGB(214, 180, 140), 0.9)
                                        end

                                        return
                                    end

                                    Effects.Status(v403, a309.status, (tonumber(a309.duration) or 1))

                                    if v403 == char and a309.status == "Burn" then
                                        Hud.Toast("BURNING", Color3.fromRGB(255, 140, 60), 1)
                                        return
                                    end

                                    if v403 == char and a309.status == "Snare" then
                                        Hud.Toast("SNARED", Color3.fromRGB(226, 196, 140), 1.2)
                                        return
                                    end
                                end
                            elseif a308 == "Charge" then
                                do
                                    local v410

                                    do
                                        local attacker = a309.attacker

                                        if typeof(attacker) == "Instance" then
                                            if attacker:IsA("Player") then
                                                v410 = attacker.Character
                                            else
                                                v410 = if attacker:IsA("Model") then attacker else nil
                                            end
                                        else
                                            v410 = nil
                                        end
                                    end

                                    if v410 and v410 ~= char and a309.on then
                                        local v412

                                        if typeof(v410) == "Instance" then
                                            if v410:IsA("Player") then
                                                v412 = v410.Character
                                            else
                                                v412 = if v410:IsA("Model") then v410 else nil
                                            end
                                        else
                                            v412 = nil
                                        end

                                        local humanoidRootPart = v412 and v412:FindFirstChild("HumanoidRootPart")
                                        local v414 = if humanoidRootPart and humanoidRootPart:IsA("BasePart") then humanoidRootPart else nil
                                        local v415 = Combat.Kind(a309.weaponId)
                                        local weaponId = a309.weaponId

                                        do
                                            local v417 = Presentation.For(weaponId, v415)

                                            if a309.kind == "Draw" then
                                                Util.Sound((v417.drawSound or "Bow_Draw"), v414)
                                                return
                                            end

                                            if a309.kind == "Heavy" or a309.kind == "Lunge" then
                                                Util.Sound((v417.chargeSound or "Charge_Up"), v414)
                                                return
                                            end

                                            if a309.kind == "Throw" then
                                                Util.Sound((v417.windupSound or "Throw_Windup"), v414)
                                                return
                                            end
                                        end
                                    end
                                end
                            elseif a308 == "Reload" then
                                do
                                    local v418

                                    do
                                        local attacker = a309.attacker

                                        if typeof(attacker) == "Instance" then
                                            if attacker:IsA("Player") then
                                                v418 = attacker.Character
                                            else
                                                v418 = if attacker:IsA("Model") then attacker else nil
                                            end
                                        else
                                            v418 = nil
                                        end
                                    end

                                    if v418 and v418 ~= char then
                                        do
                                            local v420 = Combat.Kind(a309.weaponId) or "Crossbow"
                                            local weaponId = a309.weaponId
                                            local v422 = Presentation.For(weaponId, v420)

                                            task.delay(
                                                0.5,
                                                function()
                                                    --[[
                                                      line: 1293
                                                      upvalues:
                                                        Util (copy, index: 1)
                                                        v422 (copy, index: 2)
                                                        v418 (copy, index: 3)
                                                    ]]
                                                    local v423
                                                    local sound = Util.Sound
                                                    local reloadSound = v422.reloadSound or "Crossbow_Reload"

                                                    if typeof(v418) == "Instance" then
                                                        if v418:IsA("Player") then
                                                            v423 = v418.Character
                                                        else
                                                            v423 = if v418:IsA("Model") then v418 else nil
                                                        end
                                                    else
                                                        v423 = nil
                                                    end

                                                    local humanoidRootPart = v423
                                                        and v423:FindFirstChild("HumanoidRootPart")
                                                    local v427 = if humanoidRootPart
                                                        and humanoidRootPart:IsA("BasePart") then humanoidRootPart else nil
                                                    sound(reloadSound, v427)
                                                end
                                            )
                                        end

                                        return
                                    end
                                end
                            elseif a308 == "Block" then
                                do
                                    local v428

                                    do
                                        local attacker = a309.attacker

                                        if typeof(attacker) == "Instance" then
                                            if attacker:IsA("Player") then
                                                v428 = attacker.Character
                                            else
                                                v428 = if attacker:IsA("Model") then attacker else nil
                                            end
                                        else
                                            v428 = nil
                                        end
                                    end

                                    if v428 and v428 ~= char and a309.on then
                                        do
                                            local timestamp4 = os.clock()

                                            if 0.5 <= timestamp4 - (v304[v428] or -math.huge) then
                                                local v431
                                                v304[v428] = timestamp4

                                                do
                                                    local sound = Util.Sound

                                                    if typeof(v428) == "Instance" then
                                                        if v428:IsA("Player") then
                                                            v431 = v428.Character
                                                        else
                                                            v431 = if v428:IsA("Model") then v428 else nil
                                                        end
                                                    else
                                                        v431 = nil
                                                    end

                                                    local humanoidRootPart = v431
                                                        and v431:FindFirstChild("HumanoidRootPart")
                                                    local v434 = if humanoidRootPart
                                                        and humanoidRootPart:IsA("BasePart") then humanoidRootPart else nil
                                                    sound("Block_Up", v434)

                                                    return
                                                end
                                            end
                                        end
                                    end
                                end
                            elseif a308 == "Use" then
                                do
                                    local v435

                                    do
                                        local attacker = a309.attacker

                                        if typeof(attacker) == "Instance" then
                                            if attacker:IsA("Player") then
                                                v435 = attacker.Character
                                            else
                                                v435 = if attacker:IsA("Model") then attacker else nil
                                            end
                                        else
                                            v435 = nil
                                        end
                                    end

                                    if v435 and v435 ~= char then
                                        do
                                            local v437
                                            local v438 = Combat.Kind(a309.weaponId) or "Herbs"
                                            local weaponId = a309.weaponId
                                            local v440 = Presentation.For(weaponId, v438)

                                            if v438 == "Trap" and not Util.IsTeammate(v435) then
                                                return
                                            end

                                            do
                                                local sound = Util.Sound
                                                local useSound = v440.useSound or "Bandage_Wrap"

                                                if typeof(a309.position) ~= "Vector3" then
                                                    local v443

                                                    if typeof(v435) == "Instance" then
                                                        if v435:IsA("Player") then
                                                            v443 = v435.Character
                                                        else
                                                            v443 = if v435:IsA("Model") then v435 else nil
                                                        end
                                                    else
                                                        v443 = nil
                                                    end

                                                    do
                                                        local humanoidRootPart = v443
                                                            and v443:FindFirstChild("HumanoidRootPart")
                                                        v437 = if humanoidRootPart and humanoidRootPart:IsA("BasePart") then humanoidRootPart else nil
                                                    end
                                                else
                                                    v437 = a309.position
                                                end

                                                sound(useSound, v437)

                                                return
                                            end
                                        end
                                    end
                                end
                            elseif a308 == "Equip" then
                                do
                                    local v445

                                    do
                                        local attacker = a309.attacker

                                        if typeof(attacker) == "Instance" then
                                            if attacker:IsA("Player") then
                                                v445 = attacker.Character
                                            else
                                                v445 = if attacker:IsA("Model") then attacker else nil
                                            end
                                        else
                                            v445 = nil
                                        end
                                    end

                                    if v445 and v445 ~= char then
                                        local v447
                                        local v448 = Combat.Kind(a309.weaponId) or "Sword"
                                        local weaponId = a309.weaponId
                                        local v450 = Presentation.For(weaponId, v448)

                                        do
                                            local sound = Util.Sound
                                            local equip = v450.equip or "Equip_Item"

                                            if typeof(v445) == "Instance" then
                                                if v445:IsA("Player") then
                                                    v447 = v445.Character
                                                else
                                                    v447 = if v445:IsA("Model") then v445 else nil
                                                end
                                            else
                                                v447 = nil
                                            end

                                            local humanoidRootPart = v447 and v447:FindFirstChild("HumanoidRootPart")
                                            local v454 = if humanoidRootPart and humanoidRootPart:IsA("BasePart") then humanoidRootPart else nil
                                            sound(equip, v454, {Volume = 0.7})

                                            return
                                        end
                                    end
                                end
                            elseif a308 == "Denied" then
                                if a309.reason == "NotEquipped" then
                                    v36.denied += 1

                                    do
                                        local v455 = v31

                                        if v455 and v455.Parent == v27.char then
                                            local equipAck

                                            do
                                                local equipAck2 = localPlayer:GetAttribute("EquipAck")

                                                if type(equipAck2) ~= "number" then
                                                    equipAck = 0
                                                else
                                                    equipAck = equipAck2
                                                end
                                            end

                                            if not (equipAck < count) or not (os.clock() - timestamp < 4) then
                                                v31 = v455
                                                count += 1
                                                v35[v455] = count
                                                timestamp = os.clock()
                                                v36.requests += 1
                                                enforceWant()

                                                local v458 = v31

                                                if v458 and v26 then
                                                    timestamp2 = os.clock()
                                                    send("Equip", {tool = v458, seq = count})
                                                end
                                            end
                                        end
                                    end

                                    return
                                end

                                do
                                    local handler = v27.handler

                                    if handler and type(handler.OnDenied) == "function" then
                                        handler:OnDenied(a309.reason)
                                        return
                                    end
                                end

                                if a309.reason == "NoCharges" then
                                    Hud.Toast("NONE LEFT THIS ROUND", Color3.fromRGB(255, 120, 90))
                                end
                            end
                        end
                    else
                        do
                            if const number = tonumber(a309.id) then
                                Effects.CaltropsEnd(number)
                                return
                            end
                        end
                    end
                end
            end
        end

        return
    until true
end

function v24.Start()
    --[[
      name: Start
      line: 1343
      upvalues:
        Net (copy, index: 1)
        v26 (ref,  index: 2)
        v27 (copy, index: 3)
        Hud (copy, index: 4)
        Guard (copy, index: 5)
        Poses (copy, index: 6)
        World (copy, index: 7)
        Quality (copy, index: 8)
        Touch (copy, index: 9)
        dispatch (copy, index: 10)
        onHitConfirm (copy, index: 11)
        onDamageTaken (copy, index: 12)
        onCombatFX (copy, index: 13)
        Metrics (copy, index: 14)
        Util (copy, index: 15)
        players (copy, index: 16)
        localPlayer (copy, index: 17)
        Combat (copy, index: 18)
        Presentation (copy, index: 19)
        Keybinds (copy, index: 20)
        onInputBegan (copy, index: 21)
        onInputEnded (copy, index: 22)
        runService (copy, index: 23)
        count (ref,  index: 24)
        timestamp (ref,  index: 25)
        isBusy (ref,  index: 26)
        reconcileEquip (copy, index: 27)
        refreshEquipped (copy, index: 28)
        timestamp2 (ref,  index: 29)
        v31 (ref,  index: 30)
        v36 (copy, index: 31)
        send (copy, index: 32)
        queueReconcile (copy, index: 33)
        copyDecoy (copy, index: 34)
        v255 (ref,  index: 35)
        onCharacter (copy, index: 36)
        autoDraw (copy, index: 37)
        combatDrawToken (ref,  index: 38)
        v35 (copy, index: 39)
        enforceWant (copy, index: 40)
        drawTool (copy, index: 41)
        v24 (copy, index: 42)
        InputStats (ref,  index: 43)
        v22 (copy, index: 44)
        setSpeed (copy, index: 45)
    ]]
    local v461 = false
    local fx2 = nil
    local v463 = Net.UnreliableEvent("CombatFXU")

    v463.OnClientEvent:Connect(
        function(a464, a465)
            --[[
              line: 1349
              upvalues:
                v461 (ref, index: 1)
                fx2 (ref, index: 2)
            ]]
            if v461 and fx2 then
                fx2(a464, a465)
            end
        end
    )

    v26 = Net.Event("WeaponAction")
    local v466 = Net.Event("HitConfirm")
    local v467 = Net.Event("DamageTaken")
    local v468 = Net.Event("CombatFX")
    v27.shotId = math.floor((workspace:GetServerTimeNow() % 1e+05) * 10)
    Hud.Init()
    Guard.Init()
    Poses.Init()
    World.Init()
    Quality.Start()
    Touch.Start(dispatch)

    v466.OnClientEvent:Connect(
        function(a469)
            --[[
              line: 1368
              upvalues:
                onHitConfirm (copy, index: 1)
            ]]
            local success, result = pcall(onHitConfirm, a469)
            if not success then
                warn("[Combat] HitConfirm error:", result)
            end
        end
    )

    v467.OnClientEvent:Connect(
        function(a472)
            --[[
              line: 1374
              upvalues:
                onDamageTaken (copy, index: 1)
            ]]
            local success, result = pcall(onDamageTaken, a472)
            if not success then
                warn("[Combat] DamageTaken error:", result)
            end
        end
    )

    local function fx(a476, a477)
        --[[
          name: fx
          line: 1380
          upvalues:
            onCombatFX (copy, index: 1)
            Metrics (copy, index: 2)
        ]]
        local v478
        local timestamp = os.clock()
        local success, result = pcall(onCombatFX, a476, a477)
        local addFx = Metrics.AddFx
        local elapsedTime = os.clock() - timestamp

        if type(a476) ~= "string" then
            v478 = nil
        else
            v478 = a476
        end

        addFx(elapsedTime, v478)

        if not success then
            warn("[Combat] CombatFX error:", a476, result)
        end
    end

    v468.OnClientEvent:Connect(fx)
    fx2 = fx
    v461 = true
    local v484 = Net.Event("AnimRelay")
    Util.SetAnimRelay(v484)

    v484.OnClientEvent:Connect(
        function(a485, a486, a487, a488, a489, a490)
            --[[
              line: 1396
              upvalues:
                v27 (copy, index: 1)
                Util (copy, index: 2)
            ]]
            if typeof(a485) ~= "Instance" or not a485:IsA("Model") or a485 == v27.char or type(a487) ~= "string" then
                return
            end

            local humanoid = a485:FindFirstChildOfClass("Humanoid")
            local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")

            if not animator or not a485:IsDescendantOf(workspace) then
                return
            end

            local v493

            if type(a488) ~= "number" then
                v493 = 1
            else
                v493 = a488
            end

            if a486 == "Play" then
                Util.PlayAnim(animator, a487, v493, tonumber(a489), (tonumber(a490)))
                return
            end

            if a486 == "Hold" then
                Util.PlayHold(animator, a487, v493)
                return
            end

            if a486 == "Stop" then
                Util.StopAnim(animator, a487, (tonumber(a489)))
            end
        end
    )

    local v494 = {}

    task.spawn(
        function()
            --[[
              line: 1417
              upvalues:
                players (copy, index: 1)
                localPlayer (copy, index: 2)
                Combat (copy, index: 3)
                Presentation (copy, index: 4)
                v494 (copy, index: 5)
                Util (copy, index: 6)
            ]]
            local vector3

            while true do
                task.wait(0.5)
                vector3 = if const camera = workspace.CurrentCamera then camera.CFrame.Position else Vector3.new(0, 0, 0)

                for _, player in players:GetPlayers() do
                    local character = player.Character

                    if player ~= localPlayer then
                        if not character then
                            continue
                        end

                        local instance
                        local tool
                        local hold
                        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                        local humanoid = character:FindFirstChildOfClass("Humanoid")
                        local humanoid2 = humanoid

                        if humanoid2 then
                            instance = humanoid:FindFirstChildOfClass("Animator")
                        else
                            instance = humanoid2
                        end

                        if not humanoidRootPart then
                            continue
                        end
                        if not humanoidRootPart:IsA("BasePart") then
                            continue
                        end
                        if not instance then
                            continue
                        end
                        if 160 < (humanoidRootPart.Position - vector3).Magnitude then
                            continue
                        end

                        if character then
                            tool = character:FindFirstChildOfClass("Tool")
                            tool = tool or nil
                        else
                            tool = nil
                        end

                        local weaponId = tool and tool:GetAttribute("WeaponId")

                        if type(weaponId) == "string" then
                            if not (0 < humanoid.Health) then
                                hold = nil
                            else
                                local v507 = Combat.Kind(weaponId)
                                hold = Presentation.For(weaponId, v507).hold
                            end
                        else
                            hold = nil
                        end

                        local v508 = false
                        local v509 = v494[character]

                        if v509 and v509 ~= hold then
                            Util.StopAnim(instance, v509, 0.15)
                            v494[character] = nil
                        end

                        if hold then
                            local track = Util.GetTrack(instance, hold)

                            if track and not track.IsPlaying then
                                Util.PlayAnim(instance, hold, 1, 0.2)
                            end

                            v508 = true
                        end

                        if v508 then
                            v494[character] = hold
                        end
                    end
                end

                for v511 in v494 do
                    if not v511.Parent then
                        v494[v511] = nil
                    end
                end
            end
        end
    )

    Keybinds.OnInput("Began", onInputBegan)
    Keybinds.OnInput("Ended", onInputEnded)
    local v512 = 0

    runService.Heartbeat:Connect(
        function()
            --[[
              line: 1462
              upvalues:
                count (ref,  index: 1)
                localPlayer (copy, index: 2)
                v512 (ref,  index: 3)
                timestamp (ref,  index: 4)
                isBusy (ref,  index: 5)
                reconcileEquip (copy, index: 6)
                refreshEquipped (copy, index: 7)
                timestamp2 (ref,  index: 8)
                v31 (ref,  index: 9)
                v27 (copy, index: 10)
                v36 (copy, index: 11)
                v26 (ref,  index: 12)
                send (copy, index: 13)
            ]]
            if count ~= 0 then
                local equipAck
                local equipAck2 = localPlayer:GetAttribute("EquipAck")

                if type(equipAck2) ~= "number" then
                    equipAck = 0
                else
                    equipAck = equipAck2
                end

                if not (count <= equipAck) and v512 ~= count then
                    local timestamp3 = os.clock()

                    if not (4 <= timestamp3 - timestamp) then
                        if 1 <= timestamp3 - timestamp2
                            and v31
                            and v27.hum ~= nil
                            and 0 < v27.hum.Health
                            and v27.char ~= nil
                            and (v27.char.Parent ~= nil)
                        then
                            v36.resent += 1
                            local v516 = v31

                            if v516 and v26 then
                                timestamp2 = os.clock()
                                send("Equip", {tool = v516, seq = count})
                            end
                        end
                    else
                        v512 = count

                        if not isBusy then
                            isBusy = true

                            task.defer(
                                function()
                                    --[[
                                      line: 563
                                      upvalues:
                                        isBusy (ref,  index: 1)
                                        reconcileEquip (copy, index: 2)
                                        refreshEquipped (copy, index: 3)
                                    ]]
                                    isBusy = false
                                    reconcileEquip()
                                    refreshEquipped()
                                end
                            )
                        end
                    end
                end
            end
        end
    )

    for _, attribute in {"EquipAck", "EquipSlot"} do
        localPlayer:GetAttributeChangedSignal(attribute):Connect(queueReconcile)
    end

    local v519 = false

    runService.RenderStepped:Connect(
        function(deltaTime: number)
            --[[
              line: 1480
              upvalues:
                copyDecoy (copy, index: 1)
                v255 (ref,  index: 2)
                v27 (copy, index: 3)
                Util (copy, index: 4)
                v519 (ref,  index: 5)
                Hud (copy, index: 6)
                localPlayer (copy, index: 7)
                Touch (copy, index: 8)
            ]]
            local v521
            copyDecoy()

            if v255 then
                return
            end

            local handler = v27.handler

            if handler
                and v27.hum ~= nil
                and 0 < v27.hum.Health
                and v27.char ~= nil
                and v27.char.Parent ~= nil
            then
                local success, result = pcall(
                    function()
                        --[[
                          line: 1489
                          upvalues:
                            handler (copy, index: 1)
                            deltaTime (copy, index: 2)
                        ]]
                        handler:Update(deltaTime)
                    end
                )
                if not success then
                    warn("[Combat] update error:", result)
                end
            end

            local v525 = not Util.CanAct()

            if v525 ~= v519 then
                v519 = v525
                Hud.SetFrozen(v525)

                if v525 and not v255 then
                    local handler2 = v27.handler

                    if handler2 and type(handler2.Interrupt) == "function" then
                        pcall(
                            function()
                                --[[
                                  line: 834
                                  upvalues:
                                    handler2 (copy, index: 1)
                                ]]
                                handler2:Interrupt()
                            end
                        )
                    end
                end
            end

            local combatMode = localPlayer:GetAttribute("CombatMode")

            if combatMode ~= nil then
                v521 = combatMode == true
            else
                v521 = localPlayer:GetAttribute("State") == "Match"
            end

            local v528 = not Util.IsMouseUnlocked() and localPlayer:GetAttribute("MenuOpen") ~= true
            local setVisible = Hud.SetVisible
            local v530 = v528
                and v27.hum ~= nil
                and 0 < v27.hum.Health
                and v27.char ~= nil
                and v27.char.Parent ~= nil
                and v521
            setVisible(v530)
            Touch.SetVisible(v528 and v521)
        end
    )

    localPlayer.CharacterAdded:Connect(onCharacter)

    if localPlayer.Character then
        task.spawn(onCharacter, localPlayer.Character)
    end

    localPlayer:GetAttributeChangedSignal("CombatDrawToken"):Connect(autoDraw)
    local combatDrawToken2 = localPlayer:GetAttribute("CombatDrawToken")

    if type(combatDrawToken2) == "number" and combatDrawToken2 ~= combatDrawToken then
        combatDrawToken = combatDrawToken2

        task.spawn(
            function()
                --[[
                  line: 702
                  upvalues:
                    localPlayer (copy, index: 1)
                    combatDrawToken2 (copy, index: 2)
                    v27 (copy, index: 3)
                    count (ref,  index: 4)
                    timestamp (ref,  index: 5)
                    v31 (ref,  index: 6)
                    v35 (copy, index: 7)
                    v36 (copy, index: 8)
                    enforceWant (copy, index: 9)
                    v26 (ref,  index: 10)
                    timestamp2 (ref,  index: 11)
                    send (copy, index: 12)
                    drawTool (copy, index: 13)
                    v24 (copy, index: 14)
                ]]
                local timestamp3 = os.clock()
                local timestamp4 = -math.huge

                while os.clock() - timestamp3 < 10 do
                    if localPlayer:GetAttribute("CombatDrawToken") ~= combatDrawToken2 then
                        return
                    end

                    local combatDrawSlot = localPlayer:GetAttribute("CombatDrawSlot")

                    if combatDrawSlot == 0 then
                        return
                    end

                    local char = v27.char
                    local hum = v27.hum

                    if char
                        and hum
                        and 0 < hum.Health
                        and char == localPlayer.Character
                        and char:IsDescendantOf(workspace)
                    then
                        local tool = char:FindFirstChildOfClass("Tool")
                        local v538 = false

                        if tool ~= nil then
                            v538 = tool ~= nil and tool:IsA("Tool") and type(tool:GetAttribute("WeaponId")) == "string"
                            v538 = v538 and tool:GetAttribute("DrawToken") == combatDrawToken2
                        end

                        if v538 then
                            local v539 = false
                            local equipAck = localPlayer:GetAttribute("EquipAck")

                            if type(equipAck) ~= "number" then
                                equipAck = 0
                            end

                            if equipAck < count then
                                v539 = os.clock() - timestamp < 4
                            end

                            if not v539 then
                                local equipSlot = localPlayer:GetAttribute("EquipSlot")

                                if type(equipSlot) == "number" then
                                    if 0 < equipSlot then
                                        return
                                    end
                                end

                                if 0.5 < os.clock() - timestamp4 then
                                    local timestamp5 = os.clock()
                                    v31 = tool
                                    count += 1
                                    v35[tool] = count
                                    timestamp = os.clock()
                                    v36.requests += 1
                                    enforceWant()

                                    if const v543 = v31 then
                                        if v26 then
                                            timestamp2 = os.clock()
                                            send("Equip", {tool = v543, seq = count})
                                            timestamp4 = timestamp5
                                        else
                                            timestamp4 = timestamp5
                                        end
                                    else
                                        timestamp4 = timestamp5
                                    end
                                end
                            end
                        end

                        if not v538 then
                            if type(combatDrawSlot) ~= "number" and type(combatDrawSlot) ~= "string" then
                                combatDrawSlot = 1
                            end

                            if const v544 = drawTool(combatDrawSlot, combatDrawToken2) then
                                v24.Equip(v544)
                            end
                        end
                    end

                    task.wait(0.1)
                end
            end
        )
    end

    for _, attribute in {"CombatMode", "State"} do
        localPlayer:GetAttributeChangedSignal(attribute):Connect(
            function()
                --[[
                  line: 1519
                  upvalues:
                    refreshEquipped (copy, index: 1)
                ]]
                task.defer(refreshEquipped)
            end
        )
    end

    task.spawn(
        function()
            --[[
              line: 1525
              upvalues:
                localPlayer (copy, index: 1)
                InputStats (ref,  index: 2)
                Util (copy, index: 3)
                v24 (copy, index: 4)
                v22 (copy, index: 5)
                setSpeed (copy, index: 6)
            ]]
            local core = localPlayer:WaitForChild("PlayerScripts"):WaitForChild("Core", 30)
            local inputStats = core and core:WaitForChild("InputStats", 30)

            if inputStats and inputStats:IsA("ModuleScript") then
                local inputStats2 = inputStats
                local InputStats2 = require(inputStats2)
                InputStats = InputStats2
                InputStats2.Watch(Util, 512)
                InputStats2.Watch(v24, 1024)

                for _, v552 in v22 do
                    InputStats2.Watch(v552, 1024)
                end

                local probe = InputStats2.PROBE
                InputStats2.Hooked(Util.Recoil, probe.n, 1)
                InputStats2.Hooked(v22.Melee.Detect, probe.t, 1, 2, 3)
                InputStats2.Hooked(Util.AimDirection, probe.v)
                InputStats2.Hooked(setSpeed, probe.s, 1)
                InputStats2.Hooked(Util.RecoilSlow, probe.n, 1)
                InputStats2.Hooked(Util.Shake, probe.n, 1)
                probe.m = setmetatable({lastSwing = os.clock()}, v22.Melee)
                probe.ml = rawget(probe.m, "lastSwing")
            end
        end
    )
end

function v24.PlayFX(a554, a555)
    --[[
      name: PlayFX
      line: 1553
      upvalues:
        onCombatFX (copy, index: 1)
    ]]
    local success, result = pcall(onCombatFX, a554, a555)
    if not success then
        warn("[Combat] replay FX error:", a554, result)
    end
end

function v24.SetReplayHud(replayHud)
    --[[
      name: SetReplayHud
      line: 1563
      upvalues:
        v255 (ref,  index: 1)
        Touch (copy, index: 2)
        dropHandler (copy, index: 3)
        v27 (copy, index: 4)
        refreshEquipped (copy, index: 5)
    ]]
    if v255 == replayHud then
        return
    end

    v255 = replayHud

    if replayHud then
        Touch.SetVisible(false)
        return
    end

    pcall(dropHandler)
    v27.tool = nil
    pcall(refreshEquipped)
end

function v24.ReplayHitConfirm(a559)
    --[[
      name: ReplayHitConfirm
      line: 1577
      upvalues:
        onHitConfirm (copy, index: 1)
    ]]
    local success, result = pcall(onHitConfirm, a559)
    if not success then
        warn("[Combat] replay HitConfirm error:", result)
    end
end

function v24.ReplayDamageTaken(a562)
    --[[
      name: ReplayDamageTaken
      line: 1584
      upvalues:
        onDamageTaken (copy, index: 1)
    ]]
    local success, result = pcall(onDamageTaken, a562)
    if not success then
        warn("[Combat] replay DamageTaken error:", result)
    end
end

function v24.State()
    --[[
      name: State
      line: 1592
      upvalues:
        v31 (ref,  index: 13)
        v27 (copy, index: 14)
        count (ref,  index: 15)
        localPlayer (copy, index: 16)
        timestamp (ref,  index: 17)
        v36 (copy, index: 18)
        v235 (copy, index: 19)
    ]]
    local equipAck
    local equipAck2
    local v567 = v31
    local v568 = v27
    local v569 = {kind = v568.kind, speed = if v568.hum then v568.hum.WalkSpeed else nil}
    v569.shotId = v568.shotId
    v569.tool = v568.tool and v568.tool.Name or nil
    v569.wantSlot = not v567 and 0 or v567:GetAttribute("SlotIndex")
    v569.equipSeq = count
    local equipAck3 = localPlayer:GetAttribute("EquipAck")

    if type(equipAck3) ~= "number" then
        equipAck = 0
    else
        equipAck = equipAck3
    end

    v569.equipAck = equipAck
    local equipAck4 = localPlayer:GetAttribute("EquipAck")

    if type(equipAck4) ~= "number" then
        equipAck2 = 0
    else
        equipAck2 = equipAck4
    end

    local equipPending = equipAck2 < count and os.clock() - timestamp < 4
    v569.equipPending = equipPending
    v569.equipStats = table.clone(v36)
    v569.inputs = v235.n
    v569.lastInput = v235.last

    return v569
end

return v24