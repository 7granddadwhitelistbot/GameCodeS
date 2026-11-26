local localPlayer
local v2 = {}
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local players = game:GetService("Players")
local textService = game:GetService("TextService")
localPlayer = players.LocalPlayer

while not localPlayer do
    players.PlayerAdded:wait()
    localPlayer = players.LocalPlayer
end

local chat = game:GetService("Chat")
local clientChatModules = chat:WaitForChild("ClientChatModules")
local parent = script.Parent
local ChatSettings = require(clientChatModules:WaitForChild("ChatSettings"))
local CurveUtil = require(parent:WaitForChild("CurveUtil"))
local commandModules = clientChatModules:WaitForChild("CommandModules")
local Whisper = require(commandModules:WaitForChild("Whisper"))
local _ = require(parent:WaitForChild("MessageSender"))
local v15 = nil
pcall(
    function()
        --[[
          line: 35
          upvalues:
            v15 (ref, index: 1)
        ]]
        v15 = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
    end
)

if v15 == nil then
    v15 = {}

    function v15.Get(a16, a17, a18)
        --[[
          name: Get
          line: 36
        ]]
        return a18
    end
end

local Class = {}
Class.__index = Class

function Class.CreateGuiObjects(self, instance: Instance?)
    --[[
      name: CreateGuiObjects
      line: 43
      upvalues:
        ChatSettings (copy, index: 1)
    ]]
    self.ChatBarParentFrame = instance
    local frame = Instance.new("Frame")
    frame.Selectable = false
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 0.6
    frame.BorderSizePixel = 0
    frame.BackgroundColor3 = ChatSettings.ChatBarBackGroundColor
    frame.Parent = instance

    local boxFrame = Instance.new("Frame")
    boxFrame.Selectable = false
    boxFrame.Name = "BoxFrame"
    boxFrame.BackgroundTransparency = 0.6
    boxFrame.BorderSizePixel = 0
    boxFrame.BackgroundColor3 = ChatSettings.ChatBarBoxColor
    boxFrame.Size = UDim2.new(1, -14, 1, -14)
    boxFrame.Position = UDim2.new(0, 7, 0, 7)
    boxFrame.Parent = frame

    local parent = Instance.new("Frame")
    parent.BackgroundTransparency = 1
    parent.Size = UDim2.new(1, -10, 1, -10)
    parent.Position = UDim2.new(0, 5, 0, 5)
    parent.Parent = boxFrame

    local chatBar = Instance.new("TextBox")
    chatBar.Selectable = ChatSettings.GamepadNavigationEnabled
    chatBar.Name = "ChatBar"
    chatBar.BackgroundTransparency = 1
    chatBar.Size = UDim2.new(1, 0, 1, 0)
    chatBar.Position = UDim2.new(0, 0, 0, 0)
    chatBar.TextSize = ChatSettings.ChatBarTextSize
    chatBar.Font = ChatSettings.ChatBarFont
    chatBar.TextColor3 = ChatSettings.ChatBarTextColor
    chatBar.TextTransparency = 0.4
    chatBar.TextStrokeTransparency = 1
    chatBar.ClearTextOnFocus = false
    chatBar.TextXAlignment = Enum.TextXAlignment.Left
    chatBar.TextYAlignment = Enum.TextYAlignment.Top
    chatBar.TextWrapped = true
    chatBar.Text = ""
    chatBar.Parent = parent

    local messageMode = Instance.new("TextButton")
    messageMode.Selectable = false
    messageMode.Name = "MessageMode"
    messageMode.BackgroundTransparency = 1
    messageMode.Position = UDim2.new(0, 0, 0, 0)
    messageMode.TextSize = ChatSettings.ChatBarTextSize
    messageMode.Font = ChatSettings.ChatBarFont
    messageMode.TextXAlignment = Enum.TextXAlignment.Left
    messageMode.TextWrapped = true
    messageMode.Text = ""
    messageMode.Size = UDim2.new(0, 0, 0, 0)
    messageMode.TextYAlignment = Enum.TextYAlignment.Center
    messageMode.TextColor3 = self:GetDefaultChannelNameColor()
    messageMode.Visible = true
    messageMode.Parent = parent

    local textLabel = Instance.new("TextLabel")
    textLabel.Selectable = false
    textLabel.TextWrapped = true
    textLabel.BackgroundTransparency = 1
    textLabel.Size = chatBar.Size
    textLabel.Position = chatBar.Position
    textLabel.TextSize = chatBar.TextSize
    textLabel.Font = chatBar.Font
    textLabel.TextColor3 = chatBar.TextColor3
    textLabel.TextTransparency = chatBar.TextTransparency
    textLabel.TextStrokeTransparency = chatBar.TextStrokeTransparency
    textLabel.TextXAlignment = chatBar.TextXAlignment
    textLabel.TextYAlignment = chatBar.TextYAlignment
    textLabel.Text = "..."
    textLabel.Parent = parent
    self.GuiObject = frame
    self.TextBox = chatBar
    self.TextLabel = textLabel
    self.GuiObjects.BaseFrame = frame
    self.GuiObjects.TextBoxFrame = boxFrame
    self.GuiObjects.TextBox = chatBar
    self.GuiObjects.TextLabel = textLabel
    self.GuiObjects.MessageModeTextButton = messageMode
    self:AnimGuiObjects()
    self:SetUpTextBoxEvents(chatBar, textLabel, messageMode)

    if self.UserHasChatOff then
        self:DoLockChatBar()
    end

    self.eGuiObjectsChanged:Fire()
