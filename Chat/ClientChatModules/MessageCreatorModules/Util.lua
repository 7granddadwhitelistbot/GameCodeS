local u1 = false
local success_1, _ = pcall(
    function()
        --[[
          line: 41
        ]]
        return UserSettings():IsUserFeatureEnabled("UserFixOverlappingRtlChatMessages2")
    end
)
if success_1 then

end
local TextService_upv_1 = game:GetService("TextService")
local Players_upv_1 = game:GetService("Players")
local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
while not (LocalPlayer_upv_1) do
    Players_upv_1.ChildAdded:wait()
    LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
end
local Parent_1 = script.Parent.Parent
local ChatSettings_upv_1 = require(Parent_1:WaitForChild("ChatSettings"))
local ChatConstants_upv_1 = require(Parent_1:WaitForChild("ChatConstants"))
local tbl_1 = {}
local tbl_upv_2 = {}
tbl_upv_2.__index = tbl_upv_2
function tbl_upv_2.GetStringTextBounds(a1, a2, a3, a4, a5)
    --[[
      name: GetStringTextBounds
      line: 66
      upvalues:
        TextService_upv_1 (copy, index: 1)
    ]]
    local v1 = a5 or (Vector2.new(10000, 10000))
    return TextService_upv_1:GetTextSize(a2, a4, a3, v1)
end
function tbl_upv_2.GetMessageHeight(a1, a2, a3, a4)
    --[[
      name: GetMessageHeight
      line: 72
      upvalues:
        u1 (ref, index: 1)
    ]]
    local v2 = a4 or (a3.AbsoluteSize.X)
    if u1 then
        v2 = a2.ContentText
    else
        v2 = a2.Text
    end
    local v3 = a1:GetStringTextBounds(v2, a2.Font, a2.TextSize, Vector2.new(v2, 1000))
    if v3.Y == math.floor(v3.Y) then
        return v3.Y
    end
    return v3.Y + 1
end
function tbl_upv_2.GetNumberOfSpaces(a1, a2, a3, a4)
    --[[
      name: GetNumberOfSpaces
      line: 84
    ]]
    return (math.ceil(a1:GetStringTextBounds(a2, a3, a4).X / a1:GetStringTextBounds(" ", a3, a4).X))
end
function tbl_upv_2.CreateLeadingSpaces(a1, a2)
    --[[
      name: CreateLeadingSpaces
      line: 90
      upvalues:
        u1 (ref, index: 1)
    ]]
    if u1 then
        return "<font dir=\"ltr\">" .. string.rep(" ", a2) .. "</font>"
    end
    return string.rep(" ", a2)
end
function tbl_upv_2.SanitizeForRichText(a1, a2)
    --[[
      name: SanitizeForRichText
      line: 98
      upvalues:
        u1 (ref, index: 1)
    ]]
    if u1 then
        return string.gsub(a2, "%p", {["<"] = "&lt;", [">"] = "&gt;", ["&"] = "&amp;"})
    end
    return a2
end
function tbl_upv_2.CreateBaseMessage(a1, a2, a3, a4, a5)
    --[[
      name: CreateBaseMessage
      line: 110
      upvalues:
        u1 (ref, index: 1)
    ]]
    local v4 = a1:GetFromObjectPool("Frame")
    v4.Selectable = false
    v4.Size = UDim2.new(1, 0, 0, 18)
    v4.Visible = true
    v4.BackgroundTransparency = 1
    local v5 = a1:GetFromObjectPool("TextLabel")
    v5.Selectable = false
    v5.Size = UDim2.new(1, -14, 1, 0)
    v5.Position = UDim2.new(0, 8, 0, 0)
    v5.BackgroundTransparency = 1
    v5.Font = a3
    v5.TextSize = a4
    v5.TextXAlignment = Enum.TextXAlignment.Left
    v5.TextYAlignment = Enum.TextYAlignment.Top
    v5.TextTransparency = 0
    v5.TextStrokeTransparency = 0.75
    v5.TextColor3 = a5
    v5.TextWrapped = true
    v5.ClipsDescendants = true
    v5.Text = a2
    v5.Visible = true
    v5.RichText = u1
    v5.Parent = v4
    return v4, v5
