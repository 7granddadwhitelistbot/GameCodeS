local tbl_1 = {}
local Players_upv_1 = game:GetService("Players")
local _ = game:GetService("Chat")
local PlayerGui_upv_1 = Players_upv_1.LocalPlayer:WaitForChild("PlayerGui")
local Chat_upv_1 = game:GetService("Chat")
local ClientChatModules_1 = Chat_upv_1:WaitForChild("ClientChatModules")
local Parent_1 = script.Parent
local ChatChannel_upv_1 = require(Parent_1:WaitForChild("ChatChannel"))
local ChatSettings_upv_1 = require(ClientChatModules_1:WaitForChild("ChatSettings"))
local CurveUtil_upv_1 = require(Parent_1:WaitForChild("CurveUtil"))
local tbl_upv_2 = {}
tbl_upv_2.__index = tbl_upv_2
function getClassicChatEnabled()
    --[[
      name: getClassicChatEnabled
      line: 34
      upvalues:
        ChatSettings_upv_1 (copy, index: 1)
        Players_upv_1 (copy, index: 2)
    ]]
    if ChatSettings_upv_1.ClassicChatEnabled == nil then
        return Players_upv_1.ClassicChat
    end
    return ChatSettings_upv_1.ClassicChatEnabled
end
function getBubbleChatEnabled()
    --[[
      name: getBubbleChatEnabled
      line: 41
      upvalues:
        ChatSettings_upv_1 (copy, index: 1)
        Players_upv_1 (copy, index: 2)
    ]]
    if ChatSettings_upv_1.BubbleChatEnabled == nil then
        return Players_upv_1.BubbleChat
    end
    return ChatSettings_upv_1.BubbleChatEnabled
end
function bubbleChatOnly()
    --[[
      name: bubbleChatOnly
      line: 48
    ]]
    local v1 = not getClassicChatEnabled() and (getBubbleChatEnabled())
    return v1
end
function mergeProps(a1, a2)
    --[[
      name: mergeProps
      line: 53
    ]]
    if not a1 or not a2 then
        return
    end
    for key_1, value_1 in pairs(a1) do
        if a2[key_1] ~= nil then
            a2[key_1] = value_1
        end
    end
