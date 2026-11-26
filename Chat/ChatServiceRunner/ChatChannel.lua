local success, isUserFeatureEnabled = pcall(
    function()
        --[[
          line: 8
        ]]
        return UserSettings():IsUserFeatureEnabled("UserShouldMuteUnfilteredMessage")
    end
)
local isUserFeatureEnabled2 = success and isUserFeatureEnabled
local success2, isUserFeatureEnabled3 = pcall(
    function()
        --[[
          line: 13
        ]]
        return UserSettings():IsUserFeatureEnabled("UserRemoveMessageOnTextFilterFailures")
    end
)
local isUserFeatureEnabled4 = success2 and isUserFeatureEnabled3
local success3, isUserFeatureEnabled5 = pcall(
    function()
        --[[
          line: 21
        ]]
        return UserSettings():IsUserFeatureEnabled("UserIsChatTranslationEnabled2")
    end
)
local isUserFeatureEnabled6 = success3 and isUserFeatureEnabled5
local v10 = {}
local parent = script.Parent
local chat = game:GetService("Chat")
local runService = game:GetService("RunService")
local clientChatModules = chat:WaitForChild("ClientChatModules")
local ChatSettings = require(clientChatModules:WaitForChild("ChatSettings"))
local ChatConstants = require(clientChatModules:WaitForChild("ChatConstants"))
local Util = require(parent:WaitForChild("Util"))
local v18 = nil
pcall(
    function()
        --[[
          line: 42
          upvalues:
            v18 (ref, index: 1)
        ]]
        v18 = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
    end
)
v18 = v18 or {}

if not v18.FormatMessageToSend or not v18.LocalizeFormattedMessage then
    function v18.FormatMessageToSend(a19, a20, a21)
        --[[
          name: FormatMessageToSend
          line: 46
        ]]
        return a21
    end
end

local Class = {}
Class.__index = Class

function Class.SendSystemMessage(self, a24, a25)
    --[[
      name: SendSystemMessage
      line: 55
    ]]
    local v26 = self:InternalCreateMessageObject(a24, nil, true, a25)
    local success, result = pcall(
        function()
            --[[
              line: 58
              upvalues:
                self (copy, index: 1)
                v26 (copy, index: 2)
            ]]
            self.eMessagePosted:Fire(v26)
        end
    )

    if not success and result then
        print("Error posting message: " .. result)
    end

    self:InternalAddMessageToHistoryLog(v26)

    for _, speaker in pairs(self.Speakers) do
        speaker:InternalSendSystemMessage(v26, self.Name)
    end

    return v26
end

function Class.SendSystemMessageToSpeaker(self, a32, speakerKey, a34)
    --[[
      name: SendSystemMessageToSpeaker
      line: 72
      upvalues:
        runService (copy, index: 1)
    ]]
    if const speaker = self.Speakers[speakerKey] then
        speaker:InternalSendSystemMessage(self:InternalCreateMessageObject(a32, nil, true, a34), self.Name)
        return
    end

    if runService:IsStudio() then
        warn(string.format("Speaker '%s' is not in channel '%s' and cannot be sent a system message", speakerKey, self.Name))
    end
end

function Class.SendMessageObjToFilters(self, message, a38, a39)
    --[[
      name: SendMessageObjToFilters
      line: 82
    ]]
    local previousMessage = a38.Message
    a38.Message = message
    self:InternalDoMessageFilter(a39.Name, a38, self.Name)
    self.ChatService:InternalDoMessageFilter(a39.Name, a38, self.Name)
    local currentMessage = a38.Message
    a38.Message = previousMessage

    return currentMessage
end

function Class.CanCommunicateByUserId(self, userIdFrom: number, userIdTo: number)
    --[[
      name: CanCommunicateByUserId
      line: 92
      upvalues:
        runService (copy, index: 1)
        chat (copy, index: 2)
    ]]
    if runService:IsStudio() then
        return true
    end
    if userIdFrom == 0 or userIdTo == 0 then
        return true
    end

    local success, canUsersChatAsync = pcall(
        function()
            --[[
              line: 100
              upvalues:
                chat (copy, index: 1)
                userIdFrom (copy, index: 2)
                userIdTo (copy, index: 3)
            ]]
            return chat:CanUsersChatAsync(userIdFrom, userIdTo)
        end
    )

    return success and canUsersChatAsync
