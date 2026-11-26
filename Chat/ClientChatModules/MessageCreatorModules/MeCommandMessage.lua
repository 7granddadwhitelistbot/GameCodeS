local parent = script.Parent.Parent
local ChatSettings = require(parent:WaitForChild("ChatSettings"))
local ChatConstants = require(parent:WaitForChild("ChatConstants"))
local Util = require(script.Parent:WaitForChild("Util"))

function CreateMeCommandMessageLabel(a5, a6)
    --[[
      name: CreateMeCommandMessageLabel
      line: 11
      upvalues:
        ChatSettings (copy, index: 1)
        Util (copy, index: 2)
    ]]
    local UpdateTextFunction
    local v8, v9
    local _ = a5.Message
    local v11 = a5.ExtraData or {}
    local v12 = v11.Font or Enum.Font.SourceSansItalic
    local v13 = v11.TextSize or ChatSettings.ChatWindowTextSize
    local color3 = Color3.new(1, 1, 1)
    local v15 = v11.ChannelColor or color3
    local v16 = 0
    local baseMessage, v18 = Util:CreateBaseMessage("", v12, v13, color3)

    if a6 == a5.OriginalChannel then
        v8, v9 = v16, nil
    else
        local formattedText = string.format("{%s}", a5.OriginalChannel)
        v9 = Util:AddChannelButtonToBaseMessage(v18, v15, formattedText, a5.OriginalChannel)
        v8 = Util:GetNumberOfSpaces(formattedText, v12, v13) + 1
    end

    UpdateTextFunction = function(a20)
        --[[
          name: UpdateTextFunction
          line: 29
          upvalues:
            a5 (copy, index: 1)
            v18 (copy, index: 2)
            Util (copy, index: 3)
            v8 (ref,  index: 4)
        ]]
        if a5.IsFiltered then
            v18.Text = Util:CreateLeadingSpaces(v8) .. Util:SanitizeForRichText(a20.FromSpeaker .. " " .. string.sub(a20.Message, 5))
            return
        end

        local v21 = a20.MessageLengthUtf8 or a20.MessageLength
        local count = utf8.len(utf8.nfcnormalize(a20.FromSpeaker)) + v21 - 4
        v18.Text = Util:CreateLeadingSpaces(v8) .. string.rep("_", count)
    end

    UpdateTextFunction(a5)
    local v23 = {}
    v23[v18] = {TextTransparency = {FadedIn = 0, FadedOut = 1}, TextStrokeTransparency = {FadedIn = 0.75, FadedOut = 1}}

    if v9 then
        v23[v9] = {TextTransparency = {FadedIn = 0, FadedOut = 1}, TextStrokeTransparency = {FadedIn = 0.75, FadedOut = 1}}
    end

    local fadeFunctions, v25, v26 = Util:CreateFadeFunctions(v23)
    local v27 = {}
    v27[Util.KEY_BASE_FRAME] = baseMessage
    v27[Util.KEY_BASE_MESSAGE] = v18
    v27[Util.KEY_UPDATE_TEXT_FUNC] = UpdateTextFunction

    v27[Util.KEY_GET_HEIGHT] = function(a28)
        --[[
          name: GetHeightFunction
          line: 41
          upvalues:
            Util (copy, index: 1)
            v18 (copy, index: 2)
            baseMessage (copy, index: 3)
        ]]
        return Util:GetMessageHeight(v18, baseMessage, a28)
    end

    v27[Util.KEY_FADE_IN] = fadeFunctions
    v27[Util.KEY_FADE_OUT] = v25
    v27[Util.KEY_UPDATE_ANIMATION] = v26

    return v27
end

local v29 = {}
v29[Util.KEY_MESSAGE_TYPE] = ChatConstants.MessageTypeMeCommand
v29[Util.KEY_CREATOR_FUNCTION] = CreateMeCommandMessageLabel

return v29