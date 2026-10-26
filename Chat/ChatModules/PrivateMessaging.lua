local Chat_upv_1 = game:GetService("Chat")
local RunService_upv_1 = game:GetService("RunService")
local TextChatService_upv_1 = game:GetService("TextChatService")
local ClientChatModules_1 = Chat_upv_1:WaitForChild("ClientChatModules")
local ChatModules_1 = Chat_upv_1:WaitForChild("ChatModules")
local ChatConstants_upv_1 = require(ClientChatModules_1:WaitForChild("ChatConstants"))
local ChatSettings_upv_1 = require(ClientChatModules_1:WaitForChild("ChatSettings"))
local DisplayNameHelpers_upv_1 = require(ChatModules_1.Utility.DisplayNameHelpers)
local u1 = nil
pcall(
    function()
        --[[
          line: 17
          upvalues:
            u1 (ref, index: 1)
        ]]
        u1 = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
    end
)
if u1 == nil then
    u1 = {}
end
if not (u1.FormatMessageToSend) or not (u1.LocalizeFormattedMessage) then
    function u1.FormatMessageToSend(a1, a2, a3)
        --[[
          name: FormatMessageToSend
          line: 20
        ]]
        return a3
    end
end
local v1 = ChatSettings_upv_1.ErrorMessageTextColor or (Color3.fromRGB(245, 50, 50))
local tbl_upv_1 = {}
tbl_upv_1.ChatColor = v1
local u2 = false
local success_1, v2 = pcall(
    function()
        --[[
          line: 27
        ]]
        return UserSettings():IsUserFeatureEnabled("UserUseNewDirectChatAPI")
    end
)
if success_1 then
    u2 = v2
end
local function GetWhisperChannelPrefix()
    --[[
      name: GetWhisperChannelPrefix
      line: 35
      upvalues:
        ChatConstants_upv_1 (copy, index: 1)
    ]]
    if ChatConstants_upv_1.WhisperChannelPrefix then
        return ChatConstants_upv_1.WhisperChannelPrefix
    end
    return "To "
end
local function GetWhisperChannelId(a1)
    --[[
      name: GetWhisperChannelId
      line: 42
      upvalues:
        ChatConstants_upv_1 (copy, index: 1)
    ]]
    return ((ChatConstants_upv_1.WhisperChannelPrefix) or "To ") .. a1
