local v1 = {JUMP_STUDS = 4, SETTLED_STUDS = 1, DEBOUNCE_SECONDS = 0.25}

function v1.shouldRecenter(a2, a3, a4, a5)
    --[[
      name: shouldRecenter
      line: 29
      upvalues:
        v1 (copy, index: 1)
    ]]
    if a3 <= v1.JUMP_STUDS then
        return false
    end
    if a2 ~= nil and v1.SETTLED_STUDS <= a2 then
        return false
    end
    if a4 ~= nil and a5 - a4 < v1.DEBOUNCE_SECONDS then
        return false
    end

    return true
end

return v1