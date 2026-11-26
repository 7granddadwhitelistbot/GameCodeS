local CommonUtils = require(script.Parent.Parent:WaitForChild("CommonUtils"))
local v2 = CommonUtils.get("FlagUtil")
local ZoomController = require(script.Parent:WaitForChild("ZoomController"))
local userFlag = v2.getUserFlag("UserFixCameraFPError")
local Class = {}
Class.__index = Class
local identityCFrame = CFrame.new()

local function cframeToAxis(a8)
    --[[
      name: cframeToAxis
      line: 18
    ]]
    local v9, v10 = a8:ToAxisAngle()
    return v9 * v10
end

local function axisToCFrame(a12)
    --[[
      name: axisToCFrame
      line: 23
      upvalues:
        identityCFrame (copy, index: 1)
    ]]
    local magnitude = a12.Magnitude

    if 1e-05 < magnitude then
        return CFrame.fromAxisAngle(a12, magnitude)
    end

    return identityCFrame
end

local function extractRotation(a15)
    --[[
      name: extractRotation
      line: 31
    ]]
    local _, _, _, v19, v20, v21, v22, v23, v24, v25, v26, v27 = a15:GetComponents()
    return CFrame.new(0, 0, 0, v19, v20, v21, v22, v23, v24, v25, v26, v27)
end

function Class.new()
    --[[
      name: new
      line: 36
      upvalues:
        Class (copy, index: 1)
    ]]
    return (setmetatable({lastCFrame = nil}, Class))
end

function Class.Step(self, a29, lastCFrame)
    --[[
      name: Step
      line: 42
      upvalues:
        identityCFrame (copy, index: 1)
    ]]
    local v31 = self.lastCFrame or lastCFrame
    self.lastCFrame = lastCFrame
    local position = lastCFrame.Position
    local _, _, _, v36, v37, v38, v39, v40, v41, v42, v43, v44 = lastCFrame:GetComponents()
    local cframe = CFrame.new(0, 0, 0, v36, v37, v38, v39, v40, v41, v42, v43, v44)
    local position2 = v31.Position
    local _, _, _, v50, v51, v52, v53, v54, v55, v56, v57, v58 = v31:GetComponents()
    local cframe2 = CFrame.new(0, 0, 0, v50, v51, v52, v53, v54, v55, v56, v57, v58)
    local posVelocity = (position - position2) / a29
    local v61, v62 = (cframe * cframe2:inverse()):ToAxisAngle()
    local rotVelocity = v61 * v62 / a29

    return {
        extrapolate = (function(a64)
            --[[
              name: extrapolate
              line: 57
              upvalues:
                posVelocity (copy, index: 1)
                position (copy, index: 2)
                rotVelocity (copy, index: 3)
                identityCFrame (copy, index: 4)
                cframe (copy, index: 5)
            ]]
            local v65 = posVelocity * a64 + position
            local v66 = rotVelocity * a64
            local magnitude = v66.Magnitude
            local v68 = if 1e-05 < magnitude then CFrame.fromAxisAngle(v66, magnitude) else identityCFrame

            return (v68 * cframe) + v65
        end),
        posVelocity = posVelocity,
        rotVelocity = rotVelocity
    }
end

function Class.Reset(self)
    --[[
      name: Reset
      line: 70
    ]]
    self.lastCFrame = nil
end

local BaseOcclusion = require(script.Parent:WaitForChild("BaseOcclusion"))
local v71 = setmetatable({}, BaseOcclusion)
v71.__index = v71

function v71.new()
    --[[
      name: new
      line: 81
      upvalues:
        BaseOcclusion (copy, index: 1)
        v71 (copy, index: 2)
        Class (copy, index: 3)
    ]]
    local v72 = setmetatable(BaseOcclusion.new(), v71)
    v72.focusExtrapolator = Class.new()
    return v72
end

function v71.GetOcclusionMode(a73)
    --[[
      name: GetOcclusionMode
      line: 87
    ]]
    return Enum.DevCameraOcclusionMode.Zoom
end

function v71.Enable(a74, a75)
    --[[
      name: Enable
      line: 91
    ]]
    a74.focusExtrapolator:Reset()
end

function v71.Update(a76, a77, a78, a79)
    --[[
      name: Update
      line: 95
      upvalues:
        userFlag (copy, index: 1)
        ZoomController (copy, index: 2)
    ]]
    local v80 = if userFlag then CFrame.lookAlong(a79.Position, -a78.LookVector) * CFrame.new(0, 0, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1) else CFrame.new(a79.Position, a78.Position) * CFrame.new(0, 0, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1)
    local v81 = a76.focusExtrapolator:Step(a77, v80)
    local z = ZoomController.Update(a77, v80, v81)

    return v80 * CFrame.new(0, 0, z), a79
end

function v71.CharacterAdded(a83, a84, a85)
    --[[
      name: CharacterAdded
      line: 112
    ]]
end

function v71.CharacterRemoving(a86, a87, a88)
    --[[
      name: CharacterRemoving
      line: 116
    ]]
end

function v71.OnCameraSubjectChanged(a89, a90)
    --[[
      name: OnCameraSubjectChanged
      line: 118
    ]]
end

return v71