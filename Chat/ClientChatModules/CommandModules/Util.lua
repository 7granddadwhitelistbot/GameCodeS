local parent = script.Parent.Parent
local ChatConstants = require(parent:WaitForChild("ChatConstants"))
local v3 = {}
local Class = {}
Class.__index = Class

function Class.SendSystemMessageToSelf(a5, message: string, a7, extraData)
    --[[
      name: SendSystemMessageToSelf
      line: 31
      upvalues:
        ChatConstants (copy, index: 1)
    ]]
    a7:AddMessageToChannel({ID = -1, FromSpeaker = nil, SpeakerUserId = 0, IsFiltered = true, OriginalChannel = a7.Name, MessageLength = string.len(message), MessageLengthUtf8 = utf8.len(utf8.nfcnormalize(message)), Message = message, MessageType = ChatConstants.MessageTypeSystem, Time = os.time(), ExtraData = extraData})
end

function v3.new()
    --[[
      name: new
      line: 50
      upvalues:
        Class (copy, index: 1)
    ]]
    local v9 = setmetatable({}, Class)
    v9.COMMAND_MODULES_VERSION = 1
    v9.KEY_COMMAND_PROCESSOR_TYPE = "ProcessorType"
    v9.KEY_PROCESSOR_FUNCTION = "ProcessorFunction"
    v9.IN_PROGRESS_MESSAGE_PROCESSOR = 0
    v9.COMPLETED_MESSAGE_PROCESSOR = 1
    return v9
end

return v3.new()