local v1 = {}
local chat = game:GetService("Chat")
local clientChatModules = chat:WaitForChild("ClientChatModules")
local parent = script.Parent
local ChatSettings = require(clientChatModules:WaitForChild("ChatSettings"))
local CurveUtil = require(parent:WaitForChild("CurveUtil"))
local Class = {}
Class.__index = Class

local function CreateGuiObjects()
    --[[
      name: CreateGuiObjects
      line: 21
      upvalues:
        ChatSettings (copy, index: 1)
    ]]
    local parent = Instance.new("Frame")
    parent.Selectable = false
    parent.Size = UDim2.new(1, 0, 1, 0)
    parent.BackgroundTransparency = 1

    local backgroundFrame = Instance.new("Frame")
    backgroundFrame.Selectable = false
    backgroundFrame.Name = "BackgroundFrame"
    backgroundFrame.Size = UDim2.new(1, -2, 1, -2)
    backgroundFrame.Position = UDim2.new(0, 1, 0, 1)
    backgroundFrame.BackgroundTransparency = 1
    backgroundFrame.Parent = parent

    local unselectedFrame = Instance.new("Frame")
    unselectedFrame.Selectable = false
    unselectedFrame.Name = "UnselectedFrame"
    unselectedFrame.Size = UDim2.new(1, 0, 1, 0)
    unselectedFrame.Position = UDim2.new(0, 0, 0, 0)
    unselectedFrame.BorderSizePixel = 0
    unselectedFrame.BackgroundColor3 = ChatSettings.ChannelsTabUnselectedColor
    unselectedFrame.BackgroundTransparency = 0.6
    unselectedFrame.Parent = backgroundFrame

    local selectedFrame = Instance.new("Frame")
    selectedFrame.Selectable = false
    selectedFrame.Name = "SelectedFrame"
    selectedFrame.Size = UDim2.new(1, 0, 1, 0)
    selectedFrame.Position = UDim2.new(0, 0, 0, 0)
    selectedFrame.BorderSizePixel = 0
    selectedFrame.BackgroundColor3 = ChatSettings.ChannelsTabSelectedColor
    selectedFrame.BackgroundTransparency = 1
    selectedFrame.Parent = backgroundFrame

    local backgroundImage = Instance.new("ImageLabel")
    backgroundImage.Selectable = false
    backgroundImage.Name = "BackgroundImage"
    backgroundImage.BackgroundTransparency = 1
    backgroundImage.BorderSizePixel = 0
    backgroundImage.Size = UDim2.new(1, 0, 1, 0)
    backgroundImage.Position = UDim2.new(0, 0, 0, 0)
    backgroundImage.ScaleType = Enum.ScaleType.Slice
    backgroundImage.Parent = selectedFrame
    backgroundImage.BackgroundTransparency = -0.4
    backgroundImage.BackgroundColor3 = Color3.fromRGB(93.6, 100.8, 115.19999999999999)

    local blueBarLeft = Instance.new("ImageLabel")
    blueBarLeft.Selectable = false
    blueBarLeft.Size = UDim2.new(0.5, -2, 0, 4)
    blueBarLeft.BackgroundTransparency = 1
    blueBarLeft.ScaleType = Enum.ScaleType.Slice
    blueBarLeft.SliceCenter = Rect.new(3, 3, 32, 21)
    blueBarLeft.Parent = selectedFrame

    local blueBarRight = blueBarLeft:Clone()
    blueBarRight.Parent = selectedFrame
    blueBarLeft.Position = UDim2.new(0, 2, 1, -4)
    blueBarRight.Position = UDim2.new(0.5, 0, 1, -4)
    blueBarLeft.Image = "rbxasset://textures/ui/Settings/Slider/SelectedBarLeft.png"
    blueBarRight.Image = "rbxasset://textures/ui/Settings/Slider/SelectedBarRight.png"
    blueBarLeft.Name = "BlueBarLeft"
    blueBarRight.Name = "BlueBarRight"
    local textButton = Instance.new("TextButton")
    textButton.Selectable = ChatSettings.GamepadNavigationEnabled
    textButton.Size = UDim2.new(1, 0, 1, 0)
    textButton.Position = UDim2.new(0, 0, 0, 0)
    textButton.BackgroundTransparency = 1
    textButton.Font = ChatSettings.DefaultFont
    textButton.TextSize = ChatSettings.ChatChannelsTabTextSize
    textButton.TextColor3 = Color3.new(1, 1, 1)
    textButton.TextStrokeTransparency = 0.75
    textButton.Parent = backgroundFrame
    local textButton2 = textButton:Clone()
    local textButton3 = textButton:Clone()
    textButton2.Parent = unselectedFrame
    textButton3.Parent = selectedFrame
    textButton2.Font = Enum.Font.SourceSans
    textButton2.Active = false
    textButton3.Active = false
    local parent2 = Instance.new("Frame")
    parent2.Selectable = false
    parent2.Size = UDim2.new(0, 18, 0, 18)
    parent2.Position = UDim2.new(0.8, -9, 0.5, -9)
    parent2.BackgroundTransparency = 1
    parent2.Parent = backgroundFrame

    local parent3 = Instance.new("ImageLabel")
    parent3.Selectable = false
    parent3.Size = UDim2.new(1, 0, 1, 0)
    parent3.BackgroundTransparency = 1
    parent3.Image = "rbxasset://textures/ui/Chat/MessageCounter.png"
    parent3.Visible = false
    parent3.Parent = parent2

    local textLabel = Instance.new("TextLabel")
    textLabel.Selectable = false
    textLabel.BackgroundTransparency = 1
    textLabel.Size = UDim2.new(0, 13, 0, 9)
    textLabel.Position = UDim2.new(0.5, -7, 0.5, -7)
    textLabel.Font = ChatSettings.DefaultFont
    textLabel.TextSize = 14
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.Text = ""
    textLabel.Parent = parent3

    return parent, textButton, textButton2, textButton3, parent3, unselectedFrame, selectedFrame
