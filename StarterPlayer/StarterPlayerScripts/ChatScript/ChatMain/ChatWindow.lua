local v1 = {}
local players = game:GetService("Players")
game:GetService("Chat")
local localPlayer = players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")
local chat = game:GetService("Chat")
local clientChatModules = chat:WaitForChild("ClientChatModules")
local parent = script.Parent
local ChatChannel = require(parent:WaitForChild("ChatChannel"))
local ChatSettings = require(clientChatModules:WaitForChild("ChatSettings"))
local CurveUtil = require(parent:WaitForChild("CurveUtil"))
local Class = {}
Class.__index = Class

function getClassicChatEnabled()
    --[[
      name: getClassicChatEnabled
      line: 34
      upvalues:
        ChatSettings (copy, index: 1)
        players (copy, index: 2)
    ]]
    if ChatSettings.ClassicChatEnabled ~= nil then
        return ChatSettings.ClassicChatEnabled
    end

    return players.ClassicChat
end

function getBubbleChatEnabled()
    --[[
      name: getBubbleChatEnabled
      line: 41
      upvalues:
        ChatSettings (copy, index: 1)
        players (copy, index: 2)
    ]]
    if ChatSettings.BubbleChatEnabled ~= nil then
        return ChatSettings.BubbleChatEnabled
    end

    return players.BubbleChat
end

function bubbleChatOnly()
    --[[
      name: bubbleChatOnly
      line: 48
    ]]
    return not getClassicChatEnabled() and getBubbleChatEnabled()
end

function mergeProps(a12, a13)
    --[[
      name: mergeProps
      line: 53
    ]]
    if not a12 or not a13 then
        return
    end

    for key, v15 in pairs(a12) do
        if a13[key] ~= nil then
            a13[key] = v15
        end
    end
end

