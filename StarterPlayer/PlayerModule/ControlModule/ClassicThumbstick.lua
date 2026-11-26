local guiService = game:GetService("GuiService")
local players = game:GetService("Players")
local CommonUtils = require(script.Parent.Parent:WaitForChild("CommonUtils"))
local v4 = CommonUtils.get("FlagUtil")
local userFlag = v4.getUserFlag("UserPlayerScriptsCCLIntegrationD")
    or v4.getUserFlag("UserPlayerScriptsCCLIntegrationDGA")
local userFlag2 = v4.getUserFlag("UserPlayerScriptsClassicThumbstickRenameUI")
local userFlag3 = v4.getUserFlag("UserAbilitiesUserInterfaceC")
local userFlag4 = v4.getUserFlag("UserPlayerScriptsResetDTTouchOnCreate")
local transformerContext = script.Parent.Parent:WaitForChild("InputContexts"):WaitForChild("TransformerContext")
local thumbstickAction = transformerContext:WaitForChild("ThumbstickAction")
local vector2 = Vector2.new(-1, -1)
local AvatarAbilitiesInterface = require(script.Parent:WaitForChild("AvatarAbilitiesInterface"))
local v13 = if userFlag then AvatarAbilitiesInterface.get(players.LocalPlayer) else nil
local ActionController = require(script.Parent:WaitForChild("ActionController"))
local v15 = setmetatable({}, ActionController)
v15.__index = v15

function v15.new(data)
    --[[
      name: new
      line: 34
      upvalues:
        ActionController (copy, index: 1)
        v15 (copy, index: 2)
    ]]
    local v17 = setmetatable(ActionController.new(), v15)
    v17.data = data
    v17.enabled = false
    v17.isTouchActive = false
    v17.isFollowStick = false
    v17.thumbstickFrame = nil
    v17.screenPos = nil
    v17.stickImage = nil
    v17.thumbstickSize = nil
    return v17
end

local function setupThumbstickInput(a19)
    --[[
      name: setupThumbstickInput
      line: 51
      upvalues:
        thumbstickAction (copy, index: 1)
    ]]
    for _, child in thumbstickAction:GetChildren() do
        if child.Name == "DynamicTouchBinding" or child.Name == "ClassicTouchBinding" then
            child:Destroy()
        end
    end

    local classicTouchBinding = Instance.new("InputBinding")
    classicTouchBinding.Name = "ClassicTouchBinding"
    classicTouchBinding.KeyCode = Enum.KeyCode.TouchPosition
    classicTouchBinding.UIModifier = a19.thumbstickButton
    classicTouchBinding.Parent = thumbstickAction
end

local function enableThumbstickInput(a24, a25)
    --[[
      name: enableThumbstickInput
      line: 64
      upvalues:
        setupThumbstickInput (copy, index: 1)
        thumbstickAction (copy, index: 2)
    ]]
    if a25 then
        setupThumbstickInput(a24)
        a24.thumbstickStateChangedConn = thumbstickAction.StateChanged:Connect(a24.onStateChanged)
        thumbstickAction.Enabled = true

        return
    end

    thumbstickAction.Enabled = false

    if a24.thumbstickStateChangedConn then
        a24.thumbstickStateChangedConn:Disconnect()
        a24.thumbstickStateChangedConn = nil
    end
end

function v15.Enable(a26, a27, a28)
    --[[
      name: Enable
      line: 78
      upvalues:
        ActionController (copy, index: 1)
        userFlag4 (copy, index: 2)
        setupThumbstickInput (copy, index: 3)
        thumbstickAction (copy, index: 4)
    ]]
    if a27 == nil then
        return false
    end

    local enabled = not not a27
    a27 = enabled

    if a26.enabled == a27 then
        return true
    end

    ActionController.Enable(a26, a27)
    a26.isJumping = false

    if a27 then
        if not a26.thumbstickFrame then
            a26:Create(a28)
        end

        if userFlag4 then
            setupThumbstickInput(a26)
            a26.thumbstickStateChangedConn = thumbstickAction.StateChanged:Connect(a26.onStateChanged)
            thumbstickAction.Enabled = true
        else
            a26.thumbstickStateChangedConn = thumbstickAction.StateChanged:Connect(a26.onStateChanged)
            thumbstickAction.Enabled = true
        end

        a26.thumbstickFrame.Visible = true
    else
        if userFlag4 then
            thumbstickAction.Enabled = false

            if a26.thumbstickStateChangedConn then
                a26.thumbstickStateChangedConn:Disconnect()
                a26.thumbstickStateChangedConn = nil
            end
        else
            thumbstickAction.Enabled = false

            if a26.thumbstickStateChangedConn then
                a26.thumbstickStateChangedConn:Disconnect()
                a26.thumbstickStateChangedConn = nil
            end
        end

        a26.thumbstickFrame.Visible = false
        a26:OnInputEnded()
    end

    a26.enabled = enabled
