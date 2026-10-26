local tbl_upv_1 = {0.05, 0.1, 0.2}
local tbl_2 = {}
local RunService_upv_1 = game:GetService("RunService")
local Chat_upv_1 = game:GetService("Chat")
local _ = Chat_upv_1:WaitForChild("ClientChatModules")
local Parent_1 = script.Parent
local ClientChatModules_1 = Chat_upv_1:WaitForChild("ClientChatModules")
local v1 = require(ClientChatModules_1:WaitForChild("ChatSettings")).ErrorMessageTextColor or (Color3.fromRGB(245, 50, 50))
local tbl_upv_3 = {}
tbl_upv_3.ChatColor = v1
local ChatConstants_upv_1 = require(ClientChatModules_1:WaitForChild("ChatConstants"))
local ChatChannel_upv_1 = require(Parent_1:WaitForChild("ChatChannel"))
local Speaker_upv_1 = require(Parent_1:WaitForChild("Speaker"))
local Util_upv_1 = require(Parent_1:WaitForChild("Util"))
local u1 = nil
pcall(
    function()
        --[[
          line: 38
          upvalues:
            u1 (ref, index: 1)
        ]]
        u1 = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
    end
)
local v2 = u1 or {}
u1 = v2
if not (u1.FormatMessageToSend) or not (u1.LocalizeFormattedMessage) then
    function u1.FormatMessageToSend(a1, a2, a3)
        --[[
          name: FormatMessageToSend
          line: 42
        ]]
        return a3
    end
end
local function allSpaces(a1)
    --[[
      name: allSpaces
      line: 45
    ]]
    local v3 = string.len(string.gsub(a1, " ", "")) == 0
    return v3
end
local tbl_upv_4 = {}
tbl_upv_4.__index = tbl_upv_4
function tbl_upv_4.AddChannel(a1, a2, a3)
    --[[
      name: AddChannel
      line: 55
      upvalues:
        u1 (ref,  index: 1)
        ChatChannel_upv_1 (copy, index: 2)
        ChatConstants_upv_1 (copy, index: 3)
    ]]
    if a1.ChatChannels[a2:lower()] then
        error(string.format("Channel %q alrady exists.", a2))
    end
    local function DefaultChannelCommands(a4, a5)
        --[[
          name: DefaultChannelCommands
          line: 60
          upvalues:
            a1 (copy, index: 1)
            a2 (copy, index: 2)
            u1 (ref,  index: 3)
        ]]
        if a5:lower() ~= "/leave" then
            return false
        end
        local v4 = a1:GetChannel(a2)
        local v5 = a1:GetSpeaker(a4)
        if v4 and v5 then
            if v4.Leavable then
                v5:LeaveChannel(a2)
                v5:SendSystemMessage(u1:FormatMessageToSend("GameChat_ChatService_YouHaveLeftChannel", string.format("You have left channel '%s'", a2), "RBX_NAME", a2), "System")
            else
                v5:SendSystemMessage(u1:FormatMessageToSend("GameChat_ChatService_CannotLeaveChannel", "You cannot leave this channel."), a2)
            end
        end
        return true
    end
    local v6 = ChatChannel_upv_1.new(a1, a2)
    a1.ChatChannels[a2:lower()] = v6
    v6:RegisterProcessCommandsFunction("default_commands", DefaultChannelCommands, ChatConstants_upv_1.HighPriority)
    local success_1, v7 = pcall(
        function()
            --[[
              line: 89
              upvalues:
                a1 (copy, index: 1)
                a2 (copy, index: 2)
            ]]
            a1.eChannelAdded:Fire(a2)
        end
    )
    if not (success_1) and v7 then
        print("Error addding channel: " .. v7)
    end
    if a3 ~= nil then
        v6.AutoJoin = a3
        if a3 then
            for _, value_1 in pairs(a1.Speakers) do
                value_1:JoinChannel(a2)
            end
        end
    end
    return v6