end
function tbl_upv_2.CreateGuiObjects(a1, a2)
    --[[
      name: CreateGuiObjects
      line: 62
      upvalues:
        Chat_upv_1 (copy, index: 1)
        ChatSettings_upv_1 (copy, index: 2)
        PlayerGui_upv_1 (copy, index: 3)
    ]]
    local u1 = nil
    pcall(
        function()
            --[[
              line: 64
              upvalues:
                u1 (ref,  index: 1)
                Chat_upv_1 (copy, index: 2)
            ]]
            u1 = Chat_upv_1:InvokeChatCallback(Enum.ChatCallbackType.OnCreatingChatWindow, nil)
        end
    )
    mergeProps(u1, ChatSettings_upv_1)
    local u2 = Instance.new("Frame")
    u2.BackgroundTransparency = 1
    u2.Active = ChatSettings_upv_1.WindowDraggable
    u2.Parent = a2
    u2.AutoLocalize = false
    local u3 = Instance.new("Frame")
    u3.Selectable = false
    u3.Name = "ChatBarParentFrame"
    u3.BackgroundTransparency = 1
    u3.Parent = u2
    local u4 = Instance.new("Frame")
    u4.Selectable = false
    u4.Name = "ChannelsBarParentFrame"
    u4.BackgroundTransparency = 1
    u4.Position = UDim2.new(0, 0, 0, 0)
    u4.Parent = u2
    local u5 = Instance.new("Frame")
    u5.Selectable = false
    u5.Name = "ChatChannelParentFrame"
    u5.BackgroundTransparency = 1
    u5.BackgroundColor3 = ChatSettings_upv_1.BackGroundColor
    u5.BackgroundTransparency = 0.6
    u5.BorderSizePixel = 0
    u5.Parent = u2
    local u6 = Instance.new("ImageButton")
    u6.Selectable = false
    u6.Image = ""
    u6.BackgroundTransparency = 0.6
    u6.BorderSizePixel = 0
    u6.Visible = false
    u6.BackgroundColor3 = ChatSettings_upv_1.BackGroundColor
    u6.Active = true
    if bubbleChatOnly() then
        u6.Position = UDim2.new(1, -u6.AbsoluteSize.X, 0, 0)
    else
        u6.Position = UDim2.new(1, -u6.AbsoluteSize.X, 1, -u6.AbsoluteSize.Y)
    end
    u6.Parent = u2
    local v2 = Instance.new("ImageLabel")
    v2.Selectable = false
    v2.Size = UDim2.new(0.8, 0, 0.8, 0)
    v2.Position = UDim2.new(0.2, 0, 0.2, 0)
    v2.BackgroundTransparency = 1
    v2.Image = "rbxassetid://261880743"
    v2.Parent = u6
    local function GetScreenGuiParent()
        --[[
          name: GetScreenGuiParent
          line: 122
          upvalues:
            u2 (copy, index: 1)
        ]]
        while u2 and not u2:IsA("ScreenGui") do

        end
        return u2
    end
    local v3 = u2
    while v3 and not v3:IsA("ScreenGui") do
        v3 = v3.Parent
    end
    local u7 = ((v3.AbsoluteSize.X <= 640) and 1) or (((v3.AbsoluteSize.X <= 1024) and 2) or 3)
    local u8 = false
    v3 = function()
        --[[
          name: doCheckSizeBounds
          line: 145
          upvalues:
            u8 (ref,  index: 1)
            u2 (copy, index: 2)
            PlayerGui_upv_1 (copy, index: 3)
            ChatSettings_upv_1 (copy, index: 4)
            u4 (copy, index: 5)
            u3 (copy, index: 6)
        ]]
        if u8 then
            return
        end
        u8 = true
        if not u2:IsDescendantOf(PlayerGui_upv_1) then
            return
        end
        local v4 = u2
        while v4 and not v4:IsA("ScreenGui") do
            v4 = v4.Parent
        end
        local MinimumWindowSize_1 = ChatSettings_upv_1.MinimumWindowSize
        local MaximumWindowSize_1 = ChatSettings_upv_1.MaximumWindowSize
        local v5 = MinimumWindowSize_1.X.Scale * v4.AbsoluteSize.X + MinimumWindowSize_1.X.Offset
        local v6 = math.max((MinimumWindowSize_1.Y.Scale * v4.AbsoluteSize.Y) + MinimumWindowSize_1.Y.Offset, u4.AbsoluteSize.Y + u3.AbsoluteSize.Y)
        local v7 = MaximumWindowSize_1.X.Scale * v4.AbsoluteSize.X + MaximumWindowSize_1.X.Offset
        local v8 = MaximumWindowSize_1.Y.Scale * v4.AbsoluteSize.Y + MaximumWindowSize_1.Y.Offset
        local X_1 = u2.AbsoluteSize.X
        local Y_1 = u2.AbsoluteSize.Y
        if X_1 < v5 then
            u2.Size = u2.Size + UDim2.new(0, v5 - X_1, 0, 0)
        elseif v7 < X_1 then
            u2.Size = u2.Size + UDim2.new(0, v7 - X_1, 0, 0)
        end
        if Y_1 < v6 then
            u2.Size = u2.Size + UDim2.new(0, 0, 0, v6 - Y_1)
        elseif v8 < Y_1 then
            u2.Size = u2.Size + UDim2.new(0, 0, 0, v8 - Y_1)
        end
        u2.Size = UDim2.new(u2.AbsoluteSize.X / v4.AbsoluteSize.X, 0, u2.AbsoluteSize.Y / v4.AbsoluteSize.Y, 0)
        u8 = false
    end
    u2.Changed:connect(
        function(a3)
            --[[
              line: 196
              upvalues:
                v3 (copy, index: 1)
            ]]
            if a3 ~= "AbsoluteSize" then
                return
            end
            doCheckSizeBounds()
        end
    )
    u6.DragBegin:connect(
        function(a4)
            --[[
              line: 202
              upvalues:
                u2 (copy, index: 1)
            ]]
            u2.Draggable = false
        end
    )
    u6.DragStopped:connect(
        function(a5, a6)
            --[[
              line: 219
              upvalues:
                u2 (copy, index: 1)
                ChatSettings_upv_1 (copy, index: 2)
            ]]
            u2.Draggable = ChatSettings_upv_1.WindowDraggable
        end
    )
    local u9 = false
    local function UpdatePositionFromDrag(a7)
        --[[
          name: UpdatePositionFromDrag
          line: 206
          upvalues:
            ChatSettings_upv_1 (copy, index: 1)
            u2 (copy, index: 2)
            u6 (copy, index: 3)
        ]]
        if ChatSettings_upv_1.WindowDraggable == false and ChatSettings_upv_1.WindowResizable == false then
            return
        end
        local v9 = a7 - u2.AbsolutePosition + u6.AbsoluteSize
        u2.Size = UDim2.new(0, v9.X, 0, v9.Y)
        if bubbleChatOnly() then
            u6.Position = UDim2.new(1, -u6.AbsoluteSize.X, 0, 0)
        else
            u6.Position = UDim2.new(1, -u6.AbsoluteSize.X, 1, -u6.AbsoluteSize.Y)
        end
    end
    u6.Changed:connect(
        function(a8)
            --[[
              line: 225
              upvalues:
                u2 (copy, index: 1)
                u9 (ref,  index: 2)
                UpdatePositionFromDrag (copy, index: 3)
                u6 (copy, index: 4)
            ]]
            if a8 ~= "AbsolutePosition" or (u2.Draggable) or u9 then
                return
            end
            u9 = true
            UpdatePositionFromDrag(u6.AbsolutePosition)
            u9 = false
        end
    )
    local function CalculateChannelsBarPixelSize(a9)
        --[[
          name: CalculateChannelsBarPixelSize
          line: 236
          upvalues:
            u7 (ref,  index: 1)
            ChatSettings_upv_1 (copy, index: 2)
        ]]
        if u7 ~= 1 then
            local v10 = a9 or ChatSettings_upv_1.ChatChannelsTabTextSize
            a9 = v10
        else
            local v11 = a9 or ChatSettings_upv_1.ChatChannelsTabTextSizePhone
            a9 = v11
        end
        return math.max(32, a9 + 8) + 2
    end
    local function CalculateChatBarPixelSize(a10)
        --[[
          name: CalculateChatBarPixelSize
          line: 249
          upvalues:
            u7 (ref,  index: 1)
            ChatSettings_upv_1 (copy, index: 2)
        ]]
        if u7 ~= 1 then
            local v12 = a10 or ChatSettings_upv_1.ChatBarTextSize
            a10 = v12
        else
            local v13 = a10 or ChatSettings_upv_1.ChatBarTextSizePhone
            a10 = v13
        end
        return (a10 + 14) + 10
    end
    if bubbleChatOnly() then
        u3.Position = UDim2.new(0, 0, 0, 0)
        u4.Visible = false
        u4.Active = false
        u5.Visible = false
        u5.Active = false
        local v14 = u2
        while v14 and not v14:IsA("ScreenGui") do
            v14 = v14.Parent
        end
        local v15, v16
        if u7 == 1 then
            v15 = ChatSettings_upv_1.DefaultWindowSizePhone.X.Scale
            v16 = ChatSettings_upv_1.DefaultWindowSizePhone.X.Offset
        elseif u7 ~= 2 then
            v15, v16 = ChatSettings_upv_1.DefaultWindowSizeDesktop.X.Scale, ChatSettings_upv_1.DefaultWindowSizeDesktop.X.Offset
        else
            v15, v16 = ChatSettings_upv_1.DefaultWindowSizeTablet.X.Scale, ChatSettings_upv_1.DefaultWindowSizeTablet.X.Offset
        end
        local v17 = nil
        if u7 ~= 1 then
            v17 = v17 or ChatSettings_upv_1.ChatBarTextSize
        else
            v17 = v17 or ChatSettings_upv_1.ChatBarTextSizePhone
        end
        u2.Size = UDim2.new(v15, v16, 0, (v17 + 14) + 10)
    else
        local v20 = u2
        while v20 and not v20:IsA("ScreenGui") do
            v20 = v20.Parent
        end
        if u7 == 1 then
            u2.Size = ChatSettings_upv_1.DefaultWindowSizePhone
        elseif u7 ~= 2 then
            u2.Size = ChatSettings_upv_1.DefaultWindowSizeDesktop
        else
            u2.Size = ChatSettings_upv_1.DefaultWindowSizeTablet
        end
    end
    u2.Position = ChatSettings_upv_1.DefaultWindowPosition
    if u7 == 1 then
        ChatSettings_upv_1.ChatWindowTextSize = ChatSettings_upv_1.ChatWindowTextSizePhone
        ChatSettings_upv_1.ChatChannelsTabTextSize = ChatSettings_upv_1.ChatChannelsTabTextSizePhone
        ChatSettings_upv_1.ChatBarTextSize = ChatSettings_upv_1.ChatBarTextSizePhone
    end
    local function UpdateDraggable(a11)
        --[[
          name: UpdateDraggable
          line: 318
          upvalues:
            u2 (copy, index: 1)
        ]]
        u2.Active = a11
        u2.Draggable = a11
    end
    local function UpdateChatChannelParentFrameSize()
        --[[
          name: UpdateChatChannelParentFrameSize
          line: 342
          upvalues:
            u7 (ref,  index: 1)
            ChatSettings_upv_1 (copy, index: 2)
            u5 (copy, index: 3)
        ]]
        local v21 = nil
        if u7 ~= 1 then
            v21 = v21 or ChatSettings_upv_1.ChatChannelsTabTextSize
        else
            v21 = v21 or ChatSettings_upv_1.ChatChannelsTabTextSizePhone
        end
        local v24 = math.max(32, v21 + 8) + 2
        local v25 = nil
        if u7 ~= 1 then
            v25 = v25 or ChatSettings_upv_1.ChatBarTextSize
        else
            v25 = v25 or ChatSettings_upv_1.ChatBarTextSizePhone
        end
        v21 = v25 + 14 + 10
        if ChatSettings_upv_1.ShowChannelsBar then
            u5.Size = UDim2.new(1, 0, 1, -(((v24 + v21) + 2) + 2))
            u5.Position = UDim2.new(0, 0, 0, v24 + 2)
        else
            u5.Size = UDim2.new(1, 0, 1, -((v21 + 2) + 2))
            u5.Position = UDim2.new(0, 0, 0, 2)
        end
    end
    local function UpdateChatChannelsTabTextSize(a12)
        --[[
          name: UpdateChatChannelsTabTextSize
          line: 357
          upvalues:
            u7 (ref,  index: 1)
            ChatSettings_upv_1 (copy, index: 2)
            u4 (copy, index: 3)
            UpdateChatChannelParentFrameSize (copy, index: 4)
        ]]
        local v28
        if u7 ~= 1 then
            v28 = a12 or ChatSettings_upv_1.ChatChannelsTabTextSize
        else
            v28 = a12 or ChatSettings_upv_1.ChatChannelsTabTextSizePhone
        end
        u4.Size = UDim2.new(1, 0, 0, math.max(32, v28 + 8) + 2)
        UpdateChatChannelParentFrameSize()
    end
    local function UpdateResizable(a13)
        --[[
          name: UpdateResizable
          line: 323
          upvalues:
            u6 (copy, index: 1)
            u3 (copy, index: 2)
        ]]
        u6.Visible = a13
        u6.Draggable = a13
        local Offset_1 = u3.Size.Y.Offset
        if a13 then
            u3.Size = UDim2.new(1, -Offset_1 - 2, 0, Offset_1)
        else
            u3.Size = UDim2.new(1, 0, 0, Offset_1)
        end
        if (bubbleChatOnly()) then
            return
        end
        u3.Position = UDim2.new(0, 0, 1, -Offset_1)
    end
    local function UpdateChatBarTextSize(a14)
        --[[
          name: UpdateChatBarTextSize
          line: 364
          upvalues:
            u7 (ref,  index: 1)
            ChatSettings_upv_1 (copy, index: 2)
            u3 (copy, index: 3)
            u6 (copy, index: 4)
            UpdateChatChannelParentFrameSize (copy, index: 5)
            UpdateResizable (copy, index: 6)
        ]]
        local v31
        if u7 ~= 1 then
            v31 = a14 or ChatSettings_upv_1.ChatBarTextSize
        else
            v31 = a14 or ChatSettings_upv_1.ChatBarTextSizePhone
        end
        local v34 = v31 + 14 + 10
        u3.Size = UDim2.new(1, 0, 0, v34)
        if not (bubbleChatOnly()) then
            u3.Position = UDim2.new(0, 0, 1, -v34)
        end
        u6.Size = UDim2.new(0, v34, 0, v34)
        u6.Position = UDim2.new(1, -v34, 1, -v34)
        UpdateChatChannelParentFrameSize()
        UpdateResizable(ChatSettings_upv_1.WindowResizable)
    end
    local function UpdateShowChannelsBar(a15)
        --[[
          name: UpdateShowChannelsBar
          line: 379
          upvalues:
            u4 (copy, index: 1)
            UpdateChatChannelParentFrameSize (copy, index: 2)
        ]]
        u4.Visible = a15
        UpdateChatChannelParentFrameSize()
    end
    local v35 = ChatSettings_upv_1.ChatChannelsTabTextSize
    if u7 ~= 1 then
        v35 = v35 or ChatSettings_upv_1.ChatChannelsTabTextSize
    else
        v35 = v35 or ChatSettings_upv_1.ChatChannelsTabTextSizePhone
    end
    u4.Size = UDim2.new(1, 0, 0, math.max(32, v35 + 8) + 2)
    UpdateChatChannelParentFrameSize()
    UpdateChatBarTextSize(ChatSettings_upv_1.ChatBarTextSize)
    local WindowDraggable_1 = ChatSettings_upv_1.WindowDraggable
    u2.Active = WindowDraggable_1
    u2.Draggable = WindowDraggable_1
    UpdateResizable(ChatSettings_upv_1.WindowResizable)
    u4.Visible = ChatSettings_upv_1.ShowChannelsBar
    UpdateChatChannelParentFrameSize()
    ChatSettings_upv_1.SettingsChanged:connect(
        function(a16, a17)
            --[[
              line: 390
              upvalues:
                u2 (copy, index: 1)
                UpdateResizable (copy, index: 2)
                u7 (ref,  index: 3)
                ChatSettings_upv_1 (copy, index: 4)
                u4 (copy, index: 5)
                UpdateChatChannelParentFrameSize (copy, index: 6)
                UpdateChatBarTextSize (copy, index: 7)
            ]]
            if a16 == "WindowDraggable" then
                u2.Active = a17
                u2.Draggable = a17
            elseif a16 == "WindowResizable" then
                UpdateResizable(a17)
            elseif a16 == "ChatChannelsTabTextSize" then
                local v38
                if u7 ~= 1 then
                    v38 = a17 or ChatSettings_upv_1.ChatChannelsTabTextSize
                else
                    v38 = a17 or ChatSettings_upv_1.ChatChannelsTabTextSizePhone
                end
                u4.Size = UDim2.new(1, 0, 0, math.max(32, v38 + 8) + 2)
                UpdateChatChannelParentFrameSize()
            elseif a16 == "ChatBarTextSize" then
                UpdateChatBarTextSize(a17)
            elseif a16 == "ShowChannelsBar" then
                u4.Visible = a17
                UpdateChatChannelParentFrameSize()
            end
        end
    )
    a1.GuiObject = u2
    a1.GuiObjects.BaseFrame = u2
    a1.GuiObjects.ChatBarParentFrame = u3
    a1.GuiObjects.ChannelsBarParentFrame = u4
    a1.GuiObjects.ChatChannelParentFrame = u5
    a1.GuiObjects.ChatResizerFrame = u6
    a1.GuiObjects.ResizeIcon = v2
    a1:AnimGuiObjects()
