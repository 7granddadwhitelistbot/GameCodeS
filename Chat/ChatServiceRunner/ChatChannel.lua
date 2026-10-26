local success_1, v1 = pcall(
    function()
        --[[
          line: 8
        ]]
        return UserSettings():IsUserFeatureEnabled("UserShouldMuteUnfilteredMessage")
    end
)
local u1 = success_1 and v1
local success_2, v2 = pcall(
    function()
        --[[
          line: 13
        ]]
        return UserSettings():IsUserFeatureEnabled("UserRemoveMessageOnTextFilterFailures")
    end
)
local u2 = success_2 and v2
local success_3, v3 = pcall(
    function()
        --[[
          line: 21
        ]]
        return UserSettings():IsUserFeatureEnabled("UserIsChatTranslationEnabled2")
    end
)
local u3 = success_3 and v3
local tbl_1 = {}
local Chat_upv_1 = game:GetService("Chat")
local RunService_upv_1 = game:GetService("RunService")
local ClientChatModules_1 = Chat_upv_1:WaitForChild("ClientChatModules")
local ChatSettings_upv_1 = require(ClientChatModules_1:WaitForChild("ChatSettings"))
local ChatConstants_upv_1 = require(ClientChatModules_1:WaitForChild("ChatConstants"))
local Util_upv_1 = require(script.Parent:WaitForChild("Util"))
local u4 = nil
pcall(
    function()
        --[[
          line: 42
          upvalues:
            u4 (ref, index: 1)
        ]]
        u4 = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
    end
)
local v4 = u4 or {}
u4 = v4
if not (u4.FormatMessageToSend) or not (u4.LocalizeFormattedMessage) then
    function u4.FormatMessageToSend(a1, a2, a3)
        --[[
          name: FormatMessageToSend
          line: 46
        ]]
        return a3
    end
end
local tbl_upv_2 = {}
tbl_upv_2.__index = tbl_upv_2
function tbl_upv_2.SendSystemMessage(a1, a2, a3)
    --[[
      name: SendSystemMessage
      line: 55
    ]]
    local u5 = a1:InternalCreateMessageObject(a2, nil, true, a3)
    local success_4, v5 = pcall(
        function()
            --[[
              line: 58
              upvalues:
                a1 (copy, index: 1)
                u5 (copy, index: 2)
            ]]
            a1.eMessagePosted:Fire(u5)
        end
    )
    if not (success_4) and v5 then
        print("Error posting message: " .. v5)
    end
    a1:InternalAddMessageToHistoryLog(u5)
    for _, value_1 in pairs(a1.Speakers) do
        value_1:InternalSendSystemMessage(u5, a1.Name)
    end
    return u5
end
function tbl_upv_2.SendSystemMessageToSpeaker(a1, a2, a3, a4)
    --[[
      name: SendSystemMessageToSpeaker
      line: 72
      upvalues:
        RunService_upv_1 (copy, index: 1)
    ]]
    local v6 = a1.Speakers[a3]
    if v6 then
        v6:InternalSendSystemMessage(a1:InternalCreateMessageObject(a2, nil, true, a4), a1.Name)
    elseif RunService_upv_1:IsStudio() then
        warn(string.format("Speaker '%s' is not in channel '%s' and cannot be sent a system message", a3, a1.Name))
    end
end
function tbl_upv_2.SendMessageObjToFilters(a1, a2, a3, a4)
    --[[
      name: SendMessageObjToFilters
      line: 82
    ]]
    local Message_1 = a3.Message
    a3.Message = a2
    a1:InternalDoMessageFilter(a4.Name, a3, a1.Name)
    a1.ChatService:InternalDoMessageFilter(a4.Name, a3, a1.Name)
    local Message_2 = a3.Message
    a3.Message = Message_1
    return Message_2
