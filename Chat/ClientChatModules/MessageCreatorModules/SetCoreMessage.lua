local parent = script.Parent.Parent
local ChatSettings = require(parent:WaitForChild("ChatSettings"))
local ChatConstants = require(parent:WaitForChild("ChatConstants"))
local Util = require(script.Parent:WaitForChild("Util"))

function CreateSetCoreMessageLabel(a5, a6)
    --[[
      name: CreateSetCoreMessageLabel
      line: 11
      upvalues:
        ChatSettings (copy, index: 1)
        Util (copy, index: 2)
    ]]
    local message = a5.Message
    local v8 = a5.ExtraData or {}
    local v9 = v8.Font or ChatSettings.DefaultFont
    local v10 = v8.TextSize or ChatSettings.ChatWindowTextSize
    local v11 = v8.Color or ChatSettings.DefaultMessageColor
    local baseMessage, v13 = Util:CreateBaseMessage(message, v9, v10, v11)
    local fadeFunctions, v15, v16 = Util:CreateFadeFunctions({[v13] = {TextTransparency = {FadedIn = 0, FadedOut = 1}, TextStrokeTransparency = {FadedIn = 0.75, FadedOut = 1}}})
    local v17 = {}
    v17[Util.KEY_BASE_FRAME] = baseMessage
    v17[Util.KEY_BASE_MESSAGE] = v13
    v17[Util.KEY_UPDATE_TEXT_FUNC] = nil

    v17[Util.KEY_GET_HEIGHT] = function(a18)
        --[[
          name: GetHeightFunction
          line: 20
          upvalues:
            Util (copy, index: 1)
            v13 (copy, index: 2)
            baseMessage (copy, index: 3)
        ]]
        return Util:GetMessageHeight(v13, baseMessage, a18)
    end

    v17[Util.KEY_FADE_IN] = fadeFunctions
    v17[Util.KEY_FADE_OUT] = v15
    v17[Util.KEY_UPDATE_ANIMATION] = v16

    return v17
end

local v19 = {}
v19[Util.KEY_MESSAGE_TYPE] = ChatConstants.MessageTypeSetCore
v19[Util.KEY_CREATOR_FUNCTION] = CreateSetCoreMessageLabel

return v19