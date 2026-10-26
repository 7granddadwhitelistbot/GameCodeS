local tbl_1 = {}
local RunService_upv_1 = game:GetService("RunService")
local ChatSettings_upv_1 = require(game:GetService("Chat"):WaitForChild("ClientChatModules"):WaitForChild("ChatSettings"))
local success_1, v1 = pcall(
    function()
        --[[
          line: 16
        ]]
        return UserSettings():IsUserFeatureEnabled("UserRemoveMessageOnTextFilterFailures")
    end
)
local u1 = success_1 and v1
local _, v2 = pcall(
    function()
        --[[
          line: 24
        ]]
        return UserSettings():IsUserFeatureEnabled("UserIsChatTranslationEnabled2")
    end
)
local function ShallowCopy(a1)
    --[[
      name: ShallowCopy
      line: 32
    ]]
    local tbl_2 = {}
    for key_1, value_1 in pairs(a1) do
        tbl_2[key_1] = value_1
    end
    return tbl_2
end
local tbl_upv_3 = {}
local tbl_upv_4 = {eChannelJoined = true, eMainChannelSet = true, eMessageDoneFiltering = true, eDestroyed = true, eChannelNameColorUpdated = true, eExtraDataUpdated = true, eMuted = true, eUnmuted = true, eChannelLeft = true, eReceivedMessage = true, eSaidMessage = true, eReceivedSystemMessage = true, eReceivedUnfilteredMessage = true}
local tbl_upv_5 = {
    ChannelJoined = "eChannelJoined",
    ReceivedSystemMessage = "eReceivedSystemMessage",
    ChannelNameColorUpdated = "eChannelNameColorUpdated",
    Destroyed = "eDestroyed",
    SaidMessage = "eSaidMessage",
    ExtraDataUpdated = "eExtraDataUpdated",
    ReceivedUnfilteredMessage = "eReceivedUnfilteredMessage",
    Unmuted = "eUnmuted",
    Muted = "eMuted",
    ChannelLeft = "eChannelLeft",
    RecievedUnfilteredMessage = "eReceivedUnfilteredMessage",
    ReceivedMessage = "eReceivedMessage",
    MainChannelSet = "eMainChannelSet",
    MessageDoneFiltering = "eMessageDoneFiltering"
}
tbl_upv_3.__index = function(a1, a2)
    --[[
      line: 76
      upvalues:
        tbl_upv_3 (copy, index: 1)
        tbl_upv_4 (copy, index: 2)
        tbl_upv_5 (copy, index: 3)
    ]]
    local value_2 = rawget(tbl_upv_3, a2)
    if value_2 then
        return value_2
    end
    if tbl_upv_4[a2] and not (rawget(a1, a2)) then
        rawset(a1, a2, Instance.new("BindableEvent"))
    end
    local v2 = tbl_upv_5[a2]
    if v2 and not (rawget(a1, a2)) then
        local v3 = rawget(a1, v2)
        if not (v3) then
            v3 = Instance.new("BindableEvent")
            rawset(a1, v2, v3)
        end
        rawset(a1, a2, v3.Event)
    end
    return (rawget(a1, a2))
end
function tbl_upv_3.LazyFire(a1, a2, ...)
    --[[
      name: LazyFire
      line: 95
    ]]
    local value_3 = rawget(a1, a2)
    if not value_3 then
        return
    end
    value_3:Fire(...)
end
function tbl_upv_3.SayMessage(a1, a2, a3, a4)
    --[[
      name: SayMessage
      line: 102
    ]]
    if a1.ChatService:InternalDoProcessCommands(a1.Name, a2, a3) or not a3 then
        return
    end
    local v4 = a1.Channels[a3:lower()]
    if not v4 then
        return
    end
    local u2 = v4:InternalPostMessage(a1, a2, a4)
    if u2 then
        pcall(
            function()
                --[[
                  line: 117
                  upvalues:
                    a1 (copy, index: 1)
                    u2 (copy, index: 2)
                    a3 (copy, index: 3)
                ]]
                a1:LazyFire("eSaidMessage", u2, a3)
            end
        )
    end
    return u2
