local success, isUserFeatureEnabled = pcall(
    function()
        --[[
          line: 10
        ]]
        return UserSettings():IsUserFeatureEnabled("UserExcludeNonCollidableForPathfinding")
    end
)
local isUserFeatureEnabled2 = success and isUserFeatureEnabled
local success2, isUserFeatureEnabled3 = pcall(
    function()
        --[[
          line: 17
        ]]
        return UserSettings():IsUserFeatureEnabled("UserClickToMoveSupportAgentCanClimb2")
    end
)
local isUserFeatureEnabled4 = success2 and isUserFeatureEnabled3
local userInputService = game:GetService("UserInputService")
local pathfindingService = game:GetService("PathfindingService")
local players = game:GetService("Players")
local _ = game:GetService("Debris")
local workspace = game:GetService("Workspace")
local collectionService = game:GetService("CollectionService")
local guiService = game:GetService("GuiService")
local CommonUtils = require(script.Parent.Parent:WaitForChild("CommonUtils"))
local v15 = CommonUtils.get("FlagUtil")
local userFlag = v15.getUserFlag("UserRaycastUpdateAPI2")
local userFlag2 = v15.getUserFlag("UserPSIASClickToMoveRelaxTeleport")
local userFlag3 = v15.getUserFlag("UserPlayerScriptsRefactor2")
local userFlag4 = v15.getUserFlag("UserDoubleJumpButtonFix")
local characterContext = script.Parent.Parent:WaitForChild("InputContexts"):WaitForChild("CharacterContext")
local clickToMoveAction = characterContext:WaitForChild("ClickToMoveAction")
local clickToMovePositionAction = characterContext:WaitForChild("ClickToMovePositionAction")
local v23 = true
local v24 = true
local v25 = false
local v26 = 1
local v27 = 8
local localPlayer = players.LocalPlayer
local ClickToMoveDisplay = require(script.Parent:WaitForChild("ClickToMoveDisplay"))
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
local v31 = {}

if not userFlag then
    local function FindCharacterAncestor(a33)
        --[[
          name: FindCharacterAncestor
          line: 70
          upvalues:
            FindCharacterAncestor (copy, index: 1)
        ]]
        if not a33 then
            return
        elseif const humanoid = a33:FindFirstChildOfClass("Humanoid") then
            return a33, humanoid
        end

        return FindCharacterAncestor(a33.Parent)
    end

    v31.FindCharacterAncestor = FindCharacterAncestor

    local function Raycast(ray, a37: boolean, a38)
        --[[
          name: Raycast
          line: 82
          upvalues:
            workspace (copy, index: 1)
            FindCharacterAncestor (copy, index: 2)
            Raycast (copy, index: 3)
        ]]
        local ignoreDescendantsTable = a38 or {}
        local partOnRay, v41, v42, v43 = workspace:FindPartOnRayWithIgnoreList(ray, ignoreDescendantsTable)
        if not partOnRay then
            return nil, nil
        end

        if a37 and partOnRay.CanCollide == false then
            local v44

            if partOnRay then
                if const humanoid = partOnRay:FindFirstChildOfClass("Humanoid") then
                    v44 = humanoid
                else
                    local _, v47 = FindCharacterAncestor(partOnRay.Parent)
                    v44 = v47
                end
            else
                v44 = nil
            end

            if v44 == nil then
                table.insert(ignoreDescendantsTable, partOnRay)
                return Raycast(ray, a37, ignoreDescendantsTable)
            end
        end

        return partOnRay, v41, v42, v43
    end

    v31.Raycast = Raycast
end

local v48 = {}

local function findPlayerHumanoid(key)
    --[[
      name: findPlayerHumanoid
      line: 104
      upvalues:
        v48 (copy, index: 1)
    ]]
    local character = key and key.Character
    if not character then
        return
    elseif const v52 = v48[key] then
        if v52.Parent == character then
            return v52
        end
    end

    v48[key] = nil
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        v48[key] = humanoid
    end

    return humanoid
end

local v54 = nil
local v55 = nil
local rbxScriptConnection = nil
local rbxScriptConnection2 = nil

local function GetCharacter()
    --[[
      name: GetCharacter
      line: 128
      upvalues:
        localPlayer (copy, index: 1)
    ]]
    return localPlayer and localPlayer.Character
end

