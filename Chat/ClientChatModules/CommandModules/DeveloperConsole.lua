local starterGui = game:GetService("StarterGui")
local Util = require(script.Parent:WaitForChild("Util"))

function ProcessMessage(text: string, a4, a5)
    --[[
      name: ProcessMessage
      line: 9
      upvalues:
        starterGui (copy, index: 1)
    ]]
    if string.sub(text, 1, 8):lower() ~= "/console" and string.sub(text, 1, 11):lower() ~= "/newconsole" then
        return false
    end

    local success, core = pcall(
        function()
            --[[
              line: 11
              upvalues:
                starterGui (copy, index: 1)
            ]]
            return starterGui:GetCore("DevConsoleVisible")
        end
    )
    if success then
        local success2, result = pcall(
            function()
                --[[
                  line: 13
                  upvalues:
                    starterGui (copy, index: 1)
                    core (copy, index: 2)
                ]]
                starterGui:SetCore("DevConsoleVisible", not core)
            end
        )

        if not success2 and result then
            print("Error making developer console visible: " .. result)
        end
    end

    return true
end

local v10 = {}
v10[Util.KEY_COMMAND_PROCESSOR_TYPE] = Util.COMPLETED_MESSAGE_PROCESSOR
v10[Util.KEY_PROCESSOR_FUNCTION] = ProcessMessage

return v10