end
function tbl_upv_3.JoinChannel(a1, a2)
    --[[
      name: JoinChannel
      line: 125
    ]]
    if a1.Channels[a2:lower()] then
        warn("Speaker is already in channel \"" .. a2 .. "\"")
    else
        local u3 = a1.ChatService:GetChannel(a2)
        if not (u3) then
            error("Channel \"" .. a2 .. "\" does not exist!")
        end
        a1.Channels[a2:lower()] = u3
        u3:InternalAddSpeaker(a1)
        local success_2, v5 = pcall(
            function()
                --[[
                  line: 138
                  upvalues:
                    a1 (copy, index: 1)
                    u3 (copy, index: 2)
                ]]
                a1.eChannelJoined:Fire(u3.Name, u3:GetWelcomeMessageForSpeaker(a1))
            end
        )
        if not (success_2) and v5 then
            print("Error joining channel: " .. v5)
        end
    end
end
function tbl_upv_3.LeaveChannel(a1, a2)
    --[[
      name: LeaveChannel
      line: 146
    ]]
    if a1.Channels[a2:lower()] then
        local u4 = a1.Channels[a2:lower()]
        a1.Channels[a2:lower()] = nil
        u4:InternalRemoveSpeaker(a1)
        local success_3, v6 = pcall(
            function()
                --[[
                  line: 156
                  upvalues:
                    a1 (copy, index: 1)
                    u4 (copy, index: 2)
                ]]
                a1:LazyFire("eChannelLeft", u4.Name)
                if not a1.PlayerObj then
                    return
                end
                a1.EventFolder.OnChannelLeft:FireClient(a1.PlayerObj, u4.Name)
            end
        )
        if not (success_3) and v6 then
            print("Error leaving channel: " .. v6)
        end
    else
        warn("Speaker is not in channel \"" .. a2 .. "\"")
    end
end
function tbl_upv_3.IsInChannel(a1, a2)
    --[[
      name: IsInChannel
      line: 167
    ]]
    local v7 = a1.Channels[a2:lower()] ~= nil
    return v7
end
function tbl_upv_3.GetChannelList(a1)
    --[[
      name: GetChannelList
      line: 171
    ]]
    local tbl_6 = {}
    for _, value_4 in pairs(a1.Channels) do
        table.insert(tbl_6, value_4.Name)
    end
    return tbl_6
end
function tbl_upv_3.SendMessage(a1, a2, a3, a4, a5)
    --[[
      name: SendMessage
      line: 179
      upvalues:
        RunService_upv_1 (copy, index: 1)
    ]]
    local v8 = a1.Channels[a3:lower()]
    if v8 then
        v8:SendMessageToSpeaker(a2, a1.Name, a4, a5)
    elseif RunService_upv_1:IsStudio() then
        warn(string.format("Speaker '%s' is not in channel '%s' and cannot receive a message in it.", a1.Name, a3))
    end
end
function tbl_upv_3.SendSystemMessage(a1, a2, a3, a4)
    --[[
      name: SendSystemMessage
      line: 190
      upvalues:
        RunService_upv_1 (copy, index: 1)
    ]]
    local v9 = a1.Channels[a3:lower()]
    if v9 then
        v9:SendSystemMessageToSpeaker(a2, a1.Name, a4)
    elseif RunService_upv_1:IsStudio() then
        warn(string.format("Speaker '%s' is not in channel '%s' and cannot receive a system message in it.", a1.Name, a3))
    end
end
function tbl_upv_3.GetPlayer(a1)
    --[[
      name: GetPlayer
      line: 201
    ]]
    return a1.PlayerObj
end
function tbl_upv_3.GetNameForDisplay(a1)
    --[[
      name: GetNameForDisplay
      line: 205
      upvalues:
        ChatSettings_upv_1 (copy, index: 1)
    ]]
    if not ChatSettings_upv_1.PlayerDisplayNamesEnabled then
        return a1.Name
    end
    local v10 = a1:GetPlayer()
    if v10 then
        return v10.DisplayName
    end
    return a1.Name
end
function tbl_upv_3.SetExtraData(a1, a2, a3)
    --[[
      name: SetExtraData
      line: 219
    ]]
    a1.ExtraData[a2] = a3
    a1:LazyFire("eExtraDataUpdated", a2, a3)
end
function tbl_upv_3.GetExtraData(a1, a2)
    --[[
      name: GetExtraData
      line: 224
    ]]
    return a1.ExtraData[a2]
