local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local v3 = {}
local v4 = nil
local v5 = nil
local instance = nil
local color3 = Color3.fromRGB(128, 132, 142)
local v8 = setmetatable({}, {__mode = "k"})
local v9 = {}
local childNames = {ammo_arrows = "Arrow", ammo_shot = "Ball", ammo_fire_arrows = "FireArrow", fire_arrows = "FireArrow"}
local v11 = {shield = true, palisade = true, harpoon = true, scythe = true}
local v12 = {war_horn = true}
local v13 = {bow = "CrossedArrows", gun = "CrossedArrows", melee = "Sword", throwable = "Sword", utility = "Fire", healing = "Star", armor = "Shield"}

local function findWeaponsFolder()
    --[[
      name: findWeaponsFolder
      line: 36
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
      line: 48
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
      line: 74
    ]]
    return instance:GetAttribute("Armor") == true
end

local function armorIconPart(a28)
    --[[
      name: armorIconPart
      line: 77
    ]]
    return string.find(string.lower(a28.Name), "boots", 1, true) == nil
end

local function cloneVisual(instance: Instance?)
    --[[
      name: cloneVisual
      line: 82
    ]]
    local armor = instance:GetAttribute("Armor") == true
    local parent = Instance.new("Model")
    local v33 = false

    local function copyPart(instance: Instance?)
        --[[
          name: copyPart
          line: 86
          upvalues:
            parent (copy, index: 1)
            v33 (ref,  index: 2)
        ]]
        local success, result = pcall(
            function()
                --[[
                  line: 87
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
            v33 = true
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

    if not v33 then
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
      line: 132
      upvalues:
        v9 (copy, index: 1)
    ]]
    local boundingBox, vector3 = model:GetBoundingBox()
    local position = boundingBox.Position
    local dist = ((math.max(vector3.X * 0.92, vector3.Y * 1.05) * 0.5) * 1.04) / 0.2679491924311227 + vector3.Z
    local vector32 = position + Vector3.new(0.40055739879608154, 0.1736481785774231, -0.8996666669845581) * dist
    local pivotInv = model:GetPivot():Inverse()
    v9[id] = {axis = Vector3.new(0, 1, 0), cf = pivotInv * CFrame.lookAt(vector32, position, Vector3.new(0, 1, 0)), dist = dist, center = pivotInv * position, pivotInv = pivotInv}
end

local function computeFraming(id, model: Model?, instance: Instance?)
    --[[
      name: computeFraming
      line: 154
      upvalues:
        computeArmorFraming (copy, index: 1)
        v11 (copy, index: 2)
        v12 (copy, index: 3)
        v9 (copy, index: 4)
        isArmorSource (copy, index: 5)
    ]]
    if isArmorSource(instance) then
        computeArmorFraming(id, model)
        return
    end

    local boundingBox, vector3 = model:GetBoundingBox()
    local v60 = {boundingBox.RightVector, boundingBox.UpVector, boundingBox.LookVector}
    local v61 = {vector3.X, vector3.Y, vector3.Z}
    local v62 = {1, 2, 3}

    table.sort(
        v62,
        function(left: number, right: number)
            --[[
              line: 163
              upvalues:
                v61 (copy, index: 1)
            ]]
            local v65 = v61[left]
            return v61[right] < v65
        end
    )

    local v66 = v60[v62[1]]
    local v67 = v60[v62[2]]
    local handle = instance:FindFirstChild("Handle", true)
    local instance2 = if v11[id] and handle then handle:FindFirstChild("Tip") else nil

    if instance2 and instance2:IsA("Attachment") then
        if (instance2.WorldPosition - boundingBox.Position):Dot(v66) < 0 then
            v66 = -v66
        end

        local v70 = -handle.CFrame.LookVector

        if 0 < (v66 - v67):Cross(v66 + v67):Dot(v70) then
            v67 = -v67
        end
    elseif handle and handle:IsA("BasePart") and 0 < (handle.Position - boundingBox.Position):Dot(v66) then
        v66 = -v66
    end

    local v71 = (v66 - v67).Unit
    local unit = (v66 + v67).Unit

    if v12[id] then
        v71 = -v71
    end

    local unit2 = v71:Cross(unit).Unit
    local dist = ((((v61[v62[1]] + v61[v62[2]]) / math.sqrt2) * 0.5) / 0.2679491924311227) * 1 + v61[v62[3]]
    local pivotInv = model:GetPivot():Inverse()
    v9[id] = {cf = pivotInv * CFrame.fromMatrix(boundingBox.Position + (unit2 * dist), v71, unit, unit2), dist = dist, center = pivotInv * boundingBox.Position, pivotInv = pivotInv}
end

local function clearHolder(parent, a78)
    --[[
      name: clearHolder
      line: 202
    ]]
    if a78.spinConn then
        a78.spinConn:Disconnect()
        a78.spinConn = nil
    end

    for _, v80 in {"WeaponIcon", "WeaponOutline", "WeaponGlow"} do
        if const v81 = parent:FindFirstChild(v80) then
            v81:Destroy()
        end
    end

    a78.vpf = nil
    a78.model = nil
    a78.kind = nil
    a78.outlineCam = nil
end

local function addGlow(parent, a84)
    --[[
      name: addGlow
      line: 220
      upvalues:
        v4 (ref, index: 1)
    ]]
    if a84.opts.glow == false or not v4.Assets.Icons.Glow then
        return
    end

    local new = v4.new
    local v86 = {Name = "WeaponGlow", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.25, 1.25), Image = v4.Assets.Icons.Glow}
    local v87 = a84.opts.glowColor or Color3.fromRGB(96, 108, 132)
    v86.ImageColor3 = v87
    v86.ImageTransparency = a84.opts.glowTransparency or 0.25
    v86.ZIndex = parent.ZIndex
    v86.Parent = parent
    new("ImageLabel", v86)
