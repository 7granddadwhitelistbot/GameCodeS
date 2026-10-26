local _ = game:GetService("Players")
local ContentProvider_upv_1 = game:GetService("ContentProvider")
local tbl_upv_1 = {}
local u1 = nil
local u2 = nil
local tbl_upv_2 = {}
local u3 = setmetatable({}, {__mode = "k"})
local u4 = setmetatable({}, {__mode = "k"})
local tbl_upv_3 = {UpperTorso = true, Torso = true, Head = true}
local function cloneOf(a1)
    --[[
      name: cloneOf
      line: 36
    ]]
    local success_1, v1 = pcall(function() end)
    if success_1 then
        return v1
    end
    return nil
end
local rerender = nil
local prepare = nil
local function stripPart(a1)
    --[[
      name: stripPart
      line: 47
    ]]
    a1.LocalTransparencyModifier = 0
    for _, value_1 in a1:GetDescendants() do
        if value_1:IsA("BasePart") or value_1:IsA("Decal") then
            value_1.LocalTransparencyModifier = 0
        end
    end
    for _, value_2 in a1:GetDescendants() do
        if value_2:IsA("JointInstance") or value_2:IsA("Constraint") or value_2:IsA("LuaSourceContainer") or value_2:IsA("Sound") or value_2:IsA("ParticleEmitter") or value_2:IsA("Light") or value_2:IsA("Trail") or value_2:IsA("Beam") or value_2:IsA("BillboardGui") or value_2:IsA("ProximityPrompt") or value_2:IsA("Highlight") then
            value_2:Destroy()
        end
    end
    a1.Anchored = true
    a1.CanCollide = false
    a1.CanQuery = false
    a1.CanTouch = false
end
local function capture(a1, a2)
    --[[
      name: capture
      line: 78
      upvalues:
        tbl_upv_3 (copy, index: 1)
        stripPart (copy, index: 2)
        tbl_upv_2 (copy, index: 3)
        prepare (ref,  index: 4)
        rerender (ref,  index: 5)
        u2 (ref,  index: 6)
        capture (ref,  index: 7)
    ]]
    local Head_1 = a2:FindFirstChild("Head")
    local v2 = a2:FindFirstChild("UpperTorso") or (a2:FindFirstChild("Torso"))
    if not Head_1 or not Head_1:IsA("BasePart") or not v2 or not v2:IsA("BasePart") or Head_1.Transparency >= 0.9 or v2.Transparency >= 0.9 then
        return nil
    end
    local v3 = Instance.new("Model")
    v3.Name = "Portrait"
    local v4 = v2.CFrame.LookVector
    local v5 = Vector3.new(v4.X, 0, v4.Z)
    local v6 = CFrame.lookAt(Head_1.Position, Head_1.Position + (((not (v5.Magnitude > 0.01)) and Vector3.new(0, 0, -1)) or (v5.Unit)))
    local v7 = nil
    for _, value_upv_3 in a2:GetChildren() do
        if not (value_upv_3:IsA("BasePart")) or not (tbl_upv_3[value_upv_3.Name]) then
            if value_upv_3:IsA("Accessory") or value_upv_3:IsA("Accoutrement") then
                local Handle_1 = value_upv_3:FindFirstChild("Handle")
                if not (Handle_1) or not (Handle_1:IsA("BasePart")) or not ((Handle_1.Position - v6.Position).Magnitude < 3.2) then
                    continue
                end
                local success_2, v8 = pcall(
                    function()
                        --[[
                          line: 37
                          upvalues:
                            value_upv_3 (copy, index: 1)
                        ]]
                        local Archivable_1 = value_upv_3.Archivable
                        value_upv_3.Archivable = true
                        local v9 = value_upv_3:Clone()
                        value_upv_3.Archivable = Archivable_1
                        return v9
                    end
                )
                if not (success_2) then
                    local v14 = nil
                end
                if not (v8) then
                    continue
                end
                local Handle_2 = v8:FindFirstChild("Handle")
                if Handle_2 then
                    stripPart(Handle_2)
                    Handle_2.CFrame = Handle_1.CFrame
                end
                v8.Parent = v3
            end
            if value_upv_3:IsA("Shirt") or value_upv_3:IsA("Pants") or value_upv_3:IsA("ShirtGraphic") or value_upv_3:IsA("BodyColors") or value_upv_3:IsA("CharacterMesh") then
                local success_3, v10 = pcall(function() end)
                if success_3 then
                    v7 = v10
                else
                    v7 = nil
                end
                if v7 then
                    v7.Parent = v3
                    continue
                end
            end
            continue
        end
        local success_4, v11 = pcall(function() end)
        if success_4 then
            v4 = v11
        else
            v4 = nil
        end
        if v4 then
            stripPart(v4)
            v4.CFrame = value_upv_3.CFrame
            v4.Parent = v3
        end
    end
    local v12 = Instance.new("Humanoid")
    v12.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
    v12.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
    v12.Parent = v3
    local tbl_upv_4 = {readyAt = 0, ready = false}
    tbl_upv_4.model = v3
    tbl_upv_4.head = v6
    tbl_upv_4.at = os.clock()
    tbl_upv_4.rig = a2
    local v13 = tbl_upv_2[a1]
    tbl_upv_2[a1] = tbl_upv_4
    if v13 then
        v13.model:Destroy()
    end
    prepare(a1, tbl_upv_4)
    if v13 then
        rerender(a1)
    else
        task.delay(
            2.5,
            function()
                --[[
                  line: 138
                  upvalues:
                    tbl_upv_2 (copy, index: 1)
                    a1 (copy, index: 2)
                    tbl_upv_4 (copy, index: 3)
                    u2 (ref,  index: 4)
                    a2 (copy, index: 5)
                    capture (ref,  index: 6)
                ]]
                if tbl_upv_2[a1] ~= tbl_upv_4 then
                    return
                end
                local v14 = u2.Find(a1) or a2
                if not v14 then
                    return
                end
                if v14.Parent then
                    capture(a1, v14)
                end
            end
        )
    end
    return tbl_upv_4
