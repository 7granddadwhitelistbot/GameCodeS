local u1 = require(game:GetService("Chat"):WaitForChild("ClientChatModules"):WaitForChild("ChatConstants")).StandardPriority
if u1 == nil then
    u1 = 10
end
local tbl_1 = {}
tbl_1.__index = tbl_1
local tbl_upv_2 = {}
local tbl_upv_3 = {}
tbl_upv_3.__index = tbl_upv_3
function tbl_upv_3.RebuildProcessCommandsPriorities(a1)
    --[[
      name: RebuildProcessCommandsPriorities
      line: 25
    ]]
    a1.RegisteredPriorites = {}
    local v1 = nil
    for key_1, value_1 in pairs(a1.FunctionMap) do
        v1 = true
        for _, v2 in pairs(value_1) do
            v1 = false
            break
        end
        if not (v1) then
            table.insert(a1.RegisteredPriorites, key_1)
        end
    end
    table.sort(
        a1.RegisteredPriorites,
        function(a2, a3)
            --[[
              line: 37
            ]]
            return a3 < a2
        end
    )
end
function tbl_upv_3.HasFunction(a1, a2)
    --[[
      name: HasFunction
      line: 42
    ]]
    if a1.RegisteredFunctions[a2] ~= nil then
        return true
    end
    return false
end
function tbl_upv_3.RemoveFunction(a1, a2)
    --[[
      name: RemoveFunction
      line: 49
    ]]
    a1.RegisteredFunctions[a2] = nil
    a1.FunctionMap[a1.RegisteredFunctions[a2]][a2] = nil
    a1:RebuildProcessCommandsPriorities()
end
function tbl_upv_3.AddFunction(a1, a2, a3, a4)
    --[[
      name: AddFunction
      line: 56
      upvalues:
        u1 (ref, index: 1)
    ]]
    if a4 == nil then
        a4 = u1
    end
    if a1.RegisteredFunctions[a2] then
        error(a2 .. " is already in use!")
    end
    a1.RegisteredFunctions[a2] = a4
    if a1.FunctionMap[a4] == nil then
        a1.FunctionMap[a4] = {}
    end
    a1.FunctionMap[a4][a2] = a3
    a1:RebuildProcessCommandsPriorities()
end
function tbl_upv_3.GetIterator(a1)
    --[[
      name: GetIterator
      line: 75
    ]]
    local u2 = 1
    local u3 = nil
    local u4 = nil
    local v3 = function()
        --[[
          line: 80
          upvalues:
            u2 (ref,  index: 1)
            a1 (copy, index: 2)
            u3 (ref,  index: 3)
            u4 (ref,  index: 4)
        ]]
        while not (#a1.RegisteredPriorites < u2) do
            local v4 = a1.RegisteredPriorites[u2]
            u3, u4 = next(a1.FunctionMap[v4], u3)
            if u3 == nil then
                u2 = u2 + 1
                continue
            end
            return u3, u4, v4
        end
    end
    return v3
end
function tbl_upv_2.new()
    --[[
      name: new
      line: 96
      upvalues:
        tbl_upv_3 (copy, index: 1)
    ]]
    local v5 = setmetatable({}, tbl_upv_3)
    v5.RegisteredFunctions = {}
    v5.RegisteredPriorites = {}
    v5.FunctionMap = {}
    return v5
end
function tbl_1.NewSortedFunctionContainer(a1)
    --[[
      name: NewSortedFunctionContainer
      line: 107
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    return tbl_upv_2.new()
end
return tbl_1