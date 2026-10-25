local Parent_1 = script.Parent.Parent
local Util_upv_1 = require(Parent_1.Util)
local Hud_upv_1 = require(Parent_1.Hud)
local tbl_upv_1 = {}
tbl_upv_1.__index = tbl_upv_1
local tbl_upv_2 = {FullHealth = "ALREADY AT FULL HEALTH", NoCharges = "NONE LEFT THIS ROUND", BadWallSpot = "CAN'T BUILD THERE", BadSpot = "CAN'T SET A TRAP THERE"}
tbl_upv_1.DENY_TEXT = tbl_upv_2
function tbl_upv_1.new(a1)
    --[[
      name: new
      line: 21
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v1 = setmetatable({}, tbl_upv_1)
    v1.ctx = a1
    v1.tuning = a1.tuning
    v1.preset = a1.preset
    v1.kind = a1.kind
    v1.using = false
    v1.token = 0
    v1.lastUse = -math.huge
    v1.charges = 0
    v1.conns = {}
    v1.ghost = nil
    v1.spot = nil
    return v1
end
function tbl_upv_1.Sync(a1)
    --[[
      name: Sync
      line: 37
      upvalues:
        Hud_upv_1 (copy, index: 1)
    ]]
    local v2 = a1.ctx.tool:GetAttribute("Charges")
    if type(v2) == "number" then
        a1.charges = v2
    end
    Hud_upv_1.SetPips(a1.charges, a1.tuning.charges or 0, a1.preset.color)
end
function tbl_upv_1.Equip(a1)
    --[[
      name: Equip
      line: 45
      upvalues:
        Hud_upv_1 (copy, index: 1)
        Util_upv_1 (copy, index: 2)
    ]]
    local ctx_1 = a1.ctx
    Hud_upv_1.SetStyle("Use")
    a1:Sync()
    Util_upv_1.PlayAnim(ctx_1.animator, a1.preset.hold, 1, 0.2)
    Util_upv_1.Sound(a1.preset.equip or "Equip_Item", ctx_1.root)
    table.insert(
        a1.conns,
        ctx_1.tool:GetAttributeChangedSignal("Charges"):Connect(
            function()
                --[[
                  line: 51
                  upvalues:
                    a1 (copy, index: 1)
                ]]
                a1:Sync()
            end
        )
    )
    if a1.kind == "Trap" then
        local wall_1 = a1.tuning.wall
        local v3 = Instance.new("Part")
        v3.Name = "TrapGhost"
        if type(wall_1) ~= "table" then
            v3.Shape = Enum.PartType.Cylinder
            v3.Size = Vector3.new(0.1, (a1.tuning.triggerRadius or 3) * 2, (a1.tuning.triggerRadius or 3) * 2)
        else
            v3.Size = Vector3.new(wall_1.width or 6, wall_1.height or 5, 0.9)
        end
        v3.Material = Enum.Material.SmoothPlastic
        v3.Anchored = true
        v3.CanCollide = false
        v3.CanQuery = false
        v3.CanTouch = false
        v3.CastShadow = false
        v3.Transparency = 1
        v3.Parent = workspace:FindFirstChild("FX") or workspace
        a1.ghost = v3
    end
end
function tbl_upv_1.Unequip(a1)
    --[[
      name: Unequip
      line: 77
      upvalues:
        Util_upv_1 (copy, index: 1)
        Hud_upv_1 (copy, index: 2)
    ]]
    for _, value_1 in a1.conns do
        value_1:Disconnect()
    end
    table.clear(a1.conns)
    if a1.using then
        a1:Cancel()
    end
    if a1.ghost then
        a1.ghost:Destroy()
        a1.ghost = nil
    end
    Util_upv_1.StopAnim(a1.ctx.animator, a1.preset.hold, 0.15)
    Hud_upv_1.SetPips(0, 0)
end
function tbl_upv_1.Cancel(a1)
    --[[
      name: Cancel
      line: 93
      upvalues:
        Util_upv_1 (copy, index: 1)
        Hud_upv_1 (copy, index: 2)
    ]]
    local ctx_2 = a1.ctx
    a1.using = false
    a1.token = a1.token + 1
    ctx_2.send("Use", {on = false, tool = ctx_2.tool})
    ctx_2.emit("Use", {on = false})
    Util_upv_1.StopAnim(ctx_2.animator, a1.preset.use, 0.1)
    ctx_2.setSpeed("Use", nil)
    Hud_upv_1.StopChannel()
end
function tbl_upv_1.TrapSpot(a1)
    --[[
      name: TrapSpot
      line: 105
      upvalues:
        Util_upv_1 (copy, index: 1)
    ]]
    local root_1 = a1.ctx.root
    local v5 = a1.tuning.placeRange or 7
    local v6 = Util_upv_1.AimPoint(60)
    local v7 = Vector3.new(v6.X - root_1.Position.X, 0, v6.Z - root_1.Position.Z)
    local v8 = ((v5 < v7.Magnitude) and (v7.Unit * v5)) or (((v7.Magnitude < 2.5) and (Vector3.new(root_1.CFrame.LookVector.X, 0, root_1.CFrame.LookVector.Z).Unit * 3.5)) or v7)
    local v9 = workspace:Raycast((root_1.Position + v8) + Vector3.new(0, 3, 0), Vector3.new(0, -12, 0), Util_upv_1.WorldParams(Util_upv_1.Targets()))
    if v9 and not (v9.Normal.Y < (((a1.tuning.wall) and 0.75) or 0.6)) then
        if workspace:Raycast(root_1.Position, (v9.Position + Vector3.new(0, 0.5, 0)) - root_1.Position, Util_upv_1.WorldParams(Util_upv_1.Targets())) then
            return nil
        end
        return v9.Position
    end
    return nil
end
function tbl_upv_1.Activate(a1)
    --[[
      name: Activate
      line: 127
      upvalues:
        Util_upv_1 (copy, index: 1)
        Hud_upv_1 (copy, index: 2)
        tbl_upv_2 (copy, index: 3)
    ]]
    local ctx_upv_3 = a1.ctx
    local v10 = os.clock()
    if (a1.using) or (v10 - a1.lastUse < (a1.tuning.useTime or 0.5) + 0.1) or not Util_upv_1.CanAct() then
        return
    end
    if a1.charges < 1 then
        Util_upv_1.Sound("Denied", ctx_upv_3.root)
        Hud_upv_1.Toast(tbl_upv_2.NoCharges, Color3.fromRGB(255, 120, 90))
    else
        if a1.kind ~= "Herbs" and a1.kind ~= "Horn" then
            if a1.kind == "Trap" then
                local v11 = a1:TrapSpot()
                if v11 then
                    a1.lastUse = v10
                    local u1 = Util_upv_1.PlayAnim(ctx_upv_3.animator, a1.preset.use, 1.6, 0.05)
                    Util_upv_1.Sound(a1.preset.useSound or "Trap_Set", v11)
                    ctx_upv_3.send("Use", {on = true, tool = ctx_upv_3.tool, position = v11})
                    ctx_upv_3.emit("Place", nil)
                    local v12, v13 = nil, nil
                    if Util_upv_1.InFirstPerson() then
                        local char_1 = ctx_upv_3.char
                        local u2 = char_1 and (char_1:GetAttribute("CombatantId"))
                        if type(u2) ~= "string" or u2 == "" then
                            local UserId_1 = game:GetService("Players").LocalPlayer.UserId
                            u2 = "p" .. UserId_1
                        end
                        local u3 = v10 + 0.22
                        local tbl_upv_3 = {}
                        local function watch(a2)
                            --[[
                              name: watch
                              line: 196
                              upvalues:
                                tbl_upv_3 (copy, index: 1)
                            ]]
                            if not a2 then
                                return
                            end
                            table.insert(tbl_upv_3, a2.DescendantAdded:Connect(function() end))
                        end
                        v12 = workspace:FindFirstChild("FX")
                        if v12 then
                            table.insert(tbl_upv_3, v12.DescendantAdded:Connect(function() end))
                        end
                        v13 = workspace:FindFirstChild("Walls")
                        if v13 then
                            table.insert(
                                tbl_upv_3,
                                v13.DescendantAdded:Connect(
                                    function(a3)
                                        --[[
                                          line: 201
                                          upvalues:
                                            u2 (ref,  index: 1)
                                            u3 (copy, index: 2)
                                            tbl_upv_3 (copy, index: 3)
                                        ]]
                                        if not a3:IsA("Model") or a3:GetAttribute("OwnerId") ~= u2 or u3 <= os.clock() then
                                            return
                                        end
                                        local function hide(a4)
                                            --[[
                                              name: hide
                                              line: 205
                                              upvalues:
                                                u3 (copy, index: 1)
                                            ]]
                                            if not a4:IsA("BasePart") then
                                                return
                                            end
                                            a4.LocalTransparencyModifier = 1
                                            task.delay(
                                                math.max(0, u3 - os.clock()),
                                                function()
                                                    --[[
                                                      line: 208
                                                      upvalues:
                                                        a4 (copy, index: 1)
                                                    ]]
                                                    a4.LocalTransparencyModifier = 0
                                                end
                                            )
                                        end
                                        for _, value_2 in a3:GetDescendants() do
                                            hide(value_2)
                                        end
                                        table.insert(tbl_upv_3, a3.DescendantAdded:Connect(hide))
                                    end
                                )
                            )
                        end
                        task.delay(
                            0.6,
                            function()
                                --[[
                                  line: 221
                                  upvalues:
                                    tbl_upv_3 (copy, index: 1)
                                ]]
                                for _, value_3 in tbl_upv_3 do
                                    value_3:Disconnect()
                                end
                            end
                        )
                        if a1.tuning.wall then
                            task.delay(0.2, Util_upv_1.Recoil, -5.5, 0)
                        end
                    end
                    task.delay(
                        0.45,
                        function()
                            --[[
                              line: 231
                              upvalues:
                                u1 (copy, index: 1)
                            ]]
                            if not u1 then
                                return
                            end
                            u1:Stop(0.15)
                        end
                    )
                else
                    Util_upv_1.Sound("Denied", ctx_upv_3.root)
                    local Toast_1 = Hud_upv_1.Toast
                    local v14
                    if a1.tuning.wall then
                        v14 = tbl_upv_2.BadWallSpot
                    else
                        v14 = tbl_upv_2.BadSpot
                    end
                    Toast_1(v14, Color3.fromRGB(255, 120, 90))
                    return
                end
            end
            return
        end
        local u4 = a1.kind == "Horn"
        local hum_1 = ctx_upv_3.hum
        if not (u4) and hum_1.MaxHealth - 0.5 <= hum_1.Health then
            Util_upv_1.Sound("Denied", ctx_upv_3.root)
            Hud_upv_1.Toast(tbl_upv_2.FullHealth, Color3.fromRGB(255, 120, 90))
        else
            a1.lastUse = v10
            a1.using = true
            a1.token = a1.token + 1
            local token_upv_1 = a1.token
            local v15 = a1.tuning.useTime or 0.6
            ctx_upv_3.send("Use", {on = true, tool = ctx_upv_3.tool})
            ctx_upv_3.emit("Use", {on = true, time = v15})
            Util_upv_1.PlayAnim(ctx_upv_3.animator, a1.preset.use, 1, 0.1)
            Util_upv_1.Sound(a1.preset.useSound or "Bandage_Wrap", ctx_upv_3.root)
            ctx_upv_3.setSpeed("Use", a1.tuning.useSpeedMult or 0.6)
            Hud_upv_1.StartChannel(a1.preset.label or "USING", v15, a1.preset.color)
            task.delay(
                v15,
                function()
                    --[[
                      line: 157
                      upvalues:
                        a1 (copy, index: 1)
                        token_upv_1 (copy, index: 2)
                        ctx_upv_3 (copy, index: 3)
                        Util_upv_1 (copy, index: 4)
                        Hud_upv_1 (copy, index: 5)
                        u4 (copy, index: 6)
                    ]]
                    if a1.token ~= token_upv_1 or not a1.using then
                        return
                    end
                    a1.using = false
                    ctx_upv_3.emit("Use", {on = false, done = true})
                    Util_upv_1.StopAnim(ctx_upv_3.animator, a1.preset.use, 0.15)
                    ctx_upv_3.setSpeed("Use", nil)
                    Hud_upv_1.StopChannel()
                    if u4 then
                        return
                    end
                    Hud_upv_1.Flash(Color3.fromRGB(110, 220, 110), 0.35, 0.4)
                    task.delay(
                        a1.tuning.healTime or 3,
                        function()
                            --[[
                              line: 170
                              upvalues:
                                ctx_upv_3 (copy, index: 1)
                                Util_upv_1 (copy, index: 2)
                                a1 (copy, index: 3)
                            ]]
                            if not ctx_upv_3.alive() then
                                return
                            end
                            Util_upv_1.Sound(a1.preset.doneSound or "Heal_Done", ctx_upv_3.root)
                        end
                    )
                end
            )
        end
    end
end
function tbl_upv_1.Input(a1, a2, a3)
    --[[
      name: Input
      line: 239
    ]]
    if a2 ~= "Primary" or not a3 then
        return
    end
    a1:Activate()
end
function tbl_upv_1.Update(a1, a2)
    --[[
      name: Update
      line: 245
    ]]
    local ghost_1 = a1.ghost
    if ghost_1 then
        local v16
        if a1.charges >= 1 then
            v16 = a1:TrapSpot()
        else
            v16 = nil
        end
        local wall_2 = a1.tuning.wall
        if v16 then
            local v17 = nil
            if type(wall_2) == "table" then
                local root_2 = a1.ctx.root
                v17 = Vector3.new(v16.X - root_2.Position.X, 0, v16.Z - root_2.Position.Z)
                local v18
                if v17.Magnitude > 0.1 then
                    v18 = v17.Unit
                else
                    v18 = Vector3.new(root_2.CFrame.LookVector.X, 0, root_2.CFrame.LookVector.Z).Unit
                end
                ghost_1.CFrame = CFrame.lookAt(v16, v16 + v18) * CFrame.new(0, (wall_2.height or 5) / 2, 0)
                ghost_1.Color = Color3.fromRGB(214, 180, 130)
                ghost_1.Transparency = 0.7
                return
            end
        end
        if v16 then
            ghost_1.CFrame = CFrame.new(v16 + Vector3.new(0, 0.05999999865889549, 0)) * CFrame.Angles(0, 0, 1.5707963267948966)
            ghost_1.Color = Color3.fromRGB(228, 232, 240)
            ghost_1.Transparency = 0.55
        else
            ghost_1.Transparency = 1
        end
    end
end
function tbl_upv_1.OnDenied(a1, a2)
    --[[
      name: OnDenied
      line: 269
      upvalues:
        Util_upv_1 (copy, index: 1)
        Hud_upv_1 (copy, index: 2)
        tbl_upv_2 (copy, index: 3)
    ]]
    if a1.using then
        a1.using = false
        a1.token = a1.token + 1
        a1.ctx.emit("Use", {on = false})
        Util_upv_1.StopAnim(a1.ctx.animator, a1.preset.use, 0.1)
        a1.ctx.setSpeed("Use", nil)
        Hud_upv_1.StopChannel()
    end
    local v19
    if a2 == "BadSpot" and (a1.tuning.wall) then
        v19 = tbl_upv_2.BadWallSpot
    else
        v19 = tbl_upv_2[a2]
    end
    if v19 then
        Hud_upv_1.Toast(v19, Color3.fromRGB(255, 120, 90))
    end
    a1:Sync()
end
function tbl_upv_1.Interrupt(a1)
    --[[
      name: Interrupt
      line: 285
    ]]
    if not a1.using then
        return
    end
    a1:Cancel()
end
return tbl_upv_1