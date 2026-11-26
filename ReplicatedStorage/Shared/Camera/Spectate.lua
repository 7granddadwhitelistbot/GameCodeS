game:GetService("CollectionService")
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(script.Parent.Parent:WaitForChild("Signal"))
local Fighters = require(script.Parent:WaitForChild("Fighters"))
local v5 = {}
local localPlayer = players.LocalPlayer
local spectateMode = "none"
local target = nil
local v9 = nil
local v10 = nil
local v11 = false
local v12 = nil
local v13 = nil
local v14 = ""
local timestamp = 0
local v16 = nil
local attackerId = nil
local timestamp2 = -math.huge
local timestamp3 = nil
local timestamp4 = 0
local hasRun = false
v5.Changed = Signal.new()

local function myId()
    --[[
      name: myId
      line: 60
      upvalues:
        localPlayer (copy, index: 1)
    ]]
    return "p" .. tostring(localPlayer.UserId)
end

local function humanoidAlive(a24)
    --[[
      name: humanoidAlive
      line: 64
    ]]
    local humanoid = a24:FindFirstChildOfClass("Humanoid")
    return humanoid ~= nil
        and 0 < humanoid.Health
        and a24.Parent ~= nil
        and a24:FindFirstChild("HumanoidRootPart") ~= nil
end

function v5.ResolveCombatant(text: string)
    --[[
      name: ResolveCombatant
      line: 70
      upvalues:
        players (copy, index: 1)
        Fighters (copy, index: 2)
    ]]
    if type(text) ~= "string" or text == "" then
        return nil
    end

    if string.sub(text, 1, 1) == "p" then
        local v27 = tonumber((string.sub(text, 2)))
        local player = v27 and players:GetPlayerByUserId(v27)

        if const character = player and player.Character then
            if character.Parent then
                return character
            end
        end
    end

    local v30 = nil

    Fighters.EachTagged(
        function(a31)
            --[[
              line: 83
              upvalues:
                v30 (ref,  index: 1)
                text (copy, index: 2)
            ]]
            if not v30 and a31:GetAttribute("CombatantId") == text and a31.Parent then
                v30 = a31
            end
        end
    )

    return v30
end

local function nameOf(character: Model)
    --[[
      name: nameOf
      line: 91
      upvalues:
        players (copy, index: 1)
    ]]
    if not character then
        return ""
    end

    local displayName = character:GetAttribute("DisplayName")

    return if type(displayName) == "string" and displayName ~= "" then displayName elseif const player = players:GetPlayerFromCharacter(character) then player.DisplayName else character.Name
end

local function idOf(character: Model)
    --[[
      name: idOf
      line: 103
      upvalues:
        players (copy, index: 1)
    ]]
    if not character then
        return ""
    end

    local combatantId = character:GetAttribute("CombatantId")

    return if type(combatantId) == "string" then combatantId elseif const player = players:GetPlayerFromCharacter(character) then "p" .. player.UserId else character.Name
end

local function watchedMatch()
    --[[
      name: watchedMatch
      line: 116
      upvalues:
        localPlayer (copy, index: 1)
    ]]
    local spectating = localPlayer:GetAttribute("Spectating")

    if type(spectating) == "string" and spectating ~= "" and localPlayer:GetAttribute("State") ~= "Match" then
        return spectating
    end

    return ""
end

local function teamOf(character: Model)
    --[[
      name: teamOf
      line: 124
      upvalues:
        players (copy, index: 1)
    ]]
    local team = character:GetAttribute("Team")

    if type(team) ~= "number" then
        local player = players:GetPlayerFromCharacter(character)
        team = player and player:GetAttribute("Team")
    end

    if type(team) ~= "number" then
        return 0
    end

    return team
end

local function sortIds(a47, a48, a49)
    --[[
      name: sortIds
      line: 133
    ]]
    table.sort(
        a47,
        function(left, right)
            --[[
              line: 134
              upvalues:
                a49 (copy, index: 1)
                a48 (copy, index: 2)
            ]]
            if a49 then
                local v52 = a48[left] or 0
                local v53 = a48[right] or 0

                if v52 ~= v53 then
                    return v52 < v53
                end
            end

            return left < right
        end
    )
end