end

local color32 = Color3.fromRGB(226, 232, 242)

local function addOutline(parent, a91, model: Model?, cFrame)
    --[[
      name: addOutline
      line: 240
      upvalues:
        v4 (ref,  index: 1)
        color32 (copy, index: 2)
    ]]
    local v94

    if a91.opts.outline == false then
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
                          line: 250
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

    local new = v4.new
    local v99 = {Name = "WeaponOutline", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale((a91.opts.outlineScale
        or 1.06), (a91.opts.outlineScale or 1.06)), Ambient = Color3.new(1, 1, 1), LightColor = Color3.new(0, 0, 0)}

    if a91.dim then
        local v100 = a91.opts.outlineColor or color32
        v94 = v100:Lerp(Color3.new(0, 0, 0), 0.4)
    else
        v94 = a91.opts.outlineColor or color32
    end

    v99.ImageColor3 = v94
    v99.ImageTransparency = a91.opts.outlineTransparency or 0.15
    v99.ZIndex = parent.ZIndex
    v99.Parent = parent
    local parent2 = new("ViewportFrame", v99)
    local camera = Instance.new("Camera")
    camera.FieldOfView = 30
    camera.CFrame = cFrame
    camera.Parent = parent2
    parent2.CurrentCamera = camera
    model2.Parent = parent2
    a91.outlineCam = camera
end

local v103 = {0.05, 0.2, 0.45, 0.8, 1.3, 2, 3, 4.5, 6.5}

local function keepRedrawing(a105, a106)
    --[[
      name: keepRedrawing
      line: 285
      upvalues:
        v103 (copy, index: 1)
    ]]
    for v107, v108 in v103 do
        task.delay(
            v108,
            function()
                --[[
                  line: 287
                  upvalues:
                    a105 (copy, index: 1)
                    a106 (copy, index: 2)
                    v107 (copy, index: 3)
                ]]
                if not a105.Parent then
                    return
                end

                for _, v110 in a106 do
                    if v110.Parent then
                        local cFrame = v110.CFrame
                        local newCFrame = CFrame.new
                        local z = v107 % 2 ~= 0 and 4e-04 or -4e-04
                        v110.CFrame = cFrame * newCFrame(0, 0, z)
                    end
                end
            end
        )
    end
end