end
function tbl_upv_2.AddNameButtonToBaseMessage(a1, a2, a3, a4, a5)
    --[[
      name: AddNameButtonToBaseMessage
      line: 141
    ]]
    local v6 = a1:GetStringTextBounds(a4, a2.Font, a2.TextSize)
    local u2 = a1:GetFromObjectPool("TextButton")
    u2.Selectable = false
    u2.Size = UDim2.new(0, v6.X, 0, v6.Y)
    u2.Position = UDim2.new(0, 0, 0, 0)
    u2.BackgroundTransparency = 1
    u2.Font = a2.Font
    u2.TextSize = a2.TextSize
    u2.TextXAlignment = a2.TextXAlignment
    u2.TextYAlignment = a2.TextYAlignment
    u2.TextTransparency = a2.TextTransparency
    u2.TextStrokeTransparency = a2.TextStrokeTransparency
    u2.TextColor3 = a3
    u2.Text = a4
    u2.Visible = true
    u2.Parent = a2
    local u3 = u2.MouseButton1Click:connect(
        function()
            --[[
              line: 159
              upvalues:
                a1 (copy, index: 1)
                u2 (copy, index: 2)
                a5 (copy, index: 3)
            ]]
            a1:NameButtonClicked(u2, a5)
        end
    )
    local u4 = nil
    local v7 = u2.Changed:connect(
        function(a6)
            --[[
              line: 164
              upvalues:
                u3 (copy, index: 1)
                u4 (ref,  index: 2)
            ]]
            if a6 ~= "Parent" then
                return
            end
            u3:Disconnect()
            u4:Disconnect()
        end
    )
    u4 = v7
    return u2
end
function tbl_upv_2.AddTranslationButtonToBaseMessage(a1, a2)
    --[[
      name: AddTranslationButtonToBaseMessage
      line: 174
    ]]
    local v8 = math.floor(a2.TextSize * 0.9)
    local v9 = Vector2.new(v8, v8)
    v8 = a1:GetFromObjectPool("ImageButton")
    v8.Selectable = false
    v8.Size = UDim2.new(0, v9.X, 0, v9.Y)
    v8.Position = UDim2.new(0, 0, 0, 0)
    v8.BackgroundTransparency = 1
    v8.Visible = false
    v8.Parent = a2
    v8.Image = "rbxasset://textures/translateIcon.png"
    v8.HoverImage = "rbxasset://textures/translateIconDark.png"
    v8.PressedImage = "rbxasset://textures/translateIconDark.png"
    return v8
end
function tbl_upv_2.AddChannelButtonToBaseMessage(a1, a2, a3, a4, a5)
    --[[
      name: AddChannelButtonToBaseMessage
      line: 191
    ]]
    local v10 = a1:GetStringTextBounds(a4, a2.Font, a2.TextSize)
    local u5 = a1:GetFromObjectPool("TextButton")
    u5.Selectable = false
    u5.Size = UDim2.new(0, v10.X, 0, v10.Y)
    u5.Position = UDim2.new(0, 0, 0, 0)
    u5.BackgroundTransparency = 1
    u5.Font = a2.Font
    u5.TextSize = a2.TextSize
    u5.TextXAlignment = a2.TextXAlignment
    u5.TextYAlignment = a2.TextYAlignment
    u5.TextTransparency = a2.TextTransparency
    u5.TextStrokeTransparency = a2.TextStrokeTransparency
    u5.TextColor3 = a3
    u5.Text = a4
    u5.Visible = true
    u5.Parent = a2
    local u6 = u5.MouseButton1Click:connect(
        function()
            --[[
              line: 209
              upvalues:
                a1 (copy, index: 1)
                u5 (copy, index: 2)
                a5 (copy, index: 3)
            ]]
            a1:ChannelButtonClicked(u5, a5)
        end
    )
    local u7 = nil
    local v11 = u5.Changed:connect(
        function(a6)
            --[[
              line: 214
              upvalues:
                u6 (copy, index: 1)
                u7 (ref,  index: 2)
            ]]
            if a6 ~= "Parent" then
                return
            end
            u6:Disconnect()
            u7:Disconnect()
        end
    )
    u7 = v11
    return u5
