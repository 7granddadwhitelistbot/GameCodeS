local success_1, v1 = pcall(
    function()
        --[[
          line: 7
        ]]
        return UserSettings():IsUserFeatureEnabled("UserFlagRemoveMessageFromMessageLog")
    end
)
local u1 = success_1 and v1
local success_2, v2 = pcall(
    function()
        --[[
          line: 15
        ]]
        return UserSettings():IsUserFeatureEnabled("UserIsChatTranslationEnabled2")
    end
)
local u2 = success_2 and v2
local tbl_1 = {}
local ClientChatModules_1 = game:GetService("Chat"):WaitForChild("ClientChatModules")
local Parent_1 = script.Parent
local ChatSettings_upv_1 = require(ClientChatModules_1:WaitForChild("ChatSettings"))
local u3 = nil
if u2 then
    local u4 = Parent_1:FindFirstChild("ChatTranslationEnabled")
    if u4 == nil then
        local u5 = nil
        local v3 = Parent_1.ChildAdded:Connect(
            function(a1)
                --[[
                  line: 35
                  upvalues:
                    u4 (ref, index: 1)
                    u5 (ref, index: 2)
                ]]
                if a1.Name ~= "ChatTranslationEnabled" then
                    return
                end
                u4 = a1
                u5:Disconnect()
            end
        )
        u5 = v3
    end
end
local tbl_upv_2 = {}
tbl_upv_2.__index = tbl_upv_2
function tbl_upv_2.Destroy(a1)
    --[[
      name: Destroy
      line: 50
    ]]
    a1.Destroyed = true
end
function tbl_upv_2.SetActive(a1, a2)
    --[[
      name: SetActive
      line: 54
    ]]
    if a2 == a1.Active then
        return
    end
    if a2 ~= false then
        a1.MessageLogDisplay:SetCurrentChannelName(a1.Name)
        for n_1 = 1, #a1.MessageLog do
            a1.MessageLogDisplay:AddMessage(a1.MessageLog[n_1])
        end
    else
        a1.MessageLogDisplay:Clear()
    end
    a1.Active = a2
end
function tbl_upv_2.UpdateMessageFiltered(a1, a2)
    --[[
      name: UpdateMessageFiltered
      line: 69
      upvalues:
        u2 (ref, index: 1)
        u3 (ref, index: 2)
        u1 (ref, index: 3)
    ]]
    local v4 = 1
    local MessageLog_1 = a1.MessageLog
    local v5 = nil
    local v6 = nil
    while v4 <= #MessageLog_1 do
        v6 = MessageLog_1[v4]
        if v6.ID ~= a2.ID then
            v4 = v4 + 1
            continue
        else
            v5 = v6
            break
        end
    end
    if v5 then
        v5.Message = a2.Message
        v5.IsFiltered = true
        if u2 and u3 ~= nil and u3.Value then
            v5.TranslatedMessage = a2.TranslatedMessage
            v5.ShowTranslated = true
        end
        if not a1.Active then
            return
        end
        if u1 and v5.Message == "" then
            table.remove(a1.MessageLog, v4)
        end
        a1.MessageLogDisplay:UpdateMessageFiltered(v5)
    else
        a1:AddMessageToChannelByTimeStamp(a2)
    end
end
function tbl_upv_2.AddMessageToChannel(a1, a2)
    --[[
      name: AddMessageToChannel
      line: 105
      upvalues:
        ChatSettings_upv_1 (copy, index: 1)
    ]]
    table.insert(a1.MessageLog, a2)
    if a1.Active then
        a1.MessageLogDisplay:AddMessage(a2)
    end
    if not (ChatSettings_upv_1.MessageHistoryLengthPerChannel < #a1.MessageLog) then
        return
    end
    a1:RemoveLastMessageFromChannel()
end
function tbl_upv_2.InternalAddMessageAtTimeStamp(a1, a2)
    --[[
      name: InternalAddMessageAtTimeStamp
      line: 115
    ]]
    for n_2 = 1, #a1.MessageLog do
        if not (a2.Time < a1.MessageLog[n_2].Time) then
            continue
        end
        table.insert(a1.MessageLog, n_2, a2)
        return
    end
    table.insert(a1.MessageLog, a2)
end
function tbl_upv_2.AddMessagesToChannelByTimeStamp(a1, a2, a3)
    --[[
      name: AddMessagesToChannelByTimeStamp
      line: 125
      upvalues:
        ChatSettings_upv_1 (copy, index: 1)
    ]]
    for n_3 = a3, #a2 do
        a1:InternalAddMessageAtTimeStamp(a2[n_3])
    end
    while ChatSettings_upv_1.MessageHistoryLengthPerChannel < #a1.MessageLog do
        table.remove(a1.MessageLog, 1)
    end
    if not a1.Active then
        return
    end
    a1.MessageLogDisplay:Clear()
    for n_4 = 1, #a1.MessageLog do
        a1.MessageLogDisplay:AddMessage(a1.MessageLog[n_4])
    end
end
function tbl_upv_2.AddMessageToChannelByTimeStamp(a1, a2)
    --[[
      name: AddMessageToChannelByTimeStamp
      line: 140
      upvalues:
        ChatSettings_upv_1 (copy, index: 1)
    ]]
    if #a1.MessageLog >= 1 then
        if (a2.Time < a1.MessageLog[1].Time) then
            return
        end
        if a1.MessageLog[#a1.MessageLog].Time <= a2.Time then
            a1:AddMessageToChannel(a2)
        else
            for n_5 = 1, #a1.MessageLog do
                if not (a2.Time < a1.MessageLog[n_5].Time) then
                    continue
                end
                table.insert(a1.MessageLog, n_5, a2)
                if ChatSettings_upv_1.MessageHistoryLengthPerChannel < #a1.MessageLog then
                    a1:RemoveLastMessageFromChannel()
                end
                if a1.Active then
                    a1.MessageLogDisplay:AddMessageAtIndex(a2, n_5)
                end
                return
            end
        end
    else
        a1:AddMessageToChannel(a2)
    end
end
function tbl_upv_2.RemoveLastMessageFromChannel(a1)
    --[[
      name: RemoveLastMessageFromChannel
      line: 170
    ]]
    table.remove(a1.MessageLog, 1)
    if not a1.Active then
        return
    end
    a1.MessageLogDisplay:RemoveLastMessage()
end
function tbl_upv_2.ClearMessageLog(a1)
    --[[
      name: ClearMessageLog
      line: 178
    ]]
    a1.MessageLog = {}
    if not a1.Active then
        return
    end
    a1.MessageLogDisplay:Clear()
end
function tbl_upv_2.RegisterChannelTab(a1, a2)
    --[[
      name: RegisterChannelTab
      line: 186
    ]]
    a1.ChannelTab = a2
end
function tbl_1.new(a1, a2)
    --[[
      name: new
      line: 193
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    local v7 = setmetatable({}, tbl_upv_2)
    v7.Destroyed = false
    v7.Active = false
    v7.MessageLog = {}
    v7.MessageLogDisplay = a2
    v7.ChannelTab = nil
    v7.Name = a1
    return v7
end
return tbl_1