local _ = game:GetService("Players")
local contentProvider = game:GetService("ContentProvider")
local v3 = {}
local v4 = nil
local v5 = nil
local v6 = {}
local v7 = setmetatable({}, {__mode = "k"})
local texts = setmetatable({}, {__mode = "k"})
local v9 = {Head = true, UpperTorso = true, Torso = true}

local function cloneOf(a11)
    --[[
      name: cloneOf
      line: 36
    ]]
    local success, result = pcall(
        function()
            --[[
              line: 37
              upvalues:
                a11 (copy, index: 1)
            ]]
            local archivable = a11.Archivable
            a11.Archivable = true
            local v15 = a11:Clone()
            a11.Archivable = archivable

            return v15
        end
    )

    if success then
        return result
    end

    return nil
end

local function stripPart(a17)
    --[[
      name: stripPart
      line: 47
    ]]
    a17.LocalTransparencyModifier = 0

    for _, descendant in a17:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.LocalTransparencyModifier = 0
        elseif descendant:IsA("Decal") then
            descendant.LocalTransparencyModifier = 0
        end
    end

    for _, descendant in a17:GetDescendants() do
        if descendant:IsA("JointInstance")
            or descendant:IsA("Constraint")
            or descendant:IsA("LuaSourceContainer")
            or descendant:IsA("Sound")
            or descendant:IsA("ParticleEmitter")
            or descendant:IsA("Light")
            or descendant:IsA("Trail")
            or descendant:IsA("Beam")
            or descendant:IsA("BillboardGui")
            or descendant:IsA("ProximityPrompt")
            or descendant:IsA("Highlight")
        then
            descendant:Destroy()
        end
    end

    a17.Anchored = true
    a17.CanCollide = false
    a17.CanQuery = false
    a17.CanTouch = false
end

local rerender = nil
local prepare = nil
local capture = nil

capture = function(key, rig)
    --[[
      name: capture
      line: 78
      upvalues:
        v9 (copy, index: 1)
        stripPart (copy, index: 2)
        v6 (copy, index: 3)
        prepare (ref,  index: 4)
        rerender (ref,  index: 5)
        v5 (ref,  index: 6)
        capture (ref,  index: 7)
    ]]
    local head = rig:FindFirstChild("Head")
    local v28 = rig:FindFirstChild("UpperTorso") or rig:FindFirstChild("Torso")

    if not head or not head:IsA("BasePart") or not v28 or not v28:IsA("BasePart") then
        return nil
    end
    if 0.9 <= head.Transparency or 0.9 <= v28.Transparency then
        return nil
    end

    local vector3
    local portrait = Instance.new("Model")
    portrait.Name = "Portrait"
    local lookVector = v28.CFrame.LookVector
    local vector32 = Vector3.new(lookVector.X, 0, lookVector.Z)

    if not (0.01 < vector32.Magnitude) then
        vector3 = Vector3.new(0, 0, -1)
    else
        vector3 = vector32.Unit
    end

    local head2 = CFrame.lookAt(head.Position, head.Position + vector3)

    for _, child in rig:GetChildren() do
        if child:IsA("BasePart") and v9[child.Name] then
            local result

            local success, result2 = pcall(
                function()
                    --[[
                      line: 37
                      upvalues:
                        child (copy, index: 1)
                    ]]
                    local archivable = child.Archivable
                    child.Archivable = true
                    local v40 = child:Clone()
                    child.Archivable = archivable

                    return v40
                end
            )

            if success then
                result = result2
            else
                result = nil
            end

            if result then
                stripPart(result)
                result.CFrame = child.CFrame
                result.Parent = portrait
            end
        elseif child:IsA("Accessory") or child:IsA("Accoutrement") then
            if const handle = child:FindFirstChild("Handle") then
                local result

                if not handle:IsA("BasePart") then
                    continue
                end
                if not ((handle.Position - head2.Position).Magnitude < 3.2) then
                    continue
                end

                local success, result3 = pcall(
                    function()
                        --[[
                          line: 37
                          upvalues:
                            child (copy, index: 1)
                        ]]
                        local archivable = child.Archivable
                        child.Archivable = true
                        local v46 = child:Clone()
                        child.Archivable = archivable

                        return v46
                    end
                )

                if success then
                    result = result3
                else
                    result = nil
                end

                if not result then
                    continue
                end

                if const handle2 = result:FindFirstChild("Handle") then
                    stripPart(handle2)
                    handle2.CFrame = handle.CFrame
                end

                result.Parent = portrait
            end
        elseif child:IsA("Shirt")
            or child:IsA("Pants")
            or child:IsA("ShirtGraphic")
            or child:IsA("BodyColors")
            or child:IsA("CharacterMesh")
        then
            local result

            local success, result4 = pcall(
                function()
                    --[[
                      line: 37
                      upvalues:
                        child (copy, index: 1)
                    ]]
                    local archivable = child.Archivable
                    child.Archivable = true
                    local v52 = child:Clone()
                    child.Archivable = archivable

                    return v52
                end
            )

            if success then
                result = result4
            else
                result = nil
            end

            if result then
                result.Parent = portrait
            end
        end
    end

    local humanoid = Instance.new("Humanoid")
    humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
    humanoid.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
    humanoid.Parent = portrait
    local v54 = {ready = false, readyAt = 0, model = portrait, head = head2, at = os.clock(), rig = rig}
    local v55 = v6[key]
    v6[key] = v54

    if v55 then
        v55.model:Destroy()
    end

    prepare(key, v54)

    if v55 then
        rerender(key)
        return v54
    end

    task.delay(
        2.5,
        function()
            --[[
              line: 138
              upvalues:
                v6 (copy, index: 1)
                key (copy, index: 2)
                v54 (copy, index: 3)
                v5 (ref,  index: 4)
                rig (copy, index: 5)
                capture (ref,  index: 6)
            ]]
            if v6[key] ~= v54 then
                return
            end

            local v56 = v5.Find(key) or rig

            if v56 and v56.Parent then
                capture(key, v56)
            end
        end
    )

    return v54
