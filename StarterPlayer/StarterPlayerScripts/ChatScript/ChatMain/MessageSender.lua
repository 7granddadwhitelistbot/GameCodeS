local v1 = {}
local _ = script.Parent
local Class = {}
Class.__index = Class

function Class.SendMessage(self, a5, a6)
    --[[
      name: SendMessage
      line: 15
    ]]
    self.SayMessageRequest:FireServer(a5, a6)
end

function Class.RegisterSayMessageFunction(self, sayMessageRequest)
    --[[
      name: RegisterSayMessageFunction
      line: 19
    ]]
    self.SayMessageRequest = sayMessageRequest
end

function v1.new()
    --[[
      name: new
      line: 26
      upvalues:
        Class (copy, index: 1)
    ]]
    local v9 = setmetatable({}, Class)
    v9.SayMessageRequest = nil
    return v9
end

return v1.new()