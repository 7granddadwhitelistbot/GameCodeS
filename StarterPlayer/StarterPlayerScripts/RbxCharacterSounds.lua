local function loadFlag(a2)
    --[[
      name: loadFlag
      line: 12
    ]]
    local success, isUserFeatureEnabled = pcall(
        function()
            --[[
              line: 13
              upvalues:
                a2 (copy, index: 1)
            ]]
            return UserSettings():IsUserFeatureEnabled(a2)
        end
    )
    return success and isUserFeatureEnabled
end

local players = game:GetService("Players")
local runService = game:GetService("RunService")
local soundService = game:GetService("SoundService")
local AtomicBinding = require(script:WaitForChild("AtomicBinding"))
local v9 = "UserSoundsUseRelativeVelocity2"
local success, isUserFeatureEnabled = pcall(
    function()
        --[[
          line: 13
          upvalues:
            v9 (copy, index: 1)
        ]]
        return UserSettings():IsUserFeatureEnabled(v9)
    end
)
local isUserFeatureEnabled2 = success and isUserFeatureEnabled
local v13 = "UserNewCharacterSoundsApi3"
local success2, isUserFeatureEnabled3 = pcall(
    function()
        --[[
          line: 13
          upvalues:
            v13 (copy, index: 1)
        ]]
        return UserSettings():IsUserFeatureEnabled(v13)
    end
)
local isUserFeatureEnabled4 = success2 and isUserFeatureEnabled3
local v17 = "UserFixCharSoundsEmitters"
local success3, isUserFeatureEnabled5 = pcall(
    function()
        --[[
          line: 13
          upvalues:
            v17 (copy, index: 1)
        ]]
        return UserSettings():IsUserFeatureEnabled(v17)
    end
)
local isUserFeatureEnabled6 = success3 and isUserFeatureEnabled5
local v21 = "UserFixCharSoundsEmitterRootPart"
local success4, isUserFeatureEnabled7 = pcall(
    function()
        --[[
          line: 13
          upvalues:
            v21 (copy, index: 1)
        ]]
        return UserSettings():IsUserFeatureEnabled(v21)
    end
)
local isUserFeatureEnabled8 = success4 and isUserFeatureEnabled7
local v25 = {
    Climbing = {SoundId = "rbxasset://sounds/action_footsteps_plastic.mp3", Looped = true},
    Died = {SoundId = "rbxasset://sounds/uuhhh.mp3"},
    FreeFalling = {SoundId = "rbxasset://sounds/action_falling.ogg", Looped = true},
    GettingUp = {SoundId = "rbxasset://sounds/action_get_up.mp3"},
    Jumping = {SoundId = "rbxasset://sounds/action_jump.mp3"},
    Landing = {SoundId = "rbxasset://sounds/action_jump_land.mp3"},
    Running = {SoundId = "rbxasset://sounds/action_footsteps_plastic.mp3", Looped = true, Pitch = 1.85},
    Splash = {SoundId = "rbxasset://sounds/impact_water.mp3"},
    Swimming = {SoundId = "rbxasset://sounds/action_swim.mp3", Looped = true, Pitch = 1.6}
}
local v26 = {
    Climbing = {AssetId = "rbxasset://sounds/action_footsteps_plastic.mp3", Looping = true},
    Died = {AssetId = "rbxasset://sounds/uuhhh.mp3"},
    FreeFalling = {AssetId = "rbxasset://sounds/action_falling.ogg", Looping = true},
    GettingUp = {AssetId = "rbxasset://sounds/action_get_up.mp3"},
    Jumping = {AssetId = "rbxasset://sounds/action_jump.mp3"},
    Landing = {AssetId = "rbxasset://sounds/action_jump_land.mp3"},
    Running = {AssetId = "rbxasset://sounds/action_footsteps_plastic.mp3", Looping = true, PlaybackSpeed = 1.85},
    Splash = {AssetId = "rbxasset://sounds/impact_water.mp3"},
    Swimming = {AssetId = "rbxasset://sounds/action_swim.mp3", Looping = true, PlaybackSpeed = 1.6}
}

local function map(a28, a29, a30, a31, a32)
    --[[
      name: map
      line: 97
    ]]
    return ((a28 - a29) * (a32 - a31) / (a30 - a29)) + a31
end

local function getRelativeVelocity(controllerManager, a35)
    --[[
      name: getRelativeVelocity
      line: 101
    ]]
    if not controllerManager then
        return a35
    end

    local v36 = controllerManager.ActiveController
        and (controllerManager.ActiveController:IsA("GroundController") and controllerManager.GroundSensor
            or controllerManager.ActiveController:IsA("ClimbController") and controllerManager.ClimbSensor)

    if v36 and v36.SensedPart then
        return a35 - v36.SensedPart:GetVelocityAtPosition(controllerManager.RootPart.Position)
    end

    return a35
