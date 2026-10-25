local Players_1 = game:GetService("Players")
local CommonUtils_1 = require(script.Parent.Parent.Parent:WaitForChild("CommonUtils"))
local u1 = CommonUtils_1.get("FlagUtil")
local v1 = CommonUtils_1.get("CameraWrapper")
local v2 = CommonUtils_1.get("ConnectionUtil")
local u2 = u1.getUserFlag("UserRaycastUpdateAPI2")
local u3 = u1.getUserFlag("UserCurrentCameraUpdate2")
local u4 = u1.getUserFlag("UserPlayerConnectionMemoryLeak")
if u3 then
    u1 = v1.new()
else
    u1 = nil
end
local u5 = u3 or game.Workspace.CurrentCamera
if u3 then
    u1:Enable()
end
local min_upv_1 = math.min
local tan_upv_1 = math.tan
local rad_upv_1 = math.rad
local new_upv_1 = Ray.new
local u6 = RaycastParams.new()
u6.IgnoreWater = true
u6.FilterType = Enum.RaycastFilterType.Exclude
u6.RespectCanCollide = true
local u7 = RaycastParams.new()
u7.IgnoreWater = true
u7.FilterType = Enum.RaycastFilterType.Include
if u4 then
    local _ = v2.new()
else
    local u8 = nil
end
local function getTotalTransparency(a1)
    --[[
      name: getTotalTransparency
      line: 43
    ]]
    return 1 - ((1 - a1.Transparency) * (1 - a1.LocalTransparencyModifier))
end
local function eraseFromEnd(a1, a2)
    --[[
      name: eraseFromEnd
      line: 47
    ]]
    for n_1 = #a1, a2 + 1, -1 do
        a1[n_1] = nil
    end
end
local u9 = nil
local u10 = nil
if u3 then
    local function updateProjection()
        --[[
          name: updateProjection
          line: 57
          upvalues:
            u1 (copy, index: 1)
            rad_upv_1 (copy, index: 2)
            u10 (ref,  index: 3)
            tan_upv_1 (copy, index: 4)
            u9 (ref,  index: 5)
        ]]
        local v3 = u1:getCamera()
        local v4 = rad_upv_1(v3.FieldOfView)
        local ViewportSize_1 = v3.ViewportSize
        u10 = tan_upv_1(v4 / 2) * 2
        u9 = (ViewportSize_1.X / ViewportSize_1.Y) * u10
    end
    u1:Connect("FieldOfView", updateProjection)
    u1:Connect("ViewportSize", updateProjection)
    local v5 = u1:getCamera()
    local v6 = rad_upv_1(v5.FieldOfView)
    local ViewportSize_2 = v5.ViewportSize
    local v7 = tan_upv_1(v6 / 2)
    u10 = v7 * 2
    u9 = ViewportSize_2.X / ViewportSize_2.Y * u10
    local v8 = u1:getCamera()
    local NearPlaneZ_upv_1 = v8.NearPlaneZ
    u1:Connect(
        "NearPlaneZ",
        function()
            --[[
              line: 73
              upvalues:
                NearPlaneZ_upv_1 (ref,  index: 1)
                u1 (copy, index: 2)
            ]]
            NearPlaneZ_upv_1 = u1:getCamera().NearPlaneZ
        end
    )
else
    local function updateProjection_2()
        --[[
          name: updateProjection
          line: 79
          upvalues:
            u5 (ref,  index: 1)
            rad_upv_1 (copy, index: 2)
            u10 (ref,  index: 3)
            tan_upv_1 (copy, index: 4)
            u9 (ref,  index: 5)
        ]]
        local v9 = rad_upv_1(u5.FieldOfView)
        local ViewportSize_3 = u5.ViewportSize
        u10 = tan_upv_1(v9 / 2) * 2
        u9 = (ViewportSize_3.X / ViewportSize_3.Y) * u10
    end
    u5:GetPropertyChangedSignal("FieldOfView"):Connect(updateProjection_2)
    u5:GetPropertyChangedSignal("ViewportSize"):Connect(updateProjection_2)
    local v10 = rad_upv_1(u5.FieldOfView)
    local ViewportSize_4 = u5.ViewportSize
    local v11 = tan_upv_1(v10 / 2)
    u10 = v11 * 2
    u9 = ViewportSize_4.X / ViewportSize_4.Y * u10
    local NearPlaneZ_upv_2 = u5.NearPlaneZ
    u5:GetPropertyChangedSignal("NearPlaneZ"):Connect(
        function()
            --[[
              line: 93
              upvalues:
                NearPlaneZ_upv_2 (ref, index: 1)
                u5 (ref, index: 2)
            ]]
            NearPlaneZ_upv_2 = u5.NearPlaneZ
        end
    )
