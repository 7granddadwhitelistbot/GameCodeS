local _ = game:GetService("CollectionService")
local Players_upv_1 = game:GetService("Players")
local ReplicatedStorage_upv_1 = game:GetService("ReplicatedStorage")
local Signal_1 = require(script.Parent.Parent:WaitForChild("Signal"))
local Fighters_upv_1 = require(script.Parent:WaitForChild("Fighters"))
local tbl_upv_1 = {}
local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
local u1 = "none"
local u2 = nil
local u3 = nil
local u4 = nil
local u5 = false
local u6 = nil
local u7 = nil
local u8 = ""
local u9 = 0
local u10 = nil
local attackerId_upv_1 = nil
local u11 = -math.huge
local u12 = nil
local u13 = 0
local u14 = false
tbl_upv_1.Changed = Signal_1.new()
local function myId()
    --[[
      name: myId
      line: 60
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    return "p" .. tostring(LocalPlayer_upv_1.UserId)
end
local function humanoidAlive(a1)
    --[[
      name: humanoidAlive
      line: 64
    ]]
    local v1 = a1:FindFirstChildOfClass("Humanoid")
    local v2 = (v1 ~= nil) and ((v1.Health > 0) and ((a1.Parent ~= nil) and (a1:FindFirstChild("HumanoidRootPart") ~= nil)))
    return v2
end
function tbl_upv_1.ResolveCombatant(a1)
    --[[
      name: ResolveCombatant
      line: 70
      upvalues:
        Players_upv_1 (copy, index: 1)
        Fighters_upv_1 (copy, index: 2)
    ]]
    if type(a1) == "string" and a1 ~= "" then
        local v3 = string.sub(a1, 1, 1)
        if v3 == "p" then
            local v4 = string.sub(a1, 2)
            local tonumber_1 = tonumber
            local v5 = tonumber_1(v4)
            local v6 = v5 and (Players_upv_1:GetPlayerByUserId(v5))
            local v7 = v6 and (v6.Character)
            if v7 and v7.Parent then
                return v7
            end
            v3 = v5
        end
        local u15 = nil
        Fighters_upv_1.EachTagged(
            function(a2)
                --[[
                  line: 83
                  upvalues:
                    u15 (ref,  index: 1)
                    a1 (copy, index: 2)
                ]]
                if (u15) or a2:GetAttribute("CombatantId") ~= a1 or not a2.Parent then
                    return
                end
                u15 = a2
            end
        )
        return v3
    end
    return nil
end
local function nameOf(a1)
    --[[
      name: nameOf
      line: 91
      upvalues:
        Players_upv_1 (copy, index: 1)
    ]]
    if not a1 then
        return ""
    end
    local v8 = a1:GetAttribute("DisplayName")
    if type(v8) == "string" and v8 ~= "" then
        return v8
    end
    local v9 = Players_upv_1:GetPlayerFromCharacter(a1)
    if v9 then
        return v9.DisplayName
    end
    return a1.Name
end
local function idOf(a1)
    --[[
      name: idOf
      line: 103
      upvalues:
        Players_upv_1 (copy, index: 1)
    ]]
    if not a1 then
        return ""
    end
    local v10 = a1:GetAttribute("CombatantId")
    if type(v10) == "string" then
        return v10
    end
    local v11 = Players_upv_1:GetPlayerFromCharacter(a1)
    if v11 then
        return "p" .. v11.UserId
    end
    return a1.Name
end
local function watchedMatch()
    --[[
      name: watchedMatch
      line: 116
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local v12 = LocalPlayer_upv_1:GetAttribute("Spectating")
    if type(v12) == "string" and v12 ~= "" and LocalPlayer_upv_1:GetAttribute("State") ~= "Match" then
        return v12
    end
    return ""
end
local function teamOf(a1)
    --[[
      name: teamOf
      line: 124
      upvalues:
        Players_upv_1 (copy, index: 1)
    ]]
    local v13 = a1:GetAttribute("Team")
    if type(v13) ~= "number" then
        local v14 = Players_upv_1:GetPlayerFromCharacter(a1)
        v13 = v14 and v14:GetAttribute("Team")
    end
    if type(v13) ~= "number" then
        return 0
    end
    return v13
end
local function sortIds(a1, a2, a3)
    --[[
      name: sortIds
      line: 133
    ]]
    table.sort(a1, function() end)
end
local function candidates(a1)
    --[[
      name: candidates
      line: 149
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        Players_upv_1 (copy, index: 2)
        Fighters_upv_1 (copy, index: 3)
        u4 (ref,  index: 4)
        tbl_upv_1 (copy, index: 5)
    ]]
    local v16 = LocalPlayer_upv_1:GetAttribute("Spectating")
    local v17
    if type(v16) ~= "string" or v16 == "" or LocalPlayer_upv_1:GetAttribute("State") == "Match" then
        v17 = ""
    else
        v17 = v16
    end
    local u16
    if v17 == "" then
        u16 = LocalPlayer_upv_1:GetAttribute("MatchId")
    else
        u16 = v17
    end
    local u17 = LocalPlayer_upv_1:GetAttribute("Team")
    local u18 = v17 ~= ""
    local tbl_upv_2 = {}
    local tbl_upv_3 = {}
    if type(u16) ~= "string" or u16 == "" then
        return tbl_upv_2
    end
    local function add_1(a2, a3)
        --[[
          name: add
          line: 159
          upvalues:
            LocalPlayer_upv_1 (copy, index: 1)
            tbl_upv_3 (copy, index: 2)
            tbl_upv_2 (copy, index: 3)
        ]]
        if a2 == "" or a2 == "p" .. tostring(LocalPlayer_upv_1.UserId) or tbl_upv_3[a2] ~= nil then
            return
        end
        tbl_upv_3[a2] = a3
        table.insert(tbl_upv_2, a2)
    end
    local v18, v19 = nil, nil
    for _, value_1 in Players_upv_1:GetPlayers() do
        if value_1 == LocalPlayer_upv_1 or value_1:GetAttribute("MatchId") ~= u16 or value_1:GetAttribute("Alive") == false then
            continue
        end
        if u18 then
            local Character_1 = value_1.Character
            if not (Character_1) then
                continue
            end
            v19 = Character_1:FindFirstChildOfClass("Humanoid")
            local v20 = (v19 ~= nil) and ((v19.Health > 0) and ((Character_1.Parent ~= nil) and (Character_1:FindFirstChild("HumanoidRootPart") ~= nil)))
            if not (v20) then
                continue
            end
            local UserId_1 = "p" .. value_1.UserId
            v18 = Character_1:GetAttribute("Team")
            if type(v18) ~= "number" then
                local v21 = Players_upv_1:GetPlayerFromCharacter(Character_1)
                local v22 = v21 and (v21:GetAttribute("Team"))
                v18 = v22
            end
            if type(v18) ~= "number" then
                v19 = 0
            else
                v19 = v18
            end
            if UserId_1 == "" or UserId_1 == "p" .. tostring(LocalPlayer_upv_1.UserId) then
                continue
            end
            if tbl_upv_3[UserId_1] == nil then
                tbl_upv_3[UserId_1] = v19
                table.insert(tbl_upv_2, UserId_1)
            end
        else
            local v23 = value_1:GetAttribute("Team") == u17
            if v23 ~= a1 then
                continue
            end
            local Character_1 = value_1.Character
            if not (Character_1) then
                continue
            end
            v19 = Character_1:FindFirstChildOfClass("Humanoid")
            local v20 = (v19 ~= nil) and ((v19.Health > 0) and ((Character_1.Parent ~= nil) and (Character_1:FindFirstChild("HumanoidRootPart") ~= nil)))
            if not (v20) then
                continue
            end
            local UserId_1 = "p" .. value_1.UserId
            v18 = Character_1:GetAttribute("Team")
            if type(v18) ~= "number" then
                local v21 = Players_upv_1:GetPlayerFromCharacter(Character_1)
                local v22 = v21 and (v21:GetAttribute("Team"))
                v18 = v22
            end
            if type(v18) ~= "number" then
                v19 = 0
            else
                v19 = v18
            end
            if UserId_1 == "" or UserId_1 == "p" .. tostring(LocalPlayer_upv_1.UserId) then
                continue
            end
            if tbl_upv_3[UserId_1] == nil then
                tbl_upv_3[UserId_1] = v19
                table.insert(tbl_upv_2, UserId_1)
            end
        end
    end
    Fighters_upv_1.EachTagged(
        function(a4)
            --[[
              line: 175
              upvalues:
                Players_upv_1 (copy, index: 1)
                u16 (copy, index: 2)
                u18 (copy, index: 3)
                u17 (copy, index: 4)
                a1 (copy, index: 5)
                LocalPlayer_upv_1 (copy, index: 6)
                tbl_upv_3 (copy, index: 7)
                tbl_upv_2 (copy, index: 8)
            ]]
            if Players_upv_1:GetPlayerFromCharacter(a4) ~= nil then
                return
            end
            if a4:GetAttribute("MatchId") == u16 then
                local v24 = a4:FindFirstChildOfClass("Humanoid")
                local v25 = (v24 ~= nil) and ((v24.Health > 0) and ((a4.Parent ~= nil) and (a4:FindFirstChild("HumanoidRootPart") ~= nil)))
                if v25 then
                    local v26 = nil
                    if u18 then
                        local v27, v28 = nil, nil
                        if a4 then
                            v27 = a4:GetAttribute("CombatantId")
                            if type(v27) ~= "string" then
                                local v29 = Players_upv_1:GetPlayerFromCharacter(a4)
                                v28 = (v29 and ("p" .. v29.UserId)) or (a4.Name)
                            else
                                v28 = v27
                            end
                        else
                            v28 = ""
                        end
                        local v30 = a4:GetAttribute("Team")
                        if type(v30) ~= "number" then
                            local v31 = Players_upv_1:GetPlayerFromCharacter(a4)
                            local v32 = v31 and (v31:GetAttribute("Team"))
                            v30 = v32
                        end
                        if type(v30) ~= "number" then
                            v24 = 0
                        else
                            v24 = v30
                        end
                        if v28 == "" or v28 == "p" .. tostring(LocalPlayer_upv_1.UserId) or tbl_upv_3[v28] ~= nil then
                            return
                        end
                        tbl_upv_3[v28] = v24
                        table.insert(tbl_upv_2, v28)
                    else
                        v26 = a4:GetAttribute("Team") == u17
                        if v26 == a1 then
                            local v27, v28 = nil, nil
                            if a4 then
                                v27 = a4:GetAttribute("CombatantId")
                                if type(v27) ~= "string" then
                                    local v29 = Players_upv_1:GetPlayerFromCharacter(a4)
                                    v28 = (v29 and ("p" .. v29.UserId)) or (a4.Name)
                                else
                                    v28 = v27
                                end
                            else
                                v28 = ""
                            end
                            local v30 = a4:GetAttribute("Team")
                            if type(v30) ~= "number" then
                                local v31 = Players_upv_1:GetPlayerFromCharacter(a4)
                                local v32 = v31 and (v31:GetAttribute("Team"))
                                v30 = v32
                            end
                            if type(v30) ~= "number" then
                                v24 = 0
                            else
                                v24 = v30
                            end
                            if v28 == "" or v28 == "p" .. tostring(LocalPlayer_upv_1.UserId) or tbl_upv_3[v28] ~= nil then
                                return
                            end
                            tbl_upv_3[v28] = v24
                            table.insert(tbl_upv_2, v28)
                        end
                    end
                end
            end
        end
    )
    if type(u4) == "table" and u4.matchId == u16 and type(u4.teams) == "table" then
        for key_1, value_2 in u4.teams do
            if type(key_1) ~= "number" or type(value_2) ~= "table" or type(value_2.members) ~= "table" then
                continue
            end
            if u18 or not u18 and key_1 == u17 == a1 then
                for _, value_3 in value_2.members do
                    local v33 = (type(value_3) == "table") and (value_3.id)
                    if type(v33) ~= "string" or value_3.alive ~= true or value_3.connected == false or tbl_upv_3[v33] ~= nil then
                        continue
                    end
                    if string.sub(v33, 1, 1) ~= "p" then
                        local v34 = tbl_upv_1.ResolveCombatant(v33)
                        if v34 == nil then
                            if v33 == "" or v33 == "p" .. tostring(LocalPlayer_upv_1.UserId) then
                                continue
                            end
                        else
                            local v35 = v34:FindFirstChildOfClass("Humanoid")
                            local v36 = (v35 ~= nil) and ((v35.Health > 0) and ((v34.Parent ~= nil) and (v34:FindFirstChild("HumanoidRootPart") ~= nil)))
                            if not (v36) or v33 == "" or v33 == "p" .. tostring(LocalPlayer_upv_1.UserId) then
                                continue
                            end
                        end
                        if tbl_upv_3[v33] == nil then
                            tbl_upv_3[v33] = key_1
                            table.insert(tbl_upv_2, v33)
                        end
                    else
                        local v37 = Players_upv_1:GetPlayerByUserId(tonumber(string.sub(v33, 2)) or 0)
                        if not (v37) or v37:GetAttribute("Alive") == false or v37:GetAttribute("MatchId") ~= u16 then
                            continue
                        end
                        local v34 = tbl_upv_1.ResolveCombatant(v33)
                        if v34 == nil then
                            if v33 == "" or v33 == "p" .. tostring(LocalPlayer_upv_1.UserId) then
                                continue
                            end
                        else
                            local v35 = v34:FindFirstChildOfClass("Humanoid")
                            local v36 = (v35 ~= nil) and ((v35.Health > 0) and ((v34.Parent ~= nil) and (v34:FindFirstChild("HumanoidRootPart") ~= nil)))
                            if not (v36) or v33 == "" or v33 == "p" .. tostring(LocalPlayer_upv_1.UserId) then
                                continue
                            end
                        end
                        if tbl_upv_3[v33] == nil then
                            tbl_upv_3[v33] = key_1
                            table.insert(tbl_upv_2, v33)
                        end
                    end
                end
            end
        end
    end
    table.sort(
        tbl_upv_2,
        function(a5, a6)
            --[[
              line: 134
              upvalues:
                u18 (copy, index: 1)
                tbl_upv_3 (copy, index: 2)
            ]]
            local v38, v39 = nil, nil
            if u18 then
                v38 = tbl_upv_3[a5] or 0
                v39 = tbl_upv_3[a6] or 0
                if v38 ~= v39 then
                    return v38 < v39
                end
            end
            return a5 < a6
        end
    )
    return tbl_upv_2
end
local function publishCount()
    --[[
      name: publishCount
      line: 214
      upvalues:
        u1 (ref,  index: 1)
        candidates (copy, index: 2)
        LocalPlayer_upv_1 (copy, index: 3)
    ]]
    local v40 = 0
    if u1 == "follow" then
        v40 = #candidates(true)
        if v40 == 0 then
            v40 = #candidates(false)
        end
    end
    LocalPlayer_upv_1:SetAttribute("SpectateCount", v40)
end
local function isEnemy(a1)
    --[[
      name: isEnemy
      line: 226
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        Players_upv_1 (copy, index: 3)
        u4 (ref,  index: 4)
    ]]
    local v41 = LocalPlayer_upv_1:GetAttribute("Team")
    local v42 = tbl_upv_1.ResolveCombatant(a1)
    if v42 then
        local v43 = v42:GetAttribute("Team")
        if type(v43) ~= "number" then
            local v44 = Players_upv_1:GetPlayerFromCharacter(v42)
            v43 = v44 and v44:GetAttribute("Team")
        end
        local v46
        if type(v43) ~= "number" then
            v46 = 0
        else
            v46 = v43
        end
        local v47
        if v46 ~= v41 then
            v47 = true
        else
            v47 = false
        end
        return v47
    else
        local v48 = nil
        if string.sub(a1, 1, 1) == "p" then
            v48 = Players_upv_1:GetPlayerByUserId(tonumber(string.sub(a1, 2)) or 0)
            if v48 then
                local v49 = v48:GetAttribute("Team") ~= v41
                return v49
            end
        end
        if type(u4) == "table" and type(u4.teams) == "table" then
            for key_2, value_4 in u4.teams do
                if type(value_4) ~= "table" or type(value_4.members) ~= "table" then
                    continue
                end
                for _, value_5 in value_4.members do
                    if type(value_5) ~= "table" or value_5.id ~= a1 then
                        continue
                    end
                    return key_2 ~= v41
                end
            end
        end
        return false
    end
end
local function snapshotName(a1)
    --[[
      name: snapshotName
      line: 254
      upvalues:
        u4 (ref, index: 1)
    ]]
    if a1 and type(u4) == "table" and type(u4.teams) == "table" then
        for _, value_6 in u4.teams do
            if type(value_6) ~= "table" or type(value_6.members) ~= "table" then
                continue
            end
            for v1, value_7 in value_6.members do
                if type(value_7) ~= "table" or value_7.id ~= a1 or type(value_7.name) ~= "string" then
                    continue
                end
                return value_7.name
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
        u1 (ref,  index: 1)
        candidates (copy, index: 2)
        LocalPlayer_upv_1 (copy, index: 3)
        u2 (ref,  index: 4)
        u3 (ref,  index: 5)
        Players_upv_1 (copy, index: 6)
        snapshotName (copy, index: 7)
        u8 (ref,  index: 8)
        tbl_upv_1 (copy, index: 9)
    ]]
    local v50 = 0
    if u1 == "follow" then
        v50 = #candidates(true)
        if v50 == 0 then
            v50 = #candidates(false)
        end
    end
    LocalPlayer_upv_1:SetAttribute("SpectateCount", v50)
    v50 = (u1 == "follow") and (u2 ~= nil)
    LocalPlayer_upv_1:SetAttribute("SpectateMode", u1)
    local v51
    if v50 then
        v51 = u2
    else
        v51 = ""
    end
    LocalPlayer_upv_1:SetAttribute("SpectateTargetId", v51)
    local v52
    if v50 then
        local v53 = nil
        if u3 then
            v53 = u3
            local v54, v55 = nil, nil
            if v53 then
                v54 = v53:GetAttribute("DisplayName")
                if type(v54) ~= "string" or v54 == "" then
                    v55 = Players_upv_1:GetPlayerFromCharacter(v53)
                    if v55 then
                        v52 = v55.DisplayName
                    else
                        v52 = v53.Name
                    end
                else
                    v52 = v54
                end
            else
                v52 = ""
            end
        else
            v52 = snapshotName(u2)
        end
    else
        v52 = ""
    end
    LocalPlayer_upv_1:SetAttribute("SpectateTargetName", v52)
    LocalPlayer_upv_1:SetAttribute("SpectateKillerName", u8)
    local Changed_1 = tbl_upv_1.Changed
    local v56
    if u1 ~= "follow" then
        v56 = nil
    else
        v56 = u3
    end
    Changed_1:Fire(v56, u1)
end
local u19 = nil
local function playSwitch()
    --[[
      name: playSwitch
      line: 282
      upvalues:
        u19 (ref, index: 1)
    ]]
    local v57 = nil
    if u19 == nil then
        v57 = script.Parent.Parent:FindFirstChild("Sfx")
        u19 = false
        if v57 and v57:IsA("ModuleScript") then
            local success_1, v58 = pcall(require, v57)
            if success_1 and type(v58) == "table" then
                u19 = v58
            end
        end
    end
    if not u19 or type(u19.PlayUI) ~= "function" then
        return
    end
    pcall(u19.PlayUI, "UI/Spectate_Switch")
end
local function resolveTarget()
    --[[
      name: resolveTarget
      line: 299
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u2 (ref,  index: 2)
        u3 (ref,  index: 3)
    ]]
    local v59 = tbl_upv_1.ResolveCombatant(u2)
    local v60, v61 = nil, nil
    if v59 then
        local v62 = v59:FindFirstChildOfClass("Humanoid")
        v60 = (v62 ~= nil) and ((v62.Health > 0) and ((v59.Parent ~= nil) and (v59:FindFirstChild("HumanoidRootPart") ~= nil)))
        if v60 then
            v61 = v59
        else
            v61 = nil
        end
    else
        v61 = nil
    end
    u3 = v61
end
local u20 = nil
local u21 = 0
local function reportFocus(a1)
    --[[
      name: reportFocus
      line: 308
      upvalues:
        u1 (ref,  index: 1)
        u2 (ref,  index: 2)
        LocalPlayer_upv_1 (copy, index: 3)
        u5 (ref,  index: 4)
        u21 (ref,  index: 5)
        u20 (ref,  index: 6)
        ReplicatedStorage_upv_1 (copy, index: 7)
    ]]
    local v63
    if u1 ~= "follow" then
        v63 = false
    else
        local v64 = nil
        if u2 then
            v64 = LocalPlayer_upv_1:GetAttribute("Spectating")
            local v65
            if type(v64) ~= "string" or v64 == "" or LocalPlayer_upv_1:GetAttribute("State") == "Match" then
                v65 = ""
            else
                v65 = v64
            end
            if v65 ~= "" then
                v63 = false
            else
                v63 = u2
            end
        else
            v63 = false
        end
    end
    if v63 ~= u5 or (a1) then
        u5 = v63
        u21 = os.clock()
        if not (u20) then
            local Remotes_1 = ReplicatedStorage_upv_1:FindFirstChild("Remotes")
            local v66 = Remotes_1 and (Remotes_1:FindFirstChild("SpectateFocus"))
            local v67 = not (v66) or not (v66:IsA("RemoteEvent")) or v66
            u20 = v67
        end
        if u20 then
            u20:FireServer(v63)
        end
    end
end
local function setTarget(a1)
    --[[
      name: setTarget
      line: 325
      upvalues:
        u2 (ref,  index: 1)
        u1 (ref,  index: 2)
        playSwitch (copy, index: 3)
        tbl_upv_1 (copy, index: 4)
        u3 (ref,  index: 5)
        u12 (ref,  index: 6)
        reportFocus (copy, index: 7)
        publish (copy, index: 8)
    ]]
    if a1 ~= u2 and a1 ~= nil and u1 == "follow" then
        playSwitch()
    end
    u2 = a1
    local v68 = tbl_upv_1.ResolveCombatant(u2)
    local v69, v70 = nil, nil
    if v68 then
        local v71 = v68:FindFirstChildOfClass("Humanoid")
        v69 = (v71 ~= nil) and ((v71.Health > 0) and ((v68.Parent ~= nil) and (v68:FindFirstChild("HumanoidRootPart") ~= nil)))
        if v69 then
            v70 = v68
        else
            v70 = nil
        end
    else
        v70 = nil
    end
    u3 = v70
    u12 = nil
    reportFocus()
    publish()
end
local function pick(a1)
    --[[
      name: pick
      line: 336
      upvalues:
        candidates (copy, index: 1)
        u2 (ref,  index: 2)
        u1 (ref,  index: 3)
        playSwitch (copy, index: 4)
        tbl_upv_1 (copy, index: 5)
        u3 (ref,  index: 6)
        u12 (ref,  index: 7)
        reportFocus (copy, index: 8)
        publish (copy, index: 9)
    ]]
    local v72 = candidates(true)
    if #v72 == 0 then
        v72 = candidates(false)
    end
    if #v72 ~= 0 then
        local v73
        if u2 then
            v73 = table.find(v72, u2)
        else
            v73 = nil
        end
        local v74
        if v73 then
            v74 = ((v73 - 1) + a1) % #v72 + 1
        else
            v74 = ((a1 < 0) and (#v72)) or 1
        end
        if v72[v74] ~= u2 then
            local v75 = v72[v74]
            if v75 ~= u2 and v75 ~= nil and u1 == "follow" then
                playSwitch()
            end
            u2 = v75
            local v76 = tbl_upv_1.ResolveCombatant(u2)
            local v77, v78 = nil, nil
            if v76 then
                local v79 = v76:FindFirstChildOfClass("Humanoid")
                v77 = (v79 ~= nil) and ((v79.Health > 0) and ((v76.Parent ~= nil) and (v76:FindFirstChild("HumanoidRootPart") ~= nil)))
                if v77 then
                    v78 = v76
                else
                    v78 = nil
                end
            else
                v78 = nil
            end
            u3 = v78
            u12 = nil
            reportFocus()
            publish()
        end
    elseif u2 ~= nil then
        u2 = nil
        local v80 = tbl_upv_1.ResolveCombatant(u2)
        local v81, v82 = nil, nil
        if v80 then
            local v83 = v80:FindFirstChildOfClass("Humanoid")
            v81 = (v83 ~= nil) and ((v83.Health > 0) and ((v80.Parent ~= nil) and (v80:FindFirstChild("HumanoidRootPart") ~= nil)))
            if v81 then
                v82 = v80
            else
                v82 = nil
            end
        else
            v82 = nil
        end
        u3 = v82
        u12 = nil
        reportFocus()
        publish()
    end
end
local function followWanted()
    --[[
      name: followWanted
      line: 362
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        candidates (copy, index: 2)
        u2 (ref,  index: 3)
        u1 (ref,  index: 4)
        playSwitch (copy, index: 5)
        tbl_upv_1 (copy, index: 6)
        u3 (ref,  index: 7)
        u12 (ref,  index: 8)
        reportFocus (copy, index: 9)
        publish (copy, index: 10)
    ]]
    local v84 = LocalPlayer_upv_1:GetAttribute("SpectateFollow")
    if type(v84) ~= "string" or v84 == "" then
        return false
    end
    local v85 = LocalPlayer_upv_1:GetAttribute("Spectating")
    local v86
    if type(v85) ~= "string" or v85 == "" or LocalPlayer_upv_1:GetAttribute("State") == "Match" then
        v86 = ""
    else
        v86 = v85
    end
    if v86 ~= "" then
        for _, value_8 in candidates(false) do
            if value_8 == v84 then
                if value_8 ~= u2 and value_8 ~= nil and u1 == "follow" then
                    playSwitch()
                end
                u2 = value_8
                local v87 = tbl_upv_1.ResolveCombatant(u2)
                local v88, v89 = nil, nil
                if v87 then
                    local v90 = v87:FindFirstChildOfClass("Humanoid")
                    v88 = (v90 ~= nil) and ((v90.Health > 0) and ((v87.Parent ~= nil) and (v87:FindFirstChild("HumanoidRootPart") ~= nil)))
                    if v88 then
                        v89 = v87
                    else
                        v89 = nil
                    end
                else
                    v89 = nil
                end
                u3 = v89
                u12 = nil
                reportFocus()
                publish()
                LocalPlayer_upv_1:SetAttribute("SpectateFollow", nil)
                return true
            end
        end
    else
        return false
    end
end
local u22 = nil
local u23 = ""
local function noteUnexplained()
    --[[
      name: noteUnexplained
      line: 400
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        u23 (ref,  index: 2)
    ]]
    local v91 = LocalPlayer_upv_1:GetAttribute("MatchId")
    local Arenas_1 = workspace:FindFirstChild("Arenas")
    local v92 = Arenas_1 and ((type(v91) == "string") and (Arenas_1:FindFirstChild(v91)))
    local v93 = v92 and (v92:GetAttribute("Round"))
    local v94 = ("%*:%*"):format(v91, v93)
    if v94 == u23 then
        return
    end
    u23 = v94
    local Character_2 = LocalPlayer_upv_1.Character
    local v95 = Character_2
    local v96 = v95 and (Character_2:FindFirstChildOfClass("Humanoid"))
    local v97 = Character_2
    local _ = v97 and (Character_2:FindFirstChild("HumanoidRootPart"))
    if Character_2 and Character_2.Parent and Character_2 and Character_2.Health <= 0 and LocalPlayer_upv_1:GetAttribute("Alive") == false then
        return
    end
    local Name_1 = LocalPlayer_upv_1.Name
    local v98 = LocalPlayer_upv_1:GetAttribute("Alive")
    local v99 = ((not Character_2) and "none") or (((Character_2.Parent) and "in world") or "removed")
    local v100 = (v96 and (math.floor(Character_2.Health))) or "-"
    local v101 = (v96 and (Character_2:GetState().Name)) or "-"
    local v102 = (v97 and (math.floor(Character_2.Position.Y))) or "-"
    local v103 = (v92 and (v92:GetAttribute("Phase"))) or "-"
    warn((("[Spectate] %* down with no attacker: Alive %*, body %*, hp %*, state %*, y %*, phase %* r%*"):format(Name_1, v98, v99, v100, v101, v102, v103, v92 or "-")))
end
local function resolveKiller()
    --[[
      name: resolveKiller
      line: 419
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u7 (ref,  index: 2)
        u6 (ref,  index: 3)
        u8 (ref,  index: 4)
        Players_upv_1 (copy, index: 5)
    ]]
    local v104 = tbl_upv_1.ResolveCombatant(u7)
    u6 = v104
    if v104 then
        local v105, v106, v107 = nil, nil, nil
        if v104 then
            v105 = v104:GetAttribute("DisplayName")
            if type(v105) ~= "string" or v105 == "" then
                v106 = Players_upv_1:GetPlayerFromCharacter(v104)
                if v106 then
                    v107 = v106.DisplayName
                else
                    v107 = v104.Name
                end
            else
                v107 = v105
            end
        else
            v107 = ""
        end
        u8 = v107
    end
end
local function enterDeath(a1)
    --[[
      name: enterDeath
      line: 427
      upvalues:
        u1 (ref,  index: 1)
        u9 (ref,  index: 2)
        u10 (ref,  index: 3)
        u2 (ref,  index: 4)
        u3 (ref,  index: 5)
        u5 (ref,  index: 6)
        u6 (ref,  index: 7)
        u8 (ref,  index: 8)
        u7 (ref,  index: 9)
        u11 (ref,  index: 10)
        attackerId_upv_1 (ref,  index: 11)
        tbl_upv_1 (copy, index: 12)
        Players_upv_1 (copy, index: 13)
        publish (copy, index: 14)
    ]]
    u1 = "death"
    u9 = os.clock()
    u10 = a1
    u2 = nil
    u3 = nil
    u5 = false
    u6 = nil
    u8 = ""
    if u7 == nil and os.clock() - u11 < 4 then
        u7 = attackerId_upv_1
    end
    local v108 = tbl_upv_1.ResolveCombatant(u7)
    u6 = v108
    if v108 then
        local v109, v110, v111 = nil, nil, nil
        if v108 then
            v109 = v108:GetAttribute("DisplayName")
            if type(v109) ~= "string" or v109 == "" then
                v110 = Players_upv_1:GetPlayerFromCharacter(v108)
                if v110 then
                    v111 = v110.DisplayName
                else
                    v111 = v108.Name
                end
            else
                v111 = v109
            end
        else
            v111 = ""
        end
        u8 = v111
    end
    publish()
end
local function leave()
    --[[
      name: leave
      line: 443
      upvalues:
        u22 (ref,  index: 1)
        u1 (ref,  index: 2)
        u2 (ref,  index: 3)
        u3 (ref,  index: 4)
        u5 (ref,  index: 5)
        u6 (ref,  index: 6)
        u7 (ref,  index: 7)
        u8 (ref,  index: 8)
        u10 (ref,  index: 9)
        u12 (ref,  index: 10)
        publish (copy, index: 11)
    ]]
    u22 = nil
    u1 = "none"
    u2 = nil
    u3 = nil
    u5 = false
    u6 = nil
    u7 = nil
    u8 = ""
    u10 = nil
    u12 = nil
    publish()
end
local function wantsSpectate()
    --[[
      name: wantsSpectate
      line: 377
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local v112 = LocalPlayer_upv_1:GetAttribute("Spectating")
    local v113
    if type(v112) ~= "string" or v112 == "" or LocalPlayer_upv_1:GetAttribute("State") == "Match" then
        v113 = ""
    else
        v113 = v112
    end
    if v113 ~= "" then
        return true
    end
    if LocalPlayer_upv_1:GetAttribute("State") ~= "Match" then
        return false
    end
    if LocalPlayer_upv_1:GetAttribute("Alive") == false then
        return true
    end
    local Character_3 = LocalPlayer_upv_1.Character
    local v114 = Character_3 and (Character_3:FindFirstChildOfClass("Humanoid"))
    local v115 = false
    if v114 ~= nil then
        v115 = v114.Health <= 0
    end
    return v115
end
function tbl_upv_1.Step(a1)
    --[[
      name: Step
      line: 458
      upvalues:
        wantsSpectate (copy, index: 1)
        u1 (ref,  index: 2)
        u22 (ref,  index: 3)
        u2 (ref,  index: 4)
        u3 (ref,  index: 5)
        u5 (ref,  index: 6)
        u6 (ref,  index: 7)
        u7 (ref,  index: 8)
        u8 (ref,  index: 9)
        u10 (ref,  index: 10)
        u12 (ref,  index: 11)
        publish (copy, index: 12)
        LocalPlayer_upv_1 (copy, index: 13)
        followWanted (copy, index: 14)
        pick (copy, index: 15)
        enterDeath (copy, index: 16)
        noteUnexplained (copy, index: 17)
        u13 (ref,  index: 18)
        tbl_upv_1 (copy, index: 19)
        Players_upv_1 (copy, index: 20)
        u9 (ref,  index: 21)
        candidates (copy, index: 22)
        isEnemy (copy, index: 23)
        u21 (ref,  index: 24)
        reportFocus (copy, index: 25)
    ]]
    local v116 = os.clock()
    if wantsSpectate() then
        local v117 = nil
        if u1 ~= "none" then
            if u22 and v116 - u22 >= 3 then
                u22 = nil
                noteUnexplained()
            end
            if not (v116 - u13 < 0.25) then
                u13 = v116
                local v118 = nil
                if u1 == "death" then
                    if u6 == nil or u6.Parent == nil then
                        v118 = tbl_upv_1.ResolveCombatant(u7)
                        u6 = v118
                        if v118 then
                            local v119, v120, v121 = nil, nil, nil
                            if v118 then
                                v119 = v118:GetAttribute("DisplayName")
                                if type(v119) ~= "string" or v119 == "" then
                                    v120 = Players_upv_1:GetPlayerFromCharacter(v118)
                                    if v120 then
                                        v121 = v120.DisplayName
                                    else
                                        v121 = v118.Name
                                    end
                                else
                                    v121 = v119
                                end
                            else
                                v121 = ""
                            end
                            u8 = v121
                        end
                    end
                    if v116 - u9 >= 1.55 then
                        u1 = "follow"
                        pick(1)
                        publish()
                    end
                elseif u1 == "follow" then
                    v118 = 0
                    local v122 = nil
                    if u1 == "follow" then
                        v122 = #candidates(true)
                        if v122 ~= 0 then
                            v118 = v122
                        else
                            v118 = #candidates(false)
                        end
                    end
                    LocalPlayer_upv_1:SetAttribute("SpectateCount", v118)
                    followWanted()
                    local v123 = tbl_upv_1.ResolveCombatant(u2)
                    local v124, v125 = nil, nil
                    if v123 then
                        local v126 = v123:FindFirstChildOfClass("Humanoid")
                        v124 = (v126 ~= nil) and ((v126.Health > 0) and ((v123.Parent ~= nil) and (v123:FindFirstChild("HumanoidRootPart") ~= nil)))
                        if v124 then
                            v125 = v123
                        else
                            v125 = nil
                        end
                    else
                        v125 = nil
                    end
                    u3 = v125
                    if u3 ~= u3 then
                        publish()
                    end
                    v118 = u2
                    if v118 ~= nil then
                        local v127 = candidates(true)
                        v125 = table.find(v127, v118) ~= nil
                        if v125 then
                            if u3 ~= nil then
                                u12 = nil
                            elseif v125 or table.find(candidates(false), u2) ~= nil then
                                u12 = nil
                                if v116 - u21 > 2 then
                                    reportFocus(true)
                                end
                            else
                                if u12 == nil then
                                    u12 = v116
                                end
                                if v116 - u12 >= 0.9 then
                                    pick(1)
                                end
                            end
                        else
                            local v128 = nil
                            if #v127 > 0 then
                                v128 = LocalPlayer_upv_1:GetAttribute("Spectating")
                                local v129
                                if type(v128) ~= "string" or v128 == "" or LocalPlayer_upv_1:GetAttribute("State") == "Match" then
                                    v129 = ""
                                else
                                    v129 = v128
                                end
                                if v129 == "" and isEnemy(v118) then
                                    pick(1)
                                elseif u3 ~= nil then
                                    u12 = nil
                                elseif v125 or table.find(candidates(false), u2) ~= nil then
                                    u12 = nil
                                    if v116 - u21 > 2 then
                                        reportFocus(true)
                                    end
                                else
                                    if u12 == nil then
                                        u12 = v116
                                    end
                                    if v116 - u12 >= 0.9 then
                                        pick(1)
                                    end
                                end
                            elseif u3 ~= nil then
                                u12 = nil
                            elseif v125 or table.find(candidates(false), u2) ~= nil then
                                u12 = nil
                                if v116 - u21 > 2 then
                                    reportFocus(true)
                                end
                            else
                                if u12 == nil then
                                    u12 = v116
                                end
                                if v116 - u12 >= 0.9 then
                                    pick(1)
                                end
                            end
                        end
                    else
                        pick(1)
                        return u1
                    end
                end
            end
        else
            v117 = LocalPlayer_upv_1:GetAttribute("Spectating")
            local v130
            if type(v117) ~= "string" or v117 == "" or LocalPlayer_upv_1:GetAttribute("State") == "Match" then
                v130 = ""
            else
                v130 = v117
            end
            if v130 == "" then
                enterDeath(a1)
                local v131
                if u7 ~= nil then
                    v131 = nil
                else
                    v131 = v116
                end
                u22 = v131
            else
                u1 = "follow"
                u2 = nil
                u3 = nil
                u8 = ""
                if not (followWanted()) then
                    pick(1)
                end
                publish()
            end
        end
    elseif u1 ~= "none" then
        u22 = nil
        u1 = "none"
        u2 = nil
        u3 = nil
        u5 = false
        u6 = nil
        u7 = nil
        u8 = ""
        u10 = nil
        u12 = nil
        publish()
    end
    return u1
end
function tbl_upv_1.GetMode()
    --[[
      name: GetMode
      line: 543
      upvalues:
        u1 (ref, index: 1)
    ]]
    return u1
end
function tbl_upv_1.GetTarget()
    --[[
      name: GetTarget
      line: 547
      upvalues:
        u1 (ref, index: 1)
        u3 (ref, index: 2)
    ]]
    if u1 ~= "follow" then
        return nil
    end
    return u3
end
function tbl_upv_1.GetTargetId()
    --[[
      name: GetTargetId
      line: 552
      upvalues:
        u1 (ref, index: 1)
        u2 (ref, index: 2)
    ]]
    if u1 ~= "follow" then
        return nil
    end
    return u2
end
function tbl_upv_1.GetKiller()
    --[[
      name: GetKiller
      line: 556
      upvalues:
        u6 (ref, index: 1)
    ]]
    return u6
end
function tbl_upv_1.GetDeathPosition()
    --[[
      name: GetDeathPosition
      line: 560
      upvalues:
        u10 (ref, index: 1)
    ]]
    return u10
end
function tbl_upv_1.DeathElapsed()
    --[[
      name: DeathElapsed
      line: 564
      upvalues:
        u9 (ref, index: 1)
    ]]
    return os.clock() - u9
end
function tbl_upv_1.Next(a1)
    --[[
      name: Next
      line: 568
      upvalues:
        u1 (ref,  index: 1)
        pick (copy, index: 2)
    ]]
    if u1 ~= "follow" then
        return
    end
    pick(((a1 < 0) and -1) or 1)
end
local function onRemote(a1, a2)
    --[[
      name: onRemote
      line: 576
    ]]
    task.spawn(function() end)
end
function tbl_upv_1.Start()
    --[[
      name: Start
      line: 593
      upvalues:
        u14 (ref,  index: 1)
        publish (copy, index: 2)
        LocalPlayer_upv_1 (copy, index: 3)
        u7 (ref,  index: 4)
        u1 (ref,  index: 6)
        ReplicatedStorage_upv_1 (copy, index: 12)
        attackerId_upv_1 (ref,  index: 14)
        u11 (ref,  index: 15)
    ]]
    if u14 then
        return
    end
    u14 = true
    publish()
    local _ = "MatchEvent"
    task.spawn(function() end)
    local v1 = "MatchState"
    task.spawn(function() end)
    local u24 = function(a1)
        --[[
          line: 621
          upvalues:
            attackerId_upv_1 (ref, index: 1)
            u11 (ref, index: 2)
        ]]
        if type(a1) ~= "table" or type(a1.attackerId) ~= "string" then
            return
        end
        attackerId_upv_1 = a1.attackerId
        u11 = os.clock()
    end
    local u25 = "DamageTaken"
    task.spawn(
        function()
            --[[
              line: 577
              upvalues:
                ReplicatedStorage_upv_1 (copy, index: 1)
                u25 (copy, index: 2)
                u24 (copy, index: 3)
            ]]
            local v132 = ReplicatedStorage_upv_1:WaitForChild("Remotes", 60)
            while not (v132) do
                v132 = ReplicatedStorage_upv_1:WaitForChild("Remotes", 60)
            end
            local v133 = v132:FindFirstChild(u25)
            while not (v133) do
                v132.ChildAdded:Wait()
                v133 = v132:FindFirstChild(u25)
            end
            if not v133 or not v133:IsA("RemoteEvent") then
                return
            end
            v133.OnClientEvent:Connect(u24)
        end
    )
    LocalPlayer_upv_1.CharacterAdded:Connect(
        function()
            --[[
              line: 628
              upvalues:
                u1 (ref, index: 1)
                u7 (ref, index: 2)
            ]]
            if u1 ~= "none" then
                return
            end
            u7 = nil
        end
    )
end
return tbl_upv_1