local lighting = game:GetService("Lighting")
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local tweenService = game:GetService("TweenService")
local workspace = game:GetService("Workspace")
local Config = require(replicatedStorage:WaitForChild("Shared"):WaitForChild("Config"))
local v7 = {}
local localPlayer = players.LocalPlayer
local attributeNames = {"ClockTime", "Brightness", "Ambient", "OutdoorAmbient", "ExposureCompensation", "EnvironmentDiffuseScale", "EnvironmentSpecularScale", "ShadowSoftness", "GeographicLatitude", "ColorShift_Top", "ColorShift_Bottom", "FogColor", "FogStart", "FogEnd"}
local v10 = {Atmosphere = true, Sky = true, BloomEffect = true, ColorCorrectionEffect = true, SunRaysEffect = true, DepthOfFieldEffect = true, BlurEffect = true}
local v11 = {}
local v12 = {}
local v13 = {}
local v14 = {}
local v15 = nil
local instance = nil
local count = 0
local coreLightingStash = Instance.new("Folder")
coreLightingStash.Name = "CoreLightingStash"

local coreTransition = Instance.new("ColorCorrectionEffect")
coreTransition.Name = "CoreTransition"
coreTransition.Enabled = false

local function presetsFolder()
    --[[
      name: presetsFolder
      line: 66
      upvalues:
        replicatedStorage (copy, index: 1)
    ]]
    return replicatedStorage:FindFirstChild("Lighting")
end

local function getPreset(childName: string)
    --[[
      name: getPreset
      line: 70
      upvalues:
        replicatedStorage (copy, index: 1)
    ]]
    local lighting = replicatedStorage:FindFirstChild("Lighting")

    if lighting and childName then
        return (lighting:FindFirstChild(childName))
    end

    return nil
end

local function arenaOf(childName: string)
    --[[
      name: arenaOf
      line: 75
      upvalues:
        workspace (copy, index: 1)
    ]]
    if type(childName) ~= "string" or childName == "" then
        return nil
    end

    local arenas = workspace:FindFirstChild("Arenas")

    return arenas and arenas:FindFirstChild(childName)
end

local function seenMatch()
    --[[
      name: seenMatch
      line: 84
      upvalues:
        localPlayer (copy, index: 1)
    ]]
    local v28 = if localPlayer:GetAttribute("State") == "Match" then localPlayer:GetAttribute("MatchId") else localPlayer:GetAttribute("Spectating")

    if type(v28) ~= "string" then
        return ""
    end

    return v28
end

local function wantedName()
    --[[
      name: wantedName
      line: 90
      upvalues:
        localPlayer (copy, index: 1)
        workspace (copy, index: 2)
        replicatedStorage (copy, index: 3)
        v15 (ref,  index: 4)
    ]]
    local v30
    local v31
    local child
    local v33 = if localPlayer:GetAttribute("State") == "Match" then localPlayer:GetAttribute("MatchId") else localPlayer:GetAttribute("Spectating")

    if type(v33) ~= "string" then
        v30 = ""
    else
        v30 = v33
    end

    if v30 == "" then
        return "Lobby"
    end

    local v34 = if localPlayer:GetAttribute("State") == "Match" then localPlayer:GetAttribute("MatchId") else localPlayer:GetAttribute("Spectating")

    if type(v34) ~= "string" then
        v31 = ""
    else
        v31 = v34
    end

    if type(v31) ~= "string" or v31 == "" then
        child = nil
    else
        local arenas = workspace:FindFirstChild("Arenas")
        child = arenas and arenas:FindFirstChild(v31)
    end

    if not child then
        return v15 or "Lobby"
    end

    local v36 = child:GetAttribute("LightingPreset")

    if type(v36) ~= "string" then
        v30 = child
    elseif v36 == "" then
        v30 = child
    else
        local lighting = replicatedStorage:FindFirstChild("Lighting")
        local instance = if lighting and v36 then lighting:FindFirstChild(v36) else nil
        if instance then
            return v36
        end

        v30 = child
    end

    local v39 = v30:GetAttribute("MapId")

    if type(v39) == "string" then
        local lighting = replicatedStorage:FindFirstChild("Lighting")
        local instance = if lighting and v39 then lighting:FindFirstChild(v39) else nil
        if instance then
            return v39
        end
    end

    if type(v36) == "string" and v36 ~= "" then
        return v36
    end

    return "Lobby"
end

local function restoreDefaults()
    --[[
      name: restoreDefaults
      line: 109
      upvalues:
        v11 (copy, index: 1)
        lighting (copy, index: 2)
        v13 (copy, index: 3)
        v14 (copy, index: 4)
    ]]
    for v43, v44 in v11 do
        pcall(
            function()
                --[[
                  line: 111
                  upvalues:
                    lighting (copy, index: 1)
                    v43 (copy, index: 2)
                    v44 (copy, index: 3)
                ]]
                lighting[v43] = v44
            end
        )
    end

    for _, v46 in v13 do
        v46:Destroy()
    end

    table.clear(v13)

    for _, v48 in v14 do
        v48.Parent = lighting
    end

    table.clear(v14)
