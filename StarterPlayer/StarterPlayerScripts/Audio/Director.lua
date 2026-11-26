local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local workspace = game:GetService("Workspace")
local shared = replicatedStorage:WaitForChild("Shared")
local childName = "Sounds"
local child = require(shared:WaitForChild(childName))
local Layers = require(script.Parent:WaitForChild("Layers"))
local Emitters = require(script.Parent:WaitForChild("Emitters"))
local v10 = {}
local localPlayer = players.LocalPlayer
local v12 = nil
local v13 = {inMatch = false, arena = nil, map = nil, phase = "", theme = "Lobby", music = nil, final = false}

local function myId()
    --[[
      name: myId
      line: 49
      upvalues:
        localPlayer (copy, index: 1)
    ]]
    return "p" .. localPlayer.UserId
end

local function myTeam()
    --[[
      name: myTeam
      line: 53
      upvalues:
        localPlayer (copy, index: 1)
    ]]
    local team = localPlayer:GetAttribute("Team")

    if type(team) ~= "number" then
        return 0
    end

    return team
end

local function findArena()
    --[[
      name: findArena
      line: 58
      upvalues:
        localPlayer (copy, index: 1)
        workspace (copy, index: 2)
    ]]
    local v18 = localPlayer:GetAttribute("MatchId")

    if type(v18) ~= "string" or v18 == "" then
        return nil
    end

    local arenas = workspace:FindFirstChild("Arenas")

    return arenas and arenas:FindFirstChild(v18)
end

local function themeFor(child2: Instance?, map: Instance?)
    --[[
      name: themeFor
      line: 67
      upvalues:
        child (copy, index: 1)
    ]]
    local ambience = map and map:GetAttribute("Ambience")

    if type(ambience) == "string" and child.THEMES[ambience] then
        return ambience
    end

    local mapId = child2:GetAttribute("MapId")

    if type(mapId) == "string" and child.MAP_THEMES[mapId] then
        return child.MAP_THEMES[mapId]
    end

    local mapName = child2:GetAttribute("MapName")
    local lowercaseText = string.lower(tostring((mapId or "")) .. " " .. tostring((mapName or "")))

    for _, themeKeyword in child.THEME_KEYWORDS do
        if string.find(lowercaseText, themeKeyword[1], 1, true) then
            return themeKeyword[2]
        end
    end

    return "Default"
end

local function musicFor(themeKey, a31)
    --[[
      name: musicFor
      line: 87
      upvalues:
        v12 (ref,  index: 1)
        child (copy, index: 2)
    ]]
    local music = a31 and a31:GetAttribute("Music")

    if type(music) == "string" and music ~= "" and v12.Has(music) then
        return music
    end

    local theme = child.THEMES[themeKey]

    return theme and theme.music
end

local v34 = 0
local v35 = {}
local random = Random.new()