end

local function playSound(a38, a39)
    --[[
      name: playSound
      line: 118
      upvalues:
        isUserFeatureEnabled4 (copy, index: 1)
    ]]
    if not a39 then
        a38.TimePosition = 0
    end

    if isUserFeatureEnabled4 and a38:IsA("AudioPlayer") then
        a38:Play()
        return
    end

    a38.Playing = true
end

local function stopSound(a41)
    --[[
      name: stopSound
      line: 129
      upvalues:
        isUserFeatureEnabled4 (copy, index: 1)
    ]]
    if isUserFeatureEnabled4 and a41:IsA("AudioPlayer") then
        a41:Stop()
        return
    end

    a41.Playing = false
end

local function playSoundIf(a43, playing)
    --[[
      name: playSoundIf
      line: 137
      upvalues:
        isUserFeatureEnabled4 (copy, index: 1)
    ]]
    if not isUserFeatureEnabled4 or not a43:IsA("AudioPlayer") then
        a43.Playing = playing
    else
        if a43.IsPlaying and not playing then
            a43:Stop()
            return
        end

        if not a43.IsPlaying and playing then
            a43:Play()
        end
    end
end

local function setSoundLooped(soundLooped, a47)
    --[[
      name: setSoundLooped
      line: 149
      upvalues:
        isUserFeatureEnabled4 (copy, index: 1)
    ]]
    if isUserFeatureEnabled4 and soundLooped:IsA("AudioPlayer") then
        soundLooped.Looping = a47
        return
    end

    soundLooped.Looped = a47
end

local function shallowCopy(a49)
    --[[
      name: shallowCopy
      line: 157
    ]]
    local v50 = {}

    for key, v52 in pairs(a49) do
        v50[key] = v52
    end

    return v50
end

