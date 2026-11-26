local players = game:GetService("Players")
local collectionService = game:GetService("CollectionService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(replicatedStorage:WaitForChild("Shared"):WaitForChild("Signal"))
local v5 = {Added = Signal.new(), TAGS = {"Combatant", "Bot"}}
local v6 = {}
local v7 = {}
local v8 = {}

local function idOf(character: Model)
    --[[
      name: idOf
      line: 23
      upvalues:
        players (copy, index: 1)
    ]]
    local combatantId = character:GetAttribute("CombatantId")

    return if type(combatantId) == "string" and combatantId ~= "" then combatantId elseif const player = players:GetPlayerFromCharacter(character) then "p" .. player.UserId else nil
end

local function index(character: Model)
    --[[
      name: index
      line: 32
      upvalues:
        players (copy, index: 1)
        v6 (copy, index: 2)
        v5 (copy, index: 3)
    ]]
    local v15
    local combatantId = character:GetAttribute("CombatantId")

    if type(combatantId) == "string" and combatantId ~= "" then
        v15 = combatantId
    else
        v15 = if const player = players:GetPlayerFromCharacter(character) then "p" .. player.UserId else nil
    end

    if v15 then
        v6[v15] = character
        v5.Added:Fire(v15, character)
    end
end

local function add(a19)
    --[[
      name: add
      line: 40
      upvalues:
        v8 (copy, index: 1)
        players (copy, index: 2)
        v6 (copy, index: 3)
        v5 (copy, index: 4)
    ]]
    if not a19:IsA("Model") or v8[a19] then
        return
    end

    local v20

    v8[a19] = a19:GetAttributeChangedSignal("CombatantId"):Connect(
        function()
            --[[
              line: 44
              upvalues:
                a19 (copy, index: 1)
                players (copy, index: 2)
                v6 (copy, index: 3)
                v5 (copy, index: 4)
            ]]
            local v21
            local v22 = a19
            local combatantId = v22:GetAttribute("CombatantId")

            if type(combatantId) == "string" and combatantId ~= "" then
                v21 = combatantId
            else
                v21 = if const player = players:GetPlayerFromCharacter(v22) then "p" .. player.UserId else nil
            end

            if v21 then
                v6[v21] = v22
                v5.Added:Fire(v21, v22)
            end
        end
    )

    local combatantId = a19:GetAttribute("CombatantId")

    if type(combatantId) == "string" and combatantId ~= "" then
        v20 = combatantId
    else
        v20 = if const player = players:GetPlayerFromCharacter(a19) then "p" .. player.UserId else nil
    end

    if v20 then
        v6[v20] = a19
        v5.Added:Fire(v20, a19)
    end
end

local function remove(instance: Instance)
    --[[
      name: remove
      line: 50
      upvalues:
        v8 (copy, index: 1)
        v6 (copy, index: 2)
    ]]
    if const v29 = v8[instance] then
        v29:Disconnect()
        v8[instance] = nil
    end

    for v30, v31 in v6 do
        if v31 == instance then
            v6[v30] = nil
        end
    end
end

for _, tag in v5.TAGS do
    for _, instance in collectionService:GetTagged(tag) do
        add(instance)
    end

    collectionService:GetInstanceAddedSignal(tag):Connect(add)
    collectionService:GetInstanceRemovedSignal(tag):Connect(remove)
end

for _, player in players:GetPlayers() do
    v7[player.UserId] = true

    if player.Character then
        add(player.Character)
    end

    player.CharacterAdded:Connect(add)
    player.CharacterRemoving:Connect(remove)
end

players.PlayerAdded:Connect(
    function(player: Player)
        --[[
          name: watchPlayer
          line: 71
          upvalues:
            v7 (copy, index: 1)
            add (copy, index: 2)
            remove (copy, index: 3)
        ]]
        v7[player.UserId] = true

        if player.Character then
            add(player.Character)
        end

        player.CharacterAdded:Connect(add)
        player.CharacterRemoving:Connect(remove)
    end
)

function v5.Find(text: string)
    --[[
      name: Find
      line: 85
      upvalues:
        v6 (copy, index: 1)
        players (copy, index: 2)
    ]]
    if type(text) ~= "string" then
        return nil
    end

    local v40 = v6[text]

    if v40 and v40.Parent then
        return v40
    end

    if string.sub(text, 1, 1) == "p" then
        local v41 = tonumber((string.sub(text, 2)))
        local player = v41 and players:GetPlayerByUserId(v41)

        if player and player.Character then
            return player.Character
        end
    end

    return nil
end

function v5.IsRealUserId(key)
    --[[
      name: IsRealUserId
      line: 105
      upvalues:
        v7 (copy, index: 1)
    ]]
    return type(key) == "number" and 0 < key and v7[key] == true
end

v5.TrustAllUserIds = false

return v5