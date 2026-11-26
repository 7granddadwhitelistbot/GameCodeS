local v1 = {
    MAX_LEVEL = 200,
    REWARDS = {participation = {xp = 40}, win = {xp = 60}, kill = {xp = 15}, assist = {xp = 5}, roundWon = {xp = 15}, mvp = {xp = 25}, streak = {xp = 8}},
    KILL_CAP = 12,
    ASSIST_CAP = 12,
    STREAK_CAP = 5,
    ROOKIE_MATCHES = 3,
    ROOKIE_XP_MULT = 1.5,
    XpToNext = (function(a2: number)
        --[[
          name: XpToNext
          line: 33
        ]]
        local v3 = math.max(1, (math.floor(a2))) - 1
        return math.floor((((v3 * 150) + 200 + ((v3 * 10) * v3)) / 5) + 0.5) * 5
    end)
}

function v1.AddXp(a4, xp, a6: number)
    --[[
      name: AddXp
      line: 46
      upvalues:
        v1 (copy, index: 1)
    ]]
    local level
    a4 = math.clamp(math.floor(a4), 1, v1.MAX_LEVEL)
    xp = math.max(0, (math.floor(xp))) + math.max(0, (math.floor(a6)))
    local count = 0

    while a4 < v1.MAX_LEVEL and v1.XpToNext(a4) <= xp do
        xp -= v1.XpToNext(a4)
        a4 += 1
        count += 1
    end

    if v1.MAX_LEVEL <= a4 then
        xp = math.min(xp, v1.XpToNext(a4))
    end

    return {level = level, xp = xp, levelsGained = count}
end

function v1.MatchRewards(a9)
    --[[
      name: MatchRewards
      line: 75
      upvalues:
        v1 (copy, index: 1)
    ]]
    local v10
    local xp
    local rewards = v1.REWARDS
    local lines = {}

    local function add(label, a16, a17)
        --[[
          name: add
          line: 78
          upvalues:
            lines (copy, index: 1)
        ]]
        if 0 < a16 then
            table.insert(lines, {label = label, xp = a17.xp * a16})
        end
    end

    local participation = rewards.participation
    table.insert(lines, {label = "Match played", xp = participation.xp * 1})

    if a9.won then
        local win = rewards.win
        table.insert(lines, {label = "Victory", xp = win.xp * 1})
    end

    local clampedValue = math.clamp(math.floor(a9.kills), 0, v1.KILL_CAP)
    local kill = rewards.kill

    if 0 < clampedValue then
        table.insert(lines, {label = "Eliminations", xp = kill.xp * clampedValue})
    end

    local clampedValue2 = math.clamp(math.floor((a9.assists or 0)), 0, v1.ASSIST_CAP)
    local assist = rewards.assist

    if 0 < clampedValue2 then
        table.insert(lines, {label = "Assists", xp = assist.xp * clampedValue2})
    end

    local clampedValue3 = math.clamp(math.floor(a9.roundsWon), 0, 20)
    local roundWon = rewards.roundWon

    if 0 < clampedValue3 then
        table.insert(lines, {label = "Rounds won", xp = roundWon.xp * clampedValue3})
    end

    if a9.mvp then
        local mvp = rewards.mvp
        table.insert(lines, {label = "MVP", xp = mvp.xp * 1})
    end

    if a9.won and 2 <= a9.streak then
        local v27 = math.min(a9.streak, v1.STREAK_CAP)
        local streak = rewards.streak

        if 0 < v27 then
            table.insert(lines, {label = "Win streak", xp = streak.xp * v27})
        end
    end

    local v29 = 0
    v10 = v29

    for _, v31 in lines do
        v10 += v31.xp
    end

    if a9.matchesPlayed < v1.ROOKIE_MATCHES then
        local xp2 = math.floor(v10 * (v1.ROOKIE_XP_MULT - 1))
        table.insert(lines, {label = "Rookie bonus", xp = xp2})
        v10 += xp2
        xp = v10
    else
        xp = v10
    end

    return {xp = xp, lines = lines}
end

v1.MMR_MIN = 0
v1.MMR_MAX = 4000

function v1.MmrDelta(a33, a34, a35, a36, a37)
    --[[
      name: MmrDelta
      line: 116
    ]]
    local v38
    local v39
    local clampedValue = math.clamp((a37 or 0), 0, 1)
    local clampedValue2 = math.clamp((a35 - a36) * 2, -10, 10)

    if a33 then
        v38 = (1 - (clampedValue * 0.35)) * 22 + clampedValue2
    else
        v38 = clampedValue2 * 0.5 + -18
    end

    local clampedValue3 = math.clamp((a34 - 1000) / 1500, -0.5, 0.5)

    if not (0 < v38) then
        v39 = v38 * (clampedValue3 + 1)
    else
        v39 = v38 * (1 - clampedValue3)
    end

    return (math.floor(v39 + 0.5))
end

v1.FIRST_MATCH_BOT_DIFFICULTY = 0.03

function v1.BotDifficulty(a43, a44)
    --[[
      name: BotDifficulty
      line: 143
      upvalues:
        v1 (copy, index: 1)
    ]]
    local v45 = a44 or 99

    if v45 < 1 then
        return v1.FIRST_MATCH_BOT_DIFFICULTY
    end
    if v45 < 3 then
        return 0.1
    end

    local v46 = math.clamp(((a43 - 1000) / 1400) + 0.3, 0.1, 0.95)

    if v45 < 6 then
        v46 = math.min(v46, 0.16)
    end

    return v46
end

return v1