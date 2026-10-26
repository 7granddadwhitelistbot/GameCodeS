local tbl_1 = {}
local UserInputService_upv_1 = game:GetService("UserInputService")
local RunService_upv_1 = game:GetService("RunService")
local Players_1 = game:GetService("Players")
local TextService_upv_1 = game:GetService("TextService")
local LocalPlayer_upv_1 = Players_1.LocalPlayer
while not (LocalPlayer_upv_1) do
    Players_1.PlayerAdded:wait()
    LocalPlayer_upv_1 = Players_1.LocalPlayer
end
local Chat_upv_1 = game:GetService("Chat")
local ClientChatModules_1 = Chat_upv_1:WaitForChild("ClientChatModules")
local Parent_1 = script.Parent
local ChatSettings_upv_1 = require(ClientChatModules_1:WaitForChild("ChatSettings"))
local CurveUtil_upv_1 = require(Parent_1:WaitForChild("CurveUtil"))
local Whisper_upv_1 = require(ClientChatModules_1:WaitForChild("CommandModules"):WaitForChild("Whisper"))
local _ = require(Parent_1:WaitForChild("MessageSender"))
local u1 = nil
pcall(
    function()
        --[[
          line: 35
          upvalues:
            u1 (ref, index: 1)
        ]]
        u1 = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
    end
)
if u1 == nil then
    u1 = {}
    function u1.Get(a1, a2, a3)
        --[[
          name: Get
          line: 36
        ]]
        return a3
    end
end
local tbl_upv_2 = {}
tbl_upv_2.__index = tbl_upv_2
function tbl_upv_2.CreateGuiObjects(a1, a2)
    --[[
      name: CreateGuiObjects
      line: 43
      upvalues:
        ChatSettings_upv_1 (copy, index: 1)
    ]]
    a1.ChatBarParentFrame = a2
    local v1 = Instance.new("Frame")
    v1.Selectable = false
    v1.Size = UDim2.new(1, 0, 1, 0)
    v1.BackgroundTransparency = 0.6
    v1.BorderSizePixel = 0
    v1.BackgroundColor3 = ChatSettings_upv_1.ChatBarBackGroundColor
    v1.Parent = a2
    local v2 = Instance.new("Frame")
    v2.Selectable = false
    v2.Name = "BoxFrame"
    v2.BackgroundTransparency = 0.6
    v2.BorderSizePixel = 0
    v2.BackgroundColor3 = ChatSettings_upv_1.ChatBarBoxColor
    v2.Size = UDim2.new(1, -14, 1, -14)
    v2.Position = UDim2.new(0, 7, 0, 7)
    v2.Parent = v1
    local v3 = Instance.new("Frame")
    v3.BackgroundTransparency = 1
    v3.Size = UDim2.new(1, -10, 1, -10)
    v3.Position = UDim2.new(0, 5, 0, 5)
    v3.Parent = v2
    local v4 = Instance.new("TextBox")
    v4.Selectable = ChatSettings_upv_1.GamepadNavigationEnabled
    v4.Name = "ChatBar"
    v4.BackgroundTransparency = 1
    v4.Size = UDim2.new(1, 0, 1, 0)
    v4.Position = UDim2.new(0, 0, 0, 0)
    v4.TextSize = ChatSettings_upv_1.ChatBarTextSize
    v4.Font = ChatSettings_upv_1.ChatBarFont
    v4.TextColor3 = ChatSettings_upv_1.ChatBarTextColor
    v4.TextTransparency = 0.4
    v4.TextStrokeTransparency = 1
    v4.ClearTextOnFocus = false
    v4.TextXAlignment = Enum.TextXAlignment.Left
    v4.TextYAlignment = Enum.TextYAlignment.Top
    v4.TextWrapped = true
    v4.Text = ""
    v4.Parent = v3
    local v5 = Instance.new("TextButton")
    v5.Selectable = false
    v5.Name = "MessageMode"
    v5.BackgroundTransparency = 1
    v5.Position = UDim2.new(0, 0, 0, 0)
    v5.TextSize = ChatSettings_upv_1.ChatBarTextSize
    v5.Font = ChatSettings_upv_1.ChatBarFont
    v5.TextXAlignment = Enum.TextXAlignment.Left
    v5.TextWrapped = true
    v5.Text = ""
    v5.Size = UDim2.new(0, 0, 0, 0)
    v5.TextYAlignment = Enum.TextYAlignment.Center
    v5.TextColor3 = a1:GetDefaultChannelNameColor()
    v5.Visible = true
    v5.Parent = v3
    local v6 = Instance.new("TextLabel")
    v6.Selectable = false
    v6.TextWrapped = true
    v6.BackgroundTransparency = 1
    v6.Size = v4.Size
    v6.Position = v4.Position
    v6.TextSize = v4.TextSize
    v6.Font = v4.Font
    v6.TextColor3 = v4.TextColor3
    v6.TextTransparency = v4.TextTransparency
    v6.TextStrokeTransparency = v4.TextStrokeTransparency
    v6.TextXAlignment = v4.TextXAlignment
    v6.TextYAlignment = v4.TextYAlignment
    v6.Text = "..."
    v6.Parent = v3
    a1.GuiObject = v1
    a1.TextBox = v4
    a1.TextLabel = v6
    a1.GuiObjects.BaseFrame = v1
    a1.GuiObjects.TextBoxFrame = v2
    a1.GuiObjects.TextBox = v4
    a1.GuiObjects.TextLabel = v6
    a1.GuiObjects.MessageModeTextButton = v5
    a1:AnimGuiObjects()
    a1:SetUpTextBoxEvents(v4, v6, v5)
    if a1.UserHasChatOff then
        a1:DoLockChatBar()
    end
    a1.eGuiObjectsChanged:Fire()
