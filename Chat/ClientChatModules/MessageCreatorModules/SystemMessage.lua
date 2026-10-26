local Parent_1 = script.Parent.Parent
local ChatSettings_upv_1 = require(Parent_1:WaitForChild("ChatSettings"))
local ChatConstants_1 = require(Parent_1:WaitForChild("ChatConstants"))
local Util_upv_1 = require(script.Parent:WaitForChild("Util"))
local ChatLocalization_upv_1 = nil
pcall(
    function()
        --[[
          line: 12
          upvalues:
            ChatLocalization_upv_1 (ref, index: 1)
        ]]
        ChatLocalization_upv_1 = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
    end
)
function CreateSystemMessageLabel(a1, a2)
    --[[
      name: CreateSystemMessageLabel
      line: 14
      upvalues:
        ChatLocalization_upv_1 (ref,  index: 1)
        ChatSettings_upv_1 (copy, index: 2)
        Util_upv_1 (copy, index: 3)
    ]]
    local Message_1 = a1.Message
    if ChatLocalization_upv_1 and ChatLocalization_upv_1.LocalizeFormattedMessage then
        Message_1 = ChatLocalization_upv_1:LocalizeFormattedMessage(Message_1)
    end
    local v1 = a1.ExtraData or {}
    local v2 = v1.Font or (ChatSettings_upv_1.DefaultFont)
    local v3 = v1.TextSize or (ChatSettings_upv_1.ChatWindowTextSize)
    local v4 = v1.ChatColor or (ChatSettings_upv_1.DefaultMessageColor)
    local v5 = v1.ChannelColor or v4
    local u1, u2 = Util_upv_1:CreateBaseMessage(Message_1, v2, v3, v4)
    u2.AutoLocalize = true
    local v6 = nil
    if a2 == a1.OriginalChannel then
        v4 = v6
    else
        local v7
        if (ChatLocalization_upv_1) and a1.OriginalChannel == "System" then
            v7 = string.format("{%s}", ChatLocalization_upv_1:Get("InGame.Chat.Label.SystemMessagePrefix", "System"))
        elseif (ChatLocalization_upv_1) and a1.OriginalChannel == "Team" then
            v7 = string.format("{%s}", ChatLocalization_upv_1:Get("InGame.Chat.Label.TeamMessagePrefix", "System"))
        else
            v7 = string.format("{%s}", a1.OriginalChannel)
        end
        v4 = Util_upv_1:AddChannelButtonToBaseMessage(u2, v5, v7, a1.OriginalChannel)
        u2.Text = Util_upv_1:CreateLeadingSpaces(Util_upv_1:GetNumberOfSpaces(v7, v2, v3) + 1) .. Util_upv_1:SanitizeForRichText(Message_1)
    end
    local tbl_1 = {}
    tbl_1[u2] = {TextTransparency = {FadedOut = 1, FadedIn = 0}, TextStrokeTransparency = {FadedOut = 1, FadedIn = 0.75}}
    if v4 then
        tbl_1[v4] = {TextTransparency = {FadedOut = 1, FadedIn = 0}, TextStrokeTransparency = {FadedOut = 1, FadedIn = 0.75}}
    end
    local v8, v9, v10 = Util_upv_1:CreateFadeFunctions(tbl_1)
    local tbl_2 = {}
    tbl_2[Util_upv_1.KEY_BASE_FRAME] = u1
    tbl_2[Util_upv_1.KEY_BASE_MESSAGE] = u2
    tbl_2[Util_upv_1.KEY_UPDATE_TEXT_FUNC] = nil
    tbl_2[Util_upv_1.KEY_GET_HEIGHT] = function(a3)
        --[[
          name: GetHeightFunction
          line: 45
          upvalues:
            Util_upv_1 (copy, index: 1)
            u2 (copy, index: 2)
            u1 (copy, index: 3)
        ]]
        return Util_upv_1:GetMessageHeight(u2, u1, a3)
    end
    tbl_2[Util_upv_1.KEY_FADE_IN] = v8
    tbl_2[Util_upv_1.KEY_FADE_OUT] = v9
    tbl_2[Util_upv_1.KEY_UPDATE_ANIMATION] = v10
    return tbl_2
end
local tbl_3 = {}
tbl_3[Util_upv_1.KEY_MESSAGE_TYPE] = ChatConstants_1.MessageTypeSystem
tbl_3[Util_upv_1.KEY_CREATOR_FUNCTION] = CreateSystemMessageLabel
return tbl_3