end

function Class.CanCommunicate(self, a48, a49)
    --[[
      name: CanCommunicate
      line: 106
    ]]
    local player = a48:GetPlayer()
    local player2 = a49:GetPlayer()

    if player and player2 then
        return self:CanCommunicateByUserId(player.UserId, player2.UserId)
    end

    return true
end

function Class.SendMessageToSpeaker(self, a53, speakerKey, a55, a56)
    --[[
      name: SendMessageToSpeaker
      line: 115
      upvalues:
        runService (copy, index: 1)
    ]]
    local speaker = self.Speakers[speakerKey]
    local speaker2 = self.ChatService:GetSpeaker(a55)

    if speaker and speaker2 then
        if speaker:IsSpeakerMuted(a55) then
            return
        end
        if not self:CanCommunicate(speaker, speaker2) then
            return
        end

        local v59 = self:InternalCreateMessageObject(a53, a55, speakerKey == a55, a56)
        a53 = self:SendMessageObjToFilters(a53, v59, a55)
        speaker:InternalSendMessage(v59, self.Name)
        local v60 = self.Private and Enum.TextFilterContext.PrivateChat or Enum.TextFilterContext.PublicChat
        local v61, isFilterResult, filterResult = self.ChatService:InternalApplyRobloxFilterNewAPI(v59.FromSpeaker, a53, v60)
        if v61 then
            v59.FilterResult = filterResult
            v59.IsFilterResult = isFilterResult
            v59.IsFiltered = true
            speaker:InternalSendFilteredMessageWithFilterResult(v59, self.Name)

            return
        end

        return
    end

    if runService:IsStudio() then
        warn(string.format("Speaker '%s' is not in channel '%s' and cannot be sent a message", speakerKey, self.Name))
    end
end

function Class.KickSpeaker(self, a65, a66)
    --[[
      name: KickSpeaker
      line: 151
    ]]
    local formattedText, formattedText2
    local speaker = self.ChatService:GetSpeaker(a65)
    if not speaker then
        error("Speaker \"" .. a65 .. "\" does not exist!")
    end

    local nameForDisplay = speaker:GetNameForDisplay()

    if a66 then
        formattedText = string.format("You were kicked from '%s' for the following reason(s): %s", self.Name, a66)
        formattedText2 = string.format("%s was kicked for the following reason(s): %s", nameForDisplay, a66)
    else
        formattedText = string.format("You were kicked from '%s'", self.Name)
        formattedText2 = string.format("%s was kicked", nameForDisplay)
    end

    self:SendSystemMessageToSpeaker(formattedText, a65)
    speaker:LeaveChannel(self.Name)
    self:SendSystemMessage(formattedText2)
end

function Class.MuteSpeaker(self, a72, a73, a74)
    --[[
      name: MuteSpeaker
      line: 174
    ]]
    local speaker = self.ChatService:GetSpeaker(a72)
    if not speaker then
        error("Speaker \"" .. a72 .. "\" does not exist!")
    end

    self.Mutes[a72:lower()] = if a74 ~= 0 and a74 ~= nil then os.time() + a74 else 0

    if a73 then
        local nameForDisplay = speaker:GetNameForDisplay()
        self:SendSystemMessage(string.format("%s was muted for the following reason(s): %s", nameForDisplay, a73))
    end

    local success, result = pcall(
        function()
            --[[
              line: 188
              upvalues:
                self (copy, index: 1)
                a72 (copy, index: 2)
                a73 (copy, index: 3)
                a74 (copy, index: 4)
            ]]
            self.eSpeakerMuted:Fire(a72, a73, a74)
        end
    )

    if not success and result then
        print("Error mutting speaker: " .. result)
    end

    if const speaker2 = self.ChatService:GetSpeaker(a72) then
        local success2, result2 = pcall(
            function()
                --[[
                  line: 195
                  upvalues:
                    speaker2 (copy, index: 1)
                    self (copy, index: 2)
                    a73 (copy, index: 3)
                    a74 (copy, index: 4)
                ]]
                speaker2.eMuted:Fire(self.Name, a73, a74)
            end
        )

        if not success2 and result2 then
            print("Error mutting speaker: " .. result2)
        end
    end
