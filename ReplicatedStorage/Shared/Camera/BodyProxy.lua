local Players_1 = game:GetService("Players")
local RunService_1 = game:GetService("RunService")
local Workspace_upv_1 = game:GetService("Workspace")
local v1 = RunService_1:IsStudio()
local tbl_1 = {}
local tbl_upv_2 = {"LuaSourceContainer", "JointInstance", "WeldConstraint", "NoCollisionConstraint", "Constraint", "BodyMover", "Sound", "Animator", "AnimationController", "HumanoidDescription", "Humanoid", "ForceField", "BillboardGui", "SurfaceGui", "ProximityPrompt", "ClickDetector", "Highlight", "ValueBase", "Configuration", "Backpack"}
local tbl_upv_3 = {"ParticleEmitter", "Trail", "Beam", "Light", "Fire", "Smoke", "Sparkles"}
local function isA(a1, a2)
    --[[
      name: isA
      line: 84
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
local tbl_upv_4 = {}
local tbl_upv_5 = {}
local tbl_upv_6 = {}
local tbl_upv_7 = {}
local u4 = true
local tbl_upv_8 = {}
local tbl_upv_9 = {}
local tbl_upv_10 = {}
local tbl_upv_11 = {}
local u5 = true
local u6 = false
local u7 = nil
local u8 = 0
local u9 = Instance.new("BindableEvent")
local tbl_upv_12 = {maxMs = 0, jointsStripped = 0, frames = 0, props = 0, copies = 0, totalMs = 0, builds = 0, collisionResets = 0, hideWrites = 0, parts = 0}
tbl_1.Changed = u9.Event
local function hideReal(a1, a2)
    --[[
      name: hideReal
      line: 133
      upvalues:
        tbl_upv_7 (copy, index: 1)
        tbl_upv_12 (copy, index: 2)
    ]]
    if a2 then
        tbl_upv_7[a1] = true
        if a1.LocalTransparencyModifier == 1 then
            return
        end
        a1.LocalTransparencyModifier = 1
        tbl_upv_12.hideWrites = tbl_upv_12.hideWrites + 1
    else
        tbl_upv_7[a1] = nil
        if not a1.Parent or a1.LocalTransparencyModifier == 0 then
            return
        end
        a1.LocalTransparencyModifier = 0
    end
end
local function prepCopy(a1, a2)
    --[[
      name: prepCopy
      line: 171
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
      line: 181
      upvalues:
        tbl_upv_4 (copy, index: 1)
        u4 (ref,  index: 2)
    ]]
    local v2 = tbl_upv_4[a1]
    if not v2 then
        return
    end
    tbl_upv_4[a1] = nil
    u4 = true
    for _, value_2 in a1:GetDescendants() do
        tbl_upv_4[value_2] = nil
    end
    v2:Destroy()
end
local function pair(a1, a2)
    --[[
      name: pair
      line: 196
      upvalues:
        tbl_upv_4 (copy, index: 1)
        pair (copy, index: 2)
    ]]
    tbl_upv_4[a1] = a2
    local v3 = a2:GetChildren()
    local tbl_13 = {}
    local v4 = 1
    local v5 = nil
    local v6 = nil
    for _, value_3 in a1:GetChildren() do
        v5 = nil
        for n_1 = v4, #v3 do
            v6 = v3[n_1]
            if tbl_13[v6] or v6.Name ~= value_3.Name or v6.ClassName ~= value_3.ClassName then
                continue
            end
            tbl_13[v6] = true
            if n_1 == v4 then
                v4 = v4 + 1
            end
            break
        end
        if v5 then
            pair(value_3, v5)
        end
    end
end
local function stripInstance(a1)
    --[[
      name: stripInstance
      line: 121
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
      line: 154
      upvalues:
        tbl_upv_12 (copy, index: 1)
    ]]
    for _, value_5 in a1:GetDescendants() do
        if not (value_5:IsA("BasePart")) then
            continue
        end
        if value_5.CanCollide then
            value_5.CanCollide = false
            tbl_upv_12.collisionResets = tbl_upv_12.collisionResets + 1
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
      line: 222
      upvalues:
        tbl_upv_4 (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
        tbl_upv_12 (copy, index: 3)
        stripInstance (copy, index: 4)
        tbl_upv_3 (copy, index: 5)
    ]]
    local tbl_14 = {a1}
    for _, value_6 in a1:GetDescendants() do
        table.insert(tbl_14, value_6)
    end
    local v7 = nil
    local _ = nil
    for v12, value_7 in tbl_14 do
        local v8 = tbl_upv_4[value_7]
        if not (v8) then
            continue
        end
        if value_7.Name == "TribesHull" or value_7.Name == "TribesBubbleAnchor" then
            if value_7:IsA("JointInstance") or value_7:IsA("WeldConstraint") or value_7:IsA("Constraint") then
                tbl_upv_12.jointsStripped = tbl_upv_12.jointsStripped + 1
            end
            tbl_upv_4[value_7] = nil
            for v13, value_8 in value_7:GetDescendants() do
                tbl_upv_4[value_8] = nil
            end
            if v8.Parent then
                v8:Destroy()
            end
        else
            for v14, value_9 in tbl_upv_2 do
                if value_7:IsA(value_9) then
                    v7 = true
                else
                    continue
                end
            end
            if v7 then
                if value_7:IsA("JointInstance") or value_7:IsA("WeldConstraint") or value_7:IsA("Constraint") then
                    tbl_upv_12.jointsStripped = tbl_upv_12.jointsStripped + 1
                end
                tbl_upv_4[value_7] = nil
                for v13, value_8 in value_7:GetDescendants() do
                    tbl_upv_4[value_8] = nil
                end
                if v8.Parent then
                    v8:Destroy()
                end
            else
                stripInstance(v8)
                if v8:IsA("BasePart") and value_7:IsA("BasePart") then
                    v8.Anchored = true
                    v8.CanCollide = false
                    v8.CanQuery = false
                    v8.CanTouch = false
                    v8.Massless = true
                    v8.LocalTransparencyModifier = 0
                    v8.CastShadow = value_7.CastShadow
                    continue
                end
                -- GenericForInit v9 = tbl_upv_3, nil, nil, v10, _
                -- GenericForNext _, v11 = v9(v10, [control])
                if v8:IsA(v11) then
                    v7 = true
                else
                    -- GenericForNext _, v11 = v9(v10, [control])
                end
                if v7 then
                    v8.Enabled = false
                    continue
                end
                if not (v8:IsA("Tool")) then
                    continue
                end
                v7 = Instance.new("Model")
                v7.Name = v8.Name
                for v15, value_10 in v8:GetChildren() do
                    value_10.Parent = v7
                end
                v7.Parent = v8.Parent
                tbl_upv_4[value_7] = v7
                v8:Destroy()
            end
        end
    end
end
local function add(a1)
    --[[
      name: add
      line: 266
      upvalues:
        tbl_upv_4 (copy, index: 1)
        u1 (ref,  index: 2)
        u2 (ref,  index: 3)
        tbl_upv_2 (copy, index: 4)
        pair (copy, index: 5)
        clean (copy, index: 6)
        noCollisions (copy, index: 7)
        u4 (ref,  index: 8)
    ]]
    local v12
    if tbl_upv_4[a1] or not u1 or not u2 then
        return
    end
    local Parent_1 = a1.Parent
    if not Parent_1 or not tbl_upv_4[Parent_1] or a1.Name == "TribesHull" or a1.Name == "TribesBubbleAnchor" then
        return
    end
    for _, value_11 in tbl_upv_2 do
        if a1:IsA(value_11) then
            v12 = true
        else
            continue
        end
    end
    if v12 or not a1.Archivable then
        return
    end
    local success_1, v13 = pcall(
        function()
            --[[
              line: 281
              upvalues:
                a1 (copy, index: 1)
            ]]
            return a1:Clone()
        end
    )
    if not success_1 then
        return
    end
    if v13 then
        pair(a1, v13)
        clean(a1)
        local v14 = tbl_upv_4[a1]
        if v14 then
            v14.Parent = Parent_1
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
      line: 299
      upvalues:
        u4 (ref,  index: 1)
        tbl_upv_5 (copy, index: 2)
        tbl_upv_6 (copy, index: 3)
        tbl_upv_8 (copy, index: 4)
        tbl_upv_9 (copy, index: 5)
        tbl_upv_4 (copy, index: 6)
        tbl_upv_10 (copy, index: 7)
        tbl_upv_12 (copy, index: 8)
    ]]
    u4 = false
    table.clear(tbl_upv_5)
    table.clear(tbl_upv_6)
    table.clear(tbl_upv_8)
    table.clear(tbl_upv_9)
    for key_2, value_12 in tbl_upv_4 do
        if not (key_2:IsA("BasePart")) or not (value_12:IsA("BasePart")) then
            if not (key_2:IsA("Decal")) then
                continue
            end
            if value_12:IsA("Decal") then
                table.insert(tbl_upv_6, {t = -1, real = key_2, copy = value_12})
                continue
            end
        end
        if not (key_2.Parent) then
            continue
        end
        if value_12.Parent then
            table.insert(tbl_upv_5, {t = -1, real = key_2, copy = value_12, color = value_12.Color, mat = value_12.Material})
            table.insert(tbl_upv_8, key_2)
            table.insert(tbl_upv_9, value_12)
        end
    end
    table.clear(tbl_upv_10)
    tbl_upv_12.parts = #tbl_upv_8
    tbl_upv_12.copies = #tbl_upv_9
