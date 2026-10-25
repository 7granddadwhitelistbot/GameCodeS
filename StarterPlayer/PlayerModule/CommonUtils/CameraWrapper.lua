local ConnectionUtil_upv_1 = require(script.Parent.ConnectionUtil)
local tbl_upv_1 = {}
tbl_upv_1.__index = tbl_upv_1
function tbl_upv_1.new()
    --[[
      name: new
      line: 39
      upvalues:
        ConnectionUtil_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    return (setmetatable({_enabled = false, _camera = game.Workspace.CurrentCamera, _callbacks = {}, _connectionUtil = ConnectionUtil_upv_1.new()}, tbl_upv_1))
end
function tbl_upv_1._connectCallbacks(a1)
    --[[
      name: _connectCallbacks
      line: 52
    ]]
    a1._camera = game.Workspace.CurrentCamera
    if not a1._camera then
        return
    end
    for key_1, value_1 in a1._callbacks do
        a1._connectionUtil:trackConnection(key_1, a1._camera:GetPropertyChangedSignal(key_1):Connect(value_1))
        value_1()
    end
end
function tbl_upv_1.Enable(a1)
    --[[
      name: Enable
      line: 65
    ]]
    if a1._enabled then
        return
    end
    a1._enabled = true
    a1._cameraChangedConnection = game.Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(
        function()
            --[[
              line: 72
              upvalues:
                a1 (copy, index: 1)
            ]]
            a1:_connectCallbacks()
        end
    )
    a1:_connectCallbacks()
end
function tbl_upv_1.Disable(a1)
    --[[
      name: Disable
      line: 79
    ]]
    if not a1._enabled then
        return
    end
    a1._enabled = false
    if a1._cameraChangedConnection then
        a1._cameraChangedConnection:Disconnect()
        a1._cameraChangedConnection = nil
    end
    a1._connectionUtil:disconnectAll()
end
function tbl_upv_1.Connect(a1, a2, a3)
    --[[
      name: Connect
      line: 94
    ]]
    a1._callbacks[a2] = a3
    if not a1._camera then
        return
    end
    a1._connectionUtil:trackConnection(a2, a1._camera:GetPropertyChangedSignal(a2):Connect(a3))
end
function tbl_upv_1.Disconnect(a1, a2)
    --[[
      name: Disconnect
      line: 104
    ]]
    a1._connectionUtil:disconnect(a2)
    a1._callbacks[a2] = nil
end
function tbl_upv_1.getCamera(a1)
    --[[
      name: getCamera
      line: 110
    ]]
    return a1._camera
end
return tbl_upv_1