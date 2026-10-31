local ContextActionService_upv_1 = game:GetService("ContextActionService")
local GuiService_upv_1 = game:GetService("GuiService")
local Players_upv_1 = game:GetService("Players")
local RunService_upv_1 = game:GetService("RunService")
local UserInputService_upv_1 = game:GetService("UserInputService")
local Workspace_upv_1 = game:GetService("Workspace")
local Spring_1 = require(script:WaitForChild("Spring"))
local Spectate_upv_1 = require(script:WaitForChild("Spectate"))
local Fighters_upv_1 = require(script:WaitForChild("Fighters"))
local Fades_upv_1 = require(script:WaitForChild("Fades"))
local AimAssist_upv_1 = require(script:WaitForChild("AimAssist"))
local SpectateKeys_upv_1 = require(script:WaitForChild("SpectateKeys"))
local Smoothing_upv_1 = require(script:WaitForChild("Smoothing"))
local Occlusion_upv_1 = require(script:WaitForChild("Occlusion"))
local Shoulder_upv_1 = require(script:WaitForChild("Shoulder"))
local FirstPerson_upv_1 = require(script:WaitForChild("FirstPerson"))
local Guards_upv_1 = require(script:WaitForChild("Guards"))
local Simulation_upv_1 = require(script.Parent:WaitForChild("Simulation"))
local Finite_upv_1 = require(script:WaitForChild("Finite"))
Finite_upv_1.Authority = tostring(Simulation_upv_1.Authority)
local Keybinds_upv_1 = require(script.Parent:WaitForChild("Keybinds"))
local tbl_upv_1 = {}
local u1 = -1.3962634015954636
local u2 = 1.361356816555577
tbl_upv_1.PadLook = require(script:WaitForChild("PadLook"))
local u3 = RunService_upv_1:IsClient() and (not RunService_upv_1:IsServer())
local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
local u4 = 0
local u5 = -0.20943951023931956
local u6 = false
local u7 = 50
local u8 = 70
local u9 = 10.5
local u10 = 1
local tbl_upv_2 = {zoom = 1, sens = 1}
local u11 = true
local u12 = false
local tbl_upv_3 = {}
local tbl_upv_4 = {}
local tbl_upv_5 = {}
local tbl_upv_6 = {}
local tbl_upv_7 = {}
local u13 = Spring_1.new(70, 3.2, 1)
local u14 = Spring_1.new(10.5, 3.5, 1)
local u15 = Spring_1.new(Vector3.new(0, 0, 0), 4, 1)
local u16 = Spring_1.new(0, 5, 1)
local u17 = Spring_1.new(0, 3.2, 0.45)
local u18 = Spring_1.new(Vector3.new(0, 0, 0), 5, 0.75)
local tbl_upv_8 = {time = 0, touchesIgnored = 0, max = 0, touchLookPx = 0, frames = 0}
tbl_upv_8.since = os.clock()
local tbl_upv_9 = {headFade = 0, deathSpot = 0, propFadeFrame = 0, reconcile = 0, ignoreBuilt = 0}
local u19 = false
local u20 = nil
local u21 = 0
local u22 = 0
local u23 = 1.6666666666666667
local u24 = 0
local u25 = nil
local cf_upv_1 = CFrame.new()
local u26 = 70
local u27 = nil
local u28 = nil
local u29 = false
local u30 = false
local u31 = false
local u32 = false
local CFrame_upv_1 = nil
local FieldOfView_upv_1 = 70
local u33 = 1
local u34 = nil
local u35 = false
local u36 = Vector2.zero
local zero_upv_1 = Vector2.zero
local tbl_upv_10 = {}
local u37 = nil
local u38 = "none"
local u39 = CFrame.new()
local u40 = 70
local u41 = nil
local u42 = nil
local u43 = 70
local u44 = 1
local u45 = CFrame.new()
local u46 = 70
local u47 = nil
local function wrapAngle(a1)
    --[[
      name: wrapAngle
      line: 195
    ]]
    return ((a1 + math.pi) % math.tau) - math.pi
end
local function smoothstep(a1)
    --[[
      name: smoothstep
      line: 199
    ]]
    local v1 = math.clamp(a1, 0, 1)
    return (v1 * v1) * (3 - (v1 * 2))
end
local tbl_upv_11 = {rise = 0.05, fall = 0.2, t0 = 0, amount = 0}
local function isMouseUnlocked()
    --[[
      name: isMouseUnlocked
      line: 224
      upvalues:
        tbl_upv_3 (copy, index: 1)
        GuiService_upv_1 (copy, index: 2)
    ]]
    local v2 = true
    if next(tbl_upv_3) == nil then
        v2 = GuiService_upv_1.MenuIsOpen
    end
    return v2