end
function tbl_upv_2.CanCommunicateByUserId(a1, a2, a3)
    --[[
      name: CanCommunicateByUserId
      line: 92
      upvalues:
        RunService_upv_1 (copy, index: 1)
        Chat_upv_1 (copy, index: 2)
    ]]
    if RunService_upv_1:IsStudio() or a2 == 0 or a3 == 0 then
        return true
    end
    local success_5, v7 = pcall(
        function()
            --[[
              line: 100
              upvalues:
                Chat_upv_1 (copy, index: 1)
                a2 (copy, index: 2)
                a3 (copy, index: 3)
            ]]
            return Chat_upv_1:CanUsersChatAsync(a2, a3)
        end
    )
    return success_5 and v7
end
function tbl_upv_2.CanCommunicate(a1, a2, a3)
    --[[
      name: CanCommunicate
      line: 106
    ]]
    local v8 = a2:GetPlayer()
    local v9 = a3:GetPlayer()
    if v8 and v9 then
        return a1:CanCommunicateByUserId(v8.UserId, v9.UserId)
    end
    return true
end
function tbl_upv_2.SendMessageToSpeaker(a1, a2, a3, a4, a5)
    --[[
      name: SendMessageToSpeaker
      line: 115
      upvalues:
        RunService_upv_1 (copy, index: 1)
    ]]
    local v10 = a1.Speakers[a3]
    local v11 = a1.ChatService:GetSpeaker(a4)
    if v10 and v11 then
        if v10:IsSpeakerMuted(a4) or not a1:CanCommunicate(v10, v11) then
            return
        end
        local v12 = a1:InternalCreateMessageObject(a2, a4, a3 == a4, a5)
        local v13 = a1:SendMessageObjToFilters(a2, v12, a4)
        v10:InternalSendMessage(v12, a1.Name)
        local v14, v15, v16 = a1.ChatService:InternalApplyRobloxFilterNewAPI(v12.FromSpeaker, v13, ((a1.Private) and (Enum.TextFilterContext.PrivateChat)) or (Enum.TextFilterContext.PublicChat))
        if v14 then
            v12.FilterResult = v16
            v12.IsFilterResult = v15
            v12.IsFiltered = true
            v10:InternalSendFilteredMessageWithFilterResult(v12, a1.Name)
        end
        return
    end
    if not RunService_upv_1:IsStudio() then
        return
    end
    warn(string.format("Speaker '%s' is not in channel '%s' and cannot be sent a message", a3, a1.Name))
end
function tbl_upv_2.KickSpeaker(a1, a2, a3)
    --[[
      name: KickSpeaker
      line: 151
    ]]
    local v17 = a1.ChatService:GetSpeaker(a2)
    if not (v17) then
        error("Speaker \"" .. a2 .. "\" does not exist!")
    end
    local v18 = v17:GetNameForDisplay()
    local v19, v20
    if a3 then
        v19 = string.format("You were kicked from '%s' for the following reason(s): %s", a1.Name, a3)
        v20 = string.format("%s was kicked for the following reason(s): %s", v18, a3)
    else
        v19, v20 = string.format("You were kicked from '%s'", a1.Name), string.format("%s was kicked", v18)
    end
    a1:SendSystemMessageToSpeaker(v19, a2)
    v17:LeaveChannel(a1.Name)
    a1:SendSystemMessage(v20)
end
function tbl_upv_2.MuteSpeaker(a1, a2, a3, a4)
    --[[
      name: MuteSpeaker
      line: 174
    ]]
    local v21 = a1.ChatService:GetSpeaker(a2)
    if not (v21) then
        error("Speaker \"" .. a2 .. "\" does not exist!")
    end
    local Mutes_1 = a1.Mutes
    local v22 = a2:lower()
    local v23
    if a4 == 0 or a4 == nil then
        v23 = 0
    else
        v23 = os.time() + a4
    end
    Mutes_1[v22] = v23
    if a3 then
        a1:SendSystemMessage(string.format("%s was muted for the following reason(s): %s", v21:GetNameForDisplay(), a3))
    end
    local success_6, v24 = pcall(
        function()
            --[[
              line: 188
              upvalues:
                a1 (copy, index: 1)
                a2 (copy, index: 2)
                a3 (copy, index: 3)
                a4 (copy, index: 4)
            ]]
            a1.eSpeakerMuted:Fire(a2, a3, a4)
        end
    )
    if not (success_6) and v24 then
        print("Error mutting speaker: " .. v24)
    end
    local u6 = a1.ChatService:GetSpeaker(a2)
    if u6 then
        local success_7, v25 = pcall(
            function()
                --[[
                  line: 195
                  upvalues:
                    u6 (copy, index: 1)
                    a1 (copy, index: 2)
                    a3 (copy, index: 3)
                    a4 (copy, index: 4)
                ]]
                u6.eMuted:Fire(a1.Name, a3, a4)
            end
        )
        if (success_7) or not v25 then
            return
        end
        print("Error mutting speaker: " .. v25)
    end
