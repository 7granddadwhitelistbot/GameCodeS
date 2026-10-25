local Players_1 = game:GetService("Players")
local v1 = game:GetService("RunService")
local Workspace_upv_1 = game:GetService("Workspace")
local v2 = v1:IsStudio()
v1 = {}
local tbl_upv_1 = {"LuaSourceContainer", "JointInstance", "WeldConstraint", "NoCollisionConstraint", "Constraint", "BodyMover", "Sound", "Animator", "AnimationController", "HumanoidDescription", "Humanoid", "ForceField", "BillboardGui", "SurfaceGui", "ProximityPrompt", "ClickDetector", "Highlight", "ValueBase", "Configuration", "Backpack"}
local tbl_upv_2 = {"ParticleEmitter", "Trail", "Beam", "Light", "Fire", "Smoke", "Sparkles"}
local function isA(a1, a2)
    --[[
      name: isA
      line: 75
    ]]
    for _, value_1 in a2 do
        if not (a1:IsA(value_1)) then
            continue
        end
        return true
    end
    return false
end
local LocalPlayer_upv_1 = Players_1.LocalPlayer
local u1 = nil
local u2 = nil
local u3 = nil
local tbl_upv_3 = {}
local tbl_upv_4 = {}
local tbl_upv_5 = {}
local tbl_upv_6 = {}
local u4 = true
local tbl_upv_7 = {}
local tbl_upv_8 = {}
local tbl_upv_9 = {}
local tbl_upv_10 = {}
local u5 = true
local u6 = false
local u7 = nil
local u8 = 0
local u9 = Instance.new("BindableEvent")
local tbl_upv_11 = {maxMs = 0, jointsStripped = 0, frames = 0, props = 0, copies = 0, totalMs = 0, builds = 0, collisionResets = 0, hideWrites = 0, parts = 0}
v1.Changed = u9.Event
local function hideReal(a1, a2)
    --[[
      name: hideReal
      line: 124
      upvalues:
        tbl_upv_6 (copy, index: 1)
        tbl_upv_11 (copy, index: 2)
    ]]
    if a2 then
        tbl_upv_6[a1] = true
        if a1.LocalTransparencyModifier == 1 then
            return
        end
        a1.LocalTransparencyModifier = 1
        tbl_upv_11.hideWrites = tbl_upv_11.hideWrites + 1
    else
        tbl_upv_6[a1] = nil
        if not a1.Parent or a1.LocalTransparencyModifier == 0 then
            return
        end
        a1.LocalTransparencyModifier = 0
    end
end
local function prepCopy(a1, a2)
    --[[
      name: prepCopy
      line: 162
    ]]
    a1.Anchored = true
    a1.CanCollide = false
    a1.CanQuery = false
    a1.CanTouch = false
    a1.Massless = true
    a1.LocalTransparencyModifier = 0
    a1.CastShadow = a2.CastShadow
end
local function unmap(a1)
    --[[
      name: unmap
      line: 172
      upvalues:
        tbl_upv_3 (copy, index: 1)
        u4 (ref,  index: 2)
    ]]
    local v3 = tbl_upv_3[a1]
    if not v3 then
        return
    end
    tbl_upv_3[a1] = nil
    u4 = true
    for _, value_2 in a1:GetDescendants() do
        tbl_upv_3[value_2] = nil
    end
    v3:Destroy()
end
local function pair(a1, a2)
    --[[
      name: pair
      line: 187
      upvalues:
        tbl_upv_3 (copy, index: 1)
        pair (copy, index: 2)
    ]]
    tbl_upv_3[a1] = a2
    local v4 = a2:GetChildren()
    local tbl_12 = {}
    local v5 = 1
    local v6 = nil
    local v7 = nil
    for _, value_3 in a1:GetChildren() do
        v6 = nil
        for n_1 = v5, #v4 do
            v7 = v4[n_1]
            if tbl_12[v7] or v7.Name ~= value_3.Name or v7.ClassName ~= value_3.ClassName then
                continue
            end
            tbl_12[v7] = true
            if n_1 == v5 then
                v5 = v5 + 1
            end
            break
        end
        if v6 then
            pair(value_3, v6)
        end
    end
end
local function stripInstance(a1)
    --[[
      name: stripInstance
      line: 112
    ]]
    for _, value_4 in a1:GetTags() do
        a1:RemoveTag(value_4)
    end
    for key_1 in a1:GetAttributes() do
        if string.sub(key_1, 1, 3) ~= "RBX" then
            pcall(a1.SetAttribute, a1, key_1, nil)
        end
    end
