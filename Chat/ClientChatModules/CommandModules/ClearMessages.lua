local Util = require(script.Parent:WaitForChild("Util"))

function ProcessMessage(text: string, a3, a4)
    --[[
      name: ProcessMessage
      line: 8
    ]]
    if string.sub(text, 1, 4):lower() ~= "/cls" and string.sub(text, 1, 6):lower() ~= "/clear" then
        return false
    elseif const currentChannel = a3:GetCurrentChannel() then
        currentChannel:ClearMessageLog()
    end

    return true
end

local v6 = {}
v6[Util.KEY_COMMAND_PROCESSOR_TYPE] = Util.COMPLETED_MESSAGE_PROCESSOR
v6[Util.KEY_PROCESSOR_FUNCTION] = ProcessMessage

return v6