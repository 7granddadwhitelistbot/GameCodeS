local tbl_1 = {}
local tbl_upv_2 = {}
tbl_upv_2.__index = tbl_upv_2
function tbl_upv_2.GetInstance(a1, a2)
    --[[
      name: GetInstance
      line: 14
    ]]
    if a1.InstancePoolsByClass[a2] == nil then
        a1.InstancePoolsByClass[a2] = {}
    end
    local v1 = #a1.InstancePoolsByClass[a2]
    if v1 > 0 then
        table.remove(a1.InstancePoolsByClass[a2])
        return a1.InstancePoolsByClass[a2][v1]
    end
    return Instance.new(a2)
end
function tbl_upv_2.ReturnInstance(a1, a2)
    --[[
      name: ReturnInstance
      line: 27
    ]]
    if a1.InstancePoolsByClass[a2.ClassName] == nil then
        a1.InstancePoolsByClass[a2.ClassName] = {}
    end
    if #a1.InstancePoolsByClass[a2.ClassName] < a1.PoolSizePerType then
        table.insert(a1.InstancePoolsByClass[a2.ClassName], a2)
    else
        a2:Destroy()
    end
end
function tbl_1.new(a1)
    --[[
      name: new
      line: 41
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    local v2 = setmetatable({}, tbl_upv_2)
    v2.InstancePoolsByClass = {}
    v2.Name = "ObjectPool"
    v2.PoolSizePerType = a1
    return v2
end
return tbl_1