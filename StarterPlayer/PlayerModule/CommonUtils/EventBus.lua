local Class = {}
Class.__index = Class

function Class.new()
    --[[
      name: new
      line: 23
      upvalues:
        Class (copy, index: 1)
    ]]
    local v2 = setmetatable({}, Class)
    v2._events = {}
    return v2
end

function Class._getOrCreate(self, name: string)
    --[[
      name: _getOrCreate
      line: 29
    ]]
    if not self._events[name] then
        local bindableEvent = Instance.new("BindableEvent")
        bindableEvent.Name = name
        self._events[name] = bindableEvent
    end

    return self._events[name]
end

function Class.publish(self, a7, ...)
    --[[
      name: publish
      line: 38
    ]]
    local orCreate = self:_getOrCreate(a7)
    orCreate:Fire(...)
end

function Class.subscribe(self, a10)
    --[[
      name: subscribe
      line: 43
    ]]
    local orCreate = self:_getOrCreate(a10)
    return orCreate.Event
end

return Class