end
function tbl_upv_2.DoLockChatBar(a1)
    --[[
      name: DoLockChatBar
      line: 142
      upvalues:
        LocalPlayer_upv_1 (ref, index: 1)
        u1 (ref, index: 2)
    ]]
    if a1.TextLabel then
        if LocalPlayer_upv_1.UserId > 0 then
            a1.TextLabel.Text = u1:Get("GameChat_ChatMessageValidator_SettingsError", "To chat in game, turn on chat in your Privacy Settings.")
        else
            a1.TextLabel.Text = u1:Get("GameChat_SwallowGuestChat_Message", "Sign up to chat in game.")
        end
        a1:CalculateSize()
    end
    if not a1.TextBox then
        return
    end
    a1.TextBox.Active = false
    a1.TextBox.Focused:connect(
        function()
            --[[
              line: 159
              upvalues:
                a1 (copy, index: 1)
            ]]
            a1.TextBox:ReleaseFocus()
        end
    )
end
function tbl_upv_2.SetUpTextBoxEvents(a1, a2, a3, a4)
    --[[
      name: SetUpTextBoxEvents
      line: 165
      upvalues:
        UserInputService_upv_1 (copy, index: 1)
        ChatSettings_upv_1 (copy, index: 2)
    ]]
    for key_1, value_1 in pairs(a1.TextBoxConnections) do
        value_1:disconnect()
        a1.TextBoxConnections[key_1] = nil
    end
    a1.TextBoxConnections.UserInputBegan = UserInputService_upv_1.InputBegan:connect(
        function(a5, a6)
            --[[
              line: 173
              upvalues:
                a1 (copy, index: 1)
                a2 (copy, index: 2)
                ChatSettings_upv_1 (copy, index: 3)
            ]]
            if a5.KeyCode ~= Enum.KeyCode.Backspace or not a1:IsFocused() or a2.Text ~= "" then
                return
            end
            a1:SetChannelTarget(ChatSettings_upv_1.GeneralChannelName)
        end
    )
    a1.TextBoxConnections.TextBoxChanged = a2.Changed:connect(
        function(a7)
            --[[
              line: 181
              upvalues:
                a1 (copy, index: 1)
                a2 (copy, index: 2)
                ChatSettings_upv_1 (copy, index: 3)
            ]]
            if a7 == "AbsoluteSize" then
                a1:CalculateSize()
            elseif a7 == "Text" then
                a1:CalculateSize()
                if ChatSettings_upv_1.MaximumMessageLength < utf8.len(utf8.nfcnormalize(a2.Text)) then
                    a2.Text = a1.PreviousText
                else
                    a1.PreviousText = a2.Text
                end
                local v7 = nil
                if a1.InCustomState then
                    a1.CustomState:TextUpdated()
                else
                    v7 = a1.CommandProcessor:ProcessInProgressChatMessage(a2.Text, a1.ChatWindow, a1)
                    if v7 then
                        a1.InCustomState = true
                        a1.CustomState = v7
                        return
                    end
                end
            end
        end
    )
    local function UpdateOnFocusStatusChanged(a8)
        --[[
          name: UpdateOnFocusStatusChanged
          line: 210
          upvalues:
            a2 (copy, index: 1)
            a3 (copy, index: 2)
        ]]
        if not (a8) and a2.Text == "" then
            a3.Visible = true
        else
            a3.Visible = false
        end
    end
    a1.TextBoxConnections.MessageModeClick = a4.MouseButton1Click:connect(
        function()
            --[[
              line: 218
              upvalues:
                a4 (copy, index: 1)
                a1 (copy, index: 2)
                ChatSettings_upv_1 (copy, index: 3)
            ]]
            if a4.Text == "" then
                return
            end
            a1:SetChannelTarget(ChatSettings_upv_1.GeneralChannelName)
        end
    )
    a1.TextBoxConnections.TextBoxFocused = a2.Focused:connect(
        function()
            --[[
              line: 224
              upvalues:
                a1 (copy, index: 1)
                a3 (copy, index: 2)
            ]]
            if (a1.UserHasChatOff) then
                return
            end
            a1:CalculateSize()
            a3.Visible = false
        end
    )
    a1.TextBoxConnections.TextBoxFocusLost = a2.FocusLost:connect(
        function(a9, a10)
            --[[
              line: 231
              upvalues:
                a1 (copy, index: 1)
                a2 (copy, index: 2)
                a3 (copy, index: 3)
            ]]
            a1:CalculateSize()
            if a10 and a10.KeyCode == Enum.KeyCode.Escape then
                a2.Text = ""
            end
            if a2.Text == "" then
                a3.Visible = true
            else
                a3.Visible = false
            end
        end
    )
