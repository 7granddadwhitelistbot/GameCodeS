local v1 = require(script.Parent.Parent:WaitForChild("CommonUtils")).get("FlagUtil")
local MouseLockSwitchAction_upv_1 = script.Parent.Parent:WaitForChild("InputContexts"):WaitForChild("CameraContext"):WaitForChild("MouseLockSwitchAction")
local Players_upv_1 = game:GetService("Players")
local UserInputService_upv_1 = game:GetService("UserInputService")
local GameSettings_upv_1 = UserSettings().GameSettings
local CameraUtils_upv_1 = require(script.Parent:WaitForChild("CameraUtils"))
local u1 = v1.getUserFlag("UserFixStuckShiftLock")
local tbl_upv_1 = {}
tbl_upv_1.__index = tbl_upv_1
function tbl_upv_1.new()
    --[[
      name: new
      line: 33
      upvalues:
        tbl_upv_1 (copy, index: 1)
        GameSettings_upv_1 (copy, index: 2)
        Players_upv_1 (copy, index: 3)
        UserInputService_upv_1 (copy, index: 4)
        MouseLockSwitchAction_upv_1 (copy, index: 5)
    ]]
    local u2 = setmetatable({}, tbl_upv_1)
    u2.isMouseLocked = false
    u2.savedMouseCursor = nil
    u2.enabled = false
    u2.mouseLockToggledEvent = Instance.new("BindableEvent")
    GameSettings_upv_1.Changed:Connect(
        function(a1)
            --[[
              line: 43
              upvalues:
                u2 (copy, index: 1)
            ]]
            if a1 ~= "ControlMode" and a1 ~= "ComputerMovementMode" then
                return
            end
            u2:UpdateMouseLockAvailability()
        end
    )
    Players_upv_1.LocalPlayer:GetPropertyChangedSignal("DevEnableMouseLock"):Connect(
        function()
            --[[
              line: 50
              upvalues:
                u2 (copy, index: 1)
            ]]
            u2:UpdateMouseLockAvailability()
        end
    )
    Players_upv_1.LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode"):Connect(
        function()
            --[[
              line: 55
              upvalues:
                u2 (copy, index: 1)
            ]]
            u2:UpdateMouseLockAvailability()
        end
    )
    UserInputService_upv_1:GetPropertyChangedSignal("PreferredInput"):Connect(
        function()
            --[[
              line: 59
              upvalues:
                u2 (copy, index: 1)
            ]]
            u2:UpdateMouseLockAvailability()
        end
    )
    u2:UpdateMouseLockAvailability()
    MouseLockSwitchAction_upv_1.Pressed:Connect(
        function()
            --[[
              line: 65
              upvalues:
                u2 (copy, index: 1)
            ]]
            u2:OnMouseLockToggled()
        end
    )
    return u2
end
function tbl_upv_1.GetIsMouseLocked(a1)
    --[[
      name: GetIsMouseLocked
      line: 72
    ]]
    return a1.isMouseLocked
end
function tbl_upv_1.GetBindableToggleEvent(a1)
    --[[
      name: GetBindableToggleEvent
      line: 76
    ]]
    return a1.mouseLockToggledEvent.Event
end
function tbl_upv_1.GetMouseLockOffset(a1)
    --[[
      name: GetMouseLockOffset
      line: 80
    ]]
    return Vector3.new(1.75, 0, 0)
end
function tbl_upv_1.UpdateMouseLockAvailability(a1)
    --[[
      name: UpdateMouseLockAvailability
      line: 84
      upvalues:
        Players_upv_1 (copy, index: 1)
        GameSettings_upv_1 (copy, index: 2)
        UserInputService_upv_1 (copy, index: 3)
    ]]
    local DevEnableMouseLock_1 = Players_upv_1.LocalPlayer.DevEnableMouseLock
    local v2 = Players_upv_1.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable
    local v3 = GameSettings_upv_1.ControlMode == Enum.ControlMode.MouseLockSwitch
    local v4 = GameSettings_upv_1.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove
    local v5 = UserInputService_upv_1.PreferredInput == Enum.PreferredInput.KeyboardAndMouse and (DevEnableMouseLock_1 and (v3 and (not v4 and (not v2))))
    if v5 == a1.enabled then
        return
    end
    a1:EnableMouseLock(v5)
end
function tbl_upv_1.OnMouseLockToggled(a1)
    --[[
      name: OnMouseLockToggled
      line: 98
      upvalues:
        CameraUtils_upv_1 (copy, index: 1)
    ]]
    a1.isMouseLocked = not a1.isMouseLocked
    local v6 = nil
    if a1.isMouseLocked then
        v6 = script:FindFirstChild("CursorImage")
        if v6 and v6:IsA("StringValue") and v6.Value then
            CameraUtils_upv_1.setMouseIconOverride(v6.Value)
        else
            if v6 then
                v6:Destroy()
            end
            local v7 = Instance.new("StringValue")
            assert(v7, "")
            v7.Name = "CursorImage"
            v7.Value = "rbxasset://textures/MouseLockedCursor.png"
            v7.Parent = script
            CameraUtils_upv_1.setMouseIconOverride("rbxasset://textures/MouseLockedCursor.png")
        end
    else
        CameraUtils_upv_1.restoreMouseIcon()
    end
    a1.mouseLockToggledEvent:Fire()
end
function tbl_upv_1.IsMouseLocked(a1)
    --[[
      name: IsMouseLocked
      line: 123
    ]]
    return a1.enabled and (a1.isMouseLocked)
end
function tbl_upv_1.EnableMouseLock(a1, a2)
    --[[
      name: EnableMouseLock
      line: 127
      upvalues:
        MouseLockSwitchAction_upv_1 (copy, index: 1)
        CameraUtils_upv_1 (copy, index: 2)
        u1 (copy, index: 3)
    ]]
    if a2 == a1.enabled then
        return
    end
    a1.enabled = a2
    if a1.enabled then
        MouseLockSwitchAction_upv_1.Enabled = true
    else
        CameraUtils_upv_1.restoreMouseIcon()
        MouseLockSwitchAction_upv_1.Enabled = false
        if u1 then
            if a1.isMouseLocked then
                a1.isMouseLocked = false
                a1.mouseLockToggledEvent:Fire()
                return
            end
        else
            if a1.isMouseLocked then
                a1.mouseLockToggledEvent:Fire()
            end
            a1.isMouseLocked = false
        end
    end
end
return tbl_upv_1