end
local function Run(a1)
    --[[
      name: Run
      line: 46
      upvalues:
        u2 (ref,  index: 2)
        TextChatService_upv_1 (copy, index: 3)
        Chat_upv_1 (copy, index: 4)
        ChatSettings_upv_1 (copy, index: 5)
        DisplayNameHelpers_upv_1 (copy, index: 6)
        u1 (ref,  index: 7)
        tbl_upv_1 (copy, index: 8)
    ]]
    local function CanCommunicate_upv_1(a2, a3)
        --[[
          name: CanCommunicate
          line: 48
          upvalues:
            u2 (ref,  index: 2)
            TextChatService_upv_1 (copy, index: 3)
            Chat_upv_1 (copy, index: 4)
        ]]
        if RunService_upv_1:IsStudio() then
            return true
        end
        local u3 = a2:GetPlayer()
        local u4 = a3:GetPlayer()
        if u3 and u4 then
            if u2 then
                local success_2, v3 = pcall(
                    function()
                        --[[
                          line: 56
                          upvalues:
                            TextChatService_upv_1 (copy, index: 1)
                            u3 (copy, index: 2)
                            u4 (copy, index: 3)
                        ]]
                        return TextChatService_upv_1:CanUsersDirectChatAsync(u3.UserId, {u4.UserId})
                    end
                )
                return success_2 and (#v3 > 0)
            else
                local success_3, v4 = pcall(
                    function()
                        --[[
                          line: 61
                          upvalues:
                            Chat_upv_1 (copy, index: 1)
                            u3 (copy, index: 2)
                            u4 (copy, index: 3)
                        ]]
                        return Chat_upv_1:CanUsersChatAsync(u3.UserId, u4.UserId)
                    end
                )
                return success_3 and v4
            end
        end
        return false
    end
    local function DoWhisperCommand_upv_1(a4, a5, a6)
        --[[
          name: DoWhisperCommand
          line: 70
          upvalues:
            a1 (copy, index: 1)
            ChatSettings_upv_1 (copy, index: 2)
            DisplayNameHelpers_upv_1 (copy, index: 3)
            u1 (ref,  index: 4)
            tbl_upv_1 (copy, index: 5)
            CanCommunicate_upv_1 (copy, index: 7)
        ]]
        local v5 = a1:GetSpeaker(a4)
        local v6 = nil
        local v7, v8, v9 = nil, nil, nil
        if string.sub(a5, 1, 1) ~= "\"" then
            v7 = string.match(a5, "^[^%s]+")
            if v7 then
                v6 = string.sub(a5, string.len(v7) + 2)
            else
                v8 = a5
            end
        else
            v9 = string.find(a5, "\"", 2)
            if v9 then
                v8 = string.sub(a5, 2, v9 - 1)
                v6 = string.sub(a5, v9 + 2)
            else
                v8 = a5
            end
        end
        local v10 = nil
        if (ChatSettings_upv_1.PlayerDisplayNamesEnabled) and (ChatSettings_upv_1.WhisperByDisplayNameEnabled) then
            local v11, v10 = DisplayNameHelpers_upv_1.getUserNameFromChattedName(v8, a4, v5:GetNameForDisplay())
            v9 = v11
        else
            local v12, v10 = DisplayNameHelpers_upv_1.getUserNameFromChattedName(v8, a4, nil)
            v9 = v12
        end
        local v13 = a1:GetSpeaker(v9)
        if v10 == DisplayNameHelpers_upv_1.CommandErrorCodes.ChattingToSelf then
            v5:SendSystemMessage(u1:FormatMessageToSend("GameChat_PrivateMessaging_CannotWhisperToSelf", "You cannot whisper to yourself."), a6, tbl_upv_1)
        elseif v10 == DisplayNameHelpers_upv_1.CommandErrorCodes.NoMatches then
            v5:SendSystemMessage(u1:FormatMessageToSend("GameChat_MuteSpeaker_SpeakerDoesNotExist", string.format("Speaker '%s' does not exist.", tostring(v8)), "RBX_NAME", tostring(v9)), a6, tbl_upv_1)
        elseif v10 == DisplayNameHelpers_upv_1.CommandErrorCodes.MultipleMatches then
            local v14 = DisplayNameHelpers_upv_1.getUsersWithDisplayNameString(v8, a4)
            v5:SendSystemMessage(u1:FormatMessageToSend("InGame.Chat.Response.DisplayNameMultipleMatches", "Warning: The following users have this display name: "), a6, tbl_upv_1)
            v5:SendSystemMessage(v14, a6, tbl_upv_1)
        elseif v13 then
            local v15 = a1:GetChannel(((ChatConstants_upv_1.WhisperChannelPrefix) or "To ") .. v9)
            if v15 then
                if CanCommunicate_upv_1(v5, v13) then
                    if not (v5:IsInChannel(v15.Name)) then
                        v5:JoinChannel(v15.Name)
                    end
                    if v6 and string.len(v6) > 0 then
                        v5:SayMessage(v6, v15.Name)
                    end
                    v5:SetMainChannel(v15.Name)
                else
                    v5:SendSystemMessage(u1:FormatMessageToSend("GameChat_PrivateMessaging_CannotChat", "You are not able to chat with this player."), a6, tbl_upv_1)
                end
                return
            end
            v5:SendSystemMessage(u1:FormatMessageToSend("GameChat_MuteSpeaker_SpeakerDoesNotExist", string.format("Speaker '%s' does not exist.", tostring(v8)), "RBX_NAME", tostring(v9)), a6, tbl_upv_1)
        end
    end
    local function PrivateMessageReplicationFunction_upv_1(a7, a8, a9)
        --[[
          name: PrivateMessageReplicationFunction
          line: 163
          upvalues:
            a1 (copy, index: 1)
        ]]
        local v16 = a1:GetSpeaker(a7)
        local ExtraData_1 = v16.ExtraData
        v16:SendMessage(a8, a9, a7, ExtraData_1)
        local v17 = a1:GetSpeaker(string.sub(a9, 4))
        local v18 = ((ChatConstants_upv_1.WhisperChannelPrefix) or "To ") .. a7
        if v17 then
            if not (v17:IsInChannel(v18)) then
                v17:JoinChannel(v18)
            end
            v17:SendMessage(a8, v18, a7, ExtraData_1)
        end
        return true
    end
    local function PrivateMessageAddTypeFunction_upv_1(a10, a11, a12)
        --[[
          name: PrivateMessageAddTypeFunction
          line: 181
        ]]
        if not ChatConstants_upv_1.MessageTypeWhisper then
            return
        end
        a11.MessageType = ChatConstants_upv_1.MessageTypeWhisper
    end
    local function WhisperCommandsFunction_1(a13, a14, a15)
        --[[
          name: WhisperCommandsFunction
          line: 147
          upvalues:
            DoWhisperCommand_upv_1 (copy, index: 1)
        ]]
        local v19 = false
        if string.sub(a14, 1, 3):lower() ~= "/w " then
            if string.sub(a14, 1, 9):lower() == "/whisper " then
                DoWhisperCommand_upv_1(a13, string.sub(a14, 10), a15)
                v19 = true
            end
            return v19
        end
        DoWhisperCommand_upv_1(a13, string.sub(a14, 4), a15)
        return true
    end
    a1:RegisterProcessCommandsFunction("whisper_commands", WhisperCommandsFunction_1, PrivateMessageAddTypeFunction_upv_1.StandardPriority)
    local function GetWhisperChanneNameColor_1()
        --[[
          name: GetWhisperChanneNameColor
          line: 189
          upvalues:
            ChatSettings_upv_1 (copy, index: 1)
        ]]
        if ChatSettings_upv_1.WhisperChannelNameColor then
            return ChatSettings_upv_1.WhisperChannelNameColor
        end
        return Color3.fromRGB(102, 14, 102)
    end
    a1.SpeakerAdded:connect(
        function(a16)
            --[[
              line: 196
              upvalues:
                a1 (copy, index: 1)
                ChatSettings_upv_1 (copy, index: 2)
                PrivateMessageAddTypeFunction_upv_1 (copy, index: 3)
                u1 (ref,  index: 4)
                PrivateMessageReplicationFunction_upv_1 (copy, index: 5)
                PrivateMessageAddTypeFunction_upv_1 (copy, index: 6)
            ]]
            local v20 = a1:GetSpeaker(a16)
            local v21
            if (ChatSettings_upv_1.PlayerDisplayNamesEnabled) and (v20:GetPlayer()) then
                v21 = v20:GetNameForDisplay() .. "(@" .. a16 .. ")"
            else
                v21 = a16
            end
            local v22 = (((not (ChatConstants_upv_1.WhisperChannelPrefix)) and "To ") or (ChatConstants_upv_1.WhisperChannelPrefix)) .. a16
            if a1:GetChannel(v22) then
                a1:RemoveChannel(v22)
            end
            local v23 = a1:AddChannel(v22)
            v23.Joinable = false
            v23.Leavable = true
            v23.AutoJoin = false
            v23.Private = true
            v23.WelcomeMessage = u1:FormatMessageToSend("GameChat_PrivateMessaging_NowChattingWith", "You are now privately chatting with " .. v21 .. ".", "RBX_NAME", tostring(v21))
            v23.ChannelNameColor = ChatSettings_upv_1.WhisperChannelNameColor or Color3.fromRGB(102, 14, 102)
            v23:RegisterProcessCommandsFunction("replication_function", PrivateMessageReplicationFunction_upv_1, ChatConstants_upv_1.LowPriority)
            v23:RegisterFilterMessageFunction("message_type_function", PrivateMessageAddTypeFunction_upv_1)
        end
    )
    a1.SpeakerRemoved:connect(
        function(a17)
            --[[
              line: 228
              upvalues:
                a1 (copy, index: 2)
            ]]
            local v25 = ((ChatConstants_upv_1.WhisperChannelPrefix) or "To ") .. a17
            if not a1:GetChannel(v25) then
                return
            end
            a1:RemoveChannel(v25)
        end
    )
end
return Run