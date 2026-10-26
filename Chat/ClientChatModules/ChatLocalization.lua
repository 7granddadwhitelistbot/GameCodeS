local LocalizationService_upv_1 = game:GetService("LocalizationService")
local Chat_upv_1 = game:GetService("Chat")
local tbl_upv_1 = {}
tbl_upv_1.System = "InGame.Chat.Label.SystemMessagePrefix"
tbl_upv_1.Team = "InGame.Chat.Label.TeamMessagePrefix"
local tbl_upv_2 = {}
tbl_upv_2["From(%s.+)"] = {LocalizationKey = "InGame.Chat.Label.From", English = "From"}
tbl_upv_2["To(%s.+)"] = {LocalizationKey = "InGame.Chat.Label.To", English = "To"}
local tbl_3 = {_hasFetchedLocalization = false}
function tbl_3._getTranslator(a1)
    --[[
      name: _getTranslator
      line: 27
      upvalues:
        Chat_upv_1 (copy, index: 1)
        LocalizationService_upv_1 (copy, index: 2)
    ]]
    if not (a1._translator) and not (a1._hasFetchedLocalization) then
        a1._hasFetchedLocalization = true
        local v1 = Chat_upv_1:WaitForChild("ChatLocalization", 4)
        if v1 then
            a1._translator = v1:GetTranslator(LocalizationService_upv_1.RobloxLocaleId)
            LocalizationService_upv_1:GetPropertyChangedSignal("RobloxLocaleId"):Connect(
                function()
                    --[[
                      line: 35
                      upvalues:
                        a1 (copy, index: 1)
                    ]]
                    a1._hasFetchedLocalization = false
                    a1._translator = nil
                end
            )
        else
            warn("Missing ChatLocalization. Chat interface will not be localized.")
        end
    end
    return a1._translator
end
function tbl_3.Get(a1, a2, a3, a4)
    --[[
      name: Get
      line: 47
    ]]
    local u1 = a3
    pcall(
        function()
            --[[
              line: 49
              upvalues:
                a1 (copy, index: 1)
                u1 (ref,  index: 2)
                a2 (copy, index: 3)
                a4 (copy, index: 4)
            ]]
            local v2 = a1:_getTranslator()
            if v2 then
                u1 = v2:FormatByKey(a2, a4)
            else
                warn("Missing Translator. Used default for", a2)
            end
        end
    )
    return u1
end
function tbl_3.LocalizeFormattedMessage(a1, a2)
    --[[
      name: LocalizeFormattedMessage
      line: 60
    ]]
    local v3, v4 = string.find(a2, "{RBX_LOCALIZATION_KEY}")
    if not v3 then
        return a2
    end
    local v5, v6 = string.find(a2, "{RBX_LOCALIZATION_DEFAULT}")
    if not v5 then
        return a2
    end
    local v7, v8 = string.find(a2, "{RBX_LOCALIZATION_PARAMS}")
    local v9 = string.sub(a2, v4 + 1, v5 - 1)
    if not v7 then
        return a1:Get(v9, string.sub(a2, v6 + 1))
    end
    local v10 = string.sub(a2, v6 + 1, v7 - 1)
    local v11 = string.sub(a2, v8 + 1)
    local tbl_4 = {}
    for key_1, value_1 in string.gmatch(v11, "([^%s]+)=([^%s]+)") do
        tbl_4[key_1] = value_1
    end
    return a1:Get(v9, v10, tbl_4)
end
function tbl_3.FormatMessageToSend(a1, a2, a3, a4, a5)
    --[[
      name: FormatMessageToSend
      line: 89
    ]]
    if a4 and a5 then
        return "{RBX_LOCALIZATION_KEY}" .. a2 .. "{RBX_LOCALIZATION_DEFAULT}" .. a3 .. "{RBX_LOCALIZATION_PARAMS}" .. a4 .. "=" .. a5
    end
    return "{RBX_LOCALIZATION_KEY}" .. a2 .. "{RBX_LOCALIZATION_DEFAULT}" .. a3
end
function tbl_3.tryLocalize(a1, a2)
    --[[
      name: tryLocalize
      line: 100
      upvalues:
        tbl_upv_1 (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
    ]]
    if tbl_upv_1[a2] then
        return a1:Get(tbl_upv_1[a2], a2)
    else
        for key_2, value_2 in pairs(tbl_upv_1) do
            if not (string.find(a2, key_2)) then
                continue
            end
            return string.gsub(a2, key_2, a1:Get(value_2, key_2), 1)
        end
        local v12, v13 = nil, nil
        for key_3, value_3 in pairs(tbl_upv_2) do
            v12 = string.find(a2, key_3)
            v13 = string.match(a2, key_3)
            if not (v12) or not (v13) then
                continue
            end
            local v14 = a1:Get(value_3.LocalizationKey, value_3.English)
            local v15 = ((not (v12 > 1)) and "") or (a2:sub(1, v12 - 1))
            return v15 .. v14 .. v13
        end
        return a2
    end
end
return tbl_3