local success_1, v1 = pcall(
    function()
        --[[
          line: 8
        ]]
        return UserSettings():IsUserFeatureEnabled("UserIsChatTranslationEnabled2")
    end
)
local u1 = success_1 and v1
local Players_upv_1 = game:GetService("Players")
local Parent_1 = script.Parent.Parent
local ChatSettings_upv_1 = require(Parent_1:WaitForChild("ChatSettings"))
local ChatConstants_1 = require(Parent_1:WaitForChild("ChatConstants"))
local Util_upv_1 = require(script.Parent:WaitForChild("Util"))
local u2 = utf8.char(57344)
function IsPlayerVerified(a1)
    --[[
      name: IsPlayerVerified
      line: 23
      upvalues:
        Players_upv_1 (copy, index: 1)
    ]]
    local u3 = Players_upv_1:GetPlayerByUserId(a1)
    if not u3 then
        return false
    end
    local success_2, v2 = pcall(
        function()
            --[[
              line: 30
              upvalues:
                u3 (copy, index: 1)
            ]]
            return u3.HasVerifiedBadge
        end
    )
    if success_2 then
        return v2
    end
    return false
end
function AppendVerifiedBadge(a1)
    --[[
      name: AppendVerifiedBadge
      line: 37
      upvalues:
        u2 (copy, index: 1)
    ]]
    return a1 .. u2