end
local function noCollisions(a1)
    --[[
      name: noCollisions
      line: 145
      upvalues:
        tbl_upv_11 (copy, index: 1)
    ]]
    for _, value_5 in a1:GetDescendants() do
        if not (value_5:IsA("BasePart")) then
            continue
        end
        if value_5.CanCollide then
            value_5.CanCollide = false
            tbl_upv_11.collisionResets = tbl_upv_11.collisionResets + 1
        end
        if value_5.CanQuery then
            value_5.CanQuery = false
        end
        if value_5.CanTouch then
            value_5.CanTouch = false
        end
    end
end
local function clean(a1)
    --[[
      name: clean
      line: 213
      upvalues:
        tbl_upv_3 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        tbl_upv_11 (copy, index: 3)
        stripInstance (copy, index: 4)
        tbl_upv_2 (copy, index: 5)
    ]]
    local tbl_13 = {a1}
    for _, value_6 in a1:GetDescendants() do
        table.insert(tbl_13, value_6)
    end
    local v8 = nil
    local _ = nil
    for v13, value_7 in tbl_13 do
        local v9 = tbl_upv_3[value_7]
        if not (v9) then
            continue
        end
        if value_7.Name == "TribesHull" then
            if value_7:IsA("JointInstance") or value_7:IsA("WeldConstraint") or value_7:IsA("Constraint") then
                tbl_upv_11.jointsStripped = tbl_upv_11.jointsStripped + 1
            end
            tbl_upv_3[value_7] = nil
            for v14, value_8 in value_7:GetDescendants() do
                tbl_upv_3[value_8] = nil
            end
            if v9.Parent then
                v9:Destroy()
            end
        else
            for v15, value_9 in tbl_upv_1 do
                if value_7:IsA(value_9) then
                    v8 = true
                else
                    continue
                end
            end
            if v8 then
                if value_7:IsA("JointInstance") or value_7:IsA("WeldConstraint") or value_7:IsA("Constraint") then
                    tbl_upv_11.jointsStripped = tbl_upv_11.jointsStripped + 1
                end
                tbl_upv_3[value_7] = nil
                for v14, value_8 in value_7:GetDescendants() do
                    tbl_upv_3[value_8] = nil
                end
                if v9.Parent then
                    v9:Destroy()
                end
            else
                stripInstance(v9)
                if v9:IsA("BasePart") and value_7:IsA("BasePart") then
                    v9.Anchored = true
                    v9.CanCollide = false
                    v9.CanQuery = false
                    v9.CanTouch = false
                    v9.Massless = true
                    v9.LocalTransparencyModifier = 0
                    v9.CastShadow = value_7.CastShadow
                    continue
                end
                -- GenericForInit v10 = tbl_upv_2, nil, nil, v11, _
                -- GenericForNext _, v12 = v10(v11, [control])
                if v9:IsA(v12) then
                    v8 = true
                else
                    -- GenericForNext _, v12 = v10(v11, [control])
                end
                if v8 then
                    v9.Enabled = false
                    continue
                end
                if not (v9:IsA("Tool")) then
                    continue
                end
                v8 = Instance.new("Model")
                v8.Name = v9.Name
                for v16, value_10 in v9:GetChildren() do
                    value_10.Parent = v8
                end
                v8.Parent = v9.Parent
                tbl_upv_3[value_7] = v8
                v9:Destroy()
            end
        end
    end
end
local function add(a1)
    --[[
      name: add
      line: 257
      upvalues:
        tbl_upv_3 (copy, index: 1)
        u1 (ref,  index: 2)
        u2 (ref,  index: 3)
        tbl_upv_1 (copy, index: 4)
        pair (copy, index: 5)
        clean (copy, index: 6)
        noCollisions (copy, index: 7)
        u4 (ref,  index: 8)
    ]]
    local v13
    if tbl_upv_3[a1] or not u1 or not u2 then
        return
    end
    local Parent_1 = a1.Parent
    if not Parent_1 or not tbl_upv_3[Parent_1] or a1.Name == "TribesHull" then
        return
    end
    for _, value_11 in tbl_upv_1 do
        if a1:IsA(value_11) then
            v13 = true
        else
            continue
        end
    end
    if v13 or not a1.Archivable then
        return
    end
    local success_1, v14 = pcall(
        function()
            --[[
              line: 272
              upvalues:
                a1 (copy, index: 1)
            ]]
            return a1:Clone()
        end
    )
    if not success_1 then
        return
    end
    if v14 then
        pair(a1, v14)
        clean(a1)
        local v15 = tbl_upv_3[a1]
        if v15 then
            v15.Parent = Parent_1
            if u1 and u1.Parent then
                noCollisions(u1)
            end
        end
        u4 = true
    end
