local v1 = {}
local runService = game:GetService("RunService")
local chat = game:GetService("Chat")
local clientChatModules = chat:WaitForChild("ClientChatModules")
local childName = "ChatSettings"
local child = require(clientChatModules:WaitForChild(childName))
local _ = script.Parent
local success, isUserFeatureEnabled = pcall(
    function()
        --[[
          line: 16
        ]]
        return UserSettings():IsUserFeatureEnabled("UserRemoveMessageOnTextFilterFailures")
    end
)
local isUserFeatureEnabled2 = success and isUserFeatureEnabled
_, _ = pcall(
    function()
        --[[
          line: 24
        ]]
        return UserSettings():IsUserFeatureEnabled("UserIsChatTranslationEnabled2")
    end
)

local function ShallowCopy(a14)
    --[[
      name: ShallowCopy
      line: 32
    ]]
    local v15 = {}

    for key, v17 in pairs(a14) do
        v15[key] = v17
    end

    return v15
end

local v18 = {}
local v19 = {eDestroyed = true, eSaidMessage = true, eReceivedMessage = true, eReceivedUnfilteredMessage = true, eMessageDoneFiltering = true, eReceivedSystemMessage = true, eChannelJoined = true, eChannelLeft = true, eMuted = true, eUnmuted = true, eExtraDataUpdated = true, eMainChannelSet = true, eChannelNameColorUpdated = true}
local v20 = {
    Destroyed = "eDestroyed",
    SaidMessage = "eSaidMessage",
    ReceivedMessage = "eReceivedMessage",
    ReceivedUnfilteredMessage = "eReceivedUnfilteredMessage",
    RecievedUnfilteredMessage = "eReceivedUnfilteredMessage",
    MessageDoneFiltering = "eMessageDoneFiltering",
    ReceivedSystemMessage = "eReceivedSystemMessage",
    ChannelJoined = "eChannelJoined",
    ChannelLeft = "eChannelLeft",
    Muted = "eMuted",
    Unmuted = "eUnmuted",
    ExtraDataUpdated = "eExtraDataUpdated",
    MainChannelSet = "eMainChannelSet",
    ChannelNameColorUpdated = "eChannelNameColorUpdated"
}

v18.__index = function(a21, key)
    --[[
      line: 76
      upvalues:
        v18 (copy, index: 1)
        v19 (copy, index: 2)
        v20 (copy, index: 3)
    ]]
    if const value = rawget(v18, key) then
        return value
    end

    if v19[key] and not rawget(a21, key) then
        rawset(a21, key, Instance.new("BindableEvent"))
    end

    local v24 = v20[key]

    if v24 and not rawget(a21, key) then
        local v25 = rawget(a21, v24)
        if not v25 then
            v25 = Instance.new("BindableEvent")
            rawset(a21, v24, v25)
        end

        rawset(a21, key, v25.Event)
    end

    return (rawget(a21, key))
end

function v18.LazyFire(a26, a27, ...)
    --[[
      name: LazyFire
      line: 95
    ]]
    if const value = rawget(a26, a27) then
        value:Fire(...)
    end
end

function v18.SayMessage(a29, a30, a31, a32)
    --[[
      name: SayMessage
      line: 102
    ]]
    if a29.ChatService:InternalDoProcessCommands(a29.Name, a30, a31) then
        return
    end
    if not a31 then
        return
    end

    local channel = a29.Channels[a31:lower()]
    if not channel then
        return
    end

    local v34 = channel:InternalPostMessage(a29, a30, a32)
    if v34 then
        pcall(
            function()
                --[[
                  line: 117
                  upvalues:
                    a29 (copy, index: 1)
                    v34 (copy, index: 2)
                    a31 (copy, index: 3)
                ]]
                a29:LazyFire("eSaidMessage", v34, a31)
            end
        )
    end

    return v34
end

