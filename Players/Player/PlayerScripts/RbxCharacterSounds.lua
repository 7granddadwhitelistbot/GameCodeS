local Players_upv_1 = game:GetService("Players")
local RunService_upv_1 = game:GetService("RunService")
local SoundService_upv_1 = game:GetService("SoundService")
local characterAdded = require(script:WaitForChild("AtomicBinding"))
local function loadFlag(a1)
    --[[
      name: loadFlag
      line: 12
    ]]
    local success_1, v1 = pcall(function() end)
    return success_1 and v1
end
local _ = "UserSoundsUseRelativeVelocity2"
local success_2, v2 = pcall(function() end)
local u1 = success_2 and v2
local v6 = "UserNewCharacterSoundsApi3"
local success_3, v3 = pcall(function() end)
local u2 = success_3 and v3
local v7 = "UserFixCharSoundsEmitters"
local success_4, v4 = pcall(function() end)
local u3 = success_4 and v4
local u4 = "UserFixCharSoundsEmitterRootPart"
local success_5, v5 = pcall(
    function()
        --[[
          line: 13
          upvalues:
            u4 (copy, index: 1)
        ]]
        return UserSettings():IsUserFeatureEnabled(u4)
    end
)
local u5 = success_5 and v5
local tbl_upv_1 = {}
tbl_upv_1.Climbing = {SoundId = "rbxasset://sounds/action_footsteps_plastic.mp3", Looped = true}
tbl_upv_1.Died = {SoundId = "rbxasset://sounds/uuhhh.mp3"}
tbl_upv_1.FreeFalling = {SoundId = "rbxasset://sounds/action_falling.ogg", Looped = true}
tbl_upv_1.GettingUp = {SoundId = "rbxasset://sounds/action_get_up.mp3"}
tbl_upv_1.Jumping = {SoundId = "rbxasset://sounds/action_jump.mp3"}
tbl_upv_1.Landing = {SoundId = "rbxasset://sounds/action_jump_land.mp3"}
tbl_upv_1.Running = {SoundId = "rbxasset://sounds/action_footsteps_plastic.mp3", Looped = true, Pitch = 1.85}
tbl_upv_1.Splash = {SoundId = "rbxasset://sounds/impact_water.mp3"}
tbl_upv_1.Swimming = {SoundId = "rbxasset://sounds/action_swim.mp3", Looped = true, Pitch = 1.6}
local tbl_upv_2 = {}
tbl_upv_2.Climbing = {Looping = true, AssetId = "rbxasset://sounds/action_footsteps_plastic.mp3"}
tbl_upv_2.Died = {AssetId = "rbxasset://sounds/uuhhh.mp3"}
tbl_upv_2.FreeFalling = {Looping = true, AssetId = "rbxasset://sounds/action_falling.ogg"}
tbl_upv_2.GettingUp = {AssetId = "rbxasset://sounds/action_get_up.mp3"}
tbl_upv_2.Jumping = {AssetId = "rbxasset://sounds/action_jump.mp3"}
tbl_upv_2.Landing = {AssetId = "rbxasset://sounds/action_jump_land.mp3"}
tbl_upv_2.Running = {Looping = true, AssetId = "rbxasset://sounds/action_footsteps_plastic.mp3", PlaybackSpeed = 1.85}
tbl_upv_2.Splash = {AssetId = "rbxasset://sounds/impact_water.mp3"}
tbl_upv_2.Swimming = {Looping = true, AssetId = "rbxasset://sounds/action_swim.mp3", PlaybackSpeed = 1.6}
local function map(a1, a2, a3, a4, a5)
    --[[
      name: map
      line: 97
    ]]
    return (((a1 - a2) * (a5 - a4)) / (a3 - a2)) + a4
end
local function playSound(a1, a2)
    --[[
      name: playSound
      line: 118
      upvalues:
        u2 (copy, index: 1)
    ]]
    if not (a2) then
        a1.TimePosition = 0
    end
    if u2 and a1:IsA("AudioPlayer") then
        a1:Play()
    else
        a1.Playing = true
    end
