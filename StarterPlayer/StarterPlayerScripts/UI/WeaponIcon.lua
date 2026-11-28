local contentProvider = game:GetService("ContentProvider")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local v4 = {}
local v5 = nil
local v6 = nil
local instance = nil
local color3 = Color3.fromRGB(128, 132, 142)
local v9 = setmetatable({}, {__mode = "k"})
local v10 = {}
local childNames = {ammo_arrows = "Arrow", ammo_shot = "Ball", ammo_fire_arrows = "FireArrow", fire_arrows = "FireArrow"}
local v12 = {shield = true, palisade = true, harpoon = true, scythe = true}
local v13 = {war_horn = true}
local v14 = {bow = "CrossedArrows", gun = "CrossedArrows", melee = "Sword", throwable = "Sword", utility = "Fire", healing = "Star", armor = "Shield"}

local function findWeaponsFolder()
    --[[
      name: findWeaponsFolder
      line: 37
      upvalues:
        instance (ref,  index: 1)
        replicatedStorage (copy, index: 2)
    ]]
    if instance and instance.Parent then
        return instance
    end

    local instance2 = replicatedStorage:FindFirstChild("Assets")
    instance2 = instance2 and instance2:FindFirstChild("Weapons")

    if instance2 then
        instance = instance2
    end

    return instance2
end

local function modelSource(childName)
    --[[
      name: modelSource
      line: 49
      upvalues:
        instance (ref,  index: 1)
        replicatedStorage (copy, index: 2)
        childNames (copy, index: 3)
    ]]
    local instance2

    if instance and instance.Parent then
        instance2 = instance
    else
        local instance3 = replicatedStorage:FindFirstChild("Assets")
        instance3 = instance3 and instance3:FindFirstChild("Weapons")

        if instance3 then
            instance = instance3
        end

        instance2 = instance3
    end

    local child = instance2 and instance2:FindFirstChild(childName)
    if not child then
        local instance4 = replicatedStorage:FindFirstChild("Assets")
        local armor = instance4 and instance4:FindFirstChild("Armor")
        child = armor and armor:FindFirstChild(childName)
        local childName2 = childNames[childName]

        if not child and childName2 then
            instance4 = instance4 and instance4:FindFirstChild("VFX")
            local projectiles = instance4 and instance4:FindFirstChild("Projectiles")
            child = projectiles and projectiles:FindFirstChild(childName2)
        end
    end

    if child and (child:IsA("Model") or child:IsA("Tool") or child:IsA("BasePart") or child:IsA("Folder")) then
        return child
    end

    return nil
end

local function isArmorSource(instance: Instance?)
    --[[
      name: isArmorSource
      line: 75
    ]]
    return instance:GetAttribute("Armor") == true
end

local function armorIconPart(a29)
    --[[
      name: armorIconPart
      line: 78
    ]]
    return string.find(string.lower(a29.Name), "boots", 1, true) == nil
end

local function cloneVisual(instance: Instance?)
    --[[
      name: cloneVisual
      line: 83
    ]]
    local armor = instance:GetAttribute("Armor") == true
    local parent = Instance.new("Model")
    local v34 = false

    local function copyPart(instance: Instance?)
        --[[
          name: copyPart
          line: 87
          upvalues:
            parent (copy, index: 1)
            v34 (ref,  index: 2)
        ]]
        local success, result = pcall(
            function()
                --[[
                  line: 88
                  upvalues:
                    instance (copy, index: 1)
                ]]
                return instance:Clone()
            end
        )

        if success and result then
            for _, descendant in result:GetDescendants() do
                if not descendant:IsA("DataModelMesh") then
                    if descendant:IsA("Decal") then
                        continue
                    end

                    if descendant:IsA("Texture") then
                        continue
                    end

                    if not descendant:IsA("SurfaceAppearance") and not descendant:IsA("Attachment") then
                        descendant:Destroy()
                    end
                end
            end

            result.Anchored = true
            result.CanCollide = false
            result.CanQuery = false
            result.CanTouch = false
            result.Parent = parent
            v34 = true
        end
    end

    if instance:IsA("BasePart") then
        copyPart(instance)
    end

    for _, descendant in instance:GetDescendants() do
        if descendant:IsA("BasePart") then
            if not (descendant.Transparency < 1) then
                continue
            end

            if not armor or string.find(string.lower(descendant.Name), "boots", 1, true) == nil then
                copyPart(descendant)
            end
        end
    end

    if not v34 then
        parent:Destroy()
        return nil
    end

    if armor then
        for _, child in parent:GetChildren() do
            if child:IsA("BasePart") then
                if not string.find(string.lower(child.Name), "shoulder", 1, true) then
                    continue
                end

                local x = not (0 < child.Position.X) and 0.5 or -0.5
                child.CFrame += Vector3.new(x, -0.12, 0)
            end
        end
    end

    return parent