end

function Class.DoLockChatBar(self)
    --[[
      name: DoLockChatBar
      line: 142
      upvalues:
        localPlayer (ref, index: 1)
        v15 (ref, index: 2)
    ]]
    if self.TextLabel then
        if not (0 < localPlayer.UserId) then
            self.TextLabel.Text = v15:Get("GameChat_SwallowGuestChat_Message", "Sign up to chat in game.")
        else
            self.TextLabel.Text = v15:Get("GameChat_ChatMessageValidator_SettingsError", "To chat in game, turn on chat in your Privacy Settings.")
        end

        self:CalculateSize()
    end

    if self.TextBox then
        self.TextBox.Active = false
        self.TextBox.Focused:connect(
            function()
                --[[
                  line: 159
                  upvalues:
                    self (copy, index: 1)
                ]]
                self.TextBox:ReleaseFocus()
            end
        )
    end
end

function Class.SetUpTextBoxEvents(self, a30, a31, a32)
    --[[
      name: SetUpTextBoxEvents
      line: 165
      upvalues:
        userInputService (copy, index: 1)
        ChatSettings (copy, index: 2)
    ]]
    for textBoxConnectionKey, textBoxConnection in pairs(self.TextBoxConnections) do
        textBoxConnection:disconnect()
        self.TextBoxConnections[textBoxConnectionKey] = nil
    end

    self.TextBoxConnections.UserInputBegan = userInputService.InputBegan:connect(
        function(input: InputObject, gameProcessedEvent: boolean)
            --[[
              line: 173
              upvalues:
                self (copy, index: 1)
                a30 (copy, index: 2)
                ChatSettings (copy, index: 3)
            ]]
            if input.KeyCode == Enum.KeyCode.Backspace and self:IsFocused() and a30.Text == "" then
                self:SetChannelTarget(ChatSettings.GeneralChannelName)
            end
        end
    )

    self.TextBoxConnections.TextBoxChanged = a30.Changed:connect(
        function(a37)
            --[[
              line: 181
              upvalues:
                self (copy, index: 1)
                a30 (copy, index: 2)
                ChatSettings (copy, index: 3)
            ]]
            if a37 == "AbsoluteSize" then
                self:CalculateSize()
                return
            end

            if a37 ~= "Text" then
                return
            end

            self:CalculateSize()
            local length = utf8.len(utf8.nfcnormalize(a30.Text))

            if ChatSettings.MaximumMessageLength < length then
                a30.Text = self.PreviousText
            else
                self.PreviousText = a30.Text
            end

            if self.InCustomState then
                self.CustomState:TextUpdated()
            elseif const customState = self.CommandProcessor:ProcessInProgressChatMessage(a30.Text, self.ChatWindow, self) then
                self.InCustomState = true
                self.CustomState = customState
            end
        end
    )

    local function UpdateOnFocusStatusChanged(a41)
        --[[
          name: UpdateOnFocusStatusChanged
          line: 210
          upvalues:
            a30 (copy, index: 1)
            a31 (copy, index: 2)
        ]]
        if not a41 and a30.Text == "" then
            a31.Visible = true
            return
        end

        a31.Visible = false
    end

    self.TextBoxConnections.MessageModeClick = a32.MouseButton1Click:connect(
        function()
            --[[
              line: 218
              upvalues:
                a32 (copy, index: 1)
                self (copy, index: 2)
                ChatSettings (copy, index: 3)
            ]]
            if a32.Text ~= "" then
                self:SetChannelTarget(ChatSettings.GeneralChannelName)
            end
        end
    )

    self.TextBoxConnections.TextBoxFocused = a30.Focused:connect(
        function()
            --[[
              line: 224
              upvalues:
                self (copy, index: 1)
                a31 (copy, index: 2)
            ]]
            if not self.UserHasChatOff then
                self:CalculateSize()
                a31.Visible = false
            end
        end
    )

    self.TextBoxConnections.TextBoxFocusLost = a30.FocusLost:connect(
        function(a42, a43)
            --[[
              line: 231
              upvalues:
                self (copy, index: 1)
                a30 (copy, index: 2)
                a31 (copy, index: 3)
            ]]
            self:CalculateSize()

            if a43 and a43.KeyCode == Enum.KeyCode.Escape then
                a30.Text = ""
            end

            if a30.Text ~= "" then
                a31.Visible = false
                return
            end

            a31.Visible = true
        end
    )
