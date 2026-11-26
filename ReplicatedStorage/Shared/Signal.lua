local Class = {}
Class.__index = Class

function Class.new()
    --[[
      name: new
      line: 15
      upvalues:
        Class (copy, index: 1)
    ]]
    return (setmetatable({_handlers = {}}, Class))
end

function Class.Connect(self, target)
    --[[
      name: Connect
      line: 19
    ]]
    local v4 = {Connected = true}
    local handlers = self._handlers

    function v4.Disconnect(a6)
        --[[
          name: Disconnect
          line: 22
          upvalues:
            handlers (copy, index: 1)
            target (copy, index: 2)
        ]]
        a6.Connected = false

        if const index = table.find(handlers, target) then
            table.remove(handlers, index)
        end
    end

    table.insert(handlers, target)

    return v4
end

function Class.Once(self, callback)
    --[[
      name: Once
      line: 33
    ]]
    local v10 = nil

    v10 = self:Connect(
        function(...)
            --[[
              line: 35
              upvalues:
                v10 (ref,  index: 1)
                callback (copy, index: 2)
            ]]
            v10:Disconnect()
            callback(...)
        end
    )

    return v10
end

function Class.Fire(self, ...)
    --[[
      name: Fire
      line: 42
    ]]
    for _, value in table.clone(self._handlers) do
        task.spawn(value, ...)
    end
end

function Class.Wait(self)
    --[[
      name: Wait
      line: 48
    ]]
    local v15 = coroutine.running()
    self:Once(
        function(...)
            --[[
              line: 50
              upvalues:
                v15 (copy, index: 1)
            ]]
            task.spawn(v15, ...)
        end
    )

    return coroutine.yield()
end

return Class