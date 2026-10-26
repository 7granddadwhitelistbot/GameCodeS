local tbl_1 = {}
local tbl_upv_2 = {}
tbl_upv_2.__index = tbl_upv_2
function tbl_upv_2.SendMessage(a1, a2, a3)
    --[[
      name: SendMessage
      line: 15
    ]]
    a1.SayMessageRequest:FireServer(a2, a3)
end
function tbl_upv_2.RegisterSayMessageFunction(a1, a2)
    --[[
      name: RegisterSayMessageFunction
      line: 19
    ]]
    a1.SayMessageRequest = a2
end
function tbl_1.new()
    --[[
      name: new
      line: 26
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    local v1 = setmetatable({}, tbl_upv_2)
    v1.SayMessageRequest = nil
    return v1
end
return tbl_1.new()