end

function Class.GetTextBox(self)
    --[[
      name: GetTextBox
      line: 240
    ]]
    return self.TextBox
end

function Class.GetMessageModeTextButton(self)
    --[[
      name: GetMessageModeTextButton
      line: 244
    ]]
    return self.GuiObjects.MessageModeTextButton
end

function Class.GetMessageModeTextLabel(self)
    --[[
      name: GetMessageModeTextLabel
      line: 250
    ]]
    return self:GetMessageModeTextButton()
end

function Class.IsFocused(self)
    --[[
      name: IsFocused
      line: 254
    ]]
    if self.UserHasChatOff then
        return false
    end

    return self:GetTextBox():IsFocused()
end

function Class.GetVisible(self)
    --[[
      name: GetVisible
      line: 262
    ]]
    return self.GuiObject.Visible
end

function Class.CaptureFocus(self)
    --[[
      name: CaptureFocus
      line: 266
    ]]
    if not self.UserHasChatOff then
        self:GetTextBox():CaptureFocus()
    end
end

function Class.ReleaseFocus(self, a51)
    --[[
      name: ReleaseFocus
      line: 272
    ]]
    self:GetTextBox():ReleaseFocus(a51)
end

function Class.ResetText(self)
    --[[
      name: ResetText
      line: 276
    ]]
    self:GetTextBox().Text = ""
end

function Class.SetText(self, text)
    --[[
      name: SetText
      line: 280
    ]]
    self:GetTextBox().Text = text
end

function Class.GetEnabled(self)
    --[[
      name: GetEnabled
      line: 284
    ]]
    return self.GuiObject.Visible
end

function Class.SetEnabled(self, enabled)
    --[[
      name: SetEnabled
      line: 288
    ]]
    if self.UserHasChatOff then
        self.GuiObject.Visible = true
        return
    end

    self.GuiObject.Visible = enabled
end

function Class.SetTextLabelText(self, textLabelText)
    --[[
      name: SetTextLabelText
      line: 298
    ]]
    if not self.UserHasChatOff then
        self.TextLabel.Text = textLabelText
    end
end

function Class.SetTextBoxText(self, textBoxText)
    --[[
      name: SetTextBoxText
      line: 304
    ]]
    self.TextBox.Text = textBoxText
end

function Class.GetTextBoxText(self)
    --[[
      name: GetTextBoxText
      line: 308
    ]]
    return self.TextBox.Text
end

