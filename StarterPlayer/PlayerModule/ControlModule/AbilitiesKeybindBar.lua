local userInputService = game:GetService("UserInputService")
local CommonUtils = require(script.Parent.Parent:WaitForChild("CommonUtils"))
local InputSlots = require(script.Parent:WaitForChild("InputSlots"))
local v4 = CommonUtils.get("ConnectionUtil")
local dPadUp = Enum.KeyCode.DPadUp
local m = Enum.KeyCode.M
local backgroundColor3 = Color3.fromRGB(18, 18, 21)
local builderSans = Enum.Font.BuilderSans
local textColor3 = Color3.fromRGB(247, 247, 248)
local builderSansBold = Enum.Font.BuilderSansBold
local backgroundColor32 = Color3.fromRGB(247, 247, 248)
local textColor32 = Color3.fromRGB(18, 18, 21)
local v13 = {}

for _, keyCode in {Enum.KeyCode.ButtonA, Enum.KeyCode.ButtonB, Enum.KeyCode.ButtonX, Enum.KeyCode.ButtonY, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1, Enum.KeyCode.ButtonL2, Enum.KeyCode.ButtonR2, Enum.KeyCode.ButtonL3, Enum.KeyCode.ButtonR3, Enum.KeyCode.ButtonStart, Enum.KeyCode.ButtonSelect, Enum.KeyCode.DPadLeft, Enum.KeyCode.DPadRight, Enum.KeyCode.DPadUp, Enum.KeyCode.DPadDown, Enum.KeyCode.Thumbstick1, Enum.KeyCode.Thumbstick2} do
    v13[keyCode] = true
end

local v16 = {}
v16[Enum.KeyCode.ButtonCenter] = true
v16[Enum.KeyCode.ButtonUp] = true
v16[Enum.KeyCode.ButtonDown] = true
v16[Enum.KeyCode.ButtonLeft] = true
v16[Enum.KeyCode.ButtonRight] = true

local function actionKeyCode(a18)
    --[[
      name: actionKeyCode
      line: 85
      upvalues:
        userInputService (copy, index: 1)
        v13 (copy, index: 2)
        v16 (copy, index: 3)
    ]]
    local keyCode

    for _, child in a18:GetChildren() do
        if child:IsA("InputBinding") then
            keyCode = child.KeyCode
            local v22 = if userInputService.PreferredInput == Enum.PreferredInput.Gamepad then v13[keyCode] == true else keyCode ~= Enum.KeyCode.None
                and not v13[keyCode]
                and not v16[keyCode]
            if not v22 then
                continue
            end

            return keyCode
        end
    end

    return nil
end

local function createEntryFrame(parent, name: string, layoutOrder: number)
    --[[
      name: createEntryFrame
      line: 105
    ]]
    local parent2 = Instance.new("Frame")
    parent2.Name = name
    parent2.LayoutOrder = layoutOrder
    parent2.Size = UDim2.new(0, 0, 0, 28)
    parent2.AutomaticSize = Enum.AutomaticSize.X
    parent2.BackgroundTransparency = 1
    parent2.BorderSizePixel = 0
    parent2.Parent = parent

    local uiPadding = Instance.new("UIPadding")
    uiPadding.PaddingRight = UDim.new(0, 8)
    uiPadding.Parent = parent2

    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.FillDirection = Enum.FillDirection.Horizontal
    uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    uiListLayout.Padding = UDim.new(0, 4)
    uiListLayout.Parent = parent2

    return parent2
end