end
local function clearRender(a1)
    --[[
      name: clearRender
      line: 151
    ]]
    for _, value_4 in {"RigHead", "RigBack"} do
        local v15 = a1:FindFirstChild(value_4)
        if v15 then
            v15:Destroy()
        end
    end
end
local function silhouette(a1, a2)
    --[[
      name: silhouette
      line: 160
      upvalues:
        clearRender (copy, index: 1)
        u1 (ref,  index: 2)
    ]]
    if not (a2) then
        clearRender(a1)
    end
    local new_1 = u1.new
    local tbl_5 = {Name = 0, BackgroundTransparency = 0.2, Parent = 0, ZIndex = 0, BackgroundColor3 = 0, Size = 0}
    tbl_5.Name = (a2 and "RigBack") or "RigHead"
    tbl_5.Size = UDim2.fromScale(1, 1)
    tbl_5.BackgroundColor3 = Color3.fromRGB(44, 48, 60)
    tbl_5.ZIndex = a1.ZIndex
    tbl_5.Parent = a1
    local v16 = new_1("Frame", tbl_5)
    local v17 = a1:FindFirstChildOfClass("UICorner")
    if v17 then
        v17:Clone().Parent = v16
    end
    local v18 = u1.Icon("person", 0, Color3.fromRGB(110, 118, 136), {AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.fromScale(0.5, 1), ZIndex = a1.ZIndex, Parent = v16})
    v18.Size = UDim2.fromScale(0.72, 0.8)
end
local function watchCard(a1, a2, a3, a4)
    --[[
      name: watchCard
      line: 191
    ]]
    local _ = a3.CFrame
    task.spawn(function() end)
