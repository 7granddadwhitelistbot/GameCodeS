local CommonUtils_1 = require(script.Parent.Parent:WaitForChild("CommonUtils"))
local u1 = CommonUtils_1.get("ConnectionUtil")
local u2 = CommonUtils_1.get("CharacterUtil")
local v1 = CommonUtils_1.get("FlagUtil")
local u3 = v1.getUserFlag("UserPlayerScriptsCCLIntegrationD")
local u4 = v1.getUserFlag("UserPlayerScriptsRefactor1")
local u5 = v1.getUserFlag("UserPlayerScriptsFixTouchJumpVisibility")
local _ = game:GetService("Players")
local AvatarAbilitiesInterface_upv_1 = require(script.Parent:WaitForChild("AvatarAbilitiesInterface"))
local tbl_upv_1 = {"rbxasset://textures/ui/Input/JumpButtonRegular.png", "rbxasset://textures/ui/Input/JumpButtonPressed.png"}
local ActionController_upv_1 = require(script.Parent:WaitForChild("ActionController"))
local u6 = setmetatable({}, ActionController_upv_1)
u6.__index = u6
function u6.new(a1)
    --[[
      name: new
      line: 61
      upvalues:
        ActionController_upv_1 (copy, index: 1)
        u6 (copy, index: 2)
        u5 (copy, index: 3)
        u1 (copy, index: 4)
    ]]
    local u7 = setmetatable(ActionController_upv_1.new(), u6)
    u7.data = a1
    a1.eventBus:subscribe("ACTIONS_RELOADED"):Connect(
        function()
            --[[
              line: 65
              upvalues:
                u7 (copy, index: 1)
                u5 (copy, index: 2)
            ]]
            u7:Create()
            if not u5 or not u7._active then
                return
            end
            u7._active = false
            u7:EnableButton(true)
        end
    )
    u7.parentUIFrame = nil
    u7.jumpButton = nil
    u7.externallyEnabled = false
    u7._active = false
    u7._connectionUtil = u1.new()
    return u7
