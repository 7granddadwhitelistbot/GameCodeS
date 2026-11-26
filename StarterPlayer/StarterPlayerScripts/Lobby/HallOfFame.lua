local collectionService = game:GetService("CollectionService")
local players = game:GetService("Players")
local tweenService = game:GetService("TweenService")
local workspace = game:GetService("Workspace")
local v5 = {18, 34}
local tweenInfo = TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local localPlayer = players.LocalPlayer
local random = Random.new()
local v9 = {}

local function anim(animationId: string)
    --[[
      name: anim
      line: 45
    ]]
    local animation = Instance.new("Animation")
    animation.AnimationId = animationId
    return animation
end

local function load(a14, animationId: string, priority, looped)
    --[[
      name: load
      line: 51
    ]]
    local success, result = pcall(
        function()
            --[[
              line: 52
              upvalues:
                a14 (copy, index: 1)
                animationId (copy, index: 2)
            ]]
            local animation = Instance.new("Animation")
            animation.AnimationId = animationId

            return a14:LoadAnimation(animation)
        end
    )

    if not success or not result then
        return nil
    end

    result.Priority = priority
    result.Looped = looped

    return result
end

local function teardown(a22)
    --[[
      name: teardown
      line: 63
      upvalues:
        v9 (copy, index: 1)
    ]]
    local v23 = v9[a22]
    if not v23 then
        return
    end

    v23.alive = false
    v9[a22] = nil

    if v23.plateAlpha then
        v23.plateAlpha:Destroy()
    end

    for _, v25 in {v23.idle, v23.wave, v23.cheer} do
        if v25 then
            v25:Stop(0)
            v25:Destroy()
        end
    end
end

local function setup(hallOfFameChampion: Instance)
    --[[
      name: setup
      line: 81
      upvalues:
        v9 (copy, index: 1)
        random (copy, index: 2)
    ]]
    if not hallOfFameChampion:IsA("Model") or v9[hallOfFameChampion] then
        return
    end

    local v28 = {root = nil, idle = nil, wave = nil, cheer = nil, greetedAt = -math.huge, alive = true, plate = nil, plateShown = false, plateAlpha = nil, model = hallOfFameChampion, nextEmote = os.clock() + random:NextNumber(6, 16)}
    v9[hallOfFameChampion] = v28

    task.spawn(
        function()
            --[[
              line: 99
              upvalues:
                hallOfFameChampion (copy, index: 1)
                v28 (copy, index: 2)
                random (copy, index: 3)
            ]]
            local humanoid = hallOfFameChampion:WaitForChild("Humanoid", 10)
            local animator = humanoid and humanoid:WaitForChild("Animator", 10)

            if not v28.alive or not animator or not animator:IsA("Animator") then
                return
            end

            local idleAnim
            local result
            local result2
            local result3
            local result4
            local v36 = hallOfFameChampion.PrimaryPart or hallOfFameChampion:FindFirstChild("HumanoidRootPart")
            v28.root = v36
            local idleAnim2 = hallOfFameChampion:GetAttribute("IdleAnim")

            if type(idleAnim2) ~= "string" or idleAnim2 == "" then
                idleAnim = "rbxassetid://507766388"
            else
                idleAnim = idleAnim2
            end

            local idle = Enum.AnimationPriority.Idle

            local success, result5 = pcall(
                function()
                    --[[
                      line: 52
                      upvalues:
                        animator (copy, index: 1)
                        idleAnim (copy, index: 2)
                    ]]
                    local animation = Instance.new("Animation")
                    animation.AnimationId = idleAnim

                    return animator:LoadAnimation(animation)
                end
            )

            if success and result5 then
                result5.Priority = idle
                result5.Looped = true
                result = result5
            else
                result = nil
            end

            if result then
                result2 = result
            else
                local idle2 = Enum.AnimationPriority.Idle
                local animationId = "rbxassetid://507766388"

                local success2, result6 = pcall(
                    function()
                        --[[
                          line: 52
                          upvalues:
                            animator (copy, index: 1)
                            animationId (copy, index: 2)
                        ]]
                        local animation = Instance.new("Animation")
                        animation.AnimationId = animationId

                        return animator:LoadAnimation(animation)
                    end
                )

                if success2 and result6 then
                    result6.Priority = idle2
                    result6.Looped = true
                    result2 = result6
                else
                    result2 = nil
                end
            end

            local action = Enum.AnimationPriority.Action
            local animationId = "rbxassetid://507770239"

            local success3, result7 = pcall(
                function()
                    --[[
                      line: 52
                      upvalues:
                        animator (copy, index: 1)
                        animationId (copy, index: 2)
                    ]]
                    local animation = Instance.new("Animation")
                    animation.AnimationId = animationId

                    return animator:LoadAnimation(animation)
                end
            )

            if success3 and result7 then
                result7.Priority = action
                result7.Looped = false
                result3 = result7
            else
                result3 = nil
            end

            v28.wave = result3
            local action2 = Enum.AnimationPriority.Action
            local animationId2 = "rbxassetid://507770677"

            local success4, result8 = pcall(
                function()
                    --[[
                      line: 52
                      upvalues:
                        animator (copy, index: 1)
                        animationId2 (copy, index: 2)
                    ]]
                    local animation = Instance.new("Animation")
                    animation.AnimationId = animationId2

                    return animator:LoadAnimation(animation)
                end
            )

            if success4 and result8 then
                result8.Priority = action2
                result8.Looped = false
                result4 = result8
            else
                result4 = nil
            end

            v28.cheer = result4

            if not v28.alive then
                return
            end

            v28.idle = result2

            if result2 then
                result2:Play(0.4, 1, random:NextNumber(0.85, 1))

                task.delay(
                    0.2,
                    function()
                        --[[
                          line: 118
                          upvalues:
                            v28 (copy, index: 1)
                            result2 (copy, index: 2)
                            random (copy, index: 3)
                        ]]
                        if v28.alive and 0 < result2.Length then
                            result2.TimePosition = random:NextNumber(0, result2.Length)
                        end
                    end
                )
            end
        end
    )
