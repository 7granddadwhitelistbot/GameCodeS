local success_1, v1 = pcall(
    function()
        --[[
          line: 10
        ]]
        return UserSettings():IsUserFeatureEnabled("UserExcludeNonCollidableForPathfinding")
    end
)
local u1 = success_1 and v1
local success_2, v2 = pcall(
    function()
        --[[
          line: 14
        ]]
        return UserSettings():IsUserFeatureEnabled("UserClickToMoveSupportAgentCanClimb2")
    end
)
local u2 = success_2 and v2
local UserInputService_upv_1 = game:GetService("UserInputService")
local PathfindingService_upv_1 = game:GetService("PathfindingService")
local Players_1 = game:GetService("Players")
local _ = game:GetService("Debris")
local Workspace_upv_1 = game:GetService("Workspace")
local CollectionService_upv_1 = game:GetService("CollectionService")
local GuiService_upv_1 = game:GetService("GuiService")
local v3 = require(script.Parent.Parent:WaitForChild("CommonUtils")).get("FlagUtil")
local u3 = v3.getUserFlag("UserRaycastUpdateAPI2")
local u4 = v3.getUserFlag("UserPSIASClickToMoveRelaxTeleport")
local u5 = v3.getUserFlag("UserPlayerScriptsRefactor2")
local u6 = v3.getUserFlag("UserDoubleJumpButtonFix")
local CharacterContext_1 = script.Parent.Parent:WaitForChild("InputContexts"):WaitForChild("CharacterContext")
local ClickToMoveAction_upv_1 = CharacterContext_1:WaitForChild("ClickToMoveAction")
local ClickToMovePositionAction_upv_1 = CharacterContext_1:WaitForChild("ClickToMovePositionAction")
local u7 = true
local u8 = true
local u9 = false
local u10 = 1
local u11 = 8
local LocalPlayer_upv_1 = Players_1.LocalPlayer
local ClickToMoveDisplay_upv_1 = require(script.Parent:WaitForChild("ClickToMoveDisplay"))
local u12 = RaycastParams.new()
u12.FilterType = Enum.RaycastFilterType.Exclude
local tbl_upv_1 = {}
if not (u3) then
    local function FindCharacterAncestor(a1)
        --[[
          name: FindCharacterAncestor
          line: 63
          upvalues:
            FindCharacterAncestor (copy, index: 1)
        ]]
        if not a1 then
            return
        end
        local v4 = a1:FindFirstChildOfClass("Humanoid")
        if v4 then
            return a1, v4
        end
        return FindCharacterAncestor(a1.Parent)
    end
    tbl_upv_1.FindCharacterAncestor = FindCharacterAncestor
    local function Raycast(a1, a2, a3)
        --[[
          name: Raycast
          line: 75
          upvalues:
            Workspace_upv_1 (copy, index: 1)
            FindCharacterAncestor (copy, index: 2)
            Raycast (copy, index: 3)
        ]]
        local v5 = a3 or {}
        local v6, v7, v8, v9 = Workspace_upv_1:FindPartOnRayWithIgnoreList(a1, v5)
        if v6 then
            if a2 and v6.CanCollide == false then
                local v10, v11 = nil, nil
                if v6 then
                    v10 = v6:FindFirstChildOfClass("Humanoid")
                    if v10 then
                        v11 = v10
                    else
                        local _, v12 = FindCharacterAncestor(v6.Parent)
                        v11 = v12
                    end
                else
                    v11 = nil
                end
                if v11 == nil then
                    table.insert(v5, v6)
                    return Raycast(a1, a2, v5)
                end
            end
            return v6, v7, v8, v9
        end
        return nil, nil
    end
    tbl_upv_1.Raycast = Raycast
