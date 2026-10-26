local Players_upv_1 = game:GetService("Players")
local u1 = require(script.Parent.Parent:WaitForChild("CommonUtils")).get("FlagUtil").getUserFlag("UserRaycastUpdateAPI2")
local tbl_upv_1 = {CIRCLE1 = 5, CHAR_OUTLINE = 9, MOVEMENT = 3, CORNERS = 4, LIMBS = 2, SMART_CIRCLE = 8, LIMBMOVE = 7, CIRCLE2 = 6}
local tbl_upv_2 = {}
tbl_upv_2.Head = true
tbl_upv_2["Left Arm"] = true
tbl_upv_2["Right Arm"] = true
tbl_upv_2["Left Leg"] = true
tbl_upv_2["Right Leg"] = true
tbl_upv_2.LeftLowerArm = true
tbl_upv_2.RightLowerArm = true
tbl_upv_2.LeftUpperLeg = true
tbl_upv_2.RightUpperLeg = true
local tbl_upv_3 = {Vector3.new(1, 1, -1), Vector3.new(1, -1, -1), Vector3.new(-1, -1, -1), Vector3.new(-1, 1, -1)}
local u2 = RaycastParams.new()
u2.FilterType = Enum.RaycastFilterType.Exclude
local u3 = RaycastParams.new()
u3.FilterType = Enum.RaycastFilterType.Include
local function Det3x3(a1, a2, a3, a4, a5, a6, a7, a8, a9)
    --[[
      name: Det3x3
      line: 83
    ]]
    return ((a1 * ((a5 * a9) - (a6 * a8))) - (a2 * ((a4 * a9) - (a6 * a7)))) + (a3 * ((a4 * a8) - (a5 * a7)))
