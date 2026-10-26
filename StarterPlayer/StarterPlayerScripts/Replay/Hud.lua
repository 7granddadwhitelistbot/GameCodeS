local _ = game:GetService("Players")
local ReplicatedStorage_1 = game:GetService("ReplicatedStorage")
local Workspace_upv_1 = game:GetService("Workspace")
local Shared_1 = ReplicatedStorage_1:WaitForChild("Shared")
local ReplayCodec_upv_1 = require(Shared_1:WaitForChild("ReplayCodec"))
local Combat_upv_1 = require(Shared_1:WaitForChild("Combat"))
local Weapons_upv_1 = require(Shared_1:WaitForChild("Weapons"))
local HudBridge_upv_1 = require(script.Parent.HudBridge)
local tbl_upv_1 = {}
local Parent_upv_1 = script.Parent.Parent
local u1 = Color3.fromRGB(228, 232, 240)
local u2 = Color3.fromRGB(150, 200, 255)
local tbl_upv_2 = {}
local tbl_upv_3 = {active = false, ui = false, style = "Dot", blocking = false, armor = -1, alive = true, hp = -1, aiming = false}
tbl_upv_3.items = {}
tbl_upv_3.slots = {}
local function now()
    --[[
      name: now
      line: 88
      upvalues:
        Workspace_upv_1 (copy, index: 1)
    ]]
    return Workspace_upv_1:GetServerTimeNow()
end
local function mod(a1)
    --[[
      name: mod
      line: 35
      upvalues:
        tbl_upv_2 (copy, index: 1)
        Parent_upv_1 (copy, index: 2)
    ]]
    local v1 = tbl_upv_2[a1]
    if v1 == nil then
        local Combat_2 = Parent_upv_1:FindFirstChild("Combat")
        local v2 = Combat_2 and (Combat_2:FindFirstChild(a1))
        v1 = false
        local v3 = nil
        if v2 then
            local v4 = v2:IsA("ModuleScript")
            if v4 then
                local success_1, v5 = pcall(require, v2)
                if success_1 and type(v5) == "table" then
                    v3 = v5
                end
            end
        end
        tbl_upv_2[a1] = v3
    end
    return v1 or nil
end
local function tuningOf(a1)
    --[[
      name: tuningOf
      line: 101
      upvalues:
        Combat_upv_1 (copy, index: 1)
    ]]
    local success_2, v6 = pcall(Combat_upv_1.Tuning, a1)
    if success_2 and type(v6) == "table" then
        return v6
    end
    return {}
end
local function heldSlot()
    --[[
      name: heldSlot
      line: 108
      upvalues:
        tbl_upv_3 (copy, index: 1)
    ]]
    for _, value_1 in tbl_upv_3.slots do
        if value_1.id ~= tbl_upv_3.heldId then
            continue
        end
        return value_1
    end
    return nil
end
local function presetOf(a1)
    --[[
      name: presetOf
      line: 92
      upvalues:
        mod (copy, index: 1)
        Combat_upv_1 (copy, index: 2)
    ]]
    local v7 = mod("Presentation")
    if not v7 then
        return {}
    end
    local success_3, v8 = pcall(v7.For, a1, Combat_upv_1.Kind(a1))
    if success_3 and type(v8) == "table" then
        return v8
    end
    return {}
