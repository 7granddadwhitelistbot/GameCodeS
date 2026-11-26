local function UnregisterProcessCommandsFunction(self, a3)
    --[[
      name: UnregisterProcessCommandsFunction
      line: 253
    ]]
    if not self.ProcessCommandsFunctions:HasFunction(a3) then
        error(string.format("ProcessCommandsFunction '%s' does not exist", a3))
    end

    self.ProcessCommandsFunctions:RemoveFunction(a3)
end

local function ProcessCommandsFunctionExists(self, a6)
    --[[
      name: ProcessCommandsFunctionExists
      line: 249
    ]]
    return self.ProcessCommandsFunctions:HasFunction(a6)
end

local function RegisterProcessCommandsFunction(self, a9, a10, a11)
    --[[
      name: RegisterProcessCommandsFunction
      line: 242
    ]]
    if self.ProcessCommandsFunctions:HasFunction(a9) then
        error(string.format("ProcessCommandsFunction '%s' already exists", a9))
    end

    self.ProcessCommandsFunctions:AddFunction(a9, a10, a11)
end

local function UnregisterFilterMessageFunction(self, a14)
    --[[
      name: UnregisterFilterMessageFunction
      line: 235
    ]]
    if not self.FilterMessageFunctions:HasFunction(a14) then
        error(string.format("FilterMessageFunction '%s' does not exists", a14))
    end

    self.FilterMessageFunctions:RemoveFunction(a14)
end

local function FilterMessageFunctionExists(self, a17)
    --[[
      name: FilterMessageFunctionExists
      line: 231
    ]]
    return self.FilterMessageFunctions:HasFunction(a17)
end

local function RegisterFilterMessageFunction(self, a20, a21, a22)
    --[[
      name: RegisterFilterMessageFunction
      line: 224
    ]]
    if self.FilterMessageFunctions:HasFunction(a20) then
        error(string.format("FilterMessageFunction '%s' already exists", a20))
    end

    self.FilterMessageFunctions:AddFunction(a20, a21, a22)
end

local function SendGlobalSystemMessage(self, a25)
    --[[
      name: SendGlobalSystemMessage
      line: 218
    ]]
    for _, speaker in pairs(self.Speakers) do
        speaker:SendSystemMessage(a25, nil)
    end
end

local function GetSpeakerList(self)
    --[[
      name: GetSpeakerList
      line: 210
    ]]
    local v30 = {}

    for _, speaker in pairs(self.Speakers) do
        table.insert(v30, speaker.Name)
    end

    return v30
end

local function GetAutoJoinChannelList(self)
    --[[
      name: GetAutoJoinChannelList
      line: 200
    ]]
    local v35 = {}

    for _, chatChannel in pairs(self.ChatChannels) do
        if chatChannel.AutoJoin then
            table.insert(v35, chatChannel)
        end
    end

    return v35
end

local function GetChannelList(self)
    --[[
      name: GetChannelList
      line: 190
    ]]
    local v40 = {}

    for _, chatChannel in pairs(self.ChatChannels) do
        if not chatChannel.Private then
            table.insert(v40, chatChannel.Name)
        end
    end

    return v40
end

local function GetSpeakerByUserOrDisplayName(self, a45)
    --[[
      name: GetSpeakerByUserOrDisplayName
      line: 174
    ]]
    if const speaker = self.Speakers[a45:lower()] then
        return speaker
    end

    for _, speaker2 in pairs(self.Speakers) do
        local player = speaker2:GetPlayer()

        if player and player.DisplayName:lower() == a45:lower() then
            return speaker2
        end
    end
end

local function GetSpeaker(self, a52)
    --[[
      name: GetSpeaker
      line: 170
    ]]
    return self.Speakers[a52:lower()]
end

local function RemoveSpeaker(self, a55)
    --[[
      name: RemoveSpeaker
      line: 151
    ]]
    if self.Speakers[a55:lower()] then
        local name = self.Speakers[a55:lower()].Name
        self:InternalUnmuteSpeaker(name)
        self.Speakers[a55:lower()]:InternalDestroy()
        self.Speakers[a55:lower()] = nil
        local success, result = pcall(
            function()
                --[[
                  line: 160
                  upvalues:
                    self (copy, index: 1)
                    name (copy, index: 2)
                ]]
                self.eSpeakerRemoved:Fire(name)
            end
        )

        if not success and result then
            print("Error removing speaker: " .. result)
        end
    else
        warn("Speaker \"" .. a55 .. "\" does not exist!")
    end
