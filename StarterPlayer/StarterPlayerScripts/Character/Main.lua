local ReplicatedStorage_1 = game:GetService("ReplicatedStorage")
require(ReplicatedStorage_1:WaitForChild("Shared"):WaitForChild("Loc")).Install()
require(ReplicatedStorage_1:WaitForChild("Shared"):WaitForChild("Camera"))
local tbl_upv_1 = {"Quality", "Movement", "TouchControls", "Procedural", "Footsteps", "RemoteAnimate", "ResetButton", "ViewModel"}
local tbl_upv_2 = {}
for _, value_upv_1 in tbl_upv_1 do
    task.spawn(
        function()
            --[[
              line: 28
              upvalues:
                value_upv_1 (copy, index: 1)
                tbl_upv_2 (copy, index: 2)
            ]]
            local v1 = os.clock()
            local success_1, v2 = pcall(
                function()
                    --[[
                      line: 30
                      upvalues:
                        value_upv_1 (copy, index: 1)
                    ]]
                    require(script.Parent:WaitForChild(value_upv_1, 10)).Start()
                end
            )
            if success_1 then
                tbl_upv_2[value_upv_1] = (os.clock() - v1) * 1000
            else
                warn((("[Character] %* failed to start: %*"):format(value_upv_1, v2)))
                tbl_upv_2[value_upv_1] = -1
            end
        end
    )
end
task.delay(
    5,
    function()
        --[[
          line: 43
          upvalues:
            tbl_upv_1 (copy, index: 1)
            tbl_upv_2 (copy, index: 2)
        ]]
        local tbl_3 = {}
        local v3 = nil
        for _, value_2 in tbl_upv_1 do
            local v4 = tbl_upv_2[value_2]
            if v4 == nil then
                v3 = ("%* STILL STARTING"):format(value_2)
                table.insert(tbl_3, v3)
                continue
            end
            if v4 < 0 then
                v3 = ("%* FAILED"):format(value_2)
            else
                v3 = string.format("%s %.1f", value_2, v4)
            end
            table.insert(tbl_3, v3)
        end
        local v5 = "[Character] started (ms): " .. table.concat(tbl_3, ", ")
        for _, value_3 in tbl_upv_1 do
            if tbl_upv_2[value_3] == nil or tbl_upv_2[value_3] < 0 then
                warn(v5)
                return
            end
        end
        print(v5)
    end
)