local chat = game:GetService("Chat")
local clientChatModules = chat:WaitForChild("ClientChatModules")
local ChatConstants = require(clientChatModules:WaitForChild("ChatConstants"))
local ChatSettings = require(clientChatModules:WaitForChild("ChatSettings"))

return function(a5)
    --[[
      name: Run
      line: 10
      upvalues:
        ChatSettings (copy, index: 1)
        ChatConstants (copy, index: 2)
    ]]
    if ChatSettings and ChatSettings.AllowMeCommand then
        a5:RegisterFilterMessageFunction(
            "me_command",
            function(a6, a7, a8)
                --[[
                  name: MeCommandFilterFunction
                  line: 13
                  upvalues:
                    ChatConstants (copy, index: 1)
                ]]
                local message = a7.Message

                if message and string.sub(message, 1, 4):lower() == "/me " then
                    a7.MessageType = ChatConstants.MessageTypeMeCommand
                end
            end
        )
    end
end