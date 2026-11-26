local CommonUtils = require(script.Parent.Parent:WaitForChild("CommonUtils"))
local v2 = CommonUtils.get("ConnectionUtil")
local v3 = CommonUtils.get("CharacterUtil")
local v4 = CommonUtils.get("FlagUtil")
local userFlag = v4.getUserFlag("UserPlayerScriptsCCLIntegrationD")
    or v4.getUserFlag("UserPlayerScriptsCCLIntegrationDGA")
local userFlag2 = v4.getUserFlag("UserPlayerScriptsRefactor1")
local userFlag3 = v4.getUserFlag("UserPlayerScriptsFixTouchJumpVisibility")
game:GetService("Players")
local AvatarAbilitiesInterface = require(script.Parent:WaitForChild("AvatarAbilitiesInterface"))
local v9 = {"rbxasset://textures/ui/Input/JumpButtonRegular.png", "rbxasset://textures/ui/Input/JumpButtonPressed.png"}
local ActionController = require(script.Parent:WaitForChild("ActionController"))
local v11 = setmetatable({}, ActionController)
v11.__index = v11

function v11.new(data)
    --[[
      name: new
      line: 66
      upvalues:
        ActionController (copy, index: 1)
        v11 (copy, index: 2)
        userFlag3 (copy, index: 3)
        v2 (copy, index: 4)
    ]]
    local v13 = setmetatable(ActionController.new(), v11)
    v13.data = data

    v13._actionsReloadedConn = data.eventBus:subscribe("ACTIONS_RELOADED"):Connect(
        function()
            --[[
              line: 70
              upvalues:
                v13 (copy, index: 1)
                userFlag3 (copy, index: 2)
            ]]
            v13:Create()

            if userFlag3 and v13._active then
                v13._active = false
                v13:EnableButton(true)
            end
        end
    )

    v13.parentUIFrame = nil
    v13.jumpButton = nil
    v13.externallyEnabled = false
    v13._active = false
    v13._connectionUtil = v2.new()

    return v13
end

function v11._reset(self)
    --[[
      name: _reset
      line: 88
      upvalues:
        userFlag (copy, index: 1)
        AvatarAbilitiesInterface (copy, index: 2)
        v9 (copy, index: 3)
    ]]
    if self.jumpButton then
        if not userFlag and AvatarAbilitiesInterface.isEnabled() then
            self.jumpButton.Image = v9[1]
            return
        end

        self.jumpButton.ImageRectOffset = Vector2.new(1, 146)
    end
end

function v11.EnableButton(self, active)
    --[[
      name: EnableButton
      line: 101
    ]]
    if active == self._active then
        return
    end

    if active then
        if not self.jumpButton then
            self:Create()
        end

        self.jumpButton.Visible = true
    elseif self.jumpButton then
        self.jumpButton.Visible = false
    end

    self:_reset()
    self._active = active
end

function v11.UpdateEnabled(a17)
    --[[
      name: UpdateEnabled
      line: 120
      upvalues:
        v3 (copy, index: 1)
    ]]
    local child = v3.getChild("Humanoid", "Humanoid")

    if not child
        or not a17.externallyEnabled
        or (not child.UseJumpPower or not (0 < child.JumpPower))
            and (child.UseJumpPower or not (0 < child.JumpHeight))
        or not child:GetStateEnabled(Enum.HumanoidStateType.Jumping)
    then
        a17:EnableButton(false)
        return
    end

    a17:EnableButton(true)
end

function v11._setupConfigurations(a19)
    --[[
      name: _setupConfigurations
      line: 134
      upvalues:
        v3 (copy, index: 1)
    ]]
    local function update()
        --[[
          name: update
          line: 135
          upvalues:
            a19 (copy, index: 1)
        ]]
        a19:UpdateEnabled()
    end

    local v21 = v3.onChild(
        "Humanoid",
        "Humanoid",
        function(a22)
            --[[
              line: 140
              upvalues:
                a19 (copy, index: 1)
                update (copy, index: 2)
            ]]
            a19:UpdateEnabled()
            a19:_reset()
            a19._connectionUtil:trackConnection("HUMANOID_JUMP_POWER", a22:GetPropertyChangedSignal("JumpPower"):Connect(update))
            a19._connectionUtil:trackConnection("HUMANOID_JUMP_HEIGHT", a22:GetPropertyChangedSignal("JumpHeight"):Connect(update))

            a19._connectionUtil:trackConnection(
                "HUMANOID_STATE_ENABLED_CHANGED",
                a22.StateEnabledChanged:Connect(
                    function(a23, a24)
                        --[[
                          line: 153
                          upvalues:
                            a19 (copy, index: 1)
                        ]]
                        if a23 == Enum.HumanoidStateType.Jumping and a24 ~= a19._active then
                            a19:UpdateEnabled()
                        end
                    end
                )
            )
        end
    )

    a19._connectionUtil:trackConnection("HUMANOID", v21)
end

function v11.Enable(a25, externallyEnabled, parentUiFrame)
    --[[
      name: Enable
      line: 165
      upvalues:
        ActionController (copy, index: 1)
    ]]
    if parentUiFrame then
        a25.parentUIFrame = parentUiFrame
    end

    if a25.externallyEnabled == externallyEnabled then
        return
    end

    a25.externallyEnabled = externallyEnabled
    ActionController.Enable(a25, externallyEnabled)
    a25:UpdateEnabled()

    if externallyEnabled then
        a25:_setupConfigurations()
        return
    end

    a25._connectionUtil:disconnectAll()
end

