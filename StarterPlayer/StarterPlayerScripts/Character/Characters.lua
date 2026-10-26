local CollectionService_upv_1 = game:GetService("CollectionService")
local Players_upv_1 = game:GetService("Players")
local tbl_1 = {}
local tbl_upv_2 = {"Combatant", "Bot"}
local u1 = game:GetService("RunService"):IsStudio()
local tbl_upv_3 = {}
local tbl_upv_4 = {}
local u2 = true
local u3 = false
local function markDirty()
    --[[
      name: markDirty
      line: 25
      upvalues:
        u2 (ref, index: 1)
    ]]
    u2 = true
end
local function addTagged(a1)
    --[[
      name: addTagged
      line: 29
      upvalues:
        CollectionService_upv_1 (copy, index: 1)
        tbl_upv_4 (copy, index: 2)
        tbl_upv_3 (copy, index: 3)
    ]]
    for _, value_1 in CollectionService_upv_1:GetTagged(a1) do
        if not (value_1:IsA("Model")) or not (value_1.Parent) or tbl_upv_4[value_1] then
            continue
        end
        if not (table.find(tbl_upv_3, value_1)) then
            table.insert(tbl_upv_3, value_1)
        end
    end
end
local function rebuild()
    --[[
      name: rebuild
      line: 37
      upvalues:
        tbl_upv_3 (copy, index: 1)
        tbl_upv_4 (copy, index: 2)
        Players_upv_1 (copy, index: 3)
        tbl_upv_2 (copy, index: 4)
        addTagged (copy, index: 5)
        u1 (copy, index: 6)
        u2 (ref,  index: 7)
    ]]
    table.clear(tbl_upv_3)
    table.clear(tbl_upv_4)
    for _, value_2 in Players_upv_1:GetPlayers() do
        local Character_1 = value_2.Character
        if not (Character_1) then
            continue
        end
        if Character_1.Parent then
            table.insert(tbl_upv_3, Character_1)
            tbl_upv_4[Character_1] = value_2
        end
    end
    for _, value_3 in tbl_upv_2 do
        addTagged(value_3)
    end
    if u1 then
        addTagged("CharacterLoadTest")
    end
    u2 = false
end
local function watchPlayer(a1)
    --[[
      name: watchPlayer
      line: 56
      upvalues:
        markDirty (copy, index: 1)
    ]]
    a1.CharacterAdded:Connect(markDirty)
    a1.CharacterRemoving:Connect(markDirty)
    a1:GetPropertyChangedSignal("Character"):Connect(markDirty)
end
local function start()
    --[[
      name: start
      line: 62
      upvalues:
        u3 (ref,  index: 1)
        Players_upv_1 (copy, index: 2)
        markDirty (copy, index: 3)
        u2 (ref,  index: 4)
        tbl_upv_2 (copy, index: 5)
        CollectionService_upv_1 (copy, index: 6)
        u1 (copy, index: 7)
    ]]
    if u3 then
        return
    end
    u3 = true
    for _, value_4 in Players_upv_1:GetPlayers() do
        value_4.CharacterAdded:Connect(markDirty)
        value_4.CharacterRemoving:Connect(markDirty)
        value_4:GetPropertyChangedSignal("Character"):Connect(markDirty)
    end
    Players_upv_1.PlayerAdded:Connect(
        function(a1)
            --[[
              line: 70
              upvalues:
                markDirty (copy, index: 1)
                u2 (ref,  index: 2)
            ]]
            a1.CharacterAdded:Connect(markDirty)
            a1.CharacterRemoving:Connect(markDirty)
            a1:GetPropertyChangedSignal("Character"):Connect(markDirty)
            u2 = true
        end
    )
    Players_upv_1.PlayerRemoving:Connect(markDirty)
    for _, value_5 in tbl_upv_2 do
        CollectionService_upv_1:GetInstanceAddedSignal(value_5):Connect(markDirty)
        CollectionService_upv_1:GetInstanceRemovedSignal(value_5):Connect(markDirty)
    end
    if u1 then
        CollectionService_upv_1:GetInstanceAddedSignal("CharacterLoadTest"):Connect(markDirty)
        CollectionService_upv_1:GetInstanceRemovedSignal("CharacterLoadTest"):Connect(markDirty)
    end
    task.spawn(
        function()
            --[[
              line: 83
              upvalues:
                u2 (ref, index: 1)
            ]]
            while true do
                task.wait(1)
                u2 = true
            end
        end
    )
end
function tbl_1.List()
    --[[
      name: List
      line: 92
      upvalues:
        start (copy, index: 1)
        u2 (ref,  index: 2)
        rebuild (copy, index: 3)
        tbl_upv_3 (copy, index: 4)
    ]]
    start()
    if u2 then
        rebuild()
    end
    return tbl_upv_3
end
function tbl_1.PlayerOf(a1)
    --[[
      name: PlayerOf
      line: 101
      upvalues:
        start (copy, index: 1)
        u2 (ref,  index: 2)
        rebuild (copy, index: 3)
        tbl_upv_4 (copy, index: 4)
    ]]
    start()
    if u2 then
        rebuild()
    end
    return tbl_upv_4[a1]
end
return tbl_1