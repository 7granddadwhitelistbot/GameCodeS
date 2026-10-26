local CollectionService_upv_1 = game:GetService("CollectionService")
local Players_upv_1 = game:GetService("Players")
local ReplicatedStorage_upv_1 = game:GetService("ReplicatedStorage")
local Workspace_upv_1 = game:GetService("Workspace")
local tbl_1 = {}
local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
local HudBridge_upv_1 = require(script.Parent.HudBridge)
local tbl_upv_2 = {CharacterTouch = true, TR_ReplayFrame = true, TR_ReplayHud = true, CombatTouch = true, TR_Loading = true, TR_Replay = true, CombatHUD = true}
local u1 = nil
local u2 = nil
task.spawn(
    function()
        --[[
          line: 40
          upvalues:
            ReplicatedStorage_upv_1 (copy, index: 1)
            u1 (ref,  index: 2)
            u2 (ref,  index: 3)
        ]]
        local Shared_1 = ReplicatedStorage_upv_1:WaitForChild("Shared")
        local v1 = Shared_1:WaitForChild("Camera", 15)
        if v1 and v1:IsA("ModuleScript") then
            local success_1, v2 = pcall(require, v1)
            if success_1 and type(v2) == "table" then
                u1 = v2
            end
        end
        local v3 = Shared_1:WaitForChild("Sfx", 15)
        if not v3 then
            return
        end
        if v3:IsA("ModuleScript") then
            local success_2, v4 = pcall(require, v3)
            if not success_2 or type(v4) ~= "table" then
                return
            end
            u2 = v4
        end
    end
)
local u3 = nil
local function addHidden(a1, a2)
    --[[
      name: addHidden
      line: 71
    ]]
    if not (a2:IsA("BasePart")) and not (a2:IsA("Decal")) then
        if a2:IsA("Highlight") and a2.Enabled then
            a2.Enabled = false
            table.insert(a1.highlights, a2)
        end
        return
    end
    table.insert(a1.hidden, a2)
    a2.LocalTransparencyModifier = 1
end
local function realFighters()
    --[[
      name: realFighters
      line: 94
      upvalues:
        Players_upv_1 (copy, index: 1)
        CollectionService_upv_1 (copy, index: 2)
        Workspace_upv_1 (copy, index: 3)
    ]]
    local tbl_3 = {}
    local tbl_4 = {}
    for _, value_1 in Players_upv_1:GetPlayers() do
        local Character_1 = value_1.Character
        if not (Character_1) then
            continue
        end
        if not (tbl_4[Character_1]) then
            tbl_4[Character_1] = true
            table.insert(tbl_3, Character_1)
        end
    end
    for _, value_2 in {"Combatant", "Bot"} do
        for v1, value_3 in CollectionService_upv_1:GetTagged(value_2) do
            if not (value_3:IsA("Model")) or tbl_4[value_3] then
                continue
            end
            if value_3:IsDescendantOf(Workspace_upv_1) then
                tbl_4[value_3] = true
                table.insert(tbl_3, value_3)
            end
        end
    end
    return tbl_3
end
function tbl_1.Active()
    --[[
      name: Active
      line: 115
      upvalues:
        u3 (ref, index: 1)
    ]]
    local v5 = u3 ~= nil
    return v5
end
local function hideModel(a1, a2)
    --[[
      name: hideModel
      line: 81
      upvalues:
        addHidden (copy, index: 1)
    ]]
    if a1.models[a2] then
        return
    end
    a1.models[a2] = true
    for _, value_4 in a2:GetDescendants() do
        addHidden(a1, value_4)
    end
    table.insert(
        a1.conns,
        a2.DescendantAdded:Connect(
            function(a3)
                --[[
                  line: 89
                  upvalues:
                    addHidden (copy, index: 1)
                    a1 (copy, index: 2)
                ]]
                addHidden(a1, a3)
            end
        )
    )