local function candidates(a55: boolean)
    --[[
      name: candidates
      line: 149
      upvalues:
        localPlayer (copy, index: 1)
        players (copy, index: 2)
        Fighters (copy, index: 3)
        v10 (ref,  index: 4)
        v5 (copy, index: 5)
        humanoidAlive (copy, index: 6)
    ]]
    local spectating
    local spectating2 = localPlayer:GetAttribute("Spectating")

    if type(spectating2) ~= "string" or spectating2 == "" or localPlayer:GetAttribute("State") == "Match" then
        spectating = ""
    else
        spectating = spectating2
    end

    local v58 = if spectating ~= "" then spectating else localPlayer:GetAttribute("MatchId")
    local team = localPlayer:GetAttribute("Team")
    local v60 = spectating ~= ""
    local v61 = {}
    local v62 = {}

    if type(v58) ~= "string" or v58 == "" then
        return v61
    end

    local function add(key, value)
        --[[
          name: add
          line: 159
          upvalues:
            localPlayer (copy, index: 1)
            v62 (copy, index: 2)
            v61 (copy, index: 3)
        ]]
        if key ~= "" and key ~= "p" .. tostring(localPlayer.UserId) and v62[key] == nil then
            v62[key] = value
            table.insert(v61, key)
        end
    end

    for _, player in players:GetPlayers() do
        if player ~= localPlayer then
            local team2

            if player:GetAttribute("MatchId") ~= v58 then
                continue
            end
            if player:GetAttribute("Alive") == false then
                continue
            end
            if not v60 and player:GetAttribute("Team") == team ~= a55 then
                continue
            end

            local character = player.Character
            if not character then
                continue
            end
            if not humanoidAlive(character) then
                continue
            end

            local v70 = "p" .. player.UserId
            local team3 = character:GetAttribute("Team")

            if type(team3) ~= "number" then
                local player2 = players:GetPlayerFromCharacter(character)
                team3 = player2 and player2:GetAttribute("Team")
            end

            if type(team3) == "number" then
                team2 = team3
            else
                team2 = 0
            end

            if v70 == "" then
                continue
            end

            if v70 ~= "p" .. tostring(localPlayer.UserId) and v62[v70] == nil then
                v62[v70] = team2
                table.insert(v61, v70)
            end
        end
    end

    Fighters.EachTagged(
        function(character: Model)
            --[[
              line: 175
              upvalues:
                players (copy, index: 1)
                v58 (copy, index: 2)
                v60 (copy, index: 3)
                team (copy, index: 4)
                a55 (copy, index: 5)
                localPlayer (copy, index: 6)
                v62 (copy, index: 7)
                v61 (copy, index: 8)
            ]]
            if players:GetPlayerFromCharacter(character) == nil and character:GetAttribute("MatchId") == v58 then
                local humanoid = character:FindFirstChildOfClass("Humanoid")

                if humanoid ~= nil
                    and 0 < humanoid.Health
                    and character.Parent ~= nil
                    and character:FindFirstChild("HumanoidRootPart") ~= nil
                then
                    local v75
                    local team2

                    if not v60 then
                        local v77 = character:GetAttribute("Team") == team

                        if v77 ~= a55 then
                            return
                        end
                    end

                    if character then
                        local combatantId = character:GetAttribute("CombatantId")

                        if type(combatantId) ~= "string" then
                            v75 = if const player = players:GetPlayerFromCharacter(character) then "p" .. player.UserId else character.Name
                        else
                            v75 = combatantId
                        end
                    else
                        v75 = ""
                    end

                    local team3 = character:GetAttribute("Team")

                    if type(team3) ~= "number" then
                        local player = players:GetPlayerFromCharacter(character)
                        team3 = player and player:GetAttribute("Team")
                    end

                    if type(team3) ~= "number" then
                        team2 = 0
                    else
                        team2 = team3
                    end

                    if v75 ~= "" and v75 ~= "p" .. tostring(localPlayer.UserId) and v62[v75] == nil then
                        v62[v75] = team2
                        table.insert(v61, v75)
                    end
                end
            end
        end
    )

    local v82 = v10

    if type(v82) == "table" and v82.matchId == v58 and type(v82.teams) == "table" then
        for v83, team4 in v82.teams do
            if type(v83) == "number" then
                if type(team4) ~= "table" then
                    continue
                end
                if type(team4.members) ~= "table" then
                    continue
                end

                if v60 or v83 == team == a55 then
                    for _, member in team4.members do
                        local id = type(member) == "table" and member.id

                        if type(id) == "string" then
                            if member.alive ~= true then
                                continue
                            end
                            if member.connected == false then
                                continue
                            end
                            if v62[id] ~= nil then
                                continue
                            end

                            if string.sub(id, 1, 1) == "p" then
                                local player = players:GetPlayerByUserId(tonumber((string.sub(id, 2))) or 0)
                                if not player then
                                    continue
                                end
                                if player:GetAttribute("Alive") == false then
                                    continue
                                end
                                if player:GetAttribute("MatchId") ~= v58 then
                                    continue
                                end
                            end

                            local v89 = v5.ResolveCombatant(id)

                            if v89 ~= nil and not humanoidAlive(v89) then
                                continue
                            end
                            if id == "" then
                                continue
                            end

                            if id ~= "p" .. tostring(localPlayer.UserId) and v62[id] == nil then
                                v62[id] = v83
                                table.insert(v61, id)
                            end
                        end
                    end
                end
            end
        end
    end

    table.sort(
        v61,
        function(left, right)
            --[[
              line: 134
              upvalues:
                v60 (copy, index: 1)
                v62 (copy, index: 2)
            ]]
            if v60 then
                local v92 = v62[left] or 0
                local v93 = v62[right] or 0

                if v92 ~= v93 then
                    return v92 < v93
                end
            end

            return left < right
        end
    )

    return v61