function v18.JoinChannel(a35, a36)
    --[[
      name: JoinChannel
      line: 125
    ]]
    if a35.Channels[a36:lower()] then
        warn("Speaker is already in channel \"" .. a36 .. "\"")
        return
    end

    local channel = a35.ChatService:GetChannel(a36)
    if not channel then
        error("Channel \"" .. a36 .. "\" does not exist!")
    end

    a35.Channels[a36:lower()] = channel
    channel:InternalAddSpeaker(a35)
    local success, result = pcall(
        function()
            --[[
              line: 138
              upvalues:
                a35 (copy, index: 1)
                channel (copy, index: 2)
            ]]
            a35.eChannelJoined:Fire(channel.Name, channel:GetWelcomeMessageForSpeaker(a35))
        end
    )

    if not success and result then
        print("Error joining channel: " .. result)
    end
end

function v18.LeaveChannel(a40, a41)
    --[[
      name: LeaveChannel
      line: 146
    ]]
    if not a40.Channels[a41:lower()] then
        warn("Speaker is not in channel \"" .. a41 .. "\"")
        return
    end

    local channel = a40.Channels[a41:lower()]
    a40.Channels[a41:lower()] = nil
    channel:InternalRemoveSpeaker(a40)

    local success, result = pcall(
        function()
            --[[
              line: 156
              upvalues:
                a40 (copy, index: 1)
                channel (copy, index: 2)
            ]]
            a40:LazyFire("eChannelLeft", channel.Name)

            if a40.PlayerObj then
                a40.EventFolder.OnChannelLeft:FireClient(a40.PlayerObj, channel.Name)
            end
        end
    )

    if not success and result then
        print("Error leaving channel: " .. result)
    end
end

function v18.IsInChannel(a45, a46)
    --[[
      name: IsInChannel
      line: 167
    ]]
    return a45.Channels[a46:lower()] ~= nil
end

function v18.GetChannelList(a47)
    --[[
      name: GetChannelList
      line: 171
    ]]
    local v48 = {}

    for _, channel in pairs(a47.Channels) do
        table.insert(v48, channel.Name)
    end

    return v48
end

function v18.SendMessage(a51, a52, a53, a54, a55)
    --[[
      name: SendMessage
      line: 179
      upvalues:
        runService (copy, index: 1)
    ]]
    if const channel = a51.Channels[a53:lower()] then
        channel:SendMessageToSpeaker(a52, a51.Name, a54, a55)
        return
    end

    if runService:IsStudio() then
        warn(string.format("Speaker '%s' is not in channel '%s' and cannot receive a message in it.", a51.Name, a53))
    end
end

function v18.SendSystemMessage(a57, a58, a59, a60)
    --[[
      name: SendSystemMessage
      line: 190
      upvalues:
        runService (copy, index: 1)
    ]]
    if const channel = a57.Channels[a59:lower()] then
        channel:SendSystemMessageToSpeaker(a58, a57.Name, a60)
        return
    end

    if runService:IsStudio() then
        warn(string.format("Speaker '%s' is not in channel '%s' and cannot receive a system message in it.", a57.Name, a59))
    end
end

function v18.GetPlayer(a62)
    --[[
      name: GetPlayer
      line: 201
    ]]
    return a62.PlayerObj
end

function v18.GetNameForDisplay(a63)
    --[[
      name: GetNameForDisplay
      line: 205
      upvalues:
        child (copy, index: 1)
    ]]
    return if not child.PlayerDisplayNamesEnabled then a63.Name elseif const player = a63:GetPlayer() then player.DisplayName else a63.Name
end

function v18.SetExtraData(extraData, key, value)
    --[[
      name: SetExtraData
      line: 219
    ]]
    extraData.ExtraData[key] = value
    extraData:LazyFire("eExtraDataUpdated", key, value)
end

function v18.GetExtraData(a68, key)
    --[[
      name: GetExtraData
      line: 224
    ]]
    return a68.ExtraData[key]
end

function v18.SetMainChannel(mainChannel, a71)
    --[[
      name: SetMainChannel
      line: 228
    ]]
    local success, result = pcall(
        function()
            --[[
              line: 229
              upvalues:
                mainChannel (copy, index: 1)
                a71 (copy, index: 2)
            ]]
            mainChannel:LazyFire("eMainChannelSet", a71)

            if mainChannel.PlayerObj then
                mainChannel.EventFolder.OnMainChannelSet:FireClient(mainChannel.PlayerObj, a71)
            end
        end
    )

    if not success and result then
        print("Error setting main channel: " .. result)
    end
