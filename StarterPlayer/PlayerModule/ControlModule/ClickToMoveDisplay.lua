local v1 = {}
local image = "rbxasset://textures/ui/traildot.png"
local image2 = "rbxasset://textures/ui/waypoint.png"
local alwaysOnTop = false
local size = UDim2.new(0, 42, 0, 50)
local sizeOffset = Vector2.new(0, 0.5)
local sizeOffset2 = Vector2.new(0, 1)
local sizeOffset3 = Vector2.new(0, 0.5)
local sizeOffset4 = Vector2.new(0.1, 0.5)
local sizeOffset5 = Vector2.new(-0.1, 0.5)
local size2 = Vector2.new(1.5, 1.5)
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
local players = game:GetService("Players")
local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")
local workspace = game:GetService("Workspace")
local CommonUtils = require(script.Parent.Parent:WaitForChild("CommonUtils"))
local v18 = CommonUtils.get("FlagUtil")
local userFlag = v18.getUserFlag("UserRaycastUpdateAPI2")
local localPlayer = players.LocalPlayer

local function CreateWaypointTemplates()
    --[[
      name: CreateWaypointTemplates
      line: 55
      upvalues:
        size2 (ref,  index: 1)
        alwaysOnTop (ref,  index: 2)
        image (ref,  index: 3)
        size (copy, index: 4)
        sizeOffset (copy, index: 5)
        image2 (ref,  index: 6)
        sizeOffset3 (copy, index: 7)
    ]]
    local trailDot = Instance.new("Part")
    trailDot.Size = Vector3.new(1, 1, 1)
    trailDot.Anchored = true
    trailDot.CanCollide = false
    trailDot.Name = "TrailDot"
    trailDot.Transparency = 1

    local trailDotImage = Instance.new("ImageHandleAdornment")
    trailDotImage.Name = "TrailDotImage"
    trailDotImage.Size = size2
    trailDotImage.SizeRelativeOffset = Vector3.new(0, 0, -0.10000000149011612)
    trailDotImage.AlwaysOnTop = alwaysOnTop
    trailDotImage.Image = image
    trailDotImage.Adornee = trailDot
    trailDotImage.Parent = trailDot

    local endWaypoint = Instance.new("Part")
    endWaypoint.Size = Vector3.new(2, 2, 2)
    endWaypoint.Anchored = true
    endWaypoint.CanCollide = false
    endWaypoint.Name = "EndWaypoint"
    endWaypoint.Transparency = 1

    local trailDotImage2 = Instance.new("ImageHandleAdornment")
    trailDotImage2.Name = "TrailDotImage"
    trailDotImage2.Size = size2
    trailDotImage2.SizeRelativeOffset = Vector3.new(0, 0, -0.10000000149011612)
    trailDotImage2.AlwaysOnTop = alwaysOnTop
    trailDotImage2.Image = image
    trailDotImage2.Adornee = endWaypoint
    trailDotImage2.Parent = endWaypoint

    local endWaypointBillboard = Instance.new("BillboardGui")
    endWaypointBillboard.Name = "EndWaypointBillboard"
    endWaypointBillboard.Size = size
    endWaypointBillboard.LightInfluence = 0
    endWaypointBillboard.SizeOffset = sizeOffset
    endWaypointBillboard.AlwaysOnTop = true
    endWaypointBillboard.Adornee = endWaypoint
    endWaypointBillboard.Parent = endWaypoint

    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Image = image2
    imageLabel.BackgroundTransparency = 1
    imageLabel.Size = UDim2.new(1, 0, 1, 0)
    imageLabel.Parent = endWaypointBillboard

    local failureWaypoint = Instance.new("Part")
    failureWaypoint.Size = Vector3.new(2, 2, 2)
    failureWaypoint.Anchored = true
    failureWaypoint.CanCollide = false
    failureWaypoint.Name = "FailureWaypoint"
    failureWaypoint.Transparency = 1

    local trailDotImage3 = Instance.new("ImageHandleAdornment")
    trailDotImage3.Name = "TrailDotImage"
    trailDotImage3.Size = size2
    trailDotImage3.SizeRelativeOffset = Vector3.new(0, 0, -0.10000000149011612)
    trailDotImage3.AlwaysOnTop = alwaysOnTop
    trailDotImage3.Image = image
    trailDotImage3.Adornee = failureWaypoint
    trailDotImage3.Parent = failureWaypoint

    local failureWaypointBillboard = Instance.new("BillboardGui")
    failureWaypointBillboard.Name = "FailureWaypointBillboard"
    failureWaypointBillboard.Size = size
    failureWaypointBillboard.LightInfluence = 0
    failureWaypointBillboard.SizeOffset = sizeOffset3
    failureWaypointBillboard.AlwaysOnTop = true
    failureWaypointBillboard.Adornee = failureWaypoint
    failureWaypointBillboard.Parent = failureWaypoint

    local parent = Instance.new("Frame")
    parent.BackgroundTransparency = 1
    parent.Size = UDim2.new(0, 0, 0, 0)
    parent.Position = UDim2.new(0.5, 0, 1, 0)
    parent.Parent = failureWaypointBillboard

    local imageLabel2 = Instance.new("ImageLabel")
    imageLabel2.Image = image2
    imageLabel2.BackgroundTransparency = 1
    imageLabel2.Position = UDim2.new(0, -size.X.Offset / 2, 0, -size.Y.Offset)
    imageLabel2.Size = size
    imageLabel2.Parent = parent

    return trailDot, endWaypoint, failureWaypoint