end
function tbl_upv_2.GetChatBar(a1)
    --[[
      name: GetChatBar
      line: 420
    ]]
    return a1.ChatBar
end
function tbl_upv_2.RegisterChatBar(a1, a2)
    --[[
      name: RegisterChatBar
      line: 424
    ]]
    a1.ChatBar = a2
    a1.ChatBar:CreateGuiObjects(a1.GuiObjects.ChatBarParentFrame)
end
function tbl_upv_2.RegisterChannelsBar(a1, a2)
    --[[
      name: RegisterChannelsBar
      line: 429
    ]]
    a1.ChannelsBar = a2
    a1.ChannelsBar:CreateGuiObjects(a1.GuiObjects.ChannelsBarParentFrame)
end
function tbl_upv_2.RegisterMessageLogDisplay(a1, a2)
    --[[
      name: RegisterMessageLogDisplay
      line: 434
    ]]
    a1.MessageLogDisplay = a2
    a1.MessageLogDisplay.GuiObject.Parent = a1.GuiObjects.ChatChannelParentFrame
end
function tbl_upv_2.AddChannel(a1, a2)
    --[[
      name: AddChannel
      line: 439
      upvalues:
        ChatChannel_upv_1 (copy, index: 1)
    ]]
    if a1:GetChannel(a2) then
        error("Channel '" .. a2 .. "' already exists!")
    else
        local v41 = ChatChannel_upv_1.new(a2, a1.MessageLogDisplay)
        a1.Channels[a2:lower()] = v41
        v41:SetActive(false)
        local v42 = a1.ChannelsBar:AddChannelTab(a2)
        v42.NameTag.MouseButton1Click:connect(
            function()
                --[[
                  line: 451
                  upvalues:
                    a1 (copy, index: 1)
                    a2 (copy, index: 2)
                ]]
                a1:SwitchCurrentChannel(a2)
            end
        )
        v41:RegisterChannelTab(v42)
        return v41
    end