local atomicBinding = AtomicBinding.new(
    {humanoid = "Humanoid", rootPart = "HumanoidRootPart"},
    function(a54)
        --[[
          name: initializeSoundSystem
          line: 165
          upvalues:
            isUserFeatureEnabled2 (copy, index: 1)
            isUserFeatureEnabled4 (copy, index: 2)
            soundService (copy, index: 3)
            isUserFeatureEnabled6 (copy, index: 4)
            isUserFeatureEnabled8 (copy, index: 5)
            players (copy, index: 6)
            v26 (copy, index: 7)
            v25 (copy, index: 8)
            getRelativeVelocity (copy, index: 9)
            runService (copy, index: 10)
        ]]
        local audioEmitter
        local v56

        local v57 = function(a58, a59, a60)
            --[[
              line: 337
            ]]
            if 75 < a60.Magnitude then
                a59.Volume = math.clamp(a59.Volume + (a58 * 0.9), 0, 1)
                return
            end

            a59.Volume = 0
        end

        local humanoid = a54.humanoid
        local rootPart = a54.rootPart
        local controllerManager = nil

        if isUserFeatureEnabled2 then
            local parent = humanoid.Parent
            controllerManager = parent:FindFirstChild("ControllerManager")
        end

        local v65 = {}

        if not isUserFeatureEnabled4 or soundService.CharacterSoundsUseNewApi ~= Enum.RolloutState.Enabled then
            for name, v67 in pairs(v25) do
                local sound = Instance.new("Sound")
                sound.Name = name
                sound.Archivable = false
                sound.RollOffMinDistance = 5
                sound.RollOffMaxDistance = 150
                sound.Volume = 0.65

                for key, v70 in pairs(v67) do
                    sound[key] = v70
                end

                sound.Parent = rootPart
                v65[name] = sound
            end

            audioEmitter = nil
        else
            local character = nil
            local v72 = nil

            if isUserFeatureEnabled6 then
                if isUserFeatureEnabled8 then
                    v72 = humanoid.RootPart or humanoid.Parent
                else
                    v72 = humanoid.RootPart
                end
            else
                local localPlayer = players.LocalPlayer
                character = localPlayer.Character
            end

            local curve = {}
            local v75 = 5

            while v75 < 150 do
                curve[v75] = 5 / v75
                v75 *= 1.25
            end

            curve[150] = 0
            local rbxCharacterSoundsEmitter = if isUserFeatureEnabled6 then Instance.new("AudioEmitter", v72) else Instance.new("AudioEmitter", character)
            rbxCharacterSoundsEmitter.Name = "RbxCharacterSoundsEmitter"
            rbxCharacterSoundsEmitter:SetDistanceAttenuation(curve)

            for name, v78 in pairs(v26) do
                local audioPlayer = Instance.new("AudioPlayer")
                local wire = Instance.new("Wire")
                audioPlayer.Name = name
                wire.Name = name .. "Wire"
                audioPlayer.Archivable = false
                audioPlayer.Volume = 0.65

                for key, v82 in pairs(v78) do
                    audioPlayer[key] = v82
                end

                audioPlayer.Parent = rootPart
                wire.Parent = audioPlayer
                wire.SourceInstance = audioPlayer
                wire.TargetInstance = rbxCharacterSoundsEmitter
                v65[name] = audioPlayer
            end

            audioEmitter = rbxCharacterSoundsEmitter
        end

        local v83 = {}

        local function stopPlayingLoopedSounds(a85)
            --[[
              name: stopPlayingLoopedSounds
              line: 241
              upvalues:
                v83 (copy, index: 1)
                isUserFeatureEnabled4 (copy, index: 2)
            ]]
            local pairs2 = pairs
            local v87 = {}

            for key, v89 in pairs(v83) do
                v87[key] = v89
            end

            for key in pairs2(v87) do
                local v91, v92 = false, false

                if key ~= (a85 or nil) then
                    if isUserFeatureEnabled4 then
                        if key:IsA("AudioPlayer") then
                            key:Stop()
                            v92 = true
                        else
                            v91 = true
                        end
                    else
                        v91 = true
                    end
                end

                if v91 then
                    key.Playing = false
                    v92 = true
                end

                if v92 then
                    v83[key] = nil
                end
            end
        end

        local v93 = {}

        v93[Enum.HumanoidStateType.FallingDown] = function()
            --[[
              line: 253
              upvalues:
                stopPlayingLoopedSounds (copy, index: 1)
            ]]
            stopPlayingLoopedSounds()
        end

        v93[Enum.HumanoidStateType.GettingUp] = function()
            --[[
              line: 257
              upvalues:
                stopPlayingLoopedSounds (copy, index: 1)
                v65 (copy, index: 2)
                isUserFeatureEnabled4 (copy, index: 3)
            ]]
            stopPlayingLoopedSounds()
            local gettingUp = v65.GettingUp
            gettingUp.TimePosition = 0

            if isUserFeatureEnabled4 and gettingUp:IsA("AudioPlayer") then
                gettingUp:Play()
                return
            end

            gettingUp.Playing = true
        end

        v93[Enum.HumanoidStateType.Jumping] = function()
            --[[
              line: 262
              upvalues:
                stopPlayingLoopedSounds (copy, index: 1)
                v65 (copy, index: 2)
                isUserFeatureEnabled4 (copy, index: 3)
            ]]
            stopPlayingLoopedSounds()
            local jumping = v65.Jumping
            jumping.TimePosition = 0

            if isUserFeatureEnabled4 and jumping:IsA("AudioPlayer") then
                jumping:Play()
                return
            end

            jumping.Playing = true
        end

        v93[Enum.HumanoidStateType.Swimming] = function()
            --[[
              line: 267
              upvalues:
                rootPart (copy, index: 1)
                v65 (copy, index: 2)
                isUserFeatureEnabled4 (copy, index: 3)
                stopPlayingLoopedSounds (copy, index: 4)
                v83 (copy, index: 5)
            ]]
            local absoluteValue = math.abs(rootPart.AssemblyLinearVelocity.Y)

            if 0.1 < absoluteValue then
                v65.Splash.Volume = math.clamp((((absoluteValue - 100) * 0.72) / 250) + 0.28, 0, 1)
                local splash = v65.Splash
                splash.TimePosition = 0

                if isUserFeatureEnabled4 and splash:IsA("AudioPlayer") then
                    splash:Play()
                else
                    splash.Playing = true
                end
            end

            stopPlayingLoopedSounds(v65.Swimming)
            local swimming = v65.Swimming

            if isUserFeatureEnabled4 and swimming:IsA("AudioPlayer") then
                swimming:Play()
            else
                swimming.Playing = true
            end

            v83[v65.Swimming] = true
        end

        v93[Enum.HumanoidStateType.Freefall] = function()
            --[[
              line: 278
              upvalues:
                v65 (copy, index: 1)
                stopPlayingLoopedSounds (copy, index: 2)
                isUserFeatureEnabled4 (copy, index: 3)
                v83 (copy, index: 4)
            ]]
            v65.FreeFalling.Volume = 0
            stopPlayingLoopedSounds(v65.FreeFalling)
            local freeFalling = v65.FreeFalling

            if isUserFeatureEnabled4 and freeFalling:IsA("AudioPlayer") then
                freeFalling.Looping = true
            else
                freeFalling.Looped = true
            end

            if v65.FreeFalling:IsA("Sound") then
                v65.FreeFalling.PlaybackRegionsEnabled = true
            end

            v65.FreeFalling.LoopRegion = NumberRange.new(2, 9)
            local freeFalling2 = v65.FreeFalling
            freeFalling2.TimePosition = 0

            if isUserFeatureEnabled4 and freeFalling2:IsA("AudioPlayer") then
                freeFalling2:Play()
            else
                freeFalling2.Playing = true
            end

            v83[v65.FreeFalling] = true
        end

        v93[Enum.HumanoidStateType.Landed] = function()
            --[[
              line: 292
              upvalues:
                stopPlayingLoopedSounds (copy, index: 1)
                rootPart (copy, index: 2)
                v65 (copy, index: 3)
                isUserFeatureEnabled4 (copy, index: 4)
            ]]
            stopPlayingLoopedSounds()
            local absoluteValue = math.abs(rootPart.AssemblyLinearVelocity.Y)

            if 75 < absoluteValue then
                v65.Landing.Volume = math.clamp((((absoluteValue - 50) * 1) / 50) + 0, 0, 1)
                local landing = v65.Landing
                landing.TimePosition = 0

                if isUserFeatureEnabled4 and landing:IsA("AudioPlayer") then
                    landing:Play()
                    return
                end

                landing.Playing = true
            end
        end

        v93[Enum.HumanoidStateType.Running] = function()
            --[[
              line: 301
              upvalues:
                stopPlayingLoopedSounds (copy, index: 1)
                v65 (copy, index: 2)
                isUserFeatureEnabled4 (copy, index: 3)
                v83 (copy, index: 4)
            ]]
            stopPlayingLoopedSounds(v65.Running)
            local running = v65.Running

            if isUserFeatureEnabled4 and running:IsA("AudioPlayer") then
                running:Play()
            else
                running.Playing = true
            end

            v83[v65.Running] = true
        end

        v93[Enum.HumanoidStateType.Climbing] = function()
            --[[
              line: 307
              upvalues:
                v65 (copy, index: 1)
                rootPart (copy, index: 2)
                isUserFeatureEnabled2 (copy, index: 3)
                getRelativeVelocity (copy, index: 4)
                controllerManager (ref,  index: 5)
                isUserFeatureEnabled4 (copy, index: 6)
                stopPlayingLoopedSounds (copy, index: 7)
                v83 (copy, index: 8)
            ]]
            local climbing = v65.Climbing
            local assemblyLinearVelocity = rootPart.AssemblyLinearVelocity
            local v106 = if isUserFeatureEnabled2 then getRelativeVelocity(controllerManager, assemblyLinearVelocity) else assemblyLinearVelocity

            if not (0.1 < math.abs(v106.Y)) then
                stopPlayingLoopedSounds()
            else
                if isUserFeatureEnabled4 and climbing:IsA("AudioPlayer") then
                    climbing:Play()
                else
                    climbing.Playing = true
                end

                stopPlayingLoopedSounds(climbing)
            end

            v83[climbing] = true
        end

        v93[Enum.HumanoidStateType.Seated] = function()
            --[[
              line: 320
              upvalues:
                stopPlayingLoopedSounds (copy, index: 1)
            ]]
            stopPlayingLoopedSounds()
        end

        v93[Enum.HumanoidStateType.Dead] = function()
            --[[
              line: 324
              upvalues:
                stopPlayingLoopedSounds (copy, index: 1)
                v65 (copy, index: 2)
                isUserFeatureEnabled4 (copy, index: 3)
            ]]
            stopPlayingLoopedSounds()
            local died = v65.Died
            died.TimePosition = 0

            if isUserFeatureEnabled4 and died:IsA("AudioPlayer") then
                died:Play()
                return
            end

            died.Playing = true
        end

        local v108 = {}

        v108[v65.Climbing] = function(a109, a110, a111)
            --[[
              line: 332
              upvalues:
                isUserFeatureEnabled2 (copy, index: 1)
                getRelativeVelocity (copy, index: 2)
                controllerManager (ref,  index: 3)
                isUserFeatureEnabled4 (copy, index: 4)
            ]]
            local v112 = if isUserFeatureEnabled2 then getRelativeVelocity(controllerManager, a111) else a111
            local playing = 0.1 < v112.Magnitude

            if not isUserFeatureEnabled4 or not a110:IsA("AudioPlayer") then
                a110.Playing = playing
            else
                if a110.IsPlaying and not playing then
                    a110:Stop()
                    return
                end

                if not a110.IsPlaying and playing then
                    a110:Play()
                end
            end
        end

        v108[v65.FreeFalling] = v57

        v108[v65.Running] = function(a114, a115, a116)
            --[[
              line: 345
              upvalues:
                humanoid (copy, index: 1)
                isUserFeatureEnabled4 (copy, index: 2)
            ]]
            local playing = 0.5 < a116.Magnitude and 0.5 < humanoid.MoveDirection.Magnitude

            if not isUserFeatureEnabled4 or not a115:IsA("AudioPlayer") then
                a115.Playing = playing
            else
                if a115.IsPlaying and not playing then
                    a115:Stop()
                    return
                end

                if not a115.IsPlaying and playing then
                    a115:Play()
                end
            end
        end

        local v118 = {}
        v118[Enum.HumanoidStateType.RunningNoPhysics] = Enum.HumanoidStateType.Running
        v56 = if const v119 = v118[humanoid:GetState()] then v119 else humanoid:GetState()

        local function transitionTo(key)
            --[[
              name: transitionTo
              line: 357
              upvalues:
                v93 (copy, index: 1)
                v56 (ref,  index: 2)
            ]]
            if const v122 = v93[key] then
                v122()
            end

            v56 = key
        end

        local v123 = v56

        if const v124 = v93[v123] then
            v124()
        end

        v56 = v123

        local v125 = humanoid.StateChanged:Connect(
            function(a126, a127)
                --[[
                  line: 369
                  upvalues:
                    v118 (copy, index: 1)
                    v56 (ref,  index: 2)
                    v93 (copy, index: 3)
                ]]
                a127 = v118[a127] or a127

                if a127 ~= v56 then
                    if const v128 = v93[a127] then
                        v128()
                    end

                    v56 = a127
                end
            end
        )

        local steppedConnection = runService.Stepped:Connect(
            function(time: number, deltaTime: number)
                --[[
                  line: 377
                  upvalues:
                    v83 (copy, index: 1)
                    v108 (copy, index: 2)
                    rootPart (copy, index: 3)
                ]]
                for key in pairs(v83) do
                    if const v133 = v108[key] then
                        v133(deltaTime, key, rootPart.AssemblyLinearVelocity)
                    end
                end
            end
        )

        return function()
            --[[
              name: terminate
              line: 388
              upvalues:
                v125 (copy, index: 1)
                steppedConnection (copy, index: 2)
                isUserFeatureEnabled8 (copy, index: 3)
                audioEmitter (ref,  index: 4)
                v65 (copy, index: 5)
            ]]
            v125:Disconnect()
            steppedConnection:Disconnect()

            if isUserFeatureEnabled8 and audioEmitter then
                audioEmitter:Destroy()
            end

            for _, v135 in pairs(v65) do
                v135:Destroy()
            end

            table.clear(v65)
        end
    end
)

