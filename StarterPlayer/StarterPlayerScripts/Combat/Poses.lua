local collectionService = game:GetService("CollectionService")
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local v4 = {}
local localPlayer = players.LocalPlayer
v4.POSES = {}
local v6 = {}
local v7 = {}

local function rebuild()
    --[[
      name: rebuild
      line: 37
      upvalues:
        v4 (copy, index: 1)
        v7 (copy, index: 2)
    ]]
    for v9, pose in v4.POSES do
        local v11 = {}

        for v12, v13 in pose do
            v11[v12] = CFrame.Angles(math.rad(v13.X), math.rad(v13.Y), (math.rad(v13.Z)))
        end

        v7[v9] = v11
    end
end

rebuild()
v4.Rebuild = rebuild
local v14 = {"RightShoulder", "RightElbow", "RightWrist", "LeftShoulder", "LeftElbow"}

local function findMotors(model)
    --[[
      name: findMotors
      line: 50
      upvalues:
        v14 (copy, index: 1)
    ]]
    local v17 = {}

    for _, v19 in v14 do
        if const v20 = model:FindFirstChild(v19, true) then
            if v20:IsA("Motor6D") or v20:IsA("AnimationConstraint") then
                v17[v19] = v20
            end
        end
    end

    return v17
end

local function stateOf(model)
    --[[
      name: stateOf
      line: 61
      upvalues:
        v6 (copy, index: 1)
        findMotors (copy, index: 2)
    ]]
    local v23 = v6[model]
    if not v23 then
        v23 = {pose = nil, alpha = 0, kick = 0, model = model, motors = findMotors(model)}
        v6[model] = v23
    end

    return v23
end

local function refresh(model)
    --[[
      name: refresh
      line: 70
      upvalues:
        v7 (copy, index: 1)
        v6 (copy, index: 2)
        findMotors (copy, index: 3)
    ]]
    local kind
    local tool = model:FindFirstChildOfClass("Tool")
    local kind2 = tool and tool:GetAttribute("Kind")

    if type(kind2) ~= "string" or not v7[kind2] then
        kind = nil
    else
        kind = kind2
    end

    if kind then
        local v29 = v6[model]
        if not v29 then
            v29 = {pose = nil, alpha = 0, kick = 0, model = model, motors = findMotors(model)}
            v6[model] = v29
        end

        v29.pose = kind
        v29.motors = findMotors(model)
    elseif v6[model] then
        v6[model].pose = nil
    end
end

function v4.Kick(model, a31: number)
    --[[
      name: Kick
      line: 85
      upvalues:
        v6 (copy, index: 1)
        findMotors (copy, index: 2)
    ]]
    if not model then
        return
    end

    local v32 = v6[model]
    if not v32 then
        v32 = {pose = nil, alpha = 0, kick = 0, model = model, motors = findMotors(model)}
        v6[model] = v32
    end

    if not next(v32.motors) then
        v32.motors = findMotors(model)
    end

    v32.kick = math.max(v32.kick, (math.min(a31, 45)))
end

local v33 = {}

local function watch(key)
    --[[
      name: watch
      line: 97
      upvalues:
        v33 (copy, index: 1)
        refresh (copy, index: 2)
        v6 (copy, index: 3)
    ]]
    if v33[key] then
        return
    end

    v33[key] = true

    key.ChildAdded:Connect(
        function(a36)
            --[[
              line: 102
              upvalues:
                refresh (copy, index: 1)
                key (copy, index: 2)
            ]]
            if a36:IsA("Tool") then
                task.defer(refresh, key)
            end
        end
    )

    key.ChildRemoved:Connect(
        function(a37)
            --[[
              line: 107
              upvalues:
                refresh (copy, index: 1)
                key (copy, index: 2)
            ]]
            if a37:IsA("Tool") then
                task.defer(refresh, key)
            end
        end
    )

    key.Destroying:Once(
        function()
            --[[
              line: 112
              upvalues:
                v33 (copy, index: 1)
                key (copy, index: 2)
                v6 (copy, index: 3)
            ]]
            v33[key] = nil
            v6[key] = nil
        end
    )

    refresh(key)
end

v4.Watch = watch