end

local function computeArmorFraming(id, model: Model?)
    --[[
      name: computeArmorFraming
      line: 133
      upvalues:
        v10 (copy, index: 1)
    ]]
    local boundingBox, vector3 = model:GetBoundingBox()
    local position = boundingBox.Position
    local dist = ((math.max(vector3.X * 0.92, vector3.Y * 1.05) * 0.5) * 1.04) / 0.2679491924311227 + vector3.Z
    local vector32 = position + Vector3.new(0.40055739879608154, 0.1736481785774231, -0.8996666669845581) * dist
    local pivotInv = model:GetPivot():Inverse()
    v10[id] = {axis = Vector3.new(0, 1, 0), cf = pivotInv * CFrame.lookAt(vector32, position, Vector3.new(0, 1, 0)), dist = dist, center = pivotInv * position, pivotInv = pivotInv}
end

local function computeFraming(id, model: Model?, instance: Instance?)
    --[[
      name: computeFraming
      line: 155
      upvalues:
        computeArmorFraming (copy, index: 1)
        v12 (copy, index: 2)
        v13 (copy, index: 3)
        v10 (copy, index: 4)
        isArmorSource (copy, index: 5)
    ]]
    if isArmorSource(instance) then
        computeArmorFraming(id, model)
        return
    end

    local boundingBox, vector3 = model:GetBoundingBox()
    local v61 = {boundingBox.RightVector, boundingBox.UpVector, boundingBox.LookVector}
    local v62 = {vector3.X, vector3.Y, vector3.Z}
    local v63 = {1, 2, 3}

    table.sort(
        v63,
        function(left: number, right: number)
            --[[
              line: 164
              upvalues:
                v62 (copy, index: 1)
            ]]
            local v66 = v62[left]
            return v62[right] < v66
        end
    )

    local v67 = v61[v63[1]]
    local v68 = v61[v63[2]]
    local handle = instance:FindFirstChild("Handle", true)
    local instance2 = if v12[id] and handle then handle:FindFirstChild("Tip") else nil

    if instance2 and instance2:IsA("Attachment") then
        if (instance2.WorldPosition - boundingBox.Position):Dot(v67) < 0 then
            v67 = -v67
        end

        local v71 = -handle.CFrame.LookVector

        if 0 < (v67 - v68):Cross(v67 + v68):Dot(v71) then
            v68 = -v68
        end
    elseif handle and handle:IsA("BasePart") and 0 < (handle.Position - boundingBox.Position):Dot(v67) then
        v67 = -v67
    end

    local v72 = (v67 - v68).Unit
    local unit = (v67 + v68).Unit

    if v13[id] then
        v72 = -v72
    end

    local unit2 = v72:Cross(unit).Unit
    local dist = ((((v62[v63[1]] + v62[v63[2]]) / math.sqrt2) * 0.5) / 0.2679491924311227) * 1 + v62[v63[3]]
    local pivotInv = model:GetPivot():Inverse()
    v10[id] = {cf = pivotInv * CFrame.fromMatrix(boundingBox.Position + (unit2 * dist), v72, unit, unit2), dist = dist, center = pivotInv * boundingBox.Position, pivotInv = pivotInv}
end

