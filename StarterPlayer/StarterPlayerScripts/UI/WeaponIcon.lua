local ReplicatedStorage_upv_1 = game:GetService("ReplicatedStorage")
local RunService_upv_1 = game:GetService("RunService")
local tbl_1 = {}
local u1 = nil
local u2 = nil
local u3 = nil
local u4 = Color3.fromRGB(128, 132, 142)
local u5 = setmetatable({}, {__mode = "k"})
local tbl_upv_2 = {}
local tbl_upv_3 = {ammo_shot = "Ball", ammo_arrows = "Arrow", ammo_fire_arrows = "FireArrow", fire_arrows = "FireArrow"}
local tbl_upv_4 = {shield = true, harpoon = true, scythe = true, palisade = true}
local tbl_upv_5 = {war_horn = true}
local tbl_upv_6 = {throwable = "Sword", melee = "Sword", healing = "Star", armor = "Shield", gun = "CrossedArrows", bow = "CrossedArrows", utility = "Fire"}
local function findWeaponsFolder()
    --[[
      name: findWeaponsFolder
      line: 36
      upvalues:
        u3 (ref,  index: 1)
        ReplicatedStorage_upv_1 (copy, index: 2)
    ]]
    if u3 and u3.Parent then
        return u3
    end
    local Assets_1 = ReplicatedStorage_upv_1:FindFirstChild("Assets")
    local v1 = Assets_1 and (Assets_1:FindFirstChild("Weapons"))
    if v1 then
        u3 = v1
    end
    return Assets_1
end
local function modelSource(a1)
    --[[
      name: modelSource
      line: 48
      upvalues:
        u3 (ref,  index: 1)
        ReplicatedStorage_upv_1 (copy, index: 2)
        tbl_upv_3 (copy, index: 3)
    ]]
    local v2
    if (u3) and (u3.Parent) then
        v2 = u3
    else
        local Assets_2 = ReplicatedStorage_upv_1:FindFirstChild("Assets")
        local v3 = Assets_2 and (Assets_2:FindFirstChild("Weapons"))
        if v3 then
            u3 = v3
        end
        v2 = Assets_2
    end
    local v4 = v2 and (v2:FindFirstChild(a1))
    if not (v4) then
        local Assets_3 = ReplicatedStorage_upv_1:FindFirstChild("Assets")
        local v5 = Assets_3 and (Assets_3:FindFirstChild("Armor"))
        local v6 = v5 and (v5:FindFirstChild(a1))
        local v7 = tbl_upv_3[a1]
        if not v6 and v7 then
            local v8 = Assets_3 and Assets_3:FindFirstChild("VFX")
            local v9 = v8 and (v8:FindFirstChild("Projectiles"))
            v4 = v9 and v9:FindFirstChild(v7)
        else
            v4 = v6
        end
    end
    if v4 then
        if not (v4:IsA("Model")) and not (v4:IsA("Tool")) and not (v4:IsA("BasePart")) and not (v4:IsA("Folder")) then
            return nil
        end
        return v4
    end
    return nil
end
local function isArmorSource(a1)
    --[[
      name: isArmorSource
      line: 74
    ]]
    local v11 = a1:GetAttribute("Armor") == true
    return v11
end
local function armorIconPart(a1)
    --[[
      name: armorIconPart
      line: 77
    ]]
    local v12 = string.find(string.lower(a1.Name), "boots", 1, true) == nil
    return v12
