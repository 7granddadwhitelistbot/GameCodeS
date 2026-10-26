local CollectionService_upv_1 = game:GetService("CollectionService")
local Players_1 = game:GetService("Players")
local TweenService_upv_1 = game:GetService("TweenService")
local tbl_1 = {}
local LocalPlayer_upv_1 = Players_1.LocalPlayer
local tbl_upv_2 = {}
local function close(a1)
    --[[
      name: close
      line: 33
      upvalues:
        TweenService_upv_1 (copy, index: 1)
    ]]
    if a1.closed then
        return
    end
    a1.closed = true
    local _ = a1.model:GetPivot()
    for key_1, value_1 in {"JawA", "JawB"} do
        local u1 = a1.model:FindFirstChild(value_1)
        if not (u1) then
            continue
        end
        if u1:IsA("Model") then
            local v1 = u1:GetPivot()
            local v2 = v1 * CFrame.Angles((((key_1 ~= 1) and -1) or 1) * 1.4311699866353502, 0, 0)
            local u2 = Instance.new("CFrameValue")
            u2.Value = v1
            u2.Changed:Connect(
                function(a2)
                    --[[
                      line: 47
                      upvalues:
                        u1 (copy, index: 1)
                    ]]
                    if not u1.Parent then
                        return
                    end
                    u1:PivotTo(a2)
                end
            )
            local tbl_3 = {}
            tbl_3.Value = v2
            TweenService_upv_1:Create(u2, TweenInfo.new(0.07, Enum.EasingStyle.Quad, Enum.EasingDirection.In), tbl_3):Play()
            task.delay(
                0.2,
                function()
                    --[[
                      line: 53
                      upvalues:
                        u2 (copy, index: 1)
                    ]]
                    u2:Destroy()
                end
            )
        end
    end
end
local function isAlly(a1)
    --[[
      name: isAlly
      line: 17
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local Character_1 = LocalPlayer_upv_1.Character
    if a1:GetAttribute("OwnerUserId") == LocalPlayer_upv_1.UserId then
        return true
    end
    if not Character_1 then
        return false
    end
    local v3 = Character_1:GetAttribute("MatchId")
    if type(v3) == "string" and v3 ~= "" then
        local v4 = (a1:GetAttribute("MatchId") == v3) and (a1:GetAttribute("Team") == Character_1:GetAttribute("Team"))
        return v4
    end
    return false
end
local function unregister(a1)
    --[[
      name: unregister
      line: 108
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    if not a1:IsA("Model") then
        return
    end
    tbl_upv_2[a1] = nil
end
local function register(a1)
    --[[
      name: register
      line: 61
      upvalues:
        tbl_upv_2 (copy, index: 1)
        isAlly (copy, index: 2)
        LocalPlayer_upv_1 (copy, index: 3)
        close (copy, index: 4)
    ]]
    if not a1:IsA("Model") or tbl_upv_2[a1] then
        return
    end
    local tbl_4 = {}
    for _, value_2 in a1:GetDescendants() do
        if value_2:IsA("BasePart") then
            table.insert(tbl_4, value_2)
        end
    end
    local tbl_upv_5 = {closed = false, lastAlpha = -1}
    tbl_upv_5.model = a1
    tbl_upv_5.parts = tbl_4
    tbl_upv_2[a1] = tbl_upv_5
    if isAlly(a1) then
        local v5 = Instance.new("Part")
        v5.Name = "AllyRing"
        v5.Shape = Enum.PartType.Cylinder
        v5.Size = Vector3.new(0.05000000074505806, 6.400000095367432, 6.400000095367432)
        v5.Material = Enum.Material.SmoothPlastic
        v5.Color = Color3.fromRGB(90, 170, 240)
        v5.Transparency = 0.8
        v5.Anchored = true
        v5.CanCollide = false
        v5.CanQuery = false
        v5.CanTouch = false
        v5.CastShadow = false
        v5.CFrame = CFrame.new(a1:GetPivot().Position + Vector3.new(0, 0.05000000074505806, 0)) * CFrame.Angles(0, 0, 1.5707963267948966)
        v5.Parent = a1
        tbl_upv_5.ring = v5
    end
    if a1:GetAttribute("OwnerUserId") == LocalPlayer_upv_1.UserId then
        a1:GetAttributeChangedSignal("Armed"):Connect(
            function()
                --[[
                  line: 91
                  upvalues:
                    a1 (copy, index: 1)
                ]]
                if a1:GetAttribute("Armed") ~= true or a1:GetAttribute("Sprung") == true then
                    return
                end
                require(script.Parent.Util).Sound("Trap_Armed", a1:GetPivot().Position)
            end
        )
    end
    a1:GetAttributeChangedSignal("Sprung"):Connect(
        function()
            --[[
              line: 98
              upvalues:
                a1 (copy, index: 1)
                close (copy, index: 2)
                tbl_upv_5 (copy, index: 3)
            ]]
            if a1:GetAttribute("Sprung") ~= true then
                return
            end
            close(tbl_upv_5)
        end
    )
    if a1:GetAttribute("Sprung") ~= true then
        return
    end
    close(tbl_upv_5)
end
local function update()
    --[[
      name: update
      line: 114
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
        isAlly (copy, index: 3)
    ]]
    local v6 = LocalPlayer_upv_1.Character
    local v7 = v6 and (v6:FindFirstChild("HumanoidRootPart"))
    if v7 then
        v6 = v7.Position
    else
        v6 = workspace.CurrentCamera.CFrame.Position
    end
    local v8 = nil
    for key_2, value_3 in tbl_upv_2 do
        if not (key_2.Parent) then
            tbl_upv_2[key_2] = nil
            continue
        end
        v7 = 0
        local v9 = isAlly(key_2)
        if not v9 and key_2:GetAttribute("Sprung") ~= true then
            local v10 = key_2:GetAttribute("HiddenBeyond")
            if type(v10) ~= "number" then
                v8 = 25
            else
                v8 = v10
            end
            v7 = math.clamp(((key_2:GetPivot().Position - v6).Magnitude - (v8 * 0.7)) / (v8 * 0.3), 0, 1)
        end
        if not (math.abs(v7 - value_3.lastAlpha) > 0.02) then
            continue
        end
        value_3.lastAlpha = v7
        for _, value_4 in value_3.parts do
            value_4.LocalTransparencyModifier = v7
        end
    end
end
function tbl_1.Init()
    --[[
      name: Init
      line: 141
      upvalues:
        CollectionService_upv_1 (copy, index: 1)
        register (copy, index: 2)
        unregister (copy, index: 3)
        tbl_upv_2 (copy, index: 4)
        update (copy, index: 5)
    ]]
    CollectionService_upv_1:GetInstanceAddedSignal("BearTrap"):Connect(register)
    CollectionService_upv_1:GetInstanceRemovedSignal("BearTrap"):Connect(unregister)
    for _, value_5 in CollectionService_upv_1:GetTagged("BearTrap") do
        register(value_5)
    end
    task.spawn(
        function()
            --[[
              line: 147
              upvalues:
                tbl_upv_2 (copy, index: 1)
                update (copy, index: 2)
            ]]
            repeat
                task.wait(0.1)
            until next(tbl_upv_2)
            local success_1, v11 = pcall(update)
            if success_1 then
                return
            end
            warn("[Combat] trap visuals:", v11)
        end
    )
end
return tbl_1