end

local waypointTemplates, v34, v35 = CreateWaypointTemplates()

local function getTrailDotParent()
    --[[
      name: getTrailDotParent
      line: 139
      upvalues:
        workspace (copy, index: 1)
    ]]
    local camera = workspace.CurrentCamera
    local clickToMoveDisplay = camera:FindFirstChild("ClickToMoveDisplay")
    if not clickToMoveDisplay then
        clickToMoveDisplay = Instance.new("Model")
        clickToMoveDisplay.Name = "ClickToMoveDisplay"
        clickToMoveDisplay.Parent = camera
    end

    return clickToMoveDisplay
end

local function placePathWaypoint(a40, a41)
    --[[
      name: placePathWaypoint
      line: 150
      upvalues:
        userFlag (copy, index: 1)
        raycastParams (copy, index: 2)
        workspace (copy, index: 3)
        localPlayer (copy, index: 4)
    ]]
    if userFlag then
        raycastParams.FilterDescendantsInstances = {workspace.CurrentCamera, localPlayer.Character}

        if const raycastResult = workspace:Raycast(a41 + Vector3.new(0, 2.5, 0), Vector3.new(-0, -10, -0), raycastParams) then
            a40.CFrame = CFrame.lookAlong(raycastResult.Position, raycastResult.Normal)
            local camera = workspace.CurrentCamera
            local clickToMoveDisplay = camera:FindFirstChild("ClickToMoveDisplay")
            if not clickToMoveDisplay then
                clickToMoveDisplay = Instance.new("Model")
                clickToMoveDisplay.Name = "ClickToMoveDisplay"
                clickToMoveDisplay.Parent = camera
            end

            a40.Parent = clickToMoveDisplay
        end
    else
        local partOnRay, v46, v47 = workspace:FindPartOnRayWithIgnoreList(Ray.new(a41 + Vector3.new(0, 2.5, 0), Vector3.new(0, -10, 0)), {workspace.CurrentCamera, localPlayer.Character})
        if partOnRay then
            a40.CFrame = CFrame.new(v46, v46 + v47)
            local camera = workspace.CurrentCamera
            local clickToMoveDisplay = camera:FindFirstChild("ClickToMoveDisplay")
            if not clickToMoveDisplay then
                clickToMoveDisplay = Instance.new("Model")
                clickToMoveDisplay.Name = "ClickToMoveDisplay"
                clickToMoveDisplay.Parent = camera
            end

            a40.Parent = clickToMoveDisplay
        end
    end
end

local Class = {}
Class.__index = Class

function Class.Destroy(self)
    --[[
      name: Destroy
      line: 173
    ]]
    self.DisplayModel:Destroy()