end
local function disconnectAll()
    --[[
      name: disconnectAll
      line: 321
      upvalues:
        tbl_upv_11 (copy, index: 1)
    ]]
    for _, value_13 in tbl_upv_11 do
        value_13:Disconnect()
    end
    table.clear(tbl_upv_11)
end
local function unhideAll()
    --[[
      name: unhideAll
      line: 329
      upvalues:
        tbl_upv_7 (copy, index: 1)
    ]]
    for key_3 in tbl_upv_7 do
        if key_3.Parent then
            key_3.LocalTransparencyModifier = 0
        end
    end
    table.clear(tbl_upv_7)
end
local function destroy()
    --[[
      name: destroy
      line: 338
      upvalues:
        tbl_upv_11 (copy, index: 1)
        tbl_upv_7 (copy, index: 2)
        u1 (ref,  index: 3)
        u2 (ref,  index: 4)
        u3 (ref,  index: 5)
        tbl_upv_4 (copy, index: 6)
        u4 (ref,  index: 7)
        rebuildLists (copy, index: 8)
        u6 (ref,  index: 9)
        u9 (copy, index: 10)
    ]]
    for _, value_14 in tbl_upv_11 do
        value_14:Disconnect()
    end
    table.clear(tbl_upv_11)
    for key_4 in tbl_upv_7 do
        if key_4.Parent then
            key_4.LocalTransparencyModifier = 0
        end
    end
    table.clear(tbl_upv_7)
    if u1 then
        u1:Destroy()
    end
    u1 = nil
    u2 = nil
    u3 = nil
    table.clear(tbl_upv_4)
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
      line: 354
      upvalues:
        destroy (copy, index: 1)
        u2 (ref,  index: 2)
        u3 (ref,  index: 3)
        u1 (ref,  index: 4)
        tbl_upv_4 (copy, index: 5)
        add (copy, index: 6)
        tbl_upv_11 (copy, index: 7)
        tbl_upv_12 (copy, index: 8)
        u6 (ref,  index: 9)
        tbl_upv_7 (copy, index: 10)
        u4 (ref,  index: 11)
    ]]
    destroy()
    local v15 = Instance.new("Model")
    v15.Name = "TribesDrawnBody"
    u2 = a1
    u3 = a2
    u1 = v15
    tbl_upv_4[a1] = v15
    for _, value_15 in a1:GetChildren() do
        add(value_15)
    end
    local v16 = Instance.new("Humanoid")
    local v17 = a1:FindFirstChildOfClass("Humanoid")
    local v18
    if v17 then
        v18 = v17.RigType
    else
        v18 = Enum.HumanoidRigType.R15
    end
    v16.RigType = v18
    v16.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
    v16.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
    v16.RequiresNeck = false
    v16.BreakJointsOnDeath = false
    v16.AutomaticScalingEnabled = false
    v16.EvaluateStateMachine = false
    v16.Parent = v15
    table.insert(
        tbl_upv_11,
        v15.DescendantAdded:Connect(
            function(a3)
                --[[
                  line: 374
                  upvalues:
                    tbl_upv_12 (copy, index: 1)
                ]]
                if not a3:IsA("JointInstance") and not a3:IsA("WeldConstraint") and not a3:IsA("Constraint") then
                    return
                end
                tbl_upv_12.jointsStripped = tbl_upv_12.jointsStripped + 1
                task.defer(
                    function()
                        --[[
                          line: 377
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
        tbl_upv_11,
        a1.DescendantAdded:Connect(
            function(a4)
                --[[
                  line: 384
                  upvalues:
                    add (copy, index: 1)
                    u6 (ref,  index: 2)
                    tbl_upv_7 (copy, index: 3)
                    tbl_upv_12 (copy, index: 4)
                ]]
                add(a4)
                if not u6 or not a4:IsA("BasePart") and not a4:IsA("Decal") then
                    return
                end
                tbl_upv_7[a4] = true
                if a4.LocalTransparencyModifier == 1 then
                    return
                end
                a4.LocalTransparencyModifier = 1
                tbl_upv_12.hideWrites = tbl_upv_12.hideWrites + 1
            end
        )
    )
    table.insert(
        tbl_upv_11,
        a1.DescendantRemoving:Connect(
            function(a5)
                --[[
                  line: 390
                  upvalues:
                    tbl_upv_7 (copy, index: 1)
                    tbl_upv_4 (copy, index: 2)
                    u4 (ref,  index: 3)
                ]]
                if tbl_upv_7[a5] then
                    tbl_upv_7[a5] = nil
                    pcall(
                        function()
                            --[[
                              line: 394
                              upvalues:
                                a5 (copy, index: 1)
                            ]]
                            a5.LocalTransparencyModifier = 0
                        end
                    )
                end
                local v19 = tbl_upv_4[a5]
                if not v19 then
                    return
                end
                tbl_upv_4[a5] = nil
                u4 = true
                for _, value_16 in a5:GetDescendants() do
                    tbl_upv_4[value_16] = nil
                end
                v19:Destroy()
            end
        )
    )
    tbl_upv_12.builds = tbl_upv_12.builds + 1
    u4 = true
end
local function parentFor()
    --[[
      name: parentFor
      line: 404
      upvalues:
        Workspace_upv_1 (copy, index: 1)
    ]]
    return Workspace_upv_1.CurrentCamera
end
local function setShown(a1)
    --[[
      name: setShown
      line: 409
      upvalues:
        u1 (ref,  index: 1)
        u2 (ref,  index: 2)
        u6 (ref,  index: 3)
        Workspace_upv_1 (copy, index: 4)
        noCollisions (copy, index: 5)
        tbl_upv_7 (copy, index: 6)
        tbl_upv_12 (copy, index: 7)
        LocalPlayer_upv_1 (copy, index: 8)
        u9 (copy, index: 9)
    ]]
    local v20 = u2
    if not (u1) or not (v20) then
        a1 = false
    end
    if a1 ~= u6 then
        u6 = a1
        if a1 then
            u1.Parent = Workspace_upv_1.CurrentCamera
            noCollisions(u1)
            for _, value_17 in u2:GetDescendants() do
                if value_17:IsA("BasePart") or value_17:IsA("Decal") then
                    tbl_upv_7[value_17] = true
                    if value_17.LocalTransparencyModifier ~= 1 then
                        value_17.LocalTransparencyModifier = 1
                        tbl_upv_12.hideWrites = tbl_upv_12.hideWrites + 1
                    end
                end
            end
        else
            if u1 then
                u1.Parent = nil
            end
            if LocalPlayer_upv_1:GetAttribute("ReplayPlaying") ~= true then
                for key_5 in tbl_upv_7 do
                    if key_5.Parent then
                        key_5.LocalTransparencyModifier = 0
                    end
                end
            end
            table.clear(tbl_upv_7)
        end
        local v21
        if a1 then
            v21 = u1
        else
            v21 = nil
        end
        u9:Fire(v21)
    end
end
local u10 = nil
local function placeBubbleAnchor(a1, a2)
    --[[
      name: placeBubbleAnchor
      line: 443
      upvalues:
        u10 (ref, index: 1)
    ]]
    local v22
    if a1 then
        v22 = a1.Parent
    else
        v22 = nil
    end
    if not a1 or not a2 then
        return
    end
    if v22 then
        local v23 = u10
        if not (v23) or v23.Parent ~= v22 then
            if u10 then
                u10:Destroy()
            end
            local v24 = Instance.new("Part")
            v24.Name = "TribesBubbleAnchor"
            v24.Archivable = false
            v24.Anchored = true
            v24.CanCollide = false
            v24.CanQuery = false
            v24.CanTouch = false
            v24.Massless = true
            v24.CastShadow = false
            v24.Transparency = 1
            v24.Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)
            v24.CFrame = a2
            v24.Parent = v22
            u10 = v24
            v23 = v24
        end
        if v23.CFrame ~= a2 then
            v23.CFrame = a2
        end
    end
end
function tbl_1.Render(a1, a2)
    --[[
      name: Render
      line: 473
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
        placeBubbleAnchor (copy, index: 12)
        Workspace_upv_1 (copy, index: 13)
        noCollisions (copy, index: 14)
        u4 (ref,  index: 15)
        rebuildLists (copy, index: 16)
        tbl_upv_5 (copy, index: 17)
        tbl_upv_10 (copy, index: 18)
        tbl_upv_12 (copy, index: 19)
        tbl_upv_6 (copy, index: 20)
        tbl_upv_9 (copy, index: 21)
    ]]
    local v25 = os.clock()
    local v26
    if a1 then
        v26 = a1.Parent
    else
        v26 = nil
    end
    if a1 and v26 and v26:IsA("Model") then
        if v26 ~= u2 then
            if a1 ~= u7 or os.clock() - u8 > 5 then
                local success_2, v27 = pcall(build, v26, a1)
                if not (success_2) then
                    local v28 = os.clock()
                    u7 = a1
                    u8 = v28
                    destroy()
                    warn("[BodyProxy] build failed, the real body is shown: " .. tostring(v27))
                end
            elseif not (a1) and u2 then
                destroy()
            end
        elseif a1 ~= u3 and (a1 ~= u7 or os.clock() - u8 > 5) then
            local success_2, v27 = pcall(build, v26, a1)
            if not (success_2) then
                local v28 = os.clock()
                u7 = a1
                u8 = v28
                destroy()
                warn("[BodyProxy] build failed, the real body is shown: " .. tostring(v27))
            end
        elseif not (a1) and u2 then
            destroy()
        end
    elseif not (a1) and u2 then
        destroy()
    end
    local v29 = u5 and ((a2 ~= nil) and ((u1 ~= nil) and (LocalPlayer_upv_1:GetAttribute("ReplayPlaying") ~= true)))
    setShown(v29)
    if u6 and a2 then
        local v30 = nil
        if u3 then
            placeBubbleAnchor(a1, a2)
            if u1.Parent ~= Workspace_upv_1.CurrentCamera then
                u1.Parent = Workspace_upv_1.CurrentCamera
                noCollisions(u1)
            end
            if u4 then
                rebuildLists()
            end
            local v31 = a2 * u3.CFrame:Inverse()
            for key_6, value_18 in tbl_upv_5 do
                local real_1 = value_18.real
                tbl_upv_10[key_6] = v31 * real_1.CFrame
                local copy_1 = value_18.copy
                if copy_1.CanCollide then
                    copy_1.CanCollide = false
                    copy_1.CanQuery = false
                    tbl_upv_12.collisionResets = tbl_upv_12.collisionResets + 1
                end
                local Transparency_1 = real_1.Transparency
                if Transparency_1 ~= value_18.t then
                    value_18.t = Transparency_1
                    value_18.copy.Transparency = Transparency_1
                    tbl_upv_12.props = tbl_upv_12.props + 1
                end
                local Color_1 = real_1.Color
                if Color_1 ~= value_18.color then
                    value_18.color = Color_1
                    value_18.copy.Color = Color_1
                    tbl_upv_12.props = tbl_upv_12.props + 1
                end
                local Material_1 = real_1.Material
                if Material_1 ~= value_18.mat then
                    value_18.mat = Material_1
                    value_18.copy.Material = Material_1
                    tbl_upv_12.props = tbl_upv_12.props + 1
                end
            end
            for _, value_19 in tbl_upv_6 do
                local Transparency_2 = value_19.real.Transparency
                if Transparency_2 ~= value_19.t then
                    value_19.t = Transparency_2
                    value_19.copy.Transparency = Transparency_2
                end
            end
            if #tbl_upv_9 > 0
                and not (pcall(
                    function()
                        --[[
                          line: 541
                          upvalues:
                            Workspace_upv_1 (copy, index: 1)
                            tbl_upv_9 (copy, index: 2)
                            tbl_upv_10 (copy, index: 3)
                        ]]
                        Workspace_upv_1:BulkMoveTo(tbl_upv_9, tbl_upv_10, Enum.BulkMoveMode.FireCFrameChanged)
                    end
                )) then
                u4 = true
            end
            tbl_upv_12.frames = tbl_upv_12.frames + 1
            v30 = (os.clock() - v25) * 1000
            tbl_upv_12.totalMs = tbl_upv_12.totalMs + v30
            if tbl_upv_12.maxMs < v30 then
                tbl_upv_12.maxMs = v30
            end
        else
            local v32
            if a1 then
                v32 = a1.CFrame
            else
                v32 = nil
            end
            placeBubbleAnchor(a1, v32)
        end
    else
        local v32
        if a1 then
            v32 = a1.CFrame
        else
            v32 = nil
        end
        placeBubbleAnchor(a1, v32)
    end
end
function tbl_1.EnforceHidden()
    --[[
      name: EnforceHidden
      line: 559
      upvalues:
        u6 (ref,  index: 1)
        tbl_upv_7 (copy, index: 2)
        tbl_upv_12 (copy, index: 3)
    ]]
    if not u6 then
        return
    end
    for key_7 in tbl_upv_7 do
        if key_7.LocalTransparencyModifier == 1 then
            continue
        end
        if key_7.Parent then
            key_7.LocalTransparencyModifier = 1
            tbl_upv_12.hideWrites = tbl_upv_12.hideWrites + 1
        else
            tbl_upv_7[key_7] = nil
        end
    end
end
function tbl_1.SetEnabled(a1)
    --[[
      name: SetEnabled
      line: 576
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
function tbl_1.IsShown()
    --[[
      name: IsShown
      line: 583
      upvalues:
        u6 (ref, index: 1)
    ]]
    return u6
end
function tbl_1.Model()
    --[[
      name: Model
      line: 588
      upvalues:
        u6 (ref, index: 1)
        u1 (ref, index: 2)
    ]]
    if u6 then
        return u1
    end
    return nil
end
function tbl_1.Drawn(a1)
    --[[
      name: Drawn
      line: 594
      upvalues:
        u6 (ref,  index: 1)
        tbl_upv_4 (copy, index: 2)
    ]]
    if a1 and u6 then
        return tbl_upv_4[a1] or a1
    end
    return a1
end
function tbl_1.Stats()
    --[[
      name: Stats
      line: 601
      upvalues:
        u6 (ref,  index: 1)
        tbl_upv_12 (copy, index: 2)
    ]]
    local tbl_15 = {proxyCollisionResets = 0, proxyAvgMs = 0}
    tbl_15.proxyShown = u6
    tbl_15.proxyBuilds = tbl_upv_12.builds
    tbl_15.proxyParts = tbl_upv_12.parts
    tbl_15.proxyFrames = tbl_upv_12.frames
    tbl_15.proxyJointsStripped = tbl_upv_12.jointsStripped
    tbl_15.proxyHideWrites = tbl_upv_12.hideWrites
    tbl_15.proxyPropCopies = tbl_upv_12.props
    tbl_15.proxyMaxMs = math.floor(tbl_upv_12.maxMs * 1000) / 1000
    tbl_15.proxyAvgMs = tbl_upv_12.frames > 0 and math.floor((tbl_upv_12.totalMs / tbl_upv_12.frames) * 10000) / 10000 or 0
    tbl_15.proxyCollisionResets = tbl_upv_12.collisionResets
    return tbl_15
end
if v1 then
    function tbl_1.DebugMap()
        --[[
          name: DebugMap
          line: 618
          upvalues:
            tbl_upv_4 (copy, index: 1)
        ]]
        local tbl_16 = {decals = 0, other = 0, attachments = 0, parts = 0}
        for key_8 in tbl_upv_4 do
            if key_8:IsA("BasePart") then
                tbl_16.parts = tbl_16.parts + 1
                continue
            end
            if key_8:IsA("Decal") then
                tbl_16.decals = tbl_16.decals + 1
                continue
            end
            if key_8:IsA("Attachment") then
                tbl_16.attachments = tbl_16.attachments + 1
            else
                tbl_16.other = tbl_16.other + 1
            end
        end
        return tbl_16
    end
end
if RunService_1:IsClient() then
    task.spawn(
        function()
            --[[
              line: 637
            ]]
            local v34 = game:GetService("TextChatService"):WaitForChild("BubbleChatConfiguration", 30)
            if not v34 or not v34:IsA("BubbleChatConfiguration") then
                return
            end
            v34.AdorneeName = "TribesBubbleAnchor"
        end
    )
end
return tbl_1