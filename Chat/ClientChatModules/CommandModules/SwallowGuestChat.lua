local Util_upv_1 = require(script.Parent:WaitForChild("Util"))
local RunService_upv_1 = game:GetService("RunService")
local u1 = nil
pcall(
    function()
        --[[
          line: 12
          upvalues:
            u1 (ref, index: 1)
        ]]
        u1 = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
    end
)
if u1 == nil then
    u1 = {}
    function u1.Get(a1, a2, a3)
        --[[
          name: Get
          line: 13
        ]]
        return a3
    end
end
function ProcessMessage(a1, a2, a3)
    --[[
      name: ProcessMessage
      line: 15
      upvalues:
        RunService_upv_1 (copy, index: 1)
        Util_upv_1 (copy, index: 2)
        u1 (ref,  index: 3)
    ]]
    local LocalPlayer_1 = game:GetService("Players").LocalPlayer
    if LocalPlayer_1 and LocalPlayer_1.UserId < 0 and not (RunService_upv_1:IsStudio()) then
        local v1 = a2:GetCurrentChannel()
        if v1 then
            local tbl_1 = {}
            Util_upv_1:SendSystemMessageToSelf(u1:Get("GameChat_SwallowGuestChat_Message", "Create a free account to get access to chat permissions!"), v1, tbl_1)
        end
        return true
    end
    return false
end
local tbl_2 = {}
tbl_2[Util_upv_1.KEY_COMMAND_PROCESSOR_TYPE] = Util_upv_1.COMPLETED_MESSAGE_PROCESSOR
tbl_2[Util_upv_1.KEY_PROCESSOR_FUNCTION] = ProcessMessage
return tbl_2