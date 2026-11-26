game:GetService("ContextActionService")
local userInputService = game:GetService("UserInputService")
game:GetService("Players")
local v2 = UserSettings():GetService("UserGameSettings")
game:GetService("VRService")
local guiService = game:GetService("GuiService")
local CommonUtils = require(script.Parent.Parent:WaitForChild("CommonUtils"))
local v5 = CommonUtils.get("FlagUtil")
local userFlag = v5.getUserFlag("UserPSTextboxResetCameraInput")
local userFlag2 = v5.getUserFlag("UserPlayerScriptsSupportTVRemoteKeycodes")
local cameraContext = script.Parent.Parent:WaitForChild("InputContexts"):WaitForChild("CameraContext")
local cameraRotationAction = cameraContext:WaitForChild("CameraRotationAction")
local cameraZoomAction = cameraContext:WaitForChild("CameraZoomAction")
local gamepadBinding = cameraRotationAction:WaitForChild("GamepadBinding")
local instance = if userFlag2 then cameraRotationAction:WaitForChild("MicroGamepadBinding") else nil
local mouseBinding = cameraRotationAction:WaitForChild("MouseBinding")
local trackpadBinding = cameraRotationAction:WaitForChild("TrackpadBinding")
local cameraToggleAction = cameraContext:WaitForChild("CameraToggleAction")
local cameraPanActiveAction = cameraContext:WaitForChild("CameraPanActiveAction")
local cameraYInvertValue = 1

local function updateCameraYInvert()
    --[[
      name: updateCameraYInvert
      line: 38
      upvalues:
        v2 (copy, index: 1)
        cameraYInvertValue (ref,  index: 2)
        cameraRotationAction (copy, index: 3)
    ]]
    local cameraYInvertValue2 = v2:GetCameraYInvertValue()

    if cameraYInvertValue2 == cameraYInvertValue then
        return
    end

    cameraYInvertValue = cameraYInvertValue2

    for _, child in cameraRotationAction:GetChildren() do
        if child:IsA("InputBinding") then
            local vector2scale = child.Vector2Scale
            child.Vector2Scale = Vector2.new(vector2scale.X, -vector2scale.Y)
        end
    end
end

v2:GetPropertyChangedSignal("GamepadCameraSensitivity"):Connect(
    function()
        --[[
          name: updateGamepadCameraSensitivity
          line: 52
          upvalues:
            gamepadBinding (copy, index: 1)
            v2 (copy, index: 2)
            userFlag2 (copy, index: 3)
            instance (copy, index: 4)
        ]]
        gamepadBinding.Scale = v2.GamepadCameraSensitivity

        if userFlag2 and instance then
            instance.Scale = v2.GamepadCameraSensitivity
        end
    end
)

gamepadBinding.Scale = v2.GamepadCameraSensitivity

if userFlag2 and instance then
    instance.Scale = v2.GamepadCameraSensitivity
end

v2:GetPropertyChangedSignal("MouseSensitivity"):Connect(
    function()
        --[[
          name: updateMouseCameraSensitivity
          line: 59
          upvalues:
            v2 (copy, index: 1)
            mouseBinding (copy, index: 2)
            trackpadBinding (copy, index: 3)
        ]]
        local mouseSensitivity = v2.MouseSensitivity
        mouseBinding.Scale = mouseSensitivity
        trackpadBinding.Scale = mouseSensitivity
    end
)

local mouseSensitivity = v2.MouseSensitivity
mouseBinding.Scale = mouseSensitivity
trackpadBinding.Scale = mouseSensitivity
updateCameraYInvert()

local function adjustTouchPitchSensitivity(a26)
    --[[
      name: adjustTouchPitchSensitivity
      line: 75
    ]]
    local camera = workspace.CurrentCamera
    if not camera then
        return a26
    end

    local y = camera.CFrame:ToEulerAnglesYXZ()

    if 0 <= a26.Y * y then
        return a26
    end

    y = (1 - (((math.abs(y) * 2) / math.pi) ^ 0.75)) * 0.75 + 0.25

    return Vector2.new(1, y) * a26
end

local v29 = {}
local v30 = 0

local function incPanInputCount()
    --[[
      name: incPanInputCount
      line: 106
      upvalues:
        v30 (ref, index: 1)
    ]]
    v30 = math.max(0, v30 + 1)
end

local function decPanInputCount()
    --[[
      name: decPanInputCount
      line: 110
      upvalues:
        v30 (ref, index: 1)
    ]]
    v30 = math.max(0, v30 - 1)
end

local function resetPanInputCount()
    --[[
      name: resetPanInputCount
      line: 114
      upvalues:
        v30 (ref, index: 1)
    ]]
    v30 = 0
end

