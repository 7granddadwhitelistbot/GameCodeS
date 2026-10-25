local Players_1 = game:GetService("Players")
local ReplicatedStorage_1 = game:GetService("ReplicatedStorage")
local RunService_upv_1 = game:GetService("RunService")
local UserInputService_upv_1 = game:GetService("UserInputService")
local Shared_1 = ReplicatedStorage_1:WaitForChild("Shared")
local Camera_upv_1 = require(Shared_1:WaitForChild("Camera"))
local Simulation_upv_1 = require(Shared_1:WaitForChild("Simulation"))
local Effects_upv_1 = require(script.Parent:WaitForChild("Effects"))
local Footsteps_upv_1 = require(script.Parent:WaitForChild("Footsteps"))
local Perf_upv_1 = require(script.Parent:WaitForChild("Perf"))
local AnimationIds_upv_1 = require(script.Parent:WaitForChild("AnimationIds"))
local tbl_upv_1 = {}
local BASE_SPEED_upv_1 = Simulation_upv_1.BASE_SPEED
local LocalPlayer_upv_1 = Players_1.LocalPlayer
local u1 = nil
local tbl_upv_2 = {fov = 0}
local u2 = false
local tbl_upv_3 = {pivot = Vector3.new(0, -1.2000000476837158, 0), fov = 8}
local function setSpeedKick(a1)
    --[[
      name: setSpeedKick
      line: 70
      upvalues:
        tbl_upv_2 (copy, index: 1)
        u2 (ref,  index: 2)
        Camera_upv_1 (copy, index: 3)
    ]]
    if a1 > 0.05 then
        tbl_upv_2.fov = a1
        if (u2) then
            return
        end
        u2 = true
        Camera_upv_1.SetModifier("Speed", tbl_upv_2)
    elseif u2 then
        u2 = false
        Camera_upv_1.SetModifier("Speed", nil)
    end
end
local function drawnRoot(a1)
    --[[
      name: drawnRoot
      line: 84
      upvalues:
        Camera_upv_1 (copy, index: 1)
    ]]
    local success_1, v1 = pcall(Camera_upv_1.Drawn, a1.root)
    if success_1 and typeof(v1) == "Instance" and v1:IsA("BasePart") then
        return v1
    end
    return a1.root
end
function tbl_upv_1.IsSliding()
    --[[
      name: IsSliding
      line: 92
      upvalues:
        u1 (ref, index: 1)
    ]]
    local v2 = (u1 ~= nil) and (u1.sliding)
    return v2
end
function tbl_upv_1.BaseSpeed()
    --[[
      name: BaseSpeed
      line: 96
      upvalues:
        BASE_SPEED_upv_1 (copy, index: 1)
    ]]
    return BASE_SPEED_upv_1
end
local function playing(a1)
    --[[
      name: playing
      line: 103
    ]]
    return (a1 ~= nil) and (a1.IsPlaying)
end
local function renderSlideEnd(a1)
    --[[
      name: renderSlideEnd
      line: 135
      upvalues:
        Camera_upv_1 (copy, index: 1)
    ]]
    a1.sliding = false
    if a1.character.Parent then
        a1.character:SetAttribute("Sliding", false)
    end
    if a1.legsTrack then
        a1.legsTrack:Stop(0.15)
    end
    if a1.upperTrack then
        a1.upperTrack:Stop(0.15)
    end
    if a1.slideTrail then
        a1.slideTrail.Enabled = false
    end
    local slideSound_upv_1 = a1.slideSound
    if slideSound_upv_1 then
        a1.slideSound = nil
        task.spawn(
            function()
                --[[
                  line: 152
                  upvalues:
                    slideSound_upv_1 (copy, index: 1)
                ]]
                for _ = 1, 8 do
                    if slideSound_upv_1.Parent then
                        slideSound_upv_1.Volume = slideSound_upv_1.Volume * 0.7
                        task.wait(0.02)
                        continue
                    else
                        break
                    end
                end
                slideSound_upv_1:Destroy()
            end
        )
    end
    Camera_upv_1.SetModifier("Slide", nil)
    Camera_upv_1.ResumeCharacterRotation("Slide")
