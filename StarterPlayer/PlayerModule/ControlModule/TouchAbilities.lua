local Players_upv_1 = game:GetService("Players")
local CommonUtils_1 = require(script.Parent.Parent:WaitForChild("CommonUtils"))
local u1 = require(script.Parent:WaitForChild("AvatarAbilitiesInterface")).get(Players_upv_1.LocalPlayer)
local InputSlots_upv_1 = require(script.Parent:WaitForChild("InputSlots"))
local v1 = CommonUtils_1.get("FlagUtil")
local u2 = v1.getUserFlag("UserAbilitiesUserInterfaceA")
local u3 = v1.getUserFlag("UserAbilitiesUserInterfaceC")
local tbl_upv_1 = {{small = {72, 60, 60}, large = {92, 112, 112}}, {small = {44, 132, 132}, large = {56, 200, 200}}, {small = {44, 132, 16}, large = {56, 200, 60}}, {small = {44, 16, 132}, large = {56, 60, 200}}, {small = {44, 156, 74}, large = {56, 228, 130}}, {small = {44, 74, 156}, large = {56, 130, 228}}, {small = {44, 16, 16}, large = {56, 60, 60}}}
local tbl_upv_2 = {28, 44}
local tbl_upv_3 = {36, 56}
local tbl_upv_4 = {16, 12}
local tbl_upv_5 = {16, 12}
local function IsPortrait()
    --[[
      name: IsPortrait
      line: 52
      upvalues:
        Players_upv_1 (copy, index: 1)
    ]]
    local v2 = Players_upv_1.LocalPlayer:FindFirstChildOfClass("PlayerGui")
    if v2 then
        return v2.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait
    end
    return false
end
local tbl_upv_6 = {}
tbl_upv_6.__index = tbl_upv_6
function tbl_upv_6.new(a1)
    --[[
      name: new
      line: 70
      upvalues:
        tbl_upv_6 (copy, index: 1)
    ]]
    local v3 = setmetatable({}, tbl_upv_6)
    v3.parentUIFrame = a1
    v3.managedButtons = {}
    v3.created = false
    v3.enabled = false
    v3.enabledChangedEvent = Instance.new("BindableEvent")
    return v3
end
function tbl_upv_6.Enable(a1, a2)
    --[[
      name: Enable
      line: 83
    ]]
    if a1.enabled == a2 then
        return
    end
    a1.enabled = a2
    if a2 and not (a1.created) then
        a1:Create()
        a1.created = true
    end
    a1.enabledChangedEvent:Fire()