end
function tbl_upv_2.UnmuteSpeaker(a1, a2)
    --[[
      name: UnmuteSpeaker
      line: 203
    ]]
    if not (a1.ChatService:GetSpeaker(a2)) then
        error("Speaker \"" .. a2 .. "\" does not exist!")
    end
    a1.Mutes[a2:lower()] = nil
    local success_8, v26 = pcall(
        function()
            --[[
              line: 211
              upvalues:
                a1 (copy, index: 1)
                a2 (copy, index: 2)
            ]]
            a1.eSpeakerUnmuted:Fire(a2)
        end
    )
    if not (success_8) and v26 then
        print("Error unmuting speaker: " .. v26)
    end
    local u7 = a1.ChatService:GetSpeaker(a2)
    if u7 then
        local success_9, v27 = pcall(
            function()
                --[[
                  line: 218
                  upvalues:
                    u7 (copy, index: 1)
                    a1 (copy, index: 2)
                ]]
                u7.eUnmuted:Fire(a1.Name)
            end
        )
        if (success_9) or not v27 then
            return
        end
        print("Error unmuting speaker: " .. v27)
    end
end
function tbl_upv_2.IsSpeakerMuted(a1, a2)
    --[[
      name: IsSpeakerMuted
      line: 225
    ]]
    local v28 = a1.Mutes[a2:lower()] ~= nil
    return v28
end
function tbl_upv_2.GetSpeakerList(a1)
    --[[
      name: GetSpeakerList
      line: 229
    ]]
    local tbl_3 = {}
    for _, value_2 in pairs(a1.Speakers) do
        table.insert(tbl_3, value_2.Name)
    end
    return tbl_3
end
function tbl_upv_2.RegisterFilterMessageFunction(a1, a2, a3, a4)
    --[[
      name: RegisterFilterMessageFunction
      line: 237
    ]]
    if a1.FilterMessageFunctions:HasFunction(a2) then
        error(string.format("FilterMessageFunction '%s' already exists", a2))
    end
    a1.FilterMessageFunctions:AddFunction(a2, a3, a4)
end
function tbl_upv_2.FilterMessageFunctionExists(a1, a2)
    --[[
      name: FilterMessageFunctionExists
      line: 244
    ]]
    return a1.FilterMessageFunctions:HasFunction(a2)
end
function tbl_upv_2.UnregisterFilterMessageFunction(a1, a2)
    --[[
      name: UnregisterFilterMessageFunction
      line: 248
    ]]
    if not (a1.FilterMessageFunctions:HasFunction(a2)) then
        error(string.format("FilterMessageFunction '%s' does not exists", a2))
    end
    a1.FilterMessageFunctions:RemoveFunction(a2)
end
function tbl_upv_2.RegisterProcessCommandsFunction(a1, a2, a3, a4)
    --[[
      name: RegisterProcessCommandsFunction
      line: 255
    ]]
    if a1.ProcessCommandsFunctions:HasFunction(a2) then
        error(string.format("ProcessCommandsFunction '%s' already exists", a2))
    end
    a1.ProcessCommandsFunctions:AddFunction(a2, a3, a4)
end
function tbl_upv_2.ProcessCommandsFunctionExists(a1, a2)
    --[[
      name: ProcessCommandsFunctionExists
      line: 262
    ]]
    return a1.ProcessCommandsFunctions:HasFunction(a2)
end
function tbl_upv_2.UnregisterProcessCommandsFunction(a1, a2)
    --[[
      name: UnregisterProcessCommandsFunction
      line: 266
    ]]
    if not (a1.ProcessCommandsFunctions:HasFunction(a2)) then
        error(string.format("ProcessCommandsFunction '%s' does not exist", a2))
    end
    a1.ProcessCommandsFunctions:RemoveFunction(a2)