end
local function rebuildLists()
    --[[
      name: rebuildLists
      line: 290
      upvalues:
        u4 (ref,  index: 1)
        tbl_upv_4 (copy, index: 2)
        tbl_upv_5 (copy, index: 3)
        tbl_upv_7 (copy, index: 4)
        tbl_upv_8 (copy, index: 5)
        tbl_upv_3 (copy, index: 6)
        tbl_upv_9 (copy, index: 7)
        tbl_upv_11 (copy, index: 8)
    ]]
    u4 = false
    table.clear(tbl_upv_4)
    table.clear(tbl_upv_5)
    table.clear(tbl_upv_7)
    table.clear(tbl_upv_8)
    for key_2, value_12 in tbl_upv_3 do
        if not (key_2:IsA("BasePart")) or not (value_12:IsA("BasePart")) then
            if not (key_2:IsA("Decal")) then
                continue
            end
            if value_12:IsA("Decal") then
                table.insert(tbl_upv_5, {t = -1, real = key_2, copy = value_12})
                continue
            end
        end
        if not (key_2.Parent) then
            continue
        end
        if value_12.Parent then
            table.insert(tbl_upv_4, {t = -1, real = key_2, copy = value_12, color = value_12.Color, mat = value_12.Material})
            table.insert(tbl_upv_7, key_2)
            table.insert(tbl_upv_8, value_12)
        end
    end
    table.clear(tbl_upv_9)
    tbl_upv_11.parts = #tbl_upv_7
    tbl_upv_11.copies = #tbl_upv_8
end
local function disconnectAll()
    --[[
      name: disconnectAll
      line: 312
      upvalues:
        tbl_upv_10 (copy, index: 1)
    ]]
    for _, value_13 in tbl_upv_10 do
        value_13:Disconnect()
    end
    table.clear(tbl_upv_10)
end
local function unhideAll()
    --[[
      name: unhideAll
      line: 320
      upvalues:
        tbl_upv_6 (copy, index: 1)
    ]]
    for key_3 in tbl_upv_6 do
        if key_3.Parent then
            key_3.LocalTransparencyModifier = 0
        end
    end
    table.clear(tbl_upv_6)
end
local function destroy()
    --[[
      name: destroy
      line: 329
      upvalues:
        tbl_upv_10 (copy, index: 1)
        tbl_upv_6 (copy, index: 2)
        u1 (ref,  index: 3)
        u2 (ref,  index: 4)
        u3 (ref,  index: 5)
        tbl_upv_3 (copy, index: 6)
        u4 (ref,  index: 7)
        rebuildLists (copy, index: 8)
        u6 (ref,  index: 9)
        u9 (copy, index: 10)
    ]]
    for _, value_14 in tbl_upv_10 do
        value_14:Disconnect()
    end
    table.clear(tbl_upv_10)
    for key_4 in tbl_upv_6 do
        if key_4.Parent then
            key_4.LocalTransparencyModifier = 0
        end
    end
    table.clear(tbl_upv_6)
    if u1 then
        u1:Destroy()
    end
    u1 = nil
    u2 = nil
    u3 = nil
    table.clear(tbl_upv_3)
    u4 = true
    rebuildLists()
    if not u6 then
        return
    end
    u6 = false
    u9:Fire(nil)