end
function CreateMessageLabel(a1, a2, a3)
    --[[
      name: CreateMessageLabel
      line: 41
      upvalues:
        ChatSettings_upv_1 (copy, index: 1)
        Util_upv_1 (copy, index: 2)
        u1 (ref,  index: 3)
    ]]
    local FromSpeaker_1 = a1.FromSpeaker
    local v3
    if (ChatSettings_upv_1.PlayerDisplayNamesEnabled) and (a1.SpeakerDisplayName) then
        v3 = a1.SpeakerDisplayName
    else
        v3 = FromSpeaker_1
    end
    local v4 = IsPlayerVerified(a1.SpeakerUserId)
    v3 = v4 and AppendVerifiedBadge(v3)
    local v5 = a1.ExtraData or {}
    local v6 = v5.Font or (ChatSettings_upv_1.DefaultFont)
    local v7 = v5.TextSize or (ChatSettings_upv_1.ChatWindowTextSize)
    local v8 = v5.NameColor or (ChatSettings_upv_1.DefaultNameColor)
    local u4 = v5.ChatColor or (ChatSettings_upv_1.DefaultMessageColor)
    local v9 = string.format("[%s]:", v3)
    local _ = Util_upv_1:GetStringTextBounds(v9, v6, v7)
    local u5 = Util_upv_1:GetNumberOfSpaces(v9, v6, v7) + 1
    local u6, u7 = Util_upv_1:CreateBaseMessage("", v6, v7, u4)
    u4 = Util_upv_1:AddNameButtonToBaseMessage(u7, v8, v9, FromSpeaker_1)
    v8 = nil
    local u8 = UDim2.new(0, 0, 0, 0)
    if a2 ~= a1.OriginalChannel then
        local v10 = string.format("{%s}", a1.OriginalChannel)
        v8 = Util_upv_1:AddChannelButtonToBaseMessage(u7, v5.ChannelColor or u4, v10, a1.OriginalChannel)
        local v11 = UDim2.new(0, v8.Size.X.Offset + Util_upv_1:GetStringTextBounds(" ", v6, v7).X, 0, 0)
        u5 = u5 + Util_upv_1:GetNumberOfSpaces(v10, v6, v7) + 1
        u8 = v11
    end
    local tbl_1 = {}
    for v22, value_1 in pairs(v5.Tags or {}) do
        v3 = value_1.TagColor or (Color3.fromRGB(255, 0, 255))
        local v12 = string.format("[%s] ", value_1.TagText or "???")
        local v13 = Util_upv_1:AddTagLabelToBaseMessage(u7, v3, v12)
        v13.Position = u8
        local v14 = Util_upv_1:GetNumberOfSpaces(v12, v6, v7)
        u5 = u5 + v14
        local v15 = UDim2.new(0, v13.Size.X.Offset, 0, 0)
        u8 = u8 + v15
        table.insert(tbl_1, v13)
    end
    u4.Position = u8
    local u9 = false
    local u10 = nil
    if u1 then
        pcall(
            function()
                --[[
                  line: 105
                  upvalues:
                    u10 (ref,  index: 1)
                    Util_upv_1 (copy, index: 2)
                    u7 (copy, index: 3)
                    u8 (ref,  index: 4)
                    u4 (copy, index: 5)
                ]]
                u10 = Util_upv_1:AddTranslationButtonToBaseMessage(u7)
                u8 = u8 + UDim2.new(0, u4.Size.X.Offset + 2, 0, 0)
                u10.Position = u8
            end
        )
    end
    local function useOriginalText(a4)
        --[[
          name: useOriginalText
          line: 112
          upvalues:
            u9 (ref,  index: 1)
            a1 (copy, index: 2)
            u7 (copy, index: 3)
            Util_upv_1 (copy, index: 4)
            u5 (ref,  index: 5)
        ]]
        u9 = false
        if a1.IsFiltered then
            u7.Text = Util_upv_1:CreateLeadingSpaces(u5) .. Util_upv_1:SanitizeForRichText(a4.Message)
        else
            u7.Text = Util_upv_1:CreateLeadingSpaces(u5) .. string.rep("_", a4.MessageLengthUtf8 or (a4.MessageLength))
        end
    end
    local function useTranslatedText(a5)
        --[[
          name: useTranslatedText
          line: 122
          upvalues:
            u10 (ref,  index: 1)
            u5 (ref,  index: 2)
            u9 (ref,  index: 3)
            useOriginalText (copy, index: 4)
            u7 (copy, index: 5)
            Util_upv_1 (copy, index: 6)
        ]]
        if u10 == nil then
            return
        end
        if u10.Visible == false then
            u5 = u5 + 6
        end
        u10.Visible = true
        u9 = true
        if a5.TranslatedMessage ~= "" then
            u7.Text = Util_upv_1:CreateLeadingSpaces(u5) .. Util_upv_1:SanitizeForRichText(a5.TranslatedMessage)
        else
            useOriginalText(a5)
        end
    end
    local function UpdateTextFunction_Chat(a6)
        --[[
          name: UpdateTextFunction_Chat
          line: 142
          upvalues:
            a1 (copy, index: 1)
            u10 (ref,  index: 2)
            u5 (ref,  index: 3)
            u9 (ref,  index: 4)
            useOriginalText (copy, index: 5)
            u7 (copy, index: 6)
            Util_upv_1 (copy, index: 7)
        ]]
        a1.TranslatedMessage = a6.TranslatedMessage
        if a6.TranslatedMessage then
            if u10 == nil then
                return
            end
            if u10.Visible == false then
                u5 = u5 + 6
            end
            u10.Visible = true
            u9 = true
            if a6.TranslatedMessage ~= "" then
                u7.Text = Util_upv_1:CreateLeadingSpaces(u5) .. Util_upv_1:SanitizeForRichText(a6.TranslatedMessage)
            else
                useOriginalText(a6)
            end
        else
            useOriginalText(a6)
        end
    end
    local function UpdateTextFunction(a7)
        --[[
          name: UpdateTextFunction
          line: 151
          upvalues:
            u1 (ref,  index: 1)
            a1 (copy, index: 2)
            u10 (ref,  index: 3)
            u5 (ref,  index: 4)
            u9 (ref,  index: 5)
            useOriginalText (copy, index: 6)
            u7 (copy, index: 7)
            Util_upv_1 (copy, index: 8)
        ]]
        if u1 then
            a1.TranslatedMessage = a7.TranslatedMessage
            if a7.TranslatedMessage then
                if u10 == nil then
                    return
                end
                if u10.Visible == false then
                    u5 = u5 + 6
                end
                u10.Visible = true
                u9 = true
                if a7.TranslatedMessage ~= "" then
                    u7.Text = Util_upv_1:CreateLeadingSpaces(u5) .. Util_upv_1:SanitizeForRichText(a7.TranslatedMessage)
                else
                    useOriginalText(a7)
                end
            else
                useOriginalText(a7)
            end
        elseif a1.IsFiltered then
            u7.Text = Util_upv_1:CreateLeadingSpaces(u5) .. Util_upv_1:SanitizeForRichText(a7.Message)
        else
            u7.Text = Util_upv_1:CreateLeadingSpaces(u5) .. string.rep("_", a7.MessageLengthUtf8 or (a7.MessageLength))
        end
    end
    local function v22()
        --[[
          name: toggleTranslation
          line: 164
          upvalues:
            u9 (ref,  index: 1)
            a1 (copy, index: 2)
            u10 (ref,  index: 3)
            u5 (ref,  index: 4)
            useOriginalText (copy, index: 5)
            u7 (copy, index: 6)
            Util_upv_1 (copy, index: 7)
            a3 (copy, index: 8)
        ]]
        if u9 or not (a1.TranslatedMessage) then
            useOriginalText(a1)
        else
            local v16 = a1
            if u10 ~= nil then
                if u10.Visible == false then
                    u5 = u5 + 6
                end
                u10.Visible = true
                u9 = true
                if v16.TranslatedMessage ~= "" then
                    u7.Text = Util_upv_1:CreateLeadingSpaces(u5) .. Util_upv_1:SanitizeForRichText(v16.TranslatedMessage)
                else
                    useOriginalText(v16)
                end
            end
        end
        if not a3 then
            return
        end
        a3()
    end
    if u1 and u10 ~= nil then
        local u11 = u10.MouseButton1Click:connect(
            function()
                --[[
                  line: 176
                  upvalues:
                    u9 (ref,  index: 1)
                    a1 (copy, index: 2)
                    u10 (ref,  index: 3)
                    u5 (ref,  index: 4)
                    useOriginalText (copy, index: 5)
                    u7 (copy, index: 6)
                    Util_upv_1 (copy, index: 7)
                    a3 (copy, index: 8)
                ]]
                if u9 or not (a1.TranslatedMessage) then
                    useOriginalText(a1)
                else
                    local v17 = a1
                    if u10 ~= nil then
                        if u10.Visible == false then
                            u5 = u5 + 6
                        end
                        u10.Visible = true
                        u9 = true
                        if v17.TranslatedMessage ~= "" then
                            u7.Text = Util_upv_1:CreateLeadingSpaces(u5) .. Util_upv_1:SanitizeForRichText(v17.TranslatedMessage)
                        else
                            useOriginalText(v17)
                        end
                    end
                end
                if not a3 then
                    return
                end
                a3()
            end
        )
        local u12 = nil
        local v18 = u10.Changed:connect(
            function(a8)
                --[[
                  line: 181
                  upvalues:
                    u11 (copy, index: 1)
                    u12 (ref,  index: 2)
                ]]
                if a8 ~= "Parent" then
                    return
                end
                u11:Disconnect()
                u12:Disconnect()
            end
        )
        u12 = v18
    end
    UpdateTextFunction(a1)
    local tbl_2 = {}
    tbl_2[u4] = {TextTransparency = {FadedOut = 1, FadedIn = 0}, TextStrokeTransparency = {FadedOut = 1, FadedIn = 0.75}}
    if u1 and u10 ~= nil then
        tbl_2[u10] = {ImageTransparency = {FadedOut = 1, FadedIn = 0}}
    end
    tbl_2[u7] = {TextTransparency = {FadedOut = 1, FadedIn = 0}, TextStrokeTransparency = {FadedOut = 1, FadedIn = 0.75}}
    for key_1, value_2 in pairs(tbl_1) do
        local v23 = string.format("Tag%d", key_1)
        tbl_2[value_2] = {TextTransparency = {FadedOut = 1, FadedIn = 0}, TextStrokeTransparency = {FadedOut = 1, FadedIn = 0.75}}
    end
    if v8 then
        tbl_2[v8] = {TextTransparency = {FadedOut = 1, FadedIn = 0}, TextStrokeTransparency = {FadedOut = 1, FadedIn = 0.75}}
    end
    local v19, v20, v21 = Util_upv_1:CreateFadeFunctions(tbl_2)
    local tbl_3 = {}
    tbl_3[Util_upv_1.KEY_BASE_FRAME] = u6
    tbl_3[Util_upv_1.KEY_BASE_MESSAGE] = u7
    tbl_3[Util_upv_1.KEY_UPDATE_TEXT_FUNC] = UpdateTextFunction
    tbl_3[Util_upv_1.KEY_GET_HEIGHT] = function(a9)
        --[[
          name: GetHeightFunction
          line: 191
          upvalues:
            Util_upv_1 (copy, index: 1)
            u7 (copy, index: 2)
            u6 (copy, index: 3)
        ]]
        return Util_upv_1:GetMessageHeight(u7, u6, a9)
    end
    tbl_3[Util_upv_1.KEY_FADE_IN] = v19
    tbl_3[Util_upv_1.KEY_FADE_OUT] = v20
    tbl_3[Util_upv_1.KEY_UPDATE_ANIMATION] = v21
    return tbl_3
end
local tbl_4 = {}
tbl_4[Util_upv_1.KEY_MESSAGE_TYPE] = ChatConstants_1.MessageTypeDefault
tbl_4[Util_upv_1.KEY_CREATOR_FUNCTION] = CreateMessageLabel
return tbl_4