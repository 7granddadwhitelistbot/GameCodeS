local function FormatMessageToSend(a2, a3, a4)
    --[[
      name: FormatMessageToSend
      line: 18
    ]]
    return a4
end

local chat = game:GetService("Chat")
local clientChatModules = chat:WaitForChild("ClientChatModules")
local chatModules = chat:WaitForChild("ChatModules")
local ChatConstants = require(clientChatModules:WaitForChild("ChatConstants"))
local ChatSettings = require(clientChatModules:WaitForChild("ChatSettings"))
local DisplayNameHelpers = require(chatModules.Utility.DisplayNameHelpers)
local v11 = nil
pcall(
    function()
        --[[
          line: 15
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

local v12 = ChatSettings.ErrorMessageTextColor or Color3.fromRGB(245, 50, 50)
local v13 = {ChatColor = v12}

return function(a14)
    --[[
      name: Run
      line: 24
      upvalues:
        ChatSettings (copy, index: 1)
        DisplayNameHelpers (copy, index: 2)
        v11 (ref,  index: 3)
        v13 (copy, index: 4)
        ChatConstants (copy, index: 5)
    ]]
    local function GetSpeakerNameFromMessage(text: string)
        --[[
          name: GetSpeakerNameFromMessage
          line: 26
        ]]
        return if string.sub(text, 1, 1) ~= "\"" then string.match(text, "^[^%s]+") or text elseif const startIndex = string.find(text, "\"", 2) then (string.sub(text, 2, startIndex - 1)) else text
    end

    local function DoMuteCommand(a19, substring: string, a21)
        --[[
          name: DoMuteCommand
          line: 42
          upvalues:
            a14 (copy, index: 1)
            ChatSettings (copy, index: 2)
            DisplayNameHelpers (copy, index: 3)
            v11 (ref,  index: 4)
            v13 (copy, index: 5)
        ]]
        local v22

        if string.sub(substring, 1, 1) ~= "\"" then
            v22 = string.match(substring, "^[^%s]+") or substring
        else
            v22 = if const startIndex = string.find(substring, "\"", 2) then string.sub(substring, 2, startIndex - 1) else substring
        end

        if const speaker = a14:GetSpeaker(a19) then
            local userName, v26

            if ChatSettings.PlayerDisplayNamesEnabled then
                userName, v26 = DisplayNameHelpers.getUserNameFromChattedName(v22, a19, speaker:GetNameForDisplay())
            else
                userName, v26 = DisplayNameHelpers.getUserNameFromChattedName(v22, a19, nil)
            end

            local speaker2 = a14:GetSpeaker(userName)

            if v26 == DisplayNameHelpers.CommandErrorCodes.ChattingToSelf then
                speaker:SendSystemMessage(v11:FormatMessageToSend("GameChat_DoMuteCommand_CannotMuteSelf", "You cannot mute yourself."), a21, v13)
                return
            end

            if v26 == DisplayNameHelpers.CommandErrorCodes.NoMatches then
                speaker:SendSystemMessage(v11:FormatMessageToSend("GameChat_MuteSpeaker_SpeakerDoesNotExist", string.format("Speaker '%s' does not exist.", (tostring(v22))), "RBX_NAME", (tostring(userName))), a21, v13)
                return
            end

            if v26 == DisplayNameHelpers.CommandErrorCodes.MultipleMatches then
                local users = DisplayNameHelpers.getUsersWithDisplayNameString(v22, a19)
                speaker:SendSystemMessage(v11:FormatMessageToSend("InGame.Chat.Response.DisplayNameMultipleMatches", "Warning: The following users have this display name: "), a21, v13)
                speaker:SendSystemMessage(users, a21, v13)

                return
            end

            if speaker2 then
                speaker:AddMutedSpeaker(speaker2.Name)
                local v29 = if ChatSettings.PlayerDisplayNamesEnabled then speaker2:GetNameForDisplay() else userName
                speaker:SendSystemMessage(v11:FormatMessageToSend("GameChat_ChatMain_SpeakerHasBeenMuted", string.format("Speaker '%s' has been muted.", v29), "RBX_NAME", v29), a21)
            end
        end
    end

    local function DoUnmuteCommand(a31, substring: string, a33)
        --[[
          name: DoUnmuteCommand
          line: 94
          upvalues:
            a14 (copy, index: 1)
            ChatSettings (copy, index: 2)
            DisplayNameHelpers (copy, index: 3)
            v11 (ref,  index: 4)
            v13 (copy, index: 5)
        ]]
        local v34

        if string.sub(substring, 1, 1) ~= "\"" then
            v34 = string.match(substring, "^[^%s]+") or substring
        else
            v34 = if const startIndex = string.find(substring, "\"", 2) then string.sub(substring, 2, startIndex - 1) else substring
        end

        if const speaker = a14:GetSpeaker(a31) then
            local userName, v38

            if ChatSettings.PlayerDisplayNamesEnabled then
                userName, v38 = DisplayNameHelpers.getUserNameFromChattedName(v34, a31, speaker:GetNameForDisplay())
            else
                userName, v38 = DisplayNameHelpers.getUserNameFromChattedName(v34, a31, nil)
            end

            local speaker2 = a14:GetSpeaker(userName)

            if v38 == DisplayNameHelpers.CommandErrorCodes.ChattingToSelf then
                speaker:SendSystemMessage(v11:FormatMessageToSend("GameChat_DoMuteCommand_CannotMuteSelf", "You cannot mute yourself."), a33, v13)
                return
            end

            if v38 == DisplayNameHelpers.CommandErrorCodes.NoMatches then
                speaker:SendSystemMessage(v11:FormatMessageToSend("GameChat_MuteSpeaker_SpeakerDoesNotExist", string.format("Speaker '%s' does not exist.", (tostring(userName))), "RBX_NAME", (tostring(userName))), a33, v13)
                return
            end

            if v38 == DisplayNameHelpers.CommandErrorCodes.MultipleMatches then
                local users = DisplayNameHelpers.getUsersWithDisplayNameString(v34, a31)
                speaker:SendSystemMessage(v11:FormatMessageToSend("InGame.Chat.Response.DisplayNameMultipleMatches", "Warning: The following users have this display name: "), a33, v13)
                speaker:SendSystemMessage(users, a33, v13)

                return
            end

            if speaker2 then
                speaker:RemoveMutedSpeaker(speaker2.Name)
                local v41 = if ChatSettings.PlayerDisplayNamesEnabled then speaker2:GetNameForDisplay() else userName
                speaker:SendSystemMessage(v11:FormatMessageToSend("GameChat_ChatMain_SpeakerHasBeenUnMuted", string.format("Speaker '%s' has been unmuted.", v41), "RBX_NAME", v41), a33)
            end
        end
    end

    a14:RegisterProcessCommandsFunction(
        "mute_commands",
        function(a42, text: string, a44)
            --[[
              name: MuteCommandsFunction
              line: 149
              upvalues:
                DoMuteCommand (copy, index: 1)
                DoUnmuteCommand (copy, index: 2)
            ]]
            if string.sub(text, 1, 6):lower() == "/mute " then
                DoMuteCommand(a42, string.sub(text, 7), a44)
                return true
            end

            if string.sub(text, 1, 8):lower() ~= "/unmute " then
                return false
            end

            DoUnmuteCommand(a42, string.sub(text, 9), a44)

            return true
        end,
        ChatConstants.StandardPriority
    )
end