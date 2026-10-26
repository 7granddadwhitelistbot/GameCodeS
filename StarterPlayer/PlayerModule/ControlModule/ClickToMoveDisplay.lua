local tbl_1 = {}
local u1 = "rbxasset://textures/ui/traildot.png"
local u2 = "rbxasset://textures/ui/waypoint.png"
local u3 = false
local u4 = UDim2.new(0, 42, 0, 50)
local u5 = Vector2.new(0, 0.5)
local u6 = Vector2.new(0, 1)
local u7 = Vector2.new(0, 0.5)
local u8 = Vector2.new(0.1, 0.5)
local u9 = Vector2.new(-0.1, 0.5)
local u10 = Vector2.new(1.5, 1.5)
local u11 = RaycastParams.new()
u11.FilterType = Enum.RaycastFilterType.Exclude
local Players_1 = game:GetService("Players")
local TweenService_upv_1 = game:GetService("TweenService")
local RunService_upv_1 = game:GetService("RunService")
local Workspace_upv_1 = game:GetService("Workspace")
local u12 = require(script.Parent.Parent:WaitForChild("CommonUtils")).get("FlagUtil").getUserFlag("UserRaycastUpdateAPI2")
local LocalPlayer_upv_1 = Players_1.LocalPlayer
local function CreateWaypointTemplates()
    --[[
      name: CreateWaypointTemplates
      line: 55
      upvalues:
        u10 (ref,  index: 1)
        u3 (ref,  index: 2)
        u1 (ref,  index: 3)
        u4 (copy, index: 4)
        u5 (copy, index: 5)
        u2 (ref,  index: 6)
        u7 (copy, index: 7)
    ]]
    local v1 = Instance.new("Part")
    v1.Size = Vector3.new(1, 1, 1)
    v1.Anchored = true
    v1.CanCollide = false
    v1.Name = "TrailDot"
    v1.Transparency = 1
    local v2 = Instance.new("ImageHandleAdornment")
    v2.Name = "TrailDotImage"
    v2.Size = u10
    v2.SizeRelativeOffset = Vector3.new(0, 0, -0.10000000149011612)
    v2.AlwaysOnTop = u3
    v2.Image = u1
    v2.Adornee = v1
    v2.Parent = v1
    local v3 = Instance.new("Part")
    v3.Size = Vector3.new(2, 2, 2)
    v3.Anchored = true
    v3.CanCollide = false
    v3.Name = "EndWaypoint"
    v3.Transparency = 1
    local v4 = Instance.new("ImageHandleAdornment")
    v4.Name = "TrailDotImage"
    v4.Size = u10
    v4.SizeRelativeOffset = Vector3.new(0, 0, -0.10000000149011612)
    v4.AlwaysOnTop = u3
    v4.Image = u1
    v4.Adornee = v3
    v4.Parent = v3
    local v5 = Instance.new("BillboardGui")
    v5.Name = "EndWaypointBillboard"
    v5.Size = u4
    v5.LightInfluence = 0
    v5.SizeOffset = u5
    v5.AlwaysOnTop = true
    v5.Adornee = v3
    v5.Parent = v3
    local v6 = Instance.new("ImageLabel")
    v6.Image = u2
    v6.BackgroundTransparency = 1
    v6.Size = UDim2.new(1, 0, 1, 0)
    v6.Parent = v5
    local v7 = Instance.new("Part")
    v7.Size = Vector3.new(2, 2, 2)
    v7.Anchored = true
    v7.CanCollide = false
    v7.Name = "FailureWaypoint"
    v7.Transparency = 1
    local v8 = Instance.new("ImageHandleAdornment")
    v8.Name = "TrailDotImage"
    v8.Size = u10
    v8.SizeRelativeOffset = Vector3.new(0, 0, -0.10000000149011612)
    v8.AlwaysOnTop = u3
    v8.Image = u1
    v8.Adornee = v7
    v8.Parent = v7
    local v9 = Instance.new("BillboardGui")
    v9.Name = "FailureWaypointBillboard"
    v9.Size = u4
    v9.LightInfluence = 0
    v9.SizeOffset = u7
    v9.AlwaysOnTop = true
    v9.Adornee = v7
    v9.Parent = v7
    local v10 = Instance.new("Frame")
    v10.BackgroundTransparency = 1
    v10.Size = UDim2.new(0, 0, 0, 0)
    v10.Position = UDim2.new(0.5, 0, 1, 0)
    v10.Parent = v9
    local v11 = Instance.new("ImageLabel")
    v11.Image = u2
    v11.BackgroundTransparency = 1
    v11.Position = UDim2.new(0, -u4.X.Offset / 2, 0, -u4.Y.Offset)
    v11.Size = u4
    v11.Parent = v10
    return v1, v3, v7