end
function tbl_upv_2.GetFirstChannel(a1)
    --[[
      name: GetFirstChannel
      line: 460
    ]]
    for _, value_2 in pairs(a1.Channels) do
        return value_2
    end
    return nil
end
function tbl_upv_2.RemoveChannel(a1, a2)
    --[[
      name: RemoveChannel
      line: 469
      upvalues:
        ChatSettings_upv_1 (copy, index: 1)
    ]]
    if not (a1:GetChannel(a2)) then
        error("Channel '" .. a2 .. "' does not exist!")
    end
    local v43 = a2:lower()
    local v44 = false
    if a1.Channels[v43] == a1:GetCurrentChannel() then
        v44 = true
        a1:SwitchCurrentChannel(nil)
    end
    a1.Channels[v43]:Destroy()
    a1.Channels[v43] = nil
    a1.ChannelsBar:RemoveChannelTab(a2)
    if v44 then
        local v45 = a1:GetChannel(ChatSettings_upv_1.GeneralChannelName) ~= nil
        local v46 = v43 == ChatSettings_upv_1.GeneralChannelName:lower()
        local v47
        if not (v45) or v46 then
            local v48 = a1:GetFirstChannel()
            v47 = v48 and v48.Name or nil
        else
            v47 = ChatSettings_upv_1.GeneralChannelName
        end
        a1:SwitchCurrentChannel(v47)
    end
    if (ChatSettings_upv_1.ShowChannelsBar) or a1.ChatBar.TargetChannel ~= a2 then
        return
    end
    a1.ChatBar:SetChannelTarget(ChatSettings_upv_1.GeneralChannelName)
