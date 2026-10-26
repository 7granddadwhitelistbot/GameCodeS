local CollectionService_upv_1 = game:GetService("CollectionService")
local Players_upv_1 = game:GetService("Players")
local ReplicatedStorage_upv_1 = game:GetService("ReplicatedStorage")
local RunService_1 = game:GetService("RunService")
local Weapons_upv_1 = require(ReplicatedStorage_upv_1:WaitForChild("Shared"):WaitForChild("Weapons"))
local tbl_upv_1 = {}
local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
local tbl_2 = {"LinearVelocity", "VectorForce", "AlignOrientation", "AlignPosition", "AngularVelocity", "BodyVelocity", "BodyGyro", "BodyPosition", "BodyForce", "BodyAngularVelocity", "Torque"}
local tbl_upv_3 = {}
for _, value_1 in tbl_2 do
    tbl_upv_3[value_1] = true
end
local tbl_upv_4 = {ProximityPrompt = true, ForceField = true, SelectionBox = true, Smoke = true, Explosion = true, BillboardGui = true, Sparkles = true, SurfaceGui = true, ClickDetector = true, Sound = true, Fire = true, Tool = true, Highlight = true}
local function rigidJoints(a1)
    --[[
      name: rigidJoints
      line: 137
    ]]
    local v1 = nil
    for _, value_2 in a1:GetDescendants() do
        if value_2:IsA("AnimationConstraint") or value_2:IsA("RigidConstraint") then
            local Attachment0_1 = value_2.Attachment0
            local Attachment1_1 = value_2.Attachment1
            local v2 = Attachment1_1 and (Attachment1_1.Parent)
            if not (Attachment0_1) then
                value_2:Destroy()
                continue
            end
            if not (Attachment1_1) then
                value_2:Destroy()
                continue
            end
            if not (Attachment0_1) then
                value_2:Destroy()
                continue
            end
            if not (v2) then
                value_2:Destroy()
                continue
            end
            local v3 = Attachment0_1:IsA("BasePart")
            if not (v3) then
                value_2:Destroy()
                continue
            end
            local v4 = v2:IsA("BasePart")
            if not (v4) then
                value_2:Destroy()
                continue
            end
            if value_2:IsA("AnimationConstraint") then
                v1 = Instance.new("Motor6D")
            else
                v1 = Instance.new("Weld")
            end
            v1.Name = value_2.Name
            v1.Part0 = Attachment0_1
            v1.Part1 = Attachment1_1
            v1.C0 = Attachment0_1.CFrame
            v1.C1 = Attachment1_1.CFrame
            v1.Parent = Attachment1_1
            value_2:Destroy()
        end
        if value_2:IsA("BallSocketConstraint") or value_2:IsA("HingeConstraint") or value_2:IsA("NoCollisionConstraint") then
            value_2:Destroy()
            continue
        end
        if value_2:IsA("Motor6D") then
            value_2.Transform = CFrame.identity
        end
    end
end
local function strip(a1)
    --[[
      name: strip
      line: 101
      upvalues:
        tbl_upv_4 (copy, index: 1)
        tbl_upv_3 (copy, index: 2)
    ]]
    for _, value_3 in a1:GetTags() do
        a1:RemoveTag(value_3)
    end
    for _, value_4 in {"MatchId", "Team", "CombatantId", "IsBot", "Frozen", "Blocking", "ShotNonce"} do
        a1:SetAttribute(value_4, nil)
    end
    local v5 = nil
    for _, value_5 in a1:GetDescendants() do
        local ClassName_1 = value_5.ClassName
        if value_5:IsA("ParticleEmitter") or value_5:IsA("Trail") or value_5:IsA("Beam") then
            v5 = value_5:FindFirstAncestorOfClass("Accessory") == nil
        else
            v5 = value_5:IsA("Light")
            if v5 then
                v5 = value_5:FindFirstAncestorOfClass("Accessory") == nil
            end
        end
        if value_5:IsA("LuaSourceContainer") or tbl_upv_4[ClassName_1] or tbl_upv_3[ClassName_1] or v5 then
            value_5:Destroy()
            continue
        end
        for v6, value_6 in value_5:GetTags() do
            value_5:RemoveTag(value_6)
        end
        if value_5:IsA("BasePart") then
            value_5.CanCollide = false
            value_5.CanQuery = false
            value_5.CanTouch = false
            value_5.LocalTransparencyModifier = 0
            continue
        end
        if value_5:IsA("Decal") then
            value_5.LocalTransparencyModifier = 0
        end
    end
