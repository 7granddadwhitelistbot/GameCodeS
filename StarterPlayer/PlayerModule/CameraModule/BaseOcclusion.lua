local tbl_upv_1 = {}
tbl_upv_1.__index = tbl_upv_1
local tbl_2 = {}
function tbl_2.__call(a1, ...)
    --[[
      name: __call
      line: 10
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    return tbl_upv_1.new(...)
end
setmetatable(tbl_upv_1, tbl_2)
function tbl_upv_1.new()
    --[[
      name: new
      line: 15
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    return (setmetatable({}, tbl_upv_1))
end
function tbl_upv_1.CharacterAdded(a1, a2, a3)
    --[[
      name: CharacterAdded
      line: 21
    ]]
end
function tbl_upv_1.CharacterRemoving(a1, a2, a3)
    --[[
      name: CharacterRemoving
      line: 25
    ]]
end
function tbl_upv_1.OnCameraSubjectChanged(a1, a2)
    --[[
      name: OnCameraSubjectChanged
      line: 28
    ]]
end
function tbl_upv_1.GetOcclusionMode(a1)
    --[[
      name: GetOcclusionMode
      line: 32
    ]]
    warn("BaseOcclusion GetOcclusionMode must be overridden by derived classes")
    return nil
end
function tbl_upv_1.Enable(a1, a2)
    --[[
      name: Enable
      line: 38
    ]]
    warn("BaseOcclusion Enable must be overridden by derived classes")
end
function tbl_upv_1.Update(a1, a2, a3, a4)
    --[[
      name: Update
      line: 42
    ]]
    warn("BaseOcclusion Update must be overridden by derived classes")
    return a3, a4
end
return tbl_upv_1