end
function tbl_upv_2.GetChannel(a1, a2)
    --[[
      name: GetChannel
      line: 511
    ]]
    local v50 = (a2 and (a1.Channels[a2:lower()])) or nil
    return v50
end
function tbl_upv_2.GetTargetMessageChannel(a1)
    --[[
      name: GetTargetMessageChannel
      line: 515
      upvalues:
        ChatSettings_upv_1 (copy, index: 1)
    ]]
    if not ChatSettings_upv_1.ShowChannelsBar then
        return a1.ChatBar.TargetChannel
    end
    local v51 = a1:GetCurrentChannel()
    return v51 and (v51.Name)
end
function tbl_upv_2.GetCurrentChannel(a1)
    --[[
      name: GetCurrentChannel
      line: 524
    ]]
    return a1.CurrentChannel
end
function tbl_upv_2.SwitchCurrentChannel(a1, a2)
    --[[
      name: SwitchCurrentChannel
      line: 528
      upvalues:
        ChatSettings_upv_1 (copy, index: 1)
    ]]
    local v52 = nil
    if not (ChatSettings_upv_1.ShowChannelsBar) then
        v52 = a1:GetChannel(a2)
        if v52 then
            a1.ChatBar:SetChannelTarget(v52.Name)
        end
        a2 = ChatSettings_upv_1.GeneralChannelName
    end
    local v53 = a1:GetCurrentChannel()
    local v54 = a1:GetChannel(a2)
    if v54 == nil then
        error(string.format("Channel '%s' does not exist.", a2))
    end
    if v54 == v53 then
        return
    end
    if v53 then
        v53:SetActive(false)
        a1.ChannelsBar:GetChannelTab(v53.Name):SetActive(false)
    end
    if v54 then
        v54:SetActive(true)
        a1.ChannelsBar:GetChannelTab(v54.Name):SetActive(true)
    end
    a1.CurrentChannel = v54
