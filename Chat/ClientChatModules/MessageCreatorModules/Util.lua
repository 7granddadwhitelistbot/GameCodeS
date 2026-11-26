local localPlayer
local isUserFeatureEnabled = false
local success, isUserFeatureEnabled2 = pcall(
    function()
        --[[
          line: 41
        ]]
        return UserSettings():IsUserFeatureEnabled("UserFixOverlappingRtlChatMessages2")
    end
)
if success then
    isUserFeatureEnabled = isUserFeatureEnabled2
end

local textService = game:GetService("TextService")
local players = game:GetService("Players")
localPlayer = players.LocalPlayer

while not localPlayer do
    players.ChildAdded:wait()
    localPlayer = players.LocalPlayer
end

local parent = script.Parent.Parent
local ChatSettings = require(parent:WaitForChild("ChatSettings"))
local ChatConstants = require(parent:WaitForChild("ChatConstants"))
local v10 = {}
local Class = {}
Class.__index = Class

function Class.GetStringTextBounds(self, string: string, font: Enum.Font, fontSize: number, a16)
    --[[
      name: GetStringTextBounds
      line: 66
      upvalues:
        textService (copy, index: 1)
    ]]
    local frameSize = a16 or Vector2.new(10000, 10000)
    return textService:GetTextSize(string, fontSize, font, frameSize)
end

function Class.GetMessageHeight(a18, a19, a20, a21)
    --[[
      name: GetMessageHeight
      line: 72
      upvalues:
        isUserFeatureEnabled (ref, index: 1)
    ]]
    local v22 = a21 or a20.AbsoluteSize.X
    local v23 = if isUserFeatureEnabled then a19.ContentText else a19.Text
    local stringTextBounds = a18:GetStringTextBounds(v23, a19.Font, a19.TextSize, Vector2.new(v22, 1000))

    if stringTextBounds.Y == math.floor(stringTextBounds.Y) then
        return stringTextBounds.Y
    end

    return stringTextBounds.Y + 1
end

function Class.GetNumberOfSpaces(a25, a26, a27, a28)
    --[[
      name: GetNumberOfSpaces
      line: 84
    ]]
    local stringTextBounds = a25:GetStringTextBounds(a26, a27, a28)
    local stringTextBounds2 = a25:GetStringTextBounds(" ", a27, a28)

    return (math.ceil(stringTextBounds.X / stringTextBounds2.X))
end

function Class.CreateLeadingSpaces(a31, count: number)
    --[[
      name: CreateLeadingSpaces
      line: 90
      upvalues:
        isUserFeatureEnabled (ref, index: 1)
    ]]
    if isUserFeatureEnabled then
        return "<font dir=\"ltr\">" .. string.rep(" ", count) .. "</font>"
    end

    return string.rep(" ", count)
end

function Class.SanitizeForRichText(a33, text: string)
    --[[
      name: SanitizeForRichText
      line: 98
      upvalues:
        isUserFeatureEnabled (ref, index: 1)
    ]]
    if isUserFeatureEnabled then
        return string.gsub(text, "%p", {["<"] = "&lt;", [">"] = "&gt;", ["&"] = "&amp;"})
    end

    return text
end

function Class.CreateBaseMessage(self, text, font, textSize, textColor3)
    --[[
      name: CreateBaseMessage
      line: 110
      upvalues:
        isUserFeatureEnabled (ref, index: 1)
    ]]
    local parent = self:GetFromObjectPool("Frame")
    parent.Selectable = false
    parent.Size = UDim2.new(1, 0, 0, 18)
    parent.Visible = true
    parent.BackgroundTransparency = 1

    local fromObjectPool = self:GetFromObjectPool("TextLabel")
    fromObjectPool.Selectable = false
    fromObjectPool.Size = UDim2.new(1, -14, 1, 0)
    fromObjectPool.Position = UDim2.new(0, 8, 0, 0)
    fromObjectPool.BackgroundTransparency = 1
    fromObjectPool.Font = font
    fromObjectPool.TextSize = textSize
    fromObjectPool.TextXAlignment = Enum.TextXAlignment.Left
    fromObjectPool.TextYAlignment = Enum.TextYAlignment.Top
    fromObjectPool.TextTransparency = 0
    fromObjectPool.TextStrokeTransparency = 0.75
    fromObjectPool.TextColor3 = textColor3
    fromObjectPool.TextWrapped = true
    fromObjectPool.ClipsDescendants = true
    fromObjectPool.Text = text
    fromObjectPool.Visible = true
    fromObjectPool.RichText = not not isUserFeatureEnabled
    fromObjectPool.Parent = parent

    return parent, fromObjectPool