function v11.Destroy(a28)
    --[[
      name: Destroy
      line: 185
    ]]
    if a28._actionsReloadedConn then
        a28._actionsReloadedConn:Disconnect()
        a28._actionsReloadedConn = nil
    end

    if a28.jumpButton then
        a28.jumpButton:Destroy()
        a28.jumpButton = nil
    end

    if a28.absoluteSizeChangedConn then
        a28.absoluteSizeChangedConn:Disconnect()
        a28.absoluteSizeChangedConn = nil
    end

    if a28.avatarAbilitiesEnabledChangedConn then
        a28.avatarAbilitiesEnabledChangedConn:Disconnect()
        a28.avatarAbilitiesEnabledChangedConn = nil
    end

    a28._connectionUtil:disconnectAll()
    a28.externallyEnabled = false
    a28._active = false
    a28.parentUIFrame = nil
end

function v11.Create(self)
    --[[
      name: Create
      line: 208
      upvalues:
        userFlag (copy, index: 1)
        userFlag2 (copy, index: 2)
        AvatarAbilitiesInterface (copy, index: 3)
        v9 (copy, index: 4)
    ]]
    if not self.parentUIFrame then
        return
    end

    if self.jumpButton then
        self.jumpButton:Destroy()
        self.jumpButton = nil
    end

    if self.absoluteSizeChangedConn then
        self.absoluteSizeChangedConn:Disconnect()
        self.absoluteSizeChangedConn = nil
    end

    if not userFlag and self.avatarAbilitiesEnabledChangedConn then
        self.avatarAbilitiesEnabledChangedConn:Disconnect()
        self.avatarAbilitiesEnabledChangedConn = nil
    end

    self.jumpButton = Instance.new("ImageButton")
    self.jumpButton.Name = "JumpButton"
    self.jumpButton.Visible = false
    self.jumpButton.BackgroundTransparency = 1

    if userFlag2 then
        self.jumpButton.ZIndex = 10
    end

    if userFlag or not AvatarAbilitiesInterface.isEnabled() then
        self.jumpButton.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
        self.jumpButton.ImageRectOffset = Vector2.new(1, 146)
        self.jumpButton.ImageRectSize = Vector2.new(144, 144)
    else
        self.jumpButton.Image = v9[1]
    end

    local function ResizeJumpButton()
        --[[
          name: ResizeJumpButton
          line: 246
          upvalues:
            self (copy, index: 1)
            userFlag (copy, index: 2)
            AvatarAbilitiesInterface (copy, index: 3)
            v9 (copy, index: 4)
        ]]
        local v31 = math.min(self.parentUIFrame.AbsoluteSize.x, self.parentUIFrame.AbsoluteSize.y) <= 500

        if not userFlag and AvatarAbilitiesInterface.isEnabled() then
            local v32 = v31 and 72 or 120
            local v33 = v31 and 64 or 100
            local v34 = v31 and 64 or 112
            local v35 = -v32 - v33
            local v36 = -v32 - v34
            self.jumpButton.Image = v9[1]
            self.jumpButton.ImageRectOffset = Vector2.new(0, 0)
            self.jumpButton.ImageRectSize = Vector2.new(0, 0)
            self.jumpButton.Size = UDim2.new(0, v32, 0, v32)
            self.jumpButton.Position = UDim2.new(1, v35, 1, v36)

            return
        end

        local v37 = v31 and 70 or 120
        self.jumpButton.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
        self.jumpButton.ImageRectOffset = Vector2.new(1, 146)
        self.jumpButton.ImageRectSize = Vector2.new(144, 144)
        self.jumpButton.Size = UDim2.new(0, v37, 0, v37)
        self.jumpButton.Position = v31 and UDim2.new(1, -((v37 * 1.5) - 10), 1, -v37 - 20)
            or UDim2.new(1, -((v37 * 1.5) - 10), 1, -v37 * 1.75)
    end

    ResizeJumpButton()
    self.absoluteSizeChangedConn = self.parentUIFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(ResizeJumpButton)

    if not userFlag then
        self.avatarAbilitiesEnabledChangedConn = AvatarAbilitiesInterface.GetEnabledChangedSignal():Connect(ResizeJumpButton)
    end

    self.jumpButton.Parent = self.parentUIFrame

    if not self.data.controlModule.actions.JumpAction then
        return
    end

    self.data.controlModule.actions.JumpAction:WaitForChild("TouchBinding").UIButton = self.jumpButton

    self.data.controlModule.actions.JumpAction.Pressed:Connect(
        function()
            --[[
              line: 290
              upvalues:
                self (copy, index: 1)
                userFlag (copy, index: 2)
                AvatarAbilitiesInterface (copy, index: 3)
                v9 (copy, index: 4)
            ]]
            if not self.jumpButton then
                return
            end

            if not userFlag and AvatarAbilitiesInterface.isEnabled() then
                self.jumpButton.Image = v9[2]
                return
            end

            self.jumpButton.ImageRectOffset = Vector2.new(146, 146)
        end
    )

    self.data.controlModule.actions.JumpAction.Released:Connect(
        function()
            --[[
              line: 302
              upvalues:
                self (copy, index: 1)
                userFlag (copy, index: 2)
                AvatarAbilitiesInterface (copy, index: 3)
                v9 (copy, index: 4)
            ]]
            if not self.jumpButton then
                return
            end

            if not userFlag and AvatarAbilitiesInterface.isEnabled() then
                self.jumpButton.Image = v9[1]
                return
            end

            self.jumpButton.ImageRectOffset = Vector2.new(1, 146)
        end
    )
end

return v11