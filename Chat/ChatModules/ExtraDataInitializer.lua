local tbl_upv_1 = {}
tbl_upv_1.Groups = {{GroupId = 1200769, ChatColor = Color3.new(1, 0.8431372549019608, 0)}}
tbl_upv_1.Players = {{}}
local function MakeIsInGroup(a1, a2)
    --[[
      name: MakeIsInGroup
      line: 23
    ]]
    local v1 = true
    if type(a2) ~= "nil" then
        v1 = type(a2) == "number"
    end
    assert(v1, "requiredRank must be a number or nil")
    return function() end
end
local function ConstructIsInGroups()
    --[[
      name: ConstructIsInGroups
      line: 49
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    if tbl_upv_1.Groups then
        local v2 = nil
        for _, value_1 in pairs(tbl_upv_1.Groups) do
            local GroupId_upv_1 = value_1.GroupId
            local Rank_upv_1 = value_1.Rank
            v2 = true
            if type(Rank_upv_1) ~= "nil" then
                v2 = type(Rank_upv_1) == "number"
            end
            assert(v2, "requiredRank must be a number or nil")
            value_1.IsInGroup = function(a1)
                --[[
                  line: 26
                  upvalues:
                    Rank_upv_1 (copy, index: 1)
                    GroupId_upv_1 (copy, index: 2)
                ]]
                if a1 and a1.UserId then
                    local u1 = false
                    local success_1, v3 = pcall(
                        function()
                            --[[
                              line: 31
                              upvalues:
                                Rank_upv_1 (copy, index: 1)
                                u1 (ref,  index: 2)
                                a1 (copy, index: 3)
                                GroupId_upv_1 (copy, index: 4)
                            ]]
                            if Rank_upv_1 then
                                local v4 = Rank_upv_1 < a1:GetRankInGroup(GroupId_upv_1)
                                u1 = v4
                            else
                                u1 = a1:IsInGroup(GroupId_upv_1)
                            end
                        end
                    )
                    if not (success_1) and v3 then
                        print("Error checking in group: " .. v3)
                    end
                    return u1
                end
                return false
            end
        end
    end
end
ConstructIsInGroups()
local Players_upv_1 = game:GetService("Players")
local function GetSpecialChatColor(a1)
    --[[
      name: GetSpecialChatColor
      line: 60
      upvalues:
        tbl_upv_1 (copy, index: 1)
        Players_upv_1 (copy, index: 2)
    ]]
    local v5 = nil
    if tbl_upv_1.Players then
        v5 = Players_upv_1:FindFirstChild(a1)
        if v5 then
            for _, value_2 in pairs(tbl_upv_1.Players) do
                if v5.UserId ~= value_2.UserId then
                    continue
                end
                return value_2.ChatColor
            end
        end
    end
    if not tbl_upv_1.Groups then
        return
    end
    for _, value_3 in pairs(tbl_upv_1.Groups) do
        if not (value_3.IsInGroup(Players_upv_1:FindFirstChild(a1))) then
            continue
        end
        return value_3.ChatColor
    end
end
local function Run(a1)
    --[[
      name: Run
      line: 80
      upvalues:
        GetSpecialChatColor (copy, index: 1)
        Players_upv_1 (copy, index: 2)
    ]]
    local tbl_upv_2 = {Color3.new(0.9921568627450981, 0.1607843137254902, 0.2627450980392157), Color3.new(0.00392156862745098, 0.6352941176470588, 1), Color3.new(0.00784313725490196, 0.7215686274509804, 0.3411764705882353), BrickColor.new("Bright violet").Color, BrickColor.new("Bright orange").Color, BrickColor.new("Bright yellow").Color, BrickColor.new("Light reddish violet").Color, BrickColor.new("Brick yellow").Color}
    local function GetNameValue_upv_1(a2)
        --[[
          name: GetNameValue
          line: 93
        ]]
        local v6 = 0
        v6 = v6
        for n_1 = 1, #a2 do
            local v7 = string.byte(string.sub(a2, n_1, n_1))
            local v8 = #a2 - n_1 + 1
            if #a2 % 2 == 1 then
                v8 = v8 - 1
            end
            if v8 % 4 >= 2 then
                v7 = -v7
            end
            v6 = v6 + v7
        end
        return v6
    end
    local function ComputeNameColor_1(a3)
        --[[
          name: ComputeNameColor
          line: 110
          upvalues:
            tbl_upv_2 (copy, index: 1)
            GetNameValue_upv_1 (copy, index: 2)
        ]]
        return tbl_upv_2[((GetNameValue_upv_1(a3) + 0) % #tbl_upv_2) + 1]
    end
    local function GetNameColor_1(a4)
        --[[
          name: GetNameColor
          line: 114
          upvalues:
            tbl_upv_2 (copy, index: 1)
            GetNameValue_upv_1 (copy, index: 2)
        ]]
        local v9 = a4:GetPlayer()
        if v9 and v9.Team ~= nil then
            return v9.TeamColor.Color
        end
        return tbl_upv_2[((GetNameValue_upv_1(a4.Name) + 0) % #tbl_upv_2) + 1]
    end
    local function onNewSpeaker_1(a5)
        --[[
          name: onNewSpeaker
          line: 124
          upvalues:
            a1 (copy, index: 1)
            tbl_upv_2 (copy, index: 2)
            GetNameValue_upv_1 (copy, index: 3)
            GetSpecialChatColor (copy, index: 4)
        ]]
        local v10 = a1:GetSpeaker(a5)
        local v11 = v10:GetExtraData("NameColor")
        local v12 = nil
        if not (v11) then
            v12 = v10:GetPlayer()
            local v13
            if (v12) and v12.Team ~= nil then
                v13 = v12.TeamColor.Color
            else
                v13 = tbl_upv_2[((GetNameValue_upv_1(v10.Name) + 0) % #tbl_upv_2) + 1]
            end
            v10:SetExtraData("NameColor", v13)
        end
        if not (v10:GetExtraData("ChatColor")) then
            local v14 = GetSpecialChatColor(a5)
            if v14 then
                v10:SetExtraData("ChatColor", v14)
            end
        end
        if (v10:GetExtraData("Tags")) then
            return
        end
        v10:SetExtraData("Tags", {})
    end
    a1.SpeakerAdded:connect(onNewSpeaker_1)
    for _, value_4 in pairs(a1:GetSpeakerList()) do
        onNewSpeaker_1(value_4)
    end
    local tbl_upv_3 = {}
    Players_upv_1.PlayerAdded:connect(
        function(a6)
            --[[
              line: 161
              upvalues:
                a1 (copy, index: 1)
                tbl_upv_2 (copy, index: 2)
                GetNameValue_upv_1 (copy, index: 3)
                tbl_upv_3 (copy, index: 4)
            ]]
            tbl_upv_3[a6] = a6.Changed:connect(
                function(a7)
                    --[[
                      line: 162
                      upvalues:
                        a1 (copy, index: 1)
                        a6 (copy, index: 2)
                        tbl_upv_2 (copy, index: 3)
                        GetNameValue_upv_1 (copy, index: 4)
                    ]]
                    local v15 = a1:GetSpeaker(a6.Name)
                    if not v15 then
                        return
                    end
                    if a7 == "TeamColor" or a7 == "Neutral" or a7 == "Team" then
                        local v16 = v15:GetPlayer()
                        local v17
                        if (v16) and v16.Team ~= nil then
                            v17 = v16.TeamColor.Color
                        else
                            v17 = tbl_upv_2[((GetNameValue_upv_1(v15.Name) + 0) % #tbl_upv_2) + 1]
                        end
                        v15:SetExtraData("NameColor", v17)
                    end
                end
            )
        end
    )
    Players_upv_1.PlayerRemoving:connect(
        function(a8)
            --[[
              line: 173
              upvalues:
                tbl_upv_3 (copy, index: 1)
            ]]
            local v18 = tbl_upv_3[a8]
            if v18 then
                v18:Disconnect()
            end
            tbl_upv_3[a8] = nil
        end
    )
end
return Run