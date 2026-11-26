local v1

local function GetAbilityValidChangedSignal(self, a4)
    --[[
      name: GetAbilityValidChangedSignal
      line: 449
    ]]
    return self:GetAbilityAttributeChangedSignal(a4, "IsValid")
end

local function GetAbilityValid(self, a7)
    --[[
      name: GetAbilityValid
      line: 445
    ]]
    return self:GetAbilityAttribute(a7, "IsValid", true)
end

local function GetAbilityActiveChangedSignal(self, a10)
    --[[
      name: GetAbilityActiveChangedSignal
      line: 441
    ]]
    return self:GetAbilityAttributeChangedSignal(a10, "Active")
end

local function GetAbilityActive(self, a13)
    --[[
      name: GetAbilityActive
      line: 437
    ]]
    return self:GetAbilityAttribute(a13, "Active", false)
end

local function destroy(self)
    --[[
      name: destroy
      line: 492
    ]]
    if self._characterAddedConnection then
        self._characterAddedConnection:Disconnect()
        self._characterAddedConnection = nil
    end

    if self._evaluateStateMachineChangedConnection then
        self._evaluateStateMachineChangedConnection:Disconnect()
        self._evaluateStateMachineChangedConnection = nil
    end

    if self._disconnectAbilitiesChanged then
        self._disconnectAbilitiesChanged()
        self._disconnectAbilitiesChanged = nil
    end

    for _, abilityChangedConnection in self._abilityChangedConnections do
        for _, v19 in abilityChangedConnection do
            v19:Disconnect()
        end
    end

    self._abilityChangedConnections = {}
end

local function GetAbilityConfig(self, key)
    --[[
      name: GetAbilityConfig
      line: 466
    ]]
    local v23 = {Slot = -1}

    if const v24 = self._abilitiesByInputName[key] then
        if const actionSlot = v24:GetAttribute("ActionSlot") then
            local number = tonumber(actionSlot)
            local customIcon = v24:GetAttribute("CustomIcon")
            local customIconActive = v24:GetAttribute("CustomIconActive")
            local customIconInvalid = v24:GetAttribute("CustomIconInvalid")

            return {Slot = number, ButtonAssetId = customIcon, ButtonPressedAssetId = customIconActive, ButtonInvalidAssetId = customIconInvalid}
        end
    end

    return v23
end

local function GetAbilitiesChangedSignal(self)
    --[[
      name: GetAbilitiesChangedSignal
      line: 462
    ]]
    return self._abilitiesChangedEvent.Event
end

local function GetAbilities(self)
    --[[
      name: GetAbilities
      line: 454
    ]]
    local v34 = {}

    for v35 in self._abilitiesByInputName do
        table.insert(v34, v35)
    end

    return v34
end

local function GetAbilityUIStateChangedSignal(self, a38)
    --[[
      name: GetAbilityUIStateChangedSignal
      line: 432
    ]]
    return self:GetAbilityAttributeChangedSignal(a38, "UIState")
end

local function GetAbilityUIState(self, a41)
    --[[
      name: GetAbilityUIState
      line: 428
    ]]
    return self:GetAbilityAttribute(a41, "UIState", nil)
end

local function GetAbilityAttributeChangedSignal(self, key, abilityChangedEventKey)
    --[[
      name: GetAbilityAttributeChangedSignal
      line: 412
    ]]
    if not self._abilityChangedEvents[abilityChangedEventKey] then
        self._abilityChangedEvents[abilityChangedEventKey] = {}
    end

    if self._abilityChangedEvents[abilityChangedEventKey][key] then
        return self._abilityChangedEvents[abilityChangedEventKey][key].Event
    end

    local bindableEvent = Instance.new("BindableEvent")
    self._abilityChangedEvents[abilityChangedEventKey][key] = bindableEvent
    self:_hookUpAbilityChangedEvent(key, abilityChangedEventKey)

    return bindableEvent.Event
end

local function GetAbilityAttribute(self, key, a50, a51)
    --[[
      name: GetAbilityAttribute
      line: 396
    ]]
    local v52 = self._abilitiesByInputName[key]
    if not v52 then
        return a51
    end

    local syncedState = v52:FindFirstChild("SyncedState")
    if not syncedState then
        return a51
    end

    local v54 = syncedState:GetAttribute(a50)
    if v54 == nil then
        return a51
    end

    return v54
end

local function SendInput(self, key, value)
    --[[
      name: SendInput
      line: 385
    ]]
    if not self:isEnabled() then
        return
    end

    if value ~= self._data[key] then
        self._data[key] = value
        self._avatarAbilities().setAbilityManagerCommand(self._character, key, value)
    end
