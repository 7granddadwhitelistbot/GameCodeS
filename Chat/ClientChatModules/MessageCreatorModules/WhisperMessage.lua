local localPlayer
local players = game:GetService("Players")
localPlayer = players.LocalPlayer

while not localPlayer do
    players.ChildAdded:wait()
    localPlayer = players.LocalPlayer
end

local parent = script.Parent.Parent
local ChatSettings = require(parent:WaitForChild("ChatSettings"))
local ChatConstants = require(parent:WaitForChild("ChatConstants"))
local Util = require(script.Parent:WaitForChild("Util"))
local text = utf8.char(57344)
local ChatLocalization = nil
pcall(
    function()
        --[[
          line: 22
          upvalues:
            ChatLocalization (ref, index: 1)
        ]]
        ChatLocalization = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
    end
)

function IsPlayerVerified(userId)
    --[[
      name: IsPlayerVerified
      line: 24
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
              line: 31
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

function AppendVerifiedBadge(a13)
    --[[
      name: AppendVerifiedBadge
      line: 38
      upvalues:
        text (copy, index: 1)
    ]]
    return a13 .. text
end

function CreateMessageLabel(a14, a15)
    --[[
      name: CreateMessageLabel
      line: 42
      upvalues:
        ChatSettings (copy, index: 1)
        Util (copy, index: 2)
        localPlayer (ref,  index: 3)
        ChatLocalization (ref,  index: 4)
    ]]
    local v16
    local UpdateTextFunction
    local v18
    local fromSpeaker = a14.FromSpeaker
    local v20 = if ChatSettings.PlayerDisplayNamesEnabled and a14.SpeakerDisplayName then a14.SpeakerDisplayName else fromSpeaker

    if IsPlayerVerified(a14.SpeakerUserId) then
        v20 = AppendVerifiedBadge(v20)
    end

    local _ = a14.Message
    local v22 = a14.ExtraData or {}
    local v23 = v22.Font or ChatSettings.DefaultFont
    local v24 = v22.TextSize or ChatSettings.ChatWindowTextSize
    local v25 = v22.NameColor or ChatSettings.DefaultNameColor
    local v26 = v22.ChatColor or ChatSettings.DefaultMessageColor
    local v27 = v22.ChannelColor or v26
    local formattedText = string.format("[%s]:", v20)
    Util:GetStringTextBounds(formattedText, v23, v24)
    local v29 = Util:GetNumberOfSpaces(formattedText, v23, v24) + 1
    local baseMessage, v31 = Util:CreateBaseMessage("", v23, v24, v26)
    local v32 = Util:AddNameButtonToBaseMessage(v31, v25, formattedText, fromSpeaker)

    if a15 == a14.OriginalChannel then
        v18, v16 = v29, nil
    else
        local v33 = a14.OriginalChannel

        if a14.FromSpeaker ~= localPlayer.Name then
            v33 = string.format("From %s", a14.FromSpeaker)
        end

        local v34 = if ChatLocalization.tryLocalize then ChatLocalization:tryLocalize(v33) else v33
        local formattedText2 = string.format("{%s}", v34)
        v16 = Util:AddChannelButtonToBaseMessage(v31, v27, formattedText2, a14.OriginalChannel)
        v32.Position = UDim2.new(0, v16.Size.X.Offset + Util:GetStringTextBounds(" ", v23, v24).X, 0, 0)
        v18 = v29 + Util:GetNumberOfSpaces(formattedText2, v23, v24) + 1
    end

    UpdateTextFunction = function(a36)
        --[[
          name: UpdateTextFunction
          line: 92
          upvalues:
            a14 (copy, index: 1)
            v31 (copy, index: 2)
            Util (copy, index: 3)
            v18 (ref,  index: 4)
        ]]
        if a14.IsFiltered then
            v31.Text = Util:CreateLeadingSpaces(v18) .. Util:SanitizeForRichText(a36.Message)
            return
        end

        local v37 = a36.MessageLengthUtf8 or a36.MessageLength
        v31.Text = Util:CreateLeadingSpaces(v18) .. string.rep("_", v37)
    end

    UpdateTextFunction(a14)
    local v38 = {}
    v38[v32] = {TextTransparency = {FadedIn = 0, FadedOut = 1}, TextStrokeTransparency = {FadedIn = 0.75, FadedOut = 1}}
    v38[v31] = {TextTransparency = {FadedIn = 0, FadedOut = 1}, TextStrokeTransparency = {FadedIn = 0.75, FadedOut = 1}}

    if v16 then
        v38[v16] = {TextTransparency = {FadedIn = 0, FadedOut = 1}, TextStrokeTransparency = {FadedIn = 0.75, FadedOut = 1}}
    end

    local fadeFunctions, v40, v41 = Util:CreateFadeFunctions(v38)
    local v42 = {}
    v42[Util.KEY_BASE_FRAME] = baseMessage
    v42[Util.KEY_BASE_MESSAGE] = v31
    v42[Util.KEY_UPDATE_TEXT_FUNC] = UpdateTextFunction

    v42[Util.KEY_GET_HEIGHT] = function(a43)
        --[[
          name: GetHeightFunction
          line: 103
          upvalues:
            Util (copy, index: 1)
            v31 (copy, index: 2)
            baseMessage (copy, index: 3)
        ]]
        return Util:GetMessageHeight(v31, baseMessage, a43)
    end

    v42[Util.KEY_FADE_IN] = fadeFunctions
    v42[Util.KEY_FADE_OUT] = v40
    v42[Util.KEY_UPDATE_ANIMATION] = v41

    return v42
end

local v44 = {}
v44[Util.KEY_MESSAGE_TYPE] = ChatConstants.MessageTypeWhisper
v44[Util.KEY_CREATOR_FUNCTION] = CreateMessageLabel

return v44