end
local tbl_upv_1 = {}
local tbl_upv_2 = {}
local function refreshIgnoreList()
    --[[
      name: refreshIgnoreList
      line: 102
      upvalues:
        tbl_upv_1 (ref,  index: 1)
        tbl_upv_2 (copy, index: 2)
    ]]
    local v12 = 1
    tbl_upv_1 = {}
    for _, value_1 in pairs(tbl_upv_2) do
        tbl_upv_1[v12] = value_1
        v12 = v12 + 1
    end
end
local u8
local function playerAdded(a1)
    --[[
      name: playerAdded
      line: 111
      upvalues:
        tbl_upv_2 (copy, index: 1)
        tbl_upv_1 (ref,  index: 2)
        u4 (copy, index: 3)
        u8 (copy, index: 4)
    ]]
    local function characterAdded_1(a2)
        --[[
          name: characterAdded
          line: 112
          upvalues:
            tbl_upv_2 (copy, index: 1)
            a1 (copy, index: 2)
            tbl_upv_1 (ref,  index: 3)
        ]]
        tbl_upv_2[a1] = a2
        local v13 = 1
        tbl_upv_1 = {}
        for _, value_2 in pairs(tbl_upv_2) do
            tbl_upv_1[v13] = value_2
            v13 = v13 + 1
        end
    end
    local function characterRemoving_1()
        --[[
          name: characterRemoving
          line: 116
          upvalues:
            tbl_upv_2 (copy, index: 1)
            a1 (copy, index: 2)
            tbl_upv_1 (ref,  index: 3)
        ]]
        tbl_upv_2[a1] = nil
        local v14 = 1
        tbl_upv_1 = {}
        for _, value_3 in pairs(tbl_upv_2) do
            tbl_upv_1[v14] = value_3
            v14 = v14 + 1
        end
    end
    if u4 then
        u8:trackConnection(("%*CharacterAdded"):format(a1.UserId), a1.CharacterAdded:Connect(characterAdded_1))
        u8:trackConnection(("%*CharacterRemoving"):format(a1.UserId), a1.CharacterRemoving:Connect(characterRemoving_1))
    else
        a1.CharacterAdded:Connect(characterAdded_1)
        a1.CharacterRemoving:Connect(characterRemoving_1)
    end
    if a1.Character then
        tbl_upv_2[a1] = a1.Character
        local v15 = 1
        tbl_upv_1 = {}
        local v16 = v15
        for _, value_4 in pairs(tbl_upv_2) do
            tbl_upv_1[v16] = value_4
            v16 = v16 + 1
        end
    end
end
local function playerRemoving(a1)
    --[[
      name: playerRemoving
      line: 134
      upvalues:
        tbl_upv_2 (copy, index: 1)
        tbl_upv_1 (ref,  index: 2)
        u4 (copy, index: 3)
        u8 (copy, index: 4)
    ]]
    tbl_upv_2[a1] = nil
    local v17 = 1
    tbl_upv_1 = {}
    for _, value_5 in pairs(tbl_upv_2) do
        tbl_upv_1[v17] = value_5
        v17 = v17 + 1
    end
    if not u4 then
        return
    end
    u8:disconnect((("%*CharacterAdded"):format(a1.UserId)))
    u8:disconnect((("%*CharacterRemoving"):format(a1.UserId)))