function Class.ResetSize(self)
    --[[
      name: ResetSize
      line: 312
    ]]
    self.TargetYSize = 0
    self:TweenToTargetYSize()
end

local function measureSize(a65)
    --[[
      name: measureSize
      line: 317
      upvalues:
        textService (copy, index: 1)
    ]]
    return textService:GetTextSize(a65.Text, a65.TextSize, a65.Font, Vector2.new(a65.AbsoluteSize.X, 10000))
end

function Class.CalculateSize(self)
    --[[
      name: CalculateSize
      line: 326
      upvalues:
        textService (copy, index: 1)
    ]]
    local textSize, y

    if self.CalculatingSizeLock then
        return
    end

    self.CalculatingSizeLock = true

    if self:IsFocused() or self.TextBox.Text ~= "" then
        textSize = self.TextBox.TextSize
        local textBox = self.TextBox
        y = textService:GetTextSize(textBox.Text, textBox.TextSize, textBox.Font, Vector2.new(textBox.AbsoluteSize.X, 10000)).Y
    else
        textSize = self.TextLabel.TextSize
        local textLabel = self.TextLabel
        y = textService:GetTextSize(textLabel.Text, textLabel.TextSize, textLabel.Font, Vector2.new(textLabel.AbsoluteSize.X, 10000)).Y
    end

    local targetYSize = y - textSize

    if self.TargetYSize ~= targetYSize then
        self.TargetYSize = targetYSize
        self:TweenToTargetYSize()
    end

    self.CalculatingSizeLock = false
end

function Class.TweenToTargetYSize(self)
    --[[
      name: TweenToTargetYSize
      line: 352
    ]]
    local size2 = UDim2.new(1, 0, 1, self.TargetYSize)
    local size = self.GuiObject.Size
    local y = self.GuiObject.AbsoluteSize.Y
    self.GuiObject.Size = size2
    local y2 = self.GuiObject.AbsoluteSize.Y
    self.GuiObject.Size = size
    local v77 = math.min(1, math.abs(y2 - y) * (1 / self.TweenPixelsPerSecond))

    if not pcall(
        function()
            --[[
              line: 364
              upvalues:
                self (copy, index: 1)
                size2 (copy, index: 2)
                v77 (copy, index: 3)
            ]]
            self.GuiObject:TweenSize(size2, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, v77, true)
        end
    ) then
        self.GuiObject.Size = size2
    end
end

function Class.SetTextSize(self, textSize)
    --[[
      name: SetTextSize
      line: 372
    ]]
    if not self:IsInCustomState() then
        if self.TextBox then
            self.TextBox.TextSize = textSize
        end

        if self.TextLabel then
            self.TextLabel.TextSize = textSize
        end
    end
end

function Class.GetDefaultChannelNameColor(self)
    --[[
      name: GetDefaultChannelNameColor
      line: 383
      upvalues:
        ChatSettings (copy, index: 1)
    ]]
    if ChatSettings.DefaultChannelNameColor then
        return ChatSettings.DefaultChannelNameColor
    end

    return Color3.fromRGB(35, 76, 142)
end

function Class.SetChannelTarget(self, channelTarget)
    --[[
      name: SetChannelTarget
      line: 390
      upvalues:
        ChatSettings (copy, index: 1)
        v15 (ref,  index: 2)
    ]]
    local messageModeTextButton = self.GuiObjects.MessageModeTextButton
    local textBox = self.TextBox
    local textLabel = self.TextLabel
    self.TargetChannel = channelTarget

    if not self:IsInCustomState() then
        if channelTarget ~= ChatSettings.GeneralChannelName then
            messageModeTextButton.Size = UDim2.new(0, 1000, 1, 0)
            local v86 = if v15.tryLocalize then v15:tryLocalize(channelTarget) else channelTarget
            messageModeTextButton.Text = string.format("[%s] ", v86)

            if const textColor3 = self:GetChannelNameColor(channelTarget) then
                messageModeTextButton.TextColor3 = textColor3
            else
                messageModeTextButton.TextColor3 = self:GetDefaultChannelNameColor()
            end

            local x = messageModeTextButton.TextBounds.X
            messageModeTextButton.Size = UDim2.new(0, x, 1, 0)
            textBox.Size = UDim2.new(1, -x, 1, 0)
            textBox.Position = UDim2.new(0, x, 0, 0)
            textLabel.Size = UDim2.new(1, -x, 1, 0)
            textLabel.Position = UDim2.new(0, x, 0, 0)

            return
        end

        messageModeTextButton.Text = ""
        messageModeTextButton.Size = UDim2.new(0, 0, 0, 0)
        textBox.Size = UDim2.new(1, 0, 1, 0)
        textBox.Position = UDim2.new(0, 0, 0, 0)
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.Position = UDim2.new(0, 0, 0, 0)
    end