end

local function clearRender(a58)
    --[[
      name: clearRender
      line: 151
    ]]
    for _, v60 in {"RigHead", "RigBack"} do
        if const v61 = a58:FindFirstChild(v60) then
            v61:Destroy()
        end
    end
end

local function silhouette(parent, a64: boolean?)
    --[[
      name: silhouette
      line: 160
      upvalues:
        clearRender (copy, index: 1)
        v4 (ref,  index: 2)
    ]]
    local name

    if not a64 then
        clearRender(parent)
    end

    local new = v4.new
    local v67 = {BackgroundTransparency = 0.2}

    if a64 then
        name = "RigBack"
    else
        name = "RigHead"
    end

    v67.Name = name
    v67.Size = UDim2.fromScale(1, 1)
    v67.BackgroundColor3 = Color3.fromRGB(44, 48, 60)
    v67.ZIndex = parent.ZIndex
    v67.Parent = parent
    local parent2 = new("Frame", v67)

    if const uiCorner = parent:FindFirstChildOfClass("UICorner") then
        uiCorner:Clone().Parent = parent2
    end

    local icon = v4.Icon
    local color3 = Color3.fromRGB(110, 118, 136)
    local v72 = {AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.fromScale(0.5, 1), ZIndex = parent.ZIndex, Parent = parent2}
    icon("person", 0, color3, v72).Size = UDim2.fromScale(0.72, 0.8)
end

local function watchCard(a74, a75, a76, a77)
    --[[
      name: watchCard
      line: 191
    ]]
    local cFrame = a76.CFrame

    task.spawn(
        function()
            --[[
              line: 193
              upvalues:
                a75 (copy, index: 1)
                a74 (copy, index: 2)
                a76 (copy, index: 3)
                cFrame (copy, index: 4)
                a77 (copy, index: 5)
            ]]
            local rigBack
            local timestamp = os.clock()
            local count = 0

            while a75.Parent == a74 and a76.Parent == a75 do
                count += 1
                local newCFrame = CFrame.new
                local z = count % 2 ~= 0 and 4e-04 or 0
                a76.CFrame = cFrame * newCFrame(0, 0, z)

                if a77.ready and 0.5 < os.clock() - a77.readyAt and 0.5 < os.clock() - timestamp then
                    rigBack = a74:FindFirstChild("RigBack")

                    if rigBack then
                        rigBack:Destroy()
                    end

                    for index = 1, 4 do
                        task.wait(0.5)

                        if a75.Parent == a74 then
                            local newCFrame2 = CFrame.new
                            local z2 = index % 2 ~= 0 and 4e-04 or 0
                            a76.CFrame = cFrame * newCFrame2(0, 0, z2)
                        end
                    end

                    return
                end

                if 15 < os.clock() - timestamp then
                    return
                end

                task.wait(0.2)
            end
        end
    )
end

