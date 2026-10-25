local tbl_upv_1 = {}
tbl_upv_1.JUMP_STUDS = 4
tbl_upv_1.SETTLED_STUDS = 1
tbl_upv_1.DEBOUNCE_SECONDS = 0.25
function tbl_upv_1.shouldRecenter(a1, a2, a3, a4)
    --[[
      name: shouldRecenter
      line: 29
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    if a2 <= tbl_upv_1.JUMP_STUDS or a1 ~= nil and tbl_upv_1.SETTLED_STUDS <= a1 or a3 ~= nil and a4 - a3 < tbl_upv_1.DEBOUNCE_SECONDS then
        return false
    end
    return true
end
return tbl_upv_1