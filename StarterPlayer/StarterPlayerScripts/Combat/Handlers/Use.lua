local parent = script.Parent.Parent
local Util = require(parent.Util)
local Hud = require(parent.Hud)
local Class = {}
Class.__index = Class
local denyText = {FullHealth = "ALREADY AT FULL HEALTH", NoCharges = "NONE LEFT THIS ROUND", BadSpot = "CAN'T SET A TRAP THERE", BadWallSpot = "CAN'T BUILD THERE"}
Class.DENY_TEXT = denyText

function Class.new(ctx)
    --[[
      name: new
      line: 21
      upvalues:
        Class (copy, index: 1)
    ]]
    local v7 = setmetatable({}, Class)
    v7.ctx = ctx
    v7.tuning = ctx.tuning
    v7.preset = ctx.preset
    v7.kind = ctx.kind
    v7.using = false
    v7.token = 0
    v7.lastUse = -math.huge
    v7.charges = 0
    v7.conns = {}
    v7.ghost = nil
    v7.spot = nil
    return v7
end

function Class.Sync(self)
    --[[
      name: Sync
      line: 37
      upvalues:
        Hud (copy, index: 1)
    ]]
    local charges = self.ctx.tool:GetAttribute("Charges")

    if type(charges) == "number" then
        self.charges = charges
    end

    Hud.SetPips(self.charges, (self.tuning.charges or 0), self.preset.color)
end

function Class.Equip(self)
    --[[
      name: Equip
      line: 45
      upvalues:
        Hud (copy, index: 1)
        Util (copy, index: 2)
    ]]
    local ctx = self.ctx
    Hud.SetStyle("Use")
    self:Sync()
    Util.PlayAnim(ctx.animator, self.preset.hold, 1, 0.2)
    Util.Sound((self.preset.equip or "Equip_Item"), ctx.root)
    table.insert(
        self.conns,
        ctx.tool:GetAttributeChangedSignal("Charges"):Connect(
            function()
                --[[
                  line: 51
                  upvalues:
                    self (copy, index: 1)
                ]]
                self:Sync()
            end
        )
    )

    if self.kind == "Trap" then
        local wall = self.tuning.wall
        local trapGhost = Instance.new("Part")
        trapGhost.Name = "TrapGhost"

        if type(wall) ~= "table" then
            trapGhost.Shape = Enum.PartType.Cylinder
            trapGhost.Size = Vector3.new(0.1, (self.tuning.triggerRadius or 3) * 2, (self.tuning.triggerRadius
                or 3) * 2)
        else
            trapGhost.Size = Vector3.new((wall.width or 6), (wall.height or 5), 0.9)
        end

        trapGhost.Material = Enum.Material.SmoothPlastic
        trapGhost.Anchored = true
        trapGhost.CanCollide = false
        trapGhost.CanQuery = false
        trapGhost.CanTouch = false
        trapGhost.CastShadow = false
        trapGhost.Transparency = 1
        local instance = workspace:FindFirstChild("FX") or workspace
        trapGhost.Parent = instance
        self.ghost = trapGhost
    end
end

function Class.Unequip(self)
    --[[
      name: Unequip
      line: 77
      upvalues:
        Util (copy, index: 1)
        Hud (copy, index: 2)
    ]]
    for _, conn in self.conns do
        conn:Disconnect()
    end

    table.clear(self.conns)

    if self.using then
        self:Cancel()
    end

    if self.ghost then
        self.ghost:Destroy()
        self.ghost = nil
    end

    Util.StopAnim(self.ctx.animator, self.preset.hold, 0.15)
    Hud.SetPips(0, 0)
end

function Class.Cancel(self)
    --[[
      name: Cancel
      line: 93
      upvalues:
        Util (copy, index: 1)
        Hud (copy, index: 2)
    ]]
    local ctx = self.ctx
    self.using = false
    self.token += 1
    ctx.send("Use", {on = false, tool = ctx.tool})
    ctx.emit("Use", {on = false})
    Util.StopAnim(ctx.animator, self.preset.use, 0.1)
    ctx.setSpeed("Use", nil)
    Hud.StopChannel()
end

