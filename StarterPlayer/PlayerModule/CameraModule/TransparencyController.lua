local vrService = game:GetService("VRService")
local v2 = {"BasePart", "Decal", "Beam", "ParticleEmitter", "Trail", "Fire", "Smoke", "Sparkles", "Explosion"}
local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"))
local Class = {}
Class.__index = Class

function Class.new()
    --[[
      name: new
      line: 30
      upvalues:
        Class (copy, index: 1)
    ]]
    local v5 = setmetatable({}, Class)
    v5.transparencyDirty = false
    v5.enabled = false
    v5.lastTransparency = nil
    v5.descendantAddedConn = nil
    v5.descendantRemovingConn = nil
    v5.toolDescendantAddedConns = {}
    v5.toolDescendantRemovingConns = {}
    v5.cachedParts = {}
    return v5
end

function Class.HasToolAncestor(self, a7)
    --[[
      name: HasToolAncestor
      line: 45
    ]]
    if a7.Parent == nil then
        return false
    end

    assert(a7.Parent, "")

    return a7.Parent:IsA("Tool") or self:HasToolAncestor(a7.Parent)
end

function Class.IsValidPartToModify(self, a9)
    --[[
      name: IsValidPartToModify
      line: 53
      upvalues:
        v2 (copy, index: 1)
    ]]
    for _, v11 in v2 do
        if a9:IsA(v11) then
            return not self:HasToolAncestor(a9)
        end
    end

    return false
end

function Class.CachePartsRecursive(self, cachedPartKey)
    --[[
      name: CachePartsRecursive
      line: 62
    ]]
    if cachedPartKey then
        if self:IsValidPartToModify(cachedPartKey) then
            self.cachedParts[cachedPartKey] = true
            self.transparencyDirty = true
        end

        for _, child in pairs(cachedPartKey:GetChildren()) do
            self:CachePartsRecursive(child)
        end
    end
end

function Class.TeardownTransparency(self)
    --[[
      name: TeardownTransparency
      line: 74
    ]]
    for key, _ in pairs(self.cachedParts) do
        key.LocalTransparencyModifier = 0
    end

    self.cachedParts = {}
    self.transparencyDirty = true
    self.lastTransparency = nil

    if self.descendantAddedConn then
        self.descendantAddedConn:disconnect()
        self.descendantAddedConn = nil
    end

    if self.descendantRemovingConn then
        self.descendantRemovingConn:disconnect()
        self.descendantRemovingConn = nil
    end

    for toolDescendantAddedConnKey, toolDescendantAddedConn in pairs(self.toolDescendantAddedConns) do
        toolDescendantAddedConn:Disconnect()
        self.toolDescendantAddedConns[toolDescendantAddedConnKey] = nil
    end

    for toolDescendantRemovingConnKey, toolDescendantRemovingConn in pairs(self.toolDescendantRemovingConns) do
        toolDescendantRemovingConn:Disconnect()
        self.toolDescendantRemovingConns[toolDescendantRemovingConnKey] = nil
    end
end

