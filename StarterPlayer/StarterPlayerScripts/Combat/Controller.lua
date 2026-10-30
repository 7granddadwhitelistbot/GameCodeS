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
local tbl_upv_10 = {shotId = 0}
tbl_upv_10.speed = {[tbl_upv_9] = true}
local tbl_upv_11 = {shotId = 0}
local function copyDecoy()
    --[[
      name: copyDecoy
      line: 172
      upvalues:
        tbl_upv_10 (copy, index: 1)
        tbl_upv_11 (copy, index: 2)
        tbl_upv_9 (copy, index: 3)
        tbl_upv_8 (copy, index: 4)
        u8 (ref,  index: 5)
        tbl_upv_4 (copy, index: 6)
    ]]
    if tbl_upv_10.handler ~= tbl_upv_11.handler or tbl_upv_10.shotId ~= tbl_upv_11.shotId or tbl_upv_10.speed[tbl_upv_9] ~= true or tbl_upv_8.lastSwing ~= tbl_upv_11.lastSwing or tbl_upv_8.holding ~= tbl_upv_11.holding then
        if u8 then
            u8.Note(256)
        end
        tbl_upv_10.speed[tbl_upv_9] = true
    end
    local handler_1 = tbl_upv_4.handler
    local v3
    if handler_1 then
        v3 = rawget(handler_1, "lastSwing")
    else
        v3 = nil
    end
    tbl_upv_8.lastSwing = v3
    local v4
    if handler_1 then
        v4 = rawget(handler_1, "holding")
    else
        v4 = nil
    end
    tbl_upv_8.holding = v4
    local v5
    if handler_1 then
        v5 = tbl_upv_8
    else
        v5 = nil
    end
    tbl_upv_10.handler = v5
    tbl_upv_10.shotId = tbl_upv_4.shotId
    tbl_upv_11.handler = tbl_upv_10.handler
    tbl_upv_11.shotId = tbl_upv_10.shotId
    tbl_upv_11.lastSwing = tbl_upv_8.lastSwing
    tbl_upv_11.holding = tbl_upv_8.holding
end
local function send(a1, a2)
    --[[
      name: send
      line: 197
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
local tbl_upv_12 = {Charge = "Charge", Use = "Use", Throw = "Charge", Draw = "Charge", Block = "Block", Reload = "Reload", Aim = "Aim"}
local function applySpeed()
    --[[
      name: applySpeed
      line: 228
      upvalues:
        tbl_upv_4 (copy, index: 1)
        tbl_upv_12 (copy, index: 2)
        Simulation_upv_1 (copy, index: 3)
    ]]
    local tbl_13 = {Charge = false, Use = false, Block = false, Reload = false, Aim = false}
    for key_1 in tbl_upv_4.speed do
        local v6 = tbl_upv_12[key_1]
        if v6 then
            tbl_13[v6] = true
        end
    end
    for key_2, value_1 in tbl_13 do
        Simulation_upv_1.SetInput(key_2, value_1)
    end
end
local tbl_upv_14 = {}
function tbl_upv_3.OnViewEvent(a1)
    --[[
      name: OnViewEvent
      line: 259
      upvalues:
        tbl_upv_14 (copy, index: 1)
    ]]
    table.insert(tbl_upv_14, a1)
    return function()
        --[[
          line: 261
          upvalues:
            tbl_upv_14 (copy, index: 1)
            a1 (copy, index: 2)
        ]]
        local v7 = table.find(tbl_upv_14, a1)
        if not v7 then
            return
        end
        table.remove(tbl_upv_14, v7)
    end
end
local function presetFor(a1, a2)
    --[[
      name: presetFor
      line: 269
      upvalues:
        Presentation_upv_1 (copy, index: 1)
    ]]
    return Presentation_upv_1.For(a2, a1)
end
local function modelOf(a1)
    --[[
      name: modelOf
      line: 273
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
      line: 286
    ]]
    local v8
    if typeof(a1) == "Instance" then
        if a1:IsA("Player") then
            v8 = a1.Character
        elseif a1:IsA("Model") then
            v8 = a1
        else
            v8 = nil
        end
    else
        v8 = nil
    end
    local v9 = v8 and (v8:FindFirstChild("HumanoidRootPart"))
    if v9 and v9:IsA("BasePart") then
        return v9
    end
    return nil
end
local function toolOf(a1)
    --[[
      name: toolOf
      line: 292
    ]]
    local v10 = (a1 and (a1:FindFirstChildOfClass("Tool"))) or nil
    return v10
end
local function isFar(a1)
    --[[
      name: isFar
      line: 296
      upvalues:
        Effects_upv_1 (copy, index: 1)
    ]]
    local v11 = (a1 ~= nil) and (Effects_upv_1.NEAR < Effects_upv_1.CamDistance(a1))
    return v11
end
local function dropHandler()
    --[[
      name: dropHandler
      line: 317
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
                  line: 321
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
      line: 217
      upvalues:
        tbl_upv_4 (copy, index: 1)
    ]]
    tbl_upv_4.shotId = tbl_upv_4.shotId + 1
    return tbl_upv_4.shotId
end
local function emitView(a1, a2)
    --[[
      name: emitView
      line: 249
      upvalues:
        tbl_upv_14 (copy, index: 1)
    ]]
    for _, value_2 in tbl_upv_14 do
        local success_1, v12 = pcall(value_2, a1, a2)
        if not (success_1) then
            warn("[Combat] view event listener error:", v12)
        end
    end
end
local function setSpeed(a1, a2)
    --[[
      name: setSpeed
      line: 241
      upvalues:
        tbl_upv_4 (copy, index: 1)
        applySpeed (copy, index: 2)
    ]]
    tbl_upv_4.speed[a1] = a2
    applySpeed()
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
      line: 330
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
        local v13 = LocalPlayer_upv_1:GetAttribute("CombatMode")
        local v14
        if v13 ~= nil then
            v14 = v13 == true
        else
            v14 = LocalPlayer_upv_1:GetAttribute("State") == "Match"
        end
        if v14 then
            local v15
            if (u2) and u2.Parent == char_1 then
                v15 = u2
            else
                v15 = char_1:FindFirstChildOfClass("Tool")
            end
            if v15 == tbl_upv_4.tool and tbl_upv_4.handler then
                return
            end
            dropHandler()
            tbl_upv_4.tool = v15
            v13 = Combat_upv_1.FISTS_ID
            local v16 = nil
            if v15 then
                v16 = v15:GetAttribute("WeaponId")
                if type(v16) == "string" and Weapons_upv_1.Get(v16) then
                    v13 = v16
                    local v17 = Weapons_upv_1.Get(v13)
                    local v18 = Combat_upv_1.Tuning(v13)
                    local v19 = Combat_upv_1.Kind(v13) or "Fists"
                    tbl_upv_4.kind = v19
                    tbl_upv_4.baseSpeed = v18.speedMult or 1
                    applySpeed()
                    local v20 = tbl_upv_1[tbl_upv_2[v19] or ""]
                    if v20 then
                        local u9 = v20.new({player = LocalPlayer_upv_1, char = char_1, hum = tbl_upv_4.hum, root = tbl_upv_4.root, animator = tbl_upv_4.animator, tool = v15, weaponId = v13, def = v17, tuning = v18, kind = v19, preset = Presentation_upv_1.For(v13, v19), send = send, nextId = nextId, setSpeed = setSpeed, alive = alive, emit = emitView})
                        tbl_upv_4.handler = u9
                        Hud_upv_1.SetPips(0, 0)
                        Hud_upv_1.SetArc(nil)
                        local SetWeapon_1 = Touch_upv_1.SetWeapon
                        local v21
                        if v15 then
                            v21 = v19
                        else
                            v21 = nil
                        end
                        SetWeapon_1(v21, v18)
                        local success_2, v22 = pcall(
                            function()
                                --[[
                                  line: 392
                                  upvalues:
                                    u9 (copy, index: 1)
                                ]]
                                u9:Equip()
                            end
                        )
                        if not (success_2) then
                            warn("[Combat] equip error:", v22)
                        end
                        local v23 = Util_upv_1.GuardRecovery(v15)
                        if v23 > 0 then
                            Hud_upv_1.SetArc(v23, Color3.fromRGB(150, 196, 236))
                        end
                    else
                        Hud_upv_1.SetStyle("Dot")
                    end
                    return
                end
                Hud_upv_1.SetStyle("Dot")
                return
            end
            local v17 = Weapons_upv_1.Get(v13)
            local v18 = Combat_upv_1.Tuning(v13)
            local v19 = Combat_upv_1.Kind(v13) or "Fists"
            tbl_upv_4.kind = v19
            tbl_upv_4.baseSpeed = v18.speedMult or 1
            applySpeed()
            local v20 = tbl_upv_1[tbl_upv_2[v19] or ""]
            if v20 then
                local u9 = v20.new({player = LocalPlayer_upv_1, char = char_1, hum = tbl_upv_4.hum, root = tbl_upv_4.root, animator = tbl_upv_4.animator, tool = v15, weaponId = v13, def = v17, tuning = v18, kind = v19, preset = Presentation_upv_1.For(v13, v19), send = send, nextId = nextId, setSpeed = setSpeed, alive = alive, emit = emitView})
                tbl_upv_4.handler = u9
                Hud_upv_1.SetPips(0, 0)
                Hud_upv_1.SetArc(nil)
                local SetWeapon_1 = Touch_upv_1.SetWeapon
                local v21
                if v15 then
                    v21 = v19
                else
                    v21 = nil
                end
                SetWeapon_1(v21, v18)
                local success_2, v22 = pcall(
                    function()
                        --[[
                          line: 392
                          upvalues:
                            u9 (copy, index: 1)
                        ]]
                        u9:Equip()
                    end
                )
                if not (success_2) then
                    warn("[Combat] equip error:", v22)
                end
                local v23 = Util_upv_1.GuardRecovery(v15)
                if v23 > 0 then
                    Hud_upv_1.SetArc(v23, Color3.fromRGB(150, 196, 236))
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
      line: 407
    ]]
    local v24 = (a1 ~= nil) and (a1:IsA("Tool") and (type(a1:GetAttribute("WeaponId")) == "string"))
    return v24
