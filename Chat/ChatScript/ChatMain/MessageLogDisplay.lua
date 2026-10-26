local success_1, v1 = pcall(
    function()
        --[[
          line: 7
        ]]
        return UserSettings():IsUserFeatureEnabled("UserRemoveMessageOnTextFilterFailures")
    end
)
local u1 = success_1 and v1
local success_2, v2 = pcall(
    function()
        --[[
          line: 15
        ]]
        return UserSettings():IsUserFeatureEnabled("UserIsChatTranslationEnabled2")
    end
)
local u2 = success_2 and v2
local tbl_upv_1 = {}
tbl_upv_1.ScrollBarThickness = 4
local ClientChatModules_1 = game:GetService("Chat"):WaitForChild("ClientChatModules")
local Parent_1 = script.Parent
local MessageLabelCreator_1 = require(Parent_1:WaitForChild("MessageLabelCreator"))
local CurveUtil_upv_1 = require(Parent_1:WaitForChild("CurveUtil"))
local ChatSettings_upv_1 = require(ClientChatModules_1:WaitForChild("ChatSettings"))
local u3 = MessageLabelCreator_1.new()
local tbl_upv_2 = {}
tbl_upv_2.__index = tbl_upv_2
function tbl_upv_2.Destroy(a1)
    --[[
      name: Destroy
      line: 67
    ]]
    a1.GuiObject:Destroy()
    a1.Destroyed = true
end
function tbl_upv_2.SetActive(a1, a2)
    --[[
      name: SetActive
      line: 72
    ]]
    a1.GuiObject.Visible = a2
end
function tbl_upv_2.UpdateMessageFiltered(a1, a2)
    --[[
      name: UpdateMessageFiltered
      line: 76
      upvalues:
        u1 (ref, index: 1)
    ]]
    local v3 = nil
    local v4 = 1
    local MessageObjectLog_1 = a1.MessageObjectLog
    local v5 = nil
    while v4 <= #MessageObjectLog_1 do
        v5 = MessageObjectLog_1[v4]
        if v5.ID ~= a2.ID then
            v4 = v4 + 1
            continue
        else
            v3 = v5
            break
        end
    end
    if not v3 then
        return
    end
    if u1 then
        if a2.Message ~= "" then
            v3.UpdateTextFunction(a2)
            a1:PositionMessageLabelInWindow(v3, v4)
        else
            a1:RemoveMessageAtIndex(v4)
        end
    else
        v3.UpdateTextFunction(a2)
        a1:PositionMessageLabelInWindow(v3, v4)
    end
end
function tbl_upv_2.RefreshMessagePlacement(a1, a2)
    --[[
      name: RefreshMessagePlacement
      line: 107
    ]]
    local v6 = nil
    local v7 = 1
    local MessageObjectLog_2 = a1.MessageObjectLog
    local v8 = nil
    while v7 <= #MessageObjectLog_2 do
        v8 = MessageObjectLog_2[v7]
        if v8.ID ~= a2.ID then
            v7 = v7 + 1
            continue
        else
            v6 = v8
            break
        end
    end
    if not v6 then
        return
    end
    a1:PositionMessageLabelInWindow(v6, v7)