end

function Class.UnmuteSpeaker(self, a83)
    --[[
      name: UnmuteSpeaker
      line: 203
    ]]
    if not self.ChatService:GetSpeaker(a83) then
        error("Speaker \"" .. a83 .. "\" does not exist!")
    end

    self.Mutes[a83:lower()] = nil
    local success, result = pcall(
        function()
            --[[
              line: 211
              upvalues:
                self (copy, index: 1)
                a83 (copy, index: 2)
            ]]
            self.eSpeakerUnmuted:Fire(a83)
        end
    )

    if not success and result then
        print("Error unmuting speaker: " .. result)
    end

    if const speaker = self.ChatService:GetSpeaker(a83) then
        local success2, result2 = pcall(
            function()
                --[[
                  line: 218
                  upvalues:
                    speaker (copy, index: 1)
                    self (copy, index: 2)
                ]]
                speaker.eUnmuted:Fire(self.Name)
            end
        )

        if not success2 and result2 then
            print("Error unmuting speaker: " .. result2)
        end
    end
end

function Class.IsSpeakerMuted(self, a90)
    --[[
      name: IsSpeakerMuted
      line: 225
    ]]
    return self.Mutes[a90:lower()] ~= nil
end

function Class.GetSpeakerList(self)
    --[[
      name: GetSpeakerList
      line: 229
    ]]
    local v92 = {}

    for _, speaker in pairs(self.Speakers) do
        table.insert(v92, speaker.Name)
    end

    return v92
end

function Class.RegisterFilterMessageFunction(self, a96, a97, a98)
    --[[
      name: RegisterFilterMessageFunction
      line: 237
    ]]
    if self.FilterMessageFunctions:HasFunction(a96) then
        error(string.format("FilterMessageFunction '%s' already exists", a96))
    end

    self.FilterMessageFunctions:AddFunction(a96, a97, a98)
end

function Class.FilterMessageFunctionExists(self, a100)
    --[[
      name: FilterMessageFunctionExists
      line: 244
    ]]
    return self.FilterMessageFunctions:HasFunction(a100)
end

function Class.UnregisterFilterMessageFunction(self, a102)
    --[[
      name: UnregisterFilterMessageFunction
      line: 248
    ]]
    if not self.FilterMessageFunctions:HasFunction(a102) then
        error(string.format("FilterMessageFunction '%s' does not exists", a102))
    end

    self.FilterMessageFunctions:RemoveFunction(a102)
end

function Class.RegisterProcessCommandsFunction(self, a104, a105, a106)
    --[[
      name: RegisterProcessCommandsFunction
      line: 255
    ]]
    if self.ProcessCommandsFunctions:HasFunction(a104) then
        error(string.format("ProcessCommandsFunction '%s' already exists", a104))
    end

    self.ProcessCommandsFunctions:AddFunction(a104, a105, a106)
end

function Class.ProcessCommandsFunctionExists(self, a108)
    --[[
      name: ProcessCommandsFunctionExists
      line: 262
    ]]
    return self.ProcessCommandsFunctions:HasFunction(a108)
end

function Class.UnregisterProcessCommandsFunction(self, a110)
    --[[
      name: UnregisterProcessCommandsFunction
      line: 266
    ]]
    if not self.ProcessCommandsFunctions:HasFunction(a110) then
        error(string.format("ProcessCommandsFunction '%s' does not exist", a110))
    end

    self.ProcessCommandsFunctions:RemoveFunction(a110)
end

local function ShallowCopy(a112)
    --[[
      name: ShallowCopy
      line: 273
    ]]
    local v113 = {}

    for key, v115 in pairs(a112) do
        v113[key] = v115
    end

    return v113
end