end
function tbl_upv_2.GetTextBox(a1)
    --[[
      name: GetTextBox
      line: 240
    ]]
    return a1.TextBox
end
function tbl_upv_2.GetMessageModeTextButton(a1)
    --[[
      name: GetMessageModeTextButton
      line: 244
    ]]
    return a1.GuiObjects.MessageModeTextButton
end
function tbl_upv_2.GetMessageModeTextLabel(a1)
    --[[
      name: GetMessageModeTextLabel
      line: 250
    ]]
    return a1:GetMessageModeTextButton()
end
function tbl_upv_2.IsFocused(a1)
    --[[
      name: IsFocused
      line: 254
    ]]
    if a1.UserHasChatOff then
        return false
    end
    return a1:GetTextBox():IsFocused()
end
function tbl_upv_2.GetVisible(a1)
    --[[
      name: GetVisible
      line: 262
    ]]
    return a1.GuiObject.Visible
end
function tbl_upv_2.CaptureFocus(a1)
    --[[
      name: CaptureFocus
      line: 266
    ]]
    if (a1.UserHasChatOff) then
        return
    end
    a1:GetTextBox():CaptureFocus()
end
function tbl_upv_2.ReleaseFocus(a1, a2)
    --[[
      name: ReleaseFocus
      line: 272
    ]]
    a1:GetTextBox():ReleaseFocus(a2)
