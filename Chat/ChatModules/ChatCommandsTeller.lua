local Run = game:GetService("Chat"):WaitForChild("ClientChatModules")
local ChatSettings_upv_1 = require(Run:WaitForChild("ChatSettings"))
local ChatConstants_upv_1 = require(Run:WaitForChild("ChatConstants"))
local u1 = nil
pcall(
    function()
        --[[
          line: 13
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
Run = function(a1)
    --[[
      name: Run
      line: 20
      upvalues:
        ChatSettings_upv_1 (copy, index: 1)
        u1 (ref,  index: 2)
        ChatConstants_upv_1 (copy, index: 3)
    ]]
    local function ShowJoinAndLeaveCommands_1()
        --[[
          name: ShowJoinAndLeaveCommands
          line: 22
          upvalues:
            ChatSettings_upv_1 (copy, index: 1)
        ]]
        if ChatSettings_upv_1.ShowJoinAndLeaveHelpText == nil then
            return false
        end
        return ChatSettings_upv_1.ShowJoinAndLeaveHelpText
    end
    local function ProcessCommandsFunction_1(a2, a3, a4)
        --[[
          name: ProcessCommandsFunction
          line: 29
          upvalues:
            a1 (copy, index: 1)
            u1 (ref,  index: 2)
            ChatSettings_upv_1 (copy, index: 3)
        ]]
        if a3:lower() ~= "/?" and a3:lower() ~= "/help" then
            return false
        end
        local v1 = a1:GetSpeaker(a2)
        v1:SendSystemMessage(u1:FormatMessageToSend("GameChat_ChatCommandsTeller_Desc", "These are the basic chat commands."), a4)
        if ChatSettings_upv_1.AllowMeCommand then
            v1:SendSystemMessage(u1:FormatMessageToSend("GameChat_ChatCommandsTeller_MeCommand", "/me <text> : roleplaying command for doing actions."), a4)
        end
        v1:SendSystemMessage(u1:FormatMessageToSend("GameChat_ChatCommandsTeller_SwitchChannelCommand", "/c <channel> : switch channel menu tabs."), a4)
        local v2
        if ChatSettings_upv_1.ShowJoinAndLeaveHelpText == nil then
            v2 = false
        else
            v2 = ChatSettings_upv_1.ShowJoinAndLeaveHelpText
        end
        if v2 then
            v1:SendSystemMessage(u1:FormatMessageToSend("GameChat_ChatCommandsTeller_JoinChannelCommand", "/join <channel> or /j <channel> : join channel."), a4)
            v1:SendSystemMessage(u1:FormatMessageToSend("GameChat_ChatCommandsTeller_LeaveChannelCommand", "/leave <channel> or /l <channel> : leave channel. (leaves current if none specified)"), a4)
        end
        v1:SendSystemMessage(u1:FormatMessageToSend("GameChat_ChatCommandsTeller_WhisperCommand", "/whisper <speaker> or /w <speaker> : open private message channel with speaker."), a4)
        v1:SendSystemMessage(u1:FormatMessageToSend("GameChat_ChatCommandsTeller_MuteCommand", "/mute <speaker> : mute a speaker."), a4)
        v1:SendSystemMessage(u1:FormatMessageToSend("GameChat_ChatCommandsTeller_UnMuteCommand", "/unmute <speaker> : unmute a speaker."), a4)
        local v3 = v1:GetPlayer()
        if v3 and v3.Team then
            v1:SendSystemMessage(u1:FormatMessageToSend("GameChat_ChatCommandsTeller_TeamCommand", "/team <message> or /t <message> : send a team chat to players on your team."), a4)
        end
        return true
    end
    a1:RegisterProcessCommandsFunction("chat_commands_inquiry", ProcessCommandsFunction_1, ChatConstants_upv_1.StandardPriority)
    if ChatSettings_upv_1.GeneralChannelName then
        local v4 = a1:GetChannel(ChatSettings_upv_1.GeneralChannelName)
        if not v4 then
            return
        end
        v4.WelcomeMessage = u1:FormatMessageToSend("GameChat_ChatCommandsTeller_AllChannelWelcomeMessage", "Chat '/?' or '/help' for a list of chat commands.")
    end
end
return Run