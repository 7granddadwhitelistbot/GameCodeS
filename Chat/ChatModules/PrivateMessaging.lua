local function FormatMessageToSend(a2, a3, a4)
    --[[
      name: FormatMessageToSend
      line: 20
    ]]
    return a4
end

local chat = game:GetService("Chat")
local runService = game:GetService("RunService")
local textChatService = game:GetService("TextChatService")
local clientChatModules = chat:WaitForChild("ClientChatModules")
local chatModules = chat:WaitForChild("ChatModules")
local ChatConstants = require(clientChatModules:WaitForChild("ChatConstants"))
local ChatSettings = require(clientChatModules:WaitForChild("ChatSettings"))
local DisplayNameHelpers = require(chatModules.Utility.DisplayNameHelpers)
local v13 = nil
pcall(
    function()
        --[[
          line: 17
          upvalues:
            v13 (ref, index: 1)
        ]]
        v13 = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
    end
)

if v13 == nil then
    v13 = {}
end

if not v13.FormatMessageToSend or not v13.LocalizeFormattedMessage then
    v13.FormatMessageToSend = FormatMessageToSend
end

local v14 = ChatSettings.ErrorMessageTextColor or Color3.fromRGB(245, 50, 50)
local v15 = {ChatColor = v14}
local isUserFeatureEnabled = false
local success, isUserFeatureEnabled2 = pcall(
    function()
        --[[
          line: 27
        ]]
        return UserSettings():IsUserFeatureEnabled("UserUseNewDirectChatAPI")
    end
)
if success then
    isUserFeatureEnabled = isUserFeatureEnabled2
end

local function GetWhisperChannelPrefix()
    --[[
      name: GetWhisperChannelPrefix
      line: 35
      upvalues:
        ChatConstants (copy, index: 1)
    ]]
    if ChatConstants.WhisperChannelPrefix then
        return ChatConstants.WhisperChannelPrefix
    end

    return "To "
end

local function GetWhisperChannelId(a21)
    --[[
      name: GetWhisperChannelId
      line: 42
      upvalues:
        ChatConstants (copy, index: 1)
    ]]
    local v22 = not ChatConstants.WhisperChannelPrefix and "To " or ChatConstants.WhisperChannelPrefix
    return v22 .. a21
end

