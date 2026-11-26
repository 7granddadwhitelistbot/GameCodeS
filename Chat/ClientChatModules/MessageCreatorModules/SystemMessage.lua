local parent = script.Parent.Parent
local ChatSettings = require(parent:WaitForChild("ChatSettings"))
local ChatConstants = require(parent:WaitForChild("ChatConstants"))
local Util = require(script.Parent:WaitForChild("Util"))
local ChatLocalization = nil
pcall(
    function()
        --[[
          line: 12
          upvalues:
            ChatLocalization (ref, index: 1)
        ]]
        ChatLocalization = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
    end
)

function CreateSystemMessageLabel(a6, a7)
    --[[
      name: CreateSystemMessageLabel
      line: 14
      upvalues:
        ChatLocalization (ref,  index: 1)
        ChatSettings (copy, index: 2)
        Util (copy, index: 3)
    ]]
    local v8
    local v9 = a6.Message

    if ChatLocalization and ChatLocalization.LocalizeFormattedMessage then
        v9 = ChatLocalization:LocalizeFormattedMessage(v9)
    end

    local v10 = a6.ExtraData or {}
    local v11 = v10.Font or ChatSettings.DefaultFont
    local v12 = v10.TextSize or ChatSettings.ChatWindowTextSize
    local v13 = v10.ChatColor or ChatSettings.DefaultMessageColor
    local v14 = v10.ChannelColor or v13
    local baseMessage, v16 = Util:CreateBaseMessage(v9, v11, v12, v13)
    v16.AutoLocalize = true

    if a7 == a6.OriginalChannel then
        v8 = nil
    else
        local formattedText

        if ChatLocalization and a6.OriginalChannel == "System" then
            local v18 = ChatLocalization:Get("InGame.Chat.Label.SystemMessagePrefix", "System")
            formattedText = string.format("{%s}", v18)
        else
            formattedText = if ChatLocalization and a6.OriginalChannel == "Team" then string.format("{%s}", ChatLocalization:Get("InGame.Chat.Label.TeamMessagePrefix", "System")) else string.format("{%s}", a6.OriginalChannel)
        end

        v8 = Util:AddChannelButtonToBaseMessage(v16, v14, formattedText, a6.OriginalChannel)
        v16.Text = Util:CreateLeadingSpaces(Util:GetNumberOfSpaces(formattedText, v11, v12) + 1) .. Util:SanitizeForRichText(v9)
    end

    local v19 = {}
    v19[v16] = {TextTransparency = {FadedIn = 0, FadedOut = 1}, TextStrokeTransparency = {FadedIn = 0.75, FadedOut = 1}}

    if v8 then
        v19[v8] = {TextTransparency = {FadedIn = 0, FadedOut = 1}, TextStrokeTransparency = {FadedIn = 0.75, FadedOut = 1}}
    end

    local fadeFunctions, v21, v22 = Util:CreateFadeFunctions(v19)
    local v23 = {}
    v23[Util.KEY_BASE_FRAME] = baseMessage
    v23[Util.KEY_BASE_MESSAGE] = v16
    v23[Util.KEY_UPDATE_TEXT_FUNC] = nil

    v23[Util.KEY_GET_HEIGHT] = function(a24)
        --[[
          name: GetHeightFunction
          line: 45
          upvalues:
            Util (copy, index: 1)
            v16 (copy, index: 2)
            baseMessage (copy, index: 3)
        ]]
        return Util:GetMessageHeight(v16, baseMessage, a24)
    end

    v23[Util.KEY_FADE_IN] = fadeFunctions
    v23[Util.KEY_FADE_OUT] = v21
    v23[Util.KEY_UPDATE_ANIMATION] = v22

    return v23
end

local v25 = {}
v25[Util.KEY_MESSAGE_TYPE] = ChatConstants.MessageTypeSystem
v25[Util.KEY_CREATOR_FUNCTION] = CreateSystemMessageLabel

return v25