local camera
local nearPlaneZ
local queryPoint, queryViewport, writeIndex
local players = game:GetService("Players")
local CommonUtils = require(script.Parent.Parent.Parent:WaitForChild("CommonUtils"))
local v8 = CommonUtils.get("FlagUtil")
local v9 = CommonUtils.get("CameraWrapper")
local v10 = CommonUtils.get("ConnectionUtil")
local userFlag = v8.getUserFlag("UserRaycastUpdateAPI2")
local userFlag2 = v8.getUserFlag("UserCurrentCameraUpdate2")
local userFlag3 = v8.getUserFlag("UserPlayerConnectionMemoryLeak")
local v14 = if userFlag2 then v9.new() else nil

if userFlag2 then
    camera = nil
else
    camera = game.Workspace.CurrentCamera
end

if userFlag2 then
    v14:Enable()
end

local mathMin = math.min
local mathTan = math.tan
local mathRad = math.rad
local newRay = Ray.new
local raycastParams = RaycastParams.new()
raycastParams.IgnoreWater = true
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.RespectCanCollide = true

local raycastParams2 = RaycastParams.new()
raycastParams2.IgnoreWater = true
raycastParams2.FilterType = Enum.RaycastFilterType.Include
local v21 = if userFlag3 then v10.new() else nil

local function getTotalTransparency(a23)
    --[[
      name: getTotalTransparency
      line: 43
    ]]
    return 1 - ((1 - a23.Transparency) * (1 - a23.LocalTransparencyModifier))
end

local function eraseFromEnd(a25, a26)
    --[[
      name: eraseFromEnd
      line: 47
    ]]
    for index = #a25, a26 + 1, -1 do
        a25[index] = nil
    end
end

local v28 = nil
local v29 = nil

if userFlag2 then
    local function updateProjection()
        --[[
          name: updateProjection
          line: 57
          upvalues:
            v14 (copy, index: 1)
            mathRad (copy, index: 2)
            v29 (ref,  index: 3)
            mathTan (copy, index: 4)
            v28 (ref,  index: 5)
        ]]
        local camera = v14:getCamera()
        local v32 = mathRad(camera.FieldOfView)
        local viewportSize = camera.ViewportSize
        local v34 = viewportSize.X / viewportSize.Y
        v29 = mathTan(v32 / 2) * 2
        v28 = v34 * v29
    end

    v14:Connect("FieldOfView", updateProjection)
    v14:Connect("ViewportSize", updateProjection)
    local camera2 = v14:getCamera()
    local v36 = mathRad(camera2.FieldOfView)
    local viewportSize = camera2.ViewportSize
    local v38 = viewportSize.X / viewportSize.Y
    v29 = mathTan(v36 / 2) * 2
    v28 = v38 * v29
    local nearPlaneZ2 = v14:getCamera().NearPlaneZ
    v14:Connect(
        "NearPlaneZ",
        function()
            --[[
              line: 73
              upvalues:
                nearPlaneZ2 (ref,  index: 1)
                v14 (copy, index: 2)
            ]]
            nearPlaneZ2 = v14:getCamera().NearPlaneZ
        end
    )
    nearPlaneZ = nearPlaneZ2
else
    local function updateProjection()
        --[[
          name: updateProjection
          line: 79
          upvalues:
            camera (ref,  index: 1)
            mathRad (copy, index: 2)
            v29 (ref,  index: 3)
            mathTan (copy, index: 4)
            v28 (ref,  index: 5)
        ]]
        local v41 = mathRad(camera.FieldOfView)
        local viewportSize = camera.ViewportSize
        local v43 = viewportSize.X / viewportSize.Y
        v29 = mathTan(v41 / 2) * 2
        v28 = v43 * v29
    end

    camera:GetPropertyChangedSignal("FieldOfView"):Connect(updateProjection)
    camera:GetPropertyChangedSignal("ViewportSize"):Connect(updateProjection)
    local v44 = mathRad(camera.FieldOfView)
    local viewportSize = camera.ViewportSize
    local v46 = viewportSize.X / viewportSize.Y
    v29 = mathTan(v44 / 2) * 2
    v28 = v46 * v29
    local nearPlaneZ3 = camera.NearPlaneZ
    camera:GetPropertyChangedSignal("NearPlaneZ"):Connect(
        function()
            --[[
              line: 93
              upvalues:
                nearPlaneZ3 (ref, index: 1)
                camera (ref, index: 2)
            ]]
            nearPlaneZ3 = camera.NearPlaneZ
        end
    )
    nearPlaneZ = nearPlaneZ3