function Class.GetHistoryLog(self)
    --[[
      name: GetHistoryLog
      line: 281
    ]]
    local v117 = {}

    for key, v119 in pairs(self.ChatHistory) do
        v117[key] = v119
    end

    return v117
end

function Class.GetHistoryLogForSpeaker(self, a121)
    --[[
      name: GetHistoryLogForSpeaker
      line: 285
      upvalues:
        ChatConstants (copy, index: 1)
    ]]
    local userId = -1
    local player = a121:GetPlayer()
    if player then
        userId = player.UserId
    end

    local v124 = {}

    for index = 1, #self.ChatHistory do
        if self:CanCommunicateByUserId(userId, self.ChatHistory[index].SpeakerUserId) then
            local v126 = {}

            for key, v128 in pairs(self.ChatHistory[index]) do
                v126[key] = v128
            end

            local v129 = false

            if v126.MessageType == ChatConstants.MessageTypeDefault then
                v129 = true
            elseif v126.MessageType == ChatConstants.MessageTypeMeCommand then
                v129 = true
            end

            if v129 then
                local filterResult = v126.FilterResult

                if v126.IsFilterResult then
                    if player then
                        v126.Message = filterResult:GetChatForUserAsync(player.UserId)
                    else
                        v126.Message = filterResult:GetNonChatStringForBroadcastAsync()
                    end
                else
                    v126.Message = filterResult
                end
            end

            table.insert(v124, v126)
        end
    end

    return v124
end

function Class.InternalDestroy(self)
    --[[
      name: InternalDestroy
      line: 323
    ]]
    for _, speaker in pairs(self.Speakers) do
        speaker:LeaveChannel(self.Name)
    end

    self.eDestroyed:Fire()
    self.eDestroyed:Destroy()
    self.eMessagePosted:Destroy()
    self.eSpeakerJoined:Destroy()
    self.eSpeakerLeft:Destroy()
    self.eSpeakerMuted:Destroy()
    self.eSpeakerUnmuted:Destroy()
end

function Class.InternalDoMessageFilter(self, a135, a136, a137)
    --[[
      name: InternalDoMessageFilter
      line: 338
    ]]
    local iterator = self.FilterMessageFunctions:GetIterator()

    for v139, v140, _ in iterator do
        local success, result = pcall(
            function()
                --[[
                  line: 341
                  upvalues:
                    v140 (copy, index: 1)
                    a135 (copy, index: 2)
                    a136 (copy, index: 3)
                    a137 (copy, index: 4)
                ]]
                v140(a135, a136, a137)
            end
        )
        if not success then
            warn(string.format("DoMessageFilter Function '%s' failed for reason: %s", v139, result))
        end
    end
end

function Class.InternalDoProcessCommands(self, a145, a146, a147)
    --[[
      name: InternalDoProcessCommands
      line: 351
    ]]
    local iterator = self.ProcessCommandsFunctions:GetIterator()

    for v149, v150, _ in iterator do
        local success, result = pcall(
            function()
                --[[
                  line: 354
                  upvalues:
                    v150 (copy, index: 1)
                    a145 (copy, index: 2)
                    a146 (copy, index: 3)
                    a147 (copy, index: 4)
                ]]
                local v154 = v150(a145, a146, a147)

                if type(v154) ~= "boolean" then
                    error("Process command functions must return a bool")
                end

                return v154
            end
        )

        if success then
            if result then
                return true
            end
        else
            warn(string.format("DoProcessCommands Function '%s' failed for reason: %s", v149, result))
        end
    end

    return false
end

function getLanguageCodeFromLocale(text)
    --[[
      name: getLanguageCodeFromLocale
      line: 372
    ]]
    return if const v156 = string.gmatch(text, "[^-]+")() then v156 else "en"
end

