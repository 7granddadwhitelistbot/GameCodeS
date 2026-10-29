local Players_1 = game:GetService("Players")
local ReplicatedStorage_upv_1 = game:GetService("ReplicatedStorage")
local Workspace_upv_1 = game:GetService("Workspace")
local Signal_1 = require(ReplicatedStorage_upv_1:WaitForChild("Shared"):WaitForChild("Signal"))
local Remotes_upv_1 = require(script.Parent.Remotes)
local LocalPlayer_upv_1 = Players_1.LocalPlayer
local tbl_upv_1 = {}
tbl_upv_1.ProfileChanged = Signal_1.new()
tbl_upv_1.MatchChanged = Signal_1.new()
tbl_upv_1.MatchEvent = Signal_1.new()
tbl_upv_1.PlayerStateChanged = Signal_1.new()
tbl_upv_1.WatchChanged = Signal_1.new()
tbl_upv_1.AttrChanged = Signal_1.new()
tbl_upv_1.LeaderboardsChanged = Signal_1.new()
tbl_upv_1.Notify = Signal_1.new()
local tbl_upv_2 = {armor = "hide_armor"}
tbl_upv_2.items = {"bronze_sword", "short_bow", "bandage"}
tbl_upv_2.ammo = {arrows = 3}
tbl_upv_1.STARTER_LOADOUT = tbl_upv_2
local function cloneLoadout(a1)
    --[[
      name: cloneLoadout
      line: 29
    ]]
    local tbl_3 = {}
    tbl_3.items = table.clone(a1.items)
    tbl_3.armor = a1.armor
    return tbl_3