end

function Class.NewDisplayModel(self, a53)
    --[[
      name: NewDisplayModel
      line: 177
      upvalues:
        waypointTemplates (ref,  index: 1)
        placePathWaypoint (copy, index: 2)
    ]]
    local waypointTemplates2 = waypointTemplates:Clone()
    placePathWaypoint(waypointTemplates2, a53)

    return waypointTemplates2
end

function Class.new(a55, closestWayPoint)
    --[[
      name: new
      line: 183
      upvalues:
        Class (copy, index: 1)
    ]]
    local v57 = setmetatable({}, Class)
    v57.DisplayModel = v57:NewDisplayModel(a55)
    v57.ClosestWayPoint = closestWayPoint
    return v57
end

local Class2 = {}
Class2.__index = Class2

function Class2.Destroy(self)
    --[[
      name: Destroy
      line: 195
    ]]
    self.Destroyed = true
    self.Tween:Cancel()
    self.DisplayModel:Destroy()
end

function Class2.NewDisplayModel(self, a61)
    --[[
      name: NewDisplayModel
      line: 201
      upvalues:
        v34 (ref,  index: 1)
        placePathWaypoint (copy, index: 2)
    ]]
    local v62 = v34:Clone()
    placePathWaypoint(v62, a61)

    return v62
end

function Class2.CreateTween(self)
    --[[
      name: CreateTween
      line: 207
      upvalues:
        tweenService (copy, index: 1)
        sizeOffset2 (copy, index: 2)
    ]]
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, -1, true)
    local tween = tweenService:Create(self.DisplayModel.EndWaypointBillboard, tweenInfo, {SizeOffset = sizeOffset2})
    tween:Play()

    return tween
end

function Class2.TweenInFrom(self, a67)
    --[[
      name: TweenInFrom
      line: 218
      upvalues:
        tweenService (copy, index: 1)
    ]]
    local position = self.DisplayModel.Position
    local v69 = a67 - position
    self.DisplayModel.EndWaypointBillboard.StudsOffset = Vector3.new(0, v69.Y, 0)
    local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    local tween = tweenService:Create(self.DisplayModel.EndWaypointBillboard, tweenInfo, {StudsOffset = Vector3.new(0, 0, 0)})
    tween:Play()

    return tween
end

function Class2.new(a72, closestWayPoint, a74)
    --[[
      name: new
      line: 229
      upvalues:
        Class2 (copy, index: 1)
    ]]
    local v75 = setmetatable({}, Class2)
    v75.DisplayModel = v75:NewDisplayModel(a72)
    v75.Destroyed = false

    if not a74 or not (5 < (a74 - a72).Magnitude) then
        v75.Tween = v75:CreateTween()
    else
        v75.Tween = v75:TweenInFrom(a74)

        coroutine.wrap(
            function()
                --[[
                  line: 236
                  upvalues:
                    v75 (copy, index: 1)
                ]]
                v75.Tween.Completed:Wait()

                if not v75.Destroyed then
                    v75.Tween = v75:CreateTween()
                end
            end
        )()
    end

    v75.ClosestWayPoint = closestWayPoint

    return v75
end

local Class3 = {}
Class3.__index = Class3

function Class3.Hide(self)
    --[[
      name: Hide
      line: 253
    ]]
    self.DisplayModel.Parent = nil
end

function Class3.Destroy(self)
    --[[
      name: Destroy
      line: 257
    ]]
    self.DisplayModel:Destroy()
end