end
local u3 = RaycastParams.new()
u3.FilterType = Enum.RaycastFilterType.Include
u3.FilterDescendantsInstances = {workspace.Terrain}
u3.IgnoreWater = false
local function feetOf(a1)
    --[[
      name: feetOf
      line: 170
      upvalues:
        Camera_upv_1 (copy, index: 1)
    ]]
    local v3 = a1.humanoid.HipHeight
    local v4 = a1.root:GetAttribute("SHipBase")
    if type(v4) == "number" and v4 < v3 then
        v3 = v4
    end
    local success_2, v5 = pcall(Camera_upv_1.Drawn, a1.root)
    local v6
    if success_2 and typeof(v5) == "Instance" and v5:IsA("BasePart") then
        v6 = v5
    else
        v6 = a1.root
    end
    return v6.Position - Vector3.new(0, (v3 + (a1.root.Size.Y / 2)) - 0.2, 0)
end
local function waterSplashAt(a1)
    --[[
      name: waterSplashAt
      line: 189
      upvalues:
        u3 (copy, index: 1)
    ]]
    local v7 = a1.root:GetAttribute("SWade")
    if type(v7) == "number" and not (v7 < 0.3) then
        local v8 = workspace:Raycast(a1.root.Position + Vector3.new(0, 4, 0), Vector3.new(0, -12, 0), u3)
        if v8 and v8.Material == Enum.Material.Water then
            return v8.Position
        end
        return nil
    end
    return nil
end
local function onLanded(a1)
    --[[
      name: onLanded
      line: 221
      upvalues:
        waterSplashAt (copy, index: 1)
        Effects_upv_1 (copy, index: 2)
        Camera_upv_1 (copy, index: 3)
        feetOf (copy, index: 4)
        Footsteps_upv_1 (copy, index: 5)
    ]]
    local v9 = -a1.minVy
    a1.minVy = 0
    local v10 = os.clock()
    if (v9 < 18) or (v10 - a1.airStart < 0.12) then
        return
    end
    if not (v10 - a1.lastLandFx < 0.4) then
        a1.lastLandFx = v10
        local FloorMaterial_1 = a1.humanoid.FloorMaterial
        local v11 = math.clamp((v9 - 70) / 60, 0, 1)
        local v12 = waterSplashAt(a1)
        if v12 then
            Effects_upv_1.Dust(v12, (v11 * 1.2) + 0.6, Effects_upv_1.DustColor(Enum.Material.Water))
        else
            Camera_upv_1.Dip((v11 * 1.2) + 0.12)
            if v11 > 0.6 then
                Camera_upv_1.Shake((v11 * 0.3) + 0.15, 0.3)
            end
            Effects_upv_1.Dust(feetOf(a1), (v11 * 1.8) + 0.45, Effects_upv_1.DustColor(FloorMaterial_1))
            local success_3, v13 = pcall(Camera_upv_1.Drawn, a1.root)
            if success_3 and typeof(v13) == "Instance" and v13:IsA("BasePart") then
                v9 = v13
            else
                v9 = a1.root
            end
            if v11 <= 0 then
                local tbl_4 = {pitchVar = 0.08, volume = 0.8}
                Effects_upv_1.PlaySound(Footsteps_upv_1.StepSoundName(Footsteps_upv_1.SurfaceFor(FloorMaterial_1)), v9, tbl_4)
            elseif v11 < 0.5 then
                Effects_upv_1.PlaySound("Land", v9, {pitchVar = 0.06, volume = (v11 * 0.9) + 0.35})
            else
                Effects_upv_1.PlaySound("LandHeavy", v9, {pitchVar = 0.05, volume = (v11 * 0.5) + 0.5})
            end
        end
    end
