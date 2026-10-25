local tbl_upv_1 = {}
tbl_upv_1.__index = tbl_upv_1
function tbl_upv_1.new()
    --[[
      name: new
      line: 25
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v1 = setmetatable({}, tbl_upv_1)
    v1._connections = {}
    return v1
end
function tbl_upv_1.trackConnection(a1, a2, a3)
    --[[
      name: trackConnection
      line: 33
    ]]
    if a1._connections[a2] then
        a1._connections[a2]()
    end
    a1._connections[a2] = function()
        --[[
          line: 38
          upvalues:
            a3 (copy, index: 1)
        ]]
        a3:Disconnect()
    end
end
function tbl_upv_1.trackBoundFunction(a1, a2, a3)
    --[[
      name: trackBoundFunction
      line: 41
    ]]
    if a1._connections[a2] then
        a1._connections[a2]()
    end
    a1._connections[a2] = a3
end
function tbl_upv_1.disconnect(a1, a2)
    --[[
      name: disconnect
      line: 48
    ]]
    if not a1._connections[a2] then
        return
    end
    a1._connections[a2]()
    a1._connections[a2] = nil
end
function tbl_upv_1.disconnectAll(a1)
    --[[
      name: disconnectAll
      line: 55
    ]]
    for _, value_1 in pairs(a1._connections) do
        value_1()
    end
    a1._connections = {}
end
return tbl_upv_1