function Class.CreateGuiObjects(self, parent: Instance?)
    --[[
      name: CreateGuiObjects
      line: 62
      upvalues:
        chat (copy, index: 1)
        ChatSettings (copy, index: 2)
        playerGui (copy, index: 3)
    ]]
    local v18
    local v19
    local v20 = nil
    pcall(
        function()
            --[[
              line: 64
              upvalues:
                v20 (ref,  index: 1)
                chat (copy, index: 2)
            ]]
            v20 = chat:InvokeChatCallback(Enum.ChatCallbackType.OnCreatingChatWindow, nil)
        end
    )
    mergeProps(v20, ChatSettings)
    local frame = Instance.new("Frame")
    frame.BackgroundTransparency = 1
    frame.Active = ChatSettings.WindowDraggable
    frame.Parent = parent
    frame.AutoLocalize = false

    local chatBarParentFrame = Instance.new("Frame")
    chatBarParentFrame.Selectable = false
    chatBarParentFrame.Name = "ChatBarParentFrame"
    chatBarParentFrame.BackgroundTransparency = 1
    chatBarParentFrame.Parent = frame

    local channelsBarParentFrame = Instance.new("Frame")
    channelsBarParentFrame.Selectable = false
    channelsBarParentFrame.Name = "ChannelsBarParentFrame"
    channelsBarParentFrame.BackgroundTransparency = 1
    channelsBarParentFrame.Position = UDim2.new(0, 0, 0, 0)
    channelsBarParentFrame.Parent = frame

    local chatChannelParentFrame = Instance.new("Frame")
    chatChannelParentFrame.Selectable = false
    chatChannelParentFrame.Name = "ChatChannelParentFrame"
    chatChannelParentFrame.BackgroundTransparency = 1
    chatChannelParentFrame.BackgroundColor3 = ChatSettings.BackGroundColor
    chatChannelParentFrame.BackgroundTransparency = 0.6
    chatChannelParentFrame.BorderSizePixel = 0
    chatChannelParentFrame.Parent = frame

    local imageButton = Instance.new("ImageButton")
    imageButton.Selectable = false
    imageButton.Image = ""
    imageButton.BackgroundTransparency = 0.6
    imageButton.BorderSizePixel = 0
    imageButton.Visible = false
    imageButton.BackgroundColor3 = ChatSettings.BackGroundColor
    imageButton.Active = true

    if bubbleChatOnly() then
        imageButton.Position = UDim2.new(1, -imageButton.AbsoluteSize.X, 0, 0)
    else
        imageButton.Position = UDim2.new(1, -imageButton.AbsoluteSize.X, 1, -imageButton.AbsoluteSize.Y)
    end

    imageButton.Parent = frame
    local resizeIcon = Instance.new("ImageLabel")
    resizeIcon.Selectable = false
    resizeIcon.Size = UDim2.new(0.8, 0, 0.8, 0)
    resizeIcon.Position = UDim2.new(0.2, 0, 0.2, 0)
    resizeIcon.BackgroundTransparency = 1
    resizeIcon.Image = "rbxassetid://261880743"
    resizeIcon.Parent = imageButton

    local function GetScreenGuiParent()
        --[[
          name: GetScreenGuiParent
          line: 122
          upvalues:
            frame (copy, index: 1)
        ]]
        local v28
        v28 = frame

        while v28 and not v28:IsA("ScreenGui") do
            v28 = v28.Parent
        end

        return v28
    end

    local v29 = 3
    local instance = frame

    while instance and not instance:IsA("ScreenGui") do
        instance = instance.Parent
    end

    if not (instance.AbsoluteSize.X <= 640) then
        if not (instance.AbsoluteSize.X <= 1024) then
            v18 = v29
        else
            v18 = 2
        end
    else
        v18 = 1
    end

    local isBusy = false

    local function doCheckSizeBounds()
        --[[
          name: doCheckSizeBounds
          line: 145
          upvalues:
            isBusy (ref,  index: 1)
            frame (copy, index: 2)
            playerGui (copy, index: 3)
            ChatSettings (copy, index: 4)
            channelsBarParentFrame (copy, index: 5)
            chatBarParentFrame (copy, index: 6)
        ]]
        local v33

        if isBusy then
            return
        end

        isBusy = true

        if not frame:IsDescendantOf(playerGui) then
            return
        end

        v33 = frame

        while v33 and not v33:IsA("ScreenGui") do
            v33 = v33.Parent
        end

        local minimumWindowSize = ChatSettings.MinimumWindowSize
        local maximumWindowSize = ChatSettings.MaximumWindowSize
        local v36 = channelsBarParentFrame.AbsoluteSize.Y + chatBarParentFrame.AbsoluteSize.Y
        local v37 = minimumWindowSize.X.Scale * v33.AbsoluteSize.X + minimumWindowSize.X.Offset
        local v38 = math.max((minimumWindowSize.Y.Scale * v33.AbsoluteSize.Y) + minimumWindowSize.Y.Offset, v36)
        local v39 = maximumWindowSize.X.Scale * v33.AbsoluteSize.X + maximumWindowSize.X.Offset
        local v40 = maximumWindowSize.Y.Scale * v33.AbsoluteSize.Y + maximumWindowSize.Y.Offset
        local x = frame.AbsoluteSize.X
        local y = frame.AbsoluteSize.Y

        if x < v37 then
            local udim2 = UDim2.new(0, v37 - x, 0, 0)
            frame.Size += udim2
        elseif v39 < x then
            local udim2 = UDim2.new(0, v39 - x, 0, 0)
            frame.Size += udim2
        end

        if y < v38 then
            local udim2 = UDim2.new(0, 0, 0, v38 - y)
            frame.Size += udim2
        elseif v40 < y then
            local udim2 = UDim2.new(0, 0, 0, v40 - y)
            frame.Size += udim2
        end

        local v47 = frame.AbsoluteSize.X / v33.AbsoluteSize.X
        local v48 = frame.AbsoluteSize.Y / v33.AbsoluteSize.Y
        frame.Size = UDim2.new(v47, 0, v48, 0)
        isBusy = false
    end

    frame.Changed:connect(
        function(property: string)
            --[[
              line: 196
              upvalues:
                doCheckSizeBounds (copy, index: 1)
            ]]
            if property == "AbsoluteSize" then
                doCheckSizeBounds()
            end
        end
    )

    imageButton.DragBegin:connect(
        function(initialPosition: UDim2)
            --[[
              line: 202
              upvalues:
                frame (copy, index: 1)
            ]]
            frame.Draggable = false
        end
    )

    local function UpdatePositionFromDrag(absolutePosition: Vector2)
        --[[
          name: UpdatePositionFromDrag
          line: 206
          upvalues:
            ChatSettings (copy, index: 1)
            frame (copy, index: 2)
            imageButton (copy, index: 3)
        ]]
        if ChatSettings.WindowDraggable == false and ChatSettings.WindowResizable == false then
            return
        end

        local vector2 = absolutePosition - frame.AbsolutePosition + imageButton.AbsoluteSize
        frame.Size = UDim2.new(0, vector2.X, 0, vector2.Y)

        if bubbleChatOnly() then
            imageButton.Position = UDim2.new(1, -imageButton.AbsoluteSize.X, 0, 0)
            return
        end

        imageButton.Position = UDim2.new(1, -imageButton.AbsoluteSize.X, 1, -imageButton.AbsoluteSize.Y)
    end

    imageButton.DragStopped:connect(
        function(x: number, y: number)
            --[[
              line: 219
              upvalues:
                frame (copy, index: 1)
                ChatSettings (copy, index: 2)
            ]]
            frame.Draggable = ChatSettings.WindowDraggable
        end
    )
    local v56 = false

    imageButton.Changed:connect(
        function(property: string)
            --[[
              line: 225
              upvalues:
                frame (copy, index: 1)
                v56 (ref,  index: 2)
                UpdatePositionFromDrag (copy, index: 3)
                imageButton (copy, index: 4)
            ]]
            if property == "AbsolutePosition" and not frame.Draggable and not v56 then
                v56 = true
                UpdatePositionFromDrag(imageButton.AbsolutePosition)
                v56 = false
            end
        end
    )

    local function CalculateChannelsBarPixelSize(a59)
        --[[
          name: CalculateChannelsBarPixelSize
          line: 236
          upvalues:
            v18 (ref,  index: 1)
            ChatSettings (copy, index: 2)
        ]]
        if v18 ~= 1 then
            a59 = a59 or ChatSettings.ChatChannelsTabTextSize
        else
            a59 = a59 or ChatSettings.ChatChannelsTabTextSizePhone
        end

        return math.max(32, a59 + 8) + 2
    end

    local function CalculateChatBarPixelSize(a61)
        --[[
          name: CalculateChatBarPixelSize
          line: 249
          upvalues:
            v18 (ref,  index: 1)
            ChatSettings (copy, index: 2)
        ]]
        if v18 ~= 1 then
            a61 = a61 or ChatSettings.ChatBarTextSize
        else
            a61 = a61 or ChatSettings.ChatBarTextSizePhone
        end

        return (a61 + 14) + 10
    end

    if bubbleChatOnly() then
        local scale, offset
        chatBarParentFrame.Position = UDim2.new(0, 0, 0, 0)
        channelsBarParentFrame.Visible = false
        channelsBarParentFrame.Active = false
        chatChannelParentFrame.Visible = false
        chatChannelParentFrame.Active = false
        local instance2 = frame

        while instance2 and not instance2:IsA("ScreenGui") do
            instance2 = instance2.Parent
        end

        if v18 ~= 1 then
            if v18 ~= 2 then
                scale = ChatSettings.DefaultWindowSizeDesktop.X.Scale
                offset = ChatSettings.DefaultWindowSizeDesktop.X.Offset
            else
                scale = ChatSettings.DefaultWindowSizeTablet.X.Scale
                offset = ChatSettings.DefaultWindowSizeTablet.X.Offset
            end
        else
            scale = ChatSettings.DefaultWindowSizePhone.X.Scale
            offset = ChatSettings.DefaultWindowSizePhone.X.Offset
        end

        local v65 = if v18 == 1 then ChatSettings.ChatBarTextSizePhone else ChatSettings.ChatBarTextSize
        local v66 = v65 + 14 + 10
        frame.Size = UDim2.new(scale, offset, 0, v66)
        frame.Position = ChatSettings.DefaultWindowPosition
    else
        local instance3 = frame

        while instance3 and not instance3:IsA("ScreenGui") do
            instance3 = instance3.Parent
        end

        if v18 ~= 1 then
            if v18 ~= 2 then
                frame.Size = ChatSettings.DefaultWindowSizeDesktop
            else
                frame.Size = ChatSettings.DefaultWindowSizeTablet
            end
        else
            frame.Size = ChatSettings.DefaultWindowSizePhone
        end

        frame.Position = ChatSettings.DefaultWindowPosition
    end

    if v18 == 1 then
        ChatSettings.ChatWindowTextSize = ChatSettings.ChatWindowTextSizePhone
        ChatSettings.ChatChannelsTabTextSize = ChatSettings.ChatChannelsTabTextSizePhone
        ChatSettings.ChatBarTextSize = ChatSettings.ChatBarTextSizePhone
    end

    local function UpdateDraggable(a69: boolean)
        --[[
          name: UpdateDraggable
          line: 318
          upvalues:
            frame (copy, index: 1)
        ]]
        frame.Active = a69
        frame.Draggable = a69
    end

    local function UpdateResizable(a71)
        --[[
          name: UpdateResizable
          line: 323
          upvalues:
            imageButton (copy, index: 1)
            chatBarParentFrame (copy, index: 2)
        ]]
        imageButton.Visible = a71
        imageButton.Draggable = a71
        local offset = chatBarParentFrame.Size.Y.Offset

        if a71 then
            chatBarParentFrame.Size = UDim2.new(1, -offset - 2, 0, offset)

            if not bubbleChatOnly() then
                chatBarParentFrame.Position = UDim2.new(0, 0, 1, -offset)
            end
        else
            chatBarParentFrame.Size = UDim2.new(1, 0, 0, offset)

            if not bubbleChatOnly() then
                chatBarParentFrame.Position = UDim2.new(0, 0, 1, -offset)
            end
        end
    end

    local function UpdateChatChannelParentFrameSize()
        --[[
          name: UpdateChatChannelParentFrameSize
          line: 342
          upvalues:
            v18 (ref,  index: 1)
            ChatSettings (copy, index: 2)
            chatChannelParentFrame (copy, index: 3)
        ]]
        local v74
        local v75 = if v18 == 1 then ChatSettings.ChatChannelsTabTextSizePhone else ChatSettings.ChatChannelsTabTextSize
        local v76 = math.max(32, v75 + 8) + 2

        if v18 ~= 1 then
            v74 = ChatSettings.ChatBarTextSize
        else
            v74 = ChatSettings.ChatBarTextSizePhone
        end

        local v77 = v74 + 14 + 10

        if ChatSettings.ShowChannelsBar then
            chatChannelParentFrame.Size = UDim2.new(1, 0, 1, -(((v76 + v77) + 2) + 2))
            chatChannelParentFrame.Position = UDim2.new(0, 0, 0, v76 + 2)

            return
        end

        chatChannelParentFrame.Size = UDim2.new(1, 0, 1, -((v77 + 2) + 2))
        chatChannelParentFrame.Position = UDim2.new(0, 0, 0, 2)
    end

    local function UpdateChatChannelsTabTextSize(a79)
        --[[
          name: UpdateChatChannelsTabTextSize
          line: 357
          upvalues:
            v18 (ref,  index: 1)
            ChatSettings (copy, index: 2)
            channelsBarParentFrame (copy, index: 3)
            UpdateChatChannelParentFrameSize (copy, index: 4)
        ]]
        local v80

        if v18 ~= 1 then
            a79 = v80

            if a79 then
                v80 = a79
            else
                v80 = ChatSettings.ChatChannelsTabTextSize
            end
        else
            a79 = v80

            if a79 then
                v80 = a79
            else
                v80 = ChatSettings.ChatChannelsTabTextSizePhone
            end
        end

        local v81 = math.max(32, v80 + 8) + 2
        channelsBarParentFrame.Size = UDim2.new(1, 0, 0, v81)
        UpdateChatChannelParentFrameSize()
    end

    local function UpdateChatBarTextSize(a83)
        --[[
          name: UpdateChatBarTextSize
          line: 364
          upvalues:
            v18 (ref,  index: 1)
            ChatSettings (copy, index: 2)
            chatBarParentFrame (copy, index: 3)
            imageButton (copy, index: 4)
            UpdateChatChannelParentFrameSize (copy, index: 5)
            UpdateResizable (copy, index: 6)
        ]]
        local v84

        if v18 ~= 1 then
            a83 = v84

            if a83 then
                v84 = a83
            else
                v84 = ChatSettings.ChatBarTextSize
            end
        else
            a83 = v84

            if a83 then
                v84 = a83
            else
                v84 = ChatSettings.ChatBarTextSizePhone
            end
        end

        local v85 = v84 + 14 + 10
        chatBarParentFrame.Size = UDim2.new(1, 0, 0, v85)

        if not bubbleChatOnly() then
            chatBarParentFrame.Position = UDim2.new(0, 0, 1, -v85)
        end

        imageButton.Size = UDim2.new(0, v85, 0, v85)
        imageButton.Position = UDim2.new(1, -v85, 1, -v85)
        UpdateChatChannelParentFrameSize()
        UpdateResizable(ChatSettings.WindowResizable)
    end

    local function UpdateShowChannelsBar(visible: boolean)
        --[[
          name: UpdateShowChannelsBar
          line: 379
          upvalues:
            channelsBarParentFrame (copy, index: 1)
            UpdateChatChannelParentFrameSize (copy, index: 2)
        ]]
        channelsBarParentFrame.Visible = visible
        UpdateChatChannelParentFrameSize()
    end

    local v88 = ChatSettings.ChatChannelsTabTextSize

    if v18 ~= 1 then
        v19 = v88 or ChatSettings.ChatChannelsTabTextSize
    else
        v88 = v88 or ChatSettings.ChatChannelsTabTextSizePhone
        v19 = v88
    end

    local v89 = math.max(32, v19 + 8) + 2
    channelsBarParentFrame.Size = UDim2.new(1, 0, 0, v89)
    UpdateChatChannelParentFrameSize()
    UpdateChatBarTextSize(ChatSettings.ChatBarTextSize)
    local windowDraggable = ChatSettings.WindowDraggable
    frame.Active = windowDraggable
    frame.Draggable = windowDraggable
    UpdateResizable(ChatSettings.WindowResizable)
    channelsBarParentFrame.Visible = ChatSettings.ShowChannelsBar
    UpdateChatChannelParentFrameSize()

    ChatSettings.SettingsChanged:connect(
        function(a91, a92)
            --[[
              line: 390
              upvalues:
                frame (copy, index: 1)
                UpdateResizable (copy, index: 2)
                v18 (ref,  index: 3)
                ChatSettings (copy, index: 4)
                channelsBarParentFrame (copy, index: 5)
                UpdateChatChannelParentFrameSize (copy, index: 6)
                UpdateChatBarTextSize (copy, index: 7)
            ]]
            if a91 == "WindowDraggable" then
                frame.Active = a92
                frame.Draggable = a92

                return
            end

            if a91 == "WindowResizable" then
                UpdateResizable(a92)
                return
            end

            if a91 ~= "ChatChannelsTabTextSize" then
                if a91 == "ChatBarTextSize" then
                    UpdateChatBarTextSize(a92)
                    return
                end

                if a91 == "ShowChannelsBar" then
                    channelsBarParentFrame.Visible = a92
                    UpdateChatChannelParentFrameSize()
                end

                return
            end

            local v93

            if v18 ~= 1 then
                a92 = v93

                if a92 then
                    v93 = a92
                else
                    v93 = ChatSettings.ChatChannelsTabTextSize
                end
            else
                a92 = v93

                if a92 then
                    v93 = a92
                else
                    v93 = ChatSettings.ChatChannelsTabTextSizePhone
                end
            end

            local v94 = math.max(32, v93 + 8) + 2
            channelsBarParentFrame.Size = UDim2.new(1, 0, 0, v94)
            UpdateChatChannelParentFrameSize()
        end
    )

    self.GuiObject = frame
    self.GuiObjects.BaseFrame = frame
    self.GuiObjects.ChatBarParentFrame = chatBarParentFrame
    self.GuiObjects.ChannelsBarParentFrame = channelsBarParentFrame
    self.GuiObjects.ChatChannelParentFrame = chatChannelParentFrame
    self.GuiObjects.ChatResizerFrame = imageButton
    self.GuiObjects.ResizeIcon = resizeIcon
    self:AnimGuiObjects()