end
function tbl_upv_6.CreateAbilityButton(a1, a2, a3, a4, a5, a6)
    --[[
      name: CreateAbilityButton
      line: 95
      upvalues:
        u1 (copy, index: 1)
    ]]
    local u4 = "rbxassetid://136780077406114"
    local u5 = "rbxassetid://76895455502876"
    local u6 = nil
    local u7 = false
    if a3.ButtonAssetId then
        local _ = a3.ButtonAssetId
    end
    if a3.ButtonPressedAssetId then
        local _ = a3.ButtonPressedAssetId
    end
    if a3.ButtonInvalidAssetId then
        local _ = a3.ButtonInvalidAssetId
    end
    local u8 = Instance.new("ImageButton")
    u8.Name = a2 .. "Button"
    u8.Visible = false
    u8.BackgroundTransparency = 1
    u8.Image = nil
    u8.Parent = a1.parentUIFrame
    for _, value_1 in a4:GetChildren() do
        if not (string.find(value_1.Name, "Touch")) then
            continue
        end
        if value_1:IsA("InputBinding") then
            value_1.UIButton = u8
            break
        end
    end
    local function ResizeButton()
        --[[
          name: ResizeButton
          line: 124
          upvalues:
            a1 (copy, index: 1)
            a5 (copy, index: 2)
            u8 (copy, index: 3)
            a6 (copy, index: 4)
        ]]
        local v4 = math.min(a1.parentUIFrame.AbsoluteSize.x, a1.parentUIFrame.AbsoluteSize.y) <= 500
        local v5 = v4 and a5.small or a5.large
        local v6 = v5[1]
        local v7 = v5[3]
        v5 = -v5[2] - v6
        u8.Size = UDim2.new(0, v6, 0, v6)
        if a6 then
            u8.Position = UDim2.new(1, v5, 0, v7)
        else
            u8.Position = UDim2.new(1, v5, 1, -v7 - v6)
        end
    end
    ResizeButton()
    local tbl_upv_7 = {}
    table.insert(tbl_upv_7, a1.parentUIFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(ResizeButton))
    local function UpdateButtonState()
        --[[
          name: UpdateButtonState
          line: 151
          upvalues:
            u1 (copy, index: 1)
            a2 (copy, index: 2)
            u8 (copy, index: 3)
            a1 (copy, index: 4)
            a4 (copy, index: 5)
            u7 (ref,  index: 6)
            u5 (ref,  index: 7)
            u4 (ref,  index: 8)
            u6 (ref,  index: 9)
        ]]
        local v8 = u1:GetAbilityValid(a2)
        local v9 = u1:GetAbilityActive(a2)
        u8.Visible = a1.enabled and (a4.Enabled)
        if not u8.Visible then
            return
        end
        if (v9) or u7 and v8 then
            u8.Image = u5
            u8.ImageTransparency = 0
            return
        end
        if v8 then
            u8.Image = u4
            u8.ImageTransparency = 0
        elseif u6 then
            u8.Image = u6
            u8.ImageTransparency = 0
        else
            u8.Image = u4
            u8.ImageTransparency = 0.6
        end
    end
    UpdateButtonState()
    u8.MouseButton1Down:Connect(
        function()
            --[[
              line: 176
              upvalues:
                u7 (ref,  index: 1)
                UpdateButtonState (copy, index: 2)
            ]]
            u7 = true
            UpdateButtonState()
        end
    )
    u8.MouseButton1Up:Connect(
        function()
            --[[
              line: 181
              upvalues:
                u7 (ref,  index: 1)
                UpdateButtonState (copy, index: 2)
            ]]
            u7 = false
            UpdateButtonState()
        end
    )
    u8.MouseLeave:Connect(
        function()
            --[[
              line: 186
              upvalues:
                u7 (ref,  index: 1)
                UpdateButtonState (copy, index: 2)
            ]]
            u7 = false
            UpdateButtonState()
        end
    )
    table.insert(tbl_upv_7, u1:GetAbilityActiveChangedSignal(a2):Connect(UpdateButtonState))
    table.insert(tbl_upv_7, u1:GetAbilityValidChangedSignal(a2):Connect(UpdateButtonState))
    table.insert(tbl_upv_7, a1.enabledChangedEvent.Event:Connect(UpdateButtonState))
    table.insert(tbl_upv_7, a4:GetPropertyChangedSignal("Enabled"):Connect(UpdateButtonState))
    u8.Destroying:Connect(
        function()
            --[[
              line: 196
              upvalues:
                tbl_upv_7 (copy, index: 1)
            ]]
            for _, value_2 in tbl_upv_7 do
                value_2:Disconnect()
            end
            table.clear(tbl_upv_7)
        end
    )
    return u8
