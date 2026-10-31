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
local tbl_upv_10 = {target = 0, blend = 0, startedAt = 0}
local u21 = 1.6666666666666667
local u22 = nil
local cf_upv_1 = CFrame.new()
local u23 = 70
local u24 = nil
local u25 = nil
local u26 = false
local u27 = false
local u28 = false
local u29 = false
local CFrame_upv_1 = nil
local FieldOfView_upv_1 = 70
local u30 = 1
local u31 = nil
local u32 = false
local u33 = Vector2.zero
local zero_upv_1 = Vector2.zero
local tbl_upv_11 = {}
local u34 = nil
local u35 = "none"
local u36 = CFrame.new()
local u37 = 70
local u38 = nil
local u39 = nil
local u40 = 70
local u41 = 1
local u42 = CFrame.new()
local u43 = 70
local u44 = nil
local function wrapAngle(a1)
    --[[
      name: wrapAngle
      line: 195
    ]]
    return ((a1 + math.pi) % math.tau) - math.pi
end
local u45 = nil
local u46 = function(a1, a2)
    --[[
      line: 203
      upvalues:
        u45 (ref,  index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
    ]]
    if not (u45) then
        local v1 = LocalPlayer_upv_1 and (LocalPlayer_upv_1:FindFirstChild("PlayerScripts") and (LocalPlayer_upv_1.PlayerScripts:FindFirstChild("Core")))
        local v2 = v1 and (v1:FindFirstChild("InputStats"))
        if v2 and v2:IsA("ModuleScript") then
            u45 = require(v2)
            if a2 then
                u45.Note(a1)
            else
                u45.Caller(a1)
            end
            return
        end
        return
    end
    if a2 then
        u45.Note(a1)
    else
        u45.Caller(a1)
    end
end
local u47 = 0
local u48 = -0.2
local u49 = 0
local u50 = -0.2
local u51 = 0
local u52 = -0.2
local u53 = 0
local u54 = -0.2
local u55 = 0
local u56 = -0.2
local u57 = 0
local u58 = -0.2
local u59 = 0
local u60 = -0.2
local tbl_upv_12 = {u1, u2}
local u61 = function()
    --[[
      line: 233
      upvalues:
        u57 (ref,  index: 1)
        u56 (ref,  index: 2)
        u53 (ref,  index: 3)
        u60 (ref,  index: 4)
        u52 (ref,  index: 5)
        u47 (ref,  index: 6)
        u2 (ref,  index: 7)
        tbl_upv_12 (copy, index: 8)
        u48 (ref,  index: 9)
        u54 (ref,  index: 10)
        u59 (ref,  index: 11)
        u49 (ref,  index: 12)
        u1 (ref,  index: 13)
        u50 (ref,  index: 14)
        u51 (ref,  index: 15)
        u55 (ref,  index: 16)
        u58 (ref,  index: 17)
        u46 (copy, index: 18)
    ]]
    if u57 == 0 and u56 == -0.2 and u53 == 0 and u60 == -0.2 and u52 == -0.2 and u47 == 0 and u2 == tbl_upv_12[2] and u48 == -0.2 and u54 == -0.2 and u59 == 0 and u49 == 0 and u1 == tbl_upv_12[1] and u50 == -0.2 and u51 == 0 and u55 == 0 and u58 == -0.2 then
        return
    end
    u47 = 0
    u48 = -0.2
    u49 = 0
    u50 = -0.2
    u51 = 0
    u52 = -0.2
    u53 = 0
    u54 = -0.2
    u55 = 0
    u56 = -0.2
    u57 = 0
    u58 = -0.2
    u59 = 0
    u60 = -0.2
    u1 = tbl_upv_12[1]
    u2 = tbl_upv_12[2]
    u46(256, true)
end
function tbl_upv_1.SetLook(a1, a2)
    --[[
      name: SetLook
      line: 264
      upvalues:
        u46 (copy, index: 1)
        u29 (ref,  index: 4)
        u28 (ref,  index: 5)
        u1 (ref,  index: 10)
        u2 (ref,  index: 11)
        u4 (ref,  index: 20)
        u5 (ref,  index: 21)
    ]]
    u46(32768)
    u29 = u28
    local v3 = u1
    local v4 = u2
    u4 = ((a1 + math.pi) % math.tau) - math.pi
    if not a2 then
        return
    end
    u5 = math.clamp(a2, v3, v4)
end
local function smoothstep(a1)
    --[[
      name: smoothstep
      line: 278
    ]]
    local v5 = math.clamp(a1, 0, 1)
    return (v5 * v5) * (3 - (v5 * 2))
end
local tbl_upv_13 = {rise = 0.05, fall = 0.2, t0 = 0, amount = 0}
local function isMouseUnlocked()
    --[[
      name: isMouseUnlocked
      line: 303
      upvalues:
        tbl_upv_3 (copy, index: 1)
        GuiService_upv_1 (copy, index: 2)
    ]]
    local v6 = true
    if next(tbl_upv_3) == nil then
        v6 = GuiService_upv_1.MenuIsOpen
    end
    return v6
end
local function combatModeOn()
    --[[
      name: combatModeOn
      line: 309
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local v7 = LocalPlayer_upv_1:GetAttribute("CombatMode")
    if v7 ~= nil then
        return v7 == true
    end
    local v8 = LocalPlayer_upv_1:GetAttribute("State") == "Match"
    return v8
end
local function getCharacterParts()
    --[[
      name: getCharacterParts
      line: 317
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local v9
    if LocalPlayer_upv_1 then
        v9 = LocalPlayer_upv_1.Character
    else
        v9 = LocalPlayer_upv_1
    end
    if not v9 then
        return nil, nil, nil
    end
    local HumanoidRootPart_1 = v9:FindFirstChild("HumanoidRootPart")
    local v10 = v9:FindFirstChildOfClass("Humanoid")
    local v11 = ((HumanoidRootPart_1 and (HumanoidRootPart_1:IsA("BasePart"))) and HumanoidRootPart_1) or nil
    return v9, v11, v10
end
local function yawOf(a1)
    --[[
      name: yawOf
      line: 327
    ]]
    local LookVector_1 = a1.LookVector
    return (math.atan2(-LookVector_1.X, -LookVector_1.Z))
end
local function drawnCharacter(a1)
    --[[
      name: drawnCharacter
      line: 334
      upvalues:
        Smoothing_upv_1 (copy, index: 1)
    ]]
    return Smoothing_upv_1.DrawnModel() or a1
end
local tbl_upv_14 = {}
local u62 = true
local u63 = nil
local u64 = true
local tbl_upv_15 = {"FX", "Projectiles"}
local function markIgnoreDirty()
    --[[
      name: markIgnoreDirty
      line: 347
      upvalues:
        u62 (ref, index: 1)
    ]]
    u62 = true
end
local function ignoreList(a1)
    --[[
      name: ignoreList
      line: 351
      upvalues:
        u62 (ref,  index: 1)
        u63 (ref,  index: 2)
        tbl_upv_9 (copy, index: 3)
        tbl_upv_14 (copy, index: 4)
        tbl_upv_15 (copy, index: 5)
        Workspace_upv_1 (copy, index: 6)
        Players_upv_1 (copy, index: 7)
        Fighters_upv_1 (copy, index: 8)
        Occlusion_upv_1 (copy, index: 9)
        u64 (ref,  index: 10)
    ]]
    local v12 = os.clock()
    if u62 then
        table.clear(tbl_upv_14)
        if a1 then
            table.insert(tbl_upv_14, a1)
        end
        for _, value_1 in tbl_upv_15 do
            local v13 = Workspace_upv_1:FindFirstChild(value_1)
            if v13 then
                table.insert(tbl_upv_14, v13)
            end
        end
        for _, value_2 in Players_upv_1:GetPlayers() do
            if not (value_2.Character) then
                continue
            end
            if value_2.Character ~= a1 then
                table.insert(tbl_upv_14, value_2.Character)
            end
        end
        Fighters_upv_1.EachTagged(
            function(a2)
                --[[
                  line: 369
                  upvalues:
                    a1 (copy, index: 1)
                    tbl_upv_14 (copy, index: 2)
                ]]
                if a2 == a1 then
                    return
                end
                table.insert(tbl_upv_14, a2)
            end
        )
        u62 = false
        u63 = a1
        tbl_upv_9.ignoreBuilt = v12
        Occlusion_upv_1.IgnoreChanged()
        u64 = true
    elseif a1 ~= u63 then
        table.clear(tbl_upv_14)
        if a1 then
            table.insert(tbl_upv_14, a1)
        end
        for _, value_1 in tbl_upv_15 do
            local v13 = Workspace_upv_1:FindFirstChild(value_1)
            if v13 then
                table.insert(tbl_upv_14, v13)
            end
        end
        for _, value_2 in Players_upv_1:GetPlayers() do
            if not (value_2.Character) then
                continue
            end
            if value_2.Character ~= a1 then
                table.insert(tbl_upv_14, value_2.Character)
            end
        end
        Fighters_upv_1.EachTagged(
            function(a2)
                --[[
                  line: 369
                  upvalues:
                    a1 (copy, index: 1)
                    tbl_upv_14 (copy, index: 2)
                ]]
                if a2 == a1 then
                    return
                end
                table.insert(tbl_upv_14, a2)
            end
        )
        u62 = false
        u63 = a1
        tbl_upv_9.ignoreBuilt = v12
        Occlusion_upv_1.IgnoreChanged()
        u64 = true
    elseif v12 - tbl_upv_9.ignoreBuilt > 2 then
        table.clear(tbl_upv_14)
        if a1 then
            table.insert(tbl_upv_14, a1)
        end
        for _, value_1 in tbl_upv_15 do
            local v13 = Workspace_upv_1:FindFirstChild(value_1)
            if v13 then
                table.insert(tbl_upv_14, v13)
            end
        end
        for _, value_2 in Players_upv_1:GetPlayers() do
            if not (value_2.Character) then
                continue
            end
            if value_2.Character ~= a1 then
                table.insert(tbl_upv_14, value_2.Character)
            end
        end
        Fighters_upv_1.EachTagged(
            function(a2)
                --[[
                  line: 369
                  upvalues:
                    a1 (copy, index: 1)
                    tbl_upv_14 (copy, index: 2)
                ]]
                if a2 == a1 then
                    return
                end
                table.insert(tbl_upv_14, a2)
            end
        )
        u62 = false
        u63 = a1
        tbl_upv_9.ignoreBuilt = v12
        Occlusion_upv_1.IgnoreChanged()
        u64 = true
    end
    return tbl_upv_14
end
local function watchPlayerForIgnore(a1)
    --[[
      name: watchPlayerForIgnore
      line: 383
      upvalues:
        markIgnoreDirty (copy, index: 1)
    ]]
    a1.CharacterAdded:Connect(markIgnoreDirty)
    a1.CharacterRemoving:Connect(markIgnoreDirty)
end
local function castDistance(a1, a2, a3)
    --[[
      name: castDistance
      line: 390
      upvalues:
        Occlusion_upv_1 (copy, index: 1)
    ]]
    return Occlusion_upv_1.Cast(a1, a2, a3)
end
local tbl_upv_16 = {}
local u65 = true
local tbl_upv_17 = {}
local u66 = -1
local u67 = -1
local u68 = false
local u69 = false
local u70 = Instance.new("BindableEvent")
local u71 = nil
local function isHeadAccessoryPart(a1, a2)
    --[[
      name: isHeadAccessoryPart
      line: 407
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
      line: 417
      upvalues:
        tbl_upv_16 (copy, index: 1)
        isHeadAccessoryPart (copy, index: 2)
        u65 (ref,  index: 3)
    ]]
    table.clear(tbl_upv_16)
    local Head_1 = a1:FindFirstChild("Head")
    local v14 = nil
    for _, value_4 in a1:GetDescendants() do
        if value_4:IsA("BasePart") or value_4:IsA("Decal") then
            v14 = false
            if not (Head_1) then
                table.insert(tbl_upv_16, {inst = value_4, head = v14})
                continue
            end
            local v15 = Head_1:IsA("BasePart")
            if not (v15) then
                table.insert(tbl_upv_16, {inst = value_4, head = v14})
                continue
            end
            if value_4 == Head_1 or value_4.Parent == Head_1 then
                v14 = true
                table.insert(tbl_upv_16, {inst = value_4, head = v14})
                continue
            end
            local v16 = value_4:IsA("BasePart")
            if not (v16) or not (value_4.Parent) then
                table.insert(tbl_upv_16, {inst = value_4, head = v14})
                continue
            end
            local v17 = value_4.Parent:IsA("Accessory")
            if v17 then
                v14 = isHeadAccessoryPart(value_4, Head_1)
            end
            table.insert(tbl_upv_16, {inst = value_4, head = v14})
        end
    end
    u65 = false
end
local function restoreAll(a1)
    --[[
      name: restoreAll
      line: 436
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
      line: 451
      upvalues:
        u71 (ref,  index: 1)
        tbl_upv_16 (copy, index: 2)
        tbl_upv_17 (copy, index: 3)
        u65 (ref,  index: 4)
        u66 (ref,  index: 5)
        u67 (ref,  index: 6)
        u68 (ref,  index: 7)
        rebuildFadeEntries (copy, index: 8)
        tbl_upv_9 (copy, index: 9)
    ]]
    a2 = ((a2 < 0.01) and 0) or a2
    local v18 = math.max(a2, a3 or 0)
    local v19 = ((v18 < 0.01) and 0) or v18
    if a1 ~= u71 then
        for _, value_6 in tbl_upv_16 do
            local inst_2 = value_6.inst
            if not (inst_2.Parent) then
                continue
            end
            if inst_2.LocalTransparencyModifier ~= 0 then
                inst_2.LocalTransparencyModifier = 0
            end
        end
        for _, value_7 in tbl_upv_17 do
            value_7:Disconnect()
        end
        table.clear(tbl_upv_17)
        table.clear(tbl_upv_16)
        u71 = a1
        u65 = true
        u66 = -1
        u67 = -1
        u68 = false
        if a1 then
            table.insert(
                tbl_upv_17,
                a1.DescendantAdded:Connect(
                    function(a5)
                        --[[
                          line: 471
                          upvalues:
                            u65 (ref, index: 1)
                            u68 (ref, index: 2)
                            u66 (ref, index: 3)
                        ]]
                        u65 = true
                        if a5:IsA("BasePart") or a5:IsA("Decal") then
                            a5.LocalTransparencyModifier = u68 and 1 or math.max(u66, 0)
                        end
                    end
                )
            )
            table.insert(
                tbl_upv_17,
                a1.DescendantRemoving:Connect(
                    function()
                        --[[
                          line: 478
                          upvalues:
                            u65 (ref, index: 1)
                        ]]
                        u65 = true
                    end
                )
            )
        end
    end
    if not a1 then
        return
    end
    local v21 = u65
    if u65 then
        rebuildFadeEntries(a1)
    end
    local v22 = os.clock()
    local v23 = v21 or (v22 - tbl_upv_9.reconcile > 0.25)
    local v24 = true
    if not (math.abs(a2 - u66) >= 0.02) then
        local v25 = true
        if math.abs(v19 - u67) >= 0.02 then
            v24 = v25
        elseif a2 == 0 then
            local v26 = true
            if u66 ~= 0 then
                v24 = v26
            elseif v19 ~= 0 then
                v24 = a4 == true ~= u68
            else
                local v27 = true
                if u67 ~= 0 then
                    v24 = v27
                else
                    v24 = a4 == true ~= u68
                end
            end
        elseif v19 ~= 0 then
            v24 = a4 == true ~= u68
        else
            local v27 = true
            if u67 ~= 0 then
                v24 = v27
            else
                v24 = a4 == true ~= u68
            end
        end
    end
    if (v23) or (v24) then
        tbl_upv_9.reconcile = v22
        u66 = a2
        u67 = v19
        u68 = a4 == true
        for _, value_8 in tbl_upv_16 do
            local inst_3 = value_8.inst
            if not (inst_3.Parent) then
                continue
            end
            if u68 then
                v22 = 1
            elseif value_8.head then
                v22 = v19
            else
                v22 = a2
            end
            if math.abs(inst_3.LocalTransparencyModifier - v22) > 0.001 then
                inst_3.LocalTransparencyModifier = v22
            end
        end
    end
end
local tbl_upv_18 = {}
local tbl_upv_19 = {Low = 4, High = 1, Medium = 2}
local u72 = 1
local tbl_upv_20 = {}
local u73 = OverlapParams.new()
u73.FilterType = Enum.RaycastFilterType.Exclude
local function clearPropFade()
    --[[
      name: clearPropFade
      line: 524
      upvalues:
        tbl_upv_18 (copy, index: 1)
    ]]
    for key_1 in tbl_upv_18 do
        if key_1.Parent then
            key_1.LocalTransparencyModifier = 0
        end
    end
    table.clear(tbl_upv_18)
end
local function propFadeable(a1)
    --[[
      name: propFadeable
      line: 542
    ]]
    if a1.Transparency >= 1 or a1:HasTag("Foliage") or a1.Size.Magnitude >= 80 then
        return false
    end
    local Size_1 = a1.Size
    if math.max(math.min(Size_1.X, Size_1.Y), math.min(math.max(Size_1.X, Size_1.Y), Size_1.Z)) >= 6 then
        return false
    end
    local v28 = a1:FindFirstAncestorWhichIsA("Model")
    while v28 do
        if v28:FindFirstChildOfClass("Humanoid") or v28:HasTag("BearTrap") then
            return false
        end
        v28 = v28:FindFirstAncestorWhichIsA("Model")
    end
    return true
end
local function markProp(a1)
    --[[
      name: markProp
      line: 561
      upvalues:
        tbl_upv_20 (copy, index: 1)
        tbl_upv_18 (copy, index: 2)
    ]]
    tbl_upv_20[a1] = true
    if (tbl_upv_18[a1]) then
        return
    end
    tbl_upv_18[a1] = true
    a1.LocalTransparencyModifier = 0.7
end
local u74 = RaycastParams.new()
u74.FilterType = Enum.RaycastFilterType.Exclude
local function boxDistance(a1, a2)
    --[[
      name: boxDistance
      line: 533
    ]]
    local v29 = a1.CFrame:PointToObjectSpace(a2)
    local v30 = a1.Size * 0.5
    return Vector3.new(math.max(math.abs(v29.X) - v30.X, 0), math.max(math.abs(v29.Y) - v30.Y, 0), math.max(math.abs(v29.Z) - v30.Z, 0)).Magnitude
end
local function updatePropFade(a1, a2, a3)
    --[[
      name: updatePropFade
      line: 574
      upvalues:
        u64 (ref,  index: 1)
        u73 (copy, index: 2)
        tbl_upv_20 (copy, index: 3)
        Workspace_upv_1 (copy, index: 4)
        propFadeable (copy, index: 5)
        boxDistance (copy, index: 6)
        tbl_upv_18 (copy, index: 7)
        u74 (copy, index: 8)
        Occlusion_upv_1 (copy, index: 9)
    ]]
    if u64 then
        u73.FilterDescendantsInstances = a3
        u64 = false
    end
    table.clear(tbl_upv_20)
    local success_1, v31 = pcall(
        function()
            --[[
              line: 580
              upvalues:
                Workspace_upv_1 (copy, index: 1)
                a1 (copy, index: 2)
                u73 (copy, index: 3)
            ]]
            return Workspace_upv_1:GetPartBoundsInRadius(a1, 4.2, u73)
        end
    )
    if success_1 then
        for _, value_9 in v31 do
            if not (a1.Y - 1 < value_9.Position.Y + (value_9.Size.Y / 2)) or not (propFadeable(value_9)) then
                continue
            end
            local v32 = boxDistance(value_9, a1)
            if not (v32 <= (((tbl_upv_18[value_9]) and 0.7) or 0) + 3.5) then
                continue
            end
            tbl_upv_20[value_9] = true
            if not (tbl_upv_18[value_9]) then
                tbl_upv_18[value_9] = true
                value_9.LocalTransparencyModifier = 0.7
            end
        end
    end
    if a2 then
        u74.FilterDescendantsInstances = a3
        v31 = a1
        for _ = 1, 4 do
            local v33 = a2 - v31
            local v34
            if v33.Magnitude < 0.05 then
                break
            end
            v34 = Workspace_upv_1:Raycast(v31, v33, u74)
            local v35
            if not (v34) then
                break
            end
            v35 = v34.Instance
            if not (v35:IsA("BasePart")) or Occlusion_upv_1.Classify(v35) ~= 2 or not (propFadeable(v35)) then
                u74:AddToFilter(v35)
                v31 = v34.Position
                continue
            end
            tbl_upv_20[v35] = true
            if not (tbl_upv_18[v35]) then
                tbl_upv_18[v35] = true
                v35.LocalTransparencyModifier = 0.7
            end
            u74:AddToFilter(v35)
            v31 = v34.Position
        end
    end
    for key_2 in tbl_upv_18 do
        if tbl_upv_20[key_2] then
            continue
        end
        tbl_upv_18[key_2] = nil
        if key_2.Parent then
            key_2.LocalTransparencyModifier = 0
        end
    end
end
local function applyMouseBehavior()
    --[[
      name: applyMouseBehavior
      line: 634
      upvalues:
        u11 (ref,  index: 1)
        u28 (ref,  index: 2)
        tbl_upv_3 (copy, index: 3)
        GuiService_upv_1 (copy, index: 4)
        UserInputService_upv_1 (copy, index: 5)
    ]]
    if not u11 then
        return
    end
    if not (u28) then
        local v36 = true
        if next(tbl_upv_3) == nil then
            v36 = GuiService_upv_1.MenuIsOpen
        end
        if v36 then
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
local tbl_upv_21 = {}
tbl_upv_21[Enum.HumanoidStateType.Running] = true
tbl_upv_21[Enum.HumanoidStateType.RunningNoPhysics] = true
tbl_upv_21[Enum.HumanoidStateType.Jumping] = true
tbl_upv_21[Enum.HumanoidStateType.Freefall] = true
tbl_upv_21[Enum.HumanoidStateType.Landed] = true
tbl_upv_21[Enum.HumanoidStateType.GettingUp] = true
local function releaseAutoRotate(a1)
    --[[
      name: releaseAutoRotate
      line: 668
      upvalues:
        u26 (ref,  index: 1)
        u27 (ref,  index: 2)
        Simulation_upv_1 (copy, index: 3)
    ]]
    u26 = false
    if not u27 then
        return
    end
    Simulation_upv_1.SetFacing(nil)
    u27 = false
end
local function updateCharacterRotation(a1, a2, a3, a4)
    --[[
      name: updateCharacterRotation
      line: 676
      upvalues:
        tbl_upv_5 (copy, index: 1)
        tbl_upv_21 (copy, index: 2)
        u26 (ref,  index: 3)
        u27 (ref,  index: 4)
        Simulation_upv_1 (copy, index: 5)
        Smoothing_upv_1 (copy, index: 6)
        u4 (ref,  index: 7)
        u6 (ref,  index: 8)
        u69 (ref,  index: 9)
    ]]
    local v37 = not a4 and ((next(tbl_upv_5) == nil) and ((a3.Health > 0) and (not a2.Anchored and ((tbl_upv_21[a3:GetState()] == true) and ((a3.Sit == false) and (a3.PlatformStand == false))))))
    if v37 then
        u27 = true
        local _, v38 = Smoothing_upv_1.SimCFrame(a2):ToEulerAnglesYXZ()
        local v39 = ((u4 - v38) + math.pi) % math.tau - math.pi
        local v40 = a3.MoveDirection.Magnitude > 0.05
        local v41 = (a2.Parent ~= nil) and (a2.Parent:FindFirstChildOfClass("Tool") ~= nil)
        local v42 = v40 or (v41 or (u6 or u69))
        if v42 then
            u26 = false
        else
            if math.abs(v39) > 1.7453292519943295 then
                u26 = true
            end
            if u26 and math.abs(v39) < 0.06981317007977318 then
                u26 = false
            end
            v42 = u26
        end
        if v42 then
            if u69 then
                v42 = 40
            elseif u6 or v41 then
                v42 = 30
            else
                v42 = (v40 and 18) or 12
            end
            Simulation_upv_1.SetFacing(v38 + (v39 * (1 - math.exp(-v42 * math.max(a1, 0.016666666666666666)))))
        else
            Simulation_upv_1.SetFacing(v38)
        end
    else
        u26 = false
        if u27 then
            Simulation_upv_1.SetFacing(nil)
            u27 = false
        end
    end
end
local tbl_upv_22 = {Vector3.new(-1, -1, -1), Vector3.new(-1, -1, 1), Vector3.new(-1, 1, -1), Vector3.new(-1, 1, 1), Vector3.new(1, -1, -1), Vector3.new(1, -1, 1), Vector3.new(1, 1, -1), Vector3.new(1, 1, 1)}
local function frameSubject(a1, a2, a3, a4)
    --[[
      name: frameSubject
      line: 761
      upvalues:
        Finite_upv_1 (copy, index: 1)
        u42 (ref,  index: 2)
        u25 (ref,  index: 3)
        u24 (ref,  index: 4)
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
        return u42, u42.Position + (u42.LookVector * 10)
    end
    if a2 ~= u25 or u24 == nil or (a3 - u24).Magnitude > 40 then
        u16:Snap(a3.Y)
        Occlusion_upv_1.Reset()
        u25 = a2
    end
    u24 = a3
    u16.target = a3.Y
    u16:Update(a1)
    local v43 = math.clamp(u16.value, a3.Y - 1.5, a3.Y + 1.5)
    u16.value = v43
    local v44 = CFrame.fromEulerAnglesYXZ(0, u4, 0)
    local v45 = u18.value + tbl_upv_1.SlowRecoil.value
    local v46 = CFrame.fromEulerAnglesYXZ(u5 + v45.X, u4 + v45.Y, v45.Z)
    local v47 = Vector3.new(a3.X, (v43 + 3.1) + u17.value, a3.Z) + v44:VectorToWorldSpace(u15.value)
    local v48 = Vector3.new(a3.X, a3.Y + 0.5, a3.Z)
    local Frame_1 = Occlusion_upv_1.Frame
    local RightVector_1 = v44.RightVector
    local LookVector_2 = v46.LookVector
    local v49 = Shoulder_upv_1.Value()
    local v50 = (u6 and 2.8) or 2.9
    local v51, v52, v53 = Frame_1(a1, v48, v47, RightVector_1, LookVector_2, v49, u14.value, a4, v50)
    Shoulder_upv_1.Update(v53, v44.RightVector, 2.9, a4)
    return CFrame.new(v51) * v46.Rotation, v52
end
local function focusPointOf(a1)
    --[[
      name: focusPointOf
      line: 821
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
local u75 = OverlapParams.new()
u75.FilterType = Enum.RaycastFilterType.Exclude
u75.RespectCanCollide = true
local function spotIsFree(a1, a2)
    --[[
      name: spotIsFree
      line: 837
      upvalues:
        u75 (copy, index: 1)
    ]]
    u75.FilterDescendantsInstances = a2
    local success_2, v54 = pcall(function() end)
    return success_2 and (#v54 == 0)
end
local u76 = nil
local u77 = nil
local function sees(a1, a2, a3)
    --[[
      name: sees
      line: 851
      upvalues:
        Occlusion_upv_1 (copy, index: 1)
    ]]
    local v55 = (a2 - a1).Magnitude - 0.5 <= Occlusion_upv_1.Cast(a1, a2, a3)
    return v55
end
local function pickDeathSpot(a1, a2, a3)
    --[[
      name: pickDeathSpot
      line: 855
      upvalues:
        u77 (ref,  index: 1)
        Occlusion_upv_1 (copy, index: 2)
        u75 (copy, index: 3)
        Workspace_upv_1 (copy, index: 4)
    ]]
    local v56 = u77
    local v57 = nil
    if v56 then
        v57 = (a2 - v56).Magnitude - 0.5 <= Occlusion_upv_1.Cast(v56, a2, a3)
        if v57 then
            return u77
        end
    end
    local v58 = Vector3.new(a1.X - a2.X, 0, a1.Z - a2.Z)
    local v59 = ((not (v58.Magnitude > 0.1)) and Vector3.new(0, 0, 1)) or (v58.Unit)
    for key_3, value_upv_10 in {a1, a1 + Vector3.new(0, 7, 0), a1 + Vector3.new(0, 14, 0), (a2 + (v59 * 16)) + Vector3.new(0, 8, 0), (a2 + (v59 * 11)) + Vector3.new(0, 4, 0), (a2 + (v59 * 14)) + Vector3.new(0, 18, 0)} do
        local v60 = (a2 - value_upv_10).Magnitude - 0.5 <= Occlusion_upv_1.Cast(value_upv_10, a2, a3)
        if not (v60) then
            continue
        end
        if key_3 ~= 1 then
            u75.FilterDescendantsInstances = a3
            local success_3, v61 = pcall(
                function()
                    --[[
                      line: 839
                      upvalues:
                        Workspace_upv_1 (copy, index: 1)
                        value_upv_10 (copy, index: 2)
                        u75 (copy, index: 3)
                    ]]
                    return Workspace_upv_1:GetPartBoundsInRadius(value_upv_10, 0.6, u75)
                end
            )
            if not success_3 or #v61 ~= 0 then
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
      line: 881
      upvalues:
        Spectate_upv_1 (copy, index: 1)
        u36 (ref,  index: 2)
        focusPointOf (copy, index: 3)
        u8 (ref,  index: 4)
        u77 (ref,  index: 5)
        tbl_upv_9 (copy, index: 6)
        pickDeathSpot (copy, index: 7)
        ignoreList (copy, index: 8)
        LocalPlayer_upv_1 (copy, index: 9)
        u37 (ref,  index: 12)
    ]]
    local v62 = math.clamp(Spectate_upv_1.DeathElapsed() / 0.35, 0, 1)
    local v63 = v62 * v62 * (3 - (v62 * 2))
    local v64 = Spectate_upv_1.GetKiller()
    local v65 = not (v64) or not (v64.Parent) or focusPointOf(v64)
    local v66
    if v65 then
        local v67 = os.clock()
        if u77 == nil or v67 - tbl_upv_9.deathSpot > 0.25 then
            tbl_upv_9.deathSpot = v67
            u77 = pickDeathSpot(u36.Position, v65, ignoreList(LocalPlayer_upv_1.Character))
        end
        v66 = u77
    else
        local v68 = u36.Position + Vector3.new(0, 3, 0)
        local v69 = Spectate_upv_1.GetDeathPosition() or (u36.Position + u36.LookVector * 10)
        v66, v65 = v68, v69
    end
    if v70 == nil then
        v70 = u36.Position
    end
    v70 = v70:Lerp(v66, 1 - math.exp(a1 * -5))
    local v71 = v70
    local v72
    if v64 and v64.Parent then
        v72 = math.clamp(math.deg(math.atan(9 / math.max((v65 - v71).Magnitude, 1))) * 2, 35, u8)
    else
        v72 = u8
    end
    if v73 ~= nil then
        v73 = v73:Lerp(v65, 1 - math.exp(a1 * -8))
    else
        v73 = v65
    end
    local v74 = v73
    local v75 = ((not ((v74 - v71).Magnitude > 0.1)) and (CFrame.new(v70) * u36.Rotation)) or (CFrame.lookAt(v70, v74))
    return u36.Rotation:Lerp(v75.Rotation, v63) + v70, u37 + ((v72 - u37) * v63)
end
function tbl_upv_2.fovNow()
    --[[
      name: fovNow
      line: 925
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
      line: 932
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
        u33 (ref,  index: 11)
        LocalPlayer_upv_1 (copy, index: 12)
        ignoreList (copy, index: 13)
        tbl_upv_6 (copy, index: 14)
        tbl_upv_8 (copy, index: 15)
        u2 (ref,  index: 16)
        u1 (ref,  index: 17)
    ]]
    local v76 = u10 * a3
    v76 = (u6 and (v76 * (math.clamp(tbl_upv_2.fovNow() / u8, 0.35, 1) * tbl_upv_2.sens))) or v76
    local v77, v78 = nil, nil
    if not (a2) then
        if UserInputService_upv_1.MouseBehavior == Enum.MouseBehavior.LockCenter and UserInputService_upv_1:GetLastInputType() ~= Enum.UserInputType.Touch then
            local v79 = UserInputService_upv_1:GetMouseDelta()
            local v80 = 0.006283185307179587 * v76
            u4 = u4 - (v79.X * v80)
            u5 = u5 - (v79.Y * v80)
        end
        zero_upv_1 = zero_upv_1 + AimAssist_upv_1.TakeInjected()
        local v81, v82 = tbl_upv_1.PadLook.Step(u33, a1, u6)
        local v83 = v82 * (v76 / u10)
        local v84 = v81 * (v76 / u10) - (zero_upv_1.X * 0.01745) * v76
        v77 = (-zero_upv_1.Y * 0.01745) * 0.66 * v76
        if v77 * u5 > 0 then
            v77 = v77 * (((1 - ((math.min(math.abs(u5), 1.5707963267948966) * 2 / math.pi) ^ 0.75)) * 0.75) + 0.25)
        end
        local Apply_1 = AimAssist_upv_1.Apply
        v78 = LocalPlayer_upv_1:GetAttribute("CombatMode")
        local v85
        if v78 ~= nil then
            v85 = v78 == true
        else
            v85 = LocalPlayer_upv_1:GetAttribute("State") == "Match"
        end
        local v86 = ignoreList(LocalPlayer_upv_1.Character)
        local v87 = tbl_upv_2.fovNow()
        local v88, v89 = Apply_1(a1, v84, v83 + v77, u4, u5, v85, v86, u6, v87, tbl_upv_6.CombatDraw ~= nil)
        u4 = u4 + v88
        u5 = u5 + v89
        tbl_upv_8.touchLookPx = tbl_upv_8.touchLookPx + (math.abs(zero_upv_1.X) + math.abs(zero_upv_1.Y))
    end
    zero_upv_1 = Vector2.zero
    u4 = ((u4 + math.pi) % math.tau) - math.pi
    local v90 = u2
    for _, value_11 in tbl_upv_6 do
        if not (value_11.maxPitch) then
            continue
        end
        if value_11.maxPitch < v90 then
            v90 = value_11.maxPitch
        end
    end
    if v90 < u5 then
        u5 = u5 + (v90 - u5) * (1 - math.exp(a1 * -5))
    end
    u5 = math.clamp(u5, u1, u2)
end
local function resetToOwnCharacter()
    --[[
      name: resetToOwnCharacter
      line: 982
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        u4 (ref,  index: 2)
        u5 (ref,  index: 3)
        u24 (ref,  index: 4)
        u25 (ref,  index: 5)
        u38 (ref,  index: 6)
        u39 (ref,  index: 7)
        u41 (ref,  index: 8)
        u44 (ref,  index: 9)
    ]]
    local v91
    if LocalPlayer_upv_1 then
        v91 = LocalPlayer_upv_1.Character
    else
        v91 = LocalPlayer_upv_1
    end
    local v92
    if v91 then
        local HumanoidRootPart_3 = v91:FindFirstChild("HumanoidRootPart")
        local _ = v91:FindFirstChildOfClass("Humanoid")
        v92 = ((HumanoidRootPart_3 and (HumanoidRootPart_3:IsA("BasePart"))) and HumanoidRootPart_3) or nil
    else
        v92 = nil
    end
    if v92 then
        local _ = v92.CFrame.LookVector
        u4 = math.atan2(-v92.CFrame.LookVector.X, -v92.CFrame.LookVector.Z)
        u5 = -0.20943951023931956
    end
    u24 = nil
    u25 = nil
    u38 = nil
    u39 = nil
    u41 = 1
    u44 = nil
end
local function setLobby(a1, a2, a3)
    --[[
      name: setLobby
      line: 999
      upvalues:
        u28 (ref,  index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
        u32 (ref,  index: 3)
        CFrame_upv_1 (ref,  index: 4)
        FieldOfView_upv_1 (ref,  index: 5)
        u30 (ref,  index: 6)
        u31 (ref,  index: 7)
        tbl_upv_1 (copy, index: 8)
        u6 (ref,  index: 9)
        tbl_upv_7 (copy, index: 10)
        u18 (copy, index: 11)
        u17 (copy, index: 12)
        u26 (ref,  index: 13)
        u27 (ref,  index: 14)
        Simulation_upv_1 (copy, index: 15)
        u71 (ref,  index: 16)
        tbl_upv_16 (copy, index: 17)
        tbl_upv_17 (copy, index: 18)
        u65 (ref,  index: 19)
        u66 (ref,  index: 20)
        u67 (ref,  index: 21)
        u68 (ref,  index: 22)
        tbl_upv_18 (copy, index: 23)
        UserInputService_upv_1 (copy, index: 24)
        u4 (ref,  index: 25)
        u5 (ref,  index: 26)
        u24 (ref,  index: 27)
        u25 (ref,  index: 28)
    ]]
    u28 = a1
    local v93
    if LocalPlayer_upv_1 then
        v93 = LocalPlayer_upv_1.Character
    else
        v93 = LocalPlayer_upv_1
    end
    local v94
    if v93 then
        local HumanoidRootPart_4 = v93:FindFirstChild("HumanoidRootPart")
        local _ = v93:FindFirstChildOfClass("Humanoid")
        v94 = ((HumanoidRootPart_4 and (HumanoidRootPart_4:IsA("BasePart"))) and HumanoidRootPart_4) or nil
    else
        v94 = nil
    end
    if u32 then
        CFrame_upv_1 = a2.CFrame
        FieldOfView_upv_1 = a2.FieldOfView
        u30 = 0
        u31 = v94 and v94.Position
    end
    tbl_upv_1.PopMouseUnlock("FreeCursor")
    if a1 then
        u6 = false
        table.clear(tbl_upv_7)
        u18:Snap(Vector3.new(0, 0, 0))
        tbl_upv_1.SlowRecoil:Snap(Vector3.new(0, 0, 0))
        tbl_upv_1.SlowRecoilStay = Vector3.new(0, 0, 0)
        u17:Snap(0)
        u26 = false
        if u27 then
            Simulation_upv_1.SetFacing(nil)
            u27 = false
        end
        local _ = 0
        if u71 ~= nil then
            for v95, value_12 in tbl_upv_16 do
                local inst_4 = value_12.inst
                if not (inst_4.Parent) then
                    continue
                end
                if inst_4.LocalTransparencyModifier ~= 0 then
                    inst_4.LocalTransparencyModifier = 0
                end
            end
            for v96, value_13 in tbl_upv_17 do
                value_13:Disconnect()
            end
            table.clear(tbl_upv_17)
            table.clear(tbl_upv_16)
            u71 = nil
            u65 = true
            u66 = -1
            u67 = -1
            u68 = false
        end
        for key_4 in tbl_upv_18 do
            if key_4.Parent then
                key_4.LocalTransparencyModifier = 0
            end
        end
        table.clear(tbl_upv_18)
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
        u24 = nil
        u25 = nil
        u26 = false
    end
end
local function totalModifier()
    --[[
      name: totalModifier
      line: 623
      upvalues:
        tbl_upv_6 (copy, index: 1)
    ]]
    local v95 = 0
    local v96 = 0
    local v97 = Vector3.new(0, 0, 0)
    local v98 = 1
    for _, value_14 in tbl_upv_6 do
        v95 = v95 + (value_14.fov or 0)
        v96 = v96 + (value_14.distance or 0)
        v97 = v97 + (value_14.pivot or Vector3.new(0, 0, 0))
        v98 = v98 * (value_14.sensitivity or 1)
    end
    return v95, v96, v97, v98
end
local function updateLobby(a1, a2, a3, a4)
    --[[
      name: updateLobby
      line: 1035
      upvalues:
        tbl_upv_4 (copy, index: 1)
        zero_upv_1 (ref,  index: 2)
        totalModifier (copy, index: 3)
        u13 (copy, index: 4)
        u8 (ref,  index: 5)
        u29 (ref,  index: 6)
        u5 (ref,  index: 7)
        u4 (ref,  index: 8)
        u30 (ref,  index: 9)
        CFrame_upv_1 (ref,  index: 10)
        u31 (ref,  index: 11)
        FieldOfView_upv_1 (ref,  index: 12)
        Smoothing_upv_1 (copy, index: 13)
        Occlusion_upv_1 (copy, index: 14)
        u42 (ref,  index: 15)
        u43 (ref,  index: 16)
        u32 (ref,  index: 17)
    ]]
    if next(tbl_upv_4) == nil then
        if a4 and a4.Parent and a2.CameraSubject ~= a4 then
            a2.CameraSubject = a4
        end
        if a2.CameraType == Enum.CameraType.Scriptable then
            a2.CameraType = Enum.CameraType.Custom
        end
        zero_upv_1 = Vector2.zero
        local v99 = totalModifier()
        u13.target = u8 + v99
        u13:Update(a1)
        local v100 = math.clamp(u13.value, 20, 110)
        local v101 = a2.CFrame
        if u29 then
            u29 = false
            local Position_1 = a2.Focus.Position
            local v102 = math.clamp((v101.Position - a2.Focus.Position).Magnitude, 6, 40)
            local v103 = CFrame.new(Position_1) * CFrame.fromEulerAnglesYXZ(u5, u4, 0) * CFrame.new(0, 0, v102)
            a2.CFrame = v103
            v101 = v103
        else
            local LookVector_4 = v101.LookVector
            u4 = math.atan2(-v101.LookVector.X, -v101.LookVector.Z)
            u5 = math.asin(math.clamp(LookVector_4.Y, -1, 1))
        end
        if u30 < 1 and CFrame_upv_1 then
            if a3 and u31 and (a3.Position - u31).Magnitude > 40 then
                u30 = 1
            else
                u30 = math.min(1, u30 + (a1 / 0.5))
                local v104 = math.clamp(u30, 0, 1)
                local v105 = v104 * v104 * (3 - (v104 * 2))
                local v106 = CFrame_upv_1:Lerp(v101, v105)
                v100 = FieldOfView_upv_1 + (v100 - FieldOfView_upv_1) * v105
                a2.CFrame = v106
            end
        end
        local v107 = Smoothing_upv_1.CameraOffset()
        if v107 ~= Vector3.new(0, 0, 0) then
            a2.CFrame = a2.CFrame + v107
            a2.Focus = a2.Focus + v107
        end
        local v108 = Occlusion_upv_1.AboveWater(a2.CFrame)
        if v108 ~= a2.CFrame then
            a2.CFrame = v108
        end
        a2.FieldOfView = v100
        u42 = v108
        u43 = v100
        u32 = true
    else
        a2.CameraType = Enum.CameraType.Scriptable
        zero_upv_1 = Vector2.zero
    end
end
local function headCrowdsCrosshair(a1, a2)
    --[[
      name: headCrowdsCrosshair
      line: 729
      upvalues:
        tbl_upv_16 (copy, index: 1)
        tbl_upv_22 (copy, index: 2)
    ]]
    local v109 = a1.ViewportSize / 2
    local v110 = ((a2 and 40) or 16) * math.max(a1.ViewportSize.Y, 200) / 768
    for _, value_15 in tbl_upv_16 do
        local inst_5 = value_15.inst
        if not (value_15.head) or not (inst_5:IsA("BasePart")) or not (inst_5.Parent) then
            continue
        end
        local CFrame_2 = inst_5.CFrame
        local v111 = math.huge
        local v112 = math.huge
        local v113 = -math.huge
        local v114 = -math.huge
        for v118, value_16 in tbl_upv_22 do
            local v115 = a1:WorldToViewportPoint(CFrame_2:PointToWorldSpace(inst_5.Size / 2 * value_16))
            if v115.Z > 0 then
                v111, v113, v112, v114 = math.min(v111, v115.X), math.max(v113, v115.X), math.min(v112, v115.Y), math.max(v114, v115.Y)
            end
        end
        if not (v111 <= v113) then
            continue
        end
        local v116 = math.max(v111 - v109.X, 0, v109.X - v113)
        local v117 = math.max(v112 - v109.Y, 0, v109.Y - v114)
        if not ((v116 * v116) + (v117 * v117) < v110 * v110) then
            continue
        end
        return true
    end
    return false
end
local function fovKickNow()
    --[[
      name: fovKickNow
      line: 286
      upvalues:
        tbl_upv_13 (copy, index: 1)
    ]]
    if tbl_upv_13.amount == 0 then
        return 0
    end
    local v118 = os.clock() - tbl_upv_13.t0
    if v118 < tbl_upv_13.rise then
        local v119 = math.clamp(v118 / tbl_upv_13.rise, 0, 1)
        return tbl_upv_13.amount * ((v119 * v119) * (3 - (v119 * 2)))
    else
        local v120 = (v118 - tbl_upv_13.rise) / tbl_upv_13.fall
        if v120 >= 1 then
            tbl_upv_13.amount = 0
            return 0
        else
            local v121 = math.clamp(v120, 0, 1)
            return tbl_upv_13.amount * (1 - ((v121 * v121) * (3 - (v121 * 2))))
        end
    end
end
local function applyShake(a1, a2, a3)
    --[[
      name: applyShake
      line: 795
      upvalues:
        tbl_upv_7 (copy, index: 1)
    ]]
    local v122 = 0
    for n_1 = #tbl_upv_7, 1, -1 do
        local v123 = tbl_upv_7[n_1]
        v123.t = v123.t + a2
        if v123.duration <= v123.t then
            table.remove(tbl_upv_7, n_1)
        else
            local _ = 1 - v123.t / v123.duration
            v122 = v122 + v123.intensity * (1 - v123.t / v123.duration) * (1 - v123.t / v123.duration)
        end
    end
    if v122 <= 0 then
        return a1
    end
    v122 = math.min(v122, 3) * (a3 or 1)
    local v124 = os.clock() * 17
    local v125 = v122 * 0.022689280275926284
    local v126 = math.noise(v124, 0.37, 1.1) * 2 * v125
    local v127 = math.noise(3.1, v124, 7.3) * 2 * v125
    local v128 = math.noise(9.2, 4.4, v124) * 1.2 * v125
    return a1 * CFrame.new((math.noise(v124, 11.3, 2.9) * 0.12) * v122, (math.noise(5.5, v124, 13.7) * 0.12) * v122, 0) * CFrame.Angles(v126, v127, v128)
end
local function update(a1)
    --[[
      name: update
      line: 1098
      upvalues:
        Guards_upv_1 (copy, index: 1)
        u11 (ref,  index: 2)
        u69 (ref,  index: 3)
        Workspace_upv_1 (copy, index: 4)
        LocalPlayer_upv_1 (copy, index: 5)
        Finite_upv_1 (copy, index: 6)
        u35 (ref,  index: 7)
        Spectate_upv_1 (copy, index: 8)
        u24 (ref,  index: 9)
        u36 (ref,  index: 10)
        u42 (ref,  index: 11)
        u37 (ref,  index: 12)
        u43 (ref,  index: 13)
        u38 (ref,  index: 14)
        u76 (ref,  index: 15)
        u77 (ref,  index: 16)
        u6 (ref,  index: 17)
        tbl_upv_7 (copy, index: 18)
        u39 (ref,  index: 19)
        u40 (ref,  index: 20)
        u41 (ref,  index: 21)
        u44 (ref,  index: 22)
        u4 (ref,  index: 23)
        u5 (ref,  index: 24)
        u25 (ref,  index: 25)
        tbl_upv_1 (copy, index: 26)
        SpectateKeys_upv_1 (copy, index: 27)
        u30 (ref,  index: 28)
        tbl_upv_10 (copy, index: 29)
        u28 (ref,  index: 30)
        setLobby (copy, index: 31)
        updateLobby (copy, index: 32)
        Fades_upv_1 (copy, index: 33)
        Smoothing_upv_1 (copy, index: 34)
        applyMouseBehavior (copy, index: 35)
        tbl_upv_3 (copy, index: 36)
        GuiService_upv_1 (copy, index: 37)
        totalModifier (copy, index: 38)
        tbl_upv_4 (copy, index: 39)
        readLookInput (copy, index: 40)
        zero_upv_1 (ref,  index: 41)
        u13 (copy, index: 42)
        u14 (copy, index: 43)
        u15 (copy, index: 44)
        u16 (copy, index: 45)
        u17 (copy, index: 46)
        u18 (copy, index: 47)
        tbl_upv_2 (copy, index: 48)
        u8 (ref,  index: 49)
        u9 (ref,  index: 50)
        Shoulder_upv_1 (copy, index: 51)
        u1 (ref,  index: 52)
        u2 (ref,  index: 53)
        deathView (copy, index: 54)
        u26 (ref,  index: 55)
        u27 (ref,  index: 56)
        Simulation_upv_1 (copy, index: 57)
        setCharacterFade (copy, index: 58)
        ignoreList (copy, index: 59)
        frameSubject (copy, index: 60)
        updateCharacterRotation (copy, index: 61)
        FirstPerson_upv_1 (copy, index: 62)
        applyShake (copy, index: 63)
        CFrame_upv_1 (ref,  index: 64)
        u31 (ref,  index: 65)
        FieldOfView_upv_1 (ref,  index: 66)
        u20 (ref,  index: 67)
        u22 (ref,  index: 68)
        u21 (ref,  index: 69)
        cf_upv_1 (ref,  index: 70)
        u23 (ref,  index: 71)
        Occlusion_upv_1 (copy, index: 72)
        fovKickNow (copy, index: 73)
        u32 (ref,  index: 74)
        tbl_upv_9 (copy, index: 75)
        u72 (ref,  index: 76)
        updatePropFade (copy, index: 77)
        headCrowdsCrosshair (copy, index: 78)
        u19 (ref,  index: 79)
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
        local v129
        if LocalPlayer_upv_1 then
            v129 = LocalPlayer_upv_1.Character
        else
            v129 = LocalPlayer_upv_1
        end
        local v130, v131, v132
        if v129 then
            local HumanoidRootPart_5 = v129:FindFirstChild("HumanoidRootPart")
            local v133 = v129:FindFirstChildOfClass("Humanoid")
            v130 = ((HumanoidRootPart_5 and (HumanoidRootPart_5:IsA("BasePart"))) and HumanoidRootPart_5) or nil
            v131, v132 = v133, v129
        else
            v132 = nil
            v130 = nil
            v131 = nil
        end
        u69 = false
        if v130 then
            v129 = v130.Position
        else
            v129 = nil
        end
        if v129 then
            local v134 = Finite_upv_1.Vector(v129)
            if not (v134) then
                Finite_upv_1.Say("own root")
                v129 = nil
            end
        end
        local v135 = v129 or u24
        u35 = Spectate_upv_1.Step(v135)
        local v139 = nil
        local v141 = nil
        if u35 ~= u35 then
            if u35 ~= "death" then
                if u35 ~= "follow" then
                    if LocalPlayer_upv_1 then
                        v139 = LocalPlayer_upv_1.Character
                    else
                        v139 = LocalPlayer_upv_1
                    end
                    if v139 then
                        local HumanoidRootPart_6 = v139:FindFirstChild("HumanoidRootPart")
                        v141 = v139:FindFirstChildOfClass("Humanoid")
                        v135 = ((HumanoidRootPart_6 and (HumanoidRootPart_6:IsA("BasePart"))) and HumanoidRootPart_6) or nil
                    else
                        v135 = nil
                    end
                    if v135 then
                        local _ = v135.CFrame.LookVector
                        u4 = math.atan2(-v135.CFrame.LookVector.X, -v135.CFrame.LookVector.Z)
                        u5 = -0.20943951023931956
                    end
                    u24 = nil
                    u25 = nil
                    u38 = nil
                    u39 = nil
                    u41 = 1
                else
                    u39 = u42
                    u40 = u43
                    u41 = 0
                end
                u44 = nil
            else
                u36 = u42
                u37 = u43
                u38 = nil
                u76 = nil
                u77 = nil
                u6 = false
                table.clear(tbl_upv_7)
            end
            if u35 ~= "follow" then
                tbl_upv_1.PopMouseUnlock("Spectate")
            else
                tbl_upv_1.PushMouseUnlock("Spectate")
            end
            SpectateKeys_upv_1.SetActive(u35 == "follow", tbl_upv_1.SpectateNext)
            u30 = 1
        end
        local v138 = false
        if u35 == "none" then
            v139 = LocalPlayer_upv_1:GetAttribute("CombatMode")
            if v139 ~= nil then
                v141 = v139 == true
            else
                v141 = LocalPlayer_upv_1:GetAttribute("State") == "Match"
            end
            v138 = not v141 and ((tbl_upv_10.target == 0) and (tbl_upv_10.blend == 0))
        end
        if v138 ~= u28 then
            setLobby(v138, CurrentCamera_1, v131)
        end
        if u28 then
            updateLobby(a1, CurrentCamera_1, v130, v131)
            Fades_upv_1.ClearAllies()
            local v142 = Smoothing_upv_1.DrawnModel() or v132
            local v143 = v142 and (v142:FindFirstChild("Head"))
            local UpdateDecor_1 = Fades_upv_1.UpdateDecor
            local Position_2 = CurrentCamera_1.CFrame.Position
            local HumanoidRootPart_6 = not (v143) or not (v143:IsA("BasePart")) or v143.Position
            UpdateDecor_1(Position_2, HumanoidRootPart_6)
        else
            if CurrentCamera_1.CameraType ~= Enum.CameraType.Scriptable then
                CurrentCamera_1.CameraType = Enum.CameraType.Scriptable
            end
            applyMouseBehavior()
            local v144 = true
            if next(tbl_upv_3) == nil then
                v144 = GuiService_upv_1.MenuIsOpen
            end
            local v145, v146, v147, v148 = totalModifier()
            if u35 == "none" and next(tbl_upv_4) == nil then
                readLookInput(a1, v144, v148)
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
            Finite_upv_1.HealSpring(u16, ((not v129) and 0) or (v129.Y), "height")
            Finite_upv_1.HealSpring(u17, 0, "dip")
            Finite_upv_1.HealSpring(u18, Vector3.new(0, 0, 0), "recoil")
            Finite_upv_1.HealSpring(tbl_upv_1.SlowRecoil, Vector3.new(0, 0, 0), "slow recoil")
            local v137 = u35 ~= "none"
            local v149
            if u6 then
                v149 = tbl_upv_2.fovNow()
            else
                v149 = ((not v137) and (u8 + v145)) or u8
            end
            u13.target = v149
            v149 = (u6 and (math.clamp(50 / tbl_upv_2.fovNow(), 1, 1.6) * 8 + v146)) or ((v137 and 10.5) or (u9 + v146))
            u14.target = v149
            if v137 then
                v149 = Vector3.new(0, 0, 0)
            else
                v149 = v147
            end
            u15.target = v149
            u13:Update(a1)
            u14:Update(a1)
            Shoulder_upv_1.Step(a1, (u6 and 2.8) or 2.9)
            u15:Update(a1)
            u17:Update(a1)
            u18:Update(a1)
            local SlowRecoil_1 = tbl_upv_1.SlowRecoil
            SlowRecoil_1.target = SlowRecoil_1.target * math.exp(-a1 / tbl_upv_1.SLOW_RECOIL_FADE)
            SlowRecoil_1:Update(a1)
            v141 = tbl_upv_1.SlowRecoilStay
            if v141.Magnitude > 1e-05 then
                local v150 = v141 * (1 - math.exp(-a1 * 14))
                u5 = math.clamp(u5 + v150.X, u1, u2)
                u4 = (((u4 + v150.Y) + math.pi) % math.tau) - math.pi
                tbl_upv_1.SlowRecoilStay = v141 - v150
            else
                tbl_upv_1.SlowRecoilStay = Vector3.new(0, 0, 0)
            end
            local v151, v152, _ = nil, nil, nil
            local v180 = nil
            if u35 == "death" then
                local v153, v154 = deathView(a1)
                v152 = v153.Position + v153.LookVector * 10
                u26 = false
                if u27 then
                    Simulation_upv_1.SetFacing(nil)
                    u27 = false
                end
                setCharacterFade(Smoothing_upv_1.DrawnModel() or v132, 0, 0)
                v149 = v154
            elseif u35 == "follow" then
                local v155 = Spectate_upv_1.GetTarget()
                local v156 = v155
                local v200 = v156 and (v155:FindFirstChild("HumanoidRootPart"))
                u26 = false
                if u27 then
                    Simulation_upv_1.SetFacing(nil)
                    u27 = false
                end
                setCharacterFade(Smoothing_upv_1.DrawnModel() or v132, 0, 0)
                if v155 and v156 and v156:IsA("BasePart") then
                    if Finite_upv_1.Vector(v156.Position) then
                        if Finite_upv_1.Vector(v156.CFrame.LookVector) or Finite_upv_1.Say("follow root") then
                            if v155 ~= u44 then
                                if u44 ~= nil then
                                    u39 = u42
                                    u40 = u43
                                    u41 = 0
                                end
                                u44 = v155
                                local LookVector_5 = v156.CFrame.LookVector
                                u4 = math.atan2(-LookVector_5.X, -LookVector_5.Z)
                                u5 = -0.17453292519943295
                            end
                            local v157 = u4
                            local LookVector_6 = v155.CFrame.LookVector
                            u4 = ((v157 + (((((math.atan2(-LookVector_6.X, -LookVector_6.Z) - u4) + math.pi) % math.tau) - math.pi) * (1 - math.exp(a1 * -4)))) + math.pi) % math.tau - math.pi
                            u5 = u5 + (-0.17453292519943295 - u5) * (1 - math.exp(a1 * -3))
                            local v158, v159 = frameSubject(a1, v155, v155.Position, ignoreList(v155))
                            v149 = math.clamp(u13.value, 20, 110)
                            v151, v152 = v158, v159
                        else
                            v151 = u42
                            v149 = u43
                            v152 = v151.Position + v151.LookVector * 10
                        end
                    elseif Finite_upv_1.Say("follow root") then
                        if v155 ~= u44 then
                            if u44 ~= nil then
                                u39 = u42
                                u40 = u43
                                u41 = 0
                            end
                            u44 = v155
                            local LookVector_5 = v156.CFrame.LookVector
                            u4 = math.atan2(-LookVector_5.X, -LookVector_5.Z)
                            u5 = -0.17453292519943295
                        end
                        local v157 = u4
                        local LookVector_6 = v155.CFrame.LookVector
                        u4 = ((v157 + (((((math.atan2(-LookVector_6.X, -LookVector_6.Z) - u4) + math.pi) % math.tau) - math.pi) * (1 - math.exp(a1 * -4)))) + math.pi) % math.tau - math.pi
                        u5 = u5 + (-0.17453292519943295 - u5) * (1 - math.exp(a1 * -3))
                        local v158, v159 = frameSubject(a1, v155, v155.Position, ignoreList(v155))
                        v149 = math.clamp(u13.value, 20, 110)
                        v151, v152 = v158, v159
                    else
                        v151 = u42
                        v149 = u43
                        v152 = v151.Position + v151.LookVector * 10
                    end
                else
                    v151 = u42
                    v149 = u43
                    v152 = v151.Position + v151.LookVector * 10
                end
                if u41 < 1 and u39 then
                    u41 = math.min(1, u41 + (a1 / 0.45))
                    local v160 = math.clamp(u41, 0, 1)
                    local v161 = v160 * v160 * (3 - (v160 * 2))
                    local v162 = u39:Lerp(v151, v161)
                    v149 = u40 + (v149 - u40) * v161
                    v151, v151 = v162, v162
                end
            elseif v130 and v132 and v129 then
                if v131 then
                    updateCharacterRotation(a1, v130, v131, v144)
                end
                local v163 = ignoreList(v132)
                local v164 = v129 + Finite_upv_1.Offset(Smoothing_upv_1)
                local v165, v166 = frameSubject(a1, v132, v164, v163)
                local v167 = FirstPerson_upv_1.Step(a1, (tbl_upv_10.target == 0) and ((tbl_upv_10.blend == 0) and ((v131 ~= nil) and (v131.Health > 0))))
                u69 = v167 >= 0.5
                if v167 > 0 then
                    local Head_3 = v132:FindFirstChild("Head")
                    local StepBob_1 = FirstPerson_upv_1.StepBob
                    local v168 = (v131 ~= nil) and (v131.FloorMaterial ~= Enum.Material.Air)
                    local v169 = v132:GetAttribute("Sliding") == true
                    StepBob_1(a1, v164, v168, v169, v130.AssemblyLinearVelocity, StepBob_1)
                    v165, v166, v180 = FirstPerson_upv_1.CameraBob()
                    local Eye_1 = FirstPerson_upv_1.Eye
                    local v173 = not (Head_3) or not (Head_3:IsA("BasePart")) or Head_3
                    local v174 = Eye_1(a1, v164, v130, v173, v165.LookVector) + Vector3.new(0, (u17.value * 0.5) + v170, 0)
                    local v170 = CFrame.new(v174) * v165.Rotation * CFrame.Angles(v171, 0, v180)
                    v180 = FirstPerson_upv_1.Eased()
                    if v180 >= 1 then
                        v151 = v170
                    else
                        v151 = v165:Lerp(v170, v180)
                    end
                    v152 = v166:Lerp(v174 + (v151.LookVector * 10), v180)
                else
                    v152 = v166
                end
                local v175 = (u69 and 0.6) or 1
                local v176 = applyShake(v151, a1, v175)
                v149 = math.clamp(u13.value, 20, 110)
                if u30 < 1 and CFrame_upv_1 then
                    if (u31) and ((v130.Position - u31).Magnitude > 40) then
                        u30 = 1
                        v151, v151 = v176, v176
                    else
                        u30 = math.min(1, u30 + (a1 / 0.5))
                        local v177 = math.clamp(u30, 0, 1)
                        local v178 = v177 * v177 * (3 - (v177 * 2))
                        local v179 = CFrame_upv_1:Lerp(v176, v178)
                        v149 = FieldOfView_upv_1 + (v149 - FieldOfView_upv_1) * v178
                        v151, v151 = v179, v179
                    end
                else
                    v151, v151 = v176, v176
                end
            end
            if tbl_upv_10.target > 0 then
                v180 = os.clock() - tbl_upv_10.startedAt
                v130 = false
                if v180 > 0.5 then
                    v130 = false
                    if next(tbl_upv_3) == nil then
                        local v202 = u20 and u20.untilStopped
                        v130 = not u20 or not u20.untilStopped
                    end
                end
                local v181 = true
                if u22 == v132 then
                    v181 = (v131 ~= nil) and (v131.Health <= 0)
                end
                if v130 or v181 or v180 > 120 then
                    tbl_upv_10.target = 0
                    u21 = 2.5
                end
            end
            if tbl_upv_10.blend < tbl_upv_10.target then
                tbl_upv_10.blend = math.min(tbl_upv_10.target, tbl_upv_10.blend + (a1 * u21))
            elseif tbl_upv_10.target < tbl_upv_10.blend then
                tbl_upv_10.blend = math.max(tbl_upv_10.target, tbl_upv_10.blend - (a1 * u21))
            end
            if u20 then
                cf_upv_1 = u20.cf
                local v182 = u20.fov or u23
                u23 = v182
            end
            if tbl_upv_10.blend > 0 then
                local v183 = math.clamp(tbl_upv_10.blend, 0, 1)
                local v184 = v183 * v183 * (3 - (v183 * 2))
                local v185 = v151:Lerp(cf_upv_1, v184)
                v149 = v149 + (u23 - v149) * v184
                v151, v151 = v185, v185
            elseif tbl_upv_10.target == 0 then
                u20 = nil
            end
            if tbl_upv_10.blend <= 0 then
                local v186 = Occlusion_upv_1.AboveWater(v151)
                v151, v151 = v186, v186
            end
            v149 = math.clamp(v149 + fovKickNow(), 20, 110)
            if Finite_upv_1.Vector(v151.Position) and Finite_upv_1.Vector(v151.LookVector) and Finite_upv_1.Number(v149) then
                local v187 = Finite_upv_1.Vector(v152)
                if not v187 then
                    v152 = v151.Position + v151.LookVector * 10
                end
            else
                Finite_upv_1.Say("view " .. u35)
                v151 = u42
                v149 = u43
                v152 = v151.Position + v151.LookVector * 10
            end
            CurrentCamera_1.CFrame = v151
            local v188
            if tbl_upv_10.blend > 0.5 then
                v188 = cf_upv_1.Position
            else
                v188 = v152
            end
            CurrentCamera_1.Focus = CFrame.new(v188)
            CurrentCamera_1.FieldOfView = v149
            u42 = v151
            u43 = v149
            u32 = true
            if tbl_upv_1.FrameLog then
                local v189 = v129 or Vector3.new(0, 0, 0)
                local v190 = v189 + Finite_upv_1.Offset(Smoothing_upv_1)
                local value_17 = u15.value
                local v191 = 0
                for v203 in tbl_upv_4 do
                    v191 = v191 + 1
                end
                local FrameLog_1 = tbl_upv_1.FrameLog
                local tbl_23 = {os.clock(), a1, v151.X, v151.Y, v151.Z, u4, u5, v149, v189.X, v189.Y, v189.Z, v190.X, v190.Y, v190.Z, u14.value, Shoulder_upv_1.Value()}
                local X_1 = value_17.X
                local Y_1 = value_17.Y
                local Z_1 = value_17.Z
                local value_18 = u16.value
                local value_19 = u17.value
                local value_20 = u13.value
                local v192 = u30
                local v193 = ((u35 == "none") and 0) or (((u35 ~= "death") and 2) or 1)
                local v194 = Shoulder_upv_1.Get()
                local v195 = ((LocalPlayer_upv_1:GetAttribute("Frozen") ~= true) and 0) or 1
                tbl_23[17], tbl_23[18], tbl_23[19], tbl_23[20], tbl_23[21], tbl_23[22], tbl_23[23], tbl_23[24], tbl_23[25], tbl_23[26], tbl_23[27], tbl_23[28] = X_1, Y_1, Z_1, value_18, value_19, value_20, v192, v193, v191, v194, v195, u18.value.Magnitude
                table.insert(FrameLog_1, tbl_23)
            end
            if u35 == "none" then
                v152 = Smoothing_upv_1.DrawnModel() or v132
                v149 = (v129 or (v151.Position)) + Finite_upv_1.Offset(Smoothing_upv_1)
                v129 = v152 and (v152:FindFirstChild("Head"))
                local v196
                if (v129) and (v129:IsA("BasePart")) then
                    v196 = v129.Position
                else
                    v196 = v149 + Vector3.new(0, 1.5, 0)
                end
                v149 = (v151.Position - v196).Magnitude
                local v197 = 0
                if v149 < 2.6 then
                    v129 = math.clamp((2.6 - v149) / 1.6, 0, 0.85)
                else
                    v129 = v197
                end
                if u20 and u20.hide then
                    v129 = math.max(v129, tbl_upv_10.blend)
                end
                local v198 = 0
                if v132 and tbl_upv_10.blend < 0.5 then
                    if u69 then
                        v149 = v198
                    else
                        v149 = (headCrowdsCrosshair(CurrentCamera_1, u19) and 0.6) or v198
                    end
                else
                    v149 = v198
                end
                if v149 > 0 then
                    v188 = true
                else
                    v188 = false
                end
                u19 = v188
                tbl_upv_9.headFade = tbl_upv_9.headFade + ((v149 - tbl_upv_9.headFade) * (1 - math.exp(a1 * -12)))
                if v149 == 0 and tbl_upv_9.headFade < 0.02 then
                    tbl_upv_9.headFade = 0
                end
                local v199
                if u69 then
                    v199 = 0
                else
                    v199 = v129
                end
                setCharacterFade(v152, v199, tbl_upv_9.headFade, u69)
                Fades_upv_1.UpdateAllies(v151.Position, v196, v132)
                Fades_upv_1.UpdateDecor(v151.Position, v196)
                tbl_upv_9.propFadeFrame = tbl_upv_9.propFadeFrame + 1
                if not (u72 <= tbl_upv_9.propFadeFrame) then
                    return
                end
                tbl_upv_9.propFadeFrame = 0
                updatePropFade(v151.Position, v196, (ignoreList(v132)))
            else
                tbl_upv_9.propFadeFrame = tbl_upv_9.propFadeFrame + 1
                if u72 <= tbl_upv_9.propFadeFrame then
                    tbl_upv_9.propFadeFrame = 0
                    updatePropFade(v151.Position, v152, (ignoreList(v132)))
                end
                Fades_upv_1.ClearAllies()
                Fades_upv_1.UpdateDecor(v151.Position, v152)
            end
        end
    else
        u69 = false
    end
end
local function countTouches()
    --[[
      name: countTouches
      line: 1419
      upvalues:
        tbl_upv_11 (copy, index: 1)
    ]]
    local v200 = 0
    for _ in tbl_upv_11 do
        v200 = v200 + 1
    end
    return v200
end
local u78 = nil
local function inThumbstickArea(a1)
    --[[
      name: inThumbstickArea
      line: 1433
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        Workspace_upv_1 (copy, index: 2)
    ]]
    local v201 = LocalPlayer_upv_1:FindFirstChildOfClass("PlayerGui")
    local v202 = v201 and (v201:FindFirstChild("TouchGui"))
    if v202 and v202:IsA("ScreenGui") and v202.Enabled then
        v201 = v202:FindFirstChild("TouchControlFrame")
    else
        v201 = nil
    end
    local v203 = false
    v202 = v203
    for _, value_21 in {"DynamicThumbstickFrame", "ThumbstickFrame"} do
        local v204 = v201 and (v201:FindFirstChild(value_21))
        if not (v204) then
            continue
        end
        local v205 = v204:IsA("GuiObject")
        if not (v205) or not (v204.Visible) then
            continue
        end
        local v206 = true
        local AbsolutePosition_1 = v204.AbsolutePosition
        local v207 = AbsolutePosition_1 + v204.AbsoluteSize
        if not (AbsolutePosition_1.X <= a1.X) or not (AbsolutePosition_1.Y <= a1.Y) or not (a1.X <= v207.X) or not (a1.Y <= v207.Y) then
            v202 = v206
            continue
        end
        return true
    end
    if v202 then
        return false
    end
    local CurrentCamera_2 = Workspace_upv_1.CurrentCamera
    return (CurrentCamera_2 ~= nil) and ((a1.X < CurrentCamera_2.ViewportSize.X * 0.4) and (CurrentCamera_2.ViewportSize.Y / 3 < a1.Y))
end
local function onInputBegan(a1, a2)
    --[[
      name: onInputBegan
      line: 1457
      upvalues:
        u78 (ref,  index: 1)
        inThumbstickArea (copy, index: 2)
        tbl_upv_8 (copy, index: 3)
        tbl_upv_11 (copy, index: 4)
        u34 (ref,  index: 5)
    ]]
    if a1.UserInputType ~= Enum.UserInputType.Touch then
        return
    end
    if not (a2) then
        local v208
        if u78 then
            v208 = u78.UserInputState
        else
            v208 = nil
        end
        if v208 == Enum.UserInputState.End or v208 == Enum.UserInputState.Cancel then
            u78 = nil
        end
        if (u78) or not inThumbstickArea(a1.Position) then
            tbl_upv_11[a1] = true
            u34 = nil
        end
        u78 = a1
        tbl_upv_8.touchesIgnored = tbl_upv_8.touchesIgnored + 1
    end
end
local function onInputChanged(a1, a2)
    --[[
      name: onInputChanged
      line: 1476
      upvalues:
        tbl_upv_11 (copy, index: 1)
        Guards_upv_1 (copy, index: 2)
        zero_upv_1 (ref,  index: 3)
        u34 (ref,  index: 4)
        u9 (ref,  index: 5)
        u33 (ref,  index: 6)
    ]]
    if a1.UserInputType ~= Enum.UserInputType.Touch then
        if a1.KeyCode == Enum.KeyCode.Thumbstick2 then
            u33 = Vector2.new(a1.Position.X, a1.Position.Y)
        end
    elseif tbl_upv_11[a1] then
        Guards_upv_1.PruneTouches(tbl_upv_11)
        local v209 = 0
        for _ in tbl_upv_11 do
            v209 = v209 + 1
        end
        if v209 == 1 then
            zero_upv_1 = zero_upv_1 + Vector2.new(a1.Delta.X, a1.Delta.Y)
        elseif v209 == 2 then
            local v210 = nil
            local v211 = nil
            local v212 = v210
            for key_5 in tbl_upv_11 do
                if v212 then
                    v211 = key_5
                else
                    v212 = key_5
                end
            end
            if not v212 or not v211 then
                return
            end
            local Magnitude_1 = (Vector2.new(v212.Position.X, v212.Position.Y) - Vector2.new(v211.Position.X, v211.Position.Y)).Magnitude
            if u34 then
                u9 = math.clamp(u9 - ((Magnitude_1 - u34) * 0.03), 7, 14)
            end
            u34 = Magnitude_1
        end
    end
end
local function onInputEnded(a1, a2)
    --[[
      name: onInputEnded
      line: 1508
      upvalues:
        u78 (ref,  index: 1)
        tbl_upv_11 (copy, index: 2)
        u34 (ref,  index: 3)
        u33 (ref,  index: 4)
    ]]
    if a1.UserInputType == Enum.UserInputType.Touch then
        if a1 == u78 then
            u78 = nil
        end
        tbl_upv_11[a1] = nil
        u34 = nil
    elseif a1.KeyCode == Enum.KeyCode.Thumbstick2 then
        u33 = Vector2.zero
    end
end
local function start()
    --[[
      name: start
      line: 1520
      upvalues:
        u12 (ref,  index: 1)
        u3 (copy, index: 2)
        Spectate_upv_1 (copy, index: 3)
        Smoothing_upv_1 (copy, index: 4)
        LocalPlayer_upv_1 (copy, index: 5)
        u72 (ref,  index: 6)
        tbl_upv_19 (copy, index: 7)
        Workspace_upv_1 (copy, index: 8)
        u4 (ref,  index: 9)
        Players_upv_1 (copy, index: 10)
        markIgnoreDirty (copy, index: 11)
        u62 (ref,  index: 12)
        Fighters_upv_1 (copy, index: 13)
        UserInputService_upv_1 (copy, index: 14)
        onInputBegan (copy, index: 15)
        onInputChanged (copy, index: 16)
        onInputEnded (copy, index: 17)
        Guards_upv_1 (copy, index: 18)
        tbl_upv_1 (copy, index: 19)
        Keybinds_upv_1 (copy, index: 20)
        ContextActionService_upv_1 (copy, index: 21)
        u28 (ref,  index: 22)
        tbl_upv_3 (copy, index: 23)
        GuiService_upv_1 (copy, index: 24)
        Shoulder_upv_1 (copy, index: 25)
        u35 (ref,  index: 26)
        tbl_upv_10 (copy, index: 27)
        u20 (ref,  index: 28)
        tbl_upv_9 (copy, index: 29)
        u71 (ref,  index: 30)
        tbl_upv_16 (copy, index: 31)
        tbl_upv_17 (copy, index: 32)
        u65 (ref,  index: 33)
        u66 (ref,  index: 34)
        u67 (ref,  index: 35)
        u68 (ref,  index: 36)
        u24 (ref,  index: 37)
        u25 (ref,  index: 38)
        u26 (ref,  index: 39)
        u27 (ref,  index: 40)
        Simulation_upv_1 (copy, index: 41)
        u6 (ref,  index: 42)
        tbl_upv_7 (copy, index: 43)
        u18 (copy, index: 44)
        u17 (copy, index: 45)
        u30 (ref,  index: 46)
        u5 (ref,  index: 47)
        u29 (ref,  index: 48)
        tbl_upv_4 (copy, index: 49)
        tbl_upv_11 (copy, index: 50)
        RunService_upv_1 (copy, index: 51)
        u61 (ref,  index: 52)
        update (copy, index: 53)
        tbl_upv_8 (copy, index: 54)
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
              line: 1530
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
              line: 1534
              upvalues:
                LocalPlayer_upv_1 (copy, index: 1)
                u72 (ref,  index: 2)
                tbl_upv_19 (copy, index: 3)
            ]]
            local u79 = LocalPlayer_upv_1:WaitForChild("PlayerScripts", 30)
            if not u79 then
                return
            end
            local function readLevel_1()
                --[[
                  name: readLevel
                  line: 1539
                  upvalues:
                    u72 (ref,  index: 1)
                    tbl_upv_19 (copy, index: 2)
                    u79 (copy, index: 3)
                ]]
                u72 = tbl_upv_19[u79:GetAttribute("CharacterQualityLevel")] or 1
            end
            u72 = tbl_upv_19[u79:GetAttribute("CharacterQualityLevel")] or 1
            u79:GetAttributeChangedSignal("CharacterQualityLevel"):Connect(readLevel_1)
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
              line: 1552
              upvalues:
                markIgnoreDirty (copy, index: 1)
                u62 (ref,  index: 2)
            ]]
            a1.CharacterAdded:Connect(markIgnoreDirty)
            a1.CharacterRemoving:Connect(markIgnoreDirty)
            u62 = true
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
              line: 1562
              upvalues:
                Guards_upv_1 (copy, index: 1)
                tbl_upv_1 (copy, index: 2)
            ]]
            local TextChatService_1 = game:GetService("TextChatService")
            local u80 = TextChatService_1:FindFirstChildOfClass("ChatInputBarConfiguration") or (TextChatService_1:WaitForChild("ChatInputBarConfiguration", 10))
            if not u80 or not u80:IsA("ChatInputBarConfiguration") then
                return
            end
            Guards_upv_1.SetChatConfig(u80)
            u80:GetPropertyChangedSignal("IsFocused"):Connect(
                function()
                    --[[
                      line: 1567
                      upvalues:
                        u80 (copy, index: 1)
                        tbl_upv_1 (copy, index: 2)
                    ]]
                    if u80.IsFocused then
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
              line: 1576
              upvalues:
                tbl_upv_1 (copy, index: 1)
            ]]
            tbl_upv_1.PushMouseUnlock("TextBox")
        end
    )
    UserInputService_upv_1.TextBoxFocusReleased:Connect(
        function()
            --[[
              line: 1579
              upvalues:
                tbl_upv_1 (copy, index: 1)
            ]]
            tbl_upv_1.PopMouseUnlock("TextBox")
        end
    )
    local function bindKeys_upv_1()
        --[[
          name: bindKeys
          line: 1589
          upvalues:
            Keybinds_upv_1 (copy, index: 1)
            ContextActionService_upv_1 (copy, index: 2)
            Guards_upv_1 (copy, index: 3)
            u28 (ref,  index: 4)
            tbl_upv_3 (copy, index: 5)
            tbl_upv_1 (copy, index: 6)
            GuiService_upv_1 (copy, index: 7)
            Shoulder_upv_1 (copy, index: 8)
            u35 (ref,  index: 9)
        ]]
        local v213 = Keybinds_upv_1.Inputs("FreeCursor")
        if #v213 ~= 0 then
            ContextActionService_upv_1:BindActionAtPriority(
                "TribesFreeCursor",
                function(a2, a3, a4)
                    --[[
                      line: 1594
                      upvalues:
                        Guards_upv_1 (copy, index: 1)
                        u28 (ref,  index: 2)
                        tbl_upv_3 (copy, index: 3)
                        tbl_upv_1 (copy, index: 4)
                    ]]
                    if a3 == Enum.UserInputState.Begin then
                        Guards_upv_1.FreeKeyDown(a4)
                    elseif a3 ~= Enum.UserInputState.End then
                        Guards_upv_1.FreeKeyCancel()
                    elseif Guards_upv_1.FreeKeyUp() and not (u28) then
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
              line: 1613
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
                      line: 1624
                      upvalues:
                        tbl_upv_3 (copy, index: 1)
                        GuiService_upv_1 (copy, index: 2)
                        u28 (ref,  index: 3)
                        Shoulder_upv_1 (copy, index: 4)
                    ]]
                    if a7 == Enum.UserInputState.Begin then
                        local v217 = true
                        if next(tbl_upv_3) == nil then
                            v217 = GuiService_upv_1.MenuIsOpen
                        end
                        if not (v217) and not (u28) then
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
                  line: 1632
                  upvalues:
                    tbl_upv_3 (copy, index: 1)
                    GuiService_upv_1 (copy, index: 2)
                    u28 (ref,  index: 3)
                    u35 (ref,  index: 4)
                    tbl_upv_1 (copy, index: 5)
                ]]
                if a9 == Enum.UserInputState.Begin then
                    local v218 = true
                    if next(tbl_upv_3) == nil then
                        v218 = GuiService_upv_1.MenuIsOpen
                    end
                    if not (v218) and not (u28) and u35 == "none" then
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
          line: 1641
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
              line: 1651
              upvalues:
                tbl_upv_10 (copy, index: 1)
                u20 (ref,  index: 2)
                tbl_upv_9 (copy, index: 3)
                u71 (ref,  index: 4)
                tbl_upv_16 (copy, index: 5)
                tbl_upv_17 (copy, index: 6)
                u65 (ref,  index: 7)
                u66 (ref,  index: 8)
                u67 (ref,  index: 9)
                u68 (ref,  index: 10)
                u24 (ref,  index: 11)
                u25 (ref,  index: 12)
                u26 (ref,  index: 13)
                u27 (ref,  index: 14)
                Simulation_upv_1 (copy, index: 15)
                u6 (ref,  index: 16)
                tbl_upv_7 (copy, index: 17)
                u18 (copy, index: 18)
                tbl_upv_1 (copy, index: 19)
                u17 (copy, index: 20)
                u30 (ref,  index: 21)
                u4 (ref,  index: 22)
                u5 (ref,  index: 23)
                u29 (ref,  index: 24)
                u28 (ref,  index: 25)
            ]]
            tbl_upv_10.target = 0
            tbl_upv_10.blend = 0
            u20 = nil
            tbl_upv_9.headFade = 0
            local _ = 0
            if u71 ~= nil then
                for v220, value_27 in tbl_upv_16 do
                    local inst_6 = value_27.inst
                    if not (inst_6.Parent) then
                        continue
                    end
                    if inst_6.LocalTransparencyModifier ~= 0 then
                        inst_6.LocalTransparencyModifier = 0
                    end
                end
                for v221, value_28 in tbl_upv_17 do
                    value_28:Disconnect()
                end
                table.clear(tbl_upv_17)
                table.clear(tbl_upv_16)
                u71 = nil
                u65 = true
                u66 = -1
                u67 = -1
                u68 = false
            end
            for v222, value_29 in a11:GetDescendants() do
                if value_29:IsA("BasePart") or value_29:IsA("Decal") then
                    value_29.LocalTransparencyModifier = 0
                end
            end
            u24 = nil
            u25 = nil
            u26 = false
            u27 = false
            Simulation_upv_1.SetFacing(nil)
            u71 = nil
            u6 = false
            table.clear(tbl_upv_7)
            u18:Snap(Vector3.new(0, 0, 0))
            tbl_upv_1.SlowRecoil:Snap(Vector3.new(0, 0, 0))
            tbl_upv_1.SlowRecoilStay = Vector3.new(0, 0, 0)
            u17:Snap(0)
            u30 = 1
            tbl_upv_1.PopMouseUnlock("FreeCursor")
            local u81 = a11:WaitForChild("HumanoidRootPart", 5)
            if not u81 then
                return
            end
            if u81:IsA("BasePart") then
                local LookVector_7 = u81.CFrame.LookVector
                local v219 = math.atan2(-LookVector_7.X, -LookVector_7.Z)
                u4 = v219
                u5 = -0.20943951023931956
                u29 = u28
                local u82 = os.clock()
                local Position_upv_3 = u81.Position
                task.spawn(
                    function()
                        --[[
                          line: 1686
                          upvalues:
                            u82 (copy, index: 1)
                            u81 (copy, index: 2)
                            Position_upv_3 (ref,  index: 3)
                            u4 (ref,  index: 4)
                            u5 (ref,  index: 5)
                            u29 (ref,  index: 6)
                            u28 (ref,  index: 7)
                        ]]
                        while os.clock() - u82 < 1.5 and (u81.Parent) do
                            task.wait(0.05)
                            if (u81.Position - Position_upv_3).Magnitude > 40 then
                                local _ = u81.CFrame.LookVector
                                u4 = math.atan2(-u81.CFrame.LookVector.X, -u81.CFrame.LookVector.Z)
                                u5 = -0.20943951023931956
                                u29 = u28
                            end
                            Position_upv_3 = u81.Position
                        end
                    end
                )
            end
        end
    )
    local function popUnlock_1(a12)
        --[[
          name: popUnlock
          line: 1706
          upvalues:
            tbl_upv_1 (copy, index: 1)
        ]]
        tbl_upv_1.PopMouseUnlock(a12)
    end
    local function popLookLock_1(a13)
        --[[
          name: popLookLock
          line: 1703
          upvalues:
            tbl_upv_1 (copy, index: 1)
        ]]
        tbl_upv_1.PopLookLock(a13)
    end
    local function blockers_1()
        --[[
          name: blockers
          line: 1709
          upvalues:
            tbl_upv_1 (copy, index: 1)
        ]]
        return tbl_upv_1.GetLookBlockers()
    end
    Guards_upv_1.Start({lookLocks = tbl_upv_4, unlockReasons = tbl_upv_3, touches = tbl_upv_11, popLookLock = popLookLock_1, popUnlock = popUnlock_1, blockers = blockers_1})
    RunService_upv_1:BindToRenderStep(
        "TribesCamera",
        Enum.RenderPriority.Camera.Value + 1,
        function(a14)
            --[[
              line: 1713
              upvalues:
                u61 (ref,  index: 1)
                update (copy, index: 2)
                Simulation_upv_1 (copy, index: 3)
                u4 (ref,  index: 4)
                tbl_upv_8 (copy, index: 5)
            ]]
            local v220 = os.clock()
            u61()
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
      line: 1734
      upvalues:
        u6 (ref, index: 1)
        u35 (ref, index: 2)
        u7 (ref, index: 3)
    ]]
    local v222 = (a1 == true) and (u35 == "none")
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
      line: 1741
      upvalues:
        u6 (ref, index: 1)
    ]]
    return u6
