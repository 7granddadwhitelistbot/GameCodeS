local _ = require(script.Parent.Parent:WaitForChild("ChatSettings"))
local Util_1 = require(script.Parent:WaitForChild("Util"))
function CreateUnknownMessageLabel(a1)
    --[[
      name: CreateUnknownMessageLabel
      line: 13
    ]]
    print("No message creator for message: " .. a1.Message)
end
local tbl_1 = {}
tbl_1[Util_1.KEY_MESSAGE_TYPE] = "UnknownMessage"
tbl_1[Util_1.KEY_CREATOR_FUNCTION] = CreateUnknownMessageLabel
return tbl_1