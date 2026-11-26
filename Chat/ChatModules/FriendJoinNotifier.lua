local chat = game:GetService("Chat")
local players = game:GetService("Players")
game:GetService("FriendService")
local clientChatModules = chat:WaitForChild("ClientChatModules")
local ChatSettings = require(clientChatModules:WaitForChild("ChatSettings"))
local _ = require(clientChatModules:WaitForChild("ChatConstants"))
local isUserFeatureEnabled = false
local success, isUserFeatureEnabled2 = pcall(
    function()
        --[[
          line: 16
        ]]
        return UserSettings():IsUserFeatureEnabled("UserHandleFriendJoinNotifierOnClient")
    end
)
if success then
    isUserFeatureEnabled = isUserFeatureEnabled2
end

local v9 = nil
pcall(
    function()
        --[[
          line: 26
          upvalues:
            v9 (ref, index: 1)
        ]]
        v9 = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
    end
)

if v9 == nil then
    v9 = {}
end

if not v9.FormatMessageToSend or not v9.LocalizeFormattedMessage then
    function v9.FormatMessageToSend(a10, a11, a12)
        --[[
          name: FormatMessageToSend
          line: 29
        ]]
        return a12
    end
end

local v13 = {ChatColor = Color3.fromRGB(255, 255, 255)}

return function(a14)
    --[[
      name: Run
      line: 35
      upvalues:
        isUserFeatureEnabled (ref,  index: 1)
        ChatSettings (copy, index: 2)
        v9 (ref,  index: 3)
        v13 (copy, index: 4)
        players (copy, index: 5)
    ]]
    local function ShowFriendJoinNotification()
        --[[
          name: ShowFriendJoinNotification
          line: 37
          upvalues:
            isUserFeatureEnabled (ref,  index: 1)
            ChatSettings (copy, index: 2)
        ]]
        if isUserFeatureEnabled == false and ChatSettings.ShowFriendJoinNotification ~= nil then
            return ChatSettings.ShowFriendJoinNotification
        end

        return false
    end

    local function SendFriendJoinNotification(a17, a18)
        --[[
          name: SendFriendJoinNotification
          line: 46
          upvalues:
            a14 (copy, index: 1)
            ChatSettings (copy, index: 2)
            v9 (ref,  index: 3)
            v13 (copy, index: 4)
        ]]
        if const speaker = a14:GetSpeaker(a17.Name) then
            local v20 = a18.Name

            if ChatSettings.PlayerDisplayNamesEnabled then
                v20 = a18.DisplayName
            end

            speaker:SendSystemMessage(v9:FormatMessageToSend("GameChat_FriendChatNotifier_JoinMessage", string.format("Your friend %s has joined the game.", v20), "RBX_NAME", v20), "System", v13)
        end
    end

    local function TrySendFriendNotification(a22, a23)
        --[[
          name: TrySendFriendNotification
          line: 62
          upvalues:
            SendFriendJoinNotification (copy, index: 1)
        ]]
        if a22 ~= a23 then
            coroutine.wrap(
                function()
                    --[[
                      line: 64
                      upvalues:
                        a22 (copy, index: 1)
                        a23 (copy, index: 2)
                        SendFriendJoinNotification (copy, index: 3)
                    ]]
                    if a22:IsFriendsWith(a23.UserId) then
                        SendFriendJoinNotification(a22, a23)
                    end
                end
            )()
        end
    end

    local v24 = if isUserFeatureEnabled == false and ChatSettings.ShowFriendJoinNotification ~= nil then ChatSettings.ShowFriendJoinNotification else false
    if v24 then
        players.PlayerAdded:connect(
            function(player: Player)
                --[[
                  line: 73
                  upvalues:
                    players (copy, index: 1)
                    SendFriendJoinNotification (copy, index: 2)
                ]]
                local players2 = players:GetPlayers()

                for playerKey = 1, #players2 do
                    local player2 = players2[playerKey]

                    if player2 ~= player then
                        coroutine.wrap(
                            function()
                                --[[
                                  line: 64
                                  upvalues:
                                    player2 (copy, index: 1)
                                    player (copy, index: 2)
                                    SendFriendJoinNotification (copy, index: 3)
                                ]]
                                if player2:IsFriendsWith(player.UserId) then
                                    SendFriendJoinNotification(player2, player)
                                end
                            end
                        )()
                    end
                end
            end
        )
    end
end