local function clearHolder(parent, a79)
    --[[
      name: clearHolder
      line: 203
    ]]
    if a79.spinConn then
        a79.spinConn:Disconnect()
        a79.spinConn = nil
    end

    for _, v81 in {"WeaponIcon", "WeaponOutline", "WeaponGlow"} do
        if const v82 = parent:FindFirstChild(v81) then
            v82:Destroy()
        end
    end

    a79.vpf = nil
    a79.model = nil
    a79.kind = nil
    a79.outlineCam = nil
end

local function addGlow(parent, a85)
    --[[
      name: addGlow
      line: 221
      upvalues:
        v5 (ref, index: 1)
    ]]
    if a85.opts.glow == false or not v5.Assets.Icons.Glow then
        return
    end

    local new = v5.new
    local v87 = {Name = "WeaponGlow", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.25, 1.25), Image = v5.Assets.Icons.Glow}
    local v88 = a85.opts.glowColor or Color3.fromRGB(96, 108, 132)
    v87.ImageColor3 = v88
    v87.ImageTransparency = a85.opts.glowTransparency or 0.25
    v87.ZIndex = parent.ZIndex
    v87.Parent = parent
    new("ImageLabel", v87)
end

local color32 = Color3.fromRGB(226, 232, 242)

local function addOutline(parent, a92, model: Model?, cFrame)
    --[[
      name: addOutline
      line: 241
      upvalues:
        v5 (ref,  index: 1)
        color32 (copy, index: 2)
    ]]
    local v95

    if a92.opts.outline == false then
        return
    end

    local model2 = model:Clone()

    for _, descendant in model2:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Color = Color3.new(1, 1, 1)
            descendant.Material = Enum.Material.SmoothPlastic

            if descendant:IsA("MeshPart") then
                pcall(
                    function()
                        --[[
                          line: 251
                          upvalues:
                            descendant (copy, index: 1)
                        ]]
                        descendant.TextureID = ""
                    end
                )
            end
        elseif descendant:IsA("SpecialMesh") then
            descendant.TextureId = ""
        elseif descendant:IsA("Decal") or descendant:IsA("Texture") or descendant:IsA("SurfaceAppearance") then
            descendant:Destroy()
        end
    end

    local new = v5.new
    local v100 = {Name = "WeaponOutline", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale((a92.opts.outlineScale
        or 1.06), (a92.opts.outlineScale or 1.06)), Ambient = Color3.new(1, 1, 1), LightColor = Color3.new(0, 0, 0)}

    if a92.dim then
        local v101 = a92.opts.outlineColor or color32
        v95 = v101:Lerp(Color3.new(0, 0, 0), 0.4)
    else
        v95 = a92.opts.outlineColor or color32
    end

    v100.ImageColor3 = v95
    v100.ImageTransparency = a92.opts.outlineTransparency or 0.15
    v100.ZIndex = parent.ZIndex
    v100.Parent = parent
    local parent2 = new("ViewportFrame", v100)
    local camera = Instance.new("Camera")
    camera.FieldOfView = 30
    camera.CFrame = cFrame
    camera.Parent = parent2
    parent2.CurrentCamera = camera
    model2.Parent = parent2
    a92.outlineCam = camera
end

local v104 = {0.05, 0.2, 0.45, 0.8, 1.3, 2, 3, 4.5, 6.5}

local function keepRedrawing(a106, a107, model: Model?)
    --[[
      name: keepRedrawing
      line: 289
      upvalues:
        v104 (copy, index: 1)
        contentProvider (copy, index: 2)
    ]]
    local function nudge(a110)
        --[[
          name: nudge
          line: 290
          upvalues:
            a106 (copy, index: 1)
            a107 (copy, index: 2)
        ]]
        if not a106.Parent then
            return
        end

        for _, v112 in a107 do
            if v112.Parent then
                v112.CFrame *= CFrame.new(0, 0, a110 * 4e-04)
            end
        end
    end

    for v113, v114 in v104 do
        local taskDelay = task.delay
        local v116 = v113 % 2 ~= 0 and 1 or -1
        taskDelay(v114, nudge, v116)
    end

    if model then
        task.spawn(
            function()
                --[[
                  line: 304
                  upvalues:
                    contentProvider (copy, index: 1)
                    model (copy, index: 2)
                    nudge (copy, index: 3)
                ]]
                pcall(contentProvider.PreloadAsync, contentProvider, {model})
                nudge(1)
                task.wait(0.1)
                nudge(-1)
            end
        )
    end