end
function tbl_upv_4.RemoveChannel(a1, a2)
    --[[
      name: RemoveChannel
      line: 106
    ]]
    local v8 = nil
    if a1.ChatChannels[a2:lower()] then
        local Name_upv_1 = a1.ChatChannels[a2:lower()].Name
        a1.ChatChannels[a2:lower()]:InternalDestroy()
        a1.ChatChannels[a2:lower()] = nil
        local success_2, v8 = pcall(
            function()
                --[[
                  line: 113
                  upvalues:
                    a1 (copy, index: 1)
                    Name_upv_1 (copy, index: 2)
                ]]
                a1.eChannelRemoved:Fire(Name_upv_1)
            end
        )
        if (success_2) or not v8 then
            return
        end
        print("Error removing channel: " .. v8)
    else
        warn(string.format("Channel %q does not exist.", a2))
    end
end
function tbl_upv_4.GetChannel(a1, a2)
    --[[
      name: GetChannel
      line: 122
    ]]
    return a1.ChatChannels[a2:lower()]
end
function tbl_upv_4.AddSpeaker(a1, a2)
    --[[
      name: AddSpeaker
      line: 127
      upvalues:
        Speaker_upv_1 (copy, index: 1)
    ]]
    if a1.Speakers[a2:lower()] then
        error("Speaker \"" .. a2 .. "\" already exists!")
    end
    local v9 = Speaker_upv_1.new(a1, a2)
    a1.Speakers[a2:lower()] = v9
    local success_3, v10 = pcall(
        function()
            --[[
              line: 135
              upvalues:
                a1 (copy, index: 1)
                a2 (copy, index: 2)
            ]]
            a1.eSpeakerAdded:Fire(a2)
        end
    )
    if not (success_3) and v10 then
        print("Error adding speaker: " .. v10)
    end
    return v9
end
function tbl_upv_4.InternalUnmuteSpeaker(a1, a2)
    --[[
      name: InternalUnmuteSpeaker
      line: 143
    ]]
    for _, value_2 in pairs(a1.ChatChannels) do
        if value_2:IsSpeakerMuted(a2) then
            value_2:UnmuteSpeaker(a2)
        end
    end
end
function tbl_upv_4.RemoveSpeaker(a1, a2)
    --[[
      name: RemoveSpeaker
      line: 151
    ]]
    local v11 = nil
    if a1.Speakers[a2:lower()] then
        local Name_upv_2 = a1.Speakers[a2:lower()].Name
        a1:InternalUnmuteSpeaker(Name_upv_2)
        a1.Speakers[a2:lower()]:InternalDestroy()
        a1.Speakers[a2:lower()] = nil
        local success_4, v11 = pcall(
            function()
                --[[
                  line: 160
                  upvalues:
                    a1 (copy, index: 1)
                    Name_upv_2 (copy, index: 2)
                ]]
                a1.eSpeakerRemoved:Fire(Name_upv_2)
            end
        )
        if (success_4) or not v11 then
            return
        end
        print("Error removing speaker: " .. v11)
    else
        warn("Speaker \"" .. a2 .. "\" does not exist!")
    end
end
function tbl_upv_4.GetSpeaker(a1, a2)
    --[[
      name: GetSpeaker
      line: 170
    ]]
    return a1.Speakers[a2:lower()]
end
function tbl_upv_4.GetSpeakerByUserOrDisplayName(a1, a2)
    --[[
      name: GetSpeakerByUserOrDisplayName
      line: 174
    ]]
    local v12 = a1.Speakers[a2:lower()]
    if v12 then
        return v12
    end
    for _, value_3 in pairs(a1.Speakers) do
        local v13 = value_3:GetPlayer()
        if not (v13) or v13.DisplayName:lower() ~= a2:lower() then
            continue
        end
        return value_3
    end
end
function tbl_upv_4.GetChannelList(a1)
    --[[
      name: GetChannelList
      line: 190
    ]]
    local tbl_5 = {}
    for _, value_4 in pairs(a1.ChatChannels) do
        if not (value_4.Private) then
            table.insert(tbl_5, value_4.Name)
        end
    end
    return tbl_5
end
function tbl_upv_4.GetAutoJoinChannelList(a1)
    --[[
      name: GetAutoJoinChannelList
      line: 200
    ]]
    local tbl_6 = {}
    for _, value_5 in pairs(a1.ChatChannels) do
        if value_5.AutoJoin then
            table.insert(tbl_6, value_5)
        end
    end
    return tbl_6
end
function tbl_upv_4.GetSpeakerList(a1)
    --[[
      name: GetSpeakerList
      line: 210
    ]]
    local tbl_7 = {}
    for _, value_6 in pairs(a1.Speakers) do
        table.insert(tbl_7, value_6.Name)
    end
    return tbl_7
