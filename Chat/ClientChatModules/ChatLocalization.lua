local localizationService = game:GetService("LocalizationService")
local chat = game:GetService("Chat")
local v3 = {System = "InGame.Chat.Label.SystemMessagePrefix", Team = "InGame.Chat.Label.TeamMessagePrefix"}
local v4 = {["From(%s.+)"] = {English = "From", LocalizationKey = "InGame.Chat.Label.From"}, ["To(%s.+)"] = {English = "To", LocalizationKey = "InGame.Chat.Label.To"}}

return {
    _hasFetchedLocalization = false,
    _getTranslator = (function(a5)
        --[[
          name: _getTranslator
          line: 27
          upvalues:
            chat (copy, index: 1)
            localizationService (copy, index: 2)
        ]]
        if not a5._translator and not a5._hasFetchedLocalization then
            a5._hasFetchedLocalization = true

            if const chatLocalization = chat:WaitForChild("ChatLocalization", 4) then
                a5._translator = chatLocalization:GetTranslator(localizationService.RobloxLocaleId)

                localizationService:GetPropertyChangedSignal("RobloxLocaleId"):Connect(
                    function()
                        --[[
                          line: 35
                          upvalues:
                            a5 (copy, index: 1)
                        ]]
                        a5._hasFetchedLocalization = false
                        a5._translator = nil
                    end
                )
            else
                warn("Missing ChatLocalization. Chat interface will not be localized.")
            end
        end

        return a5._translator
    end),
    Get = (function(a7, a8, a9, a10)
        --[[
          name: Get
          line: 47
        ]]
        local v11 = a9

        pcall(
            function()
                --[[
                  line: 49
                  upvalues:
                    a7 (copy, index: 1)
                    v11 (ref,  index: 2)
                    a8 (copy, index: 3)
                    a10 (copy, index: 4)
                ]]
                if const translator = a7:_getTranslator() then
                    v11 = translator:FormatByKey(a8, a10)
                    return
                end

                warn("Missing Translator. Used default for", a8)
            end
        )

        return v11
    end),
    LocalizeFormattedMessage = (function(a13, text: string)
        --[[
          name: LocalizeFormattedMessage
          line: 60
        ]]
        local startIndex, endIndex = string.find(text, "{RBX_LOCALIZATION_KEY}")
        if not startIndex then
            return text
        end

        local startIndex2, endIndex2 = string.find(text, "{RBX_LOCALIZATION_DEFAULT}")
        if not startIndex2 then
            return text
        end

        local startIndex3, endIndex3 = string.find(text, "{RBX_LOCALIZATION_PARAMS}")
        local substring = string.sub(text, endIndex + 1, startIndex2 - 1)

        if not startIndex3 then
            return a13:Get(substring, (string.sub(text, endIndex2 + 1)))
        end

        local substring2 = string.sub(text, endIndex2 + 1, startIndex3 - 1)
        local substring3 = string.sub(text, endIndex3 + 1)
        local v24 = {}

        for v25, v26 in string.gmatch(substring3, "([^%s]+)=([^%s]+)") do
            v24[v25] = v26
        end

        return a13:Get(substring, substring2, v24)
    end),
    FormatMessageToSend = (function(a27, a28, a29, a30, a31)
        --[[
          name: FormatMessageToSend
          line: 89
        ]]
        if a30 and a31 then
            return "{RBX_LOCALIZATION_KEY}" .. a28 .. "{RBX_LOCALIZATION_DEFAULT}" .. a29 .. "{RBX_LOCALIZATION_PARAMS}" .. a30 .. "=" .. a31
        end

        return "{RBX_LOCALIZATION_KEY}" .. a28 .. "{RBX_LOCALIZATION_DEFAULT}" .. a29
    end),
    tryLocalize = (function(a32, text: string)
        --[[
          name: tryLocalize
          line: 100
          upvalues:
            v3 (copy, index: 1)
            v4 (copy, index: 2)
        ]]
        if v3[text] then
            return a32:Get(v3[text], text)
        end

        for pattern, v35 in pairs(v3) do
            if string.find(text, pattern) then
                local replacement = a32:Get(v35, pattern)
                return string.gsub(text, pattern, replacement, 1)
            end
        end

        local startIndex, v38

        for pattern, v40 in pairs(v4) do
            startIndex = string.find(text, pattern)
            v38 = string.match(text, pattern)

            if startIndex and v38 then
                local v41 = a32:Get(v40.LocalizationKey, v40.English)
                local v42 = not (1 < startIndex) and "" or text:sub(1, startIndex - 1)

                return v42 .. v41 .. v38
            end
        end

        return text
    end)
}