end

function Class.AddNameButtonToBaseMessage(self, parent, textColor3, text, a46)
    --[[
      name: AddNameButtonToBaseMessage
      line: 141
    ]]
    local stringTextBounds = self:GetStringTextBounds(text, parent.Font, parent.TextSize)
    local fromObjectPool = self:GetFromObjectPool("TextButton")
    fromObjectPool.Selectable = false
    fromObjectPool.Size = UDim2.new(0, stringTextBounds.X, 0, stringTextBounds.Y)
    fromObjectPool.Position = UDim2.new(0, 0, 0, 0)
    fromObjectPool.BackgroundTransparency = 1
    fromObjectPool.Font = parent.Font
    fromObjectPool.TextSize = parent.TextSize
    fromObjectPool.TextXAlignment = parent.TextXAlignment
    fromObjectPool.TextYAlignment = parent.TextYAlignment
    fromObjectPool.TextTransparency = parent.TextTransparency
    fromObjectPool.TextStrokeTransparency = parent.TextStrokeTransparency
    fromObjectPool.TextColor3 = textColor3
    fromObjectPool.Text = text
    fromObjectPool.Visible = true
    fromObjectPool.Parent = parent
    local v49 = fromObjectPool.MouseButton1Click:connect(
        function()
            --[[
              line: 159
              upvalues:
                self (copy, index: 1)
                fromObjectPool (copy, index: 2)
                a46 (copy, index: 3)
            ]]
            self:NameButtonClicked(fromObjectPool, a46)
        end
    )
    local v50 = nil

    v50 = fromObjectPool.Changed:connect(
        function(a51)
            --[[
              line: 164
              upvalues:
                v49 (copy, index: 1)
                v50 (ref,  index: 2)
            ]]
            if a51 == "Parent" then
                v49:Disconnect()
                v50:Disconnect()
            end
        end
    )

    return fromObjectPool
end

function Class.AddTranslationButtonToBaseMessage(self, parent)
    --[[
      name: AddTranslationButtonToBaseMessage
      line: 174
    ]]
    local v54 = math.floor(parent.TextSize * 0.9)
    local vector2 = Vector2.new(v54, v54)
    local fromObjectPool = self:GetFromObjectPool("ImageButton")
    fromObjectPool.Selectable = false
    fromObjectPool.Size = UDim2.new(0, vector2.X, 0, vector2.Y)
    fromObjectPool.Position = UDim2.new(0, 0, 0, 0)
    fromObjectPool.BackgroundTransparency = 1
    fromObjectPool.Visible = false
    fromObjectPool.Parent = parent
    fromObjectPool.Image = "rbxasset://textures/translateIcon.png"
    fromObjectPool.HoverImage = "rbxasset://textures/translateIconDark.png"
    fromObjectPool.PressedImage = "rbxasset://textures/translateIconDark.png"
    return fromObjectPool
end

