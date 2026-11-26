local function RegisterChannelTab(self, channelTab)
    --[[
      name: RegisterChannelTab
      line: 186
    ]]
    self.ChannelTab = channelTab
end

local function ClearMessageLog(self)
    --[[
      name: ClearMessageLog
      line: 178
    ]]
    self.MessageLog = {}

    if self.Active then
        self.MessageLogDisplay:Clear()
    end
end

local function RemoveLastMessageFromChannel(self)
    --[[
      name: RemoveLastMessageFromChannel
      line: 170
    ]]
    table.remove(self.MessageLog, 1)

    if self.Active then
        self.MessageLogDisplay:RemoveLastMessage()
    end
end

local function InternalAddMessageAtTimeStamp(self, a10)
    --[[
      name: InternalAddMessageAtTimeStamp
      line: 115
    ]]
    for index = 1, #self.MessageLog do
        if a10.Time < self.MessageLog[index].Time then
            table.insert(self.MessageLog, index, a10)
            return
        end
    end

    table.insert(self.MessageLog, a10)
end

local function SetActive(self, active)
    --[[
      name: SetActive
      line: 54
    ]]
    if active == self.Active then
        return
    end

    if active ~= false then
        self.MessageLogDisplay:SetCurrentChannelName(self.Name)

        for index = 1, #self.MessageLog do
            self.MessageLogDisplay:AddMessage(self.MessageLog[index])
        end
    else
        self.MessageLogDisplay:Clear()
    end

    self.Active = active
end

local function Destroy(self)
    --[[
      name: Destroy
      line: 50
    ]]
    self.Destroyed = true
end

local success, isUserFeatureEnabled = pcall(
    function()
        --[[
          line: 7
        ]]
        return UserSettings():IsUserFeatureEnabled("UserFlagRemoveMessageFromMessageLog")
    end
)
local isUserFeatureEnabled2 = success and isUserFeatureEnabled
local success2, isUserFeatureEnabled3 = pcall(
    function()
        --[[
          line: 15
        ]]
        return UserSettings():IsUserFeatureEnabled("UserIsChatTranslationEnabled2")
    end
)
local isUserFeatureEnabled4 = success2 and isUserFeatureEnabled3
local v24 = {}
local chat = game:GetService("Chat")
local clientChatModules = chat:WaitForChild("ClientChatModules")
local parent = script.Parent
local ChatSettings = require(clientChatModules:WaitForChild("ChatSettings"))
local instance = nil

if isUserFeatureEnabled4 then
    local instance2 = parent:FindFirstChild("ChatTranslationEnabled")

    if instance2 ~= nil then
        instance = instance2
    else
        local childAddedConnection = nil

        childAddedConnection = parent.ChildAdded:Connect(
            function(child: Instance)
                --[[
                  line: 35
                  upvalues:
                    instance2 (ref, index: 1)
                    childAddedConnection (ref, index: 2)
                ]]
                if child.Name == "ChatTranslationEnabled" then
                    instance2 = child
                    childAddedConnection:Disconnect()
                end
            end
        )

        instance = instance2
    end
end

local Class = {}
Class.__index = Class
Class.Destroy = Destroy
Class.SetActive = SetActive

function Class.UpdateMessageFiltered(self, a35)
    --[[
      name: UpdateMessageFiltered
      line: 69
      upvalues:
        isUserFeatureEnabled4 (ref, index: 1)
        instance (ref, index: 2)
        isUserFeatureEnabled2 (ref, index: 3)
    ]]
    local v36
    local readIndex = 1
    local messageLog = self.MessageLog

    while true do
        if not (readIndex <= #messageLog) then
            v36 = nil
            break
        end

        local v39 = messageLog[readIndex]

        if v39.ID == a35.ID then
            v36 = v39
            break
        end

        readIndex += 1
    end

    if v36 then
        v36.Message = a35.Message
        v36.IsFiltered = true

        if isUserFeatureEnabled4 and instance ~= nil and instance.Value then
            v36.TranslatedMessage = a35.TranslatedMessage
            v36.ShowTranslated = true
        end

        if self.Active then
            if isUserFeatureEnabled2 and v36.Message == "" then
                table.remove(self.MessageLog, readIndex)
            end

            self.MessageLogDisplay:UpdateMessageFiltered(v36)
        end
    else
        self:AddMessageToChannelByTimeStamp(a35)
    end
end

function Class.AddMessageToChannel(self, a41)
    --[[
      name: AddMessageToChannel
      line: 105
      upvalues:
        ChatSettings (copy, index: 1)
    ]]
    table.insert(self.MessageLog, a41)

    if self.Active then
        self.MessageLogDisplay:AddMessage(a41)
    end

    local messageLogLength = #self.MessageLog

    if ChatSettings.MessageHistoryLengthPerChannel < messageLogLength then
        self:RemoveLastMessageFromChannel()
    end
end

Class.InternalAddMessageAtTimeStamp = InternalAddMessageAtTimeStamp

function Class.AddMessagesToChannelByTimeStamp(self, a44, startIndex: number)
    --[[
      name: AddMessagesToChannelByTimeStamp
      line: 125
      upvalues:
        ChatSettings (copy, index: 1)
    ]]
    for index = startIndex, #a44 do
        self:InternalAddMessageAtTimeStamp(a44[index])
    end

    while true do
        local messageLogLength = #self.MessageLog

        if not (ChatSettings.MessageHistoryLengthPerChannel < messageLogLength) then
            break
        end

        table.remove(self.MessageLog, 1)
    end

    if self.Active then
        self.MessageLogDisplay:Clear()

        for index = 1, #self.MessageLog do
            self.MessageLogDisplay:AddMessage(self.MessageLog[index])
        end
    end
end

function Class.AddMessageToChannelByTimeStamp(self, a50)
    --[[
      name: AddMessageToChannelByTimeStamp
      line: 140
      upvalues:
        ChatSettings (copy, index: 1)
    ]]
    if not (1 <= #self.MessageLog) then
        self:AddMessageToChannel(a50)
        return
    end

    local time = self.MessageLog[1].Time

    if a50.Time < time then
        return
    end

    local time2 = a50.Time

    if self.MessageLog[#self.MessageLog].Time <= time2 then
        self:AddMessageToChannel(a50)
        return
    end

    for index = 1, #self.MessageLog do
        if a50.Time < self.MessageLog[index].Time then
            table.insert(self.MessageLog, index, a50)
            local messageLogLength = #self.MessageLog

            if ChatSettings.MessageHistoryLengthPerChannel < messageLogLength then
                self:RemoveLastMessageFromChannel()
            end

            if self.Active then
                self.MessageLogDisplay:AddMessageAtIndex(a50, index)
            end

            return
        end
    end
end

Class.RemoveLastMessageFromChannel = RemoveLastMessageFromChannel
Class.ClearMessageLog = ClearMessageLog
Class.RegisterChannelTab = RegisterChannelTab

function v24.new(name, messageLogDisplay)
    --[[
      name: new
      line: 193
      upvalues:
        Class (copy, index: 1)
    ]]
    local v57 = setmetatable({}, Class)
    v57.Destroyed = false
    v57.Active = false
    v57.MessageLog = {}
    v57.MessageLogDisplay = messageLogDisplay
    v57.ChannelTab = nil
    v57.Name = name
    return v57
end

return v24