local function renderTemplate(parent, a89)
    --[[
      name: renderTemplate
      line: 221
      upvalues:
        clearRender (copy, index: 1)
        silhouette (copy, index: 2)
        v4 (ref,  index: 3)
    ]]
    clearRender(parent)
    silhouette(parent, true)
    local new = v4.new
    local v91 = {Name = "RigHead", Size = UDim2.fromScale(1, 1), Ambient = Color3.fromRGB(150, 150, 150), LightColor = Color3.fromRGB(235, 232, 226), ZIndex = parent.ZIndex}
    local v92 = parent:GetAttribute("PortraitTint") or Color3.new(1, 1, 1)
    v91.ImageColor3 = v92
    v91.ImageTransparency = parent:GetAttribute("PortraitFade") or 0
    v91.Parent = parent
    local parent2 = new("ViewportFrame", v91)

    if const uiCorner = parent:FindFirstChildOfClass("UICorner") then
        uiCorner:Clone().Parent = parent2
    end

    a89.model:Clone().Parent = parent2
    local head = a89.head
    local v96 = head.Position - head.UpVector * 0.15
    local v97 = (head.Position + (head.LookVector * 3.9)) + (head.RightVector * 0.8) + head.UpVector * 0.35
    local currentCamera = Instance.new("Camera")
    currentCamera.FieldOfView = 30
    currentCamera.CFrame = CFrame.lookAt(v97, v96)
    currentCamera.Parent = parent2
    parent2.CurrentCamera = currentCamera
    parent2.LightDirection = (v96 - v97).Unit + Vector3.new(0, -0.6000000238418579, 0)
    local cFrame = currentCamera.CFrame

    task.spawn(
        function()
            --[[
              line: 193
              upvalues:
                parent2 (copy, index: 1)
                parent (copy, index: 2)
                currentCamera (copy, index: 3)
                cFrame (copy, index: 4)
                a89 (copy, index: 5)
            ]]
            local rigBack
            local timestamp = os.clock()
            local count = 0

            while parent2.Parent == parent and currentCamera.Parent == parent2 do
                count += 1
                local newCFrame = CFrame.new
                local z = count % 2 ~= 0 and 4e-04 or 0
                currentCamera.CFrame = cFrame * newCFrame(0, 0, z)

                if a89.ready and 0.5 < os.clock() - a89.readyAt and 0.5 < os.clock() - timestamp then
                    rigBack = parent:FindFirstChild("RigBack")

                    if rigBack then
                        rigBack:Destroy()
                    end

                    for index = 1, 4 do
                        task.wait(0.5)

                        if parent2.Parent == parent then
                            local newCFrame2 = CFrame.new
                            local z2 = index % 2 ~= 0 and 4e-04 or 0
                            currentCamera.CFrame = cFrame * newCFrame2(0, 0, z2)
                        end
                    end

                    return
                end

                if 15 < os.clock() - timestamp then
                    return
                end

                task.wait(0.2)
            end
        end
    )
end

rerender = function(key)
    --[[
      name: rerender
      line: 255
      upvalues:
        v6 (copy, index: 1)
        texts (copy, index: 2)
        renderTemplate (ref,  index: 3)
    ]]
    local v109 = v6[key]
    if not v109 then
        return
    end

    local v110 = "rig:" .. key

    for parent, v112 in texts do
        if v112 == v110 and parent.Parent then
            renderTemplate(parent, v109)
        end
    end
end

local function contentIds(model)
    --[[
      name: contentIds
      line: 268
    ]]
    local v115 = {}
    local v116 = {}

    local function add(key)
        --[[
          name: add
          line: 271
          upvalues:
            v115 (copy, index: 1)
            v116 (copy, index: 2)
        ]]
        if type(key) == "string" and key ~= "" and not v115[key] then
            v115[key] = true
            table.insert(v116, key)
        end
    end

    for _, descendant in model:GetDescendants() do
        pcall(
            function()
                --[[
                  line: 278
                  upvalues:
                    descendant (copy, index: 1)
                    v115 (copy, index: 2)
                    v116 (copy, index: 3)
                ]]
                if descendant:IsA("MeshPart") then
                    local meshId = descendant.MeshId

                    if type(meshId) == "string" and meshId ~= "" and not v115[meshId] then
                        v115[meshId] = true
                        table.insert(v116, meshId)
                    end

                    local textureId = descendant.TextureID

                    if type(textureId) == "string" and textureId ~= "" and not v115[textureId] then
                        v115[textureId] = true
                        table.insert(v116, textureId)
                    end
                elseif descendant:IsA("SpecialMesh") then
                    local meshId = descendant.MeshId

                    if type(meshId) == "string" and meshId ~= "" and not v115[meshId] then
                        v115[meshId] = true
                        table.insert(v116, meshId)
                    end

                    local textureId = descendant.TextureId

                    if type(textureId) == "string" and textureId ~= "" and not v115[textureId] then
                        v115[textureId] = true
                        table.insert(v116, textureId)
                    end
                elseif descendant:IsA("Decal") then
                    local texture = descendant.Texture

                    if type(texture) == "string" and texture ~= "" and not v115[texture] then
                        v115[texture] = true
                        table.insert(v116, texture)
                    end
                elseif descendant:IsA("Shirt") then
                    local shirtTemplate = descendant.ShirtTemplate

                    if type(shirtTemplate) == "string" and shirtTemplate ~= "" and not v115[shirtTemplate] then
                        v115[shirtTemplate] = true
                        table.insert(v116, shirtTemplate)
                    end
                elseif descendant:IsA("Pants") then
                    local pantsTemplate = descendant.PantsTemplate

                    if type(pantsTemplate) == "string" and pantsTemplate ~= "" and not v115[pantsTemplate] then
                        v115[pantsTemplate] = true
                        table.insert(v116, pantsTemplate)
                    end
                elseif descendant:IsA("ShirtGraphic") then
                    local graphic = descendant.Graphic

                    if type(graphic) == "string" and graphic ~= "" and not v115[graphic] then
                        v115[graphic] = true
                        table.insert(v116, graphic)
                    end
                end
            end
        )
    end

    return v116
