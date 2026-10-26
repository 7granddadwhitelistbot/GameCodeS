local Parent_1 = script.Parent.Parent
local ChatSettings_upv_1 = require(Parent_1:WaitForChild("ChatSettings"))
local ChatConstants_1 = require(Parent_1:WaitForChild("ChatConstants"))
local Util_upv_1 = require(script.Parent:WaitForChild("Util"))
function CreateSetCoreMessageLabel(a1, a2)
    --[[
      name: CreateSetCoreMessageLabel
      line: 11
      upvalues:
        ChatSettings_upv_1 (copy, index: 1)
        Util_upv_1 (copy, index: 2)
    ]]
    local Message_1 = a1.Message
    local v1 = a1.ExtraData or {}
    local v2 = v1.Font or (ChatSettings_upv_1.DefaultFont)
    local v3 = v1.TextSize or (ChatSettings_upv_1.ChatWindowTextSize)
    local u1, u2 = Util_upv_1:CreateBaseMessage(Message_1, v2, v3, v1.Color or (ChatSettings_upv_1.DefaultMessageColor))
    local v4, v5, v6 = Util_upv_1:CreateFadeFunctions({[u2] = {TextTransparency = {FadedOut = 1, FadedIn = 0}, TextStrokeTransparency = {FadedOut = 1, FadedIn = 0.75}}})
    local tbl_1 = {}
    tbl_1[Util_upv_1.KEY_BASE_FRAME] = u1
    tbl_1[Util_upv_1.KEY_BASE_MESSAGE] = u2
    tbl_1[Util_upv_1.KEY_UPDATE_TEXT_FUNC] = nil
    tbl_1[Util_upv_1.KEY_GET_HEIGHT] = function(a3)
        --[[
          name: GetHeightFunction
          line: 20
          upvalues:
            Util_upv_1 (copy, index: 1)
            u2 (copy, index: 2)
            u1 (copy, index: 3)
        ]]
        return Util_upv_1:GetMessageHeight(u2, u1, a3)
    end
    tbl_1[Util_upv_1.KEY_FADE_IN] = v4
    tbl_1[Util_upv_1.KEY_FADE_OUT] = v5
    tbl_1[Util_upv_1.KEY_UPDATE_ANIMATION] = v6
    return tbl_1
end
local tbl_2 = {}
tbl_2[Util_upv_1.KEY_MESSAGE_TYPE] = ChatConstants_1.MessageTypeSetCore
tbl_2[Util_upv_1.KEY_CREATOR_FUNCTION] = CreateSetCoreMessageLabel
return tbl_2