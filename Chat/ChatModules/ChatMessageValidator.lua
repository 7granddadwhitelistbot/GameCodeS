local Chat_upv_1 = game:GetService("Chat")
local RunService_upv_1 = game:GetService("RunService")
local ClientChatModules_1 = Chat_upv_1:WaitForChild("ClientChatModules")
local ChatSettings_upv_1 = require(ClientChatModules_1:WaitForChild("ChatSettings"))
local ChatConstants_upv_1 = require(ClientChatModules_1:WaitForChild("ChatConstants"))
local u1 = nil
pcall(
    function()
        --[[
          line: 14
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
          line: 17
        ]]
        return a3
    end
end
local u2 = {}
u2[1], u2[2], u2[3], u2[4], u2[5] = "\n", "\r", "\t", "\v", "\f"
if ChatSettings_upv_1.DisallowedWhiteSpace then
    u2 = ChatSettings_upv_1.DisallowedWhiteSpace
end
local function CanUserChat(a1)
    --[[
      name: CanUserChat
      line: 47
      upvalues:
        RunService_upv_1 (copy, index: 1)
    ]]
    if RunService_upv_1:IsStudio() then
        return true
    end
    local success_1, v1 = pcall(function() end)
    return success_1 and v1
end
local function isMessageValidServer(a1)
    --[[
      name: isMessageValidServer
      line: 27
      upvalues:
        ChatSettings_upv_1 (copy, index: 1)
    ]]
    if not (ChatSettings_upv_1.MaximumMessageLength * 6 < a1:len()) and utf8.len(a1) ~= nil then
        if ChatSettings_upv_1.MaximumMessageLength < utf8.len(utf8.nfcnormalize(a1)) then
            return false
        end
        return true
    end
    return false
end
local function Run(a1)
    --[[
      name: Run
      line: 57
      upvalues:
        Chat_upv_1 (copy, index: 2)
        u1 (ref,  index: 3)
        isMessageValidServer (copy, index: 4)
        u2 (ref,  index: 5)
        ChatConstants_upv_1 (copy, index: 6)
    ]]
    local function ValidateChatFunction_1(a2, a3, a4)
        --[[
          name: ValidateChatFunction
          line: 58
          upvalues:
            a1 (copy, index: 1)
            Chat_upv_1 (copy, index: 3)
            u1 (ref,  index: 4)
            isMessageValidServer (copy, index: 5)
            u2 (ref,  index: 6)
        ]]
        local v2 = a1:GetSpeaker(a2)
        local u3 = v2:GetPlayer()
        if v2 and u3 then
            if not (RunService_upv_1:IsStudio()) and u3.UserId < 1 then
                return true
            end
            local v3
            if RunService_upv_1:IsStudio() then
                v3 = true
            else
                local success_2, v4 = pcall(
                    function()
                        --[[
                          line: 51
                          upvalues:
                            Chat_upv_1 (copy, index: 1)
                            u3 (copy, index: 2)
                        ]]
                        return Chat_upv_1:CanUserChatAsync(u3.UserId)
                    end
                )
                v3 = success_2 and v4
            end
            if v3 then
                if isMessageValidServer(a3) then
                    for _, value_1 in pairs(u2) do
                        if not (a3:find(value_1)) then
                            continue
                        end
                        v2:SendSystemMessage(u1:FormatMessageToSend("GameChat_ChatMessageValidator_WhitespaceError", "Your message contains whitespace that is not allowed."), a4)
                        return true
                    end
                    return false
                end
                v2:SendSystemMessage(u1:FormatMessageToSend("GameChat_ChatMessageValidator_MaxLengthError", "Your message exceeds the maximum message length."), a4)
            else
                v2:SendSystemMessage(u1:FormatMessageToSend("GameChat_ChatMessageValidator_SettingsError", "Your chat settings prevent you from sending messages."), a4)
            end
            return true
        end
        return false
    end
    a1:RegisterProcessCommandsFunction("message_validation", ValidateChatFunction_1, ChatConstants_upv_1.VeryHighPriority)
end
return Run