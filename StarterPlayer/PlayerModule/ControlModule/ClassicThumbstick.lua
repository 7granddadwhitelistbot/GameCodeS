local GuiService_upv_1 = game:GetService("GuiService")
local Players_1 = game:GetService("Players")
local v1 = require(script.Parent.Parent:WaitForChild("CommonUtils")).get("FlagUtil")
local u1 = v1.getUserFlag("UserPlayerScriptsCCLIntegrationD")
local u2 = v1.getUserFlag("UserPlayerScriptsClassicThumbstickRenameUI")
local u3 = v1.getUserFlag("UserAbilitiesUserInterfaceC")
local u4 = v1.getUserFlag("UserPlayerScriptsResetDTTouchOnCreate")
local ThumbstickAction_upv_1 = script.Parent.Parent:WaitForChild("InputContexts"):WaitForChild("TransformerContext"):WaitForChild("ThumbstickAction")
local u5 = Vector2.new(-1, -1)
local AvatarAbilitiesInterface_upv_1 = require(script.Parent:WaitForChild("AvatarAbilitiesInterface"))
local u6
if u1 then
    u6 = AvatarAbilitiesInterface_upv_1.get(Players_1.LocalPlayer)
else
    u6 = nil
end
local ActionController_upv_1 = require(script.Parent:WaitForChild("ActionController"))
local u7 = setmetatable({}, ActionController_upv_1)
u7.__index = u7
function u7.new(a1)
    --[[
      name: new
      line: 30
      upvalues:
        ActionController_upv_1 (copy, index: 1)
        u7 (copy, index: 2)
    ]]
    local v2 = setmetatable(ActionController_upv_1.new(), u7)
    v2.playerData = a1
    v2.enabled = false
    v2.isTouchActive = false
    v2.isFollowStick = false
    v2.thumbstickFrame = nil
    v2.screenPos = nil
    v2.stickImage = nil
    v2.thumbstickSize = nil
    return v2
end
local function setupThumbstickInput(a1)
    --[[
      name: setupThumbstickInput
      line: 47
      upvalues:
        ThumbstickAction_upv_1 (copy, index: 1)
    ]]
    for _, value_1 in ThumbstickAction_upv_1:GetChildren() do
        if value_1.Name == "DynamicTouchBinding" or value_1.Name == "ClassicTouchBinding" then
            value_1:Destroy()
        end
    end
    local v3 = Instance.new("InputBinding")
    v3.Name = "ClassicTouchBinding"
    v3.KeyCode = Enum.KeyCode.TouchPosition
    v3.UIModifier = a1.thumbstickButton
    v3.Parent = ThumbstickAction_upv_1
end
local function enableThumbstickInput(a1, a2)
    --[[
      name: enableThumbstickInput
      line: 60
      upvalues:
        setupThumbstickInput (copy, index: 1)
        ThumbstickAction_upv_1 (copy, index: 2)
    ]]
    if a2 then
        setupThumbstickInput(a1)
        a1.thumbstickStateChangedConn = ThumbstickAction_upv_1.StateChanged:Connect(a1.onStateChanged)
        ThumbstickAction_upv_1.Enabled = true
    else
        ThumbstickAction_upv_1.Enabled = false
        if a1.thumbstickStateChangedConn then
            a1.thumbstickStateChangedConn:Disconnect()
            a1.thumbstickStateChangedConn = nil
        end
    end
end
function u7.Enable(a1, a2, a3)
    --[[
      name: Enable
      line: 74
      upvalues:
        ActionController_upv_1 (copy, index: 1)
        u4 (copy, index: 2)
        setupThumbstickInput (copy, index: 3)
        ThumbstickAction_upv_1 (copy, index: 4)
    ]]
    if a2 == nil then
        return false
    elseif a1.enabled ~= a2 then
        ActionController_upv_1.Enable(a1, a2)
        a1.isJumping = false
        if a2 then
            if not (a1.thumbstickFrame) then
                a1:Create(a3)
            end
            if u4 then
                setupThumbstickInput(a1)
            end
            a1.thumbstickStateChangedConn = ThumbstickAction_upv_1.StateChanged:Connect(a1.onStateChanged)
            ThumbstickAction_upv_1.Enabled = true
            a1.thumbstickFrame.Visible = true
        else
            ThumbstickAction_upv_1.Enabled = false
            if a1.thumbstickStateChangedConn then
                a1.thumbstickStateChangedConn:Disconnect()
                a1.thumbstickStateChangedConn = nil
            end
            a1.thumbstickFrame.Visible = false
            a1:OnInputEnded()
        end
        a1.enabled = a2
    else
        return true
    end