end
local function ShallowCopy(a1)
    --[[
      name: ShallowCopy
      line: 273
    ]]
    local tbl_4 = {}
    for key_1, value_3 in pairs(a1) do
        tbl_4[key_1] = value_3
    end
    return tbl_4
end
function tbl_upv_2.GetHistoryLog(a1)
    --[[
      name: GetHistoryLog
      line: 281
    ]]
    local tbl_5 = {}
    for key_2, value_4 in pairs(a1.ChatHistory) do
        tbl_5[key_2] = value_4
    end
    return tbl_5
end
function tbl_upv_2.GetHistoryLogForSpeaker(a1, a2)
    --[[
      name: GetHistoryLogForSpeaker
      line: 285
      upvalues:
        ChatConstants_upv_1 (copy, index: 1)
    ]]
    local v29 = a2:GetPlayer()
    local tbl_6 = {}
    for n_1 = 1, #a1.ChatHistory do
        local v30 = a1:CanCommunicateByUserId(-1, a1.ChatHistory[n_1].SpeakerUserId)
        if not (v30) then
            continue
        end
        local tbl_7 = {}
        for key_3, value_5 in pairs(a1.ChatHistory[n_1]) do
            tbl_7[key_3] = value_5
        end
        if tbl_7.MessageType == ChatConstants_upv_1.MessageTypeDefault or tbl_7.MessageType == ChatConstants_upv_1.MessageTypeMeCommand then
            local FilterResult_1 = tbl_7.FilterResult
            if not (tbl_7.IsFilterResult) then
                tbl_7.Message = FilterResult_1
                table.insert(tbl_6, tbl_7)
                continue
            end
            if v29 then
                tbl_7.Message = FilterResult_1:GetChatForUserAsync(v29.UserId)
            else
                tbl_7.Message = FilterResult_1:GetNonChatStringForBroadcastAsync()
            end
        end
        table.insert(tbl_6, tbl_7)
    end
    return tbl_6
end
function tbl_upv_2.InternalDestroy(a1)
    --[[
      name: InternalDestroy
      line: 323
    ]]
    for _, value_6 in pairs(a1.Speakers) do
        value_6:LeaveChannel(a1.Name)
    end
    a1.eDestroyed:Fire()
    a1.eDestroyed:Destroy()
    a1.eMessagePosted:Destroy()
    a1.eSpeakerJoined:Destroy()
    a1.eSpeakerLeft:Destroy()
    a1.eSpeakerMuted:Destroy()
    a1.eSpeakerUnmuted:Destroy()
end
function tbl_upv_2.InternalDoMessageFilter(a1, a2, a3, a4)
    --[[
      name: InternalDoMessageFilter
      line: 338
    ]]
    for key_4, value_upv_7, _ in a1.FilterMessageFunctions:GetIterator() do
        local success_10, v31 = pcall(
            function()
                --[[
                  line: 341
                  upvalues:
                    value_upv_7 (copy, index: 1)
                    a2 (copy, index: 2)
                    a3 (copy, index: 3)
                    a4 (copy, index: 4)
                ]]
                value_upv_7(a2, a3, a4)
            end
        )
        if not (success_10) then
            warn(string.format("DoMessageFilter Function '%s' failed for reason: %s", key_4, v31))
        end
    end
end
function tbl_upv_2.InternalDoProcessCommands(a1, a2, a3, a4)
    --[[
      name: InternalDoProcessCommands
      line: 351
    ]]
    for key_5, value_upv_8, _ in a1.ProcessCommandsFunctions:GetIterator() do
        local success_11, v32 = pcall(
            function()
                --[[
                  line: 354
                  upvalues:
                    value_upv_8 (copy, index: 1)
                    a2 (copy, index: 2)
                    a3 (copy, index: 3)
                    a4 (copy, index: 4)
                ]]
                local v33 = value_upv_8(a2, a3, a4)
                if type(v33) ~= "boolean" then
                    error("Process command functions must return a bool")
                end
                return v33
            end
        )
        if not (success_11) then
            warn(string.format("DoProcessCommands Function '%s' failed for reason: %s", key_5, v32))
            continue
        elseif not (v32) then
            continue
        else
            return true
        end
    end
    return false
