local Chat_1 = game:GetService("Chat")
local Players_upv_1 = game:GetService("Players")
local _ = game:GetService("FriendService")
local ClientChatModules_1 = Chat_1:WaitForChild("ClientChatModules")
local ChatSettings_upv_1 = require(ClientChatModules_1:WaitForChild("ChatSettings"))
local v1 = require(ClientChatModules_1:WaitForChild("ChatConstants"))
local u1 = false
local success_1, v2 = pcall(
    function()
        --[[
          line: 16
        ]]
        return UserSettings():IsUserFeatureEnabled("UserHandleFriendJoinNotifierOnClient")
    end
)
if success_1 then

end
local u2 = nil
pcall(
    function()
        --[[
          line: 26
          upvalues:
            u2 (ref, index: 1)
        ]]
        u2 = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
    end
)
if u2 == nil then
    u2 = {}
end
if not (u2.FormatMessageToSend) or not (u2.LocalizeFormattedMessage) then
    function u2.FormatMessageToSend(a1, a2, a3)
        --[[
          name: FormatMessageToSend
          line: 29
        ]]
        return a3
    end
end
local tbl_upv_1 = {}
tbl_upv_1.ChatColor = Color3.fromRGB(255, 255, 255)
local function Run(a1)
    --[[
      name: Run
      line: 35
      upvalues:
        u1 (ref,  index: 1)
        ChatSettings_upv_1 (copy, index: 2)
        u2 (ref,  index: 3)
        Players_upv_1 (copy, index: 5)
    ]]
    local function ShowFriendJoinNotification_1()
        --[[
          name: ShowFriendJoinNotification
          line: 37
          upvalues:
            u1 (ref,  index: 1)
            ChatSettings_upv_1 (copy, index: 2)
        ]]
        if u1 == false and ChatSettings_upv_1.ShowFriendJoinNotification ~= nil then
            return ChatSettings_upv_1.ShowFriendJoinNotification
        end
        return false
    end
    local function SendFriendJoinNotification_upv_1(a2, a3)
        --[[
          name: SendFriendJoinNotification
          line: 46
          upvalues:
            a1 (copy, index: 1)
            ChatSettings_upv_1 (copy, index: 2)
            u2 (ref,  index: 3)
        ]]
        local v1 = a1:GetSpeaker(a2.Name)
        if v1 then
            local v2 = a3.Name
            if ChatSettings_upv_1.PlayerDisplayNamesEnabled then
                v2 = a3.DisplayName
            end
            v1:SendSystemMessage(u2:FormatMessageToSend("GameChat_FriendChatNotifier_JoinMessage", string.format("Your friend %s has joined the game.", v2), "RBX_NAME", v2), "System", tbl_upv_1)
        end
    end
    local function TrySendFriendNotification_1(a4, a5)
        --[[
          name: TrySendFriendNotification
          line: 62
        ]]
        if a4 == a5 then
            return
        end
        coroutine.wrap(function() end)()
    end
    local v3
    if u1 ~= false or ChatSettings_upv_1.ShowFriendJoinNotification == nil then
        v3 = false
    else
        v3 = ChatSettings_upv_1.ShowFriendJoinNotification
    end
    if not v3 then
        return
    end
    Players_upv_1.PlayerAdded:connect(
        function(a6)
            --[[
              line: 73
              upvalues:
                Players_upv_1 (copy, index: 1)
                SendFriendJoinNotification_upv_1 (copy, index: 2)
            ]]
            local v4 = Players_upv_1:GetPlayers()
            for n_1 = 1, #v4 do
                local u3 = v4[n_1]
                if u3 ~= a6 then
                    coroutine.wrap(
                        function()
                            --[[
                              line: 64
                              upvalues:
                                u3 (copy, index: 1)
                                a6 (copy, index: 2)
                                SendFriendJoinNotification_upv_1 (copy, index: 3)
                            ]]
                            if not u3:IsFriendsWith(a6.UserId) then
                                return
                            end
                            SendFriendJoinNotification_upv_1(u3, a6)
                        end
                    )()
                end
            end
        end
    )
end
return Run