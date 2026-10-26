local Players_upv_1 = game:GetService("Players")
local ChatSettings_upv_1 = require(game:GetService("Chat"):WaitForChild("ClientChatModules"):WaitForChild("ChatSettings"))
local tbl_upv_1 = {NoMatches = 2, MultipleMatches = 3, ChattingToSelf = 1}
local tbl_2 = {}
tbl_2.CommandErrorCodes = tbl_upv_1
function tbl_2.getUserNameFromChattedName(a1, a2, a3)
    --[[
      name: getUserNameFromChattedName
      line: 14
      upvalues:
        tbl_upv_1 (copy, index: 1)
        Players_upv_1 (copy, index: 2)
        ChatSettings_upv_1 (copy, index: 3)
    ]]
    if a2 == a1 then
        return a2, tbl_upv_1.ChattingToSelf
    end
    local v1 = Players_upv_1:GetPlayers()
    for _, value_1 in pairs(v1) do
        if string.lower(value_1.Name) ~= string.lower(a1) then
            continue
        end
        return value_1.Name, nil
    end
    local v2 = 0
    local v3 = nil
    local v4, v5
    if ChatSettings_upv_1.PlayerDisplayNamesEnabled then
        v4, v5 = v2, v3
        for _, value_2 in pairs(v1) do
            if value_2.Name == a2 then
                continue
            end
            if string.lower(value_2.DisplayName) == string.lower(a1) then
                v4, v5 = v4 + 1, value_2.Name
            end
        end
    else
        v4, v5 = v2, v3
    end
    if v4 == 1 then
        return v5, nil
    elseif v4 == 0 then
        if a3 ~= a1 then
            return a1, tbl_upv_1.NoMatches
        end
        return a3, tbl_upv_1.ChattingToSelf
    elseif v4 >= 2 then
        return a1, tbl_upv_1.MultipleMatches
    end
end
function tbl_2.getUsersWithDisplayNameString(a1, a2)
    --[[
      name: getUsersWithDisplayNameString
      line: 56
      upvalues:
        Players_upv_1 (copy, index: 1)
    ]]
    local tbl_3 = {}
    local v6 = ""
    for _, value_3 in pairs(Players_upv_1:GetPlayers()) do
        if value_3.Name == a2 then
            continue
        end
        if string.lower(value_3.DisplayName) == string.lower(a1) then
            table.insert(tbl_3, value_3.Name)
        end
    end
    for key_1, value_4 in pairs(tbl_3) do
        v6 = ((key_1 == #tbl_3) and (v6 .. "@" .. value_4)) or (v6 .. "@" .. value_4 .. ", ")
    end
    return v6
end
return tbl_2