end
function tbl_upv_6.CreateOverflowScrollButton(a1, a2)
    --[[
      name: CreateOverflowScrollButton
      line: 206
      upvalues:
        Players_upv_1 (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
        tbl_upv_3 (copy, index: 3)
        tbl_upv_4 (copy, index: 4)
        tbl_upv_5 (copy, index: 5)
        InputSlots_upv_1 (copy, index: 6)
    ]]
    local u9 = Instance.new("ImageButton")
    u9.Name = "ScrollButton"
    u9.BackgroundTransparency = 1
    u9.Image = "rbxassetid://120193229129639"
    u9.PressedImage = "rbxassetid://122643389561468"
    u9.Parent = a1.parentUIFrame
    local function ResizeButton_2()
        --[[
          name: ResizeButton
          line: 217
          upvalues:
            a1 (copy, index: 1)
            Players_upv_1 (copy, index: 2)
            tbl_upv_2 (copy, index: 3)
            tbl_upv_3 (copy, index: 4)
            tbl_upv_4 (copy, index: 5)
            tbl_upv_5 (copy, index: 6)
            u9 (copy, index: 7)
            a2 (copy, index: 8)
        ]]
        local v10 = math.min(a1.parentUIFrame.AbsoluteSize.x, a1.parentUIFrame.AbsoluteSize.y)
        local v11 = Players_upv_1.LocalPlayer:FindFirstChildOfClass("PlayerGui")
        local v12
        if v11 then
            v12 = v11.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait
        else
            v12 = false
        end
        local v13 = v10 <= 500
        if not (v13) or not (tbl_upv_2) then
            v10 = tbl_upv_3
        end
        local v14 = (v13 and tbl_upv_4) or tbl_upv_5
        local v15 = (v13 and 8) or 10
        local v16 = (v13 and 44) or 56
        u9.Size = UDim2.new(0, v10[1], 0, v10[2])
        if a2 then
            if v12 then
                u9.Position = UDim2.new(1, (-v14[1] - v10[2]) + (0.5 * (v10[2] - v10[1])), 0, (((v14[2] + v10[1]) + (4 * v15)) + (3 * v16)) - (0.5 * (v10[2] - v10[1])))
                u9.Rotation = 270
            else
                u9.Position = UDim2.new(1, ((-v14[1] - (2 * v10[1])) - (4 * v15)) - (3 * v16), 0, v14[2])
                u9.Rotation = 0
            end
        else
            u9.Position = UDim2.new(1, -v14[1] - v10[1], 0, v14[2])
            if v12 then
                u9.Position = UDim2.new(1, (-v14[1] - v10[2]) + (0.5 * (v10[2] - v10[1])), 0, v14[2] - (0.5 * (v10[2] - v10[1])))
                u9.Rotation = 90
            else
                u9.Position = UDim2.new(1, -v14[1] - v10[1], 0, v14[2])
                u9.Rotation = 180
            end
        end
    end
    ResizeButton_2()
    local tbl_upv_8 = {}
    table.insert(tbl_upv_8, a1.parentUIFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(ResizeButton_2))
    u9.Activated:Connect(
        function()
            --[[
              line: 253
              upvalues:
                a2 (copy, index: 1)
                InputSlots_upv_1 (copy, index: 2)
            ]]
            if a2 then
                InputSlots_upv_1.setOverflowScrollIndex(InputSlots_upv_1.getOverflowScrollIndex() + 1)
            else
                InputSlots_upv_1.setOverflowScrollIndex(InputSlots_upv_1.getOverflowScrollIndex() - 1)
            end
        end
    )
    u9.Destroying:Connect(
        function()
            --[[
              line: 261
              upvalues:
                tbl_upv_8 (copy, index: 1)
            ]]
            for _, value_3 in tbl_upv_8 do
                value_3:Disconnect()
            end
            table.clear(tbl_upv_8)
        end
    )
    return u9
end
function tbl_upv_6.Create(a1)
    --[[
      name: Create
      line: 271
      upvalues:
        u1 (copy, index: 1)
        InputSlots_upv_1 (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
        u3 (copy, index: 5)
        tbl_upv_2 (copy, index: 6)
        tbl_upv_3 (copy, index: 7)
        Players_upv_1 (copy, index: 8)
        tbl_upv_4 (copy, index: 9)
        tbl_upv_5 (copy, index: 10)
    ]]
    if not a1.parentUIFrame then
        return
    end
    local function CreateButtons()
        --[[
          name: CreateButtons
          line: 276
          upvalues:
            a1 (copy, index: 1)
            u1 (copy, index: 2)
            InputSlots_upv_1 (copy, index: 3)
            tbl_upv_1 (copy, index: 4)
            u3 (copy, index: 6)
            tbl_upv_2 (copy, index: 7)
            tbl_upv_3 (copy, index: 8)
            Players_upv_1 (copy, index: 9)
            tbl_upv_4 (copy, index: 10)
            tbl_upv_5 (copy, index: 11)
        ]]
        for _, value_4 in a1.managedButtons do
            value_4:Destroy()
        end
        a1.managedButtons = {}
        if not u1:isEnabled() then
            return
        end
        for key_1, value_5 in pairs(InputSlots_upv_1.GetSlotMap()) do
            local v17 = InputSlots_upv_1.GetActionInSlot(key_1)
            if not (value_5) or not (v17) then
                continue
            end
            if key_1 <= #tbl_upv_1 and (u2 or key_1 == 1) then
                table.insert(a1.managedButtons, a1:CreateAbilityButton(value_5, u1:GetAbilityConfig(value_5), v17, tbl_upv_1[key_1], false))
            end
        end
        if not u2 then
            return
        end
        if u3 then
            local v18 = InputSlots_upv_1.GetAbilitiesInOverflow()
            local v19 = 0
            local v20 = 0
            local v21
            if InputSlots_upv_1.GetNumOverflowSlots() < #v18 then
                if InputSlots_upv_1.getOverflowScrollIndex() > 0 then
                    table.insert(a1.managedButtons, a1:CreateOverflowScrollButton(false))
                end
                if InputSlots_upv_1.getOverflowScrollIndex() < #v18 - InputSlots_upv_1.GetNumOverflowSlots() then
                    table.insert(a1.managedButtons, a1:CreateOverflowScrollButton(true))
                end
                v19, v21 = tbl_upv_2[1] + 8, tbl_upv_3[1] + 10
            else
                v21 = v20
            end
            local v22 = nil
            for n_1 = 1, math.min(#v18, InputSlots_upv_1.GetNumOverflowSlots()) do
                local v23 = v18[n_1 + InputSlots_upv_1.getOverflowScrollIndex()]
                local v24 = InputSlots_upv_1.GetOverflowAction(n_1)
                if not (v23) or not (v24) then
                    continue
                end
                local v25 = u1:GetAbilityConfig(v23)
                local v26 = Players_upv_1.LocalPlayer:FindFirstChildOfClass("PlayerGui")
                local v27
                if v26 then
                    v27 = v26.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait
                else
                    v27 = false
                end
                if v27 then
                    local tbl_9 = {}
                    tbl_9.small = {44, tbl_upv_4[1], (tbl_upv_4[2] + v19) + ((n_1 - 1) * 52)}
                    tbl_9.large = {56, tbl_upv_5[1], (tbl_upv_5[2] + v21) + ((n_1 - 1) * 66)}
                    v22 = tbl_9
                else
                    local tbl_10 = {}
                    tbl_10.small = {44, (tbl_upv_4[1] + v19) + ((n_1 - 1) * 52), tbl_upv_4[2]}
                    tbl_10.large = {56, (tbl_upv_5[1] + v21) + ((n_1 - 1) * 66), tbl_upv_5[2]}
                    v22 = tbl_10
                end
                table.insert(a1.managedButtons, a1:CreateAbilityButton(v23, v25, v24, v22, true))
            end
        end
    end
    CreateButtons()
    InputSlots_upv_1.GetSlotMapChangedSignal():Connect(CreateButtons)
    u1:GetEnabledChangedSignal():Connect(CreateButtons)
    InputSlots_upv_1.getScrollIndexChangedEvent():Connect(CreateButtons)
    local v28 = Players_upv_1.LocalPlayer:WaitForChild("PlayerGui", 5)
    if not v28 then
        return
    end
    v28:GetPropertyChangedSignal("CurrentScreenOrientation"):Connect(CreateButtons)
end
return tbl_upv_6