end
local function build(a1, a2)
    --[[
      name: build
      line: 345
      upvalues:
        destroy (copy, index: 1)
        u2 (ref,  index: 2)
        u3 (ref,  index: 3)
        u1 (ref,  index: 4)
        tbl_upv_3 (copy, index: 5)
        add (copy, index: 6)
        tbl_upv_10 (copy, index: 7)
        tbl_upv_11 (copy, index: 8)
        u6 (ref,  index: 9)
        tbl_upv_6 (copy, index: 10)
        u4 (ref,  index: 11)
    ]]
    destroy()
    local v16 = Instance.new("Model")
    v16.Name = "TribesDrawnBody"
    u2 = a1
    u3 = a2
    u1 = v16
    tbl_upv_3[a1] = v16
    for _, value_15 in a1:GetChildren() do
        add(value_15)
    end
    local v17 = Instance.new("Humanoid")
    local v18 = a1:FindFirstChildOfClass("Humanoid")
    local v19
    if v18 then
        v19 = v18.RigType
    else
        v19 = Enum.HumanoidRigType.R15
    end
    v17.RigType = v19
    v17.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
    v17.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
    v17.RequiresNeck = false
    v17.BreakJointsOnDeath = false
    v17.AutomaticScalingEnabled = false
    v17.EvaluateStateMachine = false
    v17.Parent = v16
    table.insert(
        tbl_upv_10,
        v16.DescendantAdded:Connect(
            function(a3)
                --[[
                  line: 365
                  upvalues:
                    tbl_upv_11 (copy, index: 1)
                ]]
                if not a3:IsA("JointInstance") and not a3:IsA("WeldConstraint") and not a3:IsA("Constraint") then
                    return
                end
                tbl_upv_11.jointsStripped = tbl_upv_11.jointsStripped + 1
                task.defer(
                    function()
                        --[[
                          line: 368
                          upvalues:
                            a3 (copy, index: 1)
                        ]]
                        if not a3.Parent then
                            return
                        end
                        a3:Destroy()
                    end
                )
            end
        )
    )
    table.insert(
        tbl_upv_10,
        a1.DescendantAdded:Connect(
            function(a4)
                --[[
                  line: 375
                  upvalues:
                    add (copy, index: 1)
                    u6 (ref,  index: 2)
                    tbl_upv_6 (copy, index: 3)
                    tbl_upv_11 (copy, index: 4)
                ]]
                add(a4)
                if not u6 or not a4:IsA("BasePart") and not a4:IsA("Decal") then
                    return
                end
                tbl_upv_6[a4] = true
                if a4.LocalTransparencyModifier == 1 then
                    return
                end
                a4.LocalTransparencyModifier = 1
                tbl_upv_11.hideWrites = tbl_upv_11.hideWrites + 1
            end
        )
    )
    table.insert(
        tbl_upv_10,
        a1.DescendantRemoving:Connect(
            function(a5)
                --[[
                  line: 381
                  upvalues:
                    tbl_upv_6 (copy, index: 1)
                    tbl_upv_3 (copy, index: 2)
                    u4 (ref,  index: 3)
                ]]
                if tbl_upv_6[a5] then
                    tbl_upv_6[a5] = nil
                    pcall(
                        function()
                            --[[
                              line: 385
                              upvalues:
                                a5 (copy, index: 1)
                            ]]
                            a5.LocalTransparencyModifier = 0
                        end
                    )
                end
                local v20 = tbl_upv_3[a5]
                if not v20 then
                    return
                end
                tbl_upv_3[a5] = nil
                u4 = true
                for _, value_16 in a5:GetDescendants() do
                    tbl_upv_3[value_16] = nil
                end
                v20:Destroy()
            end
        )
    )
    tbl_upv_11.builds = tbl_upv_11.builds + 1
    u4 = true
end
local function parentFor()
    --[[
      name: parentFor
      line: 395
      upvalues:
        Workspace_upv_1 (copy, index: 1)
    ]]
    return Workspace_upv_1.CurrentCamera
end
local function setShown(a1)
    --[[
      name: setShown
      line: 400
      upvalues:
        u1 (ref,  index: 1)
        u2 (ref,  index: 2)
        u6 (ref,  index: 3)
        Workspace_upv_1 (copy, index: 4)
        noCollisions (copy, index: 5)
        tbl_upv_6 (copy, index: 6)
        tbl_upv_11 (copy, index: 7)
        LocalPlayer_upv_1 (copy, index: 8)
        u9 (copy, index: 9)
    ]]
    local v21 = u2
    if not (u1) or not (v21) then
        a1 = false
    end
    if a1 ~= u6 then
        u6 = a1
        if a1 then
            u1.Parent = Workspace_upv_1.CurrentCamera
            noCollisions(u1)
            for _, value_17 in u2:GetDescendants() do
                if value_17:IsA("BasePart") or value_17:IsA("Decal") then
                    tbl_upv_6[value_17] = true
                    if value_17.LocalTransparencyModifier ~= 1 then
                        value_17.LocalTransparencyModifier = 1
                        tbl_upv_11.hideWrites = tbl_upv_11.hideWrites + 1
                    end
                end
            end
        else
            if u1 then
                u1.Parent = nil
            end
            if LocalPlayer_upv_1:GetAttribute("ReplayPlaying") ~= true then
                for key_5 in tbl_upv_6 do
                    if key_5.Parent then
                        key_5.LocalTransparencyModifier = 0
                    end
                end
            end
            table.clear(tbl_upv_6)
        end
        local v22
        if a1 then
            v22 = u1
        else
            v22 = nil
        end
        u9:Fire(v22)
    end