local function createKeyIndicator(parent: Frame, keyCode: Enum.KeyCode, layoutOrder: number)
    --[[
      name: createKeyIndicator
      line: 130
      upvalues:
        userInputService (copy, index: 1)
        backgroundColor32 (copy, index: 2)
        builderSansBold (copy, index: 3)
        textColor32 (copy, index: 4)
    ]]
    if keyCode and userInputService.PreferredInput == Enum.PreferredInput.Gamepad then
        local image = userInputService:GetImageForKeyCode(keyCode)

        if image ~= "" then
            local key = Instance.new("ImageLabel")
            key.Name = "Key"
            key.LayoutOrder = layoutOrder
            key.Size = UDim2.new(0, 24, 0, 24)
            key.BackgroundTransparency = 1
            key.Image = image
            key.Parent = parent

            return
        end
    end

    local v36 = "?"

    if keyCode and keyCode ~= Enum.KeyCode.None then
        v36 = userInputService:GetStringForKeyCode(keyCode, Enum.KeyCodeStringFormat.Abbreviated)

        if v36:match("^%s*$") then
            v36 = keyCode.Name
        end
    end

    local key = Instance.new("TextLabel")
    key.Name = "Key"
    key.LayoutOrder = layoutOrder
    key.AutomaticSize = Enum.AutomaticSize.XY
    key.Size = UDim2.new(0, 0, 0, 0)
    key.BackgroundColor3 = backgroundColor32
    key.BackgroundTransparency = 0
    key.BorderSizePixel = 0
    key.Font = builderSansBold
    key.TextSize = 14
    key.TextColor3 = textColor32
    key.Text = v36
    key.Parent = parent

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 2)
    uiCorner.Parent = key

    local uiSizeConstraint = Instance.new("UISizeConstraint")
    uiSizeConstraint.MinSize = Vector2.new(10, 10)
    uiSizeConstraint.Parent = key

    local uiPadding = Instance.new("UIPadding")
    uiPadding.PaddingLeft = UDim.new(0, 5)
    uiPadding.PaddingRight = UDim.new(0, 5)
    uiPadding.PaddingTop = UDim.new(0, 1)
    uiPadding.PaddingBottom = UDim.new(0, 2)
    uiPadding.Parent = key
end

local function createLabel(parent: Frame, text: string, layoutOrder: number)
    --[[
      name: createLabel
      line: 183
      upvalues:
        builderSans (copy, index: 1)
        textColor3 (copy, index: 2)
    ]]
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.LayoutOrder = layoutOrder
    label.AutomaticSize = Enum.AutomaticSize.X
    label.Size = UDim2.new(0, 0, 0, 28)
    label.BackgroundTransparency = 1
    label.Font = builderSans
    label.TextSize = 18
    label.TextColor3 = textColor3
    label.Text = text
    label.Parent = parent

    local uiPadding = Instance.new("UIPadding")
    uiPadding.PaddingTop = UDim.new(0, -0)
    uiPadding.PaddingBottom = UDim.new(0, 0)
    uiPadding.Parent = label
end

local Class = {}
Class.__index = Class

function Class.new(parent)
    --[[
      name: new
      line: 211
      upvalues:
        Class (copy, index: 1)
        v4 (copy, index: 2)
    ]]
    local v49 = setmetatable({}, Class)
    v49.parent = parent
    v49.characterContext = nil
    v49.created = false
    v49.enabled = false
    v49.bar = nil
    v49.connections = v4.new()
    v49.contextConnections = v4.new()
    return v49
end

function Class.GetInputContextsParent(self)
    --[[
      name: GetInputContextsParent
      line: 226
    ]]
    return script:FindFirstAncestor("PlayerModule")
end

function Class.ResolveCharacterContext(self)
    --[[
      name: ResolveCharacterContext
      line: 230
    ]]
    local inputContextsParent = self:GetInputContextsParent()
    local inputContexts = inputContextsParent and inputContextsParent:FindFirstChild("InputContexts")
    if not inputContexts then
        return nil
    end

    return inputContexts:FindFirstChild("CharacterContext")
end

function Class.ResolveAndBind(self)
    --[[
      name: ResolveAndBind
      line: 239
    ]]
    self.connections:disconnect("ResolveWatcher")

    if const v55 = self:ResolveCharacterContext() then
        self:BindCharacterContext(v55)
        return
    end

    local inputContextsParent = self:GetInputContextsParent()
    if not inputContextsParent then
        return
    end

    local function bindWhenCharacterContextReady(a58)
        --[[
          name: bindWhenCharacterContextReady
          line: 253
          upvalues:
            self (copy, index: 1)
        ]]
        if const characterContext = a58:FindFirstChild("CharacterContext") then
            self.connections:disconnect("ResolveWatcher")
            self:BindCharacterContext(characterContext)

            return
        end

        self.connections:trackConnection(
            "ResolveWatcher",
            a58.ChildAdded:Connect(
                function(a60)
                    --[[
                      line: 262
                      upvalues:
                        self (copy, index: 1)
                    ]]
                    if a60.Name == "CharacterContext" then
                        self.connections:disconnect("ResolveWatcher")
                        self:BindCharacterContext(a60)
                    end
                end
            )
        )
    end

    if const inputContexts = inputContextsParent:FindFirstChild("InputContexts") then
        bindWhenCharacterContextReady(inputContexts)
        return
    end

    self.connections:trackConnection(
        "ResolveWatcher",
        inputContextsParent.ChildAdded:Connect(
            function(a62)
                --[[
                  line: 278
                  upvalues:
                    bindWhenCharacterContextReady (copy, index: 1)
                ]]
                if a62.Name == "InputContexts" then
                    bindWhenCharacterContextReady(a62)
                end
            end
        )
    )
