local CollectionService_1 = game:GetService("CollectionService")
local Players_1 = game:GetService("Players")
local TweenService_upv_1 = game:GetService("TweenService")
local Workspace_upv_1 = game:GetService("Workspace")
local tbl_upv_1 = {18, 34}
local u1 = TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local LocalPlayer_upv_1 = Players_1.LocalPlayer
local u2 = Random.new()
local tbl_upv_2 = {}
local function anim(a1)
    --[[
      name: anim
      line: 45
    ]]
    local v1 = Instance.new("Animation")
    v1.AnimationId = a1
    return v1
end
local function load(a1, a2, a3, a4)
    --[[
      name: load
      line: 51
    ]]
    local success_1, v2 = pcall(function() end)
    if success_1 and v2 then
        v2.Priority = a3
        v2.Looped = a4
        return v2
    end
    return nil
end
local function setup(a1)
    --[[
      name: setup
      line: 81
      upvalues:
        tbl_upv_2 (copy, index: 1)
        u2 (copy, index: 2)
    ]]
    if not a1:IsA("Model") or (tbl_upv_2[a1]) then
        return
    end
    local tbl_upv_3 = {plateShown = false, greetedAt = -math.huge, alive = true}
    tbl_upv_3.model = a1
    tbl_upv_3.nextEmote = os.clock() + u2:NextNumber(6, 16)
    tbl_upv_2[a1] = tbl_upv_3
    task.spawn(
        function()
            --[[
              line: 99
              upvalues:
                a1 (copy, index: 1)
                tbl_upv_3 (copy, index: 2)
                u2 (copy, index: 3)
            ]]
            local v3 = a1:WaitForChild("Humanoid", 10)
            local u3 = v3 and (v3:WaitForChild("Animator", 10))
            if not tbl_upv_3.alive or not u3 then
                return
            end
            if u3:IsA("Animator") then
                local v4 = a1.PrimaryPart or (a1:FindFirstChild("HumanoidRootPart"))
                tbl_upv_3.root = v4
                local v5 = a1:GetAttribute("IdleAnim")
                if type(v5) ~= "string" or v5 == "" then
                    v4 = "rbxassetid://507766388"
                else
                    v4 = v5
                end
                local success_2, v6 = pcall(function() end)
                local u4
                if (success_2) and (v6) then
                    v6.Priority = Enum.AnimationPriority.Idle
                    v6.Looped = true
                    u4 = v6
                else
                    u4 = nil
                end
                local v9 = nil
                if not (u4) then
                    local _ = "rbxassetid://507766388"
                    local v7
                    v9, v7 = pcall(function() end)
                    if (v9) and (v7) then
                        v7.Priority = Enum.AnimationPriority.Idle
                        v7.Looped = true
                        u4 = v7
                    else
                        u4 = nil
                    end
                end
                local _ = "rbxassetid://507770239"
                local success_4, v8 = pcall(function() end)
                if (success_4) and (v8) then
                    v8.Priority = Enum.AnimationPriority.Action
                    v8.Looped = false
                    v9 = v8
                else
                    v9 = nil
                end
                tbl_upv_3.wave = v9
                local u5 = "rbxassetid://507770677"
                local success_5, v10 = pcall(
                    function()
                        --[[
                          line: 52
                          upvalues:
                            u3 (copy, index: 1)
                            u5 (copy, index: 2)
                        ]]
                        local v11 = Instance.new("Animation")
                        v11.AnimationId = u5
                        return u3:LoadAnimation(v11)
                    end
                )
                if (success_5) and (v10) then
                    v10.Priority = Enum.AnimationPriority.Action
                    v10.Looped = false
                    v9 = v10
                else
                    v9 = nil
                end
                tbl_upv_3.cheer = v9
                if not tbl_upv_3.alive then
                    return
                end
                tbl_upv_3.idle = u4
                if u4 then
                    u4:Play(0.4, 1, u2:NextNumber(0.85, 1))
                    task.delay(
                        0.2,
                        function()
                            --[[
                              line: 118
                              upvalues:
                                tbl_upv_3 (copy, index: 1)
                                u4 (copy, index: 2)
                                u2 (copy, index: 3)
                            ]]
                            if not tbl_upv_3.alive or not (u4.Length > 0) then
                                return
                            end
                            u4.TimePosition = u2:NextNumber(0, u4.Length)
                        end
                    )
                end
            end
        end
    )
end
for _, value_1 in CollectionService_1:GetTagged("HallOfFameChampion") do
    setup(value_1)