function Class.TrapSpot(self)
    --[[
      name: TrapSpot
      line: 105
      upvalues:
        Util (copy, index: 1)
    ]]
    local root = self.ctx.root
    local placeRange = self.tuning.placeRange or 7
    local v23 = Util.AimPoint(60)
    local v24 = Vector3.new(v23.X - root.Position.X, 0, v23.Z - root.Position.Z)

    if placeRange < v24.Magnitude then
        v24 = v24.Unit * placeRange
    elseif v24.Magnitude < 2.5 then
        v24 = Vector3.new(root.CFrame.LookVector.X, 0, root.CFrame.LookVector.Z).Unit * 3.5
    end

    local raycastResult = workspace:Raycast((root.Position + v24) + Vector3.new(0, 3, 0), Vector3.new(0, -12, 0), Util.WorldParams(Util.Targets()))

    if raycastResult and not (raycastResult.Normal.Y < ((self.tuning.wall and 0.75) or 0.6)) then
        if workspace:Raycast(root.Position, (raycastResult.Position + Vector3.new(0, 0.5, 0)) - root.Position, Util.WorldParams(Util.Targets())) then
            return nil
        end

        return raycastResult.Position
    end

    return nil
end

function Class.Activate(self)
    --[[
      name: Activate
      line: 127
      upvalues:
        Util (copy, index: 1)
        Hud (copy, index: 2)
        denyText (copy, index: 3)
    ]]
    local ctx = self.ctx
    local timestamp = os.clock()

    if self.using or timestamp - self.lastUse < (self.tuning.useTime or 0.5) + 0.1 or not Util.CanAct() then
        return
    end

    if self.charges < 1 then
        Util.Sound("Denied", ctx.root)
        Hud.Toast(denyText.NoCharges, Color3.fromRGB(255, 120, 90))

        return
    end

    if self.kind ~= "Herbs" and self.kind ~= "Horn" then
        if self.kind == "Trap" then
            local position = self:TrapSpot()
            if not position then
                Util.Sound("Denied", ctx.root)
                local toast = Hud.Toast
                local v31 = if self.tuning.wall then denyText.BadWallSpot else denyText.BadSpot
                toast(v31, Color3.fromRGB(255, 120, 90))

                return
            end

            self.lastUse = timestamp
            local v32 = Util.PlayAnim(ctx.animator, self.preset.use, 1.6, 0.05)
            Util.Sound((self.preset.useSound or "Trap_Set"), position)
            ctx.send("Use", {on = true, tool = ctx.tool, position = position})
            ctx.emit("Place", nil)

            if Util.InFirstPerson() then
                local v33
                local char = ctx.char
                local combatantId = char and char:GetAttribute("CombatantId")

                if type(combatantId) ~= "string" or combatantId == "" then
                    v33 = "p" .. game:GetService("Players").LocalPlayer.UserId
                else
                    v33 = combatantId
                end

                local v36 = timestamp + 0.22
                local v37 = {}

                local function watch(a39)
                    --[[
                      name: watch
                      line: 199
                      upvalues:
                        v37 (copy, index: 1)
                        v33 (ref,  index: 2)
                        v36 (copy, index: 3)
                    ]]
                    if not a39 then
                        return
                    end

                    table.insert(
                        v37,
                        a39.DescendantAdded:Connect(
                            function(a40)
                                --[[
                                  line: 204
                                  upvalues:
                                    v33 (ref,  index: 1)
                                    v36 (copy, index: 2)
                                    v37 (copy, index: 3)
                                ]]
                                if not a40:IsA("Model") or a40:GetAttribute("OwnerId") ~= v33 or v36 <= os.clock() then
                                    return
                                end

                                local function hide(a42)
                                    --[[
                                      name: hide
                                      line: 208
                                      upvalues:
                                        v36 (copy, index: 1)
                                    ]]
                                    if a42:IsA("BasePart") then
                                        a42.LocalTransparencyModifier = 1
                                        task.delay(
                                            math.max(0, v36 - os.clock()),
                                            function()
                                                --[[
                                                  line: 211
                                                  upvalues:
                                                    a42 (copy, index: 1)
                                                ]]
                                                a42.LocalTransparencyModifier = 0
                                            end
                                        )
                                    end
                                end

                                for _, descendant in a40:GetDescendants() do
                                    hide(descendant)
                                end

                                table.insert(v37, a40.DescendantAdded:Connect(hide))
                            end
                        )
                    )
                end

                if const fx = workspace:FindFirstChild("FX") then
                    table.insert(
                        v37,
                        fx.DescendantAdded:Connect(
                            function(descendant: Instance)
                                --[[
                                  line: 204
                                  upvalues:
                                    v33 (ref,  index: 1)
                                    v36 (copy, index: 2)
                                    v37 (copy, index: 3)
                                ]]
                                if not descendant:IsA("Model")
                                    or descendant:GetAttribute("OwnerId") ~= v33
                                    or v36 <= os.clock()
                                then
                                    return
                                end

                                local function hide(descendant: Instance)
                                    --[[
                                      name: hide
                                      line: 208
                                      upvalues:
                                        v36 (copy, index: 1)
                                    ]]
                                    if descendant:IsA("BasePart") then
                                        descendant.LocalTransparencyModifier = 1
                                        task.delay(
                                            math.max(0, v36 - os.clock()),
                                            function()
                                                --[[
                                                  line: 211
                                                  upvalues:
                                                    descendant (copy, index: 1)
                                                ]]
                                                descendant.LocalTransparencyModifier = 0
                                            end
                                        )
                                    end
                                end

                                for _, descendant2 in descendant:GetDescendants() do
                                    hide(descendant2)
                                end

                                table.insert(v37, descendant.DescendantAdded:Connect(hide))
                            end
                        )
                    )
                end

                if const walls = workspace:FindFirstChild("Walls") then
                    table.insert(
                        v37,
                        walls.DescendantAdded:Connect(
                            function(descendant: Instance)
                                --[[
                                  line: 204
                                  upvalues:
                                    v33 (ref,  index: 1)
                                    v36 (copy, index: 2)
                                    v37 (copy, index: 3)
                                ]]
                                if not descendant:IsA("Model")
                                    or descendant:GetAttribute("OwnerId") ~= v33
                                    or v36 <= os.clock()
                                then
                                    return
                                end

                                local function hide(descendant: Instance)
                                    --[[
                                      name: hide
                                      line: 208
                                      upvalues:
                                        v36 (copy, index: 1)
                                    ]]
                                    if descendant:IsA("BasePart") then
                                        descendant.LocalTransparencyModifier = 1
                                        task.delay(
                                            math.max(0, v36 - os.clock()),
                                            function()
                                                --[[
                                                  line: 211
                                                  upvalues:
                                                    descendant (copy, index: 1)
                                                ]]
                                                descendant.LocalTransparencyModifier = 0
                                            end
                                        )
                                    end
                                end

                                for _, descendant2 in descendant:GetDescendants() do
                                    hide(descendant2)
                                end

                                table.insert(v37, descendant.DescendantAdded:Connect(hide))
                            end
                        )
                    )
                end

                task.delay(
                    0.6,
                    function()
                        --[[
                          line: 224
                          upvalues:
                            v37 (copy, index: 1)
                        ]]
                        for _, v58 in v37 do
                            v58:Disconnect()
                        end
                    end
                )

                if self.tuning.wall then
                    task.delay(0.2, Util.Recoil, -5.5, 0)
                end
            end

            task.delay(
                0.45,
                function()
                    --[[
                      line: 234
                      upvalues:
                        v32 (copy, index: 1)
                    ]]
                    if v32 then
                        v32:Stop(0.15)
                    end
                end
            )
        end

        return
    end

    local v59 = self.kind == "Horn"
    local hum = ctx.hum

    if not v59 then
        local health = hum.Health

        if hum.MaxHealth - 0.5 <= health then
            Util.Sound("Denied", ctx.root)
            Hud.Toast(denyText.FullHealth, Color3.fromRGB(255, 120, 90))

            return
        end
    end

    self.lastUse = timestamp
    self.using = true
    self.token += 1
    local token = self.token
    local useTime = self.tuning.useTime or 0.6
    ctx.send("Use", {on = true, tool = ctx.tool})
    ctx.emit("Use", {on = true, time = useTime})
    Util.PlayAnim(ctx.animator, self.preset.use, 1, 0.1)
    Util.Sound((self.preset.useSound or "Bandage_Wrap"), ctx.root)
    local useSpeedMult = self.tuning.useSpeedMult or 0.6
    local v65 = Util.ProbeValues()
    local v66 = ctx.setSpeed("Use", useSpeedMult)
    local v67 = v65 and v65.k * (useSpeedMult or 1)

    if v66 ~= v67 then
        Util.Hooked()
    end

    Hud.StartChannel((self.preset.label or "USING"), useTime, self.preset.color)

    task.delay(
        useTime,
        function()
            --[[
              line: 160
              upvalues:
                self (copy, index: 1)
                token (copy, index: 2)
                ctx (copy, index: 3)
                Util (copy, index: 4)
                Hud (copy, index: 5)
                v59 (copy, index: 6)
            ]]
            if self.token ~= token or not self.using then
                return
            end

            self.using = false
            ctx.emit("Use", {on = false, done = true})
            Util.StopAnim(ctx.animator, self.preset.use, 0.15)
            ctx.setSpeed("Use", nil)
            Hud.StopChannel()

            if v59 then
                return
            end

            Hud.Flash(Color3.fromRGB(110, 220, 110), 0.35, 0.4)

            task.delay(
                (self.tuning.healTime or 3),
                function()
                    --[[
                      line: 173
                      upvalues:
                        ctx (copy, index: 1)
                        Util (copy, index: 2)
                        self (copy, index: 3)
                    ]]
                    if ctx.alive() then
                        Util.Sound((self.preset.doneSound or "Heal_Done"), ctx.root)
                    end
                end
            )
        end
    )