end

local function renderModel(parent, a119, id, instance: Instance?)
    --[[
      name: renderModel
      line: 313
      upvalues:
        cloneVisual (copy, index: 1)
        v10 (copy, index: 2)
        computeFraming (copy, index: 3)
        addGlow (copy, index: 4)
        addOutline (copy, index: 5)
        v5 (ref,  index: 6)
        color3 (copy, index: 7)
        keepRedrawing (copy, index: 8)
        runService (copy, index: 9)
    ]]
    local model = cloneVisual(instance)
    if not model then
        return false
    end

    model:PivotTo(CFrame.new())

    if not v10[id] then
        computeFraming(id, model, instance)
    end

    local v123 = v10[id]
    addGlow(parent, a119)
    addOutline(parent, a119, model, v123.cf)
    local unit = (v123.cf.LookVector - (v123.cf.UpVector * 0.8) + (v123.cf.RightVector * 0.5)).Unit
    local v125 = v123.axis ~= nil
    local new = v5.new
    local v127 = {Name = "WeaponIcon", Size = UDim2.fromScale(1, 1), Ambient = if v125 then Color3.fromRGB(112, 116, 128) else Color3.fromRGB(176, 180, 192), LightColor = if v125 then Color3.fromRGB(255, 248, 238) else Color3.fromRGB(255, 250, 242)}
    v127.LightDirection = unit
    v127.ImageTransparency = a119.opts.transparency or 0
    v127.ImageColor3 = a119.dim and color3 or Color3.new(1, 1, 1)
    v127.ZIndex = parent.ZIndex
    v127.Parent = parent
    local v128 = new("ViewportFrame", v127)
    local currentCamera = Instance.new("Camera")
    currentCamera.FieldOfView = 30
    currentCamera.CFrame = v123.cf
    currentCamera.Parent = v128
    v128.CurrentCamera = currentCamera
    model.Parent = v128
    a119.vpf = v128
    a119.model = model
    a119.kind = "model"

    if not a119.opts.spin then
        local v130 = {currentCamera}

        if a119.outlineCam then
            table.insert(v130, a119.outlineCam)
        end

        keepRedrawing(v128, v130, model)
    end

    if a119.opts.spin then
        local cframe = CFrame.new(v123.center)
        local elapsedTime = 0

        a119.spinConn = runService.RenderStepped:Connect(
            function(deltaTime: number)
                --[[
                  line: 361
                  upvalues:
                    v128 (copy, index: 1)
                    parent (copy, index: 2)
                    elapsedTime (ref,  index: 3)
                    cframe (copy, index: 4)
                    v123 (copy, index: 5)
                    currentCamera (copy, index: 6)
                    a119 (copy, index: 7)
                ]]
                if not v128.Parent then
                    return
                end

                if not parent.Visible or not parent:IsDescendantOf(game) then
                    return
                end

                local v134
                elapsedTime += deltaTime
                local v135 = cframe:Inverse() * v123.cf
                local cframeFromAxisAngle = CFrame.fromAxisAngle
                local v137 = v123.axis or v123.cf.UpVector
                local v138 = math.sin(elapsedTime * 0.9)

                if v123.axis then
                    v134 = 0.6
                    v134 = a119
                else
                    v134 = 0.87
                    v134 = a119
                end

                currentCamera.CFrame = (cframe * cframeFromAxisAngle(v137, v138 * v134)) * v135

                if const outlineCam = v134.outlineCam then
                    outlineCam.CFrame = currentCamera.CFrame
                end
            end
        )
    end

    return true
end

local function renderImage(parent, a142, image, a144, a145: number?)
    --[[
      name: renderImage
      line: 381
      upvalues:
        v5 (ref, index: 1)
    ]]
    local v146
    local v147 = a145 or 0
    local new = v5.new
    local v149 = {Name = "WeaponIcon", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1 - v147, 0, 1 - v147, 0), Image = image}

    if a142.dim then
        local startValue = a144 or Color3.new(1, 1, 1)
        v146 = startValue:Lerp(Color3.new(0, 0, 0), 0.45)
    else
        v146 = a144 or Color3.new(1, 1, 1)
    end

    v149.ImageColor3 = v146
    v149.ImageTransparency = a142.opts.transparency or 0
    v149.ScaleType = Enum.ScaleType.Fit
    v149.ZIndex = parent.ZIndex
    v149.Parent = parent
    new("ImageLabel", v149)