end
CollectionService_1:GetInstanceAddedSignal("HallOfFameChampion"):Connect(setup)
local function teardown(a1)
    --[[
      name: teardown
      line: 63
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    local v12 = tbl_upv_2[a1]
    if not v12 then
        return
    end
    v12.alive = false
    tbl_upv_2[a1] = nil
    if v12.plateAlpha then
        v12.plateAlpha:Destroy()
    end
    for _, value_2 in {v12.idle, v12.wave, v12.cheer} do
        if value_2 then
            value_2:Stop(0)
            value_2:Destroy()
        end
    end
end
CollectionService_1:GetInstanceRemovedSignal("HallOfFameChampion"):Connect(
    function(a1)
        --[[
          line: 138
          upvalues:
            teardown (copy, index: 1)
        ]]
        if not a1:IsA("Model") then
            return
        end
        teardown(a1)
    end
)
local function bindPlate(a1, a2, a3)
    --[[
      name: bindPlate
      line: 146
    ]]
    if a1.plateAlpha then
        a1.plateAlpha:Destroy()
    end
    local tbl_upv_4 = {}
    local v13 = nil
    for _, value_3 in a2:GetDescendants() do
        if not (value_3:IsA("GuiObject")) then
            continue
        end
        local tbl_5 = {text = 0}
        tbl_5.gui = value_3
        tbl_5.bg = value_3.BackgroundTransparency
        if value_3:IsA("TextLabel") then
            v13 = value_3.TextTransparency
        else
            v13 = nil
        end
        tbl_5.text = v13
        table.insert(tbl_upv_4, tbl_5)
    end
    local v14 = Instance.new("NumberValue")
    local function apply_1(a4)
        --[[
          name: apply
          line: 157
          upvalues:
            tbl_upv_4 (copy, index: 1)
            a2 (copy, index: 2)
        ]]
        for _, value_4 in tbl_upv_4 do
            value_4.gui.BackgroundTransparency = value_4.bg + ((1 - value_4.bg) * a4)
            if value_4.text then
                value_4.gui.TextTransparency = value_4.text + ((1 - value_4.text) * a4)
            end
        end
        a2.Enabled = a4 < 0.99
    end
    v14.Changed:Connect(apply_1)
    v14.Value = (a3 and 0) or 1
    apply_1(v14.Value)
    a1.plate = a2
    a1.plateShown = a3
    a1.plateAlpha = v14
end
local function emote(a1)
    --[[
      name: emote
      line: 127
    ]]
    if not a1 or (a1.IsPlaying) then
        return
    end
    a1:Play(0.3, 1, 1)
end
local function updatePlate(a1, a2, a3)
    --[[
      name: updatePlate
      line: 172
      upvalues:
        bindPlate (copy, index: 1)
        TweenService_upv_1 (copy, index: 2)
        u1 (copy, index: 3)
    ]]
    local v15 = a2:FindFirstChild("Nameplate")
    if v15 and v15:IsA("BillboardGui") then
        local Magnitude_1 = (a2.Position - a3).Magnitude
        if v15 == a1.plate then
            if a1.plateShown then
                v15 = Magnitude_1 <= 31
            else
                v15 = Magnitude_1 <= 27
            end
            if v15 ~= a1.plateShown and a1.plateAlpha then
                a1.plateShown = v15
                local plateAlpha_1 = a1.plateAlpha
                local tbl_6 = {Value = 0}
                tbl_6.Value = (v15 and 0) or 1
                TweenService_upv_1:Create(plateAlpha_1, u1, tbl_6):Play()
            end
        else
            bindPlate(a1, v15, Magnitude_1 <= 27)
        end
        return
    end
    a1.plate = nil
end
task.spawn(
    function()
        --[[
          line: 191
          upvalues:
            Workspace_upv_1 (copy, index: 1)
            LocalPlayer_upv_1 (copy, index: 2)
            tbl_upv_2 (copy, index: 3)
            teardown (copy, index: 4)
            updatePlate (copy, index: 5)
            u2 (copy, index: 6)
            tbl_upv_1 (copy, index: 7)
            emote (copy, index: 8)
        ]]
        task.wait(0.25)
        local CurrentCamera_1 = Workspace_upv_1.CurrentCamera
        local Character_1 = LocalPlayer_upv_1.Character
        local _ = Character_1 and (Character_1:FindFirstChild("HumanoidRootPart"))
        local v16 = os.clock()
        local v17 = nil
        for key_1, value_5 in tbl_upv_2 do
            if not (key_1.Parent) then
                teardown(key_1)
                continue
            end
            local v18 = value_5.root or (key_1.PrimaryPart)
            if v18 and CurrentCamera_1 then
                updatePlate(value_5, v18, CurrentCamera_1.CFrame.Position)
            end
            if not (v18) or not (value_5.idle) or not (Character_1) then
                continue
            end
            local Magnitude_2 = (v18.Position - Character_1.Position).Magnitude
            if not (Magnitude_2 <= 22) or not (v16 - value_5.greetedAt > 40) then
                if not (Magnitude_2 <= 90) or not (value_5.nextEmote <= v16) then
                    continue
                end
                value_5.nextEmote = v16 + u2:NextNumber(tbl_upv_1[1], tbl_upv_1[2])
                if key_1:GetAttribute("Rank") ~= 1 or not (u2:NextNumber() < 0.6) then
                    v17 = value_5.wave
                    if not (v17) then
                        continue
                    end
                    if not (v17.IsPlaying) then
                        v17:Play(0.3, 1, 1)
                        continue
                    end
                end
                v17 = value_5.cheer
                if not (v17) then
                    continue
                end
                if not (v17.IsPlaying) then
                    v17:Play(0.3, 1, 1)
                    continue
                end
            end
            value_5.greetedAt = v16
            value_5.nextEmote = v16 + u2:NextNumber(tbl_upv_1[1], tbl_upv_1[2])
            task.delay(u2:NextNumber(0, 0.7), emote, value_5.wave)
        end
    end
)