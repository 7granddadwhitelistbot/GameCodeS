local ConnectionUtil = require(script.Parent.ConnectionUtil)
local Class = {}
Class.__index = Class

function Class.new()
    --[[
      name: new
      line: 42
      upvalues:
        ConnectionUtil (copy, index: 1)
        Class (copy, index: 2)
    ]]
    return (setmetatable({_enabled = false, _camera = game.Workspace.CurrentCamera, _callbacks = {}, _connectionUtil = ConnectionUtil.new()}, Class))
end

function Class._connectCallbacks(self)
    --[[
      name: _connectCallbacks
      line: 55
    ]]
    self._camera = game.Workspace.CurrentCamera

    if not self._camera then
        return
    end

    for v4, callback in self._callbacks do
        self._connectionUtil:trackConnection(v4, self._camera:GetPropertyChangedSignal(v4):Connect(callback))
        callback()
    end
end

function Class.Enable(self)
    --[[
      name: Enable
      line: 71
    ]]
    if self._enabled then
        return
    end

    self._enabled = true
    self._cameraChangedConnection = game.Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(
        function()
            --[[
              line: 78
              upvalues:
                self (copy, index: 1)
            ]]
            self:_connectCallbacks()
        end
    )
    self:_connectCallbacks()
end

function Class.Disable(self)
    --[[
      name: Disable
      line: 85
    ]]
    if not self._enabled then
        return
    end

    self._enabled = false

    if self._cameraChangedConnection then
        self._cameraChangedConnection:Disconnect()
        self._cameraChangedConnection = nil
    end

    self._connectionUtil:disconnectAll()
end

function Class.Connect(self, callbackKey, value)
    --[[
      name: Connect
      line: 100
    ]]
    self._callbacks[callbackKey] = value

    if not self._camera then
        return
    end

    self._connectionUtil:trackConnection(callbackKey, self._camera:GetPropertyChangedSignal(callbackKey):Connect(value))
end

function Class.Disconnect(self, callbackKey)
    --[[
      name: Disconnect
      line: 110
    ]]
    self._connectionUtil:disconnect(callbackKey)
    self._callbacks[callbackKey] = nil
end

function Class.getCamera(self)
    --[[
      name: getCamera
      line: 116
    ]]
    return self._camera
end

return Class