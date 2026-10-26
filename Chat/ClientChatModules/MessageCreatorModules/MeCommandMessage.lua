local Parent_1 = script.Parent.Parent
local ChatSettings_upv_1 = require(Parent_1:WaitForChild("ChatSettings"))
local ChatConstants_1 = require(Parent_1:WaitForChild("ChatConstants"))
local Util_upv_1 = require(script.Parent:WaitForChild("Util"))
function CreateMeCommandMessageLabel(a1, a2)
    --[[
      name: CreateMeCommandMessageLabel
      line: 11
      upvalues:
        ChatSettings_upv_1 (copy, index: 1)
        Util_upv_1 (copy, index: 2)
    ]]
    local v1 = a1.ExtraData or {}
    local v2 = v1.Font or (Enum.Font.SourceSansItalic)
    local v3 = v1.TextSize or (ChatSettings_upv_1.ChatWindowTextSize)
    local v4 = Color3.new(1, 1, 1)
    local u1 = 0
    local u2, u3 = Util_upv_1:CreateBaseMessage("", v2, v3, v4)
    v4 = nil
    if a2 ~= a1.OriginalChannel then
        local v5 = string.format("{%s}", a1.OriginalChannel)
        v4 = Util_upv_1:AddChannelButtonToBaseMessage(u3, v1.ChannelColor or v4, v5, a1.OriginalChannel)
        u1 = Util_upv_1:GetNumberOfSpaces(v5, v2, v3) + 1
    end
    local function UpdateTextFunction(a3)
        --[[
          name: UpdateTextFunction
          line: 29
          upvalues:
            a1 (copy, index: 1)
            u3 (copy, index: 2)
            Util_upv_1 (copy, index: 3)
            u1 (ref,  index: 4)
        ]]
        if a1.IsFiltered then
            u3.Text = Util_upv_1:CreateLeadingSpaces(u1) .. Util_upv_1:SanitizeForRichText(a3.FromSpeaker .. " " .. string.sub(a3.Message, 5))
        else
            local v6 = utf8.len(utf8.nfcnormalize(a3.FromSpeaker)) + (a3.MessageLengthUtf8 or (a3.MessageLength)) - 4
            u3.Text = Util_upv_1:CreateLeadingSpaces(u1) .. string.rep("_", v6)
        end
    end
    UpdateTextFunction(a1)
    local tbl_1 = {}
    tbl_1[u3] = {TextTransparency = {FadedOut = 1, FadedIn = 0}, TextStrokeTransparency = {FadedOut = 1, FadedIn = 0.75}}
    if v4 then
        tbl_1[v4] = {TextTransparency = {FadedOut = 1, FadedIn = 0}, TextStrokeTransparency = {FadedOut = 1, FadedIn = 0.75}}
    end
    local v7, v8, v9 = Util_upv_1:CreateFadeFunctions(tbl_1)
    local tbl_2 = {}
    tbl_2[Util_upv_1.KEY_BASE_FRAME] = u2
    tbl_2[Util_upv_1.KEY_BASE_MESSAGE] = u3
    tbl_2[Util_upv_1.KEY_UPDATE_TEXT_FUNC] = UpdateTextFunction
    tbl_2[Util_upv_1.KEY_GET_HEIGHT] = function(a4)
        --[[
          name: GetHeightFunction
          line: 41
          upvalues:
            Util_upv_1 (copy, index: 1)
            u3 (copy, index: 2)
            u2 (copy, index: 3)
        ]]
        return Util_upv_1:GetMessageHeight(u3, u2, a4)
    end
    tbl_2[Util_upv_1.KEY_FADE_IN] = v7
    tbl_2[Util_upv_1.KEY_FADE_OUT] = v8
    tbl_2[Util_upv_1.KEY_UPDATE_ANIMATION] = v9
    return tbl_2
end
local tbl_3 = {}
tbl_3[Util_upv_1.KEY_MESSAGE_TYPE] = ChatConstants_1.MessageTypeMeCommand
tbl_3[Util_upv_1.KEY_CREATOR_FUNCTION] = CreateMeCommandMessageLabel
return tbl_3