end
local function stopSound(a1)
    --[[
      name: stopSound
      line: 129
      upvalues:
        u2 (copy, index: 1)
    ]]
    if u2 and a1:IsA("AudioPlayer") then
        a1:Stop()
    else
        a1.Playing = false
    end
end
local function playSoundIf(a1, a2)
    --[[
      name: playSoundIf
      line: 137
      upvalues:
        u2 (copy, index: 1)
    ]]
    if u2 and a1:IsA("AudioPlayer") then
        if a1.IsPlaying and not (a2) then
            a1:Stop()
            return
        end
        if not a1.IsPlaying and a2 then
            a1:Play()
        end
        return
    end
    a1.Playing = a2
end
local function setSoundLooped(a1, a2)
    --[[
      name: setSoundLooped
      line: 149
      upvalues:
        u2 (copy, index: 1)
    ]]
    if u2 and a1:IsA("AudioPlayer") then
        a1.Looping = a2
    else
        a1.Looped = a2
    end
end
local function shallowCopy(a1)
    --[[
      name: shallowCopy
      line: 157
    ]]
    local tbl_3 = {}
    for key_1, value_1 in pairs(a1) do
        tbl_3[key_1] = value_1
    end
    return tbl_3
end
local function getRelativeVelocity(a1, a2)
    --[[
      name: getRelativeVelocity
      line: 101
    ]]
    if not a1 then
        return a2
    end
    local v6 = a1.ActiveController and (((a1.ActiveController:IsA("GroundController")) and (a1.GroundSensor)) or (a1.ActiveController:IsA("ClimbController") and (a1.ClimbSensor)))
    if v6 and v6.SensedPart then
        return a2 - v6.SensedPart:GetVelocityAtPosition(a1.RootPart.Position)
    end
    return a2