end
local BaseOcclusion_upv_1 = require(script.Parent:WaitForChild("BaseOcclusion"))
local u4 = setmetatable({}, BaseOcclusion_upv_1)
u4.__index = u4
function u4.new()
    --[[
      name: new
      line: 124
      upvalues:
        BaseOcclusion_upv_1 (copy, index: 1)
        u4 (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
    ]]
    local v1 = setmetatable(BaseOcclusion_upv_1.new(), u4)
    v1.char = nil
    v1.humanoidRootPart = nil
    v1.torsoPart = nil
    v1.headPart = nil
    v1.childAddedConn = nil
    v1.childRemovedConn = nil
    v1.behaviors = {}
    v1.behaviors[tbl_upv_1.LIMBS] = v1.LimbBehavior
    v1.behaviors[tbl_upv_1.MOVEMENT] = v1.MoveBehavior
    v1.behaviors[tbl_upv_1.CORNERS] = v1.CornerBehavior
    v1.behaviors[tbl_upv_1.CIRCLE1] = v1.CircleBehavior
    v1.behaviors[tbl_upv_1.CIRCLE2] = v1.CircleBehavior
    v1.behaviors[tbl_upv_1.LIMBMOVE] = v1.LimbMoveBehavior
    v1.behaviors[tbl_upv_1.SMART_CIRCLE] = v1.SmartCircleBehavior
    v1.behaviors[tbl_upv_1.CHAR_OUTLINE] = v1.CharacterOutlineBehavior
    v1.mode = tbl_upv_1.SMART_CIRCLE
    v1.behaviorFunction = v1.SmartCircleBehavior
    v1.savedHits = {}
    v1.trackedLimbs = {}
    v1.camera = game.Workspace.CurrentCamera
    v1.enabled = false
    return v1
end
function u4.Enable(a1, a2)
    --[[
      name: Enable
      line: 157
    ]]
    a1.enabled = a2
    if (a2) then
        return
    end
    a1:Cleanup()
end
function u4.GetOcclusionMode(a1)
    --[[
      name: GetOcclusionMode
      line: 165
    ]]
    return Enum.DevCameraOcclusionMode.Invisicam
end
function u4.LimbBehavior(a1, a2)
    --[[
      name: LimbBehavior
      line: 170
    ]]
    for key_1, _ in pairs(a1.trackedLimbs) do
        a2[#a2 + 1] = key_1.Position
    end
end
function u4.MoveBehavior(a1, a2)
    --[[
      name: MoveBehavior
      line: 176
    ]]
    for n_1 = 1, 3 do
        local Velocity_1 = a1.humanoidRootPart.Velocity
        a2[#a2 + 1] = a1.humanoidRootPart.Position + (((n_1 - 1) * a1.humanoidRootPart.CFrame.lookVector) * (Vector3.new(Velocity_1.X, 0, Velocity_1.Z).Magnitude / 2))
    end
end
function u4.CornerBehavior(a1, a2)
    --[[
      name: CornerBehavior
      line: 185
      upvalues:
        tbl_upv_3 (copy, index: 1)
    ]]
    local CFrame_1 = a1.humanoidRootPart.CFrame
    local Position_1 = CFrame_1.Position
    local v2 = a1.char:GetExtentsSize() / 2
    a2[#a2 + 1] = Position_1
    for n_2 = 1, #tbl_upv_3 do
        a2[#a2 + 1] = Position_1 + ((CFrame_1 - Position_1) * (v2 * tbl_upv_3[n_2]))
    end
end
function u4.CircleBehavior(a1, a2)
    --[[
      name: CircleBehavior
      line: 196
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v3
    if a1.mode ~= tbl_upv_1.CIRCLE1 then
        local _ = a1.camera.CoordinateFrame
        v3 = a1.camera.CoordinateFrame - a1.camera.CoordinateFrame.Position + a1.humanoidRootPart.Position
    else
        v3 = a1.humanoidRootPart.CFrame
    end
    a2[#a2 + 1] = v3.Position
    for n_3 = 0, 9 do
        local v4 = 0.6283185307179586 * n_3
        a2[#a2 + 1] = v3 * (Vector3.new(math.cos(v4), math.sin(v4), 0) * 3)
    end
end
function u4.LimbMoveBehavior(a1, a2)
    --[[
      name: LimbMoveBehavior
      line: 212
    ]]
    a1:LimbBehavior(a2)
    a1:MoveBehavior(a2)
end
function u4.CharacterOutlineBehavior(a1, a2)
    --[[
      name: CharacterOutlineBehavior
      line: 217
      upvalues:
        u1 (copy, index: 1)
        u3 (copy, index: 2)
    ]]
    local unit_1 = a1.torsoPart.CFrame.upVector.unit
    local unit_2 = a1.torsoPart.CFrame.rightVector.unit
    a2[#a2 + 1] = a1.torsoPart.CFrame.Position
    a2[#a2 + 1] = a1.torsoPart.CFrame.Position + unit_1
    a2[#a2 + 1] = a1.torsoPart.CFrame.Position - unit_1
    a2[#a2 + 1] = a1.torsoPart.CFrame.Position + unit_2
    a2[#a2 + 1] = a1.torsoPart.CFrame.Position - unit_2
    if a1.headPart then
        a2[#a2 + 1] = a1.headPart.CFrame.Position
    end
    local v5 = CFrame.new(Vector3.new(0, 0, 0), Vector3.new(a1.camera.CoordinateFrame.lookVector.X, 0, a1.camera.CoordinateFrame.lookVector.Z))
    local v6 = ((a1.torsoPart) and (a1.torsoPart.Position)) or (a1.humanoidRootPart.Position)
    local tbl_4 = {a1.torsoPart}
    if a1.headPart then
        tbl_4[#tbl_4 + 1] = a1.headPart
    end
    for n_4 = 1, 24 do
        local v7 = math.tau * n_4 / 24
        local v8 = v5 * (Vector3.new(math.cos(v7), math.sin(v7), 0) * 3)
        local v9 = Vector3.new(v8.X, math.max(v8.Y, -2.25), v8.Z)
        if u1 then
            u3.FilterDescendantsInstances = tbl_4
            local v10 = game.Workspace:Raycast(v6 + v9, -3 * v9, u3)
            if v10 then
                local Position_2 = v10.Position
                a2[#a2 + 1] = Position_2 + (0.2 * (v6 - Position_2).unit)
            end
        else
            local v11, v12 = game.Workspace:FindPartOnRayWithWhitelist(Ray.new(v6 + v9, -3 * v9), tbl_4, false)
            if v11 then
                a2[#a2 + 1] = v12 + (0.2 * (v6 - v12).unit)
            end
        end
    end
end
local function RayIntersection(a1, a2, a3, a4)
    --[[
      name: RayIntersection
      line: 91
    ]]
    local v13 = a2:Cross(a4)
    local v14 = a3.X - a1.X
    local v15 = a3.Y - a1.Y
    local v16 = a3.Z - a1.Z
    local Y_1 = a2.Y
    local v17 = -a4.Y
    local Y_2 = v13.Y
    local Z_1 = a2.Z
    local v18 = -a4.Z
    local Z_2 = v13.Z
    local v19 = (a2.X * ((v17 * Z_2) - (Y_2 * v18))) - (-a4.X * ((Y_1 * Z_2) - (Y_2 * Z_1))) + v13.X * ((Y_1 * v18) - (v17 * Z_1))
    if v19 == 0 then
        return Vector3.new(0, 0, 0)
    end
    local v20 = -a4.Y
    local Y_3 = v13.Y
    local v21 = -a4.Z
    local Z_3 = v13.Z
    local Y_4 = a2.Y
    local Y_5 = v13.Y
    local Z_4 = a2.Z
    local Z_5 = v13.Z
    v19 = a1 + ((((v14 * ((v20 * Z_3) - (Y_3 * v21))) - (-a4.X * ((v15 * Z_3) - (Y_3 * v16)))) + (v13.X * ((v15 * v21) - (v20 * v16)))) / v19) * a2
    local v22 = a3 + ((((a2.X * ((v15 * Z_5) - (Y_5 * v16))) - (v14 * ((Y_4 * Z_5) - (Y_5 * Z_4)))) + (v13.X * ((Y_4 * v16) - (v15 * Z_4)))) / v19) * a4
    if (v22 - v19).Magnitude < 0.25 then
        return v19 + ((v22 - v19) * 0.5)
    end
    return Vector3.new(0, 0, 0)
end
function u4.SmartCircleBehavior(a1, a2)
    --[[
      name: SmartCircleBehavior
      line: 268
      upvalues:
        u1 (copy, index: 1)
        u2 (copy, index: 2)
        RayIntersection (copy, index: 3)
    ]]
    local unit_3 = a1.torsoPart.CFrame.upVector.unit
    local unit_4 = a1.torsoPart.CFrame.rightVector.unit
    a2[#a2 + 1] = a1.torsoPart.CFrame.Position
    a2[#a2 + 1] = a1.torsoPart.CFrame.Position + unit_3
    a2[#a2 + 1] = a1.torsoPart.CFrame.Position - unit_3
    a2[#a2 + 1] = a1.torsoPart.CFrame.Position + unit_4
    a2[#a2 + 1] = a1.torsoPart.CFrame.Position - unit_4
    if a1.headPart then
        a2[#a2 + 1] = a1.headPart.CFrame.Position
    end
    local v23 = Vector3.new(0, 0.5, 0) + (((a1.torsoPart) and (a1.torsoPart.Position)) or (a1.humanoidRootPart.Position))
    local v24, v24, v25, v25 = nil, nil, nil, nil
    for n_5 = 1, 24 do
        local v26 = 0.2617993877991494 * n_5 - 1.5707963267948966
        local v27 = v23 + (a1.camera.CFrame - a1.camera.CFrame.Position) * (Vector3.new(math.cos(v26), math.sin(v26), 0) * 2.5)
        local v28 = v27 - a1.camera.CFrame.Position
        if u1 then
            u2.FilterDescendantsInstances = {a1.char}
            local v29 = game.Workspace:Raycast(v23, v27 - v23, u2)
            if not (v29) then
                a2[#a2 + 1] = v24
                continue
            end
            local Normal_1 = v29.Normal
            local v30 = v29.Position + 0.1 * Normal_1.unit
            local v31 = v30 - v23
            local unit_5 = v31:Cross(v28).unit:Cross(Normal_1).unit
            if not (v31.unit:Dot(-unit_5) < v31.unit:Dot((v30 - a1.camera.CFrame.Position).unit)) then
                v24 = v30
                local v32 = game.Workspace:Raycast(v23, v24 - v23, u2)
                v24 = (v32 and (v32.Position - (0.1 * (v24 - v23).unit))) or v24
                a2[#a2 + 1] = v24
                continue
            end
            v24 = RayIntersection(v30, unit_5, v27, v28)
            if v24.Magnitude > 0 then
                local v33 = game.Workspace:Raycast(v30, v24 - v30, u2)
                v24 = (v33 and (v33.Position + (0.1 * v33.Normal.Unit))) or v24
            else
                v24 = v30
            end
            local v32 = game.Workspace:Raycast(v23, v24 - v23, u2)
            v24 = (v32 and (v32.Position - (0.1 * (v24 - v23).unit))) or v24
            a2[#a2 + 1] = v24
        else
            local v34, v35, v36 = game.Workspace:FindPartOnRayWithIgnoreList(Ray.new(v23, v27 - v23), {a1.char}, false, false)
            if not (v34) then
                a2[#a2 + 1] = v25
                continue
            end
            local v37 = v35 + 0.1 * v36.unit
            local v38 = v37 - v23
            local unit_6 = v38:Cross(v28).unit:Cross(v36).unit
            if not (v38.unit:Dot(-unit_6) < v38.unit:Dot((v37 - a1.camera.CFrame.Position).unit)) then
                v25 = v37
                local v39, v40 = game.Workspace:FindPartOnRayWithIgnoreList(Ray.new(v23, v25 - v23), {a1.char}, false, false)
                v25 = (v39 and (v40 - (0.1 * (v25 - v23).unit))) or v25
                a2[#a2 + 1] = v25
                continue
            end
            v25 = RayIntersection(v37, unit_6, v27, v28)
            if v25.Magnitude > 0 then
                local v41, v42 = nil, nil
                local v43, v41, v42 = game.Workspace:FindPartOnRayWithIgnoreList(Ray.new(v37, v25 - v37), {a1.char}, false, false)
                v25 = (v43 and (v41 + (0.1 * v42.unit))) or v25
            else
                v25 = v37
            end
            local v39, v40 = game.Workspace:FindPartOnRayWithIgnoreList(Ray.new(v23, v25 - v23), {a1.char}, false, false)
            v25 = (v39 and (v40 - (0.1 * (v25 - v23).unit))) or v25
            a2[#a2 + 1] = v25
        end
    end
end
function u4.CheckTorsoReference(a1)
    --[[
      name: CheckTorsoReference
      line: 403
    ]]
    if not a1.char then
        return
    end
    a1.torsoPart = a1.char:FindFirstChild("Torso")
    if not (a1.torsoPart) then
        a1.torsoPart = a1.char:FindFirstChild("UpperTorso")
        if not (a1.torsoPart) then
            a1.torsoPart = a1.char:FindFirstChild("HumanoidRootPart")
        end
    end
    a1.headPart = a1.char:FindFirstChild("Head")
end
function u4.CharacterAdded(a1, a2, a3)
    --[[
      name: CharacterAdded
      line: 417
      upvalues:
        Players_upv_1 (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
    ]]
    if a3 ~= Players_upv_1.LocalPlayer then
        return
    end
    if a1.childAddedConn then
        a1.childAddedConn:Disconnect()
        a1.childAddedConn = nil
    end
    if a1.childRemovedConn then
        a1.childRemovedConn:Disconnect()
        a1.childRemovedConn = nil
    end
    a1.char = a2
    a1.trackedLimbs = {}
    local function childRemoved(a4)
        --[[
          name: childRemoved
          line: 449
          upvalues:
            a1 (copy, index: 1)
        ]]
        a1.trackedLimbs[a4] = nil
        a1:CheckTorsoReference()
    end
    local function childAdded(a5)
        --[[
          name: childAdded
          line: 433
          upvalues:
            tbl_upv_2 (copy, index: 1)
            a1 (copy, index: 2)
        ]]
        if not a5:IsA("BasePart") then
            return
        end
        if tbl_upv_2[a5.Name] then
            a1.trackedLimbs[a5] = true
        end
        if a5.Name == "Torso" or a5.Name == "UpperTorso" then
            a1.torsoPart = a5
        end
        if a5.Name ~= "Head" then
            return
        end
        a1.headPart = a5
    end
    a1.childAddedConn = a2.ChildAdded:Connect(childAdded)
    a1.childRemovedConn = a2.ChildRemoved:Connect(childRemoved)
    for _, value_1 in pairs(a1.char:GetChildren()) do
        if not (value_1:IsA("BasePart")) then
            continue
        end
        if tbl_upv_2[value_1.Name] then
            a1.trackedLimbs[value_1] = true
        end
        if value_1.Name == "Torso" or value_1.Name == "UpperTorso" then
            a1.torsoPart = value_1
        end
        if value_1.Name == "Head" then
            a1.headPart = value_1
        end
    end
end
local function AssertTypes(a1, ...)
    --[[
      name: AssertTypes
      line: 71
    ]]
    local tbl_5 = {}
    local v44 = ""
    for _, value_2 in pairs({...}) do
        tbl_5[value_2] = true
        v44 = v44 .. (((v44 ~= "") and " or ") or "") .. value_2
    end
    local ty_1 = type(a1)
    assert(tbl_5[ty_1], v44 .. " type expected, got: " .. ty_1)
end
function u4.SetMode(a1, a2)
    --[[
      name: SetMode
      line: 463
      upvalues:
        AssertTypes (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    AssertTypes(a2, "number")
    for _, value_3 in pairs(tbl_upv_1) do
        if value_3 ~= a2 then
            continue
        end
        a1.mode = a2
        a1.behaviorFunction = a1.behaviors[a1.mode]
        return
    end
    error("Invalid mode number")
end
function u4.GetObscuredParts(a1)
    --[[
      name: GetObscuredParts
      line: 475
    ]]
    return a1.savedHits
end
function u4.Cleanup(a1)
    --[[
      name: Cleanup
      line: 480
    ]]
    for key_2, value_4 in pairs(a1.savedHits) do
        key_2.LocalTransparencyModifier = value_4
    end
end
function u4.Update(a1, a2, a3, a4)
    --[[
      name: Update
      line: 486
    ]]
    if not a1.enabled or not a1.char then
        return a3, a4
    end
    a1.camera = game.Workspace.CurrentCamera
    local v45 = nil
    if not (a1.humanoidRootPart) then
        v45 = a1.char:FindFirstChildOfClass("Humanoid")
        if v45 and v45.RootPart then
            a1.humanoidRootPart = v45.RootPart
        else
            a1.humanoidRootPart = a1.char:FindFirstChild("HumanoidRootPart")
            if not (a1.humanoidRootPart) then
                return a3, a4
            end
        end
        local u5 = nil
        local v46 = a1.humanoidRootPart.AncestryChanged:Connect(
            function(a5, a6)
                --[[
                  line: 511
                  upvalues:
                    a1 (copy, index: 1)
                    u5 (ref,  index: 2)
                ]]
                if a5 ~= a1.humanoidRootPart or (a6) then
                    return
                end
                a1.humanoidRootPart = nil
                if not u5 or not u5.Connected then
                    return
                end
                u5:Disconnect()
                u5 = nil
            end
        )
        u5 = v46
    end
    if not (a1.torsoPart) then
        a1:CheckTorsoReference()
        if not (a1.torsoPart) then
            return a3, a4
        end
    end
    local tbl_6 = {}
    a1.behaviorFunction(a1, tbl_6)
    local tbl_upv_7 = {}
    local tbl_8 = {a1.char}
    local function add(a7)
        --[[
          name: add
          line: 537
          upvalues:
            tbl_upv_7 (copy, index: 1)
            a1 (copy, index: 2)
        ]]
        tbl_upv_7[a7] = true
        if (a1.savedHits[a7]) then
            return
        end
        a1.savedHits[a7] = a7.LocalTransparencyModifier
    end
    local v47 = 0
    local tbl_9 = {}
    local v48 = 0.75
    local v49 = 0.75
    local v50 = (a1.headPart and (a1.headPart.CFrame.Position)) or (tbl_6[1])
    local v51 = a1.camera:GetPartsObscuringTarget({v50, ((a1.torsoPart) and (a1.torsoPart.CFrame.Position)) or (tbl_6[2])}, tbl_8)
    local tbl_10 = v47
    for n_6 = 1, #v51 do
        local v52 = v51[n_6]
        tbl_10 = tbl_10 + 1
        tbl_9[v52] = true
        for _, value_5 in pairs(v52:GetChildren()) do
            local v53 = value_5:IsA("Decal")
            if v53 then
                tbl_10 = tbl_10 + 1
            end
        end
        local v54 = value_5:IsA("Texture")
        if v54 then
            tbl_10 = tbl_10 + 1
        end
    end
    if tbl_10 > 0 then
        v48, v49 = math.pow((0.375 / tbl_10) + 0.375, 1 / tbl_10), math.pow((0.25 / tbl_10) + 0.25, 1 / tbl_10)
    end
    local v55 = a1.camera:GetPartsObscuringTarget(tbl_6, tbl_8)
    tbl_10 = {}
    local v56 = nil
    tbl_10 = tbl_10
    for n_7 = 1, #v55 do
        local v57 = v55[n_7]
        if (tbl_9[v57]) and (v48) then
            v56 = v48
        else
            v56 = v49
        end
        n_7[v57] = v56
        if v57.Transparency < n_7[v57] then
            tbl_upv_7[v57] = true
            if not (a1.savedHits[v57]) then
                a1.savedHits[v57] = v57.LocalTransparencyModifier
            end
        end
        for _, value_6 in pairs(v57:GetChildren()) do
            if value_6:IsA("Decal") or value_6:IsA("Texture") then
                if not (value_6.Transparency < n_7[v57]) then
                    continue
                end
                n_7[value_6] = n_7[v57]
                tbl_upv_7[value_6] = true
                if not (a1.savedHits[value_6]) then
                    a1.savedHits[value_6] = value_6.LocalTransparencyModifier
                end
            end
        end
    end
    for key_3, value_7 in pairs(a1.savedHits) do
        if tbl_upv_7[key_3] then
            key_3.LocalTransparencyModifier = ((key_3.Transparency < 1) and ((tbl_10[key_3] - key_3.Transparency) / (1 - key_3.Transparency))) or 0
        else
            key_3.LocalTransparencyModifier = value_7
            a1.savedHits[key_3] = nil
        end
    end
    return a3, a4
end
return u4