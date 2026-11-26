local v1 = {0, 30}
local VRBaseCamera = require(script.Parent:WaitForChild("VRBaseCamera"))
local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"))
local CameraInput = require(script.Parent:WaitForChild("CameraInput"))
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local vrService = game:GetService("VRService")
local lighting = game:GetService("Lighting")
local localPlayer = players.LocalPlayer
local mapClamp = CameraUtils.mapClamp
local VehicleCameraConfig = require(script.Parent:WaitForChild("VehicleCamera"):FindFirstChild("VehicleCameraConfig"))
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.IgnoreWater = true

local function yawVelocity(a14, a15)
    --[[
      name: yawVelocity
      line: 37
    ]]
    return (math.abs((a15.YVector:Dot(a14))))
end

local function computeCameraCFrame(a17, a18, a19)
    --[[
      name: computeCameraCFrame
      line: 41
    ]]
    local rotationY = math.atan2(a18.X, a18.Z)
    return CFrame.new(a17.Position + (a18 * a19)) * CFrame.Angles(0, rotationY, 0)
end

local function vrOccludeDisplace(cframe: CFrame, a23, cameraToSubjectDistance, vehicleModel)
    --[[
      name: vrOccludeDisplace
      line: 46
      upvalues:
        localPlayer (copy, index: 1)
        raycastParams (copy, index: 2)
    ]]
    local rotationY = math.atan2(a23.X, a23.Z)
    local cframe2 = CFrame.new(cframe.Position + (a23 * cameraToSubjectDistance)) * CFrame.Angles(0, rotationY, 0)
    local camera = workspace.CurrentCamera
    if not camera then
        return cframe2
    end

    local position = cframe.Position
    local direction = (cframe2.Position - position) * Vector3.new(1, 0, 1)
    local magnitude = direction.Magnitude

    if magnitude < 0.5 then
        return cframe2
    end

    local filterDescendantsInstances = {camera}

    if vehicleModel then
        table.insert(filterDescendantsInstances, vehicleModel)
    end

    if const character = localPlayer and localPlayer.Character then
        table.insert(filterDescendantsInstances, character)
    end

    raycastParams.FilterDescendantsInstances = filterDescendantsInstances
    local unit = direction.Unit
    local raycastResult = workspace:Raycast(position, direction, raycastParams)

    if raycastResult and raycastResult.Normal:Dot(unit) < 0 then
        local v36 = (raycastResult.Position - position).Magnitude - 0.5

        if v36 < magnitude then
            local v37 = math.max(v36, 0.5)
            return CFrame.new(cframe.Position + (unit * v37)) * cframe2.Rotation
        end
    end

    return cframe2
end

local overlapParams = OverlapParams.new()
overlapParams.FilterType = Enum.RaycastFilterType.Exclude

local function findObstructions(cframe2: CFrame, a41, a42, vehicleModel)
    --[[
      name: findObstructions
      line: 82
      upvalues:
        vrService (copy, index: 1)
        localPlayer (copy, index: 2)
        raycastParams (copy, index: 3)
        overlapParams (copy, index: 4)
    ]]
    local camera = workspace.CurrentCamera
    if not camera then
        return 0, {}
    end

    local position = a41.Position
    local userCFrame = vrService:GetUserCFrame(Enum.UserCFrame.Head)
    local headScale = camera.HeadScale
    local cframe3 = cframe2 * (CFrame.new(userCFrame.Position * headScale) * userCFrame.Rotation)
    local direction = cframe3.Position - position
    local magnitude = direction.Magnitude

    if magnitude < 0.5 then
        return 0, {}
    end

    local filterDescendantsInstances = {camera}

    if vehicleModel then
        table.insert(filterDescendantsInstances, vehicleModel)
    end

    if const character = localPlayer and localPlayer.Character then
        table.insert(filterDescendantsInstances, character)
    end

    raycastParams.FilterDescendantsInstances = filterDescendantsInstances

    if const raycastResult = workspace:Raycast(position, direction, raycastParams) then
        local magnitude2 = (raycastResult.Position - position).Magnitude

        if magnitude2 < magnitude then
            local lookVector = cframe3.LookVector
            local v56 = math.max(math.clamp((1 - -direction.Unit:Dot(lookVector)) / 0.1339745962155613, 0, 1), 1 - (magnitude2 / a42), 0.15)
            local position2 = raycastResult.Position
            local position3 = cframe3.Position
            local v59 = (position2 + position3) / 2
            local size = Vector3.new(2, 2, (position3 - position2).Magnitude)
            local cframe = CFrame.lookAt(v59, position3)
            overlapParams.FilterDescendantsInstances = filterDescendantsInstances

            return v56, (workspace:GetPartBoundsInBox(cframe, size, overlapParams))
        end
    end

    return 0, {}