end
function getLanguageCodeFromLocale(a1)
    --[[
      name: getLanguageCodeFromLocale
      line: 372
    ]]
    local v34 = string.gmatch(a1, "[^-]+")()
    if v34 then
        return v34
    end
    return "en"
end
function tbl_upv_2.InternalPostMessage(a1, a2, a3, a4)
    --[[
      name: InternalPostMessage
      line: 382
      upvalues:
        u4 (ref,  index: 1)
        Chat_upv_1 (copy, index: 2)
        u1 (ref,  index: 3)
        u3 (ref,  index: 4)
        u2 (ref,  index: 5)
    ]]
    if a1:InternalDoProcessCommands(a2.Name, a3, a1.Name) then
        return false
    end
    local v35 = nil
    if a1.Mutes[a2.Name:lower()] ~= nil then
        v35 = a1.Mutes[a2.Name:lower()]
        if v35 > 0 and v35 < os.time() then
            a1:UnmuteSpeaker(a2.Name)
        else
            a1:SendSystemMessageToSpeaker(u4:FormatMessageToSend("GameChat_ChatChannel_MutedInChannel", "You are muted and cannot talk in this channel"), a2.Name)
            return false
        end
    end
    local u8 = a1:InternalCreateMessageObject(a3, a2.Name, false, a4)
    u8.Message = a3
    local u9 = nil
    pcall(
        function()
            --[[
              line: 400
              upvalues:
                u9 (ref,  index: 1)
                Chat_upv_1 (copy, index: 2)
                u8 (ref,  index: 3)
            ]]
            u9 = Chat_upv_1:InvokeChatCallback(Enum.ChatCallbackType.OnServerReceivingMessage, u8)
        end
    )
    u8.Message = nil
    if u9 then
        if u9.ShouldDeliver ~= false then
            u8 = u9
        else
            return false
        end
    end
    local v36 = a1:SendMessageObjToFilters(a3, u8, a2)
    local tbl_8 = {}
    for _, value_9 in pairs(a1.Speakers) do
        if value_9:IsSpeakerMuted(a2.Name) or not (a1:CanCommunicate(a2, value_9)) then
            continue
        end
        table.insert(tbl_8, value_9.Name)
        if value_9.Name ~= a2.Name then
            value_9:InternalSendMessage(u8, a1.Name)
            continue
        end
        local tbl_9 = {}
        for key_6, value_10 in pairs(u8) do
            tbl_9[key_6] = value_10
        end
        if u1 then
            tbl_9.Message = string.rep("_", u8.MessageLengthUtf8 or (u8.MessageLength))
        else
            tbl_9.Message = v36
        end
        tbl_9.IsFiltered = true
        value_9:InternalSendMessage(tbl_9, a1.Name)
    end
    local v37, v38 = pcall(
        function()
            --[[
              line: 439
              upvalues:
                a1 (copy, index: 1)
                u8 (ref,  index: 2)
            ]]
            a1.eMessagePosted:Fire(u8)
        end
    )
    if not (v37) and v38 then
        print("Error posting message: " .. v38)
    end
    local v39 = ((a1.Private) and (Enum.TextFilterContext.PrivateChat)) or (Enum.TextFilterContext.PublicChat)
    v37 = nil
    if u3 then
        local tbl_10 = {}
        local tbl_11 = {}
        for _, value_11 in pairs(a1.Speakers) do
            local v40 = value_11:GetPlayer()
            if v40 == nil then
                continue
            end
            if v40.LocaleId ~= nil then
                tbl_11[getLanguageCodeFromLocale(v40.LocaleId)] = true
            end
        end
        for key_7, _ in tbl_11 do
            table.insert(tbl_10, key_7)
        end
        local v41, v42, v43 = a1.ChatService:InternalApplyRobloxFilterAndTranslate(u8.FromSpeaker, tbl_10, v36, v39)
        if v41 then
            if v42 then
                u8.FilterResult = v43.SourceText
            else
                u8.FilterResult = v43
            end
            u8.IsFilterResult = v42
            if v42 then
                v37 = v43
            end
        elseif u2 then
            u8.IsFilterResult = false
            u8.FilterResult = ""
            u8.MessageLength = 0
        else
            return false
        end
        u8.IsFiltered = true
        a1:InternalAddMessageToHistoryLog(u8)
        for _, value_12 in pairs(tbl_8) do
            local v44 = a1.Speakers[value_12]
            if not (v44) then
                continue
            end
            local v45 = u3 and (v37 and ((a2:GetPlayer() ~= nil) and ((v44:GetPlayer() ~= nil) and (a2:GetPlayer().LocaleId ~= v44:GetPlayer().LocaleId))))
            if v45 then
                v44:InternalSendFilteredMessageWithTranslatedFilterResult(u8, a1.Name, v37)
            else
                v44:InternalSendFilteredMessageWithFilterResult(u8, a1.Name)
            end
        end
        v37 = {}
        local v46 = nil
        for _, value_13 in pairs(a1.Speakers) do
            local v47 = value_13:IsSpeakerMuted(a2.Name)
            if v47 then
                continue
            end
            local v48 = a1:CanCommunicate(a2, value_13)
            if not (v48) then
                continue
            end
            v46 = false
            for v53, value_14 in pairs(tbl_8) do
                if value_13.Name == value_14 then
                    v46 = true
                    break
                end
            end
            if not (v46) then
                table.insert(v37, value_13.Name)
            end
        end
        for _, value_15 in pairs(v37) do
            local v49 = a1.Speakers[value_15]
            if v49 then
                v49:InternalSendFilteredMessageWithFilterResult(u8, a1.Name)
            end
        end
        return u8
    else
        local v50, v51
        local v52
        v52, v50, v51 = a1.ChatService:InternalApplyRobloxFilterNewAPI(u8.FromSpeaker, v36, v39)
        if v52 then
            u8.FilterResult = v51
            u8.IsFilterResult = v50
            u8.IsFiltered = true
            a1:InternalAddMessageToHistoryLog(u8)
            for _, value_12 in pairs(tbl_8) do
                local v44 = a1.Speakers[value_12]
                if not (v44) then
                    continue
                end
                local v45 = u3 and (v37 and ((a2:GetPlayer() ~= nil) and ((v44:GetPlayer() ~= nil) and (a2:GetPlayer().LocaleId ~= v44:GetPlayer().LocaleId))))
                if v45 then
                    v44:InternalSendFilteredMessageWithTranslatedFilterResult(u8, a1.Name, v37)
                else
                    v44:InternalSendFilteredMessageWithFilterResult(u8, a1.Name)
                end
            end
            v37 = {}
            local v46 = nil
            for _, value_13 in pairs(a1.Speakers) do
                local v47 = value_13:IsSpeakerMuted(a2.Name)
                if v47 then
                    continue
                end
                local v48 = a1:CanCommunicate(a2, value_13)
                if not (v48) then
                    continue
                end
                v46 = false
                for v53, value_14 in pairs(tbl_8) do
                    if value_13.Name == value_14 then
                        v46 = true
                        break
                    end
                end
                if not (v46) then
                    table.insert(v37, value_13.Name)
                end
            end
            for _, value_15 in pairs(v37) do
                local v49 = a1.Speakers[value_15]
                if v49 then
                    v49:InternalSendFilteredMessageWithFilterResult(u8, a1.Name)
                end
            end
            return u8
        else
            if not u2 then
                return false
            end
            u8.IsFilterResult = false
            u8.FilterResult = ""
            u8.MessageLength = 0
            u8.IsFiltered = true
            a1:InternalAddMessageToHistoryLog(u8)
            for _, value_12 in pairs(tbl_8) do
                local v44 = a1.Speakers[value_12]
                if not (v44) then
                    continue
                end
                local v45 = u3 and (v37 and ((a2:GetPlayer() ~= nil) and ((v44:GetPlayer() ~= nil) and (a2:GetPlayer().LocaleId ~= v44:GetPlayer().LocaleId))))
                if v45 then
                    v44:InternalSendFilteredMessageWithTranslatedFilterResult(u8, a1.Name, v37)
                else
                    v44:InternalSendFilteredMessageWithFilterResult(u8, a1.Name)
                end
            end
            v37 = {}
            local v46 = nil
            for _, value_13 in pairs(a1.Speakers) do
                local v47 = value_13:IsSpeakerMuted(a2.Name)
                if v47 then
                    continue
                end
                local v48 = a1:CanCommunicate(a2, value_13)
                if not (v48) then
                    continue
                end
                v46 = false
                for v53, value_14 in pairs(tbl_8) do
                    if value_13.Name == value_14 then
                        v46 = true
                        break
                    end
                end
                if not (v46) then
                    table.insert(v37, value_13.Name)
                end
            end
            for _, value_15 in pairs(v37) do
                local v49 = a1.Speakers[value_15]
                if v49 then
                    v49:InternalSendFilteredMessageWithFilterResult(u8, a1.Name)
                end
            end
            return u8
        end
    end
