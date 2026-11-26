local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local shared = replicatedStorage:WaitForChild("Shared")
local Signal = require(shared:WaitForChild("Signal"))
local Tribes = require(shared:WaitForChild("Tribes"))
local v6 = {}
local v7 = {}

function v6.Init(a8)
    --[[
      name: Init
      line: 31
      upvalues:
        players (copy, index: 1)
        Signal (copy, index: 2)
        Tribes (copy, index: 3)
        v7 (copy, index: 4)
    ]]
    local function Of(a10)
        --[[
          name: Of
          line: 178
        ]]
        if not a10 then
            return nil
        end

        local tribeId = a10:GetAttribute("TribeId")
        local tribeTag = a10:GetAttribute("TribeTag")

        if type(tribeId) == "number" and not (tribeId <= 0) and type(tribeTag) == "string" and tribeTag ~= "" then
            return {id = tribeId, tag = tribeTag, icon = a10:GetAttribute("TribeIcon") or 1, color1 = a10:GetAttribute("TribeColor1")
                or 1, color2 = a10:GetAttribute("TribeColor2") or 1, role = a10:GetAttribute("TribeRole") or "member"}
        end

        return nil
    end

    local remotes = a8.Remotes
    local localPlayer = players.LocalPlayer
    local tribes = {Changed = Signal.new(), HomeChanged = Signal.new()}
    remotes.Timeouts.TribeAction = 20
    local v16 = nil
    local timestamp = -math.huge
    local v18 = nil
    local timestamp2 = -math.huge
    local v20 = false

    function tribes.Action(a21, ...)
        --[[
          name: Action
          line: 45
          upvalues:
            remotes (copy, index: 1)
            Tribes (copy, index: 2)
        ]]
        local v22, v23, v24 = remotes.Invoke("TribeAction", a21, ...)
        if not v22 then
            return false, Tribes.Message("unavailable")
        end
        if v23 ~= true then
            return false, Tribes.Message(v24)
        end

        return true, v24
    end

    function tribes.Home(a25)
        --[[
          name: Home
          line: 56
          upvalues:
            v16 (ref,  index: 1)
            timestamp (ref,  index: 2)
            v20 (ref,  index: 3)
            tribes (copy, index: 4)
        ]]
        if not a25 and v16 and os.clock() - timestamp < 8 then
            return v16
        end

        if v20 then
            local timestamp2 = os.clock()

            while v20 and os.clock() - timestamp2 < 10 do
                task.wait(0.05)
            end

            return v16
        end

        v20 = true
        local v27, v28 = tribes.Action("Home")
        v20 = false

        if not v27 or type(v28) ~= "table" then
            return nil
        end

        v16 = v28
        timestamp = os.clock()
        tribes.HomeChanged:Fire(v16)

        return v16
    end

    function tribes.Cached()
        --[[
          name: Cached
          line: 79
          upvalues:
            v16 (ref, index: 1)
        ]]
        return v16
    end

    local v29 = {}
    local v30 = {}

    local function listed(a32, a33, callback)
        --[[
          name: listed
          line: 86
          upvalues:
            v29 (copy, index: 1)
            v30 (copy, index: 2)
            Tribes (copy, index: 3)
        ]]
        local v35 = v29[a32]

        if not a33 and v35 and os.clock() - v35.at < 15 then
            return true, v35.v
        end

        if not v30[a32] then
            v30[a32] = true
            local v36, v = callback()
            v30[a32] = nil

            if v36 then
                v29[a32] = {at = os.clock(), v = v}
            end

            return v36, v
        end

        local timestamp = os.clock()

        while v30[a32] and os.clock() - timestamp < 20 do
            task.wait(0.03)
        end

        if const v39 = v29[a32] then
            return true, v39.v
        end

        return false, Tribes.Message("unavailable")
    end

    local function rankKey(a41)
        --[[
          name: rankKey
          line: 110
          upvalues:
            localPlayer (copy, index: 1)
        ]]
        return (`rank:{localPlayer:GetAttribute("TribeId") or 0}|{a41}`)
    end

    function tribes.Board(a42, a43)
        --[[
          name: Board
          line: 114
          upvalues:
            listed (copy, index: 1)
            tribes (copy, index: 2)
        ]]
        return listed(
            "board:" .. a42,
            a43,
            function()
                --[[
                  line: 115
                  upvalues:
                    tribes (copy, index: 1)
                    a42 (copy, index: 2)
                ]]
                return tribes.Action("Search", "", a42)
            end
        )
    end

    function tribes.Rank(a44, a45)
        --[[
          name: Rank
          line: 120
          upvalues:
            listed (copy, index: 1)
            localPlayer (copy, index: 2)
            tribes (copy, index: 3)
        ]]
        return listed(
            `rank:{localPlayer:GetAttribute("TribeId") or 0}|{a44}`,
            a45,
            function()
                --[[
                  line: 121
                  upvalues:
                    tribes (copy, index: 1)
                    a44 (copy, index: 2)
                ]]
                return tribes.Action("Rank", a44)
            end
        )
    end

    function tribes.CachedBoard(a46)
        --[[
          name: CachedBoard
          line: 126
          upvalues:
            v29 (copy, index: 1)
        ]]
        local v47 = v29["board:" .. a46]
        local v48 = if v47 then v47.v else nil

        if v47 then
            return v48, os.clock() - v47.at
        end

        return v48, math.huge
    end

    function tribes.CachedRank(a49)
        --[[
          name: CachedRank
          line: 131
          upvalues:
            v29 (copy, index: 1)
            localPlayer (copy, index: 2)
        ]]
        local v50 = v29[`rank:{localPlayer:GetAttribute("TribeId") or 0}|{a49}`]
        local v51 = if v50 then v50.v else nil

        if v50 then
            return v51, os.clock() - v50.at
        end

        return v51, math.huge
    end

    task.delay(
        2,
        function()
            --[[
              line: 139
              upvalues:
                a8 (copy, index: 1)
                tribes (copy, index: 2)
            ]]
            local state = a8.State

            if state and state.InMatch and state.InMatch() then
                return
            end

            task.spawn(tribes.Board, "top")
            task.spawn(tribes.Board, "alltime")

            if tribes.Mine() then
                task.spawn(tribes.Rank, "top")
            end
        end
    )

    function tribes.Territories(a53)
        --[[
          name: Territories
          line: 151
          upvalues:
            v18 (ref,  index: 1)
            timestamp2 (ref,  index: 2)
            tribes (copy, index: 3)
            v7 (copy, index: 4)
        ]]
        if not a53 and v18 and os.clock() - timestamp2 < 30 then
            return v18
        end

        local v54, v55 = tribes.Action("Territories")

        if v54 and type(v55) == "table" then
            local v56
            v18 = v55
            timestamp2 = os.clock()

            if type(v55.maps) ~= "table" then
                v56 = {}
            else
                v56 = v55.maps
            end

            for v57, v58 in v56 do
                if type(v58) == "table" and type(v58.name) == "string" then
                    v7[v57] = v58.name
                end
            end
        end

        return v18
    end

    function tribes.CachedTerritories()
        --[[
          name: CachedTerritories
          line: 169
          upvalues:
            v18 (ref, index: 1)
        ]]
        return v18
    end

    function tribes.MapName(a59)
        --[[
          name: MapName
          line: 173
          upvalues:
            v7 (copy, index: 1)
        ]]
        return v7[tostring(a59)] or string.gsub(tostring(a59), "(%l)(%u)", "%1 %2")
    end

    tribes.Of = Of

    function tribes.Mine()
        --[[
          name: Mine
          line: 197
          upvalues:
            tribes (copy, index: 1)
            localPlayer (copy, index: 2)
        ]]
        return tribes.Of(localPlayer)
    end

    local isBusy = false

    local function invalidate()
        --[[
          name: invalidate
          line: 203
          upvalues:
            timestamp (ref,  index: 1)
            tribes (copy, index: 2)
            isBusy (ref,  index: 3)
            a8 (copy, index: 4)
        ]]
        timestamp = -math.huge
        tribes.Changed:Fire()

        if isBusy then
            return
        end

        isBusy = true

        task.delay(
            0.4,
            function()
                --[[
                  line: 210
                  upvalues:
                    isBusy (ref,  index: 1)
                    a8 (copy, index: 2)
                    tribes (copy, index: 3)
                ]]
                isBusy = false

                if a8.MenuManager.IsOpen("Tribe") then
                    tribes.Home(true)
                end
            end
        )
    end

    for _, attribute in {"TribeId", "TribeTag", "TribeRole", "TribeIcon", "TribeColor1", "TribeColor2"} do
        localPlayer:GetAttributeChangedSignal(attribute):Connect(invalidate)
    end

    local function tag(a65)
        --[[
          name: tag
          line: 221
        ]]
        if type(a65) == "table" and type(a65.tag) == "string" then
            return "[" .. a65.tag .. "]"
        end

        return "your tribe"
    end

    local v66 = {chief = "the Chief", elder = "an Elder", member = "a Member"}
    local v67 = {
        request = (function(a68)
            --[[
              name: request
              line: 226
            ]]
            return `{(tostring(a68.name or "Someone"))} asked to join your tribe`, "info"
        end),
        accepted = (function(a69)
            --[[
              name: accepted
              line: 229
            ]]
            local v70
            local formatString = "You joined %*!"

            if type(a69) ~= "table" or type(a69.tag) ~= "string" then
                v70 = "your tribe"
            else
                v70 = "[" .. a69.tag .. "]"
            end

            return formatString:format(v70), "success"
        end),
        declined = (function(a72)
            --[[
              name: declined
              line: 232
            ]]
            local v73
            local formatString = "%* declined your request"

            if type(a72) ~= "table" or type(a72.tag) ~= "string" then
                v73 = "your tribe"
            else
                v73 = "[" .. a72.tag .. "]"
            end

            return formatString:format(v73), "warning"
        end),
        invited = (function(options)
            --[[
              name: invited
              line: 235
            ]]
            local v76
            local formatString = "%* invited you to %* %*. Open Tribes to answer"
            local text = tostring((options.from or "Someone"))

            if type(options) ~= "table" or type(options.tag) ~= "string" then
                v76 = "your tribe"
            else
                v76 = "[" .. options.tag .. "]"
            end

            return formatString:format(text, v76, (tostring(options.name or ""))), "info"
        end),
        kicked = (function(a79)
            --[[
              name: kicked
              line: 238
            ]]
            local v80
            local formatString = "You were removed from %*"

            if type(a79) ~= "table" or type(a79.tag) ~= "string" then
                v80 = "your tribe"
            else
                v80 = "[" .. a79.tag .. "]"
            end

            return formatString:format(v80), "warning"
        end),
        role = (function(a82)
            --[[
              name: role
              line: 241
              upvalues:
                v66 (copy, index: 1)
            ]]
            return `You're now {v66[a82.role] or "a Member"} of your tribe`, "success"
        end),
        took = (function(a83)
            --[[
              name: took
              line: 244
              upvalues:
                tribes (copy, index: 1)
            ]]
            return `Your tribe took {(tribes.MapName(a83.mapId))}!`, "success"
        end),
        lost = (function(a84)
            --[[
              name: lost
              line: 247
              upvalues:
                tribes (copy, index: 1)
            ]]
            return `[{tostring((a84.to or "?"))}] took {(tribes.MapName(a84.mapId))} from your tribe`, "warning"
        end),
        visitFailed = (function()
            --[[
              name: visitFailed
              line: 250
            ]]
            return "Couldn't join their lobby. It may be full.", "error"
        end)
    }

    remotes.On(
        "TribeEvent",
        function(a85, a86)
            --[[
              line: 254
              upvalues:
                timestamp (ref,  index: 1)
                tribes (copy, index: 2)
                isBusy (ref,  index: 3)
                a8 (copy, index: 4)
                v67 (copy, index: 5)
                timestamp2 (ref,  index: 6)
            ]]
            if a85 == "Changed" then
                timestamp = -math.huge
                tribes.Changed:Fire()

                if isBusy then
                    return
                end

                isBusy = true

                task.delay(
                    0.4,
                    function()
                        --[[
                          line: 210
                          upvalues:
                            isBusy (ref,  index: 1)
                            a8 (copy, index: 2)
                            tribes (copy, index: 3)
                        ]]
                        isBusy = false

                        if a8.MenuManager.IsOpen("Tribe") then
                            tribes.Home(true)
                        end
                    end
                )

                return
            end

            if a85 == "Notice" then
                local v87

                if type(a86) == "table" then
                    if const v88 = v67[tostring(a86.kind)] then
                        local v89

                        if type(a86.data) ~= "table" then
                            v89 = {}
                        else
                            v89 = a86.data
                        end

                        local v87, v90 = v88(v89)
                        if v87 then
                            a8.Toast(v87, v90, true)
                        end
                    end

                    if a86.kind ~= "took" and a86.kind ~= "lost" then
                        return
                    end

                    timestamp2 = -math.huge

                    return
                end
            end

            if a85 == "Chest" and type(a86) == "table" then
                local formattedText

                if not (0 < (tonumber(a86.territories) or 0)) then
                    formattedText = ""
                else
                    formattedText = ` +{a86.territories} territory bonus`
                end

                a8.Toast(`Tribe Chest opened: tier {tostring(a86.tier)}{formattedText}`, "success", true)
            end
        end
    )

    a8.Tribes = tribes
end

return v6