end
function tbl_upv_2.AddTagLabelToBaseMessage(a1, a2, a3, a4)
    --[[
      name: AddTagLabelToBaseMessage
      line: 224
    ]]
    local v12 = a1:GetStringTextBounds(a4, a2.Font, a2.TextSize)
    local v13 = a1:GetFromObjectPool("TextLabel")
    v13.Selectable = false
    v13.Size = UDim2.new(0, v12.X, 0, v12.Y)
    v13.Position = UDim2.new(0, 0, 0, 0)
    v13.BackgroundTransparency = 1
    v13.Font = a2.Font
    v13.TextSize = a2.TextSize
    v13.TextXAlignment = a2.TextXAlignment
    v13.TextYAlignment = a2.TextYAlignment
    v13.TextTransparency = a2.TextTransparency
    v13.TextStrokeTransparency = a2.TextStrokeTransparency
    v13.TextColor3 = a3
    v13.Text = a4
    v13.Visible = true
    v13.Parent = a2
    return v13
end
function GetWhisperChannelPrefix()
    --[[
      name: GetWhisperChannelPrefix
      line: 245
      upvalues:
        ChatConstants_upv_1 (copy, index: 1)
    ]]
    if ChatConstants_upv_1.WhisperChannelPrefix then
        return ChatConstants_upv_1.WhisperChannelPrefix
    end
    return "To "
end
function tbl_upv_2.NameButtonClicked(a1, a2, a3)
    --[[
      name: NameButtonClicked
      line: 252
      upvalues:
        ChatSettings_upv_1 (copy, index: 1)
        Players_upv_1 (copy, index: 2)
        LocalPlayer_upv_1 (ref,  index: 3)
    ]]
    if not a1.ChatWindow then
        return
    end
    if ChatSettings_upv_1.ClickOnPlayerNameToWhisper then
        local v14 = Players_upv_1:FindFirstChild(a3)
        if v14 and v14 ~= LocalPlayer_upv_1 then
            local v15 = GetWhisperChannelPrefix() .. a3
            if a1.ChatWindow:GetChannel(v15) then
                a1.ChatBar:ResetCustomState()
                if a1.ChatWindow:GetTargetMessageChannel() ~= v15 then
                    a1.ChatWindow:SwitchCurrentChannel(v15)
                end
                a1.ChatBar:SetText("/w " .. a3)
                a1.ChatBar:CaptureFocus()
                return
            end
            if not (a1.ChatBar:IsInCustomState()) then
                a1.ChatBar:SetText("/w " .. a3)
                a1.ChatBar:CaptureFocus()
            end
        end
    end
end
function tbl_upv_2.ChannelButtonClicked(a1, a2, a3)
    --[[
      name: ChannelButtonClicked
      line: 282
      upvalues:
        ChatSettings_upv_1 (copy, index: 1)
    ]]
    if not a1.ChatWindow then
        return
    end
    if ChatSettings_upv_1.ClickOnChannelNameToSetMainChannel and a1.ChatWindow:GetChannel(a3) then
        a1.ChatBar:ResetCustomState()
        if a1.ChatWindow:GetTargetMessageChannel() ~= a3 then
            a1.ChatWindow:SwitchCurrentChannel(a3)
        end
        a1.ChatBar:ResetText()
        a1.ChatBar:CaptureFocus()
    end
end
function tbl_upv_2.RegisterChatWindow(a1, a2)
    --[[
      name: RegisterChatWindow
      line: 300
    ]]
    a1.ChatWindow = a2
    a1.ChatBar = a2:GetChatBar()
end
function tbl_upv_2.GetFromObjectPool(a1, a2)
    --[[
      name: GetFromObjectPool
      line: 305
    ]]
    if a1.ObjectPool ~= nil then
        return a1.ObjectPool:GetInstance(a2)
    end
    return Instance.new(a2)