end

local function GetEnabledChangedSignal(self)
    --[[
      name: GetEnabledChangedSignal
      line: 381
    ]]
    return self._enabledChangedEvent.Event
end

local function isEnabled(self)
    --[[
      name: isEnabled
      line: 377
    ]]
    return (self._humanoid ~= nil) and not self._humanoid.EvaluateStateMachine
end

local function _hookUpAbilityChangedEvent(self, key, a66)
    --[[
      name: _hookUpAbilityChangedEvent
      line: 231
    ]]
    local v67 = self._abilitiesByInputName[key]
    if not v67 then
        return
    end

    local syncedState = v67:FindFirstChild("SyncedState")
    if not syncedState then
        return
    end

    if not self._abilityChangedConnections[a66] then
        self._abilityChangedConnections[a66] = {}
    end

    if self._abilityChangedConnections[a66][key] then
        self._abilityChangedConnections[a66][key]:Disconnect()
        self._abilityChangedConnections[a66][key] = nil
    end

    self._abilityChangedConnections[a66][key] = syncedState:GetAttributeChangedSignal(a66):Connect(
        function()
            --[[
              line: 251
              upvalues:
                self (copy, index: 1)
                a66 (copy, index: 2)
                key (copy, index: 3)
            ]]
            self._abilityChangedEvents[a66][key]:Fire()
        end
    )
end

local function notifyAbilitiesChanged(a70, callback)
    --[[
      name: notifyAbilitiesChanged
      line: 152
    ]]
    local v72 = a70.ChildAdded:Connect(
        function(value)
            --[[
              line: 153
              upvalues:
                callback (copy, index: 1)
            ]]
            if value:IsA("Configuration") then
                callback(value, "added")
            end
        end
    )

    local v74 = a70.ChildRemoved:Connect(
        function(value)
            --[[
              line: 158
              upvalues:
                callback (copy, index: 1)
            ]]
            if value:IsA("Configuration") then
                callback(value, "removed")
            end
        end
    )

    return function()
        --[[
          line: 163
          upvalues:
            v72 (copy, index: 1)
            v74 (copy, index: 2)
        ]]
        v72:Disconnect()
        v74:Disconnect()
    end
end

local function createAbilitiesByInputNameTable(a77)
    --[[
      name: createAbilitiesByInputNameTable
      line: 139
    ]]
    local v78 = {}

    for _, child in a77:GetChildren() do
        if child:IsA("Configuration") then
            local inputName = child:GetAttribute("InputName")
            if not inputName then
                continue
            end

            v78[inputName] = child
        end
    end

    return v78
end

local players = game:GetService("Players")
local CommonUtils = require(script.Parent.Parent:WaitForChild("CommonUtils"))
local v84 = CommonUtils.get("FlagUtil")
local userFlag = v84.getUserFlag("UserPlayerScriptsCCLIntegrationD")
    or v84.getUserFlag("UserPlayerScriptsCCLIntegrationDGA")
local userFlag2 = v84.getUserFlag("UserPlayerScriptsPlayerControlState2")
    or v84.getUserFlag("UserPlayerScriptsPlayerControlState2GA")
local userFlag3 = v84.getUserFlag("UserPlayerScriptsTaskDeferSimulation")
local userFlag4 = v84.getUserFlag("UserPlayerScriptsImportWaitForAbilitiesFolder")
local userFlag5 = v84.getUserFlag("UserAbilitiesUserInterfaceD")

if userFlag4 then
    v1 = nil