local v136 = {}

local function characterAdded(character: Model)
    --[[
      name: characterAdded
      line: 415
      upvalues:
        atomicBinding (copy, index: 1)
    ]]
    atomicBinding:bindRoot(character)
end

local function characterRemoving(character: Model)
    --[[
      name: characterRemoving
      line: 419
      upvalues:
        atomicBinding (copy, index: 1)
    ]]
    atomicBinding:unbindRoot(character)
end

local function playerAdded(player: Player)
    --[[
      name: playerAdded
      line: 423
      upvalues:
        v136 (copy, index: 1)
        atomicBinding (copy, index: 2)
        characterAdded (copy, index: 3)
        characterRemoving (copy, index: 4)
    ]]
    local v143 = v136[player]
    if not v143 then
        v143 = {}
        v136[player] = v143
    end

    if player.Character then
        atomicBinding:bindRoot(player.Character)
    end

    table.insert(v143, player.CharacterAdded:Connect(characterAdded))
    table.insert(v143, player.CharacterRemoving:Connect(characterRemoving))
end

for _, player in ipairs(players:GetPlayers()) do
    task.spawn(playerAdded, player)
end

players.PlayerAdded:Connect(playerAdded)

players.PlayerRemoving:Connect(
    function(player: Player)
        --[[
          name: playerRemoving
          line: 437
          upvalues:
            v136 (copy, index: 1)
            atomicBinding (copy, index: 2)
        ]]
        if const v147 = v136[player] then
            for _, v149 in ipairs(v147) do
                v149:Disconnect()
            end

            v136[player] = nil
        end

        if player.Character then
            atomicBinding:unbindRoot(player.Character)
        end
    end
)