local CameraInput_upv_1 = require(script.Parent:WaitForChild("CameraInput"))
local CameraUI_upv_1 = require(script.Parent:WaitForChild("CameraUI"))
local CameraUtils_upv_1 = require(script.Parent:WaitForChild("CameraUtils"))
local u1 = false
local u2 = tick()
local u3 = false
local u4 = false
local u5 = false
CameraUI_upv_1.setCameraModeToastEnabled(false)
local v1 = function(a1)
    --[[
      line: 16
      upvalues:
        CameraInput_upv_1 (copy, index: 1)
        u1 (ref,  index: 2)
        u3 (ref,  index: 3)
        u2 (ref,  index: 4)
        CameraUI_upv_1 (copy, index: 5)
        u5 (ref,  index: 6)
        u4 (ref,  index: 7)
        CameraUtils_upv_1 (copy, index: 8)
    ]]
    local v2 = CameraInput_upv_1.getTogglePan()
    if a1 and v2 ~= u1 then
        u3 = true
    end
    if u1 ~= v2 or tick() - u2 > 3 then
        local v3 = v2 and tick() - u2 < 3
        CameraUI_upv_1.setCameraModeToastOpen(v3)
        if v2 then
            u3 = false
        end
        u2 = tick()
        u1 = v2
    end
    if a1 ~= u5 then
        if a1 then
            u4 = CameraInput_upv_1.getTogglePan()
            CameraInput_upv_1.setTogglePan(true)
        elseif not (u3) then
            CameraInput_upv_1.setTogglePan(u4)
        end
    end
    if a1 then
        if CameraInput_upv_1.getTogglePan() then
            CameraUtils_upv_1.setMouseIconOverride("rbxasset://textures/Cursors/CrossMouseIcon.png")
            CameraUtils_upv_1.setMouseBehaviorOverride(Enum.MouseBehavior.LockCenter)
        else
            CameraUtils_upv_1.restoreMouseIcon()
            CameraUtils_upv_1.restoreMouseBehavior()
        end
        CameraUtils_upv_1.setRotationTypeOverride(Enum.RotationType.CameraRelative)
    elseif CameraInput_upv_1.getTogglePan() then
        CameraUtils_upv_1.setMouseIconOverride("rbxasset://textures/Cursors/CrossMouseIcon.png")
        CameraUtils_upv_1.setMouseBehaviorOverride(Enum.MouseBehavior.LockCenter)
        CameraUtils_upv_1.setRotationTypeOverride(Enum.RotationType.MovementRelative)
    elseif CameraInput_upv_1.getHoldPan() then
        CameraUtils_upv_1.restoreMouseIcon()
        CameraUtils_upv_1.setMouseBehaviorOverride(Enum.MouseBehavior.LockCurrentPosition)
        CameraUtils_upv_1.setRotationTypeOverride(Enum.RotationType.MovementRelative)
    else
        CameraUtils_upv_1.restoreMouseIcon()
        CameraUtils_upv_1.restoreMouseBehavior()
        CameraUtils_upv_1.restoreRotationType()
    end
    u5 = a1
end
return v1