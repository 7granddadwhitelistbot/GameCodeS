local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local workspace = game:GetService("Workspace")
local Signal = require(replicatedStorage:WaitForChild("Shared"):WaitForChild("Signal"))
local Remotes = require(script.Parent.Remotes)
local localPlayer = players.LocalPlayer
local v7 = {ProfileChanged = Signal.new(), MatchChanged = Signal.new(), MatchEvent = Signal.new(), PlayerStateChanged = Signal.new(), WatchChanged = Signal.new(), AttrChanged = Signal.new(), LeaderboardsChanged = Signal.new(), Notify = Signal.new()}
local starterLoadout = {armor = "hide_armor", items = {"bronze_sword", "short_bow", "bandage"}, ammo = {arrows = 3}}
v7.STARTER_LOADOUT = starterLoadout

local function cloneLoadout(a10)
    --[[
      name: cloneLoadout
      line: 29
    ]]
    return {items = table.clone(a10.items), armor = a10.armor}
end

local function defaultProfile()
    --[[
      name: defaultProfile
      line: 33
      upvalues:
        starterLoadout (copy, index: 1)
    ]]
    local v12 = {level = 1, xp = 0, xpToNext = 100, owned = {}}
    v12.loadout = {items = table.clone(starterLoadout.items), armor = starterLoadout.armor}
    v12.stats = {matches = 0, wins = 0, losses = 0, kills = 0, deaths = 0, streak = 0, bestStreak = 0, roundsWon = 0}
    return v12
end

v7.Profile = defaultProfile()
v7.HasProfile = false
v7.Match = nil
v7.Leaderboards = nil
v7.Mock = nil
v7.DEFAULT_ROUNDS_TO_WIN = 3
v7.DEFAULT_ROUND_TIME = 60
local config = replicatedStorage.Shared:FindFirstChild("Config")

if config and config:IsA("ModuleScript") then
    local success, result = pcall(require, config)

    if success and type(result) == "table" and type(result.ROUNDS_TO_WIN) == "number" then
        v7.DEFAULT_ROUNDS_TO_WIN = result.ROUNDS_TO_WIN
    end

    if success and type(result) == "table" and type(result.ROUND_TIME) == "number" then
        v7.DEFAULT_ROUND_TIME = result.ROUND_TIME
    end
end

local flooredValue = nil

function v7.RoundTime()
    --[[
      name: RoundTime
      line: 69
      upvalues:
        v7 (copy, index: 1)
        flooredValue (ref,  index: 2)
    ]]
    local match = v7.Match

    if match and type(match.roundTime) == "number" then
        return match.roundTime
    end

    return flooredValue or v7.DEFAULT_ROUND_TIME
end

local phase = nil

v7.MatchChanged:Connect(
    function(a19)
        --[[
          line: 78
          upvalues:
            phase (ref,  index: 1)
            v7 (copy, index: 2)
            flooredValue (ref,  index: 3)
        ]]
        local phase2 = a19 and a19.phase

        if phase2 == "Live" and phase ~= "Live" and type(a19.phaseEndsAt) == "number" then
            local flooredValue2 = math.floor((a19.phaseEndsAt - v7.Now()) + 0.5)

            if 10 <= flooredValue2 and flooredValue2 <= 900 then
                flooredValue = flooredValue2
            end
        end

        phase = phase2
    end
)

function v7.RoundsToWin()
    --[[
      name: RoundsToWin
      line: 89
      upvalues:
        v7 (copy, index: 1)
    ]]
    local match = v7.Match

    if match and type(match.roundsToWin) == "number" then
        return match.roundsToWin
    end

    return v7.DEFAULT_ROUNDS_TO_WIN
end

function v7.Now()
    --[[
      name: Now
      line: 95
      upvalues:
        workspace (copy, index: 1)
    ]]
    return workspace:GetServerTimeNow()
end

