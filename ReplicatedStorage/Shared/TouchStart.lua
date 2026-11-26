local userInputService = game:GetService("UserInputService")
local v2 = {}
local v3 = {}
userInputService.TouchStarted:Connect(
    function(touch: InputObject)
        --[[
          line: 19
          upvalues:
            v3 (copy, index: 1)
        ]]
        v3[touch] = Vector2.new(touch.Position.X, touch.Position.Y)
    end
)
userInputService.TouchEnded:Connect(
    function(touch: InputObject)
        --[[
          line: 22
          upvalues:
            v3 (copy, index: 1)
        ]]
        task.defer(
            function()
                --[[
                  line: 24
                  upvalues:
                    v3 (copy, index: 1)
                    touch (copy, index: 2)
                ]]
                v3[touch] = nil
            end
        )
    end
)

function v2.BeganOn(a6, key)
    --[[
      name: BeganOn
      line: 29
      upvalues:
        v3 (copy, index: 1)
    ]]
    if key.UserInputType ~= Enum.UserInputType.Touch then
        return true
    end

    local v8 = v3[key]
    if v8 == nil then
        return true
    end

    local absolutePosition = a6.AbsolutePosition
    local absoluteSize = a6.AbsoluteSize
    local v11 = false
    local x = v8.X

    if absolutePosition.X - 6 <= x then
        v11 = false

        if v8.X <= (absolutePosition.X + absoluteSize.X) + 6 then
            v11 = false
            local y = v8.Y

            if absolutePosition.Y - 6 <= y then
                v11 = v8.Y <= (absolutePosition.Y + absoluteSize.Y) + 6
            end
        end
    end

    return v11
end

return v2