end

local v129 = {}
v129[Enum.AssetFetchStatus.Success] = true
v129[Enum.AssetFetchStatus.Failure] = true
v129[Enum.AssetFetchStatus.TimedOut] = true

prepare = function(a130, a131)
    --[[
      name: prepare
      line: 302
      upvalues:
        contentIds (copy, index: 1)
        contentProvider (copy, index: 2)
        v129 (copy, index: 3)
    ]]
    task.spawn(
        function()
            --[[
              line: 303
              upvalues:
                contentIds (copy, index: 1)
                a131 (copy, index: 2)
                contentProvider (copy, index: 3)
                v129 (copy, index: 4)
            ]]
            local contentIdList = contentIds(a131.model)

            if 0 < #contentIdList then
                task.spawn(
                    function()
                        --[[
                          line: 306
                          upvalues:
                            contentProvider (copy, index: 1)
                            contentIdList (copy, index: 2)
                        ]]
                        pcall(
                            function()
                                --[[
                                  line: 307
                                  upvalues:
                                    contentProvider (copy, index: 1)
                                    contentIdList (copy, index: 2)
                                ]]
                                contentProvider:PreloadAsync(contentIdList)
                            end
                        )
                    end
                )
                local timestamp = os.clock()

                while os.clock() - timestamp < 8 do
                    local v134 = true

                    for _, contentId in contentIdList do
                        local success, assetFetchStatus = pcall(
                            function()
                                --[[
                                  line: 315
                                  upvalues:
                                    contentProvider (copy, index: 1)
                                    contentId (copy, index: 2)
                                ]]
                                return contentProvider:GetAssetFetchStatus(contentId)
                            end
                        )

                        if success and not v129[assetFetchStatus] then
                            v134 = false
                            break
                        end
                    end

                    if v134 then
                        break
                    end

                    task.wait(0.15)
                end
            end

            a131.ready = true
            a131.readyAt = os.clock()
        end
    )
end

function v3.SetTint(tint, imageColor3, imageTransparency)
    --[[
      name: SetTint
      line: 335
    ]]
    tint:SetAttribute("PortraitTint", imageColor3)
    tint:SetAttribute("PortraitFade", imageTransparency)
    tint.ImageColor3 = imageColor3
    tint.ImageTransparency = imageTransparency
    local rigHead = tint:FindFirstChild("RigHead")

    if rigHead and rigHead:IsA("ViewportFrame") then
        rigHead.ImageColor3 = imageColor3
        rigHead.ImageTransparency = imageTransparency
    end
end

function v3.ThumbFor(a143, a144)
    --[[
      name: ThumbFor
      line: 348
      upvalues:
        v5 (ref, index: 1)
    ]]
    local v145

    if type(a143) ~= "table" then
        v145 = a143
    else
        v145 = a143.userId
    end

    if not v5.IsRealUserId(v145) and (not v5.TrustAllUserIds or type(v145) ~= "number" or not (0 < v145)) then
        return ""
    end

    local v146 = a144 or 150
    local v147 = v146 <= 48 and 48 or v146 <= 60 and 60 or v146 <= 150 and 150 or 420

    return string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=%d&h=%d", v145, v147, v147)
end

function v3.ImageFor(a148, a149)
    --[[
      name: ImageFor
      line: 359
      upvalues:
        v3 (copy, index: 1)
    ]]
    return v3.ThumbFor(a148, a149)
end

