local Class = {}
Class.__index = Class
setmetatable(
    Class,
    {
        __call = (function(self, ...)
            --[[
              name: __call
              line: 11
              upvalues:
                Class (copy, index: 1)
            ]]
            return Class.new(...)
        end)
    }
)

function Class.new()
    --[[
      name: new
      line: 16
      upvalues:
        Class (copy, index: 1)
    ]]
    return (setmetatable({}, Class))
end

function Class.CharacterAdded(a3, a4, a5)
    --[[
      name: CharacterAdded
      line: 23
    ]]
end

function Class.CharacterRemoving(a6, a7, a8)
    --[[
      name: CharacterRemoving
      line: 27
    ]]
end

function Class.OnCameraSubjectChanged(a9, a10)
    --[[
      name: OnCameraSubjectChanged
      line: 29
    ]]
end

function Class.GetOcclusionMode(a11)
    --[[
      name: GetOcclusionMode
      line: 33
    ]]
    warn("BaseOcclusion GetOcclusionMode must be overridden by derived classes")
    return nil
end

function Class.Enable(a12, a13)
    --[[
      name: Enable
      line: 39
    ]]
    warn("BaseOcclusion Enable must be overridden by derived classes")
end

function Class.Update(a14, a15, a16, a17)
    --[[
      name: Update
      line: 43
    ]]
    warn("BaseOcclusion Update must be overridden by derived classes")
    return a16, a17
end

return Class