end

function Class.GetChatBar(self)
    --[[
      name: GetChatBar
      line: 420
    ]]
    return self.ChatBar
end

function Class.RegisterChatBar(self, chatBar)
    --[[
      name: RegisterChatBar
      line: 424
    ]]
    self.ChatBar = chatBar
    self.ChatBar:CreateGuiObjects(self.GuiObjects.ChatBarParentFrame)
end

function Class.RegisterChannelsBar(self, channelsBar)
    --[[
      name: RegisterChannelsBar
      line: 429
    ]]
    self.ChannelsBar = channelsBar
    self.ChannelsBar:CreateGuiObjects(self.GuiObjects.ChannelsBarParentFrame)
end

function Class.RegisterMessageLogDisplay(self, messageLogDisplay)
    --[[
      name: RegisterMessageLogDisplay
      line: 434
    ]]
    self.MessageLogDisplay = messageLogDisplay
    self.MessageLogDisplay.GuiObject.Parent = self.GuiObjects.ChatChannelParentFrame
end

function Class.AddChannel(self, a103)
    --[[
      name: AddChannel
      line: 439
      upvalues:
        ChatChannel (copy, index: 1)
    ]]
    if self:GetChannel(a103) then
        error("Channel '" .. a103 .. "' already exists!")
        return
    end

    local chatChannel = ChatChannel.new(a103, self.MessageLogDisplay)
    self.Channels[a103:lower()] = chatChannel
    chatChannel:SetActive(false)
    local v105 = self.ChannelsBar:AddChannelTab(a103)
    v105.NameTag.MouseButton1Click:connect(
        function()
            --[[
              line: 451
              upvalues:
                self (copy, index: 1)
                a103 (copy, index: 2)
            ]]
            self:SwitchCurrentChannel(a103)
        end
    )
    chatChannel:RegisterChannelTab(v105)

    return chatChannel