function Class.InternalPostMessage(self, a158, message, a160)
    --[[
      name: InternalPostMessage
      line: 382
      upvalues:
        v18 (ref,  index: 1)
        chat (copy, index: 2)
        isUserFeatureEnabled2 (ref,  index: 3)
        isUserFeatureEnabled6 (ref,  index: 4)
        isUserFeatureEnabled4 (ref,  index: 5)
    ]]
    local v161
    local v162

    if self:InternalDoProcessCommands(a158.Name, message, self.Name) then
        return false
    end

    if self.Mutes[a158.Name:lower()] ~= nil then
        local mute = self.Mutes[a158.Name:lower()]

        if not (0 < mute) or not (mute < os.time()) then
            self:SendSystemMessageToSpeaker(v18:FormatMessageToSend("GameChat_ChatChannel_MutedInChannel", "You are muted and cannot talk in this channel"), a158.Name)
            return false
        end

        self:UnmuteSpeaker(a158.Name)
    end

    local v164 = self:InternalCreateMessageObject(message, a158.Name, false, a160)
    v164.Message = message
    local v165 = nil
    pcall(
        function()
            --[[
              line: 400
              upvalues:
                v165 (ref,  index: 1)
                chat (copy, index: 2)
                v164 (ref,  index: 3)
            ]]
            v165 = chat:InvokeChatCallback(Enum.ChatCallbackType.OnServerReceivingMessage, v164)
        end
    )
    v164.Message = nil

    if v165 then
        if v165.ShouldDeliver == false then
            return false
        end

        v164 = v165
    end

    local message2 = self:SendMessageObjToFilters(message, v164, a158)
    local v167 = {}

    for _, speaker in pairs(self.Speakers) do
        if not speaker:IsSpeakerMuted(a158.Name) then
            if not self:CanCommunicate(a158, speaker) then
                continue
            end

            table.insert(v167, speaker.Name)

            if speaker.Name == a158.Name then
                local v170 = {}

                for key, v172 in pairs(v164) do
                    v170[key] = v172
                end

                if isUserFeatureEnabled2 then
                    local v173 = v164.MessageLengthUtf8 or v164.MessageLength
                    v170.Message = string.rep("_", v173)
                else
                    v170.Message = message2
                end

                v170.IsFiltered = true
                speaker:InternalSendMessage(v170, self.Name)
            else
                speaker:InternalSendMessage(v164, self.Name)
            end
        end
    end

    local success, result = pcall(
        function()
            --[[
              line: 439
              upvalues:
                self (copy, index: 1)
                v164 (ref,  index: 2)
            ]]
            self.eMessagePosted:Fire(v164)
        end
    )

    if not success and result then
        print("Error posting message: " .. result)
    end

    local v176 = self.Private and Enum.TextFilterContext.PrivateChat or Enum.TextFilterContext.PublicChat
    local v177 = nil
    local isFilterResult, filterResult

    if isUserFeatureEnabled6 then
        local filterResult2
        local v181 = {}
        local v182 = {}

        for _, speaker in pairs(self.Speakers) do
            local player = speaker:GetPlayer()

            if player ~= nil and player.LocaleId ~= nil then
                v182[getLanguageCodeFromLocale(player.LocaleId)] = true
            end
        end

        for v186, _ in v182 do
            table.insert(v181, v186)
        end

        local v188, isFilterResult2
        v188, isFilterResult2, filterResult2 = self.ChatService:InternalApplyRobloxFilterAndTranslate(v164.FromSpeaker, v181, message2, v176)

        if v188 then
            if isFilterResult2 then
                local sourceText = filterResult2.SourceText
                v164.FilterResult = sourceText
            else
                v164.FilterResult = filterResult2
            end

            v164.IsFilterResult = isFilterResult2
            v162, v177 = v167, if isFilterResult2 then filterResult2 else v177
        else
            if not isUserFeatureEnabled4 then
                return false
            end

            v164.IsFilterResult = false
            v164.FilterResult = ""
            v164.MessageLength = 0
            v162 = v167
        end
    else
        v161, isFilterResult, filterResult = self.ChatService:InternalApplyRobloxFilterNewAPI(v164.FromSpeaker, message2, v176)

        if v161 then
            v164.FilterResult = filterResult
            v164.IsFilterResult = isFilterResult
            v162 = v167
        else
            if not isUserFeatureEnabled4 then
                return false
            end

            v164.IsFilterResult = false
            v164.FilterResult = ""
            v164.MessageLength = 0
            v162 = v167
        end
    end

    v164.IsFiltered = true
    self:InternalAddMessageToHistoryLog(v164)

    for _, speakerKey in pairs(v162) do
        if const speaker = self.Speakers[speakerKey] then
            local v194 = isUserFeatureEnabled6
                and v177
                and a158:GetPlayer() ~= nil
                and speaker:GetPlayer() ~= nil
                and a158:GetPlayer().LocaleId ~= speaker:GetPlayer().LocaleId

            if v194 then
                speaker:InternalSendFilteredMessageWithTranslatedFilterResult(v164, self.Name, v177)
            else
                speaker:InternalSendFilteredMessageWithFilterResult(v164, self.Name)
            end
        end
    end

    local v195 = {}

    for _, speaker in pairs(self.Speakers) do
        if not speaker:IsSpeakerMuted(a158.Name) and self:CanCommunicate(a158, speaker) then
            local v198 = false

            for _, v200 in pairs(v162) do
                if speaker.Name == v200 then
                    v198 = true
                    break
                end
            end

            if not v198 then
                table.insert(v195, speaker.Name)
            end
        end
    end

    for _, speakerKey in pairs(v195) do
        if const speaker = self.Speakers[speakerKey] then
            speaker:InternalSendFilteredMessageWithFilterResult(v164, self.Name)
        end
    end

    return v164
