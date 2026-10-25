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
local u5 = ""
local u6 = 0
local u7 = nil
local attackerId_upv_1 = nil
local u8 = -math.huge
local u9 = nil
local u10 = 0
local u11 = false
tbl_upv_1.Changed = Signal_1.new()
local function myId()
    --[[
      name: myId
      line: 53
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    return "p" .. tostring(LocalPlayer_upv_1.UserId)
end
local function humanoidAlive(a1)
    --[[
      name: humanoidAlive
      line: 57
    ]]
    local v1 = a1:FindFirstChildOfClass("Humanoid")
    local v2 = (v1 ~= nil) and ((v1.Health > 0) and ((a1.Parent ~= nil) and (a1:FindFirstChild("HumanoidRootPart") ~= nil)))
    return v2
end
function tbl_upv_1.ResolveCombatant(a1)
    --[[
      name: ResolveCombatant
      line: 63
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
        local u12 = nil
        Fighters_upv_1.EachTagged(
            function(a2)
                --[[
                  line: 76
                  upvalues:
                    u12 (ref,  index: 1)
                    a1 (copy, index: 2)
                ]]
                if (u12) or a2:GetAttribute("CombatantId") ~= a1 or not a2.Parent then
                    return
                end
                u12 = a2
            end
        )
        return v3
    end
    return nil
end
local function nameOf(a1)
    --[[
      name: nameOf
      line: 84
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
      line: 96
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
      line: 109
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
      line: 117
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
local function candidates(a1)
    --[[
      name: candidates
      line: 128
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        Players_upv_1 (copy, index: 2)
        Fighters_upv_1 (copy, index: 3)
    ]]
    local v16 = LocalPlayer_upv_1:GetAttribute("Spectating")
    local v17
    if type(v16) ~= "string" or v16 == "" or LocalPlayer_upv_1:GetAttribute("State") == "Match" then
        v17 = ""
    else
        v17 = v16
    end
    local u13
    if v17 == "" then
        u13 = LocalPlayer_upv_1:GetAttribute("MatchId")
    else
        u13 = v17
    end
    local u14 = LocalPlayer_upv_1:GetAttribute("Team")
    local u15 = v17 ~= ""
    local tbl_upv_2 = {}
    if type(u13) == "string" and u13 ~= "" then
        for _, value_1 in Players_upv_1:GetPlayers() do
            if value_1 == LocalPlayer_upv_1 or value_1:GetAttribute("MatchId") ~= u13 or value_1:GetAttribute("Alive") == false then
                continue
            end
            if u15 then
                local Character_1 = value_1.Character
                if not (Character_1) then
                    continue
                end
                local v18 = Character_1:FindFirstChildOfClass("Humanoid")
                local v19 = (v18 ~= nil) and ((v18.Health > 0) and ((Character_1.Parent ~= nil) and (Character_1:FindFirstChild("HumanoidRootPart") ~= nil)))
                if v19 then
                    table.insert(tbl_upv_2, Character_1)
                end
            else
                local v20 = value_1:GetAttribute("Team") == u14
                if v20 ~= a1 then
                    continue
                end
                local Character_1 = value_1.Character
                if not (Character_1) then
                    continue
                end
                local v18 = Character_1:FindFirstChildOfClass("Humanoid")
                local v19 = (v18 ~= nil) and ((v18.Health > 0) and ((Character_1.Parent ~= nil) and (Character_1:FindFirstChild("HumanoidRootPart") ~= nil)))
                if v19 then
                    table.insert(tbl_upv_2, Character_1)
                end
            end
        end
        Fighters_upv_1.EachTagged(
            function(a2)
                --[[
                  line: 147
                  upvalues:
                    Players_upv_1 (copy, index: 1)
                    u13 (copy, index: 2)
                    u15 (copy, index: 3)
                    u14 (copy, index: 4)
                    a1 (copy, index: 5)
                    tbl_upv_2 (copy, index: 6)
                ]]
                if Players_upv_1:GetPlayerFromCharacter(a2) ~= nil then
                    return
                end
                if a2:GetAttribute("MatchId") == u13 then
                    local v21 = a2:FindFirstChildOfClass("Humanoid")
                    local v22 = (v21 ~= nil) and ((v21.Health > 0) and ((a2.Parent ~= nil) and (a2:FindFirstChild("HumanoidRootPart") ~= nil)))
                    if v22 then
                        local v23 = nil
                        if u15 then
                            table.insert(tbl_upv_2, a2)
                        else
                            v23 = a2:GetAttribute("Team") == u14
                            if v23 ~= a1 then
                                return
                            end
                            table.insert(tbl_upv_2, a2)
                        end
                    end
                end
            end
        )
        table.sort(
            tbl_upv_2,
            function(a3, a4)
                --[[
                  line: 154
                  upvalues:
                    u15 (copy, index: 1)
                    Players_upv_1 (copy, index: 2)
                ]]
                if u15 then
                    local v24 = a3:GetAttribute("Team")
                    if type(v24) ~= "number" then
                        local v25 = Players_upv_1:GetPlayerFromCharacter(a3)
                        v24 = v25 and v25:GetAttribute("Team")
                    end
                    local v27
                    if type(v24) ~= "number" then
                        v27 = 0
                    else
                        v27 = v24
                    end
                    v24 = a4:GetAttribute("Team")
                    if type(v24) ~= "number" then
                        local v28 = Players_upv_1:GetPlayerFromCharacter(a4)
                        v24 = v28 and v28:GetAttribute("Team")
                    end
                    local v30
                    if type(v24) ~= "number" then
                        v30 = 0
                    else
                        v30 = v24
                    end
                    if v27 ~= v30 then
                        return v27 < v30
                    end
                end
                local v31, v30 = nil, nil
                if a3 then
                    v31 = a3:GetAttribute("CombatantId")
                    if type(v31) ~= "string" then
                        local v32 = Players_upv_1:GetPlayerFromCharacter(a3)
                        v30 = (v32 and ("p" .. v32.UserId)) or (a3.Name)
                    else
                        v30 = v31
                    end
                else
                    v30 = ""
                end
                local v33, v24 = nil, nil
                if a4 then
                    v33 = a4:GetAttribute("CombatantId")
                    if type(v33) ~= "string" then
                        local v34 = Players_upv_1:GetPlayerFromCharacter(a4)
                        v24 = (v34 and ("p" .. v34.UserId)) or (a4.Name)
                    else
                        v24 = v33
                    end
                else
                    v24 = ""
                end
                local v35
                if v30 < v24 then
                    v35 = true
                else
                    v35 = false
                end
                return v35
            end
        )
    end
    return tbl_upv_2
end
local function publishCount()
    --[[
      name: publishCount
      line: 166
      upvalues:
        u1 (ref,  index: 1)
        candidates (copy, index: 2)
        LocalPlayer_upv_1 (copy, index: 3)
    ]]
    local v36 = 0
    if u1 == "follow" then
        v36 = #candidates(true)
        if v36 == 0 then
            v36 = #candidates(false)
        end
    end
    LocalPlayer_upv_1:SetAttribute("SpectateCount", v36)
end
local function publish()
    --[[
      name: publish
      line: 177
      upvalues:
        u1 (ref,  index: 1)
        candidates (copy, index: 2)
        LocalPlayer_upv_1 (copy, index: 3)
        u2 (ref,  index: 4)
        Players_upv_1 (copy, index: 5)
        u5 (ref,  index: 6)
        tbl_upv_1 (copy, index: 7)
    ]]
    local Changed_1 = 0
    if u1 == "follow" then
        Changed_1 = #candidates(true)
        if Changed_1 == 0 then
            Changed_1 = #candidates(false)
        end
    end
    LocalPlayer_upv_1:SetAttribute("SpectateCount", Changed_1)
    LocalPlayer_upv_1:SetAttribute("SpectateMode", u1)
    local v37
    local v40 = nil
    if u1 ~= "follow" then
        v37 = ""
    elseif u2 then
        v40 = u2:GetAttribute("CombatantId")
        if type(v40) ~= "string" then
            local v39 = Players_upv_1:GetPlayerFromCharacter(u2)
            v37 = (v39 and ("p" .. v39.UserId)) or (u2.Name)
        else
            v37 = v40
        end
    else
        v37 = ""
    end
    LocalPlayer_upv_1:SetAttribute("SpectateTargetId", v37)
    if u1 ~= "follow" then
        v37 = ""
    else
        v40 = u2
        local v41, v42 = nil, nil
        if v40 then
            v41 = v40:GetAttribute("DisplayName")
            if type(v41) ~= "string" or v41 == "" then
                v42 = Players_upv_1:GetPlayerFromCharacter(v40)
                if v42 then
                    v37 = v42.DisplayName
                else
                    v37 = v40.Name
                end
            else
                v37 = v41
            end
        else
            v37 = ""
        end
    end
    LocalPlayer_upv_1:SetAttribute("SpectateTargetName", v37)
    LocalPlayer_upv_1:SetAttribute("SpectateKillerName", u5)
    Changed_1 = tbl_upv_1.Changed
    local v43
    if u1 ~= "follow" then
        v43 = nil
    else
        v43 = u2
    end
    Changed_1:Fire(v43, u1)
end
local u16 = nil
local function playSwitch()
    --[[
      name: playSwitch
      line: 188
      upvalues:
        u16 (ref, index: 1)
    ]]
    local v44 = nil
    if u16 == nil then
        v44 = script.Parent.Parent:FindFirstChild("Sfx")
        u16 = false
        if v44 and v44:IsA("ModuleScript") then
            local success_1, v45 = pcall(require, v44)
            if success_1 and type(v45) == "table" then
                u16 = v45
            end
        end
    end
    if not u16 or type(u16.PlayUI) ~= "function" then
        return
    end
    pcall(u16.PlayUI, "UI/Spectate_Switch")
end
local function setTarget(a1)
    --[[
      name: setTarget
      line: 204
      upvalues:
        u2 (ref,  index: 1)
        u1 (ref,  index: 2)
        playSwitch (copy, index: 3)
        u9 (ref,  index: 4)
        publish (copy, index: 5)
    ]]
    if a1 ~= u2 and a1 ~= nil and u1 == "follow" then
        playSwitch()
    end
    u2 = a1
    u9 = nil
    publish()
end
local function pick(a1)
    --[[
      name: pick
      line: 213
      upvalues:
        candidates (copy, index: 1)
        u2 (ref,  index: 2)
        u1 (ref,  index: 3)
        playSwitch (copy, index: 4)
        u9 (ref,  index: 5)
        publish (copy, index: 6)
    ]]
    local v46 = candidates(true)
    if #v46 == 0 then
        v46 = candidates(false)
    end
    if #v46 ~= 0 then
        local v47
        if u2 then
            v47 = table.find(v46, u2)
        else
            v47 = nil
        end
        local v48
        if v47 then
            v48 = ((v47 - 1) + a1) % #v46 + 1
        else
            v48 = ((a1 < 0) and (#v46)) or 1
        end
        if v46[v48] ~= u2 then
            local v49 = v46[v48]
            if v49 ~= u2 and v49 ~= nil and u1 == "follow" then
                playSwitch()
            end
            u2 = v49
            u9 = nil
            publish()
        end
    elseif u2 ~= nil then
        u2 = nil
        u9 = nil
        publish()
    end
end
local function followWanted()
    --[[
      name: followWanted
      line: 239
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        candidates (copy, index: 2)
        Players_upv_1 (copy, index: 3)
        u2 (ref,  index: 4)
        u1 (ref,  index: 5)
        playSwitch (copy, index: 6)
        u9 (ref,  index: 7)
        publish (copy, index: 8)
    ]]
    local v50 = LocalPlayer_upv_1:GetAttribute("SpectateFollow")
    if type(v50) ~= "string" or v50 == "" then
        return false
    end
    local v51 = LocalPlayer_upv_1:GetAttribute("Spectating")
    local v52
    if type(v51) ~= "string" or v51 == "" or LocalPlayer_upv_1:GetAttribute("State") == "Match" then
        v52 = ""
    else
        v52 = v51
    end
    if v52 ~= "" then
        for _, value_2 in candidates(false) do
            local v53
            if value_2 then
                local v54 = value_2:GetAttribute("CombatantId")
                if type(v54) ~= "string" then
                    local v55 = Players_upv_1:GetPlayerFromCharacter(value_2)
                    v53 = (v55 and ("p" .. v55.UserId)) or (value_2.Name)
                else
                    v53 = v54
                end
            else
                v53 = ""
            end
            if v53 == v50 then
                if value_2 ~= u2 and value_2 ~= nil and u1 == "follow" then
                    playSwitch()
                end
                u2 = nil
                u9 = nil
                publish()
                LocalPlayer_upv_1:SetAttribute("SpectateFollow", nil)
                return true
            end
        end
    else
        return false
    end
end
local u17 = nil
local u18 = ""
local function noteUnexplained()
    --[[
      name: noteUnexplained
      line: 277
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        u18 (ref,  index: 2)
    ]]
    local v56 = LocalPlayer_upv_1:GetAttribute("MatchId")
    local Arenas_1 = workspace:FindFirstChild("Arenas")
    local v57 = Arenas_1 and ((type(v56) == "string") and (Arenas_1:FindFirstChild(v56)))
    local v58 = v57 and (v57:GetAttribute("Round"))
    local v59 = ("%*:%*"):format(v56, v58)
    if v59 == u18 then
        return
    end
    u18 = v59
    local Character_2 = LocalPlayer_upv_1.Character
    local v60 = Character_2
    local v61 = v60 and (Character_2:FindFirstChildOfClass("Humanoid"))
    local v62 = Character_2
    local _ = v62 and (Character_2:FindFirstChild("HumanoidRootPart"))
    if Character_2 and Character_2.Parent and Character_2 and Character_2.Health <= 0 and LocalPlayer_upv_1:GetAttribute("Alive") == false then
        return
    end
    local Name_1 = LocalPlayer_upv_1.Name
    local v63 = LocalPlayer_upv_1:GetAttribute("Alive")
    local v64 = ((not Character_2) and "none") or (((Character_2.Parent) and "in world") or "removed")
    local v65 = (v61 and (math.floor(Character_2.Health))) or "-"
    local v66 = (v61 and (Character_2:GetState().Name)) or "-"
    local v67 = (v62 and (math.floor(Character_2.Position.Y))) or "-"
    local v68 = (v57 and (v57:GetAttribute("Phase"))) or "-"
    warn((("[Spectate] %* down with no attacker: Alive %*, body %*, hp %*, state %*, y %*, phase %* r%*"):format(Name_1, v63, v64, v65, v66, v67, v68, v57 or "-")))
end
local function resolveKiller()
    --[[
      name: resolveKiller
      line: 296
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u4 (ref,  index: 2)
        u3 (ref,  index: 3)
        u5 (ref,  index: 4)
        Players_upv_1 (copy, index: 5)
    ]]
    local v69 = tbl_upv_1.ResolveCombatant(u4)
    u3 = v69
    if v69 then
        local v70, v71, v72 = nil, nil, nil
        if v69 then
            v70 = v69:GetAttribute("DisplayName")
            if type(v70) ~= "string" or v70 == "" then
                v71 = Players_upv_1:GetPlayerFromCharacter(v69)
                if v71 then
                    v72 = v71.DisplayName
                else
                    v72 = v69.Name
                end
            else
                v72 = v70
            end
        else
            v72 = ""
        end
        u5 = v72
    end
end
local function enterDeath(a1)
    --[[
      name: enterDeath
      line: 304
      upvalues:
        u1 (ref,  index: 1)
        u6 (ref,  index: 2)
        u7 (ref,  index: 3)
        u2 (ref,  index: 4)
        u3 (ref,  index: 5)
        u5 (ref,  index: 6)
        u4 (ref,  index: 7)
        u8 (ref,  index: 8)
        attackerId_upv_1 (ref,  index: 9)
        tbl_upv_1 (copy, index: 10)
        Players_upv_1 (copy, index: 11)
        publish (copy, index: 12)
    ]]
    u1 = "death"
    u6 = os.clock()
    u7 = a1
    u2 = nil
    u3 = nil
    u5 = ""
    if u4 == nil and os.clock() - u8 < 4 then
        u4 = attackerId_upv_1
    end
    local v73 = tbl_upv_1.ResolveCombatant(u4)
    u3 = v73
    if v73 then
        local v74, v75, v76 = nil, nil, nil
        if v73 then
            v74 = v73:GetAttribute("DisplayName")
            if type(v74) ~= "string" or v74 == "" then
                v75 = Players_upv_1:GetPlayerFromCharacter(v73)
                if v75 then
                    v76 = v75.DisplayName
                else
                    v76 = v73.Name
                end
            else
                v76 = v74
            end
        else
            v76 = ""
        end
        u5 = v76
    end
    publish()
end
local function leave()
    --[[
      name: leave
      line: 318
      upvalues:
        u17 (ref,  index: 1)
        u1 (ref,  index: 2)
        u2 (ref,  index: 3)
        u3 (ref,  index: 4)
        u4 (ref,  index: 5)
        u5 (ref,  index: 6)
        u7 (ref,  index: 7)
        u9 (ref,  index: 8)
        publish (copy, index: 9)
    ]]
    u17 = nil
    u1 = "none"
    u2 = nil
    u3 = nil
    u4 = nil
    u5 = ""
    u7 = nil
    u9 = nil
    publish()
end
local function wantsSpectate()
    --[[
      name: wantsSpectate
      line: 254
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local v77 = LocalPlayer_upv_1:GetAttribute("Spectating")
    local v78
    if type(v77) ~= "string" or v77 == "" or LocalPlayer_upv_1:GetAttribute("State") == "Match" then
        v78 = ""
    else
        v78 = v77
    end
    if v78 ~= "" then
        return true
    end
    if LocalPlayer_upv_1:GetAttribute("State") ~= "Match" then
        return false
    end
    if LocalPlayer_upv_1:GetAttribute("Alive") == false then
        return true
    end
    local Character_3 = LocalPlayer_upv_1.Character
    local v79 = Character_3 and (Character_3:FindFirstChildOfClass("Humanoid"))
    local v80 = false
    if v79 ~= nil then
        v80 = v79.Health <= 0
    end
    return v80
end
function tbl_upv_1.Step(a1)
    --[[
      name: Step
      line: 331
      upvalues:
        wantsSpectate (copy, index: 1)
        u1 (ref,  index: 2)
        u17 (ref,  index: 3)
        u2 (ref,  index: 4)
        u3 (ref,  index: 5)
        u4 (ref,  index: 6)
        u5 (ref,  index: 7)
        u7 (ref,  index: 8)
        u9 (ref,  index: 9)
        publish (copy, index: 10)
        LocalPlayer_upv_1 (copy, index: 11)
        followWanted (copy, index: 12)
        pick (copy, index: 13)
        u6 (ref,  index: 14)
        u8 (ref,  index: 15)
        attackerId_upv_1 (ref,  index: 16)
        tbl_upv_1 (copy, index: 17)
        Players_upv_1 (copy, index: 18)
        noteUnexplained (copy, index: 19)
        u10 (ref,  index: 20)
        candidates (copy, index: 21)
    ]]
    local v81 = os.clock()
    if wantsSpectate() then
        local v82 = nil
        if u1 ~= "none" then
            if u17 and v81 - u17 >= 3 then
                u17 = nil
                noteUnexplained()
            end
            if not (v81 - u10 < 0.25) then
                u10 = v81
                local v83 = nil
                if u1 == "death" then
                    if u3 == nil or u3.Parent == nil then
                        v83 = tbl_upv_1.ResolveCombatant(u4)
                        u3 = v83
                        if v83 then
                            local v84, v85, v86 = nil, nil, nil
                            if v83 then
                                v84 = v83:GetAttribute("DisplayName")
                                if type(v84) ~= "string" or v84 == "" then
                                    v85 = Players_upv_1:GetPlayerFromCharacter(v83)
                                    if v85 then
                                        v86 = v85.DisplayName
                                    else
                                        v86 = v83.Name
                                    end
                                else
                                    v86 = v84
                                end
                            else
                                v86 = ""
                            end
                            u5 = v86
                        end
                    end
                    if v81 - u6 >= 1.55 then
                        u1 = "follow"
                        pick(1)
                        publish()
                    end
                elseif u1 == "follow" then
                    v83 = 0
                    local v87 = nil
                    if u1 == "follow" then
                        v87 = #candidates(true)
                        if v87 ~= 0 then
                            v83 = v87
                        else
                            v83 = #candidates(false)
                        end
                    end
                    LocalPlayer_upv_1:SetAttribute("SpectateCount", v83)
                    followWanted()
                    v83 = u2
                    local v88 = nil
                    if v83 == nil then
                        if u9 == nil then
                            u9 = v81
                        end
                        if u2 == nil or v81 - u9 >= 0.9 then
                            pick(1)
                        end
                    else
                        local v89 = v83:FindFirstChildOfClass("Humanoid")
                        v88 = (v89 ~= nil) and ((v89.Health > 0) and ((v83.Parent ~= nil) and (v83:FindFirstChild("HumanoidRootPart") ~= nil)))
                        if v88 then
                            u9 = nil
                        else
                            if u9 == nil then
                                u9 = v81
                            end
                            if u2 == nil or v81 - u9 >= 0.9 then
                                pick(1)
                            end
                        end
                    end
                end
            end
        else
            v82 = LocalPlayer_upv_1:GetAttribute("Spectating")
            local v90
            if type(v82) ~= "string" or v82 == "" or LocalPlayer_upv_1:GetAttribute("State") == "Match" then
                v90 = ""
            else
                v90 = v82
            end
            if v90 == "" then
                u1 = "death"
                u6 = os.clock()
                u7 = a1
                u2 = nil
                u3 = nil
                u5 = ""
                if u4 == nil and os.clock() - u8 < 4 then
                    u4 = attackerId_upv_1
                end
                v90 = tbl_upv_1.ResolveCombatant(u4)
                u3 = v90
                if v90 then
                    local v91, v92, v93 = nil, nil, nil
                    if v90 then
                        v91 = v90:GetAttribute("DisplayName")
                        if type(v91) ~= "string" or v91 == "" then
                            v92 = Players_upv_1:GetPlayerFromCharacter(v90)
                            if v92 then
                                v93 = v92.DisplayName
                            else
                                v93 = v90.Name
                            end
                        else
                            v93 = v91
                        end
                    else
                        v93 = ""
                    end
                    u5 = v93
                end
                publish()
                if u4 ~= nil then
                    v90 = nil
                else
                    v90 = v81
                end
                u17 = v90
            else
                u1 = "follow"
                u2 = nil
                u5 = ""
                if not (followWanted()) then
                    pick(1)
                end
                publish()
            end
        end
    elseif u1 ~= "none" then
        u17 = nil
        u1 = "none"
        u2 = nil
        u3 = nil
        u4 = nil
        u5 = ""
        u7 = nil
        u9 = nil
        publish()
    end
    return u1
end
function tbl_upv_1.GetMode()
    --[[
      name: GetMode
      line: 392
      upvalues:
        u1 (ref, index: 1)
    ]]
    return u1
end
function tbl_upv_1.GetTarget()
    --[[
      name: GetTarget
      line: 396
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
      line: 400
      upvalues:
        u3 (ref, index: 1)
    ]]
    return u3
end
function tbl_upv_1.GetDeathPosition()
    --[[
      name: GetDeathPosition
      line: 404
      upvalues:
        u7 (ref, index: 1)
    ]]
    return u7
end
function tbl_upv_1.DeathElapsed()
    --[[
      name: DeathElapsed
      line: 408
      upvalues:
        u6 (ref, index: 1)
    ]]
    return os.clock() - u6
end
function tbl_upv_1.Next(a1)
    --[[
      name: Next
      line: 412
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
      line: 420
    ]]
    task.spawn(function() end)
end
function tbl_upv_1.Start()
    --[[
      name: Start
      line: 437
      upvalues:
        u11 (ref,  index: 1)
        publish (copy, index: 2)
        LocalPlayer_upv_1 (copy, index: 3)
        u4 (ref,  index: 4)
        u1 (ref,  index: 6)
        ReplicatedStorage_upv_1 (copy, index: 12)
        attackerId_upv_1 (ref,  index: 13)
        u8 (ref,  index: 14)
    ]]
    if u11 then
        return
    end
    u11 = true
    publish()
    local _ = "MatchEvent"
    task.spawn(function() end)
    local u19 = function(a1)
        --[[
          line: 460
          upvalues:
            attackerId_upv_1 (ref, index: 1)
            u8 (ref, index: 2)
        ]]
        if type(a1) ~= "table" or type(a1.attackerId) ~= "string" then
            return
        end
        attackerId_upv_1 = a1.attackerId
        u8 = os.clock()
    end
    local u20 = "DamageTaken"
    task.spawn(
        function()
            --[[
              line: 421
              upvalues:
                ReplicatedStorage_upv_1 (copy, index: 1)
                u20 (copy, index: 2)
                u19 (copy, index: 3)
            ]]
            local v94 = ReplicatedStorage_upv_1:WaitForChild("Remotes", 60)
            while not (v94) do
                v94 = ReplicatedStorage_upv_1:WaitForChild("Remotes", 60)
            end
            local v95 = v94:FindFirstChild(u20)
            while not (v95) do
                v94.ChildAdded:Wait()
                v95 = v94:FindFirstChild(u20)
            end
            if not v95 or not v95:IsA("RemoteEvent") then
                return
            end
            v95.OnClientEvent:Connect(u19)
        end
    )
    LocalPlayer_upv_1.CharacterAdded:Connect(
        function()
            --[[
              line: 467
              upvalues:
                u1 (ref, index: 1)
                u4 (ref, index: 2)
            ]]
            if u1 ~= "none" then
                return
            end
            u4 = nil
        end
    )
end
return tbl_upv_1