local v1 = require(script.Parent.Parent:WaitForChild("CommonUtils")).get("FlagUtil")
local ZoomController_upv_1 = require(script.Parent:WaitForChild("ZoomController"))
local u1 = v1.getUserFlag("UserFixCameraFPError")
local tbl_upv_1 = {}
tbl_upv_1.__index = tbl_upv_1
local u2 = CFrame.new()
local function cframeToAxis(a1)
    --[[
      name: cframeToAxis
      line: 17
    ]]
    local v2, v3 = a1:ToAxisAngle()
    return v2 * v3
end
local function axisToCFrame(a1)
    --[[
      name: axisToCFrame
      line: 22
      upvalues:
        u2 (copy, index: 1)
    ]]
    local Magnitude_1 = a1.Magnitude
    if Magnitude_1 > 1e-05 then
        return CFrame.fromAxisAngle(a1, Magnitude_1)
    end
    return u2
end
local function extractRotation(a1)
    --[[
      name: extractRotation
      line: 30
    ]]
    local _, v13, v14, v4, v5, v6, v7, v8, v9, v10, v11, v12 = a1:GetComponents()
    return CFrame.new(0, 0, 0, v4, v5, v6, v7, v8, v9, v10, v11, v12)
end
function tbl_upv_1.new()
    --[[
      name: new
      line: 35
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    return (setmetatable({}, tbl_upv_1))
end
function tbl_upv_1.Step(a1, a2, a3)
    --[[
      name: Step
      line: 41
      upvalues:
        u2 (copy, index: 1)
    ]]
    local v13 = a1.lastCFrame or a3
    a1.lastCFrame = a3
    local Position_upv_1 = a3.Position
    local _, v34, v35, v14, v15, v16, v17, v18, v19, v20, v21, v22 = a3:GetComponents()
    local u3 = CFrame.new(0, 0, 0, v14, v15, v16, v17, v18, v19, v20, v21, v22)
    local Position_2 = v13.Position
    local v36, v37, v38, v23, v24, v25, v26, v27, v28, v29, v30, v31 = v13:GetComponents()
    local u4 = (Position_upv_1 - Position_2) / a2
    local v32, v33 = (u3 * CFrame.new(0, 0, 0, v23, v24, v25, v26, v27, v28, v29, v30, v31):inverse()):ToAxisAngle()
    local u5 = v32 * v33 / a2
    local tbl_2 = {}
    function tbl_2.extrapolate(a4)
        --[[
          name: extrapolate
          line: 56
          upvalues:
            u4 (copy, index: 1)
            Position_upv_1 (copy, index: 2)
            u5 (copy, index: 3)
            u2 (copy, index: 4)
            u3 (copy, index: 5)
        ]]
        local v34 = u4 * a4 + Position_upv_1
        local v35 = u5 * a4
        local Magnitude_2 = v35.Magnitude
        local v36
        if Magnitude_2 > 1e-05 then
            v36 = CFrame.fromAxisAngle(v35, Magnitude_2)
        else
            v36 = u2
        end
        return (v36 * u3) + v34
    end
    tbl_2.posVelocity = u4
    tbl_2.rotVelocity = u5
    return tbl_2
end
function tbl_upv_1.Reset(a1)
    --[[
      name: Reset
      line: 69
    ]]
    a1.lastCFrame = nil
end
local BaseOcclusion_upv_1 = require(script.Parent:WaitForChild("BaseOcclusion"))
local u6 = setmetatable({}, BaseOcclusion_upv_1)
u6.__index = u6
function u6.new()
    --[[
      name: new
      line: 79
      upvalues:
        BaseOcclusion_upv_1 (copy, index: 1)
        u6 (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
    ]]
    local v37 = setmetatable(BaseOcclusion_upv_1.new(), u6)
    v37.focusExtrapolator = tbl_upv_1.new()
    return v37
end
function u6.GetOcclusionMode(a1)
    --[[
      name: GetOcclusionMode
      line: 85
    ]]
    return Enum.DevCameraOcclusionMode.Zoom
end
function u6.Enable(a1, a2)
    --[[
      name: Enable
      line: 89
    ]]
    a1.focusExtrapolator:Reset()
end
function u6.Update(a1, a2, a3, a4, a5)
    --[[
      name: Update
      line: 93
      upvalues:
        u1 (copy, index: 1)
        ZoomController_upv_1 (copy, index: 2)
    ]]
    local v38 = (u1 and (CFrame.lookAlong(a4.Position, -a3.LookVector) * CFrame.new(0, 0, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1))) or (CFrame.new(a4.Position, a3.Position) * CFrame.new(0, 0, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1))
    return v38 * CFrame.new(0, 0, ZoomController_upv_1.Update(a2, v38, a1.focusExtrapolator:Step(a2, v38))), a4
end
function u6.CharacterAdded(a1, a2, a3)
    --[[
      name: CharacterAdded
      line: 117
    ]]
end
function u6.CharacterRemoving(a1, a2, a3)
    --[[
      name: CharacterRemoving
      line: 121
    ]]
end
function u6.OnCameraSubjectChanged(a1, a2)
    --[[
      name: OnCameraSubjectChanged
      line: 124
    ]]
end
return u6