end

function Class.Destroy(self)
    --[[
      name: Destroy
      line: 141
    ]]
    self.GuiObject:Destroy()
end

function Class.UpdateMessagePostedInChannel(self, a24)
    --[[
      name: UpdateMessagePostedInChannel
      line: 145
    ]]
    local text

    if self.Active and a24 ~= true then
        return
    end

    local unreadMessageCount = self.UnreadMessageCount + 1
    self.UnreadMessageCount = unreadMessageCount
    local newMessageIcon = self.NewMessageIcon
    newMessageIcon.Visible = true
    local textLabel = newMessageIcon.TextLabel

    if not (unreadMessageCount < 100) then
        text = "!"
    else
        text = tostring(unreadMessageCount)
        text = text or "!"
    end

    textLabel.Text = text
    local udim2 = UDim2.new(0, 0, -0.1, 0)
    local _ = newMessageIcon.Position + udim2
    local out = Enum.EasingDirection.Out
    local quad = Enum.EasingStyle.Quad
    newMessageIcon.Position = UDim2.new(0, 0, -0.15, 0)
    newMessageIcon:TweenPosition(UDim2.new(0, 0, 0, 0), out, quad, 0.15, true)
end

function Class.SetActive(self, active)
    --[[
      name: SetActive
      line: 168
    ]]
    self.Active = active
    self.UnselectedFrame.Visible = not active
    self.SelectedFrame.Visible = active

    if active then
        self.UnreadMessageCount = 0
        self.NewMessageIcon.Visible = false
        self.NameTag.Font = Enum.Font.SourceSansBold

        return
    end

    self.NameTag.Font = Enum.Font.SourceSans
end

function Class.SetTextSize(self, textSize)
    --[[
      name: SetTextSize
      line: 184
    ]]
    self.NameTag.TextSize = textSize
end

function Class.FadeOutBackground(self, a38)
    --[[
      name: FadeOutBackground
      line: 188
      upvalues:
        CurveUtil (copy, index: 1)
    ]]
    self.AnimParams.Background_TargetTransparency = 1
    self.AnimParams.Background_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(a38)
end

function Class.FadeInBackground(self, a40)
    --[[
      name: FadeInBackground
      line: 193
      upvalues:
        CurveUtil (copy, index: 1)
    ]]
    self.AnimParams.Background_TargetTransparency = 0.6
    self.AnimParams.Background_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(a40)
end

function Class.FadeOutText(self, a42)
    --[[
      name: FadeOutText
      line: 198
      upvalues:
        CurveUtil (copy, index: 1)
    ]]
    self.AnimParams.Text_TargetTransparency = 1
    self.AnimParams.Text_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(a42)
    self.AnimParams.TextStroke_TargetTransparency = 1
    self.AnimParams.TextStroke_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(a42)
end

function Class.FadeInText(self, a44)
    --[[
      name: FadeInText
      line: 205
      upvalues:
        CurveUtil (copy, index: 1)
    ]]
    self.AnimParams.Text_TargetTransparency = 0
    self.AnimParams.Text_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(a44)
    self.AnimParams.TextStroke_TargetTransparency = 0.75
    self.AnimParams.TextStroke_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(a44)
end