end

local function applyNow(instance2: Instance?)
    --[[
      name: applyNow
      line: 125
      upvalues:
        restoreDefaults (copy, index: 1)
        instance (ref,  index: 2)
        attributeNames (copy, index: 3)
        lighting (copy, index: 4)
        v10 (copy, index: 5)
        v12 (copy, index: 6)
        coreLightingStash (copy, index: 7)
        v14 (copy, index: 8)
        v13 (copy, index: 9)
    ]]
    restoreDefaults()
    instance = instance2

    if not instance2 then
        return
    end

    for _, attributeName in attributeNames do
        local v53 = instance2:GetAttribute(attributeName)
        if v53 ~= nil then
            pcall(
                function()
                    --[[
                      line: 134
                      upvalues:
                        lighting (copy, index: 1)
                        attributeName (copy, index: 2)
                        v53 (copy, index: 3)
                    ]]
                    lighting[attributeName] = v53
                end
            )
        end
    end

    local v54 = {}

    for _, child in instance2:GetChildren() do
        if v10[child.ClassName] then
            v54[child.ClassName] = true
        end
    end

    for _, child in lighting:GetChildren() do
        if v12[child] and v54[child.ClassName] then
            child.Parent = coreLightingStash
            table.insert(v14, child)
        end
    end

    for _, child in instance2:GetChildren() do
        if v10[child.ClassName] then
            local child2 = child:Clone()
            child2.Parent = lighting
            table.insert(v13, child2)
        end
    end
end

local function landed()
    --[[
      name: landed
      line: 161
      upvalues:
        localPlayer (copy, index: 1)
        workspace (copy, index: 2)
        Config (copy, index: 3)
    ]]
    if localPlayer:GetAttribute("State") ~= "Match" then
        local v63
        local v64 = if localPlayer:GetAttribute("State") == "Match" then localPlayer:GetAttribute("MatchId") else localPlayer:GetAttribute("Spectating")

        if type(v64) ~= "string" then
            v63 = ""
        else
            v63 = v64
        end

        if v63 ~= "" then
            local v65
            local child
            local v67 = if localPlayer:GetAttribute("State") == "Match" then localPlayer:GetAttribute("MatchId") else localPlayer:GetAttribute("Spectating")

            if type(v67) ~= "string" then
                v65 = ""
            else
                v65 = v67
            end

            if type(v65) ~= "string" then
                child = nil
            elseif v65 ~= "" then
                local arenas = workspace:FindFirstChild("Arenas")
                child = arenas and arenas:FindFirstChild(v65)
            else
                child = nil
            end

            local ringCenterX = child and child:GetAttribute("RingCenterX")
            local ringCenterZ = child and child:GetAttribute("RingCenterZ")
            local camera = workspace.CurrentCamera

            if type(ringCenterX) ~= "number" or type(ringCenterZ) ~= "number" or not camera then
                return false
            end

            local position = camera.CFrame.Position

            return Vector2.new(position.X - ringCenterX, position.Z - ringCenterZ).Magnitude < 600
        end
    end

    local instance = localPlayer.Character
    instance = instance and instance:FindFirstChild("HumanoidRootPart")

    if not instance or not instance:IsA("BasePart") then
        return false
    end

    local v74, v75
    local position = instance.Position

    if localPlayer:GetAttribute("State") ~= "Match" then
        return Vector2.new(position.X - Config.LOBBY_CENTER.X, position.Z - Config.LOBBY_CENTER.Z).Magnitude < Config.LOBBY_HALF_SIZE + 200
    end

    local v77 = localPlayer:GetAttribute("MatchId")

    if type(v77) ~= "string" or v77 == "" then
        v74 = nil
    else
        v74 = if const arenas = workspace:FindFirstChild("Arenas") then arenas:FindFirstChild(v77) else v75
    end

    local ringCenterX = v74 and v74:GetAttribute("RingCenterX")
    v75 = v74

    if v75 then
        v74 = v74:GetAttribute("RingCenterZ")
    else
        v74 = v75
    end

    if type(ringCenterX) == "number" and type(v74) == "number" then
        return Vector2.new(position.X - ringCenterX, position.Z - v74).Magnitude < 600
    end

    return false
end