end
local function renderSlideStart(a1)
    --[[
      name: renderSlideStart
      line: 107
      upvalues:
        Camera_upv_1 (copy, index: 1)
        tbl_upv_3 (copy, index: 2)
        Effects_upv_1 (copy, index: 3)
    ]]
    a1.sliding = true
    a1.slideAirborne = false
    a1.character:SetAttribute("Sliding", true)
    Camera_upv_1.SuspendCharacterRotation("Slide")
    Camera_upv_1.SetModifier("Slide", tbl_upv_3)
    Camera_upv_1.Shake(0.1, 0.2)
    if a1.legsTrack then
        local legsTrack_1 = a1.legsTrack
        if legsTrack_1 == nil or not legsTrack_1.IsPlaying then
            a1.legsTrack:Play(0.08, 1, 1)
        end
    end
    if a1.upperTrack then
        local upperTrack_1 = a1.upperTrack
        if upperTrack_1 == nil or not upperTrack_1.IsPlaying then
            a1.upperTrack:Play(0.12, 1, 1)
        end
    end
    if not (a1.slideSound) then
        local PlaySound_1 = Effects_upv_1.PlaySound
        local success_4, v14 = pcall(Camera_upv_1.Drawn, a1.root)
        local v15
        if success_4 and typeof(v14) == "Instance" and v14:IsA("BasePart") then
            v15 = v14
        else
            v15 = a1.root
        end
        a1.slideSound = PlaySound_1("Slide", v15, {looped = true, volume = 1.2, pitchVar = 0.08})
    end
    local v16 = Effects_upv_1.DustColor(a1.humanoid.FloorMaterial)
    local Dust_1 = Effects_upv_1.Dust
    local success_5, v17 = pcall(Camera_upv_1.Drawn, a1.root)
    local v18
    if success_5 and typeof(v17) == "Instance" and v17:IsA("BasePart") then
        v18 = v17
    else
        v18 = a1.root
    end
    Dust_1(v18.Position - Vector3.new(0, 2.5999999046325684, 0), 1.1, v16)
    if a1.trailAttachment then
        if not (a1.slideTrail) or not (a1.slideTrail.Parent) then
            a1.slideTrail = Effects_upv_1.Trail(a1.trailAttachment, v16)
        end
        local slideTrail_1 = a1.slideTrail
        slideTrail_1.Color = ColorSequence.new(v16)
        slideTrail_1.Enabled = true
    end
end
local function render()
    --[[
      name: render
      line: 257
      upvalues:
        u1 (ref,  index: 1)
        Camera_upv_1 (copy, index: 2)
        renderSlideStart (copy, index: 3)
        renderSlideEnd (copy, index: 4)
        Effects_upv_1 (copy, index: 5)
        feetOf (copy, index: 6)
        u2 (ref,  index: 7)
        BASE_SPEED_upv_1 (copy, index: 8)
        tbl_upv_2 (copy, index: 9)
    ]]
    if not u1 then
        return
    end
    local humanoid_1 = u1.humanoid
    local root_1 = u1.root
    local v19 = (humanoid_1.Parent ~= nil) and (humanoid_1.Health > 0)
    local trailAttachment_upv_1 = u1.trailAttachment
    if trailAttachment_upv_1 then
        local success_6, v20 = pcall(Camera_upv_1.Drawn, u1.root)
        if success_6 and typeof(v20) == "Instance" and v20:IsA("BasePart") then
            root_upv_2 = v20
        else
            root_upv_2 = u1.root
        end
        if trailAttachment_upv_1.Parent ~= root_upv_2
            and not (pcall(
                function()
                    --[[
                      line: 269
                      upvalues:
                        trailAttachment_upv_1 (copy, index: 1)
                        root_upv_2 (copy, index: 2)
                    ]]
                    trailAttachment_upv_1.Parent = root_upv_2
                end
            )) then
            local v21 = Instance.new("Attachment")
            v21.Name = "TribesSlideTrail"
            v21.Position = Vector3.new(0, -2.299999952316284, 1)
            v21.Parent = root_upv_2
            u1.trailAttachment = v21
            u1.slideTrail = nil
        end
    end
    local root_upv_2 = v19 and (root_1:GetAttribute("SSlide") ~= nil)
    if root_upv_2 == u1.sliding then
        local v22 = nil
        if root_upv_2 then
            if u1.legsTrack then
                local legsTrack_2 = u1.legsTrack
                if legsTrack_2 == nil or not legsTrack_2.IsPlaying then
                    u1.legsTrack:Play(0.05, 1, 1)
                end
            end
            if u1.upperTrack then
                local upperTrack_2 = u1.upperTrack
                if upperTrack_2 == nil or not upperTrack_2.IsPlaying then
                    u1.upperTrack:Play(0.05, 1, 1)
                end
            end
            v22 = humanoid_1.FloorMaterial == Enum.Material.Air
            if v22 ~= u1.slideAirborne then
                u1.slideAirborne = v22
                local v23 = os.clock()
                if v22 then
                    u1.slideAirAt = v23
                elseif v23 - u1.slideAirAt > 0.08 then
                    Effects_upv_1.Dust(feetOf(u1), 0.5, Effects_upv_1.DustColor(humanoid_1.FloorMaterial))
                end
                if u1.slideTrail then
                    u1.slideTrail.Enabled = not v22
                end
            end
        end
    elseif root_upv_2 then
        renderSlideStart(u1)
    else
        renderSlideEnd(u1)
    end
    if v19 then
        local AssemblyLinearVelocity_1 = root_1.AssemblyLinearVelocity
        if humanoid_1.FloorMaterial == Enum.Material.Air then
            u1.minVy = math.min(u1.minVy, AssemblyLinearVelocity_1.Y)
        end
        if not (root_upv_2) then
            local v24 = nil
            if not (Camera_upv_1.IsAiming()) then
                v24 = math.clamp(((Vector3.new(AssemblyLinearVelocity_1.X, 0, AssemblyLinearVelocity_1.Z).Magnitude - BASE_SPEED_upv_1) - 1) * 0.45, 0, 7)
                if v24 > 0.05 then
                    tbl_upv_2.fov = v24
                    if not u2 then
                        u2 = true
                        Camera_upv_1.SetModifier("Speed", tbl_upv_2)
                    end
                elseif u2 then
                    u2 = false
                    Camera_upv_1.SetModifier("Speed", nil)
                end
                return
            end
        end
        if u2 then
            u2 = false
            Camera_upv_1.SetModifier("Speed", nil)
        end
    elseif u2 then
        u2 = false
        Camera_upv_1.SetModifier("Speed", nil)
    end
