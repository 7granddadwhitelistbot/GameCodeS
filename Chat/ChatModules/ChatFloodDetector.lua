local success, isUserFeatureEnabled
local chat = game:GetService("Chat")
local clientChatModules = chat:WaitForChild("ClientChatModules")
local ChatConstants = require(clientChatModules:WaitForChild("ChatConstants"))
local isUserFeatureEnabled2 = false
success, isUserFeatureEnabled = pcall(
    function()
        --[[
          line: 11
        ]]
        return UserSettings():IsUserFeatureEnabled("UserAddChatThrottlingToAllChannels")
    end
)

if success then
    isUserFeatureEnabled2 = isUserFeatureEnabled
end

success = true

if isUserFeatureEnabled2 then
    success = false
end

local v7 = {}
local v8 = {}
local v9 = nil
pcall(
    function()
        --[[
          line: 33
          upvalues:
            v9 (ref, index: 1)
        ]]
        v9 = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
    end
)

if v9 == nil then
    v9 = {}
end

if not v9.FormatMessageToSend or not v9.LocalizeFormattedMessage then
    function v9.FormatMessageToSend(a10, a11, a12)
        --[[
          name: FormatMessageToSend
          line: 37
        ]]
        return a12
    end
end

local function EnterTimeIntoLog(a14)
    --[[
      name: EnterTimeIntoLog
      line: 40
    ]]
    table.insert(a14, tick() + 15)
end

return function(a15)
    --[[
      name: Run
      line: 44
      upvalues:
        v8 (copy, index: 1)
        v7 (copy, index: 2)
        success (ref,  index: 3)
        v9 (ref,  index: 4)
        ChatConstants (copy, index: 5)
    ]]
    a15:RegisterProcessCommandsFunction(
        "flood_detection",
        function(key, a17, key2)
            --[[
              name: FloodDetectionProcessCommandsFunction
              line: 45
              upvalues:
                v8 (copy, index: 1)
                a15 (copy, index: 2)
                v7 (copy, index: 3)
                success (ref,  index: 4)
                v9 (ref,  index: 5)
            ]]
            local v19
            local v20

            if v8[key] then
                return false
            end

            local speaker = a15:GetSpeaker(key)
            if not speaker then
                return false
            end
            if not speaker:GetPlayer() then
                return false
            end

            if not v7[key] then
                v7[key] = {}
            end

            if success then
                if not v7[key][key2] then
                    v7[key][key2] = {}
                end

                v19 = v7[key][key2]
            else
                v19 = v7[key]
            end

            local time = tick()

            while 0 < #v19 and v19[1] < time do
                table.remove(v19, 1)
            end

            if #v19 < 7 then
                table.insert(v19, tick() + 15)
                return false
            end

            local ceilingValue = math.ceil(v19[1] - time)
            local v24 = v9
            local stringFormat = string.format

            if not (1 < ceilingValue) then
                v20 = "second"
            else
                v20 = "seconds"
            end

            speaker:SendSystemMessage(v24:FormatMessageToSend("GameChat_ChatFloodDetector_MessageDisplaySeconds", stringFormat("You must wait %d %s before sending another message!", ceilingValue, v20), "RBX_NUMBER", (tostring(ceilingValue))), key2)

            return true
        end,
        ChatConstants.LowPriority
    )

    a15.SpeakerRemoved:connect(
        function(key)
            --[[
              line: 102
              upvalues:
                v7 (copy, index: 1)
            ]]
            v7[key] = nil
        end
    )
end