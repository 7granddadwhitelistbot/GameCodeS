local tbl_upv_1 = {}
tbl_upv_1.__index = tbl_upv_1
function tbl_upv_1.new()
    --[[
      name: new
      line: 20
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v1 = setmetatable({}, tbl_upv_1)
    v1._events = {}
    return v1
end
function tbl_upv_1._getOrCreate(a1, a2)
    --[[
      name: _getOrCreate
      line: 26
    ]]
    if not (a1._events[a2]) then
        local v2 = Instance.new("BindableEvent")
        v2.Name = a2
        a1._events[a2] = v2
    end
    return a1._events[a2]
end
function tbl_upv_1.publish(a1, a2, ...)
    --[[
      name: publish
      line: 35
    ]]
    a1:_getOrCreate(a2):Fire(...)
end
function tbl_upv_1.subscribe(a1, a2)
    --[[
      name: subscribe
      line: 40
    ]]
    return a1:_getOrCreate(a2).Event
end
return tbl_upv_1