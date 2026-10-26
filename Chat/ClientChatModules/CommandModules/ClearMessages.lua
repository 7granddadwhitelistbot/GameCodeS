local Util_1 = require(script.Parent:WaitForChild("Util"))
function ProcessMessage(a1, a2, a3)
    --[[
      name: ProcessMessage
      line: 8
    ]]
    if string.sub(a1, 1, 4):lower() ~= "/cls" and string.sub(a1, 1, 6):lower() ~= "/clear" then
        return false
    end
    local v1 = a2:GetCurrentChannel()
    if v1 then
        v1:ClearMessageLog()
    end
    return true
end
local tbl_1 = {}
tbl_1[Util_1.KEY_COMMAND_PROCESSOR_TYPE] = Util_1.COMPLETED_MESSAGE_PROCESSOR
tbl_1[Util_1.KEY_PROCESSOR_FUNCTION] = ProcessMessage
return tbl_1