function Class.AddChannelButtonToBaseMessage(self, parent, textColor3, text, a61)
    --[[
      name: AddChannelButtonToBaseMessage
      line: 191
    ]]
    local stringTextBounds = self:GetStringTextBounds(text, parent.Font, parent.TextSize)
    local fromObjectPool = self:GetFromObjectPool("TextButton")
    fromObjectPool.Selectable = false
    fromObjectPool.Size = UDim2.new(0, stringTextBounds.X, 0, stringTextBounds.Y)
    fromObjectPool.Position = UDim2.new(0, 0, 0, 0)
    fromObjectPool.BackgroundTransparency = 1
    fromObjectPool.Font = parent.Font
    fromObjectPool.TextSize = parent.TextSize
    fromObjectPool.TextXAlignment = parent.TextXAlignment
    fromObjectPool.TextYAlignment = parent.TextYAlignment
    fromObjectPool.TextTransparency = parent.TextTransparency
    fromObjectPool.TextStrokeTransparency = parent.TextStrokeTransparency
    fromObjectPool.TextColor3 = textColor3
    fromObjectPool.Text = text
    fromObjectPool.Visible = true
    fromObjectPool.Parent = parent
    local v64 = fromObjectPool.MouseButton1Click:connect(
        function()
            --[[
              line: 209
              upvalues:
                self (copy, index: 1)
                fromObjectPool (copy, index: 2)
                a61 (copy, index: 3)
            ]]
            self:ChannelButtonClicked(fromObjectPool, a61)
        end
    )
    local v65 = nil

    v65 = fromObjectPool.Changed:connect(
        function(a66)
            --[[
              line: 214
              upvalues:
                v64 (copy, index: 1)
                v65 (ref,  index: 2)
            ]]
            if a66 == "Parent" then
                v64:Disconnect()
                v65:Disconnect()
            end
        end
    )

    return fromObjectPool
end

function Class.AddTagLabelToBaseMessage(self, parent, textColor3, text)
    --[[
      name: AddTagLabelToBaseMessage
      line: 224
    ]]
    local stringTextBounds = self:GetStringTextBounds(text, parent.Font, parent.TextSize)
    local fromObjectPool = self:GetFromObjectPool("TextLabel")
    fromObjectPool.Selectable = false
    fromObjectPool.Size = UDim2.new(0, stringTextBounds.X, 0, stringTextBounds.Y)
    fromObjectPool.Position = UDim2.new(0, 0, 0, 0)
    fromObjectPool.BackgroundTransparency = 1
    fromObjectPool.Font = parent.Font
    fromObjectPool.TextSize = parent.TextSize
    fromObjectPool.TextXAlignment = parent.TextXAlignment
    fromObjectPool.TextYAlignment = parent.TextYAlignment
    fromObjectPool.TextTransparency = parent.TextTransparency
    fromObjectPool.TextStrokeTransparency = parent.TextStrokeTransparency
    fromObjectPool.TextColor3 = textColor3
    fromObjectPool.Text = text
    fromObjectPool.Visible = true
    fromObjectPool.Parent = parent
    return fromObjectPool
end

function GetWhisperChannelPrefix()
    --[[
      name: GetWhisperChannelPrefix
      line: 245
      upvalues:
        ChatConstants (copy, index: 1)
    ]]
    if ChatConstants.WhisperChannelPrefix then
        return ChatConstants.WhisperChannelPrefix
    end

    return "To "
end

function Class.NameButtonClicked(self, a74, childName: string)
    --[[
      name: NameButtonClicked
      line: 252
      upvalues:
        ChatSettings (copy, index: 1)
        players (copy, index: 2)
        localPlayer (ref,  index: 3)
    ]]
    if not self.ChatWindow then
        return
    end

    if ChatSettings.ClickOnPlayerNameToWhisper then
        local player = players:FindFirstChild(childName)

        if player and player ~= localPlayer then
            local v77 = GetWhisperChannelPrefix() .. childName

            if self.ChatWindow:GetChannel(v77) then
                self.ChatBar:ResetCustomState()

                if self.ChatWindow:GetTargetMessageChannel() ~= v77 then
                    self.ChatWindow:SwitchCurrentChannel(v77)
                end

                local text = "/w " .. childName
                self.ChatBar:SetText(text)
                self.ChatBar:CaptureFocus()
            elseif not self.ChatBar:IsInCustomState() then
                local text = "/w " .. childName
                self.ChatBar:SetText(text)
                self.ChatBar:CaptureFocus()
            end
        end
    end
end

function Class.ChannelButtonClicked(self, a81, a82)
    --[[
      name: ChannelButtonClicked
      line: 282
      upvalues:
        ChatSettings (copy, index: 1)
    ]]
    if not self.ChatWindow then
        return
    end

    if ChatSettings.ClickOnChannelNameToSetMainChannel and self.ChatWindow:GetChannel(a82) then
        self.ChatBar:ResetCustomState()

        if self.ChatWindow:GetTargetMessageChannel() ~= a82 then
            self.ChatWindow:SwitchCurrentChannel(a82)
        end

        self.ChatBar:ResetText()
        self.ChatBar:CaptureFocus()
    end
