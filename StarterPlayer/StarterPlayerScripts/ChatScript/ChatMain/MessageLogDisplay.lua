local success, isUserFeatureEnabled = pcall(
    function()
        --[[
          line: 7
        ]]
        return UserSettings():IsUserFeatureEnabled("UserRemoveMessageOnTextFilterFailures")
    end
)
local isUserFeatureEnabled2 = success and isUserFeatureEnabled
local success2, isUserFeatureEnabled3 = pcall(
    function()
        --[[
          line: 15
        ]]
        return UserSettings():IsUserFeatureEnabled("UserIsChatTranslationEnabled2")
    end
)
local isUserFeatureEnabled4 = success2 and isUserFeatureEnabled3
local v7 = {ScrollBarThickness = 4}
local chat = game:GetService("Chat")
local clientChatModules = chat:WaitForChild("ClientChatModules")
local parent = script.Parent
local MessageLabelCreator = require(parent:WaitForChild("MessageLabelCreator"))
local CurveUtil = require(parent:WaitForChild("CurveUtil"))
local ChatSettings = require(clientChatModules:WaitForChild("ChatSettings"))
local messageLabelCreator = MessageLabelCreator.new()
local Class = {}
Class.__index = Class

local function CreateGuiObjects()
    --[[
      name: CreateGuiObjects
      line: 42
      upvalues:
        ChatSettings (copy, index: 1)
        v7 (copy, index: 2)
    ]]
    local parent = Instance.new("Frame")
    parent.Selectable = false
    parent.Size = UDim2.new(1, 0, 1, 0)
    parent.BackgroundTransparency = 1

    local scroller = Instance.new("ScrollingFrame")
    scroller.Selectable = ChatSettings.GamepadNavigationEnabled
    scroller.Name = "Scroller"
    scroller.BackgroundTransparency = 1
    scroller.BorderSizePixel = 0
    scroller.Position = UDim2.new(0, 0, 0, 3)
    scroller.Size = UDim2.new(1, -4, 1, -6)
    scroller.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroller.ScrollBarThickness = v7.ScrollBarThickness
    scroller.Active = true
    scroller.Parent = parent

    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    uiListLayout.Parent = scroller

    return parent, scroller, uiListLayout
end

function Class.Destroy(self)
    --[[
      name: Destroy
      line: 67
    ]]
    self.GuiObject:Destroy()
    self.Destroyed = true
end

function Class.SetActive(self, active)
    --[[
      name: SetActive
      line: 72
    ]]
    self.GuiObject.Visible = active
end

