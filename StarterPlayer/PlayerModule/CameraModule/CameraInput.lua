local _ = game:GetService("ContextActionService")
local UserInputService_upv_1 = game:GetService("UserInputService")
local v3 = game:GetService("Players")
local UserGameSettings_upv_1 = UserSettings():GetService("UserGameSettings")
local v4 = game:GetService("VRService")
local GuiService_1 = game:GetService("GuiService")
local v1 = require(script.Parent.Parent:WaitForChild("CommonUtils")).get("FlagUtil")
local v2 = v1.getUserFlag("UserPSTextboxResetCameraInput")
local u1 = v1.getUserFlag("UserPlayerScriptsSupportTVRemoteKeycodes")
local CameraContext_1 = script.Parent.Parent:WaitForChild("InputContexts"):WaitForChild("CameraContext")
local CameraRotationAction_upv_1 = CameraContext_1:WaitForChild("CameraRotationAction")
local CameraZoomAction_upv_1 = CameraContext_1:WaitForChild("CameraZoomAction")
local GamepadBinding_upv_1 = CameraRotationAction_upv_1:WaitForChild("GamepadBinding")
local u2
if u1 then
    u2 = CameraRotationAction_upv_1:WaitForChild("MicroGamepadBinding")
else
    u2 = nil
end
local MouseBinding_upv_1 = CameraRotationAction_upv_1:WaitForChild("MouseBinding")
local TrackpadBinding_upv_1 = CameraRotationAction_upv_1:WaitForChild("TrackpadBinding")
local CameraToggleAction_upv_1 = CameraContext_1:WaitForChild("CameraToggleAction")
local CameraPanActiveAction_upv_1 = CameraContext_1:WaitForChild("CameraPanActiveAction")
local u3 = 1
local function updateCameraYInvert()
    --[[
      name: updateCameraYInvert
      line: 38
      upvalues:
        UserGameSettings_upv_1 (copy, index: 1)
        u3 (ref,  index: 2)
        CameraRotationAction_upv_1 (copy, index: 3)
    ]]
    local v3 = UserGameSettings_upv_1:GetCameraYInvertValue()
    if v3 == u3 then
        return
    end
    u3 = v3
    for _, value_1 in CameraRotationAction_upv_1:GetChildren() do
        if value_1:IsA("InputBinding") then
            local Vector2Scale_1 = value_1.Vector2Scale
            value_1.Vector2Scale = Vector2.new(Vector2Scale_1.X, -Vector2Scale_1.Y)
        end
    end
end
local function updateMouseCameraSensitivity()
    --[[
      name: updateMouseCameraSensitivity
      line: 59
      upvalues:
        UserGameSettings_upv_1 (copy, index: 1)
        MouseBinding_upv_1 (copy, index: 2)
        TrackpadBinding_upv_1 (copy, index: 3)
    ]]
    local MouseSensitivity_1 = UserGameSettings_upv_1.MouseSensitivity
    MouseBinding_upv_1.Scale = MouseSensitivity_1
    TrackpadBinding_upv_1.Scale = MouseSensitivity_1
end
local function updateGamepadCameraSensitivity()
    --[[
      name: updateGamepadCameraSensitivity
      line: 52
      upvalues:
        GamepadBinding_upv_1 (copy, index: 1)
        UserGameSettings_upv_1 (copy, index: 2)
        u1 (copy, index: 3)
        u2 (copy, index: 4)
    ]]
    GamepadBinding_upv_1.Scale = UserGameSettings_upv_1.GamepadCameraSensitivity
    if not u1 or not u2 then
        return
    end
    u2.Scale = UserGameSettings_upv_1.GamepadCameraSensitivity
end
UserGameSettings_upv_1:GetPropertyChangedSignal("GamepadCameraSensitivity"):Connect(updateGamepadCameraSensitivity)
GamepadBinding_upv_1.Scale = UserGameSettings_upv_1.GamepadCameraSensitivity
if u1 and u2 then
    u2.Scale = UserGameSettings_upv_1.GamepadCameraSensitivity
end
UserGameSettings_upv_1:GetPropertyChangedSignal("MouseSensitivity"):Connect(updateMouseCameraSensitivity)
local MouseSensitivity_2 = UserGameSettings_upv_1.MouseSensitivity
MouseBinding_upv_1.Scale = MouseSensitivity_2
TrackpadBinding_upv_1.Scale = MouseSensitivity_2
updateCameraYInvert()
local tbl_1 = {}
local u4 = 0
local function incPanInputCount()
    --[[
      name: incPanInputCount
      line: 106
      upvalues:
        u4 (ref, index: 1)
    ]]
    u4 = math.max(0, u4 + 1)
end
local function decPanInputCount()
    --[[
      name: decPanInputCount
      line: 110
      upvalues:
        u4 (ref, index: 1)
    ]]
    u4 = math.max(0, u4 - 1)
end
local function resetPanInputCount()
    --[[
      name: resetPanInputCount
      line: 114
      upvalues:
        u4 (ref, index: 1)
    ]]
    u4 = 0
end
function tbl_1.getRotationActivated()
    --[[
      name: getRotationActivated
      line: 118
      upvalues:
        u4 (ref,  index: 1)
        CameraRotationAction_upv_1 (copy, index: 2)
    ]]
    local v4 = true
    if not (u4 > 0) then
        v4 = CameraRotationAction_upv_1:GetState().Magnitude > 0
    end
    return v4
end
function tbl_1.getPanActivated()
    --[[
      name: getPanActivated
      line: 123
      upvalues:
        u4 (ref, index: 1)
    ]]
    local v5 = u4 > 0
    return v5
