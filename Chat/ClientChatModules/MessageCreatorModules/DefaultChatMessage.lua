local success, isUserFeatureEnabled = pcall(
    function()
        --[[
          line: 8
        ]]
        return UserSettings():IsUserFeatureEnabled("UserIsChatTranslationEnabled2")
    end
)
local isUserFeatureEnabled2 = success and isUserFeatureEnabled
local players = game:GetService("Players")
local parent = script.Parent.Parent
local ChatSettings = require(parent:WaitForChild("ChatSettings"))
local ChatConstants = require(parent:WaitForChild("ChatConstants"))
local Util = require(script.Parent:WaitForChild("Util"))
local text = utf8.char(57344)

function IsPlayerVerified(userId)
    --[[
      name: IsPlayerVerified
      line: 23
      upvalues:
        players (copy, index: 1)
    ]]
    local player = players:GetPlayerByUserId(userId)
    if not player then
        return false
    end

    local success, hasVerifiedBadge = pcall(
        function()
            --[[
              line: 30
              upvalues:
                player (copy, index: 1)
            ]]
            return player.HasVerifiedBadge
        end
    )
    if success then
        return hasVerifiedBadge
    end

    return false
end

function AppendVerifiedBadge(a14)
    --[[
      name: AppendVerifiedBadge
      line: 37
      upvalues:
        text (copy, index: 1)
    ]]
    return a14 .. text
end

