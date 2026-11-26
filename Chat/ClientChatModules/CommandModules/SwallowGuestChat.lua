local Util = require(script.Parent:WaitForChild("Util"))
local runService = game:GetService("RunService")
local v3 = nil
pcall(
    function()
        --[[
          line: 12
          upvalues:
            v3 (ref, index: 1)
        ]]
        v3 = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
    end
)

if v3 == nil then
    v3 = {}

    function v3.Get(a4, a5, a6)
        --[[
          name: Get
          line: 13
        ]]
        return a6
    end
end

function ProcessMessage(a7, a8, a9)
    --[[
      name: ProcessMessage
      line: 15
      upvalues:
        runService (copy, index: 1)
        Util (copy, index: 2)
        v3 (ref,  index: 3)
    ]]
    local localPlayer = game:GetService("Players").LocalPlayer

    if not localPlayer or not (localPlayer.UserId < 0) or runService:IsStudio() then
        return false
    elseif const currentChannel = a8:GetCurrentChannel() then
        local v12 = {}
        Util:SendSystemMessageToSelf(v3:Get("GameChat_SwallowGuestChat_Message", "Create a free account to get access to chat permissions!"), currentChannel, v12)
    end

    return true
end

local v13 = {}
v13[Util.KEY_COMMAND_PROCESSOR_TYPE] = Util.COMPLETED_MESSAGE_PROCESSOR
v13[Util.KEY_PROCESSOR_FUNCTION] = ProcessMessage

return v13