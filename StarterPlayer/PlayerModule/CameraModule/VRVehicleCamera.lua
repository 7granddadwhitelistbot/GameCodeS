local tbl_upv_1 = {0, 30}
local VRBaseCamera_upv_1 = require(script.Parent:WaitForChild("VRBaseCamera"))
local CameraUtils_upv_1 = require(script.Parent:WaitForChild("CameraUtils"))
local CameraInput_upv_1 = require(script.Parent:WaitForChild("CameraInput"))
local Players_1 = game:GetService("Players")
local RunService_upv_1 = game:GetService("RunService")
local VRService_upv_1 = game:GetService("VRService")
local Lighting_upv_1 = game:GetService("Lighting")
local LocalPlayer_upv_1 = Players_1.LocalPlayer
local mapClamp_upv_1 = CameraUtils_upv_1.mapClamp
local VehicleCameraConfig_upv_1 = require(script.Parent:WaitForChild("VehicleCamera"):FindFirstChild("VehicleCameraConfig"))
local u1 = RaycastParams.new()
u1.FilterType = Enum.RaycastFilterType.Exclude
u1.IgnoreWater = true
local function yawVelocity(a1, a2)
    --[[
      name: yawVelocity
      line: 36
    ]]
    return (math.abs(a2.YVector:Dot(a1)))
end
local function computeCameraCFrame(a1, a2, a3)
    --[[
      name: computeCameraCFrame
      line: 40
    ]]
    local v1 = math.atan2(a2.X, a2.Z)
    return CFrame.new(a1.Position + (a2 * a3)) * CFrame.Angles(0, v1, 0)
end
local u2 = OverlapParams.new()
u2.FilterType = Enum.RaycastFilterType.Exclude
local u3 = 0.016666666666666666
local u4 = setmetatable({}, VRBaseCamera_upv_1)
u4.__index = u4
function u4.new()
    --[[
      name: new
      line: 133
      upvalues:
        VRBaseCamera_upv_1 (copy, index: 1)
        u4 (copy, index: 2)
        RunService_upv_1 (copy, index: 3)
        u3 (ref,  index: 4)
    ]]
    local v2 = setmetatable(VRBaseCamera_upv_1.new(), u4)
    v2.skipOcclusion = true
    v2:Reset()
    if v2.thirdPersonOptionChanged then
        v2.thirdPersonOptionChanged:Disconnect()
        v2.thirdPersonOptionChanged = nil
    end
    RunService_upv_1.Stepped:Connect(
        function(a1, a2)
            --[[
              line: 143
              upvalues:
                u3 (ref, index: 1)
            ]]
            u3 = a2
        end
    )
    return v2