end

function v18.AddMutedSpeaker(a74, a75)
    --[[
      name: AddMutedSpeaker
      line: 241
    ]]
    a74.MutedSpeakers[a75:lower()] = true
end

function v18.RemoveMutedSpeaker(a76, a77)
    --[[
      name: RemoveMutedSpeaker
      line: 245
    ]]
    a76.MutedSpeakers[a77:lower()] = false
end

function v18.IsSpeakerMuted(a78, a79)
    --[[
      name: IsSpeakerMuted
      line: 249
    ]]
    return a78.MutedSpeakers[a79:lower()]
end

function v18.InternalDestroy(a80)
    --[[
      name: InternalDestroy
      line: 255
    ]]
    for _, channel in pairs(a80.Channels) do
        channel:InternalRemoveSpeaker(a80)
    end

    a80.eDestroyed:Fire()
    a80.EventFolder = nil
    a80.eDestroyed:Destroy()
    a80.eSaidMessage:Destroy()
    a80.eReceivedMessage:Destroy()
    a80.eReceivedUnfilteredMessage:Destroy()
    a80.eMessageDoneFiltering:Destroy()
    a80.eReceivedSystemMessage:Destroy()
    a80.eChannelJoined:Destroy()
    a80.eChannelLeft:Destroy()
    a80.eMuted:Destroy()
    a80.eUnmuted:Destroy()
    a80.eExtraDataUpdated:Destroy()
    a80.eMainChannelSet:Destroy()
    a80.eChannelNameColorUpdated:Destroy()
end

function v18.InternalAssignPlayerObject(a83, playerObj)
    --[[
      name: InternalAssignPlayerObject
      line: 278
    ]]
    a83.PlayerObj = playerObj
end

function v18.InternalAssignEventFolder(a85, eventFolder)
    --[[
      name: InternalAssignEventFolder
      line: 282
    ]]
    a85.EventFolder = eventFolder
end

function v18.InternalSendMessage(a87, a88, a89)
    --[[
      name: InternalSendMessage
      line: 286
    ]]
    local success, result = pcall(
        function()
            --[[
              line: 287
              upvalues:
                a87 (copy, index: 1)
                a88 (copy, index: 2)
                a89 (copy, index: 3)
            ]]
            a87:LazyFire("eReceivedUnfilteredMessage", a88, a89)

            if a87.PlayerObj then
                a87.EventFolder.OnNewMessage:FireClient(a87.PlayerObj, a88, a89)
            end
        end
    )

    if not success and result then
        print("Error sending internal message: " .. result)
    end
end

function v18.InternalSendFilteredMessage(a92, a93, a94)
    --[[
      name: InternalSendFilteredMessage
      line: 298
    ]]
    local success, result = pcall(
        function()
            --[[
              line: 299
              upvalues:
                a92 (copy, index: 1)
                a93 (copy, index: 2)
                a94 (copy, index: 3)
            ]]
            a92:LazyFire("eReceivedMessage", a93, a94)
            a92:LazyFire("eMessageDoneFiltering", a93, a94)

            if a92.PlayerObj then
                a92.EventFolder.OnMessageDoneFiltering:FireClient(a92.PlayerObj, a93, a94)
            end
        end
    )

    if not success and result then
        print("Error sending internal filtered message: " .. result)
    end
end