end
local function adjustTouchPitchSensitivity(a1)
    --[[
      name: adjustTouchPitchSensitivity
      line: 75
    ]]
    local CurrentCamera_1 = workspace.CurrentCamera
    if not CurrentCamera_1 then
        return a1
    end
    local v6 = CurrentCamera_1.CFrame:ToEulerAnglesYXZ()
    if a1.Y * v6 >= 0 then
        return a1
    end
    return Vector2.new(1, ((1 - (((math.abs(v6) * 2) / math.pi) ^ 0.75)) * 0.75) + 0.25) * a1
end
function tbl_1.getRotation(a1)
    --[[
      name: getRotation
      line: 127
      upvalues:
        updateCameraYInvert (copy, index: 1)
        CameraRotationAction_upv_1 (copy, index: 2)
        UserInputService_upv_1 (copy, index: 3)
        adjustTouchPitchSensitivity (copy, index: 4)
    ]]
    updateCameraYInvert()
    local v7 = CameraRotationAction_upv_1:GetState() * a1
    if UserInputService_upv_1.PreferredInput == Enum.PreferredInput.Touch then
        v7 = adjustTouchPitchSensitivity(v7)
    end
    return v7
end
function tbl_1.getZoomDelta(a1)
    --[[
      name: getZoomDelta
      line: 136
      upvalues:
        CameraZoomAction_upv_1 (copy, index: 1)
    ]]
    return CameraZoomAction_upv_1:GetState() * a1
end
CameraPanActiveAction_upv_1.Pressed:Connect(incPanInputCount)
CameraPanActiveAction_upv_1.Released:Connect(decPanInputCount)
local u5 = false
function tbl_1.setInputEnabled(a1)
    --[[
      name: setInputEnabled
      line: 147
      upvalues:
        u5 (ref,  index: 1)
        u4 (ref,  index: 2)
        CameraZoomAction_upv_1 (copy, index: 3)
        CameraRotationAction_upv_1 (copy, index: 4)
        CameraPanActiveAction_upv_1 (copy, index: 5)
    ]]
    if u5 == a1 then
        return
    end
    u5 = a1
    u4 = 0
    if u5 then
        CameraZoomAction_upv_1.Enabled = true
        CameraRotationAction_upv_1.Enabled = true
        CameraPanActiveAction_upv_1.Enabled = true
    else
        CameraZoomAction_upv_1.Enabled = false
        CameraRotationAction_upv_1.Enabled = false
        CameraPanActiveAction_upv_1.Enabled = false
    end
end
function tbl_1.getInputEnabled()
    --[[
      name: getInputEnabled
      line: 168
      upvalues:
        u5 (ref, index: 1)
    ]]
    return u5
end
UserInputService_upv_1.WindowFocused:Connect(resetPanInputCount)
UserInputService_upv_1.WindowFocusReleased:Connect(resetPanInputCount)
GuiService_1.MenuOpened:Connect(resetPanInputCount)
if v2 then
    UserInputService_upv_1.TextBoxFocusReleased:Connect(resetPanInputCount)
end
local u6 = false
local u7 = false
local u8 = 0
function tbl_1.getHoldPan()
    --[[
      name: getHoldPan
      line: 187
      upvalues:
        u6 (ref, index: 1)
    ]]
    return u6
end
function tbl_1.getTogglePan()
    --[[
      name: getTogglePan
      line: 191
      upvalues:
        u7 (ref, index: 1)
    ]]
    return u7
end
function tbl_1.getPanning()
    --[[
      name: getPanning
      line: 195
      upvalues:
        u7 (ref, index: 1)
        u6 (ref, index: 2)
    ]]
    local v8 = u7 or u6
    return v8
end
function tbl_1.setTogglePan(a1)
    --[[
      name: setTogglePan
      line: 199
      upvalues:
        u7 (ref, index: 1)
    ]]
    u7 = a1
end
local u9 = false
local v5 = CameraToggleAction_upv_1.Pressed:Connect(
    function()
        --[[
          line: 207
          upvalues:
            u6 (ref, index: 1)
            u8 (ref, index: 2)
        ]]
        u6 = true
        u8 = tick()
    end
)
local v6 = CameraToggleAction_upv_1.Released:Connect(
    function()
        --[[
          line: 212
          upvalues:
            u6 (ref,  index: 1)
            u8 (ref,  index: 2)
            u7 (ref,  index: 3)
            UserInputService_upv_1 (copy, index: 4)
        ]]
        u6 = false
        if not (tick() - u8 < 0.3) or not u7 and not (UserInputService_upv_1:GetMouseDelta().Magnitude < 2) then
            return
        end
        u7 = not u7
    end
)
function tbl_1.enableCameraToggleInput()
    --[[
      name: enableCameraToggleInput
      line: 219
      upvalues:
        u9 (ref,  index: 1)
        u6 (ref,  index: 2)
        u7 (ref,  index: 3)
        CameraToggleAction_upv_1 (copy, index: 4)
    ]]
    if u9 then
        return
    end
    u9 = true
    u6 = false
    u7 = false
    CameraToggleAction_upv_1.Enabled = true
end
function tbl_1.disableCameraToggleInput()
    --[[
      name: disableCameraToggleInput
      line: 231
      upvalues:
        u9 (ref,  index: 1)
        CameraToggleAction_upv_1 (copy, index: 2)
    ]]
    if not u9 then
        return
    end
    u9 = false
    CameraToggleAction_upv_1.Enabled = false
end
return tbl_1