end
function tbl_upv_1.GetAimRay()
    --[[
      name: GetAimRay
      line: 1747
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
      line: 1760
      upvalues:
        tbl_upv_1 (copy, index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
        tbl_upv_15 (copy, index: 3)
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
    local tbl_24 = {}
    if v225 then
        table.insert(tbl_24, v225)
    end
    for _, value_30 in tbl_upv_15 do
        local v229 = Workspace_upv_1:FindFirstChild(value_30)
        if v229 then
            table.insert(tbl_24, v229)
        end
    end
    if a2 then
        for _, value_31 in a2 do
            table.insert(tbl_24, value_31)
        end
    end
    local v230 = RaycastParams.new()
    v230.FilterType = Enum.RaycastFilterType.Exclude
    v230.FilterDescendantsInstances = tbl_24
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
      line: 1801
      upvalues:
        tbl_upv_13 (copy, index: 1)
    ]]
    if typeof(a1) ~= "number" or a1 ~= a1 then
        return
    end
    tbl_upv_13.amount = math.clamp(a1, -20, 20)
    tbl_upv_13.t0 = os.clock()
    tbl_upv_13.rise = math.max(a2 or 0.05, 0.01)
    tbl_upv_13.fall = math.max(a3 or 0.2, 0.01)
end
function tbl_upv_1.Shake(a1, a2)
    --[[
      name: Shake
      line: 1813
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
      line: 1827
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
      line: 1840
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
      line: 1849
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
      line: 1856
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
      line: 1863
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
      line: 1876
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
      line: 1882
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
      line: 1888
      upvalues:
        tbl_upv_4 (copy, index: 1)
    ]]
    local v234 = next(tbl_upv_4) ~= nil
    return v234
end
function tbl_upv_1.GetLookBlockers()
    --[[
      name: GetLookBlockers
      line: 1896
      upvalues:
        u11 (ref,  index: 1)
        u28 (ref,  index: 2)
        u35 (ref,  index: 3)
        tbl_upv_10 (copy, index: 4)
        tbl_upv_4 (copy, index: 5)
        tbl_upv_3 (copy, index: 6)
        GuiService_upv_1 (copy, index: 7)
    ]]
    local tbl_25 = {}
    if not (u11) then
        table.insert(tbl_25, "disabled")
    end
    if u28 then
        table.insert(tbl_25, "lobby")
    end
    if u35 ~= "none" then
        table.insert(tbl_25, "spectate:" .. u35)
    end
    if tbl_upv_10.target > 0 or tbl_upv_10.blend > 0 then
        table.insert(tbl_25, "cinematic")
    end
    for key_6 in tbl_upv_4 do
        table.insert(tbl_25, "lock:" .. key_6)
    end
    for key_7 in tbl_upv_3 do
        table.insert(tbl_25, "unlock:" .. key_7)
    end
    if GuiService_upv_1.MenuIsOpen then
        table.insert(tbl_25, "robloxMenu")
    end
    table.sort(tbl_25)
    return tbl_25
end
function tbl_upv_1.IsMouseUnlocked()
    --[[
      name: IsMouseUnlocked
      line: 1925
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
      line: 1931
      upvalues:
        u28 (ref, index: 1)
    ]]
    if u28 then
        return "lobby"
    end
    return "combat"
end
function tbl_upv_1.GetUnlockReasons()
    --[[
      name: GetUnlockReasons
      line: 1935
      upvalues:
        tbl_upv_3 (copy, index: 1)
    ]]
    local tbl_26 = {}
    for key_8 in tbl_upv_3 do
        table.insert(tbl_26, key_8)
    end
    return tbl_26
end
function tbl_upv_1.GetShoulderSide()
    --[[
      name: GetShoulderSide
      line: 1944
      upvalues:
        Shoulder_upv_1 (copy, index: 1)
    ]]
    return Shoulder_upv_1.Get()
end
tbl_upv_1.FirstPersonChanged = u70.Event
function tbl_upv_1.SetFirstPerson(a1)
    --[[
      name: SetFirstPerson
      line: 1952
      upvalues:
        FirstPerson_upv_1 (copy, index: 1)
        u70 (copy, index: 2)
    ]]
    a1 = a1 == true
    if FirstPerson_upv_1.Get() == a1 then
        return
    end
    FirstPerson_upv_1.Set(a1)
    u70:Fire(a1)
end
function tbl_upv_1.IsFirstPerson()
    --[[
      name: IsFirstPerson
      line: 1960
      upvalues:
        FirstPerson_upv_1 (copy, index: 1)
    ]]
    return FirstPerson_upv_1.Get()
end
function tbl_upv_1.ToggleFirstPerson()
    --[[
      name: ToggleFirstPerson
      line: 1964
      upvalues:
        tbl_upv_1 (copy, index: 1)
        FirstPerson_upv_1 (copy, index: 2)
    ]]
    tbl_upv_1.SetFirstPerson(not FirstPerson_upv_1.Get())
end
function tbl_upv_1.InFirstPerson()
    --[[
      name: InFirstPerson
      line: 1969
      upvalues:
        u69 (ref, index: 1)
    ]]
    return u69
end
function tbl_upv_1.SetViewBobbing(a1)
    --[[
      name: SetViewBobbing
      line: 1975
      upvalues:
        FirstPerson_upv_1 (copy, index: 1)
    ]]
    FirstPerson_upv_1.SetBobbing(a1)
end
function tbl_upv_1.GetViewBobbing()
    --[[
      name: GetViewBobbing
      line: 1979
      upvalues:
        FirstPerson_upv_1 (copy, index: 1)
    ]]
    return FirstPerson_upv_1.GetBobbing()
end
function tbl_upv_1.GetViewBob()
    --[[
      name: GetViewBob
      line: 1985
      upvalues:
        FirstPerson_upv_1 (copy, index: 1)
    ]]
    return FirstPerson_upv_1.Bob()
end
function tbl_upv_1.SetShoulderSide(a1)
    --[[
      name: SetShoulderSide
      line: 1991
      upvalues:
        Shoulder_upv_1 (copy, index: 1)
    ]]
    Shoulder_upv_1.Set(a1)
end
function tbl_upv_1.SetModifier(a1, a2)
    --[[
      name: SetModifier
      line: 1996
      upvalues:
        tbl_upv_6 (copy, index: 1)
    ]]
    tbl_upv_6[a1] = a2
end
function tbl_upv_1.SuspendCharacterRotation(a1)
    --[[
      name: SuspendCharacterRotation
      line: 2001
      upvalues:
        tbl_upv_5 (copy, index: 1)
    ]]
    tbl_upv_5[tostring(a1)] = true
end
function tbl_upv_1.ResumeCharacterRotation(a1)
    --[[
      name: ResumeCharacterRotation
      line: 2005
      upvalues:
        tbl_upv_5 (copy, index: 1)
    ]]
    tbl_upv_5[tostring(a1)] = nil
end
function tbl_upv_1.FaceCamera()
    --[[
      name: FaceCamera
      line: 2011
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        u28 (ref,  index: 2)
        u27 (ref,  index: 3)
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
    if not v237 or not v238 or not (v238.Health > 0) or u28 ~= false then
        return
    end
    u27 = true
    Simulation_upv_1.SetFacing(u4)
end
function tbl_upv_1.GetAimAssistShot()
    --[[
      name: GetAimAssistShot
      line: 2029
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
      line: 2036
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
      line: 2044
      upvalues:
        AimAssist_upv_1 (copy, index: 1)
    ]]
    return AimAssist_upv_1.IsAssistedInput()
end
function tbl_upv_1.GetAimAssistInput()
    --[[
      name: GetAimAssistInput
      line: 2048
      upvalues:
        AimAssist_upv_1 (copy, index: 1)
    ]]
    return AimAssist_upv_1.InputKind()
end
function tbl_upv_1.Nudge(a1, a2)
    --[[
      name: Nudge
      line: 2052
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
      line: 2063
      upvalues:
        AimAssist_upv_1 (copy, index: 1)
    ]]
    AimAssist_upv_1.SetEnabled(a1)
end
function tbl_upv_1.GetAimAssistEnabled()
    --[[
      name: GetAimAssistEnabled
      line: 2067
      upvalues:
        AimAssist_upv_1 (copy, index: 1)
    ]]
    return AimAssist_upv_1.IsEnabled()
end
function tbl_upv_1.AimAssistDebug(a1, ...)
    --[[
      name: AimAssistDebug
      line: 2071
      upvalues:
        AimAssist_upv_1 (copy, index: 1)
    ]]
    return AimAssist_upv_1.Debug(a1, ...)
end
function tbl_upv_1.GetYaw()
    --[[
      name: GetYaw
      line: 2075
      upvalues:
        u4 (ref, index: 1)
    ]]
    return u4
end
function tbl_upv_1.GetPitch()
    --[[
      name: GetPitch
      line: 2079
      upvalues:
        u5 (ref, index: 1)
    ]]
    return u5
end
function tbl_upv_1.SetSensitivity(a1)
    --[[
      name: SetSensitivity
      line: 2085
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
      line: 2093
      upvalues:
        zero_upv_1 (ref, index: 1)
    ]]
    zero_upv_1 = zero_upv_1 + a1
end
function tbl_upv_1.GetSensitivity()
    --[[
      name: GetSensitivity
      line: 2097
      upvalues:
        u10 (ref, index: 1)
    ]]
    return u10
end
function tbl_upv_1.SetFOV(a1)
    --[[
      name: SetFOV
      line: 2102
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
      line: 2108
      upvalues:
        u8 (ref, index: 1)
    ]]
    return u8
end
function tbl_upv_1.SetAimZoom(a1)
    --[[
      name: SetAimZoom
      line: 2113
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
      line: 2120
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
      line: 2127
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
      line: 2134
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
      line: 2139
      upvalues:
        Spectate_upv_1 (copy, index: 1)
    ]]
    return Spectate_upv_1.GetTarget()
end
function tbl_upv_1.GetSpectateMode()
    --[[
      name: GetSpectateMode
      line: 2144
      upvalues:
        Spectate_upv_1 (copy, index: 1)
    ]]
    return Spectate_upv_1.GetMode()
end
function tbl_upv_1.GetKiller()
    --[[
      name: GetKiller
      line: 2149
      upvalues:
        Spectate_upv_1 (copy, index: 1)
    ]]
    return Spectate_upv_1.GetKiller()
end
tbl_upv_1.SpectateChanged = Spectate_upv_1.Changed
function tbl_upv_1.PlayCinematic(a1, a2, a3)
    --[[
      name: PlayCinematic
      line: 2162
      upvalues:
        u20 (ref,  index: 1)
        tbl_upv_10 (copy, index: 2)
        u21 (ref,  index: 3)
        u22 (ref,  index: 4)
        LocalPlayer_upv_1 (copy, index: 5)
        u23 (ref,  index: 6)
        Workspace_upv_1 (copy, index: 7)
        u8 (ref,  index: 8)
    ]]
    if typeof(a1) ~= "CFrame" then
        return
    end
    local v246 = a3 or {}
    local tbl_27 = {untilStopped = 0, hide = 0, fov = 0}
    tbl_27.cf = a1
    local v247
    if typeof(a2) ~= "number" then
        v247 = nil
    else
        v247 = math.clamp(a2, 20, 100)
    end
    tbl_27.fov = v247
    if v246.hideCharacter ~= false then
        v247 = true
    else
        v247 = false
    end
    tbl_27.hide = v247
    if v246.untilStopped == true then
        v247 = true
    else
        v247 = false
    end
    tbl_27.untilStopped = v247
    u20 = tbl_27
    tbl_upv_10.target = 1
    u21 = 1 / math.max(0.05, v246.duration or 0.6)
    tbl_upv_10.startedAt = os.clock()
    u22 = LocalPlayer_upv_1 and (LocalPlayer_upv_1.Character)
    if (tbl_27.fov) then
        return
    end
    v247 = Workspace_upv_1.CurrentCamera and Workspace_upv_1.CurrentCamera.FieldOfView or u8
    u23 = v247
end
function tbl_upv_1.StopCinematic(a1)
    --[[
      name: StopCinematic
      line: 2183
      upvalues:
        tbl_upv_10 (copy, index: 1)
        u21 (ref,  index: 2)
    ]]
    tbl_upv_10.target = 0
    u21 = 1 / math.max(0.05, a1 or 0.5)
end
function tbl_upv_1.IsCinematic()
    --[[
      name: IsCinematic
      line: 2188
      upvalues:
        tbl_upv_10 (copy, index: 1)
    ]]
    return tbl_upv_10.target > 0
end
function tbl_upv_1.SetEnabled(a1)
    --[[
      name: SetEnabled
      line: 2193
      upvalues:
        u11 (ref,  index: 1)
        Workspace_upv_1 (copy, index: 2)
        u8 (ref,  index: 3)
        UserInputService_upv_1 (copy, index: 4)
        LocalPlayer_upv_1 (copy, index: 5)
        u26 (ref,  index: 6)
        u27 (ref,  index: 7)
        Simulation_upv_1 (copy, index: 8)
        u69 (ref,  index: 9)
        FirstPerson_upv_1 (copy, index: 10)
        setCharacterFade (copy, index: 11)
        u71 (ref,  index: 12)
        tbl_upv_18 (copy, index: 13)
        Fades_upv_1 (copy, index: 14)
        u24 (ref,  index: 15)
    ]]
    u11 = a1
    local CurrentCamera_5 = Workspace_upv_1.CurrentCamera
    if a1 then
        u24 = nil
    else
        if CurrentCamera_5 then
            CurrentCamera_5.CameraType = Enum.CameraType.Custom
            CurrentCamera_5.FieldOfView = u8
        end
        UserInputService_upv_1.MouseBehavior = Enum.MouseBehavior.Default
        UserInputService_upv_1.MouseIconEnabled = true
        local v248
        if LocalPlayer_upv_1 then
            v248 = LocalPlayer_upv_1.Character
        else
            v248 = LocalPlayer_upv_1
        end
        local _
        if v248 then
            _ = v248:FindFirstChild("HumanoidRootPart")
            local v249 = v248:FindFirstChildOfClass("Humanoid")
        end
        u26 = false
        if u27 then
            Simulation_upv_1.SetFacing(nil)
            u27 = false
        end
        u69 = false
        FirstPerson_upv_1.Step(0, false)
        setCharacterFade(u71, 0, 0)
        for key_9 in tbl_upv_18 do
            if key_9.Parent then
                key_9.LocalTransparencyModifier = 0
            end
        end
        table.clear(tbl_upv_18)
        Fades_upv_1.ClearAllies()
        Fades_upv_1.ClearDecor()
    end
end
function tbl_upv_1.IsEnabled()
    --[[
      name: IsEnabled
      line: 2216
      upvalues:
        u11 (ref, index: 1)
    ]]
    return u11
end
function tbl_upv_1.DebugOcclusion(a1)
    --[[
      name: DebugOcclusion
      line: 2223
      upvalues:
        Occlusion_upv_1 (copy, index: 1)
    ]]
    return Occlusion_upv_1.Debug(a1)
end
tbl_upv_1.FrameLog = nil
function tbl_upv_1.DebugFrames(a1)
    --[[
      name: DebugFrames
      line: 2231
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
      line: 2244
      upvalues:
        Smoothing_upv_1 (copy, index: 1)
    ]]
    return Smoothing_upv_1.DrawnCFrame()
end
function tbl_upv_1.Drawn(a1)
    --[[
      name: Drawn
      line: 2248
      upvalues:
        Smoothing_upv_1 (copy, index: 1)
    ]]
    return Smoothing_upv_1.Drawn(a1)
end
function tbl_upv_1.GetDrawnModel()
    --[[
      name: GetDrawnModel
      line: 2252
      upvalues:
        Smoothing_upv_1 (copy, index: 1)
    ]]
    return Smoothing_upv_1.DrawnModel()
end
tbl_upv_1.DrawnChanged = Smoothing_upv_1.DrawnChanged
function tbl_upv_1.SmoothingTrace(a1)
    --[[
      name: SmoothingTrace
      line: 2260
      upvalues:
        Smoothing_upv_1 (copy, index: 1)
    ]]
    local v249 = Smoothing_upv_1.Trace(a1)
    if v249 then
        return (game:GetService("HttpService"):JSONEncode(v249))
    end
    return nil
end
function tbl_upv_1.DebugStats()
    --[[
      name: DebugStats
      line: 2265
      upvalues:
        tbl_upv_8 (copy, index: 1)
        Fades_upv_1 (copy, index: 2)
        AimAssist_upv_1 (copy, index: 3)
        Smoothing_upv_1 (copy, index: 4)
        Occlusion_upv_1 (copy, index: 5)
        Guards_upv_1 (copy, index: 6)
        RunService_upv_1 (copy, index: 7)
        Simulation_upv_1 (copy, index: 8)
        u69 (ref,  index: 9)
    ]]
    local v250 = os.clock()
    local v251 = math.max(0.001, v250 - tbl_upv_8.since)
    local tbl_28 = {msPerFrame = 0, touchesIgnored = 0, touchLookPx = 0, maxFrameMs = 0, fps = 0}
    tbl_28.msPerSec = (tbl_upv_8.time * 1000) / v251
    tbl_28.msPerFrame = ((tbl_upv_8.frames > 0) and (tbl_upv_8.time * 1000 / tbl_upv_8.frames)) or 0
    tbl_28.maxFrameMs = tbl_upv_8.max * 1000
    tbl_28.fps = tbl_upv_8.frames / v251
    tbl_28.touchLookPx = tbl_upv_8.touchLookPx
    tbl_28.touchesIgnored = tbl_upv_8.touchesIgnored
    tbl_upv_8.time = 0
    tbl_upv_8.max = 0
    tbl_upv_8.frames = 0
    tbl_upv_8.since = v250
    for key_10, value_32 in Fades_upv_1.Stats() do
        tbl_28[key_10] = value_32
    end
    for key_11, value_33 in AimAssist_upv_1.Stats() do
        tbl_28[key_11] = value_33
    end
    for key_12, value_34 in Smoothing_upv_1.Stats() do
        tbl_28[key_12] = value_34
    end
    for key_13, value_35 in Occlusion_upv_1.Debug("stats") do
        tbl_28["occ_" .. key_13] = value_35
    end
    for key_14, value_36 in Guards_upv_1.Stats() do
        tbl_28["guard_" .. key_14] = value_36
    end
    if RunService_upv_1:IsStudio() and Simulation_upv_1.WriteGuardStats then
        for key_15, value_37 in Simulation_upv_1.WriteGuardStats() do
            tbl_28["wg_" .. key_15] = value_37
        end
    end
    tbl_28.firstPerson = u69
    tbl_28.waterLifts = Occlusion_upv_1.WaterLifts()
    return tbl_28
end
if u3 and LocalPlayer_upv_1 then
    local TribesCameraBridge_upv_1 = LocalPlayer_upv_1:FindFirstChild("TribesCameraBridge")
    if TribesCameraBridge_upv_1 then
        local v252 = TribesCameraBridge_upv_1:IsA("BindableFunction")
        if v252 then
            for key_upv_16, value_38 in tbl_upv_1 do
                if type(value_38) == "function" then
                    tbl_upv_1[key_upv_16] = function(...)
                        --[[
                          line: 2313
                          upvalues:
                            TribesCameraBridge_upv_1 (copy, index: 1)
                            key_upv_16 (copy, index: 2)
                        ]]
                        return TribesCameraBridge_upv_1:Invoke(key_upv_16, ...)
                    end
                end
            end
        else
            local v253 = Instance.new("BindableFunction")
            v253.Name = "TribesCameraBridge"
            local u83 = table.clone(tbl_upv_1)
            v253.OnInvoke = function(a1, ...)
                --[[
                  line: 2322
                  upvalues:
                    u83 (copy, index: 1)
                ]]
                local v254 = u83[a1]
                if type(v254) ~= "function" then
                    return nil
                end
                return v254(...)
            end
            v253.Parent = LocalPlayer_upv_1
            start()
        end
    else
        local v253 = Instance.new("BindableFunction")
        v253.Name = "TribesCameraBridge"
        local u83 = table.clone(tbl_upv_1)
        v253.OnInvoke = function(a1, ...)
            --[[
              line: 2322
              upvalues:
                u83 (copy, index: 1)
            ]]
            local v254 = u83[a1]
            if type(v254) ~= "function" then
                return nil
            end
            return v254(...)
        end
        v253.Parent = LocalPlayer_upv_1
        start()
    end
end
return tbl_upv_1