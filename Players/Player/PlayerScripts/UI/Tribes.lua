local Players_upv_1 = game:GetService("Players")
local v1 = game:GetService("ReplicatedStorage"):WaitForChild("Shared")
local Signal_upv_1 = require(v1:WaitForChild("Signal"))
local Tribes_upv_1 = require(v1:WaitForChild("Tribes"))
v1 = {}
local tbl_upv_1 = {}
function v1.Init(a1)
    --[[
      name: Init
      line: 31
      upvalues:
        Players_upv_1 (copy, index: 1)
        Signal_upv_1 (copy, index: 2)
        Tribes_upv_1 (copy, index: 3)
        tbl_upv_1 (copy, index: 4)
    ]]
    local Remotes_upv_1 = a1.Remotes
    local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
    local tbl_upv_2 = {}
    tbl_upv_2.Changed = Signal_upv_1.new()
    tbl_upv_2.HomeChanged = Signal_upv_1.new()
    Remotes_upv_1.Timeouts.TribeAction = 20
    local u1 = nil
    local u2 = -math.huge
    local u3 = nil
    local u4 = -math.huge
    local u5 = false
    function tbl_upv_2.Action(a2, ...)
        --[[
          name: Action
          line: 45
          upvalues:
            Remotes_upv_1 (copy, index: 1)
            Tribes_upv_1 (copy, index: 2)
        ]]
        local v2, v3, v4 = Remotes_upv_1.Invoke("TribeAction", a2, ...)
        if v2 then
            if v3 == true then
                return true, v4
            end
            return false, Tribes_upv_1.Message(v4)
        end
        return false, Tribes_upv_1.Message("unavailable")
    end
    function tbl_upv_2.Home(a3)
        --[[
          name: Home
          line: 56
          upvalues:
            u1 (ref,  index: 1)
            u2 (ref,  index: 2)
            u5 (ref,  index: 3)
            tbl_upv_2 (copy, index: 4)
        ]]
        if not (a3) and u1 and os.clock() - u2 < 8 then
            return u1
        end
        if u5 then
            local v5 = os.clock()
            while u5 do
                if os.clock() - v5 < 10 then
                    task.wait(0.05)
                    continue
                else
                    break
                end
            end
            return u1
        else
            u5 = true
            local v6, v7 = tbl_upv_2.Action("Home")
            u5 = false
            if v6 and type(v7) == "table" then
                u1 = v7
                u2 = os.clock()
                tbl_upv_2.HomeChanged:Fire(u1)
                return u1
            end
            return nil
        end
    end
    function tbl_upv_2.Cached()
        --[[
          name: Cached
          line: 79
          upvalues:
            u1 (ref, index: 1)
        ]]
        return u1
    end
    local tbl_upv_3 = {}
    local tbl_upv_4 = {}
    local function rankKey(a4)
        --[[
          name: rankKey
          line: 110
          upvalues:
            LocalPlayer_upv_1 (copy, index: 1)
        ]]
        return (("rank:%*|%*"):format(LocalPlayer_upv_1:GetAttribute("TribeId") or 0, a4))
    end
    local function listed(a5, a6, a7)
        --[[
          name: listed
          line: 86
          upvalues:
            tbl_upv_3 (copy, index: 1)
            tbl_upv_4 (copy, index: 2)
            Tribes_upv_1 (copy, index: 3)
        ]]
        local v8 = tbl_upv_3[a5]
        if not (a6) and v8 and os.clock() - v8.at < 15 then
            return true, v8.v
        end
        local v9, v10 = nil, nil
        if tbl_upv_4[a5] then
            local v11 = os.clock()
            while tbl_upv_4[a5] do
                if os.clock() - v11 < 20 then
                    task.wait(0.03)
                    continue
                else
                    break
                end
            end
            v9 = tbl_upv_3[a5]
            if v9 then
                return true, v9.v
            end
            return false, Tribes_upv_1.Message("unavailable")
        else
            tbl_upv_4[a5] = true
            local v10, v12 = a7()
            tbl_upv_4[a5] = nil
            if v10 then
                tbl_upv_3[a5] = {at = os.clock(), v = v12}
            end
            return v10, v12
        end
    end
    function tbl_upv_2.Board(a8, a9)
        --[[
          name: Board
          line: 114
          upvalues:
            listed (copy, index: 1)
            tbl_upv_2 (copy, index: 2)
        ]]
        return listed(
            "board:" .. a8,
            a9,
            function()
                --[[
                  line: 115
                  upvalues:
                    tbl_upv_2 (copy, index: 1)
                    a8 (copy, index: 2)
                ]]
                return tbl_upv_2.Action("Search", "", a8)
            end
        )
    end
    function tbl_upv_2.Rank(a10, a11)
        --[[
          name: Rank
          line: 120
          upvalues:
            listed (copy, index: 1)
            LocalPlayer_upv_1 (copy, index: 2)
            tbl_upv_2 (copy, index: 3)
        ]]
        return listed(
            ("rank:%*|%*"):format(LocalPlayer_upv_1:GetAttribute("TribeId") or 0, a10),
            a11,
            function()
                --[[
                  line: 121
                  upvalues:
                    tbl_upv_2 (copy, index: 1)
                    a10 (copy, index: 2)
                ]]
                return tbl_upv_2.Action("Rank", a10)
            end
        )
    end
    function tbl_upv_2.CachedBoard(a12)
        --[[
          name: CachedBoard
          line: 126
          upvalues:
            tbl_upv_3 (copy, index: 1)
        ]]
        local v13 = tbl_upv_3["board:" .. a12]
        local v14
        if v13 then
            v14 = v13.v
        else
            v14 = nil
        end
        if v13 then
            return v14, os.clock() - v13.at
        end
        return v14, math.huge
    end
    function tbl_upv_2.CachedRank(a13)
        --[[
          name: CachedRank
          line: 131
          upvalues:
            tbl_upv_3 (copy, index: 1)
            LocalPlayer_upv_1 (copy, index: 2)
        ]]
        local v15 = tbl_upv_3[("rank:%*|%*"):format(LocalPlayer_upv_1:GetAttribute("TribeId") or 0, a13)]
        local v16
        if v15 then
            v16 = v15.v
        else
            v16 = nil
        end
        if v15 then
            return v16, os.clock() - v15.at
        end
        return v16, math.huge
    end
    task.delay(
        2,
        function()
            --[[
              line: 139
              upvalues:
                a1 (copy, index: 1)
                tbl_upv_2 (copy, index: 2)
            ]]
            local State_1 = a1.State
            if State_1 and State_1.InMatch and State_1.InMatch() then
                return
            end
            task.spawn(tbl_upv_2.Board, "top")
            task.spawn(tbl_upv_2.Board, "alltime")
            if not tbl_upv_2.Mine() then
                return
            end
            task.spawn(tbl_upv_2.Rank, "top")
        end
    )
    function tbl_upv_2.Territories(a14)
        --[[
          name: Territories
          line: 151
          upvalues:
            u3 (ref,  index: 1)
            u4 (ref,  index: 2)
            tbl_upv_2 (copy, index: 3)
            tbl_upv_1 (copy, index: 4)
        ]]
        if not (a14) and u3 and os.clock() - u4 < 30 then
            return u3
        end
        local v17, v18 = tbl_upv_2.Action("Territories")
        if v17 and type(v18) == "table" then
            u3 = v18
            local v19 = os.clock()
            u4 = v19
            local v20 = ((type(v18.maps) ~= "table") and {}) or (v18.maps)
            for key_1, value_1 in v20 do
                if type(value_1) ~= "table" then
                    continue
                end
                if type(value_1.name) == "string" then
                    tbl_upv_1[key_1] = value_1.name
                end
            end
        end
        return u3
    end
    function tbl_upv_2.CachedTerritories()
        --[[
          name: CachedTerritories
          line: 169
          upvalues:
            u3 (ref, index: 1)
        ]]
        return u3
    end
    function tbl_upv_2.MapName(a15)
        --[[
          name: MapName
          line: 173
          upvalues:
            tbl_upv_1 (copy, index: 1)
        ]]
        local v21 = tbl_upv_1[tostring(a15)] or (string.gsub(tostring(a15), "(%l)(%u)", "%1 %2"))
        return v21
    end
    function tbl_upv_2.Of(a16)
        --[[
          name: Of
          line: 178
        ]]
        if not a16 then
            return nil
        end
        local v22 = a16:GetAttribute("TribeId")
        local v23 = a16:GetAttribute("TribeTag")
        if type(v22) == "number" and not (v22 <= 0) and type(v23) == "string" and v23 ~= "" then
            local tbl_5 = {}
            tbl_5.id = v22
            tbl_5.tag = v23
            tbl_5.icon = a16:GetAttribute("TribeIcon") or 1
            tbl_5.color1 = a16:GetAttribute("TribeColor1") or 1
            tbl_5.color2 = a16:GetAttribute("TribeColor2") or 1
            tbl_5.role = a16:GetAttribute("TribeRole") or "member"
            return tbl_5
        end
        return nil
    end
    function tbl_upv_2.Mine()
        --[[
          name: Mine
          line: 197
          upvalues:
            tbl_upv_2 (copy, index: 1)
            LocalPlayer_upv_1 (copy, index: 2)
        ]]
        return tbl_upv_2.Of(LocalPlayer_upv_1)
    end
    local u6 = false
    local function invalidate()
        --[[
          name: invalidate
          line: 203
          upvalues:
            u2 (ref,  index: 1)
            tbl_upv_2 (copy, index: 2)
            u6 (ref,  index: 3)
        ]]
        u2 = -math.huge
        tbl_upv_2.Changed:Fire()
        if u6 then
            return
        end
        u6 = true
        task.delay(0.4, function() end)
    end
    for _, value_2 in {"TribeId", "TribeTag", "TribeRole", "TribeIcon", "TribeColor1", "TribeColor2"} do
        LocalPlayer_upv_1:GetAttributeChangedSignal(value_2):Connect(invalidate)
    end
    local function tag(a17)
        --[[
          name: tag
          line: 221
        ]]
        if type(a17) == "table" and type(a17.tag) == "string" then
            return "[" .. a17.tag .. "]"
        end
        return "your tribe"
    end
    local tbl_upv_6 = {chief = "the Chief", member = "a Member", elder = "an Elder"}
    local tbl_upv_7 = {kicked = 0, took = 0, accepted = 0, role = 0, invited = 0, request = 0, lost = 0, declined = 0, visitFailed = 0}
    function tbl_upv_7.request(a18)
        --[[
          name: request
          line: 226
        ]]
        return ("%* asked to join your tribe"):format(tostring(a18.name or "Someone")), "info"
    end
    function tbl_upv_7.accepted(a19)
        --[[
          name: accepted
          line: 229
        ]]
        local v24 = "You joined %*!"
        local v25
        if type(a19) == "table" and type(a19.tag) == "string" then
            v25 = "[" .. a19.tag .. "]"
        else
            v25 = "your tribe"
        end
        return v24:format(v25), "success"
    end
    function tbl_upv_7.declined(a20)
        --[[
          name: declined
          line: 232
        ]]
        local v26 = "%* declined your request"
        local v27
        if type(a20) == "table" and type(a20.tag) == "string" then
            v27 = "[" .. a20.tag .. "]"
        else
            v27 = "your tribe"
        end
        return v26:format(v27), "warning"
    end
    function tbl_upv_7.invited(a21)
        --[[
          name: invited
          line: 235
        ]]
        local v28 = "%* invited you to %* %*. Open Tribes to answer"
        local str_1 = tostring(a21.from or "Someone")
        local v29
        if type(a21) == "table" and type(a21.tag) == "string" then
            v29 = "[" .. a21.tag .. "]"
        else
            v29 = "your tribe"
        end
        return v28:format(str_1, v29, tostring(a21.name or "")), "info"
    end
    function tbl_upv_7.kicked(a22)
        --[[
          name: kicked
          line: 238
        ]]
        local v30 = "You were removed from %*"
        local v31
        if type(a22) == "table" and type(a22.tag) == "string" then
            v31 = "[" .. a22.tag .. "]"
        else
            v31 = "your tribe"
        end
        return v30:format(v31), "warning"
    end
    function tbl_upv_7.role(a23)
        --[[
          name: role
          line: 241
          upvalues:
            tbl_upv_6 (copy, index: 1)
        ]]
        return ("You're now %* of your tribe"):format(tbl_upv_6[a23.role] or "a Member"), "success"
    end
    function tbl_upv_7.took(a24)
        --[[
          name: took
          line: 244
          upvalues:
            tbl_upv_2 (copy, index: 1)
        ]]
        return ("Your tribe took %*!"):format(tbl_upv_2.MapName(a24.mapId)), "success"
    end
    function tbl_upv_7.lost(a25)
        --[[
          name: lost
          line: 247
          upvalues:
            tbl_upv_2 (copy, index: 1)
        ]]
        return ("[%*] took %* from your tribe"):format(tostring(a25.to or "?"), tbl_upv_2.MapName(a25.mapId)), "warning"
    end
    function tbl_upv_7.visitFailed()
        --[[
          name: visitFailed
          line: 250
        ]]
        return "Couldn't join their lobby. It may be full.", "error"
    end
    Remotes_upv_1.On(
        "TribeEvent",
        function(a26, a27)
            --[[
              line: 254
              upvalues:
                u2 (ref,  index: 1)
                tbl_upv_2 (copy, index: 2)
                u6 (ref,  index: 3)
                a1 (copy, index: 4)
                tbl_upv_7 (copy, index: 5)
                u4 (ref,  index: 6)
            ]]
            if a26 ~= "Changed" then
                if a26 == "Notice" then
                    local v32, v33 = nil, nil
                    if type(a27) == "table" then
                        v32 = tbl_upv_7[tostring(a27.kind)]
                        if v32 then
                            local v34 = ((type(a27.data) ~= "table") and {}) or (a27.data)
                            local v33, v35 = v32(v34)
                            if v33 then
                                a1.Toast(v33, v35, true)
                            end
                        end
                        if a27.kind == "took" or a27.kind == "lost" then
                            u4 = -math.huge
                        end
                        return
                    end
                end
                if a26 == "Chest" and type(a27) == "table" then
                    local v36 = ((not ((tonumber(a27.territories) or 0) > 0)) and "") or ((" +%* territory bonus"):format(a27.territories))
                    a1.Toast(("Tribe Chest opened: tier %*%*"):format(tostring(a27.tier), v36), "success", true)
                end
            else
                u2 = -math.huge
                tbl_upv_2.Changed:Fire()
                if u6 then
                    return
                end
                u6 = true
                task.delay(
                    0.4,
                    function()
                        --[[
                          line: 210
                          upvalues:
                            u6 (ref,  index: 1)
                            a1 (copy, index: 2)
                            tbl_upv_2 (copy, index: 3)
                        ]]
                        u6 = false
                        if not a1.MenuManager.IsOpen("Tribe") then
                            return
                        end
                        tbl_upv_2.Home(true)
                    end
                )
            end
        end
    )
    a1.Tribes = tbl_upv_2
end
return v1