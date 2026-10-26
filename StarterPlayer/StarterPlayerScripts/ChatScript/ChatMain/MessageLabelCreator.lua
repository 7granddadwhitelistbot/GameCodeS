local tbl_1 = {}
local Chat_upv_1 = game:GetService("Chat")
local v1 = Chat_upv_1:WaitForChild("ClientChatModules")
local MessageCreatorModules_upv_1 = v1:WaitForChild("MessageCreatorModules")
local Util_upv_1 = require(MessageCreatorModules_upv_1:WaitForChild("Util"))
local Parent_1 = script.Parent
local _ = require(v1:WaitForChild("ChatSettings"))
local ObjectPool_upv_1 = require(Parent_1:WaitForChild("ObjectPool"))
v1 = require(Parent_1:WaitForChild("MessageSender"))
local tbl_upv_2 = {}
tbl_upv_2.__index = tbl_upv_2
function mergeProps(a1, a2)
    --[[
      name: mergeProps
      line: 26
    ]]
    if not a1 then
        return
    end
    for key_1, value_1 in pairs(a1) do
        a2[key_1] = value_1
    end
end
function ReturnToObjectPoolRecursive(a1, a2)
    --[[
      name: ReturnToObjectPoolRecursive
      line: 33
    ]]
    local v2 = a1:GetChildren()
    for n_1 = 1, #v2 do
        ReturnToObjectPoolRecursive(v2[n_1], a2)
    end
    a1.Parent = nil
    a2:ReturnInstance(a1)
end
function GetMessageCreators()
    --[[
      name: GetMessageCreators
      line: 42
      upvalues:
        MessageCreatorModules_upv_1 (copy, index: 1)
        Util_upv_1 (copy, index: 2)
    ]]
    local tbl_3 = {}
    local v3 = MessageCreatorModules_upv_1:GetChildren()
    for n_2 = 1, #v3 do
        local v4 = v3[n_2]:IsA("ModuleScript")
        if (v4) and v3[n_2].Name ~= "Util" then
            local v5 = require(v3[n_2])
            tbl_3[v5[Util_upv_1.KEY_MESSAGE_TYPE]] = v5[Util_upv_1.KEY_CREATOR_FUNCTION]
        end
    end
    return tbl_3
end
function tbl_upv_2.WrapIntoMessageObject(a1, a2, a3)
    --[[
      name: WrapIntoMessageObject
      line: 56
      upvalues:
        Util_upv_1 (copy, index: 1)
    ]]
    local v6 = a3[Util_upv_1.KEY_BASE_FRAME]
    local v7 = (not (Util_upv_1.KEY_BASE_MESSAGE)) or (a3[Util_upv_1.KEY_BASE_MESSAGE])
    local v8 = a3[Util_upv_1.KEY_GET_HEIGHT]
    local v9 = a3[Util_upv_1.KEY_FADE_IN]
    local v10 = a3[Util_upv_1.KEY_FADE_OUT]
    local v11 = a3[Util_upv_1.KEY_UPDATE_ANIMATION]
    local tbl_4 = {}
    tbl_4.ID = a2.ID
    tbl_4.BaseFrame = v6
    tbl_4.BaseMessage = v7
    local v12 = a3[Util_upv_1.KEY_UPDATE_TEXT_FUNC]
        or function()
            --[[
              line: 73
            ]]
            warn("NO MESSAGE RESIZE FUNCTION")
        end
    tbl_4.UpdateTextFunction = v12
    tbl_4.GetHeightFunction = v8
    tbl_4.FadeInFunction = v9
    tbl_4.FadeOutFunction = v10
    tbl_4.UpdateAnimFunction = v11
    tbl_4.ObjectPool = a1.ObjectPool
    tbl_4.Destroyed = false
    function tbl_4.Destroy(a4)
        --[[
          name: Destroy
          line: 81
        ]]
        ReturnToObjectPoolRecursive(a4.BaseFrame, a4.ObjectPool)
        a4.Destroyed = true
    end
    return tbl_4
end
function tbl_upv_2.CreateMessageLabel_Chat(a1, a2, a3, a4)
    --[[
      name: CreateMessageLabel_Chat
      line: 89
      upvalues:
        Chat_upv_1 (copy, index: 1)
    ]]
    a2.Channel = a3
    local u1 = nil
    pcall(
        function()
            --[[
              line: 92
              upvalues:
                u1 (ref,  index: 1)
                Chat_upv_1 (copy, index: 2)
                a2 (copy, index: 3)
            ]]
            u1 = Chat_upv_1:InvokeChatCallback(Enum.ChatCallbackType.OnClientFormattingMessage, a2)
        end
    )
    a2.ExtraData = a2.ExtraData or {}
    mergeProps(u1, a2.ExtraData)
    local MessageType_1 = a2.MessageType
    local v13, v14 = nil, nil
    if a1.MessageCreators[MessageType_1] then
        v13 = a1.MessageCreators[MessageType_1](a2, a3, a4)
        if v13 then
            return a1:WrapIntoMessageObject(a2, v13)
        end
    elseif a1.DefaultCreatorType then
        v14 = a1.MessageCreators[a1.DefaultCreatorType](a2, a3, a4)
        if v14 then
            return a1:WrapIntoMessageObject(a2, v14)
        end
    else
        error("No message creator available for message type: " .. MessageType_1)
    end
end
function tbl_upv_2.CreateMessageLabel(a1, a2, a3)
    --[[
      name: CreateMessageLabel
      line: 114
      upvalues:
        Chat_upv_1 (copy, index: 1)
    ]]
    a2.Channel = a3
    local u2 = nil
    pcall(
        function()
            --[[
              line: 118
              upvalues:
                u2 (ref,  index: 1)
                Chat_upv_1 (copy, index: 2)
                a2 (copy, index: 3)
            ]]
            u2 = Chat_upv_1:InvokeChatCallback(Enum.ChatCallbackType.OnClientFormattingMessage, a2)
        end
    )
    a2.ExtraData = a2.ExtraData or {}
    mergeProps(u2, a2.ExtraData)
    local MessageType_2 = a2.MessageType
    local v15, v16 = nil, nil
    if a1.MessageCreators[MessageType_2] then
        v15 = a1.MessageCreators[MessageType_2](a2, a3)
        if v15 then
            return a1:WrapIntoMessageObject(a2, v15)
        end
    elseif a1.DefaultCreatorType then
        v16 = a1.MessageCreators[a1.DefaultCreatorType](a2, a3)
        if v16 then
            return a1:WrapIntoMessageObject(a2, v16)
        end
    else
        error("No message creator available for message type: " .. MessageType_2)
    end
end
function tbl_1.new()
    --[[
      name: new
      line: 143
      upvalues:
        tbl_upv_2 (copy, index: 1)
        ObjectPool_upv_1 (copy, index: 2)
        Util_upv_1 (copy, index: 3)
    ]]
    local v17 = setmetatable({}, tbl_upv_2)
    v17.ObjectPool = ObjectPool_upv_1.new(50)
    v17.MessageCreators = GetMessageCreators()
    v17.DefaultCreatorType = Util_upv_1.DEFAULT_MESSAGE_CREATOR
    Util_upv_1:RegisterObjectPool(v17.ObjectPool)
    return v17
end
function tbl_1.GetStringTextBounds(a1, a2, a3, a4, a5)
    --[[
      name: GetStringTextBounds
      line: 155
      upvalues:
        Util_upv_1 (copy, index: 1)
    ]]
    return Util_upv_1:GetStringTextBounds(a2, a3, a4, a5)
end
return tbl_1