end
function tbl_upv_4.SendGlobalSystemMessage(a1, a2)
    --[[
      name: SendGlobalSystemMessage
      line: 218
    ]]
    for _, value_7 in pairs(a1.Speakers) do
        value_7:SendSystemMessage(a2, nil)
    end
end
function tbl_upv_4.RegisterFilterMessageFunction(a1, a2, a3, a4)
    --[[
      name: RegisterFilterMessageFunction
      line: 224
    ]]
    if a1.FilterMessageFunctions:HasFunction(a2) then
        error(string.format("FilterMessageFunction '%s' already exists", a2))
    end
    a1.FilterMessageFunctions:AddFunction(a2, a3, a4)
end
function tbl_upv_4.FilterMessageFunctionExists(a1, a2)
    --[[
      name: FilterMessageFunctionExists
      line: 231
    ]]
    return a1.FilterMessageFunctions:HasFunction(a2)
end
function tbl_upv_4.UnregisterFilterMessageFunction(a1, a2)
    --[[
      name: UnregisterFilterMessageFunction
      line: 235
    ]]
    if not (a1.FilterMessageFunctions:HasFunction(a2)) then
        error(string.format("FilterMessageFunction '%s' does not exists", a2))
    end
    a1.FilterMessageFunctions:RemoveFunction(a2)
end
function tbl_upv_4.RegisterProcessCommandsFunction(a1, a2, a3, a4)
    --[[
      name: RegisterProcessCommandsFunction
      line: 242
    ]]
    if a1.ProcessCommandsFunctions:HasFunction(a2) then
        error(string.format("ProcessCommandsFunction '%s' already exists", a2))
    end
    a1.ProcessCommandsFunctions:AddFunction(a2, a3, a4)
end
function tbl_upv_4.ProcessCommandsFunctionExists(a1, a2)
    --[[
      name: ProcessCommandsFunctionExists
      line: 249
    ]]
    return a1.ProcessCommandsFunctions:HasFunction(a2)
end
function tbl_upv_4.UnregisterProcessCommandsFunction(a1, a2)
    --[[
      name: UnregisterProcessCommandsFunction
      line: 253
    ]]
    if not (a1.ProcessCommandsFunctions:HasFunction(a2)) then
        error(string.format("ProcessCommandsFunction '%s' does not exist", a2))
    end
    a1.ProcessCommandsFunctions:RemoveFunction(a2)
end
local u2 = 0
local u3 = 0
local u4 = 0
function tbl_upv_4.InternalNotifyFilterIssue(a1)
    --[[
      name: InternalNotifyFilterIssue
      line: 263
      upvalues:
        u3 (ref,  index: 1)
        u4 (ref,  index: 2)
        u2 (ref,  index: 3)
        u1 (ref,  index: 4)
        tbl_upv_3 (copy, index: 5)
    ]]
    if tick() - u3 > 60 then
        u4 = 0
    end
    u4 = u4 + 1
    u3 = tick()
    if not (u4 >= 3) then
        return
    end
    if tick() - u2 > 60 then
        u2 = tick()
        local v14 = a1:GetChannel("System")
        if not v14 then
            return
        end
        v14:SendSystemMessage(u1:FormatMessageToSend("GameChat_ChatService_ChatFilterIssues", "The chat filter is currently experiencing issues and messages may be slow to appear."), tbl_upv_3)
    end
