local ChatConstants_upv_1 = require(game:GetService("Chat"):WaitForChild("ClientChatModules"):WaitForChild("ChatConstants"))
local tbl_upv_1 = false
local success_1, v1 = pcall(
    function()
        --[[
          line: 11
        ]]
        return UserSettings():IsUserFeatureEnabled("UserAddChatThrottlingToAllChannels")
    end
)
if success_1 then
    tbl_upv_1 = v1
end
local u1 = true
if tbl_upv_1 then
    tbl_upv_1 = false
end
tbl_upv_1 = {}
local tbl_upv_2 = {}
local u2 = nil
pcall(
    function()
        --[[
          line: 33
          upvalues:
            u2 (ref, index: 1)
        ]]
        u2 = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
    end
)
if u2 == nil then
    u2 = {}
end
if not (u2.FormatMessageToSend) or not (u2.LocalizeFormattedMessage) then
    function u2.FormatMessageToSend(a1, a2, a3)
        --[[
          name: FormatMessageToSend
          line: 37
        ]]
        return a3
    end
end
local function EnterTimeIntoLog(a1)
    --[[
      name: EnterTimeIntoLog
      line: 40
    ]]
    table.insert(a1, tick() + 15)
end
local function Run(a1)
    --[[
      name: Run
      line: 44
      upvalues:
        tbl_upv_2 (copy, index: 1)
        u1 (ref,  index: 3)
        u2 (ref,  index: 4)
        ChatConstants_upv_1 (copy, index: 5)
    ]]
    local function v2(a2, a3, a4)
        --[[
          name: FloodDetectionProcessCommandsFunction
          line: 45
          upvalues:
            tbl_upv_2 (copy, index: 1)
            a1 (copy, index: 2)
            u1 (ref,  index: 4)
            u2 (ref,  index: 5)
        ]]
        if tbl_upv_2[a2] then
            return false
        end
        local v3 = a1:GetSpeaker(a2)
        if not v3 or not v3:GetPlayer() then
            return false
        end
        if not (tbl_upv_1[a2]) then
            tbl_upv_1[a2] = {}
        end
        local v4
        if u1 then
            if not (tbl_upv_1[a2][a4]) then
                tbl_upv_1[a2][a4] = {}
            end
            v4 = tbl_upv_1[a2][a4]
        else
            v4 = tbl_upv_1[a2]
        end
        local time_1 = tick()
        while #v4 > 0 do
            if v4[1] < time_1 then
                table.remove(v4, 1)
                continue
            else
                break
            end
        end
        if #v4 < 7 then
            table.insert(v4, tick() + 15)
            return false
        else
            local v5 = math.ceil(v4[1] - time_1)
            v3:SendSystemMessage(u2:FormatMessageToSend("GameChat_ChatFloodDetector_MessageDisplaySeconds", string.format("You must wait %d %s before sending another message!", v5, ((v5 > 1) and "seconds") or "second"), "RBX_NUMBER", tostring(v5)), a4)
            return true
        end
    end
    a1:RegisterProcessCommandsFunction("flood_detection", v2, ChatConstants_upv_1.LowPriority)
    a1.SpeakerRemoved:connect(
        function(a5)
            --[[
              line: 102
            ]]
            tbl_upv_1[a5] = nil
        end
    )
end
return Run