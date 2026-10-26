local Lighting_upv_1 = game:GetService("Lighting")
local Players_1 = game:GetService("Players")
local ReplicatedStorage_upv_1 = game:GetService("ReplicatedStorage")
local TweenService_upv_1 = game:GetService("TweenService")
local Workspace_upv_1 = game:GetService("Workspace")
local Config_upv_1 = require(ReplicatedStorage_upv_1:WaitForChild("Shared"):WaitForChild("Config"))
local tbl_1 = {}
local LocalPlayer_upv_1 = Players_1.LocalPlayer
local tbl_upv_2 = {"ClockTime", "Brightness", "Ambient", "OutdoorAmbient", "ExposureCompensation", "EnvironmentDiffuseScale", "EnvironmentSpecularScale", "ShadowSoftness", "GeographicLatitude", "ColorShift_Top", "ColorShift_Bottom", "FogColor", "FogStart", "FogEnd"}
local tbl_upv_3 = {SunRaysEffect = true, Sky = true, BloomEffect = true, Atmosphere = true, DepthOfFieldEffect = true, ColorCorrectionEffect = true, BlurEffect = true}
local tbl_upv_4 = {}
local tbl_upv_5 = {}
local tbl_upv_6 = {}
local tbl_upv_7 = {}
local u1 = nil
local u2 = nil
local u3 = 0
local u4 = Instance.new("Folder")
u4.Name = "CoreLightingStash"
local u5 = Instance.new("ColorCorrectionEffect")
u5.Name = "CoreTransition"
u5.Enabled = false
local function presetsFolder()
    --[[
      name: presetsFolder
      line: 66
      upvalues:
        ReplicatedStorage_upv_1 (copy, index: 1)
    ]]
    return ReplicatedStorage_upv_1:FindFirstChild("Lighting")
end
local function getPreset(a1)
    --[[
      name: getPreset
      line: 70
      upvalues:
        ReplicatedStorage_upv_1 (copy, index: 1)
    ]]
    local Lighting_2 = ReplicatedStorage_upv_1:FindFirstChild("Lighting")
    if Lighting_2 and a1 then
        return (Lighting_2:FindFirstChild(a1))
    end
    return nil
end
local function arenaOf(a1)
    --[[
      name: arenaOf
      line: 75
      upvalues:
        Workspace_upv_1 (copy, index: 1)
    ]]
    if type(a1) == "string" and a1 ~= "" then
        local Arenas_1 = Workspace_upv_1:FindFirstChild("Arenas")
        local v1 = Arenas_1 and (Arenas_1:FindFirstChild(a1))
        return v1
    end
    return nil