local function renderModel(parent, a116, id, instance: Instance?)
    --[[
      name: renderModel
      line: 300
      upvalues:
        cloneVisual (copy, index: 1)
        v9 (copy, index: 2)
        computeFraming (copy, index: 3)
        addGlow (copy, index: 4)
        addOutline (copy, index: 5)
        v4 (ref,  index: 6)
        color3 (copy, index: 7)
        keepRedrawing (copy, index: 8)
        runService (copy, index: 9)
    ]]
    local model = cloneVisual(instance)
    if not model then
        return false
    end

    model:PivotTo(CFrame.new())

    if not v9[id] then
        computeFraming(id, model, instance)
    end

    local v120 = v9[id]
    addGlow(parent, a116)
    addOutline(parent, a116, model, v120.cf)
    local unit = (v120.cf.LookVector - (v120.cf.UpVector * 0.8) + (v120.cf.RightVector * 0.5)).Unit
    local v122 = v120.axis ~= nil
    local new = v4.new
    local v124 = {Name = "WeaponIcon", Size = UDim2.fromScale(1, 1), Ambient = if v122 then Color3.fromRGB(112, 116, 128) else Color3.fromRGB(176, 180, 192), LightColor = if v122 then Color3.fromRGB(255, 248, 238) else Color3.fromRGB(255, 250, 242)}
    v124.LightDirection = unit
    v124.ImageTransparency = a116.opts.transparency or 0
    v124.ImageColor3 = a116.dim and color3 or Color3.new(1, 1, 1)
    v124.ZIndex = parent.ZIndex
    v124.Parent = parent
    local v125 = new("ViewportFrame", v124)
    local currentCamera = Instance.new("Camera")
    currentCamera.FieldOfView = 30
    currentCamera.CFrame = v120.cf
    currentCamera.Parent = v125
    v125.CurrentCamera = currentCamera
    model.Parent = v125
    a116.vpf = v125
    a116.model = model
    a116.kind = "model"

    if not a116.opts.spin then
        local v127 = {currentCamera}

        if a116.outlineCam then
            table.insert(v127, a116.outlineCam)
        end

        keepRedrawing(v125, v127)
    end

    if a116.opts.spin then
        local cframe = CFrame.new(v120.center)
        local elapsedTime = 0

        a116.spinConn = runService.RenderStepped:Connect(
            function(deltaTime: number)
                --[[
                  line: 348
                  upvalues:
                    v125 (copy, index: 1)
                    parent (copy, index: 2)
                    elapsedTime (ref,  index: 3)
                    cframe (copy, index: 4)
                    v120 (copy, index: 5)
                    currentCamera (copy, index: 6)
                    a116 (copy, index: 7)
                ]]
                if not v125.Parent then
                    return
                end
                if not parent.Visible or not parent:IsDescendantOf(game) then
                    return
                end

                local v131
                elapsedTime += deltaTime
                local v132 = cframe:Inverse() * v120.cf
                local cframeFromAxisAngle = CFrame.fromAxisAngle
                local v134 = v120.axis or v120.cf.UpVector
                local v135 = math.sin(elapsedTime * 0.9)

                if v120.axis then
                    v131 = 0.6
                    v131 = a116
                else
                    v131 = 0.87
                    v131 = a116
                end

                currentCamera.CFrame = (cframe * cframeFromAxisAngle(v134, v135 * v131)) * v132

                if const outlineCam = v131.outlineCam then
                    outlineCam.CFrame = currentCamera.CFrame
                end
            end
        )
    end

    return true
end

local function renderImage(parent, a139, image, a141, a142: number?)
    --[[
      name: renderImage
      line: 368
      upvalues:
        v4 (ref, index: 1)
    ]]
    local v143
    local v144 = a142 or 0
    local new = v4.new
    local v146 = {Name = "WeaponIcon", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1 - v144, 0, 1 - v144, 0), Image = image}

    if a139.dim then
        local startValue = a141 or Color3.new(1, 1, 1)
        v143 = startValue:Lerp(Color3.new(0, 0, 0), 0.45)
    else
        v143 = a141 or Color3.new(1, 1, 1)
    end

    v146.ImageColor3 = v143
    v146.ImageTransparency = a139.opts.transparency or 0
    v146.ScaleType = Enum.ScaleType.Fit
    v146.ZIndex = parent.ZIndex
    v146.Parent = parent
    new("ImageLabel", v146)
end

local function render(parent, a150)
    --[[
      name: render
      line: 384
      upvalues:
        clearHolder (copy, index: 1)
        modelSource (copy, index: 2)
        renderModel (copy, index: 3)
        v5 (ref,  index: 4)
        renderImage (copy, index: 5)
        v4 (ref,  index: 6)
        v13 (copy, index: 7)
    ]]
    clearHolder(parent, a150)
    local id = a150.id
    if not id then
        return
    end

    local instance = modelSource(id)

    if instance and not a150.opts.noModel and renderModel(parent, a150, id, instance) then
        return
    end

    local v153 = v5.Get(id)
    local icon = v153 and v153.icon

    if type(icon) == "string" and icon ~= "" then
        renderImage(parent, a150, icon)
        a150.kind = "icon"

        return
    elseif const image = v4.Assets.WeaponArt and v4.Assets.WeaponArt[id] then
        renderImage(parent, a150, image, nil, 0.06)
        a150.kind = "art"

        return
    end

    local icons = v4.Assets.Icons
    local category = v153 and v153.category or "melee"

    if const icon2 = icons[v13[category] or "Sword"] then
        renderImage(parent, a150, icon2, v4.Theme.Colors.TextMuted, 0.4)
    end

    a150.kind = "glyph"
end