end
local function computeArmorFraming(a1, a2)
    --[[
      name: computeArmorFraming
      line: 132
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    local v13, v14 = a2:GetBoundingBox()
    local Position_1 = v13.Position
    local v15 = ((math.max(v14.X * 0.92, v14.Y * 1.05) * 0.5) * 1.04) / 0.2679491924311227 + v14.Z
    local v16 = a2:GetPivot():Inverse()
    tbl_upv_2[a1] = {axis = Vector3.new(0, 1, 0), cf = v16 * CFrame.lookAt(Position_1 + (Vector3.new(0.40055739879608154, 0.1736481785774231, -0.8996666669845581) * v15), Position_1, Vector3.new(0, 1, 0)), dist = v15, center = v16 * Position_1, pivotInv = v16}
end
local function clearHolder(a1, a2)
    --[[
      name: clearHolder
      line: 202
    ]]
    if a2.spinConn then
        a2.spinConn:Disconnect()
        a2.spinConn = nil
    end
    for _, value_1 in {"WeaponIcon", "WeaponOutline", "WeaponGlow"} do
        local v17 = a1:FindFirstChild(value_1)
        if v17 then
            v17:Destroy()
        end
    end
    a2.vpf = nil
    a2.model = nil
    a2.kind = nil
    a2.outlineCam = nil
end
local function addGlow(a1, a2)
    --[[
      name: addGlow
      line: 220
      upvalues:
        u1 (ref, index: 1)
    ]]
    if a2.opts.glow == false then
        return
    end
    if u1.Assets.Icons.Glow then
        local new_1 = u1.new
        local tbl_7 = {ImageColor3 = 0, ImageTransparency = 0, Parent = 0, Name = "WeaponGlow", ZIndex = 0}
        tbl_7.AnchorPoint = Vector2.new(0.5, 0.5)
        tbl_7.Position = UDim2.fromScale(0.5, 0.5)
        tbl_7.Size = UDim2.fromScale(1.25, 1.25)
        tbl_7.Image = u1.Assets.Icons.Glow
        tbl_7.ImageColor3 = a2.opts.glowColor or Color3.fromRGB(96, 108, 132)
        tbl_7.ImageTransparency = a2.opts.glowTransparency or 0.25
        tbl_7.ZIndex = a1.ZIndex
        tbl_7.Parent = a1
        new_1("ImageLabel", tbl_7)
    end
end
local u6 = Color3.fromRGB(226, 232, 242)
local function addOutline(a1, a2, a3, a4)
    --[[
      name: addOutline
      line: 240
      upvalues:
        u1 (ref,  index: 1)
        u6 (copy, index: 2)
    ]]
    if a2.opts.outline == false then
        return
    end
    local v19 = a3:Clone()
    for _, value_upv_2 in v19:GetDescendants() do
        if value_upv_2:IsA("BasePart") then
            value_upv_2.Color = Color3.new(1, 1, 1)
            value_upv_2.Material = Enum.Material.SmoothPlastic
            if value_upv_2:IsA("MeshPart") then
                pcall(
                    function()
                        --[[
                          line: 250
                          upvalues:
                            value_upv_2 (copy, index: 1)
                        ]]
                        value_upv_2.TextureID = ""
                    end
                )
            end
        else
            if value_upv_2:IsA("SpecialMesh") then
                value_upv_2.TextureId = ""
                continue
            end
            if value_upv_2:IsA("Decal") or value_upv_2:IsA("Texture") or value_upv_2:IsA("SurfaceAppearance") then
                value_upv_2:Destroy()
            end
        end
    end
    local new_2 = u1.new
    local tbl_8 = {ImageColor3 = 0, ImageTransparency = 0, Parent = 0, Name = "WeaponOutline", ZIndex = 0}
    tbl_8.AnchorPoint = Vector2.new(0.5, 0.5)
    tbl_8.Position = UDim2.fromScale(0.5, 0.5)
    tbl_8.Size = UDim2.fromScale(a2.opts.outlineScale or 1.06, a2.opts.outlineScale or 1.06)
    tbl_8.Ambient = Color3.new(1, 1, 1)
    tbl_8.LightColor = Color3.new(0, 0, 0)
    local v20, v21 = nil, nil
    if a2.dim then
        v20 = a2.opts.outlineColor or u6
        v20 = v20:Lerp(Color3.new(0, 0, 0), 0.4)
    else
        v21 = a2.opts.outlineColor
        if v21 then
            v20 = v21
        else
            v21 = u6
        end
    end
    tbl_8.ImageColor3 = v20
    tbl_8.ImageTransparency = a2.opts.outlineTransparency or 0.15
    tbl_8.ZIndex = a1.ZIndex
    tbl_8.Parent = a1
    local v22 = new_2("ViewportFrame", tbl_8)
    local v23 = Instance.new("Camera")
    v23.FieldOfView = 30
    v23.CFrame = a4
    v23.Parent = v22
    v22.CurrentCamera = v23
    v19.Parent = v22
    a2.outlineCam = v23
end
local tbl_upv_9 = {0.05, 0.2, 0.45, 0.8, 1.3, 2, 3, 4.5, 6.5}
local function cloneVisual(a1)
    --[[
      name: cloneVisual
      line: 82
    ]]
    local v24 = a1:GetAttribute("Armor") == true
    local u7 = Instance.new("Model")
    local u8 = false
    local function copyPart_1(a2)
        --[[
          name: copyPart
          line: 86
          upvalues:
            u7 (copy, index: 1)
            u8 (ref,  index: 2)
        ]]
        local success_1, v25 = pcall(
            function()
                --[[
                  line: 87
                  upvalues:
                    a2 (copy, index: 1)
                ]]
                return a2:Clone()
            end
        )
        if not success_1 or not v25 then
            return
        end
        for _, value_3 in v25:GetDescendants() do
            if value_3:IsA("DataModelMesh") or value_3:IsA("Decal") or value_3:IsA("Texture") or value_3:IsA("SurfaceAppearance") then
                continue
            end
            if not (value_3:IsA("Attachment")) then
                value_3:Destroy()
            end
        end
        v25.Anchored = true
        v25.CanCollide = false
        v25.CanQuery = false
        v25.CanTouch = false
        v25.Parent = u7
        u8 = true
    end
    if a1:IsA("BasePart") then
        copyPart_1(a1)
    end
    for _, value_4 in a1:GetDescendants() do
        if not (value_4:IsA("BasePart")) or not (value_4.Transparency < 1) then
            continue
        end
        if not (v24) then
            copyPart_1(value_4)
            continue
        end
        local v26 = string.find(string.lower(value_4.Name), "boots", 1, true) == nil
        if v26 then
            copyPart_1(value_4)
        end
    end
    if u8 then
        if v24 then
            for _, value_5 in u7:GetChildren() do
                if not (value_5:IsA("BasePart")) then
                    continue
                end
                if string.find(string.lower(value_5.Name), "shoulder", 1, true) then
                    value_5.CFrame = value_5.CFrame + Vector3.new(((value_5.Position.X > 0) and -0.5) or 0.5, -0.12, 0)
                end
            end
        end
        return u7
    end
    u7:Destroy()
    return nil
end
local function keepRedrawing(a1, a2)
    --[[
      name: keepRedrawing
      line: 285
      upvalues:
        tbl_upv_9 (copy, index: 1)
    ]]
    for key_upv_1, value_6 in tbl_upv_9 do
        task.delay(
            value_6,
            function()
                --[[
                  line: 287
                  upvalues:
                    a1 (copy, index: 1)
                    a2 (copy, index: 2)
                    key_upv_1 (copy, index: 3)
                ]]
                if not a1.Parent then
                    return
                end
                for _, value_7 in a2 do
                    if value_7.Parent then
                        value_7.CFrame = value_7.CFrame * CFrame.new(0, 0, ((key_upv_1 % 2 ~= 0) and 4e-04) or -4e-04)
                    end
                end
            end
        )
    end
end
local function computeFraming(a1, a2, a3)
    --[[
      name: computeFraming
      line: 154
      upvalues:
        computeArmorFraming (copy, index: 1)
        tbl_upv_4 (copy, index: 2)
        tbl_upv_5 (copy, index: 3)
        tbl_upv_2 (copy, index: 4)
    ]]
    local v27 = a3:GetAttribute("Armor") == true
    if v27 then
        computeArmorFraming(a1, a2)
    else
        local v28, v29 = a2:GetBoundingBox()
        local tbl_10 = {v28.RightVector, v28.UpVector, v28.LookVector}
        local tbl_upv_11 = {v29.X, v29.Y, v29.Z}
        local tbl_12 = {1, 2, 3}
        table.sort(
            tbl_12,
            function(a4, a5)
                --[[
                  line: 163
                  upvalues:
                    tbl_upv_11 (copy, index: 1)
                ]]
                return tbl_upv_11[a5] < tbl_upv_11[a4]
            end
        )
        local v30 = tbl_10[tbl_12[1]]
        local Unit_1 = tbl_10[tbl_12[2]]
        local v31 = a3:FindFirstChild("Handle", true)
        local v32 = not (tbl_upv_4[a1]) or not (v31) or v31:FindFirstChild("Tip")
        if (v32) and (v32:IsA("Attachment")) then
            if (v32.WorldPosition - v28.Position):Dot(v30) < 0 then
                v30 = -v30
            end
            if (v30 - Unit_1):Cross(v30 + Unit_1):Dot(-v31.CFrame.LookVector) > 0 then
                Unit_1 = -Unit_1
            end
        elseif v31 then
            local v33 = v31:IsA("BasePart")
            if v33 and (v31.Position - v28.Position):Dot(v30) > 0 then
                v30 = -v30
            end
        end
        local Unit_2 = (v30 - Unit_1).Unit
        local Unit_3 = (v30 + Unit_1).Unit
        Unit_2 = tbl_upv_5[a1] and -Unit_2
        Unit_1 = Unit_2:Cross(Unit_3).Unit
        local v34 = ((((tbl_upv_11[tbl_12[1]] + tbl_upv_11[tbl_12[2]]) / math.sqrt2) * 0.5) / 0.2679491924311227) * 1 + tbl_upv_11[tbl_12[3]]
        local v35 = a2:GetPivot():Inverse()
        tbl_upv_2[a1] = {cf = v35 * CFrame.fromMatrix(v28.Position + (Unit_1 * v34), Unit_2, Unit_3, Unit_1), dist = v34, center = v35 * v28.Position, pivotInv = v35}
    end
end
local function renderModel(a1, a2, a3, a4)
    --[[
      name: renderModel
      line: 300
      upvalues:
        cloneVisual (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
        computeFraming (copy, index: 3)
        addGlow (copy, index: 4)
        addOutline (copy, index: 5)
        u1 (ref,  index: 6)
        u4 (copy, index: 7)
        keepRedrawing (copy, index: 8)
        RunService_upv_1 (copy, index: 9)
    ]]
    local v36 = cloneVisual(a4)
    if not v36 then
        return false
    end
    v36:PivotTo(CFrame.new())
    if not (tbl_upv_2[a3]) then
        computeFraming(a3, v36, a4)
    end
    local u9 = tbl_upv_2[a3]
    addGlow(a1, a2)
    addOutline(a1, a2, v36, u9.cf)
    local v37 = u9.axis ~= nil
    local new_3 = u1.new
    local tbl_13 = {ImageColor3 = 0, ImageTransparency = 0, Parent = 0, LightColor = 0, LightDirection = 0, Name = "WeaponIcon", ZIndex = 0, Ambient = 0}
    tbl_13.Size = UDim2.fromScale(1, 1)
    local v38
    if v37 then
        v38 = Color3.fromRGB(112, 116, 128)
    else
        v38 = Color3.fromRGB(176, 180, 192)
    end
    tbl_13.Ambient = v38
    local v39
    if v37 then
        v39 = Color3.fromRGB(255, 248, 238)
    else
        v39 = Color3.fromRGB(255, 250, 242)
    end
    tbl_13.LightColor = v39
    tbl_13.LightDirection = ((u9.cf.LookVector - (u9.cf.UpVector * 0.8)) + (u9.cf.RightVector * 0.5)).Unit
    tbl_13.ImageTransparency = a2.opts.transparency or 0
    v39 = ((a2.dim) and u4) or (Color3.new(1, 1, 1))
    tbl_13.ImageColor3 = v39
    tbl_13.ZIndex = a1.ZIndex
    tbl_13.Parent = a1
    local u10 = new_3("ViewportFrame", tbl_13)
    local u11 = Instance.new("Camera")
    u11.FieldOfView = 30
    u11.CFrame = u9.cf
    u11.Parent = u10
    u10.CurrentCamera = u11
    v36.Parent = u10
    a2.vpf = u10
    a2.model = v36
    a2.kind = "model"
    if not (a2.opts.spin) then
        local tbl_14 = {u11}
        if a2.outlineCam then
            table.insert(tbl_14, a2.outlineCam)
        end
        keepRedrawing(u10, tbl_14)
    end
    if a2.opts.spin then
        local u12 = CFrame.new(u9.center)
        local u13 = 0
        a2.spinConn = RunService_upv_1.RenderStepped:Connect(
            function(a5)
                --[[
                  line: 348
                  upvalues:
                    u10 (copy, index: 1)
                    a1 (copy, index: 2)
                    u13 (ref,  index: 3)
                    u12 (copy, index: 4)
                    u9 (copy, index: 5)
                    u11 (copy, index: 6)
                    a2 (copy, index: 7)
                ]]
                if not u10.Parent then
                    return
                end
                if a1.Visible and a1:IsDescendantOf(game) then
                    u13 = u13 + a5
                    local v40 = u12:Inverse()
                    local v41 = u9.axis or (u9.cf.UpVector)
                    local v42 = math.sin(u13 * 0.9)
                    u11.CFrame = (u12 * CFrame.fromAxisAngle(v41, v42 * (((u9.axis) and 0.6) or 0.87))) * (v40 * u9.cf)
                    local outlineCam_1 = a2.outlineCam
                    if outlineCam_1 then
                        outlineCam_1.CFrame = u11.CFrame
                    end
                    return
                end
            end
        )
    end
    return true
end
local function renderImage(a1, a2, a3, a4, a5)
    --[[
      name: renderImage
      line: 368
      upvalues:
        u1 (ref, index: 1)
    ]]
    local v43 = a5 or 0
    local new_4 = u1.new
    local tbl_15 = {ImageColor3 = 0, ScaleType = 0, ImageTransparency = 0, Parent = 0, Name = "WeaponIcon", ZIndex = 0}
    tbl_15.AnchorPoint = Vector2.new(0.5, 0.5)
    tbl_15.Position = UDim2.fromScale(0.5, 0.5)
    tbl_15.Size = UDim2.new(1 - v43, 0, 1 - v43, 0)
    tbl_15.Image = a3
    local v44
    if a2.dim then
        v44 = a4 or Color3.new(1, 1, 1)
        v44 = v44:Lerp(Color3.new(0, 0, 0), 0.45)
    else
        v44 = a4 or (Color3.new(1, 1, 1))
    end
    tbl_15.ImageColor3 = v44
    tbl_15.ImageTransparency = a2.opts.transparency or 0
    tbl_15.ScaleType = Enum.ScaleType.Fit
    tbl_15.ZIndex = a1.ZIndex
    tbl_15.Parent = a1
    new_4("ImageLabel", tbl_15)
end
local function render(a1, a2)
    --[[
      name: render
      line: 384
      upvalues:
        clearHolder (copy, index: 1)
        modelSource (copy, index: 2)
        renderModel (copy, index: 3)
        u2 (ref,  index: 4)
        renderImage (copy, index: 5)
        u1 (ref,  index: 6)
        tbl_upv_6 (copy, index: 7)
    ]]
    clearHolder(a1, a2)
    local id_1 = a2.id
    if not id_1 then
        return
    end
    local v45 = modelSource(id_1)
    if v45 and not (a2.opts.noModel) and renderModel(a1, a2, id_1, v45) then
        return
    end
    local v46 = u2.Get(id_1)
    local v47 = v46 and (v46.icon)
    if type(v47) == "string" and v47 ~= "" then
        renderImage(a1, a2, v47)
        a2.kind = "icon"
        return
    end
    local v48 = u1.Assets.WeaponArt and (u1.Assets.WeaponArt[id_1])
    if v48 then
        renderImage(a1, a2, v48, nil, 0.06)
        a2.kind = "art"
    else
        local Icons_1 = u1.Assets.Icons
        local v49 = Icons_1[tbl_upv_6[(v46 and (v46.category)) or "melee"] or "Sword"]
        if v49 then
            renderImage(a1, a2, v49, u1.Theme.Colors.TextMuted, 0.4)
        end
        a2.kind = "glyph"
    end
end
function tbl_1.Set(a1, a2, a3)
    --[[
      name: Set
      line: 415
      upvalues:
        u5 (copy, index: 1)
        render (copy, index: 2)
    ]]
    local v50 = u5[a1]
    if v50 then
        if v50.id ~= a2 then
            if not (v50) then
                local tbl_16 = {opts = 0}
                tbl_16.id = a2
                tbl_16.opts = a3 or {}
                u5[a1] = tbl_16
                a1.Destroying:Connect(
                    function()
                        --[[
                          line: 423
                          upvalues:
                            u5 (copy, index: 1)
                            a1 (copy, index: 2)
                        ]]
                        local v51 = u5[a1]
                        if v51 and v51.spinConn then
                            v51.spinConn:Disconnect()
                        end
                        u5[a1] = nil
                    end
                )
                v50 = tbl_16
            end
        elseif v50.kind == nil then
            if not (v50) then
                local tbl_16 = {opts = 0}
                tbl_16.id = a2
                tbl_16.opts = a3 or {}
                u5[a1] = tbl_16
                a1.Destroying:Connect(
                    function()
                        --[[
                          line: 423
                          upvalues:
                            u5 (copy, index: 1)
                            a1 (copy, index: 2)
                        ]]
                        local v51 = u5[a1]
                        if v51 and v51.spinConn then
                            v51.spinConn:Disconnect()
                        end
                        u5[a1] = nil
                    end
                )
                v50 = tbl_16
            end
        elseif v50.kind == "glyph" then
            if not (v50) then
                local tbl_16 = {opts = 0}
                tbl_16.id = a2
                tbl_16.opts = a3 or {}
                u5[a1] = tbl_16
                a1.Destroying:Connect(
                    function()
                        --[[
                          line: 423
                          upvalues:
                            u5 (copy, index: 1)
                            a1 (copy, index: 2)
                        ]]
                        local v51 = u5[a1]
                        if v51 and v51.spinConn then
                            v51.spinConn:Disconnect()
                        end
                        u5[a1] = nil
                    end
                )
                v50 = tbl_16
            end
        else
            if v50.kind ~= "art" then
                return
            end
            if not (v50) then
                local tbl_16 = {opts = 0}
                tbl_16.id = a2
                tbl_16.opts = a3 or {}
                u5[a1] = tbl_16
                a1.Destroying:Connect(
                    function()
                        --[[
                          line: 423
                          upvalues:
                            u5 (copy, index: 1)
                            a1 (copy, index: 2)
                        ]]
                        local v51 = u5[a1]
                        if v51 and v51.spinConn then
                            v51.spinConn:Disconnect()
                        end
                        u5[a1] = nil
                    end
                )
                v50 = tbl_16
            end
        end
    elseif not (v50) then
        local tbl_16 = {opts = 0}
        tbl_16.id = a2
        tbl_16.opts = a3 or {}
        u5[a1] = tbl_16
        a1.Destroying:Connect(
            function()
                --[[
                  line: 423
                  upvalues:
                    u5 (copy, index: 1)
                    a1 (copy, index: 2)
                ]]
                local v51 = u5[a1]
                if v51 and v51.spinConn then
                    v51.spinConn:Disconnect()
                end
                u5[a1] = nil
            end
        )
        v50 = tbl_16
    end
    v50.id = a2
    v50.opts = a3 or (v50.opts or {})
    render(a1, v50)
end
function tbl_1.SetDim(a1, a2)
    --[[
      name: SetDim
      line: 437
      upvalues:
        u5 (copy, index: 1)
        u6 (copy, index: 2)
        u4 (copy, index: 3)
    ]]
    local v52 = u5[a1]
    if v52 then
        v52.dim = a2
    end
    local WeaponOutline_1 = a1:FindFirstChild("WeaponOutline")
    if WeaponOutline_1 and WeaponOutline_1:IsA("ViewportFrame") then
        local v53 = ((v52 and (v52.opts)) and (v52.opts.outlineColor)) or u6
        local v54
        if a2 then
            v54 = v53:Lerp(Color3.new(0, 0, 0), 0.4)
        else
            v54 = v53
        end
        WeaponOutline_1.ImageColor3 = v54
    end
    local WeaponIcon_1 = a1:FindFirstChild("WeaponIcon")
    if WeaponIcon_1 and WeaponIcon_1:IsA("ViewportFrame") then
        local v55
        if a2 then
            v55 = u4
        else
            v55 = Color3.new(1, 1, 1)
        end
        WeaponIcon_1.ImageColor3 = v55
        return
    end
    if not WeaponIcon_1 then
        return
    end
    if WeaponIcon_1:IsA("ImageLabel") then
        local v56 = WeaponIcon_1:GetAttribute("BaseColor")
        if typeof(v56) == "Color3" then
            v52 = v56
        else
            local ImageColor3_1 = WeaponIcon_1.ImageColor3
            WeaponIcon_1:SetAttribute("BaseColor", ImageColor3_1)
            v52 = ImageColor3_1
        end
        local v57
        if a2 then
            v57 = v52:Lerp(Color3.new(0, 0, 0), 0.45)
        else
            v57 = v52
        end
        WeaponIcon_1.ImageColor3 = v57
    end
end
function tbl_1.SetTransparency(a1, a2)
    --[[
      name: SetTransparency
      line: 460
    ]]
    local WeaponIcon_2 = a1:FindFirstChild("WeaponIcon")
    if not WeaponIcon_2 or not WeaponIcon_2:IsA("ViewportFrame") and not WeaponIcon_2:IsA("ImageLabel") then
        return
    end
    WeaponIcon_2.ImageTransparency = a2
end
function tbl_1.Init(a1, a2)
    --[[
      name: Init
      line: 467
      upvalues:
        u1 (ref,  index: 1)
        u2 (ref,  index: 2)
        tbl_upv_2 (copy, index: 3)
        u5 (copy, index: 4)
        render (copy, index: 5)
        u3 (ref,  index: 6)
        ReplicatedStorage_upv_1 (copy, index: 7)
        modelSource (copy, index: 8)
    ]]
    u1 = a1
    u2 = a2
    local function hook(a3)
        --[[
          name: hook
          line: 471
        ]]
        a3.ChildAdded:Connect(function() end)
    end
    local v58
    if (u3) and (u3.Parent) then
        v58 = u3
    else
        local Assets_4 = ReplicatedStorage_upv_1:FindFirstChild("Assets")
        local v59 = Assets_4 and (Assets_4:FindFirstChild("Weapons"))
        if v59 then
            u3 = v59
        end
        v58 = Assets_4
    end
    if v58 then
        v58.ChildAdded:Connect(function() end)
    else
        task.spawn(
            function()
                --[[
                  line: 485
                  upvalues:
                    ReplicatedStorage_upv_1 (copy, index: 1)
                    u3 (ref,  index: 2)
                    tbl_upv_2 (copy, index: 3)
                    u5 (copy, index: 4)
                    render (copy, index: 5)
                    modelSource (copy, index: 6)
                ]]
                local v60 = ReplicatedStorage_upv_1:WaitForChild("Assets", 30)
                if not v60 then
                    return
                end
                local v61 = v60:FindFirstChild("Weapons") or (v60:WaitForChild("Weapons", 120))
                if not v61 then
                    return
                end
                u3 = v61
                v61.ChildAdded:Connect(
                    function(a4)
                        --[[
                          line: 472
                          upvalues:
                            tbl_upv_2 (copy, index: 1)
                            u5 (copy, index: 2)
                            render (copy, index: 3)
                        ]]
                        tbl_upv_2[a4.Name] = nil
                        for key_2, value_8 in u5 do
                            if value_8.id ~= a4.Name then
                                continue
                            end
                            if value_8.kind ~= "model" then
                                task.defer(render, key_2, value_8)
                            end
                        end
                    end
                )
                for key_3, value_9 in u5 do
                    if value_9.kind == "model" then
                        continue
                    end
                    if modelSource(value_9.id or "") then
                        task.defer(render, key_3, value_9)
                    end
                end
            end
        )
    end
end
return tbl_1