end

local function InternalUnmuteSpeaker(self, a61)
    --[[
      name: InternalUnmuteSpeaker
      line: 143
    ]]
    for _, chatChannel in pairs(self.ChatChannels) do
        if chatChannel:IsSpeakerMuted(a61) then
            chatChannel:UnmuteSpeaker(a61)
        end
    end
end

local function GetChannel(self, a66)
    --[[
      name: GetChannel
      line: 122
    ]]
    return self.ChatChannels[a66:lower()]
end

local function RemoveChannel(self, a69)
    --[[
      name: RemoveChannel
      line: 106
    ]]
    if self.ChatChannels[a69:lower()] then
        local name = self.ChatChannels[a69:lower()].Name
        self.ChatChannels[a69:lower()]:InternalDestroy()
        self.ChatChannels[a69:lower()] = nil
        local success, result = pcall(
            function()
                --[[
                  line: 113
                  upvalues:
                    self (copy, index: 1)
                    name (copy, index: 2)
                ]]
                self.eChannelRemoved:Fire(name)
            end
        )

        if not success and result then
            print("Error removing channel: " .. result)
        end
    else
        warn(string.format("Channel %q does not exist.", a69))
    end
end

local function FormatMessageToSend(a74, a75, a76)
    --[[
      name: FormatMessageToSend
      line: 42
    ]]
    return a76
end

local v77 = {0.05, 0.1, 0.2}
local v78 = {}
local runService = game:GetService("RunService")
local chat = game:GetService("Chat")
chat:WaitForChild("ClientChatModules")
local parent = script.Parent
local clientChatModules = chat:WaitForChild("ClientChatModules")
local v83 = require(clientChatModules:WaitForChild("ChatSettings")).ErrorMessageTextColor
    or Color3.fromRGB(245, 50, 50)
local v84 = {ChatColor = v83}
local childName = "ChatConstants"
local child = require(clientChatModules:WaitForChild(childName))
local ChatChannel = require(parent:WaitForChild("ChatChannel"))
local Speaker = require(parent:WaitForChild("Speaker"))
local childName2 = "Util"
local child2 = require(parent:WaitForChild(childName2))
local v91 = nil
pcall(
    function()
        --[[
          line: 38
          upvalues:
            v91 (ref, index: 1)
        ]]
        v91 = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
    end
)
v91 = v91 or {}

if not v91.FormatMessageToSend or not v91.LocalizeFormattedMessage then
    v91.FormatMessageToSend = FormatMessageToSend
end

local function allSpaces(text: string)
    --[[
      name: allSpaces
      line: 45
    ]]
    return string.len((string.gsub(text, " ", ""))) == 0
end

local Class = {}
Class.__index = Class

function Class.AddChannel(self, a96, autoJoin)
    --[[
      name: AddChannel
      line: 55
      upvalues:
        v91 (ref,  index: 1)
        ChatChannel (copy, index: 2)
        child (copy, index: 3)
    ]]
    if self.ChatChannels[a96:lower()] then
        error(string.format("Channel %q alrady exists.", a96))
    end

    local function DefaultChannelCommands(a99, a100)
        --[[
          name: DefaultChannelCommands
          line: 60
          upvalues:
            self (copy, index: 1)
            a96 (copy, index: 2)
            v91 (ref,  index: 3)
        ]]
        if a100:lower() ~= "/leave" then
            return false
        end

        local channel = self:GetChannel(a96)
        local speaker = self:GetSpeaker(a99)

        if channel and speaker then
            if channel.Leavable then
                speaker:LeaveChannel(a96)
                speaker:SendSystemMessage(v91:FormatMessageToSend("GameChat_ChatService_YouHaveLeftChannel", string.format("You have left channel '%s'", a96), "RBX_NAME", a96), "System")
            else
                speaker:SendSystemMessage(v91:FormatMessageToSend("GameChat_ChatService_CannotLeaveChannel", "You cannot leave this channel."), a96)
            end
        end

        return true
    end

    local chatChannel = ChatChannel.new(self, a96)
    self.ChatChannels[a96:lower()] = chatChannel
    chatChannel:RegisterProcessCommandsFunction("default_commands", DefaultChannelCommands, child.HighPriority)
    local success, result = pcall(
        function()
            --[[
              line: 89
              upvalues:
                self (copy, index: 1)
                a96 (copy, index: 2)
            ]]
            self.eChannelAdded:Fire(a96)
        end
    )

    if not success and result then
        print("Error addding channel: " .. result)
    end

    if autoJoin ~= nil then
        chatChannel.AutoJoin = autoJoin

        if autoJoin then
            for _, speaker in pairs(self.Speakers) do
                speaker:JoinChannel(a96)
            end
        end
    end

    return chatChannel