else
    local function waitForChildren(a91, a92, a93)
        --[[
          name: waitForChildren
          line: 26
        ]]
        if #a92 == 0 then
            return nil
        end

        local v94

        for _, v96 in a92 do
            v94 = a91:FindFirstChild(v96)

            if v94 then
                return v94
            end
        end

        local v97 = coroutine.running()
        local v98 = nil
        local hasRun = false

        local function settle(a101)
            --[[
              name: settle
              line: 45
              upvalues:
                hasRun (ref,  index: 1)
                v98 (ref,  index: 2)
                v97 (copy, index: 3)
            ]]
            if hasRun then
                return
            end

            hasRun = true
            v98 = a101
            task.spawn(v97)
        end

        local v102 = a91.ChildAdded:Connect(
            function(a103)
                --[[
                  line: 58
                  upvalues:
                    a92 (copy, index: 1)
                    hasRun (ref,  index: 2)
                    v98 (ref,  index: 3)
                    v97 (copy, index: 4)
                ]]
                if table.find(a92, a103.Name) and not hasRun then
                    hasRun = true
                    v98 = a103
                    task.spawn(v97)
                end
            end
        )

        local v104 = if a93
            then task.delay(
                a93,
                function()
                    --[[
                      line: 65
                      upvalues:
                        hasRun (ref,  index: 1)
                        v98 (ref,  index: 2)
                        v97 (copy, index: 3)
                    ]]
                    if hasRun then
                        return
                    end

                    hasRun = true
                    v98 = nil
                    task.spawn(v97)
                end
            )
            else nil
        coroutine.yield()
        v102:Disconnect()

        if v104 and coroutine.status(v104) == "suspended" then
            task.cancel(v104)
        end

        return v98
    end

    v1 = function(a105, a106)
        --[[
          line: 89
          upvalues:
            waitForChildren (copy, index: 1)
        ]]
        if not a105 then
            return nil
        end

        local v107 = if a106 then time() + a106 else nil

        local function getRemainingTime()
            --[[
              name: getRemainingTime
              line: 96
              upvalues:
                v107 (copy, index: 1)
            ]]
            if v107 then
                return (math.max(v107 - time(), 0))
            end

            return nil
        end

        local v109 = {"AbilityManagerActor", "Abilities"}
        local v110 = if v107 then math.max(v107 - time(), 0) else nil
        local children = waitForChildren(a105, v109, v110)
        if not children then
            return nil
        end

        if children.Name == "Abilities" then
            if children:IsA("Folder") then
                return children
            end

            return nil
        end

        local abilities = if const v112 = if v107 then math.max(v107 - time(), 0) else nil then children:WaitForChild("Abilities", v112) else children:WaitForChild("Abilities")

        if abilities and abilities:IsA("Folder") then
            return abilities
        end

        return nil
    end
end

if not userFlag then
    local players2 = game:GetService("Players")
    local v115 = {}
    local abilityManagerActor = nil
    local humanoid = nil
    local bindableEvent = Instance.new("BindableEvent")
    local v119 = nil
    local hasRun = false

    local function characterAdded(a122)
        --[[
          name: characterAdded
          line: 524
          upvalues:
            abilityManagerActor (ref,  index: 1)
            humanoid (ref,  index: 2)
            v119 (ref,  index: 3)
            bindableEvent (copy, index: 4)
        ]]
        abilityManagerActor = nil
        humanoid = nil

        if v119 then
            v119:Disconnect()
            v119 = nil
        end

        if a122 then
            abilityManagerActor = a122:FindFirstChild("AbilityManagerActor")
            humanoid = a122:FindFirstChildOfClass("Humanoid")

            while not humanoid do
                a122.ChildAdded:wait()
                humanoid = a122:FindFirstChildOfClass("Humanoid")
            end

            bindableEvent:Fire()
            v119 = humanoid:GetPropertyChangedSignal("EvaluateStateMachine"):Connect(
                function()
                    --[[
                      line: 543
                      upvalues:
                        bindableEvent (copy, index: 1)
                    ]]
                    bindableEvent:Fire()
                end
            )
        end
    end

    local function lazyInit()
        --[[
          name: lazyInit
          line: 549
          upvalues:
            hasRun (ref,  index: 1)
            players2 (copy, index: 2)
            characterAdded (copy, index: 3)
        ]]
        if hasRun then
            return
        end

        hasRun = true

        if const localPlayer = players2.LocalPlayer then
            localPlayer.characterAdded:Connect(characterAdded)

            if localPlayer.Character then
                characterAdded(localPlayer.Character)
            end
        end
    end

    function v115.isEnabled()
        --[[
          name: isEnabled
          line: 564
          upvalues:
            hasRun (ref,  index: 1)
            players2 (copy, index: 2)
            characterAdded (copy, index: 3)
            abilityManagerActor (ref,  index: 4)
            humanoid (ref,  index: 5)
        ]]
        if not hasRun then
            hasRun = true

            if const localPlayer = players2.LocalPlayer then
                localPlayer.characterAdded:Connect(characterAdded)

                if localPlayer.Character then
                    characterAdded(localPlayer.Character)
                end
            end
        end

        return abilityManagerActor ~= nil and humanoid and not humanoid.EvaluateStateMachine
    end

    function v115.GetEnabledChangedSignal()
        --[[
          name: GetEnabledChangedSignal
          line: 569
          upvalues:
            hasRun (ref,  index: 1)
            players2 (copy, index: 2)
            characterAdded (copy, index: 3)
            bindableEvent (copy, index: 4)
        ]]
        if not hasRun then
            hasRun = true

            if const localPlayer = players2.LocalPlayer then
                localPlayer.characterAdded:Connect(characterAdded)

                if localPlayer.Character then
                    characterAdded(localPlayer.Character)
                end
            end
        end

        return bindableEvent.Event
    end

    return v115