end

function v15.OnInputEnded(a30)
    --[[
      name: OnInputEnded
      line: 119
    ]]
    a30.isTouchActive = false
    a30.thumbstickFrame.Position = a30.screenPos
    a30.stickImage.Position = UDim2.new(0, (a30.thumbstickFrame.Size.X.Offset / 2) - (a30.thumbstickSize / 4), 0, a30.thumbstickFrame.Size.Y.Offset / 2 - (a30.thumbstickSize / 4))

    if const classicThumbstickScriptableBinding = a30.data.controlModule.actions.MoveAction:FindFirstChild("ClassicThumbstickScriptableBinding") then
        classicThumbstickScriptableBinding:Fire(Vector2.zero)
    end

    a30.isJumping = false
    a30.thumbstickFrame.Position = a30.screenPos
end

function v15.Create(a32, parent)
    --[[
      name: Create
      line: 137
      upvalues:
        thumbstickAction (copy, index: 1)
        userFlag2 (copy, index: 2)
        userFlag (copy, index: 3)
        v13 (copy, index: 4)
        AvatarAbilitiesInterface (copy, index: 5)
        userFlag4 (copy, index: 6)
        userFlag3 (copy, index: 7)
        vector2 (copy, index: 8)
        guiService (copy, index: 9)
    ]]
    if a32.thumbstickFrame then
        thumbstickAction.Enabled = false

        if a32.thumbstickStateChangedConn then
            a32.thumbstickStateChangedConn:Disconnect()
            a32.thumbstickStateChangedConn = nil
        end

        a32.thumbstickFrame:Destroy()
        a32.thumbstickFrame = nil

        if a32.absoluteSizeChangedConn then
            a32.absoluteSizeChangedConn:Disconnect()
            a32.absoluteSizeChangedConn = nil
        end

        if a32.avatarAbilitiesEnabledChangedConn then
            a32.avatarAbilitiesEnabledChangedConn:Disconnect()
            a32.avatarAbilitiesEnabledChangedConn = nil
        end
    end

    a32.thumbstickFrame = Instance.new("Frame")
    a32.thumbstickFrame.Name = userFlag2 and "ClassicThumbstickFrame" or "ThumbstickFrame"
    a32.thumbstickFrame.Active = true
    a32.thumbstickFrame.Visible = false
    a32.thumbstickFrame.BackgroundTransparency = 1
    local outerImage = Instance.new("ImageLabel")
    outerImage.Name = "OuterImage"
    outerImage.Image = "rbxasset://textures/ui/TouchControlsSheet.png"
    outerImage.ImageRectOffset = Vector2.new()
    outerImage.ImageRectSize = Vector2.new(220, 220)
    outerImage.BackgroundTransparency = 1
    outerImage.Position = UDim2.new(0, 0, 0, 0)
    a32.stickImage = Instance.new("ImageLabel")
    a32.stickImage.Name = "StickImage"
    a32.stickImage.Image = "rbxasset://textures/ui/TouchControlsSheet.png"
    a32.stickImage.ImageRectOffset = Vector2.new(220, 0)
    a32.stickImage.ImageRectSize = Vector2.new(111, 111)
    a32.stickImage.BackgroundTransparency = 1
    a32.stickImage.ZIndex = 2

    local function ResizeThumbstick()
        --[[
          name: ResizeThumbstick
          line: 180
          upvalues:
            parent (copy, index: 1)
            userFlag (copy, index: 2)
            v13 (copy, index: 3)
            AvatarAbilitiesInterface (copy, index: 4)
            a32 (copy, index: 5)
            outerImage (copy, index: 6)
        ]]
        local v36 = math.min(parent.AbsoluteSize.X, parent.AbsoluteSize.Y) <= 500
        local isEnabled = if userFlag then v13:isEnabled() else AvatarAbilitiesInterface.isEnabled()

        if isEnabled then
            local v38 = v36 and 64 or 100
            local v39 = v36 and 64 or 112
            a32.thumbstickSize = v36 and 72 or 120
            a32.screenPos = UDim2.new(0, v38, 1, -a32.thumbstickSize - v39)
        else
            a32.thumbstickSize = v36 and 70 or 120
            a32.screenPos = v36 and UDim2.new(0, (a32.thumbstickSize / 2) - 10, 1, -a32.thumbstickSize - 20)
                or UDim2.new(0, a32.thumbstickSize / 2, 1, -a32.thumbstickSize * 1.75)
        end

        a32.thumbstickFrame.Size = UDim2.new(0, a32.thumbstickSize, 0, a32.thumbstickSize)
        a32.thumbstickFrame.Position = a32.screenPos
        outerImage.Size = UDim2.new(0, a32.thumbstickSize, 0, a32.thumbstickSize)
        a32.stickImage.Size = UDim2.new(0, a32.thumbstickSize / 2, 0, a32.thumbstickSize / 2)
        a32.stickImage.Position = UDim2.new(0, (a32.thumbstickSize / 2) - (a32.thumbstickSize / 4), 0, a32.thumbstickSize / 2 - (a32.thumbstickSize / 4))
    end

    ResizeThumbstick()
    a32.absoluteSizeChangedConn = parent:GetPropertyChangedSignal("AbsoluteSize"):Connect(ResizeThumbstick)

    if userFlag then
        a32.avatarAbilitiesEnabledChangedConn = v13:GetEnabledChangedSignal():Connect(ResizeThumbstick)
    else
        a32.avatarAbilitiesEnabledChangedConn = AvatarAbilitiesInterface.GetEnabledChangedSignal():Connect(ResizeThumbstick)
    end

    outerImage.Parent = a32.thumbstickFrame
    a32.stickImage.Parent = a32.thumbstickFrame
    a32.thumbstickButton = Instance.new("ImageButton")
    a32.thumbstickButton.Name = "ClassicThumbstickUIModifier"
    a32.thumbstickButton.BackgroundTransparency = 1
    a32.thumbstickButton.ImageTransparency = 1
    a32.thumbstickButton.AutoButtonColor = false
    a32.thumbstickButton.Size = UDim2.new(1, 0, 1, 0)
    a32.thumbstickButton.ZIndex = a32.thumbstickFrame.ZIndex
    a32.thumbstickButton.Visible = true
    a32.thumbstickButton.Active = false
    a32.thumbstickButton.Parent = a32.thumbstickFrame

    if not userFlag4 then
        local classicTouchBinding = Instance.new("InputBinding")
        classicTouchBinding.Name = "ClassicTouchBinding"
        classicTouchBinding.KeyCode = Enum.KeyCode.TouchPosition
        classicTouchBinding.UIModifier = a32.thumbstickButton
        classicTouchBinding.Parent = thumbstickAction
    end

    local vector22 = nil

    local function DoMove(vector2: Vector2)
        --[[
          name: DoMove
          line: 246
          upvalues:
            a32 (copy, index: 1)
        ]]
        local v44 = vector2 / (a32.thumbstickSize / 2)
        local magnitude = v44.magnitude
        local v46 = if magnitude < 0.05 then Vector2.new() else v44.unit * math.min(1, (magnitude - 0.05) / 0.95)
        local vector22 = Vector2.new(v46.X, -v46.Y)

        if const classicThumbstickScriptableBinding = a32.data.controlModule.actions.MoveAction:FindFirstChild("ClassicThumbstickScriptableBinding") then
            classicThumbstickScriptableBinding:Fire(vector22)
        end
    end

    local function MoveStick(vector3: Vector3)
        --[[
          name: MoveStick
          line: 266
          upvalues:
            vector22 (ref,  index: 1)
            a32 (copy, index: 2)
            userFlag3 (copy, index: 3)
            parent (copy, index: 4)
        ]]
        local v51 = Vector2.new(vector3.X - vector22.X, vector3.Y - vector22.Y)
        local magnitude = v51.magnitude
        local v53 = a32.thumbstickFrame.AbsoluteSize.X / 2

        if not a32.isFollowStick or not (v53 < magnitude) then
            local v54 = math.min(magnitude, v53)
            v51 = v51.unit * v54
        else
            local v55 = v51.unit * v53

            if userFlag3 then
                local absolutePosition = parent.AbsolutePosition
                a32.thumbstickFrame.Position = UDim2.new(0, ((vector3.X - absolutePosition.X) - (a32.thumbstickFrame.AbsoluteSize.X / 2)) - v55.X, 0, (vector3.Y - absolutePosition.Y) - (a32.thumbstickFrame.AbsoluteSize.Y / 2) - v55.Y)
            else
                a32.thumbstickFrame.Position = UDim2.new(0, (vector3.X - (a32.thumbstickFrame.AbsoluteSize.X / 2)) - v55.X, 0, vector3.Y - (a32.thumbstickFrame.AbsoluteSize.Y / 2) - v55.Y)
            end
        end

        a32.stickImage.Position = UDim2.new(0, v51.X + (a32.stickImage.AbsoluteSize.X / 2), 0, v51.Y + (a32.stickImage.AbsoluteSize.Y / 2))
    end

    a32.onStateChanged = function(a57)
        --[[
          line: 300
          upvalues:
            vector2 (copy, index: 1)
            guiService (copy, index: 2)
            a32 (copy, index: 3)
            userFlag3 (copy, index: 4)
            parent (copy, index: 5)
            vector22 (ref,  index: 6)
            DoMove (copy, index: 7)
            MoveStick (copy, index: 8)
        ]]
        if a57 == vector2 then
            if a32.isTouchActive then
                a32:OnInputEnded()
            end
        else
            local min = guiService:GetInsetArea(Enum.ScreenInsets.None).Min
            local vector3 = Vector3.new(a57.X + min.X, a57.Y + min.Y, 0)

            if a32.isTouchActive then
                vector22 = Vector2.new(a32.thumbstickFrame.AbsolutePosition.X + (a32.thumbstickFrame.AbsoluteSize.X / 2), a32.thumbstickFrame.AbsolutePosition.Y + (a32.thumbstickFrame.AbsoluteSize.Y / 2))
                local vector23 = Vector2.new(vector3.X - vector22.X, vector3.Y - vector22.Y)
                DoMove(vector23)
                MoveStick(vector3)
            else
                a32.isTouchActive = true

                if userFlag3 then
                    local absolutePosition = parent.AbsolutePosition
                    a32.thumbstickFrame.Position = UDim2.new(0, (vector3.X - absolutePosition.X) - (a32.thumbstickFrame.Size.X.Offset / 2), 0, vector3.Y - absolutePosition.Y - (a32.thumbstickFrame.Size.Y.Offset / 2))
                else
                    a32.thumbstickFrame.Position = UDim2.new(0, vector3.X - (a32.thumbstickFrame.Size.X.Offset / 2), 0, vector3.Y - (a32.thumbstickFrame.Size.Y.Offset / 2))
                end

                vector22 = Vector2.new(a32.thumbstickFrame.AbsolutePosition.X + (a32.thumbstickFrame.AbsoluteSize.X / 2), a32.thumbstickFrame.AbsolutePosition.Y + (a32.thumbstickFrame.AbsoluteSize.Y / 2))
            end
        end
    end

    guiService.MenuOpened:Connect(
        function()
            --[[
              line: 343
              upvalues:
                a32 (copy, index: 1)
            ]]
            if a32.isTouchActive then
                a32:OnInputEnded()
            end
        end
    )

    a32.thumbstickFrame.Parent = parent
end

return v15