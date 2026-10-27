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
local function send(a1, a2)
    --[[
      name: send
      line: 144
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
local tbl_upv_6 = {Charge = "Charge", Use = "Use", Throw = "Charge", Draw = "Charge", Block = "Block", Reload = "Reload", Aim = "Aim"}
local function applySpeed()
    --[[
      name: applySpeed
      line: 175
      upvalues:
        tbl_upv_4 (copy, index: 1)
        tbl_upv_6 (copy, index: 2)
        Simulation_upv_1 (copy, index: 3)
    ]]
    local tbl_7 = {Charge = false, Use = false, Block = false, Reload = false, Aim = false}
    for key_1 in tbl_upv_4.speed do
        local v3 = tbl_upv_6[key_1]
        if v3 then
            tbl_7[v3] = true
        end
    end
    for key_2, value_1 in tbl_7 do
        Simulation_upv_1.SetInput(key_2, value_1)
    end
end
local tbl_upv_8 = {}
function tbl_upv_3.OnViewEvent(a1)
    --[[
      name: OnViewEvent
      line: 206
      upvalues:
        tbl_upv_8 (copy, index: 1)
    ]]
    table.insert(tbl_upv_8, a1)
    return function()
        --[[
          line: 208
          upvalues:
            tbl_upv_8 (copy, index: 1)
            a1 (copy, index: 2)
        ]]
        local v4 = table.find(tbl_upv_8, a1)
        if not v4 then
            return
        end
        table.remove(tbl_upv_8, v4)
    end
end
local function presetFor(a1, a2)
    --[[
      name: presetFor
      line: 216
      upvalues:
        Presentation_upv_1 (copy, index: 1)
    ]]
    return Presentation_upv_1.For(a2, a1)
end
local function modelOf(a1)
    --[[
      name: modelOf
      line: 220
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
      line: 233
    ]]
    local v5
    if typeof(a1) == "Instance" then
        if a1:IsA("Player") then
            v5 = a1.Character
        elseif a1:IsA("Model") then
            v5 = a1
        else
            v5 = nil
        end
    else
        v5 = nil
    end
    local v6 = v5 and (v5:FindFirstChild("HumanoidRootPart"))
    if v6 and v6:IsA("BasePart") then
        return v6
    end
    return nil
end
local function toolOf(a1)
    --[[
      name: toolOf
      line: 239
    ]]
    local v7 = (a1 and (a1:FindFirstChildOfClass("Tool"))) or nil
    return v7
end
local function isFar(a1)
    --[[
      name: isFar
      line: 243
      upvalues:
        Effects_upv_1 (copy, index: 1)
    ]]
    local v8 = (a1 ~= nil) and (Effects_upv_1.NEAR < Effects_upv_1.CamDistance(a1))
    return v8
end
local function dropHandler()
    --[[
      name: dropHandler
      line: 264
      upvalues:
        tbl_upv_4 (copy, index: 1)
        applySpeed (copy, index: 2)
    ]]
    local handler_upv_1 = tbl_upv_4.handler
    if handler_upv_1 then
        tbl_upv_4.handler = nil
        pcall(
            function()
                --[[
                  line: 268
                  upvalues:
                    handler_upv_1 (copy, index: 1)
                ]]
                handler_upv_1:Unequip()
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
      line: 164
      upvalues:
        tbl_upv_4 (copy, index: 1)
    ]]
    tbl_upv_4.shotId = tbl_upv_4.shotId + 1
    return tbl_upv_4.shotId
end
local function emitView(a1, a2)
    --[[
      name: emitView
      line: 196
      upvalues:
        tbl_upv_8 (copy, index: 1)
    ]]
    for _, value_2 in tbl_upv_8 do
        local success_1, v9 = pcall(value_2, a1, a2)
        if not (success_1) then
            warn("[Combat] view event listener error:", v9)
        end
    end
end
local function setSpeed(a1, a2)
    --[[
      name: setSpeed
      line: 188
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
      line: 277
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
        local v10 = LocalPlayer_upv_1:GetAttribute("CombatMode")
        local v11
        if v10 ~= nil then
            v11 = v10 == true
        else
            v11 = LocalPlayer_upv_1:GetAttribute("State") == "Match"
        end
        if v11 then
            local v12
            if (u2) and u2.Parent == char_1 then
                v12 = u2
            else
                v12 = char_1:FindFirstChildOfClass("Tool")
            end
            if v12 == tbl_upv_4.tool and tbl_upv_4.handler then
                return
            end
            dropHandler()
            tbl_upv_4.tool = v12
            v10 = Combat_upv_1.FISTS_ID
            local v13 = nil
            if v12 then
                v13 = v12:GetAttribute("WeaponId")
                if type(v13) == "string" and Weapons_upv_1.Get(v13) then
                    v10 = v13
                    local v14 = Weapons_upv_1.Get(v10)
                    local v15 = Combat_upv_1.Tuning(v10)
                    local v16 = Combat_upv_1.Kind(v10) or "Fists"
                    tbl_upv_4.kind = v16
                    tbl_upv_4.baseSpeed = v15.speedMult or 1
                    applySpeed()
                    local v17 = tbl_upv_1[tbl_upv_2[v16] or ""]
                    if v17 then
                        local u9 = v17.new({player = LocalPlayer_upv_1, char = char_1, hum = tbl_upv_4.hum, root = tbl_upv_4.root, animator = tbl_upv_4.animator, tool = v12, weaponId = v10, def = v14, tuning = v15, kind = v16, preset = Presentation_upv_1.For(v10, v16), send = send, nextId = nextId, setSpeed = setSpeed, alive = alive, emit = emitView})
                        tbl_upv_4.handler = u9
                        Hud_upv_1.SetPips(0, 0)
                        Hud_upv_1.SetArc(nil)
                        local SetWeapon_1 = Touch_upv_1.SetWeapon
                        local v18
                        if v12 then
                            v18 = v16
                        else
                            v18 = nil
                        end
                        SetWeapon_1(v18, v15)
                        local success_2, v19 = pcall(
                            function()
                                --[[
                                  line: 339
                                  upvalues:
                                    u9 (copy, index: 1)
                                ]]
                                u9:Equip()
                            end
                        )
                        if not (success_2) then
                            warn("[Combat] equip error:", v19)
                        end
                        local v20 = Util_upv_1.GuardRecovery(v12)
                        if v20 > 0 then
                            Hud_upv_1.SetArc(v20, Color3.fromRGB(150, 196, 236))
                        end
                    else
                        Hud_upv_1.SetStyle("Dot")
                    end
                    return
                end
                Hud_upv_1.SetStyle("Dot")
                return
            end
            local v14 = Weapons_upv_1.Get(v10)
            local v15 = Combat_upv_1.Tuning(v10)
            local v16 = Combat_upv_1.Kind(v10) or "Fists"
            tbl_upv_4.kind = v16
            tbl_upv_4.baseSpeed = v15.speedMult or 1
            applySpeed()
            local v17 = tbl_upv_1[tbl_upv_2[v16] or ""]
            if v17 then
                local u9 = v17.new({player = LocalPlayer_upv_1, char = char_1, hum = tbl_upv_4.hum, root = tbl_upv_4.root, animator = tbl_upv_4.animator, tool = v12, weaponId = v10, def = v14, tuning = v15, kind = v16, preset = Presentation_upv_1.For(v10, v16), send = send, nextId = nextId, setSpeed = setSpeed, alive = alive, emit = emitView})
                tbl_upv_4.handler = u9
                Hud_upv_1.SetPips(0, 0)
                Hud_upv_1.SetArc(nil)
                local SetWeapon_1 = Touch_upv_1.SetWeapon
                local v18
                if v12 then
                    v18 = v16
                else
                    v18 = nil
                end
                SetWeapon_1(v18, v15)
                local success_2, v19 = pcall(
                    function()
                        --[[
                          line: 339
                          upvalues:
                            u9 (copy, index: 1)
                        ]]
                        u9:Equip()
                    end
                )
                if not (success_2) then
                    warn("[Combat] equip error:", v19)
                end
                local v20 = Util_upv_1.GuardRecovery(v12)
                if v20 > 0 then
                    Hud_upv_1.SetArc(v20, Color3.fromRGB(150, 196, 236))
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
      line: 354
    ]]
    local v21 = (a1 ~= nil) and (a1:IsA("Tool") and (type(a1:GetAttribute("WeaponId")) == "string"))
    return v21
end
local function acked()
    --[[
      name: acked
      line: 377
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local v22 = LocalPlayer_upv_1:GetAttribute("EquipAck")
    if type(v22) ~= "number" then
        return 0
    end
    return v22
end
local function equipPending()
    --[[
      name: equipPending
      line: 383
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        u3 (ref,  index: 2)
        u4 (ref,  index: 3)
    ]]
    local v23 = false
    local v24 = LocalPlayer_upv_1:GetAttribute("EquipAck")
    local v25
    if type(v24) ~= "number" then
        v25 = 0
    else
        v25 = v24
    end
    if v25 < u3 then
        v23 = os.clock() - u4 < 4
    end
    return v23
end
local function backpack()
    --[[
      name: backpack
      line: 361
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local v26 = LocalPlayer_upv_1:GetAttribute("CombatDrawToken")
    local v27 = nil
    for _, value_3 in LocalPlayer_upv_1:GetChildren() do
        local v28 = value_3:IsA("Backpack")
        if not (v28) then
            continue
        end
        v27 = v27 or value_3
        for v29, value_4 in value_3:GetChildren() do
            if value_4:GetAttribute("DrawToken") ~= v26 then
                continue
            end
            return value_3
        end
    end
    return v27
end
local function enforceWant()
    --[[
      name: enforceWant
      line: 401
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
    local v29 = backpack()
    if u2.Parent ~= char_2 and u2.Parent ~= v29 then
        u2 = nil
        return
    end
    if u2.Parent ~= char_2 then
        hum_1:EquipTool(u2)
    end
    if not v29 then
        return
    end
    for _, value_5 in char_2:GetChildren() do
        if value_5 == u2 then
            continue
        end
        local v30 = (value_5 ~= nil) and (value_5:IsA("Tool") and (type(value_5:GetAttribute("WeaponId")) == "string"))
        if v30 then
            value_5.Parent = v29
        end
    end
end
local function sendEquip()
    --[[
      name: sendEquip
      line: 423
      upvalues:
        u2 (ref,  index: 1)
        u1 (ref,  index: 2)
        u5 (ref,  index: 3)
        send (copy, index: 4)
        u3 (ref,  index: 5)
    ]]
    local v31 = u2
    if not v31 or not u1 then
        return
    end
    u5 = os.clock()
    send("Equip", {tool = v31, seq = u3})
end
local function requestEquip(a1)
    --[[
      name: requestEquip
      line: 432
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
    local v32 = u2
    if not v32 or not u1 then
        return
    end
    u5 = os.clock()
    send("Equip", {tool = v32, seq = u3})
end
local function toolInSlot(a1)
    --[[
      name: toolInSlot
      line: 387
      upvalues:
        tbl_upv_4 (copy, index: 1)
        backpack (copy, index: 2)
    ]]
    local tbl_9 = {tbl_upv_4.char, backpack()}
    for _, value_6 in tbl_9 do
        if not (value_6) then
            continue
        end
        for v34, value_7 in value_6:GetChildren() do
            local v33 = (value_7 ~= nil) and (value_7:IsA("Tool") and (type(value_7:GetAttribute("WeaponId")) == "string"))
            if not (v33) or value_7:GetAttribute("SlotIndex") ~= a1 then
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
      line: 443
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
        local v34 = backpack()
        if u2 and u2.Parent ~= char_3 and u2.Parent ~= v34 then
            u2 = nil
        end
        local v35 = false
        local v36 = LocalPlayer_upv_1:GetAttribute("EquipAck")
        local v37
        if type(v36) ~= "number" then
            v37 = 0
        else
            v37 = v36
        end
        if v37 < u3 then
            v35 = os.clock() - u4 < 4
        end
        if v35 then
            enforceWant()
        else
            local v38 = LocalPlayer_upv_1:GetAttribute("EquipSlot")
            if type(v38) == "number" and (v38 > 0) then
                v35 = toolInSlot(v38)
            else
                v35 = nil
            end
            if v35 then
                if u2 ~= v35 then
                    if u2 ~= nil then
                        tbl_upv_5.adopted = tbl_upv_5.adopted + 1
                    end
                    u2 = v35
                    u6[v35] = u6[v35] or u3
                end
                enforceWant()
            elseif u2 and os.clock() - u7 > 2 then
                u7 = os.clock()
                tbl_upv_5.reasked = tbl_upv_5.reasked + 1
                local v40 = u2
                u2 = v40
                u3 = u3 + 1
                u6[v40] = u3
                u4 = os.clock()
                tbl_upv_5.requests = tbl_upv_5.requests + 1
                enforceWant()
                local v41 = u2
                if v41 and u1 then
                    u5 = os.clock()
                    send("Equip", {tool = v41, seq = u3})
                end
            end
        end
    end
end
local u10 = false
local function queueReconcile()
    --[[
      name: queueReconcile
      line: 477
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
      line: 493
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
        local v42 = (a1 ~= nil) and (a1:IsA("Tool") and (type(a1:GetAttribute("WeaponId")) == "string"))
        if not v42 then
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
      line: 503
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
        local v43 = (a1 ~= nil) and (a1:IsA("Tool") and (type(a1:GetAttribute("WeaponId")) == "string"))
        if v43 then
            local v44 = backpack()
            if a1.Parent ~= char_4 and a1.Parent ~= v44 then
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
            local v45 = u2
            if v45 and u1 then
                u5 = os.clock()
                send("Equip", {tool = v45, seq = u3})
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
      line: 521
      upvalues:
        u2 (ref, index: 1)
    ]]
    return u2
end
local function onCharacter(a1)
    --[[
      name: onCharacter
      line: 525
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
    local v46 = a1:WaitForChild("Humanoid", 10)
    local v47 = a1:WaitForChild("HumanoidRootPart", 10)
    if not v46 then
        return
    end
    if v47 then
        tbl_upv_4.hum = v46
        tbl_upv_4.root = v47
        v47 = v46:FindFirstChildOfClass("Animator") or (v46:WaitForChild("Animator", 5))
        tbl_upv_4.animator = not (v47) or not (v47:IsA("Animator")) or v47
        if tbl_upv_4.animator then
            task.spawn(Util_upv_1.Preload, tbl_upv_4.animator)
        end
        table.insert(
            tbl_upv_4.conns,
            a1.ChildAdded:Connect(
                function(a2)
                    --[[
                      line: 551
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
                        local v49 = nil
                        if u1 then
                            v49 = (a2 ~= nil) and (a2:IsA("Tool") and (type(a2:GetAttribute("WeaponId")) == "string"))
                            if v49 and a2 ~= u2 and a2.Parent == tbl_upv_4.char then
                                local v50 = (a2 ~= nil) and (a2:IsA("Tool") and (type(a2:GetAttribute("WeaponId")) == "string"))
                                if v50 then
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
                      line: 560
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
            v46.Died:Connect(
                function()
                    --[[
                      line: 568
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
        v47 = a1:FindFirstChildOfClass("Tool")
        if v47 and u1 then
            local v51 = (v47 ~= nil) and (v47:IsA("Tool") and (type(v47:GetAttribute("WeaponId")) == "string"))
            if v51 and v47 ~= u2 and v47.Parent == tbl_upv_4.char then
                local v52 = (v47 ~= nil) and (v47:IsA("Tool") and (type(v47:GetAttribute("WeaponId")) == "string"))
                if v52 then
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
      line: 615
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        u11 (ref,  index: 2)
    ]]
    local v53 = LocalPlayer_upv_1:GetAttribute("CombatDrawToken")
    if type(v53) ~= "number" or v53 == u11 then
        return
    end
    u11 = v53
    task.spawn(function() end)
end
local tbl_upv_10 = {Reload = "Reload", Aim = "Secondary", Attack = "Primary"}
local tbl_upv_11 = {last = "", n = 0}
local function mapInput(a1)
    --[[
      name: mapInput
      line: 663
      upvalues:
        Keybinds_upv_1 (copy, index: 1)
        tbl_upv_10 (copy, index: 2)
    ]]
    local v54 = nil
    for _, value_9 in Keybinds_upv_1.PadActionsOf(a1) do
        v54 = tbl_upv_10[value_9]
        if not (v54) then
            continue
        end
        return v54
    end
    local UserInputType_1 = a1.UserInputType
    if UserInputType_1 ~= Enum.UserInputType.Keyboard and UserInputType_1 ~= Enum.UserInputType.MouseButton1 and UserInputType_1 ~= Enum.UserInputType.MouseButton2 and UserInputType_1 ~= Enum.UserInputType.MouseButton3 then
        return nil
    end
    local v55 = Keybinds_upv_1.ActionOf(a1)
    if v55 then
        return tbl_upv_10[v55]
    end
    return nil
end
local function handlerInput(a1, a2)
    --[[
      name: handlerInput
      line: 684
      upvalues:
        tbl_upv_4 (copy, index: 1)
        tbl_upv_11 (copy, index: 2)
    ]]
    local handler_upv_2 = tbl_upv_4.handler
    if not handler_upv_2 then
        return
    end
    tbl_upv_11.n = tbl_upv_11.n + 1
    tbl_upv_11.last = a1 .. ((a2 and "+") or "-")
    local success_3, v56 = pcall(
        function()
            --[[
              line: 691
              upvalues:
                handler_upv_2 (copy, index: 1)
                a1 (copy, index: 2)
                a2 (copy, index: 3)
            ]]
            handler_upv_2:Input(a1, a2)
        end
    )
    if (success_3) then
        return
    end
    warn("[Combat] input error:", v56)
end
local function onInputEnded(a1, a2)
    --[[
      name: onInputEnded
      line: 714
      upvalues:
        mapInput (copy, index: 1)
        tbl_upv_4 (copy, index: 2)
        handlerInput (copy, index: 3)
    ]]
    local v57 = mapInput(a1)
    if not v57 or not tbl_upv_4.pressed[v57] then
        return
    end
    tbl_upv_4.pressed[v57] = nil
    handlerInput(v57, false)
end
local function dispatch(a1, a2)
    --[[
      name: dispatch
      line: 724
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
      line: 747
      upvalues:
        u12 (ref,  index: 1)
        tbl_upv_4 (copy, index: 2)
    ]]
    if u12 then
        return
    end
    local handler_3 = tbl_upv_4.handler
    if not handler_3 then
        return
    end
    if type(handler_3.Interrupt) == "function" then
        pcall(function() end)
    end
end
local u13 = 0
local function nameOf(a1)
    --[[
      name: nameOf
      line: 247
      upvalues:
        Players_upv_1 (copy, index: 1)
    ]]
    if not a1 then
        return nil
    end
    local v58 = a1:GetAttribute("DisplayName")
    if type(v58) == "string" and v58 ~= "" then
        return v58
    end
    local v59 = Players_upv_1:GetPlayerFromCharacter(a1)
    if v59 then
        return v59.DisplayName
    elseif a1:HasTag("TrainingDummy") then
        return "Dummy"
    else
        return a1.Name
    end
end
local function onHitConfirm(a1)
    --[[
      name: onHitConfirm
      line: 763
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
    local v60
    if typeof(a1.position) ~= "Vector3" then
        v60 = nil
    else
        v60 = a1.position
    end
    local v61 = tonumber(a1.amount) or 0
    local v62 = true
    if a1.headshot ~= true then
        v62 = a1.crit == true
    end
    local victim_1 = a1.victim
    local v63 = tonumber(a1.armor) or 0
    if a1.armorBroken then
        Util_upv_1.Sound("Shield_Break")
    end
    if v60 and v61 > 0 then
        local v64
        if a1.dot then
            v64 = "dot"
        elseif a1.killed then
            v64 = "kill"
        elseif v62 then
            v64 = "crit"
        elseif a1.blocked then
            v64 = "blocked"
        elseif (v63 > 0) and (v61 - v63 < 0.5) then
            v64 = "armor"
        else
            v64 = "health"
        end
        local v65 = a1.dot or ((a1.headshot) and "HEADSHOT") or (((a1.crit) and "BACKSTAB") or (((a1.blocked) and "BLOCKED") or (((a1.armorBroken) and "ARMOR BROKEN") or nil)))
        Hud_upv_1.DamageNumber(v60, v61, v64, victim_1, v65)
    end
    if a1.dot then
        return
    end
    local v66 = Effects_upv_1.ConsumePrediction(victim_1)
    local v67 = os.clock()
    local v68 = Combat_upv_1.Kind(a1.weaponId)
    local v69 = Combat_upv_1.IsMelee(v68)
    local v70 = nil
    if a1.killed then
        Hud_upv_1.Hitmarker("kill")
        Util_upv_1.Sound(((a1.headshot) and "Kill_Confirm_Headshot") or "Kill_Confirm")
        tbl_upv_4.killStreak = ((v67 - tbl_upv_4.lastKillAt <= 4) and (tbl_upv_4.killStreak + 1)) or 1
        tbl_upv_4.lastKillAt = v67
        v70 = nameOf(victim_1)
        local v71
        if v70 then
            v71 = string.upper(v70)
        else
            v71 = nil
        end
        if tbl_upv_4.killStreak >= 2 then
            local v72 = ((tbl_upv_4.killStreak ~= 2) and "TRIPLE ELIMINATION") or "DOUBLE ELIMINATION"
            local v73
            if (v71) and (a1.headshot) then
                v73 = ("%* \194\183 %*"):format(v71, Loc_upv_1.T("HEADSHOT"))
            elseif v71 then
                v73 = v71
            elseif a1.headshot then
                v73 = Loc_upv_1.T("HEADSHOT")
            else
                v73 = nil
            end
            Hud_upv_1.KillBanner(v72, v73)
        else
            local KillBanner_1 = Hud_upv_1.KillBanner
            local v74 = ((not v71) and "ELIMINATED") or (("ELIMINATED %*"):format(v71))
            local v75
            if a1.headshot then
                v75 = Loc_upv_1.T("HEADSHOT")
            else
                v75 = nil
            end
            KillBanner_1(v74, v75)
        end
        Util_upv_1.Shake(0.35, 0.18)
    else
        Hud_upv_1.Hitmarker((v62 and "crit") or "hit")
        if a1.headshot then
            Util_upv_1.Sound("Hitmarker_Headshot")
        elseif a1.crit then
            Util_upv_1.Sound(Presentation_upv_1.For(a1.weaponId, v68).critSound or "Hitmarker_Crit")
        elseif v67 - u13 > 0.06 then
            u13 = v67
            Util_upv_1.Sound((v69 and "Hitmarker") or "Hitmarker_Ranged")
        end
    end
    if not v60 or not v69 or v66 then
        return
    end
    Util_upv_1.Sound(Presentation_upv_1.For(a1.weaponId, v68).hitSound or "Hit_Melee", v60)
end
local function onDamageTaken(a1)
    --[[
      name: onDamageTaken
      line: 834
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
    local v76 = tonumber(a1.amount) or 0
    local fromPosition_1 = a1.fromPosition
    if a1.damageType ~= "Burn" then
        if a1.damageType ~= "World" and a1.weaponId ~= "ring" then
            if a1.damageType ~= "Sting" then
                if typeof(fromPosition_1) == "Vector3" then
                    Hud_upv_1.DamageFrom(fromPosition_1, v76 >= 40)
                end
                local v77 = tonumber(a1.armor) or 0
                if not (u12) then
                    local tbl_12 = {blocked = 0}
                    tbl_12.amount = v76
                    tbl_12.blocked = a1.blocked == true
                    emitView("Hurt", tbl_12)
                end
                if a1.interrupted then
                    local v78 = nil
                    if not (u12) then
                        v78 = tbl_upv_4.handler
                        if v78 and type(v78.Interrupt) == "function" then
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
                    local v79 = nil
                    if not (u12) then
                        v79 = tbl_upv_4.handler
                        if v79 and type(v79.Interrupt) == "function" then
                            pcall(function() end)
                        end
                    end
                    Util_upv_1.Sound("Shield_Break")
                    Hud_upv_1.Toast("SHIELD BROKEN", Color3.fromRGB(110, 190, 255), 1.3)
                end
                if a1.blocked then
                    Hud_upv_1.Hurt(math.min(0.35, v76 / 60), Color3.fromRGB(110, 190, 255))
                    Hud_upv_1.BlockPulse()
                    if not (u12) then
                        Guard_upv_1.Impact(tbl_upv_4.char, true)
                    end
                elseif (v77 > 0) and (v76 - v77 < 0.5) then
                    Hud_upv_1.Hurt(math.min(0.3, v76 / 70), Color3.fromRGB(170, 185, 205))
                    Util_upv_1.Shake(math.clamp(v76 / 70, 0.15, 0.6), 0.2)
                    Util_upv_1.Sound("Impact_Metal")
                else
                    Hud_upv_1.Hurt(v76 / 35, nil)
                    Util_upv_1.Shake(math.clamp(v76 / 45, 0.2, 1.1), 0.28)
                    Util_upv_1.Recoil(math.clamp(v76 / 12, 0.5, 4), (math.random() - 0.5) * 3)
                    Util_upv_1.Sound(((v76 >= 30) and "Damage_Receive_Heavy") or "Damage_Receive")
                end
                if type(a1.stagger) == "number" and a1.stagger > 0 then
                    local v80 = nil
                    if not (u12) then
                        v80 = tbl_upv_4.handler
                        if v80 and type(v80.Interrupt) == "function" then
                            pcall(function() end)
                        end
                    end
                    Hud_upv_1.Toast("STAGGERED", Color3.fromRGB(255, 170, 90), a1.stagger + 0.2)
                end
                if a1.damageType == "Trap" then
                    local v81 = nil
                    if not (u12) then
                        v81 = tbl_upv_4.handler
                        if v81 and type(v81.Interrupt) == "function" then
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
                    local v82 = nil
                    if not (u12) then
                        v82 = tbl_upv_4.handler
                        if v82 and type(v82.Interrupt) == "function" then
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
local tbl_upv_13 = {}
local tbl_upv_14 = {}
task.spawn(
    function()
        --[[
          line: 911
          upvalues:
            tbl_upv_13 (copy, index: 1)
            tbl_upv_14 (copy, index: 2)
        ]]
        task.wait(10)
        for key_3 in tbl_upv_13 do
            if not (key_3.Parent) then
                tbl_upv_13[key_3] = nil
            end
        end
        for key_4 in tbl_upv_14 do
            if not (key_4.Parent) then
                tbl_upv_14[key_4] = nil
            end
        end
    end
)
local function onCombatFX(a1, a2)
    --[[
      name: onCombatFX
      line: 927
      upvalues:
        tbl_upv_4 (copy, index: 1)
        Effects_upv_1 (copy, index: 2)
        Combat_upv_1 (copy, index: 3)
        Presentation_upv_1 (copy, index: 4)
        Util_upv_1 (copy, index: 5)
        Quality_upv_1 (copy, index: 6)
        Poses_upv_1 (copy, index: 7)
        tbl_upv_13 (copy, index: 8)
        Hud_upv_1 (copy, index: 9)
        RankFx_upv_1 (copy, index: 10)
        u12 (ref,  index: 11)
        emitView (copy, index: 12)
        Guard_upv_1 (copy, index: 13)
        tbl_upv_14 (copy, index: 14)
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
    local v83 = nil
    if a1 ~= "Swing" then
        local v84 = nil
        if a1 == "Projectile" then
            v84 = a2.shooter
            local v85
            if typeof(v84) == "Instance" then
                if v84:IsA("Player") then
                    v85 = v84.Character
                elseif v84:IsA("Model") then
                    v85 = v84
                else
                    v85 = nil
                end
            else
                v85 = nil
            end
            if v85 and v85 == char_5 and a2.deflected ~= true then
                return
            end
            if typeof(a2.origin) == "Vector3" and typeof(a2.velocity) == "Vector3" and type(a2.key) == "string" then
                local v86 = tonumber(a2.gravity) or 0
                local num_1 = tonumber(a2.pellets)
                if (num_1) and (num_1 > 1) then
                    local velocity_1 = a2.velocity
                    Effects_upv_1.Pellets(a2.key, a2.kind, a2.origin, velocity_1.Unit, velocity_1.Magnitude, v86, num_1, tonumber(a2.spread) or 6, tonumber(a2.seed) or 0, v85)
                else
                    Effects_upv_1.Projectile(a2.key, a2.kind, a2.origin, a2.velocity, v86, v85)
                end
                local v87 = Combat_upv_1.Kind(a2.weaponId)
                local v88 = Presentation_upv_1.For(a2.weaponId, v87 or "Bow")
                local origin_1 = a2.origin
                local v89 = (origin_1 ~= nil) and (Effects_upv_1.NEAR < Effects_upv_1.CamDistance(origin_1))
                local v90 = not v89
                if v90 and (v88.flash or v88.puff) then
                    local Muzzle_1 = Effects_upv_1.Muzzle
                    local v91 = CFrame.lookAt(a2.origin, a2.origin + a2.velocity)
                    local v92
                    if v87 ~= "Pistol" then
                        v92 = true
                    else
                        v92 = false
                    end
                    Muzzle_1(v91, v92, v88.puff ~= false)
                end
                if v85 and v88.kick then
                    Poses_upv_1.Kick(v85, v88.kick * 5)
                end
                v87 = os.clock()
                local v93 = v85 or workspace
                if not (v87 - (tbl_upv_13[v93] or 0) > 0.08) then
                    return
                end
                tbl_upv_13[v93] = v87
                if not v90 and not v88.flash then
                    return
                end
                Util_upv_1.Sound(v88.fireSound or (v88.throwSound or "Bow_Release"), a2.origin)
            end
        elseif a1 == "ProjectileHit" then
            Effects_upv_1.ResolveProjectile(a2)
        elseif a1 ~= "Explosion" then
            if a1 ~= "Smoke" then
                local v94 = nil
                if a1 ~= "Horn" then
                    local v95 = nil
                    if a1 == "Chakram" then
                        v95 = a2.shooter
                        local v85
                        if typeof(v95) == "Instance" then
                            if v95:IsA("Player") then
                                v85 = v95.Character
                            elseif v95:IsA("Model") then
                                v85 = v95
                            else
                                v85 = nil
                            end
                        else
                            v85 = nil
                        end
                        if v85 ~= char_5 and typeof(a2.origin) == "Vector3" and typeof(a2.dir) == "Vector3" and type(a2.key) == "string" then
                            Effects_upv_1.Chakram(a2.key, a2.origin, a2.dir, tonumber(a2.speed) or 110, tonumber(a2.range) or 45, tonumber(a2.catch) or 4.5, v85)
                            local origin_2 = a2.origin
                            local v96 = (origin_2 ~= nil) and (Effects_upv_1.NEAR < Effects_upv_1.CamDistance(origin_2))
                            if v96 then
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
                                            local v97 = nil
                                            if a1 == "CaltropsEnd" then
                                                v97 = tonumber(a2.id)
                                                if not v97 then
                                                    return
                                                end
                                                Effects_upv_1.CaltropsEnd(v97)
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
                                                local v98, v99 = nil, nil
                                                if a1 == "Parry" then
                                                    RankFx_upv_1.Parried(a2)
                                                    v98 = a2.target
                                                    local v100
                                                    if typeof(v98) == "Instance" then
                                                        if v98:IsA("Player") then
                                                            v100 = v98.Character
                                                        elseif v98:IsA("Model") then
                                                            v100 = v98
                                                        else
                                                            v100 = nil
                                                        end
                                                    else
                                                        v100 = nil
                                                    end
                                                    v99 = a2.attacker
                                                    if typeof(v99) == "Instance" then
                                                        if v99:IsA("Player") then
                                                            v83 = v99.Character
                                                        elseif v99:IsA("Model") then
                                                            v83 = v99
                                                        else
                                                            v83 = nil
                                                        end
                                                    else
                                                        v83 = nil
                                                    end
                                                    if v100 ~= nil and v100 == char_5 then
                                                        local handler_upv_4
                                                        if not (u12) then
                                                            Hud_upv_1.Flash(Color3.fromRGB(150, 196, 236), 0.5, 0.25)
                                                            Hud_upv_1.Toast(((a2.ranged) and "DEFLECTED") or "PARRIED", Color3.fromRGB(170, 214, 245), 0.9)
                                                            Util_upv_1.Shake(0.25, 0.12)
                                                            local tbl_15 = {ranged = 0}
                                                            tbl_15.ranged = a2.ranged == true
                                                            emitView("Parried", tbl_15)
                                                            handler_upv_4 = tbl_upv_4.handler
                                                            if handler_upv_4 and type(handler_upv_4.ParryUsed) == "function" then
                                                                pcall(
                                                                    function()
                                                                        --[[
                                                                          line: 1113
                                                                          upvalues:
                                                                            handler_upv_4 (copy, index: 1)
                                                                        ]]
                                                                        handler_upv_4:ParryUsed()
                                                                    end
                                                                )
                                                            end
                                                            return
                                                        end
                                                    end
                                                    if v83 == nil or v83 ~= char_5 or u12 then
                                                        return
                                                    end
                                                    if a2.staggered then
                                                        local v101 = nil
                                                        if not (u12) then
                                                            v101 = tbl_upv_4.handler
                                                            if v101 and type(v101.Interrupt) == "function" then
                                                                pcall(function() end)
                                                            end
                                                        end
                                                        Hud_upv_1.Toast("PARRIED \194\183 STAGGERED", Color3.fromRGB(255, 170, 90), (tonumber(a2.stagger) or 0.5) + 0.3)
                                                        Util_upv_1.Shake(0.4, 0.18)
                                                    else
                                                        Hud_upv_1.Toast("PARRIED", Color3.fromRGB(255, 170, 90), 0.9)
                                                    end
                                                elseif a1 ~= "TrapSnap" then
                                                    local v102, v103 = nil, nil
                                                    if a1 == "Hit" then
                                                        v102 = a2.target
                                                        local v85
                                                        if typeof(v102) == "Instance" then
                                                            if v102:IsA("Player") then
                                                                v85 = v102.Character
                                                            elseif v102:IsA("Model") then
                                                                v85 = v102
                                                            else
                                                                v85 = nil
                                                            end
                                                        else
                                                            v85 = nil
                                                        end
                                                        if typeof(a2.position) ~= "Vector3" then
                                                            v102 = nil
                                                        else
                                                            v102 = a2.position
                                                        end
                                                        v103 = a2.attacker
                                                        local v104
                                                        if typeof(v103) == "Instance" then
                                                            if v103:IsA("Player") then
                                                                v104 = v103.Character
                                                            elseif v103:IsA("Model") then
                                                                v104 = v103
                                                            else
                                                                v104 = nil
                                                            end
                                                        else
                                                            v104 = nil
                                                        end
                                                        if v104 == nil then
                                                            v103 = (v85 ~= nil) and (v85 == char_5)
                                                        else
                                                            v103 = true
                                                            if v104 ~= char_5 then
                                                                v103 = (v85 ~= nil) and (v85 == char_5)
                                                            end
                                                        end
                                                        local v105 = nil
                                                        if not (v103) then
                                                            v105 = (v102 ~= nil) and (Effects_upv_1.NEAR < Effects_upv_1.CamDistance(v102))
                                                            if v105 then
                                                                return
                                                            end
                                                        end
                                                        if a2.damageType ~= "Burn" and v85 ~= char_5 then
                                                            local HitFlash_1 = Effects_upv_1.HitFlash
                                                            local v106
                                                            if a2.blocked then
                                                                v106 = Color3.fromRGB(110, 190, 255)
                                                            else
                                                                v106 = nil
                                                            end
                                                            HitFlash_1(v85, v106)
                                                        end
                                                        if v102 and a2.damageType ~= "Burn" then
                                                            if typeof(a2.source) == "Vector3" and ((v102 - a2.source).Magnitude > 0.1) then
                                                                v103 = (v102 - a2.source).Unit
                                                            else
                                                                v103 = nil
                                                            end
                                                            local v107
                                                            if a2.blocked then
                                                                v107 = "blocked"
                                                            elseif a2.headshot or a2.crit then
                                                                v107 = "headshot"
                                                            else
                                                                v107 = "health"
                                                            end
                                                            local CharacterImpact_1 = Effects_upv_1.CharacterImpact
                                                            local v108 = true
                                                            if a2.headshot ~= true then
                                                                v108 = a2.killed == true
                                                            end
                                                            CharacterImpact_1(v102, v103, v108, v107)
                                                        end
                                                        if a2.blocked and v85 and v85 ~= char_5 then
                                                            Guard_upv_1.Impact(v85, false)
                                                            if a2.guardBroken and v102 then
                                                                Util_upv_1.Sound("Shield_Break", v102)
                                                            end
                                                        end
                                                        if v102 and a2.armor then
                                                            Effects_upv_1.ArmorHit(v102, a2.armorBroken == true)
                                                        end
                                                        if not v102 or v104 == char_5 or v85 == char_5 or a2.damageType ~= "Melee" then
                                                            return
                                                        end
                                                        Util_upv_1.Sound(Presentation_upv_1.For(a2.weaponId, Combat_upv_1.Kind(a2.weaponId) or "Sword").hitSound or "Hit_Melee", v102)
                                                    elseif a1 ~= "Death" then
                                                        if a1 ~= "Heal" then
                                                            if a1 ~= "Status" then
                                                                local v111 = nil
                                                                if a1 ~= "Charge" then
                                                                    local v112 = nil
                                                                    if a1 ~= "Reload" then
                                                                        local v113 = nil
                                                                        if a1 ~= "Block" then
                                                                            local v114 = nil
                                                                            if a1 ~= "Use" then
                                                                                local v115 = nil
                                                                                if a1 == "Equip" then
                                                                                    v115 = a2.attacker
                                                                                    local v85
                                                                                    if typeof(v115) == "Instance" then
                                                                                        if v115:IsA("Player") then
                                                                                            v85 = v115.Character
                                                                                        elseif v115:IsA("Model") then
                                                                                            v85 = v115
                                                                                        else
                                                                                            v85 = nil
                                                                                        end
                                                                                    else
                                                                                        v85 = nil
                                                                                    end
                                                                                    if not v85 or v85 == char_5 then
                                                                                        return
                                                                                    end
                                                                                    local v116 = Presentation_upv_1.For(a2.weaponId, Combat_upv_1.Kind(a2.weaponId) or "Sword")
                                                                                    local Sound_1 = Util_upv_1.Sound
                                                                                    local v117 = v116.equip or "Equip_Item"
                                                                                    local v118
                                                                                    if typeof(v85) == "Instance" then
                                                                                        if v85:IsA("Player") then
                                                                                            v118 = v85.Character
                                                                                        elseif v85:IsA("Model") then
                                                                                            v118 = v85
                                                                                        else
                                                                                            v118 = nil
                                                                                        end
                                                                                    else
                                                                                        v118 = nil
                                                                                    end
                                                                                    local v119 = v118 and (v118:FindFirstChild("HumanoidRootPart"))
                                                                                    local v120 = not (v119) or not (v119:IsA("BasePart")) or v119
                                                                                    Sound_1(v117, v120, {Volume = 0.7})
                                                                                elseif a1 == "Denied" then
                                                                                    local v121 = nil
                                                                                    if a2.reason ~= "NotEquipped" then
                                                                                        v121 = tbl_upv_4.handler
                                                                                        if v121 and type(v121.OnDenied) == "function" then
                                                                                            v121:OnDenied(a2.reason)
                                                                                        end
                                                                                        if a2.reason ~= "NoCharges" then
                                                                                            return
                                                                                        end
                                                                                        Hud_upv_1.Toast("NONE LEFT THIS ROUND", Color3.fromRGB(255, 120, 90))
                                                                                    else
                                                                                        tbl_upv_5.denied = tbl_upv_5.denied + 1
                                                                                        if u2 and u2.Parent == tbl_upv_4.char then
                                                                                            v115 = false
                                                                                            local v122 = LocalPlayer_upv_1:GetAttribute("EquipAck")
                                                                                            local v123
                                                                                            if type(v122) ~= "number" then
                                                                                                v123 = 0
                                                                                            else
                                                                                                v123 = v122
                                                                                            end
                                                                                            if v123 < u3 then
                                                                                                v115 = os.clock() - u4 < 4
                                                                                            end
                                                                                            if not (v115) then
                                                                                                u3 = u3 + 1
                                                                                                u6[u2] = u3
                                                                                                v115 = os.clock()
                                                                                                u4 = v115
                                                                                                tbl_upv_5.requests = tbl_upv_5.requests + 1
                                                                                                enforceWant()
                                                                                                local v124 = u2
                                                                                                if v124 and u1 then
                                                                                                    u5 = os.clock()
                                                                                                    send("Equip", {tool = v124, seq = u3})
                                                                                                end
                                                                                            end
                                                                                        end
                                                                                    end
                                                                                end
                                                                            else
                                                                                v114 = a2.attacker
                                                                                local v85
                                                                                if typeof(v114) == "Instance" then
                                                                                    if v114:IsA("Player") then
                                                                                        v85 = v114.Character
                                                                                    elseif v114:IsA("Model") then
                                                                                        v85 = v114
                                                                                    else
                                                                                        v85 = nil
                                                                                    end
                                                                                else
                                                                                    v85 = nil
                                                                                end
                                                                                if not v85 or v85 == char_5 then
                                                                                    return
                                                                                end
                                                                                local v125 = Combat_upv_1.Kind(a2.weaponId) or "Herbs"
                                                                                local v126 = Presentation_upv_1.For(a2.weaponId, v125)
                                                                                if v125 == "Trap" and not (Util_upv_1.IsTeammate(v85)) then
                                                                                    return
                                                                                end
                                                                                local Sound_2 = Util_upv_1.Sound
                                                                                local v127 = v126.useSound or "Bandage_Wrap"
                                                                                local v118
                                                                                if typeof(a2.position) ~= "Vector3" then
                                                                                    local v128
                                                                                    if typeof(v85) == "Instance" then
                                                                                        if v85:IsA("Player") then
                                                                                            v128 = v85.Character
                                                                                        elseif v85:IsA("Model") then
                                                                                            v128 = v85
                                                                                        else
                                                                                            v128 = nil
                                                                                        end
                                                                                    else
                                                                                        v128 = nil
                                                                                    end
                                                                                    local v129 = v128 and (v128:FindFirstChild("HumanoidRootPart"))
                                                                                    v118 = not (v129) or not (v129:IsA("BasePart")) or v129
                                                                                else
                                                                                    v118 = a2.position
                                                                                end
                                                                                Sound_2(v127, v118)
                                                                            end
                                                                        else
                                                                            v113 = a2.attacker
                                                                            local v85
                                                                            if typeof(v113) == "Instance" then
                                                                                if v113:IsA("Player") then
                                                                                    v85 = v113.Character
                                                                                elseif v113:IsA("Model") then
                                                                                    v85 = v113
                                                                                else
                                                                                    v85 = nil
                                                                                end
                                                                            else
                                                                                v85 = nil
                                                                            end
                                                                            if not v85 or v85 == char_5 or not a2.on then
                                                                                return
                                                                            end
                                                                            local v130 = os.clock()
                                                                            if not (v130 - (tbl_upv_14[v85] or -math.huge) >= 0.5) then
                                                                                return
                                                                            end
                                                                            tbl_upv_14[v85] = v130
                                                                            local Sound_3 = Util_upv_1.Sound
                                                                            local v131 = "Block_Up"
                                                                            local v118
                                                                            if typeof(v85) == "Instance" then
                                                                                if v85:IsA("Player") then
                                                                                    v118 = v85.Character
                                                                                elseif v85:IsA("Model") then
                                                                                    v118 = v85
                                                                                else
                                                                                    v118 = nil
                                                                                end
                                                                            else
                                                                                v118 = nil
                                                                            end
                                                                            local v132 = v118 and (v118:FindFirstChild("HumanoidRootPart"))
                                                                            local v89 = not (v132) or not (v132:IsA("BasePart")) or v132
                                                                            Sound_3(v131, v89)
                                                                        end
                                                                    else
                                                                        v112 = a2.attacker
                                                                        local u14
                                                                        if typeof(v112) == "Instance" then
                                                                            if v112:IsA("Player") then
                                                                                u14 = v112.Character
                                                                            elseif v112:IsA("Model") then
                                                                                u14 = v112
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
                                                                                  line: 1212
                                                                                  upvalues:
                                                                                    Util_upv_1 (copy, index: 1)
                                                                                    u15 (copy, index: 2)
                                                                                    u14 (copy, index: 3)
                                                                                ]]
                                                                                local Sound_4 = Util_upv_1.Sound
                                                                                local v133 = u15.reloadSound or "Crossbow_Reload"
                                                                                local v134
                                                                                if typeof(u14) == "Instance" then
                                                                                    if u14:IsA("Player") then
                                                                                        v134 = u14.Character
                                                                                    elseif u14:IsA("Model") then
                                                                                        v134 = u14
                                                                                    else
                                                                                        v134 = nil
                                                                                    end
                                                                                else
                                                                                    v134 = nil
                                                                                end
                                                                                local v135 = v134 and (v134:FindFirstChild("HumanoidRootPart"))
                                                                                local v136 = not (v135) or not (v135:IsA("BasePart")) or v135
                                                                                Sound_4(v133, v136)
                                                                            end
                                                                        )
                                                                    end
                                                                else
                                                                    v111 = a2.attacker
                                                                    local v85
                                                                    if typeof(v111) == "Instance" then
                                                                        if v111:IsA("Player") then
                                                                            v85 = v111.Character
                                                                        elseif v111:IsA("Model") then
                                                                            v85 = v111
                                                                        else
                                                                            v85 = nil
                                                                        end
                                                                    else
                                                                        v85 = nil
                                                                    end
                                                                    if not v85 or v85 == char_5 or not a2.on then
                                                                        return
                                                                    end
                                                                    local v137
                                                                    if typeof(v85) == "Instance" then
                                                                        if v85:IsA("Player") then
                                                                            v137 = v85.Character
                                                                        elseif v85:IsA("Model") then
                                                                            v137 = v85
                                                                        else
                                                                            v137 = nil
                                                                        end
                                                                    else
                                                                        v137 = nil
                                                                    end
                                                                    local v138 = v137 and (v137:FindFirstChild("HumanoidRootPart"))
                                                                    v83 = not (v138) or not (v138:IsA("BasePart")) or v138
                                                                    local v139 = Presentation_upv_1.For(a2.weaponId, Combat_upv_1.Kind(a2.weaponId))
                                                                    if a2.kind ~= "Draw" then
                                                                        if a2.kind ~= "Heavy" and a2.kind ~= "Lunge" then
                                                                            if a2.kind == "Throw" then
                                                                                Util_upv_1.Sound(v139.windupSound or "Throw_Windup", v83)
                                                                            end
                                                                            return
                                                                        end
                                                                        Util_upv_1.Sound(v139.chargeSound or "Charge_Up", v83)
                                                                    else
                                                                        Util_upv_1.Sound(v139.drawSound or "Bow_Draw", v83)
                                                                    end
                                                                end
                                                            else
                                                                local v110 = a2.target
                                                                local v85
                                                                if typeof(v110) == "Instance" then
                                                                    if v110:IsA("Player") then
                                                                        v85 = v110.Character
                                                                    elseif v110:IsA("Model") then
                                                                        v85 = v110
                                                                    else
                                                                        v85 = nil
                                                                    end
                                                                else
                                                                    v85 = nil
                                                                end
                                                                local v140
                                                                if typeof(v85) == "Instance" then
                                                                    if v85:IsA("Player") then
                                                                        v140 = v85.Character
                                                                    elseif v85:IsA("Model") then
                                                                        v140 = v85
                                                                    else
                                                                        v140 = nil
                                                                    end
                                                                else
                                                                    v140 = nil
                                                                end
                                                                local v141 = v140 and (v140:FindFirstChild("HumanoidRootPart"))
                                                                v110 = not (v141) or not (v141:IsA("BasePart")) or v141
                                                                if v85 == char_5 then
                                                                    if a2.status ~= "Caltrops" then
                                                                        Effects_upv_1.Status(v85, a2.status, tonumber(a2.duration) or 1)
                                                                        if (v85 ~= char_5 or a2.status ~= "Burn") and v85 == char_5 then
                                                                            if a2.status ~= "Snare" then
                                                                                return
                                                                            end
                                                                            Hud_upv_1.Toast("SNARED", Color3.fromRGB(226, 196, 140), 1.2)
                                                                        end
                                                                        Hud_upv_1.Toast("BURNING", Color3.fromRGB(255, 140, 60), 1)
                                                                    else
                                                                        if v85 and v85:IsA("Model") then
                                                                            Effects_upv_1.CaltropStep(v85)
                                                                        end
                                                                        if v85 == char_5 then
                                                                            Hud_upv_1.Toast("CALTROPS", Color3.fromRGB(214, 180, 140), 0.9)
                                                                        end
                                                                    end
                                                                end
                                                                if v110 then
                                                                    local Position_1 = v110.Position
                                                                    v140 = (Position_1 ~= nil) and (Effects_upv_1.NEAR < Effects_upv_1.CamDistance(Position_1))
                                                                    if not v140 then
                                                                        if a2.status ~= "Caltrops" then
                                                                            Effects_upv_1.Status(v85, a2.status, tonumber(a2.duration) or 1)
                                                                            if (v85 ~= char_5 or a2.status ~= "Burn") and v85 == char_5 then
                                                                                if a2.status ~= "Snare" then
                                                                                    return
                                                                                end
                                                                                Hud_upv_1.Toast("SNARED", Color3.fromRGB(226, 196, 140), 1.2)
                                                                            end
                                                                            Hud_upv_1.Toast("BURNING", Color3.fromRGB(255, 140, 60), 1)
                                                                        else
                                                                            if v85 and v85:IsA("Model") then
                                                                                Effects_upv_1.CaltropStep(v85)
                                                                            end
                                                                            if v85 ~= char_5 then
                                                                                return
                                                                            end
                                                                            Hud_upv_1.Toast("CALTROPS", Color3.fromRGB(214, 180, 140), 0.9)
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        else
                                                            local v109 = a2.target
                                                            local v85
                                                            if typeof(v109) == "Instance" then
                                                                if v109:IsA("Player") then
                                                                    v85 = v109.Character
                                                                elseif v109:IsA("Model") then
                                                                    v85 = v109
                                                                else
                                                                    v85 = nil
                                                                end
                                                            else
                                                                v85 = nil
                                                            end
                                                            local v142
                                                            if typeof(v85) == "Instance" then
                                                                if v85:IsA("Player") then
                                                                    v142 = v85.Character
                                                                elseif v85:IsA("Model") then
                                                                    v142 = v85
                                                                else
                                                                    v142 = nil
                                                                end
                                                            else
                                                                v142 = nil
                                                            end
                                                            local v143 = v142 and (v142:FindFirstChild("HumanoidRootPart"))
                                                            v109 = not (v143) or not (v143:IsA("BasePart")) or v143
                                                            if v85 ~= char_5 and v109 then
                                                                local Position_2 = v109.Position
                                                                v142 = (Position_2 ~= nil) and (Effects_upv_1.NEAR < Effects_upv_1.CamDistance(Position_2))
                                                                if (v142) then
                                                                    return
                                                                end
                                                                Effects_upv_1.Heal(v85, tonumber(a2.duration) or 3)
                                                            end
                                                            Effects_upv_1.Heal(v85, tonumber(a2.duration) or 3)
                                                        end
                                                    elseif typeof(a2.position) == "Vector3" then
                                                        local Death_1 = Effects_upv_1.Death
                                                        local position_1 = a2.position
                                                        v99 = false
                                                        local killer_1 = a2.killer
                                                        local v144
                                                        if typeof(killer_1) == "Instance" then
                                                            if killer_1:IsA("Player") then
                                                                v144 = killer_1.Character
                                                            elseif killer_1:IsA("Model") then
                                                                v144 = killer_1
                                                            else
                                                                v144 = nil
                                                            end
                                                        else
                                                            v144 = nil
                                                        end
                                                        if v144 == char_5 then
                                                            v99 = char_5 ~= nil
                                                        end
                                                        if type(a2.weaponId) ~= "string" then
                                                            v144 = nil
                                                        else
                                                            v144 = a2.weaponId
                                                        end
                                                        Death_1(position_1, v99, v144, a2.headshot == true)
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
                            local v144
                            if typeof(a2.position) ~= "Vector3" then
                                v144 = nil
                            else
                                v144 = a2.position
                            end
                            ChakramEnd_1(key_5, a2.caught == true, v144)
                        end
                    elseif type(a2.key) == "string" and typeof(a2.position) == "Vector3" then
                        Effects_upv_1.ChakramTurn(a2.key, a2.position)
                    end
                else
                    v94 = a2.attacker
                    local v85
                    if typeof(v94) == "Instance" then
                        if v94:IsA("Player") then
                            v85 = v94.Character
                        elseif v94:IsA("Model") then
                            v85 = v94
                        else
                            v85 = nil
                        end
                    else
                        v85 = nil
                    end
                    if typeof(a2.position) ~= "Vector3" then
                        v83 = nil
                    else
                        v83 = a2.position
                    end
                    if not v83 then
                        return
                    end
                    Util_upv_1.Sound("War_Horn", v83)
                    Effects_upv_1.HornBlast(v83)
                    if v85 == nil then
                        if v85 == nil or char_5 == nil or not Util_upv_1.IsEnemy(v85) then
                            return
                        end
                        Hud_upv_1.DamageFrom(v83, true, Color3.fromRGB(240, 180, 70), tonumber(a2.reveal) or 3)
                        Hud_upv_1.Toast("ENEMY HORN", Color3.fromRGB(240, 180, 70), 1.6)
                    else
                        if v85 ~= char_5 and not (Util_upv_1.IsTeammate(v85)) then
                            if v85 ~= nil and char_5 ~= nil and Util_upv_1.IsEnemy(v85) then
                                Hud_upv_1.DamageFrom(v83, true, Color3.fromRGB(240, 180, 70), tonumber(a2.reveal) or 3)
                                Hud_upv_1.Toast("ENEMY HORN", Color3.fromRGB(240, 180, 70), 1.6)
                            end
                            return
                        end
                        if type(a2.enemies) == "table" then
                            local v145 = nil
                            for _, value_10 in a2.enemies do
                                if typeof(value_10) == "Instance" then
                                    if value_10:IsA("Player") then
                                        v145 = value_10.Character
                                    elseif value_10:IsA("Model") then
                                        v145 = value_10
                                    else
                                        v145 = nil
                                    end
                                else
                                    v145 = nil
                                end
                                if v145 then
                                    Effects_upv_1.Reveal(v145, tonumber(a2.reveal) or 3)
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
                local v146 = tonumber(a2.duration) or 7
                Effects_upv_1.SmokeCloud(a2.position, tonumber(a2.radius) or 13, v146)
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
                    v146,
                    function()
                        --[[
                          line: 1012
                          upvalues:
                            u17 (copy, index: 1)
                            u16 (copy, index: 2)
                        ]]
                        pcall(u17, 1)
                        task.delay(
                            1.2,
                            function()
                                --[[
                                  line: 1014
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
        v83 = a2.attacker
        local v85
        if typeof(v83) == "Instance" then
            if v83:IsA("Player") then
                v85 = v83.Character
            elseif v83:IsA("Model") then
                v85 = v83
            else
                v85 = nil
            end
        else
            v85 = nil
        end
        if v85 and v85 ~= char_5 then
            local v147
            if typeof(v85) == "Instance" then
                if v85:IsA("Player") then
                    v147 = v85.Character
                elseif v85:IsA("Model") then
                    v147 = v85
                else
                    v147 = nil
                end
            else
                v147 = nil
            end
            local v148 = v147 and (v147:FindFirstChild("HumanoidRootPart"))
            v83 = not (v148) or not (v148:IsA("BasePart")) or v148
            if v83 then
                local Position_3 = v83.Position
                v147 = (Position_3 ~= nil) and (Effects_upv_1.NEAR < Effects_upv_1.CamDistance(Position_3))
                if not (v147) then
                    local v149 = Presentation_upv_1.For(a2.weaponId, Combat_upv_1.Kind(a2.weaponId) or "Fists")
                    if a2.heavy == true then
                        v147 = v149.heavySound or (v149.swingSound)
                    elseif a2.lunge ~= true then
                        v147 = v149.swingSound
                    else
                        v147 = v149.lungeSound or (v149.swingSound)
                    end
                    Util_upv_1.Sound(v147 or "Swing_Sword", v83)
                    if v149.trail and v149.trail > 0 and Quality_upv_1.layers then
                        local Trail_1 = Effects_upv_1.Trail
                        local v150 = (v85 and (v85:FindFirstChildOfClass("Tool"))) or nil
                        Trail_1(v150, v149.trail)
                    end
                    if v149.noSlash then
                        return
                    end
                    local Slash_1 = Effects_upv_1.Slash
                    local v151 = tonumber(a2.step) or 1
                    Slash_1(v85, v151, a2.heavy == true, v149.slashColor)
                    if a2.heavy == true then
                        Effects_upv_1.GroundScuff((v83.Position + (v83.CFrame.LookVector * 4)) - Vector3.new(0, 2.799999952316284, 0))
                    end
                end
            end
        end
    end
end
local function onInputBegan(a1, a2)
    --[[
      name: onInputBegan
      line: 699
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
    local v152 = mapInput(a1)
    if not v152 then
        return
    end
    if tbl_upv_4.handler and tbl_upv_4.hum ~= nil and (tbl_upv_4.hum.Health > 0) and tbl_upv_4.char ~= nil and tbl_upv_4.char.Parent ~= nil and not Util_upv_1.IsMouseUnlocked() and (not Keybinds_upv_1.PadBlocked() or not (#Keybinds_upv_1.PadActionsOf(a1) > 0)) then
        tbl_upv_4.pressed[v152] = true
        handlerInput(v152, true)
    end
end
local function drawTool(a1, a2)
    --[[
      name: drawTool
      line: 590
      upvalues:
        tbl_upv_4 (copy, index: 1)
        backpack (copy, index: 2)
    ]]
    local v153 = nil
    local tbl_16 = {tbl_upv_4.char, backpack()}
    for _, value_11 in tbl_16 do
        if not (value_11) then
            continue
        end
        for v157, value_12 in value_11:GetChildren() do
            local v154 = (value_12 ~= nil) and (value_12:IsA("Tool") and (type(value_12:GetAttribute("WeaponId")) == "string"))
            if not (v154) or value_12:GetAttribute("DrawToken") ~= a2 then
                continue
            end
            if (type(a1) ~= "string" or value_12:GetAttribute("Slot") ~= a1) and (type(a1) ~= "number" or value_12:GetAttribute("SlotIndex") ~= a1) then
                local v155 = value_12:GetAttribute("SlotIndex")
                local v156 = v153 and (v153:GetAttribute("SlotIndex"))
                if not (v153) then
                    v153 = value_12
                    continue
                end
                if type(v155) ~= "number" or type(v156) ~= "number" then
                    continue
                end
                if v155 < v156 then
                    v153 = value_12
                    continue
                end
            end
            return value_12
        end
    end
    return v153
end
function tbl_upv_3.Start()
    --[[
      name: Start
      line: 1262
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
        u12 (ref,  index: 34)
        onCharacter (copy, index: 35)
        autoDraw (copy, index: 36)
        u11 (ref,  index: 37)
        u6 (copy, index: 38)
        enforceWant (copy, index: 39)
        drawTool (copy, index: 40)
        tbl_upv_3 (copy, index: 41)
        u8 (ref,  index: 42)
        tbl_upv_1 (copy, index: 43)
    ]]
    local u18 = false
    local u19 = nil
    Net_upv_1.UnreliableEvent("CombatFXU").OnClientEvent:Connect(
        function(a1, a2)
            --[[
              line: 1268
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
    local v157 = Net_upv_1.Event("HitConfirm")
    local v158 = Net_upv_1.Event("DamageTaken")
    local v159 = Net_upv_1.Event("CombatFX")
    tbl_upv_4.shotId = math.floor((workspace:GetServerTimeNow() % 1e+05) * 10)
    Hud_upv_1.Init()
    Guard_upv_1.Init()
    Poses_upv_1.Init()
    World_upv_1.Init()
    Quality_upv_1.Start()
    Touch_upv_1.Start(dispatch)
    v157.OnClientEvent:Connect(
        function(a3)
            --[[
              line: 1287
              upvalues:
                onHitConfirm (copy, index: 1)
            ]]
            local success_4, v160 = pcall(onHitConfirm, a3)
            if (success_4) then
                return
            end
            warn("[Combat] HitConfirm error:", v160)
        end
    )
    v158.OnClientEvent:Connect(
        function(a4)
            --[[
              line: 1293
              upvalues:
                onDamageTaken (copy, index: 1)
            ]]
            local success_5, v161 = pcall(onDamageTaken, a4)
            if (success_5) then
                return
            end
            warn("[Combat] DamageTaken error:", v161)
        end
    )
    local function fx(a5, a6)
        --[[
          name: fx
          line: 1299
          upvalues:
            onCombatFX (copy, index: 1)
            Metrics_upv_1 (copy, index: 2)
        ]]
        local v162 = os.clock()
        local success_6, v163 = pcall(onCombatFX, a5, a6)
        local AddFx_1 = Metrics_upv_1.AddFx
        local v164 = os.clock() - v162
        local v165
        if type(a5) ~= "string" then
            v165 = nil
        else
            v165 = a5
        end
        AddFx_1(v164, v165)
        if (success_6) then
            return
        end
        warn("[Combat] CombatFX error:", a5, v163)
    end
    v159.OnClientEvent:Connect(fx)
    u19 = fx
    u18 = true
    local v166 = Net_upv_1.Event("AnimRelay")
    Util_upv_1.SetAnimRelay(v166)
    v166.OnClientEvent:Connect(
        function(a7, a8, a9, a10, a11, a12)
            --[[
              line: 1315
              upvalues:
                tbl_upv_4 (copy, index: 1)
                Util_upv_1 (copy, index: 2)
            ]]
            if typeof(a7) ~= "Instance" or not a7:IsA("Model") or a7 == tbl_upv_4.char then
                return
            end
            if type(a9) == "string" then
                local v167 = a7:FindFirstChildOfClass("Humanoid")
                local v168 = v167 and (v167:FindFirstChildOfClass("Animator"))
                if v168 and a7:IsDescendantOf(workspace) then
                    local v169
                    if type(a10) ~= "number" then
                        v169 = 1
                    else
                        v169 = a10
                    end
                    if a8 == "Play" then
                        Util_upv_1.PlayAnim(v167, a9, v169, tonumber(a11), (tonumber(a12)))
                    elseif a8 == "Hold" then
                        Util_upv_1.PlayHold(v167, a9, v169)
                    elseif a8 == "Stop" then
                        Util_upv_1.StopAnim(v167, a9, (tonumber(a11)))
                    end
                    return
                end
            end
        end
    )
    local tbl_upv_17 = {}
    task.spawn(
        function()
            --[[
              line: 1336
              upvalues:
                Players_upv_1 (copy, index: 1)
                LocalPlayer_upv_1 (copy, index: 2)
                Combat_upv_1 (copy, index: 3)
                Presentation_upv_1 (copy, index: 4)
                tbl_upv_17 (copy, index: 5)
                Util_upv_1 (copy, index: 6)
            ]]
            task.wait(0.5)
            local CurrentCamera_1 = workspace.CurrentCamera
            local v170 = ((not CurrentCamera_1) and Vector3.new(0, 0, 0)) or (CurrentCamera_1.CFrame.Position)
            local v171 = nil
            for _, value_13 in Players_upv_1:GetPlayers() do
                local Character_1 = value_13.Character
                if value_13 == LocalPlayer_upv_1 or not (Character_1) then
                    continue
                end
                v171 = Character_1:FindFirstChild("HumanoidRootPart")
                local v172 = Character_1:FindFirstChildOfClass("Humanoid")
                local v173 = v172 and (v172:FindFirstChildOfClass("Animator"))
                if not (v171) then
                    continue
                end
                local v174 = v171:IsA("BasePart")
                if not (v174) or not (v173) or (v171.Position - v170).Magnitude > 160 then
                    continue
                end
                v171 = (Character_1 and (Character_1:FindFirstChildOfClass("Tool"))) or nil
                v174 = v171 and (v171:GetAttribute("WeaponId"))
                if type(v174) ~= "string" or not (v172.Health > 0) then
                    v171 = nil
                    v174 = tbl_upv_17[Character_1]
                    if v174 then
                        if v174 ~= v171 then
                            Util_upv_1.StopAnim(v172, v174, 0.15)
                            tbl_upv_17[Character_1] = nil
                        end
                        if not (v171) then
                            continue
                        end
                        v174 = Util_upv_1.GetTrack(v172, v171)
                        if not (v174) then
                            tbl_upv_17[Character_1] = v171
                            continue
                        end
                        if not (v174.IsPlaying) then
                            Util_upv_1.PlayAnim(v172, v171, 1, 0.2)
                        end
                    else
                        if not (v171) then
                            continue
                        end
                        v174 = Util_upv_1.GetTrack(v172, v171)
                        if not (v175) then
                            tbl_upv_17[Character_1] = v171
                            continue
                        end
                        if not (v175.IsPlaying) then
                            Util_upv_1.PlayAnim(v172, v171, 1, 0.2)
                        end
                    end
                    tbl_upv_17[Character_1] = v171
                end
                v171 = Presentation_upv_1.For(v174, Combat_upv_1.Kind(v174)).hold
                v174 = tbl_upv_17[Character_1]
                if v174 and v174 ~= v171 then
                    Util_upv_1.StopAnim(v172, v174, 0.15)
                    tbl_upv_17[Character_1] = nil
                end
                if not (v171) then
                    continue
                end
                v174 = Util_upv_1.GetTrack(v172, v171)
                if not (v174) then
                    tbl_upv_17[Character_1] = v171
                    continue
                end
                if not (v174.IsPlaying) then
                    Util_upv_1.PlayAnim(v172, v171, 1, 0.2)
                end
                tbl_upv_17[Character_1] = v171
            end
            for key_6 in tbl_upv_17 do
                if not (key_6.Parent) then
                    tbl_upv_17[key_6] = nil
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
              line: 1381
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
                local v176 = LocalPlayer_upv_1:GetAttribute("EquipAck")
                local v177
                if type(v176) ~= "number" then
                    v177 = 0
                else
                    v177 = v176
                end
                if (u3 <= v177) then
                    return
                end
                if u20 ~= u3 then
                    local v178 = os.clock()
                    if v178 - u4 >= 4 then
                        u20 = u3
                        if u10 then
                            return
                        end
                        u10 = true
                        task.defer(
                            function()
                                --[[
                                  line: 482
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
                    elseif v178 - u5 >= 1 and u2 and (tbl_upv_4.hum ~= nil) and ((tbl_upv_4.hum.Health > 0) and ((tbl_upv_4.char ~= nil) and (tbl_upv_4.char.Parent ~= nil))) then
                        tbl_upv_5.resent = tbl_upv_5.resent + 1
                        local v179 = u2
                        if v179 and u1 then
                            u5 = os.clock()
                            send("Equip", {tool = v179, seq = u3})
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
              line: 1399
              upvalues:
                u12 (ref,  index: 1)
                tbl_upv_4 (copy, index: 2)
                Util_upv_1 (copy, index: 3)
                u21 (ref,  index: 4)
                Hud_upv_1 (copy, index: 5)
                LocalPlayer_upv_1 (copy, index: 6)
                Touch_upv_1 (copy, index: 7)
            ]]
            if u12 then
                return
            end
            local handler_upv_5 = tbl_upv_4.handler
            if handler_upv_5 and (tbl_upv_4.hum ~= nil) and ((tbl_upv_4.hum.Health > 0) and ((tbl_upv_4.char ~= nil) and (tbl_upv_4.char.Parent ~= nil))) then
                local v180, v181 = pcall(
                    function()
                        --[[
                          line: 1407
                          upvalues:
                            handler_upv_5 (copy, index: 1)
                            a13 (copy, index: 2)
                        ]]
                        handler_upv_5:Update(a13)
                    end
                )
                if not (v180) then
                    warn("[Combat] update error:", v181)
                end
            end
            local v182 = not Util_upv_1.CanAct()
            local v180 = nil
            if v182 ~= u21 then
                u21 = v182
                Hud_upv_1.SetFrozen(v182)
                if v182 then
                    if not (u12) then
                        v180 = tbl_upv_4.handler
                        if v180 and type(v180.Interrupt) == "function" then
                            pcall(
                                function()
                                    --[[
                                      line: 753
                                      upvalues:
                                        v180 (copy, index: 1)
                                    ]]
                                    v180:Interrupt()
                                end
                            )
                        end
                    end
                end
            end
            local v183 = LocalPlayer_upv_1:GetAttribute("CombatMode")
            if v183 ~= nil then
                v180 = v183 == true
            else
                local v184 = LocalPlayer_upv_1:GetAttribute("State") == "Match"
                v180 = v184
            end
            v183 = not Util_upv_1.IsMouseUnlocked() and (LocalPlayer_upv_1:GetAttribute("MenuOpen") ~= true)
            local SetVisible_1 = Hud_upv_1.SetVisible
            local v185 = v183
            if v185 then
                v185 = (tbl_upv_4.hum ~= nil) and ((tbl_upv_4.hum.Health > 0) and ((tbl_upv_4.char ~= nil) and (tbl_upv_4.char.Parent ~= nil)))
                if v185 then
                    v185 = v180
                end
            end
            SetVisible_1(v185)
            Touch_upv_1.SetVisible(v183 and v180)
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
                  line: 621
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
                local v186 = os.clock()
                local v187 = -math.huge
                local v188, v189, v189 = nil, nil, nil
                while os.clock() - v186 < 10 do
                    if LocalPlayer_upv_1:GetAttribute("CombatDrawToken") ~= u22 then
                        return
                    end
                    local v190 = LocalPlayer_upv_1:GetAttribute("CombatDrawSlot")
                    if v190 == 0 then
                        return
                    end
                    local char_6 = tbl_upv_4.char
                    local hum_4 = tbl_upv_4.hum
                    if not (char_6) or not (hum_4) or not (hum_4.Health > 0) or char_6 ~= LocalPlayer_upv_1.Character then
                        task.wait(0.1)
                        continue
                    end
                    local v191 = char_6:IsDescendantOf(workspace)
                    if not (v191) then
                        task.wait(0.1)
                        continue
                    end
                    local v192 = char_6:FindFirstChildOfClass("Tool")
                    v188 = false
                    if v192 ~= nil then
                        v188 = (v192 ~= nil) and (v192:IsA("Tool") and (type(v192:GetAttribute("WeaponId")) == "string"))
                        if v188 then
                            v188 = v192:GetAttribute("DrawToken") == u22
                        end
                    end
                    if v188 then
                        local v193 = false
                        local v194 = LocalPlayer_upv_1:GetAttribute("EquipAck")
                        if type(v194) ~= "number" then
                            v189 = 0
                        else
                            v189 = v194
                        end
                        if v189 < u3 then
                            if os.clock() - u4 < 4 then
                                v193 = true
                            else
                                v193 = false
                            end
                        end
                        if v193 then
                            if v188 then
                                task.wait(0.1)
                                continue
                            end
                            if type(v190) == "number" or type(v190) == "string" then
                                v189 = v190
                                local v195 = drawTool(v190, u22)
                                if v195 then
                                    tbl_upv_3.Equip(v195)
                                end
                                task.wait(0.1)
                            end
                            v189 = 1
                            local v195 = drawTool(v190, u22)
                            if v195 then
                                tbl_upv_3.Equip(v195)
                            end
                            task.wait(0.1)
                        else
                            local v196 = LocalPlayer_upv_1:GetAttribute("EquipSlot")
                            if type(v196) ~= "number" or not (v196 > 0) then
                                if os.clock() - v187 > 0.5 then
                                    v187 = os.clock()
                                    u2 = v192
                                    u3 = u3 + 1
                                    u6[v192] = u3
                                    u4 = os.clock()
                                    tbl_upv_5.requests = tbl_upv_5.requests + 1
                                    enforceWant()
                                    v193 = u2
                                    if v193 and u1 then
                                        u5 = os.clock()
                                        send("Equip", {tool = v193, seq = u3})
                                    end
                                end
                                if v188 then
                                    task.wait(0.1)
                                    continue
                                end
                                if type(v190) == "number" or type(v190) == "string" then
                                    v189 = v190
                                    local v195 = drawTool(v190, u22)
                                    if v195 then
                                        tbl_upv_3.Equip(v195)
                                    end
                                    task.wait(0.1)
                                end
                                v189 = 1
                                local v195 = drawTool(v190, u22)
                                if v195 then
                                    tbl_upv_3.Equip(v195)
                                end
                                task.wait(0.1)
                            end
                            return
                        end
                    else
                        if v188 then
                            task.wait(0.1)
                            continue
                        end
                        if type(v190) == "number" or type(v190) == "string" then
                            v189 = v190
                            local v195 = drawTool(v190, u22)
                            if v195 then
                                tbl_upv_3.Equip(v195)
                            end
                            task.wait(0.1)
                        end
                        v189 = 1
                        local v195 = drawTool(v189, u22)
                        if v195 then
                            tbl_upv_3.Equip(v195)
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
                  line: 1437
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
              line: 1443
              upvalues:
                LocalPlayer_upv_1 (copy, index: 1)
                u8 (ref,  index: 2)
                Util_upv_1 (copy, index: 3)
                tbl_upv_3 (copy, index: 4)
                tbl_upv_1 (copy, index: 5)
            ]]
            local v197 = LocalPlayer_upv_1:WaitForChild("PlayerScripts"):WaitForChild("Core", 30)
            local v198 = v197 and (v197:WaitForChild("InputStats", 30))
            if not v198 then
                return
            end
            if v198:IsA("ModuleScript") then
                local v199 = require(v198)
                u8 = v199
                v199.Watch(Util_upv_1, 512)
                v199.Watch(tbl_upv_3, 1024)
                for _, value_16 in tbl_upv_1 do
                    v199.Watch(value_16, 1024)
                end
            end
        end
    )
end
function tbl_upv_3.PlayFX(a1, a2)
    --[[
      name: PlayFX
      line: 1460
      upvalues:
        onCombatFX (copy, index: 1)
    ]]
    local success_7, v200 = pcall(onCombatFX, a1, a2)
    if (success_7) then
        return
    end
    warn("[Combat] replay FX error:", a1, v200)
end
function tbl_upv_3.SetReplayHud(a1)
    --[[
      name: SetReplayHud
      line: 1470
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
      line: 1484
      upvalues:
        onHitConfirm (copy, index: 1)
    ]]
    local success_8, v201 = pcall(onHitConfirm, a1)
    if (success_8) then
        return
    end
    warn("[Combat] replay HitConfirm error:", v201)
end
function tbl_upv_3.ReplayDamageTaken(a1)
    --[[
      name: ReplayDamageTaken
      line: 1491
      upvalues:
        onDamageTaken (copy, index: 1)
    ]]
    local success_9, v202 = pcall(onDamageTaken, a1)
    if (success_9) then
        return
    end
    warn("[Combat] replay DamageTaken error:", v202)
end
function tbl_upv_3.State()
    --[[
      name: State
      line: 1499
      upvalues:
        u2 (ref,  index: 1)
        tbl_upv_4 (copy, index: 2)
        u3 (ref,  index: 3)
        LocalPlayer_upv_1 (copy, index: 4)
        u4 (ref,  index: 5)
        tbl_upv_5 (copy, index: 6)
        tbl_upv_11 (copy, index: 7)
    ]]
    local v203 = u2
    local tbl_18 = {inputs = 0, equipStats = 0, shotId = 0, equipSeq = 0, equipPending = 0, equipAck = 0, lastInput = 0, speed = 0, tool = 0, wantSlot = 0}
    tbl_18.kind = tbl_upv_4.kind
    tbl_18.tool = ((tbl_upv_4.tool) and (tbl_upv_4.tool.Name)) or nil
    local v204
    if tbl_upv_4.hum then
        v204 = tbl_upv_4.hum.WalkSpeed
    else
        v204 = nil
    end
    tbl_18.speed = v204
    tbl_18.shotId = tbl_upv_4.shotId
    tbl_18.wantSlot = not v203 and 0 or u2:GetAttribute("SlotIndex")
    tbl_18.equipSeq = u3
    local v206 = LocalPlayer_upv_1:GetAttribute("EquipAck")
    local v207
    if type(v206) ~= "number" then
        v207 = 0
    else
        v207 = v206
    end
    tbl_18.equipAck = v207
    local v208 = false
    local v209 = LocalPlayer_upv_1:GetAttribute("EquipAck")
    if type(v209) ~= "number" then
        v206 = 0
    else
        v206 = v209
    end
    if v206 < u3 then
        v208 = os.clock() - u4 < 4
    end
    tbl_18.equipPending = v208
    tbl_18.equipStats = table.clone(tbl_upv_5)
    tbl_18.inputs = tbl_upv_11.n
    tbl_18.lastInput = tbl_upv_11.last
    return tbl_18
end
return tbl_upv_3