function Class.SetupTransparency(self, a24)
    --[[
      name: SetupTransparency
      line: 100
    ]]
    self:TeardownTransparency()

    if self.descendantAddedConn then
        self.descendantAddedConn:disconnect()
    end

    self.descendantAddedConn = a24.DescendantAdded:Connect(
        function(a25)
            --[[
              line: 106
              upvalues:
                self (copy, index: 1)
                a24 (copy, index: 2)
            ]]
            if self:IsValidPartToModify(a25) then
                self.cachedParts[a25] = true
                self.transparencyDirty = true

                return
            end

            if a25:IsA("Tool") then
                if self.toolDescendantAddedConns[a25] then
                    self.toolDescendantAddedConns[a25]:Disconnect()
                end

                self.toolDescendantAddedConns[a25] = a25.DescendantAdded:Connect(
                    function(cachedPartKey)
                        --[[
                          line: 116
                          upvalues:
                            self (copy, index: 1)
                        ]]
                        self.cachedParts[cachedPartKey] = nil

                        if cachedPartKey:IsA("BasePart") or cachedPartKey:IsA("Decal") then
                            cachedPartKey.LocalTransparencyModifier = 0
                        end
                    end
                )

                if self.toolDescendantRemovingConns[a25] then
                    self.toolDescendantRemovingConns[a25]:disconnect()
                end

                self.toolDescendantRemovingConns[a25] = a25.DescendantRemoving:Connect(
                    function(cachedPartKey)
                        --[[
                          line: 126
                          upvalues:
                            a24 (copy, index: 1)
                            self (copy, index: 2)
                        ]]
                        wait()

                        if a24
                            and cachedPartKey
                            and cachedPartKey:IsDescendantOf(a24)
                            and self:IsValidPartToModify(cachedPartKey)
                        then
                            self.cachedParts[cachedPartKey] = true
                            self.transparencyDirty = true
                        end
                    end
                )
            end
        end
    )

    if self.descendantRemovingConn then
        self.descendantRemovingConn:disconnect()
    end

    self.descendantRemovingConn = a24.DescendantRemoving:connect(
        function(cachedPartKey)
            --[[
              line: 140
              upvalues:
                self (copy, index: 1)
            ]]
            if self.cachedParts[cachedPartKey] then
                self.cachedParts[cachedPartKey] = nil
                cachedPartKey.LocalTransparencyModifier = 0
            end
        end
    )

    self:CachePartsRecursive(a24)
end

function Class.Enable(self, enabled)
    --[[
      name: Enable
      line: 150
    ]]
    if self.enabled ~= enabled then
        self.enabled = enabled
    end
end

function Class.SetSubject(self, subject)
    --[[
      name: SetSubject
      line: 156
    ]]
    local parent = nil

    if subject and subject:IsA("Humanoid") then
        parent = subject.Parent
    end

    if subject and subject:IsA("VehicleSeat") and subject.Occupant then
        parent = subject.Occupant.Parent
    end

    if parent then
        self:SetupTransparency(parent)
        return
    end

    self:TeardownTransparency()
end

function Class.Update(self, a35)
    --[[
      name: Update
      line: 171
      upvalues:
        CameraUtils (copy, index: 1)
        vrService (copy, index: 2)
    ]]
    local camera = workspace.CurrentCamera

    if camera and self.enabled then
        local magnitude = (camera.Focus.Position - camera.CoordinateFrame.Position).magnitude
        local v38 = magnitude < 2 and 1 - (magnitude - 0.5) / 1.5 or 0

        if v38 < 0.5 then
            v38 = 0
        end

        if not self.lastTransparency or not (v38 < 1) or not (self.lastTransparency < 0.95) then
            self.transparencyDirty = true
        else
            local v39 = v38 - self.lastTransparency
            local maxValue = 2.8 * a35
            local clampedValue = math.clamp(v39, -maxValue, maxValue)
            v38 = self.lastTransparency + clampedValue
        end

        local clampedValue = math.clamp(CameraUtils.Round(v38, 2), 0, 1)

        if self.transparencyDirty or self.lastTransparency ~= clampedValue then
            for key, _ in pairs(self.cachedParts) do
                if not vrService.VREnabled or not vrService.AvatarGestures then
                    key.LocalTransparencyModifier = clampedValue
                else
                    local v45 = {}
                    v45[Enum.AccessoryType.Hat] = true
                    v45[Enum.AccessoryType.Hair] = true
                    v45[Enum.AccessoryType.Face] = true
                    v45[Enum.AccessoryType.Eyebrow] = true
                    v45[Enum.AccessoryType.Eyelash] = true

                    if key.Parent:IsA("Accessory") and v45[key.Parent.AccessoryType] or key.Name == "Head" then
                        key.LocalTransparencyModifier = clampedValue
                    else
                        key.LocalTransparencyModifier = 0
                    end
                end
            end

            self.transparencyDirty = false
            self.lastTransparency = clampedValue
        end
    end
end

return Class