local function fade(tintColor: Color3, a82: number)
    --[[
      name: fade
      line: 189
      upvalues:
        tweenService (copy, index: 1)
        coreTransition (copy, index: 2)
    ]]
    local tween = tweenService:Create(coreTransition, TweenInfo.new(a82, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {TintColor = tintColor})
    tween:Play()

    return tween
end

local function refresh(a85: boolean)
    --[[
      name: refresh
      line: 195
      upvalues:
        wantedName (copy, index: 1)
        replicatedStorage (copy, index: 2)
        v15 (ref,  index: 3)
        instance (ref,  index: 4)
        coreTransition (copy, index: 5)
        count (ref,  index: 6)
        applyNow (copy, index: 7)
        fade (copy, index: 8)
        landed (copy, index: 9)
    ]]
    local childName = wantedName()
    local lighting = replicatedStorage:FindFirstChild("Lighting")
    local instance2 = if lighting and childName then lighting:FindFirstChild(childName) else nil

    if childName == v15 and instance2 == instance and not coreTransition.Enabled then
        return
    end

    count += 1
    local v89 = count
    local v90 = v15 ~= nil and childName ~= v15
    v15 = childName

    if a85 and v90 or coreTransition.Enabled then
        task.spawn(
            function()
                --[[
                  line: 210
                  upvalues:
                    coreTransition (copy, index: 1)
                    fade (copy, index: 2)
                    v89 (copy, index: 3)
                    count (ref,  index: 4)
                    landed (copy, index: 5)
                    applyNow (copy, index: 6)
                    childName (copy, index: 7)
                    replicatedStorage (copy, index: 8)
                ]]
                coreTransition.Enabled = true
                fade(Color3.new(0.05, 0.05, 0.06), 0.25).Completed:Wait()
                local v91 = os.clock() + 2.5

                while os.clock() < v91 and v89 == count do
                    if landed() then
                        break
                    end

                    task.wait(0.05)
                end

                if v89 ~= count then
                    return
                end

                local childName2 = childName
                local lighting = replicatedStorage:FindFirstChild("Lighting")
                local instance = if lighting and childName2 then lighting:FindFirstChild(childName2) else nil
                applyNow(instance)
                task.wait(0.1)

                if v89 ~= count then
                    return
                end

                fade(Color3.new(1, 1, 1), 0.45).Completed:Wait()

                if v89 == count then
                    coreTransition.Enabled = false
                end
            end
        )

        return
    end

    applyNow(instance2)
end

function v7.Current()
    --[[
      name: Current
      line: 233
      upvalues:
        v15 (ref, index: 1)
    ]]
    return v15
end

function v7.Start()
    --[[
      name: Start
      line: 237
      upvalues:
        attributeNames (copy, index: 1)
        lighting (copy, index: 2)
        v11 (copy, index: 3)
        v12 (copy, index: 4)
        coreTransition (copy, index: 5)
        refresh (copy, index: 6)
        localPlayer (copy, index: 7)
        replicatedStorage (copy, index: 8)
        workspace (copy, index: 9)
    ]]
    for _, v96 in attributeNames do
        local success, result = pcall(
            function()
                --[[
                  line: 239
                  upvalues:
                    lighting (copy, index: 1)
                    v96 (copy, index: 2)
                ]]
                return lighting[v96]
            end
        )
        if success then
            v11[v96] = result
        end
    end

    for _, child in lighting:GetChildren() do
        v12[child] = true
    end

    coreTransition.Parent = lighting
    refresh(false)
    localPlayer:GetAttributeChangedSignal("State"):Connect(
        function()
            --[[
              line: 252
              upvalues:
                refresh (copy, index: 1)
            ]]
            refresh(true)
        end
    )
    localPlayer:GetAttributeChangedSignal("MatchId"):Connect(
        function()
            --[[
              line: 255
              upvalues:
                refresh (copy, index: 1)
            ]]
            refresh(true)
        end
    )
    localPlayer:GetAttributeChangedSignal("Spectating"):Connect(
        function()
            --[[
              line: 258
              upvalues:
                refresh (copy, index: 1)
            ]]
            refresh(true)
        end
    )

    local function watchPresets(a102)
        --[[
          name: watchPresets
          line: 263
          upvalues:
            refresh (copy, index: 1)
        ]]
        a102.ChildAdded:Connect(
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

    if const lighting2 = replicatedStorage:FindFirstChild("Lighting") then
        lighting2.ChildAdded:Connect(
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
    else
        local childAddedConnection = nil

        childAddedConnection = replicatedStorage.ChildAdded:Connect(
            function(child: Instance)
                --[[
                  line: 274
                  upvalues:
                    childAddedConnection (ref,  index: 1)
                    refresh (copy, index: 2)
                ]]
                if child.Name == "Lighting" then
                    childAddedConnection:Disconnect()
                    child.ChildAdded:Connect(
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
            end
        )
    end

    task.spawn(
        function()
            --[[
              line: 281
              upvalues:
                workspace (copy, index: 1)
                localPlayer (copy, index: 2)
                refresh (copy, index: 3)
            ]]
            if const arenas = workspace:WaitForChild("Arenas", 60) then
                arenas.ChildAdded:Connect(
                    function(child: Instance)
                        --[[
                          line: 284
                          upvalues:
                            localPlayer (copy, index: 1)
                            refresh (copy, index: 2)
                        ]]
                        local v108
                        local name = child.Name
                        local v110 = if localPlayer:GetAttribute("State") == "Match" then localPlayer:GetAttribute("MatchId") else localPlayer:GetAttribute("Spectating")

                        if type(v110) ~= "string" then
                            v108 = ""
                        else
                            v108 = v110
                        end

                        if name == v108 then
                            task.defer(refresh, true)
                        end
                    end
                )
            end
        end
    )
end

return v7