end
local function combatModeOn()
    --[[
      name: combatModeOn
      line: 230
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local v3 = LocalPlayer_upv_1:GetAttribute("CombatMode")
    if v3 ~= nil then
        return v3 == true
    end
    local v4 = LocalPlayer_upv_1:GetAttribute("State") == "Match"
    return v4
end
local function getCharacterParts()
    --[[
      name: getCharacterParts
      line: 238
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local v5
    if LocalPlayer_upv_1 then
        v5 = LocalPlayer_upv_1.Character
    else
        v5 = LocalPlayer_upv_1
    end
    if not v5 then
        return nil, nil, nil
    end
    local HumanoidRootPart_1 = v5:FindFirstChild("HumanoidRootPart")
    local v6 = v5:FindFirstChildOfClass("Humanoid")
    local v7 = ((HumanoidRootPart_1 and (HumanoidRootPart_1:IsA("BasePart"))) and HumanoidRootPart_1) or nil
    return v5, v7, v6
end
local function yawOf(a1)
    --[[
      name: yawOf
      line: 248
    ]]
    local LookVector_1 = a1.LookVector
    return (math.atan2(-LookVector_1.X, -LookVector_1.Z))
end
local function drawnCharacter(a1)
    --[[
      name: drawnCharacter
      line: 255
      upvalues:
        Smoothing_upv_1 (copy, index: 1)
    ]]
    return Smoothing_upv_1.DrawnModel() or a1
end
local tbl_upv_12 = {}
local u48 = true
local u49 = nil
local u50 = true
local tbl_upv_13 = {"FX", "Projectiles"}
local function markIgnoreDirty()
    --[[
      name: markIgnoreDirty
      line: 268
      upvalues:
        u48 (ref, index: 1)
    ]]
    u48 = true
end
local function ignoreList(a1)
    --[[
      name: ignoreList
      line: 272
      upvalues:
        u48 (ref,  index: 1)
        u49 (ref,  index: 2)
        tbl_upv_9 (copy, index: 3)
        tbl_upv_12 (copy, index: 4)
        tbl_upv_13 (copy, index: 5)
        Workspace_upv_1 (copy, index: 6)
        Players_upv_1 (copy, index: 7)
        Fighters_upv_1 (copy, index: 8)
        Occlusion_upv_1 (copy, index: 9)
        u50 (ref,  index: 10)
    ]]
    local v8 = os.clock()
    if u48 then
        table.clear(tbl_upv_12)
        if a1 then
            table.insert(tbl_upv_12, a1)
        end
        for _, value_1 in tbl_upv_13 do
            local v9 = Workspace_upv_1:FindFirstChild(value_1)
            if v9 then
                table.insert(tbl_upv_12, v9)
            end
        end
        for _, value_2 in Players_upv_1:GetPlayers() do
            if not (value_2.Character) then
                continue
            end
            if value_2.Character ~= a1 then
                table.insert(tbl_upv_12, value_2.Character)
            end
        end
        Fighters_upv_1.EachTagged(
            function(a2)
                --[[
                  line: 290
                  upvalues:
                    a1 (copy, index: 1)
                    tbl_upv_12 (copy, index: 2)
                ]]
                if a2 == a1 then
                    return
                end
                table.insert(tbl_upv_12, a2)
            end
        )
        u48 = false
        u49 = a1
        tbl_upv_9.ignoreBuilt = v8
        Occlusion_upv_1.IgnoreChanged()
        u50 = true
    elseif a1 ~= u49 then
        table.clear(tbl_upv_12)
        if a1 then
            table.insert(tbl_upv_12, a1)
        end
        for _, value_1 in tbl_upv_13 do
            local v9 = Workspace_upv_1:FindFirstChild(value_1)
            if v9 then
                table.insert(tbl_upv_12, v9)
            end
        end
        for _, value_2 in Players_upv_1:GetPlayers() do
            if not (value_2.Character) then
                continue
            end
            if value_2.Character ~= a1 then
                table.insert(tbl_upv_12, value_2.Character)
            end
        end
        Fighters_upv_1.EachTagged(
            function(a2)
                --[[
                  line: 290
                  upvalues:
                    a1 (copy, index: 1)
                    tbl_upv_12 (copy, index: 2)
                ]]
                if a2 == a1 then
                    return
                end
                table.insert(tbl_upv_12, a2)
            end
        )
        u48 = false
        u49 = a1
        tbl_upv_9.ignoreBuilt = v8
        Occlusion_upv_1.IgnoreChanged()
        u50 = true
    elseif v8 - tbl_upv_9.ignoreBuilt > 2 then
        table.clear(tbl_upv_12)
        if a1 then
            table.insert(tbl_upv_12, a1)
        end
        for _, value_1 in tbl_upv_13 do
            local v9 = Workspace_upv_1:FindFirstChild(value_1)
            if v9 then
                table.insert(tbl_upv_12, v9)
            end
        end
        for _, value_2 in Players_upv_1:GetPlayers() do
            if not (value_2.Character) then
                continue
            end
            if value_2.Character ~= a1 then
                table.insert(tbl_upv_12, value_2.Character)
            end
        end
        Fighters_upv_1.EachTagged(
            function(a2)
                --[[
                  line: 290
                  upvalues:
                    a1 (copy, index: 1)
                    tbl_upv_12 (copy, index: 2)
                ]]
                if a2 == a1 then
                    return
                end
                table.insert(tbl_upv_12, a2)
            end
        )
        u48 = false
        u49 = a1
        tbl_upv_9.ignoreBuilt = v8
        Occlusion_upv_1.IgnoreChanged()
        u50 = true
    end
    return tbl_upv_12
end
local function watchPlayerForIgnore(a1)
    --[[
      name: watchPlayerForIgnore
      line: 304
      upvalues:
        markIgnoreDirty (copy, index: 1)
    ]]
    a1.CharacterAdded:Connect(markIgnoreDirty)
    a1.CharacterRemoving:Connect(markIgnoreDirty)
end
local function castDistance(a1, a2, a3)
    --[[
      name: castDistance
      line: 311
      upvalues:
        Occlusion_upv_1 (copy, index: 1)
    ]]
    return Occlusion_upv_1.Cast(a1, a2, a3)
end
local tbl_upv_14 = {}
local u51 = true
local tbl_upv_15 = {}
local u52 = -1
local u53 = -1
local u54 = false
local u55 = false
local u56 = Instance.new("BindableEvent")
local u57 = nil
local function isHeadAccessoryPart(a1, a2)
    --[[
      name: isHeadAccessoryPart
      line: 328
    ]]
    for _, value_3 in a1:GetChildren() do
        if not (value_3:IsA("Attachment")) or not (a2:FindFirstChild(value_3.Name)) then
            continue
        end
        return true
    end
    return false
end
local function rebuildFadeEntries(a1)
    --[[
      name: rebuildFadeEntries
      line: 338
      upvalues:
        tbl_upv_14 (copy, index: 1)
        isHeadAccessoryPart (copy, index: 2)
        u51 (ref,  index: 3)
    ]]
    table.clear(tbl_upv_14)
    local Head_1 = a1:FindFirstChild("Head")
    local v10 = nil
    for _, value_4 in a1:GetDescendants() do
        if value_4:IsA("BasePart") or value_4:IsA("Decal") then
            v10 = false
            if not (Head_1) then
                table.insert(tbl_upv_14, {inst = value_4, head = v10})
                continue
            end
            local v11 = Head_1:IsA("BasePart")
            if not (v11) then
                table.insert(tbl_upv_14, {inst = value_4, head = v10})
                continue
            end
            if value_4 == Head_1 or value_4.Parent == Head_1 then
                v10 = true
                table.insert(tbl_upv_14, {inst = value_4, head = v10})
                continue
            end
            local v12 = value_4:IsA("BasePart")
            if not (v12) or not (value_4.Parent) then
                table.insert(tbl_upv_14, {inst = value_4, head = v10})
                continue
            end
            local v13 = value_4.Parent:IsA("Accessory")
            if v13 then
                v10 = isHeadAccessoryPart(value_4, Head_1)
            end
            table.insert(tbl_upv_14, {inst = value_4, head = v10})
        end
    end
    u51 = false
end
local function restoreAll(a1)
    --[[
      name: restoreAll
      line: 357
    ]]
    for _, value_5 in a1 do
        local inst_1 = value_5.inst
        if not (inst_1.Parent) then
            continue
        end
        if inst_1.LocalTransparencyModifier ~= 0 then
            inst_1.LocalTransparencyModifier = 0
        end
    end
end
local function setCharacterFade(a1, a2, a3, a4)
    --[[
      name: setCharacterFade
      line: 372
      upvalues:
        u57 (ref,  index: 1)
        tbl_upv_14 (copy, index: 2)
        tbl_upv_15 (copy, index: 3)
        u51 (ref,  index: 4)
        u52 (ref,  index: 5)
        u53 (ref,  index: 6)
        u54 (ref,  index: 7)
        rebuildFadeEntries (copy, index: 8)
        tbl_upv_9 (copy, index: 9)
    ]]
    a2 = ((a2 < 0.01) and 0) or a2
    local v14 = math.max(a2, a3 or 0)
    local v15 = ((v14 < 0.01) and 0) or v14
    if a1 ~= u57 then
        for _, value_6 in tbl_upv_14 do
            local inst_2 = value_6.inst
            if not (inst_2.Parent) then
                continue
            end
            if inst_2.LocalTransparencyModifier ~= 0 then
                inst_2.LocalTransparencyModifier = 0
            end
        end
        for _, value_7 in tbl_upv_15 do
            value_7:Disconnect()
        end
        table.clear(tbl_upv_15)
        table.clear(tbl_upv_14)
        u57 = a1
        u51 = true
        u52 = -1
        u53 = -1
        u54 = false
        if a1 then
            table.insert(
                tbl_upv_15,
                a1.DescendantAdded:Connect(
                    function(a5)
                        --[[
                          line: 392
                          upvalues:
                            u51 (ref, index: 1)
                            u54 (ref, index: 2)
                            u52 (ref, index: 3)
                        ]]
                        u51 = true
                        if a5:IsA("BasePart") or a5:IsA("Decal") then
                            a5.LocalTransparencyModifier = u54 and 1 or math.max(u52, 0)
                        end
                    end
                )
            )
            table.insert(
                tbl_upv_15,
                a1.DescendantRemoving:Connect(
                    function()
                        --[[
                          line: 399
                          upvalues:
                            u51 (ref, index: 1)
                        ]]
                        u51 = true
                    end
                )
            )
        end
    end
    if not a1 then
        return
    end
    local v17 = u51
    if u51 then
        rebuildFadeEntries(a1)
    end
    local v18 = os.clock()
    local v19 = v17 or (v18 - tbl_upv_9.reconcile > 0.25)
    local v20 = true
    if not (math.abs(a2 - u52) >= 0.02) then
        local v21 = true
        if math.abs(v15 - u53) >= 0.02 then
            v20 = v21
        elseif a2 == 0 then
            local v22 = true
            if u52 ~= 0 then
                v20 = v22
            elseif v15 ~= 0 then
                v20 = a4 == true ~= u54
            else
                local v23 = true
                if u53 ~= 0 then
                    v20 = v23
                else
                    v20 = a4 == true ~= u54
                end
            end
        elseif v15 ~= 0 then
            v20 = a4 == true ~= u54
        else
            local v23 = true
            if u53 ~= 0 then
                v20 = v23
            else
                v20 = a4 == true ~= u54
            end
        end
    end
    if (v19) or (v20) then
        tbl_upv_9.reconcile = v18
        u52 = a2
        u53 = v15
        u54 = a4 == true
        for _, value_8 in tbl_upv_14 do
            local inst_3 = value_8.inst
            if not (inst_3.Parent) then
                continue
            end
            if u54 then
                v18 = 1
            elseif value_8.head then
                v18 = v15
            else
                v18 = a2
            end
            if math.abs(inst_3.LocalTransparencyModifier - v18) > 0.001 then
                inst_3.LocalTransparencyModifier = v18
            end
        end
    end
end
local tbl_upv_16 = {}
local tbl_upv_17 = {Low = 4, High = 1, Medium = 2}
local u58 = 1
local tbl_upv_18 = {}
local u59 = OverlapParams.new()
u59.FilterType = Enum.RaycastFilterType.Exclude
local function clearPropFade()
    --[[
      name: clearPropFade
      line: 445
      upvalues:
        tbl_upv_16 (copy, index: 1)
    ]]
    for key_1 in tbl_upv_16 do
        if key_1.Parent then
            key_1.LocalTransparencyModifier = 0
        end
    end
    table.clear(tbl_upv_16)
end
local function propFadeable(a1)
    --[[
      name: propFadeable
      line: 463
    ]]
    if a1.Transparency >= 1 or a1:HasTag("Foliage") or a1.Size.Magnitude >= 80 then
        return false
    end
    local Size_1 = a1.Size
    if math.max(math.min(Size_1.X, Size_1.Y), math.min(math.max(Size_1.X, Size_1.Y), Size_1.Z)) >= 6 then
        return false
    end
    local v24 = a1:FindFirstAncestorWhichIsA("Model")
    while v24 do
        if v24:FindFirstChildOfClass("Humanoid") or v24:HasTag("BearTrap") then
            return false
        end
        v24 = v24:FindFirstAncestorWhichIsA("Model")
    end
    return true
end
local function markProp(a1)
    --[[
      name: markProp
      line: 482
      upvalues:
        tbl_upv_18 (copy, index: 1)
        tbl_upv_16 (copy, index: 2)
    ]]
    tbl_upv_18[a1] = true
    if (tbl_upv_16[a1]) then
        return
    end
    tbl_upv_16[a1] = true
    a1.LocalTransparencyModifier = 0.7
end
local u60 = RaycastParams.new()
u60.FilterType = Enum.RaycastFilterType.Exclude
local function boxDistance(a1, a2)
    --[[
      name: boxDistance
      line: 454
    ]]
    local v25 = a1.CFrame:PointToObjectSpace(a2)
    local v26 = a1.Size * 0.5
    return Vector3.new(math.max(math.abs(v25.X) - v26.X, 0), math.max(math.abs(v25.Y) - v26.Y, 0), math.max(math.abs(v25.Z) - v26.Z, 0)).Magnitude
end
local function updatePropFade(a1, a2, a3)
    --[[
      name: updatePropFade
      line: 495
      upvalues:
        u50 (ref,  index: 1)
        u59 (copy, index: 2)
        tbl_upv_18 (copy, index: 3)
        Workspace_upv_1 (copy, index: 4)
        propFadeable (copy, index: 5)
        boxDistance (copy, index: 6)
        tbl_upv_16 (copy, index: 7)
        u60 (copy, index: 8)
        Occlusion_upv_1 (copy, index: 9)
    ]]
    if u50 then
        u59.FilterDescendantsInstances = a3
        u50 = false
    end
    table.clear(tbl_upv_18)
    local success_1, v27 = pcall(
        function()
            --[[
              line: 501
              upvalues:
                Workspace_upv_1 (copy, index: 1)
                a1 (copy, index: 2)
                u59 (copy, index: 3)
            ]]
            return Workspace_upv_1:GetPartBoundsInRadius(a1, 4.2, u59)
        end
    )
    if success_1 then
        for _, value_9 in v27 do
            if not (a1.Y - 1 < value_9.Position.Y + (value_9.Size.Y / 2)) or not (propFadeable(value_9)) then
                continue
            end
            local v28 = boxDistance(value_9, a1)
            if not (v28 <= (((tbl_upv_16[value_9]) and 0.7) or 0) + 3.5) then
                continue
            end
            tbl_upv_18[value_9] = true
            if not (tbl_upv_16[value_9]) then
                tbl_upv_16[value_9] = true
                value_9.LocalTransparencyModifier = 0.7
            end
        end
    end
    if a2 then
        u60.FilterDescendantsInstances = a3
        v27 = a1
        for _ = 1, 4 do
            local v29 = a2 - v27
            local v30
            if v29.Magnitude < 0.05 then
                break
            end
            v30 = Workspace_upv_1:Raycast(v27, v29, u60)
            local v31
            if not (v30) then
                break
            end
            v31 = v30.Instance
            if not (v31:IsA("BasePart")) or Occlusion_upv_1.Classify(v31) ~= 2 or not (propFadeable(v31)) then
                u60:AddToFilter(v31)
                v27 = v30.Position
                continue
            end
            tbl_upv_18[v31] = true
            if not (tbl_upv_16[v31]) then
                tbl_upv_16[v31] = true
                v31.LocalTransparencyModifier = 0.7
            end
            u60:AddToFilter(v31)
            v27 = v30.Position
        end
    end
    for key_2 in tbl_upv_16 do
        if tbl_upv_18[key_2] then
            continue
        end
        tbl_upv_16[key_2] = nil
        if key_2.Parent then
            key_2.LocalTransparencyModifier = 0
        end
    end
end
local function applyMouseBehavior()
    --[[
      name: applyMouseBehavior
      line: 555
      upvalues:
        u11 (ref,  index: 1)
        u31 (ref,  index: 2)
        tbl_upv_3 (copy, index: 3)
        GuiService_upv_1 (copy, index: 4)
        UserInputService_upv_1 (copy, index: 5)
    ]]
    if not u11 then
        return
    end
    if not (u31) then
        local v32 = true
        if next(tbl_upv_3) == nil then
            v32 = GuiService_upv_1.MenuIsOpen
        end
        if v32 then
            if UserInputService_upv_1.MouseBehavior ~= Enum.MouseBehavior.Default then
                UserInputService_upv_1.MouseBehavior = Enum.MouseBehavior.Default
            end
            if not (UserInputService_upv_1.MouseIconEnabled) then
                UserInputService_upv_1.MouseIconEnabled = true
                return
            end
        else
            if UserInputService_upv_1.MouseBehavior ~= Enum.MouseBehavior.LockCenter then
                UserInputService_upv_1.MouseBehavior = Enum.MouseBehavior.LockCenter
            end
            if UserInputService_upv_1.MouseIconEnabled then
                UserInputService_upv_1.MouseIconEnabled = false
            end
        end
    end
end
local tbl_upv_19 = {}
tbl_upv_19[Enum.HumanoidStateType.Running] = true
tbl_upv_19[Enum.HumanoidStateType.RunningNoPhysics] = true
tbl_upv_19[Enum.HumanoidStateType.Jumping] = true
tbl_upv_19[Enum.HumanoidStateType.Freefall] = true
tbl_upv_19[Enum.HumanoidStateType.Landed] = true
tbl_upv_19[Enum.HumanoidStateType.GettingUp] = true
local function releaseAutoRotate(a1)
    --[[
      name: releaseAutoRotate
      line: 589
      upvalues:
        u29 (ref,  index: 1)
        u30 (ref,  index: 2)
        Simulation_upv_1 (copy, index: 3)
    ]]
    u29 = false
    if not u30 then
        return
    end
    Simulation_upv_1.SetFacing(nil)
    u30 = false
end
local function updateCharacterRotation(a1, a2, a3, a4)
    --[[
      name: updateCharacterRotation
      line: 597
      upvalues:
        tbl_upv_5 (copy, index: 1)
        tbl_upv_19 (copy, index: 2)
        u29 (ref,  index: 3)
        u30 (ref,  index: 4)
        Simulation_upv_1 (copy, index: 5)
        Smoothing_upv_1 (copy, index: 6)
        u4 (ref,  index: 7)
        u6 (ref,  index: 8)
        u55 (ref,  index: 9)
    ]]
    local v33 = not a4 and ((next(tbl_upv_5) == nil) and ((a3.Health > 0) and (not a2.Anchored and ((tbl_upv_19[a3:GetState()] == true) and ((a3.Sit == false) and (a3.PlatformStand == false))))))
    if v33 then
        u30 = true
        local _, v34 = Smoothing_upv_1.SimCFrame(a2):ToEulerAnglesYXZ()
        local v35 = ((u4 - v34) + math.pi) % math.tau - math.pi
        local v36 = a3.MoveDirection.Magnitude > 0.05
        local v37 = (a2.Parent ~= nil) and (a2.Parent:FindFirstChildOfClass("Tool") ~= nil)
        local v38 = v36 or (v37 or (u6 or u55))
        if v38 then
            u29 = false
        else
            if math.abs(v35) > 1.7453292519943295 then
                u29 = true
            end
            if u29 and math.abs(v35) < 0.06981317007977318 then
                u29 = false
            end
            v38 = u29
        end
        if v38 then
            if u55 then
                v38 = 40
            elseif u6 or v37 then
                v38 = 30
            else
                v38 = (v36 and 18) or 12
            end
            Simulation_upv_1.SetFacing(v34 + (v35 * (1 - math.exp(-v38 * math.max(a1, 0.016666666666666666)))))
        else
            Simulation_upv_1.SetFacing(v34)
        end
    else
        u29 = false
        if u30 then
            Simulation_upv_1.SetFacing(nil)
            u30 = false
        end
    end
end
local tbl_upv_20 = {Vector3.new(-1, -1, -1), Vector3.new(-1, -1, 1), Vector3.new(-1, 1, -1), Vector3.new(-1, 1, 1), Vector3.new(1, -1, -1), Vector3.new(1, -1, 1), Vector3.new(1, 1, -1), Vector3.new(1, 1, 1)}
local function frameSubject(a1, a2, a3, a4)
    --[[
      name: frameSubject
      line: 682
      upvalues:
        Finite_upv_1 (copy, index: 1)
        u45 (ref,  index: 2)
        u28 (ref,  index: 3)
        u27 (ref,  index: 4)
        u16 (copy, index: 5)
        Occlusion_upv_1 (copy, index: 6)
        u4 (ref,  index: 7)
        u18 (copy, index: 8)
        tbl_upv_1 (copy, index: 9)
        u5 (ref,  index: 10)
        u14 (copy, index: 11)
        u17 (copy, index: 12)
        u15 (copy, index: 13)
        Shoulder_upv_1 (copy, index: 14)
        u6 (ref,  index: 15)
    ]]
    if not Finite_upv_1.Vector(a3) then
        return u45, u45.Position + (u45.LookVector * 10)
    end
    if a2 ~= u28 or u27 == nil or (a3 - u27).Magnitude > 40 then
        u16:Snap(a3.Y)
        Occlusion_upv_1.Reset()
        u28 = a2
    end
    u27 = a3
    u16.target = a3.Y
    u16:Update(a1)
    local v39 = math.clamp(u16.value, a3.Y - 1.5, a3.Y + 1.5)
    u16.value = v39
    local v40 = CFrame.fromEulerAnglesYXZ(0, u4, 0)
    local v41 = u18.value + tbl_upv_1.SlowRecoil.value
    local v42 = CFrame.fromEulerAnglesYXZ(u5 + v41.X, u4 + v41.Y, v41.Z)
    local v43 = Vector3.new(a3.X, (v39 + 3.1) + u17.value, a3.Z) + v40:VectorToWorldSpace(u15.value)
    local v44 = Vector3.new(a3.X, a3.Y + 0.5, a3.Z)
    local Frame_1 = Occlusion_upv_1.Frame
    local RightVector_1 = v40.RightVector
    local LookVector_2 = v42.LookVector
    local v45 = Shoulder_upv_1.Value()
    local v46 = (u6 and 2.8) or 2.9
    local v47, v48, v49 = Frame_1(a1, v44, v43, RightVector_1, LookVector_2, v45, u14.value, a4, v46)
    Shoulder_upv_1.Update(v49, v40.RightVector, 2.9, a4)
    return CFrame.new(v47) * v42.Rotation, v48
end
local function focusPointOf(a1)
    --[[
      name: focusPointOf
      line: 742
    ]]
    local Head_2 = a1:FindFirstChild("Head")
    if Head_2 and Head_2:IsA("BasePart") then
        return Head_2.Position - Vector3.new(0, 0.6000000238418579, 0)
    end
    local HumanoidRootPart_2 = a1:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart_2 and HumanoidRootPart_2:IsA("BasePart") then
        return HumanoidRootPart_2.Position + Vector3.new(0, 1, 0)
    end
    return nil
end
local u61 = OverlapParams.new()
u61.FilterType = Enum.RaycastFilterType.Exclude
u61.RespectCanCollide = true
local function spotIsFree(a1, a2)
    --[[
      name: spotIsFree
      line: 758
      upvalues:
        u61 (copy, index: 1)
    ]]
    u61.FilterDescendantsInstances = a2
    local success_2, v50 = pcall(function() end)
    return success_2 and (#v50 == 0)
end
local u62 = nil
local u63 = nil
local function sees(a1, a2, a3)
    --[[
      name: sees
      line: 772
      upvalues:
        Occlusion_upv_1 (copy, index: 1)
    ]]
    local v51 = (a2 - a1).Magnitude - 0.5 <= Occlusion_upv_1.Cast(a1, a2, a3)
    return v51
end
local function pickDeathSpot(a1, a2, a3)
    --[[
      name: pickDeathSpot
      line: 776
      upvalues:
        u63 (ref,  index: 1)
        Occlusion_upv_1 (copy, index: 2)
        u61 (copy, index: 3)
        Workspace_upv_1 (copy, index: 4)
    ]]
    local v52 = u63
    local v53 = nil
    if v52 then
        v53 = (a2 - v52).Magnitude - 0.5 <= Occlusion_upv_1.Cast(v52, a2, a3)
        if v53 then
            return u63
        end
    end
    local v54 = Vector3.new(a1.X - a2.X, 0, a1.Z - a2.Z)
    local v55 = ((not (v54.Magnitude > 0.1)) and Vector3.new(0, 0, 1)) or (v54.Unit)
    for key_3, value_upv_10 in {a1, a1 + Vector3.new(0, 7, 0), a1 + Vector3.new(0, 14, 0), (a2 + (v55 * 16)) + Vector3.new(0, 8, 0), (a2 + (v55 * 11)) + Vector3.new(0, 4, 0), (a2 + (v55 * 14)) + Vector3.new(0, 18, 0)} do
        local v56 = (a2 - value_upv_10).Magnitude - 0.5 <= Occlusion_upv_1.Cast(value_upv_10, a2, a3)
        if not (v56) then
            continue
        end
        if key_3 ~= 1 then
            u61.FilterDescendantsInstances = a3
            local success_3, v57 = pcall(
                function()
                    --[[
                      line: 760
                      upvalues:
                        Workspace_upv_1 (copy, index: 1)
                        value_upv_10 (copy, index: 2)
                        u61 (copy, index: 3)
                    ]]
                    return Workspace_upv_1:GetPartBoundsInRadius(value_upv_10, 0.6, u61)
                end
            )
            if not success_3 or #v57 ~= 0 then
                continue
            end
        end
        return value_upv_10
    end
    return a1 + Vector3.new(0, 10, 0)
end
local function deathView(a1)
    --[[
      name: deathView
      line: 802
      upvalues:
        Spectate_upv_1 (copy, index: 1)
        u39 (ref,  index: 2)
        focusPointOf (copy, index: 3)
        u8 (ref,  index: 4)
        u63 (ref,  index: 5)
        tbl_upv_9 (copy, index: 6)
        pickDeathSpot (copy, index: 7)
        ignoreList (copy, index: 8)
        LocalPlayer_upv_1 (copy, index: 9)
        u40 (ref,  index: 12)
    ]]
    local v58 = math.clamp(Spectate_upv_1.DeathElapsed() / 0.35, 0, 1)
    local v59 = v58 * v58 * (3 - (v58 * 2))
    local v60 = Spectate_upv_1.GetKiller()
    local v61 = not (v60) or not (v60.Parent) or focusPointOf(v60)
    local v62
    if v61 then
        local v63 = os.clock()
        if u63 == nil or v63 - tbl_upv_9.deathSpot > 0.25 then
            tbl_upv_9.deathSpot = v63
            u63 = pickDeathSpot(u39.Position, v61, ignoreList(LocalPlayer_upv_1.Character))
        end
        v62 = u63
    else
        local v64 = u39.Position + Vector3.new(0, 3, 0)
        local v65 = Spectate_upv_1.GetDeathPosition() or (u39.Position + u39.LookVector * 10)
        v62, v61 = v64, v65
    end
    if v66 == nil then
        v66 = u39.Position
    end
    v66 = v66:Lerp(v62, 1 - math.exp(a1 * -5))
    local v67 = v66
    local v68
    if v60 and v60.Parent then
        v68 = math.clamp(math.deg(math.atan(9 / math.max((v61 - v67).Magnitude, 1))) * 2, 35, u8)
    else
        v68 = u8
    end
    if v69 ~= nil then
        v69 = v69:Lerp(v61, 1 - math.exp(a1 * -8))
    else
        v69 = v61
    end
    local v70 = v69
    local v71 = ((not ((v70 - v67).Magnitude > 0.1)) and (CFrame.new(v66) * u39.Rotation)) or (CFrame.lookAt(v66, v70))
    return u39.Rotation:Lerp(v71.Rotation, v59) + v66, u40 + ((v68 - u40) * v59)
end
function tbl_upv_2.fovNow()
    --[[
      name: fovNow
      line: 846
      upvalues:
        u7 (ref,  index: 1)
        u8 (ref,  index: 2)
        tbl_upv_2 (copy, index: 3)
    ]]
    if u8 <= u7 then
        return u7
    end
    return u7 + ((u8 - u7) * (1 - tbl_upv_2.zoom))
end
local function readLookInput(a1, a2, a3)
    --[[
      name: readLookInput
      line: 853
      upvalues:
        u10 (ref,  index: 1)
        u6 (ref,  index: 2)
        tbl_upv_2 (copy, index: 3)
        u8 (ref,  index: 4)
        UserInputService_upv_1 (copy, index: 5)
        u4 (ref,  index: 6)
        u5 (ref,  index: 7)
        zero_upv_1 (ref,  index: 8)
        AimAssist_upv_1 (copy, index: 9)
        tbl_upv_1 (copy, index: 10)
        u36 (ref,  index: 11)
        LocalPlayer_upv_1 (copy, index: 12)
        ignoreList (copy, index: 13)
        tbl_upv_6 (copy, index: 14)
        tbl_upv_8 (copy, index: 15)
        u2 (ref,  index: 16)
        u1 (ref,  index: 17)
    ]]
    local v72 = u10 * a3
    v72 = (u6 and (v72 * (math.clamp(tbl_upv_2.fovNow() / u8, 0.35, 1) * tbl_upv_2.sens))) or v72
    local v73, v74 = nil, nil
    if not (a2) then
        if UserInputService_upv_1.MouseBehavior == Enum.MouseBehavior.LockCenter and UserInputService_upv_1:GetLastInputType() ~= Enum.UserInputType.Touch then
            local v75 = UserInputService_upv_1:GetMouseDelta()
            local v76 = 0.006283185307179587 * v72
            u4 = u4 - (v75.X * v76)
            u5 = u5 - (v75.Y * v76)
        end
        zero_upv_1 = zero_upv_1 + AimAssist_upv_1.TakeInjected()
        local v77, v78 = tbl_upv_1.PadLook.Step(u36, a1, u6)
        local v79 = v78 * (v72 / u10)
        local v80 = v77 * (v72 / u10) - (zero_upv_1.X * 0.01745) * v72
        v73 = (-zero_upv_1.Y * 0.01745) * 0.66 * v72
        if v73 * u5 > 0 then
            v73 = v73 * (((1 - ((math.min(math.abs(u5), 1.5707963267948966) * 2 / math.pi) ^ 0.75)) * 0.75) + 0.25)
        end
        local Apply_1 = AimAssist_upv_1.Apply
        v74 = LocalPlayer_upv_1:GetAttribute("CombatMode")
        local v81
        if v74 ~= nil then
            v81 = v74 == true
        else
            v81 = LocalPlayer_upv_1:GetAttribute("State") == "Match"
        end
        local v82 = ignoreList(LocalPlayer_upv_1.Character)
        local v83 = tbl_upv_2.fovNow()
        local v84, v85 = Apply_1(a1, v80, v79 + v73, u4, u5, v81, v82, u6, v83, tbl_upv_6.CombatDraw ~= nil)
        u4 = u4 + v84
        u5 = u5 + v85
        tbl_upv_8.touchLookPx = tbl_upv_8.touchLookPx + (math.abs(zero_upv_1.X) + math.abs(zero_upv_1.Y))
    end
    zero_upv_1 = Vector2.zero
    u4 = ((u4 + math.pi) % math.tau) - math.pi
    local v86 = u2
    for _, value_11 in tbl_upv_6 do
        if not (value_11.maxPitch) then
            continue
        end
        if value_11.maxPitch < v86 then
            v86 = value_11.maxPitch
        end
    end
    if v86 < u5 then
        u5 = u5 + (v86 - u5) * (1 - math.exp(a1 * -5))
    end
    u5 = math.clamp(u5, u1, u2)
end
local function resetToOwnCharacter()
    --[[
      name: resetToOwnCharacter
      line: 903
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        u4 (ref,  index: 2)
        u5 (ref,  index: 3)
        u27 (ref,  index: 4)
        u28 (ref,  index: 5)
        u41 (ref,  index: 6)
        u42 (ref,  index: 7)
        u44 (ref,  index: 8)
        u47 (ref,  index: 9)
    ]]
    local v87
    if LocalPlayer_upv_1 then
        v87 = LocalPlayer_upv_1.Character
    else
        v87 = LocalPlayer_upv_1
    end
    local v88
    if v87 then
        local HumanoidRootPart_3 = v87:FindFirstChild("HumanoidRootPart")
        local _ = v87:FindFirstChildOfClass("Humanoid")
        v88 = ((HumanoidRootPart_3 and (HumanoidRootPart_3:IsA("BasePart"))) and HumanoidRootPart_3) or nil
    else
        v88 = nil
    end
    if v88 then
        local _ = v88.CFrame.LookVector
        u4 = math.atan2(-v88.CFrame.LookVector.X, -v88.CFrame.LookVector.Z)
        u5 = -0.20943951023931956
    end
    u27 = nil
    u28 = nil
    u41 = nil
    u42 = nil
    u44 = 1
    u47 = nil
end
local function setLobby(a1, a2, a3)
    --[[
      name: setLobby
      line: 920
      upvalues:
        u31 (ref,  index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
        u35 (ref,  index: 3)
        CFrame_upv_1 (ref,  index: 4)
        FieldOfView_upv_1 (ref,  index: 5)
        u33 (ref,  index: 6)
        u34 (ref,  index: 7)
        tbl_upv_1 (copy, index: 8)
        u6 (ref,  index: 9)
        tbl_upv_7 (copy, index: 10)
        u18 (copy, index: 11)
        u17 (copy, index: 12)
        u29 (ref,  index: 13)
        u30 (ref,  index: 14)
        Simulation_upv_1 (copy, index: 15)
        u57 (ref,  index: 16)
        tbl_upv_14 (copy, index: 17)
        tbl_upv_15 (copy, index: 18)
        u51 (ref,  index: 19)
        u52 (ref,  index: 20)
        u53 (ref,  index: 21)
        u54 (ref,  index: 22)
        tbl_upv_16 (copy, index: 23)
        UserInputService_upv_1 (copy, index: 24)
        u4 (ref,  index: 25)
        u5 (ref,  index: 26)
        u27 (ref,  index: 27)
        u28 (ref,  index: 28)
    ]]
    u31 = a1
    local v89
    if LocalPlayer_upv_1 then
        v89 = LocalPlayer_upv_1.Character
    else
        v89 = LocalPlayer_upv_1
    end
    local v90
    if v89 then
        local HumanoidRootPart_4 = v89:FindFirstChild("HumanoidRootPart")
        local _ = v89:FindFirstChildOfClass("Humanoid")
        v90 = ((HumanoidRootPart_4 and (HumanoidRootPart_4:IsA("BasePart"))) and HumanoidRootPart_4) or nil
    else
        v90 = nil
    end
    if u35 then
        CFrame_upv_1 = a2.CFrame
        FieldOfView_upv_1 = a2.FieldOfView
        u33 = 0
        u34 = v90 and v90.Position
    end
    tbl_upv_1.PopMouseUnlock("FreeCursor")
    if a1 then
        u6 = false
        table.clear(tbl_upv_7)
        u18:Snap(Vector3.new(0, 0, 0))
        tbl_upv_1.SlowRecoil:Snap(Vector3.new(0, 0, 0))
        tbl_upv_1.SlowRecoilStay = Vector3.new(0, 0, 0)
        u17:Snap(0)
        u29 = false
        if u30 then
            Simulation_upv_1.SetFacing(nil)
            u30 = false
        end
        local _ = 0
        if u57 ~= nil then
            for v91, value_12 in tbl_upv_14 do
                local inst_4 = value_12.inst
                if not (inst_4.Parent) then
                    continue
                end
                if inst_4.LocalTransparencyModifier ~= 0 then
                    inst_4.LocalTransparencyModifier = 0
                end
            end
            for v92, value_13 in tbl_upv_15 do
                value_13:Disconnect()
            end
            table.clear(tbl_upv_15)
            table.clear(tbl_upv_14)
            u57 = nil
            u51 = true
            u52 = -1
            u53 = -1
            u54 = false
        end
        for key_4 in tbl_upv_16 do
            if key_4.Parent then
                key_4.LocalTransparencyModifier = 0
            end
        end
        table.clear(tbl_upv_16)
        if a3 and a2.CameraSubject ~= a3 then
            a2.CameraSubject = a3
        end
        a2.CameraType = Enum.CameraType.Custom
        UserInputService_upv_1.MouseBehavior = Enum.MouseBehavior.Default
        UserInputService_upv_1.MouseIconEnabled = true
    else
        local LookVector_3 = a2.CFrame.LookVector
        u4 = math.atan2(-LookVector_3.X, -LookVector_3.Z)
        u5 = math.clamp(math.asin(math.clamp(LookVector_3.Y, -1, 1)), -0.6981317007977318, 0.4363323129985824)
        u27 = nil
        u28 = nil
        u29 = false
    end
end
local function totalModifier()
    --[[
      name: totalModifier
      line: 544
      upvalues:
        tbl_upv_6 (copy, index: 1)
    ]]
    local v91 = 0
    local v92 = 0
    local v93 = Vector3.new(0, 0, 0)
    local v94 = 1
    for _, value_14 in tbl_upv_6 do
        v91 = v91 + (value_14.fov or 0)
        v92 = v92 + (value_14.distance or 0)
        v93 = v93 + (value_14.pivot or Vector3.new(0, 0, 0))
        v94 = v94 * (value_14.sensitivity or 1)
    end
    return v91, v92, v93, v94
end
local function updateLobby(a1, a2, a3, a4)
    --[[
      name: updateLobby
      line: 956
      upvalues:
        tbl_upv_4 (copy, index: 1)
        zero_upv_1 (ref,  index: 2)
        totalModifier (copy, index: 3)
        u13 (copy, index: 4)
        u8 (ref,  index: 5)
        u32 (ref,  index: 6)
        u5 (ref,  index: 7)
        u4 (ref,  index: 8)
        u33 (ref,  index: 9)
        CFrame_upv_1 (ref,  index: 10)
        u34 (ref,  index: 11)
        FieldOfView_upv_1 (ref,  index: 12)
        Smoothing_upv_1 (copy, index: 13)
        Occlusion_upv_1 (copy, index: 14)
        u45 (ref,  index: 15)
        u46 (ref,  index: 16)
        u35 (ref,  index: 17)
    ]]
    if next(tbl_upv_4) == nil then
        if a4 and a4.Parent and a2.CameraSubject ~= a4 then
            a2.CameraSubject = a4
        end
        if a2.CameraType == Enum.CameraType.Scriptable then
            a2.CameraType = Enum.CameraType.Custom
        end
        zero_upv_1 = Vector2.zero
        local v95 = totalModifier()
        u13.target = u8 + v95
        u13:Update(a1)
        local v96 = math.clamp(u13.value, 20, 110)
        local v97 = a2.CFrame
        if u32 then
            u32 = false
            local Position_1 = a2.Focus.Position
            local v98 = math.clamp((v97.Position - a2.Focus.Position).Magnitude, 6, 40)
            local v99 = CFrame.new(Position_1) * CFrame.fromEulerAnglesYXZ(u5, u4, 0) * CFrame.new(0, 0, v98)
            a2.CFrame = v99
            v97 = v99
        else
            local LookVector_4 = v97.LookVector
            u4 = math.atan2(-v97.LookVector.X, -v97.LookVector.Z)
            u5 = math.asin(math.clamp(LookVector_4.Y, -1, 1))
        end
        if u33 < 1 and CFrame_upv_1 then
            if a3 and u34 and (a3.Position - u34).Magnitude > 40 then
                u33 = 1
            else
                u33 = math.min(1, u33 + (a1 / 0.5))
                local v100 = math.clamp(u33, 0, 1)
                local v101 = v100 * v100 * (3 - (v100 * 2))
                local v102 = CFrame_upv_1:Lerp(v97, v101)
                v96 = FieldOfView_upv_1 + (v96 - FieldOfView_upv_1) * v101
                a2.CFrame = v102
            end
        end
        local v103 = Smoothing_upv_1.CameraOffset()
        if v103 ~= Vector3.new(0, 0, 0) then
            a2.CFrame = a2.CFrame + v103
            a2.Focus = a2.Focus + v103
        end
        local v104 = Occlusion_upv_1.AboveWater(a2.CFrame)
        if v104 ~= a2.CFrame then
            a2.CFrame = v104
        end
        a2.FieldOfView = v96
        u45 = v104
        u46 = v96
        u35 = true
    else
        a2.CameraType = Enum.CameraType.Scriptable
        zero_upv_1 = Vector2.zero
    end
end
local function headCrowdsCrosshair(a1, a2)
    --[[
      name: headCrowdsCrosshair
      line: 650
      upvalues:
        tbl_upv_14 (copy, index: 1)
        tbl_upv_20 (copy, index: 2)
    ]]
    local v105 = a1.ViewportSize / 2
    local v106 = ((a2 and 40) or 16) * math.max(a1.ViewportSize.Y, 200) / 768
    for _, value_15 in tbl_upv_14 do
        local inst_5 = value_15.inst
        if not (value_15.head) or not (inst_5:IsA("BasePart")) or not (inst_5.Parent) then
            continue
        end
        local CFrame_2 = inst_5.CFrame
        local v107 = math.huge
        local v108 = math.huge
        local v109 = -math.huge
        local v110 = -math.huge
        for v114, value_16 in tbl_upv_20 do
            local v111 = a1:WorldToViewportPoint(CFrame_2:PointToWorldSpace(inst_5.Size / 2 * value_16))
            if v111.Z > 0 then
                v107, v109, v108, v110 = math.min(v107, v111.X), math.max(v109, v111.X), math.min(v108, v111.Y), math.max(v110, v111.Y)
            end
        end
        if not (v107 <= v109) then
            continue
        end
        local v112 = math.max(v107 - v105.X, 0, v105.X - v109)
        local v113 = math.max(v108 - v105.Y, 0, v105.Y - v110)
        if not ((v112 * v112) + (v113 * v113) < v106 * v106) then
            continue
        end
        return true
    end
    return false
end
local function fovKickNow()
    --[[
      name: fovKickNow
      line: 207
      upvalues:
        tbl_upv_11 (copy, index: 1)
    ]]
    if tbl_upv_11.amount == 0 then
        return 0
    end
    local v114 = os.clock() - tbl_upv_11.t0
    if v114 < tbl_upv_11.rise then
        local v115 = math.clamp(v114 / tbl_upv_11.rise, 0, 1)
        return tbl_upv_11.amount * ((v115 * v115) * (3 - (v115 * 2)))
    else
        local v116 = (v114 - tbl_upv_11.rise) / tbl_upv_11.fall
        if v116 >= 1 then
            tbl_upv_11.amount = 0
            return 0
        else
            local v117 = math.clamp(v116, 0, 1)
            return tbl_upv_11.amount * (1 - ((v117 * v117) * (3 - (v117 * 2))))
        end
    end
end
local function applyShake(a1, a2, a3)
    --[[
      name: applyShake
      line: 716
      upvalues:
        tbl_upv_7 (copy, index: 1)
    ]]
    local v118 = 0
    for n_1 = #tbl_upv_7, 1, -1 do
        local v119 = tbl_upv_7[n_1]
        v119.t = v119.t + a2
        if v119.duration <= v119.t then
            table.remove(tbl_upv_7, n_1)
        else
            local _ = 1 - v119.t / v119.duration
            v118 = v118 + v119.intensity * (1 - v119.t / v119.duration) * (1 - v119.t / v119.duration)
        end
    end
    if v118 <= 0 then
        return a1
    end
    v118 = math.min(v118, 3) * (a3 or 1)
    local v120 = os.clock() * 17
    local v121 = v118 * 0.022689280275926284
    local v122 = math.noise(v120, 0.37, 1.1) * 2 * v121
    local v123 = math.noise(3.1, v120, 7.3) * 2 * v121
    local v124 = math.noise(9.2, 4.4, v120) * 1.2 * v121
    return a1 * CFrame.new((math.noise(v120, 11.3, 2.9) * 0.12) * v118, (math.noise(5.5, v120, 13.7) * 0.12) * v118, 0) * CFrame.Angles(v122, v123, v124)
end
local function update(a1)
    --[[
      name: update
      line: 1019
      upvalues:
        Guards_upv_1 (copy, index: 1)
        u11 (ref,  index: 2)
        u55 (ref,  index: 3)
        Workspace_upv_1 (copy, index: 4)
        LocalPlayer_upv_1 (copy, index: 5)
        Finite_upv_1 (copy, index: 6)
        u38 (ref,  index: 7)
        Spectate_upv_1 (copy, index: 8)
        u27 (ref,  index: 9)
        u39 (ref,  index: 10)
        u45 (ref,  index: 11)
        u40 (ref,  index: 12)
        u46 (ref,  index: 13)
        u41 (ref,  index: 14)
        u62 (ref,  index: 15)
        u63 (ref,  index: 16)
        u6 (ref,  index: 17)
        tbl_upv_7 (copy, index: 18)
        u42 (ref,  index: 19)
        u43 (ref,  index: 20)
        u44 (ref,  index: 21)
        u47 (ref,  index: 22)
        u4 (ref,  index: 23)
        u5 (ref,  index: 24)
        u28 (ref,  index: 25)
        tbl_upv_1 (copy, index: 26)
        SpectateKeys_upv_1 (copy, index: 27)
        u33 (ref,  index: 28)
        u22 (ref,  index: 29)
        u21 (ref,  index: 30)
        u31 (ref,  index: 31)
        setLobby (copy, index: 32)
        updateLobby (copy, index: 33)
        Fades_upv_1 (copy, index: 34)
        Smoothing_upv_1 (copy, index: 35)
        applyMouseBehavior (copy, index: 36)
        tbl_upv_3 (copy, index: 37)
        GuiService_upv_1 (copy, index: 38)
        totalModifier (copy, index: 39)
        tbl_upv_4 (copy, index: 40)
        readLookInput (copy, index: 41)
        zero_upv_1 (ref,  index: 42)
        u13 (copy, index: 43)
        u14 (copy, index: 44)
        u15 (copy, index: 45)
        u16 (copy, index: 46)
        u17 (copy, index: 47)
        u18 (copy, index: 48)
        tbl_upv_2 (copy, index: 49)
        u8 (ref,  index: 50)
        u9 (ref,  index: 51)
        Shoulder_upv_1 (copy, index: 52)
        u1 (ref,  index: 53)
        u2 (ref,  index: 54)
        deathView (copy, index: 55)
        u29 (ref,  index: 56)
        u30 (ref,  index: 57)
        Simulation_upv_1 (copy, index: 58)
        setCharacterFade (copy, index: 59)
        ignoreList (copy, index: 60)
        frameSubject (copy, index: 61)
        updateCharacterRotation (copy, index: 62)
        FirstPerson_upv_1 (copy, index: 63)
        applyShake (copy, index: 64)
        CFrame_upv_1 (ref,  index: 65)
        u34 (ref,  index: 66)
        FieldOfView_upv_1 (ref,  index: 67)
        u24 (ref,  index: 68)
        u20 (ref,  index: 69)
        u25 (ref,  index: 70)
        u23 (ref,  index: 71)
        cf_upv_1 (ref,  index: 72)
        u26 (ref,  index: 73)
        Occlusion_upv_1 (copy, index: 74)
        fovKickNow (copy, index: 75)
        u35 (ref,  index: 76)
        tbl_upv_9 (copy, index: 77)
        u58 (ref,  index: 78)
        updatePropFade (copy, index: 79)
        headCrowdsCrosshair (copy, index: 80)
        u19 (ref,  index: 81)
    ]]
    Guards_upv_1.Step()
    if u11 then
        if a1 == a1 and (a1 > 0) then
            a1 = math.min(a1, 0.1)
        else
            a1 = 0.016666666666666666
        end
        local CurrentCamera_1 = Workspace_upv_1.CurrentCamera
        if not CurrentCamera_1 then
            return
        end
        local v125
        if LocalPlayer_upv_1 then
            v125 = LocalPlayer_upv_1.Character
        else
            v125 = LocalPlayer_upv_1
        end
        local v126, v127, v128
        if v125 then
            local HumanoidRootPart_5 = v125:FindFirstChild("HumanoidRootPart")
            local v129 = v125:FindFirstChildOfClass("Humanoid")
            v126 = ((HumanoidRootPart_5 and (HumanoidRootPart_5:IsA("BasePart"))) and HumanoidRootPart_5) or nil
            v127, v128 = v129, v125
        else
            v128 = nil
            v126 = nil
            v127 = nil
        end
        u55 = false
        if v126 then
            v125 = v126.Position
        else
            v125 = nil
        end
        if v125 then
            local v130 = Finite_upv_1.Vector(v125)
            if not (v130) then
                Finite_upv_1.Say("own root")
                v125 = nil
            end
        end
        local v131 = v125 or u27
        u38 = Spectate_upv_1.Step(v131)
        local v135 = nil
        local v137 = nil
        if u38 ~= u38 then
            if u38 ~= "death" then
                if u38 ~= "follow" then
                    if LocalPlayer_upv_1 then
                        v135 = LocalPlayer_upv_1.Character
                    else
                        v135 = LocalPlayer_upv_1
                    end
                    if v135 then
                        local HumanoidRootPart_6 = v135:FindFirstChild("HumanoidRootPart")
                        v137 = v135:FindFirstChildOfClass("Humanoid")
                        v131 = ((HumanoidRootPart_6 and (HumanoidRootPart_6:IsA("BasePart"))) and HumanoidRootPart_6) or nil
                    else
                        v131 = nil
                    end
                    if v131 then
                        local _ = v131.CFrame.LookVector
                        u4 = math.atan2(-v131.CFrame.LookVector.X, -v131.CFrame.LookVector.Z)
                        u5 = -0.20943951023931956
                    end
                    u27 = nil
                    u28 = nil
                    u41 = nil
                    u42 = nil
                    u44 = 1
                else
                    u42 = u45
                    u43 = u46
                    u44 = 0
                end
                u47 = nil
            else
                u39 = u45
                u40 = u46
                u41 = nil
                u62 = nil
                u63 = nil
                u6 = false
                table.clear(tbl_upv_7)
            end
            if u38 ~= "follow" then
                tbl_upv_1.PopMouseUnlock("Spectate")
            else
                tbl_upv_1.PushMouseUnlock("Spectate")
            end
            SpectateKeys_upv_1.SetActive(u38 == "follow", tbl_upv_1.SpectateNext)
            u33 = 1
        end
        local v134 = false
        if u38 == "none" then
            v135 = LocalPlayer_upv_1:GetAttribute("CombatMode")
            if v135 ~= nil then
                v137 = v135 == true
            else
                v137 = LocalPlayer_upv_1:GetAttribute("State") == "Match"
            end
            v134 = not v137 and ((u22 == 0) and (u21 == 0))
        end
        if v134 ~= u31 then
            setLobby(v134, CurrentCamera_1, v127)
        end
        if u31 then
            updateLobby(a1, CurrentCamera_1, v126, v127)
            Fades_upv_1.ClearAllies()
            local v138 = Smoothing_upv_1.DrawnModel() or v128
            local v139 = v138 and (v138:FindFirstChild("Head"))
            local UpdateDecor_1 = Fades_upv_1.UpdateDecor
            local Position_2 = CurrentCamera_1.CFrame.Position
            local HumanoidRootPart_6 = not (v139) or not (v139:IsA("BasePart")) or v139.Position
            UpdateDecor_1(Position_2, HumanoidRootPart_6)
        else
            if CurrentCamera_1.CameraType ~= Enum.CameraType.Scriptable then
                CurrentCamera_1.CameraType = Enum.CameraType.Scriptable
            end
            applyMouseBehavior()
            local v140 = true
            if next(tbl_upv_3) == nil then
                v140 = GuiService_upv_1.MenuIsOpen
            end
            local v141, v142, v143, v144 = totalModifier()
            if u38 == "none" and next(tbl_upv_4) == nil then
                readLookInput(a1, v140, v144)
            else
                zero_upv_1 = Vector2.zero
            end
            if not (Finite_upv_1.Number(u4)) then
                Finite_upv_1.Say("yaw")
                u4 = 0
            end
            if not (Finite_upv_1.Number(u5)) then
                Finite_upv_1.Say("pitch")
                u5 = -0.20943951023931956
            end
            Finite_upv_1.HealSpring(u13, 70, "fov")
            Finite_upv_1.HealSpring(u14, 10.5, "distance")
            Finite_upv_1.HealSpring(u15, Vector3.new(0, 0, 0), "pivot")
            Finite_upv_1.HealSpring(u16, ((not v125) and 0) or (v125.Y), "height")
            Finite_upv_1.HealSpring(u17, 0, "dip")
            Finite_upv_1.HealSpring(u18, Vector3.new(0, 0, 0), "recoil")
            Finite_upv_1.HealSpring(tbl_upv_1.SlowRecoil, Vector3.new(0, 0, 0), "slow recoil")
            local v133 = u38 ~= "none"
            local v145
            if u6 then
                v145 = tbl_upv_2.fovNow()
            else
                v145 = ((not v133) and (u8 + v141)) or u8
            end
            u13.target = v145
            v145 = (u6 and (math.clamp(50 / tbl_upv_2.fovNow(), 1, 1.6) * 8 + v142)) or ((v133 and 10.5) or (u9 + v142))
            u14.target = v145
            if v133 then
                v145 = Vector3.new(0, 0, 0)
            else
                v145 = v143
            end
            u15.target = v145
            u13:Update(a1)
            u14:Update(a1)
            Shoulder_upv_1.Step(a1, (u6 and 2.8) or 2.9)
            u15:Update(a1)
            u17:Update(a1)
            u18:Update(a1)
            local SlowRecoil_1 = tbl_upv_1.SlowRecoil
            SlowRecoil_1.target = SlowRecoil_1.target * math.exp(-a1 / tbl_upv_1.SLOW_RECOIL_FADE)
            SlowRecoil_1:Update(a1)
            v137 = tbl_upv_1.SlowRecoilStay
            if v137.Magnitude > 1e-05 then
                local v146 = v137 * (1 - math.exp(-a1 * 14))
                u5 = math.clamp(u5 + v146.X, u1, u2)
                u4 = (((u4 + v146.Y) + math.pi) % math.tau) - math.pi
                tbl_upv_1.SlowRecoilStay = v137 - v146
            else
                tbl_upv_1.SlowRecoilStay = Vector3.new(0, 0, 0)
            end
            local v147, v148, _ = nil, nil, nil
            local v177 = nil
            if u38 == "death" then
                local v149, v150 = deathView(a1)
                v148 = v149.Position + v149.LookVector * 10
                u29 = false
                if u30 then
                    Simulation_upv_1.SetFacing(nil)
                    u30 = false
                end
                setCharacterFade(Smoothing_upv_1.DrawnModel() or v128, 0, 0)
                v145 = v150
            elseif u38 == "follow" then
                local v151 = Spectate_upv_1.GetTarget()
                local v152 = v151
                local v197 = v152 and (v151:FindFirstChild("HumanoidRootPart"))
                u29 = false
                if u30 then
                    Simulation_upv_1.SetFacing(nil)
                    u30 = false
                end
                setCharacterFade(Smoothing_upv_1.DrawnModel() or v128, 0, 0)
                if v151 and v152 and v152:IsA("BasePart") then
                    if Finite_upv_1.Vector(v152.Position) then
                        if Finite_upv_1.Vector(v152.CFrame.LookVector) or Finite_upv_1.Say("follow root") then
                            if v151 ~= u47 then
                                if u47 ~= nil then
                                    u42 = u45
                                    u43 = u46
                                    u44 = 0
                                end
                                u47 = v151
                                local LookVector_5 = v152.CFrame.LookVector
                                u4 = math.atan2(-LookVector_5.X, -LookVector_5.Z)
                                u5 = -0.17453292519943295
                            end
                            local v153 = u4
                            local LookVector_6 = v151.CFrame.LookVector
                            u4 = ((v153 + (((((math.atan2(-LookVector_6.X, -LookVector_6.Z) - u4) + math.pi) % math.tau) - math.pi) * (1 - math.exp(a1 * -4)))) + math.pi) % math.tau - math.pi
                            u5 = u5 + (-0.17453292519943295 - u5) * (1 - math.exp(a1 * -3))
                            local v154, v155 = frameSubject(a1, v151, v151.Position, ignoreList(v151))
                            v145 = math.clamp(u13.value, 20, 110)
                            v147, v148 = v154, v155
                        else
                            v147 = u45
                            v145 = u46
                            v148 = v147.Position + v147.LookVector * 10
                        end
                    elseif Finite_upv_1.Say("follow root") then
                        if v151 ~= u47 then
                            if u47 ~= nil then
                                u42 = u45
                                u43 = u46
                                u44 = 0
                            end
                            u47 = v151
                            local LookVector_5 = v152.CFrame.LookVector
                            u4 = math.atan2(-LookVector_5.X, -LookVector_5.Z)
                            u5 = -0.17453292519943295
                        end
                        local v153 = u4
                        local LookVector_6 = v151.CFrame.LookVector
                        u4 = ((v153 + (((((math.atan2(-LookVector_6.X, -LookVector_6.Z) - u4) + math.pi) % math.tau) - math.pi) * (1 - math.exp(a1 * -4)))) + math.pi) % math.tau - math.pi
                        u5 = u5 + (-0.17453292519943295 - u5) * (1 - math.exp(a1 * -3))
                        local v154, v155 = frameSubject(a1, v151, v151.Position, ignoreList(v151))
                        v145 = math.clamp(u13.value, 20, 110)
                        v147, v148 = v154, v155
                    else
                        v147 = u45
                        v145 = u46
                        v148 = v147.Position + v147.LookVector * 10
                    end
                else
                    v147 = u45
                    v145 = u46
                    v148 = v147.Position + v147.LookVector * 10
                end
                if u44 < 1 and u42 then
                    u44 = math.min(1, u44 + (a1 / 0.45))
                    local v156 = math.clamp(u44, 0, 1)
                    local v157 = v156 * v156 * (3 - (v156 * 2))
                    local v158 = u42:Lerp(v147, v157)
                    v145 = u43 + (v145 - u43) * v157
                    v147, v147 = v158, v158
                end
            elseif v126 and v128 and v125 then
                if v127 then
                    updateCharacterRotation(a1, v126, v127, v140)
                end
                local v159 = ignoreList(v128)
                local v160 = v125 + Finite_upv_1.Offset(Smoothing_upv_1)
                local v161, v162 = frameSubject(a1, v128, v160, v159)
                local v163 = (u22 == 0) and ((u21 == 0) and ((v127 ~= nil) and (v127.Health > 0)))
                local v164 = FirstPerson_upv_1.Step(a1, v163)
                u55 = v164 >= 0.5
                if v164 > 0 then
                    local Head_3 = v128:FindFirstChild("Head")
                    local StepBob_1 = FirstPerson_upv_1.StepBob
                    local v165 = (v127 ~= nil) and (v127.FloorMaterial ~= Enum.Material.Air)
                    local v166 = v128:GetAttribute("Sliding") == true
                    StepBob_1(a1, v160, v165, v166, v126.AssemblyLinearVelocity, StepBob_1)
                    v161, v162, v177 = FirstPerson_upv_1.CameraBob()
                    local Eye_1 = FirstPerson_upv_1.Eye
                    local v170 = not (Head_3) or not (Head_3:IsA("BasePart")) or Head_3
                    local v171 = Eye_1(a1, v160, v126, v170, v161.LookVector) + Vector3.new(0, (u17.value * 0.5) + v167, 0)
                    local v167 = CFrame.new(v171) * v161.Rotation * CFrame.Angles(v168, 0, v177)
                    v177 = FirstPerson_upv_1.Eased()
                    if v177 >= 1 then
                        v147 = v167
                    else
                        v147 = v161:Lerp(v167, v177)
                    end
                    v148 = v162:Lerp(v171 + (v147.LookVector * 10), v177)
                else
                    v148 = v162
                end
                local v172 = (u55 and 0.6) or 1
                local v173 = applyShake(v147, a1, v172)
                v145 = math.clamp(u13.value, 20, 110)
                if u33 < 1 and CFrame_upv_1 then
                    if (u34) and ((v126.Position - u34).Magnitude > 40) then
                        u33 = 1
                        v147, v147 = v173, v173
                    else
                        u33 = math.min(1, u33 + (a1 / 0.5))
                        local v174 = math.clamp(u33, 0, 1)
                        local v175 = v174 * v174 * (3 - (v174 * 2))
                        local v176 = CFrame_upv_1:Lerp(v173, v175)
                        v145 = FieldOfView_upv_1 + (v145 - FieldOfView_upv_1) * v175
                        v147, v147 = v176, v176
                    end
                else
                    v147, v147 = v173, v173
                end
            end
            if u22 > 0 then
                v177 = os.clock() - u24
                v126 = false
                if v177 > 0.5 then
                    v126 = false
                    if next(tbl_upv_3) == nil then
                        local v199 = u20 and u20.untilStopped
                        v126 = not u20 or not u20.untilStopped
                    end
                end
                local v178 = true
                if u25 == v128 then
                    v178 = (v127 ~= nil) and (v127.Health <= 0)
                end
                if v126 or v178 or v177 > 120 then
                    u22 = 0
                    u23 = 2.5
                end
            end
            if u21 < u22 then
                u21 = math.min(u22, u21 + (a1 * u23))
            elseif u22 < u21 then
                u21 = math.max(u22, u21 - (a1 * u23))
            end
            if u20 then
                cf_upv_1 = u20.cf
                local v179 = u20.fov or u26
                u26 = v179
            end
            if u21 > 0 then
                local v180 = math.clamp(u21, 0, 1)
                local v181 = v180 * v180 * (3 - (v180 * 2))
                local v182 = v147:Lerp(cf_upv_1, v181)
                v145 = v145 + (u26 - v145) * v181
                v147, v147 = v182, v182
            elseif u22 == 0 then
                u20 = nil
            end
            if u21 <= 0 then
                local v183 = Occlusion_upv_1.AboveWater(v147)
                v147, v147 = v183, v183
            end
            v145 = math.clamp(v145 + fovKickNow(), 20, 110)
            if Finite_upv_1.Vector(v147.Position) and Finite_upv_1.Vector(v147.LookVector) and Finite_upv_1.Number(v145) then
                local v184 = Finite_upv_1.Vector(v148)
                if not v184 then
                    v148 = v147.Position + v147.LookVector * 10
                end
            else
                Finite_upv_1.Say("view " .. u38)
                v147 = u45
                v145 = u46
                v148 = v147.Position + v147.LookVector * 10
            end
            CurrentCamera_1.CFrame = v147
            local v185
            if u21 > 0.5 then
                v185 = cf_upv_1.Position
            else
                v185 = v148
            end
            CurrentCamera_1.Focus = CFrame.new(v185)
            CurrentCamera_1.FieldOfView = v145
            u45 = v147
            u46 = v145
            u35 = true
            if tbl_upv_1.FrameLog then
                local v186 = v125 or Vector3.new(0, 0, 0)
                local v187 = v186 + Finite_upv_1.Offset(Smoothing_upv_1)
                local value_17 = u15.value
                local v188 = 0
                for v200 in tbl_upv_4 do
                    v188 = v188 + 1
                end
                local FrameLog_1 = tbl_upv_1.FrameLog
                local tbl_21 = {os.clock(), a1, v147.X, v147.Y, v147.Z, u4, u5, v145, v186.X, v186.Y, v186.Z, v187.X, v187.Y, v187.Z, u14.value, Shoulder_upv_1.Value()}
                local X_1 = value_17.X
                local Y_1 = value_17.Y
                local Z_1 = value_17.Z
                local value_18 = u16.value
                local value_19 = u17.value
                local value_20 = u13.value
                local v189 = u33
                local v190 = ((u38 == "none") and 0) or (((u38 ~= "death") and 2) or 1)
                local v191 = Shoulder_upv_1.Get()
                local v192 = ((LocalPlayer_upv_1:GetAttribute("Frozen") ~= true) and 0) or 1
                tbl_21[17], tbl_21[18], tbl_21[19], tbl_21[20], tbl_21[21], tbl_21[22], tbl_21[23], tbl_21[24], tbl_21[25], tbl_21[26], tbl_21[27], tbl_21[28] = X_1, Y_1, Z_1, value_18, value_19, value_20, v189, v190, v188, v191, v192, u18.value.Magnitude
                table.insert(FrameLog_1, tbl_21)
            end
            if u38 == "none" then
                v148 = Smoothing_upv_1.DrawnModel() or v128
                v145 = (v125 or (v147.Position)) + Finite_upv_1.Offset(Smoothing_upv_1)
                v125 = v148 and (v148:FindFirstChild("Head"))
                local v193
                if (v125) and (v125:IsA("BasePart")) then
                    v193 = v125.Position
                else
                    v193 = v145 + Vector3.new(0, 1.5, 0)
                end
                v145 = (v147.Position - v193).Magnitude
                local v194 = 0
                if v145 < 2.6 then
                    v125 = math.clamp((2.6 - v145) / 1.6, 0, 0.85)
                else
                    v125 = v194
                end
                if u20 and u20.hide then
                    v125 = math.max(v125, u21)
                end
                local v195 = 0
                if v128 and u21 < 0.5 then
                    if u55 then
                        v145 = v195
                    else
                        v145 = (headCrowdsCrosshair(CurrentCamera_1, u19) and 0.6) or v195
                    end
                else
                    v145 = v195
                end
                if v145 > 0 then
                    v185 = true
                else
                    v185 = false
                end
                u19 = v185
                tbl_upv_9.headFade = tbl_upv_9.headFade + ((v145 - tbl_upv_9.headFade) * (1 - math.exp(a1 * -12)))
                if v145 == 0 and tbl_upv_9.headFade < 0.02 then
                    tbl_upv_9.headFade = 0
                end
                local v196
                if u55 then
                    v196 = 0
                else
                    v196 = v125
                end
                setCharacterFade(v148, v196, tbl_upv_9.headFade, u55)
                Fades_upv_1.UpdateAllies(v147.Position, v193, v128)
                Fades_upv_1.UpdateDecor(v147.Position, v193)
                tbl_upv_9.propFadeFrame = tbl_upv_9.propFadeFrame + 1
                if not (u58 <= tbl_upv_9.propFadeFrame) then
                    return
                end
                tbl_upv_9.propFadeFrame = 0
                updatePropFade(v147.Position, v193, (ignoreList(v128)))
            else
                tbl_upv_9.propFadeFrame = tbl_upv_9.propFadeFrame + 1
                if u58 <= tbl_upv_9.propFadeFrame then
                    tbl_upv_9.propFadeFrame = 0
                    updatePropFade(v147.Position, v148, (ignoreList(v128)))
                end
                Fades_upv_1.ClearAllies()
                Fades_upv_1.UpdateDecor(v147.Position, v148)
            end
        end
    else
        u55 = false
    end
end
local function countTouches()
    --[[
      name: countTouches
      line: 1340
      upvalues:
        tbl_upv_10 (copy, index: 1)
    ]]
    local v197 = 0
    for _ in tbl_upv_10 do
        v197 = v197 + 1
    end
    return v197
end
local u64 = nil
local function inThumbstickArea(a1)
    --[[
      name: inThumbstickArea
      line: 1354
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        Workspace_upv_1 (copy, index: 2)
    ]]
    local v198 = LocalPlayer_upv_1:FindFirstChildOfClass("PlayerGui")
    local v199 = v198 and (v198:FindFirstChild("TouchGui"))
    if v199 and v199:IsA("ScreenGui") and v199.Enabled then
        v198 = v199:FindFirstChild("TouchControlFrame")
    else
        v198 = nil
    end
    local v200 = false
    v199 = v200
    for _, value_21 in {"DynamicThumbstickFrame", "ThumbstickFrame"} do
        local v201 = v198 and (v198:FindFirstChild(value_21))
        if not (v201) then
            continue
        end
        local v202 = v201:IsA("GuiObject")
        if not (v202) or not (v201.Visible) then
            continue
        end
        local v203 = true
        local AbsolutePosition_1 = v201.AbsolutePosition
        local v204 = AbsolutePosition_1 + v201.AbsoluteSize
        if not (AbsolutePosition_1.X <= a1.X) or not (AbsolutePosition_1.Y <= a1.Y) or not (a1.X <= v204.X) or not (a1.Y <= v204.Y) then
            v199 = v203
            continue
        end
        return true
    end
    if v199 then
        return false
    end
    local CurrentCamera_2 = Workspace_upv_1.CurrentCamera
    return (CurrentCamera_2 ~= nil) and ((a1.X < CurrentCamera_2.ViewportSize.X * 0.4) and (CurrentCamera_2.ViewportSize.Y / 3 < a1.Y))
end
local function onInputBegan(a1, a2)
    --[[
      name: onInputBegan
      line: 1378
      upvalues:
        u64 (ref,  index: 1)
        inThumbstickArea (copy, index: 2)
        tbl_upv_8 (copy, index: 3)
        tbl_upv_10 (copy, index: 4)
        u37 (ref,  index: 5)
    ]]
    if a1.UserInputType ~= Enum.UserInputType.Touch then
        return
    end
    if not (a2) then
        local v205
        if u64 then
            v205 = u64.UserInputState
        else
            v205 = nil
        end
        if v205 == Enum.UserInputState.End or v205 == Enum.UserInputState.Cancel then
            u64 = nil
        end
        if (u64) or not inThumbstickArea(a1.Position) then
            tbl_upv_10[a1] = true
            u37 = nil
        end
        u64 = a1
        tbl_upv_8.touchesIgnored = tbl_upv_8.touchesIgnored + 1
    end
end
local function onInputChanged(a1, a2)
    --[[
      name: onInputChanged
      line: 1397
      upvalues:
        tbl_upv_10 (copy, index: 1)
        Guards_upv_1 (copy, index: 2)
        zero_upv_1 (ref,  index: 3)
        u37 (ref,  index: 4)
        u9 (ref,  index: 5)
        u36 (ref,  index: 6)
    ]]
    if a1.UserInputType ~= Enum.UserInputType.Touch then
        if a1.KeyCode == Enum.KeyCode.Thumbstick2 then
            u36 = Vector2.new(a1.Position.X, a1.Position.Y)
        end
    elseif tbl_upv_10[a1] then
        Guards_upv_1.PruneTouches(tbl_upv_10)
        local v206 = 0
        for _ in tbl_upv_10 do
            v206 = v206 + 1
        end
        if v206 == 1 then
            zero_upv_1 = zero_upv_1 + Vector2.new(a1.Delta.X, a1.Delta.Y)
        elseif v206 == 2 then
            local v207 = nil
            local v208 = nil
            local v209 = v207
            for key_5 in tbl_upv_10 do
                if v209 then
                    v208 = key_5
                else
                    v209 = key_5
                end
            end
            if not v209 or not v208 then
                return
            end
            local Magnitude_1 = (Vector2.new(v209.Position.X, v209.Position.Y) - Vector2.new(v208.Position.X, v208.Position.Y)).Magnitude
            if u37 then
                u9 = math.clamp(u9 - ((Magnitude_1 - u37) * 0.03), 7, 14)
            end
            u37 = Magnitude_1
        end
    end
end
local function onInputEnded(a1, a2)
    --[[
      name: onInputEnded
      line: 1429
      upvalues:
        u64 (ref,  index: 1)
        tbl_upv_10 (copy, index: 2)
        u37 (ref,  index: 3)
        u36 (ref,  index: 4)
    ]]
    if a1.UserInputType == Enum.UserInputType.Touch then
        if a1 == u64 then
            u64 = nil
        end
        tbl_upv_10[a1] = nil
        u37 = nil
    elseif a1.KeyCode == Enum.KeyCode.Thumbstick2 then
        u36 = Vector2.zero
    end
end
local u65 = (function()
    --[[
      line: 1443
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local u66 = nil
    local v210 = function(a1, a2)
        --[[
          line: 1445
          upvalues:
            u66 (ref,  index: 1)
            LocalPlayer_upv_1 (copy, index: 2)
        ]]
        if not (u66) then
            local v211 = LocalPlayer_upv_1 and (LocalPlayer_upv_1:FindFirstChild("PlayerScripts") and (LocalPlayer_upv_1.PlayerScripts:FindFirstChild("Core")))
            local v212 = v211 and (v211:FindFirstChild("InputStats"))
            if v212 and v212:IsA("ModuleScript") then
                u66 = require(v212)
                if a2 then
                    u66.Note(a1)
                else
                    u66.Caller(a1)
                end
                return
            end
            return
        end
        if a2 then
            u66.Note(a1)
        else
            u66.Caller(a1)
        end
    end
    return v210
end)()
local u67 = 0
local u68 = -0.2
local u69 = 0
local u70 = -0.2
local u71 = 0
local u72 = -0.2
local u73 = 0
local u74 = -0.2
local u75 = 0
local u76 = -0.2
local function start()
    --[[
      name: start
      line: 1469
      upvalues:
        u12 (ref,  index: 1)
        u3 (copy, index: 2)
        Spectate_upv_1 (copy, index: 3)
        Smoothing_upv_1 (copy, index: 4)
        LocalPlayer_upv_1 (copy, index: 5)
        u58 (ref,  index: 6)
        tbl_upv_17 (copy, index: 7)
        Workspace_upv_1 (copy, index: 8)
        u4 (ref,  index: 9)
        Players_upv_1 (copy, index: 10)
        markIgnoreDirty (copy, index: 11)
        u48 (ref,  index: 12)
        Fighters_upv_1 (copy, index: 13)
        UserInputService_upv_1 (copy, index: 14)
        onInputBegan (copy, index: 15)
        onInputChanged (copy, index: 16)
        onInputEnded (copy, index: 17)
        Guards_upv_1 (copy, index: 18)
        tbl_upv_1 (copy, index: 19)
        Keybinds_upv_1 (copy, index: 20)
        ContextActionService_upv_1 (copy, index: 21)
        u31 (ref,  index: 22)
        tbl_upv_3 (copy, index: 23)
        GuiService_upv_1 (copy, index: 24)
        Shoulder_upv_1 (copy, index: 25)
        u38 (ref,  index: 26)
        u22 (ref,  index: 27)
        u21 (ref,  index: 28)
        u20 (ref,  index: 29)
        tbl_upv_9 (copy, index: 30)
        u57 (ref,  index: 31)
        tbl_upv_14 (copy, index: 32)
        tbl_upv_15 (copy, index: 33)
        u51 (ref,  index: 34)
        u52 (ref,  index: 35)
        u53 (ref,  index: 36)
        u54 (ref,  index: 37)
        u27 (ref,  index: 38)
        u28 (ref,  index: 39)
        u29 (ref,  index: 40)
        u30 (ref,  index: 41)
        Simulation_upv_1 (copy, index: 42)
        u6 (ref,  index: 43)
        tbl_upv_7 (copy, index: 44)
        u18 (copy, index: 45)
        u17 (copy, index: 46)
        u33 (ref,  index: 47)
        u5 (ref,  index: 48)
        u32 (ref,  index: 49)
        tbl_upv_4 (copy, index: 50)
        tbl_upv_10 (copy, index: 51)
        u1 (ref,  index: 52)
        u2 (ref,  index: 53)
        RunService_upv_1 (copy, index: 54)
        u76 (ref,  index: 55)
        u73 (ref,  index: 56)
        u72 (ref,  index: 57)
        u67 (ref,  index: 58)
        u68 (ref,  index: 59)
        u74 (ref,  index: 60)
        u69 (ref,  index: 61)
        u70 (ref,  index: 62)
        u71 (ref,  index: 63)
        u75 (ref,  index: 64)
        u65 (copy, index: 65)
        update (copy, index: 66)
        tbl_upv_8 (copy, index: 67)
    ]]
    if u12 or not u3 then
        return
    end
    u12 = true
    Spectate_upv_1.Start()
    Smoothing_upv_1.Start()
    pcall(
        function()
            --[[
              line: 1479
              upvalues:
                LocalPlayer_upv_1 (copy, index: 1)
            ]]
            LocalPlayer_upv_1.CameraMinZoomDistance = 6
            LocalPlayer_upv_1.CameraMaxZoomDistance = 40
        end
    )
    task.spawn(
        function()
            --[[
              line: 1483
              upvalues:
                LocalPlayer_upv_1 (copy, index: 1)
                u58 (ref,  index: 2)
                tbl_upv_17 (copy, index: 3)
            ]]
            local u77 = LocalPlayer_upv_1:WaitForChild("PlayerScripts", 30)
            if not u77 then
                return
            end
            local function readLevel_1()
                --[[
                  name: readLevel
                  line: 1488
                  upvalues:
                    u58 (ref,  index: 1)
                    tbl_upv_17 (copy, index: 2)
                    u77 (copy, index: 3)
                ]]
                u58 = tbl_upv_17[u77:GetAttribute("CharacterQualityLevel")] or 1
            end
            u58 = tbl_upv_17[u77:GetAttribute("CharacterQualityLevel")] or 1
            u77:GetAttributeChangedSignal("CharacterQualityLevel"):Connect(readLevel_1)
        end
    )
    local CurrentCamera_3 = Workspace_upv_1.CurrentCamera
    if CurrentCamera_3 then
        local _ = CurrentCamera_3.CFrame.LookVector
        u4 = math.atan2(-CurrentCamera_3.CFrame.LookVector.X, -CurrentCamera_3.CFrame.LookVector.Z)
    end
    for _, value_22 in Players_upv_1:GetPlayers() do
        value_22.CharacterAdded:Connect(markIgnoreDirty)
        value_22.CharacterRemoving:Connect(markIgnoreDirty)
    end
    Players_upv_1.PlayerAdded:Connect(
        function(a1)
            --[[
              line: 1501
              upvalues:
                markIgnoreDirty (copy, index: 1)
                u48 (ref,  index: 2)
            ]]
            a1.CharacterAdded:Connect(markIgnoreDirty)
            a1.CharacterRemoving:Connect(markIgnoreDirty)
            u48 = true
        end
    )
    Players_upv_1.PlayerRemoving:Connect(markIgnoreDirty)
    Fighters_upv_1.OnTaggedChanged(markIgnoreDirty)
    UserInputService_upv_1.InputBegan:Connect(onInputBegan)
    UserInputService_upv_1.InputChanged:Connect(onInputChanged)
    UserInputService_upv_1.InputEnded:Connect(onInputEnded)
    task.spawn(
        function()
            --[[
              line: 1511
              upvalues:
                Guards_upv_1 (copy, index: 1)
                tbl_upv_1 (copy, index: 2)
            ]]
            local TextChatService_1 = game:GetService("TextChatService")
            local u78 = TextChatService_1:FindFirstChildOfClass("ChatInputBarConfiguration") or (TextChatService_1:WaitForChild("ChatInputBarConfiguration", 10))
            if not u78 or not u78:IsA("ChatInputBarConfiguration") then
                return
            end
            Guards_upv_1.SetChatConfig(u78)
            u78:GetPropertyChangedSignal("IsFocused"):Connect(
                function()
                    --[[
                      line: 1516
                      upvalues:
                        u78 (copy, index: 1)
                        tbl_upv_1 (copy, index: 2)
                    ]]
                    if u78.IsFocused then
                        tbl_upv_1.PushMouseUnlock("ChatFocus")
                    else
                        tbl_upv_1.PopMouseUnlock("ChatFocus")
                    end
                end
            )
        end
    )
    UserInputService_upv_1.TextBoxFocused:Connect(
        function()
            --[[
              line: 1525
              upvalues:
                tbl_upv_1 (copy, index: 1)
            ]]
            tbl_upv_1.PushMouseUnlock("TextBox")
        end
    )
    UserInputService_upv_1.TextBoxFocusReleased:Connect(
        function()
            --[[
              line: 1528
              upvalues:
                tbl_upv_1 (copy, index: 1)
            ]]
            tbl_upv_1.PopMouseUnlock("TextBox")
        end
    )
    local function bindKeys_upv_1()
        --[[
          name: bindKeys
          line: 1538
          upvalues:
            Keybinds_upv_1 (copy, index: 1)
            ContextActionService_upv_1 (copy, index: 2)
            Guards_upv_1 (copy, index: 3)
            u31 (ref,  index: 4)
            tbl_upv_3 (copy, index: 5)
            tbl_upv_1 (copy, index: 6)
            GuiService_upv_1 (copy, index: 7)
            Shoulder_upv_1 (copy, index: 8)
            u38 (ref,  index: 9)
        ]]
        local v213 = Keybinds_upv_1.Inputs("FreeCursor")
        if #v213 ~= 0 then
            ContextActionService_upv_1:BindActionAtPriority(
                "TribesFreeCursor",
                function(a2, a3, a4)
                    --[[
                      line: 1543
                      upvalues:
                        Guards_upv_1 (copy, index: 1)
                        u31 (ref,  index: 2)
                        tbl_upv_3 (copy, index: 3)
                        tbl_upv_1 (copy, index: 4)
                    ]]
                    if a3 == Enum.UserInputState.Begin then
                        Guards_upv_1.FreeKeyDown(a4)
                    elseif a3 ~= Enum.UserInputState.End then
                        Guards_upv_1.FreeKeyCancel()
                    elseif Guards_upv_1.FreeKeyUp() and not (u31) then
                        if tbl_upv_3.FreeCursor then
                            tbl_upv_1.PopMouseUnlock("FreeCursor")
                        else
                            tbl_upv_1.PushMouseUnlock("FreeCursor")
                        end
                    end
                    return Enum.ContextActionResult.Pass
                end,
                false,
                Enum.ContextActionPriority.Low.Value,
                table.unpack(v213)
            )
        else
            ContextActionService_upv_1:UnbindAction("TribesFreeCursor")
        end
        local v214 = Keybinds_upv_1.Inputs("Shoulder")
        for _, value_23 in Keybinds_upv_1.PadInputs("Shoulder") do
            table.insert(v214, value_23)
        end
        local v215 = Keybinds_upv_1.Inputs("View")
        for _, value_24 in Keybinds_upv_1.PadInputs("View") do
            table.insert(v215, value_24)
        end
        local function inputsOf_1(a5)
            --[[
              name: inputsOf
              line: 1562
              upvalues:
                Keybinds_upv_1 (copy, index: 1)
            ]]
            local v216 = Keybinds_upv_1.Inputs(a5)
            for _, value_25 in Keybinds_upv_1.PadInputs(a5) do
                table.insert(v216, value_25)
            end
            return v216
        end
        ContextActionService_upv_1:UnbindAction("TribesShoulderSwap")
        ContextActionService_upv_1:UnbindAction("TribesFirstPerson")
        if #v214 > 0 then
            ContextActionService_upv_1:BindActionAtPriority(
                "TribesShoulderSwap",
                function(a6, a7)
                    --[[
                      line: 1573
                      upvalues:
                        tbl_upv_3 (copy, index: 1)
                        GuiService_upv_1 (copy, index: 2)
                        u31 (ref,  index: 3)
                        Shoulder_upv_1 (copy, index: 4)
                    ]]
                    if a7 == Enum.UserInputState.Begin then
                        local v217 = true
                        if next(tbl_upv_3) == nil then
                            v217 = GuiService_upv_1.MenuIsOpen
                        end
                        if not (v217) and not (u31) then
                            Shoulder_upv_1.Toggle()
                        end
                    end
                    return Enum.ContextActionResult.Pass
                end,
                false,
                Enum.ContextActionPriority.Low.Value,
                table.unpack(v214)
            )
        end
        if not (#v215 > 0) then
            return
        end
        ContextActionService_upv_1:BindActionAtPriority(
            "TribesFirstPerson",
            function(a8, a9)
                --[[
                  line: 1581
                  upvalues:
                    tbl_upv_3 (copy, index: 1)
                    GuiService_upv_1 (copy, index: 2)
                    u31 (ref,  index: 3)
                    u38 (ref,  index: 4)
                    tbl_upv_1 (copy, index: 5)
                ]]
                if a9 == Enum.UserInputState.Begin then
                    local v218 = true
                    if next(tbl_upv_3) == nil then
                        v218 = GuiService_upv_1.MenuIsOpen
                    end
                    if not (v218) and not (u31) and u38 == "none" then
                        tbl_upv_1.ToggleFirstPerson()
                    end
                end
                return Enum.ContextActionResult.Pass
            end,
            false,
            Enum.ContextActionPriority.Low.Value,
            table.unpack(v215)
        )
    end
    bindKeys_upv_1()
    local function rebindFor_1(a10)
        --[[
          name: rebindFor
          line: 1590
          upvalues:
            bindKeys_upv_1 (copy, index: 1)
        ]]
        for _, value_26 in a10 do
            if value_26 ~= "FreeCursor" and value_26 ~= "Shoulder" and value_26 ~= "View" then
                continue
            end
            bindKeys_upv_1()
            return
        end
    end
    Keybinds_upv_1.Changed:Connect(rebindFor_1)
    Keybinds_upv_1.PadChanged:Connect(rebindFor_1)
    LocalPlayer_upv_1.CharacterAdded:Connect(
        function(a11)
            --[[
              line: 1600
              upvalues:
                u22 (ref,  index: 1)
                u21 (ref,  index: 2)
                u20 (ref,  index: 3)
                tbl_upv_9 (copy, index: 4)
                u57 (ref,  index: 5)
                tbl_upv_14 (copy, index: 6)
                tbl_upv_15 (copy, index: 7)
                u51 (ref,  index: 8)
                u52 (ref,  index: 9)
                u53 (ref,  index: 10)
                u54 (ref,  index: 11)
                u27 (ref,  index: 12)
                u28 (ref,  index: 13)
                u29 (ref,  index: 14)
                u30 (ref,  index: 15)
                Simulation_upv_1 (copy, index: 16)
                u6 (ref,  index: 17)
                tbl_upv_7 (copy, index: 18)
                u18 (copy, index: 19)
                tbl_upv_1 (copy, index: 20)
                u17 (copy, index: 21)
                u33 (ref,  index: 22)
                u4 (ref,  index: 23)
                u5 (ref,  index: 24)
                u32 (ref,  index: 25)
                u31 (ref,  index: 26)
            ]]
            u22 = 0
            u21 = 0
            u20 = nil
            tbl_upv_9.headFade = 0
            local _ = 0
            if u57 ~= nil then
                for v220, value_27 in tbl_upv_14 do
                    local inst_6 = value_27.inst
                    if not (inst_6.Parent) then
                        continue
                    end
                    if inst_6.LocalTransparencyModifier ~= 0 then
                        inst_6.LocalTransparencyModifier = 0
                    end
                end
                for v221, value_28 in tbl_upv_15 do
                    value_28:Disconnect()
                end
                table.clear(tbl_upv_15)
                table.clear(tbl_upv_14)
                u57 = nil
                u51 = true
                u52 = -1
                u53 = -1
                u54 = false
            end
            for v222, value_29 in a11:GetDescendants() do
                if value_29:IsA("BasePart") or value_29:IsA("Decal") then
                    value_29.LocalTransparencyModifier = 0
                end
            end
            u27 = nil
            u28 = nil
            u29 = false
            u30 = false
            Simulation_upv_1.SetFacing(nil)
            u57 = nil
            u6 = false
            table.clear(tbl_upv_7)
            u18:Snap(Vector3.new(0, 0, 0))
            tbl_upv_1.SlowRecoil:Snap(Vector3.new(0, 0, 0))
            tbl_upv_1.SlowRecoilStay = Vector3.new(0, 0, 0)
            u17:Snap(0)
            u33 = 1
            tbl_upv_1.PopMouseUnlock("FreeCursor")
            local u79 = a11:WaitForChild("HumanoidRootPart", 5)
            if not u79 then
                return
            end
            if u79:IsA("BasePart") then
                local LookVector_7 = u79.CFrame.LookVector
                local v219 = math.atan2(-LookVector_7.X, -LookVector_7.Z)
                u4 = v219
                u5 = -0.20943951023931956
                u32 = u31
                local u80 = os.clock()
                local Position_upv_3 = u79.Position
                task.spawn(
                    function()
                        --[[
                          line: 1635
                          upvalues:
                            u80 (copy, index: 1)
                            u79 (copy, index: 2)
                            Position_upv_3 (ref,  index: 3)
                            u4 (ref,  index: 4)
                            u5 (ref,  index: 5)
                            u32 (ref,  index: 6)
                            u31 (ref,  index: 7)
                        ]]
                        while os.clock() - u80 < 1.5 and (u79.Parent) do
                            task.wait(0.05)
                            if (u79.Position - Position_upv_3).Magnitude > 40 then
                                local _ = u79.CFrame.LookVector
                                u4 = math.atan2(-u79.CFrame.LookVector.X, -u79.CFrame.LookVector.Z)
                                u5 = -0.20943951023931956
                                u32 = u31
                            end
                            Position_upv_3 = u79.Position
                        end
                    end
                )
            end
        end
    )
    local function popUnlock_1(a12)
        --[[
          name: popUnlock
          line: 1655
          upvalues:
            tbl_upv_1 (copy, index: 1)
        ]]
        tbl_upv_1.PopMouseUnlock(a12)
    end
    local function popLookLock_1(a13)
        --[[
          name: popLookLock
          line: 1652
          upvalues:
            tbl_upv_1 (copy, index: 1)
        ]]
        tbl_upv_1.PopLookLock(a13)
    end
    local function blockers_1()
        --[[
          name: blockers
          line: 1658
          upvalues:
            tbl_upv_1 (copy, index: 1)
        ]]
        return tbl_upv_1.GetLookBlockers()
    end
    Guards_upv_1.Start({lookLocks = tbl_upv_4, unlockReasons = tbl_upv_3, touches = tbl_upv_10, popLookLock = popLookLock_1, popUnlock = popUnlock_1, blockers = blockers_1})
    local tbl_upv_22 = {u1, u2}
    RunService_upv_1:BindToRenderStep(
        "TribesCamera",
        Enum.RenderPriority.Camera.Value + 1,
        function(a14)
            --[[
              line: 1663
              upvalues:
                u76 (ref,  index: 1)
                u73 (ref,  index: 2)
                u72 (ref,  index: 3)
                u67 (ref,  index: 4)
                u2 (ref,  index: 5)
                tbl_upv_22 (copy, index: 6)
                u68 (ref,  index: 7)
                u74 (ref,  index: 8)
                u69 (ref,  index: 9)
                u1 (ref,  index: 10)
                u70 (ref,  index: 11)
                u71 (ref,  index: 12)
                u75 (ref,  index: 13)
                u65 (copy, index: 14)
                update (copy, index: 15)
                Simulation_upv_1 (copy, index: 16)
                u4 (ref,  index: 17)
                tbl_upv_8 (copy, index: 18)
            ]]
            local v220 = os.clock()
            if u76 ~= -0.2 or u73 ~= 0 or u72 ~= -0.2 or u67 ~= 0 or u2 ~= tbl_upv_22[2] or u68 ~= -0.2 or u74 ~= -0.2 or u69 ~= 0 or u1 ~= tbl_upv_22[1] or u70 ~= -0.2 or u71 ~= 0 or u75 ~= 0 then
                u67 = 0
                u68 = -0.2
                u69 = 0
                u70 = -0.2
                u71 = 0
                u72 = -0.2
                u73 = 0
                u74 = -0.2
                u75 = 0
                u76 = -0.2
                u1 = tbl_upv_22[1]
                u2 = tbl_upv_22[2]
                u65(256, true)
            end
            update(a14)
            Simulation_upv_1.SetLook(u4)
            local v221 = os.clock() - v220
            tbl_upv_8.time = tbl_upv_8.time + v221
            tbl_upv_8.frames = tbl_upv_8.frames + 1
            tbl_upv_8.max = math.max(tbl_upv_8.max, v221)
        end
    )
end
local function SetAiming(a1, a2)
    --[[
      name: SetAiming
      line: 1702
      upvalues:
        u6 (ref, index: 1)
        u38 (ref, index: 2)
        u7 (ref, index: 3)
    ]]
    local v222 = (a1 == true) and (u38 == "none")
    u6 = v222
    if u6 then
        local v223 = typeof(a2) ~= "number" and 50 or math.clamp(a2, 20, 90)
        u7 = v223
    end
end
tbl_upv_1.SetAiming = SetAiming
function tbl_upv_1.IsAiming()
    --[[
      name: IsAiming
      line: 1709
      upvalues:
        u6 (ref, index: 1)
    ]]
    return u6
end
function tbl_upv_1.GetAimRay()
    --[[
      name: GetAimRay
      line: 1715
      upvalues:
        Workspace_upv_1 (copy, index: 1)
    ]]
    local CurrentCamera_4 = Workspace_upv_1.CurrentCamera
    if not CurrentCamera_4 then
        return Ray.new(Vector3.new(0, 0, 0), Vector3.new(0, 0, -1))
    end
    local CFrame_3 = CurrentCamera_4.CFrame
    return Ray.new(CFrame_3.Position, CFrame_3.LookVector)
end
function tbl_upv_1.GetAimPoint(a1, a2)
    --[[
      name: GetAimPoint
      line: 1728
      upvalues:
        tbl_upv_1 (copy, index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
        tbl_upv_13 (copy, index: 3)
        Workspace_upv_1 (copy, index: 4)
    ]]
    local v224 = tbl_upv_1.GetAimRay()
    local v225
    if LocalPlayer_upv_1 then
        v225 = LocalPlayer_upv_1.Character
    else
        v225 = LocalPlayer_upv_1
    end
    local Origin_1 = v224.Origin
    local v226
    if LocalPlayer_upv_1 then
        v226 = LocalPlayer_upv_1.Character
    else
        v226 = LocalPlayer_upv_1
    end
    local v227
    if v226 then
        local HumanoidRootPart_7 = v226:FindFirstChild("HumanoidRootPart")
        local _ = v226:FindFirstChildOfClass("Humanoid")
        v227 = ((HumanoidRootPart_7 and (HumanoidRootPart_7:IsA("BasePart"))) and HumanoidRootPart_7) or nil
    else
        v227 = nil
    end
    if v227 then
        local v228 = (v227.Position - Origin_1):Dot(v224.Direction)
        Origin_1 = ((v228 > 0) and (Origin_1 + v224.Direction * math.max(0, v228 - 1.5))) or Origin_1
    end
    local tbl_23 = {}
    if v225 then
        table.insert(tbl_23, v225)
    end
    for _, value_30 in tbl_upv_13 do
        local v229 = Workspace_upv_1:FindFirstChild(value_30)
        if v229 then
            table.insert(tbl_23, v229)
        end
    end
    if a2 then
        for _, value_31 in a2 do
            table.insert(tbl_23, value_31)
        end
    end
    local v230 = RaycastParams.new()
    v230.FilterType = Enum.RaycastFilterType.Exclude
    v230.FilterDescendantsInstances = tbl_23
    v230.IgnoreWater = true
    local v231 = (a1 or 1000) - (Origin_1 - v224.Origin).Magnitude
    local v232 = Workspace_upv_1:Raycast(Origin_1, v224.Direction * v231, v230)
    if v232 then
        return v232.Position, v232
    end
    return Origin_1 + (v224.Direction * v231), nil
end
function tbl_upv_1.FovKick(a1, a2, a3)
    --[[
      name: FovKick
      line: 1769
      upvalues:
        tbl_upv_11 (copy, index: 1)
    ]]
    if typeof(a1) ~= "number" or a1 ~= a1 then
        return
    end
    tbl_upv_11.amount = math.clamp(a1, -20, 20)
    tbl_upv_11.t0 = os.clock()
    tbl_upv_11.rise = math.max(a2 or 0.05, 0.01)
    tbl_upv_11.fall = math.max(a3 or 0.2, 0.01)
end
function tbl_upv_1.Shake(a1, a2)
    --[[
      name: Shake
      line: 1781
      upvalues:
        tbl_upv_7 (copy, index: 1)
    ]]
    if typeof(a1) ~= "number" or typeof(a2) ~= "number" then
        return
    end
    if not (a1 <= 0) and not (a2 <= 0) then
        if #tbl_upv_7 > 24 then
            table.remove(tbl_upv_7, 1)
        end
        table.insert(tbl_upv_7, {t = 0, intensity = math.min(a1, 3), duration = math.min(a2, 5)})
        return
    end
end
function tbl_upv_1.Recoil(a1, a2, a3)
    --[[
      name: Recoil
      line: 1795
      upvalues:
        u18 (copy, index: 1)
    ]]
    u18:Impulse(Vector3.new(math.rad(a1), math.rad(a2 or 0), math.rad(a3 or 0)) * 12)
end
tbl_upv_1.SlowRecoil = Spring_1.new(Vector3.new(0, 0, 0), 8, 1)
tbl_upv_1.SlowRecoilStay = Vector3.new(0, 0, 0)
tbl_upv_1.SLOW_RECOIL_FADE = 0.3
function tbl_upv_1.RecoilSlow(a1, a2, a3, a4)
    --[[
      name: RecoilSlow
      line: 1808
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local SlowRecoil_2 = tbl_upv_1.SlowRecoil
    local v233 = SlowRecoil_2.target + Vector3.new(math.rad(a1), math.rad(a2 or 0), 0)
    SlowRecoil_2.target = Vector3.new(math.clamp(v233.X, -0.4363323129985824, 0.4363323129985824), math.clamp(v233.Y, -0.4363323129985824, 0.4363323129985824), 0)
    tbl_upv_1.SlowRecoilStay = tbl_upv_1.SlowRecoilStay + Vector3.new(math.rad(a3 or 0), math.rad(a4 or 0), 0)
end
function tbl_upv_1.Dip(a1)
    --[[
      name: Dip
      line: 1817
      upvalues:
        u17 (copy, index: 1)
    ]]
    if typeof(a1) ~= "number" then
        return
    end
    u17:Impulse(-math.clamp(a1, -3, 3) * 6)
end
function tbl_upv_1.PushMouseUnlock(a1)
    --[[
      name: PushMouseUnlock
      line: 1824
      upvalues:
        tbl_upv_3 (copy, index: 1)
        u12 (ref,  index: 2)
        applyMouseBehavior (copy, index: 3)
    ]]
    tbl_upv_3[tostring(a1)] = true
    if not u12 then
        return
    end
    applyMouseBehavior()
end
function tbl_upv_1.PopMouseUnlock(a1)
    --[[
      name: PopMouseUnlock
      line: 1831
      upvalues:
        tbl_upv_3 (copy, index: 1)
        u12 (ref,  index: 2)
        applyMouseBehavior (copy, index: 3)
    ]]
    tbl_upv_3[tostring(a1)] = nil
    if not u12 then
        return
    end
    applyMouseBehavior()
end
function tbl_upv_1.PushLookLock(a1, a2)
    --[[
      name: PushLookLock
      line: 1844
      upvalues:
        tbl_upv_4 (copy, index: 1)
        Guards_upv_1 (copy, index: 2)
    ]]
    local str_1 = tostring(a1)
    tbl_upv_4[str_1] = true
    Guards_upv_1.LockPushed(str_1, a2)
end
function tbl_upv_1.PopLookLock(a1)
    --[[
      name: PopLookLock
      line: 1850
      upvalues:
        tbl_upv_4 (copy, index: 1)
        Guards_upv_1 (copy, index: 2)
    ]]
    local str_2 = tostring(a1)
    tbl_upv_4[str_2] = nil
    Guards_upv_1.LockPopped(str_2)
end
function tbl_upv_1.IsLookLocked()
    --[[
      name: IsLookLocked
      line: 1856
      upvalues:
        tbl_upv_4 (copy, index: 1)
    ]]
    local v234 = next(tbl_upv_4) ~= nil
    return v234
end
function tbl_upv_1.GetLookBlockers()
    --[[
      name: GetLookBlockers
      line: 1864
      upvalues:
        u11 (ref,  index: 1)
        u31 (ref,  index: 2)
        u38 (ref,  index: 3)
        u22 (ref,  index: 4)
        u21 (ref,  index: 5)
        tbl_upv_4 (copy, index: 6)
        tbl_upv_3 (copy, index: 7)
        GuiService_upv_1 (copy, index: 8)
    ]]
    local tbl_24 = {}
    if not (u11) then
        table.insert(tbl_24, "disabled")
    end
    if u31 then
        table.insert(tbl_24, "lobby")
    end
    if u38 ~= "none" then
        table.insert(tbl_24, "spectate:" .. u38)
    end
    if u22 > 0 or u21 > 0 then
        table.insert(tbl_24, "cinematic")
    end
    for key_6 in tbl_upv_4 do
        table.insert(tbl_24, "lock:" .. key_6)
    end
    for key_7 in tbl_upv_3 do
        table.insert(tbl_24, "unlock:" .. key_7)
    end
    if GuiService_upv_1.MenuIsOpen then
        table.insert(tbl_24, "robloxMenu")
    end
    table.sort(tbl_24)
    return tbl_24
end
function tbl_upv_1.IsMouseUnlocked()
    --[[
      name: IsMouseUnlocked
      line: 1893
      upvalues:
        tbl_upv_3 (copy, index: 1)
        GuiService_upv_1 (copy, index: 2)
    ]]
    local v235 = true
    if next(tbl_upv_3) == nil then
        v235 = GuiService_upv_1.MenuIsOpen
    end
    return v235
end
function tbl_upv_1.GetMode()
    --[[
      name: GetMode
      line: 1899
      upvalues:
        u31 (ref, index: 1)
    ]]
    if u31 then
        return "lobby"
    end
    return "combat"
end
function tbl_upv_1.GetUnlockReasons()
    --[[
      name: GetUnlockReasons
      line: 1903
      upvalues:
        tbl_upv_3 (copy, index: 1)
    ]]
    local tbl_25 = {}
    for key_8 in tbl_upv_3 do
        table.insert(tbl_25, key_8)
    end
    return tbl_25
end
function tbl_upv_1.GetShoulderSide()
    --[[
      name: GetShoulderSide
      line: 1912
      upvalues:
        Shoulder_upv_1 (copy, index: 1)
    ]]
    return Shoulder_upv_1.Get()
end
tbl_upv_1.FirstPersonChanged = u56.Event
function tbl_upv_1.SetFirstPerson(a1)
    --[[
      name: SetFirstPerson
      line: 1920
      upvalues:
        FirstPerson_upv_1 (copy, index: 1)
        u56 (copy, index: 2)
    ]]
    a1 = a1 == true
    if FirstPerson_upv_1.Get() == a1 then
        return
    end
    FirstPerson_upv_1.Set(a1)
    u56:Fire(a1)
end
function tbl_upv_1.IsFirstPerson()
    --[[
      name: IsFirstPerson
      line: 1928
      upvalues:
        FirstPerson_upv_1 (copy, index: 1)
    ]]
    return FirstPerson_upv_1.Get()
end
function tbl_upv_1.ToggleFirstPerson()
    --[[
      name: ToggleFirstPerson
      line: 1932
      upvalues:
        tbl_upv_1 (copy, index: 1)
        FirstPerson_upv_1 (copy, index: 2)
    ]]
    tbl_upv_1.SetFirstPerson(not FirstPerson_upv_1.Get())
end
function tbl_upv_1.InFirstPerson()
    --[[
      name: InFirstPerson
      line: 1937
      upvalues:
        u55 (ref, index: 1)
    ]]
    return u55
end
function tbl_upv_1.SetViewBobbing(a1)
    --[[
      name: SetViewBobbing
      line: 1943
      upvalues:
        FirstPerson_upv_1 (copy, index: 1)
    ]]
    FirstPerson_upv_1.SetBobbing(a1)
end
function tbl_upv_1.GetViewBobbing()
    --[[
      name: GetViewBobbing
      line: 1947
      upvalues:
        FirstPerson_upv_1 (copy, index: 1)
    ]]
    return FirstPerson_upv_1.GetBobbing()
end
function tbl_upv_1.GetViewBob()
    --[[
      name: GetViewBob
      line: 1953
      upvalues:
        FirstPerson_upv_1 (copy, index: 1)
    ]]
    return FirstPerson_upv_1.Bob()
end
function tbl_upv_1.SetShoulderSide(a1)
    --[[
      name: SetShoulderSide
      line: 1959
      upvalues:
        Shoulder_upv_1 (copy, index: 1)
    ]]
    Shoulder_upv_1.Set(a1)
end
function tbl_upv_1.SetModifier(a1, a2)
    --[[
      name: SetModifier
      line: 1964
      upvalues:
        tbl_upv_6 (copy, index: 1)
    ]]
    tbl_upv_6[a1] = a2
end
function tbl_upv_1.SuspendCharacterRotation(a1)
    --[[
      name: SuspendCharacterRotation
      line: 1969
      upvalues:
        tbl_upv_5 (copy, index: 1)
    ]]
    tbl_upv_5[tostring(a1)] = true
end
function tbl_upv_1.ResumeCharacterRotation(a1)
    --[[
      name: ResumeCharacterRotation
      line: 1973
      upvalues:
        tbl_upv_5 (copy, index: 1)
    ]]
    tbl_upv_5[tostring(a1)] = nil
end
function tbl_upv_1.FaceCamera()
    --[[
      name: FaceCamera
      line: 1979
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        u31 (ref,  index: 2)
        u30 (ref,  index: 3)
        Simulation_upv_1 (copy, index: 4)
        u4 (ref,  index: 5)
    ]]
    local v236
    if LocalPlayer_upv_1 then
        v236 = LocalPlayer_upv_1.Character
    else
        v236 = LocalPlayer_upv_1
    end
    local v237, v238
    if v236 then
        local HumanoidRootPart_8 = v236:FindFirstChild("HumanoidRootPart")
        local v239 = v236:FindFirstChildOfClass("Humanoid")
        v237 = ((HumanoidRootPart_8 and (HumanoidRootPart_8:IsA("BasePart"))) and HumanoidRootPart_8) or nil
        v238 = v239
    else
        v237 = nil
        v238 = nil
    end
    if not v237 or not v238 or not (v238.Health > 0) or u31 ~= false then
        return
    end
    u30 = true
    Simulation_upv_1.SetFacing(u4)
end
function tbl_upv_1.GetAimAssistShot()
    --[[
      name: GetAimAssistShot
      line: 1997
      upvalues:
        AimAssist_upv_1 (copy, index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
        ignoreList (copy, index: 3)
        u4 (ref,  index: 4)
        u5 (ref,  index: 5)
        u6 (ref,  index: 6)
        tbl_upv_2 (copy, index: 7)
        tbl_upv_6 (copy, index: 8)
    ]]
    if AimAssist_upv_1.IsEnabled() then
        local v240 = LocalPlayer_upv_1:GetAttribute("CombatMode")
        local v241
        if v240 ~= nil then
            v241 = v240 == true
        else
            v241 = LocalPlayer_upv_1:GetAttribute("State") == "Match"
        end
        if v241 then
            local Shot_1 = AimAssist_upv_1.Shot
            local v242 = ignoreList(LocalPlayer_upv_1.Character)
            local v243 = tbl_upv_2.fovNow()
            return Shot_1(v242, u4, u5, u6, v243, tbl_upv_6.CombatDraw ~= nil)
        end
    end
    return nil
end
function tbl_upv_1.GetAimAssist(a1)
    --[[
      name: GetAimAssist
      line: 2004
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v244 = tbl_upv_1.GetAimAssistShot()
    if v244 then
        if a1 ~= nil and a1 < v244.deg then
            return nil, nil, nil
        end
        return v244.model, v244.part, v244.deg
    end
    return nil, nil, nil
end
function tbl_upv_1.IsAssistedInput()
    --[[
      name: IsAssistedInput
      line: 2012
      upvalues:
        AimAssist_upv_1 (copy, index: 1)
    ]]
    return AimAssist_upv_1.IsAssistedInput()
end
function tbl_upv_1.GetAimAssistInput()
    --[[
      name: GetAimAssistInput
      line: 2016
      upvalues:
        AimAssist_upv_1 (copy, index: 1)
    ]]
    return AimAssist_upv_1.InputKind()
end
function tbl_upv_1.Nudge(a1, a2)
    --[[
      name: Nudge
      line: 2020
      upvalues:
        u4 (ref,  index: 1)
        AimAssist_upv_1 (copy, index: 2)
    ]]
    if typeof(a1) ~= "number" or a1 ~= a1 then
        return
    end
    if (a2 or 0) <= 0 then
        u4 = (((u4 + a1) + math.pi) % math.tau) - math.pi
    else
        AimAssist_upv_1.Nudge(a1, a2)
    end
end
function tbl_upv_1.SetAimAssist(a1)
    --[[
      name: SetAimAssist
      line: 2031
      upvalues:
        AimAssist_upv_1 (copy, index: 1)
    ]]
    AimAssist_upv_1.SetEnabled(a1)
end
function tbl_upv_1.GetAimAssistEnabled()
    --[[
      name: GetAimAssistEnabled
      line: 2035
      upvalues:
        AimAssist_upv_1 (copy, index: 1)
    ]]
    return AimAssist_upv_1.IsEnabled()
end
function tbl_upv_1.AimAssistDebug(a1, ...)
    --[[
      name: AimAssistDebug
      line: 2039
      upvalues:
        AimAssist_upv_1 (copy, index: 1)
    ]]
    return AimAssist_upv_1.Debug(a1, ...)
end
function tbl_upv_1.GetYaw()
    --[[
      name: GetYaw
      line: 2043
      upvalues:
        u4 (ref, index: 1)
    ]]
    return u4
end
function tbl_upv_1.GetPitch()
    --[[
      name: GetPitch
      line: 2047
      upvalues:
        u5 (ref, index: 1)
    ]]
    return u5
end
function tbl_upv_1.SetSensitivity(a1)
    --[[
      name: SetSensitivity
      line: 2053
      upvalues:
        u10 (ref, index: 1)
    ]]
    if typeof(a1) ~= "number" then
        return
    end
    u10 = math.clamp(a1, 0.05, 5)
end
function tbl_upv_1.AddTouchLook(a1)
    --[[
      name: AddTouchLook
      line: 2061
      upvalues:
        zero_upv_1 (ref, index: 1)
    ]]
    zero_upv_1 = zero_upv_1 + a1
end
function tbl_upv_1.GetSensitivity()
    --[[
      name: GetSensitivity
      line: 2065
      upvalues:
        u10 (ref, index: 1)
    ]]
    return u10
end
function tbl_upv_1.SetFOV(a1)
    --[[
      name: SetFOV
      line: 2070
      upvalues:
        u8 (ref, index: 1)
    ]]
    if typeof(a1) ~= "number" then
        return
    end
    u8 = math.clamp(a1, 60, 100)
end
function tbl_upv_1.GetFOV()
    --[[
      name: GetFOV
      line: 2076
      upvalues:
        u8 (ref, index: 1)
    ]]
    return u8
end
function tbl_upv_1.SetAimZoom(a1)
    --[[
      name: SetAimZoom
      line: 2081
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    if typeof(a1) ~= "number" or a1 ~= a1 then
        return
    end
    tbl_upv_2.zoom = math.clamp(a1, 0, 1)
end
function tbl_upv_1.SetAimSensitivity(a1)
    --[[
      name: SetAimSensitivity
      line: 2088
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    if typeof(a1) ~= "number" or a1 ~= a1 then
        return
    end
    tbl_upv_2.sens = math.clamp(a1, 0.2, 3)
end
function tbl_upv_1.SetZoom(a1)
    --[[
      name: SetZoom
      line: 2095
      upvalues:
        u9 (ref, index: 1)
    ]]
    if typeof(a1) ~= "number" then
        return
    end
    u9 = math.clamp(a1, 7, 14)
end
function tbl_upv_1.SpectateNext(a1)
    --[[
      name: SpectateNext
      line: 2102
      upvalues:
        Spectate_upv_1 (copy, index: 1)
    ]]
    local Next_1 = Spectate_upv_1.Next
    local v245
    if typeof(a1) == "number" and (a1 < 0) then
        v245 = -1
    else
        v245 = 1
    end
    Next_1(v245)
end
function tbl_upv_1.GetSpectateTarget()
    --[[
      name: GetSpectateTarget
      line: 2107
      upvalues:
        Spectate_upv_1 (copy, index: 1)
    ]]
    return Spectate_upv_1.GetTarget()
end
function tbl_upv_1.GetSpectateMode()
    --[[
      name: GetSpectateMode
      line: 2112
      upvalues:
        Spectate_upv_1 (copy, index: 1)
    ]]
    return Spectate_upv_1.GetMode()
end
function tbl_upv_1.GetKiller()
    --[[
      name: GetKiller
      line: 2117
      upvalues:
        Spectate_upv_1 (copy, index: 1)
    ]]
    return Spectate_upv_1.GetKiller()
end
tbl_upv_1.SpectateChanged = Spectate_upv_1.Changed
function tbl_upv_1.PlayCinematic(a1, a2, a3)
    --[[
      name: PlayCinematic
      line: 2130
      upvalues:
        u20 (ref,  index: 1)
        u22 (ref,  index: 2)
        u23 (ref,  index: 3)
        u24 (ref,  index: 4)
        u25 (ref,  index: 5)
        LocalPlayer_upv_1 (copy, index: 6)
        u26 (ref,  index: 7)
        Workspace_upv_1 (copy, index: 8)
        u8 (ref,  index: 9)
    ]]
    if typeof(a1) ~= "CFrame" then
        return
    end
    local v246 = a3 or {}
    local tbl_26 = {untilStopped = 0, hide = 0, fov = 0}
    tbl_26.cf = a1
    local v247
    if typeof(a2) ~= "number" then
        v247 = nil
    else
        v247 = math.clamp(a2, 20, 100)
    end
    tbl_26.fov = v247
    if v246.hideCharacter ~= false then
        v247 = true
    else
        v247 = false
    end
    tbl_26.hide = v247
    if v246.untilStopped == true then
        v247 = true
    else
        v247 = false
    end
    tbl_26.untilStopped = v247
    u20 = tbl_26
    u22 = 1
    u23 = 1 / math.max(0.05, v246.duration or 0.6)
    u24 = os.clock()
    u25 = LocalPlayer_upv_1 and (LocalPlayer_upv_1.Character)
    if (tbl_26.fov) then
        return
    end
    v247 = Workspace_upv_1.CurrentCamera and Workspace_upv_1.CurrentCamera.FieldOfView or u8
    u26 = v247
end
function tbl_upv_1.StopCinematic(a1)
    --[[
      name: StopCinematic
      line: 2151
      upvalues:
        u22 (ref, index: 1)
        u23 (ref, index: 2)
    ]]
    u22 = 0
    u23 = 1 / math.max(0.05, a1 or 0.5)
end
function tbl_upv_1.IsCinematic()
    --[[
      name: IsCinematic
      line: 2156
      upvalues:
        u22 (ref, index: 1)
    ]]
    local v248 = u22 > 0
    return v248
end
function tbl_upv_1.SetEnabled(a1)
    --[[
      name: SetEnabled
      line: 2161
      upvalues:
        u11 (ref,  index: 1)
        Workspace_upv_1 (copy, index: 2)
        u8 (ref,  index: 3)
        UserInputService_upv_1 (copy, index: 4)
        LocalPlayer_upv_1 (copy, index: 5)
        u29 (ref,  index: 6)
        u30 (ref,  index: 7)
        Simulation_upv_1 (copy, index: 8)
        u55 (ref,  index: 9)
        FirstPerson_upv_1 (copy, index: 10)
        setCharacterFade (copy, index: 11)
        u57 (ref,  index: 12)
        tbl_upv_16 (copy, index: 13)
        Fades_upv_1 (copy, index: 14)
        u27 (ref,  index: 15)
    ]]
    u11 = a1
    local CurrentCamera_5 = Workspace_upv_1.CurrentCamera
    if a1 then
        u27 = nil
    else
        if CurrentCamera_5 then
            CurrentCamera_5.CameraType = Enum.CameraType.Custom
            CurrentCamera_5.FieldOfView = u8
        end
        UserInputService_upv_1.MouseBehavior = Enum.MouseBehavior.Default
        UserInputService_upv_1.MouseIconEnabled = true
        local v249
        if LocalPlayer_upv_1 then
            v249 = LocalPlayer_upv_1.Character
        else
            v249 = LocalPlayer_upv_1
        end
        local _
        if v249 then
            _ = v249:FindFirstChild("HumanoidRootPart")
            local v250 = v249:FindFirstChildOfClass("Humanoid")
        end
        u29 = false
        if u30 then
            Simulation_upv_1.SetFacing(nil)
            u30 = false
        end
        u55 = false
        FirstPerson_upv_1.Step(0, false)
        setCharacterFade(u57, 0, 0)
        for key_9 in tbl_upv_16 do
            if key_9.Parent then
                key_9.LocalTransparencyModifier = 0
            end
        end
        table.clear(tbl_upv_16)
        Fades_upv_1.ClearAllies()
        Fades_upv_1.ClearDecor()
    end
end
function tbl_upv_1.IsEnabled()
    --[[
      name: IsEnabled
      line: 2184
      upvalues:
        u11 (ref, index: 1)
    ]]
    return u11
end
function tbl_upv_1.DebugOcclusion(a1)
    --[[
      name: DebugOcclusion
      line: 2191
      upvalues:
        Occlusion_upv_1 (copy, index: 1)
    ]]
    return Occlusion_upv_1.Debug(a1)
end
tbl_upv_1.FrameLog = nil
function tbl_upv_1.DebugFrames(a1)
    --[[
      name: DebugFrames
      line: 2199
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local FrameLog_2 = tbl_upv_1.FrameLog
    tbl_upv_1.FrameLog = (a1 and {}) or nil
    if not (a1) and FrameLog_2 then
        return (game:GetService("HttpService"):JSONEncode(FrameLog_2))
    end
    return nil
end
function tbl_upv_1.GetDrawnRoot()
    --[[
      name: GetDrawnRoot
      line: 2212
      upvalues:
        Smoothing_upv_1 (copy, index: 1)
    ]]
    return Smoothing_upv_1.DrawnCFrame()
end
function tbl_upv_1.Drawn(a1)
    --[[
      name: Drawn
      line: 2216
      upvalues:
        Smoothing_upv_1 (copy, index: 1)
    ]]
    return Smoothing_upv_1.Drawn(a1)
end
function tbl_upv_1.GetDrawnModel()
    --[[
      name: GetDrawnModel
      line: 2220
      upvalues:
        Smoothing_upv_1 (copy, index: 1)
    ]]
    return Smoothing_upv_1.DrawnModel()
end
tbl_upv_1.DrawnChanged = Smoothing_upv_1.DrawnChanged
function tbl_upv_1.SmoothingTrace(a1)
    --[[
      name: SmoothingTrace
      line: 2228
      upvalues:
        Smoothing_upv_1 (copy, index: 1)
    ]]
    local v250 = Smoothing_upv_1.Trace(a1)
    if v250 then
        return (game:GetService("HttpService"):JSONEncode(v250))
    end
    return nil
end
function tbl_upv_1.DebugStats()
    --[[
      name: DebugStats
      line: 2233
      upvalues:
        tbl_upv_8 (copy, index: 1)
        Fades_upv_1 (copy, index: 2)
        AimAssist_upv_1 (copy, index: 3)
        Smoothing_upv_1 (copy, index: 4)
        Occlusion_upv_1 (copy, index: 5)
        Guards_upv_1 (copy, index: 6)
        RunService_upv_1 (copy, index: 7)
        Simulation_upv_1 (copy, index: 8)
        u55 (ref,  index: 9)
    ]]
    local v251 = os.clock()
    local v252 = math.max(0.001, v251 - tbl_upv_8.since)
    local tbl_27 = {msPerFrame = 0, touchesIgnored = 0, touchLookPx = 0, maxFrameMs = 0, fps = 0}
    tbl_27.msPerSec = (tbl_upv_8.time * 1000) / v252
    tbl_27.msPerFrame = ((tbl_upv_8.frames > 0) and (tbl_upv_8.time * 1000 / tbl_upv_8.frames)) or 0
    tbl_27.maxFrameMs = tbl_upv_8.max * 1000
    tbl_27.fps = tbl_upv_8.frames / v252
    tbl_27.touchLookPx = tbl_upv_8.touchLookPx
    tbl_27.touchesIgnored = tbl_upv_8.touchesIgnored
    tbl_upv_8.time = 0
    tbl_upv_8.max = 0
    tbl_upv_8.frames = 0
    tbl_upv_8.since = v251
    for key_10, value_32 in Fades_upv_1.Stats() do
        tbl_27[key_10] = value_32
    end
    for key_11, value_33 in AimAssist_upv_1.Stats() do
        tbl_27[key_11] = value_33
    end
    for key_12, value_34 in Smoothing_upv_1.Stats() do
        tbl_27[key_12] = value_34
    end
    for key_13, value_35 in Occlusion_upv_1.Debug("stats") do
        tbl_27["occ_" .. key_13] = value_35
    end
    for key_14, value_36 in Guards_upv_1.Stats() do
        tbl_27["guard_" .. key_14] = value_36
    end
    if RunService_upv_1:IsStudio() and Simulation_upv_1.WriteGuardStats then
        for key_15, value_37 in Simulation_upv_1.WriteGuardStats() do
            tbl_27["wg_" .. key_15] = value_37
        end
    end
    tbl_27.firstPerson = u55
    tbl_27.waterLifts = Occlusion_upv_1.WaterLifts()
    return tbl_27
end
function tbl_upv_1.SetLook(a1, a2)
    --[[
      name: SetLook
      line: 2274
      upvalues:
        u65 (copy, index: 1)
        u32 (ref,  index: 4)
        u31 (ref,  index: 5)
        u1 (ref,  index: 10)
        u2 (ref,  index: 11)
        u4 (ref,  index: 16)
        u5 (ref,  index: 17)
    ]]
    u65(32768)
    u32 = u31
    local v253 = u1
    local v254 = u2
    u4 = ((a1 + math.pi) % math.tau) - math.pi
    if not a2 then
        return
    end
    u5 = math.clamp(a2, v253, v254)
end
if u3 and LocalPlayer_upv_1 then
    local TribesCameraBridge_upv_1 = LocalPlayer_upv_1:FindFirstChild("TribesCameraBridge")
    if TribesCameraBridge_upv_1 then
        local v255 = TribesCameraBridge_upv_1:IsA("BindableFunction")
        if v255 then
            for key_upv_16, value_38 in tbl_upv_1 do
                if type(value_38) == "function" then
                    tbl_upv_1[key_upv_16] = function(...)
                        --[[
                          line: 2297
                          upvalues:
                            TribesCameraBridge_upv_1 (copy, index: 1)
                            key_upv_16 (copy, index: 2)
                        ]]
                        return TribesCameraBridge_upv_1:Invoke(key_upv_16, ...)
                    end
                end
            end
        else
            local v256 = Instance.new("BindableFunction")
            v256.Name = "TribesCameraBridge"
            local u81 = table.clone(tbl_upv_1)
            v256.OnInvoke = function(a1, ...)
                --[[
                  line: 2306
                  upvalues:
                    u81 (copy, index: 1)
                ]]
                local v257 = u81[a1]
                if type(v257) ~= "function" then
                    return nil
                end
                return v257(...)
            end
            v256.Parent = LocalPlayer_upv_1
            start()
        end
    else
        local v256 = Instance.new("BindableFunction")
        v256.Name = "TribesCameraBridge"
        local u81 = table.clone(tbl_upv_1)
        v256.OnInvoke = function(a1, ...)
            --[[
              line: 2306
              upvalues:
                u81 (copy, index: 1)
            ]]
            local v257 = u81[a1]
            if type(v257) ~= "function" then
                return nil
            end
            return v257(...)
        end
        v256.Parent = LocalPlayer_upv_1
        start()
    end
end
return tbl_upv_1