function Class3.NewDisplayModel(self, a80)
    --[[
      name: NewDisplayModel
      line: 261
      upvalues:
        v35 (ref,  index: 1)
        placePathWaypoint (copy, index: 2)
        userFlag (copy, index: 3)
        raycastParams (copy, index: 4)
        workspace (copy, index: 5)
        localPlayer (copy, index: 6)
    ]]
    local v81 = v35:Clone()
    placePathWaypoint(v81, a80)

    if userFlag then
        raycastParams.FilterDescendantsInstances = {workspace.CurrentCamera, localPlayer.Character}

        if const raycastResult = workspace:Raycast(a80 + Vector3.new(0, 2.5, 0), Vector3.new(-0, -10, -0), raycastParams) then
            v81.CFrame = CFrame.lookAlong(raycastResult.Position, raycastResult.Normal)
            local camera = workspace.CurrentCamera
            local clickToMoveDisplay = camera:FindFirstChild("ClickToMoveDisplay")
            if not clickToMoveDisplay then
                clickToMoveDisplay = Instance.new("Model")
                clickToMoveDisplay.Name = "ClickToMoveDisplay"
                clickToMoveDisplay.Parent = camera
            end

            v81.Parent = clickToMoveDisplay

            return v81
        end
    else
        local partOnRay, v86, v87 = workspace:FindPartOnRayWithIgnoreList(Ray.new(a80 + Vector3.new(0, 2.5, 0), Vector3.new(0, -10, 0)), {workspace.CurrentCamera, localPlayer.Character})
        if partOnRay then
            v81.CFrame = CFrame.new(v86, v86 + v87)
            local camera = workspace.CurrentCamera
            local clickToMoveDisplay = camera:FindFirstChild("ClickToMoveDisplay")
            if not clickToMoveDisplay then
                clickToMoveDisplay = Instance.new("Model")
                clickToMoveDisplay.Name = "ClickToMoveDisplay"
                clickToMoveDisplay.Parent = camera
            end

            v81.Parent = clickToMoveDisplay
        end
    end

    return v81
end

