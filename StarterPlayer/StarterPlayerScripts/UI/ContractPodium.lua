local CollectionService_upv_1 = game:GetService("CollectionService")
local ReplicatedStorage_upv_1 = game:GetService("ReplicatedStorage")
local RunService_upv_1 = game:GetService("RunService")
local Workspace_upv_1 = game:GetService("Workspace")
local tbl_1 = {}
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 42
      upvalues:
        Workspace_upv_1 (copy, index: 1)
        ReplicatedStorage_upv_1 (copy, index: 2)
        CollectionService_upv_1 (copy, index: 3)
        RunService_upv_1 (copy, index: 4)
    ]]
    local UI_upv_1 = a1.UI
    local Theme_upv_1 = a1.Theme
    local State_upv_1 = a1.State
    local WeaponInfo_upv_1 = a1.WeaponInfo
    local Economy_upv_1 = a1.Economy
    local Colors_upv_1 = Theme_upv_1.Colors
    local Fonts_upv_1 = Theme_upv_1.Fonts
    local u1 = Instance.new("Folder")
    u1.Name = "TR_ContractDisplay"
    u1.Parent = Workspace_upv_1
    local function cloneVisual(a2)
        --[[
          name: cloneVisual
          line: 65
        ]]
        local v1 = a2:GetAttribute("Armor") == true
        local u2 = Instance.new("Model")
        u2.Name = "ContractItem"
        local u3 = false
        local function copy_1(a3)
            --[[
              name: copy
              line: 70
              upvalues:
                u2 (copy, index: 1)
                u3 (ref,  index: 2)
            ]]
            local success_1, v2 = pcall(
                function()
                    --[[
                      line: 71
                      upvalues:
                        a3 (copy, index: 1)
                    ]]
                    return a3:Clone()
                end
            )
            if not success_1 or not v2 then
                return
            end
            for _, value_1 in v2:GetDescendants() do
                if value_1:IsA("DataModelMesh") or value_1:IsA("Decal") or value_1:IsA("Texture") then
                    continue
                end
                if not (value_1:IsA("SurfaceAppearance")) then
                    value_1:Destroy()
                end
            end
            v2.Anchored = true
            v2.CanCollide = false
            v2.CanQuery = false
            v2.CanTouch = false
            v2.CastShadow = false
            v2.Massless = true
            if v2.Material == Enum.Material.Neon then
                v2.Material = Enum.Material.SmoothPlastic
            end
            v2.Parent = u2
            u3 = true
        end
        if a2:IsA("BasePart") then
            copy_1(a2)
        end
        for _, value_2 in a2:GetDescendants() do
            if not (value_2:IsA("BasePart")) or not (value_2.Transparency < 1) then
                continue
            end
            if not (v1) then
                copy_1(value_2)
                continue
            end
            local v3 = string.find(string.lower(value_2.Name), "boots", 1, true)
            if not (v3) then
                copy_1(value_2)
            end
        end
        if u3 then
            if v1 then
                for _, value_3 in u2:GetChildren() do
                    if not (value_3:IsA("BasePart")) then
                        continue
                    end
                    if string.find(string.lower(value_3.Name), "shoulder", 1, true) then
                        value_3.CFrame = value_3.CFrame + Vector3.new(((value_3.Position.X > 0) and -0.5) or 0.5, -0.12, 0)
                    end
                end
            end
            return u2, v1
        end
        u2:Destroy()
        return nil, v1
    end
    local function modelSource(a4)
        --[[
          name: modelSource
          line: 52
          upvalues:
            ReplicatedStorage_upv_1 (copy, index: 1)
        ]]
        local Assets_1 = ReplicatedStorage_upv_1:FindFirstChild("Assets")
        local v4 = Assets_1 and (Assets_1:FindFirstChild("Weapons"))
        local v5 = v4 and (v4:FindFirstChild(a4))
        if not (v5) then
            local v6 = Assets_1 and Assets_1:FindFirstChild("Armor")
            v5 = v6 and v6:FindFirstChild(a4)
        end
        return v5
    end
    local tbl_upv_2 = {}
    local u4 = {}
    local u5 = 1
    local function rebuildCycle()
        --[[
          name: rebuildCycle
          line: 183
          upvalues:
            u4 (ref,  index: 1)
            u5 (ref,  index: 2)
            Economy_upv_1 (copy, index: 3)
        ]]
        local v8 = u4[u5]
        local v9 = {}
        for _, value_4 in Economy_upv_1.Unlocks.AllIds() do
            if Economy_upv_1.IsLocked(value_4) then
                table.insert(v9, value_4)
            end
        end
        if #v9 == 0 then
            v9 = table.clone(Economy_upv_1.Unlocks.AllIds())
        end
        u4 = v9
        u5 = 1
        for key_1, value_5 in v9 do
            if value_5 ~= v8 then
                continue
            end
            u5 = key_1
            return
        end
    end
    local function newPart(a5, a6, a7)
        --[[
          name: newPart
          line: 205
        ]]
        local v10 = Instance.new("Part")
        v10.Name = a5
        v10.Size = a6
        v10.Anchored = true
        v10.CanCollide = false
        v10.CanQuery = false
        v10.CanTouch = false
        v10.CastShadow = false
        v10.Transparency = 1
        v10.Parent = a7
        return v10
    end
    local function findAnchor(a8)
        --[[
          name: findAnchor
          line: 373
        ]]
        local v11 = a8:FindFirstChild("ItemAnchor", true)
        if v11 and v11:IsA("Attachment") then
            return v11
        end
        return nil
    end
    local function relabel(a9)
        --[[
          name: relabel
          line: 379
        ]]
        if not a9:IsA("ProximityPrompt") or a9.Name ~= "ContractPrompt" then
            return
        end
        a9.ActionText = "Collection"
        a9.ObjectText = ""
    end
    local function buildItem(a10, a11)
        --[[
          name: buildItem
          line: 119
          upvalues:
            modelSource (copy, index: 1)
            cloneVisual (copy, index: 2)
        ]]
        local v12 = modelSource(a10)
        if not v12 then
            return nil, CFrame.identity, 1
        end
        local u6, v13 = cloneVisual(v12)
        if not u6 then
            return nil, CFrame.identity, 1
        end
        local v14, v15 = u6:GetBoundingBox()
        u6.WorldPivot = v14
        local v16 = math.max(v15.X, v15.Y, v15.Z)
        local tbl_3 = {v15.X, v15.Y, v15.Z}
        table.sort(tbl_3)
        local v17 = not v13 and (tbl_3[3] / math.max(tbl_3[2], 0.01) < 1.8)
        local u7 = ((v13 and 2.8) or ((v17 and 2.2) or 3.4)) * a11 / math.max(v16, 0.1)
        pcall(
            function()
                --[[
                  line: 136
                  upvalues:
                    u6 (copy, index: 1)
                    u7 (copy, index: 2)
                ]]
                u6:ScaleTo(u7)
            end
        )
        local v18 = CFrame.identity
        if v13 then
            v18 = CFrame.Angles(0, math.pi, 0)
        else
            if (v15.Y <= v15.X) and (v15.Z <= v15.X) then
                v18 = CFrame.Angles(0, 0, 1.5707963267948966)
            elseif v15.X <= v15.Z and v15.Y <= v15.Z then
                v18 = CFrame.Angles(1.5707963267948966, 0, 0)
            end
            v18 = CFrame.Angles(0, 0, 0.3141592653589793) * v18
        end
        return u6, v18, u7
    end
    local function paint(a12, a13)
        --[[
          name: paint
          line: 387
          upvalues:
            u4 (ref,  index: 1)
            Economy_upv_1 (copy, index: 2)
            rebuildCycle (copy, index: 3)
            u5 (ref,  index: 4)
            Colors_upv_1 (copy, index: 5)
            WeaponInfo_upv_1 (copy, index: 6)
            buildItem (copy, index: 7)
        ]]
        if #u4 == 0 and Economy_upv_1.HasData() then
            rebuildCycle()
        end
        local v19 = Economy_upv_1.HasData() and u4[u5] or false
        local v20 = Colors_upv_1.Accent
        local v21 = nil
        if v19 then
            local v22, v23, v21 = Economy_upv_1.Progress(v19)
            local v24 = Economy_upv_1.Level(v19)
            a12.name.Text = string.upper(WeaponInfo_upv_1.Name(v19))
            if v21 == "unlock" then
                local v25 = math.max(0, v23 - v22)
                local line_1 = a12.line
                line_1.Text = not (v22 > 0) and "LOCKED  \194\183  FIND ITS SHARDS IN DROPS" or string.format("LOCKED  \194\183  FIND %d MORE SHARDS", v25)
            elseif Economy_upv_1.CanUpgrade(v19) then
                a12.line.Text = string.format("UPGRADE READY  \194\183  LV %d \226\134\146 %d", v24, v24 + 1)
                v20 = Colors_upv_1.Success
            else
                local v27 = nil
                if v21 ~= "max" then
                    v27 = Economy_upv_1.Shards.BonusText(v19, v24)
                    local line_2 = a12.line
                    local v28
                    if v27 == "" then
                        v28 = string.format("LV %d", v24)
                    else
                        v28 = string.format("LV %d  \194\183  %s", v24, string.upper(v27))
                    end
                    line_2.Text = v28
                else
                    a12.line.Text = "MAX LEVEL"
                end
            end
            local fill_1 = a12.fill
            local v29 = ((v21 == "max") and 1) or (math.clamp(v22 / math.max(v23, 1), 0, 1))
            fill_1.Size = UDim2.fromScale(v29, 1)
            a12.fill.BackgroundColor3 = v20
            local pts_1 = a12.pts
            pts_1.Text = v21 == "max" and "MAX" or string.format("%d / %d SHARDS", v22, v23)
            a12.barBg.Visible = true
            a12.pts.Visible = true
        else
            local name_1 = a12.name
            name_1.Text = Economy_upv_1.HasData() and "ALL MAXED" or ""
            local line_3 = a12.line
            line_3.Text = Economy_upv_1.HasData() and "EVERY ITEM AT MAX LEVEL" or ""
            a12.barBg.Visible = false
            a12.pts.Visible = false
        end
        a12.haloImg.ImageColor3 = v20
        a12.ringImg.ImageColor3 = v20
        a12.motes.Color = ColorSequence.new(v20:Lerp(Color3.new(1, 1, 1), 0.35))
        if a12.itemId == v19 then
            return
        end
        a12.itemId = v19
        if a12.item then
            a12.item:Destroy()
            a12.item = nil
        end
        if v19 then
            local v33, v34, v35 = buildItem(v19, a12.mul)
            if v33 then
                a12.item = v33
                a12.orient = v34
                a12.scale = v35
                v33.Parent = a12.root.Parent
            end
        end
        if not a13 then
            return
        end
        a12.popAt = os.clock()
    end
    local function build(a14)
        --[[
          name: build
          line: 219
          upvalues:
            u1 (copy, index: 1)
            UI_upv_1 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            Fonts_upv_1 (copy, index: 4)
            Theme_upv_1 (copy, index: 5)
        ]]
        local v36 = Instance.new("Folder")
        v36.Name = a14:GetFullName()
        v36.Parent = u1
        local v37 = Instance.new("Part")
        v37.Name = "Root"
        v37.Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)
        v37.Anchored = true
        v37.CanCollide = false
        v37.CanQuery = false
        v37.CanTouch = false
        v37.CastShadow = false
        v37.Transparency = 1
        v37.Parent = v36
        local v38 = Instance.new("ParticleEmitter")
        v38.Texture = "rbxasset://textures/particles/sparkles_main.dds"
        v38.Rate = 3
        v38.Lifetime = NumberRange.new(2, 3.2)
        v38.Speed = NumberRange.new(0.2, 0.5)
        v38.SpreadAngle = Vector2.new(180, 180)
        v38.Acceleration = Vector3.new(0, 0.3499999940395355, 0)
        v38.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.18), NumberSequenceKeypoint.new(1, 0)})
        v38.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.35), NumberSequenceKeypoint.new(1, 1)})
        v38.LightEmission = 0.3
        v38.LightInfluence = 0
        v38.Shape = Enum.ParticleEmitterShape.Sphere
        v38.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume
        v38.Parent = v37
        v37.Size = Vector3.new(3, 3, 3)
        local v39 = Instance.new("BillboardGui")
        v39.Name = "Halo"
        v39.Size = UDim2.fromScale(5.5, 5.5)
        v39.StudsOffset = Vector3.new(0, 0, -2)
        v39.LightInfluence = 0
        v39.Brightness = 1
        v39.MaxDistance = 140
        v39.ResetOnSpawn = false
        v39.Adornee = v37
        v39.Parent = v36
        local v40 = Instance.new("ImageLabel")
        v40.BackgroundTransparency = 1
        v40.Size = UDim2.fromScale(1, 1)
        v40.Image = UI_upv_1.Assets.Icons.Glow
        v40.ImageTransparency = 0.5
        v40.Parent = v39
        local v41 = Instance.new("Part")
        v41.Name = "Ring"
        v41.Size = Vector3.new(3.4000000953674316, 0.05000000074505806, 3.4000000953674316)
        v41.Anchored = true
        v41.CanCollide = false
        v41.CanQuery = false
        v41.CanTouch = false
        v41.CastShadow = false
        v41.Transparency = 1
        v41.Parent = v36
        local v42 = Instance.new("SurfaceGui")
        v42.Face = Enum.NormalId.Top
        v42.LightInfluence = 0
        v42.Brightness = 1
        v42.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
        v42.PixelsPerStud = 60
        v42.MaxDistance = 140
        v42.Adornee = v41
        v42.Parent = v41
        local v43 = Instance.new("ImageLabel")
        v43.BackgroundTransparency = 1
        v43.Size = UDim2.fromScale(1, 1)
        v43.Image = UI_upv_1.Assets.Fx.Ring
        v43.ImageTransparency = 0.55
        v43.Parent = v42
        local v44 = v42:Clone()
        v44.Face = Enum.NormalId.Bottom
        v44.Parent = v41
        local v45 = Instance.new("BillboardGui")
        v45.Name = "Info"
        v45.Size = UDim2.new(5.2, 0, 1.45, 0)
        v45.StudsOffset = Vector3.new(4.800000190734863, -0.6000000238418579, 0)
        v45.LightInfluence = 0
        v45.MaxDistance = 55
        v45.ResetOnSpawn = false
        v45.Adornee = v37
        v45.Parent = v36
        local tbl_4 = Instance.new("Frame")
        tbl_4.Size = UDim2.fromScale(1, 1)
        tbl_4.BackgroundColor3 = Colors_upv_1.Void
        tbl_4.BackgroundTransparency = 0.35
        tbl_4.BorderSizePixel = 0
        tbl_4.Parent = v45
        UI_upv_1.Corner(UDim.new(0.22, 0)).Parent = tbl_4
        local v46 = UI_upv_1.new("TextLabel", {Name = "ItemName", Text = "", TextScaled = true, Position = UDim2.fromScale(0.05, 0.06), Size = UDim2.fromScale(0.9, 0.36), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Text, Parent = tbl_4})
        UI_upv_1.new("UITextSizeConstraint", {MaxTextSize = 30, Parent = v46})
        local v47 = UI_upv_1.new("TextLabel", {RichText = true, Text = "", Name = "Line", TextScaled = true, Position = UDim2.fromScale(0.05, 0.42), Size = UDim2.fromScale(0.9, 0.2), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextDim, Parent = tbl_4})
        UI_upv_1.new("UITextSizeConstraint", {MaxTextSize = 16, Parent = v47})
        local v48 = Instance.new("Frame")
        v48.Name = "Bar"
        v48.Position = UDim2.fromScale(0.07, 0.7)
        v48.Size = UDim2.fromScale(0.46, 0.13)
        v48.BackgroundColor3 = Colors_upv_1.Inset
        v48.BackgroundTransparency = 0.1
        v48.BorderSizePixel = 0
        v48.ClipsDescendants = true
        v48.Parent = tbl_4
        UI_upv_1.Corner(Theme_upv_1.Radius.Pill).Parent = v48
        local v49 = Instance.new("Frame")
        v49.Size = UDim2.fromScale(0, 1)
        v49.BackgroundColor3 = Colors_upv_1.Accent
        v49.BorderSizePixel = 0
        v49.Parent = v48
        UI_upv_1.Corner(Theme_upv_1.Radius.Pill).Parent = v49
        local v50 = UI_upv_1.new("TextLabel", {Text = "", Name = "Points", TextScaled = true, Position = UDim2.fromScale(0.56, 0.64), Size = UDim2.fromScale(0.39, 0.25), FontFace = Fonts_upv_1.Bold, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Right, Parent = tbl_4})
        UI_upv_1.new("UITextSizeConstraint", {MaxTextSize = 16, Parent = v50})
        tbl_4 = {scale = 1, popAt = -math.huge, mul = 1}
        tbl_4.podium = a14
        tbl_4.root = v37
        tbl_4.halo = v39
        tbl_4.haloImg = v40
        tbl_4.ring = v41
        tbl_4.ringImg = v43
        tbl_4.motes = v38
        tbl_4.info = v45
        tbl_4.name = v46
        tbl_4.line = v47
        tbl_4.fill = v49
        tbl_4.pts = v50
        tbl_4.barBg = v48
        tbl_4.orient = CFrame.identity
        tbl_4.conns = {}
        return tbl_4
    end
    local function applyAnchor(a15)
        --[[
          name: applyAnchor
          line: 445
          upvalues:
            paint (copy, index: 1)
        ]]
        local anchor_1 = a15.anchor
        local v51 = anchor_1 and (anchor_1:GetAttribute("ItemScale"))
        local v52 = math.clamp(tonumber(v51) or 1, 0.5, 4)
        local v53 = anchor_1 and (anchor_1:GetAttribute("CardScale"))
        local v54 = math.clamp(tonumber(v53) or 1, 0.5, 3)
        local v55 = anchor_1 and (anchor_1:GetAttribute("CardOffset"))
        a15.halo.Size = UDim2.fromScale(v52 * 5.5, v52 * 5.5)
        a15.halo.StudsOffset = Vector3.new(0, 0, v52 * -2)
        a15.ring.Size = Vector3.new(v52 * 3.4, 0.05, v52 * 3.4)
        a15.root.Size = Vector3.new(3, 3, 3) * v52
        local info_1 = a15.info
        local v56
        if typeof(v55) ~= "Vector3" then
            v56 = Vector3.new(4.800000190734863, -0.6000000238418579, 0)
        else
            v56 = v55
        end
        info_1.StudsOffset = v56
        a15.info.Size = UDim2.new(v54 * 5.2, 0, v54 * 1.45, 0)
        if v52 == a15.mul then
            return
        end
        a15.mul = v52
        if not a15.item then
            return
        end
        a15.itemId = nil
        paint(a15, false)
    end
    local function detach(a16)
        --[[
          name: detach
          line: 497
          upvalues:
            tbl_upv_2 (copy, index: 1)
        ]]
        local v57 = tbl_upv_2[a16]
        if not v57 then
            return
        end
        for _, value_6 in v57.conns do
            value_6:Disconnect()
        end
        v57.root.Parent:Destroy()
        tbl_upv_2[a16] = nil
    end
    local function attach(a17)
        --[[
          name: attach
          line: 465
          upvalues:
            tbl_upv_2 (copy, index: 1)
            Workspace_upv_1 (copy, index: 2)
            build (copy, index: 3)
            applyAnchor (copy, index: 4)
            paint (copy, index: 5)
        ]]
        if tbl_upv_2[a17] or not a17:IsDescendantOf(Workspace_upv_1) then
            return
        end
        local u8 = build(a17)
        tbl_upv_2[a17] = u8
        local v58 = a17:FindFirstChild("ItemAnchor", true)
        u8.anchor = not (v58) or not (v58:IsA("Attachment")) or v58
        applyAnchor(u8)
        for _, value_7 in a17:GetDescendants() do
            if not (value_7:IsA("ProximityPrompt")) then
                continue
            end
            if value_7.Name == "ContractPrompt" then
                value_7.ActionText = "Collection"
                value_7.ObjectText = ""
            end
        end
        table.insert(
            u8.conns,
            a17.DescendantAdded:Connect(
                function(a18)
                    --[[
                      line: 476
                      upvalues:
                        u8 (copy, index: 1)
                        applyAnchor (copy, index: 2)
                    ]]
                    if a18:IsA("ProximityPrompt") and a18.Name == "ContractPrompt" then
                        a18.ActionText = "Collection"
                        a18.ObjectText = ""
                    end
                    if a18.Name ~= "ItemAnchor" or not a18:IsA("Attachment") then
                        return
                    end
                    u8.anchor = a18
                    applyAnchor(u8)
                end
            )
        )
        table.insert(
            u8.conns,
            a17.AncestryChanged:Connect(
                function()
                    --[[
                      line: 483
                      upvalues:
                        a17 (copy, index: 1)
                        Workspace_upv_1 (copy, index: 2)
                        tbl_upv_2 (copy, index: 3)
                    ]]
                    if not (a17:IsDescendantOf(Workspace_upv_1)) then
                        local v60 = tbl_upv_2[a17]
                        if not v60 then
                            return
                        end
                        for _, value_8 in v60.conns do
                            value_8:Disconnect()
                        end
                        v60.root.Parent:Destroy()
                        tbl_upv_2[a17] = nil
                    end
                end
            )
        )
        paint(u8, false)
    end
    for _, value_9 in CollectionService_upv_1:GetTagged("ContractPodium") do
        task.spawn(attach, value_9)
    end
    CollectionService_upv_1:GetInstanceAddedSignal("ContractPodium"):Connect(attach)
    CollectionService_upv_1:GetInstanceRemovedSignal("ContractPodium"):Connect(detach)
    Economy_upv_1.Changed:Connect(
        function()
            --[[
              line: 513
              upvalues:
                rebuildCycle (copy, index: 1)
                tbl_upv_2 (copy, index: 2)
                paint (copy, index: 3)
            ]]
            rebuildCycle()
            for _, value_10 in tbl_upv_2 do
                paint(value_10, true)
            end
        end
    )
    task.spawn(
        function()
            --[[
              line: 520
              upvalues:
                tbl_upv_2 (copy, index: 1)
                u4 (ref,  index: 2)
                State_upv_1 (copy, index: 3)
                u5 (ref,  index: 4)
                paint (copy, index: 5)
            ]]
            while true do
                repeat
                    task.wait(7)
                until next(tbl_upv_2) ~= nil
                if #u4 > 1 then
                    if not (State_upv_1.InMatch()) then
                        break
                    end
                end
            end
            u5 = (u5 % #u4) + 1
            for _, value_11 in tbl_upv_2 do
                paint(value_11, true)
            end
        end
    )
    local u9 = CFrame.new(0, -5000, 0)
    RunService_upv_1.RenderStepped:Connect(
        function()
            --[[
              line: 534
              upvalues:
                tbl_upv_2 (copy, index: 1)
                State_upv_1 (copy, index: 2)
                Economy_upv_1 (copy, index: 3)
                Workspace_upv_1 (copy, index: 4)
                u9 (copy, index: 5)
            ]]
            if next(tbl_upv_2) == nil then
                return
            end
            local v61 = not State_upv_1.InMatch()
            local v62 = v61 and (Economy_upv_1.HasData())
            local CurrentCamera_1 = Workspace_upv_1.CurrentCamera
            local v63 = (CurrentCamera_1 and (CurrentCamera_1.CFrame.Position)) or Vector3.new(0, 0, 0)
            local v64 = os.clock()
            local v65, _ = nil, nil
            local v66 = nil
            for v69, value_upv_12 in tbl_upv_2 do
                local anchor_2 = value_upv_12.anchor
                v65 = v62 and ((anchor_2 ~= nil) and (anchor_2.Parent ~= nil))
                if v65 then
                    v66 = anchor_2.WorldCFrame
                else
                    v66 = u9
                end
                if v65 and (v66.Position - v63).Magnitude > 160 then
                    v65 = false
                end
                value_upv_12.halo.Enabled = v65
                value_upv_12.info.Enabled = v65
                value_upv_12.motes.Enabled = v65
                if v65 then
                    local v67 = CFrame.new(v66.Position) * CFrame.Angles(0, select(2, v66:ToEulerAnglesYXZ()), 0) * CFrame.new(0, math.sin(v64 * 1.6) * 0.18 * value_upv_12.mul, 0)
                    value_upv_12.root.CFrame = v67
                    value_upv_12.ring.CFrame = v67 * CFrame.Angles(0.20943951023931956, v64 * 0.6, 0) * CFrame.new(0, value_upv_12.mul * -0.35, 0)
                    v66 = v64 - value_upv_12.popAt
                    local u10 = 1
                    if v66 < 0.5 then
                        v65 = v66 / 0.5
                        local v68 = math.max(0.05, 1 + 2.70158 * (v66 / 0.5 - 1) ^ 3 + 1.70158 * (v66 / 0.5 - 1) ^ 2)
                        value_upv_12.haloImg.ImageTransparency = 0.5 - (0.3 * (1 - v65))
                        u10 = v68
                    elseif v66 < 0.6 then
                        value_upv_12.haloImg.ImageTransparency = 0.5
                    end
                    local item_upv_1 = value_upv_12.item
                    if not (item_upv_1) then
                        continue
                    end
                    if v66 < 0.6 then
                        pcall(
                            function()
                                --[[
                                  line: 582
                                  upvalues:
                                    item_upv_1 (copy, index: 1)
                                    value_upv_12 (copy, index: 2)
                                    u10 (ref,  index: 3)
                                ]]
                                item_upv_1:ScaleTo(value_upv_12.scale * u10)
                            end
                        )
                    end
                    item_upv_1:PivotTo(v67 * CFrame.Angles(0, v64 * 0.4886921905584123, 0) * value_upv_12.orient)
                else
                    if value_upv_12.root.CFrame == u9 then
                        continue
                    end
                    value_upv_12.root.CFrame = u9
                    value_upv_12.ring.CFrame = u9
                    if value_upv_12.item then
                        value_upv_12.item:PivotTo(u9)
                    end
                end
            end
        end
    )
    a1.Debug.podium = function()
        --[[
          line: 591
          upvalues:
            tbl_upv_2 (copy, index: 1)
        ]]
        local tbl_5 = {}
        for key_2, value_13 in tbl_upv_2 do
            local tbl_6 = {anchor = 0, hasModel = 0, item = 0}
            tbl_6.podium = key_2:GetFullName()
            tbl_6.anchor = value_13.anchor and value_13.anchor:GetFullName() or false
            tbl_6.item = value_13.itemId or false
            tbl_6.hasModel = value_13.item ~= nil
            table.insert(tbl_5, tbl_6)
        end
        return tbl_5
    end
end
return tbl_1