local v23 = {}
local attributeNames = {"State", "MatchId", "Team", "Alive", "Frozen", "Level", "XP", "Streak", "CombatMode", "Trophies", "RankBest", "Queued", "QueuedAt", "QueueFound", "QueueFilled", "Duel", "QueueMode", "Spectating"}

function v7.Get(attributeName: string)
    --[[
      name: Get
      line: 114
      upvalues:
        v23 (copy, index: 1)
        localPlayer (copy, index: 2)
    ]]
    local v26 = v23[attributeName]
    if v26 ~= nil then
        return v26
    end

    return localPlayer:GetAttribute(attributeName)
end

function v7.SetMockAttr(key, value)
    --[[
      name: SetMockAttr
      line: 122
      upvalues:
        v23 (copy, index: 1)
        v7 (copy, index: 2)
    ]]
    v23[key] = value
    v7.AttrChanged:Fire(key, v7.Get(key))

    if key == "Spectating" then
        v7.WatchChanged:Fire(v7.Watching())
    end

    if key == "State" then
        v7.PlayerStateChanged:Fire(v7.GetPlayerState())
    end
end

function v7.ClearMockAttrs()
    --[[
      name: ClearMockAttrs
      line: 133
      upvalues:
        v23 (copy, index: 1)
        v7 (copy, index: 2)
    ]]
    local v29 = {}

    for v30 in v23 do
        table.insert(v29, v30)
    end

    table.clear(v23)

    for _, v32 in v29 do
        v7.AttrChanged:Fire(v32, v7.Get(v32))
    end

    v7.PlayerStateChanged:Fire(v7.GetPlayerState())
end

for _, attributeName in attributeNames do
    local attributeName2 = attributeName

    localPlayer:GetAttributeChangedSignal(attributeName2):Connect(
        function()
            --[[
              line: 146
              upvalues:
                v23 (copy, index: 1)
                attributeName (copy, index: 2)
                v7 (copy, index: 3)
                localPlayer (copy, index: 4)
            ]]
            if v23[attributeName] ~= nil then
                return
            end

            v7.AttrChanged:Fire(attributeName, localPlayer:GetAttribute(attributeName))

            if attributeName == "Spectating" then
                v7.WatchChanged:Fire(v7.Watching())
            end

            if attributeName == "State" then
                v7.PlayerStateChanged:Fire(v7.GetPlayerState())
            end
        end
    )
end

function v7.GetPlayerState()
    --[[
      name: GetPlayerState
      line: 160
      upvalues:
        v7 (copy, index: 1)
    ]]
    local v36 = v7.Get("State")

    if type(v36) == "string" and v36 ~= "" then
        return v36
    end

    return "Lobby"
end

function v7.InMatch()
    --[[
      name: InMatch
      line: 165
      upvalues:
        v7 (copy, index: 1)
    ]]
    return v7.GetPlayerState() == "Match"
end

function v7.Watching()
    --[[
      name: Watching
      line: 171
      upvalues:
        v7 (copy, index: 1)
    ]]
    local v37 = v7.Get("Spectating")
    return type(v37) == "string" and v37 ~= "" and not v7.InMatch()
end

function v7.SeesMatch()
    --[[
      name: SeesMatch
      line: 177
      upvalues:
        v7 (copy, index: 1)
    ]]
    return v7.InMatch() or v7.Watching()
end

function v7.SeenMatchId()
    --[[
      name: SeenMatchId
      line: 182
      upvalues:
        v7 (copy, index: 1)
    ]]
    local v38 = if v7.InMatch() then v7.Get("MatchId") else v7.Get("Spectating")

    if type(v38) ~= "string" then
        return ""
    end

    return v38
end

function v7.MyId()
    --[[
      name: MyId
      line: 187
      upvalues:
        localPlayer (copy, index: 1)
    ]]
    return "p" .. tostring(localPlayer.UserId)
end

