local collectionService = game:GetService("CollectionService")
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local workspace = game:GetService("Workspace")
local v5 = {}
local localPlayer = players.LocalPlayer
local HudBridge = require(script.Parent.HudBridge)
local v8 = {TR_Replay = true, TR_ReplayHud = true, TR_ReplayFrame = true, TR_Loading = true, CombatHUD = true, CombatTouch = true, CharacterTouch = true}
local result = nil
local result2 = nil

task.spawn(
    function()
        --[[
          line: 40
          upvalues:
            replicatedStorage (copy, index: 1)
            result (ref,  index: 2)
            result2 (ref,  index: 3)
        ]]
        local shared = replicatedStorage:WaitForChild("Shared")
        local camera = shared:WaitForChild("Camera", 15)

        if camera and camera:IsA("ModuleScript") then
            local success, result3 = pcall(require, camera)

            if success and type(result3) == "table" then
                result = result3
            end
        end

        local sfx = shared:WaitForChild("Sfx", 15)

        if sfx and sfx:IsA("ModuleScript") then
            local success, result4 = pcall(require, sfx)

            if success and type(result4) == "table" then
                result2 = result4
            end
        end
    end
)

local v18 = nil

local function addHidden(a20, descendant: Instance)
    --[[
      name: addHidden
      line: 71
    ]]
    if not descendant:IsA("BasePart") and not descendant:IsA("Decal") then
        if descendant:IsA("Highlight") and descendant.Enabled then
            descendant.Enabled = false
            table.insert(a20.highlights, descendant)
        end
    else
        table.insert(a20.hidden, descendant)
        descendant.LocalTransparencyModifier = 1
    end
end

local function hideModel(a23, instance: Instance)
    --[[
      name: hideModel
      line: 81
      upvalues:
        addHidden (copy, index: 1)
    ]]
    if a23.models[instance] then
        return
    end

    a23.models[instance] = true

    for _, descendant in instance:GetDescendants() do
        addHidden(a23, descendant)
    end

    table.insert(
        a23.conns,
        instance.DescendantAdded:Connect(
            function(descendant: Instance)
                --[[
                  line: 89
                  upvalues:
                    addHidden (copy, index: 1)
                    a23 (copy, index: 2)
                ]]
                addHidden(a23, descendant)
            end
        )
    )
end

local function realFighters()
    --[[
      name: realFighters
      line: 94
      upvalues:
        players (copy, index: 1)
        collectionService (copy, index: 2)
        workspace (copy, index: 3)
    ]]
    local v29 = {}
    local v30 = {}

    for _, player in players:GetPlayers() do
        local character = player.Character

        if character and not v30[character] then
            v30[character] = true
            table.insert(v29, character)
        end
    end

    for _, tag in {"Combatant", "Bot"} do
        for _, instance in collectionService:GetTagged(tag) do
            if instance:IsA("Model") then
                if not v30[instance] and instance:IsDescendantOf(workspace) then
                    v30[instance] = true
                    table.insert(v29, instance)
                end
            end
        end
    end

    return v29
end

function v5.Active()
    --[[
      name: Active
      line: 115
      upvalues:
        v18 (ref, index: 1)
    ]]
    return v18 ~= nil
end