end
local function acked()
    --[[
      name: acked
      line: 430
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local v25 = LocalPlayer_upv_1:GetAttribute("EquipAck")
    if type(v25) ~= "number" then
        return 0
    end
    return v25
end
local function equipPending()
    --[[
      name: equipPending
      line: 436
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        u3 (ref,  index: 2)
        u4 (ref,  index: 3)
    ]]
    local v26 = false
    local v27 = LocalPlayer_upv_1:GetAttribute("EquipAck")
    local v28
    if type(v27) ~= "number" then
        v28 = 0
    else
        v28 = v27
    end
    if v28 < u3 then
        v26 = os.clock() - u4 < 4
    end
    return v26
end
local function backpack()
    --[[
      name: backpack
      line: 414
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local v29 = LocalPlayer_upv_1:GetAttribute("CombatDrawToken")
    local v30 = nil
    for _, value_3 in LocalPlayer_upv_1:GetChildren() do
        local v31 = value_3:IsA("Backpack")
        if not (v31) then
            continue
        end
        v30 = v30 or value_3
        for v32, value_4 in value_3:GetChildren() do
            if value_4:GetAttribute("DrawToken") ~= v29 then
                continue
            end
            return value_3
        end
    end
    return v30
end
local function enforceWant()
    --[[
      name: enforceWant
      line: 454
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
    local v32 = backpack()
    if u2.Parent ~= char_2 and u2.Parent ~= v32 then
        u2 = nil
        return
    end
    if u2.Parent ~= char_2 then
        hum_1:EquipTool(u2)
    end
    if not v32 then
        return
    end
    for _, value_5 in char_2:GetChildren() do
        if value_5 == u2 then
            continue
        end
        local v33 = (value_5 ~= nil) and (value_5:IsA("Tool") and (type(value_5:GetAttribute("WeaponId")) == "string"))
        if v33 then
            value_5.Parent = v32
        end
    end
end
local function sendEquip()
    --[[
      name: sendEquip
      line: 476
      upvalues:
        u2 (ref,  index: 1)
        u1 (ref,  index: 2)
        u5 (ref,  index: 3)
        send (copy, index: 4)
        u3 (ref,  index: 5)
    ]]
    local v34 = u2
    if not v34 or not u1 then
        return
    end
    u5 = os.clock()
    send("Equip", {tool = v34, seq = u3})
end
local function requestEquip(a1)
    --[[
      name: requestEquip
      line: 485
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
    local v35 = u2
    if not v35 or not u1 then
        return
    end
    u5 = os.clock()
    send("Equip", {tool = v35, seq = u3})
end
local function toolInSlot(a1)
    --[[
      name: toolInSlot
      line: 440
      upvalues:
        tbl_upv_4 (copy, index: 1)
        backpack (copy, index: 2)
    ]]
    local tbl_15 = {tbl_upv_4.char, backpack()}
    for _, value_6 in tbl_15 do
        if not (value_6) then
            continue
        end
        for v37, value_7 in value_6:GetChildren() do
            local v36 = (value_7 ~= nil) and (value_7:IsA("Tool") and (type(value_7:GetAttribute("WeaponId")) == "string"))
            if not (v36) or value_7:GetAttribute("SlotIndex") ~= a1 then
                continue
            end
            return value_7
        end
    end
    return nil
end
local function reconcileEquip()
    --[[
      name: reconcileEquip
      line: 496
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
        local v37 = backpack()
        if u2 and u2.Parent ~= char_3 and u2.Parent ~= v37 then
            u2 = nil
        end
        local v38 = false
        local v39 = LocalPlayer_upv_1:GetAttribute("EquipAck")
        local v40
        if type(v39) ~= "number" then
            v40 = 0
        else
            v40 = v39
        end
        if v40 < u3 then
            v38 = os.clock() - u4 < 4
        end
        if v38 then
            enforceWant()
        else
            local v41 = LocalPlayer_upv_1:GetAttribute("EquipSlot")
            if type(v41) == "number" and (v41 > 0) then
                v38 = toolInSlot(v41)
            else
                v38 = nil
            end
            if v38 then
                if u2 ~= v38 then
                    if u2 ~= nil then
                        tbl_upv_5.adopted = tbl_upv_5.adopted + 1
                    end
                    u2 = v38
                    u6[v38] = u6[v38] or u3
                end
                enforceWant()
            elseif u2 and os.clock() - u7 > 2 then
                u7 = os.clock()
                tbl_upv_5.reasked = tbl_upv_5.reasked + 1
                local v43 = u2
                u2 = v43
                u3 = u3 + 1
                u6[v43] = u3
                u4 = os.clock()
                tbl_upv_5.requests = tbl_upv_5.requests + 1
                enforceWant()
                local v44 = u2
                if v44 and u1 then
                    u5 = os.clock()
                    send("Equip", {tool = v44, seq = u3})
                end
            end
        end
    end
end
local u10 = false
local function queueReconcile()
    --[[
      name: queueReconcile
      line: 530
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
      line: 546
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
        local v45 = (a1 ~= nil) and (a1:IsA("Tool") and (type(a1:GetAttribute("WeaponId")) == "string"))
        if not v45 then
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
      line: 556
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
        local v46 = (a1 ~= nil) and (a1:IsA("Tool") and (type(a1:GetAttribute("WeaponId")) == "string"))
        if v46 then
            local v47 = backpack()
            if a1.Parent ~= char_4 and a1.Parent ~= v47 then
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
            local v48 = u2
            if v48 and u1 then
                u5 = os.clock()
                send("Equip", {tool = v48, seq = u3})
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
      line: 574
      upvalues:
        u2 (ref, index: 1)
    ]]
    return u2
end
local function onCharacter(a1)
    --[[
      name: onCharacter
      line: 578
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
    for _, value_8 in tbl_upv_4.conns do
        value_8:Disconnect()
    end
    table.clear(tbl_upv_4.conns)
    dropHandler()
    tbl_upv_4.char = a1
    u2 = nil
    tbl_upv_4.tool = nil
    tbl_upv_4.lastSpeed = -1
    tbl_upv_4.killStreak = 0
    local v49 = a1:WaitForChild("Humanoid", 10)
    local v50 = a1:WaitForChild("HumanoidRootPart", 10)
    if not v49 then
        return
    end
    if v50 then
        tbl_upv_4.hum = v49
        tbl_upv_4.root = v50
        v50 = v49:FindFirstChildOfClass("Animator") or (v49:WaitForChild("Animator", 5))
        tbl_upv_4.animator = not (v50) or not (v50:IsA("Animator")) or v50
        if tbl_upv_4.animator then
            task.spawn(Util_upv_1.Preload, tbl_upv_4.animator)
        end
        table.insert(
            tbl_upv_4.conns,
            a1.ChildAdded:Connect(
                function(a2)
                    --[[
                      line: 604
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
                        local v52 = nil
                        if u1 then
                            v52 = (a2 ~= nil) and (a2:IsA("Tool") and (type(a2:GetAttribute("WeaponId")) == "string"))
                            if v52 and a2 ~= u2 and a2.Parent == tbl_upv_4.char then
                                local v53 = (a2 ~= nil) and (a2:IsA("Tool") and (type(a2:GetAttribute("WeaponId")) == "string"))
                                if v53 then
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
                      line: 613
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
            v49.Died:Connect(
                function()
                    --[[
                      line: 621
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
        v50 = a1:FindFirstChildOfClass("Tool")
        if v50 and u1 then
            local v54 = (v50 ~= nil) and (v50:IsA("Tool") and (type(v50:GetAttribute("WeaponId")) == "string"))
            if v54 and v50 ~= u2 and v50.Parent == tbl_upv_4.char then
                local v55 = (v50 ~= nil) and (v50:IsA("Tool") and (type(v50:GetAttribute("WeaponId")) == "string"))
                if v55 then
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
      line: 668
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        u11 (ref,  index: 2)
    ]]
    local v56 = LocalPlayer_upv_1:GetAttribute("CombatDrawToken")
    if type(v56) ~= "number" or v56 == u11 then
        return
    end
    u11 = v56
    task.spawn(function() end)
end
local tbl_upv_16 = {Reload = "Reload", Aim = "Secondary", Attack = "Primary"}
local tbl_upv_17 = {last = "", n = 0}
local function mapInput(a1)
    --[[
      name: mapInput
      line: 716
      upvalues:
        Keybinds_upv_1 (copy, index: 1)
        tbl_upv_16 (copy, index: 2)
    ]]
    local v57 = nil
    for _, value_9 in Keybinds_upv_1.PadActionsOf(a1) do
        v57 = tbl_upv_16[value_9]
        if not (v57) then
            continue
        end
        return v57
    end
    local UserInputType_1 = a1.UserInputType
    if UserInputType_1 ~= Enum.UserInputType.Keyboard and UserInputType_1 ~= Enum.UserInputType.MouseButton1 and UserInputType_1 ~= Enum.UserInputType.MouseButton2 and UserInputType_1 ~= Enum.UserInputType.MouseButton3 then
        return nil
    end
    local v58 = Keybinds_upv_1.ActionOf(a1)
    if v58 then
        return tbl_upv_16[v58]
    end
    return nil
end
local function handlerInput(a1, a2)
    --[[
      name: handlerInput
      line: 737
      upvalues:
        tbl_upv_4 (copy, index: 1)
        tbl_upv_17 (copy, index: 2)
    ]]
    local handler_upv_3 = tbl_upv_4.handler
    if not handler_upv_3 then
        return
    end
    tbl_upv_17.n = tbl_upv_17.n + 1
    tbl_upv_17.last = a1 .. ((a2 and "+") or "-")
    local success_3, v59 = pcall(
        function()
            --[[
              line: 744
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
    warn("[Combat] input error:", v59)
end
local function onInputEnded(a1, a2)
    --[[
      name: onInputEnded
      line: 767
      upvalues:
        mapInput (copy, index: 1)
        tbl_upv_4 (copy, index: 2)
        handlerInput (copy, index: 3)
    ]]
    local v60 = mapInput(a1)
    if not v60 or not tbl_upv_4.pressed[v60] then
        return
    end
    tbl_upv_4.pressed[v60] = nil
    handlerInput(v60, false)
end
local function dispatch(a1, a2)
    --[[
      name: dispatch
      line: 777
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
      line: 800
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
      line: 300
      upvalues:
        Players_upv_1 (copy, index: 1)
    ]]
    if not a1 then
        return nil
    end
    local v61 = a1:GetAttribute("DisplayName")
    if type(v61) == "string" and v61 ~= "" then
        return v61
    end
    local v62 = Players_upv_1:GetPlayerFromCharacter(a1)
    if v62 then
        return v62.DisplayName
    elseif a1:HasTag("TrainingDummy") then
        return "Dummy"
    else
        return a1.Name
    end
end
local function onHitConfirm(a1)
    --[[
      name: onHitConfirm
      line: 816
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
    local v63
    if typeof(a1.position) ~= "Vector3" then
        v63 = nil
    else
        v63 = a1.position
    end
    local v64 = tonumber(a1.amount) or 0
    local v65 = true
    if a1.headshot ~= true then
        v65 = a1.crit == true
    end
    local victim_1 = a1.victim
    local v66 = tonumber(a1.armor) or 0
    if a1.armorBroken then
        Util_upv_1.Sound("Shield_Break")
    end
    if v63 and v64 > 0 then
        local v67
        if a1.dot then
            v67 = "dot"
        elseif a1.killed then
            v67 = "kill"
        elseif v65 then
            v67 = "crit"
        elseif a1.blocked then
            v67 = "blocked"
        elseif (v66 > 0) and (v64 - v66 < 0.5) then
            v67 = "armor"
        else
            v67 = "health"
        end
        local v68 = a1.dot or ((a1.headshot) and "HEADSHOT") or (((a1.crit) and "BACKSTAB") or (((a1.blocked) and "BLOCKED") or (((a1.armorBroken) and "ARMOR BROKEN") or nil)))
        Hud_upv_1.DamageNumber(v63, v64, v67, victim_1, v68)
    end
    if a1.dot then
        return
    end
    local v69 = Effects_upv_1.ConsumePrediction(victim_1)
    local v70 = os.clock()
    local v71 = Combat_upv_1.Kind(a1.weaponId)
    local v72 = Combat_upv_1.IsMelee(v71)
    local v73 = nil
    if a1.killed then
        Hud_upv_1.Hitmarker("kill")
        Util_upv_1.Sound(((a1.headshot) and "Kill_Confirm_Headshot") or "Kill_Confirm")
        tbl_upv_4.killStreak = ((v70 - tbl_upv_4.lastKillAt <= 4) and (tbl_upv_4.killStreak + 1)) or 1
        tbl_upv_4.lastKillAt = v70
        v73 = nameOf(victim_1)
        local v74
        if v73 then
            v74 = string.upper(v73)
        else
            v74 = nil
        end
        if tbl_upv_4.killStreak >= 2 then
            local v75 = ((tbl_upv_4.killStreak ~= 2) and "TRIPLE ELIMINATION") or "DOUBLE ELIMINATION"
            local v76
            if (v74) and (a1.headshot) then
                v76 = ("%* \194\183 %*"):format(v74, Loc_upv_1.T("HEADSHOT"))
            elseif v74 then
                v76 = v74
            elseif a1.headshot then
                v76 = Loc_upv_1.T("HEADSHOT")
            else
                v76 = nil
            end
            Hud_upv_1.KillBanner(v75, v76)
        else
            local KillBanner_1 = Hud_upv_1.KillBanner
            local v77 = ((not v74) and "ELIMINATED") or (("ELIMINATED %*"):format(v74))
            local v78
            if a1.headshot then
                v78 = Loc_upv_1.T("HEADSHOT")
            else
                v78 = nil
            end
            KillBanner_1(v77, v78)
        end
        Util_upv_1.Shake(0.35, 0.18)
    else
        Hud_upv_1.Hitmarker((v65 and "crit") or "hit")
        if a1.headshot then
            Util_upv_1.Sound("Hitmarker_Headshot")
        elseif a1.crit then
            Util_upv_1.Sound(Presentation_upv_1.For(a1.weaponId, v71).critSound or "Hitmarker_Crit")
        elseif v70 - u13 > 0.06 then
            u13 = v70
            Util_upv_1.Sound((v72 and "Hitmarker") or "Hitmarker_Ranged")
        end
    end
    if not v63 or not v72 or v69 then
        return
    end
    Util_upv_1.Sound(Presentation_upv_1.For(a1.weaponId, v71).hitSound or "Hit_Melee", v63)
end
local function onDamageTaken(a1)
    --[[
      name: onDamageTaken
      line: 887
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
    local v79 = tonumber(a1.amount) or 0
    local fromPosition_1 = a1.fromPosition
    if a1.damageType ~= "Burn" then
        if a1.damageType ~= "World" and a1.weaponId ~= "ring" then
            if a1.damageType ~= "Sting" then
                if typeof(fromPosition_1) == "Vector3" then
                    Hud_upv_1.DamageFrom(fromPosition_1, v79 >= 40)
                end
                local v80 = tonumber(a1.armor) or 0
                if not (u12) then
                    local tbl_18 = {blocked = 0}
                    tbl_18.amount = v79
                    tbl_18.blocked = a1.blocked == true
                    emitView("Hurt", tbl_18)
                end
                if a1.interrupted then
                    local v81 = nil
                    if not (u12) then
                        v81 = tbl_upv_4.handler
                        if v81 and type(v81.Interrupt) == "function" then
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
                    local v82 = nil
                    if not (u12) then
                        v82 = tbl_upv_4.handler
                        if v82 and type(v82.Interrupt) == "function" then
                            pcall(function() end)
                        end
                    end
                    Util_upv_1.Sound("Shield_Break")
                    Hud_upv_1.Toast("SHIELD BROKEN", Color3.fromRGB(110, 190, 255), 1.3)
                end
                if a1.blocked then
                    Hud_upv_1.Hurt(math.min(0.35, v79 / 60), Color3.fromRGB(110, 190, 255))
                    Hud_upv_1.BlockPulse()
                    if not (u12) then
                        Guard_upv_1.Impact(tbl_upv_4.char, true)
                    end
                elseif (v80 > 0) and (v79 - v80 < 0.5) then
                    Hud_upv_1.Hurt(math.min(0.3, v79 / 70), Color3.fromRGB(170, 185, 205))
                    Util_upv_1.Shake(math.clamp(v79 / 70, 0.15, 0.6), 0.2)
                    Util_upv_1.Sound("Impact_Metal")
                else
                    Hud_upv_1.Hurt(v79 / 35, nil)
                    Util_upv_1.Shake(math.clamp(v79 / 45, 0.2, 1.1), 0.28)
                    Util_upv_1.Recoil(math.clamp(v79 / 12, 0.5, 4), (math.random() - 0.5) * 3)
                    Util_upv_1.Sound(((v79 >= 30) and "Damage_Receive_Heavy") or "Damage_Receive")
                end
                if type(a1.stagger) == "number" and a1.stagger > 0 then
                    local v83 = nil
                    if not (u12) then
                        v83 = tbl_upv_4.handler
                        if v83 and type(v83.Interrupt) == "function" then
                            pcall(function() end)
                        end
                    end
                    Hud_upv_1.Toast("STAGGERED", Color3.fromRGB(255, 170, 90), a1.stagger + 0.2)
                end
                if a1.damageType == "Trap" then
                    local v84 = nil
                    if not (u12) then
                        v84 = tbl_upv_4.handler
                        if v84 and type(v84.Interrupt) == "function" then
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
                    local v85 = nil
                    if not (u12) then
                        v85 = tbl_upv_4.handler
                        if v85 and type(v85.Interrupt) == "function" then
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
local tbl_upv_19 = {}
local tbl_upv_20 = {}
task.spawn(
    function()
        --[[
          line: 964
          upvalues:
            tbl_upv_19 (copy, index: 1)
            tbl_upv_20 (copy, index: 2)
        ]]
        task.wait(10)
        for key_3 in tbl_upv_19 do
            if not (key_3.Parent) then
                tbl_upv_19[key_3] = nil
            end
        end
        for key_4 in tbl_upv_20 do
            if not (key_4.Parent) then
                tbl_upv_20[key_4] = nil
            end
        end
    end
)
local function onCombatFX(a1, a2)
    --[[
      name: onCombatFX
      line: 980
      upvalues:
        tbl_upv_4 (copy, index: 1)
        Effects_upv_1 (copy, index: 2)
        Combat_upv_1 (copy, index: 3)
        Presentation_upv_1 (copy, index: 4)
        Util_upv_1 (copy, index: 5)
        Quality_upv_1 (copy, index: 6)
        Poses_upv_1 (copy, index: 7)
        tbl_upv_19 (copy, index: 8)
        Hud_upv_1 (copy, index: 9)
        RankFx_upv_1 (copy, index: 10)
        u12 (ref,  index: 11)
        emitView (copy, index: 12)
        Guard_upv_1 (copy, index: 13)
        tbl_upv_20 (copy, index: 14)
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
    local v86 = nil
    if a1 ~= "Swing" then
        local v87 = nil
        if a1 == "Projectile" then
            v87 = a2.shooter
            local v88
            if typeof(v87) == "Instance" then
                if v87:IsA("Player") then
                    v88 = v87.Character
                elseif v87:IsA("Model") then
                    v88 = v87
                else
                    v88 = nil
                end
            else
                v88 = nil
            end
            if v88 and v88 == char_5 and a2.deflected ~= true then
                return
            end
            if typeof(a2.origin) == "Vector3" and typeof(a2.velocity) == "Vector3" and type(a2.key) == "string" then
                local v89 = tonumber(a2.gravity) or 0
                local num_1 = tonumber(a2.pellets)
                if (num_1) and (num_1 > 1) then
                    local velocity_1 = a2.velocity
                    Effects_upv_1.Pellets(a2.key, a2.kind, a2.origin, velocity_1.Unit, velocity_1.Magnitude, v89, num_1, tonumber(a2.spread) or 6, tonumber(a2.seed) or 0, v88)
                else
                    Effects_upv_1.Projectile(a2.key, a2.kind, a2.origin, a2.velocity, v89, v88)
                end
                local v90 = Combat_upv_1.Kind(a2.weaponId)
                local v91 = Presentation_upv_1.For(a2.weaponId, v90 or "Bow")
                local origin_1 = a2.origin
                local v92 = (origin_1 ~= nil) and (Effects_upv_1.NEAR < Effects_upv_1.CamDistance(origin_1))
                local v93 = not v92
                if v93 and (v91.flash or v91.puff) then
                    local Muzzle_1 = Effects_upv_1.Muzzle
                    local v94 = CFrame.lookAt(a2.origin, a2.origin + a2.velocity)
                    local v95
                    if v90 ~= "Pistol" then
                        v95 = true
                    else
                        v95 = false
                    end
                    Muzzle_1(v94, v95, v91.puff ~= false)
                end
                if v88 and v91.kick then
                    Poses_upv_1.Kick(v88, v91.kick * 5)
                end
                v90 = os.clock()
                local v96 = v88 or workspace
                if not (v90 - (tbl_upv_19[v96] or 0) > 0.08) then
                    return
                end
                tbl_upv_19[v96] = v90
                if not v93 and not v91.flash then
                    return
                end
                Util_upv_1.Sound(v91.fireSound or (v91.throwSound or "Bow_Release"), a2.origin)
            end
        elseif a1 == "ProjectileHit" then
            Effects_upv_1.ResolveProjectile(a2)
        elseif a1 ~= "Explosion" then
            if a1 ~= "Smoke" then
                local v97 = nil
                if a1 ~= "Horn" then
                    local v98 = nil
                    if a1 == "Chakram" then
                        v98 = a2.shooter
                        local v88
                        if typeof(v98) == "Instance" then
                            if v98:IsA("Player") then
                                v88 = v98.Character
                            elseif v98:IsA("Model") then
                                v88 = v98
                            else
                                v88 = nil
                            end
                        else
                            v88 = nil
                        end
                        if v88 ~= char_5 and typeof(a2.origin) == "Vector3" and typeof(a2.dir) == "Vector3" and type(a2.key) == "string" then
                            Effects_upv_1.Chakram(a2.key, a2.origin, a2.dir, tonumber(a2.speed) or 110, tonumber(a2.range) or 45, tonumber(a2.catch) or 4.5, v88)
                            local origin_2 = a2.origin
                            local v99 = (origin_2 ~= nil) and (Effects_upv_1.NEAR < Effects_upv_1.CamDistance(origin_2))
                            if v99 then
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
                                            local v100 = nil
                                            if a1 == "CaltropsEnd" then
                                                v100 = tonumber(a2.id)
                                                if not v100 then
                                                    return
                                                end
                                                Effects_upv_1.CaltropsEnd(v100)
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
                                                local v101, v102 = nil, nil
                                                if a1 == "Parry" then
                                                    RankFx_upv_1.Parried(a2)
                                                    v101 = a2.target
                                                    local v103
                                                    if typeof(v101) == "Instance" then
                                                        if v101:IsA("Player") then
                                                            v103 = v101.Character
                                                        elseif v101:IsA("Model") then
                                                            v103 = v101
                                                        else
                                                            v103 = nil
                                                        end
                                                    else
                                                        v103 = nil
                                                    end
                                                    v102 = a2.attacker
                                                    if typeof(v102) == "Instance" then
                                                        if v102:IsA("Player") then
                                                            v86 = v102.Character
                                                        elseif v102:IsA("Model") then
                                                            v86 = v102
                                                        else
                                                            v86 = nil
                                                        end
                                                    else
                                                        v86 = nil
                                                    end
                                                    if v103 ~= nil and v103 == char_5 then
                                                        local handler_upv_5
                                                        if not (u12) then
                                                            Hud_upv_1.Flash(Color3.fromRGB(150, 196, 236), 0.5, 0.25)
                                                            Hud_upv_1.Toast(((a2.ranged) and "DEFLECTED") or "PARRIED", Color3.fromRGB(170, 214, 245), 0.9)
                                                            Util_upv_1.Shake(0.25, 0.12)
                                                            local tbl_21 = {ranged = 0}
                                                            tbl_21.ranged = a2.ranged == true
                                                            emitView("Parried", tbl_21)
                                                            handler_upv_5 = tbl_upv_4.handler
                                                            if handler_upv_5 and type(handler_upv_5.ParryUsed) == "function" then
                                                                pcall(
                                                                    function()
                                                                        --[[
                                                                          line: 1166
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
                                                    if v86 == nil or v86 ~= char_5 or u12 then
                                                        return
                                                    end
                                                    if a2.staggered then
                                                        local v104 = nil
                                                        if not (u12) then
                                                            v104 = tbl_upv_4.handler
                                                            if v104 and type(v104.Interrupt) == "function" then
                                                                pcall(function() end)
                                                            end
                                                        end
                                                        Hud_upv_1.Toast("PARRIED \194\183 STAGGERED", Color3.fromRGB(255, 170, 90), (tonumber(a2.stagger) or 0.5) + 0.3)
                                                        Util_upv_1.Shake(0.4, 0.18)
                                                    else
                                                        Hud_upv_1.Toast("PARRIED", Color3.fromRGB(255, 170, 90), 0.9)
                                                    end
                                                elseif a1 ~= "TrapSnap" then
                                                    local v105, v106 = nil, nil
                                                    if a1 == "Hit" then
                                                        v105 = a2.target
                                                        local v88
                                                        if typeof(v105) == "Instance" then
                                                            if v105:IsA("Player") then
                                                                v88 = v105.Character
                                                            elseif v105:IsA("Model") then
                                                                v88 = v105
                                                            else
                                                                v88 = nil
                                                            end
                                                        else
                                                            v88 = nil
                                                        end
                                                        if typeof(a2.position) ~= "Vector3" then
                                                            v105 = nil
                                                        else
                                                            v105 = a2.position
                                                        end
                                                        v106 = a2.attacker
                                                        local v107
                                                        if typeof(v106) == "Instance" then
                                                            if v106:IsA("Player") then
                                                                v107 = v106.Character
                                                            elseif v106:IsA("Model") then
                                                                v107 = v106
                                                            else
                                                                v107 = nil
                                                            end
                                                        else
                                                            v107 = nil
                                                        end
                                                        if v107 == nil then
                                                            v106 = (v88 ~= nil) and (v88 == char_5)
                                                        else
                                                            v106 = true
                                                            if v107 ~= char_5 then
                                                                v106 = (v88 ~= nil) and (v88 == char_5)
                                                            end
                                                        end
                                                        local v108 = nil
                                                        if not (v106) then
                                                            v108 = (v105 ~= nil) and (Effects_upv_1.NEAR < Effects_upv_1.CamDistance(v105))
                                                            if v108 then
                                                                return
                                                            end
                                                        end
                                                        if a2.damageType ~= "Burn" and v88 ~= char_5 then
                                                            local HitFlash_1 = Effects_upv_1.HitFlash
                                                            local v109
                                                            if a2.blocked then
                                                                v109 = Color3.fromRGB(110, 190, 255)
                                                            else
                                                                v109 = nil
                                                            end
                                                            HitFlash_1(v88, v109)
                                                        end
                                                        if v105 and a2.damageType ~= "Burn" then
                                                            if typeof(a2.source) == "Vector3" and ((v105 - a2.source).Magnitude > 0.1) then
                                                                v106 = (v105 - a2.source).Unit
                                                            else
                                                                v106 = nil
                                                            end
                                                            local v110
                                                            if a2.blocked then
                                                                v110 = "blocked"
                                                            elseif a2.headshot or a2.crit then
                                                                v110 = "headshot"
                                                            else
                                                                v110 = "health"
                                                            end
                                                            local CharacterImpact_1 = Effects_upv_1.CharacterImpact
                                                            local v111 = true
                                                            if a2.headshot ~= true then
                                                                v111 = a2.killed == true
                                                            end
                                                            CharacterImpact_1(v105, v106, v111, v110)
                                                        end
                                                        if a2.blocked and v88 and v88 ~= char_5 then
                                                            Guard_upv_1.Impact(v88, false)
                                                            if a2.guardBroken and v105 then
                                                                Util_upv_1.Sound("Shield_Break", v105)
                                                            end
                                                        end
                                                        if v105 and a2.armor then
                                                            Effects_upv_1.ArmorHit(v105, a2.armorBroken == true)
                                                        end
                                                        if not v105 or v107 == char_5 or v88 == char_5 or a2.damageType ~= "Melee" then
                                                            return
                                                        end
                                                        Util_upv_1.Sound(Presentation_upv_1.For(a2.weaponId, Combat_upv_1.Kind(a2.weaponId) or "Sword").hitSound or "Hit_Melee", v105)
                                                    elseif a1 ~= "Death" then
                                                        if a1 ~= "Heal" then
                                                            if a1 ~= "Status" then
                                                                local v114 = nil
                                                                if a1 ~= "Charge" then
                                                                    local v115 = nil
                                                                    if a1 ~= "Reload" then
                                                                        local v116 = nil
                                                                        if a1 ~= "Block" then
                                                                            local v117 = nil
                                                                            if a1 ~= "Use" then
                                                                                local v118 = nil
                                                                                if a1 == "Equip" then
                                                                                    v118 = a2.attacker
                                                                                    local v88
                                                                                    if typeof(v118) == "Instance" then
                                                                                        if v118:IsA("Player") then
                                                                                            v88 = v118.Character
                                                                                        elseif v118:IsA("Model") then
                                                                                            v88 = v118
                                                                                        else
                                                                                            v88 = nil
                                                                                        end
                                                                                    else
                                                                                        v88 = nil
                                                                                    end
                                                                                    if not v88 or v88 == char_5 then
                                                                                        return
                                                                                    end
                                                                                    local v119 = Presentation_upv_1.For(a2.weaponId, Combat_upv_1.Kind(a2.weaponId) or "Sword")
                                                                                    local Sound_1 = Util_upv_1.Sound
                                                                                    local v120 = v119.equip or "Equip_Item"
                                                                                    local v121
                                                                                    if typeof(v88) == "Instance" then
                                                                                        if v88:IsA("Player") then
                                                                                            v121 = v88.Character
                                                                                        elseif v88:IsA("Model") then
                                                                                            v121 = v88
                                                                                        else
                                                                                            v121 = nil
                                                                                        end
                                                                                    else
                                                                                        v121 = nil
                                                                                    end
                                                                                    local v122 = v121 and (v121:FindFirstChild("HumanoidRootPart"))
                                                                                    local v123 = not (v122) or not (v122:IsA("BasePart")) or v122
                                                                                    Sound_1(v120, v123, {Volume = 0.7})
                                                                                elseif a1 == "Denied" then
                                                                                    local v124 = nil
                                                                                    if a2.reason ~= "NotEquipped" then
                                                                                        v124 = tbl_upv_4.handler
                                                                                        if v124 and type(v124.OnDenied) == "function" then
                                                                                            v124:OnDenied(a2.reason)
                                                                                        end
                                                                                        if a2.reason ~= "NoCharges" then
                                                                                            return
                                                                                        end
                                                                                        Hud_upv_1.Toast("NONE LEFT THIS ROUND", Color3.fromRGB(255, 120, 90))
                                                                                    else
                                                                                        tbl_upv_5.denied = tbl_upv_5.denied + 1
                                                                                        if u2 and u2.Parent == tbl_upv_4.char then
                                                                                            v118 = false
                                                                                            local v125 = LocalPlayer_upv_1:GetAttribute("EquipAck")
                                                                                            local v126
                                                                                            if type(v125) ~= "number" then
                                                                                                v126 = 0
                                                                                            else
                                                                                                v126 = v125
                                                                                            end
                                                                                            if v126 < u3 then
                                                                                                v118 = os.clock() - u4 < 4
                                                                                            end
                                                                                            if not (v118) then
                                                                                                u3 = u3 + 1
                                                                                                u6[u2] = u3
                                                                                                v118 = os.clock()
                                                                                                u4 = v118
                                                                                                tbl_upv_5.requests = tbl_upv_5.requests + 1
                                                                                                enforceWant()
                                                                                                local v127 = u2
                                                                                                if v127 and u1 then
                                                                                                    u5 = os.clock()
                                                                                                    send("Equip", {tool = v127, seq = u3})
                                                                                                end
                                                                                            end
                                                                                        end
                                                                                    end
                                                                                end
                                                                            else
                                                                                v117 = a2.attacker
                                                                                local v88
                                                                                if typeof(v117) == "Instance" then
                                                                                    if v117:IsA("Player") then
                                                                                        v88 = v117.Character
                                                                                    elseif v117:IsA("Model") then
                                                                                        v88 = v117
                                                                                    else
                                                                                        v88 = nil
                                                                                    end
                                                                                else
                                                                                    v88 = nil
                                                                                end
                                                                                if not v88 or v88 == char_5 then
                                                                                    return
                                                                                end
                                                                                local v128 = Combat_upv_1.Kind(a2.weaponId) or "Herbs"
                                                                                local v129 = Presentation_upv_1.For(a2.weaponId, v128)
                                                                                if v128 == "Trap" and not (Util_upv_1.IsTeammate(v88)) then
                                                                                    return
                                                                                end
                                                                                local Sound_2 = Util_upv_1.Sound
                                                                                local v130 = v129.useSound or "Bandage_Wrap"
                                                                                local v121
                                                                                if typeof(a2.position) ~= "Vector3" then
                                                                                    local v131
                                                                                    if typeof(v88) == "Instance" then
                                                                                        if v88:IsA("Player") then
                                                                                            v131 = v88.Character
                                                                                        elseif v88:IsA("Model") then
                                                                                            v131 = v88
                                                                                        else
                                                                                            v131 = nil
                                                                                        end
                                                                                    else
                                                                                        v131 = nil
                                                                                    end
                                                                                    local v132 = v131 and (v131:FindFirstChild("HumanoidRootPart"))
                                                                                    v121 = not (v132) or not (v132:IsA("BasePart")) or v132
                                                                                else
                                                                                    v121 = a2.position
                                                                                end
                                                                                Sound_2(v130, v121)
                                                                            end
                                                                        else
                                                                            v116 = a2.attacker
                                                                            local v88
                                                                            if typeof(v116) == "Instance" then
                                                                                if v116:IsA("Player") then
                                                                                    v88 = v116.Character
                                                                                elseif v116:IsA("Model") then
                                                                                    v88 = v116
                                                                                else
                                                                                    v88 = nil
                                                                                end
                                                                            else
                                                                                v88 = nil
                                                                            end
                                                                            if not v88 or v88 == char_5 or not a2.on then
                                                                                return
                                                                            end
                                                                            local v133 = os.clock()
                                                                            if not (v133 - (tbl_upv_20[v88] or -math.huge) >= 0.5) then
                                                                                return
                                                                            end
                                                                            tbl_upv_20[v88] = v133
                                                                            local Sound_3 = Util_upv_1.Sound
                                                                            local v134 = "Block_Up"
                                                                            local v121
                                                                            if typeof(v88) == "Instance" then
                                                                                if v88:IsA("Player") then
                                                                                    v121 = v88.Character
                                                                                elseif v88:IsA("Model") then
                                                                                    v121 = v88
                                                                                else
                                                                                    v121 = nil
                                                                                end
                                                                            else
                                                                                v121 = nil
                                                                            end
                                                                            local v135 = v121 and (v121:FindFirstChild("HumanoidRootPart"))
                                                                            local v92 = not (v135) or not (v135:IsA("BasePart")) or v135
                                                                            Sound_3(v134, v92)
                                                                        end
                                                                    else
                                                                        v115 = a2.attacker
                                                                        local u14
                                                                        if typeof(v115) == "Instance" then
                                                                            if v115:IsA("Player") then
                                                                                u14 = v115.Character
                                                                            elseif v115:IsA("Model") then
                                                                                u14 = v115
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
                                                                                  line: 1265
                                                                                  upvalues:
                                                                                    Util_upv_1 (copy, index: 1)
                                                                                    u15 (copy, index: 2)
                                                                                    u14 (copy, index: 3)
                                                                                ]]
                                                                                local Sound_4 = Util_upv_1.Sound
                                                                                local v136 = u15.reloadSound or "Crossbow_Reload"
                                                                                local v137
                                                                                if typeof(u14) == "Instance" then
                                                                                    if u14:IsA("Player") then
                                                                                        v137 = u14.Character
                                                                                    elseif u14:IsA("Model") then
                                                                                        v137 = u14
                                                                                    else
                                                                                        v137 = nil
                                                                                    end
                                                                                else
                                                                                    v137 = nil
                                                                                end
                                                                                local v138 = v137 and (v137:FindFirstChild("HumanoidRootPart"))
                                                                                local v139 = not (v138) or not (v138:IsA("BasePart")) or v138
                                                                                Sound_4(v136, v139)
                                                                            end
                                                                        )
                                                                    end
                                                                else
                                                                    v114 = a2.attacker
                                                                    local v88
                                                                    if typeof(v114) == "Instance" then
                                                                        if v114:IsA("Player") then
                                                                            v88 = v114.Character
                                                                        elseif v114:IsA("Model") then
                                                                            v88 = v114
                                                                        else
                                                                            v88 = nil
                                                                        end
                                                                    else
                                                                        v88 = nil
                                                                    end
                                                                    if not v88 or v88 == char_5 or not a2.on then
                                                                        return
                                                                    end
                                                                    local v140
                                                                    if typeof(v88) == "Instance" then
                                                                        if v88:IsA("Player") then
                                                                            v140 = v88.Character
                                                                        elseif v88:IsA("Model") then
                                                                            v140 = v88
                                                                        else
                                                                            v140 = nil
                                                                        end
                                                                    else
                                                                        v140 = nil
                                                                    end
                                                                    local v141 = v140 and (v140:FindFirstChild("HumanoidRootPart"))
                                                                    v86 = not (v141) or not (v141:IsA("BasePart")) or v141
                                                                    local v142 = Presentation_upv_1.For(a2.weaponId, Combat_upv_1.Kind(a2.weaponId))
                                                                    if a2.kind ~= "Draw" then
                                                                        if a2.kind ~= "Heavy" and a2.kind ~= "Lunge" then
                                                                            if a2.kind == "Throw" then
                                                                                Util_upv_1.Sound(v142.windupSound or "Throw_Windup", v86)
                                                                            end
                                                                            return
                                                                        end
                                                                        Util_upv_1.Sound(v142.chargeSound or "Charge_Up", v86)
                                                                    else
                                                                        Util_upv_1.Sound(v142.drawSound or "Bow_Draw", v86)
                                                                    end
                                                                end
                                                            else
                                                                local v113 = a2.target
                                                                local v88
                                                                if typeof(v113) == "Instance" then
                                                                    if v113:IsA("Player") then
                                                                        v88 = v113.Character
                                                                    elseif v113:IsA("Model") then
                                                                        v88 = v113
                                                                    else
                                                                        v88 = nil
                                                                    end
                                                                else
                                                                    v88 = nil
                                                                end
                                                                local v143
                                                                if typeof(v88) == "Instance" then
                                                                    if v88:IsA("Player") then
                                                                        v143 = v88.Character
                                                                    elseif v88:IsA("Model") then
                                                                        v143 = v88
                                                                    else
                                                                        v143 = nil
                                                                    end
                                                                else
                                                                    v143 = nil
                                                                end
                                                                local v144 = v143 and (v143:FindFirstChild("HumanoidRootPart"))
                                                                v113 = not (v144) or not (v144:IsA("BasePart")) or v144
                                                                if v88 == char_5 then
                                                                    if a2.status ~= "Caltrops" then
                                                                        Effects_upv_1.Status(v88, a2.status, tonumber(a2.duration) or 1)
                                                                        if (v88 ~= char_5 or a2.status ~= "Burn") and v88 == char_5 then
                                                                            if a2.status ~= "Snare" then
                                                                                return
                                                                            end
                                                                            Hud_upv_1.Toast("SNARED", Color3.fromRGB(226, 196, 140), 1.2)
                                                                        end
                                                                        Hud_upv_1.Toast("BURNING", Color3.fromRGB(255, 140, 60), 1)
                                                                    else
                                                                        if v88 and v88:IsA("Model") then
                                                                            Effects_upv_1.CaltropStep(v88)
                                                                        end
                                                                        if v88 == char_5 then
                                                                            Hud_upv_1.Toast("CALTROPS", Color3.fromRGB(214, 180, 140), 0.9)
                                                                        end
                                                                    end
                                                                end
                                                                if v113 then
                                                                    local Position_1 = v113.Position
                                                                    v143 = (Position_1 ~= nil) and (Effects_upv_1.NEAR < Effects_upv_1.CamDistance(Position_1))
                                                                    if not v143 then
                                                                        if a2.status ~= "Caltrops" then
                                                                            Effects_upv_1.Status(v88, a2.status, tonumber(a2.duration) or 1)
                                                                            if (v88 ~= char_5 or a2.status ~= "Burn") and v88 == char_5 then
                                                                                if a2.status ~= "Snare" then
                                                                                    return
                                                                                end
                                                                                Hud_upv_1.Toast("SNARED", Color3.fromRGB(226, 196, 140), 1.2)
                                                                            end
                                                                            Hud_upv_1.Toast("BURNING", Color3.fromRGB(255, 140, 60), 1)
                                                                        else
                                                                            if v88 and v88:IsA("Model") then
                                                                                Effects_upv_1.CaltropStep(v88)
                                                                            end
                                                                            if v88 ~= char_5 then
                                                                                return
                                                                            end
                                                                            Hud_upv_1.Toast("CALTROPS", Color3.fromRGB(214, 180, 140), 0.9)
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        else
                                                            local v112 = a2.target
                                                            local v88
                                                            if typeof(v112) == "Instance" then
                                                                if v112:IsA("Player") then
                                                                    v88 = v112.Character
                                                                elseif v112:IsA("Model") then
                                                                    v88 = v112
                                                                else
                                                                    v88 = nil
                                                                end
                                                            else
                                                                v88 = nil
                                                            end
                                                            local v145
                                                            if typeof(v88) == "Instance" then
                                                                if v88:IsA("Player") then
                                                                    v145 = v88.Character
                                                                elseif v88:IsA("Model") then
                                                                    v145 = v88
                                                                else
                                                                    v145 = nil
                                                                end
                                                            else
                                                                v145 = nil
                                                            end
                                                            local v146 = v145 and (v145:FindFirstChild("HumanoidRootPart"))
                                                            v112 = not (v146) or not (v146:IsA("BasePart")) or v146
                                                            if v88 ~= char_5 and v112 then
                                                                local Position_2 = v112.Position
                                                                v145 = (Position_2 ~= nil) and (Effects_upv_1.NEAR < Effects_upv_1.CamDistance(Position_2))
                                                                if (v145) then
                                                                    return
                                                                end
                                                                Effects_upv_1.Heal(v88, tonumber(a2.duration) or 3)
                                                            end
                                                            Effects_upv_1.Heal(v88, tonumber(a2.duration) or 3)
                                                        end
                                                    elseif typeof(a2.position) == "Vector3" then
                                                        local Death_1 = Effects_upv_1.Death
                                                        local position_1 = a2.position
                                                        v102 = false
                                                        local killer_1 = a2.killer
                                                        local v147
                                                        if typeof(killer_1) == "Instance" then
                                                            if killer_1:IsA("Player") then
                                                                v147 = killer_1.Character
                                                            elseif killer_1:IsA("Model") then
                                                                v147 = killer_1
                                                            else
                                                                v147 = nil
                                                            end
                                                        else
                                                            v147 = nil
                                                        end
                                                        if v147 == char_5 then
                                                            v102 = char_5 ~= nil
                                                        end
                                                        if type(a2.weaponId) ~= "string" then
                                                            v147 = nil
                                                        else
                                                            v147 = a2.weaponId
                                                        end
                                                        Death_1(position_1, v102, v147, a2.headshot == true)
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
                            local v147
                            if typeof(a2.position) ~= "Vector3" then
                                v147 = nil
                            else
                                v147 = a2.position
                            end
                            ChakramEnd_1(key_5, a2.caught == true, v147)
                        end
                    elseif type(a2.key) == "string" and typeof(a2.position) == "Vector3" then
                        Effects_upv_1.ChakramTurn(a2.key, a2.position)
                    end
                else
                    v97 = a2.attacker
                    local v88
                    if typeof(v97) == "Instance" then
                        if v97:IsA("Player") then
                            v88 = v97.Character
                        elseif v97:IsA("Model") then
                            v88 = v97
                        else
                            v88 = nil
                        end
                    else
                        v88 = nil
                    end
                    if typeof(a2.position) ~= "Vector3" then
                        v86 = nil
                    else
                        v86 = a2.position
                    end
                    if not v86 then
                        return
                    end
                    Util_upv_1.Sound("War_Horn", v86)
                    Effects_upv_1.HornBlast(v86)
                    if v88 == nil then
                        if v88 == nil or char_5 == nil or not Util_upv_1.IsEnemy(v88) then
                            return
                        end
                        Hud_upv_1.DamageFrom(v86, true, Color3.fromRGB(240, 180, 70), tonumber(a2.reveal) or 3)
                        Hud_upv_1.Toast("ENEMY HORN", Color3.fromRGB(240, 180, 70), 1.6)
                    else
                        if v88 ~= char_5 and not (Util_upv_1.IsTeammate(v88)) then
                            if v88 ~= nil and char_5 ~= nil and Util_upv_1.IsEnemy(v88) then
                                Hud_upv_1.DamageFrom(v86, true, Color3.fromRGB(240, 180, 70), tonumber(a2.reveal) or 3)
                                Hud_upv_1.Toast("ENEMY HORN", Color3.fromRGB(240, 180, 70), 1.6)
                            end
                            return
                        end
                        if type(a2.enemies) == "table" then
                            local v148 = nil
                            for _, value_10 in a2.enemies do
                                if typeof(value_10) == "Instance" then
                                    if value_10:IsA("Player") then
                                        v148 = value_10.Character
                                    elseif value_10:IsA("Model") then
                                        v148 = value_10
                                    else
                                        v148 = nil
                                    end
                                else
                                    v148 = nil
                                end
                                if v148 then
                                    Effects_upv_1.Reveal(v148, tonumber(a2.reveal) or 3)
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
                local v149 = tonumber(a2.duration) or 7
                Effects_upv_1.SmokeCloud(a2.position, tonumber(a2.radius) or 13, v149)
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
                    v149,
                    function()
                        --[[
                          line: 1065
                          upvalues:
                            u17 (copy, index: 1)
                            u16 (copy, index: 2)
                        ]]
                        pcall(u17, 1)
                        task.delay(
                            1.2,
                            function()
                                --[[
                                  line: 1067
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
        v86 = a2.attacker
        local v88
        if typeof(v86) == "Instance" then
            if v86:IsA("Player") then
                v88 = v86.Character
            elseif v86:IsA("Model") then
                v88 = v86
            else
                v88 = nil
            end
        else
            v88 = nil
        end
        if v88 and v88 ~= char_5 then
            local v150
            if typeof(v88) == "Instance" then
                if v88:IsA("Player") then
                    v150 = v88.Character
                elseif v88:IsA("Model") then
                    v150 = v88
                else
                    v150 = nil
                end
            else
                v150 = nil
            end
            local v151 = v150 and (v150:FindFirstChild("HumanoidRootPart"))
            v86 = not (v151) or not (v151:IsA("BasePart")) or v151
            if v86 then
                local Position_3 = v86.Position
                v150 = (Position_3 ~= nil) and (Effects_upv_1.NEAR < Effects_upv_1.CamDistance(Position_3))
                if not (v150) then
                    local v152 = Presentation_upv_1.For(a2.weaponId, Combat_upv_1.Kind(a2.weaponId) or "Fists")
                    if a2.heavy == true then
                        v150 = v152.heavySound or (v152.swingSound)
                    elseif a2.lunge ~= true then
                        v150 = v152.swingSound
                    else
                        v150 = v152.lungeSound or (v152.swingSound)
                    end
                    Util_upv_1.Sound(v150 or "Swing_Sword", v86)
                    if v152.trail and v152.trail > 0 and Quality_upv_1.layers then
                        local Trail_1 = Effects_upv_1.Trail
                        local v153 = (v88 and (v88:FindFirstChildOfClass("Tool"))) or nil
                        Trail_1(v153, v152.trail)
                    end
                    if v152.noSlash then
                        return
                    end
                    local Slash_1 = Effects_upv_1.Slash
                    local v154 = tonumber(a2.step) or 1
                    Slash_1(v88, v154, a2.heavy == true, v152.slashColor)
                    if a2.heavy == true then
                        Effects_upv_1.GroundScuff((v86.Position + (v86.CFrame.LookVector * 4)) - Vector3.new(0, 2.799999952316284, 0))
                    end
                end
            end
        end
    end
end
local function onInputBegan(a1, a2)
    --[[
      name: onInputBegan
      line: 752
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
    local v155 = mapInput(a1)
    if not v155 then
        return
    end
    if tbl_upv_4.handler and tbl_upv_4.hum ~= nil and (tbl_upv_4.hum.Health > 0) and tbl_upv_4.char ~= nil and tbl_upv_4.char.Parent ~= nil and not Util_upv_1.IsMouseUnlocked() and (not Keybinds_upv_1.PadBlocked() or not (#Keybinds_upv_1.PadActionsOf(a1) > 0)) then
        tbl_upv_4.pressed[v155] = true
        handlerInput(v155, true)
    end
end
local function drawTool(a1, a2)
    --[[
      name: drawTool
      line: 643
      upvalues:
        tbl_upv_4 (copy, index: 1)
        backpack (copy, index: 2)
    ]]
    local v156 = nil
    local tbl_22 = {tbl_upv_4.char, backpack()}
    for _, value_11 in tbl_22 do
        if not (value_11) then
            continue
        end
        for v160, value_12 in value_11:GetChildren() do
            local v157 = (value_12 ~= nil) and (value_12:IsA("Tool") and (type(value_12:GetAttribute("WeaponId")) == "string"))
            if not (v157) or value_12:GetAttribute("DrawToken") ~= a2 then
                continue
            end
            if (type(a1) ~= "string" or value_12:GetAttribute("Slot") ~= a1) and (type(a1) ~= "number" or value_12:GetAttribute("SlotIndex") ~= a1) then
                local v158 = value_12:GetAttribute("SlotIndex")
                local v159 = v156 and (v156:GetAttribute("SlotIndex"))
                if not (v156) then
                    v156 = value_12
                    continue
                end
                if type(v158) ~= "number" or type(v159) ~= "number" then
                    continue
                end
                if v158 < v159 then
                    v156 = value_12
                    continue
                end
            end
            return value_12
        end
    end
    return v156
end
function tbl_upv_3.Start()
    --[[
      name: Start
      line: 1315
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
    ]]
    local u18 = false
    local u19 = nil
    Net_upv_1.UnreliableEvent("CombatFXU").OnClientEvent:Connect(
        function(a1, a2)
            --[[
              line: 1321
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
    local v160 = Net_upv_1.Event("HitConfirm")
    local v161 = Net_upv_1.Event("DamageTaken")
    local v162 = Net_upv_1.Event("CombatFX")
    tbl_upv_4.shotId = math.floor((workspace:GetServerTimeNow() % 1e+05) * 10)
    Hud_upv_1.Init()
    Guard_upv_1.Init()
    Poses_upv_1.Init()
    World_upv_1.Init()
    Quality_upv_1.Start()
    Touch_upv_1.Start(dispatch)
    v160.OnClientEvent:Connect(
        function(a3)
            --[[
              line: 1340
              upvalues:
                onHitConfirm (copy, index: 1)
            ]]
            local success_4, v163 = pcall(onHitConfirm, a3)
            if (success_4) then
                return
            end
            warn("[Combat] HitConfirm error:", v163)
        end
    )
    v161.OnClientEvent:Connect(
        function(a4)
            --[[
              line: 1346
              upvalues:
                onDamageTaken (copy, index: 1)
            ]]
            local success_5, v164 = pcall(onDamageTaken, a4)
            if (success_5) then
                return
            end
            warn("[Combat] DamageTaken error:", v164)
        end
    )
    local function fx(a5, a6)
        --[[
          name: fx
          line: 1352
          upvalues:
            onCombatFX (copy, index: 1)
            Metrics_upv_1 (copy, index: 2)
        ]]
        local v165 = os.clock()
        local success_6, v166 = pcall(onCombatFX, a5, a6)
        local AddFx_1 = Metrics_upv_1.AddFx
        local v167 = os.clock() - v165
        local v168
        if type(a5) ~= "string" then
            v168 = nil
        else
            v168 = a5
        end
        AddFx_1(v167, v168)
        if (success_6) then
            return
        end
        warn("[Combat] CombatFX error:", a5, v166)
    end
    v162.OnClientEvent:Connect(fx)
    u19 = fx
    u18 = true
    local v169 = Net_upv_1.Event("AnimRelay")
    Util_upv_1.SetAnimRelay(v169)
    v169.OnClientEvent:Connect(
        function(a7, a8, a9, a10, a11, a12)
            --[[
              line: 1368
              upvalues:
                tbl_upv_4 (copy, index: 1)
                Util_upv_1 (copy, index: 2)
            ]]
            if typeof(a7) ~= "Instance" or not a7:IsA("Model") or a7 == tbl_upv_4.char then
                return
            end
            if type(a9) == "string" then
                local v170 = a7:FindFirstChildOfClass("Humanoid")
                local v171 = v170 and (v170:FindFirstChildOfClass("Animator"))
                if v171 and a7:IsDescendantOf(workspace) then
                    local v172
                    if type(a10) ~= "number" then
                        v172 = 1
                    else
                        v172 = a10
                    end
                    if a8 == "Play" then
                        Util_upv_1.PlayAnim(v170, a9, v172, tonumber(a11), (tonumber(a12)))
                    elseif a8 == "Hold" then
                        Util_upv_1.PlayHold(v170, a9, v172)
                    elseif a8 == "Stop" then
                        Util_upv_1.StopAnim(v170, a9, (tonumber(a11)))
                    end
                    return
                end
            end
        end
    )
    local tbl_upv_23 = {}
    task.spawn(
        function()
            --[[
              line: 1389
              upvalues:
                Players_upv_1 (copy, index: 1)
                LocalPlayer_upv_1 (copy, index: 2)
                Combat_upv_1 (copy, index: 3)
                Presentation_upv_1 (copy, index: 4)
                tbl_upv_23 (copy, index: 5)
                Util_upv_1 (copy, index: 6)
            ]]
            task.wait(0.5)
            local CurrentCamera_1 = workspace.CurrentCamera
            local v173 = ((not CurrentCamera_1) and Vector3.new(0, 0, 0)) or (CurrentCamera_1.CFrame.Position)
            local v174 = nil
            for _, value_13 in Players_upv_1:GetPlayers() do
                local Character_1 = value_13.Character
                if value_13 == LocalPlayer_upv_1 or not (Character_1) then
                    continue
                end
                v174 = Character_1:FindFirstChild("HumanoidRootPart")
                local v175 = Character_1:FindFirstChildOfClass("Humanoid")
                local v176 = v175 and (v175:FindFirstChildOfClass("Animator"))
                if not (v174) then
                    continue
                end
                local v177 = v174:IsA("BasePart")
                if not (v177) or not (v176) or (v174.Position - v173).Magnitude > 160 then
                    continue
                end
                v174 = (Character_1 and (Character_1:FindFirstChildOfClass("Tool"))) or nil
                v177 = v174 and (v174:GetAttribute("WeaponId"))
                if type(v177) ~= "string" or not (v175.Health > 0) then
                    v174 = nil
                    v177 = tbl_upv_23[Character_1]
                    if v177 then
                        if v177 ~= v174 then
                            Util_upv_1.StopAnim(v175, v177, 0.15)
                            tbl_upv_23[Character_1] = nil
                        end
                        if not (v174) then
                            continue
                        end
                        v177 = Util_upv_1.GetTrack(v175, v174)
                        if not (v177) then
                            tbl_upv_23[Character_1] = v174
                            continue
                        end
                        if not (v177.IsPlaying) then
                            Util_upv_1.PlayAnim(v175, v174, 1, 0.2)
                        end
                    else
                        if not (v174) then
                            continue
                        end
                        v177 = Util_upv_1.GetTrack(v175, v174)
                        if not (v178) then
                            tbl_upv_23[Character_1] = v174
                            continue
                        end
                        if not (v178.IsPlaying) then
                            Util_upv_1.PlayAnim(v175, v174, 1, 0.2)
                        end
                    end
                    tbl_upv_23[Character_1] = v174
                end
                v174 = Presentation_upv_1.For(v177, Combat_upv_1.Kind(v177)).hold
                v177 = tbl_upv_23[Character_1]
                if v177 and v177 ~= v174 then
                    Util_upv_1.StopAnim(v175, v177, 0.15)
                    tbl_upv_23[Character_1] = nil
                end
                if not (v174) then
                    continue
                end
                v177 = Util_upv_1.GetTrack(v175, v174)
                if not (v177) then
                    tbl_upv_23[Character_1] = v174
                    continue
                end
                if not (v177.IsPlaying) then
                    Util_upv_1.PlayAnim(v175, v174, 1, 0.2)
                end
                tbl_upv_23[Character_1] = v174
            end
            for key_6 in tbl_upv_23 do
                if not (key_6.Parent) then
                    tbl_upv_23[key_6] = nil
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
              line: 1434
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
                local v179 = LocalPlayer_upv_1:GetAttribute("EquipAck")
                local v180
                if type(v179) ~= "number" then
                    v180 = 0
                else
                    v180 = v179
                end
                if (u3 <= v180) then
                    return
                end
                if u20 ~= u3 then
                    local v181 = os.clock()
                    if v181 - u4 >= 4 then
                        u20 = u3
                        if u10 then
                            return
                        end
                        u10 = true
                        task.defer(
                            function()
                                --[[
                                  line: 535
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
                    elseif v181 - u5 >= 1 and u2 and (tbl_upv_4.hum ~= nil) and ((tbl_upv_4.hum.Health > 0) and ((tbl_upv_4.char ~= nil) and (tbl_upv_4.char.Parent ~= nil))) then
                        tbl_upv_5.resent = tbl_upv_5.resent + 1
                        local v182 = u2
                        if v182 and u1 then
                            u5 = os.clock()
                            send("Equip", {tool = v182, seq = u3})
                        end
                    end
                end
            end
        end
    )
    for _, value_14 in {"EquipAck", "EquipSlot"} do
        LocalPlayer_upv_1:GetAttributeChangedSignal(value_14):Connect(queueReconcile)
    end
    local u21 = false
    RunService_upv_1.RenderStepped:Connect(
        function(a13)
            --[[
              line: 1452
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
                local v183, v184 = pcall(
                    function()
                        --[[
                          line: 1461
                          upvalues:
                            handler_upv_6 (copy, index: 1)
                            a13 (copy, index: 2)
                        ]]
                        handler_upv_6:Update(a13)
                    end
                )
                if not (v183) then
                    warn("[Combat] update error:", v184)
                end
            end
            local v185 = not Util_upv_1.CanAct()
            local v183 = nil
            if v185 ~= u21 then
                u21 = v185
                Hud_upv_1.SetFrozen(v185)
                if v185 then
                    if not (u12) then
                        v183 = tbl_upv_4.handler
                        if v183 and type(v183.Interrupt) == "function" then
                            pcall(
                                function()
                                    --[[
                                      line: 806
                                      upvalues:
                                        v183 (copy, index: 1)
                                    ]]
                                    v183:Interrupt()
                                end
                            )
                        end
                    end
                end
            end
            local v186 = LocalPlayer_upv_1:GetAttribute("CombatMode")
            if v186 ~= nil then
                v183 = v186 == true
            else
                local v187 = LocalPlayer_upv_1:GetAttribute("State") == "Match"
                v183 = v187
            end
            v186 = not Util_upv_1.IsMouseUnlocked() and (LocalPlayer_upv_1:GetAttribute("MenuOpen") ~= true)
            local SetVisible_1 = Hud_upv_1.SetVisible
            local v188 = v186
            if v188 then
                v188 = (tbl_upv_4.hum ~= nil) and ((tbl_upv_4.hum.Health > 0) and ((tbl_upv_4.char ~= nil) and (tbl_upv_4.char.Parent ~= nil)))
                if v188 then
                    v188 = v183
                end
            end
            SetVisible_1(v188)
            Touch_upv_1.SetVisible(v186 and v183)
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
                  line: 674
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
                local v189 = os.clock()
                local v190 = -math.huge
                local v191, v192, v192 = nil, nil, nil
                while os.clock() - v189 < 10 do
                    if LocalPlayer_upv_1:GetAttribute("CombatDrawToken") ~= u22 then
                        return
                    end
                    local v193 = LocalPlayer_upv_1:GetAttribute("CombatDrawSlot")
                    if v193 == 0 then
                        return
                    end
                    local char_6 = tbl_upv_4.char
                    local hum_4 = tbl_upv_4.hum
                    if not (char_6) or not (hum_4) or not (hum_4.Health > 0) or char_6 ~= LocalPlayer_upv_1.Character then
                        task.wait(0.1)
                        continue
                    end
                    local v194 = char_6:IsDescendantOf(workspace)
                    if not (v194) then
                        task.wait(0.1)
                        continue
                    end
                    local v195 = char_6:FindFirstChildOfClass("Tool")
                    v191 = false
                    if v195 ~= nil then
                        v191 = (v195 ~= nil) and (v195:IsA("Tool") and (type(v195:GetAttribute("WeaponId")) == "string"))
                        if v191 then
                            v191 = v195:GetAttribute("DrawToken") == u22
                        end
                    end
                    if v191 then
                        local v196 = false
                        local v197 = LocalPlayer_upv_1:GetAttribute("EquipAck")
                        if type(v197) ~= "number" then
                            v192 = 0
                        else
                            v192 = v197
                        end
                        if v192 < u3 then
                            if os.clock() - u4 < 4 then
                                v196 = true
                            else
                                v196 = false
                            end
                        end
                        if v196 then
                            if v191 then
                                task.wait(0.1)
                                continue
                            end
                            if type(v193) == "number" or type(v193) == "string" then
                                v192 = v193
                                local v198 = drawTool(v193, u22)
                                if v198 then
                                    tbl_upv_3.Equip(v198)
                                end
                                task.wait(0.1)
                            end
                            v192 = 1
                            local v198 = drawTool(v193, u22)
                            if v198 then
                                tbl_upv_3.Equip(v198)
                            end
                            task.wait(0.1)
                        else
                            local v199 = LocalPlayer_upv_1:GetAttribute("EquipSlot")
                            if type(v199) ~= "number" or not (v199 > 0) then
                                if os.clock() - v190 > 0.5 then
                                    v190 = os.clock()
                                    u2 = v195
                                    u3 = u3 + 1
                                    u6[v195] = u3
                                    u4 = os.clock()
                                    tbl_upv_5.requests = tbl_upv_5.requests + 1
                                    enforceWant()
                                    v196 = u2
                                    if v196 and u1 then
                                        u5 = os.clock()
                                        send("Equip", {tool = v196, seq = u3})
                                    end
                                end
                                if v191 then
                                    task.wait(0.1)
                                    continue
                                end
                                if type(v193) == "number" or type(v193) == "string" then
                                    v192 = v193
                                    local v198 = drawTool(v193, u22)
                                    if v198 then
                                        tbl_upv_3.Equip(v198)
                                    end
                                    task.wait(0.1)
                                end
                                v192 = 1
                                local v198 = drawTool(v193, u22)
                                if v198 then
                                    tbl_upv_3.Equip(v198)
                                end
                                task.wait(0.1)
                            end
                            return
                        end
                    else
                        if v191 then
                            task.wait(0.1)
                            continue
                        end
                        if type(v193) == "number" or type(v193) == "string" then
                            v192 = v193
                            local v198 = drawTool(v193, u22)
                            if v198 then
                                tbl_upv_3.Equip(v198)
                            end
                            task.wait(0.1)
                        end
                        v192 = 1
                        local v198 = drawTool(v192, u22)
                        if v198 then
                            tbl_upv_3.Equip(v198)
                        end
                        task.wait(0.1)
                    end
                end
            end
        )
    end
    for _, value_15 in {"CombatMode", "State"} do
        LocalPlayer_upv_1:GetAttributeChangedSignal(value_15):Connect(
            function()
                --[[
                  line: 1491
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
              line: 1497
              upvalues:
                LocalPlayer_upv_1 (copy, index: 1)
                u8 (ref,  index: 2)
                Util_upv_1 (copy, index: 3)
                tbl_upv_3 (copy, index: 4)
                tbl_upv_1 (copy, index: 5)
            ]]
            local v200 = LocalPlayer_upv_1:WaitForChild("PlayerScripts"):WaitForChild("Core", 30)
            local v201 = v200 and (v200:WaitForChild("InputStats", 30))
            if not v201 then
                return
            end
            if v201:IsA("ModuleScript") then
                local v202 = require(v201)
                u8 = v202
                v202.Watch(Util_upv_1, 512)
                v202.Watch(tbl_upv_3, 1024)
                for _, value_16 in tbl_upv_1 do
                    v202.Watch(value_16, 1024)
                end
            end
        end
    )
end
function tbl_upv_3.PlayFX(a1, a2)
    --[[
      name: PlayFX
      line: 1514
      upvalues:
        onCombatFX (copy, index: 1)
    ]]
    local success_7, v203 = pcall(onCombatFX, a1, a2)
    if (success_7) then
        return
    end
    warn("[Combat] replay FX error:", a1, v203)
end
function tbl_upv_3.SetReplayHud(a1)
    --[[
      name: SetReplayHud
      line: 1524
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
      line: 1538
      upvalues:
        onHitConfirm (copy, index: 1)
    ]]
    local success_8, v204 = pcall(onHitConfirm, a1)
    if (success_8) then
        return
    end
    warn("[Combat] replay HitConfirm error:", v204)
end
function tbl_upv_3.ReplayDamageTaken(a1)
    --[[
      name: ReplayDamageTaken
      line: 1545
      upvalues:
        onDamageTaken (copy, index: 1)
    ]]
    local success_9, v205 = pcall(onDamageTaken, a1)
    if (success_9) then
        return
    end
    warn("[Combat] replay DamageTaken error:", v205)
end
function tbl_upv_3.State()
    --[[
      name: State
      line: 1553
      upvalues:
        u2 (ref,  index: 1)
        tbl_upv_4 (copy, index: 4)
        u3 (ref,  index: 5)
        LocalPlayer_upv_1 (copy, index: 6)
        u4 (ref,  index: 7)
        tbl_upv_5 (copy, index: 8)
        tbl_upv_17 (copy, index: 9)
    ]]
    local v206 = u2
    local tbl_24 = {inputs = 0, equipStats = 0, shotId = 0, equipSeq = 0, equipPending = 0, equipAck = 0, lastInput = 0, speed = 0, tool = 0, wantSlot = 0}
    tbl_24.kind = tbl_upv_4.kind
    tbl_24.tool = ((tbl_upv_4.tool) and (tbl_upv_4.tool.Name)) or nil
    local v207
    if tbl_upv_4.hum then
        v207 = tbl_upv_4.hum.WalkSpeed
    else
        v207 = nil
    end
    tbl_24.speed = v207
    tbl_24.shotId = tbl_upv_4.shotId
    tbl_24.wantSlot = not v206 and 0 or u2:GetAttribute("SlotIndex")
    tbl_24.equipSeq = u3
    local v209 = LocalPlayer_upv_1:GetAttribute("EquipAck")
    local v210
    if type(v209) ~= "number" then
        v210 = 0
    else
        v210 = v209
    end
    tbl_24.equipAck = v210
    local v211 = false
    local v212 = LocalPlayer_upv_1:GetAttribute("EquipAck")
    local v213
    if type(v212) ~= "number" then
        v213 = 0
    else
        v213 = v212
    end
    if v213 < u3 then
        v211 = os.clock() - u4 < 4
    end
    tbl_24.equipPending = v211
    tbl_24.equipStats = table.clone(tbl_upv_5)
    tbl_24.inputs = tbl_upv_17.n
    tbl_24.lastInput = tbl_upv_17.last
    return tbl_24
end
return tbl_upv_3