end

local function emote(wave)
    --[[
      name: emote
      line: 127
    ]]
    if not wave or wave.IsPlaying then
        return
    end

    wave:Play(0.3, 1, 1)
end

for _, hallOfFameChampion in collectionService:GetTagged("HallOfFameChampion") do
    setup(hallOfFameChampion)
end

collectionService:GetInstanceAddedSignal("HallOfFameChampion"):Connect(setup)

collectionService:GetInstanceRemovedSignal("HallOfFameChampion"):Connect(
    function(hallOfFameChampion: Instance)
        --[[
          line: 138
          upvalues:
            teardown (copy, index: 1)
        ]]
        if hallOfFameChampion:IsA("Model") then
            teardown(hallOfFameChampion)
        end
    end
)

local function bindPlate(a63, plate, plateShown: boolean)
    --[[
      name: bindPlate
      line: 146
    ]]
    local value

    if a63.plateAlpha then
        a63.plateAlpha:Destroy()
    end

    local v67 = {}

    for _, gui in plate:GetDescendants() do
        if gui:IsA("GuiObject") then
            local v70 = {gui = gui, bg = gui.BackgroundTransparency, text = if gui:IsA("TextLabel") then gui.TextTransparency else nil}
            table.insert(v67, v70)
        end
    end

    local plateAlpha = Instance.new("NumberValue")

    local function apply(a73: number)
        --[[
          name: apply
          line: 157
          upvalues:
            v67 (copy, index: 1)
            plate (copy, index: 2)
        ]]
        for _, v75 in v67 do
            v75.gui.BackgroundTransparency = v75.bg + ((1 - v75.bg) * a73)

            if v75.text then
                v75.gui.TextTransparency = v75.text + ((1 - v75.text) * a73)
            end
        end

        local enabled = a73 < 0.99
        plate.Enabled = enabled
    end

    plateAlpha.Changed:Connect(apply)

    if plateShown then
        value = 0
    else
        value = 1
    end

    plateAlpha.Value = value
    apply(plateAlpha.Value)
    a63.plate = plate
    a63.plateShown = plateShown
    a63.plateAlpha = plateAlpha
end

local function updatePlate(a78, a79, position: Vector3)
    --[[
      name: updatePlate
      line: 172
      upvalues:
        bindPlate (copy, index: 1)
        tweenService (copy, index: 2)
        tweenInfo (copy, index: 3)
    ]]
    local nameplate = a79:FindFirstChild("Nameplate")

    if not nameplate or not nameplate:IsA("BillboardGui") then
        a78.plate = nil
        return
    end

    local magnitude = (a79.Position - position).Magnitude

    if nameplate ~= a78.plate then
        bindPlate(a78, nameplate, magnitude <= 27)
        return
    end

    local plateShown = if a78.plateShown then magnitude <= 31 else magnitude <= 27

    if plateShown ~= a78.plateShown and a78.plateAlpha then
        local value
        a78.plateShown = plateShown
        local plateAlpha = a78.plateAlpha
        local propertyTable = {}

        if plateShown then
            value = 0
        else
            value = 1
        end

        propertyTable.Value = value
        tweenService:Create(plateAlpha, tweenInfo, propertyTable):Play()
    end
end

task.spawn(
    function()
        --[[
          line: 191
          upvalues:
            workspace (copy, index: 1)
            localPlayer (copy, index: 2)
            v9 (copy, index: 3)
            teardown (copy, index: 4)
            updatePlate (copy, index: 5)
            random (copy, index: 6)
            v5 (copy, index: 7)
            emote (copy, index: 8)
        ]]
        while true do
            task.wait(0.25)
            local camera = workspace.CurrentCamera
            local instance = localPlayer.Character
            instance = instance and instance:FindFirstChild("HumanoidRootPart")
            local timestamp = os.clock()

            for v90, v91 in v9 do
                if v90.Parent then
                    local v92 = if const root = v91.root then root else v90.PrimaryPart

                    if v92 and camera then
                        updatePlate(v91, v92, camera.CFrame.Position)
                    end

                    if v92 then
                        if not v91.idle then
                            continue
                        end
                        if not instance then
                            continue
                        end

                        local magnitude = (v92.Position - instance.Position).Magnitude

                        if magnitude <= 22 and 40 < timestamp - v91.greetedAt then
                            v91.greetedAt = timestamp
                            v91.nextEmote = timestamp + random:NextNumber(v5[1], v5[2])
                            task.delay(random:NextNumber(0, 0.7), emote, v91.wave)
                        elseif magnitude <= 90 then
                            if v91.nextEmote <= timestamp then
                                local v95
                                v91.nextEmote = timestamp + random:NextNumber(v5[1], v5[2])

                                if v90:GetAttribute("Rank") == 1 then
                                    if not (random:NextNumber() < 0.6) then
                                        v95 = v91.wave
                                    else
                                        v95 = v91.cheer
                                    end
                                else
                                    v95 = v91.wave
                                end

                                if v95 and not v95.IsPlaying then
                                    v95:Play(0.3, 1, 1)
                                end
                            end
                        end
                    end
                else
                    teardown(v90)
                end
            end
        end
    end
)