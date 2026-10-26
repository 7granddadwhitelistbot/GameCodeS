local CollectionService_upv_1 = game:GetService("CollectionService")
local Players_upv_1 = game:GetService("Players")
local RunService_upv_1 = game:GetService("RunService")
local tbl_upv_1 = {}
local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
tbl_upv_1.POSES = {}
local tbl_upv_2 = {}
local tbl_upv_3 = {}
local function rebuild()
    --[[
      name: rebuild
      line: 37
      upvalues:
        tbl_upv_1 (copy, index: 1)
        tbl_upv_3 (copy, index: 2)
    ]]
    for key_1, value_1 in tbl_upv_1.POSES do
        local tbl_4 = {}
        for key_2, value_2 in value_1 do
            tbl_4[key_2] = CFrame.Angles(math.rad(value_2.X), math.rad(value_2.Y), math.rad(value_2.Z))
        end
        tbl_upv_3[key_1] = tbl_4
    end
end
rebuild()
tbl_upv_1.Rebuild = rebuild
local tbl_upv_5 = {"RightShoulder", "RightElbow", "RightWrist", "LeftShoulder", "LeftElbow"}
local function findMotors(a1)
    --[[
      name: findMotors
      line: 50
      upvalues:
        tbl_upv_5 (copy, index: 1)
    ]]
    local tbl_6 = {}
    for _, value_3 in tbl_upv_5 do
        local v1 = a1:FindFirstChild(value_3, true)
        if v1 and (v1:IsA("Motor6D") or v1:IsA("AnimationConstraint")) then
            tbl_6[value_3] = v1
        end
    end
    return tbl_6
end
local function stateOf(a1)
    --[[
      name: stateOf
      line: 61
      upvalues:
        tbl_upv_2 (copy, index: 1)
        findMotors (copy, index: 2)
    ]]
    local v2 = tbl_upv_2[a1]
    if not (v2) then
        v2 = {kick = 0, alpha = 0, model = a1, motors = findMotors(a1)}
        tbl_upv_2[a1] = v2
    end
    return v2
end
function tbl_upv_1.Kick(a1, a2)
    --[[
      name: Kick
      line: 85
      upvalues:
        tbl_upv_2 (copy, index: 1)
        findMotors (copy, index: 2)
    ]]
    if not a1 then
        return
    end
    local v3 = tbl_upv_2[a1]
    if not (v3) then
        v3 = {kick = 0, alpha = 0, model = a1, motors = findMotors(a1)}
        tbl_upv_2[a1] = v3
    end
    if not (next(v3.motors)) then
        v3.motors = findMotors(a1)
    end
    v3.kick = math.max(v3.kick, math.min(a2, 45))