end

local function publishCount()
    --[[
      name: publishCount
      line: 214
      upvalues:
        spectateMode (ref,  index: 1)
        candidates (copy, index: 2)
        localPlayer (copy, index: 3)
    ]]
    local spectateCount = 0

    if spectateMode == "follow" then
        spectateCount = #candidates(true)

        if spectateCount == 0 then
            spectateCount = #candidates(false)
        end
    end

    localPlayer:SetAttribute("SpectateCount", spectateCount)
end

local function isEnemy(text)
    --[[
      name: isEnemy
      line: 226
      upvalues:
        localPlayer (copy, index: 1)
        v5 (copy, index: 2)
        players (copy, index: 3)
        v10 (ref,  index: 4)
    ]]
    local team = localPlayer:GetAttribute("Team")

    if const character = v5.ResolveCombatant(text) then
        local team2
        local team3 = character:GetAttribute("Team")

        if type(team3) ~= "number" then
            local player = players:GetPlayerFromCharacter(character)
            team3 = player and player:GetAttribute("Team")
        end

        if type(team3) ~= "number" then
            team2 = 0
        else
            team2 = team3
        end

        return team2 ~= team
    end

    if string.sub(text, 1, 1) == "p" then
        if const player = players:GetPlayerByUserId(tonumber((string.sub(text, 2))) or 0) then
            return player:GetAttribute("Team") ~= team
        end
    end

    local v104 = v10

    if type(v104) == "table" and type(v104.teams) == "table" then
        for v105, team4 in v104.teams do
            if type(team4) == "table" then
                if type(team4.members) ~= "table" then
                    continue
                end

                for _, member in team4.members do
                    if type(member) == "table" and member.id == text then
                        local v109 = v105 ~= team
                        return v109
                    end
                end
            end
        end
    end

    return false
end

local function snapshotName(a111)
    --[[
      name: snapshotName
      line: 254
      upvalues:
        v10 (ref, index: 1)
    ]]
    local v112 = v10

    if a111 and type(v112) == "table" and type(v112.teams) == "table" then
        for _, team in v112.teams do
            if type(team) == "table" then
                if type(team.members) ~= "table" then
                    continue
                end

                for _, member in team.members do
                    if type(member) == "table" and member.id == a111 and type(member.name) == "string" then
                        return member.name
                    end
                end
            end
        end
    end

    return ""
end

local function publish()
    --[[
      name: publish
      line: 270
      upvalues:
        spectateMode (ref,  index: 1)
        candidates (copy, index: 2)
        localPlayer (copy, index: 3)
        target (ref,  index: 4)
        v9 (ref,  index: 5)
        players (copy, index: 6)
        snapshotName (copy, index: 7)
        v14 (ref,  index: 8)
        v5 (copy, index: 9)
    ]]
    local v118
    local spectateCount = 0

    if spectateMode == "follow" then
        spectateCount = #candidates(true)

        if spectateCount == 0 then
            spectateCount = #candidates(false)
        end
    end

    localPlayer:SetAttribute("SpectateCount", spectateCount)
    local v120 = spectateMode == "follow" and target ~= nil
    localPlayer:SetAttribute("SpectateMode", spectateMode)
    local spectateTargetId = not v120 and "" or target
    localPlayer:SetAttribute("SpectateTargetId", spectateTargetId)

    if v120 then
        if v9 then
            if const character = v9 then
                local displayName = character:GetAttribute("DisplayName")

                if type(displayName) == "string" and displayName ~= "" then
                    v118, v118 = displayName, v5
                elseif const player = players:GetPlayerFromCharacter(character) then
                    v118 = player.DisplayName
                    v118 = v5
                else
                    v118 = character.Name
                    v118 = v5
                end
            else
                v118 = ""
                v118 = v5
            end
        else
            v118 = snapshotName(target)
            v118 = v5
        end
    else
        v118 = ""
        v118 = v5
    end

    localPlayer:SetAttribute("SpectateTargetName", v118)
    localPlayer:SetAttribute("SpectateKillerName", v14)
    local changed = v118.Changed
    local v126 = if spectateMode == "follow" then v9 else nil
    changed:Fire(v126, spectateMode)
end

local result = nil

local function playSwitch()
    --[[
      name: playSwitch
      line: 282
      upvalues:
        result (ref, index: 1)
    ]]
    if result == nil then
        local sfx = script.Parent.Parent:FindFirstChild("Sfx")
        result = false

        if sfx and sfx:IsA("ModuleScript") then
            local success, result2 = pcall(require, sfx)

            if success and type(result2) == "table" then
                result = result2
            end
        end
    end

    if result and type(result.PlayUI) == "function" then
        pcall(result.PlayUI, "UI/Spectate_Switch")
    end