function v3.Set(key, id, a161)
    --[[
      name: Set
      line: 415
      upvalues:
        v8 (copy, index: 1)
        render (copy, index: 2)
    ]]
    local v162 = v8[key]

    if v162 and v162.id == id and v162.kind ~= nil and v162.kind ~= "glyph" and v162.kind ~= "art" then
        return
    end

    if not v162 then
        v162 = {id = id, opts = a161 or {}}
        v8[key] = v162

        key.Destroying:Connect(
            function()
                --[[
                  line: 423
                  upvalues:
                    v8 (copy, index: 1)
                    key (copy, index: 2)
                ]]
                local v163 = v8[key]

                if v163 and v163.spinConn then
                    v163.spinConn:Disconnect()
                end

                v8[key] = nil
            end
        )
    end

    v162.id = id
    v162.opts = a161 or v162.opts or {}
    render(key, v162)
end

function v3.SetDim(key, dim)
    --[[
      name: SetDim
      line: 437
      upvalues:
        v8 (copy, index: 1)
        color32 (copy, index: 2)
        color3 (copy, index: 3)
    ]]
    local v166 = v8[key]
    if v166 then
        v166.dim = dim
    end

    local weaponOutline = key:FindFirstChild("WeaponOutline")

    if weaponOutline and weaponOutline:IsA("ViewportFrame") then
        local v168 = v166 and v166.opts and v166.opts.outlineColor or color32
        weaponOutline.ImageColor3 = if dim then v168:Lerp(Color3.new(0, 0, 0), 0.4) else v168
    end

    local weaponIcon = key:FindFirstChild("WeaponIcon")

    if weaponIcon and weaponIcon:IsA("ViewportFrame") then
        weaponIcon.ImageColor3 = if dim then color3 else Color3.new(1, 1, 1)
        return
    end

    if weaponIcon and weaponIcon:IsA("ImageLabel") then
        local v170 = weaponIcon:GetAttribute("BaseColor")

        if typeof(v170) ~= "Color3" then
            v170 = weaponIcon.ImageColor3
            weaponIcon:SetAttribute("BaseColor", v170)
        end

        weaponIcon.ImageColor3 = if dim then v170:Lerp(Color3.new(0, 0, 0), 0.45) else v170
    end
end

function v3.SetTransparency(a171, imageTransparency)
    --[[
      name: SetTransparency
      line: 460
    ]]
    local weaponIcon = a171:FindFirstChild("WeaponIcon")

    if weaponIcon and (weaponIcon:IsA("ViewportFrame") or weaponIcon:IsA("ImageLabel")) then
        weaponIcon.ImageTransparency = imageTransparency
    end
end

function v3.Init(a174, a175)
    --[[
      name: Init
      line: 467
      upvalues:
        v4 (ref,  index: 1)
        v5 (ref,  index: 2)
        v9 (copy, index: 3)
        v8 (copy, index: 4)
        render (copy, index: 5)
        instance (ref,  index: 6)
        replicatedStorage (copy, index: 7)
        modelSource (copy, index: 8)
    ]]
    local instance2
    v4 = a174
    v5 = a175

    local function hook(a178)
        --[[
          name: hook
          line: 471
          upvalues:
            v9 (copy, index: 1)
            v8 (copy, index: 2)
            render (copy, index: 3)
        ]]
        a178.ChildAdded:Connect(
            function(a179)
                --[[
                  line: 472
                  upvalues:
                    v9 (copy, index: 1)
                    v8 (copy, index: 2)
                    render (copy, index: 3)
                ]]
                v9[a179.Name] = nil

                for parent, v181 in v8 do
                    if v181.id == a179.Name and v181.kind ~= "model" then
                        task.defer(render, parent, v181)
                    end
                end
            end
        )
    end

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

    if instance2 then
        instance2.ChildAdded:Connect(
            function(child)
                --[[
                  line: 472
                  upvalues:
                    v9 (copy, index: 1)
                    v8 (copy, index: 2)
                    render (copy, index: 3)
                ]]
                v9[child.Name] = nil

                for parent, v185 in v8 do
                    if v185.id == child.Name and v185.kind ~= "model" then
                        task.defer(render, parent, v185)
                    end
                end
            end
        )

        return
    end

    task.spawn(
        function()
            --[[
              line: 485
              upvalues:
                replicatedStorage (copy, index: 1)
                instance (ref,  index: 2)
                v9 (copy, index: 3)
                v8 (copy, index: 4)
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
                          line: 472
                          upvalues:
                            v9 (copy, index: 1)
                            v8 (copy, index: 2)
                            render (copy, index: 3)
                        ]]
                        v9[child.Name] = nil

                        for parent, v190 in v8 do
                            if v190.id == child.Name and v190.kind ~= "model" then
                                task.defer(render, parent, v190)
                            end
                        end
                    end
                )

                for parent, v192 in v8 do
                    if v192.kind ~= "model" and modelSource((v192.id or "")) then
                        task.defer(render, parent, v192)
                    end
                end
            end
        end
    )
end

return v3