end
function tbl_upv_2.RegisterObjectPool(a1, a2)
    --[[
      name: RegisterObjectPool
      line: 312
    ]]
    a1.ObjectPool = a2
end
function tbl_upv_2.CreateFadeFunctions(a1, a2)
    --[[
      name: CreateFadeFunctions
      line: 332
    ]]
    local tbl_upv_3 = {}
    for key_1, value_1 in pairs(a2) do
        tbl_upv_3[key_1] = {}
        for key_2, value_2 in pairs(value_1) do
            tbl_upv_3[key_1][key_2] = {NormalizedExptValue = 1, Target = value_2.FadedIn, Current = key_1[key_2]}
        end
    end
    local function FadeOutFunction(a3, a4)
        --[[
          name: FadeOutFunction
          line: 354
          upvalues:
            tbl_upv_3 (copy, index: 1)
            a2 (copy, index: 2)
        ]]
        for key_3, value_3 in pairs(tbl_upv_3) do
            for key_4, value_4 in pairs(value_3) do
                value_4.Target = a2[key_3][key_4].FadedOut
                value_4.NormalizedExptValue = a4:NormalizedDefaultExptValueInSeconds(a3)
            end
        end
    end
    local function AnimGuiObjects()
        --[[
          name: AnimGuiObjects
          line: 363
          upvalues:
            tbl_upv_3 (copy, index: 1)
        ]]
        for key_5, value_5 in pairs(tbl_upv_3) do
            for key_6, value_6 in pairs(value_5) do
                key_5[key_6] = value_6.Current
            end
        end
    end
    local function FadeInFunction(a5, a6)
        --[[
          name: FadeInFunction
          line: 345
          upvalues:
            tbl_upv_3 (copy, index: 1)
            a2 (copy, index: 2)
        ]]
        for key_7, value_7 in pairs(tbl_upv_3) do
            for key_8, value_8 in pairs(value_7) do
                value_8.Target = a2[key_7][key_8].FadedIn
                value_8.NormalizedExptValue = a6:NormalizedDefaultExptValueInSeconds(a5)
            end
        end
    end
    local function UpdateAnimFunction(a7, a8)
        --[[
          name: UpdateAnimFunction
          line: 371
          upvalues:
            tbl_upv_3 (copy, index: 1)
            AnimGuiObjects (copy, index: 2)
        ]]
        for _, value_9 in pairs(tbl_upv_3) do
            for v1, value_10 in pairs(value_9) do
                value_10.Current = a8:Expt(value_10.Current, value_10.Target, value_10.NormalizedExptValue, a7)
            end
        end
        AnimGuiObjects()
    end
    return FadeInFunction, FadeOutFunction, UpdateAnimFunction
end
function tbl_upv_2.NewBindableEvent(a1, a2)
    --[[
      name: NewBindableEvent
      line: 389
    ]]
    local v16 = Instance.new("BindableEvent")
    v16.Name = a2
    return v16
end
function tbl_upv_2.RegisterGuiRoot(a1)
    --[[
      name: RegisterGuiRoot
      line: 396
    ]]
end
function tbl_1.new()
    --[[
      name: new
      line: 401
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    local v17 = setmetatable({}, tbl_upv_2)
    v17.ObjectPool = nil
    v17.ChatWindow = nil
    v17.DEFAULT_MESSAGE_CREATOR = "UnknownMessage"
    v17.MESSAGE_CREATOR_MODULES_VERSION = 1
    v17.KEY_MESSAGE_TYPE = "MessageType"
    v17.KEY_CREATOR_FUNCTION = "MessageCreatorFunc"
    v17.KEY_BASE_FRAME = "BaseFrame"
    v17.KEY_BASE_MESSAGE = "BaseMessage"
    v17.KEY_UPDATE_TEXT_FUNC = "UpdateTextFunction"
    v17.KEY_GET_HEIGHT = "GetHeightFunction"
    v17.KEY_FADE_IN = "FadeInFunction"
    v17.KEY_FADE_OUT = "FadeOutFunction"
    v17.KEY_UPDATE_ANIMATION = "UpdateAnimFunction"
    return v17
end
return tbl_1.new()