end

local function resolveTarget()
    --[[
      name: resolveTarget
      line: 299
      upvalues:
        v5 (copy, index: 1)
        target (ref,  index: 2)
        v9 (ref,  index: 3)
        humanoidAlive (copy, index: 4)
    ]]
    local v133 = v5.ResolveCombatant(target)

    if not v133 or not humanoidAlive(v133) then
        v9 = nil
    else
        v9 = v133
    end
end

local instance = nil
local timestamp5 = 0

local function reportFocus(a137: boolean?)
    --[[
      name: reportFocus
      line: 308
      upvalues:
        spectateMode (ref,  index: 1)
        target (ref,  index: 2)
        localPlayer (copy, index: 3)
        v11 (ref,  index: 4)
        timestamp5 (ref,  index: 5)
        instance (ref,  index: 6)
        replicatedStorage (copy, index: 7)
    ]]
    local v138

    if spectateMode ~= "follow" or not target then
        v138 = false
    else
        local spectating
        local spectating2 = localPlayer:GetAttribute("Spectating")

        if type(spectating2) ~= "string" or spectating2 == "" or localPlayer:GetAttribute("State") == "Match" then
            spectating = ""
        else
            spectating = spectating2
        end

        if spectating ~= "" then
            v138 = false
        else
            v138 = target
        end
    end

    if v138 == v11 and not a137 then
        return
    end

    v11 = v138
    timestamp5 = os.clock()

    if not instance then
        local instance2 = replicatedStorage:FindFirstChild("Remotes")
        instance2 = instance2 and instance2:FindFirstChild("SpectateFocus")
        instance = if instance2 and instance2:IsA("RemoteEvent") then instance2 else nil
    end

    if instance then
        instance:FireServer(v138)
    end
end

local function setTarget(target2)
    --[[
      name: setTarget
      line: 325
      upvalues:
        target (ref,  index: 1)
        spectateMode (ref,  index: 2)
        playSwitch (copy, index: 3)
        v5 (copy, index: 4)
        v9 (ref,  index: 5)
        timestamp3 (ref,  index: 6)
        reportFocus (copy, index: 7)
        publish (copy, index: 8)
        humanoidAlive (copy, index: 9)
    ]]
    local v144

    if target2 ~= target and target2 ~= nil and spectateMode == "follow" then
        playSwitch()
    end

    target = target2

    if const v145 = v5.ResolveCombatant(target) then
        if humanoidAlive(v145) then
            v144 = v145
        else
            v144 = nil
        end
    else
        v144 = nil
    end

    v9 = v144
    timestamp3 = nil
    reportFocus()
    publish()
end

local function pick(a147)
    --[[
      name: pick
      line: 336
      upvalues:
        candidates (copy, index: 1)
        target (ref,  index: 2)
        spectateMode (ref,  index: 3)
        playSwitch (copy, index: 4)
        v5 (copy, index: 5)
        v9 (ref,  index: 6)
        timestamp3 (ref,  index: 7)
        reportFocus (copy, index: 8)
        publish (copy, index: 9)
        humanoidAlive (copy, index: 10)
    ]]
    local v148 = candidates(true)

    if #v148 == 0 then
        v148 = candidates(false)
    end

    if #v148 == 0 then
        if target ~= nil then
            local v149
            target = nil

            if const v150 = v5.ResolveCombatant(target) then
                if humanoidAlive(v150) then
                    v149 = v150
                else
                    v149 = nil
                end
            else
                v149 = nil
            end

            v9 = v149
            timestamp3 = nil
            reportFocus()
            publish()
        end

        return
    end

    local v151 = if const v152 = if target then table.find(v148, target) else nil then ((v152 - 1) + a147) % #v148 + 1 else not (a147 < 0)
        and 1
        or #v148

    if v148[v151] ~= target then
        local v153
        local v154 = v148[v151]

        if v154 ~= target and v154 ~= nil and spectateMode == "follow" then
            playSwitch()
        end

        target = v154

        if const v155 = v5.ResolveCombatant(target) then
            if humanoidAlive(v155) then
                v153 = v155
            else
                v153 = nil
            end
        else
            v153 = nil
        end

        v9 = v153
        timestamp3 = nil
        reportFocus()
        publish()
    end
end