end

function Class.GetFirstChannel(self)
    --[[
      name: GetFirstChannel
      line: 460
    ]]
    local channel

    for _, channel in pairs(self.Channels) do
        return channel
    end

    return nil
end

function Class.RemoveChannel(self, a110)
    --[[
      name: RemoveChannel
      line: 469
      upvalues:
        ChatSettings (copy, index: 1)
    ]]
    if not self:GetChannel(a110) then
        error("Channel '" .. a110 .. "' does not exist!")
    end

    local channelKey = a110:lower()
    local v112 = false

    if self.Channels[channelKey] == self:GetCurrentChannel() then
        v112 = true
        self:SwitchCurrentChannel(nil)
    end

    self.Channels[channelKey]:Destroy()
    self.Channels[channelKey] = nil
    self.ChannelsBar:RemoveChannelTab(a110)

    if v112 then
        local v113
        local v114 = self:GetChannel(ChatSettings.GeneralChannelName) ~= nil
        local v115 = channelKey == ChatSettings.GeneralChannelName:lower()

        if v114 and not v115 then
            v113 = ChatSettings.GeneralChannelName
        else
            local firstChannel = self:GetFirstChannel()
            v113 = firstChannel and firstChannel.Name or nil
        end

        self:SwitchCurrentChannel(v113)
    end

    if not ChatSettings.ShowChannelsBar and self.ChatBar.TargetChannel == a110 then
        self.ChatBar:SetChannelTarget(ChatSettings.GeneralChannelName)
    end