end
local function hasBody(a1)
    --[[
      name: hasBody
      line: 164
    ]]
    local Head_1 = a1:FindFirstChild("Head")
    local v6 = a1:FindFirstChild("UpperTorso") or (a1:FindFirstChild("Torso"))
    local v7 = (Head_1 ~= nil) and (Head_1:IsA("BasePart") and ((v6 ~= nil) and (v6:IsA("BasePart"))))
    return v7
end
function tbl_upv_1.Snapshot(a1)
    --[[
      name: Snapshot
      line: 172
      upvalues:
        hasBody (copy, index: 1)
        strip (copy, index: 2)
        rigidJoints (copy, index: 3)
    ]]
    if not a1.Parent then
        return nil, "gone"
    end
    if not a1:FindFirstChildOfClass("Humanoid") then
        return nil, "nohum"
    end
    if not a1:FindFirstChild("HumanoidRootPart") then
        return nil, "noroot"
    end
    if not hasBody(a1) then
        return nil, "nobody"
    end
    local Archivable_1 = a1.Archivable
    a1.Archivable = true
    local success_1, v8 = pcall(
        function()
            --[[
              line: 184
              upvalues:
                a1 (copy, index: 1)
            ]]
            return a1:Clone()
        end
    )
    a1.Archivable = Archivable_1
    if success_1 and v8 then
        if hasBody(v8) and v8:FindFirstChild("HumanoidRootPart") then
            strip(v8)
            rigidJoints(v8)
            return v8, nil
        end
        v8:Destroy()
        return nil, "noclone"
    end
    return nil, "noclone"
end
local function aliveWithBody(a1)
    --[[
      name: aliveWithBody
      line: 202
      upvalues:
        hasBody (copy, index: 1)
    ]]
    local v9 = a1:FindFirstChildOfClass("Humanoid")
    local v10 = (v9 ~= nil) and ((v9.Health > 0) and ((a1:FindFirstChild("HumanoidRootPart") ~= nil) and (hasBody(a1))))
    return v10
end
function tbl_upv_1.FindLive(a1)
    --[[
      name: FindLive
      line: 208
      upvalues:
        CollectionService_upv_1 (copy, index: 1)
        Players_upv_1 (copy, index: 2)
    ]]
    for _, value_7 in CollectionService_upv_1:GetTagged("Combatant") do
        if not (value_7:IsA("Model")) or value_7:GetAttribute("CombatantId") ~= a1 or not (value_7.Parent) then
            continue
        end
        return value_7
    end
    local v11 = nil
    for _, value_8 in Players_upv_1:GetPlayers() do
        v11 = value_8.Character
        if not (v11) or v11:GetAttribute("CombatantId") ~= a1 or not (v11.Parent) then
            continue
        end
        return v11
    end
    return nil
end
local tbl_upv_5 = {}
local u1 = ""
local tbl_upv_6 = {}
local tbl_upv_7 = {}
local u2 = false
local function pump()
    --[[
      name: pump
      line: 231
      upvalues:
        u2 (ref, index: 1)
    ]]
    if u2 then
        return
    end
    u2 = true
    task.spawn(function() end)
end
local function clearCache()
    --[[
      name: clearCache
      line: 259
      upvalues:
        tbl_upv_5 (copy, index: 1)
        tbl_upv_6 (copy, index: 2)
        tbl_upv_7 (copy, index: 3)
    ]]
    for _, value_9 in tbl_upv_5 do
        value_9:Destroy()
    end
    table.clear(tbl_upv_5)
    table.clear(tbl_upv_6)
    table.clear(tbl_upv_7)
