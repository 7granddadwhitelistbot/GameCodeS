local tbl_upv_1 = {}
tbl_upv_1.__index = tbl_upv_1
function tbl_upv_1.new()
    --[[
      name: new
      line: 15
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    return (setmetatable({_handlers = {}}, tbl_upv_1))
end
function tbl_upv_1.Connect(a1, a2)
    --[[
      name: Connect
      line: 19
    ]]
    local tbl_2 = {Connected = true}
    local _handlers_upv_1 = a1._handlers
    function tbl_2.Disconnect(a3)
        --[[
          name: Disconnect
          line: 22
          upvalues:
            _handlers_upv_1 (copy, index: 1)
            a2 (copy, index: 2)
        ]]
        a3.Connected = false
        local v1 = table.find(_handlers_upv_1, a2)
        if not v1 then
            return
        end
        table.remove(_handlers_upv_1, v1)
    end
    table.insert(_handlers_upv_1, a2)
    return tbl_2
end
function tbl_upv_1.Once(a1, a2)
    --[[
      name: Once
      line: 33
    ]]
    local u1 = nil
    local v2 = a1:Connect(
        function(...)
            --[[
              line: 35
              upvalues:
                u1 (ref,  index: 1)
                a2 (copy, index: 2)
            ]]
            u1:Disconnect()
            a2(...)
        end
    )
    u1 = v2
    return u1
end
function tbl_upv_1.Fire(a1, ...)
    --[[
      name: Fire
      line: 42
    ]]
    for _, value_1 in table.clone(a1._handlers) do
        task.spawn(value_1, ...)
    end
end
function tbl_upv_1.Wait(a1)
    --[[
      name: Wait
      line: 48
    ]]
    local u2 = coroutine.running()
    a1:Once(
        function(...)
            --[[
              line: 50
              upvalues:
                u2 (copy, index: 1)
            ]]
            task.spawn(u2, ...)
        end
    )
    return coroutine.yield()
end
return tbl_upv_1