end

function Class.GetChannel(self, a118)
    --[[
      name: GetChannel
      line: 511
    ]]
    return a118 and self.Channels[a118:lower()] or nil
end

function Class.GetTargetMessageChannel(self)
    --[[
      name: GetTargetMessageChannel
      line: 515
      upvalues:
        ChatSettings (copy, index: 1)
    ]]
    if not ChatSettings.ShowChannelsBar then
        return self.ChatBar.TargetChannel
    end

    local currentChannel = self:GetCurrentChannel()

    return currentChannel and currentChannel.Name
end

function Class.GetCurrentChannel(self)
    --[[
      name: GetCurrentChannel
      line: 524
    ]]
    return self.CurrentChannel
end

function Class.SwitchCurrentChannel(self, a123)
    --[[
      name: SwitchCurrentChannel
      line: 528
      upvalues:
        ChatSettings (copy, index: 1)
    ]]
    if not ChatSettings.ShowChannelsBar then
        if const channel = self:GetChannel(a123) then
            self.ChatBar:SetChannelTarget(channel.Name)
        end

        a123 = ChatSettings.GeneralChannelName
    end

    local currentChannel2 = self:GetCurrentChannel()
    local currentChannel = self:GetChannel(a123)
    if currentChannel == nil then
        error(string.format("Channel '%s' does not exist.", a123))
    end

    if currentChannel ~= currentChannel2 then
        if currentChannel2 then
            currentChannel2:SetActive(false)
            local channelTab = self.ChannelsBar:GetChannelTab(currentChannel2.Name)
            channelTab:SetActive(false)
        end

        if currentChannel then
            currentChannel:SetActive(true)
            local channelTab = self.ChannelsBar:GetChannelTab(currentChannel.Name)
            channelTab:SetActive(true)
        end

        self.CurrentChannel = currentChannel
    end
