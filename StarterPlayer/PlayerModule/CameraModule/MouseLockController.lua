local CommonUtils = require(script.Parent.Parent:WaitForChild("CommonUtils"))
local v2 = CommonUtils.get("FlagUtil")
local instance = script.Parent.Parent:WaitForChild("InputContexts"):WaitForChild("CameraContext")
local mouseLockSwitchAction = instance:WaitForChild("MouseLockSwitchAction")
instance = game:GetService("Players")
local userInputService = game:GetService("UserInputService")
local userSettings = UserSettings()
local gameSettings = userSettings.GameSettings
local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"))
local userFlag = v2.getUserFlag("UserFixStuckShiftLock")
local Class = {}
Class.__index = Class

function Class.new()
    --[[
      name: new
      line: 36
      upvalues:
        Class (copy, index: 1)
        gameSettings (copy, index: 2)
        instance (copy, index: 3)
        userInputService (copy, index: 4)
        mouseLockSwitchAction (copy, index: 5)
    ]]
    local v11 = setmetatable({}, Class)
    v11.isMouseLocked = false
    v11.savedMouseCursor = nil
    v11.enabled = false
    v11.mouseLockToggledEvent = Instance.new("BindableEvent")

    gameSettings.Changed:Connect(
        function(a12)
            --[[
              line: 46
              upvalues:
                v11 (copy, index: 1)
            ]]
            if a12 == "ControlMode" or a12 == "ComputerMovementMode" then
                v11:UpdateMouseLockAvailability()
            end
        end
    )

    instance.LocalPlayer:GetPropertyChangedSignal("DevEnableMouseLock"):Connect(
        function()
            --[[
              line: 53
              upvalues:
                v11 (copy, index: 1)
            ]]
            v11:UpdateMouseLockAvailability()
        end
    )
    instance.LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode"):Connect(
        function()
            --[[
              line: 58
              upvalues:
                v11 (copy, index: 1)
            ]]
            v11:UpdateMouseLockAvailability()
        end
    )
    userInputService:GetPropertyChangedSignal("PreferredInput"):Connect(
        function()
            --[[
              line: 62
              upvalues:
                v11 (copy, index: 1)
            ]]
            v11:UpdateMouseLockAvailability()
        end
    )
    v11:UpdateMouseLockAvailability()
    mouseLockSwitchAction.Pressed:Connect(
        function()
            --[[
              line: 68
              upvalues:
                v11 (copy, index: 1)
            ]]
            v11:OnMouseLockToggled()
        end
    )

    return v11
end

function Class.GetIsMouseLocked(self)
    --[[
      name: GetIsMouseLocked
      line: 75
    ]]
    return self.isMouseLocked
end

function Class.GetBindableToggleEvent(self)
    --[[
      name: GetBindableToggleEvent
      line: 79
    ]]
    return self.mouseLockToggledEvent.Event
end

function Class.GetMouseLockOffset(a15)
    --[[
      name: GetMouseLockOffset
      line: 83
    ]]
    return Vector3.new(1.75, 0, 0)
end

function Class.UpdateMouseLockAvailability(self)
    --[[
      name: UpdateMouseLockAvailability
      line: 87
      upvalues:
        instance (copy, index: 1)
        gameSettings (copy, index: 2)
        userInputService (copy, index: 3)
    ]]
    local devEnableMouseLock = instance.LocalPlayer.DevEnableMouseLock
    local isScriptable = instance.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable
    local isMouseLockSwitch = gameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch
    local isClickToMove = gameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove
    local isNotScriptable = userInputService.PreferredInput == Enum.PreferredInput.KeyboardAndMouse
        and devEnableMouseLock
        and isMouseLockSwitch
        and not isClickToMove
        and not isScriptable

    if isNotScriptable ~= self.enabled then
        self:EnableMouseLock(isNotScriptable)
    end
end

function Class.OnMouseLockToggled(self)
    --[[
      name: OnMouseLockToggled
      line: 107
      upvalues:
        CameraUtils (copy, index: 1)
    ]]
    self.isMouseLocked = not self.isMouseLocked

    if self.isMouseLocked then
        local cursorImage2 = script:FindFirstChild("CursorImage")

        if cursorImage2 and cursorImage2:IsA("StringValue") and cursorImage2.Value then
            CameraUtils.setMouseIconOverride(cursorImage2.Value)
        else
            if cursorImage2 then
                cursorImage2:Destroy()
            end

            local cursorImage = Instance.new("StringValue")
            assert(cursorImage, "")
            cursorImage.Name = "CursorImage"
            cursorImage.Value = "rbxasset://textures/MouseLockedCursor.png"
            cursorImage.Parent = script
            CameraUtils.setMouseIconOverride("rbxasset://textures/MouseLockedCursor.png")
        end
    else
        CameraUtils.restoreMouseIcon()
    end

    self.mouseLockToggledEvent:Fire()
end

function Class.IsMouseLocked(self)
    --[[
      name: IsMouseLocked
      line: 132
    ]]
    return self.enabled and self.isMouseLocked
end

function Class.EnableMouseLock(self, enabled)
    --[[
      name: EnableMouseLock
      line: 136
      upvalues:
        mouseLockSwitchAction (copy, index: 1)
        CameraUtils (copy, index: 2)
        userFlag (copy, index: 3)
    ]]
    if enabled == self.enabled then
        return
    end

    self.enabled = enabled

    if self.enabled then
        mouseLockSwitchAction.Enabled = true
        return
    end

    CameraUtils.restoreMouseIcon()
    mouseLockSwitchAction.Enabled = false

    if userFlag then
        if self.isMouseLocked then
            self.isMouseLocked = false
            self.mouseLockToggledEvent:Fire()
        end
    else
        if self.isMouseLocked then
            self.mouseLockToggledEvent:Fire()
        end

        self.isMouseLocked = false
    end
end

return Class