end
local function initializeSoundSystem(a1)
    --[[
      name: initializeSoundSystem
      line: 165
      upvalues:
        u1 (copy, index: 1)
        u2 (copy, index: 2)
        SoundService_upv_1 (copy, index: 3)
        u3 (copy, index: 4)
        u5 (copy, index: 5)
        Players_upv_1 (copy, index: 6)
        tbl_upv_2 (copy, index: 7)
        tbl_upv_1 (copy, index: 8)
        getRelativeVelocity (copy, index: 9)
        RunService_upv_1 (copy, index: 10)
    ]]
    local humanoid_upv_1 = a1.humanoid
    local rootPart_upv_1 = a1.rootPart
    local u6 = nil
    local u7 = nil
    if u1 then
        local _ = humanoid_upv_1.Parent:FindFirstChild("ControllerManager")
    end
    local tbl_upv_4 = {}
    if u2 then
        if SoundService_upv_1.CharacterSoundsUseNewApi ~= Enum.RolloutState.Enabled then
            for key_2, value_2 in pairs(tbl_upv_1) do
                local v7 = Instance.new("Sound")
                v7.Name = key_2
                v7.Archivable = false
                v7.RollOffMinDistance = 5
                v7.RollOffMaxDistance = 150
                v7.Volume = 0.65
                for key_3, value_3 in pairs(value_2) do
                    v7[key_3] = value_3
                end
                v7.Parent = rootPart_upv_1
                tbl_upv_4[key_2] = v7
            end
        else
            local v8 = nil
            local v9 = nil
            if u3 then
                if u5 then
                    v9 = humanoid_upv_1.RootPart or humanoid_upv_1.Parent
                else
                    v9 = humanoid_upv_1.RootPart
                end
            else
                v8 = Players_upv_1.LocalPlayer.Character
            end
            local tbl_5 = {}
            local v11 = 5
            while v11 < 150 do
                tbl_5[v11] = 5 / v11
                v11 = v11 * 1.25
            end
            tbl_5[150] = 0
            if u3 then
                u6 = Instance.new("AudioEmitter", v9)
            else
                u6 = Instance.new("AudioEmitter", v8)
            end
            u6.Name = "RbxCharacterSoundsEmitter"
            u6:SetDistanceAttenuation(tbl_5)
            for key_4, value_4 in pairs(tbl_upv_2) do
                local v12 = Instance.new("AudioPlayer")
                v9 = Instance.new("Wire")
                v12.Name = key_4
                v9.Name = key_4 .. "Wire"
                v12.Archivable = false
                v12.Volume = 0.65
                for key_5, value_5 in pairs(value_4) do
                    v12[key_5] = value_5
                end
                v12.Parent = rootPart_upv_1
                v9.Parent = v12
                v9.SourceInstance = v12
                v9.TargetInstance = u6
                tbl_upv_4[key_4] = v12
            end
        end
    else
        for key_2, value_2 in pairs(tbl_upv_1) do
            local v7 = Instance.new("Sound")
            v7.Name = key_2
            v7.Archivable = false
            v7.RollOffMinDistance = 5
            v7.RollOffMaxDistance = 150
            v7.Volume = 0.65
            for key_3, value_3 in pairs(value_2) do
                v7[key_3] = value_3
            end
            v7.Parent = rootPart_upv_1
            tbl_upv_4[key_2] = v7
        end
    end
    local tbl_upv_6 = {}
    local tbl_upv_7 = {}
    local function stopPlayingLoopedSounds_upv_1(a2)
        --[[
          name: stopPlayingLoopedSounds
          line: 241
          upvalues:
            tbl_upv_6 (copy, index: 1)
            u2 (copy, index: 2)
        ]]
        local tbl_8 = {}
        for key_6, value_6 in pairs(tbl_upv_6) do
            tbl_8[key_6] = value_6
        end
        for key_7 in pairs(tbl_8) do
            if key_7 == (a2 or nil) then
                continue
            end
            if not (u2) then
                key_7.Playing = false
                tbl_upv_6[key_7] = nil
                continue
            end
            if key_7:IsA("AudioPlayer") then
                key_7:Stop()
            else
                key_7.Playing = false
            end
            tbl_upv_6[key_7] = nil
        end
    end
    tbl_upv_7[Enum.HumanoidStateType.FallingDown] = function()
        --[[
          line: 253
          upvalues:
            stopPlayingLoopedSounds_upv_1 (copy, index: 1)
        ]]
        stopPlayingLoopedSounds_upv_1()
    end
    tbl_upv_7[Enum.HumanoidStateType.GettingUp] = function()
        --[[
          line: 257
          upvalues:
            stopPlayingLoopedSounds_upv_1 (copy, index: 1)
            tbl_upv_4 (copy, index: 2)
            u2 (copy, index: 3)
        ]]
        stopPlayingLoopedSounds_upv_1()
        local GettingUp_1 = tbl_upv_4.GettingUp
        GettingUp_1.TimePosition = 0
        if u2 and GettingUp_1:IsA("AudioPlayer") then
            GettingUp_1:Play()
        else
            GettingUp_1.Playing = true
        end
    end
    tbl_upv_7[Enum.HumanoidStateType.Jumping] = function()
        --[[
          line: 262
          upvalues:
            stopPlayingLoopedSounds_upv_1 (copy, index: 1)
            tbl_upv_4 (copy, index: 2)
            u2 (copy, index: 3)
        ]]
        stopPlayingLoopedSounds_upv_1()
        local Jumping_1 = tbl_upv_4.Jumping
        Jumping_1.TimePosition = 0
        if u2 and Jumping_1:IsA("AudioPlayer") then
            Jumping_1:Play()
        else
            Jumping_1.Playing = true
        end
    end
    tbl_upv_7[Enum.HumanoidStateType.Swimming] = function()
        --[[
          line: 267
          upvalues:
            rootPart_upv_1 (copy, index: 1)
            tbl_upv_4 (copy, index: 2)
            u2 (copy, index: 3)
            stopPlayingLoopedSounds_upv_1 (copy, index: 4)
            tbl_upv_6 (copy, index: 5)
        ]]
        local v13 = math.abs(rootPart_upv_1.AssemblyLinearVelocity.Y)
        if v13 > 0.1 then
            tbl_upv_4.Splash.Volume = math.clamp((((v13 - 100) * 0.72) / 250) + 0.28, 0, 1)
            local Splash_1 = tbl_upv_4.Splash
            Splash_1.TimePosition = 0
            if (u2) and (Splash_1:IsA("AudioPlayer")) then
                Splash_1:Play()
            else
                Splash_1.Playing = true
            end
        end
        stopPlayingLoopedSounds_upv_1(tbl_upv_4.Swimming)
        local Swimming_1 = tbl_upv_4.Swimming
        if (u2) and (Swimming_1:IsA("AudioPlayer")) then
            Swimming_1:Play()
        else
            Swimming_1.Playing = true
        end
        tbl_upv_6[tbl_upv_4.Swimming] = true
    end
    tbl_upv_7[Enum.HumanoidStateType.Freefall] = function()
        --[[
          line: 278
          upvalues:
            tbl_upv_4 (copy, index: 1)
            stopPlayingLoopedSounds_upv_1 (copy, index: 2)
            u2 (copy, index: 3)
            tbl_upv_6 (copy, index: 4)
        ]]
        tbl_upv_4.FreeFalling.Volume = 0
        stopPlayingLoopedSounds_upv_1(tbl_upv_4.FreeFalling)
        local FreeFalling_1 = tbl_upv_4.FreeFalling
        if (u2) and (FreeFalling_1:IsA("AudioPlayer")) then
            FreeFalling_1.Looping = true
        else
            FreeFalling_1.Looped = true
        end
        if tbl_upv_4.FreeFalling:IsA("Sound") then
            tbl_upv_4.FreeFalling.PlaybackRegionsEnabled = true
        end
        tbl_upv_4.FreeFalling.LoopRegion = NumberRange.new(2, 9)
        local FreeFalling_2 = tbl_upv_4.FreeFalling
        FreeFalling_2.TimePosition = 0
        if (u2) and (FreeFalling_2:IsA("AudioPlayer")) then
            FreeFalling_2:Play()
        else
            FreeFalling_2.Playing = true
        end
        tbl_upv_6[tbl_upv_4.FreeFalling] = true
    end
    tbl_upv_7[Enum.HumanoidStateType.Landed] = function()
        --[[
          line: 292
          upvalues:
            stopPlayingLoopedSounds_upv_1 (copy, index: 1)
            rootPart_upv_1 (copy, index: 2)
            tbl_upv_4 (copy, index: 3)
            u2 (copy, index: 4)
        ]]
        stopPlayingLoopedSounds_upv_1()
        local v14 = math.abs(rootPart_upv_1.AssemblyLinearVelocity.Y)
        if v14 > 75 then
            tbl_upv_4.Landing.Volume = math.clamp((((v14 - 50) * 1) / 50) + 0, 0, 1)
            local Landing_1 = tbl_upv_4.Landing
            Landing_1.TimePosition = 0
            if not u2 or not Landing_1:IsA("AudioPlayer") then
                Landing_1.Playing = true
            end
            Landing_1:Play()
        end
    end
    tbl_upv_7[Enum.HumanoidStateType.Running] = function()
        --[[
          line: 301
          upvalues:
            stopPlayingLoopedSounds_upv_1 (copy, index: 1)
            tbl_upv_4 (copy, index: 2)
            u2 (copy, index: 3)
            tbl_upv_6 (copy, index: 4)
        ]]
        stopPlayingLoopedSounds_upv_1(tbl_upv_4.Running)
        local Running_1 = tbl_upv_4.Running
        if (u2) and (Running_1:IsA("AudioPlayer")) then
            Running_1:Play()
        else
            Running_1.Playing = true
        end
        tbl_upv_6[tbl_upv_4.Running] = true
    end
    tbl_upv_7[Enum.HumanoidStateType.Climbing] = function()
        --[[
          line: 307
          upvalues:
            tbl_upv_4 (copy, index: 1)
            rootPart_upv_1 (copy, index: 2)
            u1 (copy, index: 3)
            getRelativeVelocity (copy, index: 4)
            u7 (ref,  index: 5)
            u2 (copy, index: 6)
            stopPlayingLoopedSounds_upv_1 (copy, index: 7)
            tbl_upv_6 (copy, index: 8)
        ]]
        local Climbing_1 = tbl_upv_4.Climbing
        local AssemblyLinearVelocity_1 = rootPart_upv_1.AssemblyLinearVelocity
        local v15
        if u1 then
            v15 = getRelativeVelocity(u7, AssemblyLinearVelocity_1)
        else
            v15 = AssemblyLinearVelocity_1
        end
        if math.abs(v15.Y) > 0.1 then
            if (u2) and (Climbing_1:IsA("AudioPlayer")) then
                Climbing_1:Play()
            else
                Climbing_1.Playing = true
            end
            stopPlayingLoopedSounds_upv_1(Climbing_1)
        else
            stopPlayingLoopedSounds_upv_1()
        end
        tbl_upv_6[Climbing_1] = true
    end
    tbl_upv_7[Enum.HumanoidStateType.Seated] = function()
        --[[
          line: 320
          upvalues:
            stopPlayingLoopedSounds_upv_1 (copy, index: 1)
        ]]
        stopPlayingLoopedSounds_upv_1()
    end
    tbl_upv_7[Enum.HumanoidStateType.Dead] = function()
        --[[
          line: 324
          upvalues:
            stopPlayingLoopedSounds_upv_1 (copy, index: 1)
            tbl_upv_4 (copy, index: 2)
            u2 (copy, index: 3)
        ]]
        stopPlayingLoopedSounds_upv_1()
        local Died_1 = tbl_upv_4.Died
        Died_1.TimePosition = 0
        if u2 and Died_1:IsA("AudioPlayer") then
            Died_1:Play()
        else
            Died_1.Playing = true
        end
    end
    local tbl_upv_9 = {}
    tbl_upv_9[tbl_upv_4.Climbing] = function(a3, a4, a5)
        --[[
          line: 332
          upvalues:
            u1 (copy, index: 1)
            getRelativeVelocity (copy, index: 2)
            u7 (ref,  index: 3)
            u2 (copy, index: 4)
        ]]
        local v16
        if u1 then
            v16 = getRelativeVelocity(u7, a5)
        else
            v16 = a5
        end
        local v17
        if v16.Magnitude > 0.1 then
            v17 = true
        else
            v17 = false
        end
        if u2 and a4:IsA("AudioPlayer") then
            if a4.IsPlaying and not (v17) then
                a4:Stop()
                return
            end
            if not a4.IsPlaying and v17 then
                a4:Play()
            end
            return
        end
        a4.Playing = v17
    end
    tbl_upv_9[tbl_upv_4.FreeFalling] = function(a6, a7, a8)
        --[[
          line: 337
        ]]
        if a8.Magnitude > 75 then
            a7.Volume = math.clamp(a7.Volume + (a6 * 0.9), 0, 1)
        else
            a7.Volume = 0
        end
    end
    tbl_upv_9[tbl_upv_4.Running] = function(a9, a10, a11)
        --[[
          line: 345
          upvalues:
            humanoid_upv_1 (copy, index: 1)
            u2 (copy, index: 2)
        ]]
        local v18 = (a11.Magnitude > 0.5) and (humanoid_upv_1.MoveDirection.Magnitude > 0.5)
        if u2 and a10:IsA("AudioPlayer") then
            if a10.IsPlaying and not (v18) then
                a10:Stop()
                return
            end
            if not a10.IsPlaying and v18 then
                a10:Play()
            end
            return
        end
        a10.Playing = v18
    end
    local tbl_upv_10 = {}
    tbl_upv_10[Enum.HumanoidStateType.RunningNoPhysics] = Enum.HumanoidStateType.Running
    local v19 = tbl_upv_10[humanoid_upv_1:GetState()]
    local u8 = v19 or (humanoid_upv_1:GetState())
    local function transitionTo_1(a12)
        --[[
          name: transitionTo
          line: 357
          upvalues:
            tbl_upv_7 (copy, index: 1)
            u8 (ref,  index: 2)
        ]]
        local v20 = tbl_upv_7[a12]
        if v20 then
            v20()
        end
        u8 = a12
    end
    local v21 = u8
    local v22 = tbl_upv_7[v21]
    if v22 then
        v22()
    end
    u8 = v21
    local u9 = humanoid_upv_1.StateChanged:Connect(
        function(a13, a14)
            --[[
              line: 369
              upvalues:
                tbl_upv_10 (copy, index: 1)
                u8 (ref,  index: 2)
                tbl_upv_7 (copy, index: 3)
            ]]
            a14 = tbl_upv_10[a14] or a14
            if a14 ~= u8 then
                local v23 = tbl_upv_7[a14]
                if v23 then
                    v23()
                end
                u8 = a14
            end
        end
    )
    local u10 = RunService_upv_1.Stepped:Connect(
        function(a15, a16)
            --[[
              line: 377
              upvalues:
                tbl_upv_6 (copy, index: 1)
                tbl_upv_9 (copy, index: 2)
                rootPart_upv_1 (copy, index: 3)
            ]]
            for key_8 in pairs(tbl_upv_6) do
                local v24 = tbl_upv_9[key_8]
                if v24 then
                    v24(a16, key_8, rootPart_upv_1.AssemblyLinearVelocity)
                end
            end
        end
    )
    local function terminate_1()
        --[[
          name: terminate
          line: 388
          upvalues:
            u9 (copy, index: 1)
            u10 (copy, index: 2)
            u5 (copy, index: 3)
            u6 (ref,  index: 4)
            tbl_upv_4 (copy, index: 5)
        ]]
        u9:Disconnect()
        u10:Disconnect()
        if u5 and u6 then
            u6:Destroy()
        end
        for _, value_7 in pairs(tbl_upv_4) do
            value_7:Destroy()
        end
        table.clear(tbl_upv_4)
    end
    return terminate_1