end

function Class.UpdateFrameVisibility(self)
    --[[
      name: UpdateFrameVisibility
      line: 562
    ]]
    self.GuiObject.Visible = self.Visible and self.CoreGuiEnabled
end

function Class.GetVisible(self)
    --[[
      name: GetVisible
      line: 566
    ]]
    return self.Visible
end

function Class.SetVisible(self, visible)
    --[[
      name: SetVisible
      line: 570
    ]]
    self.Visible = visible
    self:UpdateFrameVisibility()
end

function Class.GetCoreGuiEnabled(self)
    --[[
      name: GetCoreGuiEnabled
      line: 575
    ]]
    return self.CoreGuiEnabled
end

function Class.SetCoreGuiEnabled(self, coreGuiEnabled)
    --[[
      name: SetCoreGuiEnabled
      line: 579
    ]]
    self.CoreGuiEnabled = coreGuiEnabled
    self:UpdateFrameVisibility()
end

function Class.EnableResizable(self)
    --[[
      name: EnableResizable
      line: 584
    ]]
    self.GuiObjects.ChatResizerFrame.Active = true
end

function Class.DisableResizable(self)
    --[[
      name: DisableResizable
      line: 588
    ]]
    self.GuiObjects.ChatResizerFrame.Active = false
end

function Class.FadeOutBackground(self, a139)
    --[[
      name: FadeOutBackground
      line: 592
      upvalues:
        CurveUtil (copy, index: 1)
    ]]
    self.ChannelsBar:FadeOutBackground(a139)
    self.MessageLogDisplay:FadeOutBackground(a139)
    self.ChatBar:FadeOutBackground(a139)
    self.AnimParams.Background_TargetTransparency = 1
    self.AnimParams.Background_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(a139)