end
function tbl_upv_3.SetMainChannel(a1, a2)
    --[[
      name: SetMainChannel
      line: 228
    ]]
    local success_4, v11 = pcall(
        function()
            --[[
              line: 229
              upvalues:
                a1 (copy, index: 1)
                a2 (copy, index: 2)
            ]]
            a1:LazyFire("eMainChannelSet", a2)
            if not a1.PlayerObj then
                return
            end
            a1.EventFolder.OnMainChannelSet:FireClient(a1.PlayerObj, a2)
        end
    )
    if (success_4) or not v11 then
        return
    end
    print("Error setting main channel: " .. v11)
end
function tbl_upv_3.AddMutedSpeaker(a1, a2)
    --[[
      name: AddMutedSpeaker
      line: 241
    ]]
    a1.MutedSpeakers[a2:lower()] = true
end
function tbl_upv_3.RemoveMutedSpeaker(a1, a2)
    --[[
      name: RemoveMutedSpeaker
      line: 245
    ]]
    a1.MutedSpeakers[a2:lower()] = false
end
function tbl_upv_3.IsSpeakerMuted(a1, a2)
    --[[
      name: IsSpeakerMuted
      line: 249
    ]]
    return a1.MutedSpeakers[a2:lower()]
end
function tbl_upv_3.InternalDestroy(a1)
    --[[
      name: InternalDestroy
      line: 255
    ]]
    for _, value_5 in pairs(a1.Channels) do
        value_5:InternalRemoveSpeaker(a1)
    end
    a1.eDestroyed:Fire()
    a1.EventFolder = nil
    a1.eDestroyed:Destroy()
    a1.eSaidMessage:Destroy()
    a1.eReceivedMessage:Destroy()
    a1.eReceivedUnfilteredMessage:Destroy()
    a1.eMessageDoneFiltering:Destroy()
    a1.eReceivedSystemMessage:Destroy()
    a1.eChannelJoined:Destroy()
    a1.eChannelLeft:Destroy()
    a1.eMuted:Destroy()
    a1.eUnmuted:Destroy()
    a1.eExtraDataUpdated:Destroy()
    a1.eMainChannelSet:Destroy()
    a1.eChannelNameColorUpdated:Destroy()
end
function tbl_upv_3.InternalAssignPlayerObject(a1, a2)
    --[[
      name: InternalAssignPlayerObject
      line: 278
    ]]
    a1.PlayerObj = a2
end
function tbl_upv_3.InternalAssignEventFolder(a1, a2)
    --[[
      name: InternalAssignEventFolder
      line: 282
    ]]
    a1.EventFolder = a2
end
function tbl_upv_3.InternalSendMessage(a1, a2, a3)
    --[[
      name: InternalSendMessage
      line: 286
    ]]
    local success_5, v12 = pcall(
        function()
            --[[
              line: 287
              upvalues:
                a1 (copy, index: 1)
                a2 (copy, index: 2)
                a3 (copy, index: 3)
            ]]
            a1:LazyFire("eReceivedUnfilteredMessage", a2, a3)
            if not a1.PlayerObj then
                return
            end
            a1.EventFolder.OnNewMessage:FireClient(a1.PlayerObj, a2, a3)
        end
    )
    if (success_5) or not v12 then
        return
    end
    print("Error sending internal message: " .. v12)
end
function tbl_upv_3.InternalSendFilteredMessage(a1, a2, a3)
    --[[
      name: InternalSendFilteredMessage
      line: 298
    ]]
    local success_6, v13 = pcall(
        function()
            --[[
              line: 299
              upvalues:
                a1 (copy, index: 1)
                a2 (copy, index: 2)
                a3 (copy, index: 3)
            ]]
            a1:LazyFire("eReceivedMessage", a2, a3)
            a1:LazyFire("eMessageDoneFiltering", a2, a3)
            if not a1.PlayerObj then
                return
            end
            a1.EventFolder.OnMessageDoneFiltering:FireClient(a1.PlayerObj, a2, a3)
        end
    )
    if (success_6) or not v13 then
        return
    end
    print("Error sending internal filtered message: " .. v13)
