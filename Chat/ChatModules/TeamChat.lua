local ClientChatModules_1 = game:GetService("Chat"):WaitForChild("ClientChatModules")
local ChatSettings_upv_1 = require(ClientChatModules_1:WaitForChild("ChatSettings"))
local ChatConstants_upv_1 = require(ClientChatModules_1:WaitForChild("ChatConstants"))
local u1 = nil
pcall(
    function()
        --[[
          line: 13
          upvalues:
            u1 (ref, index: 1)
        ]]
        u1 = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
    end
)
if u1 == nil then
    u1 = {}
end
if not (u1.FormatMessageToSend) or not (u1.LocalizeFormattedMessage) then
    function u1.FormatMessageToSend(a1, a2, a3)
        --[[
          name: FormatMessageToSend
          line: 16
        ]]
        return a3
    end
end
local v1 = ChatSettings_upv_1.ErrorMessageTextColor or (Color3.fromRGB(245, 50, 50))
local tbl_upv_1 = {}
tbl_upv_1.ChatColor = v1
local function Run(a1)
    --[[
      name: Run
      line: 22
      upvalues:
        u1 (ref,  index: 1)
        ChatConstants_upv_1 (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
        ChatSettings_upv_1 (copy, index: 4)
    ]]
    local Players_1 = game:GetService("Players")
    local u2 = a1:AddChannel("Team")
    u2.WelcomeMessage = u1:FormatMessageToSend("GameChat_TeamChat_WelcomeMessage", "This is a private channel between you and your team members.")
    u2.Joinable = false
    u2.Leavable = false
    u2.AutoJoin = false
    u2.Private = true
    local function TeamChatReplicationFunction_1(a2, a3, a4)
        --[[
          name: TeamChatReplicationFunction
          line: 33
          upvalues:
            a1 (copy, index: 1)
        ]]
        local v2 = a1:GetSpeaker(a2)
        local v3 = a1:GetChannel(a4)
        if v2 and v3 then
            local v4 = v2:GetPlayer()
            if v4 then
                for _, value_1 in pairs(v3:GetSpeakerList()) do
                    local v5 = a1:GetSpeaker(value_1)
                    if not (v5) then
                        continue
                    end
                    local v6 = v5:GetPlayer()
                    if not (v6) then
                        continue
                    end
                    if v4.Team == v6.Team then
                        v5:SendMessage(a3, a4, a2, {NameColor = v4.TeamColor.Color, ChatColor = v4.TeamColor.Color, ChannelColor = v4.TeamColor.Color})
                    end
                end
            end
        end
        return true
    end
    u2:RegisterProcessCommandsFunction("replication_function", TeamChatReplicationFunction_1, ChatConstants_upv_1.LowPriority)
    local function DoTeamCommand_upv_1(a5, a6, a7)
        --[[
          name: DoTeamCommand
          line: 70
          upvalues:
            a1 (copy, index: 1)
            u1 (ref,  index: 2)
            tbl_upv_1 (copy, index: 3)
        ]]
        if a6 == nil then
            a6 = ""
        end
        local v7 = a1:GetSpeaker(a5)
        if v7 then
            local v8 = v7:GetPlayer()
            if not v8 then
                return
            end
            if v8.Team ~= nil then
                local v9 = a1:GetChannel("Team")
                if not v9 then
                    return
                end
                if not (v7:IsInChannel(v9.Name)) then
                    v7:JoinChannel(v9.Name)
                end
                if a6 and string.len(a6) > 0 then
                    v7:SayMessage(a6, v9.Name)
                end
                v7:SetMainChannel(v9.Name)
            else
                v7:SendSystemMessage(u1:FormatMessageToSend("GameChat_TeamChat_CannotTeamChatIfNotInTeam", "You cannot team chat if you are not on a team!"), a7, tbl_upv_1)
            end
        end
    end
    local function TeamCommandsFunction_1(a8, a9, a10)
        --[[
          name: TeamCommandsFunction
          line: 99
          upvalues:
            DoTeamCommand_upv_1 (copy, index: 1)
        ]]
        local v10 = false
        if a9 == nil then
            error("Message is nil")
        end
        if a10 ~= "Team" then
            if string.sub(a9, 1, 6):lower() ~= "/team " and a9:lower() ~= "/team" then
                if string.sub(a9, 1, 3):lower() ~= "/t " and a9:lower() ~= "/t" then
                    if string.sub(a9, 1, 2):lower() == "% " or a9:lower() == "%" then
                        DoTeamCommand_upv_1(a8, string.sub(a9, 3), a10)
                        v10 = true
                    end
                    return v10
                end
                DoTeamCommand_upv_1(a8, string.sub(a9, 4), a10)
                return true
            end
            DoTeamCommand_upv_1(a8, string.sub(a9, 7), a10)
            return true
        end
        return false
    end
    a1:RegisterProcessCommandsFunction("team_commands", TeamCommandsFunction_1, ChatConstants_upv_1.StandardPriority)
    local function GetDefaultChannelNameColor_upv_1()
        --[[
          name: GetDefaultChannelNameColor
          line: 126
          upvalues:
            ChatSettings_upv_1 (copy, index: 1)
        ]]
        if ChatSettings_upv_1.DefaultChannelNameColor then
            return ChatSettings_upv_1.DefaultChannelNameColor
        end
        return Color3.fromRGB(35, 76, 142)
    end
    local function PutSpeakerInCorrectTeamChatState_upv_1(a11, a12)
        --[[
          name: PutSpeakerInCorrectTeamChatState
          line: 133
          upvalues:
            u2 (copy, index: 1)
            GetDefaultChannelNameColor_upv_1 (copy, index: 2)
        ]]
        if not (a12.Neutral) and a12.Team ~= nil then
            if not (a12.Neutral) and a12.Team then
                a11:UpdateChannelNameColor(u2.Name, a12.Team.TeamColor.Color)
                if not (a11:IsInChannel(u2.Name)) then
                    a11:JoinChannel(u2.Name)
                end
            end
            return
        end
        a11:UpdateChannelNameColor(u2.Name, GetDefaultChannelNameColor_upv_1())
        if not a11:IsInChannel(u2.Name) then
            return
        end
        a11:LeaveChannel(u2.Name)
    end
    a1.SpeakerAdded:connect(
        function(a13)
            --[[
              line: 149
              upvalues:
                a1 (copy, index: 1)
                PutSpeakerInCorrectTeamChatState_upv_1 (copy, index: 2)
            ]]
            local v11 = a1:GetSpeaker(a13)
            if v11 then
                local v12 = v11:GetPlayer()
                if not v12 then
                    return
                end
                PutSpeakerInCorrectTeamChatState_upv_1(v11, v12)
            end
        end
    )
    local tbl_upv_2 = {}
    Players_1.PlayerAdded:connect(
        function(a14)
            --[[
              line: 160
              upvalues:
                a1 (copy, index: 1)
                PutSpeakerInCorrectTeamChatState_upv_1 (copy, index: 2)
                u2 (copy, index: 3)
                u1 (ref,  index: 4)
                tbl_upv_2 (copy, index: 5)
            ]]
            tbl_upv_2[a14] = a14.Changed:connect(
                function(a15)
                    --[[
                      line: 161
                      upvalues:
                        a1 (copy, index: 1)
                        a14 (copy, index: 2)
                        PutSpeakerInCorrectTeamChatState_upv_1 (copy, index: 3)
                        u2 (copy, index: 4)
                        u1 (ref,  index: 5)
                    ]]
                    local v13 = a1:GetSpeaker(a14.Name)
                    if not v13 then
                        return
                    end
                    if a15 == "Neutral" then
                        PutSpeakerInCorrectTeamChatState_upv_1(v13, a14)
                    elseif a15 == "Team" then
                        PutSpeakerInCorrectTeamChatState_upv_1(v13, a14)
                        if not v13:IsInChannel(u2.Name) then
                            return
                        end
                        v13:SendSystemMessage(u1:FormatMessageToSend("GameChat_TeamChat_NowInTeam", string.format("You are now on the '%s' team.", a14.Team.Name), "RBX_NAME", a14.Team.Name), u2.Name)
                    end
                end
            )
        end
    )
    Players_1.PlayerRemoving:connect(
        function(a16)
            --[[
              line: 182
              upvalues:
                tbl_upv_2 (copy, index: 1)
            ]]
            local v14 = tbl_upv_2[a16]
            if v14 then
                v14:Disconnect()
            end
            tbl_upv_2[a16] = nil
        end
    )
end
return Run