end

function Class.FadeInBackground(self, a141)
    --[[
      name: FadeInBackground
      line: 601
      upvalues:
        CurveUtil (copy, index: 1)
    ]]
    self.ChannelsBar:FadeInBackground(a141)
    self.MessageLogDisplay:FadeInBackground(a141)
    self.ChatBar:FadeInBackground(a141)
    self.AnimParams.Background_TargetTransparency = 0.6
    self.AnimParams.Background_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(a141)
end

function Class.FadeOutText(self, a143)
    --[[
      name: FadeOutText
      line: 610
    ]]
    self.MessageLogDisplay:FadeOutText(a143)
    self.ChannelsBar:FadeOutText(a143)
end

function Class.FadeInText(self, a145)
    --[[
      name: FadeInText
      line: 615
    ]]
    self.MessageLogDisplay:FadeInText(a145)
    self.ChannelsBar:FadeInText(a145)
end

function Class.AnimGuiObjects(self)
    --[[
      name: AnimGuiObjects
      line: 620
    ]]
    self.GuiObjects.ChatChannelParentFrame.BackgroundTransparency = self.AnimParams.Background_CurrentTransparency
    self.GuiObjects.ChatResizerFrame.BackgroundTransparency = self.AnimParams.Background_CurrentTransparency
    self.GuiObjects.ResizeIcon.ImageTransparency = self.AnimParams.Background_CurrentTransparency
end

function Class.InitializeAnimParams(self)
    --[[
      name: InitializeAnimParams
      line: 626
      upvalues:
        CurveUtil (copy, index: 1)
    ]]
    self.AnimParams.Background_TargetTransparency = 0.6
    self.AnimParams.Background_CurrentTransparency = 0.6
    self.AnimParams.Background_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(0)
end

function Class.Update(self, a149)
    --[[
      name: Update
      line: 632
      upvalues:
        CurveUtil (copy, index: 1)
    ]]
    self.ChatBar:Update(a149)
    self.ChannelsBar:Update(a149)
    self.MessageLogDisplay:Update(a149)
    self.AnimParams.Background_CurrentTransparency = CurveUtil:Expt(self.AnimParams.Background_CurrentTransparency, self.AnimParams.Background_TargetTransparency, self.AnimParams.Background_NormalizedExptValue, a149)
    self:AnimGuiObjects()
end

function v1.new()
    --[[
      name: new
      line: 650
      upvalues:
        Class (copy, index: 1)
    ]]
    local v150 = setmetatable({}, Class)
    v150.GuiObject = nil
    v150.GuiObjects = {}
    v150.ChatBar = nil
    v150.ChannelsBar = nil
    v150.MessageLogDisplay = nil
    v150.Channels = {}
    v150.CurrentChannel = nil
    v150.Visible = true
    v150.CoreGuiEnabled = true
    v150.AnimParams = {}
    v150:InitializeAnimParams()

    return v150
end

return v1