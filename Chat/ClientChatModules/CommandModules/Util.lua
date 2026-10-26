local ChatConstants_upv_1 = require(script.Parent.Parent:WaitForChild("ChatConstants"))
local tbl_1 = {}
local tbl_upv_2 = {}
tbl_upv_2.__index = tbl_upv_2
function tbl_upv_2.SendSystemMessageToSelf(a1, a2, a3, a4)
    --[[
      name: SendSystemMessageToSelf
      line: 31
      upvalues:
        ChatConstants_upv_1 (copy, index: 1)
    ]]
    a3:AddMessageToChannel({SpeakerUserId = 0, ID = -1, IsFiltered = true, OriginalChannel = a3.Name, MessageLength = string.len(a2), MessageLengthUtf8 = utf8.len(utf8.nfcnormalize(a2)), Message = a2, MessageType = ChatConstants_upv_1.MessageTypeSystem, Time = os.time(), ExtraData = a4})
end
function tbl_1.new()
    --[[
      name: new
      line: 50
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    local v1 = setmetatable({}, tbl_upv_2)
    v1.COMMAND_MODULES_VERSION = 1
    v1.KEY_COMMAND_PROCESSOR_TYPE = "ProcessorType"
    v1.KEY_PROCESSOR_FUNCTION = "ProcessorFunction"
    v1.IN_PROGRESS_MESSAGE_PROCESSOR = 0
    v1.COMPLETED_MESSAGE_PROCESSOR = 1
    return v1
end
return tbl_1.new()