end
local tbl_upv_8 = {}
function tbl_upv_4.InternalApplyRobloxFilter(a1, a2, a3, a4)
    --[[
      name: InternalApplyRobloxFilter
      line: 292
      upvalues:
        RunService_upv_1 (copy, index: 1)
        Chat_upv_1 (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
        tbl_upv_8 (copy, index: 4)
    ]]
    if RunService_upv_1:IsServer() then
        if RunService_upv_1:IsStudio() then
            if not (tbl_upv_8[a3]) then
                tbl_upv_8[a3] = true
                wait()
            end
            return a3
        else
            local v15 = a1:GetSpeaker(a2)
            local v16 = a4 and (a1:GetSpeaker(a4))
            if v15 == nil then
                return nil
            end
            local u5 = v15:GetPlayer()
            local u6 = v16 and (v16:GetPlayer())
            if u5 == nil then
                return a3
            end
            local v17 = string.len(string.gsub(a3, " ", "")) == 0
            if v17 then
                return a3
            end
            local time_1 = tick()
            local v18 = 0
            local v19 = nil
            while true do
                local success_5, v19 = pcall(
                    function()
                        --[[
                          line: 315
                          upvalues:
                            u6 (copy, index: 1)
                            Chat_upv_1 (copy, index: 2)
                            a3 (copy, index: 3)
                            u5 (copy, index: 4)
                        ]]
                        if u6 then
                            return Chat_upv_1:FilterStringAsync(a3, u5, u6)
                        end
                        return Chat_upv_1:FilterStringForBroadcast(a3, u5)
                    end
                )
                if success_5 then
                    break
                end
                warn("Error filtering message:", v19)
                v18 = v18 + 1
                if v18 > 3 or tick() - time_1 > 60 then
                    a1:InternalNotifyFilterIssue()
                    return nil
                end
                local v20 = tbl_upv_1[math.min(#tbl_upv_1, v18)]
                wait(v20 + (((math.random() * 2) - 1) * v20))
            end
            return v19
        end
    else
        if not (tbl_upv_8[a3]) then
            tbl_upv_8[a3] = true
            wait()
        end
        return a3
    end
end
function tbl_upv_4.InternalApplyRobloxFilterAndTranslate(a1, a2, a3, a4, a5)
    --[[
      name: InternalApplyRobloxFilterAndTranslate
      line: 351
      upvalues:
        RunService_upv_1 (copy, index: 1)
    ]]
    local v21 = RunService_upv_1:IsServer() and (not RunService_upv_1:IsStudio())
    if v21 then
        local v22 = a1:GetSpeaker(a2)
        if v22 == nil then
            return false, nil, nil
        end
        local u7 = v22:GetPlayer()
        if u7 == nil then
            return true, false, a4
        end
        local v23 = string.len(string.gsub(a4, " ", "")) == 0
        if v23 then
            return true, false, a4
        end
        local success_6, v24 = pcall(
            function()
                --[[
                  line: 369
                  upvalues:
                    a4 (copy, index: 1)
                    u7 (copy, index: 2)
                    a3 (copy, index: 3)
                    a5 (copy, index: 4)
                ]]
                return (game:GetService("TextService"):FilterAndTranslateStringAsync(a4, u7.UserId, a3, a5))
            end
        )
        if success_6 then
            return true, true, v24
        end
        warn("Error filtering and translating message", a4, v24)
        a1:InternalNotifyFilterIssue()
        return false, nil, nil
    end
    wait()
    return true, false, a4
end
function tbl_upv_4.InternalApplyRobloxFilterNewAPI(a1, a2, a3, a4)
    --[[
      name: InternalApplyRobloxFilterNewAPI
      line: 388
      upvalues:
        RunService_upv_1 (copy, index: 1)
    ]]
    local v25 = RunService_upv_1:IsServer() and (not RunService_upv_1:IsStudio())
    if v25 then
        local v26 = a1:GetSpeaker(a2)
        if v26 == nil then
            return false, nil, nil
        end
        local u8 = v26:GetPlayer()
        if u8 == nil then
            return true, false, a3
        end
        local v27 = string.len(string.gsub(a3, " ", "")) == 0
        if v27 then
            return true, false, a3
        end
        local success_7, v28 = pcall(
            function()
                --[[
                  line: 407
                  upvalues:
                    a3 (copy, index: 1)
                    u8 (copy, index: 2)
                    a4 (copy, index: 3)
                ]]
                return (game:GetService("TextService"):FilterStringAsync(a3, u8.UserId, a4))
            end
        )
        if success_7 then
            return true, true, v28
        end
        warn("Error filtering message:", a3, v28)
        a1:InternalNotifyFilterIssue()
        return false, nil, nil
    end
    wait()
    return true, false, a3
end
function tbl_upv_4.InternalDoMessageFilter(a1, a2, a3, a4)
    --[[
      name: InternalDoMessageFilter
      line: 426
    ]]
    for key_1, value_upv_8, _ in a1.FilterMessageFunctions:GetIterator() do
        local success_8, v29 = pcall(
            function()
                --[[
                  line: 430
                  upvalues:
                    value_upv_8 (copy, index: 1)
                    a2 (copy, index: 2)
                    a3 (copy, index: 3)
                    a4 (copy, index: 4)
                ]]
                value_upv_8(a2, a3, a4)
            end
        )
        if not (success_8) then
            warn(string.format("DoMessageFilter Function '%s' failed for reason: %s", key_1, v29))
        end
    end
end
function tbl_upv_4.InternalDoProcessCommands(a1, a2, a3, a4)
    --[[
      name: InternalDoProcessCommands
      line: 440
    ]]
    for key_2, value_upv_9, _ in a1.ProcessCommandsFunctions:GetIterator() do
        local success_9, v30 = pcall(
            function()
                --[[
                  line: 444
                  upvalues:
                    value_upv_9 (copy, index: 1)
                    a2 (copy, index: 2)
                    a3 (copy, index: 3)
                    a4 (copy, index: 4)
                ]]
                local v31 = value_upv_9(a2, a3, a4)
                if type(v31) ~= "boolean" then
                    error("Process command functions must return a bool")
                end
                return v31
            end
        )
        if not (success_9) then
            warn(string.format("DoProcessCommands Function '%s' failed for reason: %s", key_2, v30))
            continue
        elseif not (v30) then
            continue
        else
            return true
        end
    end
    return false
end
function tbl_upv_4.InternalGetUniqueMessageId(a1)
    --[[
      name: InternalGetUniqueMessageId
      line: 462
    ]]
    local MessageIdCounter_1 = a1.MessageIdCounter
    a1.MessageIdCounter = MessageIdCounter_1 + 1
    return MessageIdCounter_1
end
function tbl_upv_4.InternalAddSpeakerWithPlayerObject(a1, a2, a3, a4)
    --[[
      name: InternalAddSpeakerWithPlayerObject
      line: 468
      upvalues:
        Speaker_upv_1 (copy, index: 1)
    ]]
    if a1.Speakers[a2:lower()] then
        error("Speaker \"" .. a2 .. "\" already exists!")
    end
    local v32 = Speaker_upv_1.new(a1, a2)
    v32:InternalAssignPlayerObject(a3)
    a1.Speakers[a2:lower()] = v32
    if a4 then
        local success_10, v33 = pcall(
            function()
                --[[
                  line: 478
                  upvalues:
                    a1 (copy, index: 1)
                    a2 (copy, index: 2)
                ]]
                a1.eSpeakerAdded:Fire(a2)
            end
        )
        if not (success_10) and v33 then
            print("Error adding speaker: " .. v33)
        end
    end
    return v32
end
function tbl_upv_4.InternalFireSpeakerAdded(a1, a2)
    --[[
      name: InternalFireSpeakerAdded
      line: 487
    ]]
    local success_11, v34 = pcall(
        function()
            --[[
              line: 488
              upvalues:
                a1 (copy, index: 1)
                a2 (copy, index: 2)
            ]]
            a1.eSpeakerAdded:Fire(a2)
        end
    )
    if (success_11) or not v34 then
        return
    end
    print("Error firing speaker added: " .. v34)
end
function tbl_2.new()
    --[[
      name: new
      line: 497
      upvalues:
        tbl_upv_4 (copy, index: 1)
        Util_upv_1 (copy, index: 2)
    ]]
    local v35 = setmetatable({}, tbl_upv_4)
    v35.MessageIdCounter = 0
    v35.ChatChannels = {}
    v35.Speakers = {}
    v35.FilterMessageFunctions = Util_upv_1:NewSortedFunctionContainer()
    v35.ProcessCommandsFunctions = Util_upv_1:NewSortedFunctionContainer()
    v35.eChannelAdded = Instance.new("BindableEvent")
    v35.eChannelRemoved = Instance.new("BindableEvent")
    v35.eSpeakerAdded = Instance.new("BindableEvent")
    v35.eSpeakerRemoved = Instance.new("BindableEvent")
    v35.ChannelAdded = v35.eChannelAdded.Event
    v35.ChannelRemoved = v35.eChannelRemoved.Event
    v35.SpeakerAdded = v35.eSpeakerAdded.Event
    v35.SpeakerRemoved = v35.eSpeakerRemoved.Event
    v35.ChatServiceMajorVersion = 0
    v35.ChatServiceMinorVersion = 5
    return v35
end
return tbl_2.new()