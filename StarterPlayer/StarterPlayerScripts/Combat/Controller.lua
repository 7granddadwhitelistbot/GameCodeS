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
local tbl_upv_15 = {tbl_13, tbl_10, tbl_14, tbl_11, tbl_12}
local tbl_upv_16 = {shotId = 0}
local function copyDecoy()
    --[[
      name: copyDecoy
      line: 177
      upvalues:
        tbl_upv_8 (copy, index: 1)
        tbl_upv_16 (copy, index: 2)
        tbl_upv_4 (copy, index: 3)
        tbl_upv_15 (copy, index: 4)
        tbl_upv_9 (copy, index: 5)
        u8 (ref,  index: 6)
    ]]
    local v3 = true
    if tbl_upv_8.lastSwing == tbl_upv_16.lastSwing then
        v3 = tbl_upv_8.holding ~= tbl_upv_16.holding
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
    for _, value_1 in tbl_upv_15 do
        if value_1.handler ~= tbl_upv_16.handler or value_1.shotId ~= tbl_upv_16.shotId or value_1.speed[tbl_upv_9] ~= true then
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
    tbl_upv_16.handler = v7
    tbl_upv_16.shotId = tbl_upv_4.shotId
    tbl_upv_16.lastSwing = tbl_upv_8.lastSwing
    tbl_upv_16.holding = tbl_upv_8.holding
end
local function send(a1, a2)
    --[[
      name: send
      line: 199
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
local tbl_upv_17 = {Charge = "Charge", Use = "Use", Throw = "Charge", Draw = "Charge", Block = "Block", Reload = "Reload", Aim = "Aim"}
local function applySpeed()
    --[[
      name: applySpeed
      line: 230
      upvalues:
        tbl_upv_4 (copy, index: 1)
        tbl_upv_17 (copy, index: 2)
        Simulation_upv_1 (copy, index: 3)
    ]]
    local tbl_18 = {Charge = false, Use = false, Block = false, Reload = false, Aim = false}
    for key_1 in tbl_upv_4.speed do
        local v8 = tbl_upv_17[key_1]
        if v8 then
            tbl_18[v8] = true
        end
    end
    for key_2, value_2 in tbl_18 do
        Simulation_upv_1.SetInput(key_2, value_2)
    end
end
local tbl_upv_19 = {}
function tbl_upv_3.OnViewEvent(a1)
    --[[
      name: OnViewEvent
      line: 265
      upvalues:
        tbl_upv_19 (copy, index: 1)
    ]]
    table.insert(tbl_upv_19, a1)
    return function()
        --[[
          line: 267
          upvalues:
            tbl_upv_19 (copy, index: 1)
            a1 (copy, index: 2)
        ]]
        local v9 = table.find(tbl_upv_19, a1)
        if not v9 then
            return
        end
        table.remove(tbl_upv_19, v9)
    end
end
local function presetFor(a1, a2)
    --[[
      name: presetFor
      line: 275
      upvalues:
        Presentation_upv_1 (copy, index: 1)
    ]]
    return Presentation_upv_1.For(a2, a1)
end
local function modelOf(a1)
    --[[
      name: modelOf
      line: 279
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
      line: 292
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
      line: 298
    ]]
    local v12 = (a1 and (a1:FindFirstChildOfClass("Tool"))) or nil
    return v12
end
local function isFar(a1)
    --[[
      name: isFar
      line: 302
      upvalues:
        Effects_upv_1 (copy, index: 1)
    ]]
    local v13 = (a1 ~= nil) and (Effects_upv_1.NEAR < Effects_upv_1.CamDistance(a1))
    return v13
end
local function dropHandler()
    --[[
      name: dropHandler
      line: 323
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
                  line: 327
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
      line: 219
      upvalues:
        tbl_upv_4 (copy, index: 1)
    ]]
    tbl_upv_4.shotId = tbl_upv_4.shotId + 1
    return tbl_upv_4.shotId
end
local function emitView(a1, a2)
    --[[
      name: emitView
      line: 255
      upvalues:
        tbl_upv_19 (copy, index: 1)
    ]]
    for _, value_3 in tbl_upv_19 do
        local success_1, v14 = pcall(value_3, a1, a2)
        if not (success_1) then
            warn("[Combat] view event listener error:", v14)
        end
    end
end
local function setSpeed(a1, a2)
    --[[
      name: setSpeed
      line: 243
      upvalues:
        Util_upv_1 (copy, index: 1)
        tbl_upv_4 (copy, index: 2)
        applySpeed (copy, index: 3)
    ]]
    local v15 = Util_upv_1.Probe(a1, a2)
    if v15 == nil then
        tbl_upv_4.speed[a1] = a2
        applySpeed()
    else
        return v15
    end
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
      line: 336
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
        local v16 = LocalPlayer_upv_1:GetAttribute("CombatMode")
        local v17
        if v16 ~= nil then
            v17 = v16 == true
        else
            v17 = LocalPlayer_upv_1:GetAttribute("State") == "Match"
        end
        if v17 then
            local v18
            if (u2) and u2.Parent == char_1 then
                v18 = u2
            else
                v18 = char_1:FindFirstChildOfClass("Tool")
            end
            if v18 == tbl_upv_4.tool and tbl_upv_4.handler then
                return
            end
            dropHandler()
            tbl_upv_4.tool = v18
            v16 = Combat_upv_1.FISTS_ID
            local v19 = nil
            if v18 then
                v19 = v18:GetAttribute("WeaponId")
                if type(v19) == "string" and Weapons_upv_1.Get(v19) then
                    v16 = v19
                    local v20 = Weapons_upv_1.Get(v16)
                    local v21 = Combat_upv_1.Tuning(v16)
                    local v22 = Combat_upv_1.Kind(v16) or "Fists"
                    tbl_upv_4.kind = v22
                    tbl_upv_4.baseSpeed = v21.speedMult or 1
                    applySpeed()
                    local v23 = tbl_upv_1[tbl_upv_2[v22] or ""]
                    if v23 then
                        local u9 = v23.new({player = LocalPlayer_upv_1, char = char_1, hum = tbl_upv_4.hum, root = tbl_upv_4.root, animator = tbl_upv_4.animator, tool = v18, weaponId = v16, def = v20, tuning = v21, kind = v22, preset = Presentation_upv_1.For(v16, v22), send = send, nextId = nextId, setSpeed = setSpeed, alive = alive, emit = emitView})
                        tbl_upv_4.handler = u9
                        Hud_upv_1.SetPips(0, 0)
                        Hud_upv_1.SetArc(nil)
                        local SetWeapon_1 = Touch_upv_1.SetWeapon
                        local v24
                        if v18 then
                            v24 = v22
                        else
                            v24 = nil
                        end
                        SetWeapon_1(v24, v21)
                        local success_2, v25 = pcall(
                            function()
                                --[[
                                  line: 398
                                  upvalues:
                                    u9 (copy, index: 1)
                                ]]
                                u9:Equip()
                            end
                        )
                        if not (success_2) then
                            warn("[Combat] equip error:", v25)
                        end
                        local v26 = Util_upv_1.GuardRecovery(v18)
                        if v26 > 0 then
                            Hud_upv_1.SetArc(v26, Color3.fromRGB(150, 196, 236))
                        end
                    else
                        Hud_upv_1.SetStyle("Dot")
                    end
                    return
                end
                Hud_upv_1.SetStyle("Dot")
                return
            end
            local v20 = Weapons_upv_1.Get(v16)
            local v21 = Combat_upv_1.Tuning(v16)
            local v22 = Combat_upv_1.Kind(v16) or "Fists"
            tbl_upv_4.kind = v22
            tbl_upv_4.baseSpeed = v21.speedMult or 1
            applySpeed()
            local v23 = tbl_upv_1[tbl_upv_2[v22] or ""]
            if v23 then
                local u9 = v23.new({player = LocalPlayer_upv_1, char = char_1, hum = tbl_upv_4.hum, root = tbl_upv_4.root, animator = tbl_upv_4.animator, tool = v18, weaponId = v16, def = v20, tuning = v21, kind = v22, preset = Presentation_upv_1.For(v16, v22), send = send, nextId = nextId, setSpeed = setSpeed, alive = alive, emit = emitView})
                tbl_upv_4.handler = u9
                Hud_upv_1.SetPips(0, 0)
                Hud_upv_1.SetArc(nil)
                local SetWeapon_1 = Touch_upv_1.SetWeapon
                local v24
                if v18 then
                    v24 = v22
                else
                    v24 = nil
                end
                SetWeapon_1(v24, v21)
                local success_2, v25 = pcall(
                    function()
                        --[[
                          line: 398
                          upvalues:
                            u9 (copy, index: 1)
                        ]]
                        u9:Equip()
                    end
                )
                if not (success_2) then
                    warn("[Combat] equip error:", v25)
                end
                local v26 = Util_upv_1.GuardRecovery(v18)
                if v26 > 0 then
                    Hud_upv_1.SetArc(v26, Color3.fromRGB(150, 196, 236))
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
      line: 413
    ]]
    local v27 = (a1 ~= nil) and (a1:IsA("Tool") and (type(a1:GetAttribute("WeaponId")) == "string"))
    return v27