end
function tbl_upv_2.ResetText(a1)
    --[[
      name: ResetText
      line: 276
    ]]
    a1:GetTextBox().Text = ""
end
function tbl_upv_2.SetText(a1, a2)
    --[[
      name: SetText
      line: 280
    ]]
    a1:GetTextBox().Text = a2
end
function tbl_upv_2.GetEnabled(a1)
    --[[
      name: GetEnabled
      line: 284
    ]]
    return a1.GuiObject.Visible
end
function tbl_upv_2.SetEnabled(a1, a2)
    --[[
      name: SetEnabled
      line: 288
    ]]
    if a1.UserHasChatOff then
        a1.GuiObject.Visible = true
    else
        a1.GuiObject.Visible = a2
    end
end
function tbl_upv_2.SetTextLabelText(a1, a2)
    --[[
      name: SetTextLabelText
      line: 298
    ]]
    if (a1.UserHasChatOff) then
        return
    end
    a1.TextLabel.Text = a2
end
function tbl_upv_2.SetTextBoxText(a1, a2)
    --[[
      name: SetTextBoxText
      line: 304
    ]]
    a1.TextBox.Text = a2
end
function tbl_upv_2.GetTextBoxText(a1)
    --[[
      name: GetTextBoxText
      line: 308
    ]]
    return a1.TextBox.Text
end
function tbl_upv_2.ResetSize(a1)
    --[[
      name: ResetSize
      line: 312
    ]]
    a1.TargetYSize = 0
    a1:TweenToTargetYSize()
end
local function measureSize(a1)
    --[[
      name: measureSize
      line: 317
      upvalues:
        TextService_upv_1 (copy, index: 1)
    ]]
    return TextService_upv_1:GetTextSize(a1.Text, a1.TextSize, a1.Font, Vector2.new(a1.AbsoluteSize.X, 10000))
end
function tbl_upv_2.CalculateSize(a1)
    --[[
      name: CalculateSize
      line: 326
      upvalues:
        TextService_upv_1 (copy, index: 1)
    ]]
    if a1.CalculatingSizeLock then
        return
    end
    a1.CalculatingSizeLock = true
    local v8, v9
    if a1:IsFocused() or a1.TextBox.Text ~= "" then
        v9 = a1.TextBox.TextSize
        local _ = a1.TextBox
        v8 = TextService_upv_1:GetTextSize(a1.TextBox.Text, a1.TextBox.TextSize, a1.TextBox.Font, Vector2.new(a1.TextBox.AbsoluteSize.X, 10000)).Y
    else
        v9 = a1.TextLabel.TextSize
        local _ = a1.TextLabel
        v8 = TextService_upv_1:GetTextSize(a1.TextLabel.Text, a1.TextLabel.TextSize, a1.TextLabel.Font, Vector2.new(a1.TextLabel.AbsoluteSize.X, 10000)).Y
    end
    local v10 = v8 - v9
    if a1.TargetYSize ~= v10 then
        a1.TargetYSize = v10
        a1:TweenToTargetYSize()
    end
    a1.CalculatingSizeLock = false
end
function tbl_upv_2.TweenToTargetYSize(a1)
    --[[
      name: TweenToTargetYSize
      line: 352
    ]]
    local u2 = UDim2.new(1, 0, 1, a1.TargetYSize)
    a1.GuiObject.Size = u2
    a1.GuiObject.Size = a1.GuiObject.Size
    local u3 = math.min(1, math.abs(a1.GuiObject.AbsoluteSize.Y - a1.GuiObject.AbsoluteSize.Y) * (1 / a1.TweenPixelsPerSecond))
    if (pcall(
        function()
            --[[
              line: 364
              upvalues:
                a1 (copy, index: 1)
                u2 (copy, index: 2)
                u3 (copy, index: 3)
            ]]
            a1.GuiObject:TweenSize(u2, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, u3, true)
        end
    )) then
        return
    end
    a1.GuiObject.Size = u2
