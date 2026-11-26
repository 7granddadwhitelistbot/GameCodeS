local CameraInput = require(script.Parent:WaitForChild("CameraInput"))
local CameraUI = require(script.Parent:WaitForChild("CameraUI"))
local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"))
local togglePan = false
local time = tick()
local v6 = false
local togglePan2 = false
local v8 = false
CameraUI.setCameraModeToastEnabled(false)

return function(a9)
    --[[
      line: 16
      upvalues:
        CameraInput (copy, index: 1)
        togglePan (ref,  index: 2)
        v6 (ref,  index: 3)
        time (ref,  index: 4)
        CameraUI (copy, index: 5)
        v8 (ref,  index: 6)
        togglePan2 (ref,  index: 7)
        CameraUtils (copy, index: 8)
    ]]
    local togglePan3 = CameraInput.getTogglePan()

    if a9 and togglePan3 ~= togglePan then
        v6 = true
    end

    if togglePan ~= togglePan3 or 3 < tick() - time then
        local v11 = togglePan3 and tick() - time < 3
        CameraUI.setCameraModeToastOpen(v11)

        if togglePan3 then
            v6 = false
        end

        time = tick()
        togglePan = togglePan3
    end

    if a9 ~= v8 then
        if a9 then
            togglePan2 = CameraInput.getTogglePan()
            CameraInput.setTogglePan(true)
        elseif not v6 then
            CameraInput.setTogglePan(togglePan2)
        end
    end

    if a9 then
        if CameraInput.getTogglePan() then
            CameraUtils.setMouseIconOverride("rbxasset://textures/Cursors/CrossMouseIcon.png")
            CameraUtils.setMouseBehaviorOverride(Enum.MouseBehavior.LockCenter)
            CameraUtils.setRotationTypeOverride(Enum.RotationType.CameraRelative)
        else
            CameraUtils.restoreMouseIcon()
            CameraUtils.restoreMouseBehavior()
            CameraUtils.setRotationTypeOverride(Enum.RotationType.CameraRelative)
        end
    elseif CameraInput.getTogglePan() then
        CameraUtils.setMouseIconOverride("rbxasset://textures/Cursors/CrossMouseIcon.png")
        CameraUtils.setMouseBehaviorOverride(Enum.MouseBehavior.LockCenter)
        CameraUtils.setRotationTypeOverride(Enum.RotationType.MovementRelative)
    elseif CameraInput.getHoldPan() then
        CameraUtils.restoreMouseIcon()
        CameraUtils.setMouseBehaviorOverride(Enum.MouseBehavior.LockCurrentPosition)
        CameraUtils.setRotationTypeOverride(Enum.RotationType.MovementRelative)
    else
        CameraUtils.restoreMouseIcon()
        CameraUtils.restoreMouseBehavior()
        CameraUtils.restoreRotationType()
    end

    v8 = a9
end