end
function tbl_upv_2.UpdateFrameVisibility(a1)
    --[[
      name: UpdateFrameVisibility
      line: 562
    ]]
    a1.GuiObject.Visible = a1.Visible and (a1.CoreGuiEnabled)
end
function tbl_upv_2.GetVisible(a1)
    --[[
      name: GetVisible
      line: 566
    ]]
    return a1.Visible
end
function tbl_upv_2.SetVisible(a1, a2)
    --[[
      name: SetVisible
      line: 570
    ]]
    a1.Visible = a2
    a1:UpdateFrameVisibility()
end
function tbl_upv_2.GetCoreGuiEnabled(a1)
    --[[
      name: GetCoreGuiEnabled
      line: 575
    ]]
    return a1.CoreGuiEnabled
end
function tbl_upv_2.SetCoreGuiEnabled(a1, a2)
    --[[
      name: SetCoreGuiEnabled
      line: 579
    ]]
    a1.CoreGuiEnabled = a2
    a1:UpdateFrameVisibility()
end
function tbl_upv_2.EnableResizable(a1)
    --[[
      name: EnableResizable
      line: 584
    ]]
    a1.GuiObjects.ChatResizerFrame.Active = true
end
function tbl_upv_2.DisableResizable(a1)
    --[[
      name: DisableResizable
      line: 588
    ]]
    a1.GuiObjects.ChatResizerFrame.Active = false
