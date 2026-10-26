local Chat_1 = game:GetService("Chat")
local ClientChatModules_1 = Chat_1:WaitForChild("ClientChatModules")
local ChatModules_1 = Chat_1:WaitForChild("ChatModules")
local ChatConstants_upv_1 = require(ClientChatModules_1:WaitForChild("ChatConstants"))
local ChatSettings_upv_1 = require(ClientChatModules_1:WaitForChild("ChatSettings"))
local DisplayNameHelpers_upv_1 = require(ChatModules_1.Utility.DisplayNameHelpers)
local u1 = nil
pcall(
    function()
        --[[
          line: 15
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
          line: 18
        ]]
        return a3
    end
end
local v1 = ChatSettings_upv_1.ErrorMessageTextColor or (Color3.fromRGB(245, 50, 50))
local tbl_upv_1 = {}
tbl_upv_1.ChatColor = v1
local function Run(a1)
    --[[
      name: Run
      line: 24
      upvalues:
        DisplayNameHelpers_upv_1 (copy, index: 2)
        u1 (ref,  index: 3)
        tbl_upv_1 (copy, index: 4)
        ChatConstants_upv_1 (copy, index: 5)
    ]]
    local function GetSpeakerNameFromMessage_1(a2)
        --[[
          name: GetSpeakerNameFromMessage
          line: 26
        ]]
        local v2, v3, v4 = nil, nil, nil
        if string.sub(a2, 1, 1) ~= "\"" then
            v2 = string.match(a2, "^[^%s]+")
            v3 = v2 or a2
        else
            v4 = string.find(a2, "\"", 2)
            if v4 then
                return (string.sub(a2, 2, v4 - 1))
            end
            v3 = a2
        end
        return v3
    end
    local function DoMuteCommand_upv_1(a3, a4, a5)
        --[[
          name: DoMuteCommand
          line: 42
          upvalues:
            a1 (copy, index: 1)
            DisplayNameHelpers_upv_1 (copy, index: 3)
            u1 (ref,  index: 4)
            tbl_upv_1 (copy, index: 5)
        ]]
        local v5, v6, v7 = nil, nil, nil
        if string.sub(a4, 1, 1) ~= "\"" then
            v5 = string.match(a4, "^[^%s]+")
            v6 = v5 or a4
        else
            v7 = string.find(a4, "\"", 2)
            if v7 then
                v6 = string.sub(a4, 2, v7 - 1)
            else
                v6 = a4
            end
        end
        local v8 = a1:GetSpeaker(a3)
        if v8 then
            local v9, v10
            if ChatSettings_upv_1.PlayerDisplayNamesEnabled then
                local v11, v12 = DisplayNameHelpers_upv_1.getUserNameFromChattedName(v6, a3, v8:GetNameForDisplay())
                v9, v10 = v11, v12
            else
                local v13, v14 = DisplayNameHelpers_upv_1.getUserNameFromChattedName(v6, a3, nil)
                v9, v10 = v13, v14
            end
            local v15 = a1:GetSpeaker(v9)
            if v10 == DisplayNameHelpers_upv_1.CommandErrorCodes.ChattingToSelf then
                v8:SendSystemMessage(u1:FormatMessageToSend("GameChat_DoMuteCommand_CannotMuteSelf", "You cannot mute yourself."), a5, tbl_upv_1)
            elseif v10 == DisplayNameHelpers_upv_1.CommandErrorCodes.NoMatches then
                v8:SendSystemMessage(u1:FormatMessageToSend("GameChat_MuteSpeaker_SpeakerDoesNotExist", string.format("Speaker '%s' does not exist.", tostring(v6)), "RBX_NAME", tostring(v9)), a5, tbl_upv_1)
            elseif v10 == DisplayNameHelpers_upv_1.CommandErrorCodes.MultipleMatches then
                local v16 = DisplayNameHelpers_upv_1.getUsersWithDisplayNameString(v6, a3)
                v8:SendSystemMessage(u1:FormatMessageToSend("InGame.Chat.Response.DisplayNameMultipleMatches", "Warning: The following users have this display name: "), a5, tbl_upv_1)
                v8:SendSystemMessage(v16, a5, tbl_upv_1)
            elseif v15 then
                v8:AddMutedSpeaker(v15.Name)
                local v17
                if ChatSettings_upv_1.PlayerDisplayNamesEnabled then
                    v17 = v15:GetNameForDisplay()
                else
                    v17 = v9
                end
                v8:SendSystemMessage(u1:FormatMessageToSend("GameChat_ChatMain_SpeakerHasBeenMuted", string.format("Speaker '%s' has been muted.", v17), "RBX_NAME", v17), a5)
            end
        end
    end
    local function DoUnmuteCommand_upv_1(a6, a7, a8)
        --[[
          name: DoUnmuteCommand
          line: 94
          upvalues:
            a1 (copy, index: 1)
            DisplayNameHelpers_upv_1 (copy, index: 3)
            u1 (ref,  index: 4)
            tbl_upv_1 (copy, index: 5)
        ]]
        local v18, v19, v20 = nil, nil, nil
        if string.sub(a7, 1, 1) ~= "\"" then
            v18 = string.match(a7, "^[^%s]+")
            v19 = v18 or a7
        else
            v20 = string.find(a7, "\"", 2)
            if v20 then
                v19 = string.sub(a7, 2, v20 - 1)
            else
                v19 = a7
            end
        end
        local v21 = a1:GetSpeaker(a6)
        if v21 then
            local v22, v23
            if ChatSettings_upv_1.PlayerDisplayNamesEnabled then
                local v24, v25 = DisplayNameHelpers_upv_1.getUserNameFromChattedName(v19, a6, v21:GetNameForDisplay())
                v22, v23 = v24, v25
            else
                local v26, v27 = DisplayNameHelpers_upv_1.getUserNameFromChattedName(v19, a6, nil)
                v22, v23 = v26, v27
            end
            local v28 = a1:GetSpeaker(v22)
            if v23 == DisplayNameHelpers_upv_1.CommandErrorCodes.ChattingToSelf then
                v21:SendSystemMessage(u1:FormatMessageToSend("GameChat_DoMuteCommand_CannotMuteSelf", "You cannot mute yourself."), a8, tbl_upv_1)
            elseif v23 == DisplayNameHelpers_upv_1.CommandErrorCodes.NoMatches then
                v21:SendSystemMessage(u1:FormatMessageToSend("GameChat_MuteSpeaker_SpeakerDoesNotExist", string.format("Speaker '%s' does not exist.", tostring(v22)), "RBX_NAME", tostring(v22)), a8, tbl_upv_1)
            elseif v23 == DisplayNameHelpers_upv_1.CommandErrorCodes.MultipleMatches then
                local v29 = DisplayNameHelpers_upv_1.getUsersWithDisplayNameString(v19, a6)
                v21:SendSystemMessage(u1:FormatMessageToSend("InGame.Chat.Response.DisplayNameMultipleMatches", "Warning: The following users have this display name: "), a8, tbl_upv_1)
                v21:SendSystemMessage(v29, a8, tbl_upv_1)
            elseif v28 then
                v21:RemoveMutedSpeaker(v28.Name)
                local v30
                if ChatSettings_upv_1.PlayerDisplayNamesEnabled then
                    v30 = v28:GetNameForDisplay()
                else
                    v30 = v22
                end
                v21:SendSystemMessage(u1:FormatMessageToSend("GameChat_ChatMain_SpeakerHasBeenUnMuted", string.format("Speaker '%s' has been unmuted.", v30), "RBX_NAME", v30), a8)
            end
        end
    end
    local function MuteCommandsFunction_1(a9, a10, a11)
        --[[
          name: MuteCommandsFunction
          line: 149
          upvalues:
            DoMuteCommand_upv_1 (copy, index: 1)
            DoUnmuteCommand_upv_1 (copy, index: 2)
        ]]
        local v31 = false
        if string.sub(a10, 1, 6):lower() ~= "/mute " then
            if string.sub(a10, 1, 8):lower() == "/unmute " then
                DoUnmuteCommand_upv_1(a9, string.sub(a10, 9), a11)
                v31 = true
            end
            return v31
        end
        DoMuteCommand_upv_1(a9, string.sub(a10, 7), a11)
        return true
    end
    a1:RegisterProcessCommandsFunction("mute_commands", MuteCommandsFunction_1, ChatConstants_upv_1.StandardPriority)
end
return Run