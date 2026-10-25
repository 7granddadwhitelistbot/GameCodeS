local CollectionService_upv_1 = game:GetService("CollectionService")
local Players_upv_1 = game:GetService("Players")
local tbl_upv_1 = {}
tbl_upv_1.TAGS = {"Combatant", "Bot"}
local tbl_upv_2 = {}
local tbl_upv_3 = {}
local u1 = true
local u2 = 0
local u3 = false
local function markDirty()
    --[[
      name: markDirty
      line: 20
      upvalues:
        u1 (ref, index: 1)
    ]]
    u1 = true
end
local function start()
    --[[
      name: start
      line: 24
      upvalues:
        u3 (ref,  index: 1)
        tbl_upv_1 (copy, index: 2)
        CollectionService_upv_1 (copy, index: 3)
        markDirty (copy, index: 4)
        Players_upv_1 (copy, index: 5)
        u1 (ref,  index: 6)
    ]]
    if u3 then
        return
    end
    u3 = true
    for _, value_1 in tbl_upv_1.TAGS do
        CollectionService_upv_1:GetInstanceAddedSignal(value_1):Connect(markDirty)
        CollectionService_upv_1:GetInstanceRemovedSignal(value_1):Connect(markDirty)
    end
    local function watch_1(a1)
        --[[
          name: watch
          line: 33
          upvalues:
            markDirty (copy, index: 1)
        ]]
        a1.CharacterAdded:Connect(markDirty)
        a1.CharacterRemoving:Connect(markDirty)
    end
    for _, value_2 in Players_upv_1:GetPlayers() do
        value_2.CharacterAdded:Connect(markDirty)
        value_2.CharacterRemoving:Connect(markDirty)
    end
    Players_upv_1.PlayerAdded:Connect(
        function(a2)
            --[[
              line: 40
              upvalues:
                markDirty (copy, index: 1)
                u1 (ref,  index: 2)
            ]]
            a2.CharacterAdded:Connect(markDirty)
            a2.CharacterRemoving:Connect(markDirty)
            u1 = true
        end
    )
    Players_upv_1.PlayerRemoving:Connect(markDirty)
end
local function add(a1)
    --[[
      name: add
      line: 47
      upvalues:
        tbl_upv_3 (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
    ]]
    if not a1:IsA("Model") or (tbl_upv_3[a1]) or not a1:IsDescendantOf(workspace) then
        return
    end
    tbl_upv_3[a1] = true
    table.insert(tbl_upv_2, a1)
end
function tbl_upv_1.List()
    --[[
      name: List
      line: 55
      upvalues:
        start (copy, index: 1)
        u1 (ref,  index: 2)
        u2 (ref,  index: 3)
        tbl_upv_2 (copy, index: 4)
        tbl_upv_3 (copy, index: 5)
        Players_upv_1 (copy, index: 6)
        tbl_upv_1 (copy, index: 7)
        CollectionService_upv_1 (copy, index: 8)
    ]]
    start()
    local v1 = os.clock()
    if u1 or v1 - u2 > 0.5 then
        table.clear(tbl_upv_2)
        table.clear(tbl_upv_3)
        for _, value_3 in Players_upv_1:GetPlayers() do
            local Character_1 = value_3.Character
            if not (Character_1) or not (Character_1:IsA("Model")) or tbl_upv_3[Character_1] then
                continue
            end
            if Character_1:IsDescendantOf(workspace) then
                tbl_upv_3[Character_1] = true
                table.insert(tbl_upv_2, Character_1)
            end
        end
        for _, value_4 in tbl_upv_1.TAGS do
            for v2, value_5 in CollectionService_upv_1:GetTagged(value_4) do
                if not (value_5:IsA("Model")) or tbl_upv_3[value_5] then
                    continue
                end
                if value_5:IsDescendantOf(workspace) then
                    tbl_upv_3[value_5] = true
                    table.insert(tbl_upv_2, value_5)
                end
            end
        end
        u1 = false
        u2 = v1
    end
    return tbl_upv_2
end
function tbl_upv_1.EachTagged(a1)
    --[[
      name: EachTagged
      line: 79
      upvalues:
        tbl_upv_1 (copy, index: 1)
        CollectionService_upv_1 (copy, index: 2)
    ]]
    local tbl_4 = {}
    for _, value_6 in tbl_upv_1.TAGS do
        for v1, value_7 in CollectionService_upv_1:GetTagged(value_6) do
            if not (value_7:IsA("Model")) then
                continue
            end
            if not (tbl_4[value_7]) then
                tbl_4[value_7] = true
                a1(value_7)
            end
        end
    end
end
function tbl_upv_1.OnTaggedChanged(a1)
    --[[
      name: OnTaggedChanged
      line: 92
      upvalues:
        tbl_upv_1 (copy, index: 1)
        CollectionService_upv_1 (copy, index: 2)
    ]]
    for _, value_8 in tbl_upv_1.TAGS do
        CollectionService_upv_1:GetInstanceAddedSignal(value_8):Connect(a1)
        CollectionService_upv_1:GetInstanceRemovedSignal(value_8):Connect(a1)
    end
end
return tbl_upv_1