end
function tbl_upv_1.CacheMatch()
    --[[
      name: CacheMatch
      line: 270
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        u1 (ref,  index: 2)
        clearCache (copy, index: 3)
        tbl_upv_7 (copy, index: 4)
        tbl_upv_6 (copy, index: 5)
        CollectionService_upv_1 (copy, index: 6)
        Players_upv_1 (copy, index: 7)
        u2 (ref,  index: 8)
        tbl_upv_1 (copy, index: 9)
        hasBody (copy, index: 10)
        tbl_upv_5 (copy, index: 11)
    ]]
    local u3 = LocalPlayer_upv_1:GetAttribute("MatchId")
    if type(u3) ~= "string" or u3 == "" then
        return
    end
    if u3 ~= u1 then
        clearCache()
        u1 = u3
    end
    local function consider(a1)
        --[[
          name: consider
          line: 279
          upvalues:
            u3 (copy, index: 1)
            tbl_upv_7 (copy, index: 2)
            tbl_upv_6 (copy, index: 3)
        ]]
        if not a1 or not a1:IsA("Model") then
            return
        end
        if a1:GetAttribute("MatchId") == u3 then
            local v12 = a1:GetAttribute("CombatantId")
            if type(v12) == "string" and v12 ~= "" and not (tbl_upv_7[v12]) then
                tbl_upv_7[v12] = true
                table.insert(tbl_upv_6, v12)
            end
        end
    end
    for _, value_10 in CollectionService_upv_1:GetTagged("Combatant") do
        consider(value_10)
    end
    for _, value_11 in Players_upv_1:GetPlayers() do
        consider(value_11.Character)
    end
    if u2 then
        return
    end
    u2 = true
    task.spawn(
        function()
            --[[
              line: 236
              upvalues:
                tbl_upv_6 (copy, index: 1)
                tbl_upv_7 (copy, index: 2)
                tbl_upv_1 (copy, index: 3)
                hasBody (copy, index: 4)
                tbl_upv_5 (copy, index: 5)
                u2 (ref,  index: 6)
            ]]
            while #tbl_upv_6 > 0 do
                local v13 = table.remove(tbl_upv_6, 1)
                tbl_upv_7[v13] = nil
                local v14 = tbl_upv_1.FindLive(v13)
                if not (v14) then
                    task.wait()
                    continue
                end
                local v15 = v14:FindFirstChildOfClass("Humanoid")
                local v16 = (v15 ~= nil) and ((v15.Health > 0) and ((v14:FindFirstChild("HumanoidRootPart") ~= nil) and (hasBody(v14))))
                if not (v16) then
                    task.wait()
                    continue
                end
                local v17 = tbl_upv_1.Snapshot(v14)
                if not (v17) then
                    task.wait()
                    continue
                end
                local v18 = tbl_upv_5[v13]
                tbl_upv_5[v13] = v17
                if v18 then
                    v18:Destroy()
                end
                task.wait()
            end
            u2 = false
        end
    )
end
function tbl_upv_1.ClearCache()
    --[[
      name: ClearCache
      line: 298
      upvalues:
        clearCache (copy, index: 1)
        u1 (ref,  index: 2)
    ]]
    clearCache()
    u1 = ""
end
local u4 = nil
local function weaponModel(a1)
    --[[
      name: weaponModel
      line: 306
      upvalues:
        u4 (ref,  index: 1)
        ReplicatedStorage_upv_1 (copy, index: 2)
    ]]
    if not (u4) or not (u4.Parent) then
        local Assets_1 = ReplicatedStorage_upv_1:FindFirstChild("Assets")
        local v19 = Assets_1 and (Assets_1:FindFirstChild("Weapons"))
        u4 = v19
    end
    local v20 = u4 and (u4:FindFirstChild(a1))
    return v20
end
local function makeTool(a1)
    --[[
      name: makeTool
      line: 314
      upvalues:
        Weapons_upv_1 (copy, index: 1)
        u4 (ref,  index: 2)
        ReplicatedStorage_upv_1 (copy, index: 3)
    ]]
    local v21 = Weapons_upv_1.Get(a1)
    if not (u4) or not (u4.Parent) then
        local Assets_2 = ReplicatedStorage_upv_1:FindFirstChild("Assets")
        local v22 = Assets_2 and (Assets_2:FindFirstChild("Weapons"))
        u4 = v22
    end
    local v23 = u4 and (u4:FindFirstChild(a1))
    if not v21 or not v23 or v21.hotbar == false then
        return nil
    end
    local v24 = Instance.new("Tool")
    v24.Name = v21.name or a1
    v24.CanBeDropped = false
    v24.ManualActivationOnly = true
    v24.RequiresHandle = true
    v24:SetAttribute("WeaponId", a1)
    v24:SetAttribute("Kind", v21.kind)
    local v25 = v23:Clone()
    for _, value_12 in v25:GetChildren() do
        value_12.Parent = v24
    end
    v25:Destroy()
    local Handle_1 = v24:FindFirstChild("Handle")
    if Handle_1 and Handle_1:IsA("BasePart") then
        local RightGripAttachment_1 = Handle_1:FindFirstChild("RightGripAttachment")
        if RightGripAttachment_1 and RightGripAttachment_1:IsA("Attachment") then
            v24.Grip = RightGripAttachment_1.CFrame
        end
        for _, value_13 in v24:GetDescendants() do
            if value_13:IsA("BasePart") then
                value_13.Anchored = false
                value_13.CanCollide = false
                value_13.CanQuery = false
                value_13.CanTouch = false
                value_13.Massless = true
                continue
            end
            if value_13:IsA("LuaSourceContainer") then
                value_13:Destroy()
            end
        end
        return v24
    end
    v24:Destroy()
    return nil