end

local Class = {}
Class.__index = Class
local v128 = {}

players.PlayerRemoving:Connect(
    function(player: Player)
        --[[
          line: 129
          upvalues:
            v128 (copy, index: 1)
        ]]
        wait(1)

        if const v130 = v128[player.UserId] then
            v130:destroy()
            v128[player.UserId] = nil
        end
    end
)

function Class._new(player)
    --[[
      name: _new
      line: 169
      upvalues:
        Class (copy, index: 1)
        userFlag2 (copy, index: 2)
        userFlag3 (copy, index: 3)
    ]]
    local v132 = setmetatable({}, Class)
    v132._player = player
    v132._data = {}
    v132._character = nil
    v132._humanoid = nil
    v132._enabledChangedEvent = Instance.new("BindableEvent")
    v132._abilitiesChangedEvent = Instance.new("BindableEvent")
    v132._evaluateStateMachineChangedConnection = nil
    v132._abilityChangedEvents = {}
    v132._abilityChangedConnections = {}
    v132._abilitiesByInputName = {}
    v132._disconnectAbilitiesChanged = nil

    if not userFlag2 or userFlag3 then
        v132._characterAddedConnection = player.CharacterAdded:Connect(
            function(a133)
                --[[
                  line: 192
                  upvalues:
                    v132 (copy, index: 1)
                ]]
                v132:_onCharacterAdded(a133)
            end
        )
    else
        task.spawn(
            function()
                --[[
                  line: 186
                  upvalues:
                    v132 (copy, index: 1)
                    player (copy, index: 2)
                ]]
                v132._characterAddedConnection = player.CharacterAdded:Connect(
                    function(a134)
                        --[[
                          line: 187
                          upvalues:
                            v132 (copy, index: 1)
                        ]]
                        v132:_onCharacterAdded(a134)
                    end
                )
            end
        )
    end

    if player.Character then
        v132:_onCharacterAdded(player.Character)
    end

    return v132
end

local v135 = nil

function Class._avatarAbilities()
    --[[
      name: _avatarAbilities
      line: 206
      upvalues:
        v135 (ref, index: 1)
    ]]
    if not v135 then
        local instance = if const packages = game:GetService("ReplicatedStorage"):FindFirstChild("Packages") then packages:FindFirstChild("AvatarAbilities") else nil
        v135 = if instance then require(instance) else nil
        v135 = v135 or require("@rbx/AvatarAbilities")
    end

    return v135
end

function Class.get(a138)
    --[[
      name: get
      line: 219
      upvalues:
        v128 (copy, index: 1)
        Class (copy, index: 2)
    ]]
    if not a138 or a138.UserId == 0 then
        return nil
    end

    local v139 = v128[a138.UserId]
    if not v139 then
        v139 = Class._new(a138)
        v128[a138.UserId] = v139
    end

    return v139
end

Class._hookUpAbilityChangedEvent = _hookUpAbilityChangedEvent