return function(a23)
    --[[
      name: Run
      line: 46
      upvalues:
        runService (copy, index: 1)
        isUserFeatureEnabled (ref,  index: 2)
        textChatService (copy, index: 3)
        chat (copy, index: 4)
        ChatSettings (copy, index: 5)
        DisplayNameHelpers (copy, index: 6)
        v13 (ref,  index: 7)
        v15 (copy, index: 8)
        ChatConstants (copy, index: 9)
    ]]
    local function CanCommunicate(speaker, speaker2)
        --[[
          name: CanCommunicate
          line: 48
          upvalues:
            runService (copy, index: 1)
            isUserFeatureEnabled (ref,  index: 2)
            textChatService (copy, index: 3)
            chat (copy, index: 4)
        ]]
        if runService:IsStudio() then
            return true
        end

        local player = speaker:GetPlayer()
        local player2 = speaker2:GetPlayer()

        if not player or not player2 then
            return false
        end

        if isUserFeatureEnabled then
            local success, canUsersDirectChatAsync = pcall(
                function()
                    --[[
                      line: 56
                      upvalues:
                        textChatService (copy, index: 1)
                        player (copy, index: 2)
                        player2 (copy, index: 3)
                    ]]
                    return textChatService:CanUsersDirectChatAsync(player.UserId, {player2.UserId})
                end
            )
            return success and (0 < #canUsersDirectChatAsync)
        end

        local success, canUsersChatAsync = pcall(
            function()
                --[[
                  line: 61
                  upvalues:
                    chat (copy, index: 1)
                    player (copy, index: 2)
                    player2 (copy, index: 3)
                ]]
                return chat:CanUsersChatAsync(player.UserId, player2.UserId)
            end
        )

        return success and canUsersChatAsync
    end

    local function DoWhisperCommand(a34, substring: string, a36)
        --[[
          name: DoWhisperCommand
          line: 70
          upvalues:
            a23 (copy, index: 1)
            ChatSettings (copy, index: 2)
            DisplayNameHelpers (copy, index: 3)
            v13 (ref,  index: 4)
            v15 (copy, index: 5)
            ChatConstants (copy, index: 6)
            CanCommunicate (copy, index: 7)
        ]]
        local text
        local userName, v39
        local speaker = a23:GetSpeaker(a34)
        local substring2 = nil

        if string.sub(substring, 1, 1) ~= "\"" then
            if const v42 = string.match(substring, "^[^%s]+") then
                text = v42
                substring2 = string.sub(substring, string.len(text) + 2)
            else
                text = substring
            end
        elseif const startIndex = string.find(substring, "\"", 2) then
            text = string.sub(substring, 2, startIndex - 1)
            substring2 = string.sub(substring, startIndex + 2)
        else
            text = substring
        end

        if not ChatSettings.PlayerDisplayNamesEnabled or not ChatSettings.WhisperByDisplayNameEnabled then
            userName, v39 = DisplayNameHelpers.getUserNameFromChattedName(text, a34, nil)
        else
            userName, v39 = DisplayNameHelpers.getUserNameFromChattedName(text, a34, speaker:GetNameForDisplay())
        end

        local speaker2 = a23:GetSpeaker(userName)

        if v39 == DisplayNameHelpers.CommandErrorCodes.ChattingToSelf then
            speaker:SendSystemMessage(v13:FormatMessageToSend("GameChat_PrivateMessaging_CannotWhisperToSelf", "You cannot whisper to yourself."), a36, v15)
            return
        end

        if v39 == DisplayNameHelpers.CommandErrorCodes.NoMatches then
            speaker:SendSystemMessage(v13:FormatMessageToSend("GameChat_MuteSpeaker_SpeakerDoesNotExist", string.format("Speaker '%s' does not exist.", (tostring(text))), "RBX_NAME", (tostring(userName))), a36, v15)
            return
        end

        if v39 == DisplayNameHelpers.CommandErrorCodes.MultipleMatches then
            local users = DisplayNameHelpers.getUsersWithDisplayNameString(text, a34)
            speaker:SendSystemMessage(v13:FormatMessageToSend("InGame.Chat.Response.DisplayNameMultipleMatches", "Warning: The following users have this display name: "), a36, v15)
            speaker:SendSystemMessage(users, a36, v15)

            return
        end

        if speaker2 then
            local v46 = not ChatConstants.WhisperChannelPrefix and "To " or ChatConstants.WhisperChannelPrefix

            if const channel = a23:GetChannel(v46 .. userName) then
                if not CanCommunicate(speaker, speaker2) then
                    speaker:SendSystemMessage(v13:FormatMessageToSend("GameChat_PrivateMessaging_CannotChat", "You are not able to chat with this player."), a36, v15)
                    return
                end

                if not speaker:IsInChannel(channel.Name) then
                    speaker:JoinChannel(channel.Name)
                end

                if substring2 and 0 < string.len(substring2) then
                    speaker:SayMessage(substring2, channel.Name)
                end

                speaker:SetMainChannel(channel.Name)

                return
            end

            speaker:SendSystemMessage(v13:FormatMessageToSend("GameChat_MuteSpeaker_SpeakerDoesNotExist", string.format("Speaker '%s' does not exist.", (tostring(text))), "RBX_NAME", (tostring(userName))), a36, v15)
        end
    end

    local function PrivateMessageReplicationFunction(a49, a50, text: string)
        --[[
          name: PrivateMessageReplicationFunction
          line: 163
          upvalues:
            a23 (copy, index: 1)
            ChatConstants (copy, index: 2)
        ]]
        local whisperChannelPrefix
        local speaker = a23:GetSpeaker(a49)
        local extraData = speaker.ExtraData
        speaker:SendMessage(a50, text, a49, extraData)
        local speaker2 = a23:GetSpeaker((string.sub(text, 4)))

        if ChatConstants.WhisperChannelPrefix then
            whisperChannelPrefix = ChatConstants.WhisperChannelPrefix
        else
            whisperChannelPrefix = "To "
        end

        local v56 = whisperChannelPrefix .. a49

        if speaker2 then
            if not speaker2:IsInChannel(v56) then
                speaker2:JoinChannel(v56)
            end

            speaker2:SendMessage(a50, v56, a49, extraData)
        end

        return true
    end

    local function PrivateMessageAddTypeFunction(a58, a59, a60)
        --[[
          name: PrivateMessageAddTypeFunction
          line: 181
          upvalues:
            ChatConstants (copy, index: 1)
        ]]
        if ChatConstants.MessageTypeWhisper then
            a59.MessageType = ChatConstants.MessageTypeWhisper
        end
    end

    a23:RegisterProcessCommandsFunction(
        "whisper_commands",
        function(a61, text: string, a63)
            --[[
              name: WhisperCommandsFunction
              line: 147
              upvalues:
                DoWhisperCommand (copy, index: 1)
            ]]
            if string.sub(text, 1, 3):lower() == "/w " then
                DoWhisperCommand(a61, string.sub(text, 4), a63)
                return true
            end

            if string.sub(text, 1, 9):lower() ~= "/whisper " then
                return false
            end

            DoWhisperCommand(a61, string.sub(text, 10), a63)

            return true
        end,
        ChatConstants.StandardPriority
    )

    local function GetWhisperChanneNameColor()
        --[[
          name: GetWhisperChanneNameColor
          line: 189
          upvalues:
            ChatSettings (copy, index: 1)
        ]]
        if ChatSettings.WhisperChannelNameColor then
            return ChatSettings.WhisperChannelNameColor
        end

        return Color3.fromRGB(102, 14, 102)
    end

    a23.SpeakerAdded:connect(
        function(a65)
            --[[
              line: 196
              upvalues:
                a23 (copy, index: 1)
                ChatSettings (copy, index: 2)
                ChatConstants (copy, index: 3)
                v13 (ref,  index: 4)
                PrivateMessageReplicationFunction (copy, index: 5)
                PrivateMessageAddTypeFunction (copy, index: 6)
            ]]
            local v66
            local speaker = a23:GetSpeaker(a65)
            local v68 = if ChatSettings.PlayerDisplayNamesEnabled and speaker:GetPlayer() then speaker:GetNameForDisplay() .. "(@" .. a65 .. ")" else a65
            local v69 = not ChatConstants.WhisperChannelPrefix and "To " or ChatConstants.WhisperChannelPrefix
            local v70 = v69 .. a65

            if a23:GetChannel(v70) then
                a23:RemoveChannel(v70)
            end

            local v71 = a23:AddChannel(v70)
            v71.Joinable = false
            v71.Leavable = true
            v71.AutoJoin = false
            v71.Private = true
            local v72 = v13
            v71.WelcomeMessage = v72:FormatMessageToSend("GameChat_PrivateMessaging_NowChattingWith", "You are now privately chatting with " .. v68 .. ".", "RBX_NAME", (tostring(v68)))

            if ChatSettings.WhisperChannelNameColor then
                v66 = ChatSettings.WhisperChannelNameColor
            else
                v66 = Color3.fromRGB(102, 14, 102)
            end

            v71.ChannelNameColor = v66
            v71:RegisterProcessCommandsFunction("replication_function", PrivateMessageReplicationFunction, ChatConstants.LowPriority)
            v71:RegisterFilterMessageFunction("message_type_function", PrivateMessageAddTypeFunction)
        end
    )

    a23.SpeakerRemoved:connect(
        function(a73)
            --[[
              line: 228
              upvalues:
                ChatConstants (copy, index: 1)
                a23 (copy, index: 2)
            ]]
            local v74 = not ChatConstants.WhisperChannelPrefix and "To " or ChatConstants.WhisperChannelPrefix
            local v75 = v74 .. a73

            if a23:GetChannel(v75) then
                a23:RemoveChannel(v75)
            end
        end
    )
end