local function step(deltaTimeSim: number)
    --[[
      name: step
      line: 121
      upvalues:
        localPlayer (copy, index: 1)
        v6 (copy, index: 2)
        v7 (copy, index: 3)
    ]]
    local character = localPlayer.Character
    local v41

    for v42, v41 in v6 do
        if v42:IsDescendantOf(workspace) then
            local v43 = v41.pose and 1 or 0

            if v41.alpha < v43 then
                v41.alpha = math.min(1, v41.alpha + (deltaTimeSim / 0.1))
            else
                v41.alpha = math.max(0, v41.alpha - (deltaTimeSim / 0.14))
            end

            v41.kick = math.max(0, (v41.kick - ((deltaTimeSim * v41.kick) * 14)) - (deltaTimeSim * 20))

            if v41.alpha <= 0 and v41.kick <= 0 then
                if not v41.pose then
                    v6[v42] = nil
                end
            else
                local alpha = v41.alpha * v41.alpha * (3 - (v41.alpha * 2))
                local v45 = v41.pose and v7[v41.pose]
                local rotationX = 0

                if v42 == character and v41.pose then
                    local camera = workspace.CurrentCamera
                    rotationX = math.asin((math.clamp(camera.CFrame.LookVector.Y, -1, 1)))
                end

                for v48, motor in v41.motors do
                    local transform, v51, cframeAngles, kick
                    local targetValue
                    local v55
                    local v56, v57, v58, v59 = false, false, false, false

                    if motor.Parent then
                        transform = motor.Transform

                        if v45 then
                            if v45[v48] then
                                v51 = v45[v48]

                                if v48 ~= "RightShoulder" then
                                    targetValue = v51
                                elseif rotationX == 0 then
                                    targetValue = v51
                                else
                                    targetValue = CFrame.Angles(rotationX, 0, 0) * v51
                                end

                                v56 = true
                            else
                                v55 = transform
                                v57 = true
                            end
                        else
                            v55 = transform
                            v57 = true
                        end
                    end

                    if v56 then
                        local startValue
                        v55 = startValue:Lerp(targetValue, alpha)
                        v57 = true
                    end

                    if v57 then
                        if not (0 < v41.kick) then
                            v59 = true
                        elseif v48 == "RightShoulder" then
                            v58 = true
                        elseif v48 ~= "RightElbow" then
                            v59 = true
                        else
                            v58 = true
                        end
                    end

                    if v58 then
                        local v61
                        cframeAngles = CFrame.Angles
                        kick = v41.kick

                        if v48 ~= "RightElbow" then
                            v61 = 1
                        else
                            v61 = 0.6
                        end

                        v55 = cframeAngles(math.rad(kick * v61), 0, 0) * v55
                        v59 = true
                    end

                    if v59 then
                        motor.Transform = v55
                    end
                end
            end
        else
            v6[v42] = nil
        end
    end
end

local hasRun = false

function v4.Init()
    --[[
      name: Init
      line: 169
      upvalues:
        hasRun (ref,  index: 1)
        runService (copy, index: 2)
        step (copy, index: 3)
        watch (copy, index: 4)
        players (copy, index: 5)
        collectionService (copy, index: 6)
    ]]
    if hasRun then
        return
    end

    hasRun = true
    runService.PreSimulation:Connect(step)

    for _, player in players:GetPlayers() do
        player.CharacterAdded:Connect(watch)

        if player.Character then
            watch(player.Character)
        end
    end

    players.PlayerAdded:Connect(
        function(player: Player)
            --[[
              name: onPlayer
              line: 175
              upvalues:
                watch (copy, index: 1)
            ]]
            player.CharacterAdded:Connect(watch)

            if player.Character then
                watch(player.Character)
            end
        end
    )

    for _, tag in {"Combatant", "Bot"} do
        collectionService:GetInstanceAddedSignal(tag):Connect(
            function(instance: Instance)
                --[[
                  line: 186
                  upvalues:
                    watch (copy, index: 1)
                ]]
                if instance:IsA("Model") then
                    watch(instance)
                end
            end
        )

        for _, instance in collectionService:GetTagged(tag) do
            if instance:IsA("Model") then
                watch(instance)
            end
        end
    end
end

return v4