end
function u7.OnInputEnded(a1)
    --[[
      name: OnInputEnded
      line: 112
    ]]
    a1.isTouchActive = false
    a1.thumbstickFrame.Position = a1.screenPos
    a1.stickImage.Position = UDim2.new(0, (a1.thumbstickFrame.Size.X.Offset / 2) - (a1.thumbstickSize / 4), 0, (a1.thumbstickFrame.Size.Y.Offset / 2) - (a1.thumbstickSize / 4))
    local ClassicThumbstickScriptableBinding_1 = a1.playerData.actions.MoveAction:FindFirstChild("ClassicThumbstickScriptableBinding")
    if ClassicThumbstickScriptableBinding_1 then
        ClassicThumbstickScriptableBinding_1:Fire(Vector2.zero)
    end
    a1.isJumping = false
    a1.thumbstickFrame.Position = a1.screenPos
end
function u7.Create(a1, a2)
    --[[
      name: Create
      line: 125
      upvalues:
        ThumbstickAction_upv_1 (copy, index: 1)
        u2 (copy, index: 2)
        u1 (copy, index: 3)
        u6 (copy, index: 4)
        AvatarAbilitiesInterface_upv_1 (copy, index: 5)
        u4 (copy, index: 6)
        u3 (copy, index: 7)
        u5 (copy, index: 8)
        GuiService_upv_1 (copy, index: 9)
    ]]
    if a1.thumbstickFrame then
        ThumbstickAction_upv_1.Enabled = false
        if a1.thumbstickStateChangedConn then
            a1.thumbstickStateChangedConn:Disconnect()
            a1.thumbstickStateChangedConn = nil
        end
        a1.thumbstickFrame:Destroy()
        a1.thumbstickFrame = nil
        if a1.absoluteSizeChangedConn then
            a1.absoluteSizeChangedConn:Disconnect()
            a1.absoluteSizeChangedConn = nil
        end
        if a1.avatarAbilitiesEnabledChangedConn then
            a1.avatarAbilitiesEnabledChangedConn:Disconnect()
            a1.avatarAbilitiesEnabledChangedConn = nil
        end
    end
    a1.thumbstickFrame = Instance.new("Frame")
    a1.thumbstickFrame.Name = (u2 and "ClassicThumbstickFrame") or "ThumbstickFrame"
    a1.thumbstickFrame.Active = true
    a1.thumbstickFrame.Visible = false
    a1.thumbstickFrame.BackgroundTransparency = 1
    local u8 = Instance.new("ImageLabel")
    u8.Name = "OuterImage"
    u8.Image = "rbxasset://textures/ui/TouchControlsSheet.png"
    u8.ImageRectOffset = Vector2.new()
    u8.ImageRectSize = Vector2.new(220, 220)
    u8.BackgroundTransparency = 1
    u8.Position = UDim2.new(0, 0, 0, 0)
    a1.stickImage = Instance.new("ImageLabel")
    a1.stickImage.Name = "StickImage"
    a1.stickImage.Image = "rbxasset://textures/ui/TouchControlsSheet.png"
    a1.stickImage.ImageRectOffset = Vector2.new(220, 0)
    a1.stickImage.ImageRectSize = Vector2.new(111, 111)
    a1.stickImage.BackgroundTransparency = 1
    a1.stickImage.ZIndex = 2
    local function ResizeThumbstick()
        --[[
          name: ResizeThumbstick
          line: 168
          upvalues:
            a2 (copy, index: 1)
            u1 (copy, index: 2)
            u6 (copy, index: 3)
            AvatarAbilitiesInterface_upv_1 (copy, index: 4)
            a1 (copy, index: 5)
            u8 (copy, index: 6)
        ]]
        local v4 = math.min(a2.AbsoluteSize.X, a2.AbsoluteSize.Y) <= 500
        local v5
        if u1 then
            v5 = u6:isEnabled()
        else
            v5 = AvatarAbilitiesInterface_upv_1.isEnabled()
        end
        if v5 then
            local v6 = (v4 and 64) or 100
            local v7 = (v4 and 64) or 112
            a1.thumbstickSize = (v4 and 72) or 120
            a1.screenPos = UDim2.new(0, v6, 1, -a1.thumbstickSize - v7)
        else
            a1.thumbstickSize = (v4 and 70) or 120
            a1.screenPos = v4 and UDim2.new(0, (a1.thumbstickSize / 2) - 10, 1, -a1.thumbstickSize - 20) or UDim2.new(0, a1.thumbstickSize / 2, 1, -a1.thumbstickSize * 1.75)
        end
        a1.thumbstickFrame.Size = UDim2.new(0, a1.thumbstickSize, 0, a1.thumbstickSize)
        a1.thumbstickFrame.Position = a1.screenPos
        u8.Size = UDim2.new(0, a1.thumbstickSize, 0, a1.thumbstickSize)
        a1.stickImage.Size = UDim2.new(0, a1.thumbstickSize / 2, 0, a1.thumbstickSize / 2)
        a1.stickImage.Position = UDim2.new(0, (a1.thumbstickSize / 2) - (a1.thumbstickSize / 4), 0, (a1.thumbstickSize / 2) - (a1.thumbstickSize / 4))
    end
    ResizeThumbstick()
    a1.absoluteSizeChangedConn = a2:GetPropertyChangedSignal("AbsoluteSize"):Connect(ResizeThumbstick)
    if u1 then
        a1.avatarAbilitiesEnabledChangedConn = u6:GetEnabledChangedSignal():Connect(ResizeThumbstick)
    else
        a1.avatarAbilitiesEnabledChangedConn = AvatarAbilitiesInterface_upv_1.GetEnabledChangedSignal():Connect(ResizeThumbstick)
    end
    u8.Parent = a1.thumbstickFrame
    a1.stickImage.Parent = a1.thumbstickFrame
    a1.thumbstickButton = Instance.new("ImageButton")
    a1.thumbstickButton.Name = "ClassicThumbstickUIModifier"
    a1.thumbstickButton.BackgroundTransparency = 1
    a1.thumbstickButton.ImageTransparency = 1
    a1.thumbstickButton.AutoButtonColor = false
    a1.thumbstickButton.Size = UDim2.new(1, 0, 1, 0)
    a1.thumbstickButton.ZIndex = a1.thumbstickFrame.ZIndex
    a1.thumbstickButton.Visible = true
    a1.thumbstickButton.Active = false
    a1.thumbstickButton.Parent = a1.thumbstickFrame
    if not (u4) then
        ResizeThumbstick = Instance.new("InputBinding")
        ResizeThumbstick.Name = "ClassicTouchBinding"
        ResizeThumbstick.KeyCode = Enum.KeyCode.TouchPosition
        ResizeThumbstick.UIModifier = a1.thumbstickButton
        ResizeThumbstick.Parent = ThumbstickAction_upv_1
    end
    local u9 = nil
    local function MoveStick(a3)
        --[[
          name: MoveStick
          line: 246
          upvalues:
            u9 (ref,  index: 1)
            a1 (copy, index: 2)
            u3 (copy, index: 3)
            a2 (copy, index: 4)
        ]]
        local v9 = Vector2.new(a3.X - u9.X, a3.Y - u9.Y)
        local magnitude_1 = v9.magnitude
        local v10 = a1.thumbstickFrame.AbsoluteSize.X / 2
        if (a1.isFollowStick) and (v10 < magnitude_1) then
            local v11 = v9.unit * v10
            if u3 then
                local AbsolutePosition_1 = a2.AbsolutePosition
                a1.thumbstickFrame.Position = UDim2.new(0, ((a3.X - AbsolutePosition_1.X) - (a1.thumbstickFrame.AbsoluteSize.X / 2)) - v11.X, 0, ((a3.Y - AbsolutePosition_1.Y) - (a1.thumbstickFrame.AbsoluteSize.Y / 2)) - v11.Y)
            else
                a1.thumbstickFrame.Position = UDim2.new(0, (a3.X - (a1.thumbstickFrame.AbsoluteSize.X / 2)) - v11.X, 0, (a3.Y - (a1.thumbstickFrame.AbsoluteSize.Y / 2)) - v11.Y)
            end
        else
            v9 = v9.unit * math.min(magnitude_1, v10)
        end
        a1.stickImage.Position = UDim2.new(0, v9.X + (a1.stickImage.AbsoluteSize.X / 2), 0, v9.Y + (a1.stickImage.AbsoluteSize.Y / 2))
    end
    local function DoMove(a4)
        --[[
          name: DoMove
          line: 226
          upvalues:
            a1 (copy, index: 1)
        ]]
        local v12 = a4 / (a1.thumbstickSize / 2)
        local magnitude_2 = v12.magnitude
        local v13 = ((not (magnitude_2 < 0.05)) and (v12.unit * math.min(1, (magnitude_2 - 0.05) / 0.95))) or (Vector2.new())
        local v14 = Vector2.new(v13.X, -v13.Y)
        local ClassicThumbstickScriptableBinding_2 = a1.playerData.actions.MoveAction:FindFirstChild("ClassicThumbstickScriptableBinding")
        if not ClassicThumbstickScriptableBinding_2 then
            return
        end
        ClassicThumbstickScriptableBinding_2:Fire(v14)
    end
    a1.onStateChanged = function(a5)
        --[[
          line: 269
          upvalues:
            u5 (copy, index: 1)
            GuiService_upv_1 (copy, index: 2)
            a1 (copy, index: 3)
            u3 (copy, index: 4)
            a2 (copy, index: 5)
            u9 (ref,  index: 6)
            DoMove (copy, index: 7)
            MoveStick (copy, index: 8)
        ]]
        if a5 == u5 then
            if a1.isTouchActive then
                a1:OnInputEnded()
            end
        else
            local Min_1 = GuiService_upv_1:GetInsetArea(Enum.ScreenInsets.None).Min
            local v15 = Vector3.new(a5.X + Min_1.X, a5.Y + Min_1.Y, 0)
            if a1.isTouchActive then
                u9 = Vector2.new(a1.thumbstickFrame.AbsolutePosition.X + (a1.thumbstickFrame.AbsoluteSize.X / 2), a1.thumbstickFrame.AbsolutePosition.Y + (a1.thumbstickFrame.AbsoluteSize.Y / 2))
                DoMove((Vector2.new(v15.X - u9.X, v15.Y - u9.Y)))
                MoveStick(v15)
            else
                a1.isTouchActive = true
                if u3 then
                    local AbsolutePosition_2 = a2.AbsolutePosition
                    a1.thumbstickFrame.Position = UDim2.new(0, (v15.X - AbsolutePosition_2.X) - (a1.thumbstickFrame.Size.X.Offset / 2), 0, (v15.Y - AbsolutePosition_2.Y) - (a1.thumbstickFrame.Size.Y.Offset / 2))
                else
                    a1.thumbstickFrame.Position = UDim2.new(0, v15.X - (a1.thumbstickFrame.Size.X.Offset / 2), 0, v15.Y - (a1.thumbstickFrame.Size.Y.Offset / 2))
                end
                u9 = Vector2.new(a1.thumbstickFrame.AbsolutePosition.X + (a1.thumbstickFrame.AbsoluteSize.X / 2), a1.thumbstickFrame.AbsolutePosition.Y + (a1.thumbstickFrame.AbsoluteSize.Y / 2))
            end
        end
    end
    GuiService_upv_1.MenuOpened:Connect(
        function()
            --[[
              line: 308
              upvalues:
                a1 (copy, index: 1)
            ]]
            if not a1.isTouchActive then
                return
            end
            a1:OnInputEnded()
        end
    )
    a1.thumbstickFrame.Parent = a2
end
return u7