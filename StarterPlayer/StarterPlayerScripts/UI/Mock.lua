local players = game:GetService("Players")
local workspace = game:GetService("Workspace")

return {
    Init = (function(a3)
        --[[
          name: Init
          line: 20
          upvalues:
            players (copy, index: 1)
            workspace (copy, index: 2)
        ]]
        local state = a3.State
        local localPlayer = players.LocalPlayer
        local mvpId = state.MyId()
        local count = 0

        local function mockProfile()
            --[[
              name: mockProfile
              line: 26
              upvalues:
                state (copy, index: 1)
            ]]
            local loadout = {armor = false, items = {"longbow", "obsidian_dagger", "bandage", "smoke_bomb"}, ammo = {arrows = 2}}
            local _ = {}
            state.SetProfile(
                {
                    level = 7,
                    xp = 340,
                    xpToNext = 505,
                    activeLoadout = 1,
                    owned = {},
                    loadout = loadout,
                    loadouts = {{armor = false, items = {"longbow", "obsidian_dagger", "bandage", "smoke_bomb"}, ammo = {arrows = 2}}, {armor = false, items = {"short_bow", "bronze_sword", "throwing_knives", "bandage", "smoke_bomb"}, ammo = {arrows = 1}}, {armor = "hide_armor", items = {"battle_axe", "throwing_knives", "fire_bomb"}}, {armor = "bronze_armor", items = {"war_club", "bandage"}}, {armor = false, items = {"short_bow", "healing_tonic", "smoke_bomb", "bear_trap"}, ammo = {arrows = 1}}},
                    loadoutNames = {"Sniper", "", "Brawler", "Tank", "Support"},
                    stats = {matches = 12, wins = 7, losses = 5, kills = 41, deaths = 22, streak = 2, bestStreak = 4, roundsWon = 38},
                    settings = {}
                }
            )
            state.SetMockAttr("Level", 7)
            state.SetMockAttr("XP", 340)
        end

        local v11 = {"Grimtooth", "Ashfang", "Mossback", "Redhawk", "Stonejaw", "Quickreed", "Emberly", "Thornwick"}

        local function member(id, name: string, userId, isBot: boolean, kills: number, deaths: number, damage: number, level: number)
            --[[
              name: member
              line: 52
            ]]
            return {alive = true, connected = true, assists = 1, id = id, name = name, userId = userId, isBot = isBot, kills = kills, deaths = deaths, damage = damage, level = level, loadout = {primary = "short_bow", secondary = "throwing_knives", melee = "bronze_sword", utility = "fire_bomb"}}
        end

        local v21 = nil

        local function newSnapshot()
            --[[
              name: newSnapshot
              line: 69
              upvalues:
                v21 (ref,  index: 1)
                state (copy, index: 2)
                member (copy, index: 3)
                mvpId (copy, index: 4)
                localPlayer (copy, index: 5)
                v11 (copy, index: 6)
            ]]
            v21 = {
                matchId = "mock",
                mapId = "SunstoneTemple",
                mapName = "Sunstone Temple",
                mapThumb = "",
                phase = "Intro",
                round = 1,
                roundsToWin = 3,
                ringRadius = 0,
                ringCenter = false,
                phaseEndsAt = state.Now() + 4,
                teams = {{name = "Wolf", score = 0, members = {member(mvpId, localPlayer.DisplayName, localPlayer.UserId, false, 0, 0, 0, 7), member("b1", v11[1], false, true, 0, 0, 0, 5), (member("p1", "Roblox", 1, false, 0, 0, 0, 12))}}, {name = "Raven", score = 0, members = {member("b2", v11[2], false, true, 0, 0, 0, 6), member("b3", v11[3], false, true, 0, 0, 0, 4), (member("p2", "builderman", 156, false, 0, 0, 0, 9))}}}
            }
            return v21
        end

        local function push()
            --[[
              name: push
              line: 104
              upvalues:
                state (copy, index: 1)
                v21 (ref,  index: 2)
            ]]
            state.InjectSnapshot(v21)
        end

        local function setPhase(phase, a26)
            --[[
              name: setPhase
              line: 107
              upvalues:
                v21 (ref,  index: 1)
                state (copy, index: 2)
            ]]
            v21.phase = phase
            v21.phaseEndsAt = state.Now() + a26
            state.InjectSnapshot(v21)
        end

        local function find(a28)
            --[[
              name: find
              line: 112
              upvalues:
                v21 (ref, index: 1)
            ]]
            for teamKey = 1, 2 do
                for _, member in v21.teams[teamKey].members do
                    if member.id == a28 then
                        return member, teamKey
                    end
                end
            end

            return nil, nil
        end

        local function eliminate(a33, victimId, a35: string, a36: boolean)
            --[[
              name: eliminate
              line: 122
              upvalues:
                find (copy, index: 1)
                state (copy, index: 2)
                v21 (ref,  index: 3)
                mvpId (copy, index: 4)
            ]]
            local v37, victimTeam = find(victimId)
            local v39 = if a33 then find(a33) else nil

            if not v37 then
                return
            end

            v37.alive = false
            v37.deaths += 1

            if v39 then
                v39.kills += 1
                v39.damage += 100
            end

            local injectEvent = state.InjectEvent
            local v41 = {assistId = false, killerTeam = 0, killerId = a33 or false, victimId = victimId, weaponId = a35
                or false, headshot = a36 == true, killerName = if v39 then v39.name else false}
            v41.victimName = v37.name
            v41.victimTeam = victimTeam
            injectEvent("Elimination", v41)
            state.InjectSnapshot(v21)

            if victimId == mvpId then
                state.SetMockAttr("Alive", false)
            end
        end

        local function resetAlive()
            --[[
              name: resetAlive
              line: 150
              upvalues:
                v21 (ref,  index: 1)
                state (copy, index: 2)
            ]]
            for _, member in v21.teams[1].members do
                member.alive = true
            end

            for _, member in v21.teams[2].members do
                member.alive = true
            end

            state.SetMockAttr("Alive", true)
            state.SetMockAttr("SpectateMode", "none")
        end

        local v47 = {
            intro = (function()
                --[[
                  line: 161
                  upvalues:
                    newSnapshot (copy, index: 1)
                    state (copy, index: 2)
                    v21 (ref,  index: 3)
                ]]
                newSnapshot()
                state.SetMockAttr("State", "Match")
                state.SetMockAttr("MatchId", "mock")
                state.SetMockAttr("Team", 1)
                state.SetMockAttr("Alive", true)
                state.InjectSnapshot(v21)
                state.InjectEvent("MatchStart", {matchId = "mock", mapName = v21.mapName, mapThumb = v21.mapThumb, teams = v21.teams})
            end)
        }

        v47.preround = function()
            --[[
              line: 170
              upvalues:
                v21 (ref,  index: 1)
                v47 (copy, index: 2)
                resetAlive (copy, index: 3)
                state (copy, index: 4)
            ]]
            if not v21 then
                v47.intro()
            end

            resetAlive()
            v21.phase = "PreRound"
            v21.phaseEndsAt = state.Now() + 8
            state.InjectSnapshot(v21)
            state.InjectEvent("RoundStart", {round = v21.round})
        end

        v47.live = function()
            --[[
              line: 178
              upvalues:
                v21 (ref,  index: 1)
                v47 (copy, index: 2)
                state (copy, index: 3)
            ]]
            if not v21 then
                v47.intro()
            end

            v21.phase = "Live"
            v21.phaseEndsAt = state.Now() + 75
            state.InjectSnapshot(v21)
        end

        v47.feed = function()
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

        v47.mykill = function(a48)
            --[[
              line: 191
              upvalues:
                eliminate (copy, index: 1)
                mvpId (copy, index: 2)
            ]]
            eliminate(mvpId, (a48 or "b2"), "short_bow", true)
        end

        v47.death = function()
            --[[
              line: 194
              upvalues:
                eliminate (copy, index: 1)
                mvpId (copy, index: 2)
                state (copy, index: 3)
            ]]
            eliminate("p2", mvpId, "musket", true)
            state.SetMockAttr("SpectateMode", "death")
        end

        v47.follow = function()
            --[[
              line: 198
              upvalues:
                state (copy, index: 1)
                v11 (copy, index: 2)
            ]]
            state.SetMockAttr("SpectateMode", "follow")
            state.SetMockAttr("SpectateTargetId", "b1")
            state.SetMockAttr("SpectateTargetName", v11[1])
        end

        v47.roundend = function(a49)
            --[[
              line: 203
              upvalues:
                v21 (ref,  index: 1)
                state (copy, index: 2)
                mvpId (copy, index: 3)
            ]]
            local v50 = a49 or 1
            local team = v21.teams[v50]
            team.score += 1
            v21.phase = "RoundEnd"
            v21.phaseEndsAt = state.Now() + 4
            state.InjectSnapshot(v21)
            state.InjectEvent("RoundEnd", {round = v21.round, winnerTeam = v50, mvpId = mvpId})
        end

        v47.overtime = function()
            --[[
              line: 209
              upvalues:
                v21 (ref,  index: 1)
                state (copy, index: 2)
            ]]
            v21.phase = "Overtime"
            v21.phaseEndsAt = state.Now() + 25
            state.InjectSnapshot(v21)
            v21.ringRadius = 90
            state.InjectEvent("Overtime", {})
        end

        v47.matchend = function(a52)
            --[[
              line: 214
              upvalues:
                v21 (ref,  index: 1)
                v47 (copy, index: 2)
                find (copy, index: 3)
                mvpId (copy, index: 4)
                state (copy, index: 5)
            ]]
            local state2
            local winnerTeam
            local streak
            local after

            if not v21 then
                v47.intro()
            end

            local won = a52 ~= false

            if const v58 = find(mvpId) then
                v58.kills = 9
                v58.deaths = 3
                v58.damage = 1240
            end

            if const v59 = find("b1") then
                v59.kills = 4
                v59.damage = 610
            end

            if const v60 = find("p2") then
                v60.kills = 7
                v60.damage = 980
            end

            v21.teams[1].score = won and 2 or 1
            local team = v21.teams[2]

            if won then
                state2 = 1
                state2 = state
            else
                state2 = 2
                state2 = state
            end

            team.score = state2
            v21.phase = "MatchEnd"
            v21.phaseEndsAt = state2.Now() + 10
            state2.InjectSnapshot(v21)
            local injectEvent = state2.InjectEvent
            local v63 = {}

            if won then
                winnerTeam = 1
            else
                winnerTeam = 2
            end

            v63.winnerTeam = winnerTeam
            v63.mvpId = mvpId
            local you = {kills = 9, deaths = 3, assists = 2, damage = 1240, xp = 420, levelBefore = 7, levelAfter = 8, xpBefore = 340, xpAfter = 255, xpToNextBefore = 505, xpToNextAfter = 605}

            if won then
                streak = 3
            else
                streak = 0
            end

            you.streak = streak
            you.won = won
            local trophies = {before = 0, rankBefore = 1, rankAfter = 1, floor = false}

            if won then
                after = 30
            else
                after = 0
            end

            trophies.after = after
            trophies.delta = won and 30 or 0
            you.trophies = trophies
            you.tribe = {tag = "SURF", renown = 3, mates = 1}
            you.lines = {{label = "Match played", xp = 40}, {label = "Victory", xp = 60}, {label = "Eliminations", xp = 120}, {label = "Assists", xp = 5}, {label = "Rounds won", xp = 45}, {label = "MVP", xp = 25}, {label = "Win streak", xp = 24}, {label = "Rookie bonus", xp = 159}}
            v63.you = you
            injectEvent("MatchEnd", v63)
        end

        local count2 = 0

        v47.unqueue = function()
            --[[
              line: 269
              upvalues:
                count2 (ref,  index: 1)
                state (copy, index: 2)
            ]]
            count2 += 1
            state.SetMockAttr("QueueFound", false)
            state.SetMockAttr("QueuedAt", 0)
            state.SetMockAttr("Queued", false)
        end

        v47.found = function()
            --[[
              line: 275
              upvalues:
                state (copy, index: 1)
            ]]
            state.SetMockAttr("QueueFound", true)
        end

        v47.queue = function(a67)
            --[[
              line: 278
              upvalues:
                count2 (ref,  index: 1)
                state (copy, index: 2)
                v47 (copy, index: 3)
            ]]
            count2 += 1
            local v68 = count2
            state.SetMockAttr("QueueFound", false)
            state.SetMockAttr("QueuedAt", state.Now())
            state.SetMockAttr("Queued", true)

            if a67 and 0 < a67 then
                task.delay(
                    a67,
                    function()
                        --[[
                          line: 285
                          upvalues:
                            v68 (copy, index: 1)
                            count2 (ref,  index: 2)
                            state (copy, index: 3)
                            v47 (copy, index: 4)
                        ]]
                        if v68 == count2 and state.Mock then
                            v47.found()
                        end
                    end
                )
            end
        end

        v47.lowhp = function(a69)
            --[[
              line: 292
              upvalues:
                localPlayer (copy, index: 1)
            ]]
            local instance = localPlayer.Character
            instance = instance and instance:FindFirstChildOfClass("Humanoid")

            if instance then
                instance.Health = a69 or 22
            end
        end

        local function stop()
            --[[
              name: stop
              line: 300
              upvalues:
                count (ref,  index: 1)
                state (copy, index: 2)
                a3 (copy, index: 3)
                v21 (ref,  index: 4)
            ]]
            count += 1
            state.Mock = nil
            a3.Fighters.TrustAllUserIds = false
            v21 = nil
            state.ClearMockAttrs()
            state.InjectSnapshot(nil)
            state.Refresh()
            state.FetchMatch()
        end

        local function run(mock)
            --[[
              name: run
              line: 311
              upvalues:
                state (copy, index: 1)
                count (ref,  index: 2)
                a3 (copy, index: 3)
                v21 (ref,  index: 4)
                mockProfile (copy, index: 5)
                localPlayer (copy, index: 6)
                v11 (copy, index: 7)
                v47 (copy, index: 8)
            ]]
            if mock ~= nil and mock ~= "" then
                count += 1
                local v74 = count
                state.Mock = mock
                a3.Fighters.TrustAllUserIds = true
                state.ClearMockAttrs()
                mockProfile()

                if mock == "lobby" then
                    state.SetMockAttr("State", "Lobby")

                    local function board(a76: number)
                        --[[
                          name: board
                          line: 326
                          upvalues:
                            localPlayer (copy, index: 1)
                            v11 (copy, index: 2)
                        ]]
                        local v77 = {}

                        for index = 1, 10 do
                            local v79
                            local v80 = {}

                            if index == 3 then
                                v79 = localPlayer.UserId
                            else
                                v79 = index % 3 == 0 and 1 or -index
                            end

                            v80.userId = v79
                            v80.name = if index == 3 then localPlayer.DisplayName else v11[((index + a76) % #v11) + 1]
                            v80.value = math.floor(900 / index) + a76
                            v77[index] = v80
                        end

                        return v77
                    end

                    state.InjectLeaderboards({Wins = board(0), Kills = board(3), Level = board(5)})

                    return
                end

                if mock == "match" then
                    task.spawn(
                        function()
                            --[[
                              line: 335
                              upvalues:
                                v47 (copy, index: 1)
                                v74 (copy, index: 2)
                                count (ref,  index: 3)
                                v21 (ref,  index: 4)
                            ]]
                            v47.intro()
                            task.wait(4)

                            if v74 ~= count then
                                return
                            end

                            v47.preround()
                            task.wait(3)

                            if v74 ~= count then
                                return
                            end

                            v47.live()
                            task.wait(2)

                            if v74 ~= count then
                                return
                            end

                            v47.mykill("b2")
                            task.wait(2.5)

                            if v74 ~= count then
                                return
                            end

                            v47.feed()
                            task.wait(2)

                            if v74 ~= count then
                                return
                            end

                            v47.mykill("b3")
                            task.wait(3)

                            if v74 ~= count then
                                return
                            end

                            v47.roundend(1)
                            task.wait(4)

                            if v74 ~= count then
                                return
                            end

                            local v81 = v21
                            v81.round += 1
                            v47.preround()
                            task.wait(3)

                            if v74 ~= count then
                                return
                            end

                            v47.live()
                        end
                    )

                    return
                end

                if mock == "matchend" then
                    v47.intro()
                    a3.SetHudHidden("Intro", false)
                    v47.live()
                    v47.matchend(true)
                end

                return
            end

            if state.Mock then
                count += 1
                state.Mock = nil
                a3.Fighters.TrustAllUserIds = false
                v21 = nil
                state.ClearMockAttrs()
                state.InjectSnapshot(nil)
                state.Refresh()
                state.FetchMatch()
            end
        end

        a3.Debug._mockProfileAction = function(a82, activeLoadout, a84)
            --[[
              line: 388
              upvalues:
                state (copy, index: 1)
            ]]
            local profile = state.Profile
            local substring = nil

            if a82 == "SetLoadout" then
                if type(activeLoadout) == "table" then
                    local ammo
                    local v88
                    local loadout = {items = table.clone((activeLoadout.items or {})), armor = activeLoadout.armor
                        or false}

                    if type(activeLoadout.ammo) ~= "table" then
                        ammo = nil
                    else
                        ammo = table.clone(activeLoadout.ammo)
                    end

                    loadout.ammo = ammo

                    if type(a84) ~= "number" then
                        v88 = profile.activeLoadout or 1
                    else
                        v88 = a84
                    end

                    if type(profile.loadouts) == "table" then
                        profile.loadouts[v88] = loadout
                    end

                    if v88 == (profile.activeLoadout or 1) then
                        profile.loadout = loadout
                    end
                end
            elseif a82 == "SelectLoadout" then
                if type(profile.loadouts) ~= "table"
                    or type(activeLoadout) ~= "number"
                    or not profile.loadouts[activeLoadout]
                then
                    return false, "Bad slot"
                end

                profile.activeLoadout = activeLoadout
                profile.loadout = profile.loadouts[activeLoadout]
            elseif a82 == "RenameLoadout" then
                if type(profile.loadoutNames) ~= "table" or type(activeLoadout) ~= "number" then
                    return false, "Bad slot"
                end

                substring = string.sub(tostring((a84 or "")), 1, 16)
                profile.loadoutNames[activeLoadout] = substring
            end

            task.defer(
                function()
                    --[[
                      line: 416
                      upvalues:
                        state (copy, index: 1)
                        profile (copy, index: 2)
                    ]]
                    state.ProfileChanged:Fire(profile)
                end
            )

            return true, nil, substring
        end

        a3.Debug._mockQueueAction = function(a90)
            --[[
              line: 423
              upvalues:
                v47 (copy, index: 1)
                count2 (ref,  index: 2)
                state (copy, index: 3)
                count (ref,  index: 4)
                a3 (copy, index: 5)
                mockProfile (copy, index: 6)
                v21 (ref,  index: 7)
                run (copy, index: 8)
            ]]
            if a90 == "Queue" or a90 == "PlayAgain" then
                v47.queue(2.5)
                local v91 = count2

                task.delay(
                    3.7,
                    function()
                        --[[
                          line: 427
                          upvalues:
                            v91 (copy, index: 1)
                            count2 (ref,  index: 2)
                            state (copy, index: 3)
                            v47 (copy, index: 4)
                            count (ref,  index: 5)
                            a3 (copy, index: 6)
                            mockProfile (copy, index: 7)
                            v21 (ref,  index: 8)
                        ]]
                        if v91 == count2 and state.Mock and state.Get("QueueFound") == true then
                            v47.unqueue()
                            count += 1
                            local v92 = count
                            state.Mock = "match"
                            a3.Fighters.TrustAllUserIds = true
                            state.ClearMockAttrs()
                            mockProfile()

                            task.spawn(
                                function()
                                    --[[
                                      line: 335
                                      upvalues:
                                        v47 (copy, index: 1)
                                        v92 (copy, index: 2)
                                        count (ref,  index: 3)
                                        v21 (ref,  index: 4)
                                    ]]
                                    v47.intro()
                                    task.wait(4)

                                    if v92 ~= count then
                                        return
                                    end

                                    v47.preround()
                                    task.wait(3)

                                    if v92 ~= count then
                                        return
                                    end

                                    v47.live()
                                    task.wait(2)

                                    if v92 ~= count then
                                        return
                                    end

                                    v47.mykill("b2")
                                    task.wait(2.5)

                                    if v92 ~= count then
                                        return
                                    end

                                    v47.feed()
                                    task.wait(2)

                                    if v92 ~= count then
                                        return
                                    end

                                    v47.mykill("b3")
                                    task.wait(3)

                                    if v92 ~= count then
                                        return
                                    end

                                    v47.roundend(1)
                                    task.wait(4)

                                    if v92 ~= count then
                                        return
                                    end

                                    local v93 = v21
                                    v93.round += 1
                                    v47.preround()
                                    task.wait(3)

                                    if v92 ~= count then
                                        return
                                    end

                                    v47.live()
                                end
                            )
                        end
                    end
                )
            elseif a90 == "Cancel" then
                v47.unqueue()
            elseif a90 == "LeaveMatch" then
                run("lobby")
            end

            return true, nil
        end

        a3.Debug.mock = function(mock)
            --[[
              line: 441
              upvalues:
                run (copy, index: 1)
                state (copy, index: 2)
            ]]
            run(mock)
            return state.Mock or "off"
        end

        a3.Debug.mockStep = function(key, ...)
            --[[
              line: 445
              upvalues:
                v47 (copy, index: 1)
                state (copy, index: 2)
                a3 (copy, index: 3)
                mockProfile (copy, index: 4)
                count (ref,  index: 5)
            ]]
            local v96 = v47[key]
            if not v96 then
                return "unknown step " .. tostring(key)
            end

            if not state.Mock then
                state.Mock = "match"
                a3.Fighters.TrustAllUserIds = true
                mockProfile()
            end

            count += 1
            v96(...)

            return true
        end

        local function fromAttr()
            --[[
              name: fromAttr
              line: 460
              upvalues:
                workspace (copy, index: 1)
                run (copy, index: 2)
            ]]
            local uiMock
            local uiMock2 = workspace:GetAttribute("UIMock")

            if type(uiMock2) ~= "string" then
                uiMock = nil
            else
                uiMock = uiMock2
            end

            run(uiMock)
        end

        workspace:GetAttributeChangedSignal("UIMock"):Connect(fromAttr)

        if workspace:GetAttribute("UIMock") then
            task.delay(1, fromAttr)
        end
    end)
}