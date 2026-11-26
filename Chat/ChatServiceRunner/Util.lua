local standardPriority
local chat = game:GetService("Chat")
local clientChatModules = chat:WaitForChild("ClientChatModules")
local standardPriority2 = require(clientChatModules:WaitForChild("ChatConstants")).StandardPriority

if standardPriority2 ~= nil then
    standardPriority = standardPriority2
else
    standardPriority = 10
end

local Class = {}
Class.__index = Class
local v6 = {}
local Class2 = {}
Class2.__index = Class2

function Class2.RebuildProcessCommandsPriorities(self)
    --[[
      name: RebuildProcessCommandsPriorities
      line: 25
    ]]
    self.RegisteredPriorites = {}

    for key, v10 in pairs(self.FunctionMap) do
        local v11 = true

        for _, v13 in pairs(v10) do
            v11 = false
            break
        end

        if not v11 then
            table.insert(self.RegisteredPriorites, key)
        end
    end

    table.sort(
        self.RegisteredPriorites,
        function(left, right)
            --[[
              line: 37
            ]]
            return right < left
        end
    )
end

function Class2.HasFunction(self, registeredFunctionKey)
    --[[
      name: HasFunction
      line: 42
    ]]
    if self.RegisteredFunctions[registeredFunctionKey] == nil then
        return false
    end

    return true
end

function Class2.RemoveFunction(self, registeredFunctionKey)
    --[[
      name: RemoveFunction
      line: 49
    ]]
    local registeredFunction = self.RegisteredFunctions[registeredFunctionKey]
    self.RegisteredFunctions[registeredFunctionKey] = nil
    self.FunctionMap[registeredFunction][registeredFunctionKey] = nil
    self:RebuildProcessCommandsPriorities()
end

function Class2.AddFunction(self, registeredFunctionKey, value, a24)
    --[[
      name: AddFunction
      line: 56
      upvalues:
        standardPriority (ref, index: 1)
    ]]
    if a24 == nil then
        a24 = standardPriority
    end

    if self.RegisteredFunctions[registeredFunctionKey] then
        error(registeredFunctionKey .. " is already in use!")
    end

    self.RegisteredFunctions[registeredFunctionKey] = a24

    if self.FunctionMap[a24] == nil then
        self.FunctionMap[a24] = {}
    end

    self.FunctionMap[a24][registeredFunctionKey] = value
    self:RebuildProcessCommandsPriorities()
end

function Class2.GetIterator(self)
    --[[
      name: GetIterator
      line: 75
    ]]
    local readIndex = 1
    local key = nil
    local value = nil

    return function()
        --[[
          line: 80
          upvalues:
            readIndex (ref,  index: 1)
            self (copy, index: 2)
            key (ref,  index: 3)
            value (ref,  index: 4)
        ]]
        while true do
            if #self.RegisteredPriorites < readIndex then
                break
            end

            local registeredPriorite = self.RegisteredPriorites[readIndex]
            key, value = next(self.FunctionMap[registeredPriorite], key)

            if key ~= nil then
                return key, value, registeredPriorite
            end

            readIndex += 1
        end
    end
end

function v6.new()
    --[[
      name: new
      line: 96
      upvalues:
        Class2 (copy, index: 1)
    ]]
    local v30 = setmetatable({}, Class2)
    v30.RegisteredFunctions = {}
    v30.RegisteredPriorites = {}
    v30.FunctionMap = {}
    return v30
end

function Class.NewSortedFunctionContainer(a31)
    --[[
      name: NewSortedFunctionContainer
      line: 107
      upvalues:
        v6 (copy, index: 1)
    ]]
    return v6.new()
end

return Class