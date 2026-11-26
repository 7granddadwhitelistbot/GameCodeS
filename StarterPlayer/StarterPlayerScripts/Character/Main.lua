local replicatedStorage = game:GetService("ReplicatedStorage")
require(replicatedStorage:WaitForChild("Shared"):WaitForChild("Loc")).Install()
require(replicatedStorage:WaitForChild("Shared"):WaitForChild("Camera"))
local childNames = {"Quality", "Movement", "TouchControls", "Procedural", "Footsteps", "RemoteAnimate", "ResetButton", "ViewModel"}
local v3 = {}

for _, childName in childNames do
    task.spawn(
        function()
            --[[
              line: 28
              upvalues:
                childName (copy, index: 1)
                v3 (copy, index: 2)
            ]]
            local timestamp = os.clock()

            local success, result = pcall(
                function()
                    --[[
                      line: 30
                      upvalues:
                        childName (copy, index: 1)
                    ]]
                    local child = require((script.Parent:WaitForChild(childName, 10)))
                    child.Start()
                end
            )

            if success then
                v3[childName] = (os.clock() - timestamp) * 1000
                return
            end

            warn((`[Character] {childName} failed to start: {result}`))
            v3[childName] = -1
        end
    )
end

task.delay(
    5,
    function()
        --[[
          line: 43
          upvalues:
            childNames (copy, index: 1)
            v3 (copy, index: 2)
        ]]
        local parts = {}

        for _, v12 in childNames do
            local formattedText
            local v14 = v3[v12]

            if v14 == nil then
                formattedText = `{v12} STILL STARTING`
            else
                formattedText = if v14 < 0 then `{v12} FAILED` else string.format("%s %.1f", v12, v14)
            end

            table.insert(parts, formattedText)
        end

        local v15 = "[Character] started (ms): " .. table.concat(parts, ", ")

        for _, v17 in childNames do
            if v3[v17] ~= nil and not (v3[v17] < 0) then
                continue
            end

            warn(v15)

            return
        end

        print(v15)
    end
)