function Class3.RunFailureTween(self)
    --[[
      name: RunFailureTween
      line: 284
      upvalues:
        tweenService (copy, index: 1)
        sizeOffset4 (copy, index: 2)
        sizeOffset5 (copy, index: 3)
        sizeOffset3 (copy, index: 4)
    ]]
    wait(0.125)
    local tweenInfo = TweenInfo.new(0.0625, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    local tween = tweenService:Create(self.DisplayModel.FailureWaypointBillboard, tweenInfo, {SizeOffset = sizeOffset4})
    tween:Play()
    tweenService:Create(self.DisplayModel.FailureWaypointBillboard.Frame, tweenInfo, {Rotation = 10}):Play()
    tween.Completed:wait()
    local tweenInfo2 = TweenInfo.new(0.125, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 3, true)
    local tween2 = tweenService:Create(self.DisplayModel.FailureWaypointBillboard, tweenInfo2, {SizeOffset = sizeOffset5})
    tween2:Play()
    local tweenInfo3 = TweenInfo.new(0.125, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 3, true)
    local tween3 = tweenService:Create(self.DisplayModel.FailureWaypointBillboard.Frame.ImageLabel, tweenInfo3, {ImageColor3 = Color3.new(0.75, 0.75, 0.75)})
    tween3:Play()
    local tween4 = tweenService:Create(self.DisplayModel.FailureWaypointBillboard.Frame, tweenInfo3, {Rotation = -10})
    tween4:Play()
    tween2.Completed:wait()
    local tweenInfo4 = TweenInfo.new(0.0625, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    local tween5 = tweenService:Create(self.DisplayModel.FailureWaypointBillboard, tweenInfo4, {SizeOffset = sizeOffset3})
    tween5:Play()
    tweenService:Create(self.DisplayModel.FailureWaypointBillboard.Frame, tweenInfo4, {Rotation = 0}):Play()
    tween5.Completed:wait()
    wait(0.125)
end

function Class3.new(a100)
    --[[
      name: new
      line: 355
      upvalues:
        Class3 (copy, index: 1)
    ]]
    local v101 = setmetatable({}, Class3)
    v101.DisplayModel = v101:NewDisplayModel(a100)
    return v101
end

local animation = Instance.new("Animation")
animation.AnimationId = "rbxassetid://2874840706"
local v103 = nil

local function getFailureAnimationTrack(a105)
    --[[
      name: getFailureAnimationTrack
      line: 369
      upvalues:
        v103 (ref,  index: 1)
        animation (copy, index: 2)
    ]]
    if a105 == nil then
        return v103
    end

    v103 = a105:LoadAnimation(animation)
    assert(v103, "")
    v103.Priority = Enum.AnimationPriority.Action
    v103.Looped = false

    return v103
end

local function findPlayerHumanoid()
    --[[
      name: findPlayerHumanoid
      line: 380
      upvalues:
        localPlayer (copy, index: 1)
    ]]
    if const character = localPlayer.Character then
        return character:FindFirstChildOfClass("Humanoid")
    end
end

local function createTrailDots(a109, a110)
    --[[
      name: createTrailDots
      line: 387
      upvalues:
        Class (copy, index: 1)
        Class2 (copy, index: 2)
    ]]
    local v111 = {}
    local writeIndex = 1

    for index = 1, #a109 - 1 do
        local v114 = (a109[index].Position - a109[#a109].Position).Magnitude < 3
        local v115 = index % 2 == 0 and not v114
        if v115 then
            v111[writeIndex] = Class.new(a109[index].Position, index)
            writeIndex += 1
        end
    end

    table.insert(v111, (Class2.new(a109[#a109].Position, #a109, a110)))
    local v116 = {}
    local writeIndex2 = 1

    for index = #v111, 1, -1 do
        v116[writeIndex2] = v111[index]
        writeIndex2 += 1
    end

    return v116
end

local function getTrailDotScale(a120, a121)
    --[[
      name: getTrailDotScale
      line: 412
    ]]
    return a121 * (((math.clamp(a120 - 10, 0, 90) / 90) * 1.5) + 1)
end

local count = 0

function v1.CreatePathDisplay(a123, a124)
    --[[
      name: CreatePathDisplay
      line: 421
      upvalues:
        count (ref,  index: 1)
        createTrailDots (copy, index: 2)
        runService (copy, index: 3)
        workspace (copy, index: 4)
        size2 (ref,  index: 5)
    ]]
    count += 1
    local trailDots = createTrailDots(a123, a124)

    local function removePathBeforePoint(a127)
        --[[
          name: removePathBeforePoint
          line: 425
          upvalues:
            trailDots (copy, index: 1)
        ]]
        for trailDotKey = #trailDots, 1, -1 do
            local trailDot = trailDots[trailDotKey]

            if not (trailDot.ClosestWayPoint <= a127) then
                break
            end

            trailDot:Destroy()
            trailDots[trailDotKey] = nil
        end
    end

    local name = "ClickToMoveResizeTrail" .. count

    local function resizeTrailDots()
        --[[
          name: resizeTrailDots
          line: 439
          upvalues:
            trailDots (copy, index: 1)
            runService (copy, index: 2)
            name (copy, index: 3)
            workspace (copy, index: 4)
            size2 (ref,  index: 5)
        ]]
        if #trailDots == 0 then
            runService:UnbindFromRenderStep(name)
            return
        end

        local position = workspace.CurrentCamera.CFrame.Position

        for trailDotKey = 1, #trailDots do
            if const trailDotImage = trailDots[trailDotKey].DisplayModel:FindFirstChild("TrailDotImage") then
                trailDotImage.Size = size2 * (((math.clamp((trailDots[trailDotKey].DisplayModel.Position - position).Magnitude - 10, 0, 90) / 90) * 1.5) + 1)
            end
        end
    end

    runService:BindToRenderStep(name, Enum.RenderPriority.Camera.Value - 1, resizeTrailDots)

    return function()
        --[[
          name: removePath
          line: 455
          upvalues:
            removePathBeforePoint (copy, index: 1)
            a123 (copy, index: 2)
        ]]
        removePathBeforePoint(#a123)
    end, removePathBeforePoint
end

local class = nil

function v1.DisplayFailureWaypoint(a136)
    --[[
      name: DisplayFailureWaypoint
      line: 463
      upvalues:
        class (ref,  index: 1)
        Class3 (copy, index: 2)
    ]]
    if class then
        class:Hide()
    end

    local class2 = Class3.new(a136)
    class = class2

    coroutine.wrap(
        function()
            --[[
              line: 469
              upvalues:
                class2 (ref, index: 1)
            ]]
            class2:RunFailureTween()
            class2:Destroy()
            class2 = nil
        end
    )()
end

function v1.CreateEndWaypoint(a138)
    --[[
      name: CreateEndWaypoint
      line: 476
      upvalues:
        Class2 (copy, index: 1)
    ]]
    return Class2.new(a138)
end

function v1.PlayFailureAnimation()
    --[[
      name: PlayFailureAnimation
      line: 480
      upvalues:
        localPlayer (copy, index: 1)
        v103 (ref,  index: 2)
        animation (copy, index: 3)
    ]]
    local humanoid = if const character = localPlayer.Character then character:FindFirstChildOfClass("Humanoid") else nil

    if humanoid then
        local v141

        if humanoid ~= nil then
            v103 = humanoid:LoadAnimation(animation)
            assert(v103, "")
            v103.Priority = Enum.AnimationPriority.Action
            v103.Looped = false
            v141 = v103
        else
            v141 = v103
        end

        v141:Play()
    end
end

function v1.CancelFailureAnimation()
    --[[
      name: CancelFailureAnimation
      line: 488
      upvalues:
        v103 (ref, index: 1)
    ]]
    if v103 ~= nil and v103.IsPlaying then
        v103:Stop()
    end
end

function v1.SetWaypointTexture(waypointTexture)
    --[[
      name: SetWaypointTexture
      line: 494
      upvalues:
        image (ref,  index: 1)
        waypointTemplates (ref,  index: 2)
        v34 (ref,  index: 3)
        v35 (ref,  index: 4)
        CreateWaypointTemplates (copy, index: 5)
    ]]
    image = waypointTexture
    waypointTemplates, v34, v35 = CreateWaypointTemplates()
end

function v1.GetWaypointTexture()
    --[[
      name: GetWaypointTexture
      line: 499
      upvalues:
        image (ref, index: 1)
    ]]
    return image
end

function v1.SetWaypointRadius(a143: number)
    --[[
      name: SetWaypointRadius
      line: 503
      upvalues:
        size2 (ref,  index: 1)
        waypointTemplates (ref,  index: 2)
        v34 (ref,  index: 3)
        v35 (ref,  index: 4)
        CreateWaypointTemplates (copy, index: 5)
    ]]
    size2 = Vector2.new(a143, a143)
    waypointTemplates, v34, v35 = CreateWaypointTemplates()
end

function v1.GetWaypointRadius()
    --[[
      name: GetWaypointRadius
      line: 508
      upvalues:
        size2 (ref, index: 1)
    ]]
    return size2.X
end

function v1.SetEndWaypointTexture(endWaypointTexture)
    --[[
      name: SetEndWaypointTexture
      line: 512
      upvalues:
        image2 (ref,  index: 1)
        waypointTemplates (ref,  index: 2)
        v34 (ref,  index: 3)
        v35 (ref,  index: 4)
        CreateWaypointTemplates (copy, index: 5)
    ]]
    image2 = endWaypointTexture
    waypointTemplates, v34, v35 = CreateWaypointTemplates()
end

function v1.GetEndWaypointTexture()
    --[[
      name: GetEndWaypointTexture
      line: 517
      upvalues:
        image2 (ref, index: 1)
    ]]
    return image2
end

function v1.SetWaypointsAlwaysOnTop(waypointsAlwaysOnTop)
    --[[
      name: SetWaypointsAlwaysOnTop
      line: 521
      upvalues:
        alwaysOnTop (ref,  index: 1)
        waypointTemplates (ref,  index: 2)
        v34 (ref,  index: 3)
        v35 (ref,  index: 4)
        CreateWaypointTemplates (copy, index: 5)
    ]]
    alwaysOnTop = waypointsAlwaysOnTop
    waypointTemplates, v34, v35 = CreateWaypointTemplates()
end

function v1.GetWaypointsAlwaysOnTop()
    --[[
      name: GetWaypointsAlwaysOnTop
      line: 526
      upvalues:
        alwaysOnTop (ref, index: 1)
    ]]
    return alwaysOnTop
end

return v1