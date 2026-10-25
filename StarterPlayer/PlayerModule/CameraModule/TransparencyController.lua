local VRService_upv_1 = game:GetService("VRService")
local tbl_upv_1 = {"BasePart", "Decal", "Beam", "ParticleEmitter", "Trail", "Fire", "Smoke", "Sparkles", "Explosion"}
local CameraUtils_upv_1 = require(script.Parent:WaitForChild("CameraUtils"))
local tbl_upv_2 = {}
tbl_upv_2.__index = tbl_upv_2
function tbl_upv_2.new()
    --[[
      name: new
      line: 29
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    local v1 = setmetatable({}, tbl_upv_2)
    v1.transparencyDirty = false
    v1.enabled = false
    v1.lastTransparency = nil
    v1.descendantAddedConn = nil
    v1.descendantRemovingConn = nil
    v1.toolDescendantAddedConns = {}
    v1.toolDescendantRemovingConns = {}
    v1.cachedParts = {}
    return v1
end
function tbl_upv_2.HasToolAncestor(a1, a2)
    --[[
      name: HasToolAncestor
      line: 45
    ]]
    if a2.Parent == nil then
        return false
    end
    assert(a2.Parent, "")
    local v2 = a2.Parent:IsA("Tool") or (a1:HasToolAncestor(a2.Parent))
    return v2
end
function tbl_upv_2.IsValidPartToModify(a1, a2)
    --[[
      name: IsValidPartToModify
      line: 51
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    for _, value_1 in tbl_upv_1 do
        if not (a2:IsA(value_1)) then
            continue
        end
        return not a1:HasToolAncestor(a2)
    end
    return false
end
function tbl_upv_2.CachePartsRecursive(a1, a2)
    --[[
      name: CachePartsRecursive
      line: 61
    ]]
    if not a2 then
        return
    end
    if a1:IsValidPartToModify(a2) then
        a1.cachedParts[a2] = true
        a1.transparencyDirty = true
    end
    for _, value_2 in pairs(a2:GetChildren()) do
        a1:CachePartsRecursive(value_2)
    end
end
function tbl_upv_2.TeardownTransparency(a1)
    --[[
      name: TeardownTransparency
      line: 73
    ]]
    for key_1, _ in pairs(a1.cachedParts) do
        key_1.LocalTransparencyModifier = 0
    end
    a1.cachedParts = {}
    a1.transparencyDirty = true
    a1.lastTransparency = nil
    if a1.descendantAddedConn then
        a1.descendantAddedConn:disconnect()
        a1.descendantAddedConn = nil
    end
    if a1.descendantRemovingConn then
        a1.descendantRemovingConn:disconnect()
        a1.descendantRemovingConn = nil
    end
    for key_2, value_3 in pairs(a1.toolDescendantAddedConns) do
        value_3:Disconnect()
        a1.toolDescendantAddedConns[key_2] = nil
    end
    for key_3, value_4 in pairs(a1.toolDescendantRemovingConns) do
        value_4:Disconnect()
        a1.toolDescendantRemovingConns[key_3] = nil
    end
end
function tbl_upv_2.SetupTransparency(a1, a2)
    --[[
      name: SetupTransparency
      line: 99
    ]]
    a1:TeardownTransparency()
    if a1.descendantAddedConn then
        a1.descendantAddedConn:disconnect()
    end
    a1.descendantAddedConn = a2.DescendantAdded:Connect(
        function(a3)
            --[[
              line: 103
              upvalues:
                a1 (copy, index: 1)
                a2 (copy, index: 2)
            ]]
            if a1:IsValidPartToModify(a3) then
                a1.cachedParts[a3] = true
                a1.transparencyDirty = true
            elseif a3:IsA("Tool") then
                if a1.toolDescendantAddedConns[a3] then
                    a1.toolDescendantAddedConns[a3]:Disconnect()
                end
                a1.toolDescendantAddedConns[a3] = a3.DescendantAdded:Connect(
                    function(a4)
                        --[[
                          line: 111
                          upvalues:
                            a1 (copy, index: 1)
                        ]]
                        a1.cachedParts[a4] = nil
                        if not a4:IsA("BasePart") and not a4:IsA("Decal") then
                            return
                        end
                        a4.LocalTransparencyModifier = 0
                    end
                )
                if a1.toolDescendantRemovingConns[a3] then
                    a1.toolDescendantRemovingConns[a3]:disconnect()
                end
                a1.toolDescendantRemovingConns[a3] = a3.DescendantRemoving:Connect(
                    function(a5)
                        --[[
                          line: 119
                          upvalues:
                            a2 (copy, index: 1)
                            a1 (copy, index: 2)
                        ]]
                        wait()
                        if not a2 or not a5 or not a5:IsDescendantOf(a2) or not a1:IsValidPartToModify(a5) then
                            return
                        end
                        a1.cachedParts[a5] = true
                        a1.transparencyDirty = true
                    end
                )
            end
        end
    )
    if a1.descendantRemovingConn then
        a1.descendantRemovingConn:disconnect()
    end
    a1.descendantRemovingConn = a2.DescendantRemoving:connect(
        function(a6)
            --[[
              line: 131
              upvalues:
                a1 (copy, index: 1)
            ]]
            if not a1.cachedParts[a6] then
                return
            end
            a1.cachedParts[a6] = nil
            a6.LocalTransparencyModifier = 0
        end
    )
    a1:CachePartsRecursive(a2)
end
function tbl_upv_2.Enable(a1, a2)
    --[[
      name: Enable
      line: 142
    ]]
    if a1.enabled == a2 then
        return
    end
    a1.enabled = a2
end
function tbl_upv_2.SetSubject(a1, a2)
    --[[
      name: SetSubject
      line: 148
    ]]
    if a2 then
        local _ = (not a2:IsA("Humanoid")) or (a2.Parent)
    end
    local v3 = (not a2) or ((not a2:IsA("VehicleSeat")) or ((not (a2.Occupant)) or (a2.Occupant.Parent)))
    if v3 then
        a1:SetupTransparency(v3)
    else
        a1:TeardownTransparency()
    end
end
function tbl_upv_2.Update(a1, a2)
    --[[
      name: Update
      line: 163
      upvalues:
        CameraUtils_upv_1 (copy, index: 1)
        VRService_upv_1 (copy, index: 2)
    ]]
    local CurrentCamera_1 = workspace.CurrentCamera
    if not CurrentCamera_1 then
        return
    end
    if a1.enabled then
        local magnitude_1 = (CurrentCamera_1.Focus.Position - CurrentCamera_1.CoordinateFrame.Position).magnitude
        local v4 = ((magnitude_1 < 2) and (1 - (magnitude_1 - 0.5) / 1.5)) or 0
        if v4 < 0.5 then
            v4 = 0
        end
        if a1.lastTransparency and v4 < 1 and a1.lastTransparency < 0.95 then
            local _ = 2.8 * a2
            v4 = a1.lastTransparency + math.clamp(v4 - a1.lastTransparency, -(2.8 * a2), 2.8 * a2)
        else
            a1.transparencyDirty = true
        end
        local v5 = math.clamp(CameraUtils_upv_1.Round(v4, 2), 0, 1)
        if a1.transparencyDirty or a1.lastTransparency ~= v5 then
            for key_4, _ in pairs(a1.cachedParts) do
                if not (VRService_upv_1.VREnabled) or not (VRService_upv_1.AvatarGestures) then
                    key_4.LocalTransparencyModifier = v5
                    continue
                end
                local tbl_3 = {}
                tbl_3[Enum.AccessoryType.Hat] = true
                tbl_3[Enum.AccessoryType.Hair] = true
                tbl_3[Enum.AccessoryType.Face] = true
                tbl_3[Enum.AccessoryType.Eyebrow] = true
                tbl_3[Enum.AccessoryType.Eyelash] = true
                if key_4.Parent:IsA("Accessory") and tbl_3[key_4.Parent.AccessoryType] or key_4.Name == "Head" then
                    key_4.LocalTransparencyModifier = v5
                    continue
                end
                key_4.LocalTransparencyModifier = 0
            end
            a1.transparencyDirty = false
            a1.lastTransparency = v5
        end
    end
end
return tbl_upv_2