end

local filterDescendantsInstances = {}
local v49 = {}

local function refreshIgnoreList()
    --[[
      name: refreshIgnoreList
      line: 103
      upvalues:
        filterDescendantsInstances (ref,  index: 1)
        v49 (copy, index: 2)
    ]]
    local writeIndex = 1
    filterDescendantsInstances = {}

    for _, v53 in pairs(v49) do
        filterDescendantsInstances[writeIndex] = v53
        writeIndex += 1
    end
end

local function playerAdded(player: Player)
    --[[
      name: playerAdded
      line: 112
      upvalues:
        v49 (copy, index: 1)
        filterDescendantsInstances (ref,  index: 2)
        userFlag3 (copy, index: 3)
        v21 (copy, index: 4)
    ]]
    local function characterAdded(character: Model)
        --[[
          name: characterAdded
          line: 113
          upvalues:
            v49 (copy, index: 1)
            player (copy, index: 2)
            filterDescendantsInstances (ref,  index: 3)
        ]]
        v49[player] = character
        local writeIndex = 1
        filterDescendantsInstances = {}

        for _, v60 in pairs(v49) do
            filterDescendantsInstances[writeIndex] = v60
            writeIndex += 1
        end
    end

    local function characterRemoving()
        --[[
          name: characterRemoving
          line: 117
          upvalues:
            v49 (copy, index: 1)
            player (copy, index: 2)
            filterDescendantsInstances (ref,  index: 3)
        ]]
        v49[player] = nil
        local writeIndex = 1
        filterDescendantsInstances = {}

        for _, v64 in pairs(v49) do
            filterDescendantsInstances[writeIndex] = v64
            writeIndex += 1
        end
    end

    if userFlag3 then
        v21:trackConnection(`{player.UserId}CharacterAdded`, player.CharacterAdded:Connect(characterAdded))
        v21:trackConnection(`{player.UserId}CharacterRemoving`, player.CharacterRemoving:Connect(characterRemoving))
    else
        player.CharacterAdded:Connect(characterAdded)
        player.CharacterRemoving:Connect(characterRemoving)
    end

    if player.Character then
        v49[player] = player.Character
        local v65 = 1
        filterDescendantsInstances = {}
        local writeIndex = v65

        for _, v68 in pairs(v49) do
            filterDescendantsInstances[writeIndex] = v68
            writeIndex += 1
        end
    end
end

local function playerRemoving(player: Player)
    --[[
      name: playerRemoving
      line: 141
      upvalues:
        v49 (copy, index: 1)
        filterDescendantsInstances (ref,  index: 2)
        userFlag3 (copy, index: 3)
        v21 (copy, index: 4)
    ]]
    v49[player] = nil
    local writeIndex = 1
    filterDescendantsInstances = {}

    for _, v73 in pairs(v49) do
        filterDescendantsInstances[writeIndex] = v73
        writeIndex += 1
    end

    if userFlag3 then
        v21:disconnect((`{player.UserId}CharacterAdded`))
        v21:disconnect((`{player.UserId}CharacterRemoving`))
    end
end

players.PlayerAdded:Connect(playerAdded)
players.PlayerRemoving:Connect(playerRemoving)

for _, player in ipairs(players:GetPlayers()) do
    playerAdded(player)
end

local v76 = 1
filterDescendantsInstances = {}
writeIndex = v76