end
local function acked()
    --[[
      name: acked
      line: 436
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local v28 = LocalPlayer_upv_1:GetAttribute("EquipAck")
    if type(v28) ~= "number" then
        return 0
    end
    return v28
end
local function equipPending()
    --[[
      name: equipPending
      line: 442
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        u3 (ref,  index: 2)
        u4 (ref,  index: 3)
    ]]
    local v29 = false
    local v30 = LocalPlayer_upv_1:GetAttribute("EquipAck")
    local v31
    if type(v30) ~= "number" then
        v31 = 0
    else
        v31 = v30
    end
    if v31 < u3 then
        v29 = os.clock() - u4 < 4
    end
    return v29
end
local function backpack()
    --[[
      name: backpack
      line: 420
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local v32 = LocalPlayer_upv_1:GetAttribute("CombatDrawToken")
    local v33 = nil
    for _, value_4 in LocalPlayer_upv_1:GetChildren() do
        local v34 = value_4:IsA("Backpack")
        if not (v34) then
            continue
        end
        v33 = v33 or value_4
        for v35, value_5 in value_4:GetChildren() do
            if value_5:GetAttribute("DrawToken") ~= v32 then
                continue
            end
            return value_4
        end
    end
    return v33
end
local function enforceWant()
    --[[
      name: enforceWant
      line: 460
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
    local v35 = backpack()
    if u2.Parent ~= char_2 and u2.Parent ~= v35 then
        u2 = nil
        return
    end
    if u2.Parent ~= char_2 then
        hum_1:EquipTool(u2)
    end
    if not v35 then
        return
    end
    for _, value_6 in char_2:GetChildren() do
        if value_6 == u2 then
            continue
        end
        local v36 = (value_6 ~= nil) and (value_6:IsA("Tool") and (type(value_6:GetAttribute("WeaponId")) == "string"))
        if v36 then
            value_6.Parent = v35
        end
    end
end
local function sendEquip()
    --[[
      name: sendEquip
      line: 482
      upvalues:
        u2 (ref,  index: 1)
        u1 (ref,  index: 2)
        u5 (ref,  index: 3)
        send (copy, index: 4)
        u3 (ref,  index: 5)
    ]]
    local v37 = u2
    if not v37 or not u1 then
        return
    end
    u5 = os.clock()
    send("Equip", {tool = v37, seq = u3})
end
local function requestEquip(a1)
    --[[
      name: requestEquip
      line: 491
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
    local v38 = u2
    if not v38 or not u1 then
        return
    end
    u5 = os.clock()
    send("Equip", {tool = v38, seq = u3})
end
local function toolInSlot(a1)
    --[[
      name: toolInSlot
      line: 446
      upvalues:
        tbl_upv_4 (copy, index: 1)
        backpack (copy, index: 2)
    ]]
    local tbl_20 = {tbl_upv_4.char, backpack()}
    for _, value_7 in tbl_20 do
        if not (value_7) then
            continue
        end
        for v40, value_8 in value_7:GetChildren() do
            local v39 = (value_8 ~= nil) and (value_8:IsA("Tool") and (type(value_8:GetAttribute("WeaponId")) == "string"))
            if not (v39) or value_8:GetAttribute("SlotIndex") ~= a1 then
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
      line: 502
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
        local v40 = backpack()
        if u2 and u2.Parent ~= char_3 and u2.Parent ~= v40 then
            u2 = nil
        end
        local v41 = false
        local v42 = LocalPlayer_upv_1:GetAttribute("EquipAck")
        local v43
        if type(v42) ~= "number" then
            v43 = 0
        else
            v43 = v42
        end
        if v43 < u3 then
            v41 = os.clock() - u4 < 4
        end
        if v41 then
            enforceWant()
        else
            local v44 = LocalPlayer_upv_1:GetAttribute("EquipSlot")
            if type(v44) == "number" and (v44 > 0) then
                v41 = toolInSlot(v44)
            else
                v41 = nil
            end
            if v41 then
                if u2 ~= v41 then
                    if u2 ~= nil then
                        tbl_upv_5.adopted = tbl_upv_5.adopted + 1
                    end
                    u2 = v41
                    u6[v41] = u6[v41] or u3
                end
                enforceWant()
            elseif u2 and os.clock() - u7 > 2 then
                u7 = os.clock()
                tbl_upv_5.reasked = tbl_upv_5.reasked + 1
                local v46 = u2
                u2 = v46
                u3 = u3 + 1
                u6[v46] = u3
                u4 = os.clock()
                tbl_upv_5.requests = tbl_upv_5.requests + 1
                enforceWant()
                local v47 = u2
                if v47 and u1 then
                    u5 = os.clock()
                    send("Equip", {tool = v47, seq = u3})
                end
            end
        end
    end
end
local u10 = false
local function queueReconcile()
    --[[
      name: queueReconcile
      line: 536
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
      line: 552
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
        local v48 = (a1 ~= nil) and (a1:IsA("Tool") and (type(a1:GetAttribute("WeaponId")) == "string"))
        if not v48 then
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
      line: 562
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
        local v49 = (a1 ~= nil) and (a1:IsA("Tool") and (type(a1:GetAttribute("WeaponId")) == "string"))
        if v49 then
            local v50 = backpack()
            if a1.Parent ~= char_4 and a1.Parent ~= v50 then
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
            local v51 = u2
            if v51 and u1 then
                u5 = os.clock()
                send("Equip", {tool = v51, seq = u3})
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
      line: 580
      upvalues:
        u2 (ref, index: 1)
    ]]
    return u2
end
local function onCharacter(a1)
    --[[
      name: onCharacter
      line: 584
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
    local v52 = a1:WaitForChild("Humanoid", 10)
    local v53 = a1:WaitForChild("HumanoidRootPart", 10)
    if not v52 then
        return
    end
    if v53 then
        tbl_upv_4.hum = v52
        tbl_upv_4.root = v53
        v53 = v52:FindFirstChildOfClass("Animator") or (v52:WaitForChild("Animator", 5))
        tbl_upv_4.animator = not (v53) or not (v53:IsA("Animator")) or v53
        if tbl_upv_4.animator then
            task.spawn(Util_upv_1.Preload, tbl_upv_4.animator)
        end
        table.insert(
            tbl_upv_4.conns,
            a1.ChildAdded:Connect(
                function(a2)
                    --[[
                      line: 610
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
                        local v55 = nil
                        if u1 then
                            v55 = (a2 ~= nil) and (a2:IsA("Tool") and (type(a2:GetAttribute("WeaponId")) == "string"))
                            if v55 and a2 ~= u2 and a2.Parent == tbl_upv_4.char then
                                local v56 = (a2 ~= nil) and (a2:IsA("Tool") and (type(a2:GetAttribute("WeaponId")) == "string"))
                                if v56 then
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
                      line: 619
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
            v52.Died:Connect(
                function()
                    --[[
                      line: 627
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
        v53 = a1:FindFirstChildOfClass("Tool")
        if v53 and u1 then
            local v57 = (v53 ~= nil) and (v53:IsA("Tool") and (type(v53:GetAttribute("WeaponId")) == "string"))
            if v57 and v53 ~= u2 and v53.Parent == tbl_upv_4.char then
                local v58 = (v53 ~= nil) and (v53:IsA("Tool") and (type(v53:GetAttribute("WeaponId")) == "string"))
                if v58 then
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
      line: 674
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        u11 (ref,  index: 2)
    ]]
    local v59 = LocalPlayer_upv_1:GetAttribute("CombatDrawToken")
    if type(v59) ~= "number" or v59 == u11 then
        return
    end
    u11 = v59
    task.spawn(function() end)
end
local tbl_upv_21 = {Reload = "Reload", Aim = "Secondary", Attack = "Primary"}
local tbl_upv_22 = {last = "", n = 0}
local function mapInput(a1)
    --[[
      name: mapInput
      line: 722
      upvalues:
        Keybinds_upv_1 (copy, index: 1)
        tbl_upv_21 (copy, index: 2)
    ]]
    local v60 = nil
    for _, value_10 in Keybinds_upv_1.PadActionsOf(a1) do
        v60 = tbl_upv_21[value_10]
        if not (v60) then
            continue
        end
        return v60
    end
    local UserInputType_1 = a1.UserInputType
    if UserInputType_1 ~= Enum.UserInputType.Keyboard and UserInputType_1 ~= Enum.UserInputType.MouseButton1 and UserInputType_1 ~= Enum.UserInputType.MouseButton2 and UserInputType_1 ~= Enum.UserInputType.MouseButton3 then
        return nil
    end
    local v61 = Keybinds_upv_1.ActionOf(a1)
    if v61 then
        return tbl_upv_21[v61]
    end
    return nil
end
local function handlerInput(a1, a2)
    --[[
      name: handlerInput
      line: 743
      upvalues:
        tbl_upv_4 (copy, index: 1)
        tbl_upv_22 (copy, index: 2)
    ]]
    local handler_upv_3 = tbl_upv_4.handler
    if not handler_upv_3 then
        return
    end
    tbl_upv_22.n = tbl_upv_22.n + 1
    tbl_upv_22.last = a1 .. ((a2 and "+") or "-")
    local success_3, v62 = pcall(
        function()
            --[[
              line: 750
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
    warn("[Combat] input error:", v62)
end
local function onInputEnded(a1, a2)
    --[[
      name: onInputEnded
      line: 773
      upvalues:
        mapInput (copy, index: 1)
        tbl_upv_4 (copy, index: 2)
        handlerInput (copy, index: 3)
    ]]
    local v63 = mapInput(a1)
    if not v63 or not tbl_upv_4.pressed[v63] then
        return
    end
    tbl_upv_4.pressed[v63] = nil
    handlerInput(v63, false)
end
local function dispatch(a1, a2)
    --[[
      name: dispatch
      line: 783
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
      line: 806
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
      line: 306
      upvalues:
        Players_upv_1 (copy, index: 1)
    ]]
    if not a1 then
        return nil
    end
    local v64 = a1:GetAttribute("DisplayName")
    if type(v64) == "string" and v64 ~= "" then
        return v64
    end
    local v65 = Players_upv_1:GetPlayerFromCharacter(a1)
    if v65 then
        return v65.DisplayName
    elseif a1:HasTag("TrainingDummy") then
        return "Dummy"
    else
        return a1.Name
    end
end
local function onHitConfirm(a1)
    --[[
      name: onHitConfirm
      line: 822
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
    local v66
    if typeof(a1.position) ~= "Vector3" then
        v66 = nil
    else
        v66 = a1.position
    end
    local v67 = tonumber(a1.amount) or 0
    local v68 = true
    if a1.headshot ~= true then
        v68 = a1.crit == true
    end
    local victim_1 = a1.victim
    local v69 = tonumber(a1.armor) or 0
    if a1.armorBroken then
        Util_upv_1.Sound("Shield_Break")
    end
    if v66 and v67 > 0 then
        local v70
        if a1.dot then
            v70 = "dot"
        elseif a1.killed then
            v70 = "kill"
        elseif v68 then
            v70 = "crit"
        elseif a1.blocked then
            v70 = "blocked"
        elseif (v69 > 0) and (v67 - v69 < 0.5) then
            v70 = "armor"
        else
            v70 = "health"
        end
        local v71 = a1.dot or ((a1.headshot) and "HEADSHOT") or (((a1.crit) and "BACKSTAB") or (((a1.blocked) and "BLOCKED") or (((a1.armorBroken) and "ARMOR BROKEN") or nil)))
        Hud_upv_1.DamageNumber(v66, v67, v70, victim_1, v71)
    end
    if a1.dot then
        return
    end
    local v72 = Effects_upv_1.ConsumePrediction(victim_1)
    local v73 = os.clock()
    local v74 = Combat_upv_1.Kind(a1.weaponId)
    local v75 = Combat_upv_1.IsMelee(v74)
    local v76 = nil
    if a1.killed then
        Hud_upv_1.Hitmarker("kill")
        Util_upv_1.Sound(((a1.headshot) and "Kill_Confirm_Headshot") or "Kill_Confirm")
        tbl_upv_4.killStreak = ((v73 - tbl_upv_4.lastKillAt <= 4) and (tbl_upv_4.killStreak + 1)) or 1
        tbl_upv_4.lastKillAt = v73
        v76 = nameOf(victim_1)
        local v77
        if v76 then
            v77 = string.upper(v76)
        else
            v77 = nil
        end
        if tbl_upv_4.killStreak >= 2 then
            local v78 = ((tbl_upv_4.killStreak ~= 2) and "TRIPLE ELIMINATION") or "DOUBLE ELIMINATION"
            local v79
            if (v77) and (a1.headshot) then
                v79 = ("%* \194\183 %*"):format(v77, Loc_upv_1.T("HEADSHOT"))
            elseif v77 then
                v79 = v77
            elseif a1.headshot then
                v79 = Loc_upv_1.T("HEADSHOT")
            else
                v79 = nil
            end
            Hud_upv_1.KillBanner(v78, v79)
        else
            local KillBanner_1 = Hud_upv_1.KillBanner
            local v80 = ((not v77) and "ELIMINATED") or (("ELIMINATED %*"):format(v77))
            local v81
            if a1.headshot then
                v81 = Loc_upv_1.T("HEADSHOT")
            else
                v81 = nil
            end
            KillBanner_1(v80, v81)
        end
        Util_upv_1.Shake(0.35, 0.18)
    else
        Hud_upv_1.Hitmarker((v68 and "crit") or "hit")
        if a1.headshot then
            Util_upv_1.Sound("Hitmarker_Headshot")
        elseif a1.crit then
            Util_upv_1.Sound(Presentation_upv_1.For(a1.weaponId, v74).critSound or "Hitmarker_Crit")
        elseif v73 - u13 > 0.06 then
            u13 = v73
            Util_upv_1.Sound((v75 and "Hitmarker") or "Hitmarker_Ranged")
        end
    end
    if not v66 or not v75 or v72 then
        return
    end
    Util_upv_1.Sound(Presentation_upv_1.For(a1.weaponId, v74).hitSound or "Hit_Melee", v66)
end
local function onDamageTaken(a1)
    --[[
      name: onDamageTaken
      line: 893
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
    local v82 = tonumber(a1.amount) or 0
    local fromPosition_1 = a1.fromPosition
    if a1.damageType ~= "Burn" then
        if a1.damageType ~= "World" and a1.weaponId ~= "ring" then
            if a1.damageType ~= "Sting" then
                if typeof(fromPosition_1) == "Vector3" then
                    Hud_upv_1.DamageFrom(fromPosition_1, v82 >= 40)
                end
                local v83 = tonumber(a1.armor) or 0
                if not (u12) then
                    local tbl_23 = {blocked = 0}
                    tbl_23.amount = v82
                    tbl_23.blocked = a1.blocked == true
                    emitView("Hurt", tbl_23)
                end
                if a1.interrupted then
                    local v84 = nil
                    if not (u12) then
                        v84 = tbl_upv_4.handler
                        if v84 and type(v84.Interrupt) == "function" then
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
                    local v85 = nil
                    if not (u12) then
                        v85 = tbl_upv_4.handler
                        if v85 and type(v85.Interrupt) == "function" then
                            pcall(function() end)
                        end
                    end
                    Util_upv_1.Sound("Shield_Break")
                    Hud_upv_1.Toast("SHIELD BROKEN", Color3.fromRGB(110, 190, 255), 1.3)
                end
                if a1.blocked then
                    Hud_upv_1.Hurt(math.min(0.35, v82 / 60), Color3.fromRGB(110, 190, 255))
                    Hud_upv_1.BlockPulse()
                    if not (u12) then
                        Guard_upv_1.Impact(tbl_upv_4.char, true)
                    end
                elseif (v83 > 0) and (v82 - v83 < 0.5) then
                    Hud_upv_1.Hurt(math.min(0.3, v82 / 70), Color3.fromRGB(170, 185, 205))
                    Util_upv_1.Shake(math.clamp(v82 / 70, 0.15, 0.6), 0.2)
                    Util_upv_1.Sound("Impact_Metal")
                else
                    Hud_upv_1.Hurt(v82 / 35, nil)
                    Util_upv_1.Shake(math.clamp(v82 / 45, 0.2, 1.1), 0.28)
                    Util_upv_1.Recoil(math.clamp(v82 / 12, 0.5, 4), (math.random() - 0.5) * 3)
                    Util_upv_1.Sound(((v82 >= 30) and "Damage_Receive_Heavy") or "Damage_Receive")
                end
                if type(a1.stagger) == "number" and a1.stagger > 0 then
                    local v86 = nil
                    if not (u12) then
                        v86 = tbl_upv_4.handler
                        if v86 and type(v86.Interrupt) == "function" then
                            pcall(function() end)
                        end
                    end
                    Hud_upv_1.Toast("STAGGERED", Color3.fromRGB(255, 170, 90), a1.stagger + 0.2)
                end
                if a1.damageType == "Trap" then
                    local v87 = nil
                    if not (u12) then
                        v87 = tbl_upv_4.handler
                        if v87 and type(v87.Interrupt) == "function" then
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
                    local v88 = nil
                    if not (u12) then
                        v88 = tbl_upv_4.handler
                        if v88 and type(v88.Interrupt) == "function" then
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
local tbl_upv_24 = {}
local tbl_upv_25 = {}
task.spawn(
    function()
        --[[
          line: 970
          upvalues:
            tbl_upv_24 (copy, index: 1)
            tbl_upv_25 (copy, index: 2)
        ]]
        task.wait(10)
        for key_3 in tbl_upv_24 do
            if not (key_3.Parent) then
                tbl_upv_24[key_3] = nil
            end
        end
        for key_4 in tbl_upv_25 do
            if not (key_4.Parent) then
                tbl_upv_25[key_4] = nil
            end
        end
    end
)
local function onCombatFX(a1, a2)
    --[[
      name: onCombatFX
      line: 986
      upvalues:
        tbl_upv_4 (copy, index: 1)
        Effects_upv_1 (copy, index: 2)
        Combat_upv_1 (copy, index: 3)
        Presentation_upv_1 (copy, index: 4)
        Util_upv_1 (copy, index: 5)
        Quality_upv_1 (copy, index: 6)
        Poses_upv_1 (copy, index: 7)
        tbl_upv_24 (copy, index: 8)
        Hud_upv_1 (copy, index: 9)
        RankFx_upv_1 (copy, index: 10)
        u12 (ref,  index: 11)
        emitView (copy, index: 12)
        Guard_upv_1 (copy, index: 13)
        tbl_upv_25 (copy, index: 14)
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
    local v89 = nil
    if a1 ~= "Swing" then
        local v90 = nil
        if a1 == "Projectile" then
            v90 = a2.shooter
            local v91
            if typeof(v90) == "Instance" then
                if v90:IsA("Player") then
                    v91 = v90.Character
                elseif v90:IsA("Model") then
                    v91 = v90
                else
                    v91 = nil
                end
            else
                v91 = nil
            end
            if v91 and v91 == char_5 and a2.deflected ~= true then
                return
            end
            if typeof(a2.origin) == "Vector3" and typeof(a2.velocity) == "Vector3" and type(a2.key) == "string" then
                local v92 = tonumber(a2.gravity) or 0
                local num_1 = tonumber(a2.pellets)
                if (num_1) and (num_1 > 1) then
                    local velocity_1 = a2.velocity
                    Effects_upv_1.Pellets(a2.key, a2.kind, a2.origin, velocity_1.Unit, velocity_1.Magnitude, v92, num_1, tonumber(a2.spread) or 6, tonumber(a2.seed) or 0, v91)
                else
                    Effects_upv_1.Projectile(a2.key, a2.kind, a2.origin, a2.velocity, v92, v91)
                end
                local v93 = Combat_upv_1.Kind(a2.weaponId)
                local v94 = Presentation_upv_1.For(a2.weaponId, v93 or "Bow")
                local origin_1 = a2.origin
                local v95 = (origin_1 ~= nil) and (Effects_upv_1.NEAR < Effects_upv_1.CamDistance(origin_1))
                local v96 = not v95
                if v96 and (v94.flash or v94.puff) then
                    local Muzzle_1 = Effects_upv_1.Muzzle
                    local v97 = CFrame.lookAt(a2.origin, a2.origin + a2.velocity)
                    local v98
                    if v93 ~= "Pistol" then
                        v98 = true
                    else
                        v98 = false
                    end
                    Muzzle_1(v97, v98, v94.puff ~= false)
                end
                if v91 and v94.kick then
                    Poses_upv_1.Kick(v91, v94.kick * 5)
                end
                v93 = os.clock()
                local v99 = v91 or workspace
                if not (v93 - (tbl_upv_24[v99] or 0) > 0.08) then
                    return
                end
                tbl_upv_24[v99] = v93
                if not v96 and not v94.flash then
                    return
                end
                Util_upv_1.Sound(v94.fireSound or (v94.throwSound or "Bow_Release"), a2.origin)
            end
        elseif a1 == "ProjectileHit" then
            Effects_upv_1.ResolveProjectile(a2)
        elseif a1 ~= "Explosion" then
            if a1 ~= "Smoke" then
                local v100 = nil
                if a1 ~= "Horn" then
                    local v101 = nil
                    if a1 == "Chakram" then
                        v101 = a2.shooter
                        local v91
                        if typeof(v101) == "Instance" then
                            if v101:IsA("Player") then
                                v91 = v101.Character
                            elseif v101:IsA("Model") then
                                v91 = v101
                            else
                                v91 = nil
                            end
                        else
                            v91 = nil
                        end
                        if v91 ~= char_5 and typeof(a2.origin) == "Vector3" and typeof(a2.dir) == "Vector3" and type(a2.key) == "string" then
                            Effects_upv_1.Chakram(a2.key, a2.origin, a2.dir, tonumber(a2.speed) or 110, tonumber(a2.range) or 45, tonumber(a2.catch) or 4.5, v91)
                            local origin_2 = a2.origin
                            local v102 = (origin_2 ~= nil) and (Effects_upv_1.NEAR < Effects_upv_1.CamDistance(origin_2))
                            if v102 then
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
                                            local v103 = nil
                                            if a1 == "CaltropsEnd" then
                                                v103 = tonumber(a2.id)
                                                if not v103 then
                                                    return
                                                end
                                                Effects_upv_1.CaltropsEnd(v103)
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
                                                local v104, v105 = nil, nil
                                                if a1 == "Parry" then
                                                    RankFx_upv_1.Parried(a2)
                                                    v104 = a2.target
                                                    local v106
                                                    if typeof(v104) == "Instance" then
                                                        if v104:IsA("Player") then
                                                            v106 = v104.Character
                                                        elseif v104:IsA("Model") then
                                                            v106 = v104
                                                        else
                                                            v106 = nil
                                                        end
                                                    else
                                                        v106 = nil
                                                    end
                                                    v105 = a2.attacker
                                                    if typeof(v105) == "Instance" then
                                                        if v105:IsA("Player") then
                                                            v89 = v105.Character
                                                        elseif v105:IsA("Model") then
                                                            v89 = v105
                                                        else
                                                            v89 = nil
                                                        end
                                                    else
                                                        v89 = nil
                                                    end
                                                    if v106 ~= nil and v106 == char_5 then
                                                        local handler_upv_5
                                                        if not (u12) then
                                                            Hud_upv_1.Flash(Color3.fromRGB(150, 196, 236), 0.5, 0.25)
                                                            Hud_upv_1.Toast(((a2.ranged) and "DEFLECTED") or "PARRIED", Color3.fromRGB(170, 214, 245), 0.9)
                                                            Util_upv_1.Shake(0.25, 0.12)
                                                            local tbl_26 = {ranged = 0}
                                                            tbl_26.ranged = a2.ranged == true
                                                            emitView("Parried", tbl_26)
                                                            handler_upv_5 = tbl_upv_4.handler
                                                            if handler_upv_5 and type(handler_upv_5.ParryUsed) == "function" then
                                                                pcall(
                                                                    function()
                                                                        --[[
                                                                          line: 1172
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
                                                    if v89 == nil or v89 ~= char_5 or u12 then
                                                        return
                                                    end
                                                    if a2.staggered then
                                                        local v107 = nil
                                                        if not (u12) then
                                                            v107 = tbl_upv_4.handler
                                                            if v107 and type(v107.Interrupt) == "function" then
                                                                pcall(function() end)
                                                            end
                                                        end
                                                        Hud_upv_1.Toast("PARRIED \194\183 STAGGERED", Color3.fromRGB(255, 170, 90), (tonumber(a2.stagger) or 0.5) + 0.3)
                                                        Util_upv_1.Shake(0.4, 0.18)
                                                    else
                                                        Hud_upv_1.Toast("PARRIED", Color3.fromRGB(255, 170, 90), 0.9)
                                                    end
                                                elseif a1 ~= "TrapSnap" then
                                                    local v108, v109 = nil, nil
                                                    if a1 == "Hit" then
                                                        v108 = a2.target
                                                        local v91
                                                        if typeof(v108) == "Instance" then
                                                            if v108:IsA("Player") then
                                                                v91 = v108.Character
                                                            elseif v108:IsA("Model") then
                                                                v91 = v108
                                                            else
                                                                v91 = nil
                                                            end
                                                        else
                                                            v91 = nil
                                                        end
                                                        if typeof(a2.position) ~= "Vector3" then
                                                            v108 = nil
                                                        else
                                                            v108 = a2.position
                                                        end
                                                        v109 = a2.attacker
                                                        local v110
                                                        if typeof(v109) == "Instance" then
                                                            if v109:IsA("Player") then
                                                                v110 = v109.Character
                                                            elseif v109:IsA("Model") then
                                                                v110 = v109
                                                            else
                                                                v110 = nil
                                                            end
                                                        else
                                                            v110 = nil
                                                        end
                                                        if v110 == nil then
                                                            v109 = (v91 ~= nil) and (v91 == char_5)
                                                        else
                                                            v109 = true
                                                            if v110 ~= char_5 then
                                                                v109 = (v91 ~= nil) and (v91 == char_5)
                                                            end
                                                        end
                                                        local v111 = nil
                                                        if not (v109) then
                                                            v111 = (v108 ~= nil) and (Effects_upv_1.NEAR < Effects_upv_1.CamDistance(v108))
                                                            if v111 then
                                                                return
                                                            end
                                                        end
                                                        if a2.damageType ~= "Burn" and v91 ~= char_5 then
                                                            local HitFlash_1 = Effects_upv_1.HitFlash
                                                            local v112
                                                            if a2.blocked then
                                                                v112 = Color3.fromRGB(110, 190, 255)
                                                            else
                                                                v112 = nil
                                                            end
                                                            HitFlash_1(v91, v112)
                                                        end
                                                        if v108 and a2.damageType ~= "Burn" then
                                                            if typeof(a2.source) == "Vector3" and ((v108 - a2.source).Magnitude > 0.1) then
                                                                v109 = (v108 - a2.source).Unit
                                                            else
                                                                v109 = nil
                                                            end
                                                            local v113
                                                            if a2.blocked then
                                                                v113 = "blocked"
                                                            elseif a2.headshot or a2.crit then
                                                                v113 = "headshot"
                                                            else
                                                                v113 = "health"
                                                            end
                                                            local CharacterImpact_1 = Effects_upv_1.CharacterImpact
                                                            local v114 = true
                                                            if a2.headshot ~= true then
                                                                v114 = a2.killed == true
                                                            end
                                                            CharacterImpact_1(v108, v109, v114, v113)
                                                        end
                                                        if a2.blocked and v91 and v91 ~= char_5 then
                                                            Guard_upv_1.Impact(v91, false)
                                                            if a2.guardBroken and v108 then
                                                                Util_upv_1.Sound("Shield_Break", v108)
                                                            end
                                                        end
                                                        if v108 and a2.armor then
                                                            Effects_upv_1.ArmorHit(v108, a2.armorBroken == true)
                                                        end
                                                        if not v108 or v110 == char_5 or v91 == char_5 or a2.damageType ~= "Melee" then
                                                            return
                                                        end
                                                        Util_upv_1.Sound(Presentation_upv_1.For(a2.weaponId, Combat_upv_1.Kind(a2.weaponId) or "Sword").hitSound or "Hit_Melee", v108)
                                                    elseif a1 ~= "Death" then
                                                        if a1 ~= "Heal" then
                                                            if a1 ~= "Status" then
                                                                local v117 = nil
                                                                if a1 ~= "Charge" then
                                                                    local v118 = nil
                                                                    if a1 ~= "Reload" then
                                                                        local v119 = nil
                                                                        if a1 ~= "Block" then
                                                                            local v120 = nil
                                                                            if a1 ~= "Use" then
                                                                                local v121 = nil
                                                                                if a1 == "Equip" then
                                                                                    v121 = a2.attacker
                                                                                    local v91
                                                                                    if typeof(v121) == "Instance" then
                                                                                        if v121:IsA("Player") then
                                                                                            v91 = v121.Character
                                                                                        elseif v121:IsA("Model") then
                                                                                            v91 = v121
                                                                                        else
                                                                                            v91 = nil
                                                                                        end
                                                                                    else
                                                                                        v91 = nil
                                                                                    end
                                                                                    if not v91 or v91 == char_5 then
                                                                                        return
                                                                                    end
                                                                                    local v122 = Presentation_upv_1.For(a2.weaponId, Combat_upv_1.Kind(a2.weaponId) or "Sword")
                                                                                    local Sound_1 = Util_upv_1.Sound
                                                                                    local v123 = v122.equip or "Equip_Item"
                                                                                    local v124
                                                                                    if typeof(v91) == "Instance" then
                                                                                        if v91:IsA("Player") then
                                                                                            v124 = v91.Character
                                                                                        elseif v91:IsA("Model") then
                                                                                            v124 = v91
                                                                                        else
                                                                                            v124 = nil
                                                                                        end
                                                                                    else
                                                                                        v124 = nil
                                                                                    end
                                                                                    local v125 = v124 and (v124:FindFirstChild("HumanoidRootPart"))
                                                                                    local v126 = not (v125) or not (v125:IsA("BasePart")) or v125
                                                                                    Sound_1(v123, v126, {Volume = 0.7})
                                                                                elseif a1 == "Denied" then
                                                                                    local v127 = nil
                                                                                    if a2.reason ~= "NotEquipped" then
                                                                                        v127 = tbl_upv_4.handler
                                                                                        if v127 and type(v127.OnDenied) == "function" then
                                                                                            v127:OnDenied(a2.reason)
                                                                                        end
                                                                                        if a2.reason ~= "NoCharges" then
                                                                                            return
                                                                                        end
                                                                                        Hud_upv_1.Toast("NONE LEFT THIS ROUND", Color3.fromRGB(255, 120, 90))
                                                                                    else
                                                                                        tbl_upv_5.denied = tbl_upv_5.denied + 1
                                                                                        if u2 and u2.Parent == tbl_upv_4.char then
                                                                                            v121 = false
                                                                                            local v128 = LocalPlayer_upv_1:GetAttribute("EquipAck")
                                                                                            local v129
                                                                                            if type(v128) ~= "number" then
                                                                                                v129 = 0
                                                                                            else
                                                                                                v129 = v128
                                                                                            end
                                                                                            if v129 < u3 then
                                                                                                v121 = os.clock() - u4 < 4
                                                                                            end
                                                                                            if not (v121) then
                                                                                                u3 = u3 + 1
                                                                                                u6[u2] = u3
                                                                                                v121 = os.clock()
                                                                                                u4 = v121
                                                                                                tbl_upv_5.requests = tbl_upv_5.requests + 1
                                                                                                enforceWant()
                                                                                                local v130 = u2
                                                                                                if v130 and u1 then
                                                                                                    u5 = os.clock()
                                                                                                    send("Equip", {tool = v130, seq = u3})
                                                                                                end
                                                                                            end
                                                                                        end
                                                                                    end
                                                                                end
                                                                            else
                                                                                v120 = a2.attacker
                                                                                local v91
                                                                                if typeof(v120) == "Instance" then
                                                                                    if v120:IsA("Player") then
                                                                                        v91 = v120.Character
                                                                                    elseif v120:IsA("Model") then
                                                                                        v91 = v120
                                                                                    else
                                                                                        v91 = nil
                                                                                    end
                                                                                else
                                                                                    v91 = nil
                                                                                end
                                                                                if not v91 or v91 == char_5 then
                                                                                    return
                                                                                end
                                                                                local v131 = Combat_upv_1.Kind(a2.weaponId) or "Herbs"
                                                                                local v132 = Presentation_upv_1.For(a2.weaponId, v131)
                                                                                if v131 == "Trap" and not (Util_upv_1.IsTeammate(v91)) then
                                                                                    return
                                                                                end
                                                                                local Sound_2 = Util_upv_1.Sound
                                                                                local v133 = v132.useSound or "Bandage_Wrap"
                                                                                local v124
                                                                                if typeof(a2.position) ~= "Vector3" then
                                                                                    local v134
                                                                                    if typeof(v91) == "Instance" then
                                                                                        if v91:IsA("Player") then
                                                                                            v134 = v91.Character
                                                                                        elseif v91:IsA("Model") then
                                                                                            v134 = v91
                                                                                        else
                                                                                            v134 = nil
                                                                                        end
                                                                                    else
                                                                                        v134 = nil
                                                                                    end
                                                                                    local v135 = v134 and (v134:FindFirstChild("HumanoidRootPart"))
                                                                                    v124 = not (v135) or not (v135:IsA("BasePart")) or v135
                                                                                else
                                                                                    v124 = a2.position
                                                                                end
                                                                                Sound_2(v133, v124)
                                                                            end
                                                                        else
                                                                            v119 = a2.attacker
                                                                            local v91
                                                                            if typeof(v119) == "Instance" then
                                                                                if v119:IsA("Player") then
                                                                                    v91 = v119.Character
                                                                                elseif v119:IsA("Model") then
                                                                                    v91 = v119
                                                                                else
                                                                                    v91 = nil
                                                                                end
                                                                            else
                                                                                v91 = nil
                                                                            end
                                                                            if not v91 or v91 == char_5 or not a2.on then
                                                                                return
                                                                            end
                                                                            local v136 = os.clock()
                                                                            if not (v136 - (tbl_upv_25[v91] or -math.huge) >= 0.5) then
                                                                                return
                                                                            end
                                                                            tbl_upv_25[v91] = v136
                                                                            local Sound_3 = Util_upv_1.Sound
                                                                            local v137 = "Block_Up"
                                                                            local v124
                                                                            if typeof(v91) == "Instance" then
                                                                                if v91:IsA("Player") then
                                                                                    v124 = v91.Character
                                                                                elseif v91:IsA("Model") then
                                                                                    v124 = v91
                                                                                else
                                                                                    v124 = nil
                                                                                end
                                                                            else
                                                                                v124 = nil
                                                                            end
                                                                            local v138 = v124 and (v124:FindFirstChild("HumanoidRootPart"))
                                                                            local v95 = not (v138) or not (v138:IsA("BasePart")) or v138
                                                                            Sound_3(v137, v95)
                                                                        end
                                                                    else
                                                                        v118 = a2.attacker
                                                                        local u14
                                                                        if typeof(v118) == "Instance" then
                                                                            if v118:IsA("Player") then
                                                                                u14 = v118.Character
                                                                            elseif v118:IsA("Model") then
                                                                                u14 = v118
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
                                                                                  line: 1271
                                                                                  upvalues:
                                                                                    Util_upv_1 (copy, index: 1)
                                                                                    u15 (copy, index: 2)
                                                                                    u14 (copy, index: 3)
                                                                                ]]
                                                                                local Sound_4 = Util_upv_1.Sound
                                                                                local v139 = u15.reloadSound or "Crossbow_Reload"
                                                                                local v140
                                                                                if typeof(u14) == "Instance" then
                                                                                    if u14:IsA("Player") then
                                                                                        v140 = u14.Character
                                                                                    elseif u14:IsA("Model") then
                                                                                        v140 = u14
                                                                                    else
                                                                                        v140 = nil
                                                                                    end
                                                                                else
                                                                                    v140 = nil
                                                                                end
                                                                                local v141 = v140 and (v140:FindFirstChild("HumanoidRootPart"))
                                                                                local v142 = not (v141) or not (v141:IsA("BasePart")) or v141
                                                                                Sound_4(v139, v142)
                                                                            end
                                                                        )
                                                                    end
                                                                else
                                                                    v117 = a2.attacker
                                                                    local v91
                                                                    if typeof(v117) == "Instance" then
                                                                        if v117:IsA("Player") then
                                                                            v91 = v117.Character
                                                                        elseif v117:IsA("Model") then
                                                                            v91 = v117
                                                                        else
                                                                            v91 = nil
                                                                        end
                                                                    else
                                                                        v91 = nil
                                                                    end
                                                                    if not v91 or v91 == char_5 or not a2.on then
                                                                        return
                                                                    end
                                                                    local v143
                                                                    if typeof(v91) == "Instance" then
                                                                        if v91:IsA("Player") then
                                                                            v143 = v91.Character
                                                                        elseif v91:IsA("Model") then
                                                                            v143 = v91
                                                                        else
                                                                            v143 = nil
                                                                        end
                                                                    else
                                                                        v143 = nil
                                                                    end
                                                                    local v144 = v143 and (v143:FindFirstChild("HumanoidRootPart"))
                                                                    v89 = not (v144) or not (v144:IsA("BasePart")) or v144
                                                                    local v145 = Presentation_upv_1.For(a2.weaponId, Combat_upv_1.Kind(a2.weaponId))
                                                                    if a2.kind ~= "Draw" then
                                                                        if a2.kind ~= "Heavy" and a2.kind ~= "Lunge" then
                                                                            if a2.kind == "Throw" then
                                                                                Util_upv_1.Sound(v145.windupSound or "Throw_Windup", v89)
                                                                            end
                                                                            return
                                                                        end
                                                                        Util_upv_1.Sound(v145.chargeSound or "Charge_Up", v89)
                                                                    else
                                                                        Util_upv_1.Sound(v145.drawSound or "Bow_Draw", v89)
                                                                    end
                                                                end
                                                            else
                                                                local v116 = a2.target
                                                                local v91
                                                                if typeof(v116) == "Instance" then
                                                                    if v116:IsA("Player") then
                                                                        v91 = v116.Character
                                                                    elseif v116:IsA("Model") then
                                                                        v91 = v116
                                                                    else
                                                                        v91 = nil
                                                                    end
                                                                else
                                                                    v91 = nil
                                                                end
                                                                local v146
                                                                if typeof(v91) == "Instance" then
                                                                    if v91:IsA("Player") then
                                                                        v146 = v91.Character
                                                                    elseif v91:IsA("Model") then
                                                                        v146 = v91
                                                                    else
                                                                        v146 = nil
                                                                    end
                                                                else
                                                                    v146 = nil
                                                                end
                                                                local v147 = v146 and (v146:FindFirstChild("HumanoidRootPart"))
                                                                v116 = not (v147) or not (v147:IsA("BasePart")) or v147
                                                                if v91 == char_5 then
                                                                    if a2.status ~= "Caltrops" then
                                                                        Effects_upv_1.Status(v91, a2.status, tonumber(a2.duration) or 1)
                                                                        if (v91 ~= char_5 or a2.status ~= "Burn") and v91 == char_5 then
                                                                            if a2.status ~= "Snare" then
                                                                                return
                                                                            end
                                                                            Hud_upv_1.Toast("SNARED", Color3.fromRGB(226, 196, 140), 1.2)
                                                                        end
                                                                        Hud_upv_1.Toast("BURNING", Color3.fromRGB(255, 140, 60), 1)
                                                                    else
                                                                        if v91 and v91:IsA("Model") then
                                                                            Effects_upv_1.CaltropStep(v91)
                                                                        end
                                                                        if v91 == char_5 then
                                                                            Hud_upv_1.Toast("CALTROPS", Color3.fromRGB(214, 180, 140), 0.9)
                                                                        end
                                                                    end
                                                                end
                                                                if v116 then
                                                                    local Position_1 = v116.Position
                                                                    v146 = (Position_1 ~= nil) and (Effects_upv_1.NEAR < Effects_upv_1.CamDistance(Position_1))
                                                                    if not v146 then
                                                                        if a2.status ~= "Caltrops" then
                                                                            Effects_upv_1.Status(v91, a2.status, tonumber(a2.duration) or 1)
                                                                            if (v91 ~= char_5 or a2.status ~= "Burn") and v91 == char_5 then
                                                                                if a2.status ~= "Snare" then
                                                                                    return
                                                                                end
                                                                                Hud_upv_1.Toast("SNARED", Color3.fromRGB(226, 196, 140), 1.2)
                                                                            end
                                                                            Hud_upv_1.Toast("BURNING", Color3.fromRGB(255, 140, 60), 1)
                                                                        else
                                                                            if v91 and v91:IsA("Model") then
                                                                                Effects_upv_1.CaltropStep(v91)
                                                                            end
                                                                            if v91 ~= char_5 then
                                                                                return
                                                                            end
                                                                            Hud_upv_1.Toast("CALTROPS", Color3.fromRGB(214, 180, 140), 0.9)
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        else
                                                            local v115 = a2.target
                                                            local v91
                                                            if typeof(v115) == "Instance" then
                                                                if v115:IsA("Player") then
                                                                    v91 = v115.Character
                                                                elseif v115:IsA("Model") then
                                                                    v91 = v115
                                                                else
                                                                    v91 = nil
                                                                end
                                                            else
                                                                v91 = nil
                                                            end
                                                            local v148
                                                            if typeof(v91) == "Instance" then
                                                                if v91:IsA("Player") then
                                                                    v148 = v91.Character
                                                                elseif v91:IsA("Model") then
                                                                    v148 = v91
                                                                else
                                                                    v148 = nil
                                                                end
                                                            else
                                                                v148 = nil
                                                            end
                                                            local v149 = v148 and (v148:FindFirstChild("HumanoidRootPart"))
                                                            v115 = not (v149) or not (v149:IsA("BasePart")) or v149
                                                            if v91 ~= char_5 and v115 then
                                                                local Position_2 = v115.Position
                                                                v148 = (Position_2 ~= nil) and (Effects_upv_1.NEAR < Effects_upv_1.CamDistance(Position_2))
                                                                if (v148) then
                                                                    return
                                                                end
                                                                Effects_upv_1.Heal(v91, tonumber(a2.duration) or 3)
                                                            end
                                                            Effects_upv_1.Heal(v91, tonumber(a2.duration) or 3)
                                                        end
                                                    elseif typeof(a2.position) == "Vector3" then
                                                        local Death_1 = Effects_upv_1.Death
                                                        local position_1 = a2.position
                                                        v105 = false
                                                        local killer_1 = a2.killer
                                                        local v150
                                                        if typeof(killer_1) == "Instance" then
                                                            if killer_1:IsA("Player") then
                                                                v150 = killer_1.Character
                                                            elseif killer_1:IsA("Model") then
                                                                v150 = killer_1
                                                            else
                                                                v150 = nil
                                                            end
                                                        else
                                                            v150 = nil
                                                        end
                                                        if v150 == char_5 then
                                                            v105 = char_5 ~= nil
                                                        end
                                                        if type(a2.weaponId) ~= "string" then
                                                            v150 = nil
                                                        else
                                                            v150 = a2.weaponId
                                                        end
                                                        Death_1(position_1, v105, v150, a2.headshot == true)
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
                            local v150
                            if typeof(a2.position) ~= "Vector3" then
                                v150 = nil
                            else
                                v150 = a2.position
                            end
                            ChakramEnd_1(key_5, a2.caught == true, v150)
                        end
                    elseif type(a2.key) == "string" and typeof(a2.position) == "Vector3" then
                        Effects_upv_1.ChakramTurn(a2.key, a2.position)
                    end
                else
                    v100 = a2.attacker
                    local v91
                    if typeof(v100) == "Instance" then
                        if v100:IsA("Player") then
                            v91 = v100.Character
                        elseif v100:IsA("Model") then
                            v91 = v100
                        else
                            v91 = nil
                        end
                    else
                        v91 = nil
                    end
                    if typeof(a2.position) ~= "Vector3" then
                        v89 = nil
                    else
                        v89 = a2.position
                    end
                    if not v89 then
                        return
                    end
                    Util_upv_1.Sound("War_Horn", v89)
                    Effects_upv_1.HornBlast(v89)
                    if v91 == nil then
                        if v91 == nil or char_5 == nil or not Util_upv_1.IsEnemy(v91) then
                            return
                        end
                        Hud_upv_1.DamageFrom(v89, true, Color3.fromRGB(240, 180, 70), tonumber(a2.reveal) or 3)
                        Hud_upv_1.Toast("ENEMY HORN", Color3.fromRGB(240, 180, 70), 1.6)
                    else
                        if v91 ~= char_5 and not (Util_upv_1.IsTeammate(v91)) then
                            if v91 ~= nil and char_5 ~= nil and Util_upv_1.IsEnemy(v91) then
                                Hud_upv_1.DamageFrom(v89, true, Color3.fromRGB(240, 180, 70), tonumber(a2.reveal) or 3)
                                Hud_upv_1.Toast("ENEMY HORN", Color3.fromRGB(240, 180, 70), 1.6)
                            end
                            return
                        end
                        if type(a2.enemies) == "table" then
                            local v151 = nil
                            for _, value_11 in a2.enemies do
                                if typeof(value_11) == "Instance" then
                                    if value_11:IsA("Player") then
                                        v151 = value_11.Character
                                    elseif value_11:IsA("Model") then
                                        v151 = value_11
                                    else
                                        v151 = nil
                                    end
                                else
                                    v151 = nil
                                end
                                if v151 then
                                    Effects_upv_1.Reveal(v151, tonumber(a2.reveal) or 3)
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
                local v152 = tonumber(a2.duration) or 7
                Effects_upv_1.SmokeCloud(a2.position, tonumber(a2.radius) or 13, v152)
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
                    v152,
                    function()
                        --[[
                          line: 1071
                          upvalues:
                            u17 (copy, index: 1)
                            u16 (copy, index: 2)
                        ]]
                        pcall(u17, 1)
                        task.delay(
                            1.2,
                            function()
                                --[[
                                  line: 1073
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
        v89 = a2.attacker
        local v91
        if typeof(v89) == "Instance" then
            if v89:IsA("Player") then
                v91 = v89.Character
            elseif v89:IsA("Model") then
                v91 = v89
            else
                v91 = nil
            end
        else
            v91 = nil
        end
        if v91 and v91 ~= char_5 then
            local v153
            if typeof(v91) == "Instance" then
                if v91:IsA("Player") then
                    v153 = v91.Character
                elseif v91:IsA("Model") then
                    v153 = v91
                else
                    v153 = nil
                end
            else
                v153 = nil
            end
            local v154 = v153 and (v153:FindFirstChild("HumanoidRootPart"))
            v89 = not (v154) or not (v154:IsA("BasePart")) or v154
            if v89 then
                local Position_3 = v89.Position
                v153 = (Position_3 ~= nil) and (Effects_upv_1.NEAR < Effects_upv_1.CamDistance(Position_3))
                if not (v153) then
                    local v155 = Presentation_upv_1.For(a2.weaponId, Combat_upv_1.Kind(a2.weaponId) or "Fists")
                    if a2.heavy == true then
                        v153 = v155.heavySound or (v155.swingSound)
                    elseif a2.lunge ~= true then
                        v153 = v155.swingSound
                    else
                        v153 = v155.lungeSound or (v155.swingSound)
                    end
                    Util_upv_1.Sound(v153 or "Swing_Sword", v89)
                    if v155.trail and v155.trail > 0 and Quality_upv_1.layers then
                        local Trail_1 = Effects_upv_1.Trail
                        local v156 = (v91 and (v91:FindFirstChildOfClass("Tool"))) or nil
                        Trail_1(v156, v155.trail)
                    end
                    if v155.noSlash then
                        return
                    end
                    local Slash_1 = Effects_upv_1.Slash
                    local v157 = tonumber(a2.step) or 1
                    Slash_1(v91, v157, a2.heavy == true, v155.slashColor)
                    if a2.heavy == true then
                        Effects_upv_1.GroundScuff((v89.Position + (v89.CFrame.LookVector * 4)) - Vector3.new(0, 2.799999952316284, 0))
                    end
                end
            end
        end
    end
end
local function onInputBegan(a1, a2)
    --[[
      name: onInputBegan
      line: 758
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
    local v158 = mapInput(a1)
    if not v158 then
        return
    end
    if tbl_upv_4.handler and tbl_upv_4.hum ~= nil and (tbl_upv_4.hum.Health > 0) and tbl_upv_4.char ~= nil and tbl_upv_4.char.Parent ~= nil and not Util_upv_1.IsMouseUnlocked() and (not Keybinds_upv_1.PadBlocked() or not (#Keybinds_upv_1.PadActionsOf(a1) > 0)) then
        tbl_upv_4.pressed[v158] = true
        handlerInput(v158, true)
    end
end
local function drawTool(a1, a2)
    --[[
      name: drawTool
      line: 649
      upvalues:
        tbl_upv_4 (copy, index: 1)
        backpack (copy, index: 2)
    ]]
    local v159 = nil
    local tbl_27 = {tbl_upv_4.char, backpack()}
    for _, value_12 in tbl_27 do
        if not (value_12) then
            continue
        end
        for v163, value_13 in value_12:GetChildren() do
            local v160 = (value_13 ~= nil) and (value_13:IsA("Tool") and (type(value_13:GetAttribute("WeaponId")) == "string"))
            if not (v160) or value_13:GetAttribute("DrawToken") ~= a2 then
                continue
            end
            if (type(a1) ~= "string" or value_13:GetAttribute("Slot") ~= a1) and (type(a1) ~= "number" or value_13:GetAttribute("SlotIndex") ~= a1) then
                local v161 = value_13:GetAttribute("SlotIndex")
                local v162 = v159 and (v159:GetAttribute("SlotIndex"))
                if not (v159) then
                    v159 = value_13
                    continue
                end
                if type(v161) ~= "number" or type(v162) ~= "number" then
                    continue
                end
                if v161 < v162 then
                    v159 = value_13
                    continue
                end
            end
            return value_13
        end
    end
    return v159
end
function tbl_upv_3.Start()
    --[[
      name: Start
      line: 1321
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
              line: 1327
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
    local v163 = Net_upv_1.Event("HitConfirm")
    local v164 = Net_upv_1.Event("DamageTaken")
    local v165 = Net_upv_1.Event("CombatFX")
    tbl_upv_4.shotId = math.floor((workspace:GetServerTimeNow() % 1e+05) * 10)
    Hud_upv_1.Init()
    Guard_upv_1.Init()
    Poses_upv_1.Init()
    World_upv_1.Init()
    Quality_upv_1.Start()
    Touch_upv_1.Start(dispatch)
    v163.OnClientEvent:Connect(
        function(a3)
            --[[
              line: 1346
              upvalues:
                onHitConfirm (copy, index: 1)
            ]]
            local success_4, v166 = pcall(onHitConfirm, a3)
            if (success_4) then
                return
            end
            warn("[Combat] HitConfirm error:", v166)
        end
    )
    v164.OnClientEvent:Connect(
        function(a4)
            --[[
              line: 1352
              upvalues:
                onDamageTaken (copy, index: 1)
            ]]
            local success_5, v167 = pcall(onDamageTaken, a4)
            if (success_5) then
                return
            end
            warn("[Combat] DamageTaken error:", v167)
        end
    )
    local function fx(a5, a6)
        --[[
          name: fx
          line: 1358
          upvalues:
            onCombatFX (copy, index: 1)
            Metrics_upv_1 (copy, index: 2)
        ]]
        local v168 = os.clock()
        local success_6, v169 = pcall(onCombatFX, a5, a6)
        local AddFx_1 = Metrics_upv_1.AddFx
        local v170 = os.clock() - v168
        local v171
        if type(a5) ~= "string" then
            v171 = nil
        else
            v171 = a5
        end
        AddFx_1(v170, v171)
        if (success_6) then
            return
        end
        warn("[Combat] CombatFX error:", a5, v169)
    end
    v165.OnClientEvent:Connect(fx)
    u19 = fx
    u18 = true
    local v172 = Net_upv_1.Event("AnimRelay")
    Util_upv_1.SetAnimRelay(v172)
    v172.OnClientEvent:Connect(
        function(a7, a8, a9, a10, a11, a12)
            --[[
              line: 1374
              upvalues:
                tbl_upv_4 (copy, index: 1)
                Util_upv_1 (copy, index: 2)
            ]]
            if typeof(a7) ~= "Instance" or not a7:IsA("Model") or a7 == tbl_upv_4.char then
                return
            end
            if type(a9) == "string" then
                local v173 = a7:FindFirstChildOfClass("Humanoid")
                local v174 = v173 and (v173:FindFirstChildOfClass("Animator"))
                if v174 and a7:IsDescendantOf(workspace) then
                    local v175
                    if type(a10) ~= "number" then
                        v175 = 1
                    else
                        v175 = a10
                    end
                    if a8 == "Play" then
                        Util_upv_1.PlayAnim(v173, a9, v175, tonumber(a11), (tonumber(a12)))
                    elseif a8 == "Hold" then
                        Util_upv_1.PlayHold(v173, a9, v175)
                    elseif a8 == "Stop" then
                        Util_upv_1.StopAnim(v173, a9, (tonumber(a11)))
                    end
                    return
                end
            end
        end
    )
    local tbl_upv_28 = {}
    task.spawn(
        function()
            --[[
              line: 1395
              upvalues:
                Players_upv_1 (copy, index: 1)
                LocalPlayer_upv_1 (copy, index: 2)
                Combat_upv_1 (copy, index: 3)
                Presentation_upv_1 (copy, index: 4)
                tbl_upv_28 (copy, index: 5)
                Util_upv_1 (copy, index: 6)
            ]]
            task.wait(0.5)
            local CurrentCamera_1 = workspace.CurrentCamera
            local v176 = ((not CurrentCamera_1) and Vector3.new(0, 0, 0)) or (CurrentCamera_1.CFrame.Position)
            local v177 = nil
            for _, value_14 in Players_upv_1:GetPlayers() do
                local Character_1 = value_14.Character
                if value_14 == LocalPlayer_upv_1 or not (Character_1) then
                    continue
                end
                v177 = Character_1:FindFirstChild("HumanoidRootPart")
                local v178 = Character_1:FindFirstChildOfClass("Humanoid")
                local v179 = v178 and (v178:FindFirstChildOfClass("Animator"))
                if not (v177) then
                    continue
                end
                local v180 = v177:IsA("BasePart")
                if not (v180) or not (v179) or (v177.Position - v176).Magnitude > 160 then
                    continue
                end
                v177 = (Character_1 and (Character_1:FindFirstChildOfClass("Tool"))) or nil
                v180 = v177 and (v177:GetAttribute("WeaponId"))
                if type(v180) ~= "string" or not (v178.Health > 0) then
                    v177 = nil
                    v180 = tbl_upv_28[Character_1]
                    if v180 then
                        if v180 ~= v177 then
                            Util_upv_1.StopAnim(v178, v180, 0.15)
                            tbl_upv_28[Character_1] = nil
                        end
                        if not (v177) then
                            continue
                        end
                        v180 = Util_upv_1.GetTrack(v178, v177)
                        if not (v180) then
                            tbl_upv_28[Character_1] = v177
                            continue
                        end
                        if not (v180.IsPlaying) then
                            Util_upv_1.PlayAnim(v178, v177, 1, 0.2)
                        end
                    else
                        if not (v177) then
                            continue
                        end
                        v180 = Util_upv_1.GetTrack(v178, v177)
                        if not (v181) then
                            tbl_upv_28[Character_1] = v177
                            continue
                        end
                        if not (v181.IsPlaying) then
                            Util_upv_1.PlayAnim(v178, v177, 1, 0.2)
                        end
                    end
                    tbl_upv_28[Character_1] = v177
                end
                v177 = Presentation_upv_1.For(v180, Combat_upv_1.Kind(v180)).hold
                v180 = tbl_upv_28[Character_1]
                if v180 and v180 ~= v177 then
                    Util_upv_1.StopAnim(v178, v180, 0.15)
                    tbl_upv_28[Character_1] = nil
                end
                if not (v177) then
                    continue
                end
                v180 = Util_upv_1.GetTrack(v178, v177)
                if not (v180) then
                    tbl_upv_28[Character_1] = v177
                    continue
                end
                if not (v180.IsPlaying) then
                    Util_upv_1.PlayAnim(v178, v177, 1, 0.2)
                end
                tbl_upv_28[Character_1] = v177
            end
            for key_6 in tbl_upv_28 do
                if not (key_6.Parent) then
                    tbl_upv_28[key_6] = nil
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
              line: 1440
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
                local v182 = LocalPlayer_upv_1:GetAttribute("EquipAck")
                local v183
                if type(v182) ~= "number" then
                    v183 = 0
                else
                    v183 = v182
                end
                if (u3 <= v183) then
                    return
                end
                if u20 ~= u3 then
                    local v184 = os.clock()
                    if v184 - u4 >= 4 then
                        u20 = u3
                        if u10 then
                            return
                        end
                        u10 = true
                        task.defer(
                            function()
                                --[[
                                  line: 541
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
                    elseif v184 - u5 >= 1 and u2 and (tbl_upv_4.hum ~= nil) and ((tbl_upv_4.hum.Health > 0) and ((tbl_upv_4.char ~= nil) and (tbl_upv_4.char.Parent ~= nil))) then
                        tbl_upv_5.resent = tbl_upv_5.resent + 1
                        local v185 = u2
                        if v185 and u1 then
                            u5 = os.clock()
                            send("Equip", {tool = v185, seq = u3})
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
              line: 1458
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
                local v186, v187 = pcall(
                    function()
                        --[[
                          line: 1467
                          upvalues:
                            handler_upv_6 (copy, index: 1)
                            a13 (copy, index: 2)
                        ]]
                        handler_upv_6:Update(a13)
                    end
                )
                if not (v186) then
                    warn("[Combat] update error:", v187)
                end
            end
            local v188 = not Util_upv_1.CanAct()
            local v186 = nil
            if v188 ~= u21 then
                u21 = v188
                Hud_upv_1.SetFrozen(v188)
                if v188 then
                    if not (u12) then
                        v186 = tbl_upv_4.handler
                        if v186 and type(v186.Interrupt) == "function" then
                            pcall(
                                function()
                                    --[[
                                      line: 812
                                      upvalues:
                                        v186 (copy, index: 1)
                                    ]]
                                    v186:Interrupt()
                                end
                            )
                        end
                    end
                end
            end
            local v189 = LocalPlayer_upv_1:GetAttribute("CombatMode")
            if v189 ~= nil then
                v186 = v189 == true
            else
                local v190 = LocalPlayer_upv_1:GetAttribute("State") == "Match"
                v186 = v190
            end
            v189 = not Util_upv_1.IsMouseUnlocked() and (LocalPlayer_upv_1:GetAttribute("MenuOpen") ~= true)
            local SetVisible_1 = Hud_upv_1.SetVisible
            local v191 = v189
            if v191 then
                v191 = (tbl_upv_4.hum ~= nil) and ((tbl_upv_4.hum.Health > 0) and ((tbl_upv_4.char ~= nil) and (tbl_upv_4.char.Parent ~= nil)))
                if v191 then
                    v191 = v186
                end
            end
            SetVisible_1(v191)
            Touch_upv_1.SetVisible(v189 and v186)
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
                  line: 680
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
                local v192 = os.clock()
                local v193 = -math.huge
                local v194, v195, v195 = nil, nil, nil
                while os.clock() - v192 < 10 do
                    if LocalPlayer_upv_1:GetAttribute("CombatDrawToken") ~= u22 then
                        return
                    end
                    local v196 = LocalPlayer_upv_1:GetAttribute("CombatDrawSlot")
                    if v196 == 0 then
                        return
                    end
                    local char_6 = tbl_upv_4.char
                    local hum_4 = tbl_upv_4.hum
                    if not (char_6) or not (hum_4) or not (hum_4.Health > 0) or char_6 ~= LocalPlayer_upv_1.Character then
                        task.wait(0.1)
                        continue
                    end
                    local v197 = char_6:IsDescendantOf(workspace)
                    if not (v197) then
                        task.wait(0.1)
                        continue
                    end
                    local v198 = char_6:FindFirstChildOfClass("Tool")
                    v194 = false
                    if v198 ~= nil then
                        v194 = (v198 ~= nil) and (v198:IsA("Tool") and (type(v198:GetAttribute("WeaponId")) == "string"))
                        if v194 then
                            v194 = v198:GetAttribute("DrawToken") == u22
                        end
                    end
                    if v194 then
                        local v199 = false
                        local v200 = LocalPlayer_upv_1:GetAttribute("EquipAck")
                        if type(v200) ~= "number" then
                            v195 = 0
                        else
                            v195 = v200
                        end
                        if v195 < u3 then
                            if os.clock() - u4 < 4 then
                                v199 = true
                            else
                                v199 = false
                            end
                        end
                        if v199 then
                            if v194 then
                                task.wait(0.1)
                                continue
                            end
                            if type(v196) == "number" or type(v196) == "string" then
                                v195 = v196
                                local v201 = drawTool(v196, u22)
                                if v201 then
                                    tbl_upv_3.Equip(v201)
                                end
                                task.wait(0.1)
                            end
                            v195 = 1
                            local v201 = drawTool(v196, u22)
                            if v201 then
                                tbl_upv_3.Equip(v201)
                            end
                            task.wait(0.1)
                        else
                            local v202 = LocalPlayer_upv_1:GetAttribute("EquipSlot")
                            if type(v202) ~= "number" or not (v202 > 0) then
                                if os.clock() - v193 > 0.5 then
                                    v193 = os.clock()
                                    u2 = v198
                                    u3 = u3 + 1
                                    u6[v198] = u3
                                    u4 = os.clock()
                                    tbl_upv_5.requests = tbl_upv_5.requests + 1
                                    enforceWant()
                                    v199 = u2
                                    if v199 and u1 then
                                        u5 = os.clock()
                                        send("Equip", {tool = v199, seq = u3})
                                    end
                                end
                                if v194 then
                                    task.wait(0.1)
                                    continue
                                end
                                if type(v196) == "number" or type(v196) == "string" then
                                    v195 = v196
                                    local v201 = drawTool(v196, u22)
                                    if v201 then
                                        tbl_upv_3.Equip(v201)
                                    end
                                    task.wait(0.1)
                                end
                                v195 = 1
                                local v201 = drawTool(v196, u22)
                                if v201 then
                                    tbl_upv_3.Equip(v201)
                                end
                                task.wait(0.1)
                            end
                            return
                        end
                    else
                        if v194 then
                            task.wait(0.1)
                            continue
                        end
                        if type(v196) == "number" or type(v196) == "string" then
                            v195 = v196
                            local v201 = drawTool(v196, u22)
                            if v201 then
                                tbl_upv_3.Equip(v201)
                            end
                            task.wait(0.1)
                        end
                        v195 = 1
                        local v201 = drawTool(v195, u22)
                        if v201 then
                            tbl_upv_3.Equip(v201)
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
                  line: 1497
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
              line: 1503
              upvalues:
                LocalPlayer_upv_1 (copy, index: 1)
                u8 (ref,  index: 2)
                Util_upv_1 (copy, index: 3)
                tbl_upv_3 (copy, index: 4)
                tbl_upv_1 (copy, index: 5)
                setSpeed (copy, index: 6)
            ]]
            local v203 = LocalPlayer_upv_1:WaitForChild("PlayerScripts"):WaitForChild("Core", 30)
            local v204 = v203 and (v203:WaitForChild("InputStats", 30))
            if not v204 then
                return
            end
            if v204:IsA("ModuleScript") then
                local v205 = require(v204)
                u8 = v205
                v205.Watch(Util_upv_1, 512)
                v205.Watch(tbl_upv_3, 1024)
                for _, value_17 in tbl_upv_1 do
                    v205.Watch(value_17, 1024)
                end
                for _, value_18 in {Util_upv_1.Recoil, Util_upv_1.Shake, Util_upv_1.RecoilSlow, Util_upv_1.AimDirection, tbl_upv_1.Melee.Detect, setSpeed} do
                    v205.Hooked(value_18)
                end
            end
        end
    )
end
function tbl_upv_3.PlayFX(a1, a2)
    --[[
      name: PlayFX
      line: 1524
      upvalues:
        onCombatFX (copy, index: 1)
    ]]
    local success_7, v206 = pcall(onCombatFX, a1, a2)
    if (success_7) then
        return
    end
    warn("[Combat] replay FX error:", a1, v206)
end
function tbl_upv_3.SetReplayHud(a1)
    --[[
      name: SetReplayHud
      line: 1534
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
      line: 1548
      upvalues:
        onHitConfirm (copy, index: 1)
    ]]
    local success_8, v207 = pcall(onHitConfirm, a1)
    if (success_8) then
        return
    end
    warn("[Combat] replay HitConfirm error:", v207)
end
function tbl_upv_3.ReplayDamageTaken(a1)
    --[[
      name: ReplayDamageTaken
      line: 1555
      upvalues:
        onDamageTaken (copy, index: 1)
    ]]
    local success_9, v208 = pcall(onDamageTaken, a1)
    if (success_9) then
        return
    end
    warn("[Combat] replay DamageTaken error:", v208)
end
function tbl_upv_3.State()
    --[[
      name: State
      line: 1563
      upvalues:
        u2 (ref,  index: 7)
        tbl_upv_4 (copy, index: 8)
        u3 (ref,  index: 9)
        LocalPlayer_upv_1 (copy, index: 10)
        u4 (ref,  index: 11)
        tbl_upv_5 (copy, index: 12)
        tbl_upv_22 (copy, index: 13)
    ]]
    local v209 = u2
    local tbl_29 = {inputs = 0, equipStats = 0, shotId = 0, equipSeq = 0, equipPending = 0, equipAck = 0, lastInput = 0, speed = 0, tool = 0, wantSlot = 0}
    tbl_29.kind = tbl_upv_4.kind
    local v210, v211
    if tbl_upv_4.hum then
        v210 = tbl_upv_4.hum.WalkSpeed
        v211 = tbl_upv_4
    else
        v210, v211 = nil, tbl_upv_4
    end
    tbl_29.speed = v210
    tbl_29.shotId = v211.shotId
    tbl_29.tool = ((tbl_upv_4.tool) and (v211.tool.Name)) or nil
    tbl_29.wantSlot = not v209 and 0 or u2:GetAttribute("SlotIndex")
    tbl_29.equipSeq = u3
    local v213 = LocalPlayer_upv_1:GetAttribute("EquipAck")
    local v214
    if type(v213) ~= "number" then
        v214 = 0
    else
        v214 = v213
    end
    tbl_29.equipAck = v214
    local v215 = false
    local v216 = LocalPlayer_upv_1:GetAttribute("EquipAck")
    local v217
    if type(v216) ~= "number" then
        v217 = 0
    else
        v217 = v216
    end
    if v217 < u3 then
        v215 = os.clock() - u4 < 4
    end
    tbl_29.equipPending = v215
    tbl_29.equipStats = table.clone(tbl_upv_5)
    tbl_29.inputs = tbl_upv_22.n
    tbl_29.lastInput = tbl_upv_22.last
    return tbl_29
end
return tbl_upv_3