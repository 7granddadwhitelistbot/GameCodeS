local players = game:GetService("Players")
local textChatService = game:GetService("TextChatService")
local Tribes = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Tribes"))
local v4 = {}

local function levelOf(a6)
    --[[
      name: levelOf
      line: 23
    ]]
    local v7 = a6.Character
    v7 = v7
    v7 = v7 and v7:GetAttribute("Level")

    if type(v7) ~= "number" then
        v7 = a6:GetAttribute("Level")
    end

    if type(v7) == "number" and 1 <= v7 then
        return (math.floor(v7))
    end

    return nil
end

function v4.Init(a8)
    --[[
      name: Init
      line: 32
      upvalues:
        players (copy, index: 1)
        Tribes (copy, index: 2)
        textChatService (copy, index: 3)
    ]]
    local v9 = {count = 0}

    local function decorate(a11)
        --[[
          name: decorate
          line: 36
          upvalues:
            players (copy, index: 1)
            Tribes (copy, index: 2)
        ]]
        local v12 = a11.TextSource
        v12 = v12 and players:GetPlayerByUserId(v12.UserId)
        local v13 = v12
        if v13 then
            local character = v12.Character
            local level = character and character:GetAttribute("Level")

            if type(level) ~= "number" then
                level = v12:GetAttribute("Level")
            end

            if type(level) ~= "number" or not (1 <= level) then
                v13 = nil
            else
                v13 = math.floor(level)
            end
        end

        if not v13 then
            return nil
        end

        local textChatMessageProperties = Instance.new("TextChatMessageProperties")
        local tribeTag = v12:GetAttribute("TribeTag")
        local formattedText = ""

        if type(tribeTag) == "string" and tribeTag ~= "" then
            formattedText = string.format("<font color=\"#%s\">[%s]</font> ", Tribes.TextColor(v12:GetAttribute("TribeColor1")):ToHex(), tribeTag)
        end

        textChatMessageProperties.PrefixText = string.format("<font color=\"%s\">[%d]</font> ", "#AEB5C2", v13) .. formattedText .. a11.PrefixText

        return textChatMessageProperties
    end

    local success, result = pcall(
        function()
            --[[
              line: 54
              upvalues:
                textChatService (copy, index: 1)
                decorate (copy, index: 2)
                v9 (copy, index: 3)
            ]]
            textChatService.OnIncomingMessage = function(message: TextChatMessage)
                --[[
                  line: 55
                  upvalues:
                    decorate (copy, index: 1)
                    v9 (copy, index: 2)
                ]]
                local textChatMessageProperties = decorate(message)
                v9.count += 1
                v9.original = message.PrefixText
                v9.prefix = if textChatMessageProperties then textChatMessageProperties.PrefixText else message.PrefixText

                return textChatMessageProperties
            end
        end
    )
    if not success then
        warn("[UI] chat tags: " .. tostring(result))
    end

    a8.Debug.chatTags = function(a23, a24, a25)
        --[[
          line: 67
          upvalues:
            players (copy, index: 1)
            decorate (copy, index: 2)
            success (copy, index: 3)
            v9 (copy, index: 4)
        ]]
        local v26
        local v27

        if a23 ~= "test" then
            return {hooked = success, count = v9.count, prefix = v9.prefix or false, original = v9.original or false}
        end

        local v28 = {}
        local textSource = {}

        if type(a24) ~= "number" then
            v26 = players.LocalPlayer.UserId
        else
            v26 = a24
        end

        textSource.UserId = v26
        v28.TextSource = textSource

        if type(a25) ~= "string" then
            v27 = players.LocalPlayer.DisplayName
        else
            v27 = a25
        end

        v28.PrefixText = v27
        local textChatMessageProperties = decorate(v28)
        local v31 = {changed = textChatMessageProperties ~= nil, prefix = if textChatMessageProperties then textChatMessageProperties.PrefixText else v28.PrefixText}
        return v31
    end
end

return v4