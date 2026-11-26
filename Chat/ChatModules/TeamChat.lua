local function FormatMessageToSend(a2, a3, a4)
    --[[
      name: FormatMessageToSend
      line: 16
    ]]
    return a4
end

local chat = game:GetService("Chat")
local clientChatModules = chat:WaitForChild("ClientChatModules")
local ChatSettings = require(clientChatModules:WaitForChild("ChatSettings"))
local ChatConstants = require(clientChatModules:WaitForChild("ChatConstants"))
local v9 = nil
pcall(
    function()
        --[[
          line: 13
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
    v9.FormatMessageToSend = FormatMessageToSend
end

local v10 = ChatSettings.ErrorMessageTextColor or Color3.fromRGB(245, 50, 50)
local v11 = {ChatColor = v10}

return function(a12)
    --[[
      name: Run
      line: 22
      upvalues:
        v9 (ref,  index: 1)
        ChatConstants (copy, index: 2)
        v11 (copy, index: 3)
        ChatSettings (copy, index: 4)
    ]]
    local players = game:GetService("Players")
    local v14 = a12:AddChannel("Team")
    v14.WelcomeMessage = v9:FormatMessageToSend("GameChat_TeamChat_WelcomeMessage", "This is a private channel between you and your team members.")
    v14.Joinable = false
    v14.Leavable = false
    v14.AutoJoin = false
    v14.Private = true

    v14:RegisterProcessCommandsFunction(
        "replication_function",
        function(a15, a16, a17)
            --[[
              name: TeamChatReplicationFunction
              line: 33
              upvalues:
                a12 (copy, index: 1)
            ]]
            local speaker = a12:GetSpeaker(a15)
            local channel = a12:GetChannel(a17)

            if speaker and channel then
                if const player = speaker:GetPlayer() then
                    for _, v22 in pairs(channel:GetSpeakerList()) do
                        if const speaker2 = a12:GetSpeaker(v22) then
                            local player2 = speaker2:GetPlayer()

                            if player2 and player.Team == player2.Team then
                                speaker2:SendMessage(a16, a17, a15, {NameColor = player.TeamColor.Color, ChatColor = player.TeamColor.Color, ChannelColor = player.TeamColor.Color})
                            end
                        end
                    end
                end
            end

            return true
        end,
        ChatConstants.LowPriority
    )

    local function DoTeamCommand(a26, text: string, a28)
        --[[
          name: DoTeamCommand
          line: 70
          upvalues:
            a12 (copy, index: 1)
            v9 (ref,  index: 2)
            v11 (copy, index: 3)
        ]]
        if text == nil then
            text = ""
        end

        if const speaker = a12:GetSpeaker(a26) then
            if const player = speaker:GetPlayer() then
                if player.Team == nil then
                    speaker:SendSystemMessage(v9:FormatMessageToSend("GameChat_TeamChat_CannotTeamChatIfNotInTeam", "You cannot team chat if you are not on a team!"), a28, v11)
                    return
                elseif const channel = a12:GetChannel("Team") then
                    if not speaker:IsInChannel(channel.Name) then
                        speaker:JoinChannel(channel.Name)
                    end

                    if text and 0 < string.len(text) then
                        speaker:SayMessage(text, channel.Name)
                    end

                    speaker:SetMainChannel(channel.Name)
                end
            end
        end
    end

    a12:RegisterProcessCommandsFunction(
        "team_commands",
        function(a32, text: string, a34)
            --[[
              name: TeamCommandsFunction
              line: 99
              upvalues:
                DoTeamCommand (copy, index: 1)
            ]]
            if text == nil then
                error("Message is nil")
            end

            if a34 == "Team" then
                return false
            end

            if string.sub(text, 1, 6):lower() == "/team " or text:lower() == "/team" then
                DoTeamCommand(a32, string.sub(text, 7), a34)
                return true
            end

            if string.sub(text, 1, 3):lower() == "/t " or text:lower() == "/t" then
                DoTeamCommand(a32, string.sub(text, 4), a34)
                return true
            end

            if string.sub(text, 1, 2):lower() ~= "% " and text:lower() ~= "%" then
                return false
            end

            DoTeamCommand(a32, string.sub(text, 3), a34)

            return true
        end,
        ChatConstants.StandardPriority
    )

    local function GetDefaultChannelNameColor()
        --[[
          name: GetDefaultChannelNameColor
          line: 126
          upvalues:
            ChatSettings (copy, index: 1)
        ]]
        if ChatSettings.DefaultChannelNameColor then
            return ChatSettings.DefaultChannelNameColor
        end

        return Color3.fromRGB(35, 76, 142)
    end

    local function PutSpeakerInCorrectTeamChatState(speaker, player)
        --[[
          name: PutSpeakerInCorrectTeamChatState
          line: 133
          upvalues:
            v14 (copy, index: 1)
            GetDefaultChannelNameColor (copy, index: 2)
        ]]
        if player.Neutral or player.Team == nil then
            speaker:UpdateChannelNameColor(v14.Name, GetDefaultChannelNameColor())

            if speaker:IsInChannel(v14.Name) then
                speaker:LeaveChannel(v14.Name)
            end
        elseif not player.Neutral and player.Team then
            speaker:UpdateChannelNameColor(v14.Name, player.Team.TeamColor.Color)

            if not speaker:IsInChannel(v14.Name) then
                speaker:JoinChannel(v14.Name)
            end
        end
    end

    a12.SpeakerAdded:connect(
        function(a39)
            --[[
              line: 149
              upvalues:
                a12 (copy, index: 1)
                PutSpeakerInCorrectTeamChatState (copy, index: 2)
            ]]
            if const speaker = a12:GetSpeaker(a39) then
                if const player = speaker:GetPlayer() then
                    PutSpeakerInCorrectTeamChatState(speaker, player)
                end
            end
        end
    )

    local v42 = {}
    players.PlayerAdded:connect(
        function(player: Player)
            --[[
              line: 160
              upvalues:
                a12 (copy, index: 1)
                PutSpeakerInCorrectTeamChatState (copy, index: 2)
                v14 (copy, index: 3)
                v9 (ref,  index: 4)
                v42 (copy, index: 5)
            ]]
            v42[player] = player.Changed:connect(
                function(property: string)
                    --[[
                      line: 161
                      upvalues:
                        a12 (copy, index: 1)
                        player (copy, index: 2)
                        PutSpeakerInCorrectTeamChatState (copy, index: 3)
                        v14 (copy, index: 4)
                        v9 (ref,  index: 5)
                    ]]
                    if const speaker = a12:GetSpeaker(player.Name) then
                        if property == "Neutral" then
                            PutSpeakerInCorrectTeamChatState(speaker, player)
                            return
                        end

                        if property == "Team" then
                            PutSpeakerInCorrectTeamChatState(speaker, player)

                            if speaker:IsInChannel(v14.Name) then
                                speaker:SendSystemMessage(v9:FormatMessageToSend("GameChat_TeamChat_NowInTeam", string.format("You are now on the '%s' team.", player.Team.Name), "RBX_NAME", player.Team.Name), v14.Name)
                            end
                        end
                    end
                end
            )
        end
    )

    players.PlayerRemoving:connect(
        function(player: Player)
            --[[
              line: 182
              upvalues:
                v42 (copy, index: 1)
            ]]
            if const v47 = v42[player] then
                v47:Disconnect()
            end

            v42[player] = nil
        end
    )
end