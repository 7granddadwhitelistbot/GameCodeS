local function Get(a2, a3, a4)
    --[[
      name: Get
      line: 14
    ]]
    return a4
end

local chat = game:GetService("Chat")
local players = game:GetService("Players")
local parent = script.Parent
local childName = "Util"
local child = require(parent:WaitForChild(childName))
local v10 = nil
pcall(
    function()
        --[[
          line: 13
          upvalues:
            v10 (ref,  index: 1)
            chat (copy, index: 2)
        ]]
        v10 = require(chat.ClientChatModules.ChatLocalization)
    end
)

if v10 == nil then
    v10 = {Get = Get}
end

local localPlayer = players.LocalPlayer
local v12 = {wave = true, point = true, dance = true, dance2 = true, dance3 = true, laugh = true, cheer = true}
local v13 = {
    ["InGame.Chat.Response.EmotesNotSupported"] = "You can't use Emotes here.",
    ["InGame.Chat.Response.EmotesWrongAvatarType"] = "Only R15 avatars can use Emotes.",
    ["InGame.Chat.ErrorMessageSwitchToR15"] = "Switch to your R15 avatar to play Emote.",
    ["InGame.Chat.Response.EmoteNotAvailable"] = "You can't use that Emote.",
    ["InGame.Chat.Response.EmotesTemporarilyUnavailable"] = "You can't use Emotes right now.",
    ["InGame.Chat.ErrorMessageAnimationPlaying"] = "You cannot play Emotes during this action."
}
local chatColor = Color3.fromRGB(245, 50, 50)

local function getEmoteName(text: string)
    --[[
      name: getEmoteName
      line: 48
    ]]
    if string.sub(text, 1, 3) == "/e " then
        return (string.sub(text, 4))
    end

    return if string.sub(text, 1, 7) ~= "/emote " then nil else (string.sub(text, 8))
end

local function sendErrorMessage(a18, key)
    --[[
      name: sendErrorMessage
      line: 58
      upvalues:
        v10 (ref,  index: 1)
        v13 (copy, index: 2)
        chatColor (copy, index: 3)
        child (copy, index: 4)
    ]]
    child:SendSystemMessageToSelf(v10:Get(key, v13[key]), a18, {ChatColor = chatColor})
end

local function ProcessMessage(text: string, a22, a23)
    --[[
      name: ProcessMessage
      line: 67
      upvalues:
        v12 (copy, index: 1)
        localPlayer (copy, index: 2)
        v10 (ref,  index: 3)
        v13 (copy, index: 4)
        chatColor (copy, index: 5)
        child (copy, index: 6)
    ]]
    local v24

    if string.sub(text, 1, 3) ~= "/e " then
        if string.sub(text, 1, 7) ~= "/emote " then
            v24 = nil
        else
            v24 = string.sub(text, 8)
        end
    else
        v24 = string.sub(text, 4)
    end

    if not v24 then
        return false
    end
    if v12[v24] then
        return true
    end

    local currentChannel = a22:GetCurrentChannel()
    if not currentChannel then
        return true
    end

    local character = localPlayer.Character
    if not character then
        local v27 = v10
        child:SendSystemMessageToSelf(v27:Get("InGame.Chat.Response.EmotesTemporarilyUnavailable", v13["InGame.Chat.Response.EmotesTemporarilyUnavailable"]), currentChannel, {ChatColor = chatColor})

        return true
    end

    local animate = character:FindFirstChild("Animate")
    if not animate then
        local v29 = v10
        child:SendSystemMessageToSelf(v29:Get("InGame.Chat.Response.EmotesNotSupported", v13["InGame.Chat.Response.EmotesNotSupported"]), currentChannel, {ChatColor = chatColor})

        return true
    end

    if not animate:FindFirstChild("PlayEmote") then
        local v30 = v10
        child:SendSystemMessageToSelf(v30:Get("InGame.Chat.Response.EmotesNotSupported", v13["InGame.Chat.Response.EmotesNotSupported"]), currentChannel, {ChatColor = chatColor})

        return true
    end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then
        local v32 = v10
        child:SendSystemMessageToSelf(v32:Get("InGame.Chat.Response.EmotesTemporarilyUnavailable", v13["InGame.Chat.Response.EmotesTemporarilyUnavailable"]), currentChannel, {ChatColor = chatColor})

        return true
    end

    if humanoid.RigType ~= Enum.HumanoidRigType.R15 then
        local v33 = v10
        child:SendSystemMessageToSelf(v33:Get("InGame.Chat.Response.EmotesWrongAvatarType", v13["InGame.Chat.Response.EmotesWrongAvatarType"]), currentChannel, {ChatColor = chatColor})

        return true
    end

    local humanoidDescription = humanoid:FindFirstChildOfClass("HumanoidDescription")
    if not humanoidDescription then
        local v35 = v10
        child:SendSystemMessageToSelf(v35:Get("InGame.Chat.Response.EmotesTemporarilyUnavailable", v13["InGame.Chat.Response.EmotesTemporarilyUnavailable"]), currentChannel, {ChatColor = chatColor})

        return true
    end

    local emoteNames = {}
    local emotes = humanoidDescription:GetEmotes()

    for text2, _ in pairs(emotes) do
        emoteNames[string.lower(text2)] = text2
    end

    if const number = tonumber(v24) then
        local equippedEmotes = humanoidDescription:GetEquippedEmotes()

        for _, equippedEmote in pairs(equippedEmotes) do
            if equippedEmote.Slot == number then
                v24 = equippedEmote.Name
            end
        end
    end

    local emoteName = emoteNames[string.lower(v24)]
    if not emoteName then
        local v45 = v10
        local v46 = {ChatColor = chatColor}
        child:SendSystemMessageToSelf(v45:Get("InGame.Chat.Response.EmoteNotAvailable", v13["InGame.Chat.Response.EmoteNotAvailable"]), currentChannel, v46)

        return true
    end

    spawn(
        function()
            --[[
              line: 143
              upvalues:
                humanoid (copy, index: 1)
                emoteName (ref,  index: 2)
                currentChannel (copy, index: 3)
                v10 (ref,  index: 4)
                v13 (copy, index: 5)
                chatColor (copy, index: 6)
                child (copy, index: 7)
            ]]
            local success, result = pcall(
                function()
                    --[[
                      line: 144
                      upvalues:
                        humanoid (copy, index: 1)
                        emoteName (ref,  index: 2)
                    ]]
                    return humanoid:PlayEmote(emoteName)
                end
            )

            if success then
                if not result then
                    local v49 = v10
                    local v50 = {ChatColor = chatColor}
                    child:SendSystemMessageToSelf(v49:Get("InGame.Chat.Response.EmotesTemporarilyUnavailable", v13["InGame.Chat.Response.EmotesTemporarilyUnavailable"]), currentChannel, v50)
                end
            else
                local v51 = v10
                child:SendSystemMessageToSelf(v51:Get("InGame.Chat.Response.EmotesNotSupported", v13["InGame.Chat.Response.EmotesNotSupported"]), currentChannel, {ChatColor = chatColor})
            end
        end
    )

    return true
end

local v52 = {}
v52[child.KEY_COMMAND_PROCESSOR_TYPE] = child.COMPLETED_MESSAGE_PROCESSOR
v52[child.KEY_PROCESSOR_FUNCTION] = ProcessMessage

return v52