for _, v78 in pairs(v49) do
    filterDescendantsInstances[writeIndex] = v78
    writeIndex += 1
end

local v79 = nil
local v80 = nil

if userFlag2 then
    v14:Connect(
        "CameraSubject",
        function()
            --[[
              line: 181
              upvalues:
                v14 (copy, index: 1)
                v80 (ref,  index: 2)
            ]]
            local cameraSubject = v14:getCamera().CameraSubject

            if cameraSubject and cameraSubject:IsA("Humanoid") then
                v80 = cameraSubject.RootPart
                return
            end

            if cameraSubject and cameraSubject:IsA("BasePart") then
                v80 = cameraSubject
                return
            end

            v80 = nil
        end
    )
else
    camera:GetPropertyChangedSignal("CameraSubject"):Connect(
        function()
            --[[
              line: 192
              upvalues:
                camera (ref, index: 1)
                v80 (ref, index: 2)
            ]]
            local cameraSubject = camera.CameraSubject

            if cameraSubject:IsA("Humanoid") then
                v80 = cameraSubject.RootPart
                return
            end

            if cameraSubject:IsA("BasePart") then
                v80 = cameraSubject
                return
            end

            v80 = nil
        end
    )
end

local function canOcclude(a84)
    --[[
      name: canOcclude
      line: 204
      upvalues:
        userFlag (copy, index: 1)
        v79 (ref,  index: 2)
    ]]
    local v85 = false
    local v86 = false

    if 1 - ((1 - a84.Transparency) * (1 - a84.LocalTransparencyModifier)) < 0.25 then
        if userFlag then
            v85 = true
        else
            v86 = a84.CanCollide

            if v86 then
                v85 = true
            end
        end
    end

    if v85 then
        v86 = false

        if v79 ~= (a84:GetRootPart() or a84) then
            v86 = not a84:IsA("TrussPart")
        end
    end

    return v86
end

local v87 = {Vector2.new(0.4, 0), Vector2.new(-0.4, 0), Vector2.new(0, -0.4), Vector2.new(0, 0.4), Vector2.new(0, 0.2)}

