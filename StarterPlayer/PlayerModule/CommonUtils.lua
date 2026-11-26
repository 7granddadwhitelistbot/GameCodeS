local v1 = {_mocks = {}}

function v1.mock(mockKey, value)
    --[[
      name: mock
      line: 16
      upvalues:
        v1 (copy, index: 1)
    ]]
    v1._mocks[mockKey] = value
end

function v1.get(childName: string)
    --[[
      name: get
      line: 20
      upvalues:
        v1 (copy, index: 1)
    ]]
    if v1._mocks[childName] then
        return require(v1._mocks[childName])
    end
    if script:FindFirstChild(childName) then
        return require(script:FindFirstChild(childName))
    end

    assert(false, "Util does not exist: " .. childName)
end

return v1