end

function Class.Input(self, a69, a70)
    --[[
      name: Input
      line: 242
    ]]
    if a69 == "Primary" and a70 then
        self:Activate()
    end
end

function Class.Update(self, a72)
    --[[
      name: Update
      line: 248
    ]]
    if const ghost = self.ghost then
        local v74 = if 1 <= self.charges then self:TrapSpot() else nil
        local wall = self.tuning.wall

        if v74 and type(wall) == "table" then
            local unit
            local root = self.ctx.root
            local vector3 = Vector3.new(v74.X - root.Position.X, 0, v74.Z - root.Position.Z)

            if not (0.1 < vector3.Magnitude) then
                unit = Vector3.new(root.CFrame.LookVector.X, 0, root.CFrame.LookVector.Z).Unit
            else
                unit = vector3.Unit
            end

            ghost.CFrame = CFrame.lookAt(v74, v74 + unit) * CFrame.new(0, (wall.height or 5) / 2, 0)
            ghost.Color = Color3.fromRGB(214, 180, 130)
            ghost.Transparency = 0.7

            return
        end

        if v74 then
            ghost.CFrame = CFrame.new(v74 + Vector3.new(0, 0.05999999865889549, 0)) * CFrame.Angles(0, 0, 1.5707963267948966)
            ghost.Color = Color3.fromRGB(228, 232, 240)
            ghost.Transparency = 0.55

            return
        end

        ghost.Transparency = 1
    end
end

function Class.OnDenied(self, key)
    --[[
      name: OnDenied
      line: 272
      upvalues:
        Util (copy, index: 1)
        Hud (copy, index: 2)
        denyText (copy, index: 3)
    ]]
    if self.using then
        self.using = false
        self.token += 1
        self.ctx.emit("Use", {on = false})
        Util.StopAnim(self.ctx.animator, self.preset.use, 0.1)
        self.ctx.setSpeed("Use", nil)
        Hud.StopChannel()
    end

    if const v81 = if key == "BadSpot" and self.tuning.wall then denyText.BadWallSpot else denyText[key] then
        Hud.Toast(v81, Color3.fromRGB(255, 120, 90))
    end

    self:Sync()
end

function Class.Interrupt(self)
    --[[
      name: Interrupt
      line: 288
    ]]
    if self.using then
        self:Cancel()
    end
end

return Class