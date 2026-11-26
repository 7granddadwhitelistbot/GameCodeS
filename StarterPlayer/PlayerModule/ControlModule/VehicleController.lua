local inputContexts = script.Parent.Parent:WaitForChild("InputContexts")
local vehicleContext = inputContexts:WaitForChild("VehicleContext")
local throttleAction = vehicleContext:WaitForChild("ThrottleAction")
local steerAction = vehicleContext:WaitForChild("SteerAction")
local CommonUtils = require(script.Parent.Parent:WaitForChild("CommonUtils"))
CommonUtils.get("FlagUtil")
local Class = {}
Class.__index = Class

function Class.new()
    --[[
      name: new
      line: 23
      upvalues:
        Class (copy, index: 1)
    ]]
    local v7 = setmetatable({}, Class)
    v7.enabled = false
    v7.vehicleSeat = nil
    return v7
end

function Class.Enable(self, enabled, vehicleSeat)
    --[[
      name: Enable
      line: 32
      upvalues:
        vehicleContext (copy, index: 1)
    ]]
    if enabled == self.enabled and vehicleSeat == self.vehicleSeat then
        return
    end

    self.enabled = enabled

    if not enabled then
        vehicleContext.Enabled = false
        self.vehicleSeat = nil

        return
    end

    if not vehicleSeat then
        return
    end

    self.vehicleSeat = vehicleSeat
    vehicleContext.Enabled = true
end

function Class.Update(self, a12, a13)
    --[[
      name: Update
      line: 53
      upvalues:
        throttleAction (copy, index: 1)
        steerAction (copy, index: 2)
    ]]
    if not self.vehicleSeat then
        return a12, false
    end

    if a13 then
        local state = throttleAction:GetState()
        a12 += Vector3.new(steerAction:GetState(), 0, -state)
        self.vehicleSeat.ThrottleFloat = -a12.Z
        self.vehicleSeat.SteerFloat = a12.X

        return a12, true
    end

    local objectSpaceVector = self.vehicleSeat.Occupant.RootPart.CFrame:VectorToObjectSpace(a12)
    self.vehicleSeat.ThrottleFloat = self:ComputeThrottle(objectSpaceVector)
    self.vehicleSeat.SteerFloat = self:ComputeSteer(objectSpaceVector)

    return Vector3.new(0, 0, 0), true
end

function Class.ComputeThrottle(self, a17)
    --[[
      name: ComputeThrottle
      line: 80
    ]]
    if a17 ~= Vector3.new(0, 0, 0) then
        return -a17.Z
    end

    return 0
end

function Class.ComputeSteer(self, a19)
    --[[
      name: ComputeSteer
      line: 88
    ]]
    if a19 ~= Vector3.new(0, 0, 0) then
        return -math.atan2(-a19.x, -a19.z) * 57.29577951308232
    end

    return 0
end

return Class