function v5.Enter(a38)
    --[[
      name: Enter
      line: 119
      upvalues:
        v18 (ref,  index: 1)
        workspace (copy, index: 2)
        localPlayer (copy, index: 3)
        v8 (copy, index: 4)
        HudBridge (copy, index: 5)
        result (ref,  index: 6)
        realFighters (copy, index: 7)
        hideModel (copy, index: 8)
        collectionService (copy, index: 9)
        players (copy, index: 10)
        result2 (ref,  index: 11)
    ]]
    if v18 then
        return
    end

    local camera = workspace.CurrentCamera
    local v40 = {camEnabled = true, guis = {}, hidden = {}, models = {}, highlights = {}, cameraType = camera.CameraType, fov = camera.FieldOfView, conns = {}}
    v18 = v40
    localPlayer:SetAttribute("ReplayPlaying", true)

    if const playerGui = localPlayer:FindFirstChildOfClass("PlayerGui") then
        for _, child in playerGui:GetChildren() do
            local v44 = v8[child.Name] or child.Name == "TR_HUD" and HudBridge.ui ~= nil

            if child:IsA("ScreenGui") then
                if child.Enabled and not v44 then
                    child.Enabled = false
                    table.insert(v40.guis, child)
                end
            end
        end
    end

    if result then
        pcall(
            function()
                --[[
                  line: 150
                  upvalues:
                    v40 (copy, index: 1)
                    result (ref,  index: 2)
                ]]
                v40.camEnabled = result.IsEnabled()
                result.PushMouseUnlock("Replay")
                result.SetEnabled(false)
            end
        )
    end

    camera.CameraType = Enum.CameraType.Scriptable

    for _, instance in realFighters() do
        hideModel(v40, instance)
    end

    table.insert(
        v40.conns,
        collectionService:GetInstanceAddedSignal("Combatant"):Connect(
            function(combatant: Instance)
                --[[
                  line: 161
                  upvalues:
                    v18 (ref,  index: 1)
                    v40 (copy, index: 2)
                    hideModel (copy, index: 3)
                ]]
                if v18 == v40 and combatant:IsA("Model") then
                    hideModel(v40, combatant)
                end
            end
        )
    )

    for _, player in players:GetPlayers() do
        table.insert(
            v40.conns,
            player.CharacterAdded:Connect(
                function(character: Model)
                    --[[
                      line: 167
                      upvalues:
                        v18 (ref,  index: 1)
                        v40 (copy, index: 2)
                        hideModel (copy, index: 3)
                    ]]
                    if v18 == v40 then
                        hideModel(v40, character)
                    end
                end
            )
        )
    end

    if result2 then
        pcall(result2.Duck, "Music", 0.35, a38)
        pcall(result2.Duck, "Ambient", 0.6, a38)
    end
end

function v5.Tick()
    --[[
      name: Tick
      line: 181
      upvalues:
        v18 (ref, index: 1)
    ]]
    local v51 = v18
    if not v51 then
        return
    end

    local hidden = v51.hidden
    local index = 1

    while index <= #hidden do
        local v54 = hidden[index]

        if v54.Parent == nil then
            hidden[index] = hidden[#hidden]
            hidden[#hidden] = nil
        else
            if v54.LocalTransparencyModifier ~= 1 then
                v54.LocalTransparencyModifier = 1
            end

            index += 1
        end
    end
end

function v5.Leave()
    --[[
      name: Leave
      line: 202
      upvalues:
        v18 (ref,  index: 1)
        workspace (copy, index: 2)
        result (ref,  index: 3)
        localPlayer (copy, index: 4)
    ]]
    local v55 = v18
    if not v55 then
        return
    end

    v18 = nil

    for _, conn in v55.conns do
        conn:Disconnect()
    end

    for _, v59 in v55.hidden do
        if v59.Parent then
            v59.LocalTransparencyModifier = 0
        end
    end

    for _, highlight in v55.highlights do
        if highlight.Parent then
            highlight.Enabled = true
        end
    end

    for _, v63 in v55.guis do
        if v63.Parent then
            v63.Enabled = true
        end
    end

    local camera = workspace.CurrentCamera
    camera.FieldOfView = v55.fov

    if result then
        pcall(
            function()
                --[[
                  line: 229
                  upvalues:
                    result (ref,  index: 1)
                    v55 (copy, index: 2)
                ]]
                result.SetEnabled(v55.camEnabled)
                result.PopMouseUnlock("Replay")
            end
        )
    end

    if not result or not v55.camEnabled then
        camera.CameraType = v55.cameraType
    end

    localPlayer:SetAttribute("ReplayPlaying", nil)
end

return v5