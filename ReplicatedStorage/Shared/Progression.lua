local tbl_upv_1 = {}
tbl_upv_1.MAX_LEVEL = 200
tbl_upv_1.REWARDS = {participation = {xp = 40}, win = {xp = 60}, kill = {xp = 15}, assist = {xp = 5}, roundWon = {xp = 15}, mvp = {xp = 25}, streak = {xp = 8}}
tbl_upv_1.KILL_CAP = 12
tbl_upv_1.ASSIST_CAP = 12
tbl_upv_1.STREAK_CAP = 5
tbl_upv_1.ROOKIE_MATCHES = 3
tbl_upv_1.ROOKIE_XP_MULT = 1.5
function tbl_upv_1.XpToNext(a1)
    --[[
      name: XpToNext
      line: 33
    ]]
    local v1 = math.max(1, math.floor(a1)) - 1
    return math.floor(((((v1 * 150) + 200) + ((v1 * 10) * v1)) / 5) + 0.5) * 5
end
function tbl_upv_1.AddXp(a1, a2, a3)
    --[[
      name: AddXp
      line: 46
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v2 = math.clamp(math.floor(a1), 1, tbl_upv_1.MAX_LEVEL)
    a2 = math.max(0, math.floor(a2)) + math.max(0, math.floor(a3))
    local v3 = 0
    a1 = v2
    while a1 < tbl_upv_1.MAX_LEVEL do
        if tbl_upv_1.XpToNext(a1) <= a2 then
            a2 = a2 - tbl_upv_1.XpToNext(a1)
            a1 = a1 + 1
            v3 = v3 + 1
            continue
        else
            break
        end
    end
    if tbl_upv_1.MAX_LEVEL <= a1 then
        a2 = math.min(a2, tbl_upv_1.XpToNext(a1))
    end
    local tbl_2 = {}
    tbl_2.level = a1
    tbl_2.xp = a2
    tbl_2.levelsGained = v3
    return tbl_2
end
function tbl_upv_1.MatchRewards(a1)
    --[[
      name: MatchRewards
      line: 75
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local REWARDS_1 = tbl_upv_1.REWARDS
    local tbl_upv_3 = {}
    local function add(a2, a3, a4)
        --[[
          name: add
          line: 78
          upvalues:
            tbl_upv_3 (copy, index: 1)
        ]]
        if not (a3 > 0) then
            return
        end
        table.insert(tbl_upv_3, {label = a2, xp = a4.xp * a3})
    end
    table.insert(tbl_upv_3, {label = "Match played", xp = REWARDS_1.participation.xp * 1})
    if a1.won then
        table.insert(tbl_upv_3, {label = "Victory", xp = REWARDS_1.win.xp * 1})
    end
    local v4 = math.clamp(math.floor(a1.kills), 0, tbl_upv_1.KILL_CAP)
    local kill_1 = REWARDS_1.kill
    if v4 > 0 then
        table.insert(tbl_upv_3, {label = "Eliminations", xp = kill_1.xp * v4})
    end
    local v5 = math.clamp(math.floor(a1.assists or 0), 0, tbl_upv_1.ASSIST_CAP)
    local assist_1 = REWARDS_1.assist
    if v5 > 0 then
        table.insert(tbl_upv_3, {label = "Assists", xp = assist_1.xp * v5})
    end
    local v6 = math.clamp(math.floor(a1.roundsWon), 0, 20)
    local roundWon_1 = REWARDS_1.roundWon
    if v6 > 0 then
        table.insert(tbl_upv_3, {label = "Rounds won", xp = roundWon_1.xp * v6})
    end
    if a1.mvp then
        table.insert(tbl_upv_3, {label = "MVP", xp = REWARDS_1.mvp.xp * 1})
    end
    if a1.won and a1.streak >= 2 then
        local v7 = math.min(a1.streak, tbl_upv_1.STREAK_CAP)
        local streak_1 = REWARDS_1.streak
        if v7 > 0 then
            table.insert(tbl_upv_3, {label = "Win streak", xp = streak_1.xp * v7})
        end
    end
    local v8 = 0
    for _, value_1 in tbl_upv_3 do
        v8 = v8 + value_1.xp
    end
    if a1.matchesPlayed < tbl_upv_1.ROOKIE_MATCHES then
        local v9 = math.floor(v8 * (tbl_upv_1.ROOKIE_XP_MULT - 1))
        table.insert(tbl_upv_3, {label = "Rookie bonus", xp = v9})
        v8 = v8 + v9
        v8 = add
    end
    local tbl_4 = {}
    tbl_4.xp = v8
    tbl_4.lines = tbl_upv_3
    return tbl_4
end
tbl_upv_1.MMR_MIN = 0
tbl_upv_1.MMR_MAX = 4000
function tbl_upv_1.MmrDelta(a1, a2, a3, a4, a5)
    --[[
      name: MmrDelta
      line: 116
    ]]
    local v10 = math.clamp(a5 or 0, 0, 1)
    local v11 = math.clamp((a3 - a4) * 2, -10, 10)
    local v12 = (a1 and ((1 - (v10 * 0.35)) * 22 + v11)) or (v11 * 0.5 + -18)
    local v13 = math.clamp((a2 - 1000) / 1500, -0.5, 0.5)
    if v12 > 0 then
        v12 = v12 * (1 - v13)
    else
        v12 = v12 * (v13 + 1)
    end
    return (math.floor(v12 + 0.5))
end
tbl_upv_1.FIRST_MATCH_BOT_DIFFICULTY = 0.03
function tbl_upv_1.BotDifficulty(a1, a2)
    --[[
      name: BotDifficulty
      line: 143
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v14 = a2 or 99
    if v14 < 1 then
        return tbl_upv_1.FIRST_MATCH_BOT_DIFFICULTY
    end
    if v14 < 3 then
        return 0.1
    end
    local v15 = math.clamp(((a1 - 1000) / 1400) + 0.3, 0.1, 0.95)
    if v14 < 6 then
        v15 = math.min(v15, 0.16)
    end
    return v15
end
return tbl_upv_1