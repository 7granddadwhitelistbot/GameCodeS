local v1 = {}
local Class = {}
Class.__index = Class

function Class.GetInstance(self, key: string)
    --[[
      name: GetInstance
      line: 14
    ]]
    if self.InstancePoolsByClass[key] == nil then
        self.InstancePoolsByClass[key] = {}
    end

    local length = #self.InstancePoolsByClass[key]

    if 0 < length then
        local v6 = self.InstancePoolsByClass[key][length]
        table.remove(self.InstancePoolsByClass[key])

        return v6
    end

    return Instance.new(key)
end

function Class.ReturnInstance(self, a8)
    --[[
      name: ReturnInstance
      line: 27
    ]]
    if self.InstancePoolsByClass[a8.ClassName] == nil then
        self.InstancePoolsByClass[a8.ClassName] = {}
    end

    if #self.InstancePoolsByClass[a8.ClassName] < self.PoolSizePerType then
        table.insert(self.InstancePoolsByClass[a8.ClassName], a8)
        return
    end

    a8:Destroy()
end

function v1.new(poolSizePerType)
    --[[
      name: new
      line: 41
      upvalues:
        Class (copy, index: 1)
    ]]
    local v10 = setmetatable({}, Class)
    v10.InstancePoolsByClass = {}
    v10.Name = "ObjectPool"
    v10.PoolSizePerType = poolSizePerType
    return v10
end

return v1