end
local u13, u14
local u15, u13, u14 = CreateWaypointTemplates()
local function getTrailDotParent()
    --[[
      name: getTrailDotParent
      line: 141
      upvalues:
        Workspace_upv_1 (copy, index: 1)
    ]]
    local CurrentCamera_1 = Workspace_upv_1.CurrentCamera
    local v12 = CurrentCamera_1:FindFirstChild("ClickToMoveDisplay")
    if not (v12) then
        v12 = Instance.new("Model")
        v12.Name = "ClickToMoveDisplay"
        v12.Parent = CurrentCamera_1
    end
    return v12
end
local tbl_upv_2 = {}
tbl_upv_2.__index = tbl_upv_2
function tbl_upv_2.Destroy(a1)
    --[[
      name: Destroy
      line: 177
    ]]
    a1.DisplayModel:Destroy()
end
local function placePathWaypoint(a1, a2)
    --[[
      name: placePathWaypoint
      line: 152
      upvalues:
        u12 (copy, index: 1)
        u11 (copy, index: 2)
        Workspace_upv_1 (copy, index: 3)
        LocalPlayer_upv_1 (copy, index: 4)
    ]]
    local v13 = nil
    if u12 then
        u11.FilterDescendantsInstances = {Workspace_upv_1.CurrentCamera, LocalPlayer_upv_1.Character}
        v13 = Workspace_upv_1:Raycast(a2 + Vector3.new(0, 2.5, 0), Vector3.new(-0, -10, -0), u11)
        if v13 then
            a1.CFrame = CFrame.lookAlong(v13.Position, v13.Normal)
            local CurrentCamera_2 = Workspace_upv_1.CurrentCamera
            local v14 = CurrentCamera_2:FindFirstChild("ClickToMoveDisplay")
            if not (v14) then
                v14 = Instance.new("Model")
                v14.Name = "ClickToMoveDisplay"
                v14.Parent = CurrentCamera_2
            end
            a1.Parent = v14
        end
    else
        local v15, v16, v17 = Workspace_upv_1:FindPartOnRayWithIgnoreList(Ray.new(a2 + Vector3.new(0, 2.5, 0), Vector3.new(0, -10, 0)), {Workspace_upv_1.CurrentCamera, LocalPlayer_upv_1.Character})
        if v15 then
            a1.CFrame = CFrame.new(v16, v16 + v17)
            local CurrentCamera_3 = Workspace_upv_1.CurrentCamera
            local v18 = CurrentCamera_3:FindFirstChild("ClickToMoveDisplay")
            if not (v18) then
                v18 = Instance.new("Model")
                v18.Name = "ClickToMoveDisplay"
                v18.Parent = CurrentCamera_3
            end
            a1.Parent = v18
        end
    end
end
function tbl_upv_2.NewDisplayModel(a1, a2)
    --[[
      name: NewDisplayModel
      line: 181
      upvalues:
        u15 (ref,  index: 1)
        placePathWaypoint (copy, index: 2)
    ]]
    local v19 = u15:Clone()
    placePathWaypoint(v19, a2)
    return v19
