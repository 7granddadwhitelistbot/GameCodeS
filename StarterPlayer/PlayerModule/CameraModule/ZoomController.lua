local Popper_upv_1 = require(script:WaitForChild("Popper"))
local clamp_upv_1 = math.clamp
local exp_upv_1 = math.exp
local min_upv_1 = math.min
local max_upv_1 = math.max
local CameraMinZoomDistance_upv_1 = nil
local CameraMaxZoomDistance_upv_1 = nil
local LocalPlayer_upv_1 = game:GetService("Players").LocalPlayer
assert(LocalPlayer_upv_1)
local function updateBounds()
    --[[
      name: updateBounds
      line: 23
      upvalues:
        CameraMinZoomDistance_upv_1 (ref,  index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
        CameraMaxZoomDistance_upv_1 (ref,  index: 3)
    ]]
    CameraMinZoomDistance_upv_1 = LocalPlayer_upv_1.CameraMinZoomDistance
    CameraMaxZoomDistance_upv_1 = LocalPlayer_upv_1.CameraMaxZoomDistance
end
CameraMinZoomDistance_upv_1 = LocalPlayer_upv_1.CameraMinZoomDistance
CameraMaxZoomDistance_upv_1 = LocalPlayer_upv_1.CameraMaxZoomDistance
LocalPlayer_upv_1:GetPropertyChangedSignal("CameraMinZoomDistance"):Connect(updateBounds)
LocalPlayer_upv_1:GetPropertyChangedSignal("CameraMaxZoomDistance"):Connect(updateBounds)
local tbl_upv_1 = {}
tbl_upv_1.__index = tbl_upv_1
function tbl_upv_1.new(a1, a2, a3, a4)
    --[[
      name: new
      line: 37
      upvalues:
        clamp_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    a2 = clamp_upv_1(a2, a3, a4)
    return (setmetatable({v = 0, freq = a1, x = a2, minValue = a3, maxValue = a4, goal = a2}, tbl_upv_1))
end
function tbl_upv_1.Step(a1, a2)
    --[[
      name: Step
      line: 49
      upvalues:
        exp_upv_1 (copy, index: 1)
    ]]
    local v1 = a1.freq * 2 * math.pi
    local v_1 = a1.v
    local minValue_1 = a1.minValue
    local maxValue_1 = a1.maxValue
    local goal_1 = a1.goal
    local v2 = goal_1 - a1.x
    local v3 = v1 * a2
    local v4 = exp_upv_1(-v3)
    local v5 = goal_1 + ((v_1 * a2) - (v2 * (v3 + 1))) * v4
    local v6 = ((((v2 * v1) - v_1) * v3) + v_1) * v4
    if v5 < minValue_1 then
        v5, v6 = minValue_1, 0
    elseif maxValue_1 < v5 then
        v5, v6 = maxValue_1, 0
    end
    a1.x = v5
    a1.v = v6
    return v5
end
local u1 = tbl_upv_1.new(4.5, 12.5, 0.5, CameraMaxZoomDistance_upv_1)
local function stepTargetZoom(a1, a2, a3, a4)
    --[[
      name: stepTargetZoom
      line: 87
      upvalues:
        clamp_upv_1 (copy, index: 1)
    ]]
    local v7 = clamp_upv_1(a1 + (a2 * ((a1 * 0.0375) + 1)), a3, a4)
    if v7 < 1 then
        local v8 = a2 <= 0 and a3 or 1
        a1 = v8
    else
        a1 = v7
    end
    return a1
end
local u2 = 0
local tbl_2 = {}
function tbl_2.Update(a1, a2, a3)
    --[[
      name: Update
      line: 98
      upvalues:
        u1 (copy, index: 1)
        u2 (ref,  index: 2)
        CameraMinZoomDistance_upv_1 (ref,  index: 3)
        CameraMaxZoomDistance_upv_1 (ref,  index: 4)
        clamp_upv_1 (copy, index: 5)
        max_upv_1 (copy, index: 6)
        Popper_upv_1 (copy, index: 7)
        min_upv_1 (copy, index: 8)
    ]]
    local v9 = math.huge
    local v10 = nil
    if u1.goal > 1 then
        local x_1 = u1.x
        local v11 = u1.goal
        local v12 = u2
        local v13 = CameraMinZoomDistance_upv_1
        v10 = clamp_upv_1(u1.goal + u2 * (u1.goal * 0.0375 + 1), CameraMinZoomDistance_upv_1, CameraMaxZoomDistance_upv_1)
        if v10 < 1 then
            v11 = v12 <= 0 and v13 or 1
        else
            v11 = v10
        end
        local v15 = max_upv_1(x_1, v11)
        v9 = Popper_upv_1(a2 * CFrame.new(0, 0, 0.5), v15 - 0.5, a3) + 0.5
    end
    u1.minValue = 0.5
    u1.maxValue = min_upv_1(CameraMaxZoomDistance_upv_1, v9)
    return u1:Step(a1)
end
function tbl_2.GetZoomRadius()
    --[[
      name: GetZoomRadius
      line: 122
      upvalues:
        u1 (copy, index: 1)
    ]]
    return u1.x
end
function tbl_2.SetZoomParameters(a1, a2)
    --[[
      name: SetZoomParameters
      line: 126
      upvalues:
        u1 (copy, index: 1)
        u2 (ref,  index: 2)
    ]]
    u1.goal = a1
    u2 = a2
end
function tbl_2.ReleaseSpring()
    --[[
      name: ReleaseSpring
      line: 131
      upvalues:
        u1 (copy, index: 1)
    ]]
    u1.x = u1.goal
    u1.v = 0
end
return tbl_2