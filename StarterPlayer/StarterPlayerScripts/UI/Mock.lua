local Players_upv_1 = game:GetService("Players")
local Workspace_upv_1 = game:GetService("Workspace")
local tbl_1 = {}
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 20
      upvalues:
        Players_upv_1 (copy, index: 1)
        Workspace_upv_1 (copy, index: 2)
    ]]
    local State_upv_1 = a1.State
    local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
    local u1 = State_upv_1.MyId()
    local u2 = 0
    local tbl_upv_2 = {"Grimtooth", "Ashfang", "Mossback", "Redhawk", "Stonejaw", "Quickreed", "Emberly", "Thornwick"}
    local u3 = nil
    local function member(a2, a3, a4, a5, a6, a7, a8, a9)
        --[[
          name: member
          line: 52
        ]]
        local tbl_3 = {connected = true, alive = true, assists = 1}
        tbl_3.id = a2
        tbl_3.name = a3
        tbl_3.userId = a4
        tbl_3.isBot = a5
        tbl_3.kills = a6
        tbl_3.deaths = a7
        tbl_3.damage = a8
        tbl_3.level = a9
        tbl_3.loadout = {utility = "fire_bomb", primary = "short_bow", melee = "bronze_sword", secondary = "throwing_knives"}
        return tbl_3
    end
    local function newSnapshot()
        --[[
          name: newSnapshot
          line: 69
          upvalues:
            u3 (ref,  index: 1)
            State_upv_1 (copy, index: 2)
            member (copy, index: 3)
            u1 (copy, index: 4)
            LocalPlayer_upv_1 (copy, index: 5)
            tbl_upv_2 (copy, index: 6)
        ]]
        local tbl_4 = {mapId = "SunstoneTemple", phase = "Intro", mapName = "Sunstone Temple", roundsToWin = 3, mapThumb = "", ringCenter = false, ringRadius = 0, round = 1, matchId = "mock"}
        tbl_4.phaseEndsAt = State_upv_1.Now() + 4
        tbl_4.teams = {{name = "Wolf", score = 0, members = {member(u1, LocalPlayer_upv_1.DisplayName, LocalPlayer_upv_1.UserId, false, 0, 0, 0, 7), member("b1", tbl_upv_2[1], false, true, 0, 0, 0, 5), member("p1", "Roblox", 1, false, 0, 0, 0, 12)}}, {name = "Raven", score = 0, members = {member("b2", tbl_upv_2[2], false, true, 0, 0, 0, 6), member("b3", tbl_upv_2[3], false, true, 0, 0, 0, 4), member("p2", "builderman", 156, false, 0, 0, 0, 9)}}}
        u3 = tbl_4
        return u3
    end
    local function push()
        --[[
          name: push
          line: 104
          upvalues:
            State_upv_1 (copy, index: 1)
            u3 (ref,  index: 2)
        ]]
        State_upv_1.InjectSnapshot(u3)
    end
    local function setPhase(a10, a11)
        --[[
          name: setPhase
          line: 107
          upvalues:
            u3 (ref,  index: 1)
            State_upv_1 (copy, index: 2)
        ]]
        u3.phase = a10
        u3.phaseEndsAt = State_upv_1.Now() + a11
        State_upv_1.InjectSnapshot(u3)
    end
    local function find(a12)
        --[[
          name: find
          line: 112
          upvalues:
            u3 (ref, index: 1)
        ]]
        for n_1 = 1, 2 do
            for _, value_1 in u3.teams[n_1].members do
                if value_1.id ~= a12 then
                    continue
                end
                return value_1, n_1
            end
        end
        return nil, nil
    end
    local function eliminate(a13, a14, a15, a16)
        --[[
          name: eliminate
          line: 122
          upvalues:
            find (copy, index: 1)
            State_upv_1 (copy, index: 2)
            u3 (ref,  index: 3)
            u1 (copy, index: 4)
        ]]
        local v1, _ = find(a14)
        local v2
        if a13 then
            v2 = find(a13)
        else
            v2 = nil
        end
        if not v1 then
            return
        end
        v1.alive = false
        v1.deaths = v1.deaths + 1
        if v2 then
            v2.kills = v2.kills + 1
            v2.damage = v2.damage + 100
        end
        local InjectEvent_1 = State_upv_1.InjectEvent
        local v3 = "Elimination"
        local tbl_5 = {killerTeam = 0, killerName = 0, headshot = 0, victimName = 0, assistId = false, victimTeam = 0}
        tbl_5.killerId = a13 or false
        tbl_5.victimId = a14
        tbl_5.weaponId = a15 or false
        tbl_5.headshot = a16 == true
        local v4
        if v2 then
            v4 = v2.name
        else
            v4 = false
        end
        tbl_5.killerName = v4
        tbl_5.victimName = v1.name
        tbl_5.victimTeam = nil
        InjectEvent_1(v3, tbl_5)
        State_upv_1.InjectSnapshot(u3)
        if a14 ~= u1 then
            return
        end
        State_upv_1.SetMockAttr("Alive", false)
    end
    local function resetAlive()
        --[[
          name: resetAlive
          line: 150
          upvalues:
            u3 (ref,  index: 1)
            State_upv_1 (copy, index: 2)
        ]]
        for _, value_2 in u3.teams[1].members do
            value_2.alive = true
        end
        for _, value_3 in u3.teams[2].members do
            value_3.alive = true
        end
        State_upv_1.SetMockAttr("Alive", true)
        State_upv_1.SetMockAttr("SpectateMode", "none")
    end
    local tbl_upv_6 = {}
    tbl_upv_6.intro = function()
        --[[
          line: 161
          upvalues:
            newSnapshot (copy, index: 1)
            State_upv_1 (copy, index: 2)
            u3 (ref,  index: 3)
        ]]
        newSnapshot()
        State_upv_1.SetMockAttr("State", "Match")
        State_upv_1.SetMockAttr("MatchId", "mock")
        State_upv_1.SetMockAttr("Team", 1)
        State_upv_1.SetMockAttr("Alive", true)
        State_upv_1.InjectSnapshot(u3)
        State_upv_1.InjectEvent("MatchStart", {matchId = "mock", mapName = u3.mapName, mapThumb = u3.mapThumb, teams = u3.teams})
    end
    tbl_upv_6.preround = function()
        --[[
          line: 170
          upvalues:
            u3 (ref,  index: 1)
            tbl_upv_6 (copy, index: 2)
            resetAlive (copy, index: 3)
            State_upv_1 (copy, index: 4)
        ]]
        if not (u3) then
            tbl_upv_6.intro()
        end
        resetAlive()
        u3.phase = "PreRound"
        u3.phaseEndsAt = State_upv_1.Now() + 8
        State_upv_1.InjectSnapshot(u3)
        State_upv_1.InjectEvent("RoundStart", {round = u3.round})
    end
    tbl_upv_6.live = function()
        --[[
          line: 178
          upvalues:
            u3 (ref,  index: 1)
            tbl_upv_6 (copy, index: 2)
            State_upv_1 (copy, index: 3)
        ]]
        if not (u3) then
            tbl_upv_6.intro()
        end
        u3.phase = "Live"
        u3.phaseEndsAt = State_upv_1.Now() + 75
        State_upv_1.InjectSnapshot(u3)
    end
    tbl_upv_6.feed = function()
        --[[
          line: 184
          upvalues:
            eliminate (copy, index: 1)
        ]]
        eliminate("b2", "b1", "longbow", false)
        task.wait(0.4)
        eliminate("p1", "b3", "throwing_knives", true)
        task.wait(0.4)
        eliminate("p2", "p1", "war_club", false)
    end
    tbl_upv_6.mykill = function(a17)
        --[[
          line: 191
          upvalues:
            eliminate (copy, index: 1)
            u1 (copy, index: 2)
        ]]
        eliminate(u1, a17 or "b2", "short_bow", true)
    end
    tbl_upv_6.death = function()
        --[[
          line: 194
          upvalues:
            eliminate (copy, index: 1)
            u1 (copy, index: 2)
            State_upv_1 (copy, index: 3)
        ]]
        eliminate("p2", u1, "musket", true)
        State_upv_1.SetMockAttr("SpectateMode", "death")
    end
    tbl_upv_6.follow = function()
        --[[
          line: 198
          upvalues:
            State_upv_1 (copy, index: 1)
            tbl_upv_2 (copy, index: 2)
        ]]
        State_upv_1.SetMockAttr("SpectateMode", "follow")
        State_upv_1.SetMockAttr("SpectateTargetId", "b1")
        State_upv_1.SetMockAttr("SpectateTargetName", tbl_upv_2[1])
    end
    tbl_upv_6.roundend = function(a18)
        --[[
          line: 203
          upvalues:
            u3 (ref,  index: 1)
            State_upv_1 (copy, index: 2)
            u1 (copy, index: 3)
        ]]
        local v5 = a18 or 1
        local v6 = u3.teams[v5]
        v6.score = v6.score + 1
        u3.phase = "RoundEnd"
        u3.phaseEndsAt = State_upv_1.Now() + 4
        State_upv_1.InjectSnapshot(u3)
        State_upv_1.InjectEvent("RoundEnd", {round = u3.round, winnerTeam = v5, mvpId = u1})
    end
    tbl_upv_6.overtime = function()
        --[[
          line: 209
          upvalues:
            u3 (ref,  index: 1)
            State_upv_1 (copy, index: 2)
        ]]
        u3.phase = "Overtime"
        u3.phaseEndsAt = State_upv_1.Now() + 25
        State_upv_1.InjectSnapshot(u3)
        u3.ringRadius = 90
        State_upv_1.InjectEvent("Overtime", {})
    end
    tbl_upv_6.matchend = function(a19)
        --[[
          line: 214
          upvalues:
            u3 (ref,  index: 1)
            tbl_upv_6 (copy, index: 2)
            find (copy, index: 3)
            u1 (copy, index: 4)
            State_upv_1 (copy, index: 5)
        ]]
        if not (u3) then
            tbl_upv_6.intro()
        end
        local v7 = a19 ~= false
        local v8 = find(u1)
        if v8 then
            v8.kills = 9
            v8.deaths = 3
            v8.damage = 1240
        end
        local v9 = find("b1")
        if v9 then
            v9.kills = 4
            v9.damage = 610
        end
        local v10 = find("p2")
        if v10 then
            v10.kills = 7
            v10.damage = 980
        end
        local v11 = u3.teams[1]
        v11.score = (v7 and 2) or 1
        local v12 = u3.teams[2]
        v12.score = (v7 and 1) or 2
        u3.phase = "MatchEnd"
        u3.phaseEndsAt = State_upv_1.Now() + 10
        State_upv_1.InjectSnapshot(u3)
        local InjectEvent_2 = State_upv_1.InjectEvent
        local tbl_7 = {winnerTeam = 0, you = 0, mvpId = 0}
        tbl_7.winnerTeam = (v7 and 1) or 2
        tbl_7.mvpId = u1
        local tbl_8 = {streak = 0, deaths = 3, xpToNextAfter = 605, lines = 0, levelBefore = 7, won = 0, assists = 2, tribe = 0, trophies = 0, kills = 9, levelAfter = 8, xpAfter = 255, xpBefore = 340, xpToNextBefore = 505, xp = 420, damage = 1240}
        tbl_8.streak = (v7 and 3) or 0
        tbl_8.won = v7
        local tbl_9 = {before = 0, after = 0, rankBefore = 1, rankAfter = 1, delta = 0, floor = false}
        tbl_9.after = (v7 and 30) or 0
        tbl_9.delta = (v7 and 30) or 0
        tbl_8.trophies = tbl_9
        tbl_8.tribe = {mates = 1, renown = 3, tag = "SURF"}
        tbl_8.lines = {{xp = 40, label = "Match played"}, {xp = 60, label = "Victory"}, {xp = 120, label = "Eliminations"}, {xp = 5, label = "Assists"}, {xp = 45, label = "Rounds won"}, {xp = 25, label = "MVP"}, {xp = 24, label = "Win streak"}, {xp = 159, label = "Rookie bonus"}}
        tbl_7.you = tbl_8
        InjectEvent_2("MatchEnd", tbl_7)
    end
    local u4 = 0
    tbl_upv_6.unqueue = function()
        --[[
          line: 269
          upvalues:
            u4 (ref,  index: 1)
            State_upv_1 (copy, index: 2)
        ]]
        u4 = u4 + 1
        State_upv_1.SetMockAttr("QueueFound", false)
        State_upv_1.SetMockAttr("QueuedAt", 0)
        State_upv_1.SetMockAttr("Queued", false)
    end
    tbl_upv_6.found = function()
        --[[
          line: 275
          upvalues:
            State_upv_1 (copy, index: 1)
        ]]
        State_upv_1.SetMockAttr("QueueFound", true)
    end
    tbl_upv_6.queue = function(a20)
        --[[
          line: 278
          upvalues:
            u4 (ref,  index: 1)
            State_upv_1 (copy, index: 2)
            tbl_upv_6 (copy, index: 3)
        ]]
        u4 = u4 + 1
        local u5 = u4
        State_upv_1.SetMockAttr("QueueFound", false)
        State_upv_1.SetMockAttr("QueuedAt", State_upv_1.Now())
        State_upv_1.SetMockAttr("Queued", true)
        if not a20 or not (a20 > 0) then
            return
        end
        task.delay(
            a20,
            function()
                --[[
                  line: 285
                  upvalues:
                    u5 (copy, index: 1)
                    u4 (ref,  index: 2)
                    State_upv_1 (copy, index: 3)
                    tbl_upv_6 (copy, index: 4)
                ]]
                if u5 ~= u4 or not State_upv_1.Mock then
                    return
                end
                tbl_upv_6.found()
            end
        )
    end
    tbl_upv_6.lowhp = function(a21)
        --[[
          line: 292
          upvalues:
            LocalPlayer_upv_1 (copy, index: 1)
        ]]
        local Character_1 = LocalPlayer_upv_1.Character
        local v13 = Character_1 and (Character_1:FindFirstChildOfClass("Humanoid"))
        if not v13 then
            return
        end
        v13.Health = a21 or 22
    end
    local function stop()
        --[[
          name: stop
          line: 300
          upvalues:
            u2 (ref,  index: 1)
            State_upv_1 (copy, index: 2)
            a1 (copy, index: 3)
            u3 (ref,  index: 4)
        ]]
        u2 = u2 + 1
        State_upv_1.Mock = nil
        a1.Fighters.TrustAllUserIds = false
        u3 = nil
        State_upv_1.ClearMockAttrs()
        State_upv_1.InjectSnapshot(nil)
        State_upv_1.Refresh()
        State_upv_1.FetchMatch()
    end
    local function mockProfile()
        --[[
          name: mockProfile
          line: 26
          upvalues:
            State_upv_1 (copy, index: 1)
        ]]
        local tbl_10 = {armor = false}
        tbl_10.items = {"longbow", "obsidian_dagger", "bandage", "smoke_bomb"}
        tbl_10.ammo = {arrows = 2}
        local _ = {}
        State_upv_1.SetProfile(
            {
                xp = 340,
                xpToNext = 505,
                activeLoadout = 1,
                level = 7,
                owned = {},
                loadout = tbl_10,
                loadouts = {{armor = false, items = {"longbow", "obsidian_dagger", "bandage", "smoke_bomb"}, ammo = {arrows = 2}}, {armor = false, items = {"short_bow", "bronze_sword", "throwing_knives", "bandage", "smoke_bomb"}, ammo = {arrows = 1}}, {armor = "hide_armor", items = {"battle_axe", "throwing_knives", "fire_bomb"}}, {armor = "bronze_armor", items = {"war_club", "bandage"}}, {armor = false, items = {"short_bow", "healing_tonic", "smoke_bomb", "bear_trap"}, ammo = {arrows = 1}}},
                loadoutNames = {"Sniper", "", "Brawler", "Tank", "Support"},
                stats = {streak = 2, kills = 41, wins = 7, bestStreak = 4, deaths = 22, matches = 12, losses = 5, roundsWon = 38},
                settings = {}
            }
        )
        State_upv_1.SetMockAttr("Level", 7)
        State_upv_1.SetMockAttr("XP", 340)
    end
    local function run(a22)
        --[[
          name: run
          line: 311
          upvalues:
            State_upv_1 (copy, index: 1)
            u2 (ref,  index: 2)
            a1 (copy, index: 3)
            u3 (ref,  index: 4)
            mockProfile (copy, index: 5)
            LocalPlayer_upv_1 (copy, index: 6)
            tbl_upv_2 (copy, index: 7)
            tbl_upv_6 (copy, index: 8)
        ]]
        if a22 ~= nil and a22 ~= "" then
            u2 = u2 + 1
            local _ = u2
            State_upv_1.Mock = a22
            a1.Fighters.TrustAllUserIds = true
            State_upv_1.ClearMockAttrs()
            mockProfile()
            if a22 == "lobby" then
                State_upv_1.SetMockAttr("State", "Lobby")
                local function board_1(a23)
                    --[[
                      name: board
                      line: 326
                      upvalues:
                        LocalPlayer_upv_1 (copy, index: 1)
                        tbl_upv_2 (copy, index: 2)
                    ]]
                    local v14 = {}
                    v14 = nil
                    for n_2 = 1, 10 do
                        local tbl_11 = {value = 0, userId = 0, name = 0}
                        local v15
                        if n_2 ~= 3 then
                            v15 = ((n_2 % 3 == 0) and 1) or (-n_2)
                        else
                            v15 = LocalPlayer_upv_1.UserId
                        end
                        tbl_11.userId = v15
                        if n_2 ~= 3 then
                            v15 = tbl_upv_2[((n_2 + a23) % #tbl_upv_2) + 1]
                        else
                            v15 = LocalPlayer_upv_1.DisplayName
                        end
                        tbl_11.name = v15
                        tbl_11.value = math.floor(900 / n_2) + a23
                        v14[n_2] = tbl_11
                    end
                    return v14
                end
                State_upv_1.InjectLeaderboards({Wins = board_1(0), Kills = board_1(3), Level = board_1(5)})
            elseif a22 == "match" then
                task.spawn(function() end)
            elseif a22 == "matchend" then
                tbl_upv_6.intro()
                a1.SetHudHidden("Intro", false)
                tbl_upv_6.live()
                tbl_upv_6.matchend(true)
            end
            return
        end
        if not State_upv_1.Mock then
            return
        end
        u2 = u2 + 1
        State_upv_1.Mock = nil
        a1.Fighters.TrustAllUserIds = false
        u3 = nil
        State_upv_1.ClearMockAttrs()
        State_upv_1.InjectSnapshot(nil)
        State_upv_1.Refresh()
        State_upv_1.FetchMatch()
    end
    a1.Debug._mockProfileAction = function(a24, a25, a26)
        --[[
          line: 388
          upvalues:
            State_upv_1 (copy, index: 1)
        ]]
        local Profile_upv_1 = State_upv_1.Profile
        local v16 = nil
        if a24 ~= "SetLoadout" then
            if a24 == "SelectLoadout" then
                if type(Profile_upv_1.loadouts) == "table" and type(a25) == "number" and Profile_upv_1.loadouts[a25] then
                    Profile_upv_1.activeLoadout = a25
                    Profile_upv_1.loadout = Profile_upv_1.loadouts[a25]
                    task.defer(
                        function()
                            --[[
                              line: 416
                              upvalues:
                                State_upv_1 (copy, index: 1)
                                Profile_upv_1 (copy, index: 2)
                            ]]
                            State_upv_1.ProfileChanged:Fire(Profile_upv_1)
                        end
                    )
                    return true, nil, v16
                end
                return false, "Bad slot"
            elseif a24 == "RenameLoadout" then
                if type(Profile_upv_1.loadoutNames) == "table" and type(a25) == "number" then
                    local v17 = string.sub(tostring(a26 or ""), 1, 16)
                    Profile_upv_1.loadoutNames[a25] = v17
                    v16 = v17
                    task.defer(
                        function()
                            --[[
                              line: 416
                              upvalues:
                                State_upv_1 (copy, index: 1)
                                Profile_upv_1 (copy, index: 2)
                            ]]
                            State_upv_1.ProfileChanged:Fire(Profile_upv_1)
                        end
                    )
                    return true, nil, v16
                end
                return false, "Bad slot"
            end
        elseif type(a25) == "table" then
            local tbl_12 = {items = 0, ammo = 0, armor = 0}
            tbl_12.items = table.clone(a25.items or {})
            tbl_12.armor = a25.armor or false
            local v18
            if type(a25.ammo) ~= "table" then
                v18 = nil
            else
                v18 = table.clone(a25.ammo)
            end
            tbl_12.ammo = v18
            if type(a26) ~= "number" then
                v18 = Profile_upv_1.activeLoadout or 1
            else
                v18 = a26
            end
            if type(Profile_upv_1.loadouts) == "table" then
                Profile_upv_1.loadouts[v18] = tbl_12
            end
            if v18 == (Profile_upv_1.activeLoadout or 1) then
                Profile_upv_1.loadout = tbl_12
            end
        end
        task.defer(
            function()
                --[[
                  line: 416
                  upvalues:
                    State_upv_1 (copy, index: 1)
                    Profile_upv_1 (copy, index: 2)
                ]]
                State_upv_1.ProfileChanged:Fire(Profile_upv_1)
            end
        )
        return true, nil, v16
    end
    a1.Debug._mockQueueAction = function(a27)
        --[[
          line: 423
          upvalues:
            tbl_upv_6 (copy, index: 1)
            u4 (ref,  index: 2)
            State_upv_1 (copy, index: 3)
            u2 (ref,  index: 4)
            a1 (copy, index: 5)
            mockProfile (copy, index: 6)
            u3 (ref,  index: 7)
            run (copy, index: 8)
        ]]
        if a27 == "Queue" or a27 == "PlayAgain" then
            tbl_upv_6.queue(2.5)
            local u6 = u4
            task.delay(
                3.7,
                function()
                    --[[
                      line: 427
                      upvalues:
                        u6 (copy, index: 1)
                        u4 (ref,  index: 2)
                        State_upv_1 (copy, index: 3)
                        tbl_upv_6 (copy, index: 4)
                        u2 (ref,  index: 5)
                        a1 (copy, index: 6)
                        mockProfile (copy, index: 7)
                        u3 (ref,  index: 8)
                    ]]
                    if u6 ~= u4 or not State_upv_1.Mock then
                        return
                    end
                    if State_upv_1.Get("QueueFound") == true then
                        tbl_upv_6.unqueue()
                        u2 = u2 + 1
                        local u7 = u2
                        State_upv_1.Mock = "match"
                        a1.Fighters.TrustAllUserIds = true
                        State_upv_1.ClearMockAttrs()
                        mockProfile()
                        task.spawn(
                            function()
                                --[[
                                  line: 335
                                  upvalues:
                                    tbl_upv_6 (copy, index: 1)
                                    u7 (copy, index: 2)
                                    u2 (ref,  index: 3)
                                    u3 (ref,  index: 4)
                                ]]
                                tbl_upv_6.intro()
                                task.wait(4)
                                if u7 ~= u2 then
                                    return
                                end
                                tbl_upv_6.preround()
                                task.wait(3)
                                if u7 ~= u2 then
                                    return
                                end
                                tbl_upv_6.live()
                                task.wait(2)
                                if u7 ~= u2 then
                                    return
                                end
                                tbl_upv_6.mykill("b2")
                                task.wait(2.5)
                                if u7 ~= u2 then
                                    return
                                end
                                tbl_upv_6.feed()
                                task.wait(2)
                                if u7 ~= u2 then
                                    return
                                end
                                tbl_upv_6.mykill("b3")
                                task.wait(3)
                                if u7 ~= u2 then
                                    return
                                end
                                tbl_upv_6.roundend(1)
                                task.wait(4)
                                if u7 ~= u2 then
                                    return
                                end
                                u3.round = u3.round + 1
                                tbl_upv_6.preround()
                                task.wait(3)
                                if u7 ~= u2 then
                                    return
                                end
                                tbl_upv_6.live()
                            end
                        )
                    end
                end
            )
        elseif a27 == "Cancel" then
            tbl_upv_6.unqueue()
        elseif a27 == "LeaveMatch" then
            run("lobby")
        end
        return true, nil
    end
    a1.Debug.mock = function(a28)
        --[[
          line: 441
          upvalues:
            run (copy, index: 1)
            State_upv_1 (copy, index: 2)
        ]]
        run(a28)
        return State_upv_1.Mock or "off"
    end
    a1.Debug.mockStep = function(a29, ...)
        --[[
          line: 445
          upvalues:
            tbl_upv_6 (copy, index: 1)
            State_upv_1 (copy, index: 2)
            a1 (copy, index: 3)
            mockProfile (copy, index: 4)
            u2 (ref,  index: 5)
        ]]
        local v19 = tbl_upv_6[a29]
        if v19 then
            if not (State_upv_1.Mock) then
                State_upv_1.Mock = "match"
                a1.Fighters.TrustAllUserIds = true
                mockProfile()
            end
            u2 = u2 + 1
            v19(...)
            return true
        end
        return "unknown step " .. tostring(a29)
    end
    local function fromAttr()
        --[[
          name: fromAttr
          line: 460
          upvalues:
            Workspace_upv_1 (copy, index: 1)
            run (copy, index: 2)
        ]]
        local v20 = Workspace_upv_1:GetAttribute("UIMock")
        local v21
        if type(v20) ~= "string" then
            v21 = nil
        else
            v21 = v20
        end
        run(v21)
    end
    Workspace_upv_1:GetAttributeChangedSignal("UIMock"):Connect(fromAttr)
    if not Workspace_upv_1:GetAttribute("UIMock") then
        return
    end
    task.delay(1, fromAttr)
end
return tbl_1