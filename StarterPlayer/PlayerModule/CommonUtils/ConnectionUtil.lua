local Class = {}
Class.__index = Class

function Class.new()
    --[[
      name: new
      line: 29
      upvalues:
        Class (copy, index: 1)
    ]]
    local v2 = setmetatable({}, Class)
    v2._connections = {}
    return v2
end

function Class.trackConnection(self, connectionKey, a5)
    --[[
      name: trackConnection
      line: 37
    ]]
    if self._connections[connectionKey] then
        self._connections[connectionKey]()
    end

    self._connections[connectionKey] = function()
        --[[
          line: 42
          upvalues:
            a5 (copy, index: 1)
        ]]
        a5:Disconnect()
    end
end

function Class.trackBoundFunction(self, connectionKey, value)
    --[[
      name: trackBoundFunction
      line: 47
    ]]
    if self._connections[connectionKey] then
        self._connections[connectionKey]()
    end

    self._connections[connectionKey] = value
end

function Class.disconnect(self, connectionKey)
    --[[
      name: disconnect
      line: 54
    ]]
    local connection = self._connections[connectionKey]
    if connection then
        self._connections[connectionKey]()
        self._connections[connectionKey] = nil
    end
end

function Class.disconnectAll(self)
    --[[
      name: disconnectAll
      line: 61
    ]]
    for _, connection in pairs(self._connections) do
        connection()
    end

    self._connections = {}
end

return Class