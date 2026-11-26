local collectionService = game:GetService("CollectionService")
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local v4 = {}
local tags = {"Combatant", "Bot"}
local isStudio = runService:IsStudio()
local v7 = {}
local v8 = {}
local v9 = true
local hasRun = false

local function markDirty()
    --[[
      name: markDirty
      line: 25
      upvalues:
        v9 (ref, index: 1)
    ]]
    v9 = true
end

local function addTagged(tag: string)
    --[[
      name: addTagged
      line: 29
      upvalues:
        collectionService (copy, index: 1)
        v8 (copy, index: 2)
        v7 (copy, index: 3)
    ]]
    for _, target in collectionService:GetTagged(tag) do
        if target:IsA("Model") then
            if not target.Parent then
                continue
            end

            if not v8[target] and not table.find(v7, target) then
                table.insert(v7, target)
            end
        end
    end
end

local function rebuild()
    --[[
      name: rebuild
      line: 37
      upvalues:
        v7 (copy, index: 1)
        v8 (copy, index: 2)
        players (copy, index: 3)
        tags (copy, index: 4)
        addTagged (copy, index: 5)
        isStudio (copy, index: 6)
        v9 (ref,  index: 7)
    ]]
    table.clear(v7)
    table.clear(v8)

    for _, player in players:GetPlayers() do
        local character = player.Character

        if character and character.Parent then
            table.insert(v7, character)
            v8[character] = player
        end
    end

    for _, tag in tags do
        addTagged(tag)
    end

    if isStudio then
        addTagged("CharacterLoadTest")
    end

    v9 = false
end

local function watchPlayer(a23)
    --[[
      name: watchPlayer
      line: 56
      upvalues:
        markDirty (copy, index: 1)
    ]]
    a23.CharacterAdded:Connect(markDirty)
    a23.CharacterRemoving:Connect(markDirty)
    a23:GetPropertyChangedSignal("Character"):Connect(markDirty)
end

local function start()
    --[[
      name: start
      line: 62
      upvalues:
        hasRun (ref,  index: 1)
        players (copy, index: 2)
        markDirty (copy, index: 3)
        v9 (ref,  index: 4)
        tags (copy, index: 5)
        collectionService (copy, index: 6)
        isStudio (copy, index: 7)
    ]]
    if hasRun then
        return
    end

    hasRun = true

    for _, player in players:GetPlayers() do
        player.CharacterAdded:Connect(markDirty)
        player.CharacterRemoving:Connect(markDirty)
        player:GetPropertyChangedSignal("Character"):Connect(markDirty)
    end

    players.PlayerAdded:Connect(
        function(player: Player)
            --[[
              line: 70
              upvalues:
                markDirty (copy, index: 1)
                v9 (ref,  index: 2)
            ]]
            player.CharacterAdded:Connect(markDirty)
            player.CharacterRemoving:Connect(markDirty)
            player:GetPropertyChangedSignal("Character"):Connect(markDirty)
            v9 = true
        end
    )

    players.PlayerRemoving:Connect(markDirty)

    for _, tag in tags do
        collectionService:GetInstanceAddedSignal(tag):Connect(markDirty)
        collectionService:GetInstanceRemovedSignal(tag):Connect(markDirty)
    end

    if isStudio then
        collectionService:GetInstanceAddedSignal("CharacterLoadTest"):Connect(markDirty)
        collectionService:GetInstanceRemovedSignal("CharacterLoadTest"):Connect(markDirty)
    end

    task.spawn(
        function()
            --[[
              line: 83
              upvalues:
                v9 (ref, index: 1)
            ]]
            while true do
                task.wait(1)
                v9 = true
            end
        end
    )
end

function v4.List()
    --[[
      name: List
      line: 92
      upvalues:
        start (copy, index: 1)
        v9 (ref,  index: 2)
        rebuild (copy, index: 3)
        v7 (copy, index: 4)
    ]]
    start()

    if v9 then
        rebuild()
    end

    return v7
end

function v4.PlayerOf(key)
    --[[
      name: PlayerOf
      line: 101
      upvalues:
        start (copy, index: 1)
        v9 (ref,  index: 2)
        rebuild (copy, index: 3)
        v8 (copy, index: 4)
    ]]
    start()

    if v9 then
        rebuild()
    end

    return v8[key]
end

return v4