end
local function renderTemplate(a1, a2)
    --[[
      name: renderTemplate
      line: 221
      upvalues:
        clearRender (copy, index: 1)
        silhouette (copy, index: 2)
        u1 (ref,  index: 3)
    ]]
    clearRender(a1)
    silhouette(a1, true)
    local new_2 = u1.new
    local tbl_6 = {ImageColor3 = 0, Name = "RigHead", ImageTransparency = 0, Parent = 0}
    tbl_6.Size = UDim2.fromScale(1, 1)
    tbl_6.Ambient = Color3.fromRGB(150, 150, 150)
    tbl_6.LightColor = Color3.fromRGB(235, 232, 226)
    tbl_6.ZIndex = a1.ZIndex
    tbl_6.ImageColor3 = a1:GetAttribute("PortraitTint") or Color3.new(1, 1, 1)
    tbl_6.ImageTransparency = a1:GetAttribute("PortraitFade") or 0
    tbl_6.Parent = a1
    local u5 = new_2("ViewportFrame", tbl_6)
    local v20 = a1:FindFirstChildOfClass("UICorner")
    if v20 then
        v20:Clone().Parent = u5
    end
    a2.model:Clone().Parent = u5
    local head_1 = a2.head
    local v21 = head_1.Position - head_1.UpVector * 0.15
    local v22 = (head_1.Position + (head_1.LookVector * 3.9)) + (head_1.RightVector * 0.8) + head_1.UpVector * 0.35
    local u6 = Instance.new("Camera")
    u6.FieldOfView = 30
    u6.CFrame = CFrame.lookAt(v22, v21)
    u6.Parent = u5
    u5.CurrentCamera = u6
    u5.LightDirection = (v21 - v22).Unit + Vector3.new(0, -0.6000000238418579, 0)
    local CFrame_upv_1 = u6.CFrame
    task.spawn(
        function()
            --[[
              line: 193
              upvalues:
                u5 (copy, index: 1)
                a1 (copy, index: 2)
                u6 (copy, index: 3)
                CFrame_upv_1 (copy, index: 4)
                a2 (copy, index: 5)
            ]]
            local v23 = os.clock()
            local v24 = 0
            while u5.Parent == a1 and u6.Parent == u5 do
                v24 = v24 + 1
                u6.CFrame = CFrame_upv_1 * CFrame.new(0, 0, ((v24 % 2 ~= 0) and 4e-04) or 0)
                if not (a2.ready) or not (os.clock() - a2.readyAt > 0.5) or not (os.clock() - v23 > 0.5) then
                    if not (os.clock() - v23 > 15) then
                        task.wait(0.2)
                        continue
                    end
                    return
                end
                local RigBack_1 = a1:FindFirstChild("RigBack")
                if RigBack_1 then
                    RigBack_1:Destroy()
                end
                for n_1 = 1, 4 do
                    task.wait(0.5)
                    if u5.Parent == a1 then
                        u6.CFrame = CFrame_upv_1 * CFrame.new(0, 0, ((n_1 % 2 ~= 0) and 4e-04) or 0)
                    end
                end
                return
            end
        end
    )
end
rerender = function(a1)
    --[[
      name: rerender
      line: 255
      upvalues:
        tbl_upv_2 (copy, index: 1)
        u4 (copy, index: 2)
        renderTemplate (ref,  index: 3)
    ]]
    local v25 = tbl_upv_2[a1]
    if not v25 then
        return
    end
    for key_1, value_5 in u4 do
        if value_5 ~= "rig:" .. a1 then
            continue
        end
        if key_1.Parent then
            renderTemplate(key_1, v25)
        end
    end