end
local function refreshArc()
    --[[
      name: refreshArc
      line: 155
      upvalues:
        mod (copy, index: 1)
        tbl_upv_3 (copy, index: 2)
        Workspace_upv_1 (copy, index: 3)
        Combat_upv_1 (copy, index: 4)
        u1 (copy, index: 5)
        u2 (copy, index: 6)
    ]]
    local v9 = mod("Hud")
    local v10 = nil
    for _, value_2 in tbl_upv_3.slots do
        if value_2.id == tbl_upv_3.heldId then
            v10 = value_2
        end
    end
    if not v9 then
        return
    end
    if v10 then
        local v11 = v10.tool
        local v12 = Workspace_upv_1:GetServerTimeNow()
        local v13 = v11:GetAttribute("ReloadEndsAt")
        if v11:GetAttribute("Reloading") == true and type(v13) == "number" and v12 < v13 then
            local success_4, v14 = pcall(Combat_upv_1.Tuning, v10.id)
            local v15
            if (success_4) and type(v14) == "table" then
                v15 = v14
            else
                v15 = {}
            end
            local v16 = v15.reloadTime or (v13 - v12)
            v9.SetArc(v16, u1, (math.max(0, v16 - (v13 - v12))))
            return
        else
            v13 = v11:GetAttribute("NextCharge")
            local success_5, v17 = pcall(Combat_upv_1.Tuning, v10.id)
            if (success_5) and type(v17) == "table" then
                v11 = v17
            else
                v11 = {}
            end
        end
        local regen_1 = v11.regen
        if type(v13) == "number" and v12 < v13 and type(regen_1) == "number" then
            v9.SetArc(regen_1, u2, (math.max(0, regen_1 - (v13 - v12))))
        end
    end
end
local function refreshPips()
    --[[
      name: refreshPips
      line: 117
      upvalues:
        mod (copy, index: 1)
        tbl_upv_3 (copy, index: 2)
        Combat_upv_1 (copy, index: 3)
        presetOf (copy, index: 4)
        Weapons_upv_1 (copy, index: 5)
    ]]
    local v18 = mod("Hud")
    if not v18 or not tbl_upv_3.src then
        return
    end
    local heldId_1 = tbl_upv_3.heldId
    local v19 = nil
    for _, value_3 in tbl_upv_3.slots do
        if value_3.id == tbl_upv_3.heldId then
            v19 = value_3
        end
    end
    local v20 = Combat_upv_1.Kind(heldId_1) or "Fists"
    local u3 = v19 and (v19.tool)
    local function num_1(a1)
        --[[
          name: num
          line: 126
          upvalues:
            u3 (copy, index: 1)
        ]]
        local v21
        if u3 then
            v21 = u3:GetAttribute(a1)
        else
            v21 = u3
        end
        if type(v21) ~= "number" then
            return nil
        end
        return v21
    end
    local model_1 = u3 and (u3:GetAttribute("Ammo"))
    local v22
    if type(model_1) ~= "number" then
        v22 = nil
    else
        v22 = model_1
    end
    model_1 = u3 and (u3:GetAttribute("MaxAmmo"))
    local v23
    if type(model_1) ~= "number" then
        v23 = nil
    else
        v23 = model_1
    end
    local v24 = u3 and (u3:GetAttribute("Charges"))
    if type(v24) ~= "number" then
        model_1 = nil
    else
        model_1 = v24
    end
    local v25 = u3 and (u3:GetAttribute("MaxCharges"))
    local v26
    if type(v25) ~= "number" then
        v26 = nil
    else
        v26 = v25
    end
    if Combat_upv_1.UsesAmmo(v20) and v22 and v23 then
        v18.SetPips(v22, v23)
    elseif model_1 and v26 then
        if v20 == "Bow" then
            v18.SetPips(0, 0)
        else
            local SetPips_1 = v18.SetPips
            local v27
            if v20 == "Herbs" or v20 == "Trap" then
                v27 = presetOf(heldId_1).color
            else
                v27 = nil
            end
            SetPips_1(model_1, v26, v27)
        end
    else
        v18.SetPips(0, 0)
    end
    v26 = heldId_1 and (Weapons_upv_1.AmmoOf and (Weapons_upv_1.AmmoOf(heldId_1)))
    model_1 = tbl_upv_3.src.model
    if type(v26) ~= "string" then
        v23 = nil
    else
        v23 = model_1:GetAttribute("Ammo_" .. v26)
    end
    v22 = mod("Util")
    if type(heldId_1) == "string" and v22 and v22.AmmoShown and v22.AmmoLeft(model_1, heldId_1) > 0 then
        v18.SetAmmoCount(v22.AmmoShown(model_1, heldId_1))
        return
    end
    if type(v23) ~= "number" then
        v18.SetAmmoCount(nil)
    else
        local SetAmmoCount_1 = v18.SetAmmoCount
        local v28 = ((v22 and (v22.AMMO_NOUN)) and (v22.AMMO_NOUN[heldId_1])) or (string.upper(heldId_1))
        SetAmmoCount_1(v23, v28)
    end
