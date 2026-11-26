local CommonUtils = require(script.Parent.Parent:WaitForChild("CommonUtils"))
local v2 = CommonUtils.get("FlagUtil")
local starterPlayer = game:GetService("StarterPlayer")
local players = game:GetService("Players")
local runService = game:GetService("RunService")
UserSettings():GetService("UserGameSettings")
local userInputService = game:GetService("UserInputService")
local InputReplication = require(script.Parent:WaitForChild("InputReplication"))
local AvatarAbilitiesInterface = require(script.Parent:WaitForChild("AvatarAbilitiesInterface"))
local v9 = AvatarAbilitiesInterface.get(players.LocalPlayer)
local userFlag = v2.getUserFlag("UserPlayerScriptsPlayerControlState2")
    or v2.getUserFlag("UserPlayerScriptsPlayerControlState2GA")
local userFlag2 = v2.getUserFlag("UserAbilitiesUserInterfaceB")
local userFlag3 = v2.getUserFlag("UserPSUseBindToAnimation")
local v13 = userFlag2 and "ControlState" or "PlayerControlState"
local Class = {}
Class.__index = Class
local v15 = {}
local v16 = {}
local v17 = {}
local count = 0
local v19 = {}
local v20 = {}
local v21 = {}
local bindableEvent = Instance.new("BindableEvent")
local v23 = 0
local bindableEvent2 = Instance.new("BindableEvent")

local function shallow_equal(a26, a27)
    --[[
      name: shallow_equal
      line: 44
    ]]
    if a26 == a27 then
        return true
    end

    for v28, v29 in a26 do
        if a27[v28] ~= v29 then
            return false
        end
    end

    for v30, _ in a27 do
        if a26[v30] == nil then
            return false
        end
    end

    return true
end

local function findInSparseTable(a33, a34)
    --[[
      name: findInSparseTable
      line: 61
    ]]
    for v35, v36 in a33 do
        if v36 == a34 then
            return v35
        end
    end

    return nil
end

local v37 = {"ButtonAssetId", "ButtonPressedAssetId", "ButtonInvalidAssetId"}

local function updateAbilityActionMetadata()
    --[[
      name: updateAbilityActionMetadata
      line: 72
      upvalues:
        v19 (copy, index: 1)
        v15 (copy, index: 2)
        v9 (copy, index: 3)
        v37 (copy, index: 4)
        v20 (copy, index: 5)
    ]]
    local v39

    for index = 1, 11 do
        if const v41 = v19[index] then
            local updateAction
            v39 = v15[index]
            local enabled = v39 ~= nil and v39 ~= ""
            local displayName = not enabled and "" or v39
            local v45 = if enabled then v9:GetAbilityConfig(v39) else nil

            updateAction = function(a46)
                --[[
                  name: updateAction
                  line: 81
                  upvalues:
                    enabled (copy, index: 1)
                    displayName (copy, index: 2)
                    v37 (copy, index: 3)
                    v45 (copy, index: 4)
                ]]
                a46.Enabled = enabled
                a46.DisplayName = displayName

                for _, v48 in v37 do
                    local v49
                    local v50 = if v45 then v45[v48] else nil

                    if type(v50) == "string" then
                        v49 = v50
                    else
                        v49 = ""
                    end

                    a46:SetAttribute(v48, v49)
                end
            end

            updateAction(v41)
            local instance = v20[index]

            if instance and instance ~= v41 then
                updateAction(instance)
            end
        end
    end
end

function Class.GetNumAbilitySlots()
    --[[
      name: GetNumAbilitySlots
      line: 102
    ]]
    return 11
end

function Class.GetNumOverflowSlots()
    --[[
      name: GetNumOverflowSlots
      line: 106
    ]]
    return 3
end

function Class.getOverflowScrollIndex()
    --[[
      name: getOverflowScrollIndex
      line: 110
      upvalues:
        v23 (ref, index: 1)
    ]]
    return v23
end