end
function tbl_upv_2.SetTextSize(a1, a2)
    --[[
      name: SetTextSize
      line: 372
    ]]
    if (a1:IsInCustomState()) then
        return
    end
    if a1.TextBox then
        a1.TextBox.TextSize = a2
    end
    if not a1.TextLabel then
        return
    end
    a1.TextLabel.TextSize = a2
end
function tbl_upv_2.GetDefaultChannelNameColor(a1)
    --[[
      name: GetDefaultChannelNameColor
      line: 383
      upvalues:
        ChatSettings_upv_1 (copy, index: 1)
    ]]
    if ChatSettings_upv_1.DefaultChannelNameColor then
        return ChatSettings_upv_1.DefaultChannelNameColor
    end
    return Color3.fromRGB(35, 76, 142)
end
function tbl_upv_2.SetChannelTarget(a1, a2)
    --[[
      name: SetChannelTarget
      line: 390
      upvalues:
        ChatSettings_upv_1 (copy, index: 1)
        u1 (ref,  index: 2)
    ]]
    local MessageModeTextButton_1 = a1.GuiObjects.MessageModeTextButton
    local TextBox_1 = a1.TextBox
    local TextLabel_1 = a1.TextLabel
    a1.TargetChannel = a2
    if not (a1:IsInCustomState()) then
        local v11 = nil
        if a2 == ChatSettings_upv_1.GeneralChannelName then
            MessageModeTextButton_1.Text = ""
            MessageModeTextButton_1.Size = UDim2.new(0, 0, 0, 0)
            TextBox_1.Size = UDim2.new(1, 0, 1, 0)
            TextBox_1.Position = UDim2.new(0, 0, 0, 0)
            TextLabel_1.Size = UDim2.new(1, 0, 1, 0)
            TextLabel_1.Position = UDim2.new(0, 0, 0, 0)
        else
            MessageModeTextButton_1.Size = UDim2.new(0, 1000, 1, 0)
            if u1.tryLocalize then
                v11 = u1:tryLocalize(a2)
            else
                v11 = a2
            end
            MessageModeTextButton_1.Text = string.format("[%s] ", v11)
            v11 = a1:GetChannelNameColor(a2)
            if v11 then
                MessageModeTextButton_1.TextColor3 = v11
            else
                MessageModeTextButton_1.TextColor3 = a1:GetDefaultChannelNameColor()
            end
            local X_1 = MessageModeTextButton_1.TextBounds.X
            MessageModeTextButton_1.Size = UDim2.new(0, X_1, 1, 0)
            TextBox_1.Size = UDim2.new(1, -X_1, 1, 0)
            TextBox_1.Position = UDim2.new(0, X_1, 0, 0)
            TextLabel_1.Size = UDim2.new(1, -X_1, 1, 0)
            TextLabel_1.Position = UDim2.new(0, X_1, 0, 0)
        end
    end
end
function tbl_upv_2.IsInCustomState(a1)
    --[[
      name: IsInCustomState
      line: 430
    ]]
    return a1.InCustomState
end
function tbl_upv_2.ResetCustomState(a1)
    --[[
      name: ResetCustomState
      line: 434
      upvalues:
        u1 (ref, index: 1)
    ]]
    if not a1.InCustomState then
        return
    end
    a1.CustomState:Destroy()
    a1.CustomState = nil
    a1.InCustomState = false
    a1.ChatBarParentFrame:ClearAllChildren()
    a1:CreateGuiObjects(a1.ChatBarParentFrame)
    a1:SetTextLabelText(u1:Get("GameChat_ChatMain_ChatBarText", "To chat click here or press \"/\" key"))
