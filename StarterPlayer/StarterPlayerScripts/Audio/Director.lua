local Players_1 = game:GetService("Players")
local ReplicatedStorage_upv_1 = game:GetService("ReplicatedStorage")
local RunService_upv_1 = game:GetService("RunService")
local Workspace_upv_1 = game:GetService("Workspace")
local Sounds_upv_1 = require(ReplicatedStorage_upv_1:WaitForChild("Shared"):WaitForChild("Sounds"))
local Layers_upv_1 = require(script.Parent:WaitForChild("Layers"))
local Emitters_upv_1 = require(script.Parent:WaitForChild("Emitters"))
local tbl_1 = {}
local LocalPlayer_upv_1 = Players_1.LocalPlayer
local u1 = nil
local tbl_upv_2 = {phase = "", inMatch = false, theme = "Lobby", final = false}
local function myId()
    --[[
      name: myId
      line: 49
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    return "p" .. LocalPlayer_upv_1.UserId
end
local function myTeam()
    --[[
      name: myTeam
      line: 53
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local v1 = LocalPlayer_upv_1:GetAttribute("Team")
    if type(v1) ~= "number" then
        return 0
    end
    return v1
end
local function findArena()
    --[[
      name: findArena
      line: 58
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        Workspace_upv_1 (copy, index: 2)
    ]]
    local v2 = LocalPlayer_upv_1:GetAttribute("MatchId")
    if type(v2) == "string" and v2 ~= "" then
        local Arenas_1 = Workspace_upv_1:FindFirstChild("Arenas")
        local v3 = Arenas_1 and (Arenas_1:FindFirstChild(v2))
        return v3
    end
    return nil
end
local function musicFor(a1, a2)
    --[[
      name: musicFor
      line: 87
      upvalues:
        u1 (ref,  index: 1)
        Sounds_upv_1 (copy, index: 2)
    ]]
    local v4 = a2 and (a2:GetAttribute("Music"))
    if type(v4) == "string" and v4 ~= "" and u1.Has(v4) then
        return v4
    end
    local v5 = Sounds_upv_1.THEMES[a1]
    return v5 and (v5.music)
end
local u2 = 0
local tbl_upv_3 = {}
local u3 = Random.new()
local function nextLobbyIndex()
    --[[
      name: nextLobbyIndex
      line: 104
      upvalues:
        tbl_upv_3 (copy, index: 1)
        Sounds_upv_1 (copy, index: 2)
        u3 (copy, index: 3)
        u2 (ref,  index: 4)
    ]]
    if #tbl_upv_3 == 0 then
        for n_1 = 1, #Sounds_upv_1.LOBBY_PLAYLIST do
            tbl_upv_3[n_1] = n_1
        end
        for n_2 = #tbl_upv_3, 2, -1 do
            local v6 = u3:NextInteger(1, n_2)
            local v7 = tbl_upv_3[n_2]
            tbl_upv_3[n_2] = tbl_upv_3[v6]
            tbl_upv_3[v6] = v7
        end
        if #tbl_upv_3 > 1 and tbl_upv_3[#tbl_upv_3] == u2 then
            tbl_upv_3[#tbl_upv_3] = tbl_upv_3[1]
            tbl_upv_3[1] = tbl_upv_3[#tbl_upv_3]
        end
    end
    return (table.remove(tbl_upv_3))
end
local u4 = nil
local u5 = 0
local function nextLobbyTrack()
    --[[
      name: nextLobbyTrack
      line: 123
      upvalues:
        u2 (ref,  index: 1)
        nextLobbyIndex (copy, index: 2)
        Sounds_upv_1 (copy, index: 3)
        Layers_upv_1 (copy, index: 4)
        u4 (ref,  index: 5)
        u5 (ref,  index: 6)
    ]]
    u2 = nextLobbyIndex()
    local v8 = "Music/Lobby" .. u2
    local v9 = Layers_upv_1.Get(v8, Sounds_upv_1.LOBBY_PLAYLIST[u2], 0.5)
    if not v9 then
        return
    end
    v9.sound.Looped = false
    Layers_upv_1.Restart(v8, 1)
    u4 = v8
    u5 = os.clock()
end
local tbl_upv_4 = {RoundEnd = 0.6, Intro = 0.55, MatchEnd = 0, Loading = 0.5, Overtime = 0, Live = 1, PreRound = 0.7}
local tbl_upv_5 = {Live = 1, PreRound = 0.8}
local function updateMusic()
    --[[
      name: updateMusic
      line: 140
      upvalues:
        tbl_upv_2 (copy, index: 1)
        u4 (ref,  index: 2)
        Layers_upv_1 (copy, index: 3)
        u5 (ref,  index: 4)
        nextLobbyTrack (copy, index: 5)
        tbl_upv_4 (copy, index: 6)
        tbl_upv_5 (copy, index: 7)
        u1 (ref,  index: 8)
    ]]
    local v10, _ = nil, nil
    if tbl_upv_2.inMatch then
        Layers_upv_1.FadeAll("Music/Lobby")
        local v11
        if tbl_upv_2.final then
            v11 = tbl_upv_5[tbl_upv_2.phase]
        else
            v11 = nil
        end
        if v11 then
            local v12 = u1.Has("Music/Final_Round")
            if not (v12) then
                v11 = nil
            end
        end
        if tbl_upv_2.music then
            v10 = Layers_upv_1.Get("Music/Match", tbl_upv_2.music, 0.6)
            if v10 then
                v10.sound.Looped = true
                Layers_upv_1.SetTarget("Music/Match", (v11 and 0) or (tbl_upv_4[tbl_upv_2.phase] or 0.8), ((tbl_upv_2.phase == "Overtime") and 1.5) or ((v11 and 1) or 0.6))
            end
        end
        local v13
        if v11 then
            v13 = Layers_upv_1.Get("Music/Final", "Music/Final_Round", 0.9)
        else
            v13 = Layers_upv_1.Find("Music/Final")
        end
        if v13 then
            v13.sound.Looped = true
            if v11 then
                if v13.target == 0 then
                    Layers_upv_1.Restart("Music/Final", v11)
                end
                Layers_upv_1.SetTarget("Music/Final", v11, 0.9)
            else
                Layers_upv_1.SetTarget("Music/Final", 0, ((tbl_upv_2.phase ~= "Overtime") and 0.6) or 1.5)
            end
        end
        v11 = Layers_upv_1.Get("Music/Overtime", "Music/Overtime", 2)
        if v11 then
            v11.sound.Looped = false
            if tbl_upv_2.phase ~= "Overtime" then
                Layers_upv_1.SetTarget("Music/Overtime", 0, 0.8)
            elseif v11.target == 0 then
                Layers_upv_1.Restart("Music/Overtime", 1)
                return
            end
        end
    else
        local v14 = u4 and (Layers_upv_1.Find(u4))
        if v14 and not (v14.ended) and os.clock() - u5 > 8 and v14.sound.TimeLength <= 0 then
            v14.ended = true
        end
        if not (u4) or u4.ended then
            nextLobbyTrack()
        elseif u4.target == 0 then
            Layers_upv_1.Restart(u4.key, 1)
        end
        Layers_upv_1.FadeAll("Music/", {[u4 or ""] = true})
        if u4 then
            Layers_upv_1.SetTarget(u4, 1, 0.5)
        end
    end
end
local u6 = 0
local function ringLevel()
    --[[
      name: ringLevel
      line: 204
      upvalues:
        tbl_upv_2 (copy, index: 1)
        Workspace_upv_1 (copy, index: 2)
    ]]
    local arena_1 = tbl_upv_2.arena
    if arena_1 and tbl_upv_2.phase == "Overtime" then
        local v15 = arena_1:GetAttribute("RingRadius")
        local v16 = arena_1:GetAttribute("RingCenterX")
        local v17 = arena_1:GetAttribute("RingCenterZ")
        local CurrentCamera_1 = Workspace_upv_1.CurrentCamera
        if type(v15) == "number" and not (v15 <= 0) and type(v16) == "number" and type(v17) == "number" and CurrentCamera_1 then
            local Position_1 = CurrentCamera_1.Focus.Position
            local Magnitude_1 = Vector2.new(Position_1.X - v16, Position_1.Z - v17).Magnitude
            if v15 <= Magnitude_1 then
                return 1
            end
            return (math.clamp(1 - ((v15 - Magnitude_1) / 45), 0.25, 1))
        end
        return 0.35
    end
    return 0
end
local function updateAmbience()
    --[[
      name: updateAmbience
      line: 223
      upvalues:
        Sounds_upv_1 (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
        Layers_upv_1 (copy, index: 3)
        ringLevel (copy, index: 4)
        u6 (ref,  index: 5)
        Workspace_upv_1 (copy, index: 6)
        u1 (ref,  index: 7)
    ]]
    local v18 = Sounds_upv_1.THEMES[tbl_upv_2.theme] or (Sounds_upv_1.THEMES.Default)
    local tbl_6 = {}
    local v19 = ((tbl_upv_2.phase ~= "MatchEnd") and 1) or 0.6
    for _, value_1 in v18.beds do
        local v20 = "Amb/" .. value_1[1]
        local v21 = Layers_upv_1.Get(v20, value_1[1], 0.5)
        if v21 then
            v21.sound.Looped = true
            Layers_upv_1.SetTarget(v20, value_1[2] * v19, 0.5)
            tbl_6[v20] = true
        end
    end
    local v22 = ringLevel()
    if v22 > 0 then
        local v23 = Layers_upv_1.Get("Amb/Ring", "Match/Ring_Fire_Loop", 1.5)
        if v23 then
            v23.sound.Looped = true
            Layers_upv_1.SetTarget("Amb/Ring", v22, 1.5)
            tbl_6["Amb/Ring"] = true
        end
    end
    Layers_upv_1.FadeAll("Amb/", tbl_6)
    local v24 = os.clock()
    if u6 <= v24 then
        local v25 = v18.every or {8, 16}
        local v26 = math.random()
        u6 = (v24 + v25[1]) + (v26 * (v25[2] - v25[1]))
        local sweeteners_1 = v18.sweeteners
        local v27 = Workspace_upv_1.CurrentCamera
        if not sweeteners_1 or not (#sweeteners_1 > 0) or not v27 then
            return
        end
        if tbl_upv_2.phase ~= "MatchEnd" then
            local v28 = math.random() * math.pi * 2
            local v29 = 25 + math.random() * 35
            local v30 = v27.Focus.Position + Vector3.new(math.cos(v28) * v29, 6 + (math.random() * 14), math.sin(v28) * v29)
            u1.Play(sweeteners_1[math.random(1, #sweeteners_1)], v30)
        end
    end
end
local u7 = 0
local u8 = 0
local function duckForBanner(a1)
    --[[
      name: duckForBanner
      line: 270
      upvalues:
        u1 (ref, index: 1)
    ]]
    u1.Duck("Music", 0.35, a1)
    u1.Duck("Ambient", 0.6, a1)
end
local function onPhase(a1, a2)
    --[[
      name: onPhase
      line: 275
      upvalues:
        u8 (ref,  index: 1)
        tbl_upv_2 (copy, index: 2)
        u1 (ref,  index: 3)
        u7 (ref,  index: 4)
        Workspace_upv_1 (copy, index: 5)
    ]]
    u8 = u8 + 1
    local u9 = u8
    local arena_2 = tbl_upv_2.arena
    if a1 == "Intro" then
        u1.Play("Match/Intro")
        u1.Duck("Music", 0.35, 3)
        u1.Duck("Ambient", 0.6, 3)
    elseif a1 ~= "PreRound" then
        if a1 ~= "Live" or a2 ~= "PreRound" then
            if a1 == "Overtime" then
                u1.Play("Match/Overtime_Warning")
                u1.Duck("Music", 0.35, 3)
                u1.Duck("Ambient", 0.6, 3)
            end
            return
        end
        u1.Play("Match/Fight")
        u1.Duck("Music", 0.35, 2.5)
        u1.Duck("Ambient", 0.6, 2.5)
    else
        u7 = 0
        u1.Play("Match/Spawn")
        local v31 = arena_2 and (arena_2:GetAttribute("PhaseEndsAt"))
        if type(v31) ~= "number" then
            return
        end
        local v32 = Workspace_upv_1:GetServerTimeNow()
        for n_upv_3 = 3, 1, -1 do
            local v33 = arena_2 - n_upv_3
            if v32 - 0.1 < v33 then
                task.delay(
                    math.max(0, v33 - v32),
                    function()
                        --[[
                          line: 291
                          upvalues:
                            u8 (ref,  index: 1)
                            u9 (copy, index: 2)
                            u1 (ref,  index: 3)
                            n_upv_3 (copy, index: 4)
                        ]]
                        if u8 ~= u9 then
                            return
                        end
                        u1.Play("Match/Countdown_" .. n_upv_3)
                    end
                )
            end
        end
    end
end
local function onMatchEvent(a1, a2)
    --[[
      name: onMatchEvent
      line: 308
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        u1 (ref,  index: 2)
        u7 (ref,  index: 3)
    ]]
    if type(a2) == "table" then
        local v34 = nil
        if a1 == "Elimination" then
            local v35 = "p" .. LocalPlayer_upv_1.UserId
            v34 = LocalPlayer_upv_1:GetAttribute("Team")
            local v36
            if type(v34) ~= "number" then
                v36 = 0
            else
                v36 = v34
            end
            if a2.victimId == v35 then
                u1.Play("Death")
                u1.Duck("Music", 0.35, 3)
                u1.Duck("Ambient", 0.6, 3)
                return
            elseif a2.killerId ~= v35 then
                if v36 ~= 0 and a2.victimTeam == v36 then
                    u1.Play("Teammate_Down")
                    return
                end
                if v36 ~= 0 and a2.killerTeam == v36 then
                    u1.Play("Kill_Ally")
                    return
                end
            else
                u7 = u7 + 1
                u1.Play("Match/Elimination")
                if u7 == 2 then
                    task.delay(0.35, u1.Play, "Kill_Double")
                    return
                elseif u7 >= 3 then
                    task.delay(0.35, u1.Play, "Kill_Triple")
                    return
                end
            end
        elseif a1 == "RoundEnd" then
            local winnerTeam_1 = a2.winnerTeam
            v34 = LocalPlayer_upv_1:GetAttribute("Team")
            local v36
            if type(v34) ~= "number" then
                v36 = 0
            else
                v36 = v34
            end
            if winnerTeam_1 == 0 then
                u1.Play("Match/Round_Draw")
            elseif winnerTeam_1 ~= v36 then
                u1.Play("Match/Round_Lose")
            else
                u1.Play("Match/Round_Win")
            end
            u1.Duck("Music", 0.35, 4)
            u1.Duck("Ambient", 0.6, 4)
            return
        elseif a1 == "MatchEnd" then
            local v35
            if type(a2.you) ~= "table" then
                v35 = false
                local v37 = nil
                if a2.winnerTeam ~= nil then
                    local winnerTeam_2 = a2.winnerTeam
                    v37 = LocalPlayer_upv_1:GetAttribute("Team")
                    if type(v37) ~= "number" then
                        v34 = 0
                    else
                        v34 = v37
                    end
                    if winnerTeam_2 == v34 then
                        v35 = true
                    else
                        v35 = false
                    end
                end
            else
                v35 = true
                if a2.you.won ~= true then
                    v35 = false
                    local v37 = nil
                    if a2.winnerTeam == nil then
                        v35 = v38
                    else
                        local winnerTeam_2 = a2.winnerTeam
                        v37 = LocalPlayer_upv_1:GetAttribute("Team")
                        if type(v37) ~= "number" then
                            v34 = 0
                        else
                            v34 = v37
                        end
                        if winnerTeam_2 == v34 then
                            v35 = true
                        else
                            v35 = false
                        end
                    end
                end
            end
            local Play_1 = u1.Play
            if v35 then
                v34 = "Match/Victory"
            else
                v34 = "Match/Defeat"
            end
            Play_1(v34)
            u1.Duck("Ambient", 0.5, 6)
        end
    end
end
local u10 = nil
local u11 = nil
local function setHeart(a1, a2)
    --[[
      name: setHeart
      line: 355
      upvalues:
        u10 (ref, index: 1)
        u11 (ref, index: 2)
        u1 (ref, index: 3)
    ]]
    if (a1 > 0) and ((a1 < 35) and (a2 > 0)) then
        if not (u10) then
            u10, u11 = u1.Loop("LowHealth_Heartbeat", nil, {fadeIn = 0.4})
        end
        if not u11 then
            return
        end
        u11.PlaybackSpeed = ((1 - (a1 / 35)) * 0.25) + 1
    elseif u10 then
        u10(0.6)
        u10 = nil
        u11 = nil
    end
end
local function watchCharacter(a1)
    --[[
      name: watchCharacter
      line: 371
      upvalues:
        setHeart (copy, index: 1)
        u10 (ref,  index: 2)
        u11 (ref,  index: 3)
    ]]
    local u12 = a1:WaitForChild("Humanoid", 10)
    if not u12 or not u12:IsA("Humanoid") then
        return
    end
    setHeart(u12.Health, u12.MaxHealth)
    u12.HealthChanged:Connect(
        function(a2)
            --[[
              line: 378
              upvalues:
                setHeart (copy, index: 1)
                u12 (copy, index: 2)
            ]]
            setHeart(a2, u12.MaxHealth)
        end
    )
    u12.Died:Connect(
        function()
            --[[
              line: 381
              upvalues:
                u10 (ref, index: 1)
                u11 (ref, index: 2)
            ]]
            if not u10 then
                return
            end
            u10(0.6)
            u10 = nil
            u11 = nil
        end
    )
end
local phase_upv_1 = ""
local u13 = nil
local u14 = 0
local function themeFor(a1, a2)
    --[[
      name: themeFor
      line: 67
      upvalues:
        Sounds_upv_1 (copy, index: 1)
    ]]
    local v39 = a2 and (a2:GetAttribute("Ambience"))
    if type(v39) == "string" and Sounds_upv_1.THEMES[v39] then
        return v39
    end
    local v40 = a1:GetAttribute("MapId")
    if type(v40) == "string" and Sounds_upv_1.MAP_THEMES[v40] then
        return Sounds_upv_1.MAP_THEMES[v40]
    end
    local v41 = a1:GetAttribute("MapName")
    local v42 = string.lower(tostring(v40 or "") .. " " .. tostring(v41 or ""))
    for _, value_2 in Sounds_upv_1.THEME_KEYWORDS do
        if not (string.find(v42, value_2[1], 1, true)) then
            continue
        end
        return value_2[2]
    end
    return "Default"
end
local function refreshContext()
    --[[
      name: refreshContext
      line: 393
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        Workspace_upv_1 (copy, index: 2)
        tbl_upv_2 (copy, index: 3)
        themeFor (copy, index: 4)
        u1 (ref,  index: 5)
        Sounds_upv_1 (copy, index: 6)
        u13 (ref,  index: 7)
        Emitters_upv_1 (copy, index: 8)
        phase_upv_1 (ref,  index: 9)
        onPhase (copy, index: 10)
    ]]
    local v43, v44 = nil, nil
    local v45 = nil
    if LocalPlayer_upv_1:GetAttribute("State") ~= "Match" then
        v43 = nil
    else
        v44 = LocalPlayer_upv_1:GetAttribute("MatchId")
        if type(v44) ~= "string" or v44 == "" then
            v43 = nil
        else
            v45 = Workspace_upv_1:FindFirstChild("Arenas")
            v43 = v45 and (v45:FindFirstChild(v44))
        end
    end
    if v43 ~= nil then
        v45 = true
    else
        v45 = false
    end
    tbl_upv_2.inMatch = v45
    tbl_upv_2.arena = v43
    local v46 = nil
    if v43 then
        local Map_1 = v43:FindFirstChild("Map")
        tbl_upv_2.map = Map_1
        v46 = v43:GetAttribute("Phase")
        local v47
        if type(v46) ~= "string" then
            v47 = ""
        else
            v47 = v46
        end
        tbl_upv_2.phase = v47
        tbl_upv_2.theme = themeFor(v43, Map_1)
        local theme_1 = tbl_upv_2.theme
        local v48 = Map_1 and (Map_1:GetAttribute("Music"))
        local v49
        if type(v48) == "string" and v48 ~= "" and u1.Has(v48) then
            v49 = v48
        else
            local _ = Sounds_upv_1.THEMES[theme_1]
            v49 = Sounds_upv_1.THEMES[theme_1] and Sounds_upv_1.THEMES[theme_1].music
        end
        tbl_upv_2.music = v49
        v49 = LocalPlayer_upv_1:GetAttribute("FinalRound") == true
        tbl_upv_2.final = v49
        if Map_1 ~= u13 then
            if u13 then
                Emitters_upv_1.Unwatch(u13)
            end
            u13 = Map_1
            if Map_1 then
                Emitters_upv_1.Watch(Map_1)
            end
        end
    else
        tbl_upv_2.map = nil
        tbl_upv_2.phase = ""
        tbl_upv_2.theme = "Lobby"
        tbl_upv_2.music = nil
        tbl_upv_2.final = false
        if u13 then
            Emitters_upv_1.Unwatch(u13)
            u13 = nil
        end
    end
    if tbl_upv_2.phase == phase_upv_1 then
        return
    end
    v43 = phase_upv_1
    phase_upv_1 = tbl_upv_2.phase
    if not tbl_upv_2.inMatch then
        return
    end
    onPhase(tbl_upv_2.phase, v43)
end
function tbl_1.State()
    --[[
      name: State
      line: 435
      upvalues:
        tbl_upv_2 (copy, index: 1)
        Emitters_upv_1 (copy, index: 2)
        u14 (ref,  index: 3)
        u10 (ref,  index: 4)
        Layers_upv_1 (copy, index: 5)
    ]]
    local tbl_7 = {}
    local v50 = string.format("inMatch=%s phase=%s theme=%s music=%s final=%s", tostring(tbl_upv_2.inMatch), tbl_upv_2.phase, tbl_upv_2.theme, tostring(tbl_upv_2.music), tostring(tbl_upv_2.final))
    local v51 = "emitters=" .. Emitters_upv_1.Count() .. " ticks=" .. u14
    local v52 = u10 ~= nil
    tbl_7[1], tbl_7[2], tbl_7[3] = v50, v51, "heart=" .. tostring(v52)
    for _, value_3 in Layers_upv_1.Debug() do
        table.insert(tbl_7, value_3)
    end
    return table.concat(tbl_7, "\n")
end
function tbl_1.NowPlaying()
    --[[
      name: NowPlaying
      line: 449
      upvalues:
        Layers_upv_1 (copy, index: 1)
        Sounds_upv_1 (copy, index: 2)
    ]]
    local tbl_8 = {}
    for _, value_4 in Layers_upv_1.Audible("Music/") do
        local v53 = Sounds_upv_1.Get(value_4.name)
        local tbl_9 = {at = 0, src = 0, id = 0, length = 0}
        tbl_9.name = value_4.name
        tbl_9.src = v53 and (v53.src)
        tbl_9.id = v53 and tonumber(v53.id)
        tbl_9.at = value_4.sound.TimePosition
        tbl_9.length = value_4.sound.TimeLength
        table.insert(tbl_8, tbl_9)
    end
    return tbl_8
end
function tbl_1.Start(a1)
    --[[
      name: Start
      line: 458
      upvalues:
        u1 (ref,  index: 1)
        Layers_upv_1 (copy, index: 2)
        Emitters_upv_1 (copy, index: 3)
        Workspace_upv_1 (copy, index: 4)
        ReplicatedStorage_upv_1 (copy, index: 5)
        onMatchEvent (copy, index: 6)
        LocalPlayer_upv_1 (copy, index: 7)
        u10 (ref,  index: 8)
        u11 (ref,  index: 9)
        watchCharacter (copy, index: 10)
        RunService_upv_1 (copy, index: 11)
        tbl_upv_2 (copy, index: 12)
        phase_upv_1 (ref,  index: 13)
        refreshContext (copy, index: 14)
        u14 (ref,  index: 15)
        updateMusic (copy, index: 16)
        updateAmbience (copy, index: 17)
    ]]
    u1 = a1
    Layers_upv_1.Init(a1)
    Emitters_upv_1.Init(a1)
    local function maybeLobby(a2)
        --[[
          name: maybeLobby
          line: 464
          upvalues:
            Emitters_upv_1 (copy, index: 1)
        ]]
        if a2.Name ~= "Lobby" then
            return
        end
        Emitters_upv_1.Watch(a2)
    end
    Workspace_upv_1.ChildAdded:Connect(maybeLobby)
    local Lobby_1 = Workspace_upv_1:FindFirstChild("Lobby")
    if Lobby_1 and Lobby_1.Name == "Lobby" then
        Emitters_upv_1.Watch(Lobby_1)
    end
    task.spawn(
        function()
            --[[
              line: 476
              upvalues:
                ReplicatedStorage_upv_1 (copy, index: 1)
                onMatchEvent (copy, index: 2)
            ]]
            local v55 = ReplicatedStorage_upv_1:WaitForChild("Remotes", 60)
            local v56 = v55 and (v55:WaitForChild("MatchEvent", 60))
            if not v56 or not v56:IsA("RemoteEvent") then
                return
            end
            v56.OnClientEvent:Connect(
                function(a3, a4)
                    --[[
                      line: 480
                      upvalues:
                        onMatchEvent (copy, index: 1)
                    ]]
                    local success_1, v57 = pcall(onMatchEvent, a3, a4)
                    if (success_1) then
                        return
                    end
                    warn("[Audio] MatchEvent cue failed:", v57)
                end
            )
        end
    )
    LocalPlayer_upv_1.CharacterAdded:Connect(
        function(a5)
            --[[
              line: 490
              upvalues:
                u10 (ref,  index: 1)
                u11 (ref,  index: 2)
                watchCharacter (copy, index: 3)
            ]]
            if u10 then
                u10(0.6)
                u10 = nil
                u11 = nil
            end
            task.spawn(watchCharacter, a5)
        end
    )
    if LocalPlayer_upv_1.Character then
        task.spawn(watchCharacter, LocalPlayer_upv_1.Character)
    end
    RunService_upv_1.Heartbeat:Connect(
        function()
            --[[
              line: 499
              upvalues:
                tbl_upv_2 (copy, index: 1)
                phase_upv_1 (ref,  index: 2)
                refreshContext (copy, index: 3)
            ]]
            local arena_3 = tbl_upv_2.arena
            if arena_3 then
                local v58 = arena_3:GetAttribute("Phase")
                if type(v58) ~= "string" or v58 == phase_upv_1 then
                    return
                end
                refreshContext()
            end
        end
    )
    task.spawn(
        function()
            --[[
              line: 508
              upvalues:
                u14 (ref,  index: 1)
                refreshContext (copy, index: 2)
                updateMusic (copy, index: 3)
                updateAmbience (copy, index: 4)
                Emitters_upv_1 (copy, index: 5)
            ]]
            u14 = u14 + 1
            local success_2, v59 = pcall(
                function()
                    --[[
                      line: 511
                      upvalues:
                        refreshContext (copy, index: 1)
                        updateMusic (copy, index: 2)
                        updateAmbience (copy, index: 3)
                        Emitters_upv_1 (copy, index: 4)
                    ]]
                    refreshContext()
                    updateMusic()
                    updateAmbience()
                    Emitters_upv_1.Update()
                end
            )
            if not success_2 then
                warn("[Audio] director update failed:", v59)
            end
            task.wait(0.25)
        end
    )
end
return tbl_1