function Class.AnimGuiObjects(self)
    --[[
      name: AnimGuiObjects
      line: 212
    ]]
    self.UnselectedFrame.BackgroundTransparency = self.AnimParams.Background_CurrentTransparency
    self.SelectedFrame.BackgroundImage.BackgroundTransparency = self.AnimParams.Background_CurrentTransparency
    self.SelectedFrame.BlueBarLeft.ImageTransparency = self.AnimParams.Background_CurrentTransparency
    self.SelectedFrame.BlueBarRight.ImageTransparency = self.AnimParams.Background_CurrentTransparency
    self.NameTagNonSelect.TextTransparency = self.AnimParams.Background_CurrentTransparency
    self.NameTagNonSelect.TextStrokeTransparency = self.AnimParams.Background_CurrentTransparency
    self.NameTag.TextTransparency = self.AnimParams.Text_CurrentTransparency
    self.NewMessageIcon.ImageTransparency = self.AnimParams.Text_CurrentTransparency
    self.WhiteTextNewMessageNotification.TextTransparency = self.AnimParams.Text_CurrentTransparency
    self.NameTagSelect.TextTransparency = self.AnimParams.Text_CurrentTransparency
    self.NameTag.TextStrokeTransparency = self.AnimParams.TextStroke_CurrentTransparency
    self.WhiteTextNewMessageNotification.TextStrokeTransparency = self.AnimParams.TextStroke_CurrentTransparency
    self.NameTagSelect.TextStrokeTransparency = self.AnimParams.TextStroke_CurrentTransparency
end

function Class.InitializeAnimParams(self)
    --[[
      name: InitializeAnimParams
      line: 230
      upvalues:
        CurveUtil (copy, index: 1)
    ]]
    self.AnimParams.Text_TargetTransparency = 0
    self.AnimParams.Text_CurrentTransparency = 0
    self.AnimParams.Text_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(0)
    self.AnimParams.TextStroke_TargetTransparency = 0.75
    self.AnimParams.TextStroke_CurrentTransparency = 0.75
    self.AnimParams.TextStroke_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(0)
    self.AnimParams.Background_TargetTransparency = 0.6
    self.AnimParams.Background_CurrentTransparency = 0.6
    self.AnimParams.Background_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(0)
end

function Class.Update(self, a48)
    --[[
      name: Update
      line: 244
      upvalues:
        CurveUtil (copy, index: 1)
    ]]
    self.AnimParams.Background_CurrentTransparency = CurveUtil:Expt(self.AnimParams.Background_CurrentTransparency, self.AnimParams.Background_TargetTransparency, self.AnimParams.Background_NormalizedExptValue, a48)
    self.AnimParams.Text_CurrentTransparency = CurveUtil:Expt(self.AnimParams.Text_CurrentTransparency, self.AnimParams.Text_TargetTransparency, self.AnimParams.Text_NormalizedExptValue, a48)
    self.AnimParams.TextStroke_CurrentTransparency = CurveUtil:Expt(self.AnimParams.TextStroke_CurrentTransparency, self.AnimParams.TextStroke_TargetTransparency, self.AnimParams.TextStroke_NormalizedExptValue, a48)
    self:AnimGuiObjects()
end

function v1.new(text)
    --[[
      name: new
      line: 270
      upvalues:
        Class (copy, index: 1)
        CreateGuiObjects (copy, index: 2)
        ChatSettings (copy, index: 3)
    ]]
    local v50 = setmetatable({}, Class)
    local guiObject, nameTag, nameTagNonSelect, nameTagSelect, newMessageIcon, unselectedFrame, selectedFrame = CreateGuiObjects()
    v50.GuiObject = guiObject
    v50.NameTag = nameTag
    v50.NameTagNonSelect = nameTagNonSelect
    v50.NameTagSelect = nameTagSelect
    v50.NewMessageIcon = newMessageIcon
    v50.UnselectedFrame = unselectedFrame
    v50.SelectedFrame = selectedFrame
    v50.BlueBarLeft = selectedFrame.BlueBarLeft
    v50.BlueBarRight = selectedFrame.BlueBarRight
    v50.BackgroundImage = selectedFrame.BackgroundImage
    v50.WhiteTextNewMessageNotification = v50.NewMessageIcon.TextLabel
    v50.ChannelName = text
    v50.UnreadMessageCount = 0
    v50.Active = false
    v50.GuiObject.Name = "Frame_" .. v50.ChannelName
    local length = string.len(text)

    if ChatSettings.MaxChannelNameLength < length then
        text = string.sub(text, 1, ChatSettings.MaxChannelNameLength - 3) .. "..."
    end

    v50.NameTag.Text = ""
    v50.NameTagNonSelect.Text = text
    v50.NameTagSelect.Text = text
    v50.AnimParams = {}
    v50:InitializeAnimParams()
    v50:AnimGuiObjects()
    v50:SetActive(false)

    return v50
end

return v1