end
Players_1.PlayerAdded:Connect(playerAdded)
Players_1.PlayerRemoving:Connect(playerRemoving)
for _, value_6 in ipairs(Players_1:GetPlayers()) do
    playerAdded(value_6)
end
local v18 = 1
tbl_upv_1 = {}
local v7 = v18
for _, value_7 in pairs(tbl_upv_2) do
    tbl_upv_1[v7] = value_7
    v7 = v7 + 1
end
local u11 = nil
local u12 = nil
if u3 then
    u1:Connect(
        "CameraSubject",
        function()
            --[[
              line: 174
              upvalues:
                u1 (copy, index: 1)
                u12 (ref,  index: 2)
            ]]
            local CameraSubject_1 = u1:getCamera().CameraSubject
            if CameraSubject_1 and CameraSubject_1:IsA("Humanoid") then
                u12 = CameraSubject_1.RootPart
                return
            end
            if CameraSubject_1 and CameraSubject_1:IsA("BasePart") then
                u12 = CameraSubject_1
            else
                u12 = nil
            end
        end
    )
else
    u5:GetPropertyChangedSignal("CameraSubject"):Connect(
        function()
            --[[
              line: 185
              upvalues:
                u5 (ref, index: 1)
                u12 (ref, index: 2)
            ]]
            local CameraSubject_2 = u5.CameraSubject
            if CameraSubject_2:IsA("Humanoid") then
                u12 = CameraSubject_2.RootPart
            elseif CameraSubject_2:IsA("BasePart") then
                u12 = CameraSubject_2
            else
                u12 = nil
            end
        end
    )
end
local function canOcclude(a1)
    --[[
      name: canOcclude
      line: 197
      upvalues:
        u2 (copy, index: 1)
        u11 (ref,  index: 2)
    ]]
    local v19 = false
    if 1 - ((1 - a1.Transparency) * (1 - a1.LocalTransparencyModifier)) < 0.25 then
        if u2 then
            v19 = (u11 ~= (a1:GetRootPart() or a1)) and (not a1:IsA("TrussPart"))
        else
            v19 = a1.CanCollide
            v19 = a1.CanCollide and u11 ~= (a1:GetRootPart() or a1) and not a1:IsA("TrussPart")
        end
    end
    return v19