end
local function unbind()
    --[[
      name: unbind
      line: 348
      upvalues:
        u1 (ref,  index: 1)
        renderSlideEnd (copy, index: 2)
        u2 (ref,  index: 3)
        Camera_upv_1 (copy, index: 4)
    ]]
    if not u1 then
        return
    end
    if u1.sliding then
        renderSlideEnd(u1)
    end
    if u2 then
        u2 = false
        Camera_upv_1.SetModifier("Speed", nil)
    end
    for _, value_1 in u1.connections do
        value_1:Disconnect()
    end
    if u1.trailAttachment then
        u1.trailAttachment:Destroy()
    end
    u1 = nil
end
local function loadTrack(a1, a2, a3, a4)
    --[[
      name: loadTrack
      line: 330
    ]]
    if a2 ~= "" and a2 ~= "rbxassetid://0" then
        local u4 = Instance.new("Animation")
        u4.Name = a4
        u4.AnimationId = a2
        local success_7, v25 = pcall(
            function()
                --[[
                  line: 337
                  upvalues:
                    a1 (copy, index: 1)
                    u4 (copy, index: 2)
                ]]
                return a1:LoadAnimation(u4)
            end
        )
        if success_7 and v25 then
            v25.Priority = a3
            v25.Looped = true
            return v25
        end
        return nil
    end
    return nil
end
local function onJumped(a1)
    --[[
      name: onJumped
      line: 202
      upvalues:
        Effects_upv_1 (copy, index: 1)
        Camera_upv_1 (copy, index: 2)
        waterSplashAt (copy, index: 3)
        feetOf (copy, index: 4)
    ]]
    local v26 = os.clock()
    if v26 - a1.lastJumpFx < 0.4 then
        return
    end
    a1.airStart = v26
    a1.minVy = 0
    a1.lastJumpFx = v26
    local PlaySound_2 = Effects_upv_1.PlaySound
    local success_8, v27 = pcall(Camera_upv_1.Drawn, a1.root)
    local v28
    if success_8 and typeof(v27) == "Instance" and v27:IsA("BasePart") then
        v28 = v27
    else
        v28 = a1.root
    end
    PlaySound_2("Jump", v28, {volume = 0.8, pitchVar = 0.08})
    local v29 = waterSplashAt(a1)
    if v29 then
        Effects_upv_1.Dust(v29, 0.55, Effects_upv_1.DustColor(Enum.Material.Water))
    else
        Effects_upv_1.Dust(feetOf(a1), 0.4, Effects_upv_1.DustColor(a1.humanoid.FloorMaterial))
    end