end
function u4.Reset(a1)
    --[[
      name: Reset
      line: 150
      upvalues:
        CameraUtils_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    local CurrentCamera_1 = workspace.CurrentCamera
    local v3 = CurrentCamera_1 and (CurrentCamera_1.CameraSubject)
    assert(CurrentCamera_1, "VRVehicleCamera initialization error")
    assert(v3)
    assert(v3:IsA("VehicleSeat"))
    a1.lastOrbitalDir = nil
    a1.wasInFirstPerson = nil
    local v4 = v3:GetConnectedParts(true)
    table.insert(v4, v3)
    local v5, v6 = CameraUtils_upv_1.getLooseBoundingSphere(v4)
    CurrentCamera_1 = v3:FindFirstAncestorOfClass("Model") or (v3.Parent)
    a1.vehicleModel = CurrentCamera_1
    a1.assemblyRadius = math.max(v6, 5)
    a1.assemblyOffset = CurrentCamera_1.CFrame:Inverse() * v5
    a1.gamepadZoomLevels = {}
    for _, value_1 in tbl_upv_1 do
        table.insert(a1.gamepadZoomLevels, ((value_1 * a1.headScale) * a1.assemblyRadius) / 10)
    end
    a1.lastCameraFocus = nil
    if not (a1:IsInFirstPerson()) then
        a1:SetCameraToSubjectDistance(a1.gamepadZoomLevels[#a1.gamepadZoomLevels])
    end
    a1.needsReset = false
end
function u4._getThirdPersonLocalOffset(a1)
    --[[
      name: _getThirdPersonLocalOffset
      line: 184
      upvalues:
        VehicleCameraConfig_upv_1 (copy, index: 1)
    ]]
    return a1.assemblyOffset + Vector3.new(0, a1.assemblyRadius * VehicleCameraConfig_upv_1.verticalCenterOffset, 0)
end
function u4._getFirstPersonLocalOffset(a1, a2)
    --[[
      name: _getFirstPersonLocalOffset
      line: 188
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local Character_1 = LocalPlayer_upv_1.Character
    if Character_1 and Character_1.Parent then
        local Head_1 = Character_1:FindFirstChild("Head")
        if Head_1 and Head_1:IsA("BasePart") then
            return a2:Inverse() * Head_1.Position
        end
    end
    return a1:_getThirdPersonLocalOffset()
end
local function findObstructions(a1, a2, a3, a4)
    --[[
      name: findObstructions
      line: 81
      upvalues:
        VRService_upv_1 (copy, index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
        u1 (copy, index: 3)
        u2 (copy, index: 4)
    ]]
    local CurrentCamera_2 = workspace.CurrentCamera
    if not CurrentCamera_2 then
        return 0, {}
    end
    local Position_1 = a2.Position
    local v7 = VRService_upv_1:GetUserCFrame(Enum.UserCFrame.Head)
    local v8 = a1 * (CFrame.new(v7.Position * CurrentCamera_2.HeadScale) * v7.Rotation)
    local v9 = v8.Position - Position_1
    local Magnitude_1 = v9.Magnitude
    if Magnitude_1 < 0.5 then
        return 0, {}
    end
    local tbl_2 = {CurrentCamera_2}
    if a4 then
        table.insert(tbl_2, a4)
    end
    local v10 = LocalPlayer_upv_1 and (LocalPlayer_upv_1.Character)
    if v10 then
        table.insert(tbl_2, v10)
    end
    u1.FilterDescendantsInstances = tbl_2
    local v11 = workspace:Raycast(Position_1, v9, u1)
    if v11 then
        local Magnitude_2 = (v11.Position - Position_1).Magnitude
        if Magnitude_2 < Magnitude_1 then
            local v12 = math.max(math.clamp((1 - -v9.Unit:Dot(v8.LookVector)) / 0.1339745962155613, 0, 1), 1 - (Magnitude_2 / a3), 0.15)
            local Position_2 = v11.Position
            local Position_3 = v8.Position
            local v13 = Vector3.new(2, 2, (Position_3 - Position_2).Magnitude)
            local v14 = CFrame.lookAt((Position_2 + Position_3) / 2, Position_3)
            u2.FilterDescendantsInstances = tbl_2
            return v12, (workspace:GetPartBoundsInBox(v14, v13, u2))
        end
    end
    return 0, {}
end
function u4._vrOccludeVignette(a1, a2, a3, a4)
    --[[
      name: _vrOccludeVignette
      line: 202
      upvalues:
        findObstructions (copy, index: 1)
        Lighting_upv_1 (copy, index: 2)
        LocalPlayer_upv_1 (copy, index: 3)
    ]]
    local v15 = math.atan2(a3.X, a3.Z)
    local v16 = CFrame.new(a2.Position + (a3 * a4)) * CFrame.Angles(0, v15, 0)
    local v17, v18 = findObstructions(v16, a2, a4, a1.vehicleModel)
    local v19 = Lighting_upv_1:FindFirstChild("VRFade")
    if not (v19) then
        local v20 = Instance.new("ColorCorrectionEffect")
        v20.Name = "VRFade"
        v20.Parent = Lighting_upv_1
        v19 = v20
    end
    v19.Brightness = -v17
    if a1.lastOccludedParts then
        for _, value_2 in a1.lastOccludedParts do
            value_2.LocalTransparencyModifier = 0
        end
    end
    if #v18 > 0 then
        for _, value_3 in v18 do
            value_3.LocalTransparencyModifier = 1
        end
        a1:StartVREdgeBlur(LocalPlayer_upv_1, true)
    end
    a1.lastOccludedParts = nil
    return v16
end
function u4.Update(a1)
    --[[
      name: Update
      line: 229
      upvalues:
        u3 (ref,  index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
    ]]
    local v21 = u3
    u3 = 0
    a1:UpdateFadeFromBlack(v21)
    a1:UpdateEdgeBlur(LocalPlayer_upv_1, v21)
    local v22, v23 = a1:_updateStepRotation(v21)
    return v22, v23
end
local function vrOccludeDisplace(a1, a2, a3, a4)
    --[[
      name: vrOccludeDisplace
      line: 45
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        u1 (copy, index: 2)
    ]]
    local v24 = math.atan2(a2.X, a2.Z)
    local v25 = CFrame.new(a1.Position + (a2 * a3)) * CFrame.Angles(0, v24, 0)
    local CurrentCamera_3 = workspace.CurrentCamera
    if not CurrentCamera_3 then
        return v25
    end
    local Position_4 = a1.Position
    local v26 = (v25.Position - Position_4) * Vector3.new(1, 0, 1)
    local Magnitude_3 = v26.Magnitude
    if Magnitude_3 < 0.5 then
        return v25
    end
    local tbl_3 = {CurrentCamera_3}
    if a4 then
        table.insert(tbl_3, a4)
    end
    local v27 = LocalPlayer_upv_1 and (LocalPlayer_upv_1.Character)
    if v27 then
        table.insert(tbl_3, v27)
    end
    u1.FilterDescendantsInstances = tbl_3
    local Unit_1 = v26.Unit
    local v28 = workspace:Raycast(Position_4, v26, u1)
    if v28 and v28.Normal:Dot(Unit_1) < 0 then
        local v29 = (v28.Position - Position_4).Magnitude - 0.5
        if v29 < Magnitude_3 then
            return CFrame.new(a1.Position + (Unit_1 * math.max(v29, 0.5))) * v25.Rotation
        end
    end
    return v25
end
function u4._updateStepRotation(a1, a2)
    --[[
      name: _updateStepRotation
      line: 241
      upvalues:
        mapClamp_upv_1 (copy, index: 1)
        CameraInput_upv_1 (copy, index: 2)
        VehicleCameraConfig_upv_1 (copy, index: 3)
        vrOccludeDisplace (copy, index: 4)
    ]]
    local v30 = a1:GetSubjectCFrame()
    local v31 = a1:GetCameraToSubjectDistance()
    local v32 = mapClamp_upv_1(v31, 0.5, a1.assemblyRadius, 1, 0)
    local v33 = CFrame.new(v30 * a1:_getThirdPersonLocalOffset():Lerp(a1:_getFirstPersonLocalOffset(v30), v32) + Vector3.new(0, a1:GetCameraHeight(), 0))
    if a1.needsReset or a1.recentered then
        a1.lastOrbitalDir = nil
        a1.needsReset = false
        a1.recentered = false
    end
    local v34 = a1.lastOrbitalDir
    if not (v34) then
        local Unit_2 = (v30.LookVector * Vector3.new(-1, 0, -1)).Unit
        a1:StartFadeFromBlack()
        v34 = Unit_2
    end
    local v35 = (a1:GetSubjectVelocity() * Vector3.new(1, 0, 1)).Magnitude > 2
    local v36 = nil
    if v35 then
        CameraInput_upv_1.getRotation(a2)
    else
        v36 = a1:getRotation(a2)
        if math.abs(v36) > 0 then
            v34 = (CFrame.Angles(0, -v36, 0) * CFrame.new(v34)).Position.Unit
            a1.lastRotateTime = os.clock()
        end
    end
    local v37
    if a1:IsInFirstPerson() then
        if not (a1.wasInFirstPerson) or v35 then
            v34 = (v30.LookVector * Vector3.new(-1, 0, -1)).Unit
            a1.wasInFirstPerson = true
        end
        local v38 = math.atan2(-v30.LookVector.X, -v30.LookVector.Z)
        local v39 = nil
        if a1.lastVehicleYaw then
            v39 = ((v38 - a1.lastVehicleYaw) + math.pi) % math.tau - math.pi
            if math.abs(v39) > 0.001 then
                v34 = (CFrame.Angles(0, v39, 0) * CFrame.new(v34)).Position.Unit
            end
        end
        a1.lastVehicleYaw = v38
        local v40 = math.atan2(v34.X, v34.Z)
        v37 = CFrame.new(v33.Position + (v34 * v31)) * CFrame.Angles(0, v40, 0)
    else
        a1.wasInFirstPerson = false
        a1.lastVehicleYaw = nil
        local v41 = a1.lastRotateTime and (os.clock() - a1.lastRotateTime < VehicleCameraConfig_upv_1.autocorrectDelay)
        if v35 then
            v34 = (v41) or v34:Lerp((v30.LookVector * Vector3.new(-1, 0, -1)).Unit, math.min(0.01 + math.acos(math.clamp(v34:Dot((v30.LookVector * Vector3.new(-1, 0, -1)).Unit), -1, 1)) / math.pi * 0.05 + math.abs(v30.YVector:Dot(a1:GetSubjectRotVelocity())) * 0.02, 0.15))
        end
        v37 = vrOccludeDisplace(v33, v34, v31, a1.vehicleModel)
    end
    a1.lastOrbitalDir = v34
    return v37, v37 * CFrame.new(0, 0, -v31)
end
return u4