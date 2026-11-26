local collectionService = game:GetService("CollectionService")
local players = game:GetService("Players")
local tweenService = game:GetService("TweenService")
local v4 = {}
local localPlayer = players.LocalPlayer
local v6 = {}

local function isAlly(a8)
    --[[
      name: isAlly
      line: 17
      upvalues:
        localPlayer (copy, index: 1)
    ]]
    local character = localPlayer.Character
    local ownerUserId = a8:GetAttribute("OwnerUserId")

    if ownerUserId == localPlayer.UserId then
        return true
    end
    if not character then
        return false
    end

    local matchId = character:GetAttribute("MatchId")

    if type(matchId) == "string" and matchId ~= "" then
        return a8:GetAttribute("MatchId") == matchId and a8:GetAttribute("Team") == character:GetAttribute("Team")
    end

    return false
end

local function close(a13)
    --[[
      name: close
      line: 33
      upvalues:
        tweenService (copy, index: 1)
    ]]
    if a13.closed then
        return
    end

    a13.closed = true
    a13.model:GetPivot()

    for v14, v15 in {"JawA", "JawB"} do
        if const v16 = a13.model:FindFirstChild(v15) then
            if not v16:IsA("Model") then
                continue
            end

            local pivot = v16:GetPivot()
            local v18 = v14 ~= 1 and -1 or 1
            local value = pivot * CFrame.Angles(v18 * 1.4311699866353502, 0, 0)
            local instance = Instance.new("CFrameValue")
            instance.Value = pivot

            instance.Changed:Connect(
                function(value: CFrame)
                    --[[
                      line: 47
                      upvalues:
                        v16 (copy, index: 1)
                    ]]
                    if v16.Parent then
                        v16:PivotTo(value)
                    end
                end
            )

            local propertyTable = {Value = value}
            tweenService:Create(instance, TweenInfo.new(0.07, Enum.EasingStyle.Quad, Enum.EasingDirection.In), propertyTable):Play()
            task.delay(
                0.2,
                function()
                    --[[
                      line: 53
                      upvalues:
                        instance (copy, index: 1)
                    ]]
                    instance:Destroy()
                end
            )
        end
    end
end

local function register(bearTrap: Instance)
    --[[
      name: register
      line: 61
      upvalues:
        v6 (copy, index: 1)
        isAlly (copy, index: 2)
        localPlayer (copy, index: 3)
        close (copy, index: 4)
    ]]
    if not bearTrap:IsA("Model") or v6[bearTrap] then
        return
    end

    local parts = {}

    for _, descendant in bearTrap:GetDescendants() do
        if descendant:IsA("BasePart") then
            table.insert(parts, descendant)
        end
    end

    local v28 = {ring = nil, closed = false, lastAlpha = -1, model = bearTrap, parts = parts}
    v6[bearTrap] = v28

    if isAlly(bearTrap) then
        local allyRing = Instance.new("Part")
        allyRing.Name = "AllyRing"
        allyRing.Shape = Enum.PartType.Cylinder
        allyRing.Size = Vector3.new(0.05000000074505806, 6.400000095367432, 6.400000095367432)
        allyRing.Material = Enum.Material.SmoothPlastic
        allyRing.Color = Color3.fromRGB(90, 170, 240)
        allyRing.Transparency = 0.8
        allyRing.Anchored = true
        allyRing.CanCollide = false
        allyRing.CanQuery = false
        allyRing.CanTouch = false
        allyRing.CastShadow = false
        allyRing.CFrame = CFrame.new(bearTrap:GetPivot().Position + Vector3.new(0, 0.05000000074505806, 0)) * CFrame.Angles(0, 0, 1.5707963267948966)
        allyRing.Parent = bearTrap
        v28.ring = allyRing
    end

    local ownerUserId = bearTrap:GetAttribute("OwnerUserId")

    if ownerUserId == localPlayer.UserId then
        bearTrap:GetAttributeChangedSignal("Armed"):Connect(
            function()
                --[[
                  line: 91
                  upvalues:
                    bearTrap (copy, index: 1)
                ]]
                if bearTrap:GetAttribute("Armed") == true and bearTrap:GetAttribute("Sprung") ~= true then
                    require(script.Parent.Util).Sound("Trap_Armed", bearTrap:GetPivot().Position)
                end
            end
        )
    end

    bearTrap:GetAttributeChangedSignal("Sprung"):Connect(
        function()
            --[[
              line: 98
              upvalues:
                bearTrap (copy, index: 1)
                close (copy, index: 2)
                v28 (copy, index: 3)
            ]]
            if bearTrap:GetAttribute("Sprung") == true then
                close(v28)
            end
        end
    )

    if bearTrap:GetAttribute("Sprung") == true then
        close(v28)
    end
end

local function unregister(bearTrap: Instance)
    --[[
      name: unregister
      line: 108
      upvalues:
        v6 (copy, index: 1)
    ]]
    if bearTrap:IsA("Model") then
        v6[bearTrap] = nil
    end
end

local function update()
    --[[
      name: update
      line: 114
      upvalues:
        localPlayer (copy, index: 1)
        v6 (copy, index: 2)
        isAlly (copy, index: 3)
    ]]
    local camera = workspace.CurrentCamera
    local instance = localPlayer.Character
    instance = instance and instance:FindFirstChild("HumanoidRootPart")
    local position = if instance then instance.Position else camera.CFrame.Position

    for v37, v38 in v6 do
        if v37.Parent then
            local clampedValue = 0

            if not isAlly(v37) and v37:GetAttribute("Sprung") ~= true then
                local hiddenBeyond = v37:GetAttribute("HiddenBeyond")

                if type(hiddenBeyond) ~= "number" then
                    hiddenBeyond = 25
                end

                clampedValue = math.clamp(((v37:GetPivot().Position - position).Magnitude - (hiddenBeyond * 0.7)) / (hiddenBeyond * 0.3), 0, 1)
            end

            if 0.02 < math.abs(clampedValue - v38.lastAlpha) then
                v38.lastAlpha = clampedValue

                for _, part in v38.parts do
                    part.LocalTransparencyModifier = clampedValue
                end
            end
        else
            v6[v37] = nil
        end
    end
end

function v4.Init()
    --[[
      name: Init
      line: 141
      upvalues:
        collectionService (copy, index: 1)
        register (copy, index: 2)
        unregister (copy, index: 3)
        v6 (copy, index: 4)
        update (copy, index: 5)
    ]]
    collectionService:GetInstanceAddedSignal("BearTrap"):Connect(register)
    collectionService:GetInstanceRemovedSignal("BearTrap"):Connect(unregister)

    for _, bearTrap in collectionService:GetTagged("BearTrap") do
        register(bearTrap)
    end

    task.spawn(
        function()
            --[[
              line: 147
              upvalues:
                v6 (copy, index: 1)
                update (copy, index: 2)
            ]]
            while true do
                task.wait(0.1)

                if next(v6) then
                    local success, result = pcall(update)
                    if success then
                        continue
                    end

                    warn("[Combat] trap visuals:", result)
                end
            end
        end
    )
end

return v4