end

local deltaTime = 0.016666666666666666
local v63 = setmetatable({}, VRBaseCamera)
v63.__index = v63

function v63.new()
    --[[
      name: new
      line: 139
      upvalues:
        VRBaseCamera (copy, index: 1)
        v63 (copy, index: 2)
        runService (copy, index: 3)
        deltaTime (ref,  index: 4)
    ]]
    local v64 = setmetatable(VRBaseCamera.new(), v63)
    v64.skipOcclusion = true
    v64:Reset()

    if v64.thirdPersonOptionChanged then
        v64.thirdPersonOptionChanged:Disconnect()
        v64.thirdPersonOptionChanged = nil
    end

    runService.Stepped:Connect(
        function(time: number, deltaTime2: number)
            --[[
              line: 149
              upvalues:
                deltaTime (ref, index: 1)
            ]]
            deltaTime = deltaTime2
        end
    )

    return v64
end

function v63.Reset(self)
    --[[
      name: Reset
      line: 156
      upvalues:
        CameraUtils (copy, index: 1)
        v1 (copy, index: 2)
    ]]
    local camera = workspace.CurrentCamera
    local cameraSubject = camera and camera.CameraSubject
    assert(camera, "VRVehicleCamera initialization error")
    assert(cameraSubject)
    assert(cameraSubject:IsA("VehicleSeat"))
    self.lastOrbitalDir = nil
    self.wasInFirstPerson = nil
    local connectedParts = cameraSubject:GetConnectedParts(true)
    table.insert(connectedParts, cameraSubject)
    local looseBoundingSphere, v72 = CameraUtils.getLooseBoundingSphere(connectedParts)
    local instance = cameraSubject:FindFirstAncestorOfClass("Model") or cameraSubject.Parent
    self.vehicleModel = instance
    self.assemblyRadius = math.max(v72, 5)
    self.assemblyOffset = cameraSubject.CFrame:Inverse() * looseBoundingSphere
    self.gamepadZoomLevels = {}

    for _, v75 in v1 do
        table.insert(self.gamepadZoomLevels, (v75 * self.headScale * self.assemblyRadius) / 10)
    end

    self.lastCameraFocus = nil

    if not self:IsInFirstPerson() then
        self:SetCameraToSubjectDistance(self.gamepadZoomLevels[#self.gamepadZoomLevels])
    end

    self.needsReset = false
end

function v63._getThirdPersonLocalOffset(a76)
    --[[
      name: _getThirdPersonLocalOffset
      line: 190
      upvalues:
        VehicleCameraConfig (copy, index: 1)
    ]]
    return a76.assemblyOffset + Vector3.new(0, a76.assemblyRadius * VehicleCameraConfig.verticalCenterOffset, 0)
end

function v63._getFirstPersonLocalOffset(a77, a78)
    --[[
      name: _getFirstPersonLocalOffset
      line: 194
      upvalues:
        localPlayer (copy, index: 1)
    ]]
    local character = localPlayer.Character

    if character and character.Parent then
        local head = character:FindFirstChild("Head")

        if head and head:IsA("BasePart") then
            return a78:Inverse() * head.Position
        end
    end

    return a77:_getThirdPersonLocalOffset()
end

function v63._vrOccludeVignette(a81, a82, a83, a84)
    --[[
      name: _vrOccludeVignette
      line: 208
      upvalues:
        findObstructions (copy, index: 1)
        lighting (copy, index: 2)
        localPlayer (copy, index: 3)
    ]]
    local rotationY = math.atan2(a83.X, a83.Z)
    local cframe = CFrame.new(a82.Position + (a83 * a84)) * CFrame.Angles(0, rotationY, 0)
    local obstructions, lastOccludedParts = findObstructions(cframe, a82, a84, a81.vehicleModel)
    local vrFade = lighting:FindFirstChild("VRFade")
    if not vrFade then
        vrFade = Instance.new("ColorCorrectionEffect")
        vrFade.Name = "VRFade"
        vrFade.Parent = lighting
    end

    vrFade.Brightness = -obstructions

    if a81.lastOccludedParts then
        for _, lastOccludedPart in a81.lastOccludedParts do
            lastOccludedPart.LocalTransparencyModifier = 0
        end
    end

    if 0 < #lastOccludedParts then
        for _, v93 in lastOccludedParts do
            v93.LocalTransparencyModifier = 1
        end

        a81:StartVREdgeBlur(localPlayer, true)
    end

    a81.lastOccludedParts = lastOccludedParts

    return cframe
end

function v63.Update(a94)
    --[[
      name: Update
      line: 235
      upvalues:
        deltaTime (ref,  index: 1)
        localPlayer (copy, index: 2)
    ]]
    local deltaTime2 = deltaTime
    deltaTime = 0
    a94:UpdateFadeFromBlack(deltaTime2)
    a94:UpdateEdgeBlur(localPlayer, deltaTime2)
    local v96, v97 = a94:_updateStepRotation(deltaTime2)
    return v96, v97
end

function v63._updateStepRotation(a98, a99)
    --[[
      name: _updateStepRotation
      line: 247
      upvalues:
        mapClamp (copy, index: 1)
        CameraInput (copy, index: 2)
        VehicleCameraConfig (copy, index: 3)
        vrOccludeDisplace (copy, index: 4)
    ]]
    local v100, cframe
    local subjectCFrame = a98:GetSubjectCFrame()
    local cameraToSubjectDistance = a98:GetCameraToSubjectDistance()
    local alpha = mapClamp(cameraToSubjectDistance, 0.5, a98.assemblyRadius, 1, 0)
    local startValue = a98:_getThirdPersonLocalOffset()
    local v106 = subjectCFrame * startValue:Lerp(a98:_getFirstPersonLocalOffset(subjectCFrame), alpha)
    local cframe2 = CFrame.new(v106 + Vector3.new(0, a98:GetCameraHeight(), 0))

    if a98.needsReset or a98.recentered then
        a98.lastOrbitalDir = nil
        a98.needsReset = false
        a98.recentered = false
    end

    local v108 = a98.lastOrbitalDir
    if not v108 then
        v108 = (subjectCFrame.LookVector * Vector3.new(-1, 0, -1)).Unit
        a98:StartFadeFromBlack()
    end

    local v109 = 2 < (a98:GetSubjectVelocity() * Vector3.new(1, 0, 1)).Magnitude

    if v109 then
        CameraInput.getRotation(a99)
    else
        local rotation = a98:getRotation(a99)

        if 0 < math.abs(rotation) then
            v108 = (CFrame.Angles(0, -rotation, 0) * CFrame.new(v108)).Position.Unit
            a98.lastRotateTime = os.clock()
        end
    end

    if a98:IsInFirstPerson() then
        if not a98.wasInFirstPerson or v109 then
            v108 = (subjectCFrame.LookVector * Vector3.new(-1, 0, -1)).Unit
            a98.wasInFirstPerson = true
        end

        local lastVehicleYaw = math.atan2(-subjectCFrame.LookVector.X, -subjectCFrame.LookVector.Z)

        if a98.lastVehicleYaw then
            local rotationY = ((lastVehicleYaw - a98.lastVehicleYaw) + math.pi) % math.tau - math.pi

            if not (0.001 < math.abs(rotationY)) then
                v100 = v108
            else
                v100 = (CFrame.Angles(0, rotationY, 0) * CFrame.new(v108)).Position.Unit
            end
        else
            v100 = v108
        end

        a98.lastVehicleYaw = lastVehicleYaw
        local rotationY = math.atan2(v100.X, v100.Z)
        cframe = CFrame.new(cframe2.Position + (v100 * cameraToSubjectDistance)) * CFrame.Angles(0, rotationY, 0)
    else
        a98.wasInFirstPerson = false
        a98.lastVehicleYaw = nil
        local v114 = a98.lastRotateTime
            and os.clock() - a98.lastRotateTime < VehicleCameraConfig.autocorrectDelay

        if v109 then
            if v114 then
                v100 = v108
            else
                local unit = (subjectCFrame.LookVector * Vector3.new(-1, 0, -1)).Unit
                local v116 = math.acos((math.clamp(v108:Dot(unit), -1, 1)))
                local subjectRotVelocity = a98:GetSubjectRotVelocity()
                local absoluteValue = math.abs((subjectCFrame.YVector:Dot(subjectRotVelocity)))
                v100 = v108:Lerp(unit, (math.min((0.01 + ((v116 / math.pi) * 0.05)) + (absoluteValue * 0.02), 0.15)))
            end
        else
            v100 = v108
        end

        cframe = vrOccludeDisplace(cframe2, v100, cameraToSubjectDistance, a98.vehicleModel)
    end

    a98.lastOrbitalDir = v100

    return cframe, cframe * CFrame.new(0, 0, -cameraToSubjectDistance)
end

return v63