function v18.InternalSendFilteredMessageWithTranslatedFilterResult(a97, a98, a99, a100)
    --[[
      name: InternalSendFilteredMessageWithTranslatedFilterResult
      line: 314
      upvalues:
        isUserFeatureEnabled2 (ref, index: 1)
    ]]
    local v101 = {}

    for key, v103 in pairs(a98) do
        local v104 = v103
        local key2 = key
        v101[key2] = v104
    end

    local filterResult = v101.FilterResult
    local player = a97:GetPlayer()
    local v108 = if player ~= nil then a100:GetTranslationForLocale(player.LocaleId) else nil
    local v109 = ""
    local translatedMessage = nil

    pcall(
        function()
            --[[
              line: 324
              upvalues:
                v101 (copy, index: 1)
                player (copy, index: 2)
                v109 (ref,  index: 3)
                filterResult (copy, index: 4)
                v108 (copy, index: 5)
                translatedMessage (ref,  index: 6)
            ]]
            if v101.IsFilterResult then
                if player then
                    v109 = filterResult:GetChatForUserAsync(player.UserId)

                    if v108 then
                        translatedMessage = v108:GetChatForUserAsync(player.UserId)
                    end
                else
                    v109 = filterResult:GetNonChatStringForBroadcastAsync()

                    if v108 then
                        translatedMessage = v108:GetNonChatStringForBroadcastAsync()
                    end
                end
            else
                v109 = filterResult
            end
        end
    )

    if isUserFeatureEnabled2 then
        v101.Message = v109

        if translatedMessage then
            v101.TranslatedMessage = translatedMessage
        end

        v101.FilterResult = nil
        a97:InternalSendFilteredMessage(v101, a99)
    elseif 0 < #v109 then
        v101.Message = v109

        if translatedMessage then
            v101.TranslatedMessage = translatedMessage
        end

        v101.FilterResult = nil
        a97:InternalSendFilteredMessage(v101, a99)
    end
end

function v18.InternalSendFilteredMessageWithFilterResult(a111, a112, a113)
    --[[
      name: InternalSendFilteredMessageWithFilterResult
      line: 360
      upvalues:
        isUserFeatureEnabled2 (ref, index: 1)
    ]]
    local v114 = {}

    for key, v116 in pairs(a112) do
        v114[key] = v116
    end

    local filterResult = v114.FilterResult
    local player = a111:GetPlayer()
    local v119 = ""

    pcall(
        function()
            --[[
              line: 367
              upvalues:
                v114 (copy, index: 1)
                player (copy, index: 2)
                v119 (ref,  index: 3)
                filterResult (copy, index: 4)
            ]]
            if not v114.IsFilterResult then
                v119 = filterResult
                return
            end

            if player then
                v119 = filterResult:GetChatForUserAsync(player.UserId)
                return
            end

            v119 = filterResult:GetNonChatStringForBroadcastAsync()
        end
    )

    if isUserFeatureEnabled2 then
        v114.Message = v119
        v114.FilterResult = nil
        a111:InternalSendFilteredMessage(v114, a113)
    elseif 0 < #v119 then
        v114.Message = v119
        v114.FilterResult = nil
        a111:InternalSendFilteredMessage(v114, a113)
    end
end

function v18.InternalSendSystemMessage(a120, a121, a122)
    --[[
      name: InternalSendSystemMessage
      line: 396
    ]]
    local success, result = pcall(
        function()
            --[[
              line: 397
              upvalues:
                a120 (copy, index: 1)
                a121 (copy, index: 2)
                a122 (copy, index: 3)
            ]]
            a120:LazyFire("eReceivedSystemMessage", a121, a122)

            if a120.PlayerObj then
                a120.EventFolder.OnNewSystemMessage:FireClient(a120.PlayerObj, a121, a122)
            end
        end
    )

    if not success and result then
        print("Error sending internal system message: " .. result)
    end
end

function v18.UpdateChannelNameColor(a125, a126, a127)
    --[[
      name: UpdateChannelNameColor
      line: 408
    ]]
    a125:LazyFire("eChannelNameColorUpdated", a126, a127)

    if a125.PlayerObj then
        a125.EventFolder.ChannelNameColorUpdated:FireClient(a125.PlayerObj, a126, a127)
    end
end

function v1.new(chatService, name)
    --[[
      name: new
      line: 418
      upvalues:
        v18 (copy, index: 1)
    ]]
    local v130 = setmetatable({}, v18)
    v130.ChatService = chatService
    v130.PlayerObj = nil
    v130.Name = name
    v130.ExtraData = {}
    v130.Channels = {}
    v130.MutedSpeakers = {}
    v130.EventFolder = nil
    return v130
end

return v1