end
local tbl_upv_7 = {}
tbl_upv_7[Enum.AssetFetchStatus.Success] = true
tbl_upv_7[Enum.AssetFetchStatus.Failure] = true
tbl_upv_7[Enum.AssetFetchStatus.TimedOut] = true
local function contentIds(a1)
    --[[
      name: contentIds
      line: 268
    ]]
    local tbl_upv_8 = {}
    local tbl_upv_9 = {}
    local function add_1(a2)
        --[[
          name: add
          line: 271
          upvalues:
            tbl_upv_8 (copy, index: 1)
            tbl_upv_9 (copy, index: 2)
        ]]
        if type(a2) ~= "string" or a2 == "" or (tbl_upv_8[a2]) then
            return
        end
        tbl_upv_8[a2] = true
        table.insert(tbl_upv_9, a2)
    end
    for _, value_upv_6 in a1:GetDescendants() do
        pcall(
            function()
                --[[
                  line: 278
                  upvalues:
                    value_upv_6 (copy, index: 1)
                    tbl_upv_8 (copy, index: 2)
                    tbl_upv_9 (copy, index: 3)
                ]]
                local v26, v27 = nil, nil
                if value_upv_6:IsA("MeshPart") then
                    v26 = value_upv_6.MeshId
                    if type(v26) == "string" and v26 ~= "" and not (tbl_upv_8[v26]) then
                        tbl_upv_8[v26] = true
                        table.insert(tbl_upv_9, v26)
                    end
                    v27 = value_upv_6.TextureID
                    if type(v27) ~= "string" or v27 == "" or (tbl_upv_8[v27]) then
                        return
                    end
                    tbl_upv_8[v27] = true
                    table.insert(tbl_upv_9, v27)
                else
                    local v28, v29 = nil, nil
                    if value_upv_6:IsA("SpecialMesh") then
                        v28 = value_upv_6.MeshId
                        if type(v28) == "string" and v28 ~= "" and not (tbl_upv_8[v28]) then
                            tbl_upv_8[v28] = true
                            table.insert(tbl_upv_9, v28)
                        end
                        v29 = value_upv_6.TextureId
                        if type(v29) ~= "string" or v29 == "" or (tbl_upv_8[v29]) then
                            return
                        end
                        tbl_upv_8[v29] = true
                        table.insert(tbl_upv_9, v29)
                    else
                        local v30 = nil
                        if value_upv_6:IsA("Decal") then
                            v30 = value_upv_6.Texture
                            if type(v30) ~= "string" or v30 == "" or (tbl_upv_8[v30]) then
                                return
                            end
                            tbl_upv_8[v30] = true
                            table.insert(tbl_upv_9, v30)
                        else
                            local v31 = nil
                            if value_upv_6:IsA("Shirt") then
                                v31 = value_upv_6.ShirtTemplate
                                if type(v31) ~= "string" or v31 == "" or (tbl_upv_8[v31]) then
                                    return
                                end
                                tbl_upv_8[v31] = true
                                table.insert(tbl_upv_9, v31)
                            else
                                local v32 = nil
                                if value_upv_6:IsA("Pants") then
                                    v32 = value_upv_6.PantsTemplate
                                    if type(v32) ~= "string" or v32 == "" or (tbl_upv_8[v32]) then
                                        return
                                    end
                                    tbl_upv_8[v32] = true
                                    table.insert(tbl_upv_9, v32)
                                elseif value_upv_6:IsA("ShirtGraphic") then
                                    local Graphic_1 = value_upv_6.Graphic
                                    if type(Graphic_1) ~= "string" or Graphic_1 == "" or (tbl_upv_8[Graphic_1]) then
                                        return
                                    end
                                    tbl_upv_8[Graphic_1] = true
                                    table.insert(tbl_upv_9, Graphic_1)
                                end
                            end
                        end
                    end
                end
            end
        )
    end
    return tbl_upv_9