function v3.Apply(key, value, a152)
    --[[
      name: Apply
      line: 364
      upvalues:
        v3 (copy, index: 1)
        texts (copy, index: 2)
        v7 (copy, index: 3)
        clearRender (copy, index: 4)
        silhouette (copy, index: 5)
        v6 (copy, index: 6)
        v5 (ref,  index: 7)
        capture (ref,  index: 8)
        renderTemplate (ref,  index: 9)
    ]]
    local image = v3.ThumbFor(value, a152)
    local id = type(value) == "table" and value.id or nil
    local v155 = if image ~= "" then image else "rig:" .. tostring(id)

    if texts[key] == v155 then
        if image ~= "" then
            return
        end

        if key:FindFirstChild("RigHead") then
            if not v7[key] then
                return
            end
        end
    end

    texts[key] = v155
    v7[key] = nil
    key.ScaleType = Enum.ScaleType.Crop

    if image ~= "" then
        clearRender(key)
        key.Image = image

        return
    end

    key.Image = ""

    if type(id) ~= "string" then
        silhouette(key)
        return
    end

    local v156 = v6[id]
    if not v156 then
        if const v157 = v5.Find(id) then
            v156 = capture(id, v157)
        end
    end

    if v156 then
        renderTemplate(key, v156)
        return
    end

    silhouette(key)
    v7[key] = value
end

function v3.Reset()
    --[[
      name: Reset
      line: 406
      upvalues:
        v6 (copy, index: 1)
        texts (copy, index: 2)
    ]]
    for _, v159 in v6 do
        v159.model:Destroy()
    end

    table.clear(v6)
    local v160 = {}

    for v161, text in texts do
        if string.sub(text, 1, 4) == "rig:" then
            table.insert(v160, v161)
        end
    end

    for _, v164 in v160 do
        texts[v164] = nil
    end
end

function v3.Init(a165, a166)
    --[[
      name: Init
      line: 423
      upvalues:
        v4 (ref,  index: 1)
        v5 (ref,  index: 2)
        v7 (copy, index: 3)
        v3 (copy, index: 4)
        v6 (copy, index: 5)
        capture (ref,  index: 6)
        texts (copy, index: 7)
    ]]
    v4 = a165
    v5 = a166

    task.spawn(
        function()
            --[[
              line: 427
              upvalues:
                v7 (copy, index: 1)
                v3 (copy, index: 2)
            ]]
            while true do
                task.wait(1)

                if next(v7) then
                    local v167 = {}

                    for v168, v169 in v7 do
                        table.insert(v167, {v168, v169})
                    end

                    for _, v171 in v167 do
                        if v171[1].Parent then
                            v3.Apply(v171[1], v171[2])
                        else
                            v7[v171[1]] = nil
                        end
                    end
                end
            end
        end
    )

    v5.Added:Connect(
        function(key, a173)
            --[[
              line: 446
              upvalues:
                v6 (copy, index: 1)
                capture (ref,  index: 2)
                v7 (copy, index: 3)
                texts (copy, index: 4)
                v3 (copy, index: 5)
            ]]
            local v174 = v6[key]

            if v174 and v174.rig ~= a173 then
                task.delay(
                    0.6,
                    function()
                        --[[
                          line: 450
                          upvalues:
                            v6 (copy, index: 1)
                            key (copy, index: 2)
                            v174 (copy, index: 3)
                            a173 (copy, index: 4)
                            capture (ref,  index: 5)
                        ]]
                        if v6[key] == v174 and a173.Parent then
                            capture(key, a173)
                        end
                    end
                )
            end

            local v175 = false

            for _, v177 in v7 do
                if type(v177) == "table" and v177.id == key then
                    v175 = true
                    break
                end
            end

            if not v175 then
                return
            end

            task.delay(
                0.4,
                function()
                    --[[
                      line: 467
                      upvalues:
                        v6 (copy, index: 1)
                        key (copy, index: 2)
                        a173 (copy, index: 3)
                        capture (ref,  index: 4)
                        v7 (copy, index: 5)
                        texts (copy, index: 6)
                        v3 (copy, index: 7)
                    ]]
                    if not v6[key] and a173.Parent then
                        capture(key, a173)
                    end

                    local v178 = {}

                    for v179, v180 in v7 do
                        if type(v180) == "table" then
                            if v180.id == key and v179.Parent then
                                table.insert(v178, {v179, v180})
                            end
                        end
                    end

                    for _, v182 in v178 do
                        v7[v182[1]] = nil
                        texts[v182[1]] = nil
                        v3.Apply(v182[1], v182[2])
                    end
                end
            )
        end
    )
end

return v3