function CreateMessageLabel(a15, a16, callback)
    --[[
      name: CreateMessageLabel
      line: 41
      upvalues:
        ChatSettings (copy, index: 1)
        Util (copy, index: 2)
        isUserFeatureEnabled2 (ref,  index: 3)
    ]]
    local v18
    local position, v20
    local v21
    local fromSpeaker = a15.FromSpeaker
    local v23 = if ChatSettings.PlayerDisplayNamesEnabled and a15.SpeakerDisplayName then a15.SpeakerDisplayName else fromSpeaker

    if IsPlayerVerified(a15.SpeakerUserId) then
        v23 = AppendVerifiedBadge(v23)
    end

    local _ = a15.Message
    local v25 = a15.ExtraData or {}
    local v26 = v25.Font or ChatSettings.DefaultFont
    local v27 = v25.TextSize or ChatSettings.ChatWindowTextSize
    local v28 = v25.NameColor or ChatSettings.DefaultNameColor
    local v29 = v25.ChatColor or ChatSettings.DefaultMessageColor
    local v30 = v25.ChannelColor or v29
    local v31 = v25.Tags or {}
    local formattedText = string.format("[%s]:", v23)
    Util:GetStringTextBounds(formattedText, v26, v27)
    local v33 = Util:GetNumberOfSpaces(formattedText, v26, v27) + 1
    local baseMessage, v35 = Util:CreateBaseMessage("", v26, v27, v29)
    local v36 = Util:AddNameButtonToBaseMessage(v35, v28, formattedText, fromSpeaker)
    local udim2 = UDim2.new(0, 0, 0, 0)

    if a16 == a15.OriginalChannel then
        v18 = nil
    else
        local formattedText2 = string.format("{%s}", a15.OriginalChannel)
        v18 = Util:AddChannelButtonToBaseMessage(v35, v30, formattedText2, a15.OriginalChannel)
        udim2 = UDim2.new(0, v18.Size.X.Offset + Util:GetStringTextBounds(" ", v26, v27).X, 0, 0)
        v33 = v33 + Util:GetNumberOfSpaces(formattedText2, v26, v27) + 1
    end

    local v39 = {}
    position, v20 = udim2, v33

    for _, v41 in pairs(v31) do
        local v42 = v41.TagColor or Color3.fromRGB(255, 0, 255)
        local tagText = v41.TagText or "???"
        local formattedText3 = string.format("[%s] ", tagText)
        local v45 = Util:AddTagLabelToBaseMessage(v35, v42, formattedText3)
        v45.Position = position
        local numberOfSpaces = Util:GetNumberOfSpaces(formattedText3, v26, v27)
        v20 += numberOfSpaces
        local udim22 = UDim2.new(0, v45.Size.X.Offset, 0, 0)
        position += udim22
        table.insert(v39, v45)
    end

    v36.Position = position
    local v48 = false
    local v49 = nil

    if isUserFeatureEnabled2 then
        pcall(
            function()
                --[[
                  line: 105
                  upvalues:
                    v49 (ref,  index: 1)
                    Util (copy, index: 2)
                    v35 (copy, index: 3)
                    position (ref,  index: 4)
                    v36 (copy, index: 5)
                ]]
                v49 = Util:AddTranslationButtonToBaseMessage(v35)
                position += UDim2.new(0, v36.Size.X.Offset + 2, 0, 0)
                v49.Position = position
            end
        )
    end

    local function useOriginalText(a51)
        --[[
          name: useOriginalText
          line: 112
          upvalues:
            v48 (ref,  index: 1)
            a15 (copy, index: 2)
            v35 (copy, index: 3)
            Util (copy, index: 4)
            v20 (ref,  index: 5)
        ]]
        v48 = false

        if a15.IsFiltered then
            v35.Text = Util:CreateLeadingSpaces(v20) .. Util:SanitizeForRichText(a51.Message)
            return
        end

        local v52 = a51.MessageLengthUtf8 or a51.MessageLength
        v35.Text = Util:CreateLeadingSpaces(v20) .. string.rep("_", v52)
    end

    local function useTranslatedText(a54)
        --[[
          name: useTranslatedText
          line: 122
          upvalues:
            v49 (ref,  index: 1)
            v20 (ref,  index: 2)
            v48 (ref,  index: 3)
            useOriginalText (copy, index: 4)
            v35 (copy, index: 5)
            Util (copy, index: 6)
        ]]
        if v49 == nil then
            return
        end

        if v49.Visible == false then
            v20 += 6
        end

        v49.Visible = true
        v48 = true

        if a54.TranslatedMessage == "" then
            useOriginalText(a54)
            return
        end

        v35.Text = Util:CreateLeadingSpaces(v20) .. Util:SanitizeForRichText(a54.TranslatedMessage)
    end

    local function UpdateTextFunction_Chat(a56)
        --[[
          name: UpdateTextFunction_Chat
          line: 142
          upvalues:
            a15 (copy, index: 1)
            v49 (ref,  index: 2)
            v20 (ref,  index: 3)
            v48 (ref,  index: 4)
            useOriginalText (copy, index: 5)
            v35 (copy, index: 6)
            Util (copy, index: 7)
        ]]
        a15.TranslatedMessage = a56.TranslatedMessage

        if not a56.TranslatedMessage then
            useOriginalText(a56)
            return
        end

        if v49 == nil then
            return
        end

        if v49.Visible == false then
            v20 += 6
        end

        v49.Visible = true
        v48 = true

        if a56.TranslatedMessage == "" then
            useOriginalText(a56)
            return
        end

        v35.Text = Util:CreateLeadingSpaces(v20) .. Util:SanitizeForRichText(a56.TranslatedMessage)
    end

    local function UpdateTextFunction(a58)
        --[[
          name: UpdateTextFunction
          line: 151
          upvalues:
            isUserFeatureEnabled2 (ref,  index: 1)
            a15 (copy, index: 2)
            v49 (ref,  index: 3)
            v20 (ref,  index: 4)
            v48 (ref,  index: 5)
            useOriginalText (copy, index: 6)
            v35 (copy, index: 7)
            Util (copy, index: 8)
        ]]
        if not isUserFeatureEnabled2 then
            if a15.IsFiltered then
                v35.Text = Util:CreateLeadingSpaces(v20) .. Util:SanitizeForRichText(a58.Message)
                return
            end

            local v59 = a58.MessageLengthUtf8 or a58.MessageLength
            v35.Text = Util:CreateLeadingSpaces(v20) .. string.rep("_", v59)

            return
        end

        a15.TranslatedMessage = a58.TranslatedMessage

        if not a58.TranslatedMessage then
            useOriginalText(a58)
            return
        end

        if v49 == nil then
            return
        end

        if v49.Visible == false then
            v20 += 6
        end

        v49.Visible = true
        v48 = true

        if a58.TranslatedMessage == "" then
            useOriginalText(a58)
            return
        end

        v35.Text = Util:CreateLeadingSpaces(v20) .. Util:SanitizeForRichText(a58.TranslatedMessage)
    end

    local function toggleTranslation()
        --[[
          name: toggleTranslation
          line: 164
          upvalues:
            v48 (ref,  index: 1)
            a15 (copy, index: 2)
            v49 (ref,  index: 3)
            v20 (ref,  index: 4)
            useOriginalText (copy, index: 5)
            v35 (copy, index: 6)
            Util (copy, index: 7)
            callback (copy, index: 8)
        ]]
        if v48 or not a15.TranslatedMessage then
            useOriginalText(a15)
        else
            local v61 = a15

            if v49 ~= nil then
                if v49.Visible == false then
                    v20 += 6
                end

                v49.Visible = true
                v48 = true

                if v61.TranslatedMessage ~= "" then
                    v35.Text = Util:CreateLeadingSpaces(v20) .. Util:SanitizeForRichText(v61.TranslatedMessage)
                else
                    useOriginalText(v61)
                end
            end
        end

        if callback then
            callback()
        end
    end

    if isUserFeatureEnabled2 and v49 ~= nil then
        local v62 = v49.MouseButton1Click:connect(
            function()
                --[[
                  line: 176
                  upvalues:
                    v48 (ref,  index: 1)
                    a15 (copy, index: 2)
                    v49 (ref,  index: 3)
                    v20 (ref,  index: 4)
                    useOriginalText (copy, index: 5)
                    v35 (copy, index: 6)
                    Util (copy, index: 7)
                    callback (copy, index: 8)
                ]]
                if v48 or not a15.TranslatedMessage then
                    useOriginalText(a15)
                else
                    local v63 = a15

                    if v49 ~= nil then
                        if v49.Visible == false then
                            v20 += 6
                        end

                        v49.Visible = true
                        v48 = true

                        if v63.TranslatedMessage ~= "" then
                            v35.Text = Util:CreateLeadingSpaces(v20) .. Util:SanitizeForRichText(v63.TranslatedMessage)
                        else
                            useOriginalText(v63)
                        end
                    end
                end

                if callback then
                    callback()
                end
            end
        )

        local v64 = nil

        v64 = v49.Changed:connect(
            function(a65)
                --[[
                  line: 181
                  upvalues:
                    v62 (copy, index: 1)
                    v64 (ref,  index: 2)
                ]]
                if a65 == "Parent" then
                    v62:Disconnect()
                    v64:Disconnect()
                end
            end
        )
    end

    UpdateTextFunction(a15)
    local v66 = {}
    v66[v36] = {TextTransparency = {FadedIn = 0, FadedOut = 1}, TextStrokeTransparency = {FadedIn = 0.75, FadedOut = 1}}

    if isUserFeatureEnabled2 and v49 ~= nil then
        v66[v49] = {ImageTransparency = {FadedIn = 0, FadedOut = 1}}
    end

    v66[v35] = {TextTransparency = {FadedIn = 0, FadedOut = 1}, TextStrokeTransparency = {FadedIn = 0.75, FadedOut = 1}}

    for key, v68 in pairs(v39) do
        string.format("Tag%d", key)
        v66[v68] = {TextTransparency = {FadedIn = 0, FadedOut = 1}, TextStrokeTransparency = {FadedIn = 0.75, FadedOut = 1}}
    end

    if v18 then
        v66[v18] = {TextTransparency = {FadedIn = 0, FadedOut = 1}, TextStrokeTransparency = {FadedIn = 0.75, FadedOut = 1}}
    end

    local fadeFunctions, v70
    fadeFunctions, v70, v21 = Util:CreateFadeFunctions(v66)
    local v71 = {}
    v71[Util.KEY_BASE_FRAME] = baseMessage
    v71[Util.KEY_BASE_MESSAGE] = v35
    v71[Util.KEY_UPDATE_TEXT_FUNC] = UpdateTextFunction

    v71[Util.KEY_GET_HEIGHT] = function(a72)
        --[[
          name: GetHeightFunction
          line: 191
          upvalues:
            Util (copy, index: 1)
            v35 (copy, index: 2)
            baseMessage (copy, index: 3)
        ]]
        return Util:GetMessageHeight(v35, baseMessage, a72)
    end

    v71[Util.KEY_FADE_IN] = fadeFunctions
    v71[Util.KEY_FADE_OUT] = v70
    v71[Util.KEY_UPDATE_ANIMATION] = v21

    return v71
end

local v73 = {}
v73[Util.KEY_MESSAGE_TYPE] = ChatConstants.MessageTypeDefault
v73[Util.KEY_CREATOR_FUNCTION] = CreateMessageLabel

return v73