end
function tbl_upv_2.FadeOutBackground(a1, a2)
    --[[
      name: FadeOutBackground
      line: 592
      upvalues:
        CurveUtil_upv_1 (copy, index: 1)
    ]]
    a1.ChannelsBar:FadeOutBackground(a2)
    a1.MessageLogDisplay:FadeOutBackground(a2)
    a1.ChatBar:FadeOutBackground(a2)
    a1.AnimParams.Background_TargetTransparency = 1
    a1.AnimParams.Background_NormalizedExptValue = CurveUtil_upv_1:NormalizedDefaultExptValueInSeconds(a2)
end
function tbl_upv_2.FadeInBackground(a1, a2)
    --[[
      name: FadeInBackground
      line: 601
      upvalues:
        CurveUtil_upv_1 (copy, index: 1)
    ]]
    a1.ChannelsBar:FadeInBackground(a2)
    a1.MessageLogDisplay:FadeInBackground(a2)
    a1.ChatBar:FadeInBackground(a2)
    a1.AnimParams.Background_TargetTransparency = 0.6
    a1.AnimParams.Background_NormalizedExptValue = CurveUtil_upv_1:NormalizedDefaultExptValueInSeconds(a2)
end
function tbl_upv_2.FadeOutText(a1, a2)
    --[[
      name: FadeOutText
      line: 610
    ]]
    a1.MessageLogDisplay:FadeOutText(a2)
    a1.ChannelsBar:FadeOutText(a2)
end
function tbl_upv_2.FadeInText(a1, a2)
    --[[
      name: FadeInText
      line: 615
    ]]
    a1.MessageLogDisplay:FadeInText(a2)
    a1.ChannelsBar:FadeInText(a2)
end
function tbl_upv_2.AnimGuiObjects(a1)
    --[[
      name: AnimGuiObjects
      line: 620
    ]]
    a1.GuiObjects.ChatChannelParentFrame.BackgroundTransparency = a1.AnimParams.Background_CurrentTransparency
    a1.GuiObjects.ChatResizerFrame.BackgroundTransparency = a1.AnimParams.Background_CurrentTransparency
    a1.GuiObjects.ResizeIcon.ImageTransparency = a1.AnimParams.Background_CurrentTransparency
end
function tbl_upv_2.InitializeAnimParams(a1)
    --[[
      name: InitializeAnimParams
      line: 626
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
      line: 632
      upvalues:
        CurveUtil_upv_1 (copy, index: 1)
    ]]
    a1.ChatBar:Update(a2)
    a1.ChannelsBar:Update(a2)
    a1.MessageLogDisplay:Update(a2)
    a1.AnimParams.Background_CurrentTransparency = CurveUtil_upv_1:Expt(a1.AnimParams.Background_CurrentTransparency, a1.AnimParams.Background_TargetTransparency, a1.AnimParams.Background_NormalizedExptValue, a2)
    a1:AnimGuiObjects()
end
function tbl_1.new()
    --[[
      name: new
      line: 650
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    local v55 = setmetatable({}, tbl_upv_2)
    v55.GuiObject = nil
    v55.GuiObjects = {}
    v55.ChatBar = nil
    v55.ChannelsBar = nil
    v55.MessageLogDisplay = nil
    v55.Channels = {}
    v55.CurrentChannel = nil
    v55.Visible = true
    v55.CoreGuiEnabled = true
    v55.AnimParams = {}
    v55:InitializeAnimParams()
    return v55
end
return tbl_1