local tbl_1 = {}
function tbl_1.getUserFlag(a1)
    --[[
      name: getUserFlag
      line: 11
    ]]
    local success_1, v1 = pcall(
        function()
            --[[
              line: 12
              upvalues:
                a1 (copy, index: 1)
            ]]
            return UserSettings():IsUserFeatureEnabled(a1)
        end
    )
    return success_1 and v1
end
return tbl_1