end
local tbl_upv_7 = {}
local function refresh(a1)
    --[[
      name: refresh
      line: 70
      upvalues:
        tbl_upv_3 (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
        findMotors (copy, index: 3)
    ]]
    local v4 = a1:FindFirstChildOfClass("Tool")
    local v5 = v4 and (v4:GetAttribute("Kind"))
    v4 = type(v5) ~= "string" or not (tbl_upv_3[v5]) or v5
    local v6 = nil
    if v4 then
        v6 = tbl_upv_2[a1]
        if not (v6) then
            v6 = {kick = 0, alpha = 0, model = a1, motors = findMotors(a1)}
            tbl_upv_2[a1] = v6
        end
        v6.pose = v4
        v6.motors = findMotors(a1)
    elseif tbl_upv_2[a1] then
        tbl_upv_2[a1].pose = nil
    end
end
local function watch(a1)
    --[[
      name: watch
      line: 97
      upvalues:
        tbl_upv_7 (copy, index: 1)
        refresh (copy, index: 2)
        tbl_upv_2 (copy, index: 3)
    ]]
    if tbl_upv_7[a1] then
        return
    end
    tbl_upv_7[a1] = true
    a1.ChildAdded:Connect(
        function(a2)
            --[[
              line: 102
              upvalues:
                refresh (copy, index: 1)
                a1 (copy, index: 2)
            ]]
            if not a2:IsA("Tool") then
                return
            end
            task.defer(refresh, a1)
        end
    )
    a1.ChildRemoved:Connect(
        function(a3)
            --[[
              line: 107
              upvalues:
                refresh (copy, index: 1)
                a1 (copy, index: 2)
            ]]
            if not a3:IsA("Tool") then
                return
            end
            task.defer(refresh, a1)
        end
    )
    a1.Destroying:Once(
        function()
            --[[
              line: 112
              upvalues:
                tbl_upv_7 (copy, index: 1)
                a1 (copy, index: 2)
                tbl_upv_2 (copy, index: 3)
            ]]
            tbl_upv_7[a1] = nil
            tbl_upv_2[a1] = nil
        end
    )
    refresh(a1)
end
tbl_upv_1.Watch = watch
local u1 = false
local function step(a1)
    --[[
      name: step
      line: 121
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
        tbl_upv_3 (copy, index: 3)
    ]]
    local Character_1 = LocalPlayer_upv_1.Character
    local v7, v8 = nil, nil
    for key_3, value_4 in tbl_upv_2 do
        if not (key_3:IsDescendantOf(workspace)) then
            tbl_upv_2[key_3] = nil
            continue
        end
        if value_4.alpha < (((value_4.pose) and 1) or 0) then
            value_4.alpha = math.min(1, value_4.alpha + (a1 / 0.1))
        else
            value_4.alpha = math.max(0, value_4.alpha - (a1 / 0.14))
        end
        value_4.kick = math.max(0, (value_4.kick - ((a1 * value_4.kick) * 14)) - (a1 * 20))
        if value_4.alpha <= 0 and value_4.kick <= 0 then
            if not (value_4.pose) then
                tbl_upv_2[key_3] = nil
            end
        else
            local pose_1 = value_4.pose
            local v9 = pose_1 and (tbl_upv_3[value_4.pose])
            v7 = 0
            if key_3 == Character_1 and value_4.pose then
                v7 = math.asin(math.clamp(workspace.CurrentCamera.CFrame.LookVector.Y, -1, 1))
            end
            for key_4, value_5 in value_4.motors do
                if not (value_5.Parent) then
                    continue
                end
                local Transform_1 = value_5.Transform
                if v9 and v9[key_4] then
                    v8 = v9[key_4]
                    if key_4 == "RightShoulder" and v7 ~= 0 then
                        v8 = CFrame.Angles(v7, 0, 0) * v8
                    end
                    local _ = Transform_1:Lerp(v8, (value_4.alpha * value_4.alpha) * (3 - (value_4.alpha * 2)))
                end
                if value_4.kick > 0 and (key_4 == "RightShoulder" or key_4 == "RightElbow") then
                    Transform_1 = CFrame.Angles(math.rad(value_4.kick * (((key_4 ~= "RightElbow") and 1) or 0.6)), 0, 0) * Transform_1
                end
                value_5.Transform = Transform_1
            end
        end
    end
end
function tbl_upv_1.Init()
    --[[
      name: Init
      line: 169
      upvalues:
        u1 (ref,  index: 1)
        RunService_upv_1 (copy, index: 2)
        step (copy, index: 3)
        watch (copy, index: 4)
        Players_upv_1 (copy, index: 5)
        CollectionService_upv_1 (copy, index: 6)
    ]]
    if u1 then
        return
    end
    u1 = true
    RunService_upv_1.PreSimulation:Connect(step)
    for _, value_6 in Players_upv_1:GetPlayers() do
        value_6.CharacterAdded:Connect(watch)
        if value_6.Character then
            watch(value_6.Character)
        end
    end
    local function onPlayer(a1)
        --[[
          name: onPlayer
          line: 175
          upvalues:
            watch (copy, index: 1)
        ]]
        a1.CharacterAdded:Connect(watch)
        if not a1.Character then
            return
        end
        watch(a1.Character)
    end
    Players_upv_1.PlayerAdded:Connect(onPlayer)
    for _, value_7 in {"Combatant", "Bot"} do
        CollectionService_upv_1:GetInstanceAddedSignal(value_7):Connect(
            function(a2)
                --[[
                  line: 186
                  upvalues:
                    watch (copy, index: 1)
                ]]
                if not a2:IsA("Model") then
                    return
                end
                watch(a2)
            end
        )
        for v1, value_8 in CollectionService_upv_1:GetTagged(value_7) do
            if value_8:IsA("Model") then
                watch(value_8)
            end
        end
    end
end
return tbl_upv_1