local function followWanted()
    --[[
      name: followWanted
      line: 362
      upvalues:
        localPlayer (copy, index: 1)
        candidates (copy, index: 2)
        target (ref,  index: 3)
        spectateMode (ref,  index: 4)
        playSwitch (copy, index: 5)
        v5 (copy, index: 6)
        v9 (ref,  index: 7)
        timestamp3 (ref,  index: 8)
        reportFocus (copy, index: 9)
        publish (copy, index: 10)
        humanoidAlive (copy, index: 11)
    ]]
    local spectateFollow = localPlayer:GetAttribute("SpectateFollow")

    if type(spectateFollow) == "string" and spectateFollow ~= "" then
        local spectating
        local spectating2 = localPlayer:GetAttribute("Spectating")

        if type(spectating2) ~= "string" then
            spectating = ""
        elseif spectating2 == "" or localPlayer:GetAttribute("State") == "Match" then
            spectating = ""
        else
            spectating = spectating2
        end

        if spectating ~= "" then
            for _, v161 in candidates(false) do
                if v161 == spectateFollow then
                    local v162

                    if v161 ~= target then
                        if v161 ~= nil then
                            if spectateMode == "follow" then
                                playSwitch()
                            end

                            target = v161
                            local v163 = v5.ResolveCombatant(target)

                            if v163 then
                                if humanoidAlive(v163) then
                                    v162 = v163
                                end
                            else
                                v162 = nil
                            end

                            v9 = v162
                            timestamp3 = nil
                            reportFocus()
                            publish()
                            localPlayer:SetAttribute("SpectateFollow", nil)

                            return true
                        end
                    end

                    target = v161
                    local v163 = v5.ResolveCombatant(target)

                    if v163 then
                        humanoidAlive(v163)
                    else
                        v162 = nil
                    end

                    v9 = v162
                    timestamp3 = nil
                    reportFocus()
                    publish()
                    localPlayer:SetAttribute("SpectateFollow", nil)

                    return true
                end
            end

            return false
        end
    end

    return false
end

local function wantsSpectate()
    --[[
      name: wantsSpectate
      line: 377
      upvalues:
        localPlayer (copy, index: 1)
    ]]
    local spectating
    local spectating2 = localPlayer:GetAttribute("Spectating")

    if type(spectating2) ~= "string" or spectating2 == "" or localPlayer:GetAttribute("State") == "Match" then
        spectating = ""
    else
        spectating = spectating2
    end

    if spectating ~= "" then
        return true
    end
    if localPlayer:GetAttribute("State") ~= "Match" then
        return false
    end
    if localPlayer:GetAttribute("Alive") == false then
        return true
    end

    local character = localPlayer.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")

    return humanoid ~= nil and humanoid.Health <= 0
end

local v169 = nil
local formattedText = ""

local function noteUnexplained()
    --[[
      name: noteUnexplained
      line: 400
      upvalues:
        localPlayer (copy, index: 1)
        formattedText (ref,  index: 2)
    ]]
    local flooredValue
    local flooredValue2
    local v174 = localPlayer:GetAttribute("MatchId")
    local arenas = workspace:FindFirstChild("Arenas")
    local child = arenas and type(v174) == "string" and arenas:FindFirstChild(v174)
    local round = child and child:GetAttribute("Round")
    local formattedText2 = `{v174}:{round}`

    if formattedText2 == formattedText then
        return
    end

    formattedText = formattedText2
    local character = localPlayer.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

    if character
        and character.Parent
        and humanoid
        and humanoid.Health <= 0
        and localPlayer:GetAttribute("Alive") == false
    then
        return
    end

    local warn = warn
    local name = localPlayer.Name
    local alive = localPlayer:GetAttribute("Alive")
    local v185 = character and (character.Parent and "in world" or "removed") or "none"

    if humanoid then
        flooredValue = math.floor(humanoid.Health)
        flooredValue = flooredValue or "-"
    else
        flooredValue = "-"
    end

    local name2 = humanoid and humanoid:GetState().Name or "-"

    if humanoidRootPart then
        flooredValue2 = math.floor(humanoidRootPart.Position.Y)
        flooredValue2 = flooredValue2 or "-"
    else
        flooredValue2 = "-"
    end

    local phase = child and child:GetAttribute("Phase") or "-"
    warn((`[Spectate] {name} down with no attacker: Alive {alive}, body {v185}, hp {flooredValue}, state {name2}, y {flooredValue2}, phase {phase} r{round
        or "-"}`))
end

local function resolveKiller()
    --[[
      name: resolveKiller
      line: 419
      upvalues:
        v5 (copy, index: 1)
        v13 (ref,  index: 2)
        v12 (ref,  index: 3)
        v14 (ref,  index: 4)
        players (copy, index: 5)
    ]]
    local character = v5.ResolveCombatant(v13)
    v12 = character

    if character then
        local v190

        if character then
            local displayName = character:GetAttribute("DisplayName")

            if type(displayName) == "string" and displayName ~= "" then
                v190 = displayName
                v14 = v190

                return
            end

            v190 = if const player = players:GetPlayerFromCharacter(character) then player.DisplayName else character.Name
        else
            v190 = ""
        end

        v14 = v190
    end
end