function Class.setOverflowScrollIndex(overflowScrollIndex: number)
    --[[
      name: setOverflowScrollIndex
      line: 114
      upvalues:
        v23 (ref,  index: 1)
        v16 (ref,  index: 2)
        bindableEvent2 (copy, index: 3)
    ]]
    local v53 = v23
    v23 = math.max(0, (math.min(#v16 - 3, overflowScrollIndex)))

    if v23 ~= v53 then
        bindableEvent2:Fire()
    end
end

function Class.getScrollIndexChangedEvent()
    --[[
      name: getScrollIndexChangedEvent
      line: 122
      upvalues:
        bindableEvent2 (copy, index: 1)
    ]]
    return bindableEvent2.Event
end

function Class.setupSlotActions(a54, a55, a56)
    --[[
      name: setupSlotActions
      line: 126
      upvalues:
        userFlag (copy, index: 1)
        userFlag3 (copy, index: 2)
        runService (copy, index: 3)
        v9 (copy, index: 4)
        InputReplication (copy, index: 5)
        v15 (copy, index: 6)
        v16 (ref,  index: 7)
        userInputService (copy, index: 8)
        starterPlayer (copy, index: 9)
        v17 (copy, index: 10)
        count (ref,  index: 11)
        Class (copy, index: 12)
        updateAbilityActionMetadata (copy, index: 13)
        bindableEvent (copy, index: 14)
        userFlag2 (copy, index: 15)
        v13 (copy, index: 16)
        v19 (copy, index: 17)
        v20 (copy, index: 18)
        v21 (copy, index: 19)
        v23 (ref,  index: 20)
    ]]
    local function getAbilityAction(a58)
        --[[
          name: getAbilityAction
          line: 127
          upvalues:
            userFlag (copy, index: 1)
            a55 (ref,  index: 2)
            a54 (copy, index: 3)
        ]]
        if not a58 then
            return nil
        end

        local inputContexts = if userFlag and not a55 then script.Parent.Parent:FindFirstChild("InputContexts") else a54:FindFirstChild("InputContexts")
        return if not inputContexts then nil elseif const characterContext = inputContexts:FindFirstChild("CharacterContext") then (characterContext:FindFirstChild(a58 .. "Action")) else nil
    end

    if not userFlag then
        if userFlag3 then
            runService:BindToAnimation(
                function(a61)
                    --[[
                      line: 148
                      upvalues:
                        v9 (copy, index: 1)
                        InputReplication (copy, index: 2)
                        a54 (copy, index: 3)
                    ]]
                    if v9:isEnabled() then
                        InputReplication.FireCustomInputs(a54)
                        InputReplication.SendInputToCCLCharacter(a54)
                    end
                end,
                Enum.StepFrequency.Hz60
            )
        else
            runService:BindToSimulation(
                function(a62)
                    --[[
                      line: 155
                      upvalues:
                        v9 (copy, index: 1)
                        InputReplication (copy, index: 2)
                        a54 (copy, index: 3)
                    ]]
                    if v9:isEnabled() then
                        InputReplication.FireCustomInputs(a54)
                        InputReplication.SendInputToCCLCharacter(a54)
                    end
                end,
                Enum.StepFrequency.Hz60
            )
        end
    end

    local v63 = {}

    local function updateSlotMap()
        --[[
          name: updateSlotMap
          line: 166
          upvalues:
            v15 (copy, index: 1)
            v16 (ref,  index: 2)
            v9 (copy, index: 3)
            userInputService (copy, index: 4)
            starterPlayer (copy, index: 5)
            v63 (copy, index: 6)
            v17 (copy, index: 7)
            count (ref,  index: 8)
            Class (copy, index: 9)
            updateAbilityActionMetadata (copy, index: 10)
            bindableEvent (copy, index: 11)
        ]]
        local v65
        local v66
        local values = table.clone(v15)
        local values2 = table.clone(v16)
        local abilities = v9:GetAbilities()
        local endIndex = userInputService.PreferredInput ~= Enum.PreferredInput.Touch and 11 or 7

        for v71, v72 in v15 do
            local v73

            for v74, ability in abilities do
                if ability == v72 then
                    v73 = v74
                    break
                end
            end

            if not v73 or endIndex < v71 then
                v15[v71] = nil
            end
        end

        v16 = {}
        local targets = {}

        for _, ability in abilities do
            local v79

            for v80, v81 in v15 do
                if v81 == ability then
                    v79 = v80
                    break
                end
            end

            if not v79 then
                table.insert(targets, ability)
            end
        end

        local abilitySlotConflictFifo = starterPlayer:FindFirstChild("AbilitySlotConflictFifo")
        local value = abilitySlotConflictFifo ~= nil
            and abilitySlotConflictFifo:IsA("BoolValue")
            and abilitySlotConflictFifo.Value

        for _, target in targets do
            if const abilityConfig = v9:GetAbilityConfig(target) then
                local v87
                local number = tonumber(abilityConfig.Slot)

                if not (0 < number) then
                    continue
                end

                local v89 = v15[number]
                v87 = nil

                for v90, value2 in values do
                    if value2 == target then
                        v87 = v90
                        break
                    end
                end

                local v92 = not v87 and not table.find(values2, target)

                if number <= endIndex and not v89 then
                    v15[number] = target
                elseif not (number <= endIndex) or not value or not v92 then
                    table.insert(v16, target)
                else
                    table.insert(v16, v89)
                    v15[number] = target
                end
            end
        end

        for _, v94 in targets do
            if const abilityConfig = v9:GetAbilityConfig(v94) then
                if tonumber(abilityConfig.Slot) ~= 0 then
                    continue
                end

                if const v96 = v63[v94] then
                    if not (v96 <= endIndex) or v15[v96] then
                        table.insert(v16, v94)
                    else
                        v15[v96] = v94
                    end
                else
                    local v97 = -1

                    for index = 1, endIndex do
                        if not v15[index] then
                            v97 = index
                            break
                        end
                    end

                    if v97 == -1 then
                        table.insert(v16, v94)
                    else
                        v15[v97] = v94
                        v63[v94] = v97
                    end
                end
            end
        end

        local v99 = {}

        for _, v101 in v16 do
            v99[v101] = true

            if v17[v101] == nil then
                count += 1
                v17[v101] = count
            end
        end

        for v102 in v17 do
            if not v99[v102] then
                v17[v102] = nil
            end
        end

        table.sort(
            v16,
            function(left, right)
                --[[
                  line: 263
                  upvalues:
                    v17 (copy, index: 1)
                ]]
                return v17[left] < v17[right]
            end
        )
        local v105 = v16

        if v105 ~= values2 then
            do
                local v106 = true

                for valueKey, v108 in v105 do
                    if values2[valueKey] ~= v108 then
                        v65 = false
                        v106 = false
                        break
                    end
                end

                if v106 then
                    v65 = true

                    for v109, _ in values2 do
                        if v105[v109] == nil then
                            v65 = false
                            break
                        end
                    end
                end
            end
        else
            v65 = true
        end

        local v111 = not v65

        if v111 then
            Class.setOverflowScrollIndex(#v16 - 3)
        else
            Class.setOverflowScrollIndex(Class.getOverflowScrollIndex())
        end

        local v112 = v15

        if v112 ~= values then
            do
                local v113 = true

                for valueKey, v115 in v112 do
                    if values[valueKey] ~= v115 then
                        v66 = false
                        v113 = false
                        break
                    end
                end

                if v113 then
                    v66 = true

                    for v116, _ in values do
                        if v15[v116] == nil then
                            v66 = false
                            break
                        end
                    end
                end
            end
        else
            v66 = true
        end

        if not v66 or v111 then
            updateAbilityActionMetadata()
            bindableEvent:Fire()
        end
    end

    v9:GetAbilitiesChangedSignal():Connect(updateSlotMap)
    userInputService:GetPropertyChangedSignal("PreferredInput"):Connect(updateSlotMap)
    updateSlotMap()

    local function UpdateAbilityInPCS(a119, a120, a121)
        --[[
          name: UpdateAbilityInPCS
          line: 285
          upvalues:
            userFlag2 (copy, index: 1)
            v13 (copy, index: 2)
        ]]
        local character = a119.Character
        if not character then
            return
        end

        local v123 = if userFlag2 then character:FindFirstChildOfClass(v13) else character:FindFirstChild(v13)
        if not v123 then
            return
        end

        v123:UpdateFields({[a120] = a121})
    end

    local v124 = {}
    local v125 = {}

    local function resolveHeldAbility(a127, key, value, a130)
        --[[
          name: resolveHeldAbility
          line: 306
        ]]
        if a130 then
            a127[key] = value
            return value
        end

        local v131 = a127[key]
        a127[key] = nil

        if v131 ~= nil then
            return v131
        end

        return value
    end

    local v132 = {}
    local count2 = 0

    local function resolveAndWireActions()
        --[[
          name: resolveAndWireActions
          line: 318
          upvalues:
            count2 (ref,  index: 1)
            v132 (copy, index: 2)
            userFlag (copy, index: 3)
            a55 (ref,  index: 4)
            a54 (copy, index: 5)
            v19 (copy, index: 6)
            v20 (copy, index: 7)
            v124 (copy, index: 8)
            v15 (copy, index: 9)
            UpdateAbilityInPCS (copy, index: 10)
            getAbilityAction (copy, index: 11)
            updateAbilityActionMetadata (copy, index: 12)
            v21 (copy, index: 13)
            v125 (copy, index: 14)
            v16 (ref,  index: 15)
            v23 (ref,  index: 16)
            bindableEvent (copy, index: 17)
        ]]
        count2 += 1
        local v135 = count2

        for _, v137 in v132 do
            v137:Disconnect()
        end

        table.clear(v132)
        local inputContexts = if userFlag and not a55 then script.Parent.Parent:WaitForChild("InputContexts", math.huge) else a54:WaitForChild("InputContexts", math.huge)
        local characterContext = inputContexts:WaitForChild("CharacterContext")

        if v135 ~= count2 then
            return
        end

        local inputContexts2 = script.Parent.Parent:FindFirstChild("InputContexts")
        local characterContext2 = inputContexts2 and inputContexts2:FindFirstChild("CharacterContext")

        for index = 1, 11 do
            local v143 = characterContext:WaitForChild("AbilityAction" .. tostring(index))

            if v135 ~= count2 then
                return
            end

            v19[index] = v143
            v20[index] = if characterContext2 then characterContext2:FindFirstChild("AbilityAction" .. tostring(index)) else nil

            table.insert(
                v132,
                v143.StateChanged:Connect(
                    function(a144)
                        --[[
                          line: 352
                          upvalues:
                            v124 (copy, index: 1)
                            index (copy, index: 2)
                            v15 (copy, index: 3)
                            userFlag (copy, index: 4)
                            UpdateAbilityInPCS (copy, index: 5)
                            a54 (copy, index: 6)
                            getAbilityAction (copy, index: 7)
                        ]]
                        local v145
                        local v146 = index
                        local v147 = v15[index]

                        if a144 then
                            v124[v146] = v147
                            v145 = v147
                        else
                            local v148 = v124[v146]
                            v124[v146] = nil
                            v145 = if v148 ~= nil then v148 else v147
                        end

                        if userFlag then
                            if v145 ~= nil and v145 ~= "" then
                                UpdateAbilityInPCS(a54, v145, a144)
                            end
                        elseif const abilityAction = getAbilityAction(v145) then
                            if const scriptableBinding = abilityAction:FindFirstChild("ScriptableBinding") then
                                scriptableBinding:Fire(a144)
                            end
                        end
                    end
                )
            )
        end

        updateAbilityActionMetadata()

        if userFlag then
            for index = 1, 3 do
                local v152 = characterContext:WaitForChild("OverflowAction" .. tostring(index))

                if v135 ~= count2 then
                    return
                end

                v21[index] = v152

                table.insert(
                    v132,
                    v152.StateChanged:Connect(
                        function(a153)
                            --[[
                              line: 382
                              upvalues:
                                v125 (copy, index: 1)
                                index (copy, index: 2)
                                v16 (ref,  index: 3)
                                v23 (ref,  index: 4)
                                UpdateAbilityInPCS (copy, index: 5)
                                a54 (copy, index: 6)
                            ]]
                            local v154
                            local v155 = index
                            local v156 = v16[index + v23]

                            if a153 then
                                v125[v155] = v156
                                v154 = v156
                            else
                                local v157 = v125[v155]
                                v125[v155] = nil
                                v154 = if v157 ~= nil then v157 else v156
                            end

                            if v154 ~= nil and v154 ~= "" then
                                UpdateAbilityInPCS(a54, v154, a153)
                            end
                        end
                    )
                )
            end
        end

        bindableEvent:Fire()
    end

    task.spawn(resolveAndWireActions)

    if a56 then
        a56:subscribe("SERVER_AUTHORITY_CHANGED"):Connect(
            function(a158)
                --[[
                  line: 403
                  upvalues:
                    a55 (ref,  index: 1)
                    resolveAndWireActions (copy, index: 2)
                ]]
                if a158 == a55 then
                    return
                end

                a55 = a158
                task.spawn(resolveAndWireActions)
            end
        )
    end
end

function Class.GetSlotMapChangedSignal()
    --[[
      name: GetSlotMapChangedSignal
      line: 413
      upvalues:
        bindableEvent (copy, index: 1)
    ]]
    return bindableEvent.Event
end

function Class.GetSlotMap()
    --[[
      name: GetSlotMap
      line: 417
      upvalues:
        v15 (copy, index: 1)
    ]]
    return v15
end

function Class.GetAbilitiesInOverflow()
    --[[
      name: GetAbilitiesInOverflow
      line: 421
      upvalues:
        v16 (ref, index: 1)
    ]]
    return v16
end

function Class.GetActionInSlot(key)
    --[[
      name: GetActionInSlot
      line: 425
      upvalues:
        v19 (copy, index: 1)
    ]]
    return v19[key]
end

function Class.GetOverflowAction(key)
    --[[
      name: GetOverflowAction
      line: 429
      upvalues:
        v21 (copy, index: 1)
    ]]
    return v21[key]
end

return Class