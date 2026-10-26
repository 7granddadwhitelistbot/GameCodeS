local Chat_upv_1 = game:GetService("Chat")
local Players_1 = game:GetService("Players")
local Util_upv_1 = require(script.Parent:WaitForChild("Util"))
local u1 = nil
pcall(
    function()
        --[[
          line: 13
          upvalues:
            u1 (ref,  index: 1)
            Chat_upv_1 (copy, index: 2)
        ]]
        u1 = require(Chat_upv_1.ClientChatModules.ChatLocalization)
    end
)
if u1 == nil then
    local tbl_1 = {Get = 0}
    function tbl_1.Get(a1, a2, a3)
        --[[
          name: Get
          line: 14
        ]]
        return a3
    end
    u1 = tbl_1
end
local LocalPlayer_upv_1 = Players_1.LocalPlayer
local tbl_upv_2 = {laugh = true, wave = true, point = true, dance2 = true, cheer = true, dance3 = true, dance = true}
local tbl_upv_3 = {}
tbl_upv_3["InGame.Chat.Response.EmotesNotSupported"] = "You can't use Emotes here."
tbl_upv_3["InGame.Chat.Response.EmotesWrongAvatarType"] = "Only R15 avatars can use Emotes."
tbl_upv_3["InGame.Chat.ErrorMessageSwitchToR15"] = "Switch to your R15 avatar to play Emote."
tbl_upv_3["InGame.Chat.Response.EmoteNotAvailable"] = "You can't use that Emote."
tbl_upv_3["InGame.Chat.Response.EmotesTemporarilyUnavailable"] = "You can't use Emotes right now."
tbl_upv_3["InGame.Chat.ErrorMessageAnimationPlaying"] = "You cannot play Emotes during this action."
local u2 = Color3.fromRGB(245, 50, 50)
local function getEmoteName(a1)
    --[[
      name: getEmoteName
      line: 48
    ]]
    if string.sub(a1, 1, 3) ~= "/e " then
        if string.sub(a1, 1, 7) ~= "/emote " then
            return nil
        end
        return (string.sub(a1, 8))
    end
    return (string.sub(a1, 4))
end
local function sendErrorMessage(a1, a2)
    --[[
      name: sendErrorMessage
      line: 58
      upvalues:
        u1 (ref,  index: 1)
        tbl_upv_3 (copy, index: 2)
        u2 (copy, index: 3)
        Util_upv_1 (copy, index: 4)
    ]]
    Util_upv_1:SendSystemMessageToSelf(u1:Get(a2, tbl_upv_3[a2]), a1, {ChatColor = u2})
end
local tbl_4 = {}
tbl_4[Util_upv_1.KEY_COMMAND_PROCESSOR_TYPE] = Util_upv_1.COMPLETED_MESSAGE_PROCESSOR
tbl_4[Util_upv_1.KEY_PROCESSOR_FUNCTION] = function(a1, a2, a3)
    --[[
      name: ProcessMessage
      line: 67
      upvalues:
        tbl_upv_2 (copy, index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
        u1 (ref,  index: 3)
        tbl_upv_3 (copy, index: 4)
        u2 (copy, index: 5)
        Util_upv_1 (copy, index: 6)
    ]]
    local v1
    if string.sub(a1, 1, 3) == "/e " then
        v1 = string.sub(a1, 4)
    elseif string.sub(a1, 1, 7) ~= "/emote " then
        v1 = nil
    else
        v1 = string.sub(a1, 8)
    end
    if not v1 then
        return false
    end
    if tbl_upv_2[v1] then
        return true
    end
    local u3 = a2:GetCurrentChannel()
    if not u3 then
        return true
    end
    local Character_1 = LocalPlayer_upv_1.Character
    if Character_1 then
        local Animate_1 = Character_1:FindFirstChild("Animate")
        if Animate_1 and Animate_1:FindFirstChild("PlayEmote") then
            local u4 = Character_1:FindFirstChildOfClass("Humanoid")
            if u4 then
                if u4.RigType == Enum.HumanoidRigType.R15 then
                    local v2 = u4:FindFirstChildOfClass("HumanoidDescription")
                    if v2 then
                        local tbl_5 = {}
                        for key_1, _ in pairs(v2:GetEmotes()) do
                            tbl_5[string.lower(key_1)] = key_1
                        end
                        local num_1 = tonumber(v1)
                        if num_1 then
                            for _, value_1 in pairs(v2:GetEquippedEmotes()) do
                                if value_1.Slot == num_1 then
                                    v1 = value_1.Name
                                end
                            end
                        end
                        local v3 = string.lower(v1)
                        local u5 = tbl_5[v3]
                        if u5 then
                            spawn(
                                function()
                                    --[[
                                      line: 143
                                      upvalues:
                                        u4 (copy, index: 1)
                                        u5 (ref,  index: 2)
                                        u3 (copy, index: 3)
                                        u1 (ref,  index: 4)
                                        tbl_upv_3 (copy, index: 5)
                                        u2 (copy, index: 6)
                                        Util_upv_1 (copy, index: 7)
                                    ]]
                                    local success_1, v4 = pcall(
                                        function()
                                            --[[
                                              line: 144
                                              upvalues:
                                                u4 (copy, index: 1)
                                                u5 (ref,  index: 2)
                                            ]]
                                            return u4:PlayEmote(u5)
                                        end
                                    )
                                    if success_1 then
                                        if not (v4) then
                                            Util_upv_1:SendSystemMessageToSelf(u1:Get("InGame.Chat.Response.EmotesTemporarilyUnavailable", tbl_upv_3["InGame.Chat.Response.EmotesTemporarilyUnavailable"]), u3, {ChatColor = u2})
                                        end
                                    else
                                        Util_upv_1:SendSystemMessageToSelf(u1:Get("InGame.Chat.Response.EmotesNotSupported", tbl_upv_3["InGame.Chat.Response.EmotesNotSupported"]), u3, {ChatColor = u2})
                                    end
                                end
                            )
                        else
                            Util_upv_1:SendSystemMessageToSelf(u1:Get("InGame.Chat.Response.EmoteNotAvailable", tbl_upv_3["InGame.Chat.Response.EmoteNotAvailable"]), u3, {ChatColor = u2})
                        end
                    else
                        Util_upv_1:SendSystemMessageToSelf(u1:Get("InGame.Chat.Response.EmotesTemporarilyUnavailable", tbl_upv_3["InGame.Chat.Response.EmotesTemporarilyUnavailable"]), u3, {ChatColor = u2})
                    end
                else
                    Util_upv_1:SendSystemMessageToSelf(u1:Get("InGame.Chat.Response.EmotesWrongAvatarType", tbl_upv_3["InGame.Chat.Response.EmotesWrongAvatarType"]), u3, {ChatColor = u2})
                end
            else
                Util_upv_1:SendSystemMessageToSelf(u1:Get("InGame.Chat.Response.EmotesTemporarilyUnavailable", tbl_upv_3["InGame.Chat.Response.EmotesTemporarilyUnavailable"]), u3, {ChatColor = u2})
            end
        else
            Util_upv_1:SendSystemMessageToSelf(u1:Get("InGame.Chat.Response.EmotesNotSupported", tbl_upv_3["InGame.Chat.Response.EmotesNotSupported"]), u3, {ChatColor = u2})
        end
    else
        Util_upv_1:SendSystemMessageToSelf(u1:Get("InGame.Chat.Response.EmotesTemporarilyUnavailable", tbl_upv_3["InGame.Chat.Response.EmotesTemporarilyUnavailable"]), u3, {ChatColor = u2})
    end
    return true
end
return tbl_4