function v29.getRotationActivated()
    --[[
      name: getRotationActivated
      line: 118
      upvalues:
        v30 (ref,  index: 1)
        cameraRotationAction (copy, index: 2)
    ]]
    return 0 < v30 or 0 < cameraRotationAction:GetState().Magnitude
end

function v29.getPanActivated()
    --[[
      name: getPanActivated
      line: 123
      upvalues:
        v30 (ref, index: 1)
    ]]
    return 0 < v30
end

function v29.getRotation(a34)
    --[[
      name: getRotation
      line: 127
      upvalues:
        updateCameraYInvert (copy, index: 1)
        cameraRotationAction (copy, index: 2)
        userInputService (copy, index: 3)
        adjustTouchPitchSensitivity (copy, index: 4)
    ]]
    updateCameraYInvert()
    local v35 = cameraRotationAction:GetState() * a34

    if userInputService.PreferredInput == Enum.PreferredInput.Touch then
        v35 = adjustTouchPitchSensitivity(v35)
    end

    return v35
end

function v29.getZoomDelta(a36)
    --[[
      name: getZoomDelta
      line: 136
      upvalues:
        cameraZoomAction (copy, index: 1)
    ]]
    return cameraZoomAction:GetState() * a36
end

cameraPanActiveAction.Pressed:Connect(incPanInputCount)
cameraPanActiveAction.Released:Connect(decPanInputCount)
local v37 = false

function v29.setInputEnabled(inputEnabled)
    --[[
      name: setInputEnabled
      line: 147
      upvalues:
        v37 (ref,  index: 1)
        v30 (ref,  index: 2)
        cameraZoomAction (copy, index: 3)
        cameraRotationAction (copy, index: 4)
        cameraPanActiveAction (copy, index: 5)
    ]]
    if v37 == inputEnabled then
        return
    end

    v37 = inputEnabled
    v30 = 0

    if v37 then
        cameraZoomAction.Enabled = true
        cameraRotationAction.Enabled = true
        cameraPanActiveAction.Enabled = true

        return
    end

    cameraZoomAction.Enabled = false
    cameraRotationAction.Enabled = false
    cameraPanActiveAction.Enabled = false
end

function v29.getInputEnabled()
    --[[
      name: getInputEnabled
      line: 168
      upvalues:
        v37 (ref, index: 1)
    ]]
    return v37
end

userInputService.WindowFocused:Connect(resetPanInputCount)
userInputService.WindowFocusReleased:Connect(resetPanInputCount)
guiService.MenuOpened:Connect(resetPanInputCount)

if userFlag then
    userInputService.TextBoxFocusReleased:Connect(resetPanInputCount)
end

local v39 = false
local v40 = false
local time = 0

function v29.getHoldPan()
    --[[
      name: getHoldPan
      line: 187
      upvalues:
        v39 (ref, index: 1)
    ]]
    return v39
end

function v29.getTogglePan()
    --[[
      name: getTogglePan
      line: 191
      upvalues:
        v40 (ref, index: 1)
    ]]
    return v40
end

function v29.getPanning()
    --[[
      name: getPanning
      line: 195
      upvalues:
        v40 (ref, index: 1)
        v39 (ref, index: 2)
    ]]
    return v40 or v39
end

function v29.setTogglePan(togglePan)
    --[[
      name: setTogglePan
      line: 199
      upvalues:
        v40 (ref, index: 1)
    ]]
    v40 = togglePan
end

local isBusy = false

cameraToggleAction.Pressed:Connect(
    function()
        --[[
          line: 207
          upvalues:
            v39 (ref, index: 1)
            time (ref, index: 2)
        ]]
        v39 = true
        time = tick()
    end
)

cameraToggleAction.Released:Connect(
    function()
        --[[
          line: 212
          upvalues:
            v39 (ref,  index: 1)
            time (ref,  index: 2)
            v40 (ref,  index: 3)
            userInputService (copy, index: 4)
        ]]
        v39 = false

        if tick() - time < 0.3 and (v40 or userInputService:GetMouseDelta().Magnitude < 2) then
            v40 = not v40
        end
    end
)

function v29.enableCameraToggleInput()
    --[[
      name: enableCameraToggleInput
      line: 219
      upvalues:
        isBusy (ref,  index: 1)
        v39 (ref,  index: 2)
        v40 (ref,  index: 3)
        cameraToggleAction (copy, index: 4)
    ]]
    if isBusy then
        return
    end

    isBusy = true
    v39 = false
    v40 = false
    cameraToggleAction.Enabled = true
end

function v29.disableCameraToggleInput()
    --[[
      name: disableCameraToggleInput
      line: 231
      upvalues:
        isBusy (ref,  index: 1)
        cameraToggleAction (copy, index: 2)
    ]]
    if not isBusy then
        return
    end

    isBusy = false
    cameraToggleAction.Enabled = false
end

return v29