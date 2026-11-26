local Util = require(script.Parent:WaitForChild("Util"))
local v2 = nil
pcall(
    function()
        --[[
          line: 10
          upvalues:
            v2 (ref, index: 1)
        ]]
        v2 = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
    end
)

if v2 == nil then
    v2 = {
        Get = (function(a3, a4, a5)
            --[[
              name: Get
              line: 11
            ]]
            return a5
        end)
    }
end

function ProcessMessage(text: string, a7, a8)
    --[[
      name: ProcessMessage
      line: 13
      upvalues:
        Util (copy, index: 1)
        v2 (ref,  index: 2)
    ]]
    if string.sub(text, 1, 3):lower() ~= "/c " then
        return false
    end

    local rbxName = string.sub(text, 4)

    if const channel = a7:GetChannel(rbxName) then
        a7:SwitchCurrentChannel(rbxName)

        if not a8.ShowChannelsBar and a7:GetCurrentChannel() then
            local stringGsub = string.gsub
            local v12 = v2
            Util:SendSystemMessageToSelf(stringGsub(v12:Get("GameChat_SwitchChannel_NowInChannel", string.format("You are now chatting in channel: '%s'", rbxName), {RBX_NAME = rbxName}), "{RBX_NAME}", rbxName), channel, {})
        end
    elseif const currentChannel = a7:GetCurrentChannel() then
        local stringGsub = string.gsub
        local v15 = v2
        local v16 = {RBX_NAME = rbxName}
        Util:SendSystemMessageToSelf(stringGsub(v15:Get("GameChat_SwitchChannel_NotInChannel", string.format("You are not in channel: '%s'", rbxName), v16), "{RBX_NAME}", rbxName), currentChannel, {ChatColor = Color3.fromRGB(245, 50, 50)})
    end

    return true
end

local v17 = {}
v17[Util.KEY_COMMAND_PROCESSOR_TYPE] = Util.COMPLETED_MESSAGE_PROCESSOR
v17[Util.KEY_PROCESSOR_FUNCTION] = ProcessMessage

return v17