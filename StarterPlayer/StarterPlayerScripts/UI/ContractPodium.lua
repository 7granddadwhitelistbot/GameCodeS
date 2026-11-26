local collectionService = game:GetService("CollectionService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local workspace = game:GetService("Workspace")

return {
    Init = (function(a5)
        --[[
          name: Init
          line: 42
          upvalues:
            workspace (copy, index: 1)
            replicatedStorage (copy, index: 2)
            collectionService (copy, index: 3)
            runService (copy, index: 4)
        ]]
        local ui = a5.UI
        local theme = a5.Theme
        local state = a5.State
        local weaponInfo = a5.WeaponInfo
        local economy = a5.Economy
        local colors = theme.Colors
        local fonts = theme.Fonts
        local trContractDisplay = Instance.new("Folder")
        trContractDisplay.Name = "TR_ContractDisplay"
        trContractDisplay.Parent = workspace

        local function modelSource(childName)
            --[[
              name: modelSource
              line: 52
              upvalues:
                replicatedStorage (copy, index: 1)
            ]]
            local assets = replicatedStorage:FindFirstChild("Assets")
            local weapons = assets and assets:FindFirstChild("Weapons")
            local child = weapons and weapons:FindFirstChild(childName)
            if not child then
                local armor = assets and assets:FindFirstChild("Armor")
                child = armor and armor:FindFirstChild(childName)
            end

            return child
        end

        local function cloneVisual(instance: Instance?)
            --[[
              name: cloneVisual
              line: 65
            ]]
            local armor = instance:GetAttribute("Armor") == true
            local contractItem = Instance.new("Model")
            contractItem.Name = "ContractItem"
            local v24 = false

            local function copy(instance: Instance?)
                --[[
                  name: copy
                  line: 70
                  upvalues:
                    contractItem (copy, index: 1)
                    v24 (ref,  index: 2)
                ]]
                local success, result = pcall(
                    function()
                        --[[
                          line: 71
                          upvalues:
                            instance (copy, index: 1)
                        ]]
                        return instance:Clone()
                    end
                )

                if not success or not result then
                    return
                end

                for _, descendant in result:GetDescendants() do
                    if not descendant:IsA("DataModelMesh") then
                        if descendant:IsA("Decal") then
                            continue
                        end

                        if not descendant:IsA("Texture") and not descendant:IsA("SurfaceAppearance") then
                            descendant:Destroy()
                        end
                    end
                end

                result.Anchored = true
                result.CanCollide = false
                result.CanQuery = false
                result.CanTouch = false
                result.CastShadow = false
                result.Massless = true

                if result.Material == Enum.Material.Neon then
                    result.Material = Enum.Material.SmoothPlastic
                end

                result.Parent = contractItem
                v24 = true
            end

            if instance:IsA("BasePart") then
                copy(instance)
            end

            for _, descendant in instance:GetDescendants() do
                if descendant:IsA("BasePart") then
                    if not (descendant.Transparency < 1) then
                        continue
                    end

                    if not armor or not string.find(string.lower(descendant.Name), "boots", 1, true) then
                        copy(descendant)
                    end
                end
            end

            if not v24 then
                contractItem:Destroy()
                return nil, armor
            end

            if armor then
                for _, child in contractItem:GetChildren() do
                    if child:IsA("BasePart") then
                        if not string.find(string.lower(child.Name), "shoulder", 1, true) then
                            continue
                        end

                        local x = not (0 < child.Position.X) and 0.5 or -0.5
                        child.CFrame += Vector3.new(x, -0.12, 0)
                    end
                end
            end

            return contractItem, armor
        end

        local function buildItem(childName, mul)
            --[[
              name: buildItem
              line: 119
              upvalues:
                modelSource (copy, index: 1)
                cloneVisual (copy, index: 2)
            ]]
            local instance = modelSource(childName)
            if not instance then
                return nil, CFrame.identity, 1
            end

            local model, v41 = cloneVisual(instance)
            if not model then
                return nil, CFrame.identity, 1
            end

            local worldPivot, vector3 = model:GetBoundingBox()
            model.WorldPivot = worldPivot
            local v44 = math.max(vector3.X, vector3.Y, vector3.Z)
            local v45 = {vector3.X, vector3.Y, vector3.Z}
            table.sort(v45)
            local v46 = not v41 and v45[3] / math.max(v45[2], 0.01) < 1.8
            local cframe
            local v48, v49 = false, false
            local newScaleFactor = (v41 and 2.8 or v46 and 2.2 or 3.4) * mul / math.max(v44, 0.1)
            pcall(
                function()
                    --[[
                      line: 136
                      upvalues:
                        model (copy, index: 1)
                        newScaleFactor (copy, index: 2)
                    ]]
                    model:ScaleTo(newScaleFactor)
                end
            )
            local cframe2 = CFrame.identity

            if v41 then
                cframe = CFrame.Angles(0, math.pi, 0)
            else
                local x = vector3.X

                if not (vector3.Y <= x) then
                    v48 = true
                else
                    local x2 = vector3.X

                    if not (vector3.Z <= x2) then
                        v48 = true
                    else
                        cframe2 = CFrame.Angles(0, 0, 1.5707963267948966)
                        v49 = true
                    end
                end
            end

            if v48 then
                local z = vector3.Z

                if vector3.X <= z then
                    local z2 = vector3.Z

                    if vector3.Y <= z2 then
                        cframe2 = CFrame.Angles(1.5707963267948966, 0, 0)
                    end
                end

                v49 = true
            end

            if v49 then
                cframe = CFrame.Angles(0, 0, 0.3141592653589793) * cframe2
            end

            return model, cframe, newScaleFactor
        end

        local v56 = {}
        local v57 = {}
        local v58 = 1

        local function rebuildCycle()
            --[[
              name: rebuildCycle
              line: 183
              upvalues:
                v57 (ref,  index: 1)
                v58 (ref,  index: 2)
                economy (copy, index: 3)
            ]]
            local v60 = v57[v58]
            local v61 = {}

            for _, v63 in economy.Unlocks.AllIds() do
                if economy.IsLocked(v63) then
                    table.insert(v61, v63)
                end
            end

            local v64 = if #v61 == 0 then table.clone(economy.Unlocks.AllIds()) else v61
            v57 = v64
            v58 = 1

            for v65, v66 in v64 do
                if v66 == v60 then
                    v58 = v65
                    return
                end
            end
        end

        local function newPart(name: string, size: Vector3, parent: Instance?)
            --[[
              name: newPart
              line: 205
            ]]
            local part = Instance.new("Part")
            part.Name = name
            part.Size = size
            part.Anchored = true
            part.CanCollide = false
            part.CanQuery = false
            part.CanTouch = false
            part.CastShadow = false
            part.Transparency = 1
            part.Parent = parent
            return part
        end

        local function build(podium: Instance)
            --[[
              name: build
              line: 219
              upvalues:
                trContractDisplay (copy, index: 1)
                ui (copy, index: 2)
                colors (copy, index: 3)
                fonts (copy, index: 4)
                theme (copy, index: 5)
            ]]
            local parent = Instance.new("Folder")
            parent.Name = podium:GetFullName()
            parent.Parent = trContractDisplay

            local root = Instance.new("Part")
            root.Name = "Root"
            root.Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)
            root.Anchored = true
            root.CanCollide = false
            root.CanQuery = false
            root.CanTouch = false
            root.CastShadow = false
            root.Transparency = 1
            root.Parent = parent

            local motes = Instance.new("ParticleEmitter")
            motes.Texture = "rbxasset://textures/particles/sparkles_main.dds"
            motes.Rate = 3
            motes.Lifetime = NumberRange.new(2, 3.2)
            motes.Speed = NumberRange.new(0.2, 0.5)
            motes.SpreadAngle = Vector2.new(180, 180)
            motes.Acceleration = Vector3.new(0, 0.3499999940395355, 0)
            motes.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.18), NumberSequenceKeypoint.new(1, 0)})
            motes.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.35), NumberSequenceKeypoint.new(1, 1)})
            motes.LightEmission = 0.3
            motes.LightInfluence = 0
            motes.Shape = Enum.ParticleEmitterShape.Sphere
            motes.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume
            motes.Parent = root
            root.Size = Vector3.new(3, 3, 3)
            local halo = Instance.new("BillboardGui")
            halo.Name = "Halo"
            halo.Size = UDim2.fromScale(5.5, 5.5)
            halo.StudsOffset = Vector3.new(0, 0, -2)
            halo.LightInfluence = 0
            halo.Brightness = 1
            halo.MaxDistance = 140
            halo.ResetOnSpawn = false
            halo.Adornee = root
            halo.Parent = parent

            local haloImg = Instance.new("ImageLabel")
            haloImg.BackgroundTransparency = 1
            haloImg.Size = UDim2.fromScale(1, 1)
            haloImg.Image = ui.Assets.Icons.Glow
            haloImg.ImageTransparency = 0.5
            haloImg.Parent = halo

            local ring = Instance.new("Part")
            ring.Name = "Ring"
            ring.Size = Vector3.new(3.4000000953674316, 0.05000000074505806, 3.4000000953674316)
            ring.Anchored = true
            ring.CanCollide = false
            ring.CanQuery = false
            ring.CanTouch = false
            ring.CastShadow = false
            ring.Transparency = 1
            ring.Parent = parent

            local parent2 = Instance.new("SurfaceGui")
            parent2.Face = Enum.NormalId.Top
            parent2.LightInfluence = 0
            parent2.Brightness = 1
            parent2.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
            parent2.PixelsPerStud = 60
            parent2.MaxDistance = 140
            parent2.Adornee = ring
            parent2.Parent = ring

            local ringImg = Instance.new("ImageLabel")
            ringImg.BackgroundTransparency = 1
            ringImg.Size = UDim2.fromScale(1, 1)
            ringImg.Image = ui.Assets.Fx.Ring
            ringImg.ImageTransparency = 0.55
            ringImg.Parent = parent2

            local surfaceGui = parent2:Clone()
            surfaceGui.Face = Enum.NormalId.Bottom
            surfaceGui.Parent = ring

            local info = Instance.new("BillboardGui")
            info.Name = "Info"
            info.Size = UDim2.new(5.2, 0, 1.45, 0)
            info.StudsOffset = Vector3.new(4.800000190734863, -0.6000000238418579, 0)
            info.LightInfluence = 0
            info.MaxDistance = 55
            info.ResetOnSpawn = false
            info.Adornee = root
            info.Parent = parent

            local parent3 = Instance.new("Frame")
            parent3.Size = UDim2.fromScale(1, 1)
            parent3.BackgroundColor3 = colors.Void
            parent3.BackgroundTransparency = 0.35
            parent3.BorderSizePixel = 0
            parent3.Parent = info
            ui.Corner(UDim.new(0.22, 0)).Parent = parent3
            local ui2 = ui.new("TextLabel", {Name = "ItemName", Text = "", TextScaled = true, Position = UDim2.fromScale(0.05, 0.06), Size = UDim2.fromScale(0.9, 0.36), FontFace = fonts.Heavy, TextColor3 = colors.Text, Parent = parent3})
            ui.new("UITextSizeConstraint", {MaxTextSize = 30, Parent = ui2})
            local ui3 = ui.new("TextLabel", {Name = "Line", Text = "", RichText = true, TextScaled = true, Position = UDim2.fromScale(0.05, 0.42), Size = UDim2.fromScale(0.9, 0.2), FontFace = fonts.Heavy, TextColor3 = colors.TextDim, Parent = parent3})
            ui.new("UITextSizeConstraint", {MaxTextSize = 16, Parent = ui3})
            local bar = Instance.new("Frame")
            bar.Name = "Bar"
            bar.Position = UDim2.fromScale(0.07, 0.7)
            bar.Size = UDim2.fromScale(0.46, 0.13)
            bar.BackgroundColor3 = colors.Inset
            bar.BackgroundTransparency = 0.1
            bar.BorderSizePixel = 0
            bar.ClipsDescendants = true
            bar.Parent = parent3
            ui.Corner(theme.Radius.Pill).Parent = bar
            local frame = Instance.new("Frame")
            frame.Size = UDim2.fromScale(0, 1)
            frame.BackgroundColor3 = colors.Accent
            frame.BorderSizePixel = 0
            frame.Parent = bar
            ui.Corner(theme.Radius.Pill).Parent = frame
            local ui4 = ui.new("TextLabel", {Name = "Points", Text = "", TextScaled = true, Position = UDim2.fromScale(0.56, 0.64), Size = UDim2.fromScale(0.39, 0.25), FontFace = fonts.Bold, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Right, Parent = parent3})
            ui.new("UITextSizeConstraint", {MaxTextSize = 16, Parent = ui4})

            return {anchor = nil, item = nil, itemId = nil, scale = 1, mul = 1, popAt = -math.huge, podium = podium, root = root, halo = halo, haloImg = haloImg, ring = ring, ringImg = ringImg, motes = motes, info = info, name = ui2, line = ui3, fill = frame, pts = ui4, barBg = bar, orient = CFrame.identity, conns = {}}
        end

        local function findAnchor(a91)
            --[[
              name: findAnchor
              line: 373
            ]]
            local itemAnchor = a91:FindFirstChild("ItemAnchor", true)

            if itemAnchor and itemAnchor:IsA("Attachment") then
                return itemAnchor
            end

            return nil
        end

        local function relabel(a94)
            --[[
              name: relabel
              line: 379
            ]]
            if a94:IsA("ProximityPrompt") and a94.Name == "ContractPrompt" then
                a94.ActionText = "Collection"
                a94.ObjectText = ""
            end
        end

        local function paint(a96, a97: boolean)
            --[[
              name: paint
              line: 387
              upvalues:
                v57 (ref,  index: 1)
                economy (copy, index: 2)
                rebuildCycle (copy, index: 3)
                v58 (ref,  index: 4)
                colors (copy, index: 5)
                weaponInfo (copy, index: 6)
                buildItem (copy, index: 7)
            ]]
            if #v57 == 0 and economy.HasData() then
                rebuildCycle()
            end

            local itemId = if economy.HasData() then v57[v58] or false else false
            local v99 = colors.Accent
            local v100

            if itemId then
                local v101, v102, v100 = economy.Progress(itemId)
                local v103 = economy.Level(itemId)
                a96.name.Text = string.upper(weaponInfo.Name(itemId))

                if v100 ~= "unlock" then
                    if economy.CanUpgrade(itemId) then
                        a96.line.Text = string.format("UPGRADE READY  ·  LV %d → %d", v103, v103 + 1)
                        v99 = colors.Success
                    elseif v100 ~= "max" then
                        local text = economy.Shards.BonusText(itemId, v103)
                        a96.line.Text = if text ~= "" then string.format("LV %d  ·  %s", v103, string.upper(text)) else string.format("LV %d", v103)
                    else
                        a96.line.Text = "MAX LEVEL"
                    end
                else
                    local text
                    local v106 = math.max(0, v102 - v101)
                    local line = a96.line

                    if not (0 < v101) then
                        text = "LOCKED  ·  FIND ITS SHARDS IN DROPS"
                    else
                        text = string.format("LOCKED  ·  FIND %d MORE SHARDS", v106)
                    end

                    line.Text = text
                end

                local fill = a96.fill
                local udim2FromScale = UDim2.fromScale
                local v110 = v100 == "max" and 1 or math.clamp(v101 / math.max(v102, 1), 0, 1)
                fill.Size = udim2FromScale(v110, 1)
                a96.fill.BackgroundColor3 = v99
                a96.pts.Text = v100 == "max" and "MAX" or string.format("%d / %d SHARDS", v101, v102)
                a96.barBg.Visible = true
                a96.pts.Visible = true
            else
                a96.name.Text = economy.HasData() and "ALL MAXED" or ""
                a96.line.Text = economy.HasData() and "EVERY ITEM AT MAX LEVEL" or ""
                a96.barBg.Visible = false
                a96.pts.Visible = false
            end

            a96.haloImg.ImageColor3 = v99
            a96.ringImg.ImageColor3 = v99
            a96.motes.Color = ColorSequence.new(v99:Lerp(Color3.new(1, 1, 1), 0.35))

            if a96.itemId ~= itemId then
                a96.itemId = itemId

                if a96.item then
                    a96.item:Destroy()
                    a96.item = nil
                end

                if itemId then
                    local item, orient, scale = buildItem(itemId, a96.mul)
                    if item then
                        a96.item = item
                        a96.orient = orient
                        a96.scale = scale
                        item.Parent = a96.root.Parent
                    end
                end

                if a97 then
                    a96.popAt = os.clock()
                end
            end
        end

        local function applyAnchor(a115)
            --[[
              name: applyAnchor
              line: 445
              upvalues:
                paint (copy, index: 1)
            ]]
            local v116
            local anchor = a115.anchor
            local itemScale = anchor and anchor:GetAttribute("ItemScale")
            local mul = math.clamp((tonumber(itemScale) or 1), 0.5, 4)
            local cardScale = anchor and anchor:GetAttribute("CardScale")
            local clampedValue = math.clamp((tonumber(cardScale) or 1), 0.5, 3)
            local cardOffset = anchor and anchor:GetAttribute("CardOffset")
            a115.halo.Size = UDim2.fromScale(mul * 5.5, mul * 5.5)
            a115.halo.StudsOffset = Vector3.new(0, 0, mul * -2)
            a115.ring.Size = Vector3.new(mul * 3.4, 0.05, mul * 3.4)
            a115.root.Size = Vector3.new(3, 3, 3) * mul
            local info = a115.info

            if typeof(cardOffset) ~= "Vector3" then
                v116 = Vector3.new(4.800000190734863, -0.6000000238418579, 0)
            else
                v116 = cardOffset
            end

            info.StudsOffset = v116
            a115.info.Size = UDim2.new(clampedValue * 5.2, 0, clampedValue * 1.45, 0)

            if mul ~= a115.mul then
                a115.mul = mul

                if a115.item then
                    a115.itemId = nil
                    paint(a115, false)
                end
            end
        end

        local function attach(podium: Instance)
            --[[
              name: attach
              line: 465
              upvalues:
                v56 (copy, index: 1)
                workspace (copy, index: 2)
                build (copy, index: 3)
                applyAnchor (copy, index: 4)
                paint (copy, index: 5)
            ]]
            if v56[podium] or not podium:IsDescendantOf(workspace) then
                return
            end

            local v126 = build(podium)
            v56[podium] = v126
            local itemAnchor = podium:FindFirstChild("ItemAnchor", true)
            v126.anchor = if itemAnchor and itemAnchor:IsA("Attachment") then itemAnchor else nil
            applyAnchor(v126)

            for _, descendant in podium:GetDescendants() do
                if descendant:IsA("ProximityPrompt") and descendant.Name == "ContractPrompt" then
                    descendant.ActionText = "Collection"
                    descendant.ObjectText = ""
                end
            end

            table.insert(
                v126.conns,
                podium.DescendantAdded:Connect(
                    function(descendant: Instance)
                        --[[
                          line: 476
                          upvalues:
                            v126 (copy, index: 1)
                            applyAnchor (copy, index: 2)
                        ]]
                        if descendant:IsA("ProximityPrompt") and descendant.Name == "ContractPrompt" then
                            descendant.ActionText = "Collection"
                            descendant.ObjectText = ""
                        end

                        if descendant.Name == "ItemAnchor" and descendant:IsA("Attachment") then
                            v126.anchor = descendant
                            applyAnchor(v126)
                        end
                    end
                )
            )

            table.insert(
                v126.conns,
                podium.AncestryChanged:Connect(
                    function()
                        --[[
                          line: 483
                          upvalues:
                            podium (copy, index: 1)
                            workspace (copy, index: 2)
                            v56 (copy, index: 3)
                        ]]
                        if not podium:IsDescendantOf(workspace) then
                            if const v131 = v56[podium] then
                                for _, conn in v131.conns do
                                    conn:Disconnect()
                                end

                                v131.root.Parent:Destroy()
                                v56[podium] = nil
                            end
                        end
                    end
                )
            )

            paint(v126, false)
        end

        for _, contractPodium in collectionService:GetTagged("ContractPodium") do
            task.spawn(attach, contractPodium)
        end

        collectionService:GetInstanceAddedSignal("ContractPodium"):Connect(attach)

        collectionService:GetInstanceRemovedSignal("ContractPodium"):Connect(
            function(contractPodium: Instance)
                --[[
                  name: detach
                  line: 497
                  upvalues:
                    v56 (copy, index: 1)
                ]]
                if const v137 = v56[contractPodium] then
                    for _, conn in v137.conns do
                        conn:Disconnect()
                    end

                    v137.root.Parent:Destroy()
                    v56[contractPodium] = nil
                end
            end
        )

        economy.Changed:Connect(
            function()
                --[[
                  line: 513
                  upvalues:
                    rebuildCycle (copy, index: 1)
                    v56 (copy, index: 2)
                    paint (copy, index: 3)
                ]]
                rebuildCycle()

                for _, v141 in v56 do
                    paint(v141, true)
                end
            end
        )

        task.spawn(
            function()
                --[[
                  line: 520
                  upvalues:
                    v56 (copy, index: 1)
                    v57 (ref,  index: 2)
                    state (copy, index: 3)
                    v58 (ref,  index: 4)
                    paint (copy, index: 5)
                ]]
                while true do
                    task.wait(7)

                    if next(v56) ~= nil then
                        if not (1 < #v57) then
                            continue
                        end
                        if state.InMatch() then
                            continue
                        end

                        v58 = (v58 % #v57) + 1

                        for _, v143 in v56 do
                            paint(v143, true)
                        end
                    end
                end
            end
        )

        local cFrame = CFrame.new(0, -5000, 0)

        runService.RenderStepped:Connect(
            function()
                --[[
                  line: 534
                  upvalues:
                    v56 (copy, index: 1)
                    state (copy, index: 2)
                    economy (copy, index: 3)
                    workspace (copy, index: 4)
                    cFrame (copy, index: 5)
                ]]
                if next(v56) == nil then
                    return
                end

                local hasData = not state.InMatch() and economy.HasData()
                local camera = workspace.CurrentCamera
                local v147 = camera and camera.CFrame.Position or Vector3.new(0, 0, 0)
                local timestamp = os.clock()

                for _, v150 in v56 do
                    local anchor = v150.anchor
                    local enabled = hasData and anchor ~= nil and anchor.Parent ~= nil
                    local v153 = if enabled then anchor.WorldCFrame else cFrame

                    if enabled and 160 < (v153.Position - v147).Magnitude then
                        enabled = false
                    end

                    v150.halo.Enabled = enabled
                    v150.info.Enabled = enabled
                    v150.motes.Enabled = enabled

                    if enabled then
                        local cframe = CFrame.new(v153.Position) * CFrame.Angles(0, select(2, v153:ToEulerAnglesYXZ()), 0)
                        local y = math.sin(timestamp * 1.6) * 0.18 * v150.mul
                        local cFrame2 = cframe * CFrame.new(0, y, 0)
                        v150.root.CFrame = cFrame2
                        v150.ring.CFrame = cFrame2 * CFrame.Angles(0.20943951023931956, timestamp * 0.6, 0) * CFrame.new(0, v150.mul * -0.35, 0)
                        local v157 = timestamp - v150.popAt
                        local v158 = 1

                        if not (v157 < 0.5) then
                            if v157 < 0.6 then
                                v150.haloImg.ImageTransparency = 0.5
                            end
                        else
                            local v159 = v157 / 0.5
                            v158 = math.max(0.05, (1 + (2.70158 * ((function(...) return (...) ^ 3 end)(((v159 - 1)))))) + (1.70158 * ((function(...) return (...) ^ 2 end)(((v159 - 1))))))
                            v150.haloImg.ImageTransparency = 0.5 - (0.3 * (1 - v159))
                        end

                        if const item = v150.item then
                            if v157 < 0.6 then
                                pcall(
                                    function()
                                        --[[
                                          line: 582
                                          upvalues:
                                            item (copy, index: 1)
                                            v150 (copy, index: 2)
                                            v158 (ref,  index: 3)
                                        ]]
                                        item:ScaleTo(v150.scale * v158)
                                    end
                                )
                            end

                            item:PivotTo(cFrame2 * CFrame.Angles(0, timestamp * 0.4886921905584123, 0) * v150.orient)
                        end
                    elseif v150.root.CFrame ~= cFrame then
                        v150.root.CFrame = cFrame
                        v150.ring.CFrame = cFrame

                        if not v150.item then
                            continue
                        end

                        v150.item:PivotTo(cFrame)
                    end
                end
            end
        )

        a5.Debug.podium = function()
            --[[
              line: 591
              upvalues:
                v56 (copy, index: 1)
            ]]
            local v161 = {}

            for v162, v163 in v56 do
                local anchor
                local v165 = {podium = v162:GetFullName()}

                if v163.anchor then
                    anchor = v163.anchor:GetFullName()

                    if anchor then
                        v165.anchor = anchor
                        v165.item = v163.itemId or false
                        v165.hasModel = v163.item ~= nil
                        table.insert(v161, v165)
                        continue
                    end
                end

                anchor = false
                v165.anchor = anchor
                v165.item = v163.itemId or false
                v165.hasModel = v163.item ~= nil
                table.insert(v161, v165)
            end

            return v161
        end
    end)
}