end
function tbl_1.Enter(a1)
    --[[
      name: Enter
      line: 119
      upvalues:
        u3 (ref,  index: 1)
        Workspace_upv_1 (copy, index: 2)
        LocalPlayer_upv_1 (copy, index: 3)
        tbl_upv_2 (copy, index: 4)
        HudBridge_upv_1 (copy, index: 5)
        u1 (ref,  index: 6)
        realFighters (copy, index: 7)
        hideModel (copy, index: 8)
        CollectionService_upv_1 (copy, index: 9)
        Players_upv_1 (copy, index: 10)
        u2 (ref,  index: 11)
    ]]
    if u3 then
        return
    end
    local CurrentCamera_1 = Workspace_upv_1.CurrentCamera
    local tbl_upv_5 = {camEnabled = true}
    tbl_upv_5.guis = {}
    tbl_upv_5.hidden = {}
    tbl_upv_5.models = {}
    tbl_upv_5.highlights = {}
    tbl_upv_5.cameraType = CurrentCamera_1.CameraType
    tbl_upv_5.fov = CurrentCamera_1.FieldOfView
    tbl_upv_5.conns = {}
    u3 = tbl_upv_5
    LocalPlayer_upv_1:SetAttribute("ReplayPlaying", true)
    local v6 = LocalPlayer_upv_1:FindFirstChildOfClass("PlayerGui")
    if v6 then
        for _, value_5 in v6:GetChildren() do
            local v7 = tbl_upv_2[value_5.Name] or ((value_5.Name == "TR_HUD") and (HudBridge_upv_1.ui ~= nil))
            if not (value_5:IsA("ScreenGui")) or not (value_5.Enabled) then
                continue
            end
            if not (v7) then
                value_5.Enabled = false
                table.insert(tbl_upv_5.guis, value_5)
            end
        end
    end
    if u1 then
        pcall(
            function()
                --[[
                  line: 150
                  upvalues:
                    tbl_upv_5 (copy, index: 1)
                    u1 (ref,  index: 2)
                ]]
                tbl_upv_5.camEnabled = u1.IsEnabled()
                u1.PushMouseUnlock("Replay")
                u1.SetEnabled(false)
            end
        )
    end
    CurrentCamera_1.CameraType = Enum.CameraType.Scriptable
    for _, value_6 in realFighters() do
        hideModel(tbl_upv_5, value_6)
    end
    table.insert(
        tbl_upv_5.conns,
        CollectionService_upv_1:GetInstanceAddedSignal("Combatant"):Connect(
            function(a2)
                --[[
                  line: 161
                  upvalues:
                    u3 (ref,  index: 1)
                    tbl_upv_5 (copy, index: 2)
                    hideModel (copy, index: 3)
                ]]
                if u3 ~= tbl_upv_5 or not a2:IsA("Model") then
                    return
                end
                hideModel(tbl_upv_5, a2)
            end
        )
    )
    for _, value_7 in Players_upv_1:GetPlayers() do
        table.insert(
            tbl_upv_5.conns,
            value_7.CharacterAdded:Connect(
                function(a3)
                    --[[
                      line: 167
                      upvalues:
                        u3 (ref,  index: 1)
                        tbl_upv_5 (copy, index: 2)
                        hideModel (copy, index: 3)
                    ]]
                    if u3 ~= tbl_upv_5 then
                        return
                    end
                    hideModel(tbl_upv_5, a3)
                end
            )
        )
    end
    if not u2 then
        return
    end
    pcall(u2.Duck, "Music", 0.35, a1)
    pcall(u2.Duck, "Ambient", 0.6, a1)
end
function tbl_1.Tick()
    --[[
      name: Tick
      line: 181
      upvalues:
        u3 (ref, index: 1)
    ]]
    if not u3 then
        return
    end
    local hidden_1 = u3.hidden
    local v8 = 1
    while v8 <= #hidden_1 do
        local v9 = hidden_1[v8]
        if v9.Parent == nil then
            hidden_1[v8] = hidden_1[#hidden_1]
            hidden_1[#hidden_1] = nil
            continue
        end
        if v9.LocalTransparencyModifier ~= 1 then
            v9.LocalTransparencyModifier = 1
        end
        v8 = v8 + 1
    end
end
function tbl_1.Leave()
    --[[
      name: Leave
      line: 202
      upvalues:
        u3 (ref,  index: 1)
        Workspace_upv_1 (copy, index: 2)
        u1 (ref,  index: 3)
        LocalPlayer_upv_1 (copy, index: 4)
    ]]
    if not u3 then
        return
    end
    u3 = nil
    for _, value_8 in u3.conns do
        value_8:Disconnect()
    end
    for _, value_9 in u3.hidden do
        if value_9.Parent then
            value_9.LocalTransparencyModifier = 0
        end
    end
    for _, value_10 in u3.highlights do
        if value_10.Parent then
            value_10.Enabled = true
        end
    end
    for _, value_11 in u3.guis do
        if value_11.Parent then
            value_11.Enabled = true
        end
    end
    local CurrentCamera_2 = Workspace_upv_1.CurrentCamera
    CurrentCamera_2.FieldOfView = u3.fov
    if u1 then
        pcall(
            function()
                --[[
                  line: 229
                  upvalues:
                    u1 (ref,  index: 1)
                    u3 (copy, index: 2)
                ]]
                u1.SetEnabled(u3.camEnabled)
                u1.PopMouseUnlock("Replay")
            end
        )
    end
    if not (u1) or not (u3.camEnabled) then
        CurrentCamera_2.CameraType = u3.cameraType
    end
    LocalPlayer_upv_1:SetAttribute("ReplayPlaying", nil)
end
return tbl_1