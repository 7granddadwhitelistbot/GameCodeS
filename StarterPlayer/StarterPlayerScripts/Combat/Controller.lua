local Players_upv_1 = game:GetService("Players")
local ReplicatedStorage_1 = game:GetService("ReplicatedStorage")
local RunService_upv_1 = game:GetService("RunService")
local _ = game:GetService("UserInputService")
local Shared_1 = ReplicatedStorage_1:WaitForChild("Shared")
local Net_upv_1 = require(Shared_1.Net)
local Simulation_upv_1 = require(Shared_1:WaitForChild("Simulation"))
local Weapons_upv_1 = require(Shared_1.Weapons)
local Combat_upv_1 = require(Shared_1.Combat)
local Keybinds_upv_1 = require(Shared_1:WaitForChild("Keybinds"))
local Loc_upv_1 = require(Shared_1:WaitForChild("Loc"))
local Util_upv_1 = require(script.Parent.Util)
local Hud_upv_1 = require(script.Parent.Hud)
local Effects_upv_1 = require(script.Parent.Effects)
local Presentation_upv_1 = require(script.Parent.Presentation)
local Guard_upv_1 = require(script.Parent.Guard)
local Poses_upv_1 = require(script.Parent.Poses)
local Metrics_upv_1 = require(script.Parent.Metrics)
local Touch_upv_1 = require(script.Parent.Touch)
local Quality_upv_1 = require(script.Parent.Quality)
local World_upv_1 = require(script.Parent.World)
local RankFx_upv_1 = require(script.Parent.RankFx)
local tbl_upv_1 = {}
tbl_upv_1.Melee = require(script.Parent.Handlers.Melee)
tbl_upv_1.Bow = require(script.Parent.Handlers.Bow)
tbl_upv_1.Gun = require(script.Parent.Handlers.Gun)
tbl_upv_1.Throw = require(script.Parent.Handlers.Throw)
tbl_upv_1.Use = require(script.Parent.Handlers.Use)
local tbl_upv_2 = {Crossbow = "Gun", Axe = "Melee", Shield = "Melee", Sword = "Melee", Spear = "Melee", Knives = "Throw", Club = "Melee", Gauntlets = "Melee", Dagger = "Melee", Horn = "Use", Bow = "Bow", Musket = "Gun", Fists = "Melee", Katana = "Melee", Scythe = "Melee", Trap = "Use", Herbs = "Use", Bomb = "Throw", Sling = "Throw", Javelin = "Throw", Blunderbuss = "Gun", Pistol = "Gun", Hatchets = "Melee"}
local tbl_upv_3 = {}
local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
local u1 = nil
local tbl_upv_4 = {lastKillAt = 0, killStreak = 0, shotId = 0, baseSpeed = 1, lastSpeed = -1}
tbl_upv_4.pressed = {}
tbl_upv_4.speed = {}
tbl_upv_4.conns = {}
local function combatMode()
    --[[
      name: combatMode
      line: 118
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local v1 = LocalPlayer_upv_1:GetAttribute("CombatMode")
    if v1 ~= nil then
        return v1 == true
    end
    local v2 = LocalPlayer_upv_1:GetAttribute("State") == "Match"
    return v2
end
local u2 = nil
local u3 = 0
local u4 = 0
local u5 = 0
local u6 = setmetatable({}, {__mode = "k"})
local tbl_upv_5 = {adopted = 0, reasked = 0, stale = 0, denied = 0, resent = 0, requests = 0}
local u7 = -math.huge
local u8 = nil
local tbl_6 = {}
local tbl_7 = {}
function tbl_7.__index(a1, a2)
    --[[
      name: __index
      line: 154
      upvalues:
        u8 (ref,  index: 1)
        tbl_upv_4 (copy, index: 2)
    ]]
    if u8 then
        u8.Note(128)
    end
    return tbl_upv_4[a2]
end
function tbl_7.__newindex(a1, a2, a3)
    --[[
      name: __newindex
      line: 160
      upvalues:
        u8 (ref,  index: 1)
        tbl_upv_4 (copy, index: 2)
    ]]
    if u8 then
        u8.Note(128)
    end
    tbl_upv_4[a2] = a3
end
local v1 = setmetatable(tbl_6, tbl_7)
local tbl_upv_8 = {}
local tbl_upv_9 = {}
local tbl_10 = {shotId = 0}
tbl_10.speed = {[tbl_upv_9] = true}
local tbl_11 = {shotId = 0}
tbl_11.speed = {[tbl_upv_9] = true}
local tbl_12 = {shotId = 0}
tbl_12.speed = {[tbl_upv_9] = true}
local tbl_13 = {shotId = 0}
tbl_13.speed = {[tbl_upv_9] = true}
local tbl_14 = {shotId = 0}
tbl_14.speed = {[tbl_upv_9] = true}
local tbl_15 = {shotId = 0}
tbl_15.speed = {[tbl_upv_9] = true}
local tbl_16 = {shotId = 0}
tbl_16.speed = {[tbl_upv_9] = true}
local tbl_17 = {shotId = 0}
tbl_17.speed = {[tbl_upv_9] = true}
local tbl_18 = {shotId = 0}
tbl_18.speed = {[tbl_upv_9] = true}
local tbl_19 = {shotId = 0}
tbl_19.speed = {[tbl_upv_9] = true}
local tbl_20 = {shotId = 0}
tbl_20.speed = {[tbl_upv_9] = true}
local tbl_upv_21 = {tbl_18, tbl_13, tbl_20, tbl_16, tbl_10, tbl_14, tbl_17, tbl_19, tbl_11, tbl_15, tbl_12}
local tbl_upv_22 = {shotId = 0}
local function copyDecoy()
    --[[
      name: copyDecoy
      line: 195
      upvalues:
        tbl_upv_8 (copy, index: 1)
        tbl_upv_22 (copy, index: 2)
        tbl_upv_4 (copy, index: 3)
        tbl_upv_21 (copy, index: 4)
        tbl_upv_9 (copy, index: 5)
        u8 (ref,  index: 6)
    ]]
    local v3 = true
    if tbl_upv_8.lastSwing == tbl_upv_22.lastSwing then
        v3 = tbl_upv_8.holding ~= tbl_upv_22.holding
    end
    local handler_1 = tbl_upv_4.handler
    local v4
    if handler_1 then
        v4 = rawget(handler_1, "lastSwing")
    else
        v4 = nil
    end
    tbl_upv_8.lastSwing = v4
    local v5
    if handler_1 then
        v5 = rawget(handler_1, "holding")
    else
        v5 = nil
    end
    tbl_upv_8.holding = v5
    local v6 = nil
    for _, value_1 in tbl_upv_21 do
        if value_1.handler ~= tbl_upv_22.handler or value_1.shotId ~= tbl_upv_22.shotId or value_1.speed[tbl_upv_9] ~= true then
            v3 = true
            value_1.speed[tbl_upv_9] = true
        end
        if handler_1 then
            v6 = tbl_upv_8
        else
            v6 = nil
        end
        value_1.handler = v6
        value_1.shotId = tbl_upv_4.shotId
    end
    if v3 and u8 then
        u8.Note(256)
    end
    local v7
    if handler_1 then
        v7 = tbl_upv_8
    else
        v7 = nil
    end
    tbl_upv_22.handler = v7
    tbl_upv_22.shotId = tbl_upv_4.shotId
    tbl_upv_22.lastSwing = tbl_upv_8.lastSwing
    tbl_upv_22.holding = tbl_upv_8.holding
end
local function send(a1, a2)
    --[[
      name: send
      line: 217
      upvalues:
        u8 (ref,  index: 1)
        u6 (copy, index: 2)
        u1 (ref,  index: 3)
    ]]
    if u8 then
        u8.Caller(8192)
    end
    local tool_1 = a2.tool
    if tool_1 and u6[tool_1] then
        a2.eq = u6[tool_1]
    end
    a2.ct = os.clock()
    local dir_1 = a2.dir
    if typeof(dir_1) == "Vector3" then
        a2.q = ((dir_1.X * 3) + (dir_1.Y * 5)) + (dir_1.Z * 7)
    end
    u1:FireServer(a1, a2)
end
local tbl_upv_23 = {Charge = "Charge", Use = "Use", Throw = "Charge", Draw = "Charge", Block = "Block", Reload = "Reload", Aim = "Aim"}
local function applySpeed()
    --[[
      name: applySpeed
      line: 248
      upvalues:
        tbl_upv_4 (copy, index: 1)
        tbl_upv_23 (copy, index: 2)
        Simulation_upv_1 (copy, index: 3)
    ]]
    local tbl_24 = {Charge = false, Use = false, Block = false, Reload = false, Aim = false}
    for key_1 in tbl_upv_4.speed do
        local v8 = tbl_upv_23[key_1]
        if v8 then
            tbl_24[v8] = true
        end
    end
    for key_2, value_2 in tbl_24 do
        Simulation_upv_1.SetInput(key_2, value_2)
    end
end
local tbl_upv_25 = {}
function tbl_upv_3.OnViewEvent(a1)
    --[[
      name: OnViewEvent
      line: 287
      upvalues:
        tbl_upv_25 (copy, index: 1)
    ]]
    table.insert(tbl_upv_25, a1)
    return function()
        --[[
          line: 289
          upvalues:
            tbl_upv_25 (copy, index: 1)
            a1 (copy, index: 2)
        ]]
        local v9 = table.find(tbl_upv_25, a1)
        if not v9 then
            return
        end
        table.remove(tbl_upv_25, v9)
    end
end
local function presetFor(a1, a2)
    --[[
      name: presetFor
      line: 297
      upvalues:
        Presentation_upv_1 (copy, index: 1)
    ]]
    return Presentation_upv_1.For(a2, a1)
end
local function modelOf(a1)
    --[[
      name: modelOf
      line: 301
    ]]
    if typeof(a1) == "Instance" then
        if a1:IsA("Player") then
            return a1.Character
        end
        if a1:IsA("Model") then
            return a1
        end
    end
    return nil
end
local function rootOf(a1)
    --[[
      name: rootOf
      line: 314
    ]]
    local v10
    if typeof(a1) == "Instance" then
        if a1:IsA("Player") then
            v10 = a1.Character
        elseif a1:IsA("Model") then
            v10 = a1
        else
            v10 = nil
        end
    else
        v10 = nil
    end
    local v11 = v10 and (v10:FindFirstChild("HumanoidRootPart"))
    if v11 and v11:IsA("BasePart") then
        return v11
    end
    return nil
end
local function toolOf(a1)
    --[[
      name: toolOf
      line: 320
    ]]
    local v12 = (a1 and (a1:FindFirstChildOfClass("Tool"))) or nil
    return v12
end
local function isFar(a1)
    --[[
      name: isFar
      line: 324
      upvalues:
        Effects_upv_1 (copy, index: 1)
    ]]
    local v13 = (a1 ~= nil) and (Effects_upv_1.NEAR < Effects_upv_1.CamDistance(a1))
    return v13
end
local function dropHandler()
    --[[
      name: dropHandler
      line: 345
      upvalues:
        tbl_upv_4 (copy, index: 1)
        applySpeed (copy, index: 2)
    ]]
    local handler_upv_2 = tbl_upv_4.handler
    if handler_upv_2 then
        tbl_upv_4.handler = nil
        pcall(
            function()
                --[[
                  line: 349
                  upvalues:
                    handler_upv_2 (copy, index: 1)
                ]]
                handler_upv_2:Unequip()
            end
        )
    end
    table.clear(tbl_upv_4.pressed)
    table.clear(tbl_upv_4.speed)
    applySpeed()
end
local function nextId()
    --[[
      name: nextId
      line: 237
      upvalues:
        tbl_upv_4 (copy, index: 1)
    ]]
    tbl_upv_4.shotId = tbl_upv_4.shotId + 1
    return tbl_upv_4.shotId
end
local function emitView(a1, a2)
    --[[
      name: emitView
      line: 277
      upvalues:
        tbl_upv_25 (copy, index: 1)
    ]]
    for _, value_3 in tbl_upv_25 do
        local success_1, v14 = pcall(value_3, a1, a2)
        if not (success_1) then
            warn("[Combat] view event listener error:", v14)
        end
    end
end
local function setSpeed(a1, a2)
    --[[
      name: setSpeed
      line: 261
      upvalues:
        Util_upv_1 (copy, index: 1)
        tbl_upv_4 (copy, index: 2)
        applySpeed (copy, index: 3)
    ]]
    local v15 = Util_upv_1.Probe(a1, a2)
    if v15 ~= nil then
        return v15
    end
    tbl_upv_4.speed[a1] = a2
    applySpeed()
    local v16 = Util_upv_1.ProbeValues()
    if v16 then
        return v16.k * (a2 or 1)
    end
    return nil
end
local function alive()
    --[[
      name: alive
      line: 112
      upvalues:
        tbl_upv_4 (copy, index: 1)
    ]]
    return (tbl_upv_4.hum ~= nil) and ((tbl_upv_4.hum.Health > 0) and ((tbl_upv_4.char ~= nil) and (tbl_upv_4.char.Parent ~= nil)))
end
local function refreshEquipped()
    --[[
      name: refreshEquipped
      line: 358
      upvalues:
        tbl_upv_4 (copy, index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
        dropHandler (copy, index: 3)
        Hud_upv_1 (copy, index: 4)
        Touch_upv_1 (copy, index: 5)
        u2 (ref,  index: 6)
        Combat_upv_1 (copy, index: 7)
        Weapons_upv_1 (copy, index: 8)
        applySpeed (copy, index: 9)
        tbl_upv_1 (copy, index: 10)
        tbl_upv_2 (copy, index: 11)
        Presentation_upv_1 (copy, index: 12)
        send (copy, index: 13)
        nextId (copy, index: 14)
        setSpeed (copy, index: 15)
        alive (copy, index: 16)
        emitView (copy, index: 17)
        Util_upv_1 (copy, index: 18)
    ]]
    local char_1 = tbl_upv_4.char
    if char_1 and (tbl_upv_4.hum ~= nil) and ((tbl_upv_4.hum.Health > 0) and ((tbl_upv_4.char ~= nil) and (tbl_upv_4.char.Parent ~= nil))) then
        local v17 = LocalPlayer_upv_1:GetAttribute("CombatMode")
        local v18
        if v17 ~= nil then
            v18 = v17 == true
        else
            v18 = LocalPlayer_upv_1:GetAttribute("State") == "Match"
        end
        if v18 then
            local v19
            if (u2) and u2.Parent == char_1 then
                v19 = u2
            else
                v19 = char_1:FindFirstChildOfClass("Tool")
            end
            if v19 == tbl_upv_4.tool and tbl_upv_4.handler then
                return
            end
            dropHandler()
            tbl_upv_4.tool = v19
            v17 = Combat_upv_1.FISTS_ID
            local v20 = nil
            if v19 then
                v20 = v19:GetAttribute("WeaponId")
                if type(v20) == "string" and Weapons_upv_1.Get(v20) then
                    v17 = v20
                    local v21 = Weapons_upv_1.Get(v17)
                    local v22 = Combat_upv_1.Tuning(v17)
                    local v23 = Combat_upv_1.Kind(v17) or "Fists"
                    tbl_upv_4.kind = v23
                    tbl_upv_4.baseSpeed = v22.speedMult or 1
                    applySpeed()
                    local v24 = tbl_upv_1[tbl_upv_2[v23] or ""]
                    if v24 then
                        local u9 = v24.new({player = LocalPlayer_upv_1, char = char_1, hum = tbl_upv_4.hum, root = tbl_upv_4.root, animator = tbl_upv_4.animator, tool = v19, weaponId = v17, def = v21, tuning = v22, kind = v23, preset = Presentation_upv_1.For(v17, v23), send = send, nextId = nextId, setSpeed = setSpeed, alive = alive, emit = emitView})
                        tbl_upv_4.handler = u9
                        Hud_upv_1.SetPips(0, 0)
                        Hud_upv_1.SetArc(nil)
                        local SetWeapon_1 = Touch_upv_1.SetWeapon
                        local v25
                        if v19 then
                            v25 = v23
                        else
                            v25 = nil
                        end
                        SetWeapon_1(v25, v22)
                        local success_2, v26 = pcall(
                            function()
                                --[[
                                  line: 420
                                  upvalues:
                                    u9 (copy, index: 1)
                                ]]
                                u9:Equip()
                            end
                        )
                        if not (success_2) then
                            warn("[Combat] equip error:", v26)
                        end
                        local v27 = Util_upv_1.GuardRecovery(v19)
                        if v27 > 0 then
                            Hud_upv_1.SetArc(v27, Color3.fromRGB(150, 196, 236))
                        end
                    else
                        Hud_upv_1.SetStyle("Dot")
                    end
                    return
                end
                Hud_upv_1.SetStyle("Dot")
                return
            end
            local v21 = Weapons_upv_1.Get(v17)
            local v22 = Combat_upv_1.Tuning(v17)
            local v23 = Combat_upv_1.Kind(v17) or "Fists"
            tbl_upv_4.kind = v23
            tbl_upv_4.baseSpeed = v22.speedMult or 1
            applySpeed()
            local v24 = tbl_upv_1[tbl_upv_2[v23] or ""]
            if v24 then
                local u9 = v24.new({player = LocalPlayer_upv_1, char = char_1, hum = tbl_upv_4.hum, root = tbl_upv_4.root, animator = tbl_upv_4.animator, tool = v19, weaponId = v17, def = v21, tuning = v22, kind = v23, preset = Presentation_upv_1.For(v17, v23), send = send, nextId = nextId, setSpeed = setSpeed, alive = alive, emit = emitView})
                tbl_upv_4.handler = u9
                Hud_upv_1.SetPips(0, 0)
                Hud_upv_1.SetArc(nil)
                local SetWeapon_1 = Touch_upv_1.SetWeapon
                local v25
                if v19 then
                    v25 = v23
                else
                    v25 = nil
                end
                SetWeapon_1(v25, v22)
                local success_2, v26 = pcall(
                    function()
                        --[[
                          line: 420
                          upvalues:
                            u9 (copy, index: 1)
                        ]]
                        u9:Equip()
                    end
                )
                if not (success_2) then
                    warn("[Combat] equip error:", v26)
                end
                local v27 = Util_upv_1.GuardRecovery(v19)
                if v27 > 0 then
                    Hud_upv_1.SetArc(v27, Color3.fromRGB(150, 196, 236))
                end
            else
                Hud_upv_1.SetStyle("Dot")
            end
            return
        end
    end
    tbl_upv_4.baseSpeed = 1
    dropHandler()
    tbl_upv_4.tool = nil
    tbl_upv_4.kind = nil
    Hud_upv_1.SetStyle("Dot")
    Hud_upv_1.SetPips(0, 0)
    Hud_upv_1.SetArc(nil)
    Touch_upv_1.SetWeapon(nil)
end
local function isWeaponTool(a1)
    --[[
      name: isWeaponTool
      line: 435
    ]]
    local v28 = (a1 ~= nil) and (a1:IsA("Tool") and (type(a1:GetAttribute("WeaponId")) == "string"))
    return v28
end
local function acked()
    --[[
      name: acked
      line: 458
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local v29 = LocalPlayer_upv_1:GetAttribute("EquipAck")
    if type(v29) ~= "number" then
        return 0
    end
    return v29
end
local function equipPending()
    --[[
      name: equipPending
      line: 464
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        u3 (ref,  index: 2)
        u4 (ref,  index: 3)
    ]]
    local v30 = false
    local v31 = LocalPlayer_upv_1:GetAttribute("EquipAck")
    local v32
    if type(v31) ~= "number" then
        v32 = 0
    else
        v32 = v31
    end
    if v32 < u3 then
        v30 = os.clock() - u4 < 4
    end
    return v30
end
local function backpack()
    --[[
      name: backpack
      line: 442
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local v33 = LocalPlayer_upv_1:GetAttribute("CombatDrawToken")
    local v34 = nil
    for _, value_4 in LocalPlayer_upv_1:GetChildren() do
        local v35 = value_4:IsA("Backpack")
        if not (v35) then
            continue
        end
        v34 = v34 or value_4
        for v36, value_5 in value_4:GetChildren() do
            if value_5:GetAttribute("DrawToken") ~= v33 then
                continue
            end
            return value_4
        end
    end
    return v34
end
local function enforceWant()
    --[[
      name: enforceWant
      line: 482
      upvalues:
        tbl_upv_4 (copy, index: 1)
        u2 (ref,  index: 2)
        backpack (copy, index: 3)
    ]]
    local char_2 = tbl_upv_4.char
    local hum_1 = tbl_upv_4.hum
    if not char_2 or not hum_1 or hum_1.Health <= 0 or not u2 then
        return
    end
    local v36 = backpack()
    if u2.Parent ~= char_2 and u2.Parent ~= v36 then
        u2 = nil
        return
    end
    if u2.Parent ~= char_2 then
        hum_1:EquipTool(u2)
    end
    if not v36 then
        return
    end
    for _, value_6 in char_2:GetChildren() do
        if value_6 == u2 then
            continue
        end
        local v37 = (value_6 ~= nil) and (value_6:IsA("Tool") and (type(value_6:GetAttribute("WeaponId")) == "string"))
        if v37 then
            value_6.Parent = v36
        end
    end
end
local function sendEquip()
    --[[
      name: sendEquip
      line: 504
      upvalues:
        u2 (ref,  index: 1)
        u1 (ref,  index: 2)
        u5 (ref,  index: 3)
        send (copy, index: 4)
        u3 (ref,  index: 5)
    ]]
    local v38 = u2
    if not v38 or not u1 then
        return
    end
    u5 = os.clock()
    send("Equip", {tool = v38, seq = u3})
end
local function requestEquip(a1)
    --[[
      name: requestEquip
      line: 513
      upvalues:
        u2 (ref,  index: 1)
        u3 (ref,  index: 2)
        u6 (copy, index: 3)
        u4 (ref,  index: 4)
        tbl_upv_5 (copy, index: 5)
        enforceWant (copy, index: 6)
        u1 (ref,  index: 7)
        u5 (ref,  index: 8)
        send (copy, index: 9)
    ]]
    u2 = a1
    u3 = u3 + 1
    u6[a1] = u3
    u4 = os.clock()
    tbl_upv_5.requests = tbl_upv_5.requests + 1
    enforceWant()
    local v39 = u2
    if not v39 or not u1 then
        return
    end
    u5 = os.clock()
    send("Equip", {tool = v39, seq = u3})
end
local function toolInSlot(a1)
    --[[
      name: toolInSlot
      line: 468
      upvalues:
        tbl_upv_4 (copy, index: 1)
        backpack (copy, index: 2)
    ]]
    local tbl_26 = {tbl_upv_4.char, backpack()}
    for _, value_7 in tbl_26 do
        if not (value_7) then
            continue
        end
        for v41, value_8 in value_7:GetChildren() do
            local v40 = (value_8 ~= nil) and (value_8:IsA("Tool") and (type(value_8:GetAttribute("WeaponId")) == "string"))
            if not (v40) or value_8:GetAttribute("SlotIndex") ~= a1 then
                continue
            end
            return value_8
        end
    end
    return nil
end
local function reconcileEquip()
    --[[
      name: reconcileEquip
      line: 524
      upvalues:
        tbl_upv_4 (copy, index: 1)
        backpack (copy, index: 2)
        u2 (ref,  index: 3)
        LocalPlayer_upv_1 (copy, index: 4)
        u3 (ref,  index: 5)
        u4 (ref,  index: 6)
        enforceWant (copy, index: 7)
        toolInSlot (copy, index: 8)
        tbl_upv_5 (copy, index: 9)
        u6 (copy, index: 10)
        u7 (ref,  index: 11)
        u1 (ref,  index: 12)
        u5 (ref,  index: 13)
        send (copy, index: 14)
    ]]
    local char_3 = tbl_upv_4.char
    local hum_2 = tbl_upv_4.hum
    if not char_3 or not hum_2 then
        return
    end
    if not (hum_2.Health <= 0) then
        local v41 = backpack()
        if u2 and u2.Parent ~= char_3 and u2.Parent ~= v41 then
            u2 = nil
        end
        local v42 = false
        local v43 = LocalPlayer_upv_1:GetAttribute("EquipAck")
        local v44
        if type(v43) ~= "number" then
            v44 = 0
        else
            v44 = v43
        end
        if v44 < u3 then
            v42 = os.clock() - u4 < 4
        end
        if v42 then
            enforceWant()
        else
            local v45 = LocalPlayer_upv_1:GetAttribute("EquipSlot")
            if type(v45) == "number" and (v45 > 0) then
                v42 = toolInSlot(v45)
            else
                v42 = nil
            end
            if v42 then
                if u2 ~= v42 then
                    if u2 ~= nil then
                        tbl_upv_5.adopted = tbl_upv_5.adopted + 1
                    end
                    u2 = v42
                    u6[v42] = u6[v42] or u3
                end
                enforceWant()
            elseif u2 and os.clock() - u7 > 2 then
                u7 = os.clock()
                tbl_upv_5.reasked = tbl_upv_5.reasked + 1
                local v47 = u2
                u2 = v47
                u3 = u3 + 1
                u6[v47] = u3
                u4 = os.clock()
                tbl_upv_5.requests = tbl_upv_5.requests + 1
                enforceWant()
                local v48 = u2
                if v48 and u1 then
                    u5 = os.clock()
                    send("Equip", {tool = v48, seq = u3})
                end
            end
        end
    end
end
local u10 = false
local function queueReconcile()
    --[[
      name: queueReconcile
      line: 558
      upvalues:
        u10 (ref, index: 1)
    ]]
    if u10 then
        return
    end
    u10 = true
    task.defer(function() end)
end
local function onToolAdded(a1)
    --[[
      name: onToolAdded
      line: 574
      upvalues:
        u2 (ref,  index: 1)
        tbl_upv_4 (copy, index: 2)
        tbl_upv_5 (copy, index: 3)
        u10 (ref,  index: 4)
    ]]
    if a1 == u2 then
        return
    end
    if a1.Parent == tbl_upv_4.char then
        local v49 = (a1 ~= nil) and (a1:IsA("Tool") and (type(a1:GetAttribute("WeaponId")) == "string"))
        if not v49 then
            return
        end
        tbl_upv_5.stale = tbl_upv_5.stale + 1
        if u10 then
            return
        end
        u10 = true
        task.defer(function() end)
    end
end
function tbl_upv_3.Equip(a1)
    --[[
      name: Equip
      line: 584
      upvalues:
        tbl_upv_4 (copy, index: 1)
        backpack (copy, index: 2)
        u2 (ref,  index: 3)
        u3 (ref,  index: 4)
        u6 (copy, index: 5)
        u4 (ref,  index: 6)
        tbl_upv_5 (copy, index: 7)
        enforceWant (copy, index: 8)
        u1 (ref,  index: 9)
        u5 (ref,  index: 10)
        send (copy, index: 11)
        refreshEquipped (copy, index: 12)
    ]]
    local char_4 = tbl_upv_4.char
    local hum_3 = tbl_upv_4.hum
    if a1 and char_4 and hum_3 and not (hum_3.Health <= 0) then
        local v50 = (a1 ~= nil) and (a1:IsA("Tool") and (type(a1:GetAttribute("WeaponId")) == "string"))
        if v50 then
            local v51 = backpack()
            if a1.Parent ~= char_4 and a1.Parent ~= v51 then
                return false
            end
            if a1 == u2 and a1.Parent == char_4 then
                return true
            end
            u2 = a1
            u3 = u3 + 1
            u6[a1] = u3
            u4 = os.clock()
            tbl_upv_5.requests = tbl_upv_5.requests + 1
            enforceWant()
            local v52 = u2
            if v52 and u1 then
                u5 = os.clock()
                send("Equip", {tool = v52, seq = u3})
            end
            refreshEquipped()
            return true
        end
    end
    return false
end
function tbl_upv_3.Wanted()
    --[[
      name: Wanted
      line: 602
      upvalues:
        u2 (ref, index: 1)
    ]]
    return u2
end
local function onCharacter(a1)
    --[[
      name: onCharacter
      line: 606
      upvalues:
        tbl_upv_4 (copy, index: 1)
        dropHandler (copy, index: 2)
        u2 (ref,  index: 3)
        Util_upv_1 (copy, index: 4)
        Combat_upv_1 (copy, index: 5)
        u1 (ref,  index: 6)
        tbl_upv_5 (copy, index: 7)
        u10 (ref,  index: 8)
        refreshEquipped (copy, index: 10)
        Hud_upv_1 (copy, index: 11)
        Touch_upv_1 (copy, index: 12)
        applySpeed (copy, index: 13)
    ]]
    for _, value_9 in tbl_upv_4.conns do
        value_9:Disconnect()
    end
    table.clear(tbl_upv_4.conns)
    dropHandler()
    tbl_upv_4.char = a1
    u2 = nil
    tbl_upv_4.tool = nil
    tbl_upv_4.lastSpeed = -1
    tbl_upv_4.killStreak = 0
    local v53 = a1:WaitForChild("Humanoid", 10)
    local v54 = a1:WaitForChild("HumanoidRootPart", 10)
    if not v53 then
        return
    end
    if v54 then
        tbl_upv_4.hum = v53
        tbl_upv_4.root = v54
        v54 = v53:FindFirstChildOfClass("Animator") or (v53:WaitForChild("Animator", 5))
        tbl_upv_4.animator = not (v54) or not (v54:IsA("Animator")) or v54
        if tbl_upv_4.animator then
            task.spawn(Util_upv_1.Preload, tbl_upv_4.animator)
        end
        table.insert(
            tbl_upv_4.conns,
            a1.ChildAdded:Connect(
                function(a2)
                    --[[
                      line: 632
                      upvalues:
                        Combat_upv_1 (copy, index: 1)
                        a1 (copy, index: 2)
                        u1 (ref,  index: 3)
                        u2 (ref,  index: 4)
                        tbl_upv_4 (copy, index: 5)
                        tbl_upv_5 (copy, index: 6)
                        u10 (ref,  index: 7)
                        refreshEquipped (copy, index: 9)
                    ]]
                    if a2:IsA("Tool") then
                        Combat_upv_1.BindOffHand(a2, a1)
                        local v56 = nil
                        if u1 then
                            v56 = (a2 ~= nil) and (a2:IsA("Tool") and (type(a2:GetAttribute("WeaponId")) == "string"))
                            if v56 and a2 ~= u2 and a2.Parent == tbl_upv_4.char then
                                local v57 = (a2 ~= nil) and (a2:IsA("Tool") and (type(a2:GetAttribute("WeaponId")) == "string"))
                                if v57 then
                                    tbl_upv_5.stale = tbl_upv_5.stale + 1
                                    if not (u10) then
                                        u10 = true
                                        task.defer(function() end)
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
            tbl_upv_4.conns,
            a1.ChildRemoved:Connect(
                function(a3)
                    --[[
                      line: 641
                      upvalues:
                        u2 (ref,  index: 1)
                        u10 (ref,  index: 2)
                        refreshEquipped (copy, index: 4)
                    ]]
                    if not a3:IsA("Tool") then
                        return
                    end
                    if a3 == u2 and not (u10) then
                        u10 = true
                        task.defer(function() end)
                    end
                    task.defer(refreshEquipped)
                end
            )
        )
        table.insert(
            tbl_upv_4.conns,
            v53.Died:Connect(
                function()
                    --[[
                      line: 649
                      upvalues:
                        dropHandler (copy, index: 1)
                        Hud_upv_1 (copy, index: 2)
                        Touch_upv_1 (copy, index: 3)
                    ]]
                    dropHandler()
                    Hud_upv_1.SetStyle("Dot")
                    Hud_upv_1.SetPips(0, 0)
                    Hud_upv_1.SetArc(nil)
                    Touch_upv_1.SetWeapon(nil)
                end
            )
        )
        applySpeed()
        v54 = a1:FindFirstChildOfClass("Tool")
        if v54 and u1 then
            local v58 = (v54 ~= nil) and (v54:IsA("Tool") and (type(v54:GetAttribute("WeaponId")) == "string"))
            if v58 and v54 ~= u2 and v54.Parent == tbl_upv_4.char then
                local v59 = (v54 ~= nil) and (v54:IsA("Tool") and (type(v54:GetAttribute("WeaponId")) == "string"))
                if v59 then
                    tbl_upv_5.stale = tbl_upv_5.stale + 1
                    if not (u10) then
                        u10 = true
                        task.defer(function() end)
                    end
                end
            end
        end
        refreshEquipped()
    end
end
local u11 = nil
local function autoDraw()
    --[[
      name: autoDraw
      line: 696
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        u11 (ref,  index: 2)
    ]]
    local v60 = LocalPlayer_upv_1:GetAttribute("CombatDrawToken")
    if type(v60) ~= "number" or v60 == u11 then
        return
    end
    u11 = v60
    task.spawn(function() end)
end
local tbl_upv_27 = {Reload = "Reload", Aim = "Secondary", Attack = "Primary"}
local tbl_upv_28 = {last = "", n = 0}
local function mapInput(a1)
    --[[
      name: mapInput
      line: 744
      upvalues:
        Keybinds_upv_1 (copy, index: 1)
        tbl_upv_27 (copy, index: 2)
    ]]
    local v61 = nil
    for _, value_10 in Keybinds_upv_1.PadActionsOf(a1) do
        v61 = tbl_upv_27[value_10]
        if not (v61) then
            continue
        end
        return v61
    end
    local UserInputType_1 = a1.UserInputType
    if UserInputType_1 ~= Enum.UserInputType.Keyboard and UserInputType_1 ~= Enum.UserInputType.MouseButton1 and UserInputType_1 ~= Enum.UserInputType.MouseButton2 and UserInputType_1 ~= Enum.UserInputType.MouseButton3 then
        return nil
    end
    local v62 = Keybinds_upv_1.ActionOf(a1)
    if v62 then
        return tbl_upv_27[v62]
    end
    return nil
end
local function handlerInput(a1, a2)
    --[[
      name: handlerInput
      line: 765
      upvalues:
        tbl_upv_4 (copy, index: 1)
        tbl_upv_28 (copy, index: 2)
    ]]
    local handler_upv_3 = tbl_upv_4.handler
    if not handler_upv_3 then
        return
    end
    tbl_upv_28.n = tbl_upv_28.n + 1
    tbl_upv_28.last = a1 .. ((a2 and "+") or "-")
    local success_3, v63 = pcall(
        function()
            --[[
              line: 772
              upvalues:
                handler_upv_3 (copy, index: 1)
                a1 (copy, index: 2)
                a2 (copy, index: 3)
            ]]
            handler_upv_3:Input(a1, a2)
        end
    )
    if (success_3) then
        return
    end
    warn("[Combat] input error:", v63)
end
local function onInputEnded(a1, a2)
    --[[
      name: onInputEnded
      line: 795
      upvalues:
        mapInput (copy, index: 1)
        tbl_upv_4 (copy, index: 2)
        handlerInput (copy, index: 3)
    ]]
    local v64 = mapInput(a1)
    if not v64 or not tbl_upv_4.pressed[v64] then
        return
    end
    tbl_upv_4.pressed[v64] = nil
    handlerInput(v64, false)
end
local function dispatch(a1, a2)
    --[[
      name: dispatch
      line: 805
      upvalues:
        u8 (ref,  index: 1)
        tbl_upv_4 (copy, index: 2)
        Util_upv_1 (copy, index: 3)
        handlerInput (copy, index: 4)
    ]]
    if u8 then
        u8.Caller(8192)
    end
    if a2 then
        if tbl_upv_4.handler and (tbl_upv_4.hum ~= nil) and ((tbl_upv_4.hum.Health > 0) and ((tbl_upv_4.char ~= nil) and (tbl_upv_4.char.Parent ~= nil))) and not (Util_upv_1.IsMouseUnlocked()) then
            tbl_upv_4.pressed[a1] = true
            handlerInput(a1, a2)
            return
        end
        return
    end
    if not tbl_upv_4.pressed[a1] then
        return
    end
    tbl_upv_4.pressed[a1] = nil
    handlerInput(a1, a2)
end
tbl_upv_3.Dispatch = dispatch
local u12 = false
local function interrupt()
    --[[
      name: interrupt
      line: 828
      upvalues:
        u12 (ref,  index: 1)
        tbl_upv_4 (copy, index: 2)
    ]]
    if u12 then
        return
    end
    local handler_4 = tbl_upv_4.handler
    if not handler_4 then
        return
    end
    if type(handler_4.Interrupt) == "function" then
        pcall(function() end)
    end
end
local u13 = 0
local function nameOf(a1)
    --[[
      name: nameOf
      line: 328
      upvalues:
        Players_upv_1 (copy, index: 1)
    ]]
    if not a1 then
        return nil
    end
    local v65 = a1:GetAttribute("DisplayName")
    if type(v65) == "string" and v65 ~= "" then
        return v65
    end
    local v66 = Players_upv_1:GetPlayerFromCharacter(a1)
    if v66 then
        return v66.DisplayName
    elseif a1:HasTag("TrainingDummy") then
        return "Dummy"
    else
        return a1.Name
    end
end
local function onHitConfirm(a1)
    --[[
      name: onHitConfirm
      line: 844
      upvalues:
        Util_upv_1 (copy, index: 1)
        Hud_upv_1 (copy, index: 2)
        Effects_upv_1 (copy, index: 3)
        Combat_upv_1 (copy, index: 4)
        tbl_upv_4 (copy, index: 5)
        nameOf (copy, index: 6)
        Loc_upv_1 (copy, index: 7)
        Presentation_upv_1 (copy, index: 8)
        u13 (ref,  index: 9)
    ]]
    if type(a1) ~= "table" then
        return
    end
    local v67
    if typeof(a1.position) ~= "Vector3" then
        v67 = nil
    else
        v67 = a1.position
    end
    local v68 = tonumber(a1.amount) or 0
    local v69 = true
    if a1.headshot ~= true then
        v69 = a1.crit == true
    end
    local victim_1 = a1.victim
    local v70 = tonumber(a1.armor) or 0
    if a1.armorBroken then
        Util_upv_1.Sound("Shield_Break")
    end
    if v67 and v68 > 0 then
        local v71
        if a1.dot then
            v71 = "dot"
        elseif a1.killed then
            v71 = "kill"
        elseif v69 then
            v71 = "crit"
        elseif a1.blocked then
            v71 = "blocked"
        elseif (v70 > 0) and (v68 - v70 < 0.5) then
            v71 = "armor"
        else
            v71 = "health"
        end
        local v72 = a1.dot or ((a1.headshot) and "HEADSHOT") or (((a1.crit) and "BACKSTAB") or (((a1.blocked) and "BLOCKED") or (((a1.armorBroken) and "ARMOR BROKEN") or nil)))
        Hud_upv_1.DamageNumber(v67, v68, v71, victim_1, v72)
    end
    if a1.dot then
        return
    end
    local v73 = Effects_upv_1.ConsumePrediction(victim_1)
    local v74 = os.clock()
    local v75 = Combat_upv_1.Kind(a1.weaponId)
    local v76 = Combat_upv_1.IsMelee(v75)
    local v77 = nil
    if a1.killed then
        Hud_upv_1.Hitmarker("kill")
        Util_upv_1.Sound(((a1.headshot) and "Kill_Confirm_Headshot") or "Kill_Confirm")
        tbl_upv_4.killStreak = ((v74 - tbl_upv_4.lastKillAt <= 4) and (tbl_upv_4.killStreak + 1)) or 1
        tbl_upv_4.lastKillAt = v74
        v77 = nameOf(victim_1)
        local v78
        if v77 then
            v78 = string.upper(v77)
        else
            v78 = nil
        end
        if tbl_upv_4.killStreak >= 2 then
            local v79 = ((tbl_upv_4.killStreak ~= 2) and "TRIPLE ELIMINATION") or "DOUBLE ELIMINATION"
            local v80
            if (v78) and (a1.headshot) then
                v80 = ("%* \194\183 %*"):format(v78, Loc_upv_1.T("HEADSHOT"))
            elseif v78 then
                v80 = v78
            elseif a1.headshot then
                v80 = Loc_upv_1.T("HEADSHOT")
            else
                v80 = nil
            end
            Hud_upv_1.KillBanner(v79, v80)
        else
            local KillBanner_1 = Hud_upv_1.KillBanner
            local v81 = ((not v78) and "ELIMINATED") or (("ELIMINATED %*"):format(v78))
            local v82
            if a1.headshot then
                v82 = Loc_upv_1.T("HEADSHOT")
            else
                v82 = nil
            end
            KillBanner_1(v81, v82)
        end
        Util_upv_1.Shake(0.35, 0.18)
    else
        Hud_upv_1.Hitmarker((v69 and "crit") or "hit")
        if a1.headshot then
            Util_upv_1.Sound("Hitmarker_Headshot")
        elseif a1.crit then
            Util_upv_1.Sound(Presentation_upv_1.For(a1.weaponId, v75).critSound or "Hitmarker_Crit")
        elseif v74 - u13 > 0.06 then
            u13 = v74
            Util_upv_1.Sound((v76 and "Hitmarker") or "Hitmarker_Ranged")
        end
    end
    if not v67 or not v76 or v73 then
        return
    end
    Util_upv_1.Sound(Presentation_upv_1.For(a1.weaponId, v75).hitSound or "Hit_Melee", v67)
end
local function onDamageTaken(a1)
    --[[
      name: onDamageTaken
      line: 915
      upvalues:
        Hud_upv_1 (copy, index: 1)
        RankFx_upv_1 (copy, index: 2)
        Util_upv_1 (copy, index: 3)
        u12 (ref,  index: 4)
        tbl_upv_4 (copy, index: 5)
        emitView (copy, index: 6)
        Guard_upv_1 (copy, index: 7)
    ]]
    if type(a1) ~= "table" then
        return
    end
    local v83 = tonumber(a1.amount) or 0
    local fromPosition_1 = a1.fromPosition
    if a1.damageType ~= "Burn" then
        if a1.damageType ~= "World" and a1.weaponId ~= "ring" then
            if a1.damageType ~= "Sting" then
                if typeof(fromPosition_1) == "Vector3" then
                    Hud_upv_1.DamageFrom(fromPosition_1, v83 >= 40)
                end
                local v84 = tonumber(a1.armor) or 0
                if not (u12) then
                    local tbl_29 = {blocked = 0}
                    tbl_29.amount = v83
                    tbl_29.blocked = a1.blocked == true
                    emitView("Hurt", tbl_29)
                end
                if a1.interrupted then
                    local v85 = nil
                    if not (u12) then
                        v85 = tbl_upv_4.handler
                        if v85 and type(v85.Interrupt) == "function" then
                            pcall(function() end)
                        end
                    end
                    Hud_upv_1.Toast("INTERRUPTED", Color3.fromRGB(255, 150, 90), 0.9)
                end
                if a1.armorBroken then
                    Util_upv_1.Sound("Shield_Break")
                    Hud_upv_1.Toast("ARMOR BROKEN", Color3.fromRGB(200, 210, 225), 1.1)
                end
                if a1.guardBroken then
                    local v86 = nil
                    if not (u12) then
                        v86 = tbl_upv_4.handler
                        if v86 and type(v86.Interrupt) == "function" then
                            pcall(function() end)
                        end
                    end
                    Util_upv_1.Sound("Shield_Break")
                    Hud_upv_1.Toast("SHIELD BROKEN", Color3.fromRGB(110, 190, 255), 1.3)
                end
                if a1.blocked then
                    Hud_upv_1.Hurt(math.min(0.35, v83 / 60), Color3.fromRGB(110, 190, 255))
                    Hud_upv_1.BlockPulse()
                    if not (u12) then
                        Guard_upv_1.Impact(tbl_upv_4.char, true)
                    end
                elseif (v84 > 0) and (v83 - v84 < 0.5) then
                    Hud_upv_1.Hurt(math.min(0.3, v83 / 70), Color3.fromRGB(170, 185, 205))
                    Util_upv_1.Shake(math.clamp(v83 / 70, 0.15, 0.6), 0.2)
                    Util_upv_1.Sound("Impact_Metal")
                else
                    Hud_upv_1.Hurt(v83 / 35, nil)
                    Util_upv_1.Shake(math.clamp(v83 / 45, 0.2, 1.1), 0.28)
                    Util_upv_1.Recoil(math.clamp(v83 / 12, 0.5, 4), (math.random() - 0.5) * 3)
                    Util_upv_1.Sound(((v83 >= 30) and "Damage_Receive_Heavy") or "Damage_Receive")
                end
                if type(a1.stagger) == "number" and a1.stagger > 0 then
                    local v87 = nil
                    if not (u12) then
                        v87 = tbl_upv_4.handler
                        if v87 and type(v87.Interrupt) == "function" then
                            pcall(function() end)
                        end
                    end
                    Hud_upv_1.Toast("STAGGERED", Color3.fromRGB(255, 170, 90), a1.stagger + 0.2)
                end
                if a1.damageType == "Trap" then
                    local v88 = nil
                    if not (u12) then
                        v88 = tbl_upv_4.handler
                        if v88 and type(v88.Interrupt) == "function" then
                            pcall(function() end)
                        end
                    end
                    Hud_upv_1.Toast("TRAPPED!", Color3.fromRGB(255, 120, 90), 1.4)
                end
            else
                Hud_upv_1.Hurt(0.18, Color3.fromRGB(220, 160, 40))
                RankFx_upv_1.Stung()
                Util_upv_1.Sound("Damage_Receive", nil, {PlaybackSpeed = 1.18, Volume = 0.6})
                if a1.interrupted then
                    local v89 = nil
                    if not (u12) then
                        v89 = tbl_upv_4.handler
                        if v89 and type(v89.Interrupt) == "function" then
                            pcall(function() end)
                        end
                    end
                    Hud_upv_1.Toast("INTERRUPTED", Color3.fromRGB(255, 150, 90), 0.9)
                end
            end
            return
        end
        Hud_upv_1.Hurt(0.25, Color3.fromRGB(255, 110, 40))
    else
        Hud_upv_1.Hurt(0.2, Color3.fromRGB(255, 120, 40))
    end
end
local tbl_upv_30 = {}
local tbl_upv_31 = {}
task.spawn(
    function()
        --[[
          line: 992
          upvalues:
            tbl_upv_30 (copy, index: 1)
            tbl_upv_31 (copy, index: 2)
        ]]
        task.wait(10)
        for key_3 in tbl_upv_30 do
            if not (key_3.Parent) then
                tbl_upv_30[key_3] = nil
            end
        end
        for key_4 in tbl_upv_31 do
            if not (key_4.Parent) then
                tbl_upv_31[key_4] = nil
            end
        end
    end
)
local function onCombatFX(a1, a2)
    --[[
      name: onCombatFX
      line: 1008
      upvalues:
        tbl_upv_4 (copy, index: 1)
        Effects_upv_1 (copy, index: 2)
        Combat_upv_1 (copy, index: 3)
        Presentation_upv_1 (copy, index: 4)
        Util_upv_1 (copy, index: 5)
        Quality_upv_1 (copy, index: 6)
        Poses_upv_1 (copy, index: 7)
        tbl_upv_30 (copy, index: 8)
        Hud_upv_1 (copy, index: 9)
        RankFx_upv_1 (copy, index: 10)
        u12 (ref,  index: 11)
        emitView (copy, index: 12)
        Guard_upv_1 (copy, index: 13)
        tbl_upv_31 (copy, index: 14)
        tbl_upv_5 (copy, index: 15)
        u2 (ref,  index: 16)
        LocalPlayer_upv_1 (copy, index: 17)
        u3 (ref,  index: 18)
        u4 (ref,  index: 19)
        u6 (copy, index: 20)
        enforceWant (copy, index: 21)
        u1 (ref,  index: 22)
        u5 (ref,  index: 23)
        send (copy, index: 24)
    ]]
    if type(a1) ~= "string" or type(a2) ~= "table" then
        return
    end
    local char_5 = tbl_upv_4.char
    local v90 = nil
    if a1 ~= "Swing" then
        local v91 = nil
        if a1 == "Projectile" then
            v91 = a2.shooter
            local v92
            if typeof(v91) == "Instance" then
                if v91:IsA("Player") then
                    v92 = v91.Character
                elseif v91:IsA("Model") then
                    v92 = v91
                else
                    v92 = nil
                end
            else
                v92 = nil
            end
            if v92 and v92 == char_5 and a2.deflected ~= true then
                return
            end
            if typeof(a2.origin) == "Vector3" and typeof(a2.velocity) == "Vector3" and type(a2.key) == "string" then
                local v93 = tonumber(a2.gravity) or 0
                local num_1 = tonumber(a2.pellets)
                if (num_1) and (num_1 > 1) then
                    local velocity_1 = a2.velocity
                    Effects_upv_1.Pellets(a2.key, a2.kind, a2.origin, velocity_1.Unit, velocity_1.Magnitude, v93, num_1, tonumber(a2.spread) or 6, tonumber(a2.seed) or 0, v92)
                else
                    Effects_upv_1.Projectile(a2.key, a2.kind, a2.origin, a2.velocity, v93, v92)
                end
                local v94 = Combat_upv_1.Kind(a2.weaponId)
                local v95 = Presentation_upv_1.For(a2.weaponId, v94 or "Bow")
                local origin_1 = a2.origin
                local v96 = (origin_1 ~= nil) and (Effects_upv_1.NEAR < Effects_upv_1.CamDistance(origin_1))
                local v97 = not v96
                if v97 and (v95.flash or v95.puff) then
                    local Muzzle_1 = Effects_upv_1.Muzzle
                    local v98 = CFrame.lookAt(a2.origin, a2.origin + a2.velocity)
                    local v99
                    if v94 ~= "Pistol" then
                        v99 = true
                    else
                        v99 = false
                    end
                    Muzzle_1(v98, v99, v95.puff ~= false)
                end
                if v92 and v95.kick then
                    Poses_upv_1.Kick(v92, v95.kick * 5)
                end
                v94 = os.clock()
                local v100 = v92 or workspace
                if not (v94 - (tbl_upv_30[v100] or 0) > 0.08) then
                    return
                end
                tbl_upv_30[v100] = v94
                if not v97 and not v95.flash then
                    return
                end
                Util_upv_1.Sound(v95.fireSound or (v95.throwSound or "Bow_Release"), a2.origin)
            end
        elseif a1 == "ProjectileHit" then
            Effects_upv_1.ResolveProjectile(a2)
        elseif a1 ~= "Explosion" then
            if a1 ~= "Smoke" then
                local v101 = nil
                if a1 ~= "Horn" then
                    local v102 = nil
                    if a1 == "Chakram" then
                        v102 = a2.shooter
                        local v92
                        if typeof(v102) == "Instance" then
                            if v102:IsA("Player") then
                                v92 = v102.Character
                            elseif v102:IsA("Model") then
                                v92 = v102
                            else
                                v92 = nil
                            end
                        else
                            v92 = nil
                        end
                        if v92 ~= char_5 and typeof(a2.origin) == "Vector3" and typeof(a2.dir) == "Vector3" and type(a2.key) == "string" then
                            Effects_upv_1.Chakram(a2.key, a2.origin, a2.dir, tonumber(a2.speed) or 110, tonumber(a2.range) or 45, tonumber(a2.catch) or 4.5, v92)
                            local origin_2 = a2.origin
                            local v103 = (origin_2 ~= nil) and (Effects_upv_1.NEAR < Effects_upv_1.CamDistance(origin_2))
                            if v103 then
                                return
                            end
                            Util_upv_1.Sound("Knife_Throw", a2.origin)
                        end
                    elseif a1 ~= "ChakramTurn" then
                        if a1 ~= "ChakramEnd" then
                            if a1 ~= "FirePatch" then
                                if a1 ~= "Wall" then
                                    if a1 ~= "HealPool" then
                                        if a1 ~= "Caltrops" then
                                            local v104 = nil
                                            if a1 == "CaltropsEnd" then
                                                v104 = tonumber(a2.id)
                                                if not v104 then
                                                    return
                                                end
                                                Effects_upv_1.CaltropsEnd(v104)
                                            elseif a1 == "Swarm" then
                                                RankFx_upv_1.Swarm(a2)
                                            elseif a1 == "SwarmTarget" then
                                                RankFx_upv_1.SwarmTarget(a2)
                                            elseif a1 == "SwarmSync" then
                                                RankFx_upv_1.SwarmSync(a2)
                                            elseif a1 == "SwarmEnd" then
                                                RankFx_upv_1.SwarmEnd(a2)
                                            elseif a1 == "HatchetDrop" then
                                                RankFx_upv_1.HatchetDrop(a2)
                                            elseif a1 == "HatchetEnd" then
                                                RankFx_upv_1.HatchetEnd(a2)
                                            elseif a1 ~= "ParryStart" then
                                                local v105, v106 = nil, nil
                                                if a1 == "Parry" then
                                                    RankFx_upv_1.Parried(a2)
                                                    v105 = a2.target
                                                    local v107
                                                    if typeof(v105) == "Instance" then
                                                        if v105:IsA("Player") then
                                                            v107 = v105.Character
                                                        elseif v105:IsA("Model") then
                                                            v107 = v105
                                                        else
                                                            v107 = nil
                                                        end
                                                    else
                                                        v107 = nil
                                                    end
                                                    v106 = a2.attacker
                                                    if typeof(v106) == "Instance" then
                                                        if v106:IsA("Player") then
                                                            v90 = v106.Character
                                                        elseif v106:IsA("Model") then
                                                            v90 = v106
                                                        else
                                                            v90 = nil
                                                        end
                                                    else
                                                        v90 = nil
                                                    end
                                                    if v107 ~= nil and v107 == char_5 then
                                                        local handler_upv_5
                                                        if not (u12) then
                                                            Hud_upv_1.Flash(Color3.fromRGB(150, 196, 236), 0.5, 0.25)
                                                            Hud_upv_1.Toast(((a2.ranged) and "DEFLECTED") or "PARRIED", Color3.fromRGB(170, 214, 245), 0.9)
                                                            Util_upv_1.Shake(0.25, 0.12)
                                                            local tbl_32 = {ranged = 0}
                                                            tbl_32.ranged = a2.ranged == true
                                                            emitView("Parried", tbl_32)
                                                            handler_upv_5 = tbl_upv_4.handler
                                                            if handler_upv_5 and type(handler_upv_5.ParryUsed) == "function" then
                                                                pcall(
                                                                    function()
                                                                        --[[
                                                                          line: 1194
                                                                          upvalues:
                                                                            handler_upv_5 (copy, index: 1)
                                                                        ]]
                                                                        handler_upv_5:ParryUsed()
                                                                    end
                                                                )
                                                            end
                                                            return
                                                        end
                                                    end
                                                    if v90 == nil or v90 ~= char_5 or u12 then
                                                        return
                                                    end
                                                    if a2.staggered then
                                                        local v108 = nil
                                                        if not (u12) then
                                                            v108 = tbl_upv_4.handler
                                                            if v108 and type(v108.Interrupt) == "function" then
                                                                pcall(function() end)
                                                            end
                                                        end
                                                        Hud_upv_1.Toast("PARRIED \194\183 STAGGERED", Color3.fromRGB(255, 170, 90), (tonumber(a2.stagger) or 0.5) + 0.3)
                                                        Util_upv_1.Shake(0.4, 0.18)
                                                    else
                                                        Hud_upv_1.Toast("PARRIED", Color3.fromRGB(255, 170, 90), 0.9)
                                                    end
                                                elseif a1 ~= "TrapSnap" then
                                                    local v109, v110 = nil, nil
                                                    if a1 == "Hit" then
                                                        v109 = a2.target
                                                        local v92
                                                        if typeof(v109) == "Instance" then
                                                            if v109:IsA("Player") then
                                                                v92 = v109.Character
                                                            elseif v109:IsA("Model") then
                                                                v92 = v109
                                                            else
                                                                v92 = nil
                                                            end
                                                        else
                                                            v92 = nil
                                                        end
                                                        if typeof(a2.position) ~= "Vector3" then
                                                            v109 = nil
                                                        else
                                                            v109 = a2.position
                                                        end
                                                        v110 = a2.attacker
                                                        local v111
                                                        if typeof(v110) == "Instance" then
                                                            if v110:IsA("Player") then
                                                                v111 = v110.Character
                                                            elseif v110:IsA("Model") then
                                                                v111 = v110
                                                            else
                                                                v111 = nil
                                                            end
                                                        else
                                                            v111 = nil
                                                        end
                                                        if v111 == nil then
                                                            v110 = (v92 ~= nil) and (v92 == char_5)
                                                        else
                                                            v110 = true
                                                            if v111 ~= char_5 then
                                                                v110 = (v92 ~= nil) and (v92 == char_5)
                                                            end
                                                        end
                                                        local v112 = nil
                                                        if not (v110) then
                                                            v112 = (v109 ~= nil) and (Effects_upv_1.NEAR < Effects_upv_1.CamDistance(v109))
                                                            if v112 then
                                                                return
                                                            end
                                                        end
                                                        if a2.damageType ~= "Burn" and v92 ~= char_5 then
                                                            local HitFlash_1 = Effects_upv_1.HitFlash
                                                            local v113
                                                            if a2.blocked then
                                                                v113 = Color3.fromRGB(110, 190, 255)
                                                            else
                                                                v113 = nil
                                                            end
                                                            HitFlash_1(v92, v113)
                                                        end
                                                        if v109 and a2.damageType ~= "Burn" then
                                                            if typeof(a2.source) == "Vector3" and ((v109 - a2.source).Magnitude > 0.1) then
                                                                v110 = (v109 - a2.source).Unit
                                                            else
                                                                v110 = nil
                                                            end
                                                            local v114
                                                            if a2.blocked then
                                                                v114 = "blocked"
                                                            elseif a2.headshot or a2.crit then
                                                                v114 = "headshot"
                                                            else
                                                                v114 = "health"
                                                            end
                                                            local CharacterImpact_1 = Effects_upv_1.CharacterImpact
                                                            local v115 = true
                                                            if a2.headshot ~= true then
                                                                v115 = a2.killed == true
                                                            end
                                                            CharacterImpact_1(v109, v110, v115, v114)
                                                        end
                                                        if a2.blocked and v92 and v92 ~= char_5 then
                                                            Guard_upv_1.Impact(v92, false)
                                                            if a2.guardBroken and v109 then
                                                                Util_upv_1.Sound("Shield_Break", v109)
                                                            end
                                                        end
                                                        if v109 and a2.armor then
                                                            Effects_upv_1.ArmorHit(v109, a2.armorBroken == true)
                                                        end
                                                        if not v109 or v111 == char_5 or v92 == char_5 or a2.damageType ~= "Melee" then
                                                            return
                                                        end
                                                        Util_upv_1.Sound(Presentation_upv_1.For(a2.weaponId, Combat_upv_1.Kind(a2.weaponId) or "Sword").hitSound or "Hit_Melee", v109)
                                                    elseif a1 ~= "Death" then
                                                        if a1 ~= "Heal" then
                                                            if a1 ~= "Status" then
                                                                local v118 = nil
                                                                if a1 ~= "Charge" then
                                                                    local v119 = nil
                                                                    if a1 ~= "Reload" then
                                                                        local v120 = nil
                                                                        if a1 ~= "Block" then
                                                                            local v121 = nil
                                                                            if a1 ~= "Use" then
                                                                                local v122 = nil
                                                                                if a1 == "Equip" then
                                                                                    v122 = a2.attacker
                                                                                    local v92
                                                                                    if typeof(v122) == "Instance" then
                                                                                        if v122:IsA("Player") then
                                                                                            v92 = v122.Character
                                                                                        elseif v122:IsA("Model") then
                                                                                            v92 = v122
                                                                                        else
                                                                                            v92 = nil
                                                                                        end
                                                                                    else
                                                                                        v92 = nil
                                                                                    end
                                                                                    if not v92 or v92 == char_5 then
                                                                                        return
                                                                                    end
                                                                                    local v123 = Presentation_upv_1.For(a2.weaponId, Combat_upv_1.Kind(a2.weaponId) or "Sword")
                                                                                    local Sound_1 = Util_upv_1.Sound
                                                                                    local v124 = v123.equip or "Equip_Item"
                                                                                    local v125
                                                                                    if typeof(v92) == "Instance" then
                                                                                        if v92:IsA("Player") then
                                                                                            v125 = v92.Character
                                                                                        elseif v92:IsA("Model") then
                                                                                            v125 = v92
                                                                                        else
                                                                                            v125 = nil
                                                                                        end
                                                                                    else
                                                                                        v125 = nil
                                                                                    end
                                                                                    local v126 = v125 and (v125:FindFirstChild("HumanoidRootPart"))
                                                                                    local v127 = not (v126) or not (v126:IsA("BasePart")) or v126
                                                                                    Sound_1(v124, v127, {Volume = 0.7})
                                                                                elseif a1 == "Denied" then
                                                                                    local v128 = nil
                                                                                    if a2.reason ~= "NotEquipped" then
                                                                                        v128 = tbl_upv_4.handler
                                                                                        if v128 and type(v128.OnDenied) == "function" then
                                                                                            v128:OnDenied(a2.reason)
                                                                                        end
                                                                                        if a2.reason ~= "NoCharges" then
                                                                                            return
                                                                                        end
                                                                                        Hud_upv_1.Toast("NONE LEFT THIS ROUND", Color3.fromRGB(255, 120, 90))
                                                                                    else
                                                                                        tbl_upv_5.denied = tbl_upv_5.denied + 1
                                                                                        if u2 and u2.Parent == tbl_upv_4.char then
                                                                                            v122 = false
                                                                                            local v129 = LocalPlayer_upv_1:GetAttribute("EquipAck")
                                                                                            local v130
                                                                                            if type(v129) ~= "number" then
                                                                                                v130 = 0
                                                                                            else
                                                                                                v130 = v129
                                                                                            end
                                                                                            if v130 < u3 then
                                                                                                v122 = os.clock() - u4 < 4
                                                                                            end
                                                                                            if not (v122) then
                                                                                                u3 = u3 + 1
                                                                                                u6[u2] = u3
                                                                                                v122 = os.clock()
                                                                                                u4 = v122
                                                                                                tbl_upv_5.requests = tbl_upv_5.requests + 1
                                                                                                enforceWant()
                                                                                                local v131 = u2
                                                                                                if v131 and u1 then
                                                                                                    u5 = os.clock()
                                                                                                    send("Equip", {tool = v131, seq = u3})
                                                                                                end
                                                                                            end
                                                                                        end
                                                                                    end
                                                                                end
                                                                            else
                                                                                v121 = a2.attacker
                                                                                local v92
                                                                                if typeof(v121) == "Instance" then
                                                                                    if v121:IsA("Player") then
                                                                                        v92 = v121.Character
                                                                                    elseif v121:IsA("Model") then
                                                                                        v92 = v121
                                                                                    else
                                                                                        v92 = nil
                                                                                    end
                                                                                else
                                                                                    v92 = nil
                                                                                end
                                                                                if not v92 or v92 == char_5 then
                                                                                    return
                                                                                end
                                                                                local v132 = Combat_upv_1.Kind(a2.weaponId) or "Herbs"
                                                                                local v133 = Presentation_upv_1.For(a2.weaponId, v132)
                                                                                if v132 == "Trap" and not (Util_upv_1.IsTeammate(v92)) then
                                                                                    return
                                                                                end
                                                                                local Sound_2 = Util_upv_1.Sound
                                                                                local v134 = v133.useSound or "Bandage_Wrap"
                                                                                local v125
                                                                                if typeof(a2.position) ~= "Vector3" then
                                                                                    local v135
                                                                                    if typeof(v92) == "Instance" then
                                                                                        if v92:IsA("Player") then
                                                                                            v135 = v92.Character
                                                                                        elseif v92:IsA("Model") then
                                                                                            v135 = v92
                                                                                        else
                                                                                            v135 = nil
                                                                                        end
                                                                                    else
                                                                                        v135 = nil
                                                                                    end
                                                                                    local v136 = v135 and (v135:FindFirstChild("HumanoidRootPart"))
                                                                                    v125 = not (v136) or not (v136:IsA("BasePart")) or v136
                                                                                else
                                                                                    v125 = a2.position
                                                                                end
                                                                                Sound_2(v134, v125)
                                                                            end
                                                                        else
                                                                            v120 = a2.attacker
                                                                            local v92
                                                                            if typeof(v120) == "Instance" then
                                                                                if v120:IsA("Player") then
                                                                                    v92 = v120.Character
                                                                                elseif v120:IsA("Model") then
                                                                                    v92 = v120
                                                                                else
                                                                                    v92 = nil
                                                                                end
                                                                            else
                                                                                v92 = nil
                                                                            end
                                                                            if not v92 or v92 == char_5 or not a2.on then
                                                                                return
                                                                            end
                                                                            local v137 = os.clock()
                                                                            if not (v137 - (tbl_upv_31[v92] or -math.huge) >= 0.5) then
                                                                                return
                                                                            end
                                                                            tbl_upv_31[v92] = v137
                                                                            local Sound_3 = Util_upv_1.Sound
                                                                            local v138 = "Block_Up"
                                                                            local v125
                                                                            if typeof(v92) == "Instance" then
                                                                                if v92:IsA("Player") then
                                                                                    v125 = v92.Character
                                                                                elseif v92:IsA("Model") then
                                                                                    v125 = v92
                                                                                else
                                                                                    v125 = nil
                                                                                end
                                                                            else
                                                                                v125 = nil
                                                                            end
                                                                            local v139 = v125 and (v125:FindFirstChild("HumanoidRootPart"))
                                                                            local v96 = not (v139) or not (v139:IsA("BasePart")) or v139
                                                                            Sound_3(v138, v96)
                                                                        end
                                                                    else
                                                                        v119 = a2.attacker
                                                                        local u14
                                                                        if typeof(v119) == "Instance" then
                                                                            if v119:IsA("Player") then
                                                                                u14 = v119.Character
                                                                            elseif v119:IsA("Model") then
                                                                                u14 = v119
                                                                            else
                                                                                u14 = nil
                                                                            end
                                                                        else
                                                                            u14 = nil
                                                                        end
                                                                        if not u14 or u14 == char_5 then
                                                                            return
                                                                        end
                                                                        local u15 = Presentation_upv_1.For(a2.weaponId, Combat_upv_1.Kind(a2.weaponId) or "Crossbow")
                                                                        task.delay(
                                                                            0.5,
                                                                            function()
                                                                                --[[
                                                                                  line: 1293
                                                                                  upvalues:
                                                                                    Util_upv_1 (copy, index: 1)
                                                                                    u15 (copy, index: 2)
                                                                                    u14 (copy, index: 3)
                                                                                ]]
                                                                                local Sound_4 = Util_upv_1.Sound
                                                                                local v140 = u15.reloadSound or "Crossbow_Reload"
                                                                                local v141
                                                                                if typeof(u14) == "Instance" then
                                                                                    if u14:IsA("Player") then
                                                                                        v141 = u14.Character
                                                                                    elseif u14:IsA("Model") then
                                                                                        v141 = u14
                                                                                    else
                                                                                        v141 = nil
                                                                                    end
                                                                                else
                                                                                    v141 = nil
                                                                                end
                                                                                local v142 = v141 and (v141:FindFirstChild("HumanoidRootPart"))
                                                                                local v143 = not (v142) or not (v142:IsA("BasePart")) or v142
                                                                                Sound_4(v140, v143)
                                                                            end
                                                                        )
                                                                    end
                                                                else
                                                                    v118 = a2.attacker
                                                                    local v92
                                                                    if typeof(v118) == "Instance" then
                                                                        if v118:IsA("Player") then
                                                                            v92 = v118.Character
                                                                        elseif v118:IsA("Model") then
                                                                            v92 = v118
                                                                        else
                                                                            v92 = nil
                                                                        end
                                                                    else
                                                                        v92 = nil
                                                                    end
                                                                    if not v92 or v92 == char_5 or not a2.on then
                                                                        return
                                                                    end
                                                                    local v144
                                                                    if typeof(v92) == "Instance" then
                                                                        if v92:IsA("Player") then
                                                                            v144 = v92.Character
                                                                        elseif v92:IsA("Model") then
                                                                            v144 = v92
                                                                        else
                                                                            v144 = nil
                                                                        end
                                                                    else
                                                                        v144 = nil
                                                                    end
                                                                    local v145 = v144 and (v144:FindFirstChild("HumanoidRootPart"))
                                                                    v90 = not (v145) or not (v145:IsA("BasePart")) or v145
                                                                    local v146 = Presentation_upv_1.For(a2.weaponId, Combat_upv_1.Kind(a2.weaponId))
                                                                    if a2.kind ~= "Draw" then
                                                                        if a2.kind ~= "Heavy" and a2.kind ~= "Lunge" then
                                                                            if a2.kind == "Throw" then
                                                                                Util_upv_1.Sound(v146.windupSound or "Throw_Windup", v90)
                                                                            end
                                                                            return
                                                                        end
                                                                        Util_upv_1.Sound(v146.chargeSound or "Charge_Up", v90)
                                                                    else
                                                                        Util_upv_1.Sound(v146.drawSound or "Bow_Draw", v90)
                                                                    end
                                                                end
                                                            else
                                                                local v117 = a2.target
                                                                local v92
                                                                if typeof(v117) == "Instance" then
                                                                    if v117:IsA("Player") then
                                                                        v92 = v117.Character
                                                                    elseif v117:IsA("Model") then
                                                                        v92 = v117
                                                                    else
                                                                        v92 = nil
                                                                    end
                                                                else
                                                                    v92 = nil
                                                                end
                                                                local v147
                                                                if typeof(v92) == "Instance" then
                                                                    if v92:IsA("Player") then
                                                                        v147 = v92.Character
                                                                    elseif v92:IsA("Model") then
                                                                        v147 = v92
                                                                    else
                                                                        v147 = nil
                                                                    end
                                                                else
                                                                    v147 = nil
                                                                end
                                                                local v148 = v147 and (v147:FindFirstChild("HumanoidRootPart"))
                                                                v117 = not (v148) or not (v148:IsA("BasePart")) or v148
                                                                if v92 == char_5 then
                                                                    if a2.status ~= "Caltrops" then
                                                                        Effects_upv_1.Status(v92, a2.status, tonumber(a2.duration) or 1)
                                                                        if (v92 ~= char_5 or a2.status ~= "Burn") and v92 == char_5 then
                                                                            if a2.status ~= "Snare" then
                                                                                return
                                                                            end
                                                                            Hud_upv_1.Toast("SNARED", Color3.fromRGB(226, 196, 140), 1.2)
                                                                        end
                                                                        Hud_upv_1.Toast("BURNING", Color3.fromRGB(255, 140, 60), 1)
                                                                    else
                                                                        if v92 and v92:IsA("Model") then
                                                                            Effects_upv_1.CaltropStep(v92)
                                                                        end
                                                                        if v92 == char_5 then
                                                                            Hud_upv_1.Toast("CALTROPS", Color3.fromRGB(214, 180, 140), 0.9)
                                                                        end
                                                                    end
                                                                end
                                                                if v117 then
                                                                    local Position_1 = v117.Position
                                                                    v147 = (Position_1 ~= nil) and (Effects_upv_1.NEAR < Effects_upv_1.CamDistance(Position_1))
                                                                    if not v147 then
                                                                        if a2.status ~= "Caltrops" then
                                                                            Effects_upv_1.Status(v92, a2.status, tonumber(a2.duration) or 1)
                                                                            if (v92 ~= char_5 or a2.status ~= "Burn") and v92 == char_5 then
                                                                                if a2.status ~= "Snare" then
                                                                                    return
                                                                                end
                                                                                Hud_upv_1.Toast("SNARED", Color3.fromRGB(226, 196, 140), 1.2)
                                                                            end
                                                                            Hud_upv_1.Toast("BURNING", Color3.fromRGB(255, 140, 60), 1)
                                                                        else
                                                                            if v92 and v92:IsA("Model") then
                                                                                Effects_upv_1.CaltropStep(v92)
                                                                            end
                                                                            if v92 ~= char_5 then
                                                                                return
                                                                            end
                                                                            Hud_upv_1.Toast("CALTROPS", Color3.fromRGB(214, 180, 140), 0.9)
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        else
                                                            local v116 = a2.target
                                                            local v92
                                                            if typeof(v116) == "Instance" then
                                                                if v116:IsA("Player") then
                                                                    v92 = v116.Character
                                                                elseif v116:IsA("Model") then
                                                                    v92 = v116
                                                                else
                                                                    v92 = nil
                                                                end
                                                            else
                                                                v92 = nil
                                                            end
                                                            local v149
                                                            if typeof(v92) == "Instance" then
                                                                if v92:IsA("Player") then
                                                                    v149 = v92.Character
                                                                elseif v92:IsA("Model") then
                                                                    v149 = v92
                                                                else
                                                                    v149 = nil
                                                                end
                                                            else
                                                                v149 = nil
                                                            end
                                                            local v150 = v149 and (v149:FindFirstChild("HumanoidRootPart"))
                                                            v116 = not (v150) or not (v150:IsA("BasePart")) or v150
                                                            if v92 ~= char_5 and v116 then
                                                                local Position_2 = v116.Position
                                                                v149 = (Position_2 ~= nil) and (Effects_upv_1.NEAR < Effects_upv_1.CamDistance(Position_2))
                                                                if (v149) then
                                                                    return
                                                                end
                                                                Effects_upv_1.Heal(v92, tonumber(a2.duration) or 3)
                                                            end
                                                            Effects_upv_1.Heal(v92, tonumber(a2.duration) or 3)
                                                        end
                                                    elseif typeof(a2.position) == "Vector3" then
                                                        local Death_1 = Effects_upv_1.Death
                                                        local position_1 = a2.position
                                                        v106 = false
                                                        local killer_1 = a2.killer
                                                        local v151
                                                        if typeof(killer_1) == "Instance" then
                                                            if killer_1:IsA("Player") then
                                                                v151 = killer_1.Character
                                                            elseif killer_1:IsA("Model") then
                                                                v151 = killer_1
                                                            else
                                                                v151 = nil
                                                            end
                                                        else
                                                            v151 = nil
                                                        end
                                                        if v151 == char_5 then
                                                            v106 = char_5 ~= nil
                                                        end
                                                        if type(a2.weaponId) ~= "string" then
                                                            v151 = nil
                                                        else
                                                            v151 = a2.weaponId
                                                        end
                                                        Death_1(position_1, v106, v151, a2.headshot == true)
                                                    end
                                                elseif typeof(a2.position) == "Vector3" then
                                                    Effects_upv_1.TrapSnap(a2.position)
                                                end
                                            else
                                                RankFx_upv_1.ParryStart(a2)
                                            end
                                        else
                                            Effects_upv_1.Caltrops(a2)
                                        end
                                    elseif typeof(a2.position) == "Vector3" then
                                        Effects_upv_1.HealPool(a2.position, tonumber(a2.radius) or 10, tonumber(a2.duration) or 3)
                                    end
                                elseif typeof(a2.position) == "Vector3" then
                                    Effects_upv_1.Wall(a2.position, tostring(a2.op), tonumber(a2.width) or 6, tonumber(a2.height) or 5)
                                end
                            elseif typeof(a2.position) == "Vector3" then
                                Effects_upv_1.FirePatch(a2.position, tonumber(a2.radius) or 3.5, tonumber(a2.duration) or 1.5)
                            end
                        elseif type(a2.key) == "string" then
                            local ChakramEnd_1 = Effects_upv_1.ChakramEnd
                            local key_5 = a2.key
                            local v151
                            if typeof(a2.position) ~= "Vector3" then
                                v151 = nil
                            else
                                v151 = a2.position
                            end
                            ChakramEnd_1(key_5, a2.caught == true, v151)
                        end
                    elseif type(a2.key) == "string" and typeof(a2.position) == "Vector3" then
                        Effects_upv_1.ChakramTurn(a2.key, a2.position)
                    end
                else
                    v101 = a2.attacker
                    local v92
                    if typeof(v101) == "Instance" then
                        if v101:IsA("Player") then
                            v92 = v101.Character
                        elseif v101:IsA("Model") then
                            v92 = v101
                        else
                            v92 = nil
                        end
                    else
                        v92 = nil
                    end
                    if typeof(a2.position) ~= "Vector3" then
                        v90 = nil
                    else
                        v90 = a2.position
                    end
                    if not v90 then
                        return
                    end
                    Util_upv_1.Sound("War_Horn", v90)
                    Effects_upv_1.HornBlast(v90)
                    if v92 == nil then
                        if v92 == nil or char_5 == nil or not Util_upv_1.IsEnemy(v92) then
                            return
                        end
                        Hud_upv_1.DamageFrom(v90, true, Color3.fromRGB(240, 180, 70), tonumber(a2.reveal) or 3)
                        Hud_upv_1.Toast("ENEMY HORN", Color3.fromRGB(240, 180, 70), 1.6)
                    else
                        if v92 ~= char_5 and not (Util_upv_1.IsTeammate(v92)) then
                            if v92 ~= nil and char_5 ~= nil and Util_upv_1.IsEnemy(v92) then
                                Hud_upv_1.DamageFrom(v90, true, Color3.fromRGB(240, 180, 70), tonumber(a2.reveal) or 3)
                                Hud_upv_1.Toast("ENEMY HORN", Color3.fromRGB(240, 180, 70), 1.6)
                            end
                            return
                        end
                        if type(a2.enemies) == "table" then
                            local v152 = nil
                            for _, value_11 in a2.enemies do
                                if typeof(value_11) == "Instance" then
                                    if value_11:IsA("Player") then
                                        v152 = value_11.Character
                                    elseif value_11:IsA("Model") then
                                        v152 = value_11
                                    else
                                        v152 = nil
                                    end
                                else
                                    v152 = nil
                                end
                                if v152 then
                                    Effects_upv_1.Reveal(v152, tonumber(a2.reveal) or 3)
                                end
                            end
                        end
                        if not Util_upv_1.InMatch() then
                            return
                        end
                        Hud_upv_1.Toast("TRIBE RALLIED", Color3.fromRGB(226, 190, 110), 1.6)
                    end
                end
            elseif typeof(a2.position) == "Vector3" then
                local v153 = tonumber(a2.duration) or 7
                Effects_upv_1.SmokeCloud(a2.position, tonumber(a2.radius) or 13, v153)
                if a2.hiss ~= true then
                    return
                end
                local u16 = Instance.new("Part")
                u16.Name = "SmokeHiss"
                u16.Anchored = true
                u16.CanCollide = false
                u16.CanQuery = false
                u16.CanTouch = false
                u16.Transparency = 1
                u16.Size = Vector3.new(1, 1, 1)
                u16.CFrame = CFrame.new(a2.position)
                u16.Parent = workspace
                local u17 = Util_upv_1.Loop("Smoke_Hiss_Loop", u16)
                task.delay(
                    v153,
                    function()
                        --[[
                          line: 1093
                          upvalues:
                            u17 (copy, index: 1)
                            u16 (copy, index: 2)
                        ]]
                        pcall(u17, 1)
                        task.delay(
                            1.2,
                            function()
                                --[[
                                  line: 1095
                                  upvalues:
                                    u16 (copy, index: 1)
                                ]]
                                u16:Destroy()
                            end
                        )
                    end
                )
            end
        elseif typeof(a2.position) == "Vector3" then
            Effects_upv_1.Explosion(a2.position, tonumber(a2.radius) or 10, tonumber(a2.zoneRadius), (tonumber(a2.zoneTime)))
        end
    else
        v90 = a2.attacker
        local v92
        if typeof(v90) == "Instance" then
            if v90:IsA("Player") then
                v92 = v90.Character
            elseif v90:IsA("Model") then
                v92 = v90
            else
                v92 = nil
            end
        else
            v92 = nil
        end
        if v92 and v92 ~= char_5 then
            local v154
            if typeof(v92) == "Instance" then
                if v92:IsA("Player") then
                    v154 = v92.Character
                elseif v92:IsA("Model") then
                    v154 = v92
                else
                    v154 = nil
                end
            else
                v154 = nil
            end
            local v155 = v154 and (v154:FindFirstChild("HumanoidRootPart"))
            v90 = not (v155) or not (v155:IsA("BasePart")) or v155
            if v90 then
                local Position_3 = v90.Position
                v154 = (Position_3 ~= nil) and (Effects_upv_1.NEAR < Effects_upv_1.CamDistance(Position_3))
                if not (v154) then
                    local v156 = Presentation_upv_1.For(a2.weaponId, Combat_upv_1.Kind(a2.weaponId) or "Fists")
                    if a2.heavy == true then
                        v154 = v156.heavySound or (v156.swingSound)
                    elseif a2.lunge ~= true then
                        v154 = v156.swingSound
                    else
                        v154 = v156.lungeSound or (v156.swingSound)
                    end
                    Util_upv_1.Sound(v154 or "Swing_Sword", v90)
                    if v156.trail and v156.trail > 0 and Quality_upv_1.layers then
                        local Trail_1 = Effects_upv_1.Trail
                        local v157 = (v92 and (v92:FindFirstChildOfClass("Tool"))) or nil
                        Trail_1(v157, v156.trail)
                    end
                    if v156.noSlash then
                        return
                    end
                    local Slash_1 = Effects_upv_1.Slash
                    local v158 = tonumber(a2.step) or 1
                    Slash_1(v92, v158, a2.heavy == true, v156.slashColor)
                    if a2.heavy == true then
                        Effects_upv_1.GroundScuff((v90.Position + (v90.CFrame.LookVector * 4)) - Vector3.new(0, 2.799999952316284, 0))
                    end
                end
            end
        end
    end
end
local function onInputBegan(a1, a2)
    --[[
      name: onInputBegan
      line: 780
      upvalues:
        mapInput (copy, index: 1)
        tbl_upv_4 (copy, index: 2)
        Util_upv_1 (copy, index: 3)
        Keybinds_upv_1 (copy, index: 4)
        handlerInput (copy, index: 5)
    ]]
    if a2 then
        return
    end
    local v159 = mapInput(a1)
    if not v159 then
        return
    end
    if tbl_upv_4.handler and tbl_upv_4.hum ~= nil and (tbl_upv_4.hum.Health > 0) and tbl_upv_4.char ~= nil and tbl_upv_4.char.Parent ~= nil and not Util_upv_1.IsMouseUnlocked() and (not Keybinds_upv_1.PadBlocked() or not (#Keybinds_upv_1.PadActionsOf(a1) > 0)) then
        tbl_upv_4.pressed[v159] = true
        handlerInput(v159, true)
    end
end
local function drawTool(a1, a2)
    --[[
      name: drawTool
      line: 671
      upvalues:
        tbl_upv_4 (copy, index: 1)
        backpack (copy, index: 2)
    ]]
    local v160 = nil
    local tbl_33 = {tbl_upv_4.char, backpack()}
    for _, value_12 in tbl_33 do
        if not (value_12) then
            continue
        end
        for v164, value_13 in value_12:GetChildren() do
            local v161 = (value_13 ~= nil) and (value_13:IsA("Tool") and (type(value_13:GetAttribute("WeaponId")) == "string"))
            if not (v161) or value_13:GetAttribute("DrawToken") ~= a2 then
                continue
            end
            if (type(a1) ~= "string" or value_13:GetAttribute("Slot") ~= a1) and (type(a1) ~= "number" or value_13:GetAttribute("SlotIndex") ~= a1) then
                local v162 = value_13:GetAttribute("SlotIndex")
                local v163 = v160 and (v160:GetAttribute("SlotIndex"))
                if not (v160) then
                    v160 = value_13
                    continue
                end
                if type(v162) ~= "number" or type(v163) ~= "number" then
                    continue
                end
                if v162 < v163 then
                    v160 = value_13
                    continue
                end
            end
            return value_13
        end
    end
    return v160
end
function tbl_upv_3.Start()
    --[[
      name: Start
      line: 1343
      upvalues:
        Net_upv_1 (copy, index: 1)
        u1 (ref,  index: 2)
        tbl_upv_4 (copy, index: 3)
        Hud_upv_1 (copy, index: 4)
        Guard_upv_1 (copy, index: 5)
        Poses_upv_1 (copy, index: 6)
        World_upv_1 (copy, index: 7)
        Quality_upv_1 (copy, index: 8)
        Touch_upv_1 (copy, index: 9)
        dispatch (copy, index: 10)
        onHitConfirm (copy, index: 11)
        onDamageTaken (copy, index: 12)
        onCombatFX (copy, index: 13)
        Metrics_upv_1 (copy, index: 14)
        Util_upv_1 (copy, index: 15)
        Players_upv_1 (copy, index: 16)
        LocalPlayer_upv_1 (copy, index: 17)
        Combat_upv_1 (copy, index: 18)
        Presentation_upv_1 (copy, index: 19)
        Keybinds_upv_1 (copy, index: 20)
        onInputBegan (copy, index: 21)
        onInputEnded (copy, index: 22)
        RunService_upv_1 (copy, index: 23)
        u3 (ref,  index: 24)
        u4 (ref,  index: 25)
        u10 (ref,  index: 26)
        reconcileEquip (copy, index: 27)
        refreshEquipped (copy, index: 28)
        u5 (ref,  index: 29)
        u2 (ref,  index: 30)
        tbl_upv_5 (copy, index: 31)
        send (copy, index: 32)
        queueReconcile (copy, index: 33)
        copyDecoy (copy, index: 34)
        u12 (ref,  index: 35)
        onCharacter (copy, index: 36)
        autoDraw (copy, index: 37)
        u11 (ref,  index: 38)
        u6 (copy, index: 39)
        enforceWant (copy, index: 40)
        drawTool (copy, index: 41)
        tbl_upv_3 (copy, index: 42)
        u8 (ref,  index: 43)
        tbl_upv_1 (copy, index: 44)
        setSpeed (copy, index: 45)
    ]]
    local u18 = false
    local u19 = nil
    Net_upv_1.UnreliableEvent("CombatFXU").OnClientEvent:Connect(
        function(a1, a2)
            --[[
              line: 1349
              upvalues:
                u18 (ref, index: 1)
                u19 (ref, index: 2)
            ]]
            if not u18 or not u19 then
                return
            end
            u19(a1, a2)
        end
    )
    u1 = Net_upv_1.Event("WeaponAction")
    local v164 = Net_upv_1.Event("HitConfirm")
    local v165 = Net_upv_1.Event("DamageTaken")
    local v166 = Net_upv_1.Event("CombatFX")
    tbl_upv_4.shotId = math.floor((workspace:GetServerTimeNow() % 1e+05) * 10)
    Hud_upv_1.Init()
    Guard_upv_1.Init()
    Poses_upv_1.Init()
    World_upv_1.Init()
    Quality_upv_1.Start()
    Touch_upv_1.Start(dispatch)
    v164.OnClientEvent:Connect(
        function(a3)
            --[[
              line: 1368
              upvalues:
                onHitConfirm (copy, index: 1)
            ]]
            local success_4, v167 = pcall(onHitConfirm, a3)
            if (success_4) then
                return
            end
            warn("[Combat] HitConfirm error:", v167)
        end
    )
    v165.OnClientEvent:Connect(
        function(a4)
            --[[
              line: 1374
              upvalues:
                onDamageTaken (copy, index: 1)
            ]]
            local success_5, v168 = pcall(onDamageTaken, a4)
            if (success_5) then
                return
            end
            warn("[Combat] DamageTaken error:", v168)
        end
    )
    local function fx(a5, a6)
        --[[
          name: fx
          line: 1380
          upvalues:
            onCombatFX (copy, index: 1)
            Metrics_upv_1 (copy, index: 2)
        ]]
        local v169 = os.clock()
        local success_6, v170 = pcall(onCombatFX, a5, a6)
        local AddFx_1 = Metrics_upv_1.AddFx
        local v171 = os.clock() - v169
        local v172
        if type(a5) ~= "string" then
            v172 = nil
        else
            v172 = a5
        end
        AddFx_1(v171, v172)
        if (success_6) then
            return
        end
        warn("[Combat] CombatFX error:", a5, v170)
    end
    v166.OnClientEvent:Connect(fx)
    u19 = fx
    u18 = true
    local v173 = Net_upv_1.Event("AnimRelay")
    Util_upv_1.SetAnimRelay(v173)
    v173.OnClientEvent:Connect(
        function(a7, a8, a9, a10, a11, a12)
            --[[
              line: 1396
              upvalues:
                tbl_upv_4 (copy, index: 1)
                Util_upv_1 (copy, index: 2)
            ]]
            if typeof(a7) ~= "Instance" or not a7:IsA("Model") or a7 == tbl_upv_4.char then
                return
            end
            if type(a9) == "string" then
                local v174 = a7:FindFirstChildOfClass("Humanoid")
                local v175 = v174 and (v174:FindFirstChildOfClass("Animator"))
                if v175 and a7:IsDescendantOf(workspace) then
                    local v176
                    if type(a10) ~= "number" then
                        v176 = 1
                    else
                        v176 = a10
                    end
                    if a8 == "Play" then
                        Util_upv_1.PlayAnim(v174, a9, v176, tonumber(a11), (tonumber(a12)))
                    elseif a8 == "Hold" then
                        Util_upv_1.PlayHold(v174, a9, v176)
                    elseif a8 == "Stop" then
                        Util_upv_1.StopAnim(v174, a9, (tonumber(a11)))
                    end
                    return
                end
            end
        end
    )
    local tbl_upv_34 = {}
    task.spawn(
        function()
            --[[
              line: 1417
              upvalues:
                Players_upv_1 (copy, index: 1)
                LocalPlayer_upv_1 (copy, index: 2)
                Combat_upv_1 (copy, index: 3)
                Presentation_upv_1 (copy, index: 4)
                tbl_upv_34 (copy, index: 5)
                Util_upv_1 (copy, index: 6)
            ]]
            task.wait(0.5)
            local CurrentCamera_1 = workspace.CurrentCamera
            local v177 = ((not CurrentCamera_1) and Vector3.new(0, 0, 0)) or (CurrentCamera_1.CFrame.Position)
            local v178 = nil
            for _, value_14 in Players_upv_1:GetPlayers() do
                local Character_1 = value_14.Character
                if value_14 == LocalPlayer_upv_1 or not (Character_1) then
                    continue
                end
                v178 = Character_1:FindFirstChild("HumanoidRootPart")
                local v179 = Character_1:FindFirstChildOfClass("Humanoid")
                local v180 = v179 and (v179:FindFirstChildOfClass("Animator"))
                if not (v178) then
                    continue
                end
                local v181 = v178:IsA("BasePart")
                if not (v181) or not (v180) or (v178.Position - v177).Magnitude > 160 then
                    continue
                end
                v178 = (Character_1 and (Character_1:FindFirstChildOfClass("Tool"))) or nil
                v181 = v178 and (v178:GetAttribute("WeaponId"))
                if type(v181) ~= "string" or not (v179.Health > 0) then
                    v178 = nil
                    v181 = tbl_upv_34[Character_1]
                    if v181 then
                        if v181 ~= v178 then
                            Util_upv_1.StopAnim(v179, v181, 0.15)
                            tbl_upv_34[Character_1] = nil
                        end
                        if not (v178) then
                            continue
                        end
                        v181 = Util_upv_1.GetTrack(v179, v178)
                        if not (v181) then
                            tbl_upv_34[Character_1] = v178
                            continue
                        end
                        if not (v181.IsPlaying) then
                            Util_upv_1.PlayAnim(v179, v178, 1, 0.2)
                        end
                    else
                        if not (v178) then
                            continue
                        end
                        v181 = Util_upv_1.GetTrack(v179, v178)
                        if not (v182) then
                            tbl_upv_34[Character_1] = v178
                            continue
                        end
                        if not (v182.IsPlaying) then
                            Util_upv_1.PlayAnim(v179, v178, 1, 0.2)
                        end
                    end
                    tbl_upv_34[Character_1] = v178
                end
                v178 = Presentation_upv_1.For(v181, Combat_upv_1.Kind(v181)).hold
                v181 = tbl_upv_34[Character_1]
                if v181 and v181 ~= v178 then
                    Util_upv_1.StopAnim(v179, v181, 0.15)
                    tbl_upv_34[Character_1] = nil
                end
                if not (v178) then
                    continue
                end
                v181 = Util_upv_1.GetTrack(v179, v178)
                if not (v181) then
                    tbl_upv_34[Character_1] = v178
                    continue
                end
                if not (v181.IsPlaying) then
                    Util_upv_1.PlayAnim(v179, v178, 1, 0.2)
                end
                tbl_upv_34[Character_1] = v178
            end
            for key_6 in tbl_upv_34 do
                if not (key_6.Parent) then
                    tbl_upv_34[key_6] = nil
                end
            end
        end
    )
    Keybinds_upv_1.OnInput("Began", onInputBegan)
    Keybinds_upv_1.OnInput("Ended", onInputEnded)
    local u20 = 0
    RunService_upv_1.Heartbeat:Connect(
        function()
            --[[
              line: 1462
              upvalues:
                u3 (ref,  index: 1)
                LocalPlayer_upv_1 (copy, index: 2)
                u20 (ref,  index: 3)
                u4 (ref,  index: 4)
                u10 (ref,  index: 5)
                reconcileEquip (copy, index: 6)
                refreshEquipped (copy, index: 7)
                u5 (ref,  index: 8)
                u2 (ref,  index: 9)
                tbl_upv_4 (copy, index: 10)
                tbl_upv_5 (copy, index: 11)
                u1 (ref,  index: 12)
                send (copy, index: 13)
            ]]
            if u3 ~= 0 then
                local v183 = LocalPlayer_upv_1:GetAttribute("EquipAck")
                local v184
                if type(v183) ~= "number" then
                    v184 = 0
                else
                    v184 = v183
                end
                if (u3 <= v184) then
                    return
                end
                if u20 ~= u3 then
                    local v185 = os.clock()
                    if v185 - u4 >= 4 then
                        u20 = u3
                        if u10 then
                            return
                        end
                        u10 = true
                        task.defer(
                            function()
                                --[[
                                  line: 563
                                  upvalues:
                                    u10 (ref,  index: 1)
                                    reconcileEquip (copy, index: 2)
                                    refreshEquipped (copy, index: 3)
                                ]]
                                u10 = false
                                reconcileEquip()
                                refreshEquipped()
                            end
                        )
                    elseif v185 - u5 >= 1 and u2 and (tbl_upv_4.hum ~= nil) and ((tbl_upv_4.hum.Health > 0) and ((tbl_upv_4.char ~= nil) and (tbl_upv_4.char.Parent ~= nil))) then
                        tbl_upv_5.resent = tbl_upv_5.resent + 1
                        local v186 = u2
                        if v186 and u1 then
                            u5 = os.clock()
                            send("Equip", {tool = v186, seq = u3})
                        end
                    end
                end
            end
        end
    )
    for _, value_15 in {"EquipAck", "EquipSlot"} do
        LocalPlayer_upv_1:GetAttributeChangedSignal(value_15):Connect(queueReconcile)
    end
    local u21 = false
    RunService_upv_1.RenderStepped:Connect(
        function(a13)
            --[[
              line: 1480
              upvalues:
                copyDecoy (copy, index: 1)
                u12 (ref,  index: 2)
                tbl_upv_4 (copy, index: 3)
                Util_upv_1 (copy, index: 4)
                u21 (ref,  index: 5)
                Hud_upv_1 (copy, index: 6)
                LocalPlayer_upv_1 (copy, index: 7)
                Touch_upv_1 (copy, index: 8)
            ]]
            copyDecoy()
            if u12 then
                return
            end
            local handler_upv_6 = tbl_upv_4.handler
            if handler_upv_6 and (tbl_upv_4.hum ~= nil) and ((tbl_upv_4.hum.Health > 0) and ((tbl_upv_4.char ~= nil) and (tbl_upv_4.char.Parent ~= nil))) then
                local v187, v188 = pcall(
                    function()
                        --[[
                          line: 1489
                          upvalues:
                            handler_upv_6 (copy, index: 1)
                            a13 (copy, index: 2)
                        ]]
                        handler_upv_6:Update(a13)
                    end
                )
                if not (v187) then
                    warn("[Combat] update error:", v188)
                end
            end
            local v189 = not Util_upv_1.CanAct()
            local v187 = nil
            if v189 ~= u21 then
                u21 = v189
                Hud_upv_1.SetFrozen(v189)
                if v189 then
                    if not (u12) then
                        v187 = tbl_upv_4.handler
                        if v187 and type(v187.Interrupt) == "function" then
                            pcall(
                                function()
                                    --[[
                                      line: 834
                                      upvalues:
                                        v187 (copy, index: 1)
                                    ]]
                                    v187:Interrupt()
                                end
                            )
                        end
                    end
                end
            end
            local v190 = LocalPlayer_upv_1:GetAttribute("CombatMode")
            if v190 ~= nil then
                v187 = v190 == true
            else
                local v191 = LocalPlayer_upv_1:GetAttribute("State") == "Match"
                v187 = v191
            end
            v190 = not Util_upv_1.IsMouseUnlocked() and (LocalPlayer_upv_1:GetAttribute("MenuOpen") ~= true)
            local SetVisible_1 = Hud_upv_1.SetVisible
            local v192 = v190
            if v192 then
                v192 = (tbl_upv_4.hum ~= nil) and ((tbl_upv_4.hum.Health > 0) and ((tbl_upv_4.char ~= nil) and (tbl_upv_4.char.Parent ~= nil)))
                if v192 then
                    v192 = v187
                end
            end
            SetVisible_1(v192)
            Touch_upv_1.SetVisible(v190 and v187)
        end
    )
    LocalPlayer_upv_1.CharacterAdded:Connect(onCharacter)
    if LocalPlayer_upv_1.Character then
        task.spawn(onCharacter, LocalPlayer_upv_1.Character)
    end
    LocalPlayer_upv_1:GetAttributeChangedSignal("CombatDrawToken"):Connect(autoDraw)
    local u22 = LocalPlayer_upv_1:GetAttribute("CombatDrawToken")
    if type(u22) == "number" and u22 ~= u11 then
        u11 = u22
        task.spawn(
            function()
                --[[
                  line: 702
                  upvalues:
                    LocalPlayer_upv_1 (copy, index: 1)
                    u22 (copy, index: 2)
                    tbl_upv_4 (copy, index: 3)
                    u3 (ref,  index: 4)
                    u4 (ref,  index: 5)
                    u2 (ref,  index: 6)
                    u6 (copy, index: 7)
                    tbl_upv_5 (copy, index: 8)
                    enforceWant (copy, index: 9)
                    u1 (ref,  index: 10)
                    u5 (ref,  index: 11)
                    send (copy, index: 12)
                    drawTool (copy, index: 13)
                    tbl_upv_3 (copy, index: 14)
                ]]
                local v193 = os.clock()
                local v194 = -math.huge
                local v195, v196, v196 = nil, nil, nil
                while os.clock() - v193 < 10 do
                    if LocalPlayer_upv_1:GetAttribute("CombatDrawToken") ~= u22 then
                        return
                    end
                    local v197 = LocalPlayer_upv_1:GetAttribute("CombatDrawSlot")
                    if v197 == 0 then
                        return
                    end
                    local char_6 = tbl_upv_4.char
                    local hum_4 = tbl_upv_4.hum
                    if not (char_6) or not (hum_4) or not (hum_4.Health > 0) or char_6 ~= LocalPlayer_upv_1.Character then
                        task.wait(0.1)
                        continue
                    end
                    local v198 = char_6:IsDescendantOf(workspace)
                    if not (v198) then
                        task.wait(0.1)
                        continue
                    end
                    local v199 = char_6:FindFirstChildOfClass("Tool")
                    v195 = false
                    if v199 ~= nil then
                        v195 = (v199 ~= nil) and (v199:IsA("Tool") and (type(v199:GetAttribute("WeaponId")) == "string"))
                        if v195 then
                            v195 = v199:GetAttribute("DrawToken") == u22
                        end
                    end
                    if v195 then
                        local v200 = false
                        local v201 = LocalPlayer_upv_1:GetAttribute("EquipAck")
                        if type(v201) ~= "number" then
                            v196 = 0
                        else
                            v196 = v201
                        end
                        if v196 < u3 then
                            if os.clock() - u4 < 4 then
                                v200 = true
                            else
                                v200 = false
                            end
                        end
                        if v200 then
                            if v195 then
                                task.wait(0.1)
                                continue
                            end
                            if type(v197) == "number" or type(v197) == "string" then
                                v196 = v197
                                local v202 = drawTool(v197, u22)
                                if v202 then
                                    tbl_upv_3.Equip(v202)
                                end
                                task.wait(0.1)
                            end
                            v196 = 1
                            local v202 = drawTool(v197, u22)
                            if v202 then
                                tbl_upv_3.Equip(v202)
                            end
                            task.wait(0.1)
                        else
                            local v203 = LocalPlayer_upv_1:GetAttribute("EquipSlot")
                            if type(v203) ~= "number" or not (v203 > 0) then
                                if os.clock() - v194 > 0.5 then
                                    v194 = os.clock()
                                    u2 = v199
                                    u3 = u3 + 1
                                    u6[v199] = u3
                                    u4 = os.clock()
                                    tbl_upv_5.requests = tbl_upv_5.requests + 1
                                    enforceWant()
                                    v200 = u2
                                    if v200 and u1 then
                                        u5 = os.clock()
                                        send("Equip", {tool = v200, seq = u3})
                                    end
                                end
                                if v195 then
                                    task.wait(0.1)
                                    continue
                                end
                                if type(v197) == "number" or type(v197) == "string" then
                                    v196 = v197
                                    local v202 = drawTool(v197, u22)
                                    if v202 then
                                        tbl_upv_3.Equip(v202)
                                    end
                                    task.wait(0.1)
                                end
                                v196 = 1
                                local v202 = drawTool(v197, u22)
                                if v202 then
                                    tbl_upv_3.Equip(v202)
                                end
                                task.wait(0.1)
                            end
                            return
                        end
                    else
                        if v195 then
                            task.wait(0.1)
                            continue
                        end
                        if type(v197) == "number" or type(v197) == "string" then
                            v196 = v197
                            local v202 = drawTool(v197, u22)
                            if v202 then
                                tbl_upv_3.Equip(v202)
                            end
                            task.wait(0.1)
                        end
                        v196 = 1
                        local v202 = drawTool(v196, u22)
                        if v202 then
                            tbl_upv_3.Equip(v202)
                        end
                        task.wait(0.1)
                    end
                end
            end
        )
    end
    for _, value_16 in {"CombatMode", "State"} do
        LocalPlayer_upv_1:GetAttributeChangedSignal(value_16):Connect(
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
                LocalPlayer_upv_1 (copy, index: 1)
                u8 (ref,  index: 2)
                Util_upv_1 (copy, index: 3)
                tbl_upv_3 (copy, index: 4)
                tbl_upv_1 (copy, index: 5)
                setSpeed (copy, index: 6)
            ]]
            local v204 = LocalPlayer_upv_1:WaitForChild("PlayerScripts"):WaitForChild("Core", 30)
            local v205 = v204 and (v204:WaitForChild("InputStats", 30))
            if not v205 then
                return
            end
            if v205:IsA("ModuleScript") then
                local v206 = require(v205)
                u8 = v206
                v206.Watch(Util_upv_1, 512)
                v206.Watch(tbl_upv_3, 1024)
                for _, value_17 in tbl_upv_1 do
                    v206.Watch(value_17, 1024)
                end
                local PROBE_1 = v206.PROBE
                v206.Hooked(Util_upv_1.Recoil, PROBE_1.n, 1)
                v206.Hooked(tbl_upv_1.Melee.Detect, PROBE_1.t, 1, 2, 3)
                v206.Hooked(Util_upv_1.AimDirection, PROBE_1.v)
                v206.Hooked(setSpeed, PROBE_1.s, 1)
                v206.Hooked(Util_upv_1.RecoilSlow, PROBE_1.n, 1)
                v206.Hooked(Util_upv_1.Shake, PROBE_1.n, 1)
                PROBE_1.m = setmetatable({lastSwing = os.clock()}, tbl_upv_1.Melee)
                PROBE_1.ml = rawget(PROBE_1.m, "lastSwing")
            end
        end
    )
end
function tbl_upv_3.PlayFX(a1, a2)
    --[[
      name: PlayFX
      line: 1553
      upvalues:
        onCombatFX (copy, index: 1)
    ]]
    local success_7, v207 = pcall(onCombatFX, a1, a2)
    if (success_7) then
        return
    end
    warn("[Combat] replay FX error:", a1, v207)
end
function tbl_upv_3.SetReplayHud(a1)
    --[[
      name: SetReplayHud
      line: 1563
      upvalues:
        u12 (ref,  index: 1)
        Touch_upv_1 (copy, index: 2)
        dropHandler (copy, index: 3)
        tbl_upv_4 (copy, index: 4)
        refreshEquipped (copy, index: 5)
    ]]
    if u12 == a1 then
        return
    end
    u12 = a1
    if a1 then
        Touch_upv_1.SetVisible(false)
    else
        pcall(dropHandler)
        tbl_upv_4.tool = nil
        pcall(refreshEquipped)
    end
end
function tbl_upv_3.ReplayHitConfirm(a1)
    --[[
      name: ReplayHitConfirm
      line: 1577
      upvalues:
        onHitConfirm (copy, index: 1)
    ]]
    local success_8, v208 = pcall(onHitConfirm, a1)
    if (success_8) then
        return
    end
    warn("[Combat] replay HitConfirm error:", v208)
end
function tbl_upv_3.ReplayDamageTaken(a1)
    --[[
      name: ReplayDamageTaken
      line: 1584
      upvalues:
        onDamageTaken (copy, index: 1)
    ]]
    local success_9, v209 = pcall(onDamageTaken, a1)
    if (success_9) then
        return
    end
    warn("[Combat] replay DamageTaken error:", v209)
end
function tbl_upv_3.State()
    --[[
      name: State
      line: 1592
      upvalues:
        u2 (ref,  index: 13)
        tbl_upv_4 (copy, index: 14)
        u3 (ref,  index: 15)
        LocalPlayer_upv_1 (copy, index: 16)
        u4 (ref,  index: 17)
        tbl_upv_5 (copy, index: 18)
        tbl_upv_28 (copy, index: 19)
    ]]
    local v210 = u2
    local tbl_35 = {inputs = 0, equipStats = 0, shotId = 0, equipSeq = 0, equipPending = 0, equipAck = 0, lastInput = 0, speed = 0, tool = 0, wantSlot = 0}
    tbl_35.kind = tbl_upv_4.kind
    local v211, v212
    if tbl_upv_4.hum then
        v211 = tbl_upv_4.hum.WalkSpeed
        v212 = tbl_upv_4
    else
        v211, v212 = nil, tbl_upv_4
    end
    tbl_35.speed = v211
    tbl_35.shotId = v212.shotId
    tbl_35.tool = ((tbl_upv_4.tool) and (v212.tool.Name)) or nil
    tbl_35.wantSlot = not v210 and 0 or u2:GetAttribute("SlotIndex")
    tbl_35.equipSeq = u3
    local v214 = LocalPlayer_upv_1:GetAttribute("EquipAck")
    local v215
    if type(v214) ~= "number" then
        v215 = 0
    else
        v215 = v214
    end
    tbl_35.equipAck = v215
    local v216 = false
    local v217 = LocalPlayer_upv_1:GetAttribute("EquipAck")
    local v218
    if type(v217) ~= "number" then
        v218 = 0
    else
        v218 = v217
    end
    if v218 < u3 then
        v216 = os.clock() - u4 < 4
    end
    tbl_35.equipPending = v216
    tbl_35.equipStats = table.clone(tbl_upv_5)
    tbl_35.inputs = tbl_upv_28.n
    tbl_35.lastInput = tbl_upv_28.last
    return tbl_35
end
return tbl_upv_3