end

Class.RemoveChannel = RemoveChannel
Class.GetChannel = GetChannel

function Class.AddSpeaker(self, a109)
    --[[
      name: AddSpeaker
      line: 127
      upvalues:
        Speaker (copy, index: 1)
    ]]
    if self.Speakers[a109:lower()] then
        error("Speaker \"" .. a109 .. "\" already exists!")
    end

    local speaker = Speaker.new(self, a109)
    self.Speakers[a109:lower()] = speaker
    local success, result = pcall(
        function()
            --[[
              line: 135
              upvalues:
                self (copy, index: 1)
                a109 (copy, index: 2)
            ]]
            self.eSpeakerAdded:Fire(a109)
        end
    )

    if not success and result then
        print("Error adding speaker: " .. result)
    end

    return speaker
end

Class.InternalUnmuteSpeaker = InternalUnmuteSpeaker
Class.RemoveSpeaker = RemoveSpeaker
Class.GetSpeaker = GetSpeaker
Class.GetSpeakerByUserOrDisplayName = GetSpeakerByUserOrDisplayName
Class.GetChannelList = GetChannelList
Class.GetAutoJoinChannelList = GetAutoJoinChannelList
Class.GetSpeakerList = GetSpeakerList
Class.SendGlobalSystemMessage = SendGlobalSystemMessage
Class.RegisterFilterMessageFunction = RegisterFilterMessageFunction
Class.FilterMessageFunctionExists = FilterMessageFunctionExists
Class.UnregisterFilterMessageFunction = UnregisterFilterMessageFunction
Class.RegisterProcessCommandsFunction = RegisterProcessCommandsFunction
Class.ProcessCommandsFunctionExists = ProcessCommandsFunctionExists
Class.UnregisterProcessCommandsFunction = UnregisterProcessCommandsFunction
local time = 0
local time2 = 0
local v115 = 0

function Class.InternalNotifyFilterIssue(self)
    --[[
      name: InternalNotifyFilterIssue
      line: 263
      upvalues:
        time2 (ref,  index: 1)
        v115 (ref,  index: 2)
        time (ref,  index: 3)
        v91 (ref,  index: 4)
        v84 (copy, index: 5)
    ]]
    if 60 < tick() - time2 then
        v115 = 0
    end

    v115 += 1
    time2 = tick()

    if 3 <= v115 and 60 < tick() - time then
        time = tick()

        if const channel = self:GetChannel("System") then
            channel:SendSystemMessage(v91:FormatMessageToSend("GameChat_ChatService_ChatFilterIssues", "The chat filter is currently experiencing issues and messages may be slow to appear."), v84)
        end
    end
end

local v118 = {}

