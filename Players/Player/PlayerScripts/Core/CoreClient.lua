local Parent_upv_1 = script.Parent
local function start(a1)
    --[[
      name: start
      line: 7
      upvalues:
        Parent_upv_1 (copy, index: 1)
    ]]
    local u1 = Parent_upv_1:WaitForChild(a1, 10)
    if u1 then
        local success_1, v1 = pcall(
            function()
                --[[
                  line: 13
                  upvalues:
                    u1 (copy, index: 1)
                ]]
                require(u1).Start()
            end
        )
        if not (success_1) then
            warn((("[CoreClient] %*.Start failed: %*"):format(a1, v1)))
        end
    else
        warn((("[CoreClient] missing module %*"):format(a1)))
    end
end
start("LightingController")
start("RingOfFire")
task.spawn(start, "AnalyticsClient")