end
function u6._reset(a1)
    --[[
      name: _reset
      line: 83
      upvalues:
        u3 (copy, index: 1)
        AvatarAbilitiesInterface_upv_1 (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
    ]]
    if not a1.jumpButton then
        return
    end
    if (u3) or not AvatarAbilitiesInterface_upv_1.isEnabled() then
        a1.jumpButton.ImageRectOffset = Vector2.new(1, 146)
    end
    a1.jumpButton.Image = tbl_upv_1[1]
end
function u6.EnableButton(a1, a2)
    --[[
      name: EnableButton
      line: 96
    ]]
    if a2 == a1._active then
        return
    end
    if a2 then
        if not (a1.jumpButton) then
            a1:Create()
        end
        a1.jumpButton.Visible = true
    elseif a1.jumpButton then
        a1.jumpButton.Visible = false
    end
    a1:_reset()
    a1._active = a2
end
function u6.UpdateEnabled(a1)
    --[[
      name: UpdateEnabled
      line: 115
      upvalues:
        u2 (copy, index: 1)
    ]]
    local v2 = u2.getChild("Humanoid", "Humanoid")
    if v2 and a1.externallyEnabled and (v2.UseJumpPower and v2.JumpPower > 0 or not (v2.UseJumpPower) and v2.JumpHeight > 0) and v2:GetStateEnabled(Enum.HumanoidStateType.Jumping) then
        a1:EnableButton(true)
        return
    end
    a1:EnableButton(false)
end
function u6._setupConfigurations(a1)
    --[[
      name: _setupConfigurations
      line: 124
      upvalues:
        u2 (copy, index: 1)
    ]]
    local function update()
        --[[
          name: update
          line: 125
          upvalues:
            a1 (copy, index: 1)
        ]]
        a1:UpdateEnabled()
    end
    a1._connectionUtil:trackConnection(
        "HUMANOID",
        (u2.onChild(
            "Humanoid",
            "Humanoid",
            function(a2)
                --[[
                  line: 130
                  upvalues:
                    a1 (copy, index: 1)
                    update (copy, index: 2)
                ]]
                a1:UpdateEnabled()
                a1:_reset()
                a1._connectionUtil:trackConnection("HUMANOID_JUMP_POWER", a2:GetPropertyChangedSignal("JumpPower"):Connect(update))
                a1._connectionUtil:trackConnection("HUMANOID_JUMP_HEIGHT", a2:GetPropertyChangedSignal("JumpHeight"):Connect(update))
                a1._connectionUtil:trackConnection(
                    "HUMANOID_STATE_ENABLED_CHANGED",
                    a2.StateEnabledChanged:Connect(
                        function(a3, a4)
                            --[[
                              line: 143
                              upvalues:
                                a1 (copy, index: 1)
                            ]]
                            if a3 ~= Enum.HumanoidStateType.Jumping or a4 == a1._active then
                                return
                            end
                            a1:UpdateEnabled()
                        end
                    )
                )
            end
        ))
    )
end
function u6.Enable(a1, a2, a3)
    --[[
      name: Enable
      line: 155
      upvalues:
        ActionController_upv_1 (copy, index: 1)
    ]]
    if a3 then
        a1.parentUIFrame = a3
    end
    if a1.externallyEnabled == a2 then
        return
    end
    a1.externallyEnabled = a2
    ActionController_upv_1.Enable(a1, a2)
    a1:UpdateEnabled()
    if a2 then
        a1:_setupConfigurations()
    else
        a1._connectionUtil:disconnectAll()
    end
end
function u6.Create(a1)
    --[[
      name: Create
      line: 173
      upvalues:
        u3 (copy, index: 1)
        u4 (copy, index: 2)
        AvatarAbilitiesInterface_upv_1 (copy, index: 3)
        tbl_upv_1 (copy, index: 4)
    ]]
    if not a1.parentUIFrame then
        return
    end
    if a1.jumpButton then
        a1.jumpButton:Destroy()
        a1.jumpButton = nil
    end
    if a1.absoluteSizeChangedConn then
        a1.absoluteSizeChangedConn:Disconnect()
        a1.absoluteSizeChangedConn = nil
    end
    if not (u3) and a1.avatarAbilitiesEnabledChangedConn then
        a1.avatarAbilitiesEnabledChangedConn:Disconnect()
        a1.avatarAbilitiesEnabledChangedConn = nil
    end
    a1.jumpButton = Instance.new("ImageButton")
    a1.jumpButton.Name = "JumpButton"
    a1.jumpButton.Visible = false
    a1.jumpButton.BackgroundTransparency = 1
    if u4 then
        a1.jumpButton.ZIndex = 10
    end
    if u3 or not (AvatarAbilitiesInterface_upv_1.isEnabled()) then
        a1.jumpButton.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
        a1.jumpButton.ImageRectOffset = Vector2.new(1, 146)
        a1.jumpButton.ImageRectSize = Vector2.new(144, 144)
    else
        a1.jumpButton.Image = tbl_upv_1[1]
    end
    local function ResizeJumpButton()
        --[[
          name: ResizeJumpButton
          line: 211
          upvalues:
            a1 (copy, index: 1)
            u3 (copy, index: 2)
            AvatarAbilitiesInterface_upv_1 (copy, index: 3)
            tbl_upv_1 (copy, index: 4)
        ]]
        local v3 = math.min(a1.parentUIFrame.AbsoluteSize.x, a1.parentUIFrame.AbsoluteSize.y) <= 500
        if not (u3) and AvatarAbilitiesInterface_upv_1.isEnabled() then
            local v4 = (v3 and 72) or 120
            local v5 = (v3 and 64) or 100
            local v6 = (v3 and 64) or 112
            a1.jumpButton.Image = tbl_upv_1[1]
            a1.jumpButton.ImageRectOffset = Vector2.new(0, 0)
            a1.jumpButton.ImageRectSize = Vector2.new(0, 0)
            a1.jumpButton.Size = UDim2.new(0, v4, 0, v4)
            a1.jumpButton.Position = UDim2.new(1, -v4 - v5, 1, -v4 - v6)
            return
        end
        local v7 = (v3 and 70) or 120
        a1.jumpButton.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
        a1.jumpButton.ImageRectOffset = Vector2.new(1, 146)
        a1.jumpButton.ImageRectSize = Vector2.new(144, 144)
        a1.jumpButton.Size = UDim2.new(0, v7, 0, v7)
        local jumpButton_1 = a1.jumpButton
        jumpButton_1.Position = v3 and UDim2.new(1, -((v7 * 1.5) - 10), 1, -v7 - 20) or UDim2.new(1, -((v7 * 1.5) - 10), 1, -v7 * 1.75)
    end
    ResizeJumpButton()
    a1.absoluteSizeChangedConn = a1.parentUIFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(ResizeJumpButton)
    if not (u3) then
        a1.avatarAbilitiesEnabledChangedConn = AvatarAbilitiesInterface_upv_1.GetEnabledChangedSignal():Connect(ResizeJumpButton)
    end
    a1.jumpButton.Parent = a1.parentUIFrame
    if not a1.data.actions.JumpAction then
        return
    end
    a1.data.actions.JumpAction:WaitForChild("TouchBinding").UIButton = a1.jumpButton
    a1.data.actions.JumpAction.Pressed:Connect(
        function()
            --[[
              line: 253
              upvalues:
                a1 (copy, index: 1)
                u3 (copy, index: 2)
                AvatarAbilitiesInterface_upv_1 (copy, index: 3)
                tbl_upv_1 (copy, index: 4)
            ]]
            if not a1.jumpButton then
                return
            end
            if not (u3) and AvatarAbilitiesInterface_upv_1.isEnabled() then
                a1.jumpButton.Image = tbl_upv_1[2]
            else
                a1.jumpButton.ImageRectOffset = Vector2.new(146, 146)
            end
        end
    )
    a1.data.actions.JumpAction.Released:Connect(
        function()
            --[[
              line: 265
              upvalues:
                a1 (copy, index: 1)
                u3 (copy, index: 2)
                AvatarAbilitiesInterface_upv_1 (copy, index: 3)
                tbl_upv_1 (copy, index: 4)
            ]]
            if not a1.jumpButton then
                return
            end
            if not (u3) and AvatarAbilitiesInterface_upv_1.isEnabled() then
                a1.jumpButton.Image = tbl_upv_1[1]
            else
                a1.jumpButton.ImageRectOffset = Vector2.new(1, 146)
            end
        end
    )
end
return u6