function v7.MyTeam()
    --[[
      name: MyTeam
      line: 192
      upvalues:
        v7 (copy, index: 1)
    ]]
    local v39 = v7.Get("Team")

    if type(v39) == "number" then
        if v39 == 1 then
            return v39
        elseif v39 == 2 then
            return v39
        end
    end

    local match = v7.Match

    if match and match.teams then
        local v41 = v7.MyId()

        for teamKey = 1, 2 do
            local team = match.teams[teamKey]
            local v44 = team and team.members or {}

            for _, v46 in v44 do
                if v46.id == v41 then
                    return teamKey
                end
            end
        end
    end

    return 1
end

function v7.IsAlive()
    --[[
      name: IsAlive
      line: 212
      upvalues:
        v7 (copy, index: 1)
        localPlayer (copy, index: 2)
    ]]
    if v7.InMatch() then
        local v47 = v7.Get("Alive")
        if v47 ~= nil then
            return v47 == true
        end
    end

    local character = localPlayer.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")

    return humanoid ~= nil and 0 < humanoid.Health
end

local function num(a51, a52)
    --[[
      name: num
      line: 226
    ]]
    if type(a51) ~= "number" then
        return a52
    end

    return a51
end

function v7.Level()
    --[[
      name: Level
      line: 231
      upvalues:
        v7 (copy, index: 1)
    ]]
    local level
    local v54 = v7.Get("Level")
    local level2 = v7.Profile.level

    if type(level2) ~= "number" then
        level = 1
    else
        level = level2
    end

    if type(v54) ~= "number" then
        return level
    end

    return v54
end

function v7.Xp()
    --[[
      name: Xp
      line: 234
      upvalues:
        v7 (copy, index: 1)
    ]]
    local xp
    local v57 = v7.Get("XP")
    local xp2 = v7.Profile.xp

    if type(xp2) ~= "number" then
        xp = 0
    else
        xp = xp2
    end

    if type(v57) ~= "number" then
        return xp
    end

    return v57
end

local result = false

function v7.XpToNext(a60)
    --[[
      name: XpToNext
      line: 241
      upvalues:
        v7 (copy, index: 1)
        result (ref,  index: 2)
        replicatedStorage (copy, index: 3)
    ]]
    local v61 = a60 or v7.Level()

    if a60 == nil and type(v7.Profile.xpToNext) == "number" and 0 < v7.Profile.xpToNext then
        return v7.Profile.xpToNext
    end

    if result == false then
        result = nil
        local progression = replicatedStorage.Shared:FindFirstChild("Progression")

        if progression and progression:IsA("ModuleScript") then
            local success, result2 = pcall(require, progression)

            if success and type(result2) == "table" then
                result = result2
            end
        end
    end

    if result then
        local result3

        for _, v67 in {"XpToNext", "XpForLevel", "XPToNext", "XpRequired"} do
            local v68 = result[v67]

            if type(v68) == "function" then
                local success
                success, result3 = pcall(v68, v61)

                if not success or type(result3) ~= "number" or not (0 < result3) then
                    continue
                end

                return result3
            end
        end
    end

    return 100 + ((v61 - 1) * 50)
end

function v7.Owns(key)
    --[[
      name: Owns
      line: 270
      upvalues:
        v7 (copy, index: 1)
    ]]
    local owned = v7.Profile.owned
    return type(owned) == "table" and owned[key] == true
end

