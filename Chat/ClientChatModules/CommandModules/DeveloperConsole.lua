local StarterGui_upv_1 = game:GetService("StarterGui")
local Util_1 = require(script.Parent:WaitForChild("Util"))
function ProcessMessage(a1, a2, a3)
    --[[
      name: ProcessMessage
      line: 9
      upvalues:
        StarterGui_upv_1 (copy, index: 1)
    ]]
    if string.sub(a1, 1, 8):lower() ~= "/console" and string.sub(a1, 1, 11):lower() ~= "/newconsole" then
        return false
    end
    local success_1, u1 = pcall(
        function()
            --[[
              line: 11
              upvalues:
                StarterGui_upv_1 (copy, index: 1)
            ]]
            return StarterGui_upv_1:GetCore("DevConsoleVisible")
        end
    )
    if success_1 then
        local success_2, v1 = pcall(
            function()
                --[[
                  line: 13
                  upvalues:
                    StarterGui_upv_1 (copy, index: 1)
                    u1 (copy, index: 2)
                ]]
                StarterGui_upv_1:SetCore("DevConsoleVisible", not u1)
            end
        )
        if not (success_2) and v1 then
            print("Error making developer console visible: " .. v1)
        end
    end
    return true
end
local tbl_1 = {}
tbl_1[Util_1.KEY_COMMAND_PROCESSOR_TYPE] = Util_1.COMPLETED_MESSAGE_PROCESSOR
tbl_1[Util_1.KEY_PROCESSOR_FUNCTION] = ProcessMessage
return tbl_1