local Util_upv_1 = require(script.Parent:WaitForChild("Util"))
local u1 = nil
pcall(
    function()
        --[[
          line: 10
          upvalues:
            u1 (ref, index: 1)
        ]]
        u1 = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
    end
)
if u1 == nil then
    local tbl_1 = {Get = 0}
    function tbl_1.Get(a1, a2, a3)
        --[[
          name: Get
          line: 11
        ]]
        return a3
    end
    u1 = tbl_1
end
function ProcessMessage(a1, a2, a3)
    --[[
      name: ProcessMessage
      line: 13
      upvalues:
        Util_upv_1 (copy, index: 1)
        u1 (ref,  index: 2)
    ]]
    if string.sub(a1, 1, 3):lower() ~= "/c " then
        return false
    end
    local v1 = string.sub(a1, 4)
    local v2 = a2:GetChannel(v1)
    local v3 = nil
    if v2 then
        a2:SwitchCurrentChannel(v1)
        if not (a3.ShowChannelsBar) and a2:GetCurrentChannel() then
            Util_upv_1:SendSystemMessageToSelf(string.gsub(u1:Get("GameChat_SwitchChannel_NowInChannel", string.format("You are now chatting in channel: '%s'", v1), {RBX_NAME = v1}), "{RBX_NAME}", v1), v2, {})
        end
    else
        v3 = a2:GetCurrentChannel()
        if v3 then
            Util_upv_1:SendSystemMessageToSelf(string.gsub(u1:Get("GameChat_SwitchChannel_NotInChannel", string.format("You are not in channel: '%s'", v1), {RBX_NAME = v1}), "{RBX_NAME}", v1), v3, {ChatColor = Color3.fromRGB(245, 50, 50)})
        end
    end
    return true
end
local tbl_2 = {}
tbl_2[Util_upv_1.KEY_COMMAND_PROCESSOR_TYPE] = Util_upv_1.COMPLETED_MESSAGE_PROCESSOR
tbl_2[Util_upv_1.KEY_PROCESSOR_FUNCTION] = ProcessMessage
return tbl_2