local tbl_upv_1 = {}
tbl_upv_1._mocks = {}
function tbl_upv_1.mock(a1, a2)
    --[[
      name: mock
      line: 16
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    tbl_upv_1._mocks[a1] = a2
end
function tbl_upv_1.get(a1)
    --[[
      name: get
      line: 20
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    if tbl_upv_1._mocks[a1] then
        return require(tbl_upv_1._mocks[a1])
    end
    if script:FindFirstChild(a1) then
        return require(script:FindFirstChild(a1))
    end
    assert(false, "Util does not exist: " .. a1)
end
return tbl_upv_1