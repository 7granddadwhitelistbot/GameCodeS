local Util_upv_1 = require(script.Parent:WaitForChild("Util"))
local ChatConstants_upv_1 = require(script.Parent.Parent:WaitForChild("ChatConstants"))
local tbl_1 = {}
tbl_1[Util_upv_1.KEY_COMMAND_PROCESSOR_TYPE] = Util_upv_1.COMPLETED_MESSAGE_PROCESSOR
tbl_1[Util_upv_1.KEY_PROCESSOR_FUNCTION] = function(a1, a2, a3)
    --[[
      name: ProcessMessage
      line: 9
      upvalues:
        Util_upv_1 (copy, index: 1)
        ChatConstants_upv_1 (copy, index: 2)
    ]]
    if string.sub(a1, 1, 8):lower() ~= "/version" and string.sub(a1, 1, 9):lower() ~= "/version " then
        return false
    end
    local tbl_2 = {}
    Util_upv_1:SendSystemMessageToSelf(string.format("This experience is running chat version [%d.%d.%s].", ChatConstants_upv_1.MajorVersion, ChatConstants_upv_1.MinorVersion, ChatConstants_upv_1.BuildVersion), a2:GetCurrentChannel(), tbl_2)
    return true
end
return tbl_1