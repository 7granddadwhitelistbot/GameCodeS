local collectionService = game:GetService("CollectionService")
local players = game:GetService("Players")
local v3 = {TAGS = {"Combatant", "Bot"}}
local v4 = {}
local v5 = {}
local v6 = true
local timestamp = 0
local hasRun = false

local function markDirty()
    --[[
      name: markDirty
      line: 20
      upvalues:
        v6 (ref, index: 1)
    ]]
    v6 = true
end

local function start()
    --[[
      name: start
      line: 24
      upvalues:
        hasRun (ref,  index: 1)
        v3 (copy, index: 2)
        collectionService (copy, index: 3)
        markDirty (copy, index: 4)
        players (copy, index: 5)
        v6 (ref,  index: 6)
    ]]
    if hasRun then
        return
    end

    hasRun = true

    for _, tag in v3.TAGS do
        collectionService:GetInstanceAddedSignal(tag):Connect(markDirty)
        collectionService:GetInstanceRemovedSignal(tag):Connect(markDirty)
    end

    local function watch(a14)
        --[[
          name: watch
          line: 33
          upvalues:
            markDirty (copy, index: 1)
        ]]
        a14.CharacterAdded:Connect(markDirty)
        a14.CharacterRemoving:Connect(markDirty)
    end

    for _, player in players:GetPlayers() do
        player.CharacterAdded:Connect(markDirty)
        player.CharacterRemoving:Connect(markDirty)
    end

    players.PlayerAdded:Connect(
        function(player: Player)
            --[[
              line: 40
              upvalues:
                markDirty (copy, index: 1)
                v6 (ref,  index: 2)
            ]]
            player.CharacterAdded:Connect(markDirty)
            player.CharacterRemoving:Connect(markDirty)
            v6 = true
        end
    )

    players.PlayerRemoving:Connect(markDirty)
end

local function add(key)
    --[[
      name: add
      line: 47
      upvalues:
        v5 (copy, index: 1)
        v4 (copy, index: 2)
    ]]
    if key:IsA("Model") and not v5[key] and key:IsDescendantOf(workspace) then
        v5[key] = true
        table.insert(v4, key)
    end
end

function v3.List()
    --[[
      name: List
      line: 55
      upvalues:
        start (copy, index: 1)
        v6 (ref,  index: 2)
        timestamp (ref,  index: 3)
        v4 (copy, index: 4)
        v5 (copy, index: 5)
        players (copy, index: 6)
        v3 (copy, index: 7)
        collectionService (copy, index: 8)
    ]]
    start()
    local timestamp2 = os.clock()

    if v6 or 0.5 < timestamp2 - timestamp then
        table.clear(v4)
        table.clear(v5)

        for _, player in players:GetPlayers() do
            if const character = player.Character then
                if not character:IsA("Model") then
                    continue
                end

                if not v5[character] and character:IsDescendantOf(workspace) then
                    v5[character] = true
                    table.insert(v4, character)
                end
            end
        end

        for _, tag in v3.TAGS do
            for _, instance in collectionService:GetTagged(tag) do
                if instance:IsA("Model") then
                    if not v5[instance] and instance:IsDescendantOf(workspace) then
                        v5[instance] = true
                        table.insert(v4, instance)
                    end
                end
            end
        end

        v6 = false
        timestamp = timestamp2
    end

    return v4
end

function v3.EachTagged(callback)
    --[[
      name: EachTagged
      line: 79
      upvalues:
        v3 (copy, index: 1)
        collectionService (copy, index: 2)
    ]]
    local v29 = {}

    for _, tag in v3.TAGS do
        for _, instance in collectionService:GetTagged(tag) do
            if instance:IsA("Model") and not v29[instance] then
                v29[instance] = true
                callback(instance)
            end
        end
    end
end

function v3.OnTaggedChanged(a34)
    --[[
      name: OnTaggedChanged
      line: 92
      upvalues:
        v3 (copy, index: 1)
        collectionService (copy, index: 2)
    ]]
    for _, tag in v3.TAGS do
        collectionService:GetInstanceAddedSignal(tag):Connect(a34)
        collectionService:GetInstanceRemovedSignal(tag):Connect(a34)
    end
end

return v3