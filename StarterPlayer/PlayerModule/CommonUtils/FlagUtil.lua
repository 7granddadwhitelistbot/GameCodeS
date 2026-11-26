return {
    getUserFlag = (function(a1)
        --[[
          name: getUserFlag
          line: 11
        ]]
        local success, isUserFeatureEnabled = pcall(
            function()
                --[[
                  line: 12
                  upvalues:
                    a1 (copy, index: 1)
                ]]
                return UserSettings():IsUserFeatureEnabled(a1)
            end
        )
        return success and isUserFeatureEnabled
    end)
}