local function enterDeath(a194)
    --[[
      name: enterDeath
      line: 427
      upvalues:
        spectateMode (ref,  index: 1)
        timestamp (ref,  index: 2)
        v16 (ref,  index: 3)
        target (ref,  index: 4)
        v9 (ref,  index: 5)
        v11 (ref,  index: 6)
        v12 (ref,  index: 7)
        v14 (ref,  index: 8)
        v13 (ref,  index: 9)
        timestamp2 (ref,  index: 10)
        attackerId (ref,  index: 11)
        v5 (copy, index: 12)
        players (copy, index: 13)
        publish (copy, index: 14)
    ]]
    spectateMode = "death"
    timestamp = os.clock()
    v16 = a194
    target = nil
    v9 = nil
    v11 = false
    v12 = nil
    v14 = ""

    if v13 == nil and os.clock() - timestamp2 < 4 then
        v13 = attackerId
    end

    local character = v5.ResolveCombatant(v13)
    v12 = character

    if character then
        local v196

        if character then
            local displayName = character:GetAttribute("DisplayName")

            if type(displayName) == "string" and displayName ~= "" then
                v196 = displayName
            else
                v196 = if const player = players:GetPlayerFromCharacter(character) then player.DisplayName else character.Name
            end
        else
            v196 = ""
        end

        v14 = v196
    end

    publish()
end

local function leave()
    --[[
      name: leave
      line: 443
      upvalues:
        v169 (ref,  index: 1)
        spectateMode (ref,  index: 2)
        target (ref,  index: 3)
        v9 (ref,  index: 4)
        v11 (ref,  index: 5)
        v12 (ref,  index: 6)
        v13 (ref,  index: 7)
        v14 (ref,  index: 8)
        v16 (ref,  index: 9)
        timestamp3 (ref,  index: 10)
        publish (copy, index: 11)
    ]]
    v169 = nil
    spectateMode = "none"
    target = nil
    v9 = nil
    v11 = false
    v12 = nil
    v13 = nil
    v14 = ""
    v16 = nil
    timestamp3 = nil
    publish()
end