end

function Class.RegisterChatWindow(self, chatWindow)
    --[[
      name: RegisterChatWindow
      line: 300
    ]]
    self.ChatWindow = chatWindow
    self.ChatBar = chatWindow:GetChatBar()
end

function Class.GetFromObjectPool(self, a86: string)
    --[[
      name: GetFromObjectPool
      line: 305
    ]]
    if self.ObjectPool == nil then
        return Instance.new(a86)
    end

    return self.ObjectPool:GetInstance(a86)
end

function Class.RegisterObjectPool(self, objectPool)
    --[[
      name: RegisterObjectPool
      line: 312
    ]]
    self.ObjectPool = objectPool
end

function Class.CreateFadeFunctions(a89, a90)
    --[[
      name: CreateFadeFunctions
      line: 332
    ]]
    local v91 = {}

    for key, v93 in pairs(a90) do
        v91[key] = {}

        for key2, v95 in pairs(v93) do
            v91[key][key2] = {NormalizedExptValue = 1, Target = v95.FadedIn, Current = key[key2]}
        end
    end

    local function AnimGuiObjects()
        --[[
          name: AnimGuiObjects
          line: 363
          upvalues:
            v91 (copy, index: 1)
        ]]
        for key, v98 in pairs(v91) do
            for key2, v100 in pairs(v98) do
                key[key2] = v100.Current
            end
        end
    end

    return function(a101, a102)
        --[[
          name: FadeInFunction
          line: 345
          upvalues:
            v91 (copy, index: 1)
            a90 (copy, index: 2)
        ]]
        for key, v104 in pairs(v91) do
            for key2, v106 in pairs(v104) do
                v106.Target = a90[key][key2].FadedIn
                v106.NormalizedExptValue = a102:NormalizedDefaultExptValueInSeconds(a101)
            end
        end
    end,
        function(a107, a108)
            --[[
              name: FadeOutFunction
              line: 354
              upvalues:
                v91 (copy, index: 1)
                a90 (copy, index: 2)
            ]]
            for key, v110 in pairs(v91) do
                for key2, v112 in pairs(v110) do
                    v112.Target = a90[key][key2].FadedOut
                    v112.NormalizedExptValue = a108:NormalizedDefaultExptValueInSeconds(a107)
                end
            end
        end,
        function(a113, a114)
            --[[
              name: UpdateAnimFunction
              line: 371
              upvalues:
                v91 (copy, index: 1)
                AnimGuiObjects (copy, index: 2)
            ]]
            for _, v116 in pairs(v91) do
                for _, v118 in pairs(v116) do
                    v118.Current = a114:Expt(v118.Current, v118.Target, v118.NormalizedExptValue, a113)
                end
            end

            AnimGuiObjects()
        end
end

function Class.NewBindableEvent(a119, name: string)
    --[[
      name: NewBindableEvent
      line: 389
    ]]
    local bindableEvent = Instance.new("BindableEvent")
    bindableEvent.Name = name
    return bindableEvent
end

function Class.RegisterGuiRoot(a122)
    --[[
      name: RegisterGuiRoot
      line: 396
    ]]
end

function v10.new()
    --[[
      name: new
      line: 401
      upvalues:
        Class (copy, index: 1)
    ]]
    local v123 = setmetatable({}, Class)
    v123.ObjectPool = nil
    v123.ChatWindow = nil
    v123.DEFAULT_MESSAGE_CREATOR = "UnknownMessage"
    v123.MESSAGE_CREATOR_MODULES_VERSION = 1
    v123.KEY_MESSAGE_TYPE = "MessageType"
    v123.KEY_CREATOR_FUNCTION = "MessageCreatorFunc"
    v123.KEY_BASE_FRAME = "BaseFrame"
    v123.KEY_BASE_MESSAGE = "BaseMessage"
    v123.KEY_UPDATE_TEXT_FUNC = "UpdateTextFunction"
    v123.KEY_GET_HEIGHT = "GetHeightFunction"
    v123.KEY_FADE_IN = "FadeInFunction"
    v123.KEY_FADE_OUT = "FadeOutFunction"
    v123.KEY_UPDATE_ANIMATION = "UpdateAnimFunction"
    return v123
end

return v10.new()