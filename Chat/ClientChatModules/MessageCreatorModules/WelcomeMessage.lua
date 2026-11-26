local parent = script.Parent.Parent
local ChatSettings = require(parent:WaitForChild("ChatSettings"))
local ChatConstants = require(parent:WaitForChild("ChatConstants"))
local Util = require(script.Parent:WaitForChild("Util"))
pcall(
    function()
        --[[
          line: 12
        ]]
        ChatLocalization = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
    end
)

function CreateWelcomeMessageLabel(a5, a6)
    --[[
      name: CreateWelcomeMessageLabel
      line: 14
      upvalues:
        ChatSettings (copy, index: 1)
        Util (copy, index: 2)
    ]]
    local v7
    local v8 = a5.Message

    if ChatLocalization and ChatLocalization.LocalizeFormattedMessage then
        v8 = ChatLocalization:LocalizeFormattedMessage(v8)
    end

    local v9 = a5.ExtraData or {}
    local v10 = v9.Font or ChatSettings.DefaultFont
    local v11 = v9.FontSize or ChatSettings.ChatWindowTextSize
    local v12 = v9.ChatColor or ChatSettings.DefaultMessageColor
    local v13 = v9.ChannelColor or v12
    local baseMessage, v15 = Util:CreateBaseMessage(v8, v10, v11, v12)

    if a6 == a5.OriginalChannel then
        v7 = nil
    else
        local v16 = a5.OriginalChannel

        if ChatLocalization.tryLocalize then
            v16 = ChatLocalization:tryLocalize(a5.OriginalChannel)
        end

        local formattedText = string.format("{%s}", v16)
        v7 = Util:AddChannelButtonToBaseMessage(v15, v13, formattedText, a5.OriginalChannel)
        v15.Text = Util:CreateLeadingSpaces(Util:GetNumberOfSpaces(formattedText, v10, v11) + 1) .. Util:SanitizeForRichText(v8)
    end

    local v18 = {}
    v18[v15] = {TextTransparency = {FadedIn = 0, FadedOut = 1}, TextStrokeTransparency = {FadedIn = 0.75, FadedOut = 1}}

    if v7 then
        v18[v7] = {TextTransparency = {FadedIn = 0, FadedOut = 1}, TextStrokeTransparency = {FadedIn = 0.75, FadedOut = 1}}
    end

    local fadeFunctions, v20, v21 = Util:CreateFadeFunctions(v18)
    local v22 = {}
    v22[Util.KEY_BASE_FRAME] = baseMessage
    v22[Util.KEY_BASE_MESSAGE] = v15
    v22[Util.KEY_UPDATE_TEXT_FUNC] = nil

    v22[Util.KEY_GET_HEIGHT] = function(a23)
        --[[
          name: GetHeightFunction
          line: 39
          upvalues:
            Util (copy, index: 1)
            v15 (copy, index: 2)
            baseMessage (copy, index: 3)
        ]]
        return Util:GetMessageHeight(v15, baseMessage, a23)
    end

    v22[Util.KEY_FADE_IN] = fadeFunctions
    v22[Util.KEY_FADE_OUT] = v20
    v22[Util.KEY_UPDATE_ANIMATION] = v21

    return v22
end

local v24 = {}
v24[Util.KEY_MESSAGE_TYPE] = ChatConstants.MessageTypeWelcome
v24[Util.KEY_CREATOR_FUNCTION] = CreateWelcomeMessageLabel

return v24