local function UpdateIgnoreTag(a60)
    --[[
      name: UpdateIgnoreTag
      line: 132
      upvalues:
        v55 (ref,  index: 1)
        rbxScriptConnection (ref,  index: 2)
        rbxScriptConnection2 (ref,  index: 3)
        v54 (ref,  index: 4)
        localPlayer (copy, index: 5)
        collectionService (copy, index: 6)
    ]]
    if a60 == v55 then
        return
    end

    if rbxScriptConnection then
        rbxScriptConnection:Disconnect()
        rbxScriptConnection = nil
    end

    if rbxScriptConnection2 then
        rbxScriptConnection2:Disconnect()
        rbxScriptConnection2 = nil
    end

    v55 = a60
    v54 = {[1] = localPlayer and localPlayer.Character}

    if v55 ~= nil then
        local tagged = collectionService:GetTagged(v55)

        for _, instance in ipairs(tagged) do
            table.insert(v54, instance)
        end

        rbxScriptConnection = collectionService:GetInstanceAddedSignal(v55):Connect(
            function(instance: Instance)
                --[[
                  line: 152
                  upvalues:
                    v54 (ref, index: 1)
                ]]
                table.insert(v54, instance)
            end
        )

        rbxScriptConnection2 = collectionService:GetInstanceRemovedSignal(v55):Connect(
            function(instance: Instance)
                --[[
                  line: 156
                  upvalues:
                    v54 (ref, index: 1)
                ]]
                for index = 1, #v54 do
                    if v54[index] == instance then
                        v54[index] = v54[#v54]
                        table.remove(v54)

                        return
                    end
                end
            end
        )
    end
end

local function getIgnoreList()
    --[[
      name: getIgnoreList
      line: 168
      upvalues:
        v54 (ref,  index: 1)
        localPlayer (copy, index: 2)
    ]]
    if v54 then
        return v54
    end

    v54 = {}
    assert(v54, "")
    table.insert(v54, (localPlayer and localPlayer.Character))

    return v54
end

local function minV(a69, a70)
    --[[
      name: minV
      line: 178
    ]]
    return (Vector3.new(math.min(a69.X, a70.X), math.min(a69.Y, a70.Y), (math.min(a69.Z, a70.Z))))
end

local function maxV(a72, a73)
    --[[
      name: maxV
      line: 181
    ]]
    return (Vector3.new(math.max(a72.X, a73.X), math.max(a72.Y, a73.Y), (math.max(a72.Z, a73.Z))))
end

local function getCollidableExtentsSize(character: Instance?)
    --[[
      name: getCollidableExtentsSize
      line: 184
    ]]
    if character == nil or character.PrimaryPart == nil then
        return
    end

    assert(character, "")
    assert(character.PrimaryPart, "")
    local v76 = character.PrimaryPart.CFrame:Inverse()
    local vector3 = Vector3.new((1 / 0), (1 / 0), (1 / 0))
    local vector32 = Vector3.new((-1 / 0), (-1 / 0), (-1 / 0))

    for _, descendant in pairs(character:GetDescendants()) do
        if descendant:IsA("BasePart") and descendant.CanCollide then
            local v81 = v76 * descendant.CFrame
            local vector33 = Vector3.new(descendant.Size.X / 2, descendant.Size.Y / 2, descendant.Size.Z / 2)
            local v83 = {
                Vector3.new(vector33.X, vector33.Y, vector33.Z),
                Vector3.new(vector33.X, vector33.Y, -vector33.Z),
                Vector3.new(vector33.X, -vector33.Y, vector33.Z),
                Vector3.new(vector33.X, -vector33.Y, -vector33.Z),
                Vector3.new(-vector33.X, vector33.Y, vector33.Z),
                Vector3.new(-vector33.X, vector33.Y, -vector33.Z),
                Vector3.new(-vector33.X, -vector33.Y, vector33.Z),
                (Vector3.new(-vector33.X, -vector33.Y, -vector33.Z))
            }

            for _, vector34 in ipairs(v83) do
                local v86 = v81 * vector34
                local vector35 = vector3
                vector3 = Vector3.new(math.min(vector35.X, v86.X), math.min(vector35.Y, v86.Y), (math.min(vector35.Z, v86.Z)))
                local vector36 = vector32
                vector32 = Vector3.new(math.max(vector36.X, v86.X), math.max(vector36.Y, v86.Y), (math.max(vector36.Z, v86.Z)))
            end
        end
    end

    local vector37 = vector32 - vector3

    if not (vector37.X < 0) and not (vector37.Y < 0) and not (vector37.Z < 0) then
        return vector37
    end

    return nil
end

local function Pather(a91, targetSurfaceNormal, a93)
    --[[
      name: Pather
      line: 223
      upvalues:
        v25 (ref,  index: 1)
        localPlayer (copy, index: 2)
        v48 (copy, index: 3)
        v26 (ref,  index: 4)
        isUserFeatureEnabled2 (copy, index: 5)
        getCollidableExtentsSize (copy, index: 6)
        isUserFeatureEnabled4 (copy, index: 7)
        pathfindingService (copy, index: 8)
        v23 (ref,  index: 9)
        ClickToMoveDisplay (copy, index: 10)
        v27 (ref,  index: 11)
        userFlag2 (copy, index: 12)
        userFlag (copy, index: 13)
        raycastParams (copy, index: 14)
        v54 (ref,  index: 15)
        workspace (copy, index: 16)
    ]]
    local directPath, directPath2
    local v96
    local v97 = {}

    if a93 == nil then
        directPath = v25
        directPath2 = true
    else
        directPath2, directPath = a93, a93
    end

    v97.Cancelled = false
    v97.Started = false
    v97.Finished = Instance.new("BindableEvent")
    v97.PathFailed = Instance.new("BindableEvent")
    v97.PathComputing = false
    v97.PathComputed = false
    v97.OriginalTargetPoint = a91
    v97.TargetPoint = a91
    v97.TargetSurfaceNormal = targetSurfaceNormal
    v97.DiedConn = nil
    v97.SeatedConn = nil
    v97.BlockedConn = nil
    v97.TeleportedConn = nil
    v97.CurrentPoint = 0
    v97.HumanoidOffsetFromPath = Vector3.new(0, 0, 0)
    v97.CurrentWaypointPosition = nil
    v97.CurrentWaypointPlaneNormal = Vector3.new(0, 0, 0)
    v97.CurrentWaypointPlaneDistance = 0
    v97.CurrentWaypointNeedsJump = false
    v97.CurrentHumanoidPosition = Vector3.new(0, 0, 0)
    v97.CurrentHumanoidVelocity = 0
    v97.NextActionMoveDirection = Vector3.new(0, 0, 0)
    v97.NextActionJump = false
    v97.Timeout = 0
    local localPlayer2 = localPlayer
    local instance = localPlayer2
    instance = localPlayer and localPlayer2.Character

    if instance then
        local v100 = v48[localPlayer2]

        if v100 and v100.Parent == instance then
            v96 = v100
        else
            v48[localPlayer2] = nil
            local humanoid = instance:FindFirstChildOfClass("Humanoid")
            if humanoid then
                v48[localPlayer2] = humanoid
            end

            v96 = humanoid
        end
    else
        v96 = nil
    end

    v97.Humanoid = v96
    v97.OriginPoint = nil
    v97.AgentCanFollowPath = false
    v97.DirectPath = false
    v97.DirectPathRiseFirst = false
    v97.stopTraverseFunc = nil
    v97.setPointFunc = nil
    v97.pointList = nil

    if const rootPart = v97.Humanoid and v97.Humanoid.RootPart then
        v97.OriginPoint = rootPart.CFrame.Position
        local agentRadius = 2
        local agentHeight = 5
        local agentCanJump = true
        local seatPart = v97.Humanoid.SeatPart

        if seatPart and seatPart:IsA("VehicleSeat") then
            if const firstAncestorOfClass = seatPart:FindFirstAncestorOfClass("Model") then
                local primaryPart = firstAncestorOfClass.PrimaryPart
                firstAncestorOfClass.PrimaryPart = seatPart

                if directPath2 then
                    local extentsSize = firstAncestorOfClass:GetExtentsSize()
                    agentRadius = v26 * 0.5 * math.sqrt(extentsSize.X * extentsSize.X + (extentsSize.Z * extentsSize.Z))
                    agentHeight = v26 * extentsSize.Y
                    agentCanJump = false
                    v97.AgentCanFollowPath = true
                    v97.DirectPath = directPath2
                end

                firstAncestorOfClass.PrimaryPart = primaryPart
            end
        else
            local vector3 = nil

            if isUserFeatureEnabled2 then
                local character = localPlayer and localPlayer.Character
                if character ~= nil then
                    vector3 = getCollidableExtentsSize(character)
                end
            end

            if vector3 == nil then
                local character = localPlayer and localPlayer.Character
                vector3 = character:GetExtentsSize()
            end

            assert(vector3, "")
            agentRadius = v26 * 0.5 * math.sqrt(vector3.X * vector3.X + (vector3.Z * vector3.Z))
            agentHeight = v26 * vector3.Y
            agentCanJump = 0 < v97.Humanoid.JumpPower
            v97.AgentCanFollowPath = true
            v97.DirectPath = directPath
            v97.DirectPathRiseFirst = v97.Humanoid.Sit
        end

        if isUserFeatureEnabled4 then
            v97.pathResult = pathfindingService:CreatePath({AgentCanClimb = true, AgentRadius = agentRadius, AgentHeight = agentHeight, AgentCanJump = agentCanJump})
        else
            v97.pathResult = pathfindingService:CreatePath({AgentRadius = agentRadius, AgentHeight = agentHeight, AgentCanJump = agentCanJump})
        end
    end

    function v97.Cleanup(a113)
        --[[
          name: Cleanup
          line: 352
          upvalues:
            v97 (copy, index: 1)
        ]]
        if v97.stopTraverseFunc then
            v97.stopTraverseFunc()
            v97.stopTraverseFunc = nil
        end

        if v97.BlockedConn then
            v97.BlockedConn:Disconnect()
            v97.BlockedConn = nil
        end

        if v97.DiedConn then
            v97.DiedConn:Disconnect()
            v97.DiedConn = nil
        end

        if v97.SeatedConn then
            v97.SeatedConn:Disconnect()
            v97.SeatedConn = nil
        end

        if v97.TeleportedConn then
            v97.TeleportedConn:Disconnect()
            v97.TeleportedConn = nil
        end

        v97.Started = false
    end

    function v97.Cancel(a114)
        --[[
          name: Cancel
          line: 381
          upvalues:
            v97 (copy, index: 1)
        ]]
        v97.Cancelled = true
        v97:Cleanup()
    end

    function v97.IsActive(a115)
        --[[
          name: IsActive
          line: 386
          upvalues:
            v97 (copy, index: 1)
        ]]
        return v97.AgentCanFollowPath and v97.Started and not v97.Cancelled
    end

    function v97.OnPathInterrupted(a116)
        --[[
          name: OnPathInterrupted
          line: 390
          upvalues:
            v97 (copy, index: 1)
        ]]
        v97.Cancelled = true
        v97:OnPointReached(false)
    end

    function v97.ComputePath(a117)
        --[[
          name: ComputePath
          line: 396
          upvalues:
            v97 (copy, index: 1)
        ]]
        if v97.OriginPoint then
            if v97.PathComputed or v97.PathComputing then
                return
            end

            v97.PathComputing = true

            if v97.AgentCanFollowPath then
                if v97.DirectPath then
                    local pathWaypoint = PathWaypoint.new(v97.OriginPoint, Enum.PathWaypointAction.Walk)
                    local newPathWaypoint = PathWaypoint.new
                    local targetPoint = v97.TargetPoint
                    local v121 = v97.DirectPathRiseFirst and Enum.PathWaypointAction.Jump
                        or Enum.PathWaypointAction.Walk
                    v97.pointList = {pathWaypoint, newPathWaypoint(targetPoint, v121)}
                    v97.PathComputed = true
                else
                    v97.pathResult:ComputeAsync(v97.OriginPoint, v97.TargetPoint)
                    v97.pointList = v97.pathResult:GetWaypoints()
                    v97.BlockedConn = v97.pathResult.Blocked:Connect(
                        function(a122)
                            --[[
                              line: 415
                              upvalues:
                                v97 (copy, index: 1)
                            ]]
                            v97:OnPathBlocked(a122)
                        end
                    )
                    v97.PathComputed = v97.pathResult.Status == Enum.PathStatus.Success
                end
            end

            v97.PathComputing = false
        end
    end

    function v97.IsValidPath(a123)
        --[[
          name: IsValidPath
          line: 425
          upvalues:
            v97 (copy, index: 1)
        ]]
        v97:ComputePath()
        return v97.PathComputed and v97.AgentCanFollowPath
    end

    v97.Recomputing = false

    function v97.OnPathBlocked(a124, a125)
        --[[
          name: OnPathBlocked
          line: 431
          upvalues:
            v97 (copy, index: 1)
            v23 (ref,  index: 2)
            ClickToMoveDisplay (copy, index: 3)
        ]]
        if not (v97.CurrentPoint <= a125) or v97.Recomputing then
            return
        end

        v97.Recomputing = true

        if v97.stopTraverseFunc then
            v97.stopTraverseFunc()
            v97.stopTraverseFunc = nil
        end

        v97.OriginPoint = v97.Humanoid.RootPart.CFrame.Position
        v97.pathResult:ComputeAsync(v97.OriginPoint, v97.TargetPoint)
        v97.pointList = v97.pathResult:GetWaypoints()

        if 0 < #v97.pointList then
            v97.HumanoidOffsetFromPath = v97.pointList[1].Position - v97.OriginPoint
        end

        v97.PathComputed = v97.pathResult.Status == Enum.PathStatus.Success

        if v23 then
            local stopTraverseFunc, setPointFunc = ClickToMoveDisplay.CreatePathDisplay(v97.pointList)
            v97.stopTraverseFunc = stopTraverseFunc
            v97.setPointFunc = setPointFunc
        end

        if v97.PathComputed then
            v97.CurrentPoint = 1
            v97:OnPointReached(true)
        else
            v97.PathFailed:Fire()
            v97:Cleanup()
        end

        v97.Recomputing = false
    end

    function v97.OnRenderStepped(a128, a129)
        --[[
          name: OnRenderStepped
          line: 467
          upvalues:
            v97 (copy, index: 1)
            v27 (ref,  index: 2)
        ]]
        if v97.Started and not v97.Cancelled then
            v97.Timeout += a129

            if v27 < v97.Timeout then
                v97:OnPointReached(false)
                return
            end

            v97.CurrentHumanoidPosition = v97.Humanoid.RootPart.Position + v97.HumanoidOffsetFromPath
            v97.CurrentHumanoidVelocity = v97.Humanoid.RootPart.Velocity

            while v97.Started and v97:IsCurrentWaypointReached() do
                v97:OnPointReached(true)
            end

            if v97.Started then
                v97.NextActionMoveDirection = v97.CurrentWaypointPosition - v97.CurrentHumanoidPosition

                if not (1e-06 < v97.NextActionMoveDirection.Magnitude) then
                    v97.NextActionMoveDirection = Vector3.new(0, 0, 0)
                else
                    v97.NextActionMoveDirection = v97.NextActionMoveDirection.Unit
                end

                if v97.CurrentWaypointNeedsJump then
                    v97.NextActionJump = true
                    v97.CurrentWaypointNeedsJump = false

                    return
                end

                v97.NextActionJump = false
            end
        end
    end

    function v97.IsCurrentWaypointReached(a130)
        --[[
          name: IsCurrentWaypointReached
          line: 505
          upvalues:
            v97 (copy, index: 1)
        ]]
        local v131 = v97.CurrentWaypointPlaneNormal == Vector3.new(0, 0, 0)
            or v97.CurrentWaypointPlaneNormal:Dot(v97.CurrentHumanoidPosition) - v97.CurrentWaypointPlaneDistance < math.max(1, 0.0625 * -v97.CurrentWaypointPlaneNormal:Dot(v97.CurrentHumanoidVelocity))
        if v131 then
            v97.CurrentWaypointPosition = nil
            v97.CurrentWaypointPlaneNormal = Vector3.new(0, 0, 0)
            v97.CurrentWaypointPlaneDistance = 0
        end

        return v131
    end

    function v97.OnPointReached(a132, a133)
        --[[
          name: OnPointReached
          line: 532
          upvalues:
            v97 (copy, index: 1)
        ]]
        if not a133 or v97.Cancelled then
            v97.PathFailed:Fire()
            v97:Cleanup()

            return
        end

        if v97.setPointFunc then
            v97.setPointFunc(v97.CurrentPoint)
        end

        local v134 = v97.CurrentPoint + 1

        if #v97.pointList < v134 then
            if v97.stopTraverseFunc then
                v97.stopTraverseFunc()
            end

            v97.Finished:Fire()
            v97:Cleanup()

            return
        end

        local v135 = v97.pointList[v97.CurrentPoint]
        local v136 = v97.pointList[v134]
        local state = v97.Humanoid:GetState()

        if state == Enum.HumanoidStateType.FallingDown
            or state == Enum.HumanoidStateType.Freefall
            or (state == Enum.HumanoidStateType.Jumping)
        then
            local v138 = v136.Action == Enum.PathWaypointAction.Jump

            if not v138 and 1 < v97.CurrentPoint then
                local v139 = v97.pointList[v97.CurrentPoint - 1]
                local v140 = v135.Position - v139.Position
                local v141 = v136.Position - v135.Position
                local unit = Vector2.new(v140.x, v140.z).Unit
                v138 = unit:Dot(Vector2.new(v141.x, v141.z).Unit) < 0.996
            end

            if v138 then
                v97.Humanoid.FreeFalling:Wait()
                wait(0.1)
            end
        end

        v97:MoveToNextWayPoint(v135, v136, v134)
    end

    function v97.MoveToNextWayPoint(a143, a144, a145, currentPoint)
        --[[
          name: MoveToNextWayPoint
          line: 594
          upvalues:
            v97 (copy, index: 1)
            isUserFeatureEnabled4 (copy, index: 2)
        ]]
        v97.CurrentWaypointPlaneNormal = a144.Position - a145.Position

        if not isUserFeatureEnabled4 or a145.Label ~= "Climb" then
            v97.CurrentWaypointPlaneNormal = Vector3.new(v97.CurrentWaypointPlaneNormal.X, 0, v97.CurrentWaypointPlaneNormal.Z)
        end

        if not (1e-06 < v97.CurrentWaypointPlaneNormal.Magnitude) then
            v97.CurrentWaypointPlaneNormal = Vector3.new(0, 0, 0)
            v97.CurrentWaypointPlaneDistance = 0
        else
            v97.CurrentWaypointPlaneNormal = v97.CurrentWaypointPlaneNormal.Unit
            v97.CurrentWaypointPlaneDistance = v97.CurrentWaypointPlaneNormal:Dot(a145.Position)
        end

        v97.CurrentWaypointNeedsJump = a145.Action == Enum.PathWaypointAction.Jump
        v97.CurrentWaypointPosition = a145.Position
        v97.CurrentPoint = currentPoint
        v97.Timeout = 0
    end

    function v97.Start(a147, a148)
        --[[
          name: Start
          line: 627
          upvalues:
            v97 (copy, index: 1)
            ClickToMoveDisplay (copy, index: 2)
            v23 (ref,  index: 3)
            userFlag2 (copy, index: 4)
        ]]
        if not v97.AgentCanFollowPath then
            v97.PathFailed:Fire()
            return
        end

        if v97.Started then
            return
        end

        v97.Started = true
        ClickToMoveDisplay.CancelFailureAnimation()

        if v23 and (a148 == nil or a148) then
            local stopTraverseFunc, setPointFunc = ClickToMoveDisplay.CreatePathDisplay(v97.pointList, v97.OriginalTargetPoint)
            v97.stopTraverseFunc = stopTraverseFunc
            v97.setPointFunc = setPointFunc
        end

        if not (0 < #v97.pointList) then
            v97.PathFailed:Fire()

            if v97.stopTraverseFunc then
                v97.stopTraverseFunc()
            end
        else
            v97.HumanoidOffsetFromPath = Vector3.new(0, v97.pointList[1].Position.Y - v97.OriginPoint.Y, 0)
            v97.CurrentHumanoidPosition = v97.Humanoid.RootPart.Position + v97.HumanoidOffsetFromPath
            v97.CurrentHumanoidVelocity = v97.Humanoid.RootPart.Velocity
            v97.SeatedConn = v97.Humanoid.Seated:Connect(
                function(a151, a152)
                    --[[
                      line: 657
                      upvalues:
                        v97 (copy, index: 1)
                    ]]
                    v97:OnPathInterrupted()
                end
            )
            v97.DiedConn = v97.Humanoid.Died:Connect(
                function()
                    --[[
                      line: 660
                      upvalues:
                        v97 (copy, index: 1)
                    ]]
                    v97:OnPathInterrupted()
                end
            )

            if userFlag2 then
                v97.lastPosition = v97.Humanoid.RootPart.CFrame.Position

                v97.TeleportedConn = v97.Humanoid.RootPart:GetPropertyChangedSignal("CFrame"):Connect(
                    function()
                        --[[
                          line: 665
                          upvalues:
                            v97 (copy, index: 1)
                        ]]
                        local position = v97.Humanoid.RootPart.CFrame.Position
                        local magnitude = (position - v97.lastPosition).Magnitude
                        v97.lastPosition = position

                        if v97.Humanoid.WalkSpeed < magnitude then
                            v97:OnPathInterrupted()
                        end
                    end
                )
            else
                v97.TeleportedConn = v97.Humanoid.RootPart:GetPropertyChangedSignal("CFrame"):Connect(
                    function()
                        --[[
                          line: 674
                          upvalues:
                            v97 (copy, index: 1)
                        ]]
                        v97:OnPathInterrupted()
                    end
                )
            end

            v97.CurrentPoint = 1
            v97:OnPointReached(true)
        end
    end

    local origin = v97.TargetPoint + v97.TargetSurfaceNormal * 1.5

    if userFlag then
        local filterDescendantsInstances

        if v54 then
            filterDescendantsInstances = v54
        else
            v54 = {}
            assert(v54, "")
            table.insert(v54, (localPlayer and localPlayer.Character))
            filterDescendantsInstances = v54
        end

        raycastParams.FilterDescendantsInstances = filterDescendantsInstances

        if const raycastResult = workspace:Raycast(origin, Vector3.new(-0, -50, -0), raycastParams) then
            v97.TargetPoint = raycastResult.Position
        end
    else
        local v158
        local ray = Ray.new(origin, Vector3.new(0, -50, 0))

        if v54 then
            v158 = v54
        else
            v54 = {}
            assert(v54, "")
            table.insert(v54, (localPlayer and localPlayer.Character))
            v158 = v54
        end

        local partOnRay, targetPoint = workspace:FindPartOnRayWithIgnoreList(ray, v158)
        if partOnRay then
            v97.TargetPoint = targetPoint
        end
    end

    v97:ComputePath()

    return v97
end

local function CheckAlive()
    --[[
      name: CheckAlive
      line: 713
      upvalues:
        localPlayer (copy, index: 1)
        v48 (copy, index: 2)
    ]]
    local v163
    local localPlayer2 = localPlayer
    local instance = localPlayer2
    instance = localPlayer and localPlayer2.Character

    if instance then
        local v166 = v48[localPlayer2]

        if v166 and v166.Parent == instance then
            v163 = v166
        else
            v48[localPlayer2] = nil
            local humanoid = instance:FindFirstChildOfClass("Humanoid")
            if humanoid then
                v48[localPlayer2] = humanoid
            end

            v163 = humanoid
        end
    else
        v163 = nil
    end

    return (v163 ~= nil) and (0 < v163.Health)
end

local function GetEquippedTool(a169)
    --[[
      name: GetEquippedTool
      line: 718
    ]]
    if a169 ~= nil then
        for _, child in pairs(a169:GetChildren()) do
            if child:IsA("Tool") then
                return child
            end
        end
    end
end

local function DisconnectEvent(a173)
    --[[
      name: DisconnectEvent
      line: 728
    ]]
    if a173 then
        a173:Disconnect()
    end
end

local function calculateLocalMoveVector(nextActionMoveDirection)
    --[[
      name: calculateLocalMoveVector
      line: 734
      upvalues:
        workspace (copy, index: 1)
    ]]
    local vector3 = Vector3.new(nextActionMoveDirection.X, 0, nextActionMoveDirection.Z)

    if vector3.Magnitude < 1e-06 then
        return Vector2.zero
    end

    local unit = vector3.Unit
    local camera = workspace.CurrentCamera
    if not camera then
        return Vector2.new(unit.X, -unit.Z)
    end

    local _, rotationY = camera.CFrame:ToEulerAnglesYXZ()
    local objectSpaceUnit = CFrame.Angles(0, rotationY, 0):VectorToObjectSpace(unit)

    return Vector2.new(objectSpaceUnit.X, -objectSpaceUnit.Z)
end

local Class = {}
Class.__index = Class

function Class.new(a183)
    --[[
      name: new
      line: 754
      upvalues:
        Class (copy, index: 1)
        userFlag4 (copy, index: 2)
    ]]
    local v184 = setmetatable({}, Class)
    v184.mouse2DownTime = tick()
    v184.mouse2DownPos = Vector2.new()
    v184.mouse2UpTime = tick()
    v184.humanoidDiedConn = nil
    v184.characterChildAddedConn = nil
    v184.onCharacterAddedConn = nil
    v184.characterChildRemovedConn = nil
    v184.renderSteppedConn = nil
    v184.menuOpenedConnection = nil
    v184.preferredInputChangedConnection = nil

    if not userFlag4 then
        v184.jumpEnabled = true
    end

    v184.clickPressedConn = nil
    v184.clickReleasedConn = nil
    v184.shouldCleanupPath = false
    v184.lastPatherJumped = false
    v184.data = nil
    v184.running = false

    return v184
end

local v185 = nil
local v186 = nil
local v187 = nil

function Class.CleanupPath(self)
    --[[
      name: CleanupPath
      line: 788
      upvalues:
        v185 (ref, index: 1)
        v186 (ref, index: 2)
        v187 (ref, index: 3)
    ]]
    if v185 then
        v185:Cancel()
        v185 = nil
    end

    if v186 then
        v186:Disconnect()
        v186 = nil
    end

    if v187 then
        v187:Disconnect()
        v187 = nil
    end

    self.shouldCleanupPath = true
end

function Class.HandleMoveTo(self, a190, a191, a192, a193, a194)
    --[[
      name: HandleMoveTo
      line: 807
      upvalues:
        v185 (ref,  index: 1)
        v186 (ref,  index: 2)
        GetEquippedTool (copy, index: 3)
        v187 (ref,  index: 4)
        v24 (ref,  index: 5)
        ClickToMoveDisplay (copy, index: 6)
    ]]
    self.shouldCleanupPath = false

    if v185 then
        self:CleanupPath()
    end

    v185 = a190
    a190:Start(a194)

    v186 = a190.Finished.Event:Connect(
        function()
            --[[
              line: 816
              upvalues:
                self (copy, index: 1)
                a192 (copy, index: 2)
                GetEquippedTool (copy, index: 3)
                a193 (copy, index: 4)
            ]]
            self:CleanupPath()

            if a192 then
                if const equippedTool = GetEquippedTool(a193) then
                    equippedTool:Activate()
                end
            end
        end
    )

    v187 = a190.PathFailed.Event:Connect(
        function()
            --[[
              line: 825
              upvalues:
                self (copy, index: 1)
                a194 (copy, index: 2)
                v24 (ref,  index: 3)
                v185 (ref,  index: 4)
                ClickToMoveDisplay (copy, index: 5)
                a191 (copy, index: 6)
            ]]
            self:CleanupPath()

            if a194 == nil or a194 then
                local v196 = v24 and not (v185 and v185:IsActive())
                if v196 then
                    ClickToMoveDisplay.PlayFailureAnimation()
                end

                ClickToMoveDisplay.DisplayFailureWaypoint(a191)
            end
        end
    )
end

function Class.ShowPathFailedFeedback(self, a198)
    --[[
      name: ShowPathFailedFeedback
      line: 837
      upvalues:
        v185 (ref,  index: 1)
        v24 (ref,  index: 2)
        ClickToMoveDisplay (copy, index: 3)
    ]]
    if v185 and v185:IsActive() then
        v185:Cancel()
    end

    if v24 then
        ClickToMoveDisplay.PlayFailureAnimation()
    end

    ClickToMoveDisplay.DisplayFailureWaypoint(a198)
end

function Class.OnTap(self, a200, a201)
    --[[
      name: OnTap
      line: 847
      upvalues:
        workspace (copy, index: 1)
        localPlayer (copy, index: 2)
        v48 (copy, index: 3)
        userFlag (copy, index: 4)
        v54 (ref,  index: 5)
        raycastParams (copy, index: 6)
        Pather (copy, index: 7)
        v31 (copy, index: 8)
        GetEquippedTool (copy, index: 9)
    ]]
    local v202
    local camera = workspace.CurrentCamera
    local character = localPlayer.Character
    local localPlayer2 = localPlayer
    local instance2 = localPlayer2
    instance2 = localPlayer and localPlayer2.Character

    if instance2 then
        local v207 = v48[localPlayer2]

        if v207 and v207.Parent == instance2 then
            v202 = v207
        else
            v48[localPlayer2] = nil
            local humanoid = instance2:FindFirstChildOfClass("Humanoid")
            if humanoid then
                v48[localPlayer2] = humanoid
            end

            v202 = humanoid
        end
    else
        v202 = nil
    end

    if v202 == nil or not (0 < v202.Health) then
        return
    end

    if #a200 == 1 or a201 then
        if camera then
            local ray = camera:ScreenPointToRay(a200[1].X, a200[1].Y)

            if userFlag then
                local filterDescendantsInstances
                local raycastResult, instance
                local v213 = nil

                if v54 then
                    filterDescendantsInstances = v54
                else
                    v54 = {}
                    assert(v54, "")
                    table.insert(v54, (localPlayer and localPlayer.Character))
                    filterDescendantsInstances = v54
                end

                filterDescendantsInstances = filterDescendantsInstances or {}

                repeat
                    local v214 = true
                    raycastParams.FilterDescendantsInstances = filterDescendantsInstances
                    raycastResult = workspace:Raycast(ray.Origin, ray.Direction * 1000, raycastParams)

                    if raycastResult then
                        instance = raycastResult.Instance

                        if not instance.CanCollide then
                            local v215, humanoid, parent
                            v215 = instance

                            while true do
                                humanoid = v215:FindFirstChildOfClass("Humanoid")
                                parent = v215.Parent

                                if humanoid then
                                    break
                                end
                                if not parent then
                                    break
                                end

                                v215 = parent
                            end

                            if not humanoid and parent then
                                v214 = false
                                table.insert(filterDescendantsInstances, parent)
                                v213 = nil
                            else
                                v213 = v215
                            end
                        end
                    end
                until v214

                if not raycastResult or not character then
                    return
                end

                local v218 = raycastResult.Position

                if a201 then
                    v218, v213 = a201, nil
                end

                self:CleanupPath()
                local v219 = Pather(v218, raycastResult.Normal)

                if v219:IsValidPath() then
                    self:HandleMoveTo(v219, v218, v213, character)
                    return
                end

                v219:Cleanup()
                self:ShowPathFailedFeedback(v218)

                return
            end

            local v220
            local ray2 = Ray.new(ray.Origin, ray.Direction * 1000)
            local raycast = v31.Raycast

            if v54 then
                v220 = v54
            else
                v54 = {}
                assert(v54, "")
                table.insert(v54, (localPlayer and localPlayer.Character))
                v220 = v54
            end

            local v223, v224, targetSurfaceNormal = raycast(ray2, true, v220)
            local characterAncestor = v31.FindCharacterAncestor(v223)

            if a201 then
                v224, characterAncestor = a201, nil
            end

            if v224 and character then
                self:CleanupPath()
                local v227 = Pather(v224, targetSurfaceNormal)

                if v227:IsValidPath() then
                    self:HandleMoveTo(v227, v224, characterAncestor, character)
                    return
                end

                v227:Cleanup()
                self:ShowPathFailedFeedback(v224)
            end
        end
    elseif 2 <= #a200 and camera then
        if const equippedTool = GetEquippedTool(character) then
            equippedTool:Activate()
        end
    end
end

function Class.DisconnectEvents(self)
    --[[
      name: DisconnectEvents
      line: 944
    ]]
    if const humanoidDiedConn = self.humanoidDiedConn then
        humanoidDiedConn:Disconnect()
    end

    if const characterChildAddedConn = self.characterChildAddedConn then
        characterChildAddedConn:Disconnect()
    end

    if const onCharacterAddedConn = self.onCharacterAddedConn then
        onCharacterAddedConn:Disconnect()
    end

    if const renderSteppedConn = self.renderSteppedConn then
        renderSteppedConn:Disconnect()
    end

    if const characterChildRemovedConn = self.characterChildRemovedConn then
        characterChildRemovedConn:Disconnect()
    end

    if const menuOpenedConnection = self.menuOpenedConnection then
        menuOpenedConnection:Disconnect()
    end

    if const preferredInputChangedConnection = self.preferredInputChangedConnection then
        preferredInputChangedConnection:Disconnect()
    end

    if const clickPressedConn = self.clickPressedConn then
        clickPressedConn:Disconnect()
    end

    if const clickReleasedConn = self.clickReleasedConn then
        clickReleasedConn:Disconnect()
    end
end

function Class.OnPreferredInputChanged(self)
    --[[
      name: OnPreferredInputChanged
      line: 956
      upvalues:
        localPlayer (copy, index: 1)
        userInputService (copy, index: 2)
    ]]
    if const character = localPlayer.Character then
        local manualActivationOnly = userInputService.PreferredInput == Enum.PreferredInput.Touch

        for _, child in pairs(character:GetChildren()) do
            if child:IsA("Tool") then
                child.ManualActivationOnly = manualActivationOnly
            end
        end
    end
end

function Class.OnCharacterAdded(self, a245)
    --[[
      name: OnCharacterAdded
      line: 968
      upvalues:
        clickToMoveAction (copy, index: 1)
        guiService (copy, index: 2)
        clickToMovePositionAction (copy, index: 3)
        userFlag3 (copy, index: 4)
        v185 (ref,  index: 5)
        userInputService (copy, index: 6)
    ]]
    self:DisconnectEvents()

    self.clickPressedConn = clickToMoveAction.Pressed:Connect(
        function()
            --[[
              line: 971
              upvalues:
                guiService (copy, index: 1)
                clickToMovePositionAction (copy, index: 2)
                userFlag3 (copy, index: 3)
                self (copy, index: 4)
            ]]
            local mouse2downPos
            local guiInset = guiService:GetGuiInset()
            local state = clickToMovePositionAction:GetState()

            if state.X == -1 and state.Y == -1 then
                return
            end

            if userFlag3 then
                local min = guiService:GetInsetArea(Enum.ScreenInsets.None).Min
                mouse2downPos = Vector2.new(state.X + min.X, state.Y + min.Y)
            else
                mouse2downPos = Vector2.new(state.X - guiInset.X, state.Y - guiInset.Y)
            end

            self.mouse2DownPos = mouse2downPos
            self.mouse2DownTime = tick()
        end
    )

    self.clickReleasedConn = clickToMoveAction.Released:Connect(
        function()
            --[[
              line: 987
              upvalues:
                self (copy, index: 1)
                v185 (ref,  index: 2)
            ]]
            self.mouse2UpTime = tick()
            local mouse2downPos = self.mouse2DownPos

            if self.data and self.data.controlModule.actions.MoveAction then
                local v251 = v185 or self.data.controlModule.actions.MoveAction:GetState().Magnitude <= 0

                if self.mouse2UpTime - self.mouse2DownTime < 0.25 and v251 then
                    self:OnTap({mouse2downPos})
                end
            end
        end
    )

    self.menuOpenedConnection = guiService.MenuOpened:Connect(
        function()
            --[[
              line: 1002
              upvalues:
                self (copy, index: 1)
            ]]
            self:CleanupPath()
        end
    )

    local function OnCharacterChildAdded(a253)
        --[[
          name: OnCharacterChildAdded
          line: 1006
          upvalues:
            userInputService (copy, index: 1)
            self (copy, index: 2)
        ]]
        if userInputService.PreferredInput == Enum.PreferredInput.Touch and a253:IsA("Tool") then
            a253.ManualActivationOnly = true
        end

        if a253:IsA("Humanoid") then
            if const humanoidDiedConn = self.humanoidDiedConn then
                humanoidDiedConn:Disconnect()
            end

            self.humanoidDiedConn = a253.Died:Connect(function()
                --[[
                  line: 1014
                ]]
            end)
        end
    end

    self.characterChildAddedConn = a245.ChildAdded:Connect(
        function(a255)
            --[[
              line: 1022
              upvalues:
                OnCharacterChildAdded (copy, index: 1)
            ]]
            OnCharacterChildAdded(a255)
        end
    )

    self.characterChildRemovedConn = a245.ChildRemoved:Connect(
        function(a256)
            --[[
              line: 1025
              upvalues:
                userInputService (copy, index: 1)
            ]]
            if userInputService.PreferredInput == Enum.PreferredInput.Touch and a256:IsA("Tool") then
                a256.ManualActivationOnly = false
            end
        end
    )

    for _, child in pairs(a245:GetChildren()) do
        OnCharacterChildAdded(child)
    end

    self.preferredInputChangedConnection = userInputService:GetPropertyChangedSignal("PreferredInput"):Connect(
        function()
            --[[
              line: 1037
              upvalues:
                self (copy, index: 1)
            ]]
            self:OnPreferredInputChanged()
        end
    )
end

function Class.Start(self)
    --[[
      name: Start
      line: 1042
    ]]
    self:Enable(true)
end

function Class.Stop(self)
    --[[
      name: Stop
      line: 1046
    ]]
    self:Enable(false)
end

function Class.Enable(self, enabled: boolean, a263, touchJumpController)
    --[[
      name: Enable
      line: 1051
      upvalues:
        localPlayer (copy, index: 1)
        userFlag4 (copy, index: 2)
        userInputService (copy, index: 3)
        clickToMoveAction (copy, index: 4)
        clickToMovePositionAction (copy, index: 5)
    ]]
    if enabled then
        if not self.running then
            if localPlayer.Character then
                self:OnCharacterAdded(localPlayer.Character)
            end

            self.onCharacterAddedConn = localPlayer.CharacterAdded:Connect(
                function(character: Model)
                    --[[
                      line: 1057
                      upvalues:
                        self (copy, index: 1)
                    ]]
                    self:OnCharacterAdded(character)
                end
            )
            self.running = true
        end

        if not userFlag4 then
            self.touchJumpController = touchJumpController

            if self.touchJumpController then
                self.touchJumpController:Enable(self.jumpEnabled)
            end
        end
    else
        if self.running then
            self:DisconnectEvents()
            self:CleanupPath()

            if userInputService.PreferredInput == Enum.PreferredInput.Touch then
                if const character = localPlayer.Character then
                    for _, child in pairs(character:GetChildren()) do
                        if child:IsA("Tool") then
                            child.ManualActivationOnly = false
                        end
                    end
                end
            end

            self.running = false
        end

        if not userFlag4 then
            if self.touchJumpController and not self.jumpEnabled then
                self.touchJumpController:Enable(true)
            end

            self.touchJumpController = nil
        end
    end

    clickToMoveAction.Enabled = enabled
    clickToMovePositionAction.Enabled = enabled
    self.wasdEnabled = enabled and a263 or false
    self.enabled = enabled
end

function Class.Update(self, data, a271)
    --[[
      name: Update
      line: 1100
      upvalues:
        v185 (ref,  index: 1)
        calculateLocalMoveVector (copy, index: 2)
    ]]
    assert(data.controlModule.actions.MoveAction)
    assert(data.controlModule.actions.JumpAction)

    if not self.data then
        self.data = data
    end

    if const v272 = v185 then
        v272:OnRenderStepped(a271)

        if v185 and v185 == v272 then
            local moveVector = calculateLocalMoveVector(v272.NextActionMoveDirection)

            if const clickToMoveScriptableBinding = data.controlModule.actions.MoveAction:FindFirstChild("ClickToMoveScriptableBinding") then
                clickToMoveScriptableBinding:Fire(moveVector)
            end

            data.controlModule.moveVector = moveVector

            if v272.NextActionJump then
                if data.controlModule.actions.JumpAction:GetState() ~= true then
                    if const clickToMoveScriptableBinding2 = data.controlModule.actions.JumpAction:FindFirstChild("ClickToMoveScriptableBinding") then
                        clickToMoveScriptableBinding2:Fire(true)
                    end
                end

                self.lastPatherJumped = true
                data.controlModule.isJumping = true
            elseif self.lastPatherJumped then
                if data.controlModule.actions.JumpAction:GetState() == true then
                    if const clickToMoveScriptableBinding3 = data.controlModule.actions.JumpAction:FindFirstChild("ClickToMoveScriptableBinding") then
                        clickToMoveScriptableBinding3:Fire(false)
                    end
                end

                self.lastPatherJumped = false
                data.controlModule.isJumping = false
            end
        elseif self.lastPatherJumped then
            if data.controlModule.actions.JumpAction:GetState() == true then
                if const clickToMoveScriptableBinding = data.controlModule.actions.JumpAction:FindFirstChild("ClickToMoveScriptableBinding") then
                    clickToMoveScriptableBinding:Fire(false)
                end
            end

            self.lastPatherJumped = false
        end
    end

    if self.shouldCleanupPath then
        self.shouldCleanupPath = false

        if const clickToMoveScriptableBinding = data.controlModule.actions.MoveAction:FindFirstChild("ClickToMoveScriptableBinding") then
            clickToMoveScriptableBinding:Fire(Vector2.zero)
        end

        data.controlModule.moveVector = Vector2.zero
        self.lastPatherJumped = false

        if const clickToMoveScriptableBinding4 = data.controlModule.actions.JumpAction:FindFirstChild("ClickToMoveScriptableBinding") then
            clickToMoveScriptableBinding4:Fire(false)
        end

        data.controlModule.isJumping = false
    end
end

function Class.SetShowPath(a280, a281)
    --[[
      name: SetShowPath
      line: 1176
      upvalues:
        v23 (ref, index: 1)
    ]]
    v23 = a281
end

function Class.GetShowPath(a282)
    --[[
      name: GetShowPath
      line: 1180
      upvalues:
        v23 (ref, index: 1)
    ]]
    return v23
end

function Class.SetWaypointTexture(a283, a284)
    --[[
      name: SetWaypointTexture
      line: 1184
      upvalues:
        ClickToMoveDisplay (copy, index: 1)
    ]]
    ClickToMoveDisplay.SetWaypointTexture(a284)
end

function Class.GetWaypointTexture(a285)
    --[[
      name: GetWaypointTexture
      line: 1188
      upvalues:
        ClickToMoveDisplay (copy, index: 1)
    ]]
    return ClickToMoveDisplay.GetWaypointTexture()
end

function Class.SetWaypointRadius(a286, a287)
    --[[
      name: SetWaypointRadius
      line: 1192
      upvalues:
        ClickToMoveDisplay (copy, index: 1)
    ]]
    ClickToMoveDisplay.SetWaypointRadius(a287)
end

function Class.GetWaypointRadius(a288)
    --[[
      name: GetWaypointRadius
      line: 1196
      upvalues:
        ClickToMoveDisplay (copy, index: 1)
    ]]
    return ClickToMoveDisplay.GetWaypointRadius()
end

function Class.SetEndWaypointTexture(a289, a290)
    --[[
      name: SetEndWaypointTexture
      line: 1200
      upvalues:
        ClickToMoveDisplay (copy, index: 1)
    ]]
    ClickToMoveDisplay.SetEndWaypointTexture(a290)
end

function Class.GetEndWaypointTexture(a291)
    --[[
      name: GetEndWaypointTexture
      line: 1204
      upvalues:
        ClickToMoveDisplay (copy, index: 1)
    ]]
    return ClickToMoveDisplay.GetEndWaypointTexture()
end

function Class.SetWaypointsAlwaysOnTop(a292, a293)
    --[[
      name: SetWaypointsAlwaysOnTop
      line: 1208
      upvalues:
        ClickToMoveDisplay (copy, index: 1)
    ]]
    ClickToMoveDisplay.SetWaypointsAlwaysOnTop(a293)
end

function Class.GetWaypointsAlwaysOnTop(a294)
    --[[
      name: GetWaypointsAlwaysOnTop
      line: 1212
      upvalues:
        ClickToMoveDisplay (copy, index: 1)
    ]]
    return ClickToMoveDisplay.GetWaypointsAlwaysOnTop()
end

function Class.SetFailureAnimationEnabled(a295, a296)
    --[[
      name: SetFailureAnimationEnabled
      line: 1216
      upvalues:
        v24 (ref, index: 1)
    ]]
    v24 = a296
end

function Class.GetFailureAnimationEnabled(a297)
    --[[
      name: GetFailureAnimationEnabled
      line: 1220
      upvalues:
        v24 (ref, index: 1)
    ]]
    return v24
end

function Class.SetIgnoredPartsTag(a298, a299)
    --[[
      name: SetIgnoredPartsTag
      line: 1224
      upvalues:
        UpdateIgnoreTag (copy, index: 1)
    ]]
    UpdateIgnoreTag(a299)
end

function Class.GetIgnoredPartsTag(a300)
    --[[
      name: GetIgnoredPartsTag
      line: 1228
      upvalues:
        v55 (ref, index: 1)
    ]]
    return v55
end

function Class.SetUseDirectPath(a301, a302)
    --[[
      name: SetUseDirectPath
      line: 1232
      upvalues:
        v25 (ref, index: 1)
    ]]
    v25 = a302
end

function Class.GetUseDirectPath(a303)
    --[[
      name: GetUseDirectPath
      line: 1236
      upvalues:
        v25 (ref, index: 1)
    ]]
    return v25
end

function Class.SetAgentSizeIncreaseFactor(a304, a305)
    --[[
      name: SetAgentSizeIncreaseFactor
      line: 1240
      upvalues:
        v26 (ref, index: 1)
    ]]
    v26 = (a305 / 100) + 1
end

function Class.GetAgentSizeIncreaseFactor(a306)
    --[[
      name: GetAgentSizeIncreaseFactor
      line: 1244
      upvalues:
        v26 (ref, index: 1)
    ]]
    return (v26 - 1) * 100
end

function Class.SetUnreachableWaypointTimeout(a307, a308)
    --[[
      name: SetUnreachableWaypointTimeout
      line: 1248
      upvalues:
        v27 (ref, index: 1)
    ]]
    v27 = a308
end

function Class.GetUnreachableWaypointTimeout(a309)
    --[[
      name: GetUnreachableWaypointTimeout
      line: 1252
      upvalues:
        v27 (ref, index: 1)
    ]]
    return v27
end

if not userFlag4 then
    function Class.SetUserJumpEnabled(self, userJumpEnabled)
        --[[
          name: SetUserJumpEnabled
          line: 1257
        ]]
        self.jumpEnabled = userJumpEnabled

        if self.touchJumpController then
            self.touchJumpController:Enable(userJumpEnabled)
        end
    end

    function Class.GetUserJumpEnabled(self)
        --[[
          name: GetUserJumpEnabled
          line: 1264
        ]]
        return self.jumpEnabled
    end
end

function Class.MoveTo(self, a314, a315, a316)
    --[[
      name: MoveTo
      line: 1269
      upvalues:
        localPlayer (copy, index: 1)
        Pather (copy, index: 2)
    ]]
    local character = localPlayer.Character
    if character == nil then
        return false
    end

    local v318 = Pather(a314, Vector3.new(0, 1, 0), a316)

    if not v318 or not v318:IsValidPath() then
        return false
    end

    self:HandleMoveTo(v318, a314, nil, character, a315)

    return true
end

return Class