end

function Class.BindCharacterContext(self, characterContext)
    --[[
      name: BindCharacterContext
      line: 286
      upvalues:
        InputSlots (copy, index: 1)
    ]]
    self.characterContext = characterContext
    self.contextConnections:disconnectAll()

    if characterContext then
        local function watchAction(a66)
            --[[
              name: watchAction
              line: 292
              upvalues:
                self (copy, index: 1)
            ]]
            self.contextConnections:trackConnection(
                a66.Name .. "_Enabled",
                a66:GetPropertyChangedSignal("Enabled"):Connect(
                    function()
                        --[[
                          line: 295
                          upvalues:
                            self (copy, index: 1)
                        ]]
                        self:Rebuild()
                    end
                )
            )
            self.contextConnections:trackConnection(
                a66.Name .. "_AttributeChanged",
                a66.AttributeChanged:Connect(
                    function()
                        --[[
                          line: 301
                          upvalues:
                            self (copy, index: 1)
                        ]]
                        self:Rebuild()
                    end
                )
            )
        end

        for index = 1, InputSlots.GetNumAbilitySlots() do
            if const v68 = characterContext:FindFirstChild("AbilityAction" .. index) then
                watchAction(v68)
            end
        end

        self.contextConnections:trackConnection(
            "ChildAdded",
            characterContext.ChildAdded:Connect(
                function(a69)
                    --[[
                      line: 314
                      upvalues:
                        watchAction (copy, index: 1)
                        self (copy, index: 2)
                    ]]
                    if a69:IsA("InputAction") and string.match(a69.Name, "^AbilityAction%d+$") then
                        watchAction(a69)
                        self:Rebuild()
                    end
                end
            )
        )

        self.contextConnections:trackConnection(
            "ChildRemoved",
            characterContext.ChildRemoved:Connect(
                function(a70)
                    --[[
                      line: 323
                      upvalues:
                        self (copy, index: 1)
                    ]]
                    if a70:IsA("InputAction") and string.match(a70.Name, "^AbilityAction%d+$") then
                        self.contextConnections:disconnect(a70.Name .. "_Enabled")
                        self.contextConnections:disconnect(a70.Name .. "_AttributeChanged")
                        self:Rebuild()
                    end
                end
            )
        )
    end

    self:Rebuild()
end

function Class.IsVisiblePlatform(self)
    --[[
      name: IsVisiblePlatform
      line: 336
      upvalues:
        userInputService (copy, index: 1)
    ]]
    local preferredInput = userInputService.PreferredInput
    return (preferredInput == Enum.PreferredInput.KeyboardAndMouse) or (preferredInput == Enum.PreferredInput.Gamepad)
end

function Class.Enable(self, enabled)
    --[[
      name: Enable
      line: 341
    ]]
    if self.enabled == enabled then
        return
    end

    self.enabled = enabled

    if enabled and not self.created then
        self:Create()
        self.created = true
    end

    self:Rebuild()
end

function Class.CreateEntry(self, layoutOrder: number, text: string, keyCode: Enum.KeyCode)
    --[[
      name: CreateEntry
      line: 355
      upvalues:
        createEntryFrame (copy, index: 1)
        createKeyIndicator (copy, index: 2)
        createLabel (copy, index: 3)
    ]]
    local entryFrame = createEntryFrame(self.bar, "Slot" .. layoutOrder, layoutOrder)
    createKeyIndicator(entryFrame, keyCode, 1)
    createLabel(entryFrame, text, 2)
end

function Class.CreateActionEntry(self, name: string, layoutOrder: number, text: string, keyCode: Enum.KeyCode)
    --[[
      name: CreateActionEntry
      line: 362
      upvalues:
        createEntryFrame (copy, index: 1)
        createKeyIndicator (copy, index: 2)
        createLabel (copy, index: 3)
    ]]
    local entryFrame = createEntryFrame(self.bar, name, layoutOrder)
    createKeyIndicator(entryFrame, keyCode, 1)
    createLabel(entryFrame, text, 2)
