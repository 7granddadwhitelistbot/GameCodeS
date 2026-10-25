local UserInputService_1 = game:GetService("UserInputService")
local tbl_1 = {}
local tbl_upv_2 = {}
UserInputService_1.TouchStarted:Connect(
    function(a1)
        --[[
          line: 19
          upvalues:
            tbl_upv_2 (copy, index: 1)
        ]]
        tbl_upv_2[a1] = Vector2.new(a1.Position.X, a1.Position.Y)
    end
)
UserInputService_1.TouchEnded:Connect(
    function(a1)
        --[[
          line: 22
          upvalues:
            tbl_upv_2 (copy, index: 1)
        ]]
        task.defer(
            function()
                --[[
                  line: 24
                  upvalues:
                    tbl_upv_2 (copy, index: 1)
                    a1 (copy, index: 2)
                ]]
                tbl_upv_2[a1] = nil
            end
        )
    end
)
function tbl_1.BeganOn(a1, a2)
    --[[
      name: BeganOn
      line: 29
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    if a2.UserInputType ~= Enum.UserInputType.Touch then
        return true
    end
    local v1 = tbl_upv_2[a2]
    if v1 == nil then
        return true
    end
    local AbsolutePosition_1 = a1.AbsolutePosition
    local AbsoluteSize_1 = a1.AbsoluteSize
    return (AbsolutePosition_1.X - 6 <= v1.X) and ((v1.X <= (AbsolutePosition_1.X + AbsoluteSize_1.X) + 6) and ((AbsolutePosition_1.Y - 6 <= v1.Y) and (v1.Y <= (AbsolutePosition_1.Y + AbsoluteSize_1.Y) + 6)))
end
return tbl_1