end
prepare = function(a1, a2)
    --[[
      name: prepare
      line: 302
      upvalues:
        contentIds (copy, index: 1)
        ContentProvider_upv_1 (copy, index: 2)
        tbl_upv_7 (copy, index: 3)
    ]]
    task.spawn(
        function()
            --[[
              line: 303
              upvalues:
                contentIds (copy, index: 1)
                a2 (copy, index: 2)
                ContentProvider_upv_1 (copy, index: 3)
                tbl_upv_7 (copy, index: 4)
            ]]
            local u7 = contentIds(a2.model)
            if #u7 > 0 then
                task.spawn(
                    function()
                        --[[
                          line: 306
                          upvalues:
                            ContentProvider_upv_1 (copy, index: 1)
                            u7 (copy, index: 2)
                        ]]
                        pcall(
                            function()
                                --[[
                                  line: 307
                                  upvalues:
                                    ContentProvider_upv_1 (copy, index: 1)
                                    u7 (copy, index: 2)
                                ]]
                                ContentProvider_upv_1:PreloadAsync(u7)
                            end
                        )
                    end
                )
                local v33 = os.clock()
                local v34 = nil
                while os.clock() - v33 < 8 do
                    v34 = true
                    for _, value_upv_7 in u7 do
                        local success_5, v35 = pcall(
                            function()
                                --[[
                                  line: 315
                                  upvalues:
                                    ContentProvider_upv_1 (copy, index: 1)
                                    value_upv_7 (copy, index: 2)
                                ]]
                                return ContentProvider_upv_1:GetAssetFetchStatus(value_upv_7)
                            end
                        )
                        if not (success_5) then
                            continue
                        end
                        if not (tbl_upv_7[v35]) then
                            v34 = false
                            break
                        end
                    end
                    if v34 then
                        break
                    else
                        task.wait(0.15)
                    end
                end
            end
            a2.ready = true
            a2.readyAt = os.clock()
        end
    )
end
function tbl_upv_1.SetTint(a1, a2, a3)
    --[[
      name: SetTint
      line: 335
    ]]
    a1:SetAttribute("PortraitTint", a2)
    a1:SetAttribute("PortraitFade", a3)
    a1.ImageColor3 = a2
    a1.ImageTransparency = a3
    local RigHead_1 = a1:FindFirstChild("RigHead")
    if not RigHead_1 or not RigHead_1:IsA("ViewportFrame") then
        return
    end
    RigHead_1.ImageColor3 = a2
    RigHead_1.ImageTransparency = a3
end
function tbl_upv_1.ThumbFor(a1, a2)
    --[[
      name: ThumbFor
      line: 348
      upvalues:
        u2 (ref, index: 1)
    ]]
    local v36
    if type(a1) ~= "table" then
        v36 = a1
    else
        v36 = a1.userId
    end
    if u2.IsRealUserId(v36) or u2.TrustAllUserIds and type(v36) == "number" and v36 > 0 then
        local v37 = a2 or 150
        local v38 = ((v37 <= 48) and 48) or (((v37 <= 60) and 60) or (((v37 <= 150) and 150) or 420))
        return string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=%d&h=%d", v36, v38, v38)
    end
    return ""