end
local function applyInv(a1)
    --[[
      name: applyInv
      line: 202
      upvalues:
        tbl_upv_3 (copy, index: 1)
        Workspace_upv_1 (copy, index: 2)
        ReplayCodec_upv_1 (copy, index: 3)
        Weapons_upv_1 (copy, index: 4)
        Combat_upv_1 (copy, index: 5)
        refreshPips (copy, index: 6)
        refreshArc (copy, index: 7)
    ]]
    local src_1 = tbl_upv_3.src
    if not src_1 then
        return
    end
    local items_1 = a1.items
    local v29 = Workspace_upv_1:GetServerTimeNow()
    local tbl_5 = {}
    if type(items_1) == "string" then
        local v30, v31 = nil, nil
        for n_1 = 0, (#items_1 // ReplayCodec_upv_1.INV_BYTES) - 1 do
            local success_6, v30, v32, v33, v34, v35, v36, v37, v38, v39 = pcall(string.unpack, ReplayCodec_upv_1.INV_FORMAT, items_1, (n_1 * ReplayCodec_upv_1.INV_BYTES) + 1)
            local v40, v41 = nil, nil
            if not (success_6) then
                break
            end
            v40 = tbl_upv_3.items[v30]
            if not (v40) or v32 < 1 or v32 > 6 then
                continue
            end
            tbl_5[v32] = true
            v30 = tbl_upv_3.slots[v32]
            if not (v30) or v30.id ~= v40 then
                if v30 then
                    v30.tool:Destroy()
                end
                local v42 = Instance.new("Tool")
                v41 = Weapons_upv_1.Get(v40)
                if v41 then
                    v31 = v41.name
                else
                    v31 = v40
                end
                v42.Name = v31
                v42.RequiresHandle = false
                v42.CanBeDropped = false
                v42:SetAttribute("WeaponId", v40)
                v42:SetAttribute("SlotIndex", v32)
                v42:SetAttribute("Kind", Combat_upv_1.Kind(v40))
                if v40 ~= tbl_upv_3.heldId then
                    v31 = src_1.backpack
                else
                    v31 = src_1.character
                end
                v42.Parent = v31
                v30 = {tool = v42, id = v40}
                tbl_upv_3.slots[v32] = v30
                local tool_upv_1 = v30.tool
                local function set_1(a2, a3)
                    --[[
                      name: set
                      line: 240
                      upvalues:
                        tool_upv_1 (copy, index: 1)
                    ]]
                    local v43 = ((a3 > 0) and (a3 - 1)) or nil
                    if tool_upv_1:GetAttribute(a2) == v43 then
                        return
                    end
                    tool_upv_1:SetAttribute(a2, v43)
                end
                success_6 = ((v33 > 0) and (v33 - 1)) or nil
                if tool_upv_1:GetAttribute("Ammo") ~= success_6 then
                    tool_upv_1:SetAttribute("Ammo", success_6)
                end
                v33 = ((v34 > 0) and (v34 - 1)) or nil
                if tool_upv_1:GetAttribute("MaxAmmo") ~= v33 then
                    tool_upv_1:SetAttribute("MaxAmmo", v33)
                end
                v34 = ((v35 > 0) and (v35 - 1)) or nil
                if tool_upv_1:GetAttribute("Charges") ~= v34 then
                    tool_upv_1:SetAttribute("Charges", v34)
                end
                v35 = ((v36 > 0) and (v36 - 1)) or nil
                if tool_upv_1:GetAttribute("MaxCharges") ~= v35 then
                    tool_upv_1:SetAttribute("MaxCharges", v35)
                end
                tool_upv_1:SetAttribute("Reloading", v37 > 0)
                tool_upv_1:SetAttribute("ReloadEndsAt", ((v37 > 0) and (v29 + v37 / 100)) or 0)
                tool_upv_1:SetAttribute("Cooldown", ((v38 > 0) and (v29 + v38 / 100)) or 0)
                tool_upv_1:SetAttribute("NextCharge", ((v39 > 0) and (v29 + v39 / 100)) or 0)
            end
            local tool_upv_1 = v30.tool
            local function set_1(a2, a3)
                --[[
                  name: set
                  line: 240
                  upvalues:
                    tool_upv_1 (copy, index: 1)
                ]]
                local v43 = ((a3 > 0) and (a3 - 1)) or nil
                if tool_upv_1:GetAttribute(a2) == v43 then
                    return
                end
                tool_upv_1:SetAttribute(a2, v43)
            end
            success_6 = ((v33 > 0) and (v33 - 1)) or nil
            if tool_upv_1:GetAttribute("Ammo") ~= success_6 then
                tool_upv_1:SetAttribute("Ammo", success_6)
            end
            v33 = ((v34 > 0) and (v34 - 1)) or nil
            if tool_upv_1:GetAttribute("MaxAmmo") ~= v33 then
                tool_upv_1:SetAttribute("MaxAmmo", v33)
            end
            v34 = ((v35 > 0) and (v35 - 1)) or nil
            if tool_upv_1:GetAttribute("Charges") ~= v34 then
                tool_upv_1:SetAttribute("Charges", v34)
            end
            v35 = ((v36 > 0) and (v36 - 1)) or nil
            if tool_upv_1:GetAttribute("MaxCharges") ~= v35 then
                tool_upv_1:SetAttribute("MaxCharges", v35)
            end
            tool_upv_1:SetAttribute("Reloading", v37 > 0)
            tool_upv_1:SetAttribute("ReloadEndsAt", ((v37 > 0) and (v29 + v37 / 100)) or 0)
            tool_upv_1:SetAttribute("Cooldown", ((v38 > 0) and (v29 + v38 / 100)) or 0)
            tool_upv_1:SetAttribute("NextCharge", ((v39 > 0) and (v29 + v39 / 100)) or 0)
        end
    end
    for key_1, value_4 in tbl_upv_3.slots do
        if not (tbl_5[key_1]) then
            value_4.tool:Destroy()
            tbl_upv_3.slots[key_1] = nil
        end
    end
    for key_2, value_5 in a1 do
        if type(key_2) ~= "string" or string.sub(key_2, 1, 4) ~= "Ammo" then
            continue
        end
        if type(value_5) == "number" then
            src_1.model:SetAttribute(key_2, value_5)
        end
    end
    if type(a1.maxArmor) == "number" then
        src_1.model:SetAttribute("MaxArmor", a1.maxArmor)
    end
    refreshPips()
    refreshArc()
end
function tbl_upv_1.Begin(a1)
    --[[
      name: Begin
      line: 276
      upvalues:
        tbl_upv_1 (copy, index: 1)
        tbl_upv_3 (copy, index: 2)
        mod (copy, index: 3)
        HudBridge_upv_1 (copy, index: 4)
    ]]
    tbl_upv_1.End()
    tbl_upv_3.active = true
    tbl_upv_3.items = a1
    tbl_upv_3.slots = {}
    tbl_upv_3.heldId = nil
    tbl_upv_3.charge = nil
    tbl_upv_3.aiming = false
    tbl_upv_3.blocking = false
    tbl_upv_3.hp = -1
    tbl_upv_3.armor = -1
    tbl_upv_3.alive = true
    local v44 = Instance.new("Model")
    v44.Name = "ReplayHudSource"
    local v45 = Instance.new("Humanoid")
    v45.MaxHealth = 100
    v45.Health = 100
    v45.Parent = v44
    v44:SetAttribute("Armor", 0)
    v44:SetAttribute("MaxArmor", 0)
    local v46 = Instance.new("Folder")
    v46.Name = "Backpack"
    v46.Parent = v44
    local v47 = Instance.new("Folder")
    v47.Name = "Character"
    v47.Parent = v44
    tbl_upv_3.src = {backpack = v46, character = v47, model = v44}
    tbl_upv_3.hum = v45
    local v48 = mod("Controller")
    if v48 and type(v48.SetReplayHud) == "function" then
        pcall(v48.SetReplayHud, true)
    end
    local v49 = mod("Hud")
    if v49 then
        v49.SetVisible(true)
        v49.SetStyle("Dot")
        v49.SetPips(0, 0)
        v49.SetArc(nil)
        v49.SetAmmoCount(nil)
        v49.SetFrozen(false)
    end
    tbl_upv_3.ui = false
    local ui_1 = HudBridge_upv_1.ui
    if not ui_1 then
        return
    end
    tbl_upv_3.ui = pcall(ui_1.Enter, tbl_upv_3.src)
end
function tbl_upv_1.Active()
    --[[
      name: Active
      line: 324
      upvalues:
        tbl_upv_3 (copy, index: 1)
    ]]
    return tbl_upv_3.active
end
function tbl_upv_1.UiShown()
    --[[
      name: UiShown
      line: 328
      upvalues:
        tbl_upv_3 (copy, index: 1)
    ]]
    return tbl_upv_3.ui
end
function tbl_upv_1.End()
    --[[
      name: End
      line: 332
      upvalues:
        tbl_upv_3 (copy, index: 1)
        mod (copy, index: 2)
        HudBridge_upv_1 (copy, index: 3)
    ]]
    if not tbl_upv_3.active then
        return
    end
    tbl_upv_3.active = false
    local v50 = mod("Hud")
    if v50 then
        pcall(v50.StopChannel)
        pcall(v50.SetCharge, 0)
        pcall(v50.SetArc, nil)
        pcall(v50.SetAmmoCount, nil)
        pcall(v50.SetVisible, false)
    end
    local ui_2 = HudBridge_upv_1.ui
    if tbl_upv_3.ui and ui_2 then
        pcall(ui_2.Leave)
    end
    tbl_upv_3.ui = false
    local v51 = mod("Controller")
    if v51 and type(v51.SetReplayHud) == "function" then
        pcall(v51.SetReplayHud, false)
    end
    if tbl_upv_3.src then
        tbl_upv_3.src.model:Destroy()
    end
    tbl_upv_3.src = nil
    tbl_upv_3.hum = nil
    tbl_upv_3.slots = {}
end
local function setHeld(a1)
    --[[
      name: setHeld
      line: 176
      upvalues:
        tbl_upv_3 (copy, index: 1)
        mod (copy, index: 2)
        presetOf (copy, index: 3)
        Combat_upv_1 (copy, index: 4)
        refreshPips (copy, index: 5)
        refreshArc (copy, index: 6)
    ]]
    tbl_upv_3.heldId = a1
    tbl_upv_3.charge = nil
    local v52 = mod("Hud")
    local src_2 = tbl_upv_3.src
    if src_2 then
        local v53 = nil
        for _, value_6 in tbl_upv_3.slots do
            if value_6.id ~= a1 then
                v53 = src_2.backpack
            else
                v53 = src_2.character
            end
            if value_6.tool.Parent ~= v53 then
                value_6.tool.Parent = v53
            end
        end
    end
    if v52 then
        local v54 = presetOf(a1 or (Combat_upv_1.FISTS_ID)).crosshair or "Dot"
        tbl_upv_3.style = v54
        v52.SetStyle(v54)
        v52.SetArc(nil)
        v52.SetBlocking(tbl_upv_3.blocking)
    end
    refreshPips()
    refreshArc()
end
function tbl_upv_1.Update(a1, a2, a3, a4, a5)
    --[[
      name: Update
      line: 365
      upvalues:
        tbl_upv_3 (copy, index: 1)
        mod (copy, index: 2)
        setHeld (copy, index: 3)
        ReplayCodec_upv_1 (copy, index: 4)
        Combat_upv_1 (copy, index: 5)
    ]]
    if not tbl_upv_3.active then
        return
    end
    local v55 = mod("Hud")
    local v56 = tbl_upv_3.hum
    if v56 and math.abs(a3 - tbl_upv_3.hp) >= 0.5 then
        tbl_upv_3.hp = a3
        v56.Health = math.clamp(a3, 0, 100)
    end
    if tbl_upv_3.src and math.abs(a4 - tbl_upv_3.armor) >= 0.5 then
        tbl_upv_3.armor = a4
        tbl_upv_3.src.model:SetAttribute("Armor", a4)
    end
    if a2 ~= tbl_upv_3.heldId then
        setHeld(a2)
    end
    if not v55 then
        return
    end
    local v57 = bit32.btest(a5, ReplayCodec_upv_1.F_ALIVE)
    if v57 ~= tbl_upv_3.alive then
        tbl_upv_3.alive = v57
        v55.SetVisible(v57)
        if not (v57) then
            v55.StopChannel()
            v55.SetCharge(0)
            tbl_upv_3.charge = nil
        end
    end
    local v58 = bit32.btest(a5, ReplayCodec_upv_1.F_BLOCKING)
    if v58 ~= tbl_upv_3.blocking then
        tbl_upv_3.blocking = v58
        v55.SetBlocking(v58)
    end
    tbl_upv_3.aiming = bit32.btest(a5, ReplayCodec_upv_1.F_AIMING)
    v56 = tbl_upv_3.charge
    if v56 then
        v55.SetCharge((math.clamp((a1 - v56.start) / math.max(0.05, v56.time), 0, 1)))
    end
    if tbl_upv_3.style == "Gun" or tbl_upv_3.style == "Spread" then
        local success_7, v59 = pcall(Combat_upv_1.Tuning, tbl_upv_3.heldId)
        if (success_7) and type(v59) == "table" then
            v56 = v59
        else
            v56 = {}
        end
        local v60 = Combat_upv_1.Kind(tbl_upv_3.heldId)
        local v61
        if v60 == "Blunderbuss" then
            v61 = tbl_upv_3.aiming and v56.spreadAim or (v56.spread or 6)
        elseif v60 == "Crossbow" then
            v61 = 0.4
        elseif tbl_upv_3.aiming then
            v61 = v56.spreadAim or 0
        else
            v61 = v56.spreadHip or 0
        end
        v55.SetSpread(v61)
    end
end
function tbl_upv_1.ChargeAt(a1)
    --[[
      name: ChargeAt
      line: 418
      upvalues:
        tbl_upv_3 (copy, index: 1)
    ]]
    local charge_1 = tbl_upv_3.charge
    if charge_1 then
        return (math.clamp((a1 - charge_1.start) / math.max(0.05, charge_1.time), 0, 1))
    end
    return 1
end
function tbl_upv_1.HeldCharges()
    --[[
      name: HeldCharges
      line: 427
      upvalues:
        tbl_upv_3 (copy, index: 1)
    ]]
    local v62 = nil
    for _, value_7 in tbl_upv_3.slots do
        if value_7.id == tbl_upv_3.heldId then
            v62 = value_7
        end
    end
    if not v62 then
        return nil
    end
    local v63 = v62.tool:GetAttribute("MaxCharges")
    local v64 = v62.tool:GetAttribute("Charges")
    if type(v63) == "number" and v63 > 0 and type(v64) == "number" then
        return v64
    end
    return nil
end
function tbl_upv_1.OnFighterEvent(a1, a2, a3)
    --[[
      name: OnFighterEvent
      line: 440
      upvalues:
        tbl_upv_3 (copy, index: 1)
        mod (copy, index: 2)
        applyInv (copy, index: 3)
        Combat_upv_1 (copy, index: 4)
        presetOf (copy, index: 5)
        u1 (copy, index: 6)
    ]]
    if not tbl_upv_3.active then
        return
    end
    local v65 = mod("Hud")
    if a1 == "Inv" then
        applyInv(a2)
    elseif v65 then
        if a1 ~= "Charge" then
            if a1 == "Projectile" then
                local v66 = Combat_upv_1.Kind(a2.weaponId)
                local charge_2 = tbl_upv_3.charge
                local v67 = ((not charge_2) and 1) or (math.clamp((a3 - charge_2.start) / math.max(0.05, charge_2.time), 0, 1))
                if v66 ~= "Bow" then
                    local v68 = nil
                    if Combat_upv_1.UsesAmmo(v66) then
                        local v69 = presetOf(a2.weaponId)
                        local Kick_1 = v65.Kick
                        local success_8, v70 = pcall(Combat_upv_1.Tuning, a2.weaponId)
                        local v71
                        if (success_8) and type(v70) == "table" then
                            v71 = v70
                        else
                            v71 = {}
                        end
                        Kick_1((v71.kick or (v69.kick or 2)) * 3)
                    else
                        v65.Kick(4)
                        local success_9, v72 = pcall(Combat_upv_1.Tuning, a2.weaponId)
                        local v73
                        if (success_9) and type(v72) == "table" then
                            v73 = v72
                        else
                            v73 = {}
                        end
                        v68 = v73.cooldown
                        if type(v68) == "number" and v68 >= 0.3 then
                            v65.SetArc(v68, u1)
                        end
                    end
                else
                    v65.Kick(v67 * 6)
                end
                tbl_upv_3.charge = nil
                v65.SetCharge(0)
            elseif a1 == "Swing" then
                if a2.heavy == true or a2.lunge == true then
                    local success_10, v74 = pcall(Combat_upv_1.Tuning, a2.weaponId)
                    local v75
                    if (success_10) and type(v74) == "table" then
                        v75 = v74
                    else
                        local tbl_8 = {}
                        v75 = tbl_8
                    end
                    local v76
                    if a2.heavy ~= true then
                        v76 = v75.lunge
                    else
                        v76 = v75.heavy
                    end
                    local SetArc_1 = v65.SetArc
                    if type(v76) ~= "table" then
                        v74 = 1
                    else
                        v74 = v76.cooldown
                        v74 = v74 or 1
                    end
                    SetArc_1(v74, u1)
                end
                tbl_upv_3.charge = nil
                v65.SetCharge(0)
            elseif a1 ~= "Reload" then
                if a1 == "Use" then
                    local v77 = nil
                    if a2.position == nil then
                        local v78 = presetOf(a2.weaponId)
                        v77 = tonumber(a2.duration)
                        if v77 and v77 > 0 then
                            v65.StartChannel(v78.label or "USING", v77, v78.color)
                        end
                        return
                    end
                end
                if a1 ~= "Heal" then
                    return
                end
                v65.StopChannel()
                v65.Flash(Color3.fromRGB(110, 220, 110), 0.35, 0.4)
            else
                local v79 = tonumber(a2.duration)
                if not (v79) then
                    local success_11, v80 = pcall(Combat_upv_1.Tuning, a2.weaponId)
                    if (success_11) and type(v80) == "table" then
                        v79 = v80
                    else
                        v79 = {}
                    end
                    v79 = v79.reloadTime or 1
                end
                v65.SetArc(v79, u1)
            end
        elseif a2.on ~= true then
            tbl_upv_3.charge = nil
            v65.SetCharge(0)
        else
            local v81
            if type(a2.weaponId) ~= "string" then
                v81 = tbl_upv_3.heldId
            else
                v81 = a2.weaponId
            end
            local v82, v83 = pcall(Combat_upv_1.Tuning, v81)
            local v84
            if (v82) and type(v83) == "table" then
                v84 = v83
            else
                local tbl_9 = {}
                v84 = tbl_9
            end
            local str_1 = tostring(a2.kind)
            if str_1 == "Heavy" then
                v82 = ((v84.heavy) and (v84.heavy.charge)) or 0.6
            elseif str_1 == "Lunge" then
                v82 = ((v84.lunge) and (v84.lunge.charge)) or 0.6
            elseif str_1 ~= "Throw" then
                v82 = v84.drawTime or 1
            else
                v82 = v84.drawTime or 0.5
            end
            tbl_upv_3.charge = {kind = str_1, start = a3, time = v82}
        end
    end
end
function tbl_upv_1.HitConfirm(a1, a2)
    --[[
      name: HitConfirm
      line: 508
      upvalues:
        mod (copy, index: 1)
        tbl_upv_3 (copy, index: 2)
    ]]
    local v85 = mod("Controller")
    if not tbl_upv_3.active or not v85 then
        return
    end
    if type(v85.ReplayHitConfirm) == "function" then
        local ReplayHitConfirm_1 = v85.ReplayHitConfirm
        local tbl_10 = {weaponId = 0, armorBroken = 0, armor = 0, headshot = 0, dot = 0, position = 0, blocked = 0, crit = 0, killed = 0}
        tbl_10.victimId = a2 or ""
        tbl_10.victim = a1.victim
        tbl_10.amount = tonumber(a1.amount) or 0
        tbl_10.headshot = a1.headshot == true
        tbl_10.crit = a1.crit == true
        tbl_10.killed = a1.killed == true
        tbl_10.blocked = a1.blocked == true
        tbl_10.position = a1.position
        tbl_10.weaponId = a1.weaponId
        tbl_10.dot = a1.dot == true
        tbl_10.armor = tonumber(a1.armor) or 0
        tbl_10.armorBroken = a1.armorBroken == true
        ReplayHitConfirm_1(tbl_10)
    end
end
function tbl_upv_1.DamageTaken(a1, a2)
    --[[
      name: DamageTaken
      line: 530
      upvalues:
        mod (copy, index: 1)
        tbl_upv_3 (copy, index: 2)
    ]]
    local v86 = mod("Controller")
    if not tbl_upv_3.active or not v86 then
        return
    end
    if type(v86.ReplayDamageTaken) == "function" then
        local attacker_1 = a1.attacker
        local fromPosition_1 = a1.fromPosition
        if typeof(fromPosition_1) ~= "Vector3" then
            local v87 = nil
            if typeof(attacker_1) == "Instance" then
                v87 = attacker_1:FindFirstChild("HumanoidRootPart")
                fromPosition_1 = not (v87) or not (v87:IsA("BasePart")) or v87.Position
            end
        end
        local ReplayDamageTaken_1 = v86.ReplayDamageTaken
        local tbl_11 = {armorBroken = 0, knockback = false, attackerId = 0, weaponId = 0, fromPosition = 0, attacker = 0, headshot = 0, damageType = 0, stagger = 0, armor = 0, blocked = 0, interrupted = 0, killed = 0}
        tbl_11.amount = tonumber(a1.amount) or 0
        local v88
        if typeof(fromPosition_1) ~= "Vector3" then
            v88 = false
        else
            v88 = fromPosition_1
        end
        tbl_11.fromPosition = v88
        tbl_11.attackerId = a2 or ""
        tbl_11.attacker = attacker_1
        tbl_11.headshot = a1.headshot == true
        tbl_11.killed = a1.killed == true
        tbl_11.blocked = a1.blocked == true
        if type(a1.weaponId) ~= "string" then
            v88 = false
        else
            v88 = a1.weaponId
        end
        tbl_11.weaponId = v88
        if type(a1.damageType) ~= "string" then
            v88 = false
        else
            v88 = a1.damageType
        end
        tbl_11.damageType = v88
        if type(a1.stagger) ~= "number" then
            v88 = false
        else
            v88 = a1.stagger
        end
        tbl_11.stagger = v88
        tbl_11.armor = tonumber(a1.armor) or 0
        tbl_11.armorBroken = a1.armorBroken == true
        tbl_11.interrupted = a1.interrupted == true
        ReplayDamageTaken_1(tbl_11)
        if a1.interrupted == true then
            fromPosition_1 = mod("Hud")
            if fromPosition_1 then
                fromPosition_1.StopChannel()
            end
        end
    end
end
return tbl_upv_1