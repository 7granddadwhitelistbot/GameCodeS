local Players_upv_1 = game:GetService("Players")
local TextChatService_upv_1 = game:GetService("TextChatService")
local Tribes_upv_1 = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Tribes"))
local tbl_1 = {}
local function levelOf(a1)
    --[[
      name: levelOf
      line: 23
    ]]
    local Character_1 = a1.Character
    local v1 = Character_1 and (Character_1:GetAttribute("Level"))
    if type(v1) ~= "number" then
        v1 = a1:GetAttribute("Level")
    end
    if type(v1) == "number" and v1 >= 1 then
        return (math.floor(v1))
    end
    return nil
end
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 32
      upvalues:
        Players_upv_1 (copy, index: 1)
        TextChatService_upv_1 (copy, index: 3)
    ]]
    local tbl_upv_2 = {count = 0}
    local function decorate(a2)
        --[[
          name: decorate
          line: 36
          upvalues:
            Players_upv_1 (copy, index: 1)
        ]]
        local v2 = a2.TextSource
        local v3 = v2 and (Players_upv_1:GetPlayerByUserId(v2.UserId))
        v2 = v3
        if v2 then
            local Character_2 = v3.Character
            local v4 = Character_2 and (Character_2:GetAttribute("Level"))
            if type(v4) ~= "number" then
                v4 = v2:GetAttribute("Level")
            end
            if type(v4) == "number" and (v4 >= 1) then
                v2 = math.floor(v4)
            else
                v2 = nil
            end
        end
        if not v2 then
            return nil
        end
        local v5 = Instance.new("TextChatMessageProperties")
        local v6 = v2:GetAttribute("TribeTag")
        local v7 = ""
        if type(v6) == "string" and v6 ~= "" then
            v7 = string.format("<font color=\"#%s\">[%s]</font> ", Tribes_upv_1.TextColor(v2:GetAttribute("TribeColor1")):ToHex(), v6)
        end
        v5.PrefixText = string.format("<font color=\"%s\">[%d]</font> ", "#AEB5C2", v2) .. v7 .. a2.PrefixText
        return v5
    end
    local success_upv_1, v8 = pcall(
        function()
            --[[
              line: 54
              upvalues:
                TextChatService_upv_1 (copy, index: 1)
                decorate (copy, index: 2)
                tbl_upv_2 (copy, index: 3)
            ]]
            TextChatService_upv_1.OnIncomingMessage = function(a3)
                --[[
                  line: 55
                  upvalues:
                    decorate (copy, index: 1)
                    tbl_upv_2 (copy, index: 2)
                ]]
                local v9 = decorate(a3)
                tbl_upv_2.count = tbl_upv_2.count + 1
                tbl_upv_2.original = a3.PrefixText
                local v10
                if v9 then
                    v10 = v9.PrefixText
                else
                    v10 = a3.PrefixText
                end
                tbl_upv_2.prefix = v10
                return v9
            end
        end
    )
    if not (success_upv_1) then
        warn("[UI] chat tags: " .. tostring(v8))
    end
    a1.Debug.chatTags = function(a4, a5, a6)
        --[[
          line: 67
          upvalues:
            Players_upv_1 (copy, index: 1)
            decorate (copy, index: 2)
            success_upv_1 (copy, index: 3)
            tbl_upv_2 (copy, index: 4)
        ]]
        if a4 ~= "test" then
            local tbl_3 = {}
            tbl_3.hooked = success_upv_1
            tbl_3.count = tbl_upv_2.count
            tbl_3.prefix = tbl_upv_2.prefix or false
            tbl_3.original = tbl_upv_2.original or false
            return tbl_3
        else
            local tbl_4 = {TextSource = 0, PrefixText = 0}
            local tbl_5 = {UserId = 0}
            local v11
            if type(a5) ~= "number" then
                v11 = Players_upv_1.LocalPlayer.UserId
            else
                v11 = a5
            end
            tbl_5.UserId = v11
            tbl_4.TextSource = tbl_5
            local v12
            if type(a6) ~= "string" then
                v12 = Players_upv_1.LocalPlayer.DisplayName
            else
                v12 = a6
            end
            tbl_4.PrefixText = v12
            local v13 = decorate(tbl_4)
            local tbl_6 = {prefix = 0, changed = 0}
            tbl_6.changed = v13 ~= nil
            local v14
            if v13 then
                v14 = v13.PrefixText
            else
                v14 = tbl_4.PrefixText
            end
            tbl_6.prefix = v14
            return tbl_6
        end
    end
end
return tbl_1