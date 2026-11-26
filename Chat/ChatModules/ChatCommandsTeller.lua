local chat = game:GetService("Chat")
local clientChatModules = chat:WaitForChild("ClientChatModules")
local ChatSettings = require(clientChatModules:WaitForChild("ChatSettings"))
local ChatConstants = require(clientChatModules:WaitForChild("ChatConstants"))
local v5 = nil
pcall(
    function()
        --[[
          line: 13
          upvalues:
            v5 (ref, index: 1)
        ]]
        v5 = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
    end
)

if v5 == nil then
    v5 = {}
end

if not v5.FormatMessageToSend or not v5.LocalizeFormattedMessage then
    function v5.FormatMessageToSend(a6, a7, a8)
        --[[
          name: FormatMessageToSend
          line: 17
        ]]
        return a8
    end
end

return function(a9)
    --[[
      name: Run
      line: 20
      upvalues:
        ChatSettings (copy, index: 1)
        v5 (ref,  index: 2)
        ChatConstants (copy, index: 3)
    ]]
    local function ShowJoinAndLeaveCommands()
        --[[
          name: ShowJoinAndLeaveCommands
          line: 22
          upvalues:
            ChatSettings (copy, index: 1)
        ]]
        if ChatSettings.ShowJoinAndLeaveHelpText ~= nil then
            return ChatSettings.ShowJoinAndLeaveHelpText
        end

        return false
    end

    a9:RegisterProcessCommandsFunction(
        "chat_commands_inquiry",
        function(a11, a12, a13)
            --[[
              name: ProcessCommandsFunction
              line: 29
              upvalues:
                a9 (copy, index: 1)
                v5 (ref,  index: 2)
                ChatSettings (copy, index: 3)
            ]]
            if a12:lower() ~= "/?" and a12:lower() ~= "/help" then
                return false
            end

            local speaker = a9:GetSpeaker(a11)
            speaker:SendSystemMessage(v5:FormatMessageToSend("GameChat_ChatCommandsTeller_Desc", "These are the basic chat commands."), a13)

            if ChatSettings.AllowMeCommand then
                speaker:SendSystemMessage(v5:FormatMessageToSend("GameChat_ChatCommandsTeller_MeCommand", "/me <text> : roleplaying command for doing actions."), a13)
            end

            speaker:SendSystemMessage(v5:FormatMessageToSend("GameChat_ChatCommandsTeller_SwitchChannelCommand", "/c <channel> : switch channel menu tabs."), a13)
            local v15 = if ChatSettings.ShowJoinAndLeaveHelpText ~= nil then ChatSettings.ShowJoinAndLeaveHelpText else false
            if v15 then
                speaker:SendSystemMessage(v5:FormatMessageToSend("GameChat_ChatCommandsTeller_JoinChannelCommand", "/join <channel> or /j <channel> : join channel."), a13)
                speaker:SendSystemMessage(v5:FormatMessageToSend("GameChat_ChatCommandsTeller_LeaveChannelCommand", "/leave <channel> or /l <channel> : leave channel. (leaves current if none specified)"), a13)
            end

            speaker:SendSystemMessage(v5:FormatMessageToSend("GameChat_ChatCommandsTeller_WhisperCommand", "/whisper <speaker> or /w <speaker> : open private message channel with speaker."), a13)
            speaker:SendSystemMessage(v5:FormatMessageToSend("GameChat_ChatCommandsTeller_MuteCommand", "/mute <speaker> : mute a speaker."), a13)
            speaker:SendSystemMessage(v5:FormatMessageToSend("GameChat_ChatCommandsTeller_UnMuteCommand", "/unmute <speaker> : unmute a speaker."), a13)
            local player = speaker:GetPlayer()

            if player and player.Team then
                speaker:SendSystemMessage(v5:FormatMessageToSend("GameChat_ChatCommandsTeller_TeamCommand", "/team <message> or /t <message> : send a team chat to players on your team."), a13)
            end

            return true
        end,
        ChatConstants.StandardPriority
    )

    if ChatSettings.GeneralChannelName then
        if const channel = a9:GetChannel(ChatSettings.GeneralChannelName) then
            channel.WelcomeMessage = v5:FormatMessageToSend("GameChat_ChatCommandsTeller_AllChannelWelcomeMessage", "Chat '/?' or '/help' for a list of chat commands.")
        end
    end
end