end
local function seenMatch()
    --[[
      name: seenMatch
      line: 84
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local v2
    if LocalPlayer_upv_1:GetAttribute("State") ~= "Match" then
        v2 = LocalPlayer_upv_1:GetAttribute("Spectating")
    else
        v2 = LocalPlayer_upv_1:GetAttribute("MatchId")
    end
    if type(v2) ~= "string" then
        return ""
    end
    return v2
end
local function wantedName()
    --[[
      name: wantedName
      line: 90
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        Workspace_upv_1 (copy, index: 2)
        ReplicatedStorage_upv_1 (copy, index: 3)
        u1 (ref,  index: 4)
    ]]
    local v3
    if LocalPlayer_upv_1:GetAttribute("State") ~= "Match" then
        v3 = LocalPlayer_upv_1:GetAttribute("Spectating")
    else
        v3 = LocalPlayer_upv_1:GetAttribute("MatchId")
    end
    local v4
    if type(v3) ~= "string" then
        v4 = ""
    else
        v4 = v3
    end
    if v4 == "" then
        return "Lobby"
    end
    local v5
    if LocalPlayer_upv_1:GetAttribute("State") ~= "Match" then
        v5 = LocalPlayer_upv_1:GetAttribute("Spectating")
    else
        v5 = LocalPlayer_upv_1:GetAttribute("MatchId")
    end
    if type(v5) ~= "string" then
        v3 = ""
    else
        v3 = v5
    end
    if type(v3) ~= "string" or v3 == "" then
        v4 = nil
    else
        local Arenas_2 = Workspace_upv_1:FindFirstChild("Arenas")
        v4 = Arenas_2 and (Arenas_2:FindFirstChild(v3))
    end
    if not v4 then
        return u1 or "Lobby"
    end
    v3 = v4:GetAttribute("LightingPreset")
    local v9 = nil
    if type(v3) == "string" then
        if v3 ~= "" then
            v9 = ReplicatedStorage_upv_1:FindFirstChild("Lighting")
            local v7 = not (v9) or not (v3) or v9:FindFirstChild(v3)
            if v7 then
                return v3
            end
        end
    end
    local v8 = v4:GetAttribute("MapId")
    if type(v8) == "string" then
        v9 = ReplicatedStorage_upv_1:FindFirstChild("Lighting")
        local v10 = not (v9) or not (v8) or v9:FindFirstChild(v8)
        if v10 then
            return v8
        end
    end
    if type(v3) == "string" and v3 ~= "" then
        return v3
    end
    return "Lobby"
end
local function restoreDefaults()
    --[[
      name: restoreDefaults
      line: 109
      upvalues:
        tbl_upv_4 (copy, index: 1)
        Lighting_upv_1 (copy, index: 2)
        tbl_upv_6 (copy, index: 3)
        tbl_upv_7 (copy, index: 4)
    ]]
    for key_upv_1, value_upv_1 in tbl_upv_4 do
        pcall(
            function()
                --[[
                  line: 111
                  upvalues:
                    Lighting_upv_1 (copy, index: 1)
                    key_upv_1 (copy, index: 2)
                    value_upv_1 (copy, index: 3)
                ]]
                Lighting_upv_1[key_upv_1] = value_upv_1
            end
        )
    end
    for _, value_2 in tbl_upv_6 do
        value_2:Destroy()
    end
    table.clear(tbl_upv_6)
    for _, value_3 in tbl_upv_7 do
        value_3.Parent = Lighting_upv_1
    end
    table.clear(tbl_upv_7)
end
local function applyNow(a1)
    --[[
      name: applyNow
      line: 125
      upvalues:
        restoreDefaults (copy, index: 1)
        u2 (ref,  index: 2)
        tbl_upv_2 (copy, index: 3)
        Lighting_upv_1 (copy, index: 4)
        tbl_upv_3 (copy, index: 5)
        tbl_upv_5 (copy, index: 6)
        u4 (copy, index: 7)
        tbl_upv_7 (copy, index: 8)
        tbl_upv_6 (copy, index: 9)
    ]]
    restoreDefaults()
    u2 = a1
    if not a1 then
        return
    end
    for _, value_upv_4 in tbl_upv_2 do
        local u6 = a1:GetAttribute(value_upv_4)
        if u6 ~= nil then
            pcall(
                function()
                    --[[
                      line: 134
                      upvalues:
                        Lighting_upv_1 (copy, index: 1)
                        value_upv_4 (copy, index: 2)
                        u6 (copy, index: 3)
                    ]]
                    Lighting_upv_1[value_upv_4] = u6
                end
            )
        end
    end
    local tbl_8 = {}
    for _, value_5 in a1:GetChildren() do
        if tbl_upv_3[value_5.ClassName] then
            tbl_8[value_5.ClassName] = true
        end
    end
    for _, value_6 in Lighting_upv_1:GetChildren() do
        if not (tbl_upv_5[value_6]) then
            continue
        end
        if tbl_8[value_6.ClassName] then
            value_6.Parent = u4
            table.insert(tbl_upv_7, value_6)
        end
    end
    for _, value_7 in a1:GetChildren() do
        if tbl_upv_3[value_7.ClassName] then
            local v11 = value_7:Clone()
            v11.Parent = Lighting_upv_1
            table.insert(tbl_upv_6, v11)
        end
    end
end
local function fade(a1, a2)
    --[[
      name: fade
      line: 189
      upvalues:
        TweenService_upv_1 (copy, index: 1)
        u5 (copy, index: 2)
    ]]
    local v12 = TweenService_upv_1:Create(u5, TweenInfo.new(a2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {TintColor = a1})
    v12:Play()
    return v12
end
local function landed()
    --[[
      name: landed
      line: 161
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        Workspace_upv_1 (copy, index: 2)
        Config_upv_1 (copy, index: 3)
    ]]
    if LocalPlayer_upv_1:GetAttribute("State") ~= "Match" then
        local v13
        if LocalPlayer_upv_1:GetAttribute("State") ~= "Match" then
            v13 = LocalPlayer_upv_1:GetAttribute("Spectating")
        else
            v13 = LocalPlayer_upv_1:GetAttribute("MatchId")
        end
        local v14
        if type(v13) ~= "string" then
            v14 = ""
        else
            v14 = v13
        end
        if v14 ~= "" then
            local v15
            if LocalPlayer_upv_1:GetAttribute("State") ~= "Match" then
                v15 = LocalPlayer_upv_1:GetAttribute("Spectating")
            else
                v15 = LocalPlayer_upv_1:GetAttribute("MatchId")
            end
            if type(v15) ~= "string" then
                v13 = ""
            else
                v13 = v15
            end
            if type(v13) ~= "string" or v13 == "" then
                v14 = nil
            else
                local Arenas_3 = Workspace_upv_1:FindFirstChild("Arenas")
                v14 = Arenas_3 and (Arenas_3:FindFirstChild(v13))
            end
            v13 = v14 and (v14:GetAttribute("RingCenterX"))
            local v16 = v14 and (v14:GetAttribute("RingCenterZ"))
            v14 = Workspace_upv_1.CurrentCamera
            if type(v14) == "number" and type(v16) == "number" and v14 then
                local Position_1 = v14.CFrame.Position
                local v17 = Vector2.new(Position_1.X - v14, Position_1.Z - v16).Magnitude < 600
                return v17
            end
            return false
        end
    end
    local Character_1 = LocalPlayer_upv_1.Character
    local v13 = Character_1 and (Character_1:FindFirstChild("HumanoidRootPart"))
    if v13 and v13:IsA("BasePart") then
        local Position_2 = v13.Position
        local v18 = nil
        if LocalPlayer_upv_1:GetAttribute("State") ~= "Match" then
            local v19 = Vector2.new(Position_2.X - Config_upv_1.LOBBY_CENTER.X, Position_2.Z - Config_upv_1.LOBBY_CENTER.Z).Magnitude < Config_upv_1.LOBBY_HALF_SIZE + 200
            return v19
        else
            v18 = LocalPlayer_upv_1:GetAttribute("MatchId")
            if type(v18) ~= "string" or v18 == "" then
                v13 = nil
            else
                local Arenas_4 = Workspace_upv_1:FindFirstChild("Arenas")
                v13 = Arenas_4 and (Arenas_4:FindFirstChild(v18))
            end
            local v20 = v13
            local _ = v20 and (v13:GetAttribute("RingCenterX"))
            local v21 = v13 and (v13:GetAttribute("RingCenterZ"))
            if type(v20) == "number" and type(v21) == "number" then
                local v22 = Vector2.new(Position_2.X - v20, Position_2.Z - v21).Magnitude < 600
                return v22
            end
            return false
        end
    end
    return false
end
local function refresh(a1)
    --[[
      name: refresh
      line: 195
      upvalues:
        wantedName (copy, index: 1)
        ReplicatedStorage_upv_1 (copy, index: 2)
        u1 (ref,  index: 3)
        u2 (ref,  index: 4)
        u5 (copy, index: 5)
        u3 (ref,  index: 6)
        applyNow (copy, index: 7)
        fade (copy, index: 8)
        landed (copy, index: 9)
    ]]
    local u7 = wantedName()
    local Lighting_3 = ReplicatedStorage_upv_1:FindFirstChild("Lighting")
    local v23 = not (Lighting_3) or not (u7) or Lighting_3:FindFirstChild(u7)
    if u7 == u1 and v23 == u2 and not (u5.Enabled) then
        return
    end
    u3 = u3 + 1
    local u8 = u3
    local v24 = (u1 ~= nil) and (u7 ~= u1)
    u1 = u7
    if (not a1 or not v24) and not u5.Enabled then
        applyNow(v23)
    end
    task.spawn(
        function()
            --[[
              line: 210
              upvalues:
                u5 (copy, index: 1)
                fade (copy, index: 2)
                u8 (copy, index: 3)
                u3 (ref,  index: 4)
                landed (copy, index: 5)
                applyNow (copy, index: 6)
                u7 (copy, index: 7)
                ReplicatedStorage_upv_1 (copy, index: 8)
            ]]
            u5.Enabled = true
            fade(Color3.new(0.05, 0.05, 0.06), 0.25).Completed:Wait()
            local v25 = os.clock() + 2.5
            while os.clock() < v25 and u8 == u3 and not landed() do
                task.wait(0.05)
            end
            if u8 ~= u3 then
                return
            end
            local v26 = u7
            local Lighting_4 = ReplicatedStorage_upv_1:FindFirstChild("Lighting")
            local v27 = not (Lighting_4) or not (v26) or Lighting_4:FindFirstChild(v26)
            applyNow(v27)
            task.wait(0.1)
            if u8 ~= u3 then
                return
            end
            fade(Color3.new(1, 1, 1), 0.45).Completed:Wait()
            if u8 ~= u3 then
                return
            end
            u5.Enabled = false
        end
    )
end
function tbl_1.Current()
    --[[
      name: Current
      line: 233
      upvalues:
        u1 (ref, index: 1)
    ]]
    return u1
end
function tbl_1.Start()
    --[[
      name: Start
      line: 237
      upvalues:
        tbl_upv_2 (copy, index: 1)
        Lighting_upv_1 (copy, index: 2)
        tbl_upv_4 (copy, index: 3)
        tbl_upv_5 (copy, index: 4)
        u5 (copy, index: 5)
        refresh (copy, index: 6)
        LocalPlayer_upv_1 (copy, index: 7)
        ReplicatedStorage_upv_1 (copy, index: 8)
        Workspace_upv_1 (copy, index: 9)
    ]]
    for _, value_upv_8 in tbl_upv_2 do
        local success_1, v28 = pcall(
            function()
                --[[
                  line: 239
                  upvalues:
                    Lighting_upv_1 (copy, index: 1)
                    value_upv_8 (copy, index: 2)
                ]]
                return Lighting_upv_1[value_upv_8]
            end
        )
        if success_1 then
            tbl_upv_4[value_upv_8] = v28
        end
    end
    for _, value_9 in Lighting_upv_1:GetChildren() do
        tbl_upv_5[value_9] = true
    end
    u5.Parent = Lighting_upv_1
    refresh(false)
    LocalPlayer_upv_1:GetAttributeChangedSignal("State"):Connect(
        function()
            --[[
              line: 252
              upvalues:
                refresh (copy, index: 1)
            ]]
            refresh(true)
        end
    )
    LocalPlayer_upv_1:GetAttributeChangedSignal("MatchId"):Connect(
        function()
            --[[
              line: 255
              upvalues:
                refresh (copy, index: 1)
            ]]
            refresh(true)
        end
    )
    LocalPlayer_upv_1:GetAttributeChangedSignal("Spectating"):Connect(
        function()
            --[[
              line: 258
              upvalues:
                refresh (copy, index: 1)
            ]]
            refresh(true)
        end
    )
    local function watchPresets(a1)
        --[[
          name: watchPresets
          line: 263
          upvalues:
            refresh (copy, index: 1)
        ]]
        a1.ChildAdded:Connect(function() end)
        refresh(false)
    end
    local Lighting_5 = ReplicatedStorage_upv_1:FindFirstChild("Lighting")
    if Lighting_5 then
        Lighting_5.ChildAdded:Connect(function() end)
        refresh(false)
    else
        local u9 = nil
        local v29 = ReplicatedStorage_upv_1.ChildAdded:Connect(
            function(a2)
                --[[
                  line: 274
                  upvalues:
                    u9 (ref,  index: 1)
                    refresh (copy, index: 2)
                ]]
                if a2.Name ~= "Lighting" then
                    return
                end
                u9:Disconnect()
                a2.ChildAdded:Connect(
                    function()
                        --[[
                          line: 264
                          upvalues:
                            refresh (copy, index: 1)
                        ]]
                        task.defer(refresh, false)
                    end
                )
                refresh(false)
            end
        )
        u9 = v29
    end
    task.spawn(
        function()
            --[[
              line: 281
              upvalues:
                Workspace_upv_1 (copy, index: 1)
                LocalPlayer_upv_1 (copy, index: 2)
                refresh (copy, index: 3)
            ]]
            local v30 = Workspace_upv_1:WaitForChild("Arenas", 60)
            if not v30 then
                return
            end
            v30.ChildAdded:Connect(
                function(a3)
                    --[[
                      line: 284
                      upvalues:
                        LocalPlayer_upv_1 (copy, index: 1)
                        refresh (copy, index: 2)
                    ]]
                    local Name_1 = a3.Name
                    local v31
                    if LocalPlayer_upv_1:GetAttribute("State") ~= "Match" then
                        v31 = LocalPlayer_upv_1:GetAttribute("Spectating")
                    else
                        v31 = LocalPlayer_upv_1:GetAttribute("MatchId")
                    end
                    local v32
                    if type(v31) ~= "string" then
                        v32 = ""
                    else
                        v32 = v31
                    end
                    if Name_1 ~= v32 then
                        return
                    end
                    task.defer(refresh, true)
                end
            )
        end
    )
end
return tbl_1