local Players_1 = game:GetService("Players")
local v1 = require(script.Parent.Parent:WaitForChild("CommonUtils")).get("FlagUtil")
local v2 = v1.getUserFlag("UserPlayerScriptsCCLIntegrationD")
local u1 = v1.getUserFlag("UserPlayerScriptsPlayerControlState2")
local u2 = v1.getUserFlag("UserPlayerScriptsTaskDeferSimulation")
local u3 = v1.getUserFlag("UserPlayerScriptsImportWaitForAbilitiesFolder")
local u4 = nil
if not (u3) then
    local function waitForChildren(a1, a2, a3)
        --[[
          name: waitForChildren
          line: 22
        ]]
        if #a2 == 0 then
            return nil
        end
        local v3 = nil
        for _, value_1 in a2 do
            v3 = a1:FindFirstChild(value_1)
            if not (v3) then
                continue
            end
            return v3
        end
        local u5 = coroutine.running()
        local u6 = nil
        local u7 = false
        local function _(a4)
            --[[
              name: settle
              line: 41
              upvalues:
                u7 (ref,  index: 1)
                u6 (ref,  index: 2)
                u5 (copy, index: 3)
            ]]
            if u7 then
                return
            end
            u7 = true
            u6 = a4
            task.spawn(u5)
        end
        local v4 = a1.ChildAdded:Connect(
            function(a5)
                --[[
                  line: 54
                  upvalues:
                    a2 (copy, index: 1)
                    u7 (ref,  index: 2)
                    u6 (ref,  index: 3)
                    u5 (copy, index: 4)
                ]]
                if not table.find(a2, a5.Name) or u7 then
                    return
                end
                u7 = true
                u6 = a5
                task.spawn(u5)
            end
        )
        v3 = nil
        v3 = a3
            and task.delay(
                a3,
                function()
                    --[[
                      line: 61
                      upvalues:
                        u7 (ref,  index: 1)
                        u6 (ref,  index: 2)
                        u5 (copy, index: 3)
                    ]]
                    if u7 then
                        return
                    end
                    u7 = true
                    u6 = nil
                    task.spawn(u5)
                end
            )
        coroutine.yield()
        v4:Disconnect()
        if v3 and coroutine.status(v3) == "suspended" then
            task.cancel(v3)
        end
        return u6
    end
    local v5 = function(a1, a2)
        --[[
          line: 85
          upvalues:
            waitForChildren (copy, index: 1)
        ]]
        if not a1 then
            return nil
        end
        local u8 = (a2 and (time() + a2)) or nil
        local function getRemainingTime_1()
            --[[
              name: getRemainingTime
              line: 92
              upvalues:
                u8 (copy, index: 1)
            ]]
            if u8 then
                return (math.max(u8 - time(), 0))
            end
            return nil
        end
        local tbl_1 = {"AbilityManagerActor", "Abilities"}
        local v6
        if u8 then
            v6 = math.max(u8 - time(), 0)
        else
            v6 = nil
        end
        local v7 = waitForChildren(a1, tbl_1, v6)
        if v7 then
            if v7.Name ~= "Abilities" then
                local v8
                if u8 then
                    v8 = math.max(u8 - time(), 0)
                else
                    v8 = nil
                end
                if v8 then
                    getRemainingTime_1 = v7:WaitForChild("Abilities", v8)
                else
                    getRemainingTime_1 = v7:WaitForChild("Abilities")
                end
                if getRemainingTime_1 and getRemainingTime_1:IsA("Folder") then
                    return getRemainingTime_1
                end
            elseif v7:IsA("Folder") then
                return v7
            end
        end
        return nil
    end
    u4 = v5
