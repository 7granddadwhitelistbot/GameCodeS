local v1 = require(script.Parent.Parent:WaitForChild("CommonUtils")).get("FlagUtil")
local _ = game:GetService("StarterPlayer")
local Players_1 = game:GetService("Players")
local RunService_upv_1 = game:GetService("RunService")
local v2 = UserSettings():GetService("UserGameSettings")
local UserInputService_upv_1 = game:GetService("UserInputService")
local InputReplication_upv_1 = require(script.Parent:WaitForChild("InputReplication"))
local u1 = require(script.Parent:WaitForChild("AvatarAbilitiesInterface")).get(Players_1.LocalPlayer)
local u2 = v1.getUserFlag("UserPlayerScriptsPlayerControlState2")
local u3 = v1.getUserFlag("UserAbilitiesUserInterfaceB")
local u4 = v1.getUserFlag("UserPSUseBindToAnimation")
local u5 = (u3 and "ControlState") or "PlayerControlState"
local tbl_upv_1 = {}
tbl_upv_1.__index = tbl_upv_1
local tbl_upv_2 = {}
local tbl_upv_3 = {}
local tbl_upv_4 = {}
local tbl_upv_5 = {}
local u6 = Instance.new("BindableEvent")
local u7 = 0
local u8 = Instance.new("BindableEvent")
local function findInSparseTable(a1, a2)
    --[[
      name: findInSparseTable
      line: 40
    ]]
    for key_1, value_1 in pairs(a1) do
        if value_1 ~= a2 then
            continue
        end
        return key_1
    end
    return nil
end
function tbl_upv_1.GetNumOverflowSlots()
    --[[
      name: GetNumOverflowSlots
      line: 49
    ]]
    return 3
end
function tbl_upv_1.getOverflowScrollIndex()
    --[[
      name: getOverflowScrollIndex
      line: 53
      upvalues:
        u7 (ref, index: 1)
    ]]
    return u7
