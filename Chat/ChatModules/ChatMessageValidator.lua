local v1

local function FormatMessageToSend(a3, a4, a5)
    --[[
      name: FormatMessageToSend
      line: 17
    ]]
    return a5
end

local chat = game:GetService("Chat")
local runService = game:GetService("RunService")
local clientChatModules = chat:WaitForChild("ClientChatModules")
local ChatSettings = require(clientChatModules:WaitForChild("ChatSettings"))
local ChatConstants = require(clientChatModules:WaitForChild("ChatConstants"))
local v11 = nil
pcall(
    function()
        --[[
          line: 14
          upvalues:
            v11 (ref, index: 1)
        ]]
        v11 = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
    end
)

if v11 == nil then
    v11 = {}
end

if not v11.FormatMessageToSend or not v11.LocalizeFormattedMessage then
    v11.FormatMessageToSend = FormatMessageToSend
end

local v12 = {"\n", "\r", "\t", "\v", "\f"}

if ChatSettings.DisallowedWhiteSpace then
    v1 = ChatSettings.DisallowedWhiteSpace
else
    v1 = v12
end

local function isMessageValidServer(text)
    --[[
      name: isMessageValidServer
      line: 27
      upvalues:
        ChatSettings (copy, index: 1)
    ]]
    local v15 = text:len()

    if ChatSettings.MaximumMessageLength * 6 < v15 then
        return false
    end

    if utf8.len(text) == nil then
        return false
    end

    local length = utf8.len(utf8.nfcnormalize(text))

    if ChatSettings.MaximumMessageLength < length then
        return false
    end

    return true
end

local function CanUserChat(a18)
    --[[
      name: CanUserChat
      line: 47
      upvalues:
        runService (copy, index: 1)
        chat (copy, index: 2)
    ]]
    if runService:IsStudio() then
        return true
    end

    local success, canUserChatAsync = pcall(
        function()
            --[[
              line: 51
              upvalues:
                chat (copy, index: 1)
                a18 (copy, index: 2)
            ]]
            return chat:CanUserChatAsync(a18.UserId)
        end
    )

    return success and canUserChatAsync
end

return function(a21)
    --[[
      name: Run
      line: 57
      upvalues:
        runService (copy, index: 1)
        chat (copy, index: 2)
        v11 (ref,  index: 3)
        isMessageValidServer (copy, index: 4)
        v1 (ref,  index: 5)
        ChatConstants (copy, index: 6)
    ]]
    a21:RegisterProcessCommandsFunction(
        "message_validation",
        function(a22, text, a24)
            --[[
              name: ValidateChatFunction
              line: 58
              upvalues:
                a21 (copy, index: 1)
                runService (copy, index: 2)
                chat (copy, index: 3)
                v11 (ref,  index: 4)
                isMessageValidServer (copy, index: 5)
                v1 (ref,  index: 6)
            ]]
            local canUserChatAsync
            local speaker = a21:GetSpeaker(a22)
            local player = speaker:GetPlayer()

            if not speaker then
                return false
            end

            if not player then
                return false
            end

            if not runService:IsStudio() and player.UserId < 1 then
                return true
            end

            if runService:IsStudio() then
                canUserChatAsync = true
            else
                local success, canUserChatAsync2 = pcall(
                    function()
                        --[[
                          line: 51
                          upvalues:
                            chat (copy, index: 1)
                            player (copy, index: 2)
                        ]]
                        return chat:CanUserChatAsync(player.UserId)
                    end
                )
                canUserChatAsync = success and canUserChatAsync2
            end

            if not canUserChatAsync then
                speaker:SendSystemMessage(v11:FormatMessageToSend("GameChat_ChatMessageValidator_SettingsError", "Your chat settings prevent you from sending messages."), a24)
                return true
            end

            if not isMessageValidServer(text) then
                speaker:SendSystemMessage(v11:FormatMessageToSend("GameChat_ChatMessageValidator_MaxLengthError", "Your message exceeds the maximum message length."), a24)
                return true
            end

            for _, v31 in pairs(v1) do
                if text:find(v31) then
                    speaker:SendSystemMessage(v11:FormatMessageToSend("GameChat_ChatMessageValidator_WhitespaceError", "Your message contains whitespace that is not allowed."), a24)
                    return true
                end
            end

            return false
        end,
        ChatConstants.VeryHighPriority
    )
end