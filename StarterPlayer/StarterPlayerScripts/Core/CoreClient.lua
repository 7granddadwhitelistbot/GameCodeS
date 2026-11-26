local parent = script.Parent

local function start(childName: string)
    --[[
      name: start
      line: 7
      upvalues:
        parent (copy, index: 1)
    ]]
    local child = parent:WaitForChild(childName, 10)
    if not child then
        warn((`[CoreClient] missing module {childName}`))
        return
    end

    local success, result = pcall(
        function()
            --[[
              line: 13
              upvalues:
                child (copy, index: 1)
            ]]
            require(child).Start()
        end
    )
    if not success then
        warn((`[CoreClient] {childName}.Start failed: {result}`))
    end
end

start("LightingController")
start("RingOfFire")
task.spawn(start, "AnalyticsClient")