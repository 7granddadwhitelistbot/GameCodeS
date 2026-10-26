local ClientChatModules_1 = game:GetService("Chat"):WaitForChild("ClientChatModules")
local ChatConstants_upv_1 = require(ClientChatModules_1:WaitForChild("ChatConstants"))
local ChatSettings_upv_1 = require(ClientChatModules_1:WaitForChild("ChatSettings"))
local function Run(a1)
    --[[
      name: Run
      line: 10
      upvalues:
        ChatSettings_upv_1 (copy, index: 1)
        ChatConstants_upv_1 (copy, index: 2)
    ]]
    if not ChatSettings_upv_1 then
        return
    end
    if ChatSettings_upv_1.AllowMeCommand then
        local function MeCommandFilterFunction_1(a2, a3, a4)
            --[[
              name: MeCommandFilterFunction
              line: 13
              upvalues:
                ChatConstants_upv_1 (copy, index: 1)
            ]]
            local Message_1 = a3.Message
            if not Message_1 or string.sub(Message_1, 1, 4):lower() ~= "/me " then
                return
            end
            a3.MessageType = ChatConstants_upv_1.MessageTypeMeCommand
        end
        a1:RegisterFilterMessageFunction("me_command", MeCommandFilterFunction_1)
    end
end
return Run