end

function Class.IsInCustomState(self)
    --[[
      name: IsInCustomState
      line: 430
    ]]
    return self.InCustomState
end

function Class.ResetCustomState(self)
    --[[
      name: ResetCustomState
      line: 434
      upvalues:
        v15 (ref, index: 1)
    ]]
    if self.InCustomState then
        self.CustomState:Destroy()
        self.CustomState = nil
        self.InCustomState = false
        self.ChatBarParentFrame:ClearAllChildren()
        self:CreateGuiObjects(self.ChatBarParentFrame)
        self:SetTextLabelText(v15:Get("GameChat_ChatMain_ChatBarText", "To chat click here or press \"/\" key"))
    end
end

function Class.EnterWhisperState(self, a92)
    --[[
      name: EnterWhisperState
      line: 451
      upvalues:
        Whisper (copy, index: 1)
        ChatSettings (copy, index: 2)
    ]]
    self:ResetCustomState()

    if Whisper.CustomStateCreator then
        self.CustomState = Whisper.CustomStateCreator(a92, self.ChatWindow, self, ChatSettings)
        self.InCustomState = true
    else
        local v93 = if ChatSettings.PlayerDisplayNamesEnabled then a92.DisplayName else a92.Name
        self:SetText("/w " .. v93)
    end

    self:CaptureFocus()
end

function Class.GetCustomMessage(self)
    --[[
      name: GetCustomMessage
      line: 475
    ]]
    if self.InCustomState then
        return self.CustomState:GetMessage()
    end

    return nil
end

function Class.CustomStateProcessCompletedMessage(self, a96)
    --[[
      name: CustomStateProcessCompletedMessage
      line: 482
    ]]
    if self.InCustomState then
        return self.CustomState:ProcessCompletedMessage()
    end

    return false
end

function Class.FadeOutBackground(self, a98)
    --[[
      name: FadeOutBackground
      line: 489
      upvalues:
        CurveUtil (copy, index: 1)
    ]]
    self.AnimParams.Background_TargetTransparency = 1
    self.AnimParams.Background_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(a98)
    self:FadeOutText(a98)
end

function Class.FadeInBackground(self, a100)
    --[[
      name: FadeInBackground
      line: 495
      upvalues:
        CurveUtil (copy, index: 1)
    ]]
    self.AnimParams.Background_TargetTransparency = 0.6
    self.AnimParams.Background_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(a100)
    self:FadeInText(a100)
end

function Class.FadeOutText(self, a102)
    --[[
      name: FadeOutText
      line: 501
      upvalues:
        CurveUtil (copy, index: 1)
    ]]
    self.AnimParams.Text_TargetTransparency = 1
    self.AnimParams.Text_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(a102)
end

function Class.FadeInText(self, a104)
    --[[
      name: FadeInText
      line: 506
      upvalues:
        CurveUtil (copy, index: 1)
    ]]
    self.AnimParams.Text_TargetTransparency = 0.4
    self.AnimParams.Text_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(a104)
end

function Class.AnimGuiObjects(self)
    --[[
      name: AnimGuiObjects
      line: 511
    ]]
    self.GuiObject.BackgroundTransparency = self.AnimParams.Background_CurrentTransparency
    self.GuiObjects.TextBoxFrame.BackgroundTransparency = self.AnimParams.Background_CurrentTransparency
    self.GuiObjects.TextLabel.TextTransparency = self.AnimParams.Text_CurrentTransparency
    self.GuiObjects.TextBox.TextTransparency = self.AnimParams.Text_CurrentTransparency
    self.GuiObjects.MessageModeTextButton.TextTransparency = self.AnimParams.Text_CurrentTransparency
