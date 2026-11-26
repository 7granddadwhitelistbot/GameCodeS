local Util = require(script.Parent:WaitForChild("Util"))
local ChatConstants = require(script.Parent.Parent:WaitForChild("ChatConstants"))
local v3 = {}
v3[Util.KEY_COMMAND_PROCESSOR_TYPE] = Util.COMPLETED_MESSAGE_PROCESSOR

v3[Util.KEY_PROCESSOR_FUNCTION] = function(text: string, a5, a6)
    --[[
      name: ProcessMessage
      line: 9
      upvalues:
        Util (copy, index: 1)
        ChatConstants (copy, index: 2)
    ]]
    if string.sub(text, 1, 8):lower() ~= "/version" and string.sub(text, 1, 9):lower() ~= "/version " then
        return false
    end

    local v7 = {}
    Util:SendSystemMessageToSelf(string.format("This experience is running chat version [%d.%d.%s].", ChatConstants.MajorVersion, ChatConstants.MinorVersion, ChatConstants.BuildVersion), a5:GetCurrentChannel(), v7)

    return true
end

return v3