local function getCollisionPoint(origin, direction)
    --[[
      name: getCollisionPoint
      line: 231
      upvalues:
        userFlag (copy, index: 1)
        raycastParams (copy, index: 2)
        filterDescendantsInstances (ref,  index: 3)
        newRay (copy, index: 4)
    ]]
    if userFlag then
        raycastParams.FilterDescendantsInstances = filterDescendantsInstances

        if const raycastResult = workspace:Raycast(origin, direction, raycastParams) then
            return raycastResult.Position, true
        end
    else
        local v92, v93, v94
        local filterDescendantsInstanceCount = #filterDescendantsInstances

        while true do
            local partOnRay
            partOnRay, v92 = workspace:FindPartOnRayWithIgnoreList(newRay(origin, direction), filterDescendantsInstances, false, true)

            if partOnRay then
                if partOnRay.CanCollide then
                    v93 = filterDescendantsInstances

                    for index = #v93, filterDescendantsInstanceCount + 1, -1 do
                        v93[index] = nil
                    end

                    return v92, true
                end

                filterDescendantsInstances[#filterDescendantsInstances + 1] = partOnRay
            end

            if not partOnRay then
                v94 = filterDescendantsInstances

                for index = #v94, filterDescendantsInstanceCount + 1, -1 do
                    v94[index] = nil
                end

                return origin + direction, false
            end
        end
    end

    return origin + direction, false
end

queryPoint = function(a99, a100, a101, origin)
    --[[
      name: queryPoint
      line: 262
      upvalues:
        filterDescendantsInstances (ref,  index: 1)
        nearPlaneZ (ref,  index: 2)
        userFlag (copy, index: 3)
        raycastParams (copy, index: 4)
        v79 (ref,  index: 5)
        raycastParams2 (copy, index: 6)
        newRay (copy, index: 7)
    ]]
    debug.profilebegin("queryPoint")
    local filterDescendantsInstanceCount = #filterDescendantsInstances
    a101 += nearPlaneZ
    local origin2 = a99 + a100 * a101
    local magnitude = math.huge
    local magnitude2 = math.huge
    local count = 0

    if userFlag then
        local v108, raycastParams3, v110, magnitude3
        raycastParams.FilterDescendantsInstances = filterDescendantsInstances
        v108, raycastParams3, v110 = a99, raycastParams, count

        while const raycastResult = workspace:Raycast(v108, origin2 - v108, raycastParams3) do
            local canCollide
            local v114
            local v115
            local v116, v117, v118 = false, false, false
            v110 += 1
            local instance = raycastResult.Instance
            local position = raycastResult.Position
            magnitude3 = (position - a99).Magnitude

            if not (64 <= v110) then
                v115 = false

                if not (1 - ((1 - instance.Transparency) * (1 - instance.LocalTransparencyModifier)) < 0.25) then
                    v117 = true
                elseif userFlag then
                    v116 = true
                else
                    canCollide = instance.CanCollide

                    if canCollide then
                        v116 = true
                    else
                        v115 = canCollide
                        v117 = true
                    end
                end
            else
                magnitude2 = magnitude3
            end

            if v116 then
                v115 = false

                if v79 ~= (instance:GetRootPart() or instance) then
                    v115 = not instance:IsA("TrussPart")
                end

                v117 = true
            end

            if v117 and v115 then
                raycastParams2.FilterDescendantsInstances = {instance}

                if workspace:Raycast(origin2, position - origin2, raycastParams2) then
                    if origin then
                        v114 = workspace:Raycast(origin, origin2 - origin, raycastParams2)
                        v114 = v114 or workspace:Raycast(origin2, origin - origin2, raycastParams2)
                    else
                        v114 = false
                    end

                    v118 = true
                else
                    magnitude2 = magnitude3
                end
            end

            if v118 then
                if v114 then
                    magnitude2 = magnitude3
                elseif a101 < magnitude then
                    magnitude = magnitude3
                end
            end

            raycastParams3:AddToFilter(instance)
            v108 = position - a100 * 0.001

            if magnitude2 < math.huge then
                break
            end
            if not instance then
                break
            end

            raycastParams3 = raycastParams
        end
    else
        local v121, v122, magnitude4, canCollide
        v121 = a99
        local partOnRay

        repeat
            partOnRay, v122 = workspace:FindPartOnRayWithIgnoreList(newRay(v121, origin2 - v121), filterDescendantsInstances, false, true)
            count += 1

            if partOnRay then
                local v126 = 64 <= count
                local v127 = false
                local v128 = false

                if 1 - ((1 - partOnRay.Transparency) * (1 - partOnRay.LocalTransparencyModifier)) < 0.25 then
                    if userFlag then
                        v127 = true
                    else
                        canCollide = partOnRay.CanCollide

                        if canCollide then
                            v127 = true
                        else
                            v128 = canCollide
                        end
                    end
                end

                if v127 then
                    v128 = false

                    if v79 ~= (partOnRay:GetRootPart() or partOnRay) then
                        v128 = not partOnRay:IsA("TrussPart")
                    end
                end

                if v128 or v126 then
                    local whitelistDescendantsTable = {partOnRay}
                    local partOnRay2 = workspace:FindPartOnRayWithWhitelist(newRay(origin2, v122 - origin2), whitelistDescendantsTable, true)
                    magnitude4 = (v122 - a99).Magnitude

                    if partOnRay2 then
                        if v126 then
                            magnitude2 = magnitude4
                        else
                            local partOnRay3 = false

                            if origin then
                                partOnRay3 = workspace:FindPartOnRayWithWhitelist(newRay(origin, origin2 - origin), whitelistDescendantsTable, true)
                                    or workspace:FindPartOnRayWithWhitelist(newRay(origin2, origin - origin2), whitelistDescendantsTable, true)
                            end

                            if partOnRay3 then
                                magnitude2 = magnitude4
                            elseif a101 < magnitude then
                                magnitude = magnitude4
                            end
                        end
                    else
                        magnitude2 = magnitude4
                    end
                end

                filterDescendantsInstances[#filterDescendantsInstances + 1] = partOnRay
                v121 = v122 - a100 * 0.001
            end
        until magnitude2 < math.huge or not partOnRay

        local v132 = filterDescendantsInstances

        for index = #v132, filterDescendantsInstanceCount + 1, -1 do
            v132[index] = nil
        end
    end

    debug.profileend()

    return magnitude - nearPlaneZ, magnitude2 - nearPlaneZ
end

queryViewport = function(a134, a135)
    --[[
      name: queryViewport
      line: 373
      upvalues:
        camera (ref,  index: 1)
        userFlag2 (copy, index: 2)
        v14 (copy, index: 3)
        v28 (ref,  index: 4)
        v29 (ref,  index: 5)
        nearPlaneZ (ref,  index: 6)
        queryPoint (copy, index: 7)
    ]]
    debug.profilebegin("queryViewport")
    local position = a134.Position
    local rightVector = a134.rightVector
    local upVector = a134.upVector
    local v139 = -a134.lookVector
    camera = if userFlag2 then v14:getCamera() else camera
    local viewportSize = camera.ViewportSize
    local minValue = math.huge
    local minValue2 = math.huge

    for index = 0, 1 do
        local v144 = rightVector * ((index - 0.5) * v28)
        local v145

        for index2 = 0, 1 do
            local v147 = position + nearPlaneZ * (v144 + upVector * ((index2 - 0.5) * v29))
            local camera2 = camera
            local v149
            v145, v149 = queryPoint(v147, v139, a135, camera2:ViewportPointToRay(viewportSize.x * index, viewportSize.y * index2).Origin)

            if v149 < minValue then
                minValue = v149
            end

            if v145 < minValue2 then
                minValue2 = v145
            end
        end
    end

    debug.profileend()

    return minValue2, minValue
end

local function testPromotion(a151, a152, a153)
    --[[
      name: testPromotion
      line: 413
      upvalues:
        getCollisionPoint (copy, index: 1)
        mathMin (copy, index: 2)
        queryPoint (copy, index: 3)
        v87 (copy, index: 4)
    ]]
    debug.profilebegin("testPromotion")
    local position = a151.Position
    local rightVector = a151.rightVector
    local upVector = a151.upVector
    local v157 = -a151.lookVector
    debug.profilebegin("extrapolate")
    local magnitude = (getCollisionPoint(position, a153.posVelocity * 1.25) - position).Magnitude
    local magnitude2 = a153.posVelocity.magnitude

    for index = 0, mathMin(1.25, a153.rotVelocity.magnitude + (magnitude / magnitude2)), 0.0625 do
        local v161 = a153.extrapolate(index)

        if a152 <= queryPoint(v161.Position, -v161.lookVector, a152) then
            return false
        end
    end

    debug.profileend()
    debug.profilebegin("testOffsets")

    for _, vector2 in ipairs(v87) do
        local collisionPoint = getCollisionPoint(position, rightVector * vector2.x + (upVector * vector2.y))

        if queryPoint(collisionPoint, ((position + (v157 * a152)) - collisionPoint).Unit, a152) == math.huge then
            return false
        end
    end

    debug.profileend()
    debug.profileend()

    return true
end

return function(a165, a166, a167)
    --[[
      name: Popper
      line: 462
      upvalues:
        v79 (ref,  index: 1)
        v80 (ref,  index: 2)
        queryViewport (copy, index: 3)
        testPromotion (copy, index: 4)
    ]]
    debug.profilebegin("popper")
    v79 = v80 and v80:GetRootPart() or v80
    local v168, v169 = queryViewport(a165, a166)
    local v170 = if v169 < a166 then v169 else a166

    if v168 < v170 and testPromotion(a165, a166, a167) then
        v170 = v168
    end

    v79 = nil
    debug.profileend()

    return v170
end