function Class.UpdateMessageFiltered(self, a24)
    --[[
      name: UpdateMessageFiltered
      line: 76
      upvalues:
        isUserFeatureEnabled2 (ref, index: 1)
    ]]
    local v25
    local readIndex = 1
    local messageObjectLog = self.MessageObjectLog

    while true do
        if not (readIndex <= #messageObjectLog) then
            v25 = nil
            break
        end

        local v28 = messageObjectLog[readIndex]

        if v28.ID == a24.ID then
            v25 = v28
            break
        end

        readIndex += 1
    end

    if v25 then
        if isUserFeatureEnabled2 then
            if a24.Message ~= "" then
                v25.UpdateTextFunction(a24)
                self:PositionMessageLabelInWindow(v25, readIndex)
            else
                self:RemoveMessageAtIndex(readIndex)
            end
        else
            v25.UpdateTextFunction(a24)
            self:PositionMessageLabelInWindow(v25, readIndex)
        end
    end
end

function Class.RefreshMessagePlacement(self, a30)
    --[[
      name: RefreshMessagePlacement
      line: 107
    ]]
    local v31
    local readIndex = 1
    local messageObjectLog = self.MessageObjectLog

    while true do
        if not (readIndex <= #messageObjectLog) then
            v31 = nil
            break
        end

        local v34 = messageObjectLog[readIndex]

        if v34.ID == a30.ID then
            v31 = v34
            break
        end

        readIndex += 1
    end

    if v31 then
        self:PositionMessageLabelInWindow(v31, readIndex)
    end
end

function Class.AddMessage(self, a36)
    --[[
      name: AddMessage
      line: 129
      upvalues:
        isUserFeatureEnabled4 (ref,  index: 1)
        messageLabelCreator (copy, index: 2)
    ]]
    self:WaitUntilParentedCorrectly()
    local v37 = if isUserFeatureEnabled4
        then messageLabelCreator:CreateMessageLabel_Chat(
            a36,
            self.CurrentChannelName,
            function()
                --[[
                  line: 134
                  upvalues:
                    self (copy, index: 1)
                    a36 (copy, index: 2)
                ]]
                self:RefreshMessagePlacement(a36)
            end
        )
        else messageLabelCreator:CreateMessageLabel(a36, self.CurrentChannelName)
    if v37 == nil then
        return
    end

    table.insert(self.MessageObjectLog, v37)
    self:PositionMessageLabelInWindow(v37, #self.MessageObjectLog)
end

function Class.RemoveMessageAtIndex(self, index)
    --[[
      name: RemoveMessageAtIndex
      line: 151
    ]]
    self:WaitUntilParentedCorrectly()

    if const v40 = self.MessageObjectLog[index] then
        v40:Destroy()
        table.remove(self.MessageObjectLog, index)
    end
end

function Class.AddMessageAtIndex(self, a42, a43: number)
    --[[
      name: AddMessageAtIndex
      line: 162
      upvalues:
        isUserFeatureEnabled4 (ref,  index: 1)
        messageLabelCreator (copy, index: 2)
    ]]
    local v44 = if isUserFeatureEnabled4
        then messageLabelCreator:CreateMessageLabel_Chat(
            a42,
            self.CurrentChannelName,
            function()
                --[[
                  line: 165
                  upvalues:
                    self (copy, index: 1)
                    a42 (copy, index: 2)
                ]]
                self:RefreshMessagePlacement(a42)
            end
        )
        else messageLabelCreator:CreateMessageLabel(a42, self.CurrentChannelName)
    if v44 == nil then
        return
    end

    table.insert(self.MessageObjectLog, a43, v44)
    self:PositionMessageLabelInWindow(v44, a43)
end

function Class.RemoveLastMessage(self)
    --[[
      name: RemoveLastMessage
      line: 183
    ]]
    self:WaitUntilParentedCorrectly()
    local v46 = self.MessageObjectLog[1]
    v46:Destroy()
    table.remove(self.MessageObjectLog, 1)
end

function Class.IsScrolledDown(self)
    --[[
      name: IsScrolledDown
      line: 192
    ]]
    local offset = self.Scroller.CanvasSize.Y.Offset
    local y = self.Scroller.AbsoluteWindowSize.Y
    local y2 = self.Scroller.CanvasPosition.Y

    return (offset < y) or (offset - y2 <= y + 5)
end

function Class.UpdateMessageTextHeight(self, a52)
    --[[
      name: UpdateMessageTextHeight
      line: 201
    ]]
    local baseFrame = a52.BaseFrame

    for index = 1, 10 do
        if a52.BaseMessage.TextFits then
            break
        end

        local v55 = self.Scroller.AbsoluteSize.X - index
        baseFrame.Size = UDim2.new(1, 0, 0, a52.GetHeightFunction(v55))
    end
end

function Class.PositionMessageLabelInWindow(self, a57, a58)
    --[[
      name: PositionMessageLabelInWindow
      line: 213
    ]]
    self:WaitUntilParentedCorrectly()
    local isScrolledDown = self:IsScrolledDown()
    local baseFrame = a57.BaseFrame
    local v61 = 1

    if self.MessageObjectLog[a58 - 1] then
        v61 = if a58 == #self.MessageObjectLog then self.MessageObjectLog[a58 - 1].BaseFrame.LayoutOrder + 1 else self.MessageObjectLog[a58 - 1].BaseFrame.LayoutOrder
    end

    baseFrame.LayoutOrder = v61
    baseFrame.Size = UDim2.new(1, 0, 0, a57.GetHeightFunction(self.Scroller.AbsoluteSize.X))
    baseFrame.Parent = self.Scroller

    if a57.BaseMessage then
        self:UpdateMessageTextHeight(a57)
    end

    if isScrolledDown then
        self.Scroller.CanvasPosition = Vector2.new(0, (math.max(0, self.Scroller.CanvasSize.Y.Offset - self.Scroller.AbsoluteSize.Y)))
    end
end

function Class.ReorderAllMessages(self)
    --[[
      name: ReorderAllMessages
      line: 243
    ]]
    self:WaitUntilParentedCorrectly()

    if self.GuiObject.AbsoluteSize.Y < 1 then
        return
    end

    local canvasPosition = self.Scroller.CanvasPosition
    local isScrolledDown = self:IsScrolledDown()

    for _, v66 in pairs(self.MessageObjectLog) do
        self:UpdateMessageTextHeight(v66)
    end

    if not isScrolledDown then
        self.Scroller.CanvasPosition = canvasPosition
        return
    end

    self.Scroller.CanvasPosition = Vector2.new(0, (math.max(0, self.Scroller.CanvasSize.Y.Offset - self.Scroller.AbsoluteSize.Y)))
end

function Class.Clear(self)
    --[[
      name: Clear
      line: 265
    ]]
    for _, v69 in pairs(self.MessageObjectLog) do
        v69:Destroy()
    end

    self.MessageObjectLog = {}
end

function Class.SetCurrentChannelName(self, currentChannelName)
    --[[
      name: SetCurrentChannelName
      line: 272
    ]]
    self.CurrentChannelName = currentChannelName
end

function Class.FadeOutBackground(a72, a73)
    --[[
      name: FadeOutBackground
      line: 276
    ]]
end

function Class.FadeInBackground(a74, a75)
    --[[
      name: FadeInBackground
      line: 280
    ]]
end

function Class.FadeOutText(self, a77)
    --[[
      name: FadeOutText
      line: 284
      upvalues:
        CurveUtil (copy, index: 1)
    ]]
    for index = 1, #self.MessageObjectLog do
        if self.MessageObjectLog[index].FadeOutFunction then
            self.MessageObjectLog[index].FadeOutFunction(a77, CurveUtil)
        end
    end
end

function Class.FadeInText(self, a80)
    --[[
      name: FadeInText
      line: 292
      upvalues:
        CurveUtil (copy, index: 1)
    ]]
    for index = 1, #self.MessageObjectLog do
        if self.MessageObjectLog[index].FadeInFunction then
            self.MessageObjectLog[index].FadeInFunction(a80, CurveUtil)
        end
    end
end

function Class.Update(self, a83)
    --[[
      name: Update
      line: 300
      upvalues:
        CurveUtil (copy, index: 1)
    ]]
    for index = 1, #self.MessageObjectLog do
        if self.MessageObjectLog[index].UpdateAnimFunction then
            self.MessageObjectLog[index].UpdateAnimFunction(a83, CurveUtil)
        end
    end
end

function Class.WaitUntilParentedCorrectly(self)
    --[[
      name: WaitUntilParentedCorrectly
      line: 309
    ]]
    while not self.GuiObject:IsDescendantOf(game:GetService("Players").LocalPlayer) do
        self.GuiObject.AncestryChanged:wait()
    end
end

function v7.new()
    --[[
      name: new
      line: 318
      upvalues:
        Class (copy, index: 1)
        CreateGuiObjects (copy, index: 2)
    ]]
    local v86 = setmetatable({}, Class)
    v86.Destroyed = false
    local guiObject, scroller, layout = CreateGuiObjects()
    v86.GuiObject = guiObject
    v86.Scroller = scroller
    v86.Layout = layout
    v86.MessageObjectLog = {}
    v86.Name = "MessageLogDisplay"
    v86.GuiObject.Name = "Frame_" .. v86.Name
    v86.CurrentChannelName = ""
    v86.GuiObject:GetPropertyChangedSignal("AbsoluteSize"):Connect(
        function()
            --[[
              line: 334
              upvalues:
                v86 (copy, index: 1)
            ]]
            spawn(
                function()
                    --[[
                      line: 335
                      upvalues:
                        v86 (copy, index: 1)
                    ]]
                    v86:ReorderAllMessages()
                end
            )
        end
    )
    local isScrolledDown = true

    v86.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
        function()
            --[[
              line: 340
              upvalues:
                v86 (copy, index: 1)
                isScrolledDown (ref,  index: 2)
            ]]
            local absoluteContentSize = v86.Layout.AbsoluteContentSize
            v86.Scroller.CanvasSize = UDim2.new(0, 0, 0, absoluteContentSize.Y)

            if isScrolledDown then
                local absoluteWindowSize = v86.Scroller.AbsoluteWindowSize
                v86.Scroller.CanvasPosition = Vector2.new(0, absoluteContentSize.Y - absoluteWindowSize.Y)
            end
        end
    )

    v86.Scroller:GetPropertyChangedSignal("CanvasPosition"):Connect(
        function()
            --[[
              line: 349
              upvalues:
                isScrolledDown (ref,  index: 1)
                v86 (copy, index: 2)
            ]]
            isScrolledDown = v86:IsScrolledDown()
        end
    )

    return v86
end

return v7