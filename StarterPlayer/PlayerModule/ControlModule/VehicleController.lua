local VehicleContext_upv_1 = script.Parent.Parent:WaitForChild("InputContexts"):WaitForChild("VehicleContext")
local ThrottleAction_upv_1 = VehicleContext_upv_1:WaitForChild("ThrottleAction")
local SteerAction_upv_1 = VehicleContext_upv_1:WaitForChild("SteerAction")
local _ = require(script.Parent.Parent:WaitForChild("CommonUtils")).get("FlagUtil")
local tbl_upv_1 = {}
tbl_upv_1.__index = tbl_upv_1
function tbl_upv_1.new()
    --[[
      name: new
      line: 23
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v1 = setmetatable({}, tbl_upv_1)
    v1.enabled = false
    v1.vehicleSeat = nil
    return v1
end
function tbl_upv_1.Enable(a1, a2, a3)
    --[[
      name: Enable
      line: 32
      upvalues:
        VehicleContext_upv_1 (copy, index: 1)
    ]]
    if a2 ~= a1.enabled or a3 ~= a1.vehicleSeat then
        a1.enabled = a2
        if a2 then
            if not a3 then
                return
            end
            a1.vehicleSeat = a3
            VehicleContext_upv_1.Enabled = true
        else
            VehicleContext_upv_1.Enabled = false
            a1.vehicleSeat = nil
        end
    end
end
function tbl_upv_1.Update(a1, a2, a3)
    --[[
      name: Update
      line: 53
      upvalues:
        ThrottleAction_upv_1 (copy, index: 1)
        SteerAction_upv_1 (copy, index: 2)
    ]]
    if a1.vehicleSeat then
        if a3 then
            local v2 = ThrottleAction_upv_1:GetState()
            a2 = a2 + Vector3.new(SteerAction_upv_1:GetState(), 0, -v2)
            a1.vehicleSeat.ThrottleFloat = -a2.Z
            a1.vehicleSeat.SteerFloat = a2.X
            return a2, true
        else
            local v3 = a1.vehicleSeat.Occupant.RootPart.CFrame:VectorToObjectSpace(a2)
            a1.vehicleSeat.ThrottleFloat = a1:ComputeThrottle(v3)
            a1.vehicleSeat.SteerFloat = a1:ComputeSteer(v3)
            return Vector3.new(0, 0, 0), true
        end
    else
        return a2, false
    end
end
function tbl_upv_1.ComputeThrottle(a1, a2)
    --[[
      name: ComputeThrottle
      line: 80
    ]]
    if a2 == Vector3.new(0, 0, 0) then
        return 0
    end
    return -a2.Z
end
function tbl_upv_1.ComputeSteer(a1, a2)
    --[[
      name: ComputeSteer
      line: 88
    ]]
    if a2 == Vector3.new(0, 0, 0) then
        return 0
    end
    return -math.atan2(-a2.x, -a2.z) * 57.29577951308232
end
return tbl_upv_1