function v5.Step(a200)
    --[[
      name: Step
      line: 458
      upvalues:
        wantsSpectate (copy, index: 1)
        spectateMode (ref,  index: 2)
        v169 (ref,  index: 3)
        target (ref,  index: 4)
        v9 (ref,  index: 5)
        v11 (ref,  index: 6)
        v12 (ref,  index: 7)
        v13 (ref,  index: 8)
        v14 (ref,  index: 9)
        v16 (ref,  index: 10)
        timestamp3 (ref,  index: 11)
        publish (copy, index: 12)
        localPlayer (copy, index: 13)
        followWanted (copy, index: 14)
        pick (copy, index: 15)
        enterDeath (copy, index: 16)
        noteUnexplained (copy, index: 17)
        timestamp4 (ref,  index: 18)
        v5 (copy, index: 19)
        players (copy, index: 20)
        timestamp (ref,  index: 21)
        candidates (copy, index: 22)
        isEnemy (copy, index: 23)
        timestamp5 (ref,  index: 24)
        reportFocus (copy, index: 25)
        humanoidAlive (copy, index: 26)
    ]]
    local timestamp2 = os.clock()

    if not wantsSpectate() then
        if spectateMode ~= "none" then
            v169 = nil
            spectateMode = "none"
            target = nil
            v9 = nil
            v11 = false
            v12 = nil
            v13 = nil
            v14 = ""
            v16 = nil
            timestamp3 = nil
            publish()
        end

        return spectateMode
    end

    if spectateMode == "none" then
        local spectating
        local spectating2 = localPlayer:GetAttribute("Spectating")

        if type(spectating2) ~= "string" or spectating2 == "" or localPlayer:GetAttribute("State") == "Match" then
            spectating = ""
        else
            spectating = spectating2
        end

        if spectating == "" then
            enterDeath(a200)
            v169 = if v13 == nil then timestamp2 else nil

            return spectateMode
        end

        spectateMode = "follow"
        target = nil
        v9 = nil
        v14 = ""

        if not followWanted() then
            pick(1)
        end

        publish()

        return spectateMode
    end

    if v169 and 3 <= timestamp2 - v169 then
        v169 = nil
        noteUnexplained()
    end

    if timestamp2 - timestamp4 < 0.25 then
        return spectateMode
    end

    timestamp4 = timestamp2

    if spectateMode == "death" then
        if v12 == nil or v12.Parent == nil then
            local character = v5.ResolveCombatant(v13)
            v12 = character

            if character then
                local v205

                if character then
                    local displayName = character:GetAttribute("DisplayName")

                    if type(displayName) == "string" and displayName ~= "" then
                        v205 = displayName
                    else
                        v205 = if const player = players:GetPlayerFromCharacter(character) then player.DisplayName else character.Name
                    end
                else
                    v205 = ""
                end

                v14 = v205
            end
        end

        if 1.55 <= timestamp2 - timestamp then
            spectateMode = "follow"
            pick(1)
            publish()
        end
    elseif spectateMode == "follow" then
        local v208
        local spectateCount = 0

        if spectateMode == "follow" then
            spectateCount = #candidates(true)

            if spectateCount == 0 then
                spectateCount = #candidates(false)
            end
        end

        localPlayer:SetAttribute("SpectateCount", spectateCount)
        followWanted()
        local v210 = v9

        if const v211 = v5.ResolveCombatant(target) then
            if humanoidAlive(v211) then
                v208 = v211
            else
                v208 = nil
            end
        else
            v208 = nil
        end

        local spectating
        local spectating3
        local v214, v215, v216, v217, v218 = false, false, false, false, false
        v9 = v208

        if v9 ~= v210 then
            publish()
        end

        local target2 = target
        if target2 == nil then
            pick(1)
            return spectateMode
        end

        local v220 = candidates(true)
        local v221 = table.find(v220, target2) ~= nil

        if v221 then
            v216 = true
        elseif not (0 < #v220) then
            v216 = true
        else
            spectating = localPlayer:GetAttribute("Spectating")

            if type(spectating) ~= "string" then
                v214 = true
            elseif spectating == "" then
                v214 = true
            elseif localPlayer:GetAttribute("State") == "Match" then
                v214 = true
            else
                spectating3 = spectating
                v215 = true
            end
        end

        if v214 then
            spectating3 = ""
            v215 = true
        end

        if v215 then
            if spectating3 ~= "" then
                v216 = true
            elseif isEnemy(target2) then
                pick(1)
            else
                v216 = true
            end
        end

        if v216 then
            if v9 ~= nil then
                timestamp3 = nil
            elseif v221 then
                v218 = true
            elseif table.find(candidates(false), target2) == nil then
                if timestamp3 == nil then
                    timestamp3 = timestamp2
                end

                v217 = true
            else
                v218 = true
            end
        end

        if v217 and 0.9 <= timestamp2 - timestamp3 then
            pick(1)
        end

        if v218 then
            timestamp3 = nil

            if 2 < timestamp2 - timestamp5 then
                reportFocus(true)
            end
        end
    end

    return spectateMode
end

function v5.GetMode()
    --[[
      name: GetMode
      line: 543
      upvalues:
        spectateMode (ref, index: 1)
    ]]
    return spectateMode
end

function v5.GetTarget()
    --[[
      name: GetTarget
      line: 547
      upvalues:
        spectateMode (ref, index: 1)
        v9 (ref, index: 2)
    ]]
    if spectateMode == "follow" then
        return v9
    end

    return nil
end

function v5.GetTargetId()
    --[[
      name: GetTargetId
      line: 552
      upvalues:
        spectateMode (ref, index: 1)
        target (ref, index: 2)
    ]]
    if spectateMode == "follow" then
        return target
    end

    return nil
end

function v5.GetKiller()
    --[[
      name: GetKiller
      line: 556
      upvalues:
        v12 (ref, index: 1)
    ]]
    return v12
end

function v5.GetDeathPosition()
    --[[
      name: GetDeathPosition
      line: 560
      upvalues:
        v16 (ref, index: 1)
    ]]
    return v16
end

function v5.DeathElapsed()
    --[[
      name: DeathElapsed
      line: 564
      upvalues:
        timestamp (ref, index: 1)
    ]]
    return os.clock() - timestamp
end

function v5.Next(a222)
    --[[
      name: Next
      line: 568
      upvalues:
        spectateMode (ref,  index: 1)
        pick (copy, index: 2)
    ]]
    if spectateMode ~= "follow" then
        return
    end

    local v223 = not (a222 < 0) and 1 or -1
    pick(v223)
end

local function onRemote(childName: string, a226)
    --[[
      name: onRemote
      line: 576
      upvalues:
        replicatedStorage (copy, index: 1)
    ]]
    task.spawn(
        function()
            --[[
              line: 577
              upvalues:
                replicatedStorage (copy, index: 1)
                childName (copy, index: 2)
                a226 (copy, index: 3)
            ]]
            local remotes = replicatedStorage:WaitForChild("Remotes", 60)

            while not remotes do
                remotes = replicatedStorage:WaitForChild("Remotes", 60)
            end

            local child = remotes:FindFirstChild(childName)

            while not child do
                remotes.ChildAdded:Wait()
                child = remotes:FindFirstChild(childName)
            end

            if child and child:IsA("RemoteEvent") then
                child.OnClientEvent:Connect(a226)
            end
        end
    )
end

function v5.Start()
    --[[
      name: Start
      line: 593
      upvalues:
        hasRun (ref,  index: 1)
        publish (copy, index: 2)
        localPlayer (copy, index: 3)
        v13 (ref,  index: 4)
        v14 (ref,  index: 5)
        spectateMode (ref,  index: 6)
        v5 (copy, index: 7)
        v12 (ref,  index: 8)
        players (copy, index: 9)
        target (ref,  index: 10)
        timestamp3 (ref,  index: 11)
        replicatedStorage (copy, index: 12)
        v10 (ref,  index: 13)
        attackerId (ref,  index: 14)
        timestamp2 (ref,  index: 15)
    ]]
    if hasRun then
        return
    end

    hasRun = true
    publish()

    local onOnClientEvent = function(a230, a231)
        --[[
          line: 599
          upvalues:
            localPlayer (copy, index: 1)
            v13 (ref,  index: 2)
            v14 (ref,  index: 3)
            spectateMode (ref,  index: 4)
            v5 (copy, index: 5)
            v12 (ref,  index: 6)
            players (copy, index: 7)
            publish (copy, index: 8)
            target (ref,  index: 9)
            timestamp3 (ref,  index: 10)
        ]]
        if a230 ~= "Elimination" or type(a231) ~= "table" then
            return
        end

        if a231.victimId ~= "p" .. tostring(localPlayer.UserId) then
            if spectateMode == "follow" and target and a231.victimId == target then
                timestamp3 = os.clock()
            end
        else
            if type(a231.killerId) ~= "string" then
                v13 = nil
            else
                v13 = a231.killerId
            end

            if type(a231.killerName) == "string" then
                v14 = a231.killerName
            end

            if spectateMode == "death" then
                local character = v5.ResolveCombatant(v13)
                v12 = character

                if character then
                    local v233

                    if character then
                        local displayName = character:GetAttribute("DisplayName")

                        if type(displayName) == "string" and displayName ~= "" then
                            v233 = displayName
                        else
                            v233 = if const player = players:GetPlayerFromCharacter(character) then player.DisplayName else character.Name
                        end
                    else
                        v233 = ""
                    end

                    v14 = v233
                end

                publish()
            end
        end
    end

    local childName = "MatchEvent"

    task.spawn(
        function()
            --[[
              line: 577
              upvalues:
                replicatedStorage (copy, index: 1)
                childName (copy, index: 2)
                onOnClientEvent (copy, index: 3)
            ]]
            local remotes = replicatedStorage:WaitForChild("Remotes", 60)

            while not remotes do
                remotes = replicatedStorage:WaitForChild("Remotes", 60)
            end

            local child = remotes:FindFirstChild(childName)

            while not child do
                remotes.ChildAdded:Wait()
                child = remotes:FindFirstChild(childName)
            end

            if child and child:IsA("RemoteEvent") then
                child.OnClientEvent:Connect(onOnClientEvent)
            end
        end
    )

    local onOnClientEvent2 = function(a240)
        --[[
          line: 616
          upvalues:
            v10 (ref, index: 1)
        ]]
        if type(a240) == "table" then
            v10 = a240
        end
    end

    local childName2 = "MatchState"

    task.spawn(
        function()
            --[[
              line: 577
              upvalues:
                replicatedStorage (copy, index: 1)
                childName2 (copy, index: 2)
                onOnClientEvent2 (copy, index: 3)
            ]]
            local remotes = replicatedStorage:WaitForChild("Remotes", 60)

            while not remotes do
                remotes = replicatedStorage:WaitForChild("Remotes", 60)
            end

            local child = remotes:FindFirstChild(childName2)

            while not child do
                remotes.ChildAdded:Wait()
                child = remotes:FindFirstChild(childName2)
            end

            if child and child:IsA("RemoteEvent") then
                child.OnClientEvent:Connect(onOnClientEvent2)
            end
        end
    )

    local onOnClientEvent3 = function(a245)
        --[[
          line: 621
          upvalues:
            attackerId (ref, index: 1)
            timestamp2 (ref, index: 2)
        ]]
        if type(a245) == "table" and type(a245.attackerId) == "string" then
            attackerId = a245.attackerId
            timestamp2 = os.clock()
        end
    end

    local childName3 = "DamageTaken"

    task.spawn(
        function()
            --[[
              line: 577
              upvalues:
                replicatedStorage (copy, index: 1)
                childName3 (copy, index: 2)
                onOnClientEvent3 (copy, index: 3)
            ]]
            local remotes = replicatedStorage:WaitForChild("Remotes", 60)

            while not remotes do
                remotes = replicatedStorage:WaitForChild("Remotes", 60)
            end

            local child = remotes:FindFirstChild(childName3)

            while not child do
                remotes.ChildAdded:Wait()
                child = remotes:FindFirstChild(childName3)
            end

            if child and child:IsA("RemoteEvent") then
                child.OnClientEvent:Connect(onOnClientEvent3)
            end
        end
    )

    localPlayer.CharacterAdded:Connect(
        function()
            --[[
              line: 628
              upvalues:
                spectateMode (ref, index: 1)
                v13 (ref, index: 2)
            ]]
            if spectateMode == "none" then
                v13 = nil
            end
        end
    )
end

return v5