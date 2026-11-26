local v1 = {}
local chat = game:GetService("Chat")
local clientChatModules = chat:WaitForChild("ClientChatModules")
local messageCreatorModules = clientChatModules:WaitForChild("MessageCreatorModules")
local childName = "Util"
local child = require(messageCreatorModules:WaitForChild(childName))
local parent = script.Parent
require(clientChatModules:WaitForChild("ChatSettings"))
local ObjectPool = require(parent:WaitForChild("ObjectPool"))
require(parent:WaitForChild("MessageSender"))
local Class = {}
Class.__index = Class

function mergeProps(a10, a11)
    --[[
      name: mergeProps
      line: 26
    ]]
    if not a10 then
        return
    end

    for key, v13 in pairs(a10) do
        a11[key] = v13
    end
end

function ReturnToObjectPoolRecursive(a14, a15)
    --[[
      name: ReturnToObjectPoolRecursive
      line: 33
    ]]
    local children = a14:GetChildren()

    for childKey = 1, #children do
        ReturnToObjectPoolRecursive(children[childKey], a15)
    end

    a14.Parent = nil
    a15:ReturnInstance(a14)
end

function GetMessageCreators()
    --[[
      name: GetMessageCreators
      line: 42
      upvalues:
        messageCreatorModules (copy, index: 1)
        child (copy, index: 2)
    ]]
    local v18 = {}
    local children = messageCreatorModules:GetChildren()

    for childKey = 1, #children do
        if children[childKey]:IsA("ModuleScript") and children[childKey].Name ~= "Util" then
            local Module = require(children[childKey])
            v18[Module[child.KEY_MESSAGE_TYPE]] = Module[child.KEY_CREATOR_FUNCTION]
        end
    end

    return v18
end

function Class.WrapIntoMessageObject(self, a23, a24)
    --[[
      name: WrapIntoMessageObject
      line: 56
      upvalues:
        child (copy, index: 1)
    ]]
    local baseFrame = a24[child.KEY_BASE_FRAME]
    local baseMessage = nil

    if child.KEY_BASE_MESSAGE then
        baseMessage = a24[child.KEY_BASE_MESSAGE]
    end

    local v27 = a24[child.KEY_UPDATE_TEXT_FUNC]
    local getHeightFunction = a24[child.KEY_GET_HEIGHT]
    local fadeInFunction = a24[child.KEY_FADE_IN]
    local fadeOutFunction = a24[child.KEY_FADE_OUT]
    local updateAnimFunction = a24[child.KEY_UPDATE_ANIMATION]

    return {
        ID = a23.ID,
        BaseFrame = baseFrame,
        BaseMessage = baseMessage,
        UpdateTextFunction = v27
            or function()
                --[[
                  line: 73
                ]]
                warn("NO MESSAGE RESIZE FUNCTION")
            end,
        GetHeightFunction = getHeightFunction,
        FadeInFunction = fadeInFunction,
        FadeOutFunction = fadeOutFunction,
        UpdateAnimFunction = updateAnimFunction,
        ObjectPool = self.ObjectPool,
        Destroyed = false,
        Destroy = (function(a32)
            --[[
              name: Destroy
              line: 81
            ]]
            ReturnToObjectPoolRecursive(a32.BaseFrame, a32.ObjectPool)
            a32.Destroyed = true
        end)
    }
end

function Class.CreateMessageLabel_Chat(self, a34, channel, a36)
    --[[
      name: CreateMessageLabel_Chat
      line: 89
      upvalues:
        chat (copy, index: 1)
    ]]
    a34.Channel = channel
    local v37 = nil
    pcall(
        function()
            --[[
              line: 92
              upvalues:
                v37 (ref,  index: 1)
                chat (copy, index: 2)
                a34 (copy, index: 3)
            ]]
            v37 = chat:InvokeChatCallback(Enum.ChatCallbackType.OnClientFormattingMessage, a34)
        end
    )
    a34.ExtraData = a34.ExtraData or {}
    mergeProps(v37, a34.ExtraData)
    local messageType = a34.MessageType

    if self.MessageCreators[messageType] then
        if const v39 = self.MessageCreators[messageType](a34, channel, a36) then
            return self:WrapIntoMessageObject(a34, v39)
        end
    elseif self.DefaultCreatorType then
        if const v40 = self.MessageCreators[self.DefaultCreatorType](a34, channel, a36) then
            return self:WrapIntoMessageObject(a34, v40)
        end
    else
        error("No message creator available for message type: " .. messageType)
    end
end

function Class.CreateMessageLabel(self, a42, channel)
    --[[
      name: CreateMessageLabel
      line: 114
      upvalues:
        chat (copy, index: 1)
    ]]
    a42.Channel = channel
    local v44 = nil
    pcall(
        function()
            --[[
              line: 118
              upvalues:
                v44 (ref,  index: 1)
                chat (copy, index: 2)
                a42 (copy, index: 3)
            ]]
            v44 = chat:InvokeChatCallback(Enum.ChatCallbackType.OnClientFormattingMessage, a42)
        end
    )
    a42.ExtraData = a42.ExtraData or {}
    mergeProps(v44, a42.ExtraData)
    local messageType = a42.MessageType

    if self.MessageCreators[messageType] then
        if const v46 = self.MessageCreators[messageType](a42, channel) then
            return self:WrapIntoMessageObject(a42, v46)
        end
    elseif self.DefaultCreatorType then
        if const v47 = self.MessageCreators[self.DefaultCreatorType](a42, channel) then
            return self:WrapIntoMessageObject(a42, v47)
        end
    else
        error("No message creator available for message type: " .. messageType)
    end
end

function v1.new()
    --[[
      name: new
      line: 143
      upvalues:
        Class (copy, index: 1)
        ObjectPool (copy, index: 2)
        child (copy, index: 3)
    ]]
    local v48 = setmetatable({}, Class)
    v48.ObjectPool = ObjectPool.new(50)
    v48.MessageCreators = GetMessageCreators()
    v48.DefaultCreatorType = child.DEFAULT_MESSAGE_CREATOR
    child:RegisterObjectPool(v48.ObjectPool)

    return v48
end

function v1.GetStringTextBounds(a49, a50, a51, a52, a53)
    --[[
      name: GetStringTextBounds
      line: 155
      upvalues:
        child (copy, index: 1)
    ]]
    return child:GetStringTextBounds(a50, a51, a52, a53)
end

return v1