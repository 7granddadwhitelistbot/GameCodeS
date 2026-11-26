local v1 = {Groups = {{GroupId = 1200769, ChatColor = Color3.new(1, 0.8431372549019608, 0)}}, Players = {{}}}

local function MakeIsInGroup(a3, a4)
    --[[
      name: MakeIsInGroup
      line: 23
    ]]
    assert(((type(a4) == "nil") or (type(a4) == "number")), "requiredRank must be a number or nil")
    return function(a5)
        --[[
          line: 26
          upvalues:
            a4 (copy, index: 1)
            a3 (copy, index: 2)
        ]]
        if not a5 or not a5.UserId then
            return false
        end

        local _ = a5.UserId
        local v7 = false

        local success, result = pcall(
            function()
                --[[
                  line: 31
                  upvalues:
                    a4 (copy, index: 1)
                    v7 (ref,  index: 2)
                    a5 (copy, index: 3)
                    a3 (copy, index: 4)
                ]]
                if a4 then
                    v7 = a4 < a5:GetRankInGroup(a3)
                    return
                end

                v7 = a5:IsInGroup(a3)
            end
        )

        if not success and result then
            print("Error checking in group: " .. result)
        end

        return v7
    end
end

;(function()
    --[[
      name: ConstructIsInGroups
      line: 49
      upvalues:
        v1 (copy, index: 1)
    ]]
    if v1.Groups then
        for _, group in pairs(v1.Groups) do
            local groupId = group.GroupId
            local rank = group.Rank
            local v14 = type(rank) == "nil" or type(rank) == "number"
            assert(v14, "requiredRank must be a number or nil")

            group.IsInGroup = function(instance: Instance?)
                --[[
                  line: 26
                  upvalues:
                    rank (copy, index: 1)
                    groupId (copy, index: 2)
                ]]
                if not instance or not instance.UserId then
                    return false
                end

                local _ = instance.UserId
                local v17 = false

                local success, result = pcall(
                    function()
                        --[[
                          line: 31
                          upvalues:
                            rank (copy, index: 1)
                            v17 (ref,  index: 2)
                            instance (copy, index: 3)
                            groupId (copy, index: 4)
                        ]]
                        if rank then
                            v17 = rank < instance:GetRankInGroup(groupId)
                            return
                        end

                        v17 = instance:IsInGroup(groupId)
                    end
                )

                if not success and result then
                    print("Error checking in group: " .. result)
                end

                return v17
            end
        end
    end
end)()
local players = game:GetService("Players")

local function GetSpecialChatColor(childName)
    --[[
      name: GetSpecialChatColor
      line: 60
      upvalues:
        v1 (copy, index: 1)
        players (copy, index: 2)
    ]]
    if v1.Players then
        if const player = players:FindFirstChild(childName) then
            for _, player2 in pairs(v1.Players) do
                if player.UserId == player2.UserId then
                    return player2.ChatColor
                end
            end
        end
    end

    if v1.Groups then
        for _, group in pairs(v1.Groups) do
            if group.IsInGroup(players:FindFirstChild(childName)) then
                return group.ChatColor
            end
        end
    end
end

return function(a28)
    --[[
      name: Run
      line: 80
      upvalues:
        GetSpecialChatColor (copy, index: 1)
        players (copy, index: 2)
    ]]
    local v29 = {Color3.new(0.9921568627450981, 0.1607843137254902, 0.2627450980392157), Color3.new(0.00392156862745098, 0.6352941176470588, 1), Color3.new(0.00784313725490196, 0.7215686274509804, 0.3411764705882353), BrickColor.new("Bright violet").Color, BrickColor.new("Bright orange").Color, BrickColor.new("Bright yellow").Color, BrickColor.new("Light reddish violet").Color, BrickColor.new("Brick yellow").Color}

    local function GetNameValue(text)
        --[[
          name: GetNameValue
          line: 93
        ]]
        local total = 0

        for index = 1, #text do
            local v34 = string.byte((string.sub(text, index, index)))
            local v35 = #text - index + 1

            if #text % 2 == 1 then
                v35 -= 1
            end

            if 2 <= v35 % 4 then
                v34 = -v34
            end

            total += v34
        end

        return total
    end

    local function ComputeNameColor(text: string)
        --[[
          name: ComputeNameColor
          line: 110
          upvalues:
            v29 (copy, index: 1)
            GetNameValue (copy, index: 2)
        ]]
        return v29[((GetNameValue(text) + 0) % #v29) + 1]
    end

    local function GetNameColor(a39)
        --[[
          name: GetNameColor
          line: 114
          upvalues:
            v29 (copy, index: 1)
            GetNameValue (copy, index: 2)
        ]]
        local player = a39:GetPlayer()

        if player and player.Team ~= nil then
            return player.TeamColor.Color
        end

        return v29[((GetNameValue(a39.Name) + 0) % #v29) + 1]
    end

    local function onNewSpeaker(childName)
        --[[
          name: onNewSpeaker
          line: 124
          upvalues:
            a28 (copy, index: 1)
            v29 (copy, index: 2)
            GetNameValue (copy, index: 3)
            GetSpecialChatColor (copy, index: 4)
        ]]
        local speaker = a28:GetSpeaker(childName)

        if not speaker:GetExtraData("NameColor") then
            local player = speaker:GetPlayer()
            local v45 = if player and player.Team ~= nil then player.TeamColor.Color else v29[((GetNameValue(speaker.Name) + 0) % #v29) + 1]
            speaker:SetExtraData("NameColor", v45)
        end

        if not speaker:GetExtraData("ChatColor") then
            if const specialChatColor = GetSpecialChatColor(childName) then
                speaker:SetExtraData("ChatColor", specialChatColor)
            end
        end

        if not speaker:GetExtraData("Tags") then
            speaker:SetExtraData("Tags", {})
        end
    end

    a28.SpeakerAdded:connect(onNewSpeaker)

    for _, childName in pairs(a28:GetSpeakerList()) do
        onNewSpeaker(childName)
    end

    local v49 = {}
    players.PlayerAdded:connect(
        function(player: Player)
            --[[
              line: 161
              upvalues:
                a28 (copy, index: 1)
                v29 (copy, index: 2)
                GetNameValue (copy, index: 3)
                v49 (copy, index: 4)
            ]]
            v49[player] = player.Changed:connect(
                function(property: string)
                    --[[
                      line: 162
                      upvalues:
                        a28 (copy, index: 1)
                        player (copy, index: 2)
                        v29 (copy, index: 3)
                        GetNameValue (copy, index: 4)
                    ]]
                    local speaker = a28:GetSpeaker(player.Name)

                    if speaker and (property == "TeamColor" or property == "Neutral" or property == "Team") then
                        local player2 = speaker:GetPlayer()
                        local v54 = if player2 and player2.Team ~= nil then player2.TeamColor.Color else v29[((GetNameValue(speaker.Name) + 0) % #v29) + 1]
                        speaker:SetExtraData("NameColor", v54)
                    end
                end
            )
        end
    )

    players.PlayerRemoving:connect(
        function(player: Player)
            --[[
              line: 173
              upvalues:
                v49 (copy, index: 1)
            ]]
            if const v56 = v49[player] then
                v56:Disconnect()
            end

            v49[player] = nil
        end
    )
end