end
local function bindCharacter(a1)
    --[[
      name: bindCharacter
      line: 366
      upvalues:
        unbind (copy, index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
        loadTrack (copy, index: 3)
        AnimationIds_upv_1 (copy, index: 4)
        u1 (ref,  index: 5)
        RunService_upv_1 (copy, index: 6)
        onJumped (copy, index: 7)
        onLanded (copy, index: 8)
        renderSlideEnd (copy, index: 9)
        u2 (ref,  index: 10)
        Camera_upv_1 (copy, index: 11)
    ]]
    unbind()
    local v30 = a1:WaitForChild("Humanoid", 10)
    local v31 = a1:WaitForChild("HumanoidRootPart", 10)
    if not v30 or not v31 then
        return
    end
    if LocalPlayer_upv_1.Character == a1 then
        local v32 = Instance.new("Attachment")
        v32.Name = "TribesSlideTrail"
        v32.Position = Vector3.new(0, -2.299999952316284, 1)
        local v33 = v30:FindFirstChildOfClass("Animator") or (v30:WaitForChild("Animator", 5))
        local v34 = nil
        local v35 = nil
        if v33 then
            local v36 = v33:IsA("Animator")
            if v36 then
                v34 = loadTrack(v33, AnimationIds_upv_1.SlideLegs, Enum.AnimationPriority.Action2, "SlideLegs")
                v35 = loadTrack(v33, AnimationIds_upv_1.SlideUpper, Enum.AnimationPriority.Movement, "SlideUpper")
                v34 = v34 or (loadTrack(v33, AnimationIds_upv_1.SlideFallback, Enum.AnimationPriority.Movement, "SlideFallback"))
            end
        end
        local tbl_upv_5 = {sliding = false, lastJumpFx = 0, lastLandFx = 0, minVy = 0, slideAirborne = false, slideAirAt = 0}
        tbl_upv_5.character = a1
        tbl_upv_5.humanoid = v30
        tbl_upv_5.root = v31
        tbl_upv_5.legsTrack = v34
        tbl_upv_5.upperTrack = v35
        tbl_upv_5.trailAttachment = v32
        tbl_upv_5.airStart = os.clock()
        tbl_upv_5.connections = {}
        u1 = tbl_upv_5
        a1:SetAttribute("Sliding", false)
        table.insert(
            tbl_upv_5.connections,
            v30.StateChanged:Connect(
                function(a2, a3)
                    --[[
                      line: 412
                      upvalues:
                        RunService_upv_1 (copy, index: 1)
                        onJumped (copy, index: 2)
                        tbl_upv_5 (copy, index: 3)
                        onLanded (copy, index: 4)
                    ]]
                    if RunService_upv_1:IsResimulating() then
                        return
                    end
                    if a3 == Enum.HumanoidStateType.Jumping then
                        onJumped(tbl_upv_5)
                    elseif a3 ~= Enum.HumanoidStateType.Freefall then
                        if a3 == Enum.HumanoidStateType.Landed then
                            onLanded(tbl_upv_5)
                        end
                    elseif a2 ~= Enum.HumanoidStateType.Jumping and os.clock() - tbl_upv_5.lastJumpFx >= 0.4 then
                        tbl_upv_5.airStart = os.clock()
                        tbl_upv_5.minVy = 0
                        return
                    end
                end
            )
        )
        table.insert(
            tbl_upv_5.connections,
            v30.Died:Connect(
                function()
                    --[[
                      line: 427
                      upvalues:
                        tbl_upv_5 (copy, index: 1)
                        renderSlideEnd (copy, index: 2)
                        u2 (ref,  index: 3)
                        Camera_upv_1 (copy, index: 4)
                    ]]
                    if tbl_upv_5.sliding then
                        renderSlideEnd(tbl_upv_5)
                    end
                    if not u2 then
                        return
                    end
                    u2 = false
                    Camera_upv_1.SetModifier("Speed", nil)
                end
            )
        )
    end
end
function tbl_upv_1.SetSlideHeld(a1)
    --[[
      name: SetSlideHeld
      line: 439
      upvalues:
        Simulation_upv_1 (copy, index: 1)
    ]]
    Simulation_upv_1.SetInput("Slide", a1 == true)
end
function tbl_upv_1.RequestSlide()
    --[[
      name: RequestSlide
      line: 444
      upvalues:
        Simulation_upv_1 (copy, index: 1)
    ]]
    Simulation_upv_1.Pulse("Slide", 0.1)
end
function tbl_upv_1.SetJumpHeld(a1)
    --[[
      name: SetJumpHeld
      line: 449
      upvalues:
        Simulation_upv_1 (copy, index: 1)
    ]]
    Simulation_upv_1.SetInput("Jump", a1 == true)
end
local u5 = false
function tbl_upv_1.Start()
    --[[
      name: Start
      line: 454
      upvalues:
        u5 (ref,  index: 1)
        UserInputService_upv_1 (copy, index: 2)
        Simulation_upv_1 (copy, index: 3)
        LocalPlayer_upv_1 (copy, index: 4)
        bindCharacter (copy, index: 5)
        u1 (ref,  index: 6)
        unbind (copy, index: 7)
        RunService_upv_1 (copy, index: 8)
        tbl_upv_1 (copy, index: 9)
        Perf_upv_1 (copy, index: 10)
        render (copy, index: 11)
    ]]
    if u5 then
        return
    end
    u5 = true
    UserInputService_upv_1.WindowFocusReleased:Connect(
        function()
            --[[
              line: 459
              upvalues:
                Simulation_upv_1 (copy, index: 1)
            ]]
            Simulation_upv_1.SetInput("Slide", false)
            Simulation_upv_1.SetInput("Jump", false)
        end
    )
    if LocalPlayer_upv_1.Character then
        task.spawn(bindCharacter, LocalPlayer_upv_1.Character)
    end
    LocalPlayer_upv_1.CharacterAdded:Connect(bindCharacter)
    LocalPlayer_upv_1.CharacterRemoving:Connect(
        function(a1)
            --[[
              line: 467
              upvalues:
                u1 (ref,  index: 1)
                unbind (copy, index: 2)
            ]]
            if not u1 or u1.character ~= a1 then
                return
            end
            unbind()
        end
    )
    local v37 = RunService_upv_1:IsStudio()
    if v37 then
        local v38 = Instance.new("BindableFunction")
        v38.Name = "CharacterDebug"
        v38.OnInvoke = function(a2, a3)
            --[[
              line: 478
              upvalues:
                Simulation_upv_1 (copy, index: 1)
                tbl_upv_1 (copy, index: 2)
                u1 (ref,  index: 3)
            ]]
            if a2 ~= "jump" then
                if a2 ~= "slide" then
                    if a2 == "simperf" then
                        return Simulation_upv_1.DebugStats()
                    end
                    if a2 ~= "state" or not u1 then
                        return nil
                    end
                    local tbl_6 = {}
                    tbl_6.walkSpeed = u1.humanoid.WalkSpeed
                    tbl_6.jumpHeight = u1.humanoid.JumpHeight
                    tbl_6.hipHeight = u1.humanoid.HipHeight
                    tbl_6.rendered = u1.sliding
                    for key_1, value_2 in u1.root:GetAttributes() do
                        if string.sub(key_1, 1, 1) == "S" then
                            tbl_6[key_1] = value_2
                        end
                    end
                    return tbl_6
                end
                tbl_upv_1.RequestSlide()
            else
                Simulation_upv_1.Pulse("Jump", 0.05)
            end
            return true
        end
        v38.Parent = LocalPlayer_upv_1
    end
    RunService_upv_1.RenderStepped:Connect(
        function()
            --[[
              line: 504
              upvalues:
                Perf_upv_1 (copy, index: 1)
                render (copy, index: 2)
            ]]
            local v39 = Perf_upv_1.Begin()
            render()
            Perf_upv_1.End("Movement", v39)
        end
    )
end
return tbl_upv_1