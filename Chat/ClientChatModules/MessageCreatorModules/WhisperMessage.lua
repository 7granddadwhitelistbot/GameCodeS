local Players_upv_1 = game:GetService("Players")
local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
while not (LocalPlayer_upv_1) do
    Players_upv_1.ChildAdded:wait()
    LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
end
local Parent_1 = script.Parent.Parent
local ChatSettings_upv_1 = require(Parent_1:WaitForChild("ChatSettings"))
local ChatConstants_1 = require(Parent_1:WaitForChild("ChatConstants"))
local Util_upv_1 = require(script.Parent:WaitForChild("Util"))
local u1 = utf8.char(57344)
local ChatLocalization_upv_1 = nil
pcall(
    function()
        --[[
          line: 22
          upvalues:
            ChatLocalization_upv_1 (ref, index: 1)
        ]]
        ChatLocalization_upv_1 = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
    end
)
function IsPlayerVerified(a1)
    --[[
      name: IsPlayerVerified
      line: 24
      upvalues:
        Players_upv_1 (copy, index: 1)
    ]]
    local u2 = Players_upv_1:GetPlayerByUserId(a1)
    if not u2 then
        return false
    end
    local success_1, v1 = pcall(
        function()
            --[[
              line: 31
              upvalues:
                u2 (copy, index: 1)
            ]]
            return u2.HasVerifiedBadge
        end
    )
    if success_1 then
        return v1
    end
    return false
end
function AppendVerifiedBadge(a1)
    --[[
      name: AppendVerifiedBadge
      line: 38
      upvalues:
        u1 (copy, index: 1)
    ]]
    return a1 .. u1
end
function CreateMessageLabel(a1, a2)
    --[[
      name: CreateMessageLabel
      line: 42
      upvalues:
        ChatSettings_upv_1 (copy, index: 1)
        Util_upv_1 (copy, index: 2)
        LocalPlayer_upv_1 (ref,  index: 3)
        ChatLocalization_upv_1 (ref,  index: 4)
    ]]
    local FromSpeaker_1 = a1.FromSpeaker
    local v2
    if (ChatSettings_upv_1.PlayerDisplayNamesEnabled) and (a1.SpeakerDisplayName) then
        v2 = a1.SpeakerDisplayName
    else
        v2 = FromSpeaker_1
    end
    local v3 = IsPlayerVerified(a1.SpeakerUserId)
    v2 = v3 and AppendVerifiedBadge(v2)
    local v4 = a1.ExtraData or {}
    v3 = v4.Font or (ChatSettings_upv_1.DefaultFont)
    local v5 = v4.TextSize or (ChatSettings_upv_1.ChatWindowTextSize)
    local v6 = v4.NameColor or (ChatSettings_upv_1.DefaultNameColor)
    local v7 = v4.ChatColor or (ChatSettings_upv_1.DefaultMessageColor)
    local v8 = v4.ChannelColor or v7
    local v9 = string.format("[%s]:", v2)
    v2 = Util_upv_1:GetStringTextBounds(v9, v3, v5)
    local u3 = Util_upv_1:GetNumberOfSpaces(v9, v3, v5) + 1
    local u4, u5 = Util_upv_1:CreateBaseMessage("", v3, v5, v7)
    local v10 = Util_upv_1:AddNameButtonToBaseMessage(u5, v6, v9, FromSpeaker_1)
    v6 = nil
    if a2 ~= a1.OriginalChannel then
        local v11 = a1.OriginalChannel
        if a1.FromSpeaker == LocalPlayer_upv_1.Name then
            v4 = v11
        else
            v4 = string.format("From %s", a1.FromSpeaker)
        end
        if ChatLocalization_upv_1.tryLocalize then
            v11 = ChatLocalization_upv_1:tryLocalize(v4)
        else
            v11 = v4
        end
        v2 = string.format("{%s}", v11)
        v6 = Util_upv_1:AddChannelButtonToBaseMessage(u5, v8, v2, a1.OriginalChannel)
        v10.Position = UDim2.new(0, v6.Size.X.Offset + Util_upv_1:GetStringTextBounds(" ", v3, v5).X, 0, 0)
        u3 = u3 + Util_upv_1:GetNumberOfSpaces(v2, v3, v5) + 1
    end
    local function UpdateTextFunction(a3)
        --[[
          name: UpdateTextFunction
          line: 92
          upvalues:
            a1 (copy, index: 1)
            u5 (copy, index: 2)
            Util_upv_1 (copy, index: 3)
            u3 (ref,  index: 4)
        ]]
        if a1.IsFiltered then
            u5.Text = Util_upv_1:CreateLeadingSpaces(u3) .. Util_upv_1:SanitizeForRichText(a3.Message)
        else
            u5.Text = Util_upv_1:CreateLeadingSpaces(u3) .. string.rep("_", a3.MessageLengthUtf8 or (a3.MessageLength))
        end
    end
    UpdateTextFunction(a1)
    local tbl_1 = {}
    tbl_1[v10] = {TextTransparency = {FadedOut = 1, FadedIn = 0}, TextStrokeTransparency = {FadedOut = 1, FadedIn = 0.75}}
    tbl_1[u5] = {TextTransparency = {FadedOut = 1, FadedIn = 0}, TextStrokeTransparency = {FadedOut = 1, FadedIn = 0.75}}
    if v6 then
        tbl_1[v6] = {TextTransparency = {FadedOut = 1, FadedIn = 0}, TextStrokeTransparency = {FadedOut = 1, FadedIn = 0.75}}
    end
    local v12, v13, v14 = Util_upv_1:CreateFadeFunctions(tbl_1)
    local tbl_2 = {}
    tbl_2[Util_upv_1.KEY_BASE_FRAME] = u4
    tbl_2[Util_upv_1.KEY_BASE_MESSAGE] = u5
    tbl_2[Util_upv_1.KEY_UPDATE_TEXT_FUNC] = UpdateTextFunction
    tbl_2[Util_upv_1.KEY_GET_HEIGHT] = function(a4)
        --[[
          name: GetHeightFunction
          line: 103
          upvalues:
            Util_upv_1 (copy, index: 1)
            u5 (copy, index: 2)
            u4 (copy, index: 3)
        ]]
        return Util_upv_1:GetMessageHeight(u5, u4, a4)
    end
    tbl_2[Util_upv_1.KEY_FADE_IN] = v12
    tbl_2[Util_upv_1.KEY_FADE_OUT] = v13
    tbl_2[Util_upv_1.KEY_UPDATE_ANIMATION] = v14
    return tbl_2
end
local tbl_3 = {}
tbl_3[Util_upv_1.KEY_MESSAGE_TYPE] = ChatConstants_1.MessageTypeWhisper
tbl_3[Util_upv_1.KEY_CREATOR_FUNCTION] = CreateMessageLabel
return tbl_3