end

function Class.InternalAddSpeaker(self, a205)
    --[[
      name: InternalAddSpeaker
      line: 551
    ]]
    if self.Speakers[a205.Name] then
        warn("Speaker \"" .. a205.name .. "\" is already in the channel!")
        return
    end

    self.Speakers[a205.Name] = a205
    local success, result = pcall(
        function()
            --[[
              line: 558
              upvalues:
                self (copy, index: 1)
                a205 (copy, index: 2)
            ]]
            self.eSpeakerJoined:Fire(a205.Name)
        end
    )

    if not success and result then
        print("Error removing channel: " .. result)
    end
end

function Class.InternalRemoveSpeaker(self, a209)
    --[[
      name: InternalRemoveSpeaker
      line: 564
    ]]
    if not self.Speakers[a209.Name] then
        warn("Speaker \"" .. a209.name .. "\" is not in the channel!")
        return
    end

    self.Speakers[a209.Name] = nil
    local success, result = pcall(
        function()
            --[[
              line: 571
              upvalues:
                self (copy, index: 1)
                a209 (copy, index: 2)
            ]]
            self.eSpeakerLeft:Fire(a209.Name)
        end
    )

    if not success and result then
        print("Error removing speaker: " .. result)
    end
end

function Class.InternalRemoveExcessMessagesFromLog(self)
    --[[
      name: InternalRemoveExcessMessagesFromLog
      line: 577
    ]]
    local tableRemove = table.remove

    while true do
        local chatHistoryLength = #self.ChatHistory

        if not (self.MaxHistory < chatHistoryLength) then
            break
        end

        tableRemove(self.ChatHistory, 1)
    end
end

function Class.InternalAddMessageToHistoryLog(self, a216)
    --[[
      name: InternalAddMessageToHistoryLog
      line: 584
    ]]
    table.insert(self.ChatHistory, a216)
    self:InternalRemoveExcessMessagesFromLog()
end

function Class.GetMessageType(self, a218, a219)
    --[[
      name: GetMessageType
      line: 590
      upvalues:
        ChatConstants (copy, index: 1)
    ]]
    if a219 == nil then
        return ChatConstants.MessageTypeSystem
    end

    return ChatConstants.MessageTypeDefault
end

