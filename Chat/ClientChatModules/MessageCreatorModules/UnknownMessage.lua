local parent = script.Parent.Parent
require(parent:WaitForChild("ChatSettings"))
local Util = require(script.Parent:WaitForChild("Util"))

function CreateUnknownMessageLabel(a3)
    --[[
      name: CreateUnknownMessageLabel
      line: 13
    ]]
    print("No message creator for message: " .. a3.Message)
end

local v4 = {}
v4[Util.KEY_MESSAGE_TYPE] = "UnknownMessage"
v4[Util.KEY_CREATOR_FUNCTION] = CreateUnknownMessageLabel

return v4