function Class.InternalApplyRobloxFilter(self, a120, stringToFilter: string, a122)
    --[[
      name: InternalApplyRobloxFilter
      line: 292
      upvalues:
        runService (copy, index: 1)
        chat (copy, index: 2)
        v77 (copy, index: 3)
        v118 (copy, index: 4)
    ]]
    if runService:IsServer() and not runService:IsStudio() then
        local v123 = self:GetSpeaker(a120)
        local speaker = a122 and self:GetSpeaker(a122)

        if v123 == nil then
            return nil
        end

        local playerFrom = v123:GetPlayer()
        v123 = speaker and speaker:GetPlayer()

        if playerFrom == nil then
            return stringToFilter
        end

        if string.len((string.gsub(stringToFilter, " ", ""))) == 0 then
            return stringToFilter
        end

        local result
        local time = tick()
        local count = 0

        while true do
            local success

            success, result = pcall(
                function()
                    --[[
                      line: 315
                      upvalues:
                        v123 (copy, index: 1)
                        chat (copy, index: 2)
                        stringToFilter (copy, index: 3)
                        playerFrom (copy, index: 4)
                    ]]
                    if v123 then
                        return chat:FilterStringAsync(stringToFilter, playerFrom, v123)
                    end

                    return chat:FilterStringForBroadcast(stringToFilter, playerFrom)
                end
            )

            if success then
                break
            end

            warn("Error filtering message:", result)
            count += 1

            if 3 < count or 60 < tick() - time then
                self:InternalNotifyFilterIssue()
                return nil
            end

            local v130 = v77[math.min(#v77, count)]
            wait(v130 + (((math.random() * 2) - 1) * v130))
        end

        return result
    end

    if not v118[stringToFilter] then
        v118[stringToFilter] = true
        wait()
    end

    return stringToFilter
end

function Class.InternalApplyRobloxFilterAndTranslate(self, a132, targetLocales, stringToFilter: string, textContext: Enum.TextFilterContext?)
    --[[
      name: InternalApplyRobloxFilterAndTranslate
      line: 351
      upvalues:
        runService (copy, index: 1)
    ]]
    local v136 = runService:IsServer() and not runService:IsStudio()
    if not v136 then
        wait()
        return true, false, stringToFilter
    end

    local speaker = self:GetSpeaker(a132)
    if speaker == nil then
        return false, nil, nil
    end

    local player = speaker:GetPlayer()
    if player == nil then
        return true, false, stringToFilter
    end

    if string.len((string.gsub(stringToFilter, " ", ""))) == 0 then
        return true, false, stringToFilter
    end

    local success, result = pcall(
        function()
            --[[
              line: 369
              upvalues:
                stringToFilter (copy, index: 1)
                player (copy, index: 2)
                targetLocales (copy, index: 3)
                textContext (copy, index: 4)
            ]]
            local textService = game:GetService("TextService")
            return (textService:FilterAndTranslateStringAsync(stringToFilter, player.UserId, targetLocales, textContext))
        end
    )

    if success then
        return true, true, result
    end

    warn("Error filtering and translating message", stringToFilter, result)
    self:InternalNotifyFilterIssue()

    return false, nil, nil
end

function Class.InternalApplyRobloxFilterNewAPI(self, a143, stringToFilter: string, textContext: Enum.TextFilterContext?)
    --[[
      name: InternalApplyRobloxFilterNewAPI
      line: 388
      upvalues:
        runService (copy, index: 1)
    ]]
    local v146 = runService:IsServer() and not runService:IsStudio()
    if not v146 then
        wait()
        return true, false, stringToFilter
    end

    local speaker = self:GetSpeaker(a143)
    if speaker == nil then
        return false, nil, nil
    end

    local player = speaker:GetPlayer()
    if player == nil then
        return true, false, stringToFilter
    end

    if string.len((string.gsub(stringToFilter, " ", ""))) == 0 then
        return true, false, stringToFilter
    end

    local success, result = pcall(
        function()
            --[[
              line: 407
              upvalues:
                stringToFilter (copy, index: 1)
                player (copy, index: 2)
                textContext (copy, index: 3)
            ]]
            local textService = game:GetService("TextService")
            return (textService:FilterStringAsync(stringToFilter, player.UserId, textContext))
        end
    )

    if success then
        return true, true, result
    end

    warn("Error filtering message:", stringToFilter, result)
    self:InternalNotifyFilterIssue()

    return false, nil, nil
end

function Class.InternalDoMessageFilter(self, a153, a154, a155)
    --[[
      name: InternalDoMessageFilter
      line: 426
    ]]
    local iterator = self.FilterMessageFunctions:GetIterator()

    for v157, v158, _ in iterator do
        local success, result = pcall(
            function()
                --[[
                  line: 430
                  upvalues:
                    v158 (copy, index: 1)
                    a153 (copy, index: 2)
                    a154 (copy, index: 3)
                    a155 (copy, index: 4)
                ]]
                v158(a153, a154, a155)
            end
        )
        if not success then
            warn(string.format("DoMessageFilter Function '%s' failed for reason: %s", v157, result))
        end
    end
end

function Class.InternalDoProcessCommands(self, a163, a164, a165)
    --[[
      name: InternalDoProcessCommands
      line: 440
    ]]
    local iterator = self.ProcessCommandsFunctions:GetIterator()

    for v167, v168, _ in iterator do
        local success, result = pcall(
            function()
                --[[
                  line: 444
                  upvalues:
                    v168 (copy, index: 1)
                    a163 (copy, index: 2)
                    a164 (copy, index: 3)
                    a165 (copy, index: 4)
                ]]
                local v172 = v168(a163, a164, a165)

                if type(v172) ~= "boolean" then
                    error("Process command functions must return a bool")
                end

                return v172
            end
        )

        if success then
            if result then
                return true
            end
        else
            warn(string.format("DoProcessCommands Function '%s' failed for reason: %s", v167, result))
        end
    end

    return false
end

function Class.InternalGetUniqueMessageId(self)
    --[[
      name: InternalGetUniqueMessageId
      line: 462
    ]]
    local messageIdCounter = self.MessageIdCounter
    self.MessageIdCounter = messageIdCounter + 1

    return messageIdCounter
end

function Class.InternalAddSpeakerWithPlayerObject(self, a176, a177, a178)
    --[[
      name: InternalAddSpeakerWithPlayerObject
      line: 468
      upvalues:
        Speaker (copy, index: 1)
    ]]
    if self.Speakers[a176:lower()] then
        error("Speaker \"" .. a176 .. "\" already exists!")
    end

    local speaker = Speaker.new(self, a176)
    speaker:InternalAssignPlayerObject(a177)
    self.Speakers[a176:lower()] = speaker

    if a178 then
        local success, result = pcall(
            function()
                --[[
                  line: 478
                  upvalues:
                    self (copy, index: 1)
                    a176 (copy, index: 2)
                ]]
                self.eSpeakerAdded:Fire(a176)
            end
        )

        if not success and result then
            print("Error adding speaker: " .. result)
        end
    end

    return speaker
end

function Class.InternalFireSpeakerAdded(self, a183)
    --[[
      name: InternalFireSpeakerAdded
      line: 487
    ]]
    local success, result = pcall(
        function()
            --[[
              line: 488
              upvalues:
                self (copy, index: 1)
                a183 (copy, index: 2)
            ]]
            self.eSpeakerAdded:Fire(a183)
        end
    )

    if not success and result then
        print("Error firing speaker added: " .. result)
    end
end

function v78.new()
    --[[
      name: new
      line: 497
      upvalues:
        Class (copy, index: 1)
        child2 (copy, index: 2)
    ]]
    local v186 = setmetatable({}, Class)
    v186.MessageIdCounter = 0
    v186.ChatChannels = {}
    v186.Speakers = {}
    v186.FilterMessageFunctions = child2:NewSortedFunctionContainer()
    v186.ProcessCommandsFunctions = child2:NewSortedFunctionContainer()
    v186.eChannelAdded = Instance.new("BindableEvent")
    v186.eChannelRemoved = Instance.new("BindableEvent")
    v186.eSpeakerAdded = Instance.new("BindableEvent")
    v186.eSpeakerRemoved = Instance.new("BindableEvent")
    v186.ChannelAdded = v186.eChannelAdded.Event
    v186.ChannelRemoved = v186.eChannelRemoved.Event
    v186.SpeakerAdded = v186.eSpeakerAdded.Event
    v186.SpeakerRemoved = v186.eSpeakerRemoved.Event
    v186.ChatServiceMajorVersion = 0
    v186.ChatServiceMinorVersion = 5
    return v186
end

return v78.new()