end
function v1.Render(a1, a2)
    --[[
      name: Render
      line: 434
      upvalues:
        u2 (ref,  index: 1)
        u3 (ref,  index: 2)
        u7 (ref,  index: 3)
        u8 (ref,  index: 4)
        build (copy, index: 5)
        destroy (copy, index: 6)
        u5 (ref,  index: 7)
        u1 (ref,  index: 8)
        LocalPlayer_upv_1 (copy, index: 9)
        setShown (copy, index: 10)
        u6 (ref,  index: 11)
        Workspace_upv_1 (copy, index: 12)
        noCollisions (copy, index: 13)
        u4 (ref,  index: 14)
        rebuildLists (copy, index: 15)
        tbl_upv_4 (copy, index: 16)
        tbl_upv_9 (copy, index: 17)
        tbl_upv_11 (copy, index: 18)
        tbl_upv_5 (copy, index: 19)
        tbl_upv_8 (copy, index: 20)
    ]]
    local v23 = os.clock()
    local v24
    if a1 then
        v24 = a1.Parent
    else
        v24 = nil
    end
    if a1 and v24 and v24:IsA("Model") then
        if v24 ~= u2 then
            if a1 ~= u7 or os.clock() - u8 > 5 then
                local success_2, v25 = pcall(build, v24, a1)
                if not (success_2) then
                    local v26 = os.clock()
                    u7 = a1
                    u8 = v26
                    destroy()
                    warn("[BodyProxy] build failed, the real body is shown: " .. tostring(v25))
                end
            elseif not (a1) and u2 then
                destroy()
            end
        elseif a1 ~= u3 and (a1 ~= u7 or os.clock() - u8 > 5) then
            local success_2, v25 = pcall(build, v24, a1)
            if not (success_2) then
                local v26 = os.clock()
                u7 = a1
                u8 = v26
                destroy()
                warn("[BodyProxy] build failed, the real body is shown: " .. tostring(v25))
            end
        elseif not (a1) and u2 then
            destroy()
        end
    elseif not (a1) and u2 then
        destroy()
    end
    local v27 = u5 and ((a2 ~= nil) and ((u1 ~= nil) and (LocalPlayer_upv_1:GetAttribute("ReplayPlaying") ~= true)))
    setShown(v27)
    if not u6 or not a2 or not u3 then
        return
    end
    if u1.Parent ~= Workspace_upv_1.CurrentCamera then
        u1.Parent = Workspace_upv_1.CurrentCamera
        noCollisions(u1)
    end
    if u4 then
        rebuildLists()
    end
    local v28 = a2 * u3.CFrame:Inverse()
    for key_6, value_18 in tbl_upv_4 do
        local real_1 = value_18.real
        tbl_upv_9[key_6] = v28 * real_1.CFrame
        local copy_1 = value_18.copy
        if copy_1.CanCollide then
            copy_1.CanCollide = false
            copy_1.CanQuery = false
            tbl_upv_11.collisionResets = tbl_upv_11.collisionResets + 1
        end
        local Transparency_1 = real_1.Transparency
        if Transparency_1 ~= value_18.t then
            value_18.t = Transparency_1
            value_18.copy.Transparency = Transparency_1
            tbl_upv_11.props = tbl_upv_11.props + 1
        end
        local Color_1 = real_1.Color
        if Color_1 ~= value_18.color then
            value_18.color = Color_1
            value_18.copy.Color = Color_1
            tbl_upv_11.props = tbl_upv_11.props + 1
        end
        local Material_1 = real_1.Material
        if Material_1 ~= value_18.mat then
            value_18.mat = Material_1
            value_18.copy.Material = Material_1
            tbl_upv_11.props = tbl_upv_11.props + 1
        end
    end
    for _, value_19 in tbl_upv_5 do
        local Transparency_2 = value_19.real.Transparency
        if Transparency_2 ~= value_19.t then
            value_19.t = Transparency_2
            value_19.copy.Transparency = Transparency_2
        end
    end
    if #tbl_upv_8 > 0
        and not (pcall(
            function()
                --[[
                  line: 500
                  upvalues:
                    Workspace_upv_1 (copy, index: 1)
                    tbl_upv_8 (copy, index: 2)
                    tbl_upv_9 (copy, index: 3)
                ]]
                Workspace_upv_1:BulkMoveTo(tbl_upv_8, tbl_upv_9, Enum.BulkMoveMode.FireCFrameChanged)
            end
        )) then
        u4 = true
    end
    tbl_upv_11.frames = tbl_upv_11.frames + 1
    local v29 = (os.clock() - v23) * 1000
    tbl_upv_11.totalMs = tbl_upv_11.totalMs + v29
    if not (tbl_upv_11.maxMs < v29) then
        return
    end
    tbl_upv_11.maxMs = v29