end
local tbl_upv_2 = {}
local function findPlayerHumanoid(a1)
    --[[
      name: findPlayerHumanoid
      line: 97
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    local v13 = a1 and (a1.Character)
    if not v13 then
        return
    end
    local v14 = tbl_upv_2[a1]
    if v14 and v14.Parent == v13 then
        return v14
    end
    tbl_upv_2[a1] = nil
    local v15 = a1:FindFirstChildOfClass("Humanoid")
    if v15 then
        tbl_upv_2[a1] = v15
    end
    return v15
end
local tbl_upv_3 = nil
local u13 = nil
local u14 = nil
local u15 = nil
local function GetCharacter()
    --[[
      name: GetCharacter
      line: 121
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local v16
    if LocalPlayer_upv_1 then
        v16 = LocalPlayer_upv_1.Character
    else
        v16 = LocalPlayer_upv_1
    end
    return v16
end
local function UpdateIgnoreTag(a1)
    --[[
      name: UpdateIgnoreTag
      line: 125
      upvalues:
        u13 (ref,  index: 1)
        u14 (ref,  index: 2)
        u15 (ref,  index: 3)
        tbl_upv_3 (ref,  index: 4)
        LocalPlayer_upv_1 (copy, index: 5)
        CollectionService_upv_1 (copy, index: 6)
    ]]
    if a1 == u13 then
        return
    end
    if u14 then
        u14:Disconnect()
        u14 = nil
    end
    if u15 then
        u15:Disconnect()
        u15 = nil
    end
    u13 = a1
    local tbl_4 = {}
    local v17
    if LocalPlayer_upv_1 then
        v17 = LocalPlayer_upv_1.Character
    else
        v17 = LocalPlayer_upv_1
    end
    tbl_4[1] = v17
    tbl_upv_3 = tbl_4
    if u13 ~= nil then
        for _, value_1 in ipairs(CollectionService_upv_1:GetTagged(u13)) do
            table.insert(tbl_upv_3, value_1)
        end
        local v18 = CollectionService_upv_1:GetInstanceAddedSignal(u13):Connect(
            function(a2)
                --[[
                  line: 145
                  upvalues:
                    tbl_upv_3 (ref, index: 1)
                ]]
                table.insert(tbl_upv_3, a2)
            end
        )
        u14 = v18
        local v19 = CollectionService_upv_1:GetInstanceRemovedSignal(u13):Connect(
            function(a3)
                --[[
                  line: 149
                  upvalues:
                    tbl_upv_3 (ref, index: 1)
                ]]
                for n_1 = 1, #tbl_upv_3 do
                    if tbl_upv_3[n_1] ~= a3 then
                        continue
                    end
                    tbl_upv_3[n_1] = tbl_upv_3[#tbl_upv_3]
                    table.remove(tbl_upv_3)
                    return
                end
            end
        )
        u15 = v19
    end
end
local function getIgnoreList()
    --[[
      name: getIgnoreList
      line: 161
      upvalues:
        tbl_upv_3 (ref,  index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
    ]]
    if not tbl_upv_3 then
        tbl_upv_3 = {}
        assert(tbl_upv_3, "")
        table.insert(tbl_upv_3, LocalPlayer_upv_1 and (LocalPlayer_upv_1.Character))
    end
    return tbl_upv_3
end
local function minV(a1, a2)
    --[[
      name: minV
      line: 171
    ]]
    return (Vector3.new(math.min(a1.X, a2.X), math.min(a1.Y, a2.Y), math.min(a1.Z, a2.Z)))
end
local function maxV(a1, a2)
    --[[
      name: maxV
      line: 174
    ]]
    return (Vector3.new(math.max(a1.X, a2.X), math.max(a1.Y, a2.Y), math.max(a1.Z, a2.Z)))
end
local function getCollidableExtentsSize(a1)
    --[[
      name: getCollidableExtentsSize
      line: 177
    ]]
    if a1 == nil or a1.PrimaryPart == nil then
        return
    end
    assert(a1, "")
    assert(a1.PrimaryPart, "")
    local v20 = a1.PrimaryPart.CFrame:Inverse()
    local v21 = Vector3.new((1 / 0), (1 / 0), (1 / 0))
    local v22 = Vector3.new((-1 / 0), (-1 / 0), (-1 / 0))
    for _, value_2 in pairs(a1:GetDescendants()) do
        local v23 = value_2:IsA("BasePart")
        if not (v23) or not (value_2.CanCollide) then
            continue
        end
        local v24 = Vector3.new(value_2.Size.X / 2, value_2.Size.Y / 2, value_2.Size.Z / 2)
        for v27, value_3 in ipairs({Vector3.new(v24.X, v24.Y, v24.Z), Vector3.new(v24.X, v24.Y, -v24.Z), Vector3.new(v24.X, -v24.Y, v24.Z), Vector3.new(v24.X, -v24.Y, -v24.Z), Vector3.new(-v24.X, v24.Y, v24.Z), Vector3.new(-v24.X, v24.Y, -v24.Z), Vector3.new(-v24.X, -v24.Y, v24.Z), Vector3.new(-v24.X, -v24.Y, -v24.Z)}) do
            local v25 = v20 * value_2.CFrame * value_3
            v21 = Vector3.new(math.min(v21.X, v25.X), math.min(v21.Y, v25.Y), math.min(v21.Z, v25.Z))
            v22 = Vector3.new(math.max(v22.X, v25.X), math.max(v22.Y, v25.Y), math.max(v22.Z, v25.Z))
        end
    end
    local v26 = v22 - v21
    if not (v26.X < 0) and not (v26.Y < 0) and not (v26.Z < 0) then
        return v26
    end
    return nil
end
local function Pather(a1, a2, a3)
    --[[
      name: Pather
      line: 212
      upvalues:
        u9 (ref,  index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
        tbl_upv_2 (copy, index: 3)
        u10 (ref,  index: 4)
        u1 (copy, index: 5)
        getCollidableExtentsSize (copy, index: 6)
        u2 (copy, index: 7)
        PathfindingService_upv_1 (copy, index: 8)
        u7 (ref,  index: 9)
        ClickToMoveDisplay_upv_1 (copy, index: 10)
        u11 (ref,  index: 11)
        u4 (copy, index: 12)
        u3 (copy, index: 13)
        u12 (copy, index: 14)
        tbl_upv_3 (ref,  index: 15)
        Workspace_upv_1 (copy, index: 16)
    ]]
    local tbl_upv_5 = {}
    local v27, v28
    if a3 == nil then
        v27 = u9
        v28 = true
    else
        v28, v27 = a3, a3
    end
    tbl_upv_5.Cancelled = false
    tbl_upv_5.Started = false
    tbl_upv_5.Finished = Instance.new("BindableEvent")
    tbl_upv_5.PathFailed = Instance.new("BindableEvent")
    tbl_upv_5.PathComputing = false
    tbl_upv_5.PathComputed = false
    tbl_upv_5.OriginalTargetPoint = a1
    tbl_upv_5.TargetPoint = a1
    tbl_upv_5.TargetSurfaceNormal = a2
    tbl_upv_5.DiedConn = nil
    tbl_upv_5.SeatedConn = nil
    tbl_upv_5.BlockedConn = nil
    tbl_upv_5.TeleportedConn = nil
    tbl_upv_5.CurrentPoint = 0
    tbl_upv_5.HumanoidOffsetFromPath = Vector3.new(0, 0, 0)
    tbl_upv_5.CurrentWaypointPosition = nil
    tbl_upv_5.CurrentWaypointPlaneNormal = Vector3.new(0, 0, 0)
    tbl_upv_5.CurrentWaypointPlaneDistance = 0
    tbl_upv_5.CurrentWaypointNeedsJump = false
    tbl_upv_5.CurrentHumanoidPosition = Vector3.new(0, 0, 0)
    tbl_upv_5.CurrentHumanoidVelocity = 0
    tbl_upv_5.NextActionMoveDirection = Vector3.new(0, 0, 0)
    tbl_upv_5.NextActionJump = false
    tbl_upv_5.Timeout = 0
    local v29 = LocalPlayer_upv_1
    local v30 = v29 and (v29.Character)
    local v31, v32, v33 = nil, nil, nil
    if v30 then
        v31 = tbl_upv_2[v29]
        if (v31) and v31.Parent == v30 then
            v33 = v31
        else
            tbl_upv_2[v29] = nil
            v32 = LocalPlayer_upv_1:FindFirstChildOfClass("Humanoid")
            if v32 then
                tbl_upv_2[v29] = v32
            end
            v33 = v32
        end
    else
        v33 = nil
    end
    tbl_upv_5.Humanoid = v33
    tbl_upv_5.OriginPoint = nil
    tbl_upv_5.AgentCanFollowPath = false
    tbl_upv_5.DirectPath = false
    tbl_upv_5.DirectPathRiseFirst = false
    tbl_upv_5.stopTraverseFunc = nil
    tbl_upv_5.setPointFunc = nil
    tbl_upv_5.pointList = nil
    v33 = tbl_upv_5.Humanoid and (tbl_upv_5.Humanoid.RootPart)
    local v34 = nil
    if v33 then
        tbl_upv_5.OriginPoint = v33.CFrame.Position
        v29 = 2
        v30 = 5
        v31 = true
        v34 = tbl_upv_5.Humanoid.SeatPart
        if v34 then
            local v35 = nil
            if v34:IsA("VehicleSeat") then
                v35 = v34:FindFirstAncestorOfClass("Model")
                if v35 then
                    local PrimaryPart_1 = v35.PrimaryPart
                    v35.PrimaryPart = v34
                    if v28 then
                        local v36 = v35:GetExtentsSize()
                        local _ = u10 * 0.5 * math.sqrt((v36.X * v36.X) + (v36.Z * v36.Z))
                        local v59 = u10 * v36.Y
                        v31 = false
                        tbl_upv_5.AgentCanFollowPath = true
                        tbl_upv_5.DirectPath = v28
                    end
                    v35.PrimaryPart = PrimaryPart_1
                end
            else
                local v37 = nil
                if u1 then
                    local v38 = LocalPlayer_upv_1 and (LocalPlayer_upv_1.Character)
                    if v38 ~= nil then
                        v37 = getCollidableExtentsSize(v38)
                    end
                end
                if v37 == nil then
                    v37 = (LocalPlayer_upv_1 and (LocalPlayer_upv_1.Character)):GetExtentsSize()
                end
                assert(v37, "")
                local v39 = u10 * 0.5 * math.sqrt((v37.X * v37.X) + (v37.Z * v37.Z))
                local v40 = u10 * v37.Y
                local v41 = tbl_upv_5.Humanoid.JumpPower > 0
                tbl_upv_5.AgentCanFollowPath = true
                tbl_upv_5.DirectPath = v27
                tbl_upv_5.DirectPathRiseFirst = tbl_upv_5.Humanoid.Sit
                v29, v30, v31 = v39, v40, v41
            end
        else
            local v37 = nil
            if u1 then
                local v38 = LocalPlayer_upv_1 and (LocalPlayer_upv_1.Character)
                if v38 ~= nil then
                    v37 = getCollidableExtentsSize(v38)
                end
            end
            if v37 == nil then
                v37 = (LocalPlayer_upv_1 and (LocalPlayer_upv_1.Character)):GetExtentsSize()
            end
            assert(v37, "")
            local v39 = u10 * 0.5 * math.sqrt((v37.X * v37.X) + (v37.Z * v37.Z))
            local v40 = u10 * v37.Y
            local v41 = tbl_upv_5.Humanoid.JumpPower > 0
            tbl_upv_5.AgentCanFollowPath = true
            tbl_upv_5.DirectPath = v27
            tbl_upv_5.DirectPathRiseFirst = tbl_upv_5.Humanoid.Sit
            v29, v30, v31 = v39, v40, v41
        end
        if u2 then
            tbl_upv_5.pathResult = PathfindingService_upv_1:CreatePath({AgentCanClimb = true, AgentRadius = v29, AgentHeight = v30, AgentCanJump = v31})
        else
            tbl_upv_5.pathResult = PathfindingService_upv_1:CreatePath({AgentRadius = v29, AgentHeight = v30, AgentCanJump = v31})
        end
    end
    function tbl_upv_5.Cleanup(a4)
        --[[
          name: Cleanup
          line: 330
          upvalues:
            tbl_upv_5 (copy, index: 1)
        ]]
        if tbl_upv_5.stopTraverseFunc then
            tbl_upv_5.stopTraverseFunc()
            tbl_upv_5.stopTraverseFunc = nil
        end
        if tbl_upv_5.BlockedConn then
            tbl_upv_5.BlockedConn:Disconnect()
            tbl_upv_5.BlockedConn = nil
        end
        if tbl_upv_5.DiedConn then
            tbl_upv_5.DiedConn:Disconnect()
            tbl_upv_5.DiedConn = nil
        end
        if tbl_upv_5.SeatedConn then
            tbl_upv_5.SeatedConn:Disconnect()
            tbl_upv_5.SeatedConn = nil
        end
        if tbl_upv_5.TeleportedConn then
            tbl_upv_5.TeleportedConn:Disconnect()
            tbl_upv_5.TeleportedConn = nil
        end
        tbl_upv_5.Started = false
    end
    function tbl_upv_5.Cancel(a5)
        --[[
          name: Cancel
          line: 359
          upvalues:
            tbl_upv_5 (copy, index: 1)
        ]]
        tbl_upv_5.Cancelled = true
        tbl_upv_5:Cleanup()
    end
    function tbl_upv_5.IsActive(a6)
        --[[
          name: IsActive
          line: 364
          upvalues:
            tbl_upv_5 (copy, index: 1)
        ]]
        return tbl_upv_5.AgentCanFollowPath and (tbl_upv_5.Started and (not tbl_upv_5.Cancelled))
    end
    function tbl_upv_5.OnPathInterrupted(a7)
        --[[
          name: OnPathInterrupted
          line: 368
          upvalues:
            tbl_upv_5 (copy, index: 1)
        ]]
        tbl_upv_5.Cancelled = true
        tbl_upv_5:OnPointReached(false)
    end
    function tbl_upv_5.ComputePath(a8)
        --[[
          name: ComputePath
          line: 374
          upvalues:
            tbl_upv_5 (copy, index: 1)
        ]]
        if not tbl_upv_5.OriginPoint then
            return
        end
        if not (tbl_upv_5.PathComputed) and not (tbl_upv_5.PathComputing) then
            tbl_upv_5.PathComputing = true
            if tbl_upv_5.AgentCanFollowPath then
                if tbl_upv_5.DirectPath then
                    local v42 = PathWaypoint.new(tbl_upv_5.OriginPoint, Enum.PathWaypointAction.Walk)
                    tbl_upv_5.pointList = {v42, PathWaypoint.new(tbl_upv_5.TargetPoint, ((tbl_upv_5.DirectPathRiseFirst) and (Enum.PathWaypointAction.Jump)) or (Enum.PathWaypointAction.Walk))}
                    tbl_upv_5.PathComputed = true
                else
                    tbl_upv_5.pathResult:ComputeAsync(tbl_upv_5.OriginPoint, tbl_upv_5.TargetPoint)
                    tbl_upv_5.pointList = tbl_upv_5.pathResult:GetWaypoints()
                    tbl_upv_5.BlockedConn = tbl_upv_5.pathResult.Blocked:Connect(
                        function(a9)
                            --[[
                              line: 388
                              upvalues:
                                tbl_upv_5 (copy, index: 1)
                            ]]
                            tbl_upv_5:OnPathBlocked(a9)
                        end
                    )
                    tbl_upv_5.PathComputed = tbl_upv_5.pathResult.Status == Enum.PathStatus.Success
                end
            end
            tbl_upv_5.PathComputing = false
            return
        end
    end
    function tbl_upv_5.IsValidPath(a10)
        --[[
          name: IsValidPath
          line: 396
          upvalues:
            tbl_upv_5 (copy, index: 1)
        ]]
        tbl_upv_5:ComputePath()
        return tbl_upv_5.PathComputed and (tbl_upv_5.AgentCanFollowPath)
    end
    tbl_upv_5.Recomputing = false
    function tbl_upv_5.OnPathBlocked(a11, a12)
        --[[
          name: OnPathBlocked
          line: 402
          upvalues:
            tbl_upv_5 (copy, index: 1)
            u7 (ref,  index: 2)
            ClickToMoveDisplay_upv_1 (copy, index: 3)
        ]]
        if not (tbl_upv_5.CurrentPoint <= a12) or (tbl_upv_5.Recomputing) then
            return
        end
        tbl_upv_5.Recomputing = true
        if tbl_upv_5.stopTraverseFunc then
            tbl_upv_5.stopTraverseFunc()
            tbl_upv_5.stopTraverseFunc = nil
        end
        tbl_upv_5.OriginPoint = tbl_upv_5.Humanoid.RootPart.CFrame.Position
        tbl_upv_5.pathResult:ComputeAsync(tbl_upv_5.OriginPoint, tbl_upv_5.TargetPoint)
        tbl_upv_5.pointList = tbl_upv_5.pathResult:GetWaypoints()
        if #tbl_upv_5.pointList > 0 then
            tbl_upv_5.HumanoidOffsetFromPath = tbl_upv_5.pointList[1].Position - tbl_upv_5.OriginPoint
        end
        tbl_upv_5.PathComputed = tbl_upv_5.pathResult.Status == Enum.PathStatus.Success
        if u7 then
            local v43, v44 = ClickToMoveDisplay_upv_1.CreatePathDisplay(tbl_upv_5.pointList)
            tbl_upv_5.stopTraverseFunc = v43
            tbl_upv_5.setPointFunc = v44
        end
        if tbl_upv_5.PathComputed then
            tbl_upv_5.CurrentPoint = 1
            tbl_upv_5:OnPointReached(true)
        else
            tbl_upv_5.PathFailed:Fire()
            tbl_upv_5:Cleanup()
        end
        tbl_upv_5.Recomputing = false
    end
    function tbl_upv_5.OnRenderStepped(a13, a14)
        --[[
          name: OnRenderStepped
          line: 438
          upvalues:
            tbl_upv_5 (copy, index: 1)
            u11 (ref,  index: 2)
        ]]
        if not tbl_upv_5.Started or tbl_upv_5.Cancelled then
            return
        end
        tbl_upv_5.Timeout = tbl_upv_5.Timeout + a14
        if u11 < tbl_upv_5.Timeout then
            tbl_upv_5:OnPointReached(false)
        else
            tbl_upv_5.CurrentHumanoidPosition = tbl_upv_5.Humanoid.RootPart.Position + tbl_upv_5.HumanoidOffsetFromPath
            tbl_upv_5.CurrentHumanoidVelocity = tbl_upv_5.Humanoid.RootPart.Velocity
            while tbl_upv_5.Started do
                if tbl_upv_5:IsCurrentWaypointReached() then
                    tbl_upv_5:OnPointReached(true)
                    continue
                else
                    break
                end
            end
            if not tbl_upv_5.Started then
                return
            end
            tbl_upv_5.NextActionMoveDirection = tbl_upv_5.CurrentWaypointPosition - tbl_upv_5.CurrentHumanoidPosition
            if tbl_upv_5.NextActionMoveDirection.Magnitude > 1e-06 then
                tbl_upv_5.NextActionMoveDirection = tbl_upv_5.NextActionMoveDirection.Unit
            else
                tbl_upv_5.NextActionMoveDirection = Vector3.new(0, 0, 0)
            end
            if tbl_upv_5.CurrentWaypointNeedsJump then
                tbl_upv_5.NextActionJump = true
                tbl_upv_5.CurrentWaypointNeedsJump = false
            else
                tbl_upv_5.NextActionJump = false
            end
        end
    end
    function tbl_upv_5.IsCurrentWaypointReached(a15)
        --[[
          name: IsCurrentWaypointReached
          line: 476
          upvalues:
            tbl_upv_5 (copy, index: 1)
        ]]
        local v45
        if tbl_upv_5.CurrentWaypointPlaneNormal == Vector3.new(0, 0, 0) then
            v45 = true
        else
            v45 = tbl_upv_5.CurrentWaypointPlaneNormal:Dot(tbl_upv_5.CurrentHumanoidPosition) - tbl_upv_5.CurrentWaypointPlaneDistance < math.max(1, 0.0625 * -tbl_upv_5.CurrentWaypointPlaneNormal:Dot(tbl_upv_5.CurrentHumanoidVelocity))
        end
        if v45 then
            tbl_upv_5.CurrentWaypointPosition = nil
            tbl_upv_5.CurrentWaypointPlaneNormal = Vector3.new(0, 0, 0)
            tbl_upv_5.CurrentWaypointPlaneDistance = 0
        end
        return v45
    end
    function tbl_upv_5.OnPointReached(a16, a17)
        --[[
          name: OnPointReached
          line: 502
          upvalues:
            tbl_upv_5 (copy, index: 1)
        ]]
        if a17 and not (tbl_upv_5.Cancelled) then
            if tbl_upv_5.setPointFunc then
                tbl_upv_5.setPointFunc(tbl_upv_5.CurrentPoint)
            end
            local v46 = tbl_upv_5.CurrentPoint + 1
            local v47 = nil
            if #tbl_upv_5.pointList < v46 then
                if tbl_upv_5.stopTraverseFunc then
                    tbl_upv_5.stopTraverseFunc()
                end
                tbl_upv_5.Finished:Fire()
                tbl_upv_5:Cleanup()
            else
                local v48 = tbl_upv_5.pointList[tbl_upv_5.CurrentPoint]
                local v49 = tbl_upv_5.pointList[v46]
                v47 = tbl_upv_5.Humanoid:GetState()
                local v50 = true
                local v51
                if v47 == Enum.HumanoidStateType.FallingDown then
                    v51 = v50
                else
                    v51 = true
                    if v47 ~= Enum.HumanoidStateType.Freefall then
                        v51 = v47 == Enum.HumanoidStateType.Jumping
                    end
                end
                if v51 then
                    v47 = v49.Action == Enum.PathWaypointAction.Jump
                    if not (v47) and tbl_upv_5.CurrentPoint > 1 then
                        local _ = v48.Position - tbl_upv_5.pointList[tbl_upv_5.CurrentPoint - 1].Position
                        local v52 = v49.Position - v48.Position
                        v47 = Vector2.new((v48.Position - tbl_upv_5.pointList[tbl_upv_5.CurrentPoint - 1].Position).x, (v48.Position - tbl_upv_5.pointList[tbl_upv_5.CurrentPoint - 1].Position).z).Unit:Dot(Vector2.new((v49.Position - v48.Position).x, (v49.Position - v48.Position).z).Unit) < 0.996
                    end
                    if v47 then
                        tbl_upv_5.Humanoid.FreeFalling:Wait()
                        wait(0.1)
                    end
                end
                tbl_upv_5:MoveToNextWayPoint(v48, v49, v46)
            end
            return
        end
        tbl_upv_5.PathFailed:Fire()
        tbl_upv_5:Cleanup()
    end
    function tbl_upv_5.MoveToNextWayPoint(a18, a19, a20, a21)
        --[[
          name: MoveToNextWayPoint
          line: 565
          upvalues:
            tbl_upv_5 (copy, index: 1)
            u2 (copy, index: 2)
        ]]
        tbl_upv_5.CurrentWaypointPlaneNormal = a19.Position - a20.Position
        if not (u2) or a20.Label ~= "Climb" then
            tbl_upv_5.CurrentWaypointPlaneNormal = Vector3.new(tbl_upv_5.CurrentWaypointPlaneNormal.X, 0, tbl_upv_5.CurrentWaypointPlaneNormal.Z)
        end
        if tbl_upv_5.CurrentWaypointPlaneNormal.Magnitude > 1e-06 then
            tbl_upv_5.CurrentWaypointPlaneNormal = tbl_upv_5.CurrentWaypointPlaneNormal.Unit
            tbl_upv_5.CurrentWaypointPlaneDistance = tbl_upv_5.CurrentWaypointPlaneNormal:Dot(a20.Position)
        else
            tbl_upv_5.CurrentWaypointPlaneNormal = Vector3.new(0, 0, 0)
            tbl_upv_5.CurrentWaypointPlaneDistance = 0
        end
        tbl_upv_5.CurrentWaypointNeedsJump = a20.Action == Enum.PathWaypointAction.Jump
        tbl_upv_5.CurrentWaypointPosition = a20.Position
        tbl_upv_5.CurrentPoint = a21
        tbl_upv_5.Timeout = 0
    end
    function tbl_upv_5.Start(a22, a23)
        --[[
          name: Start
          line: 597
          upvalues:
            tbl_upv_5 (copy, index: 1)
            ClickToMoveDisplay_upv_1 (copy, index: 2)
            u7 (ref,  index: 3)
            u4 (copy, index: 4)
        ]]
        if tbl_upv_5.AgentCanFollowPath then
            if tbl_upv_5.Started then
                return
            end
            tbl_upv_5.Started = true
            ClickToMoveDisplay_upv_1.CancelFailureAnimation()
            if u7 and (a23 == nil or a23) then
                local v52, v53 = ClickToMoveDisplay_upv_1.CreatePathDisplay(tbl_upv_5.pointList, tbl_upv_5.OriginalTargetPoint)
                tbl_upv_5.stopTraverseFunc = v52
                tbl_upv_5.setPointFunc = v53
            end
            if #tbl_upv_5.pointList > 0 then
                tbl_upv_5.HumanoidOffsetFromPath = Vector3.new(0, tbl_upv_5.pointList[1].Position.Y - tbl_upv_5.OriginPoint.Y, 0)
                tbl_upv_5.CurrentHumanoidPosition = tbl_upv_5.Humanoid.RootPart.Position + tbl_upv_5.HumanoidOffsetFromPath
                tbl_upv_5.CurrentHumanoidVelocity = tbl_upv_5.Humanoid.RootPart.Velocity
                tbl_upv_5.SeatedConn = tbl_upv_5.Humanoid.Seated:Connect(
                    function(a24, a25)
                        --[[
                          line: 624
                          upvalues:
                            tbl_upv_5 (copy, index: 1)
                        ]]
                        tbl_upv_5:OnPathInterrupted()
                    end
                )
                tbl_upv_5.DiedConn = tbl_upv_5.Humanoid.Died:Connect(
                    function()
                        --[[
                          line: 625
                          upvalues:
                            tbl_upv_5 (copy, index: 1)
                        ]]
                        tbl_upv_5:OnPathInterrupted()
                    end
                )
                if u4 then
                    tbl_upv_5.lastPosition = tbl_upv_5.Humanoid.RootPart.CFrame.Position
                    tbl_upv_5.TeleportedConn = tbl_upv_5.Humanoid.RootPart:GetPropertyChangedSignal("CFrame"):Connect(
                        function()
                            --[[
                              line: 628
                              upvalues:
                                tbl_upv_5 (copy, index: 1)
                            ]]
                            local Position_1 = tbl_upv_5.Humanoid.RootPart.CFrame.Position
                            tbl_upv_5.lastPosition = Position_1
                            if not (tbl_upv_5.Humanoid.WalkSpeed < (Position_1 - tbl_upv_5.lastPosition).Magnitude) then
                                return
                            end
                            tbl_upv_5:OnPathInterrupted()
                        end
                    )
                else
                    tbl_upv_5.TeleportedConn = tbl_upv_5.Humanoid.RootPart:GetPropertyChangedSignal("CFrame"):Connect(
                        function()
                            --[[
                              line: 637
                              upvalues:
                                tbl_upv_5 (copy, index: 1)
                            ]]
                            tbl_upv_5:OnPathInterrupted()
                        end
                    )
                end
                tbl_upv_5.CurrentPoint = 1
                tbl_upv_5:OnPointReached(true)
            else
                tbl_upv_5.PathFailed:Fire()
                if tbl_upv_5.stopTraverseFunc then
                    tbl_upv_5.stopTraverseFunc()
                end
            end
        else
            tbl_upv_5.PathFailed:Fire()
        end
    end
    local v54 = tbl_upv_5.TargetPoint + tbl_upv_5.TargetSurfaceNormal * 1.5
    local v55 = nil
    if u3 then
        if not (tbl_upv_3) then
            tbl_upv_3 = {}
            assert(tbl_upv_3, "")
            table.insert(tbl_upv_3, LocalPlayer_upv_1 and (LocalPlayer_upv_1.Character))
        end
        u12.FilterDescendantsInstances = tbl_upv_3
        v55 = Workspace_upv_1:Raycast(v54, Vector3.new(-0, -50, -0), u12)
        if v55 then
            tbl_upv_5.TargetPoint = v55.Position
        end
    else
        local v56 = Ray.new(v54, Vector3.new(0, -50, 0))
        if not (tbl_upv_3) then
            tbl_upv_3 = {}
            assert(tbl_upv_3, "")
            table.insert(tbl_upv_3, LocalPlayer_upv_1 and (LocalPlayer_upv_1.Character))
        end
        local v57, v58 = Workspace_upv_1:FindPartOnRayWithIgnoreList(v56, tbl_upv_3)
        if v57 then
            tbl_upv_5.TargetPoint = v58
        end
    end
    tbl_upv_5:ComputePath()
    return tbl_upv_5
end
local function CheckAlive()
    --[[
      name: CheckAlive
      line: 674
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
    ]]
    local v59 = LocalPlayer_upv_1 and (LocalPlayer_upv_1.Character)
    local v60, v61, v62 = nil, nil, nil
    if v59 then
        v60 = tbl_upv_2[LocalPlayer_upv_1]
        if (v60) and v60.Parent == v59 then
            v62 = v60
        else
            tbl_upv_2[LocalPlayer_upv_1] = nil
            v61 = LocalPlayer_upv_1:FindFirstChildOfClass("Humanoid")
            if v61 then
                tbl_upv_2[LocalPlayer_upv_1] = v61
            end
            v62 = v61
        end
    else
        v62 = nil
    end
    local v63 = false
    if v62 ~= nil then
        v63 = v62.Health > 0
    end
    return v63
end
local function DisconnectEvent(a1)
    --[[
      name: DisconnectEvent
      line: 689
    ]]
    if not a1 then
        return
    end
    a1:Disconnect()
end
local tbl_upv_6 = {}
tbl_upv_6.__index = tbl_upv_6
function tbl_upv_6.new(a1)
    --[[
      name: new
      line: 714
      upvalues:
        tbl_upv_6 (copy, index: 1)
        u6 (copy, index: 2)
    ]]
    local v64 = setmetatable({}, tbl_upv_6)
    v64.mouse2DownTime = tick()
    v64.mouse2DownPos = Vector2.new()
    v64.mouse2UpTime = tick()
    v64.humanoidDiedConn = nil
    v64.characterChildAddedConn = nil
    v64.onCharacterAddedConn = nil
    v64.characterChildRemovedConn = nil
    v64.renderSteppedConn = nil
    v64.menuOpenedConnection = nil
    v64.preferredInputChangedConnection = nil
    if not (u6) then
        v64.jumpEnabled = true
    end
    v64.clickPressedConn = nil
    v64.clickReleasedConn = nil
    v64.shouldCleanupPath = false
    v64.lastPatherJumped = false
    v64.data = nil
    v64.running = false
    return v64
end
local u16 = nil
local u17 = nil
local u18 = nil
function tbl_upv_6.CleanupPath(a1)
    --[[
      name: CleanupPath
      line: 749
      upvalues:
        u16 (ref, index: 1)
        u17 (ref, index: 2)
        u18 (ref, index: 3)
    ]]
    if u16 then
        u16:Cancel()
        u16 = nil
    end
    if u17 then
        u17:Disconnect()
        u17 = nil
    end
    if u18 then
        u18:Disconnect()
        u18 = nil
    end
    a1.shouldCleanupPath = true
end
local function GetEquippedTool(a1)
    --[[
      name: GetEquippedTool
      line: 679
    ]]
    if a1 == nil then
        return
    end
    for _, value_4 in pairs(a1:GetChildren()) do
        if not (value_4:IsA("Tool")) then
            continue
        end
        return value_4
    end
end
function tbl_upv_6.HandleMoveTo(a1, a2, a3, a4, a5, a6)
    --[[
      name: HandleMoveTo
      line: 768
      upvalues:
        u16 (ref,  index: 1)
        u17 (ref,  index: 2)
        GetEquippedTool (copy, index: 3)
        u18 (ref,  index: 4)
        u8 (ref,  index: 5)
        ClickToMoveDisplay_upv_1 (copy, index: 6)
    ]]
    a1.shouldCleanupPath = false
    if u16 then
        a1:CleanupPath()
    end
    u16 = a2
    a2:Start(a6)
    local v65 = a2.Finished.Event:Connect(
        function()
            --[[
              line: 777
              upvalues:
                a1 (copy, index: 1)
                a4 (copy, index: 2)
                GetEquippedTool (copy, index: 3)
                a5 (copy, index: 4)
            ]]
            a1:CleanupPath()
            if a4 then
                local v66 = GetEquippedTool(a5)
                if not v66 then
                    return
                end
                v66:Activate()
            end
        end
    )
    u17 = v65
    local v67 = a2.PathFailed.Event:Connect(
        function()
            --[[
              line: 786
              upvalues:
                a1 (copy, index: 1)
                a6 (copy, index: 2)
                u8 (ref,  index: 3)
                u16 (ref,  index: 4)
                ClickToMoveDisplay_upv_1 (copy, index: 5)
                a3 (copy, index: 6)
            ]]
            a1:CleanupPath()
            if a6 == nil or a6 then
                local v68 = u8
                if v68 then
                    local v69 = u16 and u16:IsActive()
                    v68 = not v69
                end
                if v68 then
                    ClickToMoveDisplay_upv_1.PlayFailureAnimation()
                end
                ClickToMoveDisplay_upv_1.DisplayFailureWaypoint(a3)
            end
        end
    )
    u18 = v67
end
function tbl_upv_6.ShowPathFailedFeedback(a1, a2)
    --[[
      name: ShowPathFailedFeedback
      line: 798
      upvalues:
        u16 (ref,  index: 1)
        u8 (ref,  index: 2)
        ClickToMoveDisplay_upv_1 (copy, index: 3)
    ]]
    if u16 and u16:IsActive() then
        u16:Cancel()
    end
    if u8 then
        ClickToMoveDisplay_upv_1.PlayFailureAnimation()
    end
    ClickToMoveDisplay_upv_1.DisplayFailureWaypoint(a2)
end
function tbl_upv_6.OnTap(a1, a2, a3)
    --[[
      name: OnTap
      line: 808
      upvalues:
        Workspace_upv_1 (copy, index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
        tbl_upv_2 (copy, index: 3)
        u3 (copy, index: 4)
        tbl_upv_3 (ref,  index: 5)
        u12 (copy, index: 6)
        Pather (copy, index: 7)
        tbl_upv_1 (copy, index: 8)
        GetEquippedTool (copy, index: 9)
    ]]
    local CurrentCamera_1 = Workspace_upv_1.CurrentCamera
    local Character_1 = LocalPlayer_upv_1.Character
    local v70 = LocalPlayer_upv_1 and (LocalPlayer_upv_1.Character)
    local v71, v72, v73 = nil, nil, nil
    if v70 then
        v71 = tbl_upv_2[LocalPlayer_upv_1]
        if (v71) and v71.Parent == v70 then
            v73 = v71
        else
            tbl_upv_2[LocalPlayer_upv_1] = nil
            v72 = LocalPlayer_upv_1:FindFirstChildOfClass("Humanoid")
            if v72 then
                tbl_upv_2[LocalPlayer_upv_1] = v72
            end
            v73 = v72
        end
    else
        v73 = nil
    end
    local v74 = false
    if v73 ~= nil then
        v74 = v73.Health > 0
    end
    if not v74 then
        return
    end
    if #a2 ~= 1 and not (a3) then
        if #a2 >= 2 and CurrentCamera_1 then
            v74 = GetEquippedTool(Character_1)
            if v74 then
                v74:Activate()
            end
        end
        return
    end
    if not CurrentCamera_1 then
        return
    end
    v74 = CurrentCamera_1:ScreenPointToRay(a2[1].X, a2[1].Y)
    local v75 = nil
    if u3 then
        local v76 = nil
        if not (tbl_upv_3) then
            tbl_upv_3 = {}
            assert(tbl_upv_3, "")
            table.insert(tbl_upv_3, LocalPlayer_upv_1 and (LocalPlayer_upv_1.Character))
        end
        local v77 = tbl_upv_3 or {}
        local v78, v79
        repeat
            v79 = true
            u12.FilterDescendantsInstances = v77
            v78 = Workspace_upv_1:Raycast(v74.Origin, v74.Direction * 1000, u12)
            if v78 then
                v75 = v78.Instance
                if not v75.CanCollide then
                    local v80, v81 = nil, nil
                    while true do
                        v80 = v75:FindFirstChildOfClass("Humanoid")
                        v81 = v75.Parent
                        if v80 then
                            break
                        end
                        if v81 then
                            v75 = v81
                            continue
                        else
                            break
                        end
                    end
                    if not (v80) and v81 then
                        local v82 = nil
                        local v83 = false
                        table.insert(v77, v81)
                        v79, v76 = v83, v82
                    end
                end
            end
        until v79
        if v78 and Character_1 then
            v77 = v78.Position
            if a3 then
                v77, v76 = a3, nil
            end
            a1:CleanupPath()
            local v84 = Pather(v77, v78.Normal)
            if v84:IsValidPath() then
                a1:HandleMoveTo(v84, v77, v76, Character_1)
            else
                v84:Cleanup()
                a1:ShowPathFailedFeedback(v77)
            end
        end
    else
        local v85 = Ray.new(v74.Origin, v74.Direction * 1000)
        local Raycast_2 = tbl_upv_1.Raycast
        if not (tbl_upv_3) then
            tbl_upv_3 = {}
            assert(tbl_upv_3, "")
            table.insert(tbl_upv_3, LocalPlayer_upv_1 and (LocalPlayer_upv_1.Character))
        end
        local v86, v87, v88 = Raycast_2(v85, true, tbl_upv_3)
        v72 = tbl_upv_1.FindCharacterAncestor(v86)
        if a3 then
            v70, v72 = a3, nil
        else
            v70 = v87
        end
        if not v70 or not Character_1 then
            return
        end
        a1:CleanupPath()
        local v89 = Pather(v70, v88)
        if v89:IsValidPath() then
            a1:HandleMoveTo(v89, v70, v72, Character_1)
        else
            v89:Cleanup()
            a1:ShowPathFailedFeedback(v70)
        end
    end
end
function tbl_upv_6.DisconnectEvents(a1)
    --[[
      name: DisconnectEvents
      line: 903
    ]]
    local humanoidDiedConn_1 = a1.humanoidDiedConn
    if humanoidDiedConn_1 then
        humanoidDiedConn_1:Disconnect()
    end
    local characterChildAddedConn_1 = a1.characterChildAddedConn
    if characterChildAddedConn_1 then
        characterChildAddedConn_1:Disconnect()
    end
    local onCharacterAddedConn_1 = a1.onCharacterAddedConn
    if onCharacterAddedConn_1 then
        onCharacterAddedConn_1:Disconnect()
    end
    local renderSteppedConn_1 = a1.renderSteppedConn
    if renderSteppedConn_1 then
        renderSteppedConn_1:Disconnect()
    end
    local characterChildRemovedConn_1 = a1.characterChildRemovedConn
    if characterChildRemovedConn_1 then
        characterChildRemovedConn_1:Disconnect()
    end
    local menuOpenedConnection_1 = a1.menuOpenedConnection
    if menuOpenedConnection_1 then
        menuOpenedConnection_1:Disconnect()
    end
    local preferredInputChangedConnection_1 = a1.preferredInputChangedConnection
    if preferredInputChangedConnection_1 then
        preferredInputChangedConnection_1:Disconnect()
    end
    local clickPressedConn_1 = a1.clickPressedConn
    if clickPressedConn_1 then
        clickPressedConn_1:Disconnect()
    end
    local clickReleasedConn_1 = a1.clickReleasedConn
    if not clickReleasedConn_1 then
        return
    end
    clickReleasedConn_1:Disconnect()
end
function tbl_upv_6.OnPreferredInputChanged(a1)
    --[[
      name: OnPreferredInputChanged
      line: 915
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        UserInputService_upv_1 (copy, index: 2)
    ]]
    local Character_2 = LocalPlayer_upv_1.Character
    if Character_2 then
        local v90 = UserInputService_upv_1.PreferredInput == Enum.PreferredInput.Touch
        for _, value_5 in pairs(Character_2:GetChildren()) do
            if value_5:IsA("Tool") then
                value_5.ManualActivationOnly = v90
            end
        end
    end
end
function tbl_upv_6.OnCharacterAdded(a1, a2)
    --[[
      name: OnCharacterAdded
      line: 927
      upvalues:
        ClickToMoveAction_upv_1 (copy, index: 1)
        GuiService_upv_1 (copy, index: 2)
        ClickToMovePositionAction_upv_1 (copy, index: 3)
        u5 (copy, index: 4)
        u16 (ref,  index: 5)
        UserInputService_upv_1 (copy, index: 6)
    ]]
    a1:DisconnectEvents()
    a1.clickPressedConn = ClickToMoveAction_upv_1.Pressed:Connect(
        function()
            --[[
              line: 930
              upvalues:
                GuiService_upv_1 (copy, index: 1)
                ClickToMovePositionAction_upv_1 (copy, index: 2)
                u5 (copy, index: 3)
                a1 (copy, index: 4)
            ]]
            local v91 = GuiService_upv_1:GetGuiInset()
            local v92 = ClickToMovePositionAction_upv_1:GetState()
            if v92.X ~= -1 or v92.Y ~= -1 then
                if u5 then
                    local Min_1 = GuiService_upv_1:GetInsetArea(Enum.ScreenInsets.None).Min
                    v92 = Vector2.new(v92.X + Min_1.X, v92.Y + Min_1.Y)
                else
                    v92 = Vector2.new(v92.X - v91.X, v92.Y - v91.Y)
                end
                a1.mouse2DownPos = v92
                a1.mouse2DownTime = tick()
            end
        end
    )
    a1.clickReleasedConn = ClickToMoveAction_upv_1.Released:Connect(
        function()
            --[[
              line: 946
              upvalues:
                a1 (copy, index: 1)
                u16 (ref,  index: 2)
            ]]
            a1.mouse2UpTime = tick()
            local mouse2DownPos_1 = a1.mouse2DownPos
            if not a1.data then
                return
            end
            if a1.data.actions.MoveAction then
                local v93 = u16 or (a1.data.actions.MoveAction:GetState().Magnitude <= 0)
                if a1.mouse2UpTime - a1.mouse2DownTime < 0.25 and v93 then
                    a1:OnTap({mouse2DownPos_1})
                end
            end
        end
    )
    a1.menuOpenedConnection = GuiService_upv_1.MenuOpened:Connect(
        function()
            --[[
              line: 961
              upvalues:
                a1 (copy, index: 1)
            ]]
            a1:CleanupPath()
        end
    )
    local function OnCharacterChildAdded(a3)
        --[[
          name: OnCharacterChildAdded
          line: 965
          upvalues:
            UserInputService_upv_1 (copy, index: 1)
            a1 (copy, index: 2)
        ]]
        if UserInputService_upv_1.PreferredInput == Enum.PreferredInput.Touch and a3:IsA("Tool") then
            a3.ManualActivationOnly = true
        end
        if a3:IsA("Humanoid") then
            local humanoidDiedConn_2 = a1.humanoidDiedConn
            if humanoidDiedConn_2 then
                humanoidDiedConn_2:Disconnect()
            end
            a1.humanoidDiedConn = a3.Died:Connect(function()
                --[[
                  line: 973
                ]]
            end)
        end
    end
    a1.characterChildAddedConn = a2.ChildAdded:Connect(
        function(a4)
            --[[
              line: 981
              upvalues:
                OnCharacterChildAdded (copy, index: 1)
            ]]
            OnCharacterChildAdded(a4)
        end
    )
    a1.characterChildRemovedConn = a2.ChildRemoved:Connect(
        function(a5)
            --[[
              line: 984
              upvalues:
                UserInputService_upv_1 (copy, index: 1)
            ]]
            if UserInputService_upv_1.PreferredInput ~= Enum.PreferredInput.Touch or not a5:IsA("Tool") then
                return
            end
            a5.ManualActivationOnly = false
        end
    )
    for _, value_6 in pairs(a2:GetChildren()) do
        OnCharacterChildAdded(value_6)
    end
    a1.preferredInputChangedConnection = UserInputService_upv_1:GetPropertyChangedSignal("PreferredInput"):Connect(
        function()
            --[[
              line: 995
              upvalues:
                a1 (copy, index: 1)
            ]]
            a1:OnPreferredInputChanged()
        end
    )
end
function tbl_upv_6.Start(a1)
    --[[
      name: Start
      line: 1000
    ]]
    a1:Enable(true)
end
function tbl_upv_6.Stop(a1)
    --[[
      name: Stop
      line: 1004
    ]]
    a1:Enable(false)
end
function tbl_upv_6.Enable(a1, a2, a3, a4)
    --[[
      name: Enable
      line: 1009
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        u6 (copy, index: 2)
        UserInputService_upv_1 (copy, index: 3)
        ClickToMoveAction_upv_1 (copy, index: 4)
        ClickToMovePositionAction_upv_1 (copy, index: 5)
    ]]
    if a2 then
        if not (a1.running) then
            if LocalPlayer_upv_1.Character then
                a1:OnCharacterAdded(LocalPlayer_upv_1.Character)
            end
            a1.onCharacterAddedConn = LocalPlayer_upv_1.CharacterAdded:Connect(
                function(a5)
                    --[[
                      line: 1015
                      upvalues:
                        a1 (copy, index: 1)
                    ]]
                    a1:OnCharacterAdded(a5)
                end
            )
            a1.running = true
        end
        if not (u6) then
            a1.touchJumpController = a4
            if a1.touchJumpController then
                a1.touchJumpController:Enable(a1.jumpEnabled)
            end
        end
    else
        if a1.running then
            a1:DisconnectEvents()
            a1:CleanupPath()
            local v94 = nil
            if UserInputService_upv_1.PreferredInput == Enum.PreferredInput.Touch then
                v94 = LocalPlayer_upv_1.Character
                if v94 then
                    for _, value_7 in pairs(v94:GetChildren()) do
                        if value_7:IsA("Tool") then
                            value_7.ManualActivationOnly = false
                        end
                    end
                end
            end
            a1.running = false
        end
        if not (u6) then
            if a1.touchJumpController and not (a1.jumpEnabled) then
                a1.touchJumpController:Enable(true)
            end
            a1.touchJumpController = nil
        end
    end
    ClickToMoveAction_upv_1.Enabled = a2
    ClickToMovePositionAction_upv_1.Enabled = a2
    a1.wasdEnabled = (a2 and a3) or false
    a1.enabled = a2
end
local function calculateLocalMoveVector(a1)
    --[[
      name: calculateLocalMoveVector
      line: 695
      upvalues:
        Workspace_upv_1 (copy, index: 1)
    ]]
    local v95 = Vector3.new(a1.X, 0, a1.Z)
    if v95.Magnitude < 1e-06 then
        return Vector2.zero
    end
    local Unit_1 = v95.Unit
    local CurrentCamera_2 = Workspace_upv_1.CurrentCamera
    if not CurrentCamera_2 then
        return Vector2.new(Unit_1.X, -Unit_1.Z)
    end
    local _, v96 = CurrentCamera_2.CFrame:ToEulerAnglesYXZ()
    local v97 = CFrame.Angles(0, v96, 0):VectorToObjectSpace(Unit_1)
    return Vector2.new(v97.X, -v97.Z)
end
function tbl_upv_6.Update(a1, a2, a3)
    --[[
      name: Update
      line: 1058
      upvalues:
        u16 (ref,  index: 1)
        calculateLocalMoveVector (copy, index: 2)
    ]]
    assert(a2.actions.MoveAction)
    assert(a2.actions.JumpAction)
    if not (a1.data) then
        a1.data = a2
    end
    if u16 then
        u16:OnRenderStepped(a3)
        if u16 then
            local v98 = nil
            if u16 ~= u16 then
                local v99 = nil
                if a1.lastPatherJumped then
                    if a2.actions.JumpAction:GetState() == true then
                        v99 = a2.actions.JumpAction:FindFirstChild("ClickToMoveScriptableBinding")
                        if v99 then
                            v99:Fire(false)
                        end
                    end
                    a1.lastPatherJumped = false
                end
            else
                local v100 = calculateLocalMoveVector(u16.NextActionMoveDirection)
                v98 = a2.actions.MoveAction:FindFirstChild("ClickToMoveScriptableBinding")
                if v98 then
                    v98:Fire(v100)
                end
                a2.moveVector = v100
                local v101 = nil
                if u16.NextActionJump then
                    if a2.actions.JumpAction:GetState() ~= true then
                        v101 = a2.actions.JumpAction:FindFirstChild("ClickToMoveScriptableBinding")
                        if v101 then
                            v101:Fire(true)
                        end
                    end
                    a1.lastPatherJumped = true
                    a2.isJumping = true
                else
                    local v102 = nil
                    if a1.lastPatherJumped then
                        if a2.actions.JumpAction:GetState() == true then
                            v102 = a2.actions.JumpAction:FindFirstChild("ClickToMoveScriptableBinding")
                            if v102 then
                                v102:Fire(false)
                            end
                        end
                        a1.lastPatherJumped = false
                        a2.isJumping = false
                    end
                end
            end
        else
            local v99 = nil
            if a1.lastPatherJumped then
                if a2.actions.JumpAction:GetState() == true then
                    v99 = a2.actions.JumpAction:FindFirstChild("ClickToMoveScriptableBinding")
                    if v99 then
                        v99:Fire(false)
                    end
                end
                a1.lastPatherJumped = false
            end
        end
    end
    if a1.shouldCleanupPath then
        a1.shouldCleanupPath = false
        local ClickToMoveScriptableBinding_1 = a2.actions.MoveAction:FindFirstChild("ClickToMoveScriptableBinding")
        if ClickToMoveScriptableBinding_1 then
            ClickToMoveScriptableBinding_1:Fire(Vector2.zero)
        end
        a2.moveVector = Vector2.zero
        a1.lastPatherJumped = false
        local ClickToMoveScriptableBinding_2 = a2.actions.JumpAction:FindFirstChild("ClickToMoveScriptableBinding")
        if ClickToMoveScriptableBinding_2 then
            ClickToMoveScriptableBinding_2:Fire(false)
        end
        a2.isJumping = false
    end
end
function tbl_upv_6.SetShowPath(a1, a2)
    --[[
      name: SetShowPath
      line: 1132
      upvalues:
        u7 (ref, index: 1)
    ]]
    u7 = a2
end
function tbl_upv_6.GetShowPath(a1)
    --[[
      name: GetShowPath
      line: 1136
      upvalues:
        u7 (ref, index: 1)
    ]]
    return u7
end
function tbl_upv_6.SetWaypointTexture(a1, a2)
    --[[
      name: SetWaypointTexture
      line: 1140
      upvalues:
        ClickToMoveDisplay_upv_1 (copy, index: 1)
    ]]
    ClickToMoveDisplay_upv_1.SetWaypointTexture(a2)
end
function tbl_upv_6.GetWaypointTexture(a1)
    --[[
      name: GetWaypointTexture
      line: 1144
      upvalues:
        ClickToMoveDisplay_upv_1 (copy, index: 1)
    ]]
    return ClickToMoveDisplay_upv_1.GetWaypointTexture()
end
function tbl_upv_6.SetWaypointRadius(a1, a2)
    --[[
      name: SetWaypointRadius
      line: 1148
      upvalues:
        ClickToMoveDisplay_upv_1 (copy, index: 1)
    ]]
    ClickToMoveDisplay_upv_1.SetWaypointRadius(a2)
end
function tbl_upv_6.GetWaypointRadius(a1)
    --[[
      name: GetWaypointRadius
      line: 1152
      upvalues:
        ClickToMoveDisplay_upv_1 (copy, index: 1)
    ]]
    return ClickToMoveDisplay_upv_1.GetWaypointRadius()
end
function tbl_upv_6.SetEndWaypointTexture(a1, a2)
    --[[
      name: SetEndWaypointTexture
      line: 1156
      upvalues:
        ClickToMoveDisplay_upv_1 (copy, index: 1)
    ]]
    ClickToMoveDisplay_upv_1.SetEndWaypointTexture(a2)
end
function tbl_upv_6.GetEndWaypointTexture(a1)
    --[[
      name: GetEndWaypointTexture
      line: 1160
      upvalues:
        ClickToMoveDisplay_upv_1 (copy, index: 1)
    ]]
    return ClickToMoveDisplay_upv_1.GetEndWaypointTexture()
end
function tbl_upv_6.SetWaypointsAlwaysOnTop(a1, a2)
    --[[
      name: SetWaypointsAlwaysOnTop
      line: 1164
      upvalues:
        ClickToMoveDisplay_upv_1 (copy, index: 1)
    ]]
    ClickToMoveDisplay_upv_1.SetWaypointsAlwaysOnTop(a2)
end
function tbl_upv_6.GetWaypointsAlwaysOnTop(a1)
    --[[
      name: GetWaypointsAlwaysOnTop
      line: 1168
      upvalues:
        ClickToMoveDisplay_upv_1 (copy, index: 1)
    ]]
    return ClickToMoveDisplay_upv_1.GetWaypointsAlwaysOnTop()
end
function tbl_upv_6.SetFailureAnimationEnabled(a1, a2)
    --[[
      name: SetFailureAnimationEnabled
      line: 1172
      upvalues:
        u8 (ref, index: 1)
    ]]
    u8 = a2
end
function tbl_upv_6.GetFailureAnimationEnabled(a1)
    --[[
      name: GetFailureAnimationEnabled
      line: 1176
      upvalues:
        u8 (ref, index: 1)
    ]]
    return u8
end
function tbl_upv_6.SetIgnoredPartsTag(a1, a2)
    --[[
      name: SetIgnoredPartsTag
      line: 1180
      upvalues:
        UpdateIgnoreTag (copy, index: 1)
    ]]
    UpdateIgnoreTag(a2)
end
function tbl_upv_6.GetIgnoredPartsTag(a1)
    --[[
      name: GetIgnoredPartsTag
      line: 1184
      upvalues:
        u13 (ref, index: 1)
    ]]
    return u13
end
function tbl_upv_6.SetUseDirectPath(a1, a2)
    --[[
      name: SetUseDirectPath
      line: 1188
      upvalues:
        u9 (ref, index: 1)
    ]]
    u9 = a2
end
function tbl_upv_6.GetUseDirectPath(a1)
    --[[
      name: GetUseDirectPath
      line: 1192
      upvalues:
        u9 (ref, index: 1)
    ]]
    return u9
end
function tbl_upv_6.SetAgentSizeIncreaseFactor(a1, a2)
    --[[
      name: SetAgentSizeIncreaseFactor
      line: 1196
      upvalues:
        u10 (ref, index: 1)
    ]]
    u10 = (a2 / 100) + 1
end
function tbl_upv_6.GetAgentSizeIncreaseFactor(a1)
    --[[
      name: GetAgentSizeIncreaseFactor
      line: 1200
      upvalues:
        u10 (ref, index: 1)
    ]]
    return (u10 - 1) * 100
end
function tbl_upv_6.SetUnreachableWaypointTimeout(a1, a2)
    --[[
      name: SetUnreachableWaypointTimeout
      line: 1204
      upvalues:
        u11 (ref, index: 1)
    ]]
    u11 = a2
end
function tbl_upv_6.GetUnreachableWaypointTimeout(a1)
    --[[
      name: GetUnreachableWaypointTimeout
      line: 1208
      upvalues:
        u11 (ref, index: 1)
    ]]
    return u11
end
if not (u6) then
    function tbl_upv_6.SetUserJumpEnabled(a1, a2)
        --[[
          name: SetUserJumpEnabled
          line: 1213
        ]]
        a1.jumpEnabled = a2
        if not a1.touchJumpController then
            return
        end
        a1.touchJumpController:Enable(a2)
    end
    function tbl_upv_6.GetUserJumpEnabled(a1)
        --[[
          name: GetUserJumpEnabled
          line: 1220
        ]]
        return a1.jumpEnabled
    end
end
function tbl_upv_6.MoveTo(a1, a2, a3, a4)
    --[[
      name: MoveTo
      line: 1225
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        Pather (copy, index: 2)
    ]]
    local Character_3 = LocalPlayer_upv_1.Character
    if Character_3 == nil then
        return false
    end
    local v103 = Pather(a2, Vector3.new(0, 1, 0), a4)
    if v103 and v103:IsValidPath() then
        a1:HandleMoveTo(v103, a2, nil, Character_3, a3)
        return true
    end
    return false
end
return tbl_upv_6