end
local function defaultProfile()
    --[[
      name: defaultProfile
      line: 33
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    local tbl_4 = {level = 1, xp = 0, xpToNext = 100}
    tbl_4.owned = {}
    tbl_4.loadout = {items = table.clone(tbl_upv_2.items), armor = tbl_upv_2.armor}
    tbl_4.stats = {streak = 0, kills = 0, wins = 0, bestStreak = 0, deaths = 0, matches = 0, losses = 0, roundsWon = 0}
    return tbl_4
end
tbl_upv_1.Profile = defaultProfile()
tbl_upv_1.HasProfile = false
tbl_upv_1.Match = nil
tbl_upv_1.Leaderboards = nil
tbl_upv_1.Mock = nil
tbl_upv_1.DEFAULT_ROUNDS_TO_WIN = 3
tbl_upv_1.DEFAULT_ROUND_TIME = 60
local Config_1 = ReplicatedStorage_upv_1.Shared:FindFirstChild("Config")
if Config_1 then
    local v1, v2 = nil, nil
    if Config_1:IsA("ModuleScript") then
        v1, v2 = pcall(require, Config_1)
        if v1 and type(v2) == "table" and type(v2.ROUNDS_TO_WIN) == "number" then
            tbl_upv_1.DEFAULT_ROUNDS_TO_WIN = v2.ROUNDS_TO_WIN
        end
        if v1 and type(v2) == "table" and type(v2.ROUND_TIME) == "number" then
            tbl_upv_1.DEFAULT_ROUND_TIME = v2.ROUND_TIME
        end
    end
end
local u1 = nil
function tbl_upv_1.RoundTime()
    --[[
      name: RoundTime
      line: 69
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u1 (ref,  index: 2)
    ]]
    local Match_1 = tbl_upv_1.Match
    if Match_1 and type(Match_1.roundTime) == "number" then
        return Match_1.roundTime
    end
    local v3 = u1 or (tbl_upv_1.DEFAULT_ROUND_TIME)
    return v3
end
local u2 = nil
tbl_upv_1.MatchChanged:Connect(
    function(a1)
        --[[
          line: 78
          upvalues:
            u2 (ref,  index: 1)
            tbl_upv_1 (copy, index: 2)
            u1 (ref,  index: 3)
        ]]
        if (a1 and (a1.phase)) == "Live" and u2 ~= "Live" and type(a1.phaseEndsAt) == "number" then
            local v4 = math.floor((a1.phaseEndsAt - tbl_upv_1.Now()) + 0.5)
            if v4 >= 10 and v4 <= 900 then
                u1 = v4
            end
        end
        u2 = a1
    end
)
function tbl_upv_1.RoundsToWin()
    --[[
      name: RoundsToWin
      line: 89
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local Match_2 = tbl_upv_1.Match
    if Match_2 and type(Match_2.roundsToWin) == "number" then
        return Match_2.roundsToWin
    end
    return tbl_upv_1.DEFAULT_ROUNDS_TO_WIN
end
function tbl_upv_1.Now()
    --[[
      name: Now
      line: 95
      upvalues:
        Workspace_upv_1 (copy, index: 1)
    ]]
    return Workspace_upv_1:GetServerTimeNow()
end
local tbl_upv_5 = {}
local tbl_6 = {"State", "MatchId", "Team", "Alive", "Frozen", "Level", "XP", "Streak", "CombatMode", "Trophies", "RankBest", "Queued", "QueuedAt", "QueueFound", "QueueFilled", "Duel", "QueueMode", "Spectating"}
function tbl_upv_1.Get(a1)
    --[[
      name: Get
      line: 114
      upvalues:
        tbl_upv_5 (copy, index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
    ]]
    local v5 = tbl_upv_5[a1]
    if v5 == nil then
        return LocalPlayer_upv_1:GetAttribute(a1)
    end
    return v5
end
function tbl_upv_1.SetMockAttr(a1, a2)
    --[[
      name: SetMockAttr
      line: 122
      upvalues:
        tbl_upv_5 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    tbl_upv_5[a1] = a2
    tbl_upv_1.AttrChanged:Fire(a1, tbl_upv_1.Get(a1))
    if a1 == "Spectating" then
        tbl_upv_1.WatchChanged:Fire(tbl_upv_1.Watching())
    end
    if a1 ~= "State" then
        return
    end
    tbl_upv_1.PlayerStateChanged:Fire(tbl_upv_1.GetPlayerState())
end
function tbl_upv_1.ClearMockAttrs()
    --[[
      name: ClearMockAttrs
      line: 133
      upvalues:
        tbl_upv_5 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    local tbl_7 = {}
    for key_1 in tbl_upv_5 do
        table.insert(tbl_7, key_1)
    end
    table.clear(tbl_upv_5)
    for _, value_1 in tbl_7 do
        tbl_upv_1.AttrChanged:Fire(value_1, tbl_upv_1.Get(value_1))
    end
    tbl_upv_1.PlayerStateChanged:Fire(tbl_upv_1.GetPlayerState())
end
for _, value_upv_2 in tbl_6 do
    LocalPlayer_upv_1:GetAttributeChangedSignal(value_upv_2):Connect(
        function()
            --[[
              line: 146
              upvalues:
                tbl_upv_5 (copy, index: 1)
                value_upv_2 (copy, index: 2)
                tbl_upv_1 (copy, index: 3)
                LocalPlayer_upv_1 (copy, index: 4)
            ]]
            if tbl_upv_5[value_upv_2] ~= nil then
                return
            end
            tbl_upv_1.AttrChanged:Fire(value_upv_2, LocalPlayer_upv_1:GetAttribute(value_upv_2))
            if value_upv_2 == "Spectating" then
                tbl_upv_1.WatchChanged:Fire(tbl_upv_1.Watching())
            end
            if value_upv_2 == "State" then
                tbl_upv_1.PlayerStateChanged:Fire(tbl_upv_1.GetPlayerState())
            end
        end
    )
end
function tbl_upv_1.GetPlayerState()
    --[[
      name: GetPlayerState
      line: 160
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v6 = tbl_upv_1.Get("State")
    if type(v6) == "string" and v6 ~= "" then
        return v6
    end
    return "Lobby"
end
function tbl_upv_1.InMatch()
    --[[
      name: InMatch
      line: 165
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v7 = tbl_upv_1.GetPlayerState() == "Match"
    return v7
end
function tbl_upv_1.Watching()
    --[[
      name: Watching
      line: 171
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v8 = tbl_upv_1.Get("Spectating")
    local v9 = (type(v8) == "string") and ((v8 ~= "") and (not tbl_upv_1.InMatch()))
    return v9
end
function tbl_upv_1.SeesMatch()
    --[[
      name: SeesMatch
      line: 177
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v10 = tbl_upv_1.InMatch() or (tbl_upv_1.Watching())
    return v10
end
function tbl_upv_1.SeenMatchId()
    --[[
      name: SeenMatchId
      line: 182
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v11
    if tbl_upv_1.InMatch() then
        v11 = tbl_upv_1.Get("MatchId")
    else
        v11 = tbl_upv_1.Get("Spectating")
    end
    if type(v11) ~= "string" then
        return ""
    end
    return v11
end
function tbl_upv_1.MyId()
    --[[
      name: MyId
      line: 187
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    return "p" .. tostring(LocalPlayer_upv_1.UserId)
end
function tbl_upv_1.MyTeam()
    --[[
      name: MyTeam
      line: 192
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v12 = tbl_upv_1.Get("Team")
    if type(v12) == "number" and (v12 == 1 or v12 == 2) then
        return v12
    end
    local Match_3 = tbl_upv_1.Match
    if not Match_3 or not Match_3.teams then
        return 1
    end
    local v13 = tbl_upv_1.MyId()
    for n_1 = 1, 2 do
        local v14 = Match_3.teams[n_1]
        for _, value_3 in (v14 and (v14.members)) or {} do
            if value_3.id ~= v13 then
                continue
            end
            return n_1
        end
    end
    return 1
end
function tbl_upv_1.IsAlive()
    --[[
      name: IsAlive
      line: 212
      upvalues:
        tbl_upv_1 (copy, index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
    ]]
    local v15 = nil
    if tbl_upv_1.InMatch() then
        v15 = tbl_upv_1.Get("Alive")
        if v15 ~= nil then
            return v15 == true
        end
    end
    local Character_1 = LocalPlayer_upv_1.Character
    local v16 = Character_1 and (Character_1:FindFirstChildOfClass("Humanoid"))
    local v17 = false
    if v16 ~= nil then
        v17 = v16.Health > 0
    end
    return v17
end
local function num(a1, a2)
    --[[
      name: num
      line: 226
    ]]
    if type(a1) ~= "number" then
        return a2
    end
    return a1
end
function tbl_upv_1.Level()
    --[[
      name: Level
      line: 231
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v18 = tbl_upv_1.Get("Level")
    local level_1 = tbl_upv_1.Profile.level
    local v19
    if type(level_1) ~= "number" then
        v19 = 1
    else
        v19 = level_1
    end
    if type(v18) ~= "number" then
        return v19
    end
    return v18
end
function tbl_upv_1.Xp()
    --[[
      name: Xp
      line: 234
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v20 = tbl_upv_1.Get("XP")
    local xp_1 = tbl_upv_1.Profile.xp
    local v21
    if type(xp_1) ~= "number" then
        v21 = 0
    else
        v21 = xp_1
    end
    if type(v20) ~= "number" then
        return v21
    end
    return v20
end
local u3 = false
function tbl_upv_1.XpToNext(a1)
    --[[
      name: XpToNext
      line: 241
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u3 (ref,  index: 2)
        ReplicatedStorage_upv_1 (copy, index: 3)
    ]]
    local v22 = a1 or (tbl_upv_1.Level())
    if a1 == nil and type(tbl_upv_1.Profile.xpToNext) == "number" and tbl_upv_1.Profile.xpToNext > 0 then
        return tbl_upv_1.Profile.xpToNext
    end
    local v23 = nil
    if u3 == false then
        u3 = nil
        v23 = ReplicatedStorage_upv_1.Shared:FindFirstChild("Progression")
        if v23 and v23:IsA("ModuleScript") then
            local success_1, v24 = pcall(require, v23)
            if success_1 and type(v24) == "table" then
                u3 = v24
            end
        end
    end
    if u3 then
        local v25 = nil
        for _, value_4 in {"XpToNext", "XpForLevel", "XPToNext", "XpRequired"} do
            local v26 = u3[value_4]
            if type(v26) ~= "function" then
                continue
            end
            local success_2, v25 = pcall(v26, v22)
            if not (success_2) or type(v25) ~= "number" or not (v25 > 0) then
                continue
            end
            return v25
        end
    end
    return 100 + ((v22 - 1) * 50)
end
function tbl_upv_1.Owns(a1)
    --[[
      name: Owns
      line: 270
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local owned_1 = tbl_upv_1.Profile.owned
    local v27 = (type(owned_1) == "table") and (owned_1[a1] == true)
    return v27
end
function tbl_upv_1.LoadoutSlotCount()
    --[[
      name: LoadoutSlotCount
      line: 278
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local loadouts_1 = tbl_upv_1.Profile.loadouts
    if type(loadouts_1) == "table" and #loadouts_1 >= 1 then
        return (math.min(#loadouts_1, 5))
    end
    return 1
end
function tbl_upv_1.ActiveLoadout()
    --[[
      name: ActiveLoadout
      line: 282
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local activeLoadout_1 = tbl_upv_1.Profile.activeLoadout
    local v28 = tbl_upv_1.LoadoutSlotCount()
    if type(activeLoadout_1) == "number" and activeLoadout_1 >= 1 and activeLoadout_1 <= v28 then
        return (math.floor(activeLoadout_1))
    end
    return 1
end
function tbl_upv_1.HasLoadoutSlots()
    --[[
      name: HasLoadoutSlots
      line: 287
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v29 = (type(tbl_upv_1.Profile.loadouts) == "table") and (#tbl_upv_1.Profile.loadouts >= 1)
    return v29
end
function tbl_upv_1.LoadoutName(a1)
    --[[
      name: LoadoutName
      line: 290
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local loadoutNames_1 = tbl_upv_1.Profile.loadoutNames
    local v30 = (type(loadoutNames_1) == "table") and (loadoutNames_1[a1])
    if type(v30) == "string" and v30 ~= "" then
        return v30
    end
    return "LOADOUT " .. a1
end
function tbl_upv_1.LoadoutCustomName(a1)
    --[[
      name: LoadoutCustomName
      line: 295
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local loadoutNames_2 = tbl_upv_1.Profile.loadoutNames
    local v31 = (type(loadoutNames_2) == "table") and (loadoutNames_2[a1])
    if type(v31) ~= "string" then
        return ""
    end
    return v31
end
function tbl_upv_1.LoadoutSlot(a1)
    --[[
      name: LoadoutSlot
      line: 300
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local loadouts_2 = tbl_upv_1.Profile.loadouts
    if type(loadouts_2) == "table" and type(loadouts_2[a1]) == "table" then
        return tbl_upv_1.NormalizeLoadout(loadouts_2[a1])
    end
    return tbl_upv_1.Loadout()
end
function tbl_upv_1.Loadout()
    --[[
      name: Loadout
      line: 309
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    return tbl_upv_1.NormalizeLoadout(tbl_upv_1.Profile.loadout)
end
function tbl_upv_1.NormalizeLoadout(a1)
    --[[
      name: NormalizeLoadout
      line: 312
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    if type(a1) == "table" then
        if type(a1.items) ~= "table" then
            local tbl_8 = {}
            for _, value_5 in {"primary", "secondary", "melee", "utility"} do
                if type(a1[value_5]) == "string" then
                    table.insert(tbl_8, a1[value_5])
                end
            end
            local tbl_9 = {armor = false}
            tbl_9.items = tbl_8
            return tbl_9
        else
            local tbl_10 = {ammo = 0, armor = 0}
            tbl_10.items = a1.items
            local v32
            if type(a1.armor) ~= "string" or a1.armor == "" then
                v32 = false
            else
                v32 = a1.armor
            end
            tbl_10.armor = v32
            if type(a1.ammo) ~= "table" then
                v32 = nil
            else
                v32 = a1.ammo
            end
            tbl_10.ammo = v32
            return tbl_10
        end
    else
        local tbl_11 = {}
        tbl_11.items = table.clone(tbl_upv_2.items)
        tbl_11.armor = tbl_upv_2.armor
        return tbl_11
    end
end
function tbl_upv_1.SetProfile(a1, a2)
    --[[
      name: SetProfile
      line: 333
      upvalues:
        tbl_upv_1 (copy, index: 1)
        defaultProfile (copy, index: 2)
        tbl_upv_2 (copy, index: 3)
    ]]
    if type(a1) == "table" then
        local v33
        if a2 then
            v33 = tbl_upv_1.Profile
        else
            v33 = defaultProfile()
        end
        for key_2, value_6 in a1 do
            v33[key_2] = value_6
        end
        if type(v33.owned) ~= "table" then
            v33.owned = {}
        end
        if type(v33.loadout) ~= "table" then
            local v34 = tbl_upv_2
            v33.loadout = {items = table.clone(v34.items), armor = v34.armor}
        end
        if type(v33.stats) ~= "table" then
            v33.stats = defaultProfile().stats
        end
        tbl_upv_1.Profile = v33
        tbl_upv_1.HasProfile = true
        tbl_upv_1.ProfileChanged:Fire(v33)
    end
end
function tbl_upv_1.Refresh()
    --[[
      name: Refresh
      line: 355
      upvalues:
        Remotes_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    task.spawn(
        function()
            --[[
              line: 356
              upvalues:
                Remotes_upv_1 (copy, index: 1)
                tbl_upv_1 (copy, index: 2)
            ]]
            local v35, v36 = Remotes_upv_1.Invoke("GetProfile")
            if not v35 or type(v36) ~= "table" or (tbl_upv_1.Mock) then
                return
            end
            tbl_upv_1.SetProfile(v36)
        end
    )
end
Remotes_upv_1.On(
    "ProfileChanged",
    function(a1)
        --[[
          line: 364
          upvalues:
            tbl_upv_1 (copy, index: 1)
        ]]
        if type(a1) ~= "table" or (tbl_upv_1.Mock) then
            return
        end
        tbl_upv_1.SetProfile(a1)
    end
)
local function normalizeSnapshot(a1)
    --[[
      name: normalizeSnapshot
      line: 371
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    if type(a1) ~= "table" then
        return nil
    end
    a1.teams = type(a1.teams) ~= "table" and {} or a1.teams
    local v38, v39, v39, v39 = nil, nil, nil, nil
    for n_2 = 1, 2 do
        v38 = a1.teams[n_2]
        if type(v38) ~= "table" then
            v39 = {members = 0, name = 0, score = 0}
            v39.name = ((n_2 ~= 1) and "Raven") or "Wolf"
            v39.members = {}
            a1.teams[n_2] = v39
            v38 = v39
        end
        if type(v38.members) ~= "table" then
            v39 = {}
        else
            v39 = v38.members
        end
        v38.members = v39
        local score_1 = v38.score
        if type(score_1) ~= "number" then
            v39 = 0
        else
            v39 = score_1
        end
        v38.score = v39
        if type(v38.name) ~= "string" then
            v39 = "Tribe " .. n_2
        else
            v39 = v38.name
        end
        v38.name = v39
    end
    local roundsToWin_1 = a1.roundsToWin
    local DEFAULT_ROUNDS_TO_WIN_1 = tbl_upv_1.DEFAULT_ROUNDS_TO_WIN
    local v40
    if type(roundsToWin_1) ~= "number" then
        v40 = DEFAULT_ROUNDS_TO_WIN_1
    else
        v40 = roundsToWin_1
    end
    a1.roundsToWin = v40
    local round_1 = a1.round
    if type(round_1) ~= "number" then
        v40 = 1
    else
        v40 = round_1
    end
    a1.round = v40
    local phaseEndsAt_1 = a1.phaseEndsAt
    if type(phaseEndsAt_1) ~= "number" then
        v40 = 0
    else
        v40 = phaseEndsAt_1
    end
    a1.phaseEndsAt = v40
    return a1
end
function tbl_upv_1.InjectSnapshot(a1)
    --[[
      name: InjectSnapshot
      line: 392
      upvalues:
        tbl_upv_1 (copy, index: 1)
        normalizeSnapshot (copy, index: 2)
    ]]
    tbl_upv_1.Match = normalizeSnapshot(a1)
    tbl_upv_1.MatchChanged:Fire(tbl_upv_1.Match)
end
function tbl_upv_1.FindMember(a1)
    --[[
      name: FindMember
      line: 398
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local Match_4 = tbl_upv_1.Match
    if Match_4 and type(a1) == "string" then
        for n_3 = 1, 2 do
            for _, value_7 in Match_4.teams[n_3].members do
                if value_7.id ~= a1 then
                    continue
                end
                return value_7, n_3
            end
        end
    end
    return nil, nil
end
function tbl_upv_1.IsAllyTeam(a1)
    --[[
      name: IsAllyTeam
      line: 414
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v41 = a1 == tbl_upv_1.MyTeam()
    return v41
end
local mode_upv_1 = nil
function tbl_upv_1.InjectEvent(a1, a2)
    --[[
      name: InjectEvent
      line: 419
      upvalues:
        tbl_upv_1 (copy, index: 1)
        mode_upv_1 (ref,  index: 2)
    ]]
    if type(a1) ~= "string" then
        return
    end
    if type(a2) ~= "table" then
        local tbl_12 = {}
        a2 = tbl_12
    end
    local Match_5 = tbl_upv_1.Match
    if a1 == "Elimination" then
        local v42 = nil
        if Match_5 then
            v42 = tbl_upv_1.FindMember(a2.victimId)
            if v42 and v42.alive ~= false then
                v42.alive = false
                tbl_upv_1.MatchChanged:Fire(Match_5)
            end
        elseif a1 == "RoundStart" and Match_5 then
            for _, value_8 in Match_5.teams[1].members do
                value_8.alive = true
            end
            for _, value_9 in Match_5.teams[2].members do
                value_9.alive = true
            end
            tbl_upv_1.MatchChanged:Fire(Match_5)
        end
    elseif a1 == "RoundStart" and Match_5 then
        for _, value_8 in Match_5.teams[1].members do
            value_8.alive = true
        end
        for _, value_9 in Match_5.teams[2].members do
            value_9.alive = true
        end
        tbl_upv_1.MatchChanged:Fire(Match_5)
    end
    if a1 == "MatchStart" then
        local v42
        if type(a2.mode) ~= "string" then
            v42 = nil
        else
            v42 = a2.mode
        end
        mode_upv_1 = v42
    elseif a1 == "MatchEnd" and type(a2.mode) == "string" then
        mode_upv_1 = a2.mode
    end
    tbl_upv_1.MatchEvent:Fire(a1, a2)
end
Remotes_upv_1.On(
    "MatchState",
    function(a1)
        --[[
          line: 450
          upvalues:
            tbl_upv_1 (copy, index: 1)
        ]]
        if tbl_upv_1.Mock then
            return
        end
        tbl_upv_1.InjectSnapshot(a1)
    end
)
Remotes_upv_1.On(
    "MatchEvent",
    function(a1, a2)
        --[[
          line: 456
          upvalues:
            tbl_upv_1 (copy, index: 1)
        ]]
        if tbl_upv_1.Mock then
            return
        end
        tbl_upv_1.InjectEvent(a1, a2)
    end
)
function tbl_upv_1.FetchMatch()
    --[[
      name: FetchMatch
      line: 463
      upvalues:
        Remotes_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    task.spawn(
        function()
            --[[
              line: 464
              upvalues:
                Remotes_upv_1 (copy, index: 1)
                tbl_upv_1 (copy, index: 2)
            ]]
            local v43, v44 = Remotes_upv_1.Invoke("GetMatchState")
            if not v43 or type(v44) ~= "table" or (tbl_upv_1.Mock) then
                return
            end
            tbl_upv_1.InjectSnapshot(v44)
        end
    )
end
function tbl_upv_1.PhaseTimeLeft()
    --[[
      name: PhaseTimeLeft
      line: 473
      upvalues:
        tbl_upv_1 (copy, index: 1)
        Workspace_upv_1 (copy, index: 2)
    ]]
    local Match_6 = tbl_upv_1.Match
    local v45 = (Match_6 and (Match_6.phaseEndsAt)) or 0
    if v45 and not (v45 <= 0) or not (Match_6) or not (Match_6.matchId) then
        return (math.max(0, (v45 or 0) - tbl_upv_1.Now()))
    end
    local Arenas_1 = Workspace_upv_1:FindFirstChild("Arenas")
    local v46 = Arenas_1 and (Arenas_1:FindFirstChild(tostring(Match_6.matchId)))
    local v47 = v46 and (v46:GetAttribute("PhaseEndsAt"))
    if type(v47) ~= "number" then
        v45 = 0
    else
        v45 = v47
    end
    return (math.max(0, (v45 or 0) - tbl_upv_1.Now()))
end
function tbl_upv_1.Phase()
    --[[
      name: Phase
      line: 485
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local Match_7 = tbl_upv_1.Match
    return (Match_7 and (Match_7.phase)) or nil
end
local u4 = nil
local u5 = nil
function tbl_upv_1.PhaseClock()
    --[[
      name: PhaseClock
      line: 496
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u5 (ref,  index: 2)
        u4 (ref,  index: 3)
        Workspace_upv_1 (copy, index: 4)
    ]]
    local Match_8 = tbl_upv_1.Match
    local v48 = nil
    if not (tbl_upv_1.Mock) then
        v48 = tbl_upv_1.Get("MatchId")
        if type(v48) == "string" and v48 ~= "" then
            local v50 = nil
            if u5 ~= v48 or not (u4) or u4.Parent == nil then
                local Arenas_2 = Workspace_upv_1:FindFirstChild("Arenas")
                v50 = Arenas_2 and (Arenas_2:FindFirstChild(v48))
                u4 = v50
                if u4 then
                    v50 = v48
                else
                    v50 = nil
                end
                u5 = v50
            end
            if u4 then
                v50 = u4:GetAttribute("Phase")
                local v51 = nil
                if type(v50) == "string" then
                    v51 = u4:GetAttribute("PhaseEndsAt")
                    local v52 = u4:GetAttribute("Round")
                    local v53
                    if type(v51) ~= "number" then
                        v53 = 0
                    else
                        v53 = v51
                    end
                    if type(v52) ~= "number" then
                        return v50, v53, (Match_8 and (Match_8.round)) or 1
                    end
                    return v50, v53, v52
                end
            end
        end
    end
    if Match_8 then
        return Match_8.phase, Match_8.phaseEndsAt or 0, Match_8.round or 1
    end
    return nil, 0, 1
end
function tbl_upv_1.MatchMode()
    --[[
      name: MatchMode
      line: 526
      upvalues:
        tbl_upv_1 (copy, index: 1)
        Workspace_upv_1 (copy, index: 2)
        mode_upv_1 (ref,  index: 3)
    ]]
    local v54 = tbl_upv_1.Get("MatchId")
    if not (tbl_upv_1.Mock) and type(v54) == "string" then
        local v55 = nil
        if v54 ~= "" then
            local Arenas_3 = Workspace_upv_1:FindFirstChild("Arenas")
            local v56 = Arenas_3 and (Arenas_3:FindFirstChild(v54))
            local v57 = v56
            v55 = v57 and (v56:GetAttribute("Mode"))
            if v55 ~= "1v1" and v55 ~= "3v3" then
                if mode_upv_1 ~= "1v1" then
                    return "3v3"
                end
                return "1v1"
            end
            return v57
        end
    end
    if mode_upv_1 ~= "1v1" then
        return "3v3"
    end
    return "1v1"
end
function tbl_upv_1.IsDuel()
    --[[
      name: IsDuel
      line: 538
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v58 = tbl_upv_1.MatchMode() == "1v1"
    return v58
end
function tbl_upv_1.TeamSize(a1)
    --[[
      name: TeamSize
      line: 542
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v59 = a1 or (tbl_upv_1.Match and (tbl_upv_1.Match.teams))
    local v60 = 0
    if type(v59) == "table" then
        for n_4 = 1, 2 do
            local v61 = v59[n_4]
            if type(v61) == "table" and type(v61.members) == "table" then
                v60 = math.max(v60, #v61.members)
            end
        end
    end
    if v60 > 0 then
        return v60
    end
    return 3
end
Remotes_upv_1.On(
    "Leaderboards",
    function(a1)
        --[[
          line: 557
          upvalues:
            tbl_upv_1 (copy, index: 1)
        ]]
        if type(a1) ~= "table" or (tbl_upv_1.Mock) then
            return
        end
        tbl_upv_1.Leaderboards = a1
        tbl_upv_1.LeaderboardsChanged:Fire(a1)
    end
)
function tbl_upv_1.InjectLeaderboards(a1)
    --[[
      name: InjectLeaderboards
      line: 564
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    tbl_upv_1.Leaderboards = a1
    tbl_upv_1.LeaderboardsChanged:Fire(a1)
end
Remotes_upv_1.On(
    "Notify",
    function(a1, a2)
        --[[
          line: 569
          upvalues:
            tbl_upv_1 (copy, index: 1)
        ]]
        tbl_upv_1.Notify:Fire(a1, a2)
    end
)
function tbl_upv_1.Start()
    --[[
      name: Start
      line: 574
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    tbl_upv_1.Refresh()
    task.spawn(
        function()
            --[[
              line: 577
              upvalues:
                tbl_upv_1 (copy, index: 1)
            ]]
            for _ = 1, 6 do
                task.wait(2.5)
                if tbl_upv_1.HasProfile then
                    break
                else
                    tbl_upv_1.Refresh()
                end
            end
        end
    )
    if tbl_upv_1.InMatch() then
        tbl_upv_1.FetchMatch()
    end
    tbl_upv_1.PlayerStateChanged:Connect(
        function(a1)
            --[[
              line: 589
              upvalues:
                tbl_upv_1 (copy, index: 1)
            ]]
            if a1 == "Match" then
                tbl_upv_1.FetchMatch()
            elseif a1 == "Lobby" and not (tbl_upv_1.Mock) and not (tbl_upv_1.Watching()) then
                tbl_upv_1.Match = nil
                tbl_upv_1.MatchChanged:Fire(nil)
                tbl_upv_1.Refresh()
            end
        end
    )
    tbl_upv_1.WatchChanged:Connect(
        function(a2)
            --[[
              line: 598
              upvalues:
                tbl_upv_1 (copy, index: 1)
            ]]
            if a2 then
                tbl_upv_1.FetchMatch()
            elseif not (tbl_upv_1.InMatch()) and not (tbl_upv_1.Mock) then
                tbl_upv_1.Match = nil
                tbl_upv_1.MatchChanged:Fire(nil)
            end
        end
    )
    if not tbl_upv_1.Watching() then
        return
    end
    tbl_upv_1.FetchMatch()
end
return tbl_upv_1