end
function v1.EnforceHidden()
    --[[
      name: EnforceHidden
      line: 518
      upvalues:
        u6 (ref,  index: 1)
        tbl_upv_6 (copy, index: 2)
        tbl_upv_11 (copy, index: 3)
    ]]
    if not u6 then
        return
    end
    for key_7 in tbl_upv_6 do
        if key_7.LocalTransparencyModifier == 1 then
            continue
        end
        if key_7.Parent then
            key_7.LocalTransparencyModifier = 1
            tbl_upv_11.hideWrites = tbl_upv_11.hideWrites + 1
        else
            tbl_upv_6[key_7] = nil
        end
    end
end
function v1.SetEnabled(a1)
    --[[
      name: SetEnabled
      line: 535
      upvalues:
        u5 (ref,  index: 1)
        setShown (copy, index: 2)
    ]]
    u5 = a1 == true
    if (u5) then
        return
    end
    setShown(false)
end
function v1.IsShown()
    --[[
      name: IsShown
      line: 542
      upvalues:
        u6 (ref, index: 1)
    ]]
    return u6
end
function v1.Model()
    --[[
      name: Model
      line: 547
      upvalues:
        u6 (ref, index: 1)
        u1 (ref, index: 2)
    ]]
    if u6 then
        return u1
    end
    return nil
end
function v1.Drawn(a1)
    --[[
      name: Drawn
      line: 553
      upvalues:
        u6 (ref,  index: 1)
        tbl_upv_3 (copy, index: 2)
    ]]
    if a1 and u6 then
        return tbl_upv_3[a1] or a1
    end
    return a1
end
function v1.Stats()
    --[[
      name: Stats
      line: 560
      upvalues:
        u6 (ref,  index: 1)
        tbl_upv_11 (copy, index: 2)
    ]]
    local tbl_14 = {proxyCollisionResets = 0, proxyAvgMs = 0}
    tbl_14.proxyShown = u6
    tbl_14.proxyBuilds = tbl_upv_11.builds
    tbl_14.proxyParts = tbl_upv_11.parts
    tbl_14.proxyFrames = tbl_upv_11.frames
    tbl_14.proxyJointsStripped = tbl_upv_11.jointsStripped
    tbl_14.proxyHideWrites = tbl_upv_11.hideWrites
    tbl_14.proxyPropCopies = tbl_upv_11.props
    tbl_14.proxyMaxMs = math.floor(tbl_upv_11.maxMs * 1000) / 1000
    tbl_14.proxyAvgMs = tbl_upv_11.frames > 0 and math.floor((tbl_upv_11.totalMs / tbl_upv_11.frames) * 10000) / 10000 or 0
    tbl_14.proxyCollisionResets = tbl_upv_11.collisionResets
    return tbl_14
end
if v2 then
    function v1.DebugMap()
        --[[
          name: DebugMap
          line: 577
          upvalues:
            tbl_upv_3 (copy, index: 1)
        ]]
        local tbl_15 = {decals = 0, other = 0, attachments = 0, parts = 0}
        for key_8 in tbl_upv_3 do
            if key_8:IsA("BasePart") then
                tbl_15.parts = tbl_15.parts + 1
                continue
            end
            if key_8:IsA("Decal") then
                tbl_15.decals = tbl_15.decals + 1
                continue
            end
            if key_8:IsA("Attachment") then
                tbl_15.attachments = tbl_15.attachments + 1
            else
                tbl_15.other = tbl_15.other + 1
            end
        end
        return tbl_15
    end
end
return v1