end
local function attach(a1, a2)
    --[[
      name: attach
      line: 355
    ]]
    local rightHand_1 = a1.rightHand
    local Handle_2 = a2:FindFirstChild("Handle")
    if not rightHand_1 or not Handle_2 then
        return
    end
    if not (Handle_2:FindFirstChild("ReplayGrip")) then
        local v26 = Instance.new("Weld")
        v26.Name = "ReplayGrip"
        v26.Part0 = rightHand_1
        v26.Part1 = Handle_2
        local RightGripAttachment_2 = rightHand_1:FindFirstChild("RightGripAttachment")
        local v27
        if (RightGripAttachment_2) and (RightGripAttachment_2:IsA("Attachment")) then
            v27 = RightGripAttachment_2.CFrame
        else
            v27 = CFrame.new(0, -rightHand_1.Size.Y / 2, 0) * CFrame.Angles(-1.5707963267948966, 0, 0)
        end
        v26.C0 = v27
        v26.C1 = a2.Grip
        v26.Parent = Handle_2
    end
    a2.Parent = a1.model
end
function tbl_upv_1.SetItem(a1, a2)
    --[[
      name: SetItem
      line: 376
      upvalues:
        makeTool (copy, index: 1)
        attach (copy, index: 2)
    ]]
    if a1.itemId == a2 then
        return false
    end
    local v28 = a1.itemId and (a1.tools[a1.itemId])
    if v28 then
        v28.Parent = nil
    end
    a1.itemId = a2
    if a2 then
        local v29 = a1.tools[a2]
        if v29 ~= nil then
            v28 = v29
        else
            v28 = makeTool(a2) or false
            a1.tools[a2] = v28
        end
        if v28 then
            attach(a1, v28)
        end
    end
    return true
end
local function findPart(a1, a2)
    --[[
      name: findPart
      line: 400
    ]]
    local v30 = a1:FindFirstChild(a2)
    if v30 and v30:IsA("BasePart") then
        return v30
    end
    local v31 = a1:FindFirstChild(a2, true)
    if v31 and v31:IsA("BasePart") then
        return v31
    end
    return nil
