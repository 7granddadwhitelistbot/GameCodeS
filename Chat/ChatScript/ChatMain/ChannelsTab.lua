local tbl_1 = {}
local ChatSettings_upv_1 = require(game:GetService("Chat"):WaitForChild("ClientChatModules"):WaitForChild("ChatSettings"))
local CurveUtil_upv_1 = require(script.Parent:WaitForChild("CurveUtil"))
local tbl_upv_2 = {}
tbl_upv_2.__index = tbl_upv_2
function tbl_upv_2.Destroy(a1)
    --[[
      name: Destroy
      line: 141
    ]]
    a1.GuiObject:Destroy()
end
function tbl_upv_2.UpdateMessagePostedInChannel(a1, a2)
    --[[
      name: UpdateMessagePostedInChannel
      line: 145
    ]]
    if a1.Active and a2 ~= true then
        return
    end
    local v1 = a1.UnreadMessageCount + 1
    a1.UnreadMessageCount = v1
    local NewMessageIcon_1 = a1.NewMessageIcon
    NewMessageIcon_1.Visible = true
    local TextLabel_1 = NewMessageIcon_1.TextLabel
    TextLabel_1.Text = v1 < 100 and tostring(v1) or "!"
    local _ = NewMessageIcon_1.Position + UDim2.new(0, 0, -0.1, 0)
    NewMessageIcon_1.Position = UDim2.new(0, 0, -0.15, 0)
    NewMessageIcon_1:TweenPosition(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
end
function tbl_upv_2.SetActive(a1, a2)
    --[[
      name: SetActive
      line: 168
    ]]
    a1.Active = a2
    a1.UnselectedFrame.Visible = not a2
    a1.SelectedFrame.Visible = a2
    if a2 then
        a1.UnreadMessageCount = 0
        a1.NewMessageIcon.Visible = false
        a1.NameTag.Font = Enum.Font.SourceSansBold
    else
        a1.NameTag.Font = Enum.Font.SourceSans
    end
end
function tbl_upv_2.SetTextSize(a1, a2)
    --[[
      name: SetTextSize
      line: 184
    ]]
    a1.NameTag.TextSize = a2
end
function tbl_upv_2.FadeOutBackground(a1, a2)
    --[[
      name: FadeOutBackground
      line: 188
      upvalues:
        CurveUtil_upv_1 (copy, index: 1)
    ]]
    a1.AnimParams.Background_TargetTransparency = 1
    a1.AnimParams.Background_NormalizedExptValue = CurveUtil_upv_1:NormalizedDefaultExptValueInSeconds(a2)
end
function tbl_upv_2.FadeInBackground(a1, a2)
    --[[
      name: FadeInBackground
      line: 193
      upvalues:
        CurveUtil_upv_1 (copy, index: 1)
    ]]
    a1.AnimParams.Background_TargetTransparency = 0.6
    a1.AnimParams.Background_NormalizedExptValue = CurveUtil_upv_1:NormalizedDefaultExptValueInSeconds(a2)
end
function tbl_upv_2.FadeOutText(a1, a2)
    --[[
      name: FadeOutText
      line: 198
      upvalues:
        CurveUtil_upv_1 (copy, index: 1)
    ]]
    a1.AnimParams.Text_TargetTransparency = 1
    a1.AnimParams.Text_NormalizedExptValue = CurveUtil_upv_1:NormalizedDefaultExptValueInSeconds(a2)
    a1.AnimParams.TextStroke_TargetTransparency = 1
    a1.AnimParams.TextStroke_NormalizedExptValue = CurveUtil_upv_1:NormalizedDefaultExptValueInSeconds(a2)
end
function tbl_upv_2.FadeInText(a1, a2)
    --[[
      name: FadeInText
      line: 205
      upvalues:
        CurveUtil_upv_1 (copy, index: 1)
    ]]
    a1.AnimParams.Text_TargetTransparency = 0
    a1.AnimParams.Text_NormalizedExptValue = CurveUtil_upv_1:NormalizedDefaultExptValueInSeconds(a2)
    a1.AnimParams.TextStroke_TargetTransparency = 0.75
    a1.AnimParams.TextStroke_NormalizedExptValue = CurveUtil_upv_1:NormalizedDefaultExptValueInSeconds(a2)
end
function tbl_upv_2.AnimGuiObjects(a1)
    --[[
      name: AnimGuiObjects
      line: 212
    ]]
    a1.UnselectedFrame.BackgroundTransparency = a1.AnimParams.Background_CurrentTransparency
    a1.SelectedFrame.BackgroundImage.BackgroundTransparency = a1.AnimParams.Background_CurrentTransparency
    a1.SelectedFrame.BlueBarLeft.ImageTransparency = a1.AnimParams.Background_CurrentTransparency
    a1.SelectedFrame.BlueBarRight.ImageTransparency = a1.AnimParams.Background_CurrentTransparency
    a1.NameTagNonSelect.TextTransparency = a1.AnimParams.Background_CurrentTransparency
    a1.NameTagNonSelect.TextStrokeTransparency = a1.AnimParams.Background_CurrentTransparency
    a1.NameTag.TextTransparency = a1.AnimParams.Text_CurrentTransparency
    a1.NewMessageIcon.ImageTransparency = a1.AnimParams.Text_CurrentTransparency
    a1.WhiteTextNewMessageNotification.TextTransparency = a1.AnimParams.Text_CurrentTransparency
    a1.NameTagSelect.TextTransparency = a1.AnimParams.Text_CurrentTransparency
    a1.NameTag.TextStrokeTransparency = a1.AnimParams.TextStroke_CurrentTransparency
    a1.WhiteTextNewMessageNotification.TextStrokeTransparency = a1.AnimParams.TextStroke_CurrentTransparency
    a1.NameTagSelect.TextStrokeTransparency = a1.AnimParams.TextStroke_CurrentTransparency
end
function tbl_upv_2.InitializeAnimParams(a1)
    --[[
      name: InitializeAnimParams
      line: 230
      upvalues:
        CurveUtil_upv_1 (copy, index: 1)
    ]]
    a1.AnimParams.Text_TargetTransparency = 0
    a1.AnimParams.Text_CurrentTransparency = 0
    a1.AnimParams.Text_NormalizedExptValue = CurveUtil_upv_1:NormalizedDefaultExptValueInSeconds(0)
    a1.AnimParams.TextStroke_TargetTransparency = 0.75
    a1.AnimParams.TextStroke_CurrentTransparency = 0.75
    a1.AnimParams.TextStroke_NormalizedExptValue = CurveUtil_upv_1:NormalizedDefaultExptValueInSeconds(0)
    a1.AnimParams.Background_TargetTransparency = 0.6
    a1.AnimParams.Background_CurrentTransparency = 0.6
    a1.AnimParams.Background_NormalizedExptValue = CurveUtil_upv_1:NormalizedDefaultExptValueInSeconds(0)
end
function tbl_upv_2.Update(a1, a2)
    --[[
      name: Update
      line: 244
      upvalues:
        CurveUtil_upv_1 (copy, index: 1)
    ]]
    a1.AnimParams.Background_CurrentTransparency = CurveUtil_upv_1:Expt(a1.AnimParams.Background_CurrentTransparency, a1.AnimParams.Background_TargetTransparency, a1.AnimParams.Background_NormalizedExptValue, a2)
    a1.AnimParams.Text_CurrentTransparency = CurveUtil_upv_1:Expt(a1.AnimParams.Text_CurrentTransparency, a1.AnimParams.Text_TargetTransparency, a1.AnimParams.Text_NormalizedExptValue, a2)
    a1.AnimParams.TextStroke_CurrentTransparency = CurveUtil_upv_1:Expt(a1.AnimParams.TextStroke_CurrentTransparency, a1.AnimParams.TextStroke_TargetTransparency, a1.AnimParams.TextStroke_NormalizedExptValue, a2)
    a1:AnimGuiObjects()
end
local function CreateGuiObjects()
    --[[
      name: CreateGuiObjects
      line: 21
      upvalues:
        ChatSettings_upv_1 (copy, index: 1)
    ]]
    local v3 = Instance.new("Frame")
    v3.Selectable = false
    v3.Size = UDim2.new(1, 0, 1, 0)
    v3.BackgroundTransparency = 1
    local v4 = Instance.new("Frame")
    v4.Selectable = false
    v4.Name = "BackgroundFrame"
    v4.Size = UDim2.new(1, -2, 1, -2)
    v4.Position = UDim2.new(0, 1, 0, 1)
    v4.BackgroundTransparency = 1
    v4.Parent = v3
    local v5 = Instance.new("Frame")
    v5.Selectable = false
    v5.Name = "UnselectedFrame"
    v5.Size = UDim2.new(1, 0, 1, 0)
    v5.Position = UDim2.new(0, 0, 0, 0)
    v5.BorderSizePixel = 0
    v5.BackgroundColor3 = ChatSettings_upv_1.ChannelsTabUnselectedColor
    v5.BackgroundTransparency = 0.6
    v5.Parent = v4
    local v6 = Instance.new("Frame")
    v6.Selectable = false
    v6.Name = "SelectedFrame"
    v6.Size = UDim2.new(1, 0, 1, 0)
    v6.Position = UDim2.new(0, 0, 0, 0)
    v6.BorderSizePixel = 0
    v6.BackgroundColor3 = ChatSettings_upv_1.ChannelsTabSelectedColor
    v6.BackgroundTransparency = 1
    v6.Parent = v4
    local v7 = Instance.new("ImageLabel")
    v7.Selectable = false
    v7.Name = "BackgroundImage"
    v7.BackgroundTransparency = 1
    v7.BorderSizePixel = 0
    v7.Size = UDim2.new(1, 0, 1, 0)
    v7.Position = UDim2.new(0, 0, 0, 0)
    v7.ScaleType = Enum.ScaleType.Slice
    v7.Parent = v6
    v7.BackgroundTransparency = -0.4
    v7.BackgroundColor3 = Color3.fromRGB(93.6, 100.8, 115.19999999999999)
    local v8 = Instance.new("ImageLabel")
    v8.Selectable = false
    v8.Size = UDim2.new(0.5, -2, 0, 4)
    v8.BackgroundTransparency = 1
    v8.ScaleType = Enum.ScaleType.Slice
    v8.SliceCenter = Rect.new(3, 3, 32, 21)
    v8.Parent = v6
    local v9 = v8:Clone()
    v9.Parent = v6
    v8.Position = UDim2.new(0, 2, 1, -4)
    v9.Position = UDim2.new(0.5, 0, 1, -4)
    v8.Image = "rbxasset://textures/ui/Settings/Slider/SelectedBarLeft.png"
    v9.Image = "rbxasset://textures/ui/Settings/Slider/SelectedBarRight.png"
    v8.Name = "BlueBarLeft"
    v9.Name = "BlueBarRight"
    local v10 = Instance.new("TextButton")
    v10.Selectable = ChatSettings_upv_1.GamepadNavigationEnabled
    v10.Size = UDim2.new(1, 0, 1, 0)
    v10.Position = UDim2.new(0, 0, 0, 0)
    v10.BackgroundTransparency = 1
    v10.Font = ChatSettings_upv_1.DefaultFont
    v10.TextSize = ChatSettings_upv_1.ChatChannelsTabTextSize
    v10.TextColor3 = Color3.new(1, 1, 1)
    v10.TextStrokeTransparency = 0.75
    v10.Parent = v4
    v8 = v10:Clone()
    local v11 = v10:Clone()
    v8.Parent = v5
    v11.Parent = v6
    v8.Font = Enum.Font.SourceSans
    v8.Active = false
    v11.Active = false
    local v12 = Instance.new("Frame")
    v12.Selectable = false
    v12.Size = UDim2.new(0, 18, 0, 18)
    v12.Position = UDim2.new(0.8, -9, 0.5, -9)
    v12.BackgroundTransparency = 1
    v12.Parent = v4
    local v13 = Instance.new("ImageLabel")
    v13.Selectable = false
    v13.Size = UDim2.new(1, 0, 1, 0)
    v13.BackgroundTransparency = 1
    v13.Image = "rbxasset://textures/ui/Chat/MessageCounter.png"
    v13.Visible = false
    v13.Parent = v12
    local v14 = Instance.new("TextLabel")
    v14.Selectable = false
    v14.BackgroundTransparency = 1
    v14.Size = UDim2.new(0, 13, 0, 9)
    v14.Position = UDim2.new(0.5, -7, 0.5, -7)
    v14.Font = ChatSettings_upv_1.DefaultFont
    v14.TextSize = 14
    v14.TextColor3 = Color3.new(1, 1, 1)
    v14.Text = ""
    v14.Parent = v13
    return v3, v10, v8, v11, v13, v5, v6
end
function tbl_1.new(a1)
    --[[
      name: new
      line: 270
      upvalues:
        tbl_upv_2 (copy, index: 1)
        CreateGuiObjects (copy, index: 2)
        ChatSettings_upv_1 (copy, index: 3)
    ]]
    local v15 = setmetatable({}, tbl_upv_2)
    local v16, v17, v18, v19, v20, v21, v22 = CreateGuiObjects()
    v15.GuiObject = v16
    v15.NameTag = v17
    v15.NameTagNonSelect = v18
    v15.NameTagSelect = v19
    v15.NewMessageIcon = v20
    v15.UnselectedFrame = v21
    v15.SelectedFrame = v22
    v15.BlueBarLeft = v22.BlueBarLeft
    v15.BlueBarRight = v22.BlueBarRight
    v15.BackgroundImage = v22.BackgroundImage
    v15.WhiteTextNewMessageNotification = v15.NewMessageIcon.TextLabel
    v15.ChannelName = a1
    v15.UnreadMessageCount = 0
    v15.Active = false
    v15.GuiObject.Name = "Frame_" .. v15.ChannelName
    a1 = ((ChatSettings_upv_1.MaxChannelNameLength < string.len(a1)) and (string.sub(a1, 1, ChatSettings_upv_1.MaxChannelNameLength - 3) .. "...")) or a1
    v15.NameTag.Text = ""
    v15.NameTagNonSelect.Text = a1
    v15.NameTagSelect.Text = a1
    v15.AnimParams = {}
    v15:InitializeAnimParams()
    v15:AnimGuiObjects()
    v15:SetActive(false)
    return v15
end
return tbl_1