function Class._onCharacterAdded(self, character)
    --[[
      name: _onCharacterAdded
      line: 256
      upvalues:
        userFlag4 (copy, index: 1)
        v1 (ref,  index: 2)
        notifyAbilitiesChanged (copy, index: 3)
        createAbilitiesByInputNameTable (copy, index: 4)
    ]]
    self._humanoid = nil
    self._character = character
    self._abilitiesByInputName = {}
    self._data = {}

    if self._disconnectAbilitiesChanged then
        self._disconnectAbilitiesChanged()
        self._disconnectAbilitiesChanged = nil
    end

    for _, abilityChangedConnection in self._abilityChangedConnections do
        for _, v145 in abilityChangedConnection do
            v145:Disconnect()
        end
    end

    self._abilityChangedConnections = {}

    if self._evaluateStateMachineChangedConnection then
        self._evaluateStateMachineChangedConnection:Disconnect()
        self._evaluateStateMachineChangedConnection = nil
    end

    if not self._character then
        return
    end

    local function isStale()
        --[[
          name: isStale
          line: 283
          upvalues:
            self (copy, index: 1)
            character (copy, index: 2)
        ]]
        return self._character ~= character
    end

    task.spawn(
        function()
            --[[
              line: 288
              upvalues:
                userFlag4 (copy, index: 1)
                self (copy, index: 2)
                character (copy, index: 3)
                v1 (ref,  index: 4)
                notifyAbilitiesChanged (copy, index: 5)
                createAbilitiesByInputNameTable (copy, index: 6)
            ]]
            local v147 = if userFlag4 then self._avatarAbilities().waitForAbilitiesFolder(character) else v1(character)

            if v147 and self._character == character then
                local enabledChanged
                local v149
                self._humanoid = character:FindFirstChildOfClass("Humanoid")
                v149 = v147

                while not self._humanoid do
                    character.ChildAdded:Wait()

                    if self._character ~= character then
                        return
                    end

                    self._humanoid = character:FindFirstChildOfClass("Humanoid")
                end

                if self._evaluateStateMachineChangedConnection then
                    self._evaluateStateMachineChangedConnection:Disconnect()
                    self._evaluateStateMachineChangedConnection = nil
                end

                enabledChanged = function()
                    --[[
                      name: enabledChanged
                      line: 313
                      upvalues:
                        self (copy, index: 1)
                        notifyAbilitiesChanged (copy, index: 2)
                        v149 (ref,  index: 3)
                        createAbilitiesByInputNameTable (copy, index: 4)
                    ]]
                    if self._disconnectAbilitiesChanged then
                        self._disconnectAbilitiesChanged()
                        self._disconnectAbilitiesChanged = nil
                    end

                    if self:isEnabled() then
                        self._disconnectAbilitiesChanged = notifyAbilitiesChanged(
                            v149,
                            function(value, a151: string)
                                --[[
                                  line: 320
                                  upvalues:
                                    self (copy, index: 1)
                                ]]
                                local inputName = value:GetAttribute("InputName")
                                if not inputName then
                                    return
                                end

                                if a151 ~= "added" then
                                    if self._abilitiesByInputName[inputName] == value then
                                        self._abilitiesByInputName[inputName] = nil

                                        for _, abilityChangedConnection in self._abilityChangedConnections do
                                            if const v155 = abilityChangedConnection[inputName] then
                                                v155:Disconnect()
                                                abilityChangedConnection[inputName] = nil
                                            end
                                        end
                                    end
                                else
                                    self._abilitiesByInputName[inputName] = value

                                    for v156, abilityChangedEvent in self._abilityChangedEvents do
                                        if abilityChangedEvent[inputName] then
                                            self:_hookUpAbilityChangedEvent(inputName, v156)
                                        end
                                    end
                                end

                                self._abilitiesChangedEvent:Fire()
                            end
                        )

                        self._abilitiesByInputName = createAbilitiesByInputNameTable(v149)
                        self._abilitiesChangedEvent:Fire()

                        for v158, abilityChangedEvent in self._abilityChangedEvents do
                            for v160, v161 in abilityChangedEvent do
                                v161:Fire()
                                self:_hookUpAbilityChangedEvent(v160, v158)
                            end
                        end
                    end

                    self._enabledChangedEvent:Fire()
                end

                self._evaluateStateMachineChangedConnection = self._humanoid:GetPropertyChangedSignal("EvaluateStateMachine"):Connect(
                    function()
                        --[[
                          line: 370
                          upvalues:
                            enabledChanged (copy, index: 1)
                        ]]
                        enabledChanged()
                    end
                )
                enabledChanged()
            end
        end
    )
end

Class.isEnabled = isEnabled
Class.GetEnabledChangedSignal = GetEnabledChangedSignal
Class.SendInput = SendInput
Class.GetAbilityAttribute = GetAbilityAttribute
Class.GetAbilityAttributeChangedSignal = GetAbilityAttributeChangedSignal
Class.GetAbilityUIState = GetAbilityUIState
Class.GetAbilityUIStateChangedSignal = GetAbilityUIStateChangedSignal

if not userFlag5 then
    Class.GetAbilityActive = GetAbilityActive
    Class.GetAbilityActiveChangedSignal = GetAbilityActiveChangedSignal
    Class.GetAbilityValid = GetAbilityValid
    Class.GetAbilityValidChangedSignal = GetAbilityValidChangedSignal
end

Class.GetAbilities = GetAbilities
Class.GetAbilitiesChangedSignal = GetAbilitiesChangedSignal
Class.GetAbilityConfig = GetAbilityConfig
Class.destroy = destroy

return Class