end
function tbl_upv_2.InternalAddSpeaker(a1, a2)
    --[[
      name: InternalAddSpeaker
      line: 551
    ]]
    if a1.Speakers[a2.Name] then
        warn("Speaker \"" .. a2.name .. "\" is already in the channel!")
    else
        a1.Speakers[a2.Name] = a2
        local success_12, v53 = pcall(
            function()
                --[[
                  line: 558
                  upvalues:
                    a1 (copy, index: 1)
                    a2 (copy, index: 2)
                ]]
                a1.eSpeakerJoined:Fire(a2.Name)
            end
        )
        if not (success_12) and v53 then
            print("Error removing channel: " .. v53)
        end
    end
end
function tbl_upv_2.InternalRemoveSpeaker(a1, a2)
    --[[
      name: InternalRemoveSpeaker
      line: 564
    ]]
    if a1.Speakers[a2.Name] then
        a1.Speakers[a2.Name] = nil
        local success_13, v54 = pcall(
            function()
                --[[
                  line: 571
                  upvalues:
                    a1 (copy, index: 1)
                    a2 (copy, index: 2)
                ]]
                a1.eSpeakerLeft:Fire(a2.Name)
            end
        )
        if not (success_13) and v54 then
            print("Error removing speaker: " .. v54)
        end
    else
        warn("Speaker \"" .. a2.name .. "\" is not in the channel!")
    end