end
function tbl_upv_1.ImageFor(a1, a2)
    --[[
      name: ImageFor
      line: 359
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    return tbl_upv_1.ThumbFor(a1, a2)
end
function tbl_upv_1.Apply(a1, a2, a3)
    --[[
      name: Apply
      line: 364
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u4 (copy, index: 2)
        u3 (copy, index: 3)
        clearRender (copy, index: 4)
        silhouette (copy, index: 5)
        tbl_upv_2 (copy, index: 6)
        u2 (ref,  index: 7)
        capture (ref,  index: 8)
        renderTemplate (ref,  index: 9)
    ]]
    local v39 = tbl_upv_1.ThumbFor(a2, a3)
    local v40 = ((type(a2) == "table") and (a2.id)) or nil
    local v41
    if v39 == "" then
        v41 = "rig:" .. tostring(v40)
    else
        v41 = v39
    end
    if u4[a1] == v41 then
        if v39 ~= "" then
            return
        end
        local RigHead_2 = a1:FindFirstChild("RigHead")
        if RigHead_2 and not (u3[a1]) then
            return
        end
    end
    u4[a1] = v41
    u3[a1] = nil
    a1.ScaleType = Enum.ScaleType.Crop
    if v39 == "" then
        a1.Image = ""
        if type(v40) == "string" then
            v41 = tbl_upv_2[v40]
            local v42 = nil
            if not v41 then
                v42 = u2.Find(v40)
                v41 = v42 and capture(v40, v42)
            end
            if v41 then
                renderTemplate(a1, v41)
            else
                silhouette(a1)
                u3[a1] = a2
            end
        else
            silhouette(a1)
        end
    else
        clearRender(a1)
        a1.Image = v39
    end
end
function tbl_upv_1.Reset()
    --[[
      name: Reset
      line: 406
      upvalues:
        tbl_upv_2 (copy, index: 1)
        u4 (copy, index: 2)
    ]]
    for _, value_8 in tbl_upv_2 do
        value_8.model:Destroy()
    end
    table.clear(tbl_upv_2)
    local tbl_10 = {}
    for key_2, value_9 in u4 do
        if string.sub(value_9, 1, 4) == "rig:" then
            table.insert(tbl_10, key_2)
        end
    end
    for _, value_10 in tbl_10 do
        u4[value_10] = nil
    end
end
function tbl_upv_1.Init(a1, a2)
    --[[
      name: Init
      line: 423
      upvalues:
        u1 (ref,  index: 1)
        u2 (ref,  index: 2)
        u3 (copy, index: 3)
        tbl_upv_1 (copy, index: 4)
        tbl_upv_2 (copy, index: 5)
        capture (ref,  index: 6)
        u4 (copy, index: 7)
    ]]
    u1 = a1
    u2 = a2
    task.spawn(
        function()
            --[[
              line: 427
              upvalues:
                u3 (copy, index: 1)
                tbl_upv_1 (copy, index: 2)
            ]]
            repeat
                task.wait(1)
            until next(u3)
            local tbl_11 = {}
            for key_3, value_11 in u3 do
                table.insert(tbl_11, {key_3, value_11})
            end
            for _, value_12 in tbl_11 do
                if value_12[1].Parent then
                    tbl_upv_1.Apply(value_12[1], value_12[2])
                else
                    u3[value_12[1]] = nil
                end
            end
        end
    )
    u2.Added:Connect(
        function(a3, a4)
            --[[
              line: 446
              upvalues:
                tbl_upv_2 (copy, index: 1)
                capture (ref,  index: 2)
                u3 (copy, index: 3)
                u4 (copy, index: 4)
                tbl_upv_1 (copy, index: 5)
            ]]
            local u8 = tbl_upv_2[a3]
            if u8 and u8.rig ~= a4 then
                task.delay(
                    0.6,
                    function()
                        --[[
                          line: 450
                          upvalues:
                            tbl_upv_2 (copy, index: 1)
                            a3 (copy, index: 2)
                            u8 (copy, index: 3)
                            a4 (copy, index: 4)
                            capture (ref,  index: 5)
                        ]]
                        if tbl_upv_2[a3] ~= u8 or not a4.Parent then
                            return
                        end
                        capture(a3, a4)
                    end
                )
            end
            local v43 = false
            for _, value_13 in u3 do
                if type(value_13) ~= "table" then
                    continue
                end
                if value_13.id == a3 then
                    v43 = true
                    break
                end
            end
            if not v43 then
                return
            end
            task.delay(
                0.4,
                function()
                    --[[
                      line: 467
                      upvalues:
                        tbl_upv_2 (copy, index: 1)
                        a3 (copy, index: 2)
                        a4 (copy, index: 3)
                        capture (ref,  index: 4)
                        u3 (copy, index: 5)
                        u4 (copy, index: 6)
                        tbl_upv_1 (copy, index: 7)
                    ]]
                    if not (tbl_upv_2[a3]) and a4.Parent then
                        capture(a3, a4)
                    end
                    local tbl_12 = {}
                    for key_4, value_14 in u3 do
                        if type(value_14) ~= "table" or value_14.id ~= a3 then
                            continue
                        end
                        if key_4.Parent then
                            table.insert(tbl_12, {key_4, value_14})
                        end
                    end
                    for _, value_15 in tbl_12 do
                        u3[value_15[1]] = nil
                        u4[value_15[1]] = nil
                        tbl_upv_1.Apply(value_15[1], value_15[2])
                    end
                end
            )
        end
    )
end
return tbl_upv_1