end

local function render(parent, a153)
    --[[
      name: render
      line: 397
      upvalues:
        clearHolder (copy, index: 1)
        modelSource (copy, index: 2)
        renderModel (copy, index: 3)
        v6 (ref,  index: 4)
        renderImage (copy, index: 5)
        v5 (ref,  index: 6)
        v14 (copy, index: 7)
    ]]
    clearHolder(parent, a153)
    local id = a153.id
    if not id then
        return
    end

    local instance = modelSource(id)

    if instance and not a153.opts.noModel and renderModel(parent, a153, id, instance) then
        return
    end

    local v156 = v6.Get(id)
    local icon = v156 and v156.icon

    if type(icon) == "string" and icon ~= "" then
        renderImage(parent, a153, icon)
        a153.kind = "icon"

        return
    elseif const image = v5.Assets.WeaponArt and v5.Assets.WeaponArt[id] then
        renderImage(parent, a153, image, nil, 0.06)
        a153.kind = "art"

        return
    end

    local icons = v5.Assets.Icons
    local category = v156 and v156.category or "melee"

    if const icon2 = icons[v14[category] or "Sword"] then
        renderImage(parent, a153, icon2, v5.Theme.Colors.TextMuted, 0.4)
    end

    a153.kind = "glyph"
end

function v4.Set(key, id, a164)
    --[[
      name: Set
      line: 428
      upvalues:
        v9 (copy, index: 1)
        render (copy, index: 2)
    ]]
    local v165 = v9[key]

    if v165 and v165.id == id and v165.kind ~= nil and v165.kind ~= "glyph" and v165.kind ~= "art" then
        return
    end

    if not v165 then
        v165 = {id = id, opts = a164 or {}}
        v9[key] = v165

        key.Destroying:Connect(
            function()
                --[[
                  line: 436
                  upvalues:
                    v9 (copy, index: 1)
                    key (copy, index: 2)
                ]]
                local v166 = v9[key]

                if v166 and v166.spinConn then
                    v166.spinConn:Disconnect()
                end

                v9[key] = nil
            end
        )
    end

    v165.id = id
    v165.opts = a164 or v165.opts or {}
    render(key, v165)
end

function v4.SetDim(key, dim)
    --[[
      name: SetDim
      line: 450
      upvalues:
        v9 (copy, index: 1)
        color32 (copy, index: 2)
        color3 (copy, index: 3)
    ]]
    local v169 = v9[key]
    if v169 then
        v169.dim = dim
    end

    local weaponOutline = key:FindFirstChild("WeaponOutline")

    if weaponOutline and weaponOutline:IsA("ViewportFrame") then
        local v171 = v169 and v169.opts and v169.opts.outlineColor or color32
        weaponOutline.ImageColor3 = if dim then v171:Lerp(Color3.new(0, 0, 0), 0.4) else v171
    end

    local weaponIcon = key:FindFirstChild("WeaponIcon")

    if weaponIcon and weaponIcon:IsA("ViewportFrame") then
        weaponIcon.ImageColor3 = if dim then color3 else Color3.new(1, 1, 1)
        return
    end

    if weaponIcon and weaponIcon:IsA("ImageLabel") then
        local v173 = weaponIcon:GetAttribute("BaseColor")

        if typeof(v173) ~= "Color3" then
            v173 = weaponIcon.ImageColor3
            weaponIcon:SetAttribute("BaseColor", v173)
        end

        weaponIcon.ImageColor3 = if dim then v173:Lerp(Color3.new(0, 0, 0), 0.45) else v173
    end
end

function v4.SetTransparency(a174, imageTransparency)
    --[[
      name: SetTransparency
      line: 473
    ]]
    local weaponIcon = a174:FindFirstChild("WeaponIcon")

    if weaponIcon and (weaponIcon:IsA("ViewportFrame") or weaponIcon:IsA("ImageLabel")) then
        weaponIcon.ImageTransparency = imageTransparency
    end