end

function Class.Rebuild(self)
    --[[
      name: Rebuild
      line: 374
      upvalues:
        userInputService (copy, index: 1)
        InputSlots (copy, index: 2)
        dPadUp (copy, index: 3)
        m (copy, index: 4)
        actionKeyCode (copy, index: 5)
    ]]
    if not self.bar then
        return
    end

    for _, child in self.bar:GetChildren() do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end

    local characterContext = self.characterContext

    if not self.enabled or not self:IsVisiblePlatform() or not characterContext then
        self.bar.Visible = false
        return
    end

    local visible
    local v91 = false
    local preferredInput = userInputService.PreferredInput

    if 0 < #InputSlots.GetAbilitiesInOverflow() then
        local keyCode

        if preferredInput ~= Enum.PreferredInput.Gamepad then
            keyCode = if preferredInput == Enum.PreferredInput.KeyboardAndMouse then m else nil
        else
            keyCode = dPadUp
        end

        if keyCode then
            self:CreateActionEntry("MoreActions", InputSlots.GetNumAbilitySlots() + 1, "More Actions", keyCode)
            v91 = true
        end
    end

    visible = v91

    for index = 1, InputSlots.GetNumAbilitySlots() do
        local v95 = characterContext:FindFirstChild("AbilityAction" .. index)

        if v95 and v95.Enabled then
            local displayName = v95.DisplayName

            if type(displayName) == "string" and displayName ~= "" then
                self:CreateEntry(index, displayName, (actionKeyCode(v95)))
                visible = true
            end
        end
    end

    self.bar.Visible = visible
end

function Class.Create(self)
    --[[
      name: Create
      line: 422
      upvalues:
        backgroundColor3 (copy, index: 1)
        userInputService (copy, index: 2)
        InputSlots (copy, index: 3)
    ]]
    if not self.parent then
        return
    end

    local abilityKeybindBar = Instance.new("Frame")
    abilityKeybindBar.Name = "AbilityKeybindBar"
    abilityKeybindBar.AnchorPoint = Vector2.new(1, 1)
    abilityKeybindBar.Position = UDim2.new(1, -17, 1, -17)
    abilityKeybindBar.Size = UDim2.new(0, 0, 0, 28)
    abilityKeybindBar.AutomaticSize = Enum.AutomaticSize.XY
    abilityKeybindBar.BackgroundColor3 = backgroundColor3
    abilityKeybindBar.BackgroundTransparency = 0.4
    abilityKeybindBar.BorderSizePixel = 0
    abilityKeybindBar.Visible = false
    abilityKeybindBar.Parent = self.parent
    self.bar = abilityKeybindBar
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(1, 0)
    uiCorner.Parent = abilityKeybindBar

    local uiPadding = Instance.new("UIPadding")
    uiPadding.PaddingLeft = UDim.new(0, 16)
    uiPadding.PaddingRight = UDim.new(0, 12)
    uiPadding.PaddingTop = UDim.new(0, 4)
    uiPadding.PaddingBottom = UDim.new(0, 4)
    uiPadding.Parent = abilityKeybindBar

    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.FillDirection = Enum.FillDirection.Horizontal
    uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    uiListLayout.Padding = UDim.new(0, 8)
    uiListLayout.Parent = abilityKeybindBar
    self.connections:trackConnection(
        "PreferredInput",
        userInputService:GetPropertyChangedSignal("PreferredInput"):Connect(
            function()
                --[[
                  line: 461
                  upvalues:
                    self (copy, index: 1)
                ]]
                self:Rebuild()
            end
        )
    )
    self.connections:trackConnection(
        "SlotMapChanged",
        InputSlots.GetSlotMapChangedSignal():Connect(
            function()
                --[[
                  line: 468
                  upvalues:
                    self (copy, index: 1)
                ]]
                self:Rebuild()
            end
        )
    )
    self.connections:trackConnection(
        "ParentDestroying",
        self.parent.Destroying:Connect(
            function()
                --[[
                  line: 475
                  upvalues:
                    self (copy, index: 1)
                ]]
                self:Teardown()
            end
        )
    )
    self:ResolveAndBind()
end

function Class.Teardown(self)
    --[[
      name: Teardown
      line: 483
    ]]
    self.connections:disconnectAll()
    self.contextConnections:disconnectAll()

    if self.bar then
        self.bar:Destroy()
        self.bar = nil
    end

    self.created = false
end

return Class