end
function tbl_upv_2.AddMessage(a1, a2)
    --[[
      name: AddMessage
      line: 129
      upvalues:
        u2 (ref,  index: 1)
        u3 (copy, index: 2)
    ]]
    a1:WaitUntilParentedCorrectly()
    local v9
    if u2 then
        v9 = u3:CreateMessageLabel_Chat(
            a2,
            a1.CurrentChannelName,
            function()
                --[[
                  line: 134
                  upvalues:
                    a1 (copy, index: 1)
                    a2 (copy, index: 2)
                ]]
                a1:RefreshMessagePlacement(a2)
            end
        )
    else
        v9 = u3:CreateMessageLabel(a2, a1.CurrentChannelName)
    end
    if v9 == nil then
        return
    end
    table.insert(a1.MessageObjectLog, v9)
    a1:PositionMessageLabelInWindow(v9, #a1.MessageObjectLog)
end
function tbl_upv_2.RemoveMessageAtIndex(a1, a2)
    --[[
      name: RemoveMessageAtIndex
      line: 151
    ]]
    a1:WaitUntilParentedCorrectly()
    local v10 = a1.MessageObjectLog[a2]
    if not v10 then
        return
    end
    v10:Destroy()
    table.remove(a1.MessageObjectLog, a2)
end
function tbl_upv_2.AddMessageAtIndex(a1, a2, a3)
    --[[
      name: AddMessageAtIndex
      line: 162
      upvalues:
        u2 (ref,  index: 1)
        u3 (copy, index: 2)
    ]]
    local v11
    if u2 then
        v11 = u3:CreateMessageLabel_Chat(
            a2,
            a1.CurrentChannelName,
            function()
                --[[
                  line: 165
                  upvalues:
                    a1 (copy, index: 1)
                    a2 (copy, index: 2)
                ]]
                a1:RefreshMessagePlacement(a2)
            end
        )
    else
        v11 = u3:CreateMessageLabel(a2, a1.CurrentChannelName)
    end
    if v11 == nil then
        return
    end
    table.insert(a1.MessageObjectLog, a3, v11)
    a1:PositionMessageLabelInWindow(v11, a3)
end
function tbl_upv_2.RemoveLastMessage(a1)
    --[[
      name: RemoveLastMessage
      line: 183
    ]]
    a1:WaitUntilParentedCorrectly()
    a1.MessageObjectLog[1]:Destroy()
    table.remove(a1.MessageObjectLog, 1)
end
function tbl_upv_2.IsScrolledDown(a1)
    --[[
      name: IsScrolledDown
      line: 192
    ]]
    local Offset_1 = a1.Scroller.CanvasSize.Y.Offset
    local Y_1 = a1.Scroller.AbsoluteWindowSize.Y
    local Y_2 = a1.Scroller.CanvasPosition.Y
    local v12 = true
    if not (Offset_1 < Y_1) then
        v12 = Offset_1 - Y_2 <= Y_1 + 5
    end
    return v12
end
function tbl_upv_2.UpdateMessageTextHeight(a1, a2)
    --[[
      name: UpdateMessageTextHeight
      line: 201
    ]]
    local BaseFrame_1 = a2.BaseFrame
    for n_1 = 1, 10 do
        if a2.BaseMessage.TextFits then
            break
        else
            BaseFrame_1.Size = UDim2.new(1, 0, 0, a2.GetHeightFunction(a1.Scroller.AbsoluteSize.X - n_1))
        end
    end
end
function tbl_upv_2.PositionMessageLabelInWindow(a1, a2, a3)
    --[[
      name: PositionMessageLabelInWindow
      line: 213
    ]]
    a1:WaitUntilParentedCorrectly()
    local v13 = a1:IsScrolledDown()
    local BaseFrame_2 = a2.BaseFrame
    local v14 = 1
    if a1.MessageObjectLog[a3 - 1] then
        v14 = ((a3 == #a1.MessageObjectLog) and (a1.MessageObjectLog[a3 - 1].BaseFrame.LayoutOrder + 1)) or (a1.MessageObjectLog[a3 - 1].BaseFrame.LayoutOrder)
    end
    BaseFrame_2.LayoutOrder = v14
    BaseFrame_2.Size = UDim2.new(1, 0, 0, a2.GetHeightFunction(a1.Scroller.AbsoluteSize.X))
    BaseFrame_2.Parent = a1.Scroller
    if a2.BaseMessage then
        a1:UpdateMessageTextHeight(a2)
    end
    if not v13 then
        return
    end
    a1.Scroller.CanvasPosition = Vector2.new(0, math.max(0, a1.Scroller.CanvasSize.Y.Offset - a1.Scroller.AbsoluteSize.Y))
end
function tbl_upv_2.ReorderAllMessages(a1)
    --[[
      name: ReorderAllMessages
      line: 243
    ]]
    a1:WaitUntilParentedCorrectly()
    if a1.GuiObject.AbsoluteSize.Y < 1 then
        return
    end
    local CanvasPosition_1 = a1.Scroller.CanvasPosition
    local v15 = a1:IsScrolledDown()
    for _, value_1 in pairs(a1.MessageObjectLog) do
        a1:UpdateMessageTextHeight(value_1)
    end
    if v15 then
        a1.Scroller.CanvasPosition = Vector2.new(0, math.max(0, a1.Scroller.CanvasSize.Y.Offset - a1.Scroller.AbsoluteSize.Y))
    else
        a1.Scroller.CanvasPosition = CanvasPosition_1
    end
end
function tbl_upv_2.Clear(a1)
    --[[
      name: Clear
      line: 265
    ]]
    for _, value_2 in pairs(a1.MessageObjectLog) do
        value_2:Destroy()
    end
    a1.MessageObjectLog = {}
end
function tbl_upv_2.SetCurrentChannelName(a1, a2)
    --[[
      name: SetCurrentChannelName
      line: 272
    ]]
    a1.CurrentChannelName = a2
end
function tbl_upv_2.FadeOutBackground(a1, a2)
    --[[
      name: FadeOutBackground
      line: 276
    ]]
end
function tbl_upv_2.FadeInBackground(a1, a2)
    --[[
      name: FadeInBackground
      line: 280
    ]]
end
function tbl_upv_2.FadeOutText(a1, a2)
    --[[
      name: FadeOutText
      line: 284
      upvalues:
        CurveUtil_upv_1 (copy, index: 1)
    ]]
    for n_2 = 1, #a1.MessageObjectLog do
        if a1.MessageObjectLog[n_2].FadeOutFunction then
            a1.MessageObjectLog[n_2].FadeOutFunction(a2, CurveUtil_upv_1)
        end
    end
end
function tbl_upv_2.FadeInText(a1, a2)
    --[[
      name: FadeInText
      line: 292
      upvalues:
        CurveUtil_upv_1 (copy, index: 1)
    ]]
    for n_3 = 1, #a1.MessageObjectLog do
        if a1.MessageObjectLog[n_3].FadeInFunction then
            a1.MessageObjectLog[n_3].FadeInFunction(a2, CurveUtil_upv_1)
        end
    end
end
function tbl_upv_2.Update(a1, a2)
    --[[
      name: Update
      line: 300
      upvalues:
        CurveUtil_upv_1 (copy, index: 1)
    ]]
    for n_4 = 1, #a1.MessageObjectLog do
        if a1.MessageObjectLog[n_4].UpdateAnimFunction then
            a1.MessageObjectLog[n_4].UpdateAnimFunction(a2, CurveUtil_upv_1)
        end
    end
end
function tbl_upv_2.WaitUntilParentedCorrectly(a1)
    --[[
      name: WaitUntilParentedCorrectly
      line: 309
    ]]
    while not (a1.GuiObject:IsDescendantOf(game:GetService("Players").LocalPlayer)) do
        a1.GuiObject.AncestryChanged:wait()
    end
end
local function CreateGuiObjects()
    --[[
      name: CreateGuiObjects
      line: 42
      upvalues:
        ChatSettings_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    local v16 = Instance.new("Frame")
    v16.Selectable = false
    v16.Size = UDim2.new(1, 0, 1, 0)
    v16.BackgroundTransparency = 1
    local v17 = Instance.new("ScrollingFrame")
    v17.Selectable = ChatSettings_upv_1.GamepadNavigationEnabled
    v17.Name = "Scroller"
    v17.BackgroundTransparency = 1
    v17.BorderSizePixel = 0
    v17.Position = UDim2.new(0, 0, 0, 3)
    v17.Size = UDim2.new(1, -4, 1, -6)
    v17.CanvasSize = UDim2.new(0, 0, 0, 0)
    v17.ScrollBarThickness = tbl_upv_1.ScrollBarThickness
    v17.Active = true
    v17.Parent = v16
    local v18 = Instance.new("UIListLayout")
    v18.SortOrder = Enum.SortOrder.LayoutOrder
    v18.Parent = v17
    return v16, v17, v18
end
function tbl_upv_1.new()
    --[[
      name: new
      line: 318
      upvalues:
        tbl_upv_2 (copy, index: 1)
        CreateGuiObjects (copy, index: 2)
    ]]
    local u4 = setmetatable({}, tbl_upv_2)
    u4.Destroyed = false
    local v19, v20, v21 = CreateGuiObjects()
    u4.GuiObject = v19
    u4.Scroller = v20
    u4.Layout = v21
    u4.MessageObjectLog = {}
    u4.Name = "MessageLogDisplay"
    u4.GuiObject.Name = "Frame_" .. u4.Name
    u4.CurrentChannelName = ""
    u4.GuiObject:GetPropertyChangedSignal("AbsoluteSize"):Connect(
        function()
            --[[
              line: 334
              upvalues:
                u4 (copy, index: 1)
            ]]
            spawn(
                function()
                    --[[
                      line: 335
                      upvalues:
                        u4 (copy, index: 1)
                    ]]
                    u4:ReorderAllMessages()
                end
            )
        end
    )
    local u5 = true
    u4.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
        function()
            --[[
              line: 340
              upvalues:
                u4 (copy, index: 1)
                u5 (ref,  index: 2)
            ]]
            local AbsoluteContentSize_1 = u4.Layout.AbsoluteContentSize
            u4.Scroller.CanvasSize = UDim2.new(0, 0, 0, AbsoluteContentSize_1.Y)
            if not u5 then
                return
            end
            u4.Scroller.CanvasPosition = Vector2.new(0, AbsoluteContentSize_1.Y - u4.Scroller.AbsoluteWindowSize.Y)
        end
    )
    u4.Scroller:GetPropertyChangedSignal("CanvasPosition"):Connect(
        function()
            --[[
              line: 349
              upvalues:
                u5 (ref,  index: 1)
                u4 (copy, index: 2)
            ]]
            u5 = u4:IsScrolledDown()
        end
    )
    return u4
end
return tbl_upv_1