end
local function greyCopy(a1, a2)
    --[[
      name: greyCopy
      line: 412
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    if a1 then
        local v32 = nil
        if a1.Parent then
            if a2 then
                local success_2, v33 = pcall(
                    function()
                        --[[
                          line: 420
                          upvalues:
                            a1 (copy, index: 1)
                        ]]
                        local Archivable_2 = a1.Archivable
                        a1.Archivable = true
                        local v34 = a1:Clone()
                        a1.Archivable = Archivable_2
                        return v34
                    end
                )
                if success_2 then
                    v32 = v33
                else
                    v32 = nil
                end
                if v32 and a2 then
                    for _, value_14 in v32:GetDescendants() do
                        if value_14:IsA("Tool") or value_14:IsA("Highlight") then
                            value_14:Destroy()
                        end
                    end
                end
            else
                v32 = tbl_upv_1.Snapshot(a1)
            end
        else
            local success_2, v33 = pcall(
                function()
                    --[[
                      line: 420
                      upvalues:
                        a1 (copy, index: 1)
                    ]]
                    local Archivable_2 = a1.Archivable
                    a1.Archivable = true
                    local v34 = a1:Clone()
                    a1.Archivable = Archivable_2
                    return v34
                end
            )
            if success_2 then
                v32 = v33
            else
                v32 = nil
            end
            if v32 and a2 then
                for _, value_14 in v32:GetDescendants() do
                    if value_14:IsA("Tool") or value_14:IsA("Highlight") then
                        value_14:Destroy()
                    end
                end
            end
        end
        if v32 then
            for _, value_15 in v32:GetDescendants() do
                if value_15:IsA("Accessory") or value_15:IsA("Clothing") or value_15:IsA("ShirtGraphic") or not (not (value_15:IsA("Decal"))) and value_15.Name ~= "face" then
                    value_15:Destroy()
                elseif value_15:IsA("BodyColors") then
                    local v35 = Color3.fromRGB(150, 150, 156)
                    value_15.HeadColor3 = v35
                    value_15.TorsoColor3 = v35
                    value_15.LeftArmColor3 = v35
                    value_15.RightArmColor3 = v35
                    value_15.LeftLegColor3 = v35
                    value_15.RightLegColor3 = v35
                end
            end
            return v32
        end
    end
    return nil
end
local function assemble(a1, a2, a3, a4, a5, a6)
    --[[
      name: assemble
      line: 464
    ]]
    local HumanoidRootPart_1 = a1:FindFirstChild("HumanoidRootPart")
    local u5 = a1:FindFirstChildOfClass("Humanoid")
    if HumanoidRootPart_1 and HumanoidRootPart_1:IsA("BasePart") and u5 then
        pcall(
            function()
                --[[
                  line: 472
                  upvalues:
                    u5 (copy, index: 1)
                ]]
                u5.EvaluateStateMachine = false
            end
        )
        u5.BreakJointsOnDeath = false
        u5.RequiresNeck = false
        if u5.MaxHealth <= 0 then
            u5.MaxHealth = 100
        end
        u5.Health = u5.MaxHealth
        u5.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
        u5.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
        HumanoidRootPart_1.Anchored = true
        HumanoidRootPart_1.Transparency = 1
        local v36 = u5:FindFirstChildOfClass("Animator")
        if not (v36) then
            local v37 = Instance.new("Animator")
            v37.Parent = u5
            v36 = v37
        end
        a1.Name = ("ReplayPuppet_%*"):format(a2)
        a1:SetAttribute("ReplayPuppet", a3)
        a1:SetAttribute("DisplayName", a4)
        local tbl_8 = {}
        for _, value_16 in a1:GetChildren() do
            if value_16:IsA("BasePart") then
                tbl_8[value_16.Name] = value_16
            end
        end
        local v38 = tbl_8.RightHand or (tbl_8["Right Arm"])
        local tbl_9 = {visible = false, src = "", blocking = false, standIn = false, alive = true, liveParts = -1}
        tbl_9.index = a2
        tbl_9.id = a3
        tbl_9.name = a4
        tbl_9.team = a5
        tbl_9.model = a1
        tbl_9.root = HumanoidRootPart_1
        tbl_9.hum = u5
        tbl_9.animator = v36
        tbl_9.rightHand = v38
        tbl_9.parts = tbl_8
        tbl_9.tools = {}
        tbl_9.folder = a6
        return tbl_9, nil
    else
        a1:Destroy()
        local v39 = nil
        if u5 then
            return v39, "noroot"
        end
        return v39, "nohum"
    end
end
local function isBody(a1, a2)
    --[[
      name: isBody
      line: 527
    ]]
    if a1:IsA("BasePart") and a1.Name ~= "HumanoidRootPart" and a1.Name ~= "TribesHull" then
        local v40 = a1:FindFirstAncestorOfClass("Tool")
        local v41 = true
        if v40 ~= nil then
            v41 = not v40:IsDescendantOf(a2)
        end
        return v41
    end
    return false
end
local u6 = RunService_1:IsStudio()
local tbl_upv_10 = {"live", "cache", "standin", "donor"}
local tbl_upv_11 = {"cache", "live", "standin", "donor"}
local function bodyCount(a1)
    --[[
      name: bodyCount
      line: 535
    ]]
    local v42 = 0
    local v43 = nil
    for _, value_17 in a1:GetDescendants() do
        if value_17:IsA("BasePart") and value_17.Name ~= "HumanoidRootPart" and value_17.Name ~= "TribesHull" then
            local v44 = value_17:FindFirstAncestorOfClass("Tool")
            v43 = true
            if v44 ~= nil then
                v43 = not v44:IsDescendantOf(a1)
            end
        else
            v43 = false
        end
        if v43 then
            v42 = v42 + 1
        end
    end
    return v42
end
local function standIn()
    --[[
      name: standIn
      line: 451
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        greyCopy (copy, index: 2)
        tbl_upv_5 (copy, index: 3)
    ]]
    local Character_1 = LocalPlayer_upv_1.Character
    local v45 = not (Character_1) or not (Character_1.Parent) or greyCopy(Character_1, false)
    if v45 then
        return v45
    end
    for _, value_18 in tbl_upv_5 do
        return (greyCopy(value_18, true))
    end
    return nil
end
local function debugBreak(a1, a2)
    --[[
      name: debugBreak
      line: 549
      upvalues:
        u6 (copy, index: 1)
    ]]
    if not u6 or string.sub(a2, 1, 1) ~= "p" then
        return nil
    end
    local v46 = workspace:GetAttribute("ReplayDiagBreak")
    if type(v46) == "string" and v46 ~= "" then
        local v47 = nil
        if v46 == "noroot" then
            v47 = a1:FindFirstChild("HumanoidRootPart")
            if v47 then
                v47:Destroy()
            end
        elseif v46 == "tr" or v46 == "ltm" then
            local v48 = nil
            for _, value_19 in a1:GetDescendants() do
                if value_19:IsA("BasePart") and value_19.Name ~= "HumanoidRootPart" and value_19.Name ~= "TribesHull" then
                    local v49 = value_19:FindFirstAncestorOfClass("Tool")
                    v48 = true
                    if v49 ~= nil then
                        v48 = not v49:IsDescendantOf(a1)
                    end
                else
                    v48 = false
                end
                if not (v48) then
                    continue
                end
                if v46 ~= "tr" then
                    value_19.LocalTransparencyModifier = 1
                else
                    value_19.Transparency = 1
                end
            end
        elseif v46 == "loose" or v46 == "far" then
            for _, value_20 in a1:GetDescendants() do
                if value_20:IsA("JointInstance") and value_20.Name == "Root" or value_20:IsA("Attachment") and value_20.Name == "RootRigAttachment" then
                    value_20:Destroy()
                end
            end
            if v46 == "far" then
                local v48 = nil
                for _, value_21 in a1:GetDescendants() do
                    if value_21:IsA("BasePart") and value_21.Name ~= "HumanoidRootPart" and value_21.Name ~= "TribesHull" then
                        local v50 = value_21:FindFirstAncestorOfClass("Tool")
                        v48 = true
                        if v50 ~= nil then
                            v48 = not v50:IsDescendantOf(a1)
                        end
                    else
                        v48 = false
                    end
                    if v48 then
                        value_21.Anchored = true
                        value_21.CFrame = value_21.CFrame + Vector3.new(0, 60, 0)
                    end
                end
            end
        end
        return v46
    end
    return nil
end
function tbl_upv_1.Build(a1, a2, a3, a4, a5, a6, a7)
    --[[
      name: Build
      line: 600
      upvalues:
        tbl_upv_1 (copy, index: 1)
        bodyCount (copy, index: 2)
        tbl_upv_5 (copy, index: 3)
        hasBody (copy, index: 4)
        tbl_upv_11 (copy, index: 5)
        tbl_upv_10 (copy, index: 6)
        standIn (copy, index: 7)
        greyCopy (copy, index: 8)
        debugBreak (copy, index: 9)
        assemble (copy, index: 10)
    ]]
    local v51 = tbl_upv_1.FindLive(a2)
    local v52 = ((not v51) and -1) or (bodyCount(v51))
    local v53
    if v51 then
        local v54 = nil
        if tbl_upv_5[a2] then
            local v55 = v51:FindFirstChildOfClass("Humanoid")
            v54 = (v55 ~= nil) and ((v55.Health > 0) and ((v51:FindFirstChild("HumanoidRootPart") ~= nil) and (hasBody(v51))))
            if v54 then
                v53 = tbl_upv_10
            else
                v53 = tbl_upv_11
            end
        else
            v53 = tbl_upv_10
        end
    else
        v53 = tbl_upv_10
    end
    local v56 = 1
    if a6 then
        for key_1, value_22 in v53 do
            if value_22 == a6 then
                v56 = key_1 + 1
            end
        end
    end
    local v57 = nil
    local v58, v59, v60, v61, v55, v62 = nil, nil, nil, nil, nil, nil
    v55 = v57
    for n_1 = v56, #v53 do
        v58 = v53[n_1]
        v59 = nil
        v62 = nil
        if v58 ~= "live" then
            if v58 == "cache" then
                local v63 = tbl_upv_5[a2]
                if v63 then
                    v59 = v63:Clone()
                else
                    v59 = nil
                end
            elseif v58 ~= "standin" then
                v59 = (not a7) or (greyCopy(a7, true))
            else
                v59 = standIn()
            end
        elseif v51 then
            local v64, v65 = tbl_upv_1.Snapshot(v51)
            v59, v62 = v64, v65
        end
        local v66 = nil
        if v59 then
            if v58 ~= "live" then
                local v64 = v66
            else
                local v64 = debugBreak(v59, a2)
            end
        else
            local v64 = v66
        end
        v60 = nil
        if v59 then
            local _, v67 = assemble(v59, a1, a2, a3, a4, a5)
            v61 = v67
        else
            v61 = v62
        end
        if v61 then
            v55 = v55 or (v61 .. ":" .. v58)
        end
        if not (v60) then
            continue
        end
        v60.skipped = v55
        v60.src = v58
        local v68 = true
        if v58 ~= "standin" then
            v68 = v58 == "donor"
        end
        v60.standIn = v68
        v60.liveParts = v52
        local v64 = nil
        if v64 == "unparent" then
            v60.debugUnparent = true
        end
        return v60, v55, v52
    end
    return nil, v55, v52
end
function tbl_upv_1.Inspect(a1, a2)
    --[[
      name: Inspect
      line: 656
    ]]
    local model_1 = a1.model
    local Position_1 = a1.root.Position
    local v69 = model_1:IsDescendantOf(workspace)
    local tbl_12 = {tr = 0, loose = 0, far = 0, vis = 0, wrap = 0, ltm = 0, parts = 0}
    tbl_12.parented = v69
    local v70, v70, _ = nil, nil, nil
    for v72, value_23 in model_1:GetDescendants() do
        if value_23:IsA("WrapLayer") then
            tbl_12.wrap = tbl_12.wrap + 1
            continue
        end
        if value_23:IsA("BasePart") and value_23.Name ~= "HumanoidRootPart" and value_23.Name ~= "TribesHull" then
            local v71 = value_23:FindFirstAncestorOfClass("Tool")
            v70 = true
            if v71 ~= nil then
                v70 = not v71:IsDescendantOf(model_1)
            end
        else
            v70 = false
        end
        if not (v70) then
            continue
        end
        tbl_12.parts = tbl_12.parts + 1
        v70 = false
        if value_23.Transparency >= 0.95 then
            tbl_12.tr = tbl_12.tr + 1
            v70 = true
        end
        if value_23.LocalTransparencyModifier >= 0.95 then
            tbl_12.ltm = tbl_12.ltm + 1
            v70 = true
        end
        if not (v70) then
            tbl_12.vis = tbl_12.vis + 1
        end
        if a2 < (value_23.Position - Position_1).Magnitude then
            tbl_12.far = tbl_12.far + 1
        end
        if not (v69) then
            continue
        end
        if not (value_23:IsGrounded()) then
            tbl_12.loose = tbl_12.loose + 1
        end
    end
    return tbl_12
end
function tbl_upv_1.SetVisible(a1, a2)
    --[[
      name: SetVisible
      line: 690
    ]]
    if a1.visible == a2 then
        return
    end
    a1.visible = a2
    local model_2 = a1.model
    local v72
    if a2 then
        v72 = a1.folder
    else
        v72 = nil
    end
    model_2.Parent = v72
end
function tbl_upv_1.Part(a1, a2)
    --[[
      name: Part
      line: 699
    ]]
    if a2 == "Handle" then
        return a1.parts.Head or (a1.root)
    end
    local v73 = a1.parts[a2]
    local v74, v75 = nil, nil
    if not (v73) then
        local model_3 = a1.model
        v74 = model_3:FindFirstChild(a2)
        if (v74) and (v74:IsA("BasePart")) then
            v73 = v74
        else
            v75 = model_3:FindFirstChild(a2, true)
            v73 = not (v75) or not (v75:IsA("BasePart")) or v75
        end
        if not (v73) then
            v73 = a1.parts.UpperTorso or (a1.root)
        end
    end
    return v73
end
function tbl_upv_1.Destroy(a1)
    --[[
      name: Destroy
      line: 706
    ]]
    for _, value_24 in a1.tools do
        if value_24 then
            value_24:Destroy()
        end
    end
    a1.model:Destroy()
end
return tbl_upv_1