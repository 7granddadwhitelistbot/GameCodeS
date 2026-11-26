local v1 = {}
local chat = game:GetService("Chat")
local clientChatModules = chat:WaitForChild("ClientChatModules")
local parent = script.Parent
local ChannelsTab = require(parent:WaitForChild("ChannelsTab"))
local MessageSender = require(parent:WaitForChild("MessageSender"))
local ChatSettings = require(clientChatModules:WaitForChild("ChatSettings"))
local CurveUtil = require(parent:WaitForChild("CurveUtil"))
local Class = {}
Class.__index = Class

function Class.CreateGuiObjects(self, parent: Instance?)
    --[[
      name: CreateGuiObjects
      line: 24
      upvalues:
        ChatSettings (copy, index: 1)
        MessageSender (copy, index: 2)
    ]]
    local frame = Instance.new("Frame")
    frame.Selectable = false
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local scrollingBase = Instance.new("Frame")
    scrollingBase.Selectable = false
    scrollingBase.Name = "ScrollingBase"
    scrollingBase.BackgroundTransparency = 1
    scrollingBase.ClipsDescendants = true
    scrollingBase.Size = UDim2.new(1, 0, 1, 0)
    scrollingBase.Position = UDim2.new(0, 0, 0, 0)
    scrollingBase.Parent = frame

    local scrollerSizer = Instance.new("Frame")
    scrollerSizer.Selectable = false
    scrollerSizer.Name = "ScrollerSizer"
    scrollerSizer.BackgroundTransparency = 1
    scrollerSizer.Size = UDim2.new(1, 0, 1, 0)
    scrollerSizer.Position = UDim2.new(0, 0, 0, 0)
    scrollerSizer.Parent = scrollingBase

    local scrollerFrame = Instance.new("Frame")
    scrollerFrame.Selectable = false
    scrollerFrame.Name = "ScrollerFrame"
    scrollerFrame.BackgroundTransparency = 1
    scrollerFrame.Size = UDim2.new(1, 0, 1, 0)
    scrollerFrame.Position = UDim2.new(0, 0, 0, 0)
    scrollerFrame.Parent = scrollerSizer

    local parent2 = Instance.new("Frame")
    parent2.Selectable = false
    parent2.Size = UDim2.new(1, 0, 1, 0)
    parent2.Position = UDim2.new(0, 0, 0, 0)
    parent2.ClipsDescendants = true
    parent2.BackgroundTransparency = 1
    parent2.Parent = frame

    local leaveConfirmationFrame = Instance.new("Frame")
    leaveConfirmationFrame.Selectable = false
    leaveConfirmationFrame.Name = "LeaveConfirmationFrame"
    leaveConfirmationFrame.Size = UDim2.new(1, 0, 1, 0)
    leaveConfirmationFrame.Position = UDim2.new(0, 0, 1, 0)
    leaveConfirmationFrame.BackgroundTransparency = 0.6
    leaveConfirmationFrame.BorderSizePixel = 0
    leaveConfirmationFrame.BackgroundColor3 = Color3.new(0, 0, 0)
    leaveConfirmationFrame.Parent = parent2

    local textButton = Instance.new("TextButton")
    textButton.Selectable = false
    textButton.Size = UDim2.new(1, 0, 1, 0)
    textButton.BackgroundTransparency = 1
    textButton.Text = ""
    textButton.Parent = leaveConfirmationFrame

    local textButton2 = Instance.new("TextButton")
    textButton2.Selectable = false
    textButton2.Size = UDim2.new(0.25, 0, 1, 0)
    textButton2.BackgroundTransparency = 1
    textButton2.Font = ChatSettings.DefaultFont
    textButton2.TextSize = 18
    textButton2.TextStrokeTransparency = 0.75
    textButton2.Position = UDim2.new(0, 0, 0, 0)
    textButton2.TextColor3 = Color3.new(0, 1, 0)
    textButton2.Text = "Confirm"
    textButton2.Parent = leaveConfirmationFrame

    local textButton3 = textButton2:Clone()
    textButton3.Parent = leaveConfirmationFrame
    textButton3.Position = UDim2.new(0.75, 0, 0, 0)
    textButton3.TextColor3 = Color3.new(1, 0, 0)
    textButton3.Text = "Cancel"

    local leaveConfirmationNotice = Instance.new("TextLabel")
    leaveConfirmationNotice.Selectable = false
    leaveConfirmationNotice.Size = UDim2.new(0.5, 0, 1, 0)
    leaveConfirmationNotice.Position = UDim2.new(0.25, 0, 0, 0)
    leaveConfirmationNotice.BackgroundTransparency = 1
    leaveConfirmationNotice.TextColor3 = Color3.new(1, 1, 1)
    leaveConfirmationNotice.TextStrokeTransparency = 0.75
    leaveConfirmationNotice.Text = "Leave channel <XX>?"
    leaveConfirmationNotice.Font = ChatSettings.DefaultFont
    leaveConfirmationNotice.TextSize = 18
    leaveConfirmationNotice.Parent = leaveConfirmationFrame

    local leaveTarget = Instance.new("StringValue")
    leaveTarget.Name = "LeaveTarget"
    leaveTarget.Parent = leaveConfirmationFrame
    local position = leaveConfirmationFrame.Position

    textButton2.MouseButton1Click:connect(
        function()
            --[[
              line: 116
              upvalues:
                MessageSender (copy, index: 1)
                leaveTarget (copy, index: 2)
                leaveConfirmationFrame (copy, index: 3)
                position (copy, index: 4)
            ]]
            MessageSender:SendMessage(string.format("/leave %s", leaveTarget.Value), nil)
            leaveConfirmationFrame:TweenPosition(position, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
        end
    )

    textButton3.MouseButton1Click:connect(
        function()
            --[[
              line: 120
              upvalues:
                leaveConfirmationFrame (copy, index: 1)
                position (copy, index: 2)
            ]]
            leaveConfirmationFrame:TweenPosition(position, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
        end
    )
    local pageLeftButton = Instance.new("ImageButton", frame)
    pageLeftButton.Selectable = ChatSettings.GamepadNavigationEnabled
    pageLeftButton.Name = "PageLeftButton"
    pageLeftButton.SizeConstraint = Enum.SizeConstraint.RelativeYY
    pageLeftButton.Size = UDim2.new(0.7, 0, 0.7, 0)
    pageLeftButton.BackgroundTransparency = 1
    pageLeftButton.Position = UDim2.new(0, 4, 0.15000000000000002, 0)
    pageLeftButton.Visible = false
    pageLeftButton.Image = "rbxassetid://471630199"

    local arrowLabel = Instance.new("ImageLabel", pageLeftButton)
    arrowLabel.Name = "ArrowLabel"
    arrowLabel.BackgroundTransparency = 1
    arrowLabel.Size = UDim2.new(0.4, 0, 0.4, 0)
    arrowLabel.Image = "rbxassetid://471630112"

    local positionalHelper = Instance.new("Frame", frame)
    positionalHelper.Selectable = false
    positionalHelper.BackgroundTransparency = 1
    positionalHelper.Name = "PositionalHelper"
    positionalHelper.Size = pageLeftButton.Size
    positionalHelper.SizeConstraint = pageLeftButton.SizeConstraint
    positionalHelper.Position = UDim2.new(1, 0, 0.15000000000000002, 0)

    local pageRightButton = pageLeftButton:Clone()
    pageRightButton.Parent = positionalHelper
    pageRightButton.Name = "PageRightButton"
    pageRightButton.Size = UDim2.new(1, 0, 1, 0)
    pageRightButton.SizeConstraint = Enum.SizeConstraint.RelativeXY
    pageRightButton.Position = UDim2.new(-1, -4, 0, 0)
    local udim2 = UDim2.new(0.05, 0, 0, 0)
    pageRightButton.ArrowLabel.Position = UDim2.new(0.3, 0, 0.3, 0) + udim2
    pageLeftButton.ArrowLabel.Position = UDim2.new(0.3, 0, 0.3, 0) - udim2
    pageLeftButton.ArrowLabel.Rotation = 180
    self.GuiObject = frame
    self.GuiObjects.BaseFrame = frame
    self.GuiObjects.ScrollerSizer = scrollerSizer
    self.GuiObjects.ScrollerFrame = scrollerFrame
    self.GuiObjects.PageLeftButton = pageLeftButton
    self.GuiObjects.PageRightButton = pageRightButton
    self.GuiObjects.LeaveConfirmationFrame = leaveConfirmationFrame
    self.GuiObjects.LeaveConfirmationNotice = leaveConfirmationNotice
    self.GuiObjects.PageLeftButtonArrow = pageLeftButton.ArrowLabel
    self.GuiObjects.PageRightButtonArrow = pageRightButton.ArrowLabel
    self:AnimGuiObjects()
    pageLeftButton.MouseButton1Click:connect(
        function()
            --[[
              line: 188
              upvalues:
                self (copy, index: 1)
            ]]
            self:ScrollChannelsFrame(-1)
        end
    )
    pageRightButton.MouseButton1Click:connect(
        function()
            --[[
              line: 189
              upvalues:
                self (copy, index: 1)
            ]]
            self:ScrollChannelsFrame(1)
        end
    )
    self:ScrollChannelsFrame(0)
end

function Class.UpdateMessagePostedInChannel(self, a30)
    --[[
      name: UpdateMessagePostedInChannel
      line: 195
    ]]
    if const channelTab = self:GetChannelTab(a30) then
        channelTab:UpdateMessagePostedInChannel()
        return
    end

    warn("ChannelsTab '" .. a30 .. "' does not exist!")
end

function Class.AddChannelTab(self, a33)
    --[[
      name: AddChannelTab
      line: 204
      upvalues:
        ChannelsTab (copy, index: 1)
        ChatSettings (copy, index: 2)
    ]]
    if self:GetChannelTab(a33) then
        error("Channel tab '" .. a33 .. "'already exists!")
    end

    local channelsTab = ChannelsTab.new(a33)
    channelsTab.GuiObject.Parent = self.GuiObjects.ScrollerFrame
    self.ChannelTabs[a33:lower()] = channelsTab
    self.NumTabs += 1
    self:OrganizeChannelTabs()

    if ChatSettings.RightClickToLeaveChannelEnabled then
        channelsTab.NameTag.MouseButton2Click:connect(
            function()
                --[[
                  line: 217
                  upvalues:
                    self (copy, index: 1)
                    channelsTab (copy, index: 2)
                ]]
                self.LeaveConfirmationNotice.Text = string.format("Leave channel %s?", channelsTab.ChannelName)
                self.LeaveConfirmationFrame.LeaveTarget.Value = channelsTab.ChannelName
                self.LeaveConfirmationFrame:TweenPosition(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.2, true)
            end
        )
    end

    return channelsTab
end

function Class.RemoveChannelTab(self, a36)
    --[[
      name: RemoveChannelTab
      line: 227
    ]]
    if not self:GetChannelTab(a36) then
        error("Channel tab '" .. a36 .. "'does not exist!")
    end

    local channelTabKey = a36:lower()
    self.ChannelTabs[channelTabKey]:Destroy()
    self.ChannelTabs[channelTabKey] = nil
    self.NumTabs -= 1
    self:OrganizeChannelTabs()
end

function Class.GetChannelTab(self, a39)
    --[[
      name: GetChannelTab
      line: 240
    ]]
    return self.ChannelTabs[a39:lower()]
end

function Class.OrganizeChannelTabs(self)
    --[[
      name: OrganizeChannelTabs
      line: 244
      upvalues:
        ChatSettings (copy, index: 1)
    ]]
    local v41 = {}
    table.insert(v41, self:GetChannelTab(ChatSettings.GeneralChannelName))
    table.insert(v41, self:GetChannelTab("System"))

    for _, channelTab in pairs(self.ChannelTabs) do
        if channelTab.ChannelName ~= ChatSettings.GeneralChannelName and channelTab.ChannelName ~= "System" then
            table.insert(v41, channelTab)
        end
    end

    for key, v45 in pairs(v41) do
        v45.GuiObject.Position = UDim2.new(key - 1, 0, 0, 0)
    end

    self.GuiObjects.ScrollerSizer.Size = UDim2.new(1 / math.max(1, (math.min(ChatSettings.ChannelsBarFullTabSize, self.NumTabs))), 0, 1, 0)
    self:ScrollChannelsFrame(0)
end

function Class.ResizeChannelTabText(self, textSize)
    --[[
      name: ResizeChannelTabText
      line: 266
    ]]
    for _, channelTab in pairs(self.ChannelTabs) do
        channelTab:SetTextSize(textSize)
    end
end

function Class.ScrollChannelsFrame(self, a51)
    --[[
      name: ScrollChannelsFrame
      line: 272
      upvalues:
        ChatSettings (copy, index: 1)
    ]]
    if self.ScrollChannelsFrameLock then
        return
    end

    self.ScrollChannelsFrameLock = true
    local channelsBarFullTabSize = ChatSettings.ChannelsBarFullTabSize
    local curPageNum = self.CurPageNum + a51

    if not (curPageNum < 0) then
        if 0 < curPageNum then
            local v54 = curPageNum + channelsBarFullTabSize

            if self.NumTabs < v54 then
                curPageNum = self.NumTabs - channelsBarFullTabSize
            end
        end
    else
        curPageNum = 0
    end

    self.CurPageNum = curPageNum
    local udim2 = UDim2.new(-self.CurPageNum, 0, 0, 0)
    self.GuiObjects.PageLeftButton.Visible = 0 < self.CurPageNum
    self.GuiObjects.PageRightButton.Visible = (self.CurPageNum + channelsBarFullTabSize) < self.NumTabs

    if a51 == 0 then
        self.ScrollChannelsFrameLock = false
        return
    end

    self:WaitUntilParentedCorrectly()
    self.GuiObjects.ScrollerFrame:TweenPosition(
        udim2,
        Enum.EasingDirection.InOut,
        Enum.EasingStyle.Quad,
        0.15,
        true,
        function()
            --[[
              name: UnlockFunc
              line: 298
              upvalues:
                self (copy, index: 1)
            ]]
            self.ScrollChannelsFrameLock = false
        end
    )
end

function Class.FadeOutBackground(self, a57)
    --[[
      name: FadeOutBackground
      line: 307
      upvalues:
        CurveUtil (copy, index: 1)
    ]]
    for _, channelTab in pairs(self.ChannelTabs) do
        channelTab:FadeOutBackground(a57)
    end

    self.AnimParams.Background_TargetTransparency = 1
    self.AnimParams.Background_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(a57)
end

function Class.FadeInBackground(self, a61)
    --[[
      name: FadeInBackground
      line: 316
      upvalues:
        CurveUtil (copy, index: 1)
    ]]
    for _, channelTab in pairs(self.ChannelTabs) do
        channelTab:FadeInBackground(a61)
    end

    self.AnimParams.Background_TargetTransparency = 0.6
    self.AnimParams.Background_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(a61)
end

function Class.FadeOutText(self, a65)
    --[[
      name: FadeOutText
      line: 325
    ]]
    for _, channelTab in pairs(self.ChannelTabs) do
        channelTab:FadeOutText(a65)
    end
end

function Class.FadeInText(self, a69)
    --[[
      name: FadeInText
      line: 331
    ]]
    for _, channelTab in pairs(self.ChannelTabs) do
        channelTab:FadeInText(a69)
    end
end

function Class.AnimGuiObjects(self)
    --[[
      name: AnimGuiObjects
      line: 337
    ]]
    self.GuiObjects.PageLeftButton.ImageTransparency = self.AnimParams.Background_CurrentTransparency
    self.GuiObjects.PageRightButton.ImageTransparency = self.AnimParams.Background_CurrentTransparency
    self.GuiObjects.PageLeftButtonArrow.ImageTransparency = self.AnimParams.Background_CurrentTransparency
    self.GuiObjects.PageRightButtonArrow.ImageTransparency = self.AnimParams.Background_CurrentTransparency
end

function Class.InitializeAnimParams(self)
    --[[
      name: InitializeAnimParams
      line: 344
      upvalues:
        CurveUtil (copy, index: 1)
    ]]
    self.AnimParams.Background_TargetTransparency = 0.6
    self.AnimParams.Background_CurrentTransparency = 0.6
    self.AnimParams.Background_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(0)
end

function Class.Update(self, a75)
    --[[
      name: Update
      line: 350
      upvalues:
        CurveUtil (copy, index: 1)
    ]]
    for _, channelTab in pairs(self.ChannelTabs) do
        channelTab:Update(a75)
    end

    self.AnimParams.Background_CurrentTransparency = CurveUtil:Expt(self.AnimParams.Background_CurrentTransparency, self.AnimParams.Background_TargetTransparency, self.AnimParams.Background_NormalizedExptValue, a75)
    self:AnimGuiObjects()
end

function Class.WaitUntilParentedCorrectly(self)
    --[[
      name: WaitUntilParentedCorrectly
      line: 366
    ]]
    while not self.GuiObject:IsDescendantOf(game:GetService("Players").LocalPlayer) do
        self.GuiObject.AncestryChanged:wait()
    end
end

function v1.new()
    --[[
      name: new
      line: 375
      upvalues:
        Class (copy, index: 1)
        ChatSettings (copy, index: 2)
    ]]
    local v79 = setmetatable({}, Class)
    v79.GuiObject = nil
    v79.GuiObjects = {}
    v79.ChannelTabs = {}
    v79.NumTabs = 0
    v79.CurPageNum = 0
    v79.ScrollChannelsFrameLock = false
    v79.AnimParams = {}
    v79:InitializeAnimParams()

    ChatSettings.SettingsChanged:connect(
        function(a80, a81)
            --[[
              line: 391
              upvalues:
                v79 (copy, index: 1)
            ]]
            if a80 == "ChatChannelsTabTextSize" then
                v79:ResizeChannelTabText(a81)
            end
        end
    )

    return v79
end

return v1