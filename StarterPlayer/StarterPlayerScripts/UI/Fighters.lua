local Players_upv_1 = game:GetService("Players")
local CollectionService_1 = game:GetService("CollectionService")
local tbl_upv_1 = {}
tbl_upv_1.Added = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Signal")).new()
tbl_upv_1.TAGS = {"Combatant", "Bot"}
local tbl_upv_2 = {}
local tbl_upv_3 = {}
local tbl_upv_4 = {}
local function idOf(a1)
    --[[
      name: idOf
      line: 23
      upvalues:
        Players_upv_1 (copy, index: 1)
    ]]
    local v1 = a1:GetAttribute("CombatantId")
    if type(v1) == "string" and v1 ~= "" then
        return v1
    end
    local v2 = Players_upv_1:GetPlayerFromCharacter(a1)
    if v2 then
        return "p" .. v2.UserId
    end
    return nil
end
local function index(a1)
    --[[
      name: index
      line: 32
      upvalues:
        Players_upv_1 (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
    ]]
    local v3 = a1:GetAttribute("CombatantId")
    local v4
    if type(v3) ~= "string" or v3 == "" then
        local v5 = Players_upv_1:GetPlayerFromCharacter(a1)
        v4 = (v5 and ("p" .. v5.UserId)) or nil
    else
        v4 = v3
    end
    if not v4 then
        return
    end
    tbl_upv_2[v4] = a1
    tbl_upv_1.Added:Fire(v4, a1)
end
local function remove(a1)
    --[[
      name: remove
      line: 50
      upvalues:
        tbl_upv_4 (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
    ]]
    local v6 = tbl_upv_4[a1]
    if v6 then
        v6:Disconnect()
        tbl_upv_4[a1] = nil
    end
    for key_1, value_1 in tbl_upv_2 do
        if value_1 == a1 then
            tbl_upv_2[key_1] = nil
        end
    end
end
local function add(a1)
    --[[
      name: add
      line: 40
      upvalues:
        tbl_upv_4 (copy, index: 1)
        Players_upv_1 (copy, index: 2)
        tbl_upv_2 (copy, index: 3)
        tbl_upv_1 (copy, index: 4)
    ]]
    if not a1:IsA("Model") then
        return
    end
    if not (tbl_upv_4[a1]) then
        tbl_upv_4[a1] = a1:GetAttributeChangedSignal("CombatantId"):Connect(
            function()
                --[[
                  line: 44
                  upvalues:
                    a1 (copy, index: 1)
                    Players_upv_1 (copy, index: 2)
                    tbl_upv_2 (copy, index: 3)
                    tbl_upv_1 (copy, index: 4)
                ]]
                local v7 = a1:GetAttribute("CombatantId")
                local v8
                if type(v7) ~= "string" or v7 == "" then
                    local v9 = Players_upv_1:GetPlayerFromCharacter(a1)
                    v8 = (v9 and ("p" .. v9.UserId)) or nil
                else
                    v8 = v7
                end
                if not v8 then
                    return
                end
                tbl_upv_2[v8] = a1
                tbl_upv_1.Added:Fire(v8, a1)
            end
        )
        local v10 = a1:GetAttribute("CombatantId")
        local v11
        if type(v10) ~= "string" or v10 == "" then
            local v12 = Players_upv_1:GetPlayerFromCharacter(a1)
            v11 = (v12 and ("p" .. v12.UserId)) or nil
        else
            v11 = v10
        end
        if v11 then
            tbl_upv_2[v11] = a1
            tbl_upv_1.Added:Fire(v11, a1)
        end
    end
end
for _, value_2 in tbl_upv_1.TAGS do
    for v1, value_3 in CollectionService_1:GetTagged(value_2) do
        add(value_3)
    end
    CollectionService_1:GetInstanceAddedSignal(value_2):Connect(add)
    CollectionService_1:GetInstanceRemovedSignal(value_2):Connect(remove)
end
for _, value_4 in Players_upv_1:GetPlayers() do
    tbl_upv_3[value_4.UserId] = true
    if value_4.Character then
        add(value_4.Character)
    end
    value_4.CharacterAdded:Connect(add)
    value_4.CharacterRemoving:Connect(remove)
end
local function watchPlayer(a1)
    --[[
      name: watchPlayer
      line: 71
      upvalues:
        tbl_upv_3 (copy, index: 1)
        add (copy, index: 2)
        remove (copy, index: 3)
    ]]
    tbl_upv_3[a1.UserId] = true
    if a1.Character then
        add(a1.Character)
    end
    a1.CharacterAdded:Connect(add)
    a1.CharacterRemoving:Connect(remove)
end
Players_upv_1.PlayerAdded:Connect(watchPlayer)
function tbl_upv_1.Find(a1)
    --[[
      name: Find
      line: 85
      upvalues:
        tbl_upv_2 (copy, index: 1)
        Players_upv_1 (copy, index: 2)
    ]]
    if type(a1) ~= "string" then
        return nil
    end
    local v13 = tbl_upv_2[a1]
    if v13 and v13.Parent then
        return v13
    end
    if string.sub(a1, 1, 1) == "p" then
        local num_1 = tonumber(string.sub(a1, 2))
        local v14 = num_1 and (Players_upv_1:GetPlayerByUserId(num_1))
        if v14 and v14.Character then
            return v14.Character
        end
    end
    return nil
end
function tbl_upv_1.IsRealUserId(a1)
    --[[
      name: IsRealUserId
      line: 105
      upvalues:
        tbl_upv_3 (copy, index: 1)
    ]]
    local v15 = (type(a1) == "number") and ((a1 > 0) and (tbl_upv_3[a1] == true))
    return v15
end
tbl_upv_1.TrustAllUserIds = false
return tbl_upv_1