end
function tbl_upv_2.EnterWhisperState(a1, a2)
    --[[
      name: EnterWhisperState
      line: 451
      upvalues:
        Whisper_upv_1 (copy, index: 1)
        ChatSettings_upv_1 (copy, index: 2)
    ]]
    a1:ResetCustomState()
    if Whisper_upv_1.CustomStateCreator then
        a1.CustomState = Whisper_upv_1.CustomStateCreator(a2, a1.ChatWindow, a1, ChatSettings_upv_1)
        a1.InCustomState = true
    else
        local v12
        if ChatSettings_upv_1.PlayerDisplayNamesEnabled then
            v12 = a2.DisplayName
        else
            v12 = a2.Name
        end
        a1:SetText("/w " .. v12)
    end
    a1:CaptureFocus()
end
function tbl_upv_2.GetCustomMessage(a1)
    --[[
      name: GetCustomMessage
      line: 475
    ]]
    if a1.InCustomState then
        return a1.CustomState:GetMessage()
    end
    return nil
end
function tbl_upv_2.CustomStateProcessCompletedMessage(a1, a2)
    --[[
      name: CustomStateProcessCompletedMessage
      line: 482
    ]]
    if a1.InCustomState then
        return a1.CustomState:ProcessCompletedMessage()
    end
    return false
end
function tbl_upv_2.FadeOutBackground(a1, a2)
    --[[
      name: FadeOutBackground
      line: 489
      upvalues:
        CurveUtil_upv_1 (copy, index: 1)
    ]]
    a1.AnimParams.Background_TargetTransparency = 1
    a1.AnimParams.Background_NormalizedExptValue = CurveUtil_upv_1:NormalizedDefaultExptValueInSeconds(a2)
    a1:FadeOutText(a2)
end
function tbl_upv_2.FadeInBackground(a1, a2)
    --[[
      name: FadeInBackground
      line: 495
      upvalues:
        CurveUtil_upv_1 (copy, index: 1)
    ]]
    a1.AnimParams.Background_TargetTransparency = 0.6
    a1.AnimParams.Background_NormalizedExptValue = CurveUtil_upv_1:NormalizedDefaultExptValueInSeconds(a2)
    a1:FadeInText(a2)
end
function tbl_upv_2.FadeOutText(a1, a2)
    --[[
      name: FadeOutText
      line: 501
      upvalues:
        CurveUtil_upv_1 (copy, index: 1)
    ]]
    a1.AnimParams.Text_TargetTransparency = 1
    a1.AnimParams.Text_NormalizedExptValue = CurveUtil_upv_1:NormalizedDefaultExptValueInSeconds(a2)
end
function tbl_upv_2.FadeInText(a1, a2)
    --[[
      name: FadeInText
      line: 506
      upvalues:
        CurveUtil_upv_1 (copy, index: 1)
    ]]
    a1.AnimParams.Text_TargetTransparency = 0.4
    a1.AnimParams.Text_NormalizedExptValue = CurveUtil_upv_1:NormalizedDefaultExptValueInSeconds(a2)
end
function tbl_upv_2.AnimGuiObjects(a1)
    --[[
      name: AnimGuiObjects
      line: 511
    ]]
    a1.GuiObject.BackgroundTransparency = a1.AnimParams.Background_CurrentTransparency
    a1.GuiObjects.TextBoxFrame.BackgroundTransparency = a1.AnimParams.Background_CurrentTransparency
    a1.GuiObjects.TextLabel.TextTransparency = a1.AnimParams.Text_CurrentTransparency
    a1.GuiObjects.TextBox.TextTransparency = a1.AnimParams.Text_CurrentTransparency
    a1.GuiObjects.MessageModeTextButton.TextTransparency = a1.AnimParams.Text_CurrentTransparency
end
function tbl_upv_2.InitializeAnimParams(a1)
    --[[
      name: InitializeAnimParams
      line: 520
    ]]
    a1.AnimParams.Text_TargetTransparency = 0.4
    a1.AnimParams.Text_CurrentTransparency = 0.4
    a1.AnimParams.Text_NormalizedExptValue = 1
    a1.AnimParams.Background_TargetTransparency = 0.6
    a1.AnimParams.Background_CurrentTransparency = 0.6
    a1.AnimParams.Background_NormalizedExptValue = 1