function Class.InternalCreateMessageObject(self, text: string, fromSpeaker, isFiltered, a224)
    --[[
      name: InternalCreateMessageObject
      line: 597
      upvalues:
        ChatSettings (copy, index: 1)
    ]]
    local message
    local messageType = self:GetMessageType(text, fromSpeaker)
    local userId = -1
    local speakerDisplayName = nil
    local speaker = nil

    if fromSpeaker then
        speaker = self.ChatService:GetSpeaker(fromSpeaker)

        if speaker then
            if const player = speaker:GetPlayer() then
                userId = player.UserId

                if ChatSettings.PlayerDisplayNamesEnabled then
                    speakerDisplayName = speaker:GetNameForDisplay()
                end
            else
                userId = 0
            end
        end
    end

    local v231 = {ID = self.ChatService:InternalGetUniqueMessageId(), FromSpeaker = fromSpeaker, SpeakerDisplayName = speakerDisplayName, SpeakerUserId = userId, OriginalChannel = self.Name, MessageLength = string.len(text), MessageLengthUtf8 = utf8.len(utf8.nfcnormalize(text)), MessageType = messageType, IsFiltered = isFiltered}

    if not isFiltered or not text then
        message = nil
    else
        message = text
    end

    v231.Message = message
    v231.Time = os.time()
    v231.ExtraData = {}

    if speaker then
        for key, v233 in pairs(speaker.ExtraData) do
            v231.ExtraData[key] = v233
        end
    end

    if a224 then
        for key, v235 in pairs(a224) do
            v231.ExtraData[key] = v235
        end
    end

    return v231
end

function Class.SetChannelNameColor(self, channelNameColor)
    --[[
      name: SetChannelNameColor
      line: 657
    ]]
    self.ChannelNameColor = channelNameColor

    for _, speaker in pairs(self.Speakers) do
        speaker:UpdateChannelNameColor(self.Name, channelNameColor)
    end
end

function Class.GetWelcomeMessageForSpeaker(self, a241)
    --[[
      name: GetWelcomeMessageForSpeaker
      line: 664
    ]]
    if self.GetWelcomeMessageFunction then
        if const welcomeMessageFunction = self.GetWelcomeMessageFunction(a241) then
            return welcomeMessageFunction
        end
    end

    return self.WelcomeMessage
end

function Class.RegisterGetWelcomeMessageFunction(self, getWelcomeMessageFunction)
    --[[
      name: RegisterGetWelcomeMessageFunction
      line: 674
    ]]
    if type(getWelcomeMessageFunction) ~= "function" then
        error("RegisterGetWelcomeMessageFunction must be called with a function.")
    end

    self.GetWelcomeMessageFunction = getWelcomeMessageFunction
end

function Class.UnRegisterGetWelcomeMessageFunction(self)
    --[[
      name: UnRegisterGetWelcomeMessageFunction
      line: 681
    ]]
    self.GetWelcomeMessageFunction = nil
end

function v10.new(chatService, name, a248, channelNameColor)
    --[[
      name: new
      line: 688
      upvalues:
        Class (copy, index: 1)
        Util (copy, index: 2)
    ]]
    local v250 = setmetatable({}, Class)
    v250.ChatService = chatService
    v250.Name = name
    v250.WelcomeMessage = a248 or ""
    v250.GetWelcomeMessageFunction = nil
    v250.ChannelNameColor = channelNameColor
    v250.Joinable = true
    v250.Leavable = true
    v250.AutoJoin = false
    v250.Private = false
    v250.Speakers = {}
    v250.Mutes = {}
    v250.MaxHistory = 200
    v250.HistoryIndex = 0
    v250.ChatHistory = {}
    v250.FilterMessageFunctions = Util:NewSortedFunctionContainer()
    v250.ProcessCommandsFunctions = Util:NewSortedFunctionContainer()
    v250.eDestroyed = Instance.new("BindableEvent")
    v250.eMessagePosted = Instance.new("BindableEvent")
    v250.eSpeakerJoined = Instance.new("BindableEvent")
    v250.eSpeakerLeft = Instance.new("BindableEvent")
    v250.eSpeakerMuted = Instance.new("BindableEvent")
    v250.eSpeakerUnmuted = Instance.new("BindableEvent")
    v250.MessagePosted = v250.eMessagePosted.Event
    v250.SpeakerJoined = v250.eSpeakerJoined.Event
    v250.SpeakerLeft = v250.eSpeakerLeft.Event
    v250.SpeakerMuted = v250.eSpeakerMuted.Event
    v250.SpeakerUnmuted = v250.eSpeakerUnmuted.Event
    v250.Destroyed = v250.eDestroyed.Event
    return v250
end

return v10