function v7.LoadoutSlotCount()
    --[[
      name: LoadoutSlotCount
      line: 278
      upvalues:
        v7 (copy, index: 1)
    ]]
    local loadouts = v7.Profile.loadouts

    if type(loadouts) == "table" and 1 <= #loadouts then
        return (math.min(#loadouts, 5))
    end

    return 1
end

function v7.ActiveLoadout()
    --[[
      name: ActiveLoadout
      line: 282
      upvalues:
        v7 (copy, index: 1)
    ]]
    local activeLoadout = v7.Profile.activeLoadout
    local v74 = v7.LoadoutSlotCount()

    if type(activeLoadout) == "number" and 1 <= activeLoadout and activeLoadout <= v74 then
        return (math.floor(activeLoadout))
    end

    return 1
end

function v7.HasLoadoutSlots()
    --[[
      name: HasLoadoutSlots
      line: 287
      upvalues:
        v7 (copy, index: 1)
    ]]
    return type(v7.Profile.loadouts) == "table" and 1 <= #v7.Profile.loadouts
end

function v7.LoadoutName(loadoutNameKey)
    --[[
      name: LoadoutName
      line: 290
      upvalues:
        v7 (copy, index: 1)
    ]]
    local loadoutNames = v7.Profile.loadoutNames
    local loadoutName = type(loadoutNames) == "table" and loadoutNames[loadoutNameKey]

    if type(loadoutName) == "string" and loadoutName ~= "" then
        return loadoutName
    end

    return "LOADOUT " .. loadoutNameKey
end

function v7.LoadoutCustomName(loadoutNameKey)
    --[[
      name: LoadoutCustomName
      line: 295
      upvalues:
        v7 (copy, index: 1)
    ]]
    local loadoutNames = v7.Profile.loadoutNames
    local loadoutName = type(loadoutNames) == "table" and loadoutNames[loadoutNameKey]

    if type(loadoutName) ~= "string" then
        return ""
    end

    return loadoutName
end

function v7.LoadoutSlot(loadoutKey)
    --[[
      name: LoadoutSlot
      line: 300
      upvalues:
        v7 (copy, index: 1)
    ]]
    local loadouts = v7.Profile.loadouts

    if type(loadouts) == "table" and type(loadouts[loadoutKey]) == "table" then
        return v7.NormalizeLoadout(loadouts[loadoutKey])
    end

    return v7.Loadout()
end

function v7.Loadout()
    --[[
      name: Loadout
      line: 309
      upvalues:
        v7 (copy, index: 1)
    ]]
    return v7.NormalizeLoadout(v7.Profile.loadout)
end

function v7.NormalizeLoadout(a83)
    --[[
      name: NormalizeLoadout
      line: 312
      upvalues:
        starterLoadout (copy, index: 1)
    ]]
    if type(a83) ~= "table" then
        return {items = table.clone(starterLoadout.items), armor = starterLoadout.armor}
    end

    if type(a83.items) ~= "table" then
        local items = {}

        for _, v86 in {"primary", "secondary", "melee", "utility"} do
            if type(a83[v86]) == "string" then
                table.insert(items, a83[v86])
            end
        end

        return {armor = false, items = items}
    end

    local armor
    local ammo
    local v89 = {items = a83.items}

    if type(a83.armor) ~= "string" or a83.armor == "" then
        armor = false
    else
        armor = a83.armor
    end

    v89.armor = armor

    if type(a83.ammo) ~= "table" then
        ammo = nil
    else
        ammo = a83.ammo
    end

    v89.ammo = ammo

    return v89
end

function v7.SetProfile(a90, a91)
    --[[
      name: SetProfile
      line: 333
      upvalues:
        v7 (copy, index: 1)
        defaultProfile (copy, index: 2)
        starterLoadout (copy, index: 3)
    ]]
    if type(a90) ~= "table" then
        return
    end

    local v92 = if a91 then v7.Profile else defaultProfile()

    for v93, v94 in a90 do
        v92[v93] = v94
    end

    if type(v92.owned) ~= "table" then
        v92.owned = {}
    end

    if type(v92.loadout) ~= "table" then
        local starterLoadout2 = starterLoadout
        v92.loadout = {items = table.clone(starterLoadout2.items), armor = starterLoadout2.armor}
    end

    if type(v92.stats) ~= "table" then
        v92.stats = defaultProfile().stats
    end

    v7.Profile = v92
    v7.HasProfile = true
    v7.ProfileChanged:Fire(v92)
end

function v7.Refresh()
    --[[
      name: Refresh
      line: 355
      upvalues:
        Remotes (copy, index: 1)
        v7 (copy, index: 2)
    ]]
    task.spawn(
        function()
            --[[
              line: 356
              upvalues:
                Remotes (copy, index: 1)
                v7 (copy, index: 2)
            ]]
            local v96, v97 = Remotes.Invoke("GetProfile")

            if v96 and type(v97) == "table" and not v7.Mock then
                v7.SetProfile(v97)
            end
        end
    )
end

Remotes.On(
    "ProfileChanged",
    function(a98)
        --[[
          line: 364
          upvalues:
            v7 (copy, index: 1)
        ]]
        if type(a98) == "table" and not v7.Mock then
            v7.SetProfile(a98)
        end
    end
)

local function normalizeSnapshot(a100)
    --[[
      name: normalizeSnapshot
      line: 371
      upvalues:
        v7 (copy, index: 1)
    ]]
    if type(a100) ~= "table" then
        return nil
    end

    local v101
    local v102
    local round
    local phaseEndsAt

    if type(a100.teams) ~= "table" then
        v101 = {}
    else
        v101 = a100.teams
    end

    a100.teams = v101

    for teamKey = 1, 2 do
        local v106
        local v107
        local score
        local v109
        local team = a100.teams[teamKey]

        if type(team) == "table" then
            v106 = team
        else
            local name
            local v112 = {score = 0}

            if teamKey == 1 then
                name = "Wolf"
            else
                name = "Raven"
            end

            v112.name = name
            v112.members = {}
            v106 = v112
            a100.teams[teamKey] = v106
        end

        if type(v106.members) == "table" then
            v107 = v106.members
        else
            v107 = {}
        end

        v106.members = v107

        if type(v106.score) == "number" then
            score = v106.score
        else
            score = 0
        end

        v106.score = score

        if type(v106.name) == "string" then
            v109 = v106.name
        else
            v109 = "Tribe " .. teamKey
        end

        v106.name = v109
    end

    local roundsToWin = a100.roundsToWin
    local defaultRoundsToWin = v7.DEFAULT_ROUNDS_TO_WIN

    if type(roundsToWin) ~= "number" then
        v102 = defaultRoundsToWin
    else
        v102 = roundsToWin
    end

    a100.roundsToWin = v102
    local round2 = a100.round

    if type(round2) ~= "number" then
        round = 1
    else
        round = round2
    end

    a100.round = round
    local phaseEndsAt2 = a100.phaseEndsAt

    if type(phaseEndsAt2) ~= "number" then
        phaseEndsAt = 0
    else
        phaseEndsAt = phaseEndsAt2
    end

    a100.phaseEndsAt = phaseEndsAt

    return a100
end

function v7.InjectSnapshot(a117)
    --[[
      name: InjectSnapshot
      line: 392
      upvalues:
        v7 (copy, index: 1)
        normalizeSnapshot (copy, index: 2)
    ]]
    v7.Match = normalizeSnapshot(a117)
    v7.MatchChanged:Fire(v7.Match)
end

function v7.FindMember(a118)
    --[[
      name: FindMember
      line: 398
      upvalues:
        v7 (copy, index: 1)
    ]]
    local match = v7.Match

    if not match or type(a118) ~= "string" then
        return nil, nil
    end

    for teamKey = 1, 2 do
        for _, member in match.teams[teamKey].members do
            if member.id == a118 then
                return member, teamKey
            end
        end
    end

    return nil, nil
end

function v7.IsAllyTeam(a123)
    --[[
      name: IsAllyTeam
      line: 414
      upvalues:
        v7 (copy, index: 1)
    ]]
    return a123 == v7.MyTeam()
end

local mode = nil

function v7.InjectEvent(a125, a126)
    --[[
      name: InjectEvent
      line: 419
      upvalues:
        v7 (copy, index: 1)
        mode (ref,  index: 2)
    ]]
    if type(a125) ~= "string" then
        return
    end

    local v127

    if type(a126) ~= "table" then
        v127 = {}
    else
        v127 = a126
    end

    local match = v7.Match

    if a125 == "Elimination" and match then
        local member = v7.FindMember(v127.victimId)

        if member and member.alive ~= false then
            member.alive = false
            v7.MatchChanged:Fire(match)
        end
    elseif a125 == "RoundStart" and match then
        for _, member in match.teams[1].members do
            member.alive = true
        end

        for _, member in match.teams[2].members do
            member.alive = true
        end

        v7.MatchChanged:Fire(match)
    end

    if a125 == "MatchStart" then
        if type(v127.mode) ~= "string" then
            mode = nil
        else
            mode = v127.mode
        end
    elseif a125 == "MatchEnd" and type(v127.mode) == "string" then
        mode = v127.mode
    end

    v7.MatchEvent:Fire(a125, v127)
end

Remotes.On(
    "MatchState",
    function(a134)
        --[[
          line: 450
          upvalues:
            v7 (copy, index: 1)
        ]]
        if v7.Mock then
            return
        end

        v7.InjectSnapshot(a134)
    end
)

Remotes.On(
    "MatchEvent",
    function(a135, a136)
        --[[
          line: 456
          upvalues:
            v7 (copy, index: 1)
        ]]
        if v7.Mock then
            return
        end

        v7.InjectEvent(a135, a136)
    end
)

function v7.FetchMatch()
    --[[
      name: FetchMatch
      line: 463
      upvalues:
        Remotes (copy, index: 1)
        v7 (copy, index: 2)
    ]]
    task.spawn(
        function()
            --[[
              line: 464
              upvalues:
                Remotes (copy, index: 1)
                v7 (copy, index: 2)
            ]]
            local v137, v138 = Remotes.Invoke("GetMatchState")

            if v137 and type(v138) == "table" and not v7.Mock then
                v7.InjectSnapshot(v138)
            end
        end
    )
end

function v7.PhaseTimeLeft()
    --[[
      name: PhaseTimeLeft
      line: 473
      upvalues:
        v7 (copy, index: 1)
        workspace (copy, index: 2)
    ]]
    local match = v7.Match
    local phaseEndsAt = match and match.phaseEndsAt or 0

    if (not phaseEndsAt or phaseEndsAt <= 0) and match and match.matchId then
        local arenas = workspace:FindFirstChild("Arenas")
        local child = arenas and arenas:FindFirstChild((tostring(match.matchId)))
        local phaseEndsAt2 = child and child:GetAttribute("PhaseEndsAt")

        if type(phaseEndsAt2) ~= "number" then
            phaseEndsAt = 0
        else
            phaseEndsAt = phaseEndsAt2
        end
    end

    return (math.max(0, (phaseEndsAt or 0) - v7.Now()))
end

function v7.Phase()
    --[[
      name: Phase
      line: 485
      upvalues:
        v7 (copy, index: 1)
    ]]
    local match = v7.Match
    return match and match.phase or nil
end

local child = nil
local v146 = nil

function v7.PhaseClock()
    --[[
      name: PhaseClock
      line: 496
      upvalues:
        v7 (copy, index: 1)
        v146 (ref,  index: 2)
        child (ref,  index: 3)
        workspace (copy, index: 4)
    ]]
    local match = v7.Match

    if not v7.Mock then
        local childName = v7.Get("MatchId")

        if type(childName) == "string" and childName ~= "" then
            if v146 ~= childName or not child or child.Parent == nil then
                local arenas = workspace:FindFirstChild("Arenas")
                child = arenas and arenas:FindFirstChild(childName)
                v146 = if child then childName else nil
            end

            if const child2 = child then
                local phase = child2:GetAttribute("Phase")

                if type(phase) == "string" then
                    local phaseEndsAt
                    local phaseEndsAt2 = child2:GetAttribute("PhaseEndsAt")
                    local round = child2:GetAttribute("Round")

                    if type(phaseEndsAt2) ~= "number" then
                        phaseEndsAt = 0
                    else
                        phaseEndsAt = phaseEndsAt2
                    end

                    if type(round) == "number" then
                        return phase, phaseEndsAt, round
                    end

                    local round2 = match and match.round or 1

                    return phase, phaseEndsAt, round2
                end
            end
        end
    end

    if match then
        return match.phase, match.phaseEndsAt or 0, match.round or 1
    end

    return nil, 0, 1
end

function v7.MatchMode()
    --[[
      name: MatchMode
      line: 526
      upvalues:
        v7 (copy, index: 1)
        workspace (copy, index: 2)
        mode (ref,  index: 3)
    ]]
    local childName = v7.Get("MatchId")

    if not v7.Mock and type(childName) == "string" and childName ~= "" then
        local arenas = workspace:FindFirstChild("Arenas")
        local child = arenas and arenas:FindFirstChild(childName)
        local mode2 = child and child:GetAttribute("Mode")

        if mode2 == "1v1" then
            return mode2
        end
        if mode2 == "3v3" then
            return mode2
        end
    end

    if mode == "1v1" then
        return "1v1"
    end

    return "3v3"
end

function v7.IsDuel()
    --[[
      name: IsDuel
      line: 538
      upvalues:
        v7 (copy, index: 1)
    ]]
    return v7.MatchMode() == "1v1"
end

function v7.TeamSize(a160)
    --[[
      name: TeamSize
      line: 542
      upvalues:
        v7 (copy, index: 1)
    ]]
    local v161 = a160 or v7.Match and v7.Match.teams
    local v162 = 0

    if type(v161) == "table" then
        for index = 1, 2 do
            local v164 = v161[index]

            if type(v164) == "table" and type(v164.members) == "table" then
                v162 = math.max(v162, #v164.members)
            end
        end
    end

    if 0 < v162 then
        return v162
    end

    return 3
end

Remotes.On(
    "Leaderboards",
    function(leaderboards)
        --[[
          line: 557
          upvalues:
            v7 (copy, index: 1)
        ]]
        if type(leaderboards) == "table" and not v7.Mock then
            v7.Leaderboards = leaderboards
            v7.LeaderboardsChanged:Fire(leaderboards)
        end
    end
)

function v7.InjectLeaderboards(leaderboards)
    --[[
      name: InjectLeaderboards
      line: 564
      upvalues:
        v7 (copy, index: 1)
    ]]
    v7.Leaderboards = leaderboards
    v7.LeaderboardsChanged:Fire(leaderboards)
end

Remotes.On(
    "Notify",
    function(a167, a168)
        --[[
          line: 569
          upvalues:
            v7 (copy, index: 1)
        ]]
        v7.Notify:Fire(a167, a168)
    end
)

function v7.Start()
    --[[
      name: Start
      line: 574
      upvalues:
        v7 (copy, index: 1)
    ]]
    v7.Refresh()

    task.spawn(
        function()
            --[[
              line: 577
              upvalues:
                v7 (copy, index: 1)
            ]]
            for _ = 1, 6 do
                task.wait(2.5)

                if v7.HasProfile then
                    break
                end

                v7.Refresh()
            end
        end
    )

    if v7.InMatch() then
        v7.FetchMatch()
    end

    v7.PlayerStateChanged:Connect(
        function(a170)
            --[[
              line: 589
              upvalues:
                v7 (copy, index: 1)
            ]]
            if a170 == "Match" then
                v7.FetchMatch()
                return
            end

            if a170 == "Lobby" and not v7.Mock and not v7.Watching() then
                v7.Match = nil
                v7.MatchChanged:Fire(nil)
                v7.Refresh()
            end
        end
    )

    v7.WatchChanged:Connect(
        function(a171)
            --[[
              line: 598
              upvalues:
                v7 (copy, index: 1)
            ]]
            if a171 then
                v7.FetchMatch()
                return
            end

            if not v7.InMatch() and not v7.Mock then
                v7.Match = nil
                v7.MatchChanged:Fire(nil)
            end
        end
    )

    if v7.Watching() then
        v7.FetchMatch()
    end
end

return v7