end
function tbl_upv_1.setOverflowScrollIndex(a1)
    --[[
      name: setOverflowScrollIndex
      line: 57
      upvalues:
        u7 (ref,  index: 1)
        tbl_upv_3 (ref,  index: 2)
        u8 (copy, index: 3)
    ]]
    local v2 = u7
    u7 = math.max(0, math.min(#tbl_upv_3 - 3, a1))
    if u7 == v2 then
        return
    end
    u8:Fire()
end
function tbl_upv_1.getScrollIndexChangedEvent()
    --[[
      name: getScrollIndexChangedEvent
      line: 65
      upvalues:
        u8 (copy, index: 1)
    ]]
    return u8.Event
end
local function shallow_equal(a1, a2)
    --[[
      name: shallow_equal
      line: 33
    ]]
    if a1 ~= a2 then
        for key_2, value_2 in pairs(a1) do
            if a2[key_2] == value_2 then
                continue
            end
            return false
        end
        for key_3, _ in pairs(a2) do
            if a1[key_3] ~= nil then
                continue
            end
            return false
        end
    end
    return true
end
function tbl_upv_1.setupSlotActions(a1, a2)
    --[[
      name: setupSlotActions
      line: 69
      upvalues:
        u2 (copy, index: 1)
        u4 (copy, index: 2)
        RunService_upv_1 (copy, index: 3)
        u1 (copy, index: 4)
        InputReplication_upv_1 (copy, index: 5)
        tbl_upv_2 (copy, index: 6)
        tbl_upv_3 (ref,  index: 7)
        UserInputService_upv_1 (copy, index: 8)
        tbl_upv_1 (copy, index: 9)
        shallow_equal (copy, index: 10)
        u6 (copy, index: 11)
        u5 (copy, index: 13)
        tbl_upv_4 (copy, index: 14)
        tbl_upv_5 (copy, index: 15)
        u7 (ref,  index: 16)
    ]]
    local function getAbilityAction(a3)
        --[[
          name: getAbilityAction
          line: 70
          upvalues:
            u2 (copy, index: 1)
            a2 (copy, index: 2)
            a1 (copy, index: 3)
        ]]
        if not a3 then
            return nil
        end
        local v3
        if not (u2) or a2 then
            v3 = a1:FindFirstChild("InputContexts")
        else
            v3 = script.Parent.Parent:FindFirstChild("InputContexts")
        end
        if not v3 then
            return nil
        end
        local CharacterContext_1 = v3:FindFirstChild("CharacterContext")
        if CharacterContext_1 then
            return (CharacterContext_1:FindFirstChild(a3 .. "Action"))
        end
        return nil
    end
    if not (u2) then
        if u4 then
            RunService_upv_1:BindToAnimation(
                function(a4)
                    --[[
                      line: 85
                      upvalues:
                        u1 (copy, index: 1)
                        InputReplication_upv_1 (copy, index: 2)
                        a1 (copy, index: 3)
                    ]]
                    if not u1:isEnabled() then
                        return
                    end
                    InputReplication_upv_1.FireCustomInputs(a1)
                    InputReplication_upv_1.SendInputToCCLCharacter(a1)
                end,
                Enum.StepFrequency.Hz60
            )
        else
            RunService_upv_1:BindToSimulation(
                function(a5)
                    --[[
                      line: 92
                      upvalues:
                        u1 (copy, index: 1)
                        InputReplication_upv_1 (copy, index: 2)
                        a1 (copy, index: 3)
                    ]]
                    if not u1:isEnabled() then
                        return
                    end
                    InputReplication_upv_1.FireCustomInputs(a1)
                    InputReplication_upv_1.SendInputToCCLCharacter(a1)
                end,
                Enum.StepFrequency.Hz60
            )
        end
    end
    local tbl_upv_6 = {}
    local function updateSlotMap()
        --[[
          name: updateSlotMap
          line: 103
          upvalues:
            tbl_upv_2 (copy, index: 1)
            tbl_upv_3 (ref,  index: 2)
            u1 (copy, index: 3)
            UserInputService_upv_1 (copy, index: 4)
            tbl_upv_6 (copy, index: 5)
            tbl_upv_1 (copy, index: 6)
            shallow_equal (copy, index: 7)
            u6 (copy, index: 8)
        ]]
        local v4 = table.clone(tbl_upv_2)
        local v5 = table.clone(tbl_upv_3)
        local v6 = u1:GetAbilities()
        local v7 = ((UserInputService_upv_1.PreferredInput ~= Enum.PreferredInput.Touch) and 11) or 7
        local v8 = nil
        for key_4, value_3 in pairs(tbl_upv_2) do
            for key_5, value_4 in pairs(v6) do
                if value_4 == value_3 then
                    v8 = key_5
                end
            end
            if not (v8) or v7 < key_4 then
                tbl_upv_2[key_4] = nil
            end
        end
        tbl_upv_3 = {}
        local tbl_7 = {}
        local v9 = nil
        for _, value_5 in ipairs(v6) do
            for key_6, value_6 in pairs(tbl_upv_2) do
                if value_6 == value_5 then
                    v9 = key_6
                end
            end
            if not (v9) then
                table.insert(tbl_7, value_5)
            end
        end
        for _, value_7 in ipairs(tbl_7) do
            local v10 = u1:GetAbilityConfig(value_7)
            if not (v10) then
                continue
            end
            local num_1 = tonumber(v10.Slot)
            if not (num_1 > 0) then
                continue
            end
            if tbl_upv_2[num_1] then
                table.insert(tbl_upv_3, value_7)
                continue
            end
            if num_1 <= v7 then
                tbl_upv_2[num_1] = value_7
            else
                table.insert(tbl_upv_3, value_7)
            end
        end
        local v11 = nil
        for _, value_8 in ipairs(tbl_7) do
            local v12 = u1:GetAbilityConfig(value_8)
            if not (v12) or tonumber(v12.Slot) ~= 0 then
                continue
            end
            local v13 = tbl_upv_6[value_8]
            if v13 and v13 > 0 and v13 <= v7 and not (tbl_upv_2[v13]) then
                tbl_upv_2[v13] = value_8
                continue
            end
            v11 = -1
            for n_1 = 1, v7 do
                if not (tbl_upv_2[n_1]) then
                    v11 = n_1
                    break
                end
            end
            if v11 == -1 then
                table.insert(tbl_upv_3, value_8)
            else
                tbl_upv_2[v11] = value_8
                tbl_upv_6[value_8] = v11
            end
        end
        tbl_upv_1.setOverflowScrollIndex(tbl_upv_1.getOverflowScrollIndex())
        if (shallow_equal(tbl_upv_2, v4)) and (shallow_equal(tbl_upv_3, v5)) then
            return
        end
        u6:Fire()
    end
    u1:GetAbilitiesChangedSignal():Connect(updateSlotMap)
    UserInputService_upv_1:GetPropertyChangedSignal("PreferredInput"):Connect(updateSlotMap)
    updateSlotMap()
    task.spawn(
        function()
            --[[
              line: 186
              upvalues:
                u5 (copy, index: 2)
                u2 (copy, index: 3)
                a2 (copy, index: 4)
                a1 (copy, index: 5)
                tbl_upv_4 (copy, index: 6)
                tbl_upv_2 (copy, index: 7)
                getAbilityAction (copy, index: 8)
                tbl_upv_5 (copy, index: 9)
                tbl_upv_3 (ref,  index: 10)
                u7 (ref,  index: 11)
            ]]
            local function UpdateAbilityInPCS(a6, a7, a8)
                --[[
                  name: UpdateAbilityInPCS
                  line: 187
                  upvalues:
                    u5 (copy, index: 2)
                ]]
                local Character_1 = a6.Character
                if Character_1 then
                    local v14
                    if u3 then
                        v14 = Character_1:FindFirstChildOfClass(u5)
                    else
                        v14 = Character_1:FindFirstChild(u5)
                    end
                    if not v14 then
                        return
                    end
                    v14:UpdateFields({[a7] = a8})
                end
            end
            local v15
            if not (u2) or a2 then
                v15 = a1:WaitForChild("InputContexts", math.huge)
            else
                v15 = script.Parent.Parent:FindFirstChild("InputContexts")
            end
            local CharacterContext_2 = v15:WaitForChild("CharacterContext")
            for n_upv_2 = 1, 11 do
                local v16 = CharacterContext_2:WaitForChild("AbilityAction" .. tostring(n_upv_2))
                tbl_upv_4[n_upv_2] = v16
                v16.StateChanged:Connect(
                    function(a9)
                        --[[
                          line: 208
                          upvalues:
                            u2 (copy, index: 1)
                            tbl_upv_2 (copy, index: 2)
                            n_upv_2 (copy, index: 3)
                            UpdateAbilityInPCS (copy, index: 4)
                            a1 (copy, index: 5)
                            getAbilityAction (copy, index: 6)
                        ]]
                        local v17, v18 = nil, nil
                        if u2 then
                            if tbl_upv_2[n_upv_2] == nil or tbl_upv_2[n_upv_2] == "" then
                                return
                            end
                            UpdateAbilityInPCS(a1, tbl_upv_2[n_upv_2], a9)
                        else
                            v17 = getAbilityAction(tbl_upv_2[n_upv_2])
                            if not v17 then
                                return
                            end
                            v18 = v17:FindFirstChild("ScriptableBinding")
                            if not v18 then
                                return
                            end
                            v18:Fire(a9)
                        end
                    end
                )
            end
            if not u2 then
                return
            end
            for n_upv_3 = 1, 3 do
                local v19 = CharacterContext_2:WaitForChild("OverflowAction" .. tostring(n_upv_3))
                tbl_upv_5[n_upv_3] = v19
                v19.StateChanged:Connect(
                    function(a10)
                        --[[
                          line: 229
                          upvalues:
                            tbl_upv_3 (ref,  index: 1)
                            n_upv_3 (copy, index: 2)
                            u7 (ref,  index: 3)
                            UpdateAbilityInPCS (copy, index: 4)
                            a1 (copy, index: 5)
                        ]]
                        local v20 = tbl_upv_3[n_upv_3 + u7]
                        if v20 == nil or v20 == "" then
                            return
                        end
                        UpdateAbilityInPCS(a1, v20, a10)
                    end
                )
            end
        end
    )
end
function tbl_upv_1.GetSlotMapChangedSignal()
    --[[
      name: GetSlotMapChangedSignal
      line: 240
      upvalues:
        u6 (copy, index: 1)
    ]]
    return u6.Event
end
function tbl_upv_1.GetSlotMap()
    --[[
      name: GetSlotMap
      line: 244
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    return tbl_upv_2
end
function tbl_upv_1.GetAbilitiesInOverflow()
    --[[
      name: GetAbilitiesInOverflow
      line: 248
      upvalues:
        tbl_upv_3 (ref, index: 1)
    ]]
    return tbl_upv_3
end
function tbl_upv_1.GetActionInSlot(a1)
    --[[
      name: GetActionInSlot
      line: 252
      upvalues:
        tbl_upv_4 (copy, index: 1)
    ]]
    return tbl_upv_4[a1]
end
function tbl_upv_1.GetOverflowAction(a1)
    --[[
      name: GetOverflowAction
      line: 256
      upvalues:
        tbl_upv_5 (copy, index: 1)
    ]]
    return tbl_upv_5[a1]
end
return tbl_upv_1