end
function tbl_upv_2.new(a1, a2)
    --[[
      name: new
      line: 187
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    local v20 = setmetatable({}, tbl_upv_2)
    v20.DisplayModel = v20:NewDisplayModel(a1)
    v20.ClosestWayPoint = a2
    return v20
end
local tbl_upv_3 = {}
tbl_upv_3.__index = tbl_upv_3
function tbl_upv_3.Destroy(a1)
    --[[
      name: Destroy
      line: 199
    ]]
    a1.Destroyed = true
    a1.Tween:Cancel()
    a1.DisplayModel:Destroy()
end
function tbl_upv_3.NewDisplayModel(a1, a2)
    --[[
      name: NewDisplayModel
      line: 205
      upvalues:
        u13 (ref,  index: 1)
        placePathWaypoint (copy, index: 2)
    ]]
    local v21 = u13:Clone()
    placePathWaypoint(v21, a2)
    return v21
end
function tbl_upv_3.CreateTween(a1)
    --[[
      name: CreateTween
      line: 211
      upvalues:
        TweenService_upv_1 (copy, index: 1)
        u6 (copy, index: 2)
    ]]
    local v22 = TweenService_upv_1:Create(a1.DisplayModel.EndWaypointBillboard, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, -1, true), {SizeOffset = u6})
    v22:Play()
    return v22
end
function tbl_upv_3.TweenInFrom(a1, a2)
    --[[
      name: TweenInFrom
      line: 222
      upvalues:
        TweenService_upv_1 (copy, index: 1)
    ]]
    a1.DisplayModel.EndWaypointBillboard.StudsOffset = Vector3.new(0, (a2 - a1.DisplayModel.Position).Y, 0)
    local v23 = TweenService_upv_1:Create(a1.DisplayModel.EndWaypointBillboard, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {StudsOffset = Vector3.new(0, 0, 0)})
    v23:Play()
    return v23
end
function tbl_upv_3.new(a1, a2, a3)
    --[[
      name: new
      line: 236
      upvalues:
        tbl_upv_3 (copy, index: 1)
    ]]
    local u16 = setmetatable({}, tbl_upv_3)
    u16.DisplayModel = u16:NewDisplayModel(a1)
    u16.Destroyed = false
    if (a3) and ((a3 - a1).Magnitude > 5) then
        u16.Tween = u16:TweenInFrom(a3)
        coroutine.wrap(
            function()
                --[[
                  line: 243
                  upvalues:
                    u16 (copy, index: 1)
                ]]
                u16.Tween.Completed:Wait()
                if (u16.Destroyed) then
                    return
                end
                u16.Tween = u16:CreateTween()
            end
        )()
    else
        u16.Tween = u16:CreateTween()
    end
    u16.ClosestWayPoint = a2
    return u16
end
local tbl_upv_4 = {}
tbl_upv_4.__index = tbl_upv_4
function tbl_upv_4.Hide(a1)
    --[[
      name: Hide
      line: 260
    ]]
    a1.DisplayModel.Parent = nil
end
function tbl_upv_4.Destroy(a1)
    --[[
      name: Destroy
      line: 264
    ]]
    a1.DisplayModel:Destroy()
end
function tbl_upv_4.NewDisplayModel(a1, a2)
    --[[
      name: NewDisplayModel
      line: 268
      upvalues:
        u14 (ref,  index: 1)
        placePathWaypoint (copy, index: 2)
        u12 (copy, index: 3)
        u11 (copy, index: 4)
        Workspace_upv_1 (copy, index: 5)
        LocalPlayer_upv_1 (copy, index: 6)
    ]]
    local v24 = u14:Clone()
    placePathWaypoint(v24, a2)
    local v25 = nil
    if u12 then
        u11.FilterDescendantsInstances = {Workspace_upv_1.CurrentCamera, LocalPlayer_upv_1.Character}
        v25 = Workspace_upv_1:Raycast(a2 + Vector3.new(0, 2.5, 0), Vector3.new(-0, -10, -0), u11)
        if v25 then
            v24.CFrame = CFrame.lookAlong(v25.Position, v25.Normal)
            local CurrentCamera_4 = Workspace_upv_1.CurrentCamera
            local v26 = CurrentCamera_4:FindFirstChild("ClickToMoveDisplay")
            if not (v26) then
                v26 = Instance.new("Model")
                v26.Name = "ClickToMoveDisplay"
                v26.Parent = CurrentCamera_4
            end
            v24.Parent = v26
            return v24
        end
    else
        local v27, v28, v29 = Workspace_upv_1:FindPartOnRayWithIgnoreList(Ray.new(a2 + Vector3.new(0, 2.5, 0), Vector3.new(0, -10, 0)), {Workspace_upv_1.CurrentCamera, LocalPlayer_upv_1.Character})
        if v27 then
            v24.CFrame = CFrame.new(v28, v28 + v29)
            local CurrentCamera_5 = Workspace_upv_1.CurrentCamera
            local v30 = CurrentCamera_5:FindFirstChild("ClickToMoveDisplay")
            if not (v30) then
                v30 = Instance.new("Model")
                v30.Name = "ClickToMoveDisplay"
                v30.Parent = CurrentCamera_5
            end
            v24.Parent = v30
        end
    end
    return v24
end
function tbl_upv_4.RunFailureTween(a1)
    --[[
      name: RunFailureTween
      line: 292
      upvalues:
        TweenService_upv_1 (copy, index: 1)
        u8 (copy, index: 2)
        u9 (copy, index: 3)
        u7 (copy, index: 4)
    ]]
    wait(0.125)
    local v31 = TweenInfo.new(0.0625, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    local v32 = TweenService_upv_1:Create(a1.DisplayModel.FailureWaypointBillboard, v31, {SizeOffset = u8})
    v32:Play()
    TweenService_upv_1:Create(a1.DisplayModel.FailureWaypointBillboard.Frame, v31, {Rotation = 10}):Play()
    v32.Completed:wait()
    local v33 = TweenService_upv_1:Create(a1.DisplayModel.FailureWaypointBillboard, TweenInfo.new(0.125, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 3, true), {SizeOffset = u9})
    v33:Play()
    local v34 = TweenInfo.new(0.125, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 3, true)
    local tbl_5 = {}
    tbl_5.ImageColor3 = Color3.new(0.75, 0.75, 0.75)
    TweenService_upv_1:Create(a1.DisplayModel.FailureWaypointBillboard.Frame.ImageLabel, v34, tbl_5):Play()
    TweenService_upv_1:Create(a1.DisplayModel.FailureWaypointBillboard.Frame, v34, {Rotation = -10}):Play()
    v33.Completed:wait()
    local v35 = TweenInfo.new(0.0625, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    local v36 = TweenService_upv_1:Create(a1.DisplayModel.FailureWaypointBillboard, v35, {SizeOffset = u7})
    v36:Play()
    TweenService_upv_1:Create(a1.DisplayModel.FailureWaypointBillboard.Frame, v35, {Rotation = 0}):Play()
    v36.Completed:wait()
    wait(0.125)
end
function tbl_upv_4.new(a1)
    --[[
      name: new
      line: 341
      upvalues:
        tbl_upv_4 (copy, index: 1)
    ]]
    local v37 = setmetatable({}, tbl_upv_4)
    v37.DisplayModel = v37:NewDisplayModel(a1)
    return v37
end
local u17 = Instance.new("Animation")
u17.AnimationId = "rbxassetid://2874840706"
local u18 = nil
local function getFailureAnimationTrack(a1)
    --[[
      name: getFailureAnimationTrack
      line: 355
      upvalues:
        u18 (ref,  index: 1)
        u17 (copy, index: 2)
    ]]
    if a1 ~= nil then
        u18 = a1:LoadAnimation(u17)
        assert(u18, "")
        u18.Priority = Enum.AnimationPriority.Action
        u18.Looped = false
    end
    return u18
end
local function findPlayerHumanoid()
    --[[
      name: findPlayerHumanoid
      line: 366
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local Character_1 = LocalPlayer_upv_1.Character
    if Character_1 then
        return Character_1:FindFirstChildOfClass("Humanoid")
    end
end
local function getTrailDotScale(a1, a2)
    --[[
      name: getTrailDotScale
      line: 398
    ]]
    return a2 * (((math.clamp(a1 - 10, 0, 90) / 90) * 1.5) + 1)
end
local u19 = 0
local function createTrailDots(a1, a2)
    --[[
      name: createTrailDots
      line: 373
      upvalues:
        tbl_upv_2 (copy, index: 1)
        tbl_upv_3 (copy, index: 2)
    ]]
    local tbl_6 = {}
    local v38 = 1
    for n_1 = 1, #a1 - 1 do
        local v39 = (a1[n_1].Position - a1[#a1].Position).Magnitude < 3
        if not v39 and n_1 % 2 == 0 then
            tbl_6[v38] = tbl_upv_2.new(a1[n_1].Position, n_1)
            v38 = v38 + 1
        end
    end
    table.insert(tbl_6, (tbl_upv_3.new(a1[#a1].Position, #a1, a2)))
    local tbl_7 = {}
    local v40 = 1
    v38 = v40
    for n_2 = #tbl_6, 1, -1 do
        tbl_7[v38] = tbl_6[n_2]
        v38 = v38 + 1
    end
    return tbl_7
end
function tbl_1.CreatePathDisplay(a1, a2)
    --[[
      name: CreatePathDisplay
      line: 407
      upvalues:
        u19 (ref,  index: 1)
        createTrailDots (copy, index: 2)
        RunService_upv_1 (copy, index: 3)
        Workspace_upv_1 (copy, index: 4)
        u10 (ref,  index: 5)
    ]]
    u19 = u19 + 1
    local u20 = createTrailDots(a1, a2)
    local u21 = "ClickToMoveResizeTrail" .. u19
    local function resizeTrailDots()
        --[[
          name: resizeTrailDots
          line: 425
          upvalues:
            u20 (copy, index: 1)
            RunService_upv_1 (copy, index: 2)
            u21 (copy, index: 3)
            Workspace_upv_1 (copy, index: 4)
            u10 (ref,  index: 5)
        ]]
        if #u20 ~= 0 then
            local Position_1 = Workspace_upv_1.CurrentCamera.CFrame.Position
            for n_3 = 1, #u20 do
                local TrailDotImage_1 = u20[n_3].DisplayModel:FindFirstChild("TrailDotImage")
                if TrailDotImage_1 then
                    TrailDotImage_1.Size = u10 * (((math.clamp((u20[n_3].DisplayModel.Position - Position_1).Magnitude - 10, 0, 90) / 90) * 1.5) + 1)
                end
            end
        else
            RunService_upv_1:UnbindFromRenderStep(u21)
        end
    end
    RunService_upv_1:BindToRenderStep(u21, Enum.RenderPriority.Camera.Value - 1, resizeTrailDots)
    local function removePathBeforePoint(a3)
        --[[
          name: removePathBeforePoint
          line: 411
          upvalues:
            u20 (copy, index: 1)
        ]]
        for n_4 = #u20, 1, -1 do
            local v41 = u20[n_4]
            if v41.ClosestWayPoint <= a3 then
                v41:Destroy()
                u20[n_4] = nil
                continue
            else
                break
            end
        end
    end
    local function removePath()
        --[[
          name: removePath
          line: 441
          upvalues:
            removePathBeforePoint (copy, index: 1)
            a1 (copy, index: 2)
        ]]
        removePathBeforePoint(#a1)
    end
    return removePath, removePathBeforePoint
end
local u22 = nil
function tbl_1.DisplayFailureWaypoint(a1)
    --[[
      name: DisplayFailureWaypoint
      line: 449
      upvalues:
        u22 (ref,  index: 1)
        tbl_upv_4 (copy, index: 2)
    ]]
    if u22 then
        u22:Hide()
    end
    local u23 = tbl_upv_4.new(a1)
    u22 = u23
    coroutine.wrap(
        function()
            --[[
              line: 455
              upvalues:
                u23 (ref, index: 1)
            ]]
            u23:RunFailureTween()
            u23:Destroy()
            u23 = nil
        end
    )()
end
function tbl_1.CreateEndWaypoint(a1)
    --[[
      name: CreateEndWaypoint
      line: 462
      upvalues:
        tbl_upv_3 (copy, index: 1)
    ]]
    return tbl_upv_3.new(a1)
end
function tbl_1.PlayFailureAnimation()
    --[[
      name: PlayFailureAnimation
      line: 466
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        u18 (ref,  index: 2)
        u17 (copy, index: 3)
    ]]
    local Character_2 = LocalPlayer_upv_1.Character
    local v42
    if Character_2 then
        v42 = Character_2:FindFirstChildOfClass("Humanoid")
    else
        v42 = nil
    end
    if not v42 then
        return
    end
    if v42 ~= nil then
        u18 = v42:LoadAnimation(u17)
        assert(u18, "")
        u18.Priority = Enum.AnimationPriority.Action
        u18.Looped = false
    end
    u18:Play()
end
function tbl_1.CancelFailureAnimation()
    --[[
      name: CancelFailureAnimation
      line: 474
      upvalues:
        u18 (ref, index: 1)
    ]]
    if u18 == nil or not u18.IsPlaying then
        return
    end
    u18:Stop()
end
function tbl_1.SetWaypointTexture(a1)
    --[[
      name: SetWaypointTexture
      line: 480
      upvalues:
        u1 (ref,  index: 1)
        u15 (ref,  index: 2)
        u13 (ref,  index: 3)
        u14 (ref,  index: 4)
        CreateWaypointTemplates (copy, index: 5)
    ]]
    u1 = a1
    u15, u13, u14 = CreateWaypointTemplates()
end
function tbl_1.GetWaypointTexture()
    --[[
      name: GetWaypointTexture
      line: 485
      upvalues:
        u1 (ref, index: 1)
    ]]
    return u1
end
function tbl_1.SetWaypointRadius(a1)
    --[[
      name: SetWaypointRadius
      line: 489
      upvalues:
        u10 (ref,  index: 1)
        u15 (ref,  index: 2)
        u13 (ref,  index: 3)
        u14 (ref,  index: 4)
        CreateWaypointTemplates (copy, index: 5)
    ]]
    u10 = Vector2.new(a1, a1)
    u15, u13, u14 = CreateWaypointTemplates()
end
function tbl_1.GetWaypointRadius()
    --[[
      name: GetWaypointRadius
      line: 494
      upvalues:
        u10 (ref, index: 1)
    ]]
    return u10.X
end
function tbl_1.SetEndWaypointTexture(a1)
    --[[
      name: SetEndWaypointTexture
      line: 498
      upvalues:
        u2 (ref,  index: 1)
        u15 (ref,  index: 2)
        u13 (ref,  index: 3)
        u14 (ref,  index: 4)
        CreateWaypointTemplates (copy, index: 5)
    ]]
    u2 = a1
    u15, u13, u14 = CreateWaypointTemplates()
end
function tbl_1.GetEndWaypointTexture()
    --[[
      name: GetEndWaypointTexture
      line: 503
      upvalues:
        u2 (ref, index: 1)
    ]]
    return u2
end
function tbl_1.SetWaypointsAlwaysOnTop(a1)
    --[[
      name: SetWaypointsAlwaysOnTop
      line: 507
      upvalues:
        u3 (ref,  index: 1)
        u15 (ref,  index: 2)
        u13 (ref,  index: 3)
        u14 (ref,  index: 4)
        CreateWaypointTemplates (copy, index: 5)
    ]]
    u3 = a1
    u15, u13, u14 = CreateWaypointTemplates()
end
function tbl_1.GetWaypointsAlwaysOnTop()
    --[[
      name: GetWaypointsAlwaysOnTop
      line: 512
      upvalues:
        u3 (ref, index: 1)
    ]]
    return u3
end
return tbl_1