end
if v2 then
    local tbl_upv_2 = {}
    tbl_upv_2.__index = tbl_upv_2
    local tbl_upv_3 = {}
    Players_1.PlayerRemoving:Connect(
        function(a1)
            --[[
              line: 125
              upvalues:
                tbl_upv_3 (copy, index: 1)
            ]]
            wait(1)
            local v9 = tbl_upv_3[a1.UserId]
            if not v9 then
                return
            end
            v9:destroy()
            tbl_upv_3[a1.UserId] = nil
        end
    )
    local function notifyAbilitiesChanged(a1, a2)
        --[[
          name: notifyAbilitiesChanged
          line: 148
        ]]
        local u9 = a1.ChildAdded:Connect(
            function(a3)
                --[[
                  line: 149
                  upvalues:
                    a2 (copy, index: 1)
                ]]
                if not a3:IsA("Configuration") then
                    return
                end
                a2(a3, "added")
            end
        )
        local u10 = a1.ChildRemoved:Connect(
            function(a4)
                --[[
                  line: 154
                  upvalues:
                    a2 (copy, index: 1)
                ]]
                if not a4:IsA("Configuration") then
                    return
                end
                a2(a4, "removed")
            end
        )
        return function()
            --[[
              line: 159
              upvalues:
                u9 (copy, index: 1)
                u10 (copy, index: 2)
            ]]
            u9:Disconnect()
            u10:Disconnect()
        end
    end
    function tbl_upv_2._new(a1)
        --[[
          name: _new
          line: 165
          upvalues:
            tbl_upv_2 (copy, index: 1)
            u1 (copy, index: 2)
            u2 (copy, index: 3)
        ]]
        local u11 = setmetatable({}, tbl_upv_2)
        u11._player = a1
        u11._data = {}
        u11._character = nil
        u11._humanoid = nil
        u11._enabledChangedEvent = Instance.new("BindableEvent")
        u11._abilitiesChangedEvent = Instance.new("BindableEvent")
        u11._evaluateStateMachineChangedConnection = nil
        u11._abilityChangedEvents = {}
        u11._abilityChangedConnections = {}
        u11._abilitiesByInputName = {}
        u11._disconnectAbilitiesChanged = nil
        if not (u1) or u2 then
            u11._characterAddedConnection = a1.CharacterAdded:Connect(
                function(a2)
                    --[[
                      line: 188
                      upvalues:
                        u11 (copy, index: 1)
                    ]]
                    u11:_onCharacterAdded(a2)
                end
            )
        else
            task.spawn(
                function()
                    --[[
                      line: 182
                      upvalues:
                        u11 (copy, index: 1)
                        a1 (copy, index: 2)
                    ]]
                    u11._characterAddedConnection = a1.CharacterAdded:Connect(
                        function(a3)
                            --[[
                              line: 183
                              upvalues:
                                u11 (copy, index: 1)
                            ]]
                            u11:_onCharacterAdded(a3)
                        end
                    )
                end
            )
        end
        if a1.Character then
            u11:_onCharacterAdded(a1.Character)
        end
        return u11
    end
    local u12 = nil
    function tbl_upv_2._avatarAbilities()
        --[[
          name: _avatarAbilities
          line: 202
          upvalues:
            u12 (ref, index: 1)
        ]]
        if not (u12) then
            local Packages_1 = game:GetService("ReplicatedStorage"):FindFirstChild("Packages")
            local v10
            if Packages_1 then
                v10 = Packages_1:FindFirstChild("AvatarAbilities")
            else
                v10 = nil
            end
            local v11
            if v10 then
                v11 = require(v10)
            else
                v11 = nil
            end
            u12 = v11
            if not (u12) then
                u12 = require("@rbx/AvatarAbilities")
            end
        end
        return u12
    end
    function tbl_upv_2.get(a1)
        --[[
          name: get
          line: 215
          upvalues:
            tbl_upv_3 (copy, index: 1)
            tbl_upv_2 (copy, index: 2)
        ]]
        if a1 and a1.UserId ~= 0 then
            local v12 = tbl_upv_3[a1.UserId]
            if not (v12) then
                v12 = tbl_upv_2._new(a1)
                tbl_upv_3[a1.UserId] = v12
            end
            return v12
        end
        return nil
    end
    function tbl_upv_2._hookUpAbilityChangedEvent(a1, a2, a3)
        --[[
          name: _hookUpAbilityChangedEvent
          line: 225
        ]]
        local v13 = a1._abilitiesByInputName[a2]
        if not v13 then
            return
        end
        local SyncedState_1 = v13:FindFirstChild("SyncedState")
        if not SyncedState_1 then
            return
        end
        if not (a1._abilityChangedConnections[a3]) then
            a1._abilityChangedConnections[a3] = {}
        end
        if a1._abilityChangedConnections[a3][a2] then
            a1._abilityChangedConnections[a3][a2]:Disconnect()
            a1._abilityChangedConnections[a3][a2] = nil
        end
        a1._abilityChangedConnections[a3][a2] = SyncedState_1:GetAttributeChangedSignal(a3):Connect(
            function()
                --[[
                  line: 239
                  upvalues:
                    a1 (copy, index: 1)
                    a3 (copy, index: 2)
                    a2 (copy, index: 3)
                ]]
                a1._abilityChangedEvents[a3][a2]:Fire()
            end
        )
    end
    local function createAbilitiesByInputNameTable(a1)
        --[[
          name: createAbilitiesByInputNameTable
          line: 135
        ]]
        local tbl_4 = {}
        for _, value_2 in a1:GetChildren() do
            if not (value_2:IsA("Configuration")) then
                continue
            end
            local v14 = value_2:GetAttribute("InputName")
            if v14 then
                tbl_4[v14] = value_2
            end
        end
        return tbl_4
    end
    function tbl_upv_2._onCharacterAdded(a1, a2)
        --[[
          name: _onCharacterAdded
          line: 244
          upvalues:
            u3 (copy, index: 1)
            u4 (ref,  index: 2)
            notifyAbilitiesChanged (copy, index: 3)
            createAbilitiesByInputNameTable (copy, index: 4)
        ]]
        a1._humanoid = nil
        a1._character = a2
        a1._abilitiesByInputName = {}
        a1._data = {}
        if a1._disconnectAbilitiesChanged then
            a1._disconnectAbilitiesChanged()
            a1._disconnectAbilitiesChanged = nil
        end
        for _, value_3 in a1._abilityChangedConnections do
            for v1, value_4 in value_3 do
                value_4:Disconnect()
            end
        end
        a1._abilityChangedConnections = {}
        if a1._evaluateStateMachineChangedConnection then
            a1._evaluateStateMachineChangedConnection:Disconnect()
            a1._evaluateStateMachineChangedConnection = nil
        end
        if not a1._character then
            return
        end
        local function isStale()
            --[[
              name: isStale
              line: 271
              upvalues:
                a1 (copy, index: 1)
                a2 (copy, index: 2)
            ]]
            return a1._character ~= a2
        end
        task.spawn(
            function()
                --[[
                  line: 276
                  upvalues:
                    u3 (copy, index: 1)
                    a1 (copy, index: 2)
                    a2 (copy, index: 3)
                    u4 (ref,  index: 4)
                    notifyAbilitiesChanged (copy, index: 5)
                    createAbilitiesByInputNameTable (copy, index: 6)
                ]]
                local u13
                if u3 then
                    u13 = a1._avatarAbilities().waitForAbilitiesFolder(a2)
                else
                    u13 = u4(a2)
                end
                if not u13 or a1._character ~= a2 then
                    return
                end
                a1._humanoid = a2:FindFirstChildOfClass("Humanoid")
                while not (a1._humanoid) do
                    a2.ChildAdded:Wait()
                    if a1._character == a2 then
                        a1._humanoid = a2:FindFirstChildOfClass("Humanoid")
                        continue
                    end
                    return
                end
                if a1._evaluateStateMachineChangedConnection then
                    a1._evaluateStateMachineChangedConnection:Disconnect()
                    a1._evaluateStateMachineChangedConnection = nil
                end
                local function enabledChanged()
                    --[[
                      name: enabledChanged
                      line: 297
                      upvalues:
                        a1 (copy, index: 1)
                        notifyAbilitiesChanged (copy, index: 2)
                        u13 (ref,  index: 3)
                        createAbilitiesByInputNameTable (copy, index: 4)
                    ]]
                    if a1._disconnectAbilitiesChanged then
                        a1._disconnectAbilitiesChanged()
                        a1._disconnectAbilitiesChanged = nil
                    end
                    if a1:isEnabled() then
                        a1._disconnectAbilitiesChanged = notifyAbilitiesChanged(
                            u13,
                            function(a3, a4)
                                --[[
                                  line: 304
                                  upvalues:
                                    a1 (copy, index: 1)
                                ]]
                                local v15 = a3:GetAttribute("InputName")
                                if not v15 then
                                    return
                                end
                                if a4 == "added" then
                                    a1._abilitiesByInputName[v15] = a3
                                    for key_1, value_5 in a1._abilityChangedEvents do
                                        if value_5[v15] then
                                            a1:_hookUpAbilityChangedEvent(v15, key_1)
                                        end
                                    end
                                elseif a1._abilitiesByInputName[v15] == a3 then
                                    a1._abilitiesByInputName[v15] = nil
                                    for _, value_6 in a1._abilityChangedConnections do
                                        local v16 = value_6[v15]
                                        if v16 then
                                            v16:Disconnect()
                                            value_6[v15] = nil
                                        end
                                    end
                                end
                                a1._abilitiesChangedEvent:Fire()
                            end
                        )
                        a1._abilitiesByInputName = createAbilitiesByInputNameTable(u13)
                        a1._abilitiesChangedEvent:Fire()
                        for key_2, value_7 in a1._abilityChangedEvents do
                            for key_3, value_8 in value_7 do
                                value_8:Fire()
                                a1:_hookUpAbilityChangedEvent(key_3, key_2)
                            end
                        end
                    end
                    a1._enabledChangedEvent:Fire()
                end
                a1._evaluateStateMachineChangedConnection = a1._humanoid:GetPropertyChangedSignal("EvaluateStateMachine"):Connect(
                    function()
                        --[[
                          line: 350
                          upvalues:
                            enabledChanged (copy, index: 1)
                        ]]
                        enabledChanged()
                    end
                )
                enabledChanged()
            end
        )
    end
    function tbl_upv_2.isEnabled(a1)
        --[[
          name: isEnabled
          line: 357
        ]]
        return (a1._humanoid ~= nil) and (not a1._humanoid.EvaluateStateMachine)
    end
    function tbl_upv_2.GetEnabledChangedSignal(a1)
        --[[
          name: GetEnabledChangedSignal
          line: 361
        ]]
        return a1._enabledChangedEvent.Event
    end
    function tbl_upv_2.SendInput(a1, a2, a3)
        --[[
          name: SendInput
          line: 365
        ]]
        if not a1:isEnabled() then
            return
        end
        if a3 ~= a1._data[a2] then
            a1._data[a2] = a3
            a1._avatarAbilities().setAbilityManagerCommand(a1._character, a2, a3)
        end
    end
    function tbl_upv_2.GetAbilityAttribute(a1, a2, a3, a4)
        --[[
          name: GetAbilityAttribute
          line: 374
        ]]
        local v17 = a1._abilitiesByInputName[a2]
        if not v17 then
            return a4
        end
        local SyncedState_2 = v17:FindFirstChild("SyncedState")
        if not SyncedState_2 then
            return a4
        end
        local v18 = SyncedState_2:GetAttribute(a3)
        if v18 ~= nil then
            return v18
        end
        return a4
    end
    function tbl_upv_2.GetAbilityAttributeChangedSignal(a1, a2, a3)
        --[[
          name: GetAbilityAttributeChangedSignal
          line: 384
        ]]
        if not (a1._abilityChangedEvents[a3]) then
            a1._abilityChangedEvents[a3] = {}
        end
        if a1._abilityChangedEvents[a3][a2] then
            return a1._abilityChangedEvents[a3][a2].Event
        end
        local v19 = Instance.new("BindableEvent")
        a1._abilityChangedEvents[a3][a2] = v19
        a1:_hookUpAbilityChangedEvent(a2, a3)
        return v19.Event
    end
    function tbl_upv_2.GetAbilityEnabled(a1, a2)
        --[[
          name: GetAbilityEnabled
          line: 400
        ]]
        return a1:GetAbilityAttribute(a2, "Enabled", false)
    end
    function tbl_upv_2.GetAbilityEnabledChangedSignal(a1, a2)
        --[[
          name: GetAbilityEnabledChangedSignal
          line: 404
        ]]
        return a1:GetAbilityAttributeChangedSignal(a2, "Enabled")
    end
    function tbl_upv_2.GetAbilitySuspended(a1, a2)
        --[[
          name: GetAbilitySuspended
          line: 408
        ]]
        return a1:GetAbilityAttribute(a2, "Suspended", false)
    end
    function tbl_upv_2.GetAbilitySuspendedChangedSignal(a1, a2)
        --[[
          name: GetAbilitySuspendedChangedSignal
          line: 412
        ]]
        return a1:GetAbilityAttributeChangedSignal(a2, "Suspended")
    end
    function tbl_upv_2.GetAbilityActive(a1, a2)
        --[[
          name: GetAbilityActive
          line: 416
        ]]
        return a1:GetAbilityAttribute(a2, "Active", false)
    end
    function tbl_upv_2.GetAbilityActiveChangedSignal(a1, a2)
        --[[
          name: GetAbilityActiveChangedSignal
          line: 420
        ]]
        return a1:GetAbilityAttributeChangedSignal(a2, "Active")
    end
    function tbl_upv_2.GetAbilityValid(a1, a2)
        --[[
          name: GetAbilityValid
          line: 424
        ]]
        return a1:GetAbilityAttribute(a2, "IsValid", true)
    end
    function tbl_upv_2.GetAbilityValidChangedSignal(a1, a2)
        --[[
          name: GetAbilityValidChangedSignal
          line: 428
        ]]
        return a1:GetAbilityAttributeChangedSignal(a2, "IsValid")
    end
    function tbl_upv_2.GetAbilities(a1)
        --[[
          name: GetAbilities
          line: 432
        ]]
        local tbl_5 = {}
        for key_4 in a1._abilitiesByInputName do
            table.insert(tbl_5, key_4)
        end
        return tbl_5
    end
    function tbl_upv_2.GetAbilitiesChangedSignal(a1)
        --[[
          name: GetAbilitiesChangedSignal
          line: 440
        ]]
        return a1._abilitiesChangedEvent.Event
    end
    function tbl_upv_2.GetAbilityConfig(a1, a2)
        --[[
          name: GetAbilityConfig
          line: 444
        ]]
        local tbl_6 = {Slot = -1}
        local v20 = a1._abilitiesByInputName[a2]
        if not v20 then
            return tbl_6
        end
        local v21 = v20:GetAttribute("ActionSlot")
        if not v21 then
            return tbl_6
        end
        local tbl_7 = {}
        tbl_7.Slot = tonumber(v21)
        tbl_7.ButtonAssetId = v20:GetAttribute("CustomIcon")
        tbl_7.ButtonPressedAssetId = v20:GetAttribute("CustomIconActive")
        tbl_7.ButtonInvalidAssetId = v20:GetAttribute("CustomIconInvalid")
        return tbl_7
    end
    function tbl_upv_2.destroy(a1)
        --[[
          name: destroy
          line: 466
        ]]
        if a1._characterAddedConnection then
            a1._characterAddedConnection:Disconnect()
            a1._characterAddedConnection = nil
        end
        if a1._evaluateStateMachineChangedConnection then
            a1._evaluateStateMachineChangedConnection:Disconnect()
            a1._evaluateStateMachineChangedConnection = nil
        end
        if a1._disconnectAbilitiesChanged then
            a1._disconnectAbilitiesChanged()
            a1._disconnectAbilitiesChanged = nil
        end
        for _, value_9 in a1._abilityChangedConnections do
            for v1, value_10 in value_9 do
                value_10:Disconnect()
            end
        end
        a1._abilityChangedConnections = {}
    end
    return tbl_upv_2