end
local u11 = characterAdded.new({rootPart = "HumanoidRootPart", humanoid = "Humanoid"}, initializeSoundSystem)
local tbl_upv_11 = {}
local function characterRemoving(a1)
    --[[
      name: characterRemoving
      line: 419
      upvalues:
        u11 (copy, index: 1)
    ]]
    u11:unbindRoot(a1)
end
characterAdded = function(a1)
    --[[
      name: characterAdded
      line: 415
      upvalues:
        u11 (copy, index: 1)
    ]]
    u11:bindRoot(a1)
end
local function playerRemoving(a1)
    --[[
      name: playerRemoving
      line: 437
      upvalues:
        tbl_upv_11 (copy, index: 1)
        u11 (copy, index: 2)
    ]]
    local v25 = tbl_upv_11[a1]
    if v25 then
        for _, value_8 in ipairs(v25) do
            value_8:Disconnect()
        end
        tbl_upv_11[a1] = nil
    end
    if not a1.Character then
        return
    end
    u11:unbindRoot(a1.Character)
end
local function playerAdded(a1)
    --[[
      name: playerAdded
      line: 423
      upvalues:
        tbl_upv_11 (copy, index: 1)
        u11 (copy, index: 2)
        characterAdded (copy, index: 3)
        characterRemoving (copy, index: 4)
    ]]
    local v26 = tbl_upv_11[a1]
    if not (v26) then
        local tbl_12 = {}
        tbl_upv_11[a1] = tbl_12
        v26 = tbl_12
    end
    if a1.Character then
        u11:bindRoot(a1.Character)
    end
    table.insert(v26, a1.CharacterAdded:Connect(characterAdded))
    table.insert(v26, a1.CharacterRemoving:Connect(characterRemoving))
end
for v8, value_9 in ipairs(Players_upv_1:GetPlayers()) do
    task.spawn(playerAdded, value_9)
end
Players_upv_1.PlayerAdded:Connect(playerAdded)
Players_upv_1.PlayerRemoving:Connect(playerRemoving)