end
function tbl_upv_3.InternalSendFilteredMessageWithTranslatedFilterResult(a1, a2, a3, a4)
    --[[
      name: InternalSendFilteredMessageWithTranslatedFilterResult
      line: 314
      upvalues:
        u1 (ref, index: 1)
    ]]
    local tbl_upv_7 = {}
    for key_2, value_6 in pairs(a2) do
        tbl_upv_7[key_2] = value_6
    end
    local FilterResult_upv_1 = tbl_upv_7.FilterResult
    local u5 = a1:GetPlayer()
    local u6
    if u5 == nil then
        u6 = nil
    else
        u6 = a4:GetTranslationForLocale(u5.LocaleId)
    end
    local u7 = ""
    local u8 = nil
    pcall(
        function()
            --[[
              line: 324
              upvalues:
                tbl_upv_7 (copy, index: 1)
                u5 (copy, index: 2)
                u7 (ref,  index: 3)
                FilterResult_upv_1 (copy, index: 4)
                u6 (copy, index: 5)
                u8 (ref,  index: 6)
            ]]
            if tbl_upv_7.IsFilterResult then
                if u5 then
                    u7 = FilterResult_upv_1:GetChatForUserAsync(u5.UserId)
                    if not u6 then
                        return
                    end
                    u8 = u6:GetChatForUserAsync(u5.UserId)
                else
                    u7 = FilterResult_upv_1:GetNonChatStringForBroadcastAsync()
                    if not u6 then
                        return
                    end
                    u8 = u6:GetNonChatStringForBroadcastAsync()
                end
            else
                u7 = FilterResult_upv_1
            end
        end
    )
    if u1 or (#u7 > 0) then
        tbl_upv_7.Message = u7
        if u8 then
            tbl_upv_7.TranslatedMessage = u8
        end
        tbl_upv_7.FilterResult = nil
        a1:InternalSendFilteredMessage(tbl_upv_7, a3)
    end
end
function tbl_upv_3.InternalSendFilteredMessageWithFilterResult(a1, a2, a3)
    --[[
      name: InternalSendFilteredMessageWithFilterResult
      line: 360
      upvalues:
        u1 (ref, index: 1)
    ]]
    local tbl_upv_8 = {}
    for key_3, value_7 in pairs(a2) do
        tbl_upv_8[key_3] = value_7
    end
    local FilterResult_upv_2 = tbl_upv_8.FilterResult
    local u9 = a1:GetPlayer()
    local u10 = ""
    pcall(
        function()
            --[[
              line: 367
              upvalues:
                tbl_upv_8 (copy, index: 1)
                u9 (copy, index: 2)
                u10 (ref,  index: 3)
                FilterResult_upv_2 (copy, index: 4)
            ]]
            if tbl_upv_8.IsFilterResult then
                if u9 then
                    u10 = FilterResult_upv_2:GetChatForUserAsync(u9.UserId)
                else
                    u10 = FilterResult_upv_2:GetNonChatStringForBroadcastAsync()
                end
            else
                u10 = FilterResult_upv_2
            end
        end
    )
    if u1 or (#u10 > 0) then
        tbl_upv_8.Message = u10
        tbl_upv_8.FilterResult = nil
        a1:InternalSendFilteredMessage(tbl_upv_8, a3)
    end
end
function tbl_upv_3.InternalSendSystemMessage(a1, a2, a3)
    --[[
      name: InternalSendSystemMessage
      line: 396
    ]]
    local success_7, v14 = pcall(
        function()
            --[[
              line: 397
              upvalues:
                a1 (copy, index: 1)
                a2 (copy, index: 2)
                a3 (copy, index: 3)
            ]]
            a1:LazyFire("eReceivedSystemMessage", a2, a3)
            if not a1.PlayerObj then
                return
            end
            a1.EventFolder.OnNewSystemMessage:FireClient(a1.PlayerObj, a2, a3)
        end
    )
    if (success_7) or not v14 then
        return
    end
    print("Error sending internal system message: " .. v14)
end
function tbl_upv_3.UpdateChannelNameColor(a1, a2, a3)
    --[[
      name: UpdateChannelNameColor
      line: 408
    ]]
    a1:LazyFire("eChannelNameColorUpdated", a2, a3)
    if not a1.PlayerObj then
        return
    end
    a1.EventFolder.ChannelNameColorUpdated:FireClient(a1.PlayerObj, a2, a3)
end
function tbl_1.new(a1, a2)
    --[[
      name: new
      line: 418
      upvalues:
        tbl_upv_3 (copy, index: 1)
    ]]
    local v15 = setmetatable({}, tbl_upv_3)
    v15.ChatService = a1
    v15.PlayerObj = nil
    v15.Name = a2
    v15.ExtraData = {}
    v15.Channels = {}
    v15.MutedSpeakers = {}
    v15.EventFolder = nil
    return v15
end
return tbl_1