else
    local Players_upv_2 = game:GetService("Players")
    local tbl_8 = {}
    local AbilityManagerActor_upv_1 = nil
    local u14 = nil
    local u15 = Instance.new("BindableEvent")
    local u16 = nil
    local u17 = false
    local function characterAdded(a1)
        --[[
          name: characterAdded
          line: 500
          upvalues:
            AbilityManagerActor_upv_1 (ref,  index: 1)
            u14 (ref,  index: 2)
            u16 (ref,  index: 3)
            u15 (copy, index: 4)
        ]]
        AbilityManagerActor_upv_1 = nil
        u14 = nil
        if u16 then
            u16:Disconnect()
            u16 = nil
        end
        if a1 then
            AbilityManagerActor_upv_1 = a1:FindFirstChild("AbilityManagerActor")
            u14 = a1:FindFirstChildOfClass("Humanoid")
            while not (u14) do
                a1.ChildAdded:wait()
                u14 = a1:FindFirstChildOfClass("Humanoid")
            end
            u15:Fire()
            local v22 = u14:GetPropertyChangedSignal("EvaluateStateMachine"):Connect(
                function()
                    --[[
                      line: 517
                      upvalues:
                        u15 (copy, index: 1)
                    ]]
                    u15:Fire()
                end
            )
            u16 = v22
        end
    end
    local function lazyInit()
        --[[
          name: lazyInit
          line: 523
          upvalues:
            u17 (ref,  index: 1)
            Players_upv_2 (copy, index: 2)
            characterAdded (copy, index: 3)
        ]]
        if u17 then
            return
        end
        u17 = true
        local LocalPlayer_1 = Players_upv_2.LocalPlayer
        if not LocalPlayer_1 then
            return
        end
        LocalPlayer_1.characterAdded:Connect(characterAdded)
        if LocalPlayer_1.Character then
            characterAdded(LocalPlayer_1.Character)
        end
    end
    function tbl_8.isEnabled()
        --[[
          name: isEnabled
          line: 538
          upvalues:
            u17 (ref,  index: 1)
            Players_upv_2 (copy, index: 2)
            characterAdded (copy, index: 3)
            AbilityManagerActor_upv_1 (ref,  index: 4)
            u14 (ref,  index: 5)
        ]]
        local v23 = nil
        if not (u17) then
            u17 = true
            v23 = Players_upv_2.LocalPlayer
            if v23 then
                v23.characterAdded:Connect(characterAdded)
                if v23.Character then
                    characterAdded(v23.Character)
                end
            end
        end
        local v24 = (AbilityManagerActor_upv_1 ~= nil) and (u14 and (not u14.EvaluateStateMachine))
        return v24
    end
    function tbl_8.GetEnabledChangedSignal()
        --[[
          name: GetEnabledChangedSignal
          line: 543
          upvalues:
            u17 (ref,  index: 1)
            Players_upv_2 (copy, index: 2)
            characterAdded (copy, index: 3)
            u15 (copy, index: 4)
        ]]
        local v25 = nil
        if not (u17) then
            u17 = true
            v25 = Players_upv_2.LocalPlayer
            if v25 then
                v25.characterAdded:Connect(characterAdded)
                if v25.Character then
                    characterAdded(v25.Character)
                end
            end
        end
        return u15.Event
    end
    return tbl_8
end