end

function v4.Init(a177, a178)
    --[[
      name: Init
      line: 480
      upvalues:
        v5 (ref,  index: 1)
        v6 (ref,  index: 2)
        v10 (copy, index: 3)
        v9 (copy, index: 4)
        render (copy, index: 5)
        instance (ref,  index: 6)
        replicatedStorage (copy, index: 7)
        contentProvider (copy, index: 8)
        modelSource (copy, index: 9)
    ]]
    local instance2
    v5 = a177
    v6 = a178

    local function hook(a181)
        --[[
          name: hook
          line: 484
          upvalues:
            v10 (copy, index: 1)
            v9 (copy, index: 2)
            render (copy, index: 3)
        ]]
        a181.ChildAdded:Connect(
            function(a182)
                --[[
                  line: 485
                  upvalues:
                    v10 (copy, index: 1)
                    v9 (copy, index: 2)
                    render (copy, index: 3)
                ]]
                v10[a182.Name] = nil

                for parent, v184 in v9 do
                    if v184.id == a182.Name and v184.kind ~= "model" then
                        task.defer(render, parent, v184)
                    end
                end
            end
        )
    end

    task.delay(
        3,
        function()
            --[[
              line: 496
              upvalues:
                instance (ref,  index: 1)
                replicatedStorage (copy, index: 2)
                contentProvider (copy, index: 3)
            ]]
            local instance2

            if instance and instance.Parent then
                instance2 = instance
            else
                local instance3 = replicatedStorage:FindFirstChild("Assets")
                instance3 = instance3 and instance3:FindFirstChild("Weapons")

                if instance3 then
                    instance = instance3
                end

                instance2 = instance3
            end

            if not instance2 then
                return
            end

            local v187 = {}

            for _, child in instance2:GetChildren() do
                if child:FindFirstChildWhichIsA("SurfaceAppearance", true) then
                    table.insert(v187, child)
                end
            end

            if 0 < #v187 then
                pcall(contentProvider.PreloadAsync, contentProvider, v187)
            end
        end
    )

    if instance and instance.Parent then
        instance2 = instance
    else
        local assets = replicatedStorage:FindFirstChild("Assets")
        local weapons = assets and assets:FindFirstChild("Weapons")
        if weapons then
            instance = weapons
        end

        instance2 = weapons
    end

    if instance2 then
        instance2.ChildAdded:Connect(
            function(child)
                --[[
                  line: 485
                  upvalues:
                    v10 (copy, index: 1)
                    v9 (copy, index: 2)
                    render (copy, index: 3)
                ]]
                v10[child.Name] = nil

                for parent, v194 in v9 do
                    if v194.id == child.Name and v194.kind ~= "model" then
                        task.defer(render, parent, v194)
                    end
                end
            end
        )

        return
    end

    task.spawn(
        function()
            --[[
              line: 515
              upvalues:
                replicatedStorage (copy, index: 1)
                instance (ref,  index: 2)
                v10 (copy, index: 3)
                v9 (copy, index: 4)
                render (copy, index: 5)
                modelSource (copy, index: 6)
            ]]
            local assets = replicatedStorage:WaitForChild("Assets", 30)
            if not assets then
                return
            elseif const weapons = assets:FindFirstChild("Weapons") or assets:WaitForChild("Weapons", 120) then
                instance = weapons

                weapons.ChildAdded:Connect(
                    function(child: Instance)
                        --[[
                          line: 485
                          upvalues:
                            v10 (copy, index: 1)
                            v9 (copy, index: 2)
                            render (copy, index: 3)
                        ]]
                        v10[child.Name] = nil

                        for parent, v199 in v9 do
                            if v199.id == child.Name and v199.kind ~= "model" then
                                task.defer(render, parent, v199)
                            end
                        end
                    end
                )

                for parent, v201 in v9 do
                    if v201.kind ~= "model" and modelSource((v201.id or "")) then
                        task.defer(render, parent, v201)
                    end
                end
            end
        end
    )
end

return v4