end
function tbl_upv_2.Update(a1, a2)
    --[[
      name: Update
      line: 530
      upvalues:
        CurveUtil_upv_1 (copy, index: 1)
    ]]
    a1.AnimParams.Text_CurrentTransparency = CurveUtil_upv_1:Expt(a1.AnimParams.Text_CurrentTransparency, a1.AnimParams.Text_TargetTransparency, a1.AnimParams.Text_NormalizedExptValue, a2)
    a1.AnimParams.Background_CurrentTransparency = CurveUtil_upv_1:Expt(a1.AnimParams.Background_CurrentTransparency, a1.AnimParams.Background_TargetTransparency, a1.AnimParams.Background_NormalizedExptValue, a2)
    a1:AnimGuiObjects()
end
function tbl_upv_2.SetChannelNameColor(a1, a2, a3)
    --[[
      name: SetChannelNameColor
      line: 547
    ]]
    a1.ChannelNameColors[a2] = a3
    if a1.GuiObjects.MessageModeTextButton.Text ~= a2 then
        return
    end
    a1.GuiObjects.MessageModeTextButton.TextColor3 = a3
end
function tbl_upv_2.GetChannelNameColor(a1, a2)
    --[[
      name: GetChannelNameColor
      line: 554
    ]]
    return a1.ChannelNameColors[a2]
end
function tbl_1.new(a1, a2)
    --[[
      name: new
      line: 561
      upvalues:
        tbl_upv_2 (copy, index: 1)
        ChatSettings_upv_1 (copy, index: 2)
        Chat_upv_1 (copy, index: 3)
        LocalPlayer_upv_1 (ref,  index: 4)
        RunService_upv_1 (copy, index: 5)
    ]]
    local u4 = setmetatable({}, tbl_upv_2)
    u4.GuiObject = nil
    u4.ChatBarParentFrame = nil
    u4.TextBox = nil
    u4.TextLabel = nil
    u4.GuiObjects = {}
    u4.eGuiObjectsChanged = Instance.new("BindableEvent")
    u4.GuiObjectsChanged = u4.eGuiObjectsChanged.Event
    u4.TextBoxConnections = {}
    u4.PreviousText = ""
    u4.InCustomState = false
    u4.CustomState = nil
    u4.TargetChannel = nil
    u4.CommandProcessor = a1
    u4.ChatWindow = a2
    u4.TweenPixelsPerSecond = 500
    u4.TargetYSize = 0
    u4.AnimParams = {}
    u4.CalculatingSizeLock = false
    u4.ChannelNameColors = {}
    u4.UserHasChatOff = false
    u4:InitializeAnimParams()
    ChatSettings_upv_1.SettingsChanged:connect(
        function(a3, a4)
            --[[
              line: 593
              upvalues:
                u4 (copy, index: 1)
            ]]
            if a3 ~= "ChatBarTextSize" then
                return
            end
            u4:SetTextSize(a4)
        end
    )
    coroutine.wrap(
        function()
            --[[
              line: 599
              upvalues:
                Chat_upv_1 (copy, index: 1)
                LocalPlayer_upv_1 (ref,  index: 2)
                RunService_upv_1 (copy, index: 3)
                u4 (copy, index: 4)
            ]]
            local success_1, v13 = pcall(
                function()
                    --[[
                      line: 600
                      upvalues:
                        Chat_upv_1 (copy, index: 1)
                        LocalPlayer_upv_1 (ref,  index: 2)
                    ]]
                    return Chat_upv_1:CanUserChatAsync(LocalPlayer_upv_1.UserId)
                end
            )
            local v14 = success_1 and (RunService_upv_1:IsStudio() or v13)
            if v14 ~= false then
                return
            end
            u4.UserHasChatOff = true
            u4:DoLockChatBar()
        end
    )()
    return u4
end
return tbl_1