end

function Class.InitializeAnimParams(self)
    --[[
      name: InitializeAnimParams
      line: 520
    ]]
    self.AnimParams.Text_TargetTransparency = 0.4
    self.AnimParams.Text_CurrentTransparency = 0.4
    self.AnimParams.Text_NormalizedExptValue = 1
    self.AnimParams.Background_TargetTransparency = 0.6
    self.AnimParams.Background_CurrentTransparency = 0.6
    self.AnimParams.Background_NormalizedExptValue = 1
end

function Class.Update(self, a108)
    --[[
      name: Update
      line: 530
      upvalues:
        CurveUtil (copy, index: 1)
    ]]
    self.AnimParams.Text_CurrentTransparency = CurveUtil:Expt(self.AnimParams.Text_CurrentTransparency, self.AnimParams.Text_TargetTransparency, self.AnimParams.Text_NormalizedExptValue, a108)
    self.AnimParams.Background_CurrentTransparency = CurveUtil:Expt(self.AnimParams.Background_CurrentTransparency, self.AnimParams.Background_TargetTransparency, self.AnimParams.Background_NormalizedExptValue, a108)
    self:AnimGuiObjects()
end

function Class.SetChannelNameColor(self, channelNameColorKey, textColor3)
    --[[
      name: SetChannelNameColor
      line: 547
    ]]
    self.ChannelNameColors[channelNameColorKey] = textColor3

    if self.GuiObjects.MessageModeTextButton.Text == channelNameColorKey then
        self.GuiObjects.MessageModeTextButton.TextColor3 = textColor3
    end
end

function Class.GetChannelNameColor(self, channelNameColorKey)
    --[[
      name: GetChannelNameColor
      line: 554
    ]]
    return self.ChannelNameColors[channelNameColorKey]
end

function v2.new(commandProcessor, chatWindow)
    --[[
      name: new
      line: 561
      upvalues:
        Class (copy, index: 1)
        ChatSettings (copy, index: 2)
        chat (copy, index: 3)
        localPlayer (ref,  index: 4)
        runService (copy, index: 5)
    ]]
    local v116 = setmetatable({}, Class)
    v116.GuiObject = nil
    v116.ChatBarParentFrame = nil
    v116.TextBox = nil
    v116.TextLabel = nil
    v116.GuiObjects = {}
    v116.eGuiObjectsChanged = Instance.new("BindableEvent")
    v116.GuiObjectsChanged = v116.eGuiObjectsChanged.Event
    v116.TextBoxConnections = {}
    v116.PreviousText = ""
    v116.InCustomState = false
    v116.CustomState = nil
    v116.TargetChannel = nil
    v116.CommandProcessor = commandProcessor
    v116.ChatWindow = chatWindow
    v116.TweenPixelsPerSecond = 500
    v116.TargetYSize = 0
    v116.AnimParams = {}
    v116.CalculatingSizeLock = false
    v116.ChannelNameColors = {}
    v116.UserHasChatOff = false
    v116:InitializeAnimParams()

    ChatSettings.SettingsChanged:connect(
        function(a117, textSize)
            --[[
              line: 593
              upvalues:
                v116 (copy, index: 1)
            ]]
            if a117 == "ChatBarTextSize" then
                v116:SetTextSize(textSize)
            end
        end
    )

    coroutine.wrap(
        function()
            --[[
              line: 599
              upvalues:
                chat (copy, index: 1)
                localPlayer (ref,  index: 2)
                runService (copy, index: 3)
                v116 (copy, index: 4)
            ]]
            local v119, canUserChatAsync = pcall(
                function()
                    --[[
                      line: 600
                      upvalues:
                        chat (copy, index: 1)
                        localPlayer (ref,  index: 2)
                    ]]
                    return chat:CanUserChatAsync(localPlayer.UserId)
                end
            )
            v119 = v119 and (runService:IsStudio() or canUserChatAsync)

            if v119 == false then
                v116.UserHasChatOff = true
                v116:DoLockChatBar()
            end
        end
    )()

    return v116
end

return v2