local function nextLobbyIndex()
    --[[
      name: nextLobbyIndex
      line: 104
      upvalues:
        v35 (copy, index: 1)
        child (copy, index: 2)
        random (copy, index: 3)
        v34 (ref,  index: 4)
    ]]
    if #v35 == 0 then
        for index = 1, #child.LOBBY_PLAYLIST do
            v35[index] = index
        end

        for index = #v35, 2, -1 do
            local v40 = random:NextInteger(1, index)
            v35[index], v35[v40] = v35[v40], v35[index]
        end

        if 1 < #v35 and v35[#v35] == v34 then
            v35[#v35], v35[1] = v35[1], v35[#v35]
        end
    end

    return (table.remove(v35))
end

local v41 = nil
local timestamp = 0

local function nextLobbyTrack()
    --[[
      name: nextLobbyTrack
      line: 123
      upvalues:
        v34 (ref,  index: 1)
        nextLobbyIndex (copy, index: 2)
        child (copy, index: 3)
        Layers (copy, index: 4)
        v41 (ref,  index: 5)
        timestamp (ref,  index: 6)
    ]]
    v34 = nextLobbyIndex()
    local v44 = child.LOBBY_PLAYLIST[v34]
    local v45 = "Music/Lobby" .. v34

    if const v46 = Layers.Get(v45, v44, 0.5) then
        v46.sound.Looped = false
        Layers.Restart(v45, 1)
        v41 = v45
        timestamp = os.clock()
    end
end

local v47 = {Loading = 0.5, Intro = 0.55, PreRound = 0.7, Live = 1, Overtime = 0, RoundEnd = 0.6, MatchEnd = 0}
local v48 = {PreRound = 0.8, Live = 1}

local function updateMusic()
    --[[
      name: updateMusic
      line: 140
      upvalues:
        v13 (copy, index: 1)
        v41 (ref,  index: 2)
        Layers (copy, index: 3)
        timestamp (ref,  index: 4)
        nextLobbyTrack (copy, index: 5)
        v47 (copy, index: 6)
        v48 (copy, index: 7)
        v12 (ref,  index: 8)
    ]]
    if not v13.inMatch then
        local v50 = v41 and Layers.Find(v41)

        if v50 and not v50.ended and 8 < os.clock() - timestamp and v50.sound.TimeLength <= 0 then
            v50.ended = true
        end

        if not v50 or v50.ended then
            nextLobbyTrack()
        elseif v50.target == 0 then
            Layers.Restart(v50.key, 1)
        end

        Layers.FadeAll("Music/", {[v41 or ""] = true})

        if v41 then
            Layers.SetTarget(v41, 1, 0.5)
        end

        return
    end

    Layers.FadeAll("Music/Lobby")
    local v51 = v47[v13.phase] or 0.8
    local v52 = if v13.final then v48[v13.phase] else nil

    if v52 and not v12.Has("Music/Final_Round") then
        v52 = nil
    end

    if v13.music then
        if const v53 = Layers.Get("Music/Match", v13.music, 0.6) then
            v53.sound.Looped = true
            local setTarget = Layers.SetTarget
            local v55 = v52 and 0 or v51
            setTarget("Music/Match", v55, ((v13.phase ~= "Overtime" and (v52 and 1 or 0.6)) or 1.5))
        end
    end

    if const v56 = if v52 then Layers.Get("Music/Final", "Music/Final_Round", 0.9) else Layers.Find("Music/Final") then
        v56.sound.Looped = true

        if v52 then
            if v56.target == 0 then
                Layers.Restart("Music/Final", v52)
            end

            Layers.SetTarget("Music/Final", v52, 0.9)
        else
            local setTarget = Layers.SetTarget
            local v58 = v13.phase ~= "Overtime" and 0.6 or 1.5
            setTarget("Music/Final", 0, v58)
        end
    end

    if const v59 = Layers.Get("Music/Overtime", "Music/Overtime", 2) then
        v59.sound.Looped = false

        if v13.phase ~= "Overtime" then
            Layers.SetTarget("Music/Overtime", 0, 0.8)
        elseif v59.target == 0 then
            Layers.Restart("Music/Overtime", 1)
        end
    end
end

local v60 = 0

local function ringLevel()
    --[[
      name: ringLevel
      line: 204
      upvalues:
        v13 (copy, index: 1)
        workspace (copy, index: 2)
    ]]
    local arena = v13.arena

    if not arena or v13.phase ~= "Overtime" then
        return 0
    end

    local ringRadius = arena:GetAttribute("RingRadius")
    local ringCenterX = arena:GetAttribute("RingCenterX")
    local ringCenterZ = arena:GetAttribute("RingCenterZ")
    local camera = workspace.CurrentCamera

    if type(ringRadius) ~= "number"
        or ringRadius <= 0
        or type(ringCenterX) ~= "number"
        or type(ringCenterZ) ~= "number"
        or not camera
    then
        return 0.35
    end

    local position = camera.Focus.Position
    local magnitude = Vector2.new(position.X - ringCenterX, position.Z - ringCenterZ).Magnitude

    if ringRadius <= magnitude then
        return 1
    end

    return (math.clamp(1 - ((ringRadius - magnitude) / 45), 0.25, 1))
end

local function updateAmbience()
    --[[
      name: updateAmbience
      line: 223
      upvalues:
        child (copy, index: 1)
        v13 (copy, index: 2)
        Layers (copy, index: 3)
        ringLevel (copy, index: 4)
        v60 (ref,  index: 5)
        workspace (copy, index: 6)
        v12 (ref,  index: 7)
    ]]
    local v70 = child.THEMES[v13.theme] or child.THEMES.Default
    local v71 = {}
    local v72 = v13.phase ~= "MatchEnd" and 1 or 0.6

    for _, bed in v70.beds do
        local v75 = "Amb/" .. bed[1]

        if const v76 = Layers.Get(v75, bed[1], 0.5) then
            v76.sound.Looped = true
            Layers.SetTarget(v75, bed[2] * v72, 0.5)
            v71[v75] = true
        end
    end

    local v77 = ringLevel()

    if 0 < v77 then
        if const v78 = Layers.Get("Amb/Ring", "Match/Ring_Fire_Loop", 1.5) then
            v78.sound.Looped = true
            Layers.SetTarget("Amb/Ring", v77, 1.5)
            v71["Amb/Ring"] = true
        end
    end

    Layers.FadeAll("Amb/", v71)
    local timestamp = os.clock()

    if v60 <= timestamp then
        local v80 = v70.every or {8, 16}
        v60 = timestamp + v80[1] + (math.random() * (v80[2] - v80[1]))
        local sweeteners = v70.sweeteners
        local camera = workspace.CurrentCamera

        if sweeteners and 0 < #sweeteners and camera and v13.phase ~= "MatchEnd" then
            local v83 = math.random() * math.pi * 2
            local v84 = 25 + math.random() * 35
            local vector3 = camera.Focus.Position + Vector3.new(math.cos(v83) * v84, 6 + (math.random() * 14), math.sin(v83) * v84)
            v12.Play(sweeteners[math.random(1, #sweeteners)], vector3)
        end
    end
end

local v86 = 0
local count = 0

local function duckForBanner(a89)
    --[[
      name: duckForBanner
      line: 270
      upvalues:
        v12 (ref, index: 1)
    ]]
    v12.Duck("Music", 0.35, a89)
    v12.Duck("Ambient", 0.6, a89)
end

local function onPhase(phase, phase2)
    --[[
      name: onPhase
      line: 275
      upvalues:
        count (ref,  index: 1)
        v13 (copy, index: 2)
        v12 (ref,  index: 3)
        v86 (ref,  index: 4)
        workspace (copy, index: 5)
    ]]
    count += 1
    local v93 = count
    local arena = v13.arena

    if phase == "Intro" then
        v12.Play("Match/Intro")
        v12.Duck("Music", 0.35, 3)
        v12.Duck("Ambient", 0.6, 3)

        return
    end

    if phase ~= "PreRound" then
        if phase == "Live" and phase2 == "PreRound" then
            v12.Play("Match/Fight")
            v12.Duck("Music", 0.35, 2.5)
            v12.Duck("Ambient", 0.6, 2.5)

            return
        end

        if phase == "Overtime" then
            v12.Play("Match/Overtime_Warning")
            v12.Duck("Music", 0.35, 3)
            v12.Duck("Ambient", 0.6, 3)
        end
    else
        v86 = 0
        v12.Play("Match/Spawn")
        local phaseEndsAt = arena and arena:GetAttribute("PhaseEndsAt")

        if type(phaseEndsAt) == "number" then
            local serverTimeNow = workspace:GetServerTimeNow()

            for index = 3, 1, -1 do
                local v98 = phaseEndsAt - index

                if serverTimeNow - 0.1 < v98 then
                    task.delay(
                        math.max(0, v98 - serverTimeNow),
                        function()
                            --[[
                              line: 291
                              upvalues:
                                count (ref,  index: 1)
                                v93 (copy, index: 2)
                                v12 (ref,  index: 3)
                                index (copy, index: 4)
                            ]]
                            if count == v93 then
                                v12.Play("Match/Countdown_" .. index)
                            end
                        end
                    )
                end
            end
        end
    end
end

local function onMatchEvent(a100, a101)
    --[[
      name: onMatchEvent
      line: 308
      upvalues:
        localPlayer (copy, index: 1)
        v12 (ref,  index: 2)
        v86 (ref,  index: 3)
    ]]
    if type(a101) ~= "table" then
        return
    end

    if a100 ~= "Elimination" then
        local play, winnerTeam, team, winnerTeam2, team2
        local team3
        local v108
        local team4
        local v110, v111, v112, v113 = false, false, false, false

        if a100 == "RoundEnd" then
            winnerTeam2 = a101.winnerTeam
            team2 = localPlayer:GetAttribute("Team")

            if type(team2) ~= "number" then
                team4 = 0
            else
                team4 = team2
            end

            v110 = true
        elseif a100 == "MatchEnd" then
            if type(a101.you) ~= "table" then
                v111 = true
            else
                v108 = true

                if a101.you.won == true then
                    v113 = true
                else
                    v111 = true
                end
            end
        end

        if v110 then
            if winnerTeam2 ~= 0 then
                if winnerTeam2 ~= team4 then
                    v12.Play("Match/Round_Lose")
                else
                    v12.Play("Match/Round_Win")
                end
            else
                v12.Play("Match/Round_Draw")
            end

            v12.Duck("Music", 0.35, 4)
            v12.Duck("Ambient", 0.6, 4)

            return
        end

        if v111 then
            v108 = false

            if a101.winnerTeam == nil then
                v113 = true
            else
                winnerTeam = a101.winnerTeam
                team = localPlayer:GetAttribute("Team")

                if type(team) ~= "number" then
                    team3 = 0
                else
                    team3 = team
                end

                v112 = true
            end
        end

        if v112 then
            v108 = winnerTeam == team3
            v113 = true
        end

        if v113 then
            local v114
            play = v12.Play

            if v108 then
                v114 = "Match/Victory"
            else
                v114 = "Match/Defeat"
            end

            play(v114)
            v12.Duck("Ambient", 0.5, 6)
        end
    else
        local team
        local v116 = "p" .. localPlayer.UserId
        local team5 = localPlayer:GetAttribute("Team")

        if type(team5) ~= "number" then
            team = 0
        else
            team = team5
        end

        if a101.victimId == v116 then
            v12.Play("Death")
            v12.Duck("Music", 0.35, 3)
            v12.Duck("Ambient", 0.6, 3)

            return
        end

        if a101.killerId ~= v116 then
            if team ~= 0 and a101.victimTeam == team then
                v12.Play("Teammate_Down")
                return
            end

            if team ~= 0 and a101.killerTeam == team then
                v12.Play("Kill_Ally")
            end
        else
            v86 += 1
            v12.Play("Match/Elimination")

            if v86 == 2 then
                task.delay(0.35, v12.Play, "Kill_Double")
                return
            end

            if 3 <= v86 then
                task.delay(0.35, v12.Play, "Kill_Triple")
            end
        end
    end
end

local v118 = nil
local v119 = nil

local function setHeart(a121, maxHealth)
    --[[
      name: setHeart
      line: 355
      upvalues:
        v118 (ref, index: 1)
        v119 (ref, index: 2)
        v12 (ref, index: 3)
    ]]
    if 0 < a121 and a121 < 35 and (0 < maxHealth) then
        if not v118 then
            v118, v119 = v12.Loop("LowHealth_Heartbeat", nil, {fadeIn = 0.4})
        end

        if v119 then
            v119.PlaybackSpeed = ((1 - a121 / 35) * 0.25) + 1
        end
    elseif v118 then
        v118(0.6)
        v118 = nil
        v119 = nil
    end
end

local function watchCharacter(character: Model?)
    --[[
      name: watchCharacter
      line: 371
      upvalues:
        setHeart (copy, index: 1)
        v118 (ref,  index: 2)
        v119 (ref,  index: 3)
    ]]
    local humanoid = character:WaitForChild("Humanoid", 10)

    if not humanoid or not humanoid:IsA("Humanoid") then
        return
    end

    setHeart(humanoid.Health, humanoid.MaxHealth)
    humanoid.HealthChanged:Connect(
        function(health: number)
            --[[
              line: 378
              upvalues:
                setHeart (copy, index: 1)
                humanoid (copy, index: 2)
            ]]
            setHeart(health, humanoid.MaxHealth)
        end
    )

    humanoid.Died:Connect(
        function()
            --[[
              line: 381
              upvalues:
                v118 (ref, index: 1)
                v119 (ref, index: 2)
            ]]
            if v118 then
                v118(0.6)
                v118 = nil
                v119 = nil
            end
        end
    )
end

local phase = ""
local map = nil
local count2 = 0

local function refreshContext()
    --[[
      name: refreshContext
      line: 393
      upvalues:
        localPlayer (copy, index: 1)
        workspace (copy, index: 2)
        v13 (copy, index: 3)
        themeFor (copy, index: 4)
        v12 (ref,  index: 5)
        child (copy, index: 6)
        map (ref,  index: 7)
        Emitters (copy, index: 8)
        phase (ref,  index: 9)
        onPhase (copy, index: 10)
    ]]
    local instance

    if localPlayer:GetAttribute("State") ~= "Match" then
        instance = nil
    else
        local v132 = localPlayer:GetAttribute("MatchId")

        if type(v132) ~= "string" or v132 == "" then
            instance = nil
        else
            local arenas = workspace:FindFirstChild("Arenas")
            instance = arenas and arenas:FindFirstChild(v132)
        end
    end

    v13.inMatch = instance ~= nil
    v13.arena = instance

    if instance then
        local phase2
        local music
        local map2 = instance:FindFirstChild("Map")
        v13.map = map2
        local phase3 = instance:GetAttribute("Phase")

        if type(phase3) ~= "string" then
            phase2 = ""
        else
            phase2 = phase3
        end

        v13.phase = phase2
        v13.theme = themeFor(instance, map2)
        local theme = v13.theme
        local music2 = map2 and map2:GetAttribute("Music")

        if type(music2) == "string" and music2 ~= "" and v12.Has(music2) then
            music = music2
        else
            local theme2 = child.THEMES[theme]
            music = theme2 and theme2.music
        end

        v13.music = music
        local finalRound = localPlayer:GetAttribute("FinalRound") == true
        v13.final = finalRound

        if map2 ~= map then
            if map then
                Emitters.Unwatch(map)
            end

            map = map2

            if map2 then
                Emitters.Watch(map2)
            end
        end
    else
        v13.map = nil
        v13.phase = ""
        v13.theme = "Lobby"
        v13.music = nil
        v13.final = false

        if map then
            Emitters.Unwatch(map)
            map = nil
        end
    end

    if v13.phase ~= phase then
        local phase4 = phase
        phase = v13.phase

        if v13.inMatch then
            onPhase(v13.phase, phase4)
        end
    end
end

function v10.State()
    --[[
      name: State
      line: 435
      upvalues:
        v13 (copy, index: 1)
        Emitters (copy, index: 2)
        count2 (ref,  index: 3)
        v118 (ref,  index: 4)
        Layers (copy, index: 5)
    ]]
    local parts = {}
    local formattedText = string.format("inMatch=%s phase=%s theme=%s music=%s final=%s", tostring(v13.inMatch), v13.phase, v13.theme, tostring(v13.music), (tostring(v13.final)))
    local v145 = "emitters=" .. Emitters.Count() .. " ticks=" .. count2
    local v146 = v118 ~= nil
    parts[1], parts[2], parts[3] = formattedText, v145, "heart=" .. tostring(v146)

    for _, v148 in Layers.Debug() do
        table.insert(parts, v148)
    end

    return table.concat(parts, "\n")
end

function v10.NowPlaying()
    --[[
      name: NowPlaying
      line: 449
      upvalues:
        Layers (copy, index: 1)
        child (copy, index: 2)
    ]]
    local v149 = {}

    for _, v151 in Layers.Audible("Music/") do
        local v152 = child.Get(v151.name)
        local v153 = {name = v151.name, src = v152 and v152.src}
        local number = v152 and tonumber(v152.id)
        v153.id = number
        v153.at = v151.sound.TimePosition
        v153.length = v151.sound.TimeLength
        table.insert(v149, v153)
    end

    return v149
end

function v10.Start(a155)
    --[[
      name: Start
      line: 458
      upvalues:
        v12 (ref,  index: 1)
        Layers (copy, index: 2)
        Emitters (copy, index: 3)
        workspace (copy, index: 4)
        replicatedStorage (copy, index: 5)
        onMatchEvent (copy, index: 6)
        localPlayer (copy, index: 7)
        v118 (ref,  index: 8)
        v119 (ref,  index: 9)
        watchCharacter (copy, index: 10)
        runService (copy, index: 11)
        v13 (copy, index: 12)
        phase (ref,  index: 13)
        refreshContext (copy, index: 14)
        count2 (ref,  index: 15)
        updateMusic (copy, index: 16)
        updateAmbience (copy, index: 17)
    ]]
    v12 = a155
    Layers.Init(a155)
    Emitters.Init(a155)

    workspace.ChildAdded:Connect(
        function(child: Instance)
            --[[
              name: maybeLobby
              line: 464
              upvalues:
                Emitters (copy, index: 1)
            ]]
            if child.Name == "Lobby" then
                Emitters.Watch(child)
            end
        end
    )

    local lobby = workspace:FindFirstChild("Lobby")

    if lobby and lobby.Name == "Lobby" then
        Emitters.Watch(lobby)
    end

    task.spawn(
        function()
            --[[
              line: 476
              upvalues:
                replicatedStorage (copy, index: 1)
                onMatchEvent (copy, index: 2)
            ]]
            local remotes = replicatedStorage:WaitForChild("Remotes", 60)
            local matchEvent = remotes and remotes:WaitForChild("MatchEvent", 60)

            if matchEvent and matchEvent:IsA("RemoteEvent") then
                matchEvent.OnClientEvent:Connect(
                    function(a160, a161)
                        --[[
                          line: 480
                          upvalues:
                            onMatchEvent (copy, index: 1)
                        ]]
                        local success, result = pcall(onMatchEvent, a160, a161)
                        if not success then
                            warn("[Audio] MatchEvent cue failed:", result)
                        end
                    end
                )
            end
        end
    )

    localPlayer.CharacterAdded:Connect(
        function(character: Model)
            --[[
              line: 490
              upvalues:
                v118 (ref,  index: 1)
                v119 (ref,  index: 2)
                watchCharacter (copy, index: 3)
            ]]
            if v118 then
                v118(0.6)
                v118 = nil
                v119 = nil
            end

            task.spawn(watchCharacter, character)
        end
    )

    if localPlayer.Character then
        task.spawn(watchCharacter, localPlayer.Character)
    end

    runService.Heartbeat:Connect(
        function()
            --[[
              line: 499
              upvalues:
                v13 (copy, index: 1)
                phase (ref,  index: 2)
                refreshContext (copy, index: 3)
            ]]
            if const arena = v13.arena then
                local phase2 = arena:GetAttribute("Phase")

                if type(phase2) == "string" and phase2 ~= phase then
                    refreshContext()
                end
            end
        end
    )

    task.spawn(
        function()
            --[[
              line: 508
              upvalues:
                count2 (ref,  index: 1)
                refreshContext (copy, index: 2)
                updateMusic (copy, index: 3)
                updateAmbience (copy, index: 4)
                Emitters (copy, index: 5)
            ]]
            while true do
                count2 += 1

                local success, result = pcall(
                    function()
                        --[[
                          line: 511
                          upvalues:
                            refreshContext (copy, index: 1)
                            updateMusic (copy, index: 2)
                            updateAmbience (copy, index: 3)
                            Emitters (copy, index: 4)
                        ]]
                        refreshContext()
                        updateMusic()
                        updateAmbience()
                        Emitters.Update()
                    end
                )

                if not success then
                    warn("[Audio] director update failed:", result)
                end

                task.wait(0.25)
            end
        end
    )
end

return v10