end
local tbl_upv_3 = {Vector2.new(0.4, 0), Vector2.new(-0.4, 0), Vector2.new(0, -0.4), Vector2.new(0, 0.4), Vector2.new(0, 0.2)}
local function getCollisionPoint(a1, a2)
    --[[
      name: getCollisionPoint
      line: 225
      upvalues:
        u2 (copy, index: 1)
        u6 (copy, index: 2)
        tbl_upv_1 (ref,  index: 3)
        new_upv_1 (copy, index: 4)
    ]]
    local v20 = nil
    if u2 then
        u6.FilterDescendantsInstances = tbl_upv_1
        v20 = workspace:Raycast(a1, a2, u6)
        if v20 then
            return v20.Position, true
        end
        return a1 + a2, false
    else
        local v21 = #tbl_upv_1
        local v22 = nil
        while true do
            local v23, v22 = workspace:FindPartOnRayWithIgnoreList(new_upv_1(a1, a2), tbl_upv_1, false, true)
            if v23 then
                if v23.CanCollide then
                    for n_2 = #tbl_upv_1, v21 + 1, -1 do
                        tbl_upv_1[n_2] = nil
                    end
                    return v22, true
                end
                tbl_upv_1[#tbl_upv_1 + 1] = v23
            end
            if v23 then
                continue
            end
            for n_3 = #tbl_upv_1, v21 + 1, -1 do
                tbl_upv_1[n_3] = nil
            end
            return a1 + a2, false
        end
    end
end
local u13
local function queryPoint(a1, a2, a3, a4)
    --[[
      name: queryPoint
      line: 258
      upvalues:
        tbl_upv_1 (ref,  index: 1)
        u13 (ref,  index: 2)
        u2 (copy, index: 3)
        u6 (copy, index: 4)
        u11 (ref,  index: 5)
        u7 (copy, index: 6)
        new_upv_1 (copy, index: 7)
    ]]
    debug.profilebegin("queryPoint")
    local v24 = #tbl_upv_1
    a3 = a3 + u13
    local v25 = a1 + a2 * a3
    local v26 = math.huge
    local v27 = math.huge
    local v28 = 0
    local v29, v30 = nil, nil
    if u2 then
        u6.FilterDescendantsInstances = tbl_upv_1
        local v31 = a1
        local v32 = nil
        while true do
            local v33 = workspace:Raycast(v31, v25 - v31, u6)
            if not (v33) then
                break
            end
            v28 = v28 + 1
            local Instance_1 = v33.Instance
            v29 = v33.Position
            local Magnitude_1 = (v29 - a1).Magnitude
            if v28 >= 64 then
                v27 = Magnitude_1
            else
                v32 = false
                if 1 - ((1 - Instance_1.Transparency) * (1 - Instance_1.LocalTransparencyModifier)) < 0.25 then
                    if u2 then
                        v32 = (u11 ~= (Instance_1:GetRootPart() or Instance_1)) and (not Instance_1:IsA("TrussPart"))
                    else
                        v32 = Instance_1.CanCollide
                        v32 = Instance_1.CanCollide and u11 ~= (Instance_1:GetRootPart() or Instance_1) and not Instance_1:IsA("TrussPart")
                    end
                end
                if v32 then
                    u7.FilterDescendantsInstances = {Instance_1}
                    if workspace:Raycast(v25, v29 - v25, u7) then
                        local v34
                        if a4 then
                            v34 = workspace:Raycast(a4, v25 - a4, u7) or (workspace:Raycast(v25, a4 - v25, u7))
                        else
                            v34 = false
                        end
                        if v34 then
                            v27 = Magnitude_1
                        elseif a3 < v26 then
                            v26 = Magnitude_1
                        end
                    else
                        v27 = Magnitude_1
                    end
                end
            end
            u6:AddToFilter(Instance_1)
            v31 = v29 - a2 * 0.001
            if not (v27 < math.huge) and Instance_1 then
                continue
            end
            break
        end
    else
        local v31 = a1
        local v35, v36 = nil, nil
        local v37
        repeat
            local v38
            v37, v38 = workspace:FindPartOnRayWithIgnoreList(new_upv_1(v31, v25 - v31), tbl_upv_1, false, true)
            v28 = v28 + 1
            if v37 then
                v29 = v28 >= 64
                v35 = false
                if 1 - ((1 - v37.Transparency) * (1 - v37.LocalTransparencyModifier)) < 0.25 then
                    if u2 then
                        v35 = (u11 ~= (v37:GetRootPart() or v37)) and (not v37:IsA("TrussPart"))
                    else
                        v30 = v37.CanCollide
                        if v30 then
                            v35 = (u11 ~= (v37:GetRootPart() or v37)) and (not v37:IsA("TrussPart"))
                        else
                            v35 = v30
                        end
                    end
                end
                if v35 or v29 then
                    local tbl_4 = {v37}
                    local v39 = workspace:FindPartOnRayWithWhitelist(new_upv_1(v25, v38 - v25), tbl_4, true)
                    local Magnitude_2 = (v38 - a1).Magnitude
                    if not (v39) or v29 then
                        v27 = Magnitude_2
                        tbl_upv_1[#tbl_upv_1 + 1] = v37
                        v31 = v38 - a2 * 0.001
                        if v27 < math.huge or not (v37) then
                            break
                        end
                    end
                    v36 = false
                    if a4 then
                        v36 = workspace:FindPartOnRayWithWhitelist(new_upv_1(a4, v25 - a4), tbl_4, true) or workspace:FindPartOnRayWithWhitelist(new_upv_1(v25, a4 - v25), tbl_4, true)
                    end
                    if v36 then
                        v27 = Magnitude_2
                    elseif a3 < v26 then
                        v26 = Magnitude_2
                    end
                    tbl_upv_1[#tbl_upv_1 + 1] = v37
                    v31 = v38 - a2 * 0.001
                    if v27 < math.huge or not (v37) then
                        break
                    end
                end
                tbl_upv_1[#tbl_upv_1 + 1] = v37
                v31 = v38 - a2 * 0.001
            end
            if v27 < math.huge then
                break
            end
        until not (v37)
        for n_4 = #tbl_upv_1, v24 + 1, -1 do
            tbl_upv_1[n_4] = nil
        end
    end
    debug.profileend()
    return v26 - u13, v27 - u13
end
local function queryViewport(a1, a2)
    --[[
      name: queryViewport
      line: 361
      upvalues:
        u5 (ref,  index: 1)
        u3 (copy, index: 2)
        u1 (copy, index: 3)
        u9 (ref,  index: 4)
        u10 (ref,  index: 5)
        u13 (ref,  index: 6)
        queryPoint (copy, index: 7)
    ]]
    debug.profilebegin("queryViewport")
    local Position_1 = a1.Position
    local rightVector_1 = a1.rightVector
    local upVector_1 = a1.upVector
    local v41
    if u3 then
        v41 = u1:getCamera()
    else
        v41 = u5
    end
    u5 = v41
    local ViewportSize_5 = u5.ViewportSize
    local v42 = math.huge
    local v43 = math.huge
    for n_5 = 0, 1 do
        local v44 = rightVector_1 * ((n_5 - 0.5) * u9)
        for n_6 = 0, 1 do
            local v45, v46 = queryPoint(Position_1 + (u13 * (v44 + (upVector_1 * ((n_6 - 0.5) * u10)))), -a1.lookVector, a2, u5:ViewportPointToRay(ViewportSize_5.x * n_5, ViewportSize_5.y * n_6).Origin)
            if v46 < v42 then
                v42 = v46
            end
            if v45 < v43 then
                v43 = v45
            end
        end
    end
    debug.profileend()
    return v43, v42
end
local function testPromotion(a1, a2, a3)
    --[[
      name: testPromotion
      line: 404
      upvalues:
        getCollisionPoint (copy, index: 1)
        min_upv_1 (copy, index: 2)
        queryPoint (copy, index: 3)
        tbl_upv_3 (copy, index: 4)
    ]]
    debug.profilebegin("testPromotion")
    local Position_2 = a1.Position
    local rightVector_2 = a1.rightVector
    local upVector_2 = a1.upVector
    debug.profilebegin("extrapolate")
    for n_7 = 0, min_upv_1(1.25, a3.rotVelocity.magnitude + ((getCollisionPoint(Position_2, a3.posVelocity * 1.25) - Position_2).Magnitude / a3.posVelocity.magnitude)), 0.0625 do
        local v47 = a3.extrapolate(n_7)
        if not (a2 <= queryPoint(v47.Position, -v47.lookVector, a2)) then
            continue
        end
        return false
    end
    debug.profileend()
    debug.profilebegin("testOffsets")
    for _, value_8 in ipairs(tbl_upv_3) do
        local v48 = getCollisionPoint(Position_2, (rightVector_2 * value_8.x) + (upVector_2 * value_8.y))
        if queryPoint(v48, ((Position_2 + (-a1.lookVector * a2)) - v48).Unit, a2) ~= math.huge then
            continue
        end
        return false
    end
    debug.profileend()
    debug.profileend()
    return true
end
local function Popper(a1, a2, a3)
    --[[
      name: Popper
      line: 453
      upvalues:
        u11 (ref,  index: 1)
        u12 (ref,  index: 2)
        queryViewport (copy, index: 3)
        testPromotion (copy, index: 4)
    ]]
    debug.profilebegin("popper")
    local v49 = (u12 and (u12:GetRootPart())) or u12
    u11 = v49
    local v50, v51 = queryViewport(a1, a2)
    if v51 < a2 then

    end
    if v50 < a2 then
        if testPromotion(a1, a2, a3) then

        end
    end
    u11 = nil
    debug.profileend()
    return a2
end
return Popper