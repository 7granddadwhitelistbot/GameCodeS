local tbl_1 = {}
local ClientChatModules_1 = game:GetService("Chat"):WaitForChild("ClientChatModules")
local Parent_1 = script.Parent
local ChannelsTab_upv_1 = require(Parent_1:WaitForChild("ChannelsTab"))
local MessageSender_upv_1 = require(Parent_1:WaitForChild("MessageSender"))
local ChatSettings_upv_1 = require(ClientChatModules_1:WaitForChild("ChatSettings"))
local CurveUtil_upv_1 = require(Parent_1:WaitForChild("CurveUtil"))
local tbl_upv_2 = {}
tbl_upv_2.__index = tbl_upv_2
function tbl_upv_2.CreateGuiObjects(a1, a2)
    --[[
      name: CreateGuiObjects
      line: 24
      upvalues:
        ChatSettings_upv_1 (copy, index: 1)
        MessageSender_upv_1 (copy, index: 2)
    ]]
    local v1 = Instance.new("Frame")
    v1.Selectable = false
    v1.Size = UDim2.new(1, 0, 1, 0)
    v1.BackgroundTransparency = 1
    v1.Parent = a2
    local v2 = Instance.new("Frame")
    v2.Selectable = false
    v2.Name = "ScrollingBase"
    v2.BackgroundTransparency = 1
    v2.ClipsDescendants = true
    v2.Size = UDim2.new(1, 0, 1, 0)
    v2.Position = UDim2.new(0, 0, 0, 0)
    v2.Parent = v1
    local v3 = Instance.new("Frame")
    v3.Selectable = false
    v3.Name = "ScrollerSizer"
    v3.BackgroundTransparency = 1
    v3.Size = UDim2.new(1, 0, 1, 0)
    v3.Position = UDim2.new(0, 0, 0, 0)
    v3.Parent = v2
    local v4 = Instance.new("Frame")
    v4.Selectable = false
    v4.Name = "ScrollerFrame"
    v4.BackgroundTransparency = 1
    v4.Size = UDim2.new(1, 0, 1, 0)
    v4.Position = UDim2.new(0, 0, 0, 0)
    v4.Parent = v3
    local v5 = Instance.new("Frame")
    v5.Selectable = false
    v5.Size = UDim2.new(1, 0, 1, 0)
    v5.Position = UDim2.new(0, 0, 0, 0)
    v5.ClipsDescendants = true
    v5.BackgroundTransparency = 1
    v5.Parent = v1
    local u1 = Instance.new("Frame")
    u1.Selectable = false
    u1.Name = "LeaveConfirmationFrame"
    u1.Size = UDim2.new(1, 0, 1, 0)
    u1.Position = UDim2.new(0, 0, 1, 0)
    u1.BackgroundTransparency = 0.6
    u1.BorderSizePixel = 0
    u1.BackgroundColor3 = Color3.new(0, 0, 0)
    u1.Parent = v5
    local v6 = Instance.new("TextButton")
    v6.Selectable = false
    v6.Size = UDim2.new(1, 0, 1, 0)
    v6.BackgroundTransparency = 1
    v6.Text = ""
    v6.Parent = u1
    local v7 = Instance.new("TextButton")
    v7.Selectable = false
    v7.Size = UDim2.new(0.25, 0, 1, 0)
    v7.BackgroundTransparency = 1
    v7.Font = ChatSettings_upv_1.DefaultFont
    v7.TextSize = 18
    v7.TextStrokeTransparency = 0.75
    v7.Position = UDim2.new(0, 0, 0, 0)
    v7.TextColor3 = Color3.new(0, 1, 0)
    v7.Text = "Confirm"
    v7.Parent = u1
    local v8 = v7:Clone()
    v8.Parent = u1
    v8.Position = UDim2.new(0.75, 0, 0, 0)
    v8.TextColor3 = Color3.new(1, 0, 0)
    v8.Text = "Cancel"
    local v9 = Instance.new("TextLabel")
    v9.Selectable = false
    v9.Size = UDim2.new(0.5, 0, 1, 0)
    v9.Position = UDim2.new(0.25, 0, 0, 0)
    v9.BackgroundTransparency = 1
    v9.TextColor3 = Color3.new(1, 1, 1)
    v9.TextStrokeTransparency = 0.75
    v9.Text = "Leave channel <XX>?"
    v9.Font = ChatSettings_upv_1.DefaultFont
    v9.TextSize = 18
    v9.Parent = u1
    local u2 = Instance.new("StringValue")
    u2.Name = "LeaveTarget"
    u2.Parent = u1
    local Position_upv_1 = u1.Position
    v7.MouseButton1Click:connect(
        function()
            --[[
              line: 116
              upvalues:
                MessageSender_upv_1 (copy, index: 1)
                u2 (copy, index: 2)
                u1 (copy, index: 3)
                Position_upv_1 (copy, index: 4)
            ]]
            MessageSender_upv_1:SendMessage(string.format("/leave %s", u2.Value), nil)
            u1:TweenPosition(Position_upv_1, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
        end
    )
    v8.MouseButton1Click:connect(
        function()
            --[[
              line: 120
              upvalues:
                u1 (copy, index: 1)
                Position_upv_1 (copy, index: 2)
            ]]
            u1:TweenPosition(Position_upv_1, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
        end
    )
    local v10 = Instance.new("ImageButton", v1)
    v10.Selectable = ChatSettings_upv_1.GamepadNavigationEnabled
    v10.Name = "PageLeftButton"
    v10.SizeConstraint = Enum.SizeConstraint.RelativeYY
    v10.Size = UDim2.new(0.7, 0, 0.7, 0)
    v10.BackgroundTransparency = 1
    v10.Position = UDim2.new(0, 4, 0.15000000000000002, 0)
    v10.Visible = false
    v10.Image = "rbxassetid://471630199"
    local v11 = Instance.new("ImageLabel", v10)
    v11.Name = "ArrowLabel"
    v11.BackgroundTransparency = 1
    v11.Size = UDim2.new(0.4, 0, 0.4, 0)
    v11.Image = "rbxassetid://471630112"
    local v12 = Instance.new("Frame", v1)
    v12.Selectable = false
    v12.BackgroundTransparency = 1
    v12.Name = "PositionalHelper"
    v12.Size = v10.Size
    v12.SizeConstraint = v10.SizeConstraint
    v12.Position = UDim2.new(1, 0, 0.15000000000000002, 0)
    v7 = v10:Clone()
    v7.Parent = v12
    v7.Name = "PageRightButton"
    v7.Size = UDim2.new(1, 0, 1, 0)
    v7.SizeConstraint = Enum.SizeConstraint.RelativeXY
    v7.Position = UDim2.new(-1, -4, 0, 0)
    local v13 = UDim2.new(0.05, 0, 0, 0)
    v7.ArrowLabel.Position = UDim2.new(0.3, 0, 0.3, 0) + v13
    v10.ArrowLabel.Position = UDim2.new(0.3, 0, 0.3, 0) - v13
    v10.ArrowLabel.Rotation = 180
    a1.GuiObject = v1
    a1.GuiObjects.BaseFrame = v1
    a1.GuiObjects.ScrollerSizer = v3
    a1.GuiObjects.ScrollerFrame = v4
    a1.GuiObjects.PageLeftButton = v10
    a1.GuiObjects.PageRightButton = v7
    a1.GuiObjects.LeaveConfirmationFrame = u1
    a1.GuiObjects.LeaveConfirmationNotice = v9
    a1.GuiObjects.PageLeftButtonArrow = v10.ArrowLabel
    a1.GuiObjects.PageRightButtonArrow = v7.ArrowLabel
    a1:AnimGuiObjects()
    v10.MouseButton1Click:connect(
        function()
            --[[
              line: 188
              upvalues:
                a1 (copy, index: 1)
            ]]
            a1:ScrollChannelsFrame(-1)
        end
    )
    v7.MouseButton1Click:connect(
        function()
            --[[
              line: 189
              upvalues:
                a1 (copy, index: 1)
            ]]
            a1:ScrollChannelsFrame(1)
        end
    )
    a1:ScrollChannelsFrame(0)
end
function tbl_upv_2.UpdateMessagePostedInChannel(a1, a2)
    --[[
      name: UpdateMessagePostedInChannel
      line: 195
    ]]
    local v14 = a1:GetChannelTab(a2)
    if v14 then
        v14:UpdateMessagePostedInChannel()
    else
        warn("ChannelsTab '" .. a2 .. "' does not exist!")
    end
end
function tbl_upv_2.AddChannelTab(a1, a2)
    --[[
      name: AddChannelTab
      line: 204
      upvalues:
        ChannelsTab_upv_1 (copy, index: 1)
        ChatSettings_upv_1 (copy, index: 2)
    ]]
    if a1:GetChannelTab(a2) then
        error("Channel tab '" .. a2 .. "'already exists!")
    end
    local u3 = ChannelsTab_upv_1.new(a2)
    u3.GuiObject.Parent = a1.GuiObjects.ScrollerFrame
    a1.ChannelTabs[a2:lower()] = u3
    a1.NumTabs = a1.NumTabs + 1
    a1:OrganizeChannelTabs()
    if ChatSettings_upv_1.RightClickToLeaveChannelEnabled then
        u3.NameTag.MouseButton2Click:connect(
            function()
                --[[
                  line: 217
                  upvalues:
                    a1 (copy, index: 1)
                    u3 (copy, index: 2)
                ]]
                a1.LeaveConfirmationNotice.Text = string.format("Leave channel %s?", u3.ChannelName)
                a1.LeaveConfirmationFrame.LeaveTarget.Value = u3.ChannelName
                a1.LeaveConfirmationFrame:TweenPosition(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.2, true)
            end
        )
    end
    return u3
end
function tbl_upv_2.RemoveChannelTab(a1, a2)
    --[[
      name: RemoveChannelTab
      line: 227
    ]]
    if not (a1:GetChannelTab(a2)) then
        error("Channel tab '" .. a2 .. "'does not exist!")
    end
    local v15 = a2:lower()
    a1.ChannelTabs[v15]:Destroy()
    a1.ChannelTabs[v15] = nil
    a1.NumTabs = a1.NumTabs - 1
    a1:OrganizeChannelTabs()
end
function tbl_upv_2.GetChannelTab(a1, a2)
    --[[
      name: GetChannelTab
      line: 240
    ]]
    return a1.ChannelTabs[a2:lower()]
end
function tbl_upv_2.OrganizeChannelTabs(a1)
    --[[
      name: OrganizeChannelTabs
      line: 244
      upvalues:
        ChatSettings_upv_1 (copy, index: 1)
    ]]
    local tbl_3 = {}
    table.insert(tbl_3, a1:GetChannelTab(ChatSettings_upv_1.GeneralChannelName))
    table.insert(tbl_3, a1:GetChannelTab("System"))
    for _, value_1 in pairs(a1.ChannelTabs) do
        if value_1.ChannelName == ChatSettings_upv_1.GeneralChannelName then
            continue
        end
        if value_1.ChannelName ~= "System" then
            table.insert(tbl_3, value_1)
        end
    end
    for key_1, value_2 in pairs(tbl_3) do
        value_2.GuiObject.Position = UDim2.new(key_1 - 1, 0, 0, 0)
    end
    a1.GuiObjects.ScrollerSizer.Size = UDim2.new(1 / math.max(1, math.min(ChatSettings_upv_1.ChannelsBarFullTabSize, a1.NumTabs)), 0, 1, 0)
    a1:ScrollChannelsFrame(0)
end
function tbl_upv_2.ResizeChannelTabText(a1, a2)
    --[[
      name: ResizeChannelTabText
      line: 266
    ]]
    for _, value_3 in pairs(a1.ChannelTabs) do
        value_3:SetTextSize(a2)
    end
end
function tbl_upv_2.ScrollChannelsFrame(a1, a2)
    --[[
      name: ScrollChannelsFrame
      line: 272
      upvalues:
        ChatSettings_upv_1 (copy, index: 1)
    ]]
    if a1.ScrollChannelsFrameLock then
        return
    end
    a1.ScrollChannelsFrameLock = true
    local ChannelsBarFullTabSize_1 = ChatSettings_upv_1.ChannelsBarFullTabSize
    local v16 = a1.CurPageNum + a2
    if v16 < 0 then
        v16 = 0
    elseif v16 > 0 then
        v16 = ((a1.NumTabs < v16 + ChannelsBarFullTabSize_1) and (a1.NumTabs - ChannelsBarFullTabSize_1)) or v16
    end
    a1.CurPageNum = v16
    v16 = UDim2.new(-a1.CurPageNum, 0, 0, 0)
    a1.GuiObjects.PageLeftButton.Visible = a1.CurPageNum > 0
    a1.GuiObjects.PageRightButton.Visible = (a1.CurPageNum + ChannelsBarFullTabSize_1) < a1.NumTabs
    if a2 ~= 0 then
        a1:WaitUntilParentedCorrectly()
        local function UnlockFunc()
            --[[
              name: UnlockFunc
              line: 298
              upvalues:
                a1 (copy, index: 1)
            ]]
            a1.ScrollChannelsFrameLock = false
        end
        a1.GuiObjects.ScrollerFrame:TweenPosition(v16, Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.15, true, UnlockFunc)
    else
        a1.ScrollChannelsFrameLock = false
    end
end
function tbl_upv_2.FadeOutBackground(a1, a2)
    --[[
      name: FadeOutBackground
      line: 307
      upvalues:
        CurveUtil_upv_1 (copy, index: 1)
    ]]
    for _, value_4 in pairs(a1.ChannelTabs) do
        value_4:FadeOutBackground(a2)
    end
    a1.AnimParams.Background_TargetTransparency = 1
    a1.AnimParams.Background_NormalizedExptValue = CurveUtil_upv_1:NormalizedDefaultExptValueInSeconds(a2)
end
function tbl_upv_2.FadeInBackground(a1, a2)
    --[[
      name: FadeInBackground
      line: 316
      upvalues:
        CurveUtil_upv_1 (copy, index: 1)
    ]]
    for _, value_5 in pairs(a1.ChannelTabs) do
        value_5:FadeInBackground(a2)
    end
    a1.AnimParams.Background_TargetTransparency = 0.6
    a1.AnimParams.Background_NormalizedExptValue = CurveUtil_upv_1:NormalizedDefaultExptValueInSeconds(a2)
end
function tbl_upv_2.FadeOutText(a1, a2)
    --[[
      name: FadeOutText
      line: 325
    ]]
    for _, value_6 in pairs(a1.ChannelTabs) do
        value_6:FadeOutText(a2)
    end
end
function tbl_upv_2.FadeInText(a1, a2)
    --[[
      name: FadeInText
      line: 331
    ]]
    for _, value_7 in pairs(a1.ChannelTabs) do
        value_7:FadeInText(a2)
    end
end
function tbl_upv_2.AnimGuiObjects(a1)
    --[[
      name: AnimGuiObjects
      line: 337
    ]]
    a1.GuiObjects.PageLeftButton.ImageTransparency = a1.AnimParams.Background_CurrentTransparency
    a1.GuiObjects.PageRightButton.ImageTransparency = a1.AnimParams.Background_CurrentTransparency
    a1.GuiObjects.PageLeftButtonArrow.ImageTransparency = a1.AnimParams.Background_CurrentTransparency
    a1.GuiObjects.PageRightButtonArrow.ImageTransparency = a1.AnimParams.Background_CurrentTransparency
end
function tbl_upv_2.InitializeAnimParams(a1)
    --[[
      name: InitializeAnimParams
      line: 344
      upvalues:
        CurveUtil_upv_1 (copy, index: 1)
    ]]
    a1.AnimParams.Background_TargetTransparency = 0.6
    a1.AnimParams.Background_CurrentTransparency = 0.6
    a1.AnimParams.Background_NormalizedExptValue = CurveUtil_upv_1:NormalizedDefaultExptValueInSeconds(0)
end
function tbl_upv_2.Update(a1, a2)
    --[[
      name: Update
      line: 350
      upvalues:
        CurveUtil_upv_1 (copy, index: 1)
    ]]
    for _, value_8 in pairs(a1.ChannelTabs) do
        value_8:Update(a2)
    end
    a1.AnimParams.Background_CurrentTransparency = CurveUtil_upv_1:Expt(a1.AnimParams.Background_CurrentTransparency, a1.AnimParams.Background_TargetTransparency, a1.AnimParams.Background_NormalizedExptValue, a2)
    a1:AnimGuiObjects()
end
function tbl_upv_2.WaitUntilParentedCorrectly(a1)
    --[[
      name: WaitUntilParentedCorrectly
      line: 366
    ]]
    while not (a1.GuiObject:IsDescendantOf(game:GetService("Players").LocalPlayer)) do
        a1.GuiObject.AncestryChanged:wait()
    end
end
function tbl_1.new()
    --[[
      name: new
      line: 375
      upvalues:
        tbl_upv_2 (copy, index: 1)
        ChatSettings_upv_1 (copy, index: 2)
    ]]
    local u4 = setmetatable({}, tbl_upv_2)
    u4.GuiObject = nil
    u4.GuiObjects = {}
    u4.ChannelTabs = {}
    u4.NumTabs = 0
    u4.CurPageNum = 0
    u4.ScrollChannelsFrameLock = false
    u4.AnimParams = {}
    u4:InitializeAnimParams()
    ChatSettings_upv_1.SettingsChanged:connect(
        function(a1, a2)
            --[[
              line: 391
              upvalues:
                u4 (copy, index: 1)
            ]]
            if a1 ~= "ChatChannelsTabTextSize" then
                return
            end
            u4:ResizeChannelTabText(a2)
        end
    )
    return u4
end
return tbl_1