end
function tbl_upv_2.InternalRemoveExcessMessagesFromLog(a1)
    --[[
      name: InternalRemoveExcessMessagesFromLog
      line: 577
    ]]
    while a1.MaxHistory < #a1.ChatHistory do
        table.remove(a1.ChatHistory, 1)
    end
end
function tbl_upv_2.InternalAddMessageToHistoryLog(a1, a2)
    --[[
      name: InternalAddMessageToHistoryLog
      line: 584
    ]]
    table.insert(a1.ChatHistory, a2)
    a1:InternalRemoveExcessMessagesFromLog()
end
function tbl_upv_2.GetMessageType(a1, a2, a3)
    --[[
      name: GetMessageType
      line: 590
      upvalues:
        ChatConstants_upv_1 (copy, index: 1)
    ]]
    if a3 ~= nil then
        return ChatConstants_upv_1.MessageTypeDefault
    end
    return ChatConstants_upv_1.MessageTypeSystem
end
function tbl_upv_2.InternalCreateMessageObject(a1, a2, a3, a4, a5)
    --[[
      name: InternalCreateMessageObject
      line: 597
      upvalues:
        ChatSettings_upv_1 (copy, index: 1)
    ]]
    local v55 = a1:GetMessageType(a2, a3)
    local v56 = -1
    local v57 = nil
    local v58 = nil
    if a3 then
        v58 = a1.ChatService:GetSpeaker(a3)
        local v59 = nil
        if v58 then
            v59 = v58:GetPlayer()
            if v59 then
                v56 = v59.UserId
                v57 = not ChatSettings_upv_1.PlayerDisplayNamesEnabled or v58:GetNameForDisplay()
            else
                v56 = 0
            end
        end
    end
    local tbl_12 = {Message = 0, Time = 0, ExtraData = 0}
    tbl_12.ID = a1.ChatService:InternalGetUniqueMessageId()
    tbl_12.FromSpeaker = a3
    tbl_12.SpeakerDisplayName = v57
    tbl_12.SpeakerUserId = v56
    tbl_12.OriginalChannel = a1.Name
    tbl_12.MessageLength = string.len(a2)
    tbl_12.MessageLengthUtf8 = utf8.len(utf8.nfcnormalize(a2))
    tbl_12.MessageType = v55
    tbl_12.IsFiltered = a4
    tbl_12.Message = (a4 and a2) or nil
    tbl_12.Time = os.time()
    tbl_12.ExtraData = {}
    if v58 then
        for key_8, value_16 in pairs(v58.ExtraData) do
            tbl_12.ExtraData[key_8] = value_16
        end
    end
    if a5 then
        for key_9, value_17 in pairs(a5) do
            tbl_12.ExtraData[key_9] = value_17
        end
    end
    return tbl_12
end
function tbl_upv_2.SetChannelNameColor(a1, a2)
    --[[
      name: SetChannelNameColor
      line: 657
    ]]
    a1.ChannelNameColor = a2
    for _, value_18 in pairs(a1.Speakers) do
        value_18:UpdateChannelNameColor(a1.Name, a2)
    end
end
function tbl_upv_2.GetWelcomeMessageForSpeaker(a1, a2)
    --[[
      name: GetWelcomeMessageForSpeaker
      line: 664
    ]]
    if a1.GetWelcomeMessageFunction then
        local v60 = a1.GetWelcomeMessageFunction(a2)
        if v60 then
            return v60
        end
    end
    return a1.WelcomeMessage
end
function tbl_upv_2.RegisterGetWelcomeMessageFunction(a1, a2)
    --[[
      name: RegisterGetWelcomeMessageFunction
      line: 674
    ]]
    if type(a2) ~= "function" then
        error("RegisterGetWelcomeMessageFunction must be called with a function.")
    end
    a1.GetWelcomeMessageFunction = a2
end
function tbl_upv_2.UnRegisterGetWelcomeMessageFunction(a1)
    --[[
      name: UnRegisterGetWelcomeMessageFunction
      line: 681
    ]]
    a1.GetWelcomeMessageFunction = nil
end
function tbl_1.new(a1, a2, a3, a4)
    --[[
      name: new
      line: 688
      upvalues:
        tbl_upv_2 (copy, index: 1)
        Util_upv_1 (copy, index: 2)
    ]]
    local v61 = setmetatable({}, tbl_upv_2)
    v61.ChatService = a1
    v61.Name = a2
    v61.WelcomeMessage = a3 or ""
    v61.GetWelcomeMessageFunction = nil
    v61.ChannelNameColor = a4
    v61.Joinable = true
    v61.Leavable = true
    v61.AutoJoin = false
    v61.Private = false
    v61.Speakers = {}
    v61.Mutes = {}
    v61.MaxHistory = 200
    v61.HistoryIndex = 0
    v61.ChatHistory = {}
    v61.FilterMessageFunctions = Util_upv_1:NewSortedFunctionContainer()
    v61.ProcessCommandsFunctions = Util_upv_1:NewSortedFunctionContainer()
    v61.eDestroyed = Instance.new("BindableEvent")
    v61.eMessagePosted = Instance.new("BindableEvent")
    v61.eSpeakerJoined = Instance.new("BindableEvent")
    v61.eSpeakerLeft = Instance.new("BindableEvent")
    v61.eSpeakerMuted = Instance.new("BindableEvent")
    v61.eSpeakerUnmuted = Instance.new("BindableEvent")
    v61.MessagePosted = v61.eMessagePosted.Event
    v61.SpeakerJoined = v61.eSpeakerJoined.Event
    v61.SpeakerLeft = v61.eSpeakerLeft.Event
    v61.SpeakerMuted = v61.eSpeakerMuted.Event
    v61.SpeakerUnmuted = v61.eSpeakerUnmuted.Event
    v61.Destroyed = v61.eDestroyed.Event
    return v61
end
return tbl_1