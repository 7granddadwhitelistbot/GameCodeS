local players = game:GetService("Players")
local userInputService = game:GetService("UserInputService")
local guiService = game:GetService("GuiService")
local CommonUtils = require(script.Parent.Parent:WaitForChild("CommonUtils"))
local v5 = CommonUtils.get("ConnectionUtil")
local v6 = require(script.Parent:WaitForChild("AvatarAbilitiesInterface")).get(players.LocalPlayer)
local InputSlots = require(script.Parent:WaitForChild("InputSlots"))
local AbilityButton = require(script.Parent:WaitForChild("AbilityButton"))
local v9 = {28, 44}
local v10 = {36, 56}
local v11 = {16, 12}
local v12 = {16, 12}

local function IsPortrait()
    --[[
      name: IsPortrait
      line: 32
      upvalues:
        players (copy, index: 1)
    ]]
    return if const playerGui = players.LocalPlayer:FindFirstChildOfClass("PlayerGui") then playerGui.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait else false
end

local Class = {}
Class.__index = Class

function Class.new(parentUiFrame)
    --[[
      name: new
      line: 49
      upvalues:
        Class (copy, index: 1)
        v5 (copy, index: 2)
    ]]
    local v17 = setmetatable({}, Class)
    v17.parentUIFrame = parentUiFrame
    v17.managedButtons = {}
    v17.created = false
    v17.enabled = false
    v17.enabledChangedEvent = Instance.new("BindableEvent")
    v17.selectionMode = false
    v17.selectedVisibleSlot = 1
    v17.numVisibleSlots = 0
    v17.abilityButtonsByVisibleSlot = {}
    v17.selectionRing = nil
    v17.activeActionSlot = nil
    v17.activeButton = nil
    v17.scrollHighlightDirection = "none"
    v17.connections = v5.new()
    v17.inputFolder = nil
    v17.navContext = nil
    return v17
end

function Class.Enable(self, enabled)
    --[[
      name: Enable
      line: 74
    ]]
    if self.enabled == enabled then
        return
    end

    self.enabled = enabled

    if enabled and not self.created then
        self:Create()
        self.created = true
    end

    if not enabled then
        self:ExitSelectionMode()
    end

    if self.created then
        self:UpdateInputMode()
    end

    self.enabledChangedEvent:Fire()
end

function Class.CreateOverflowScrollButton(self, a21)
    --[[
      name: CreateOverflowScrollButton
      line: 96
      upvalues:
        players (copy, index: 1)
        v9 (copy, index: 2)
        v10 (copy, index: 3)
        v11 (copy, index: 4)
        v12 (copy, index: 5)
        InputSlots (copy, index: 6)
        v5 (copy, index: 7)
        Class (copy, index: 8)
    ]]
    local scrollButton = Instance.new("ImageButton")
    scrollButton.Name = "ScrollButton"
    scrollButton.BackgroundTransparency = 1
    scrollButton.Image = "rbxassetid://120193229129639"
    scrollButton.PressedImage = "rbxassetid://122643389561468"
    scrollButton.Parent = self.parentUIFrame

    local function ResizeButton()
        --[[
          name: ResizeButton
          line: 104
          upvalues:
            self (copy, index: 1)
            players (copy, index: 2)
            v9 (copy, index: 3)
            v10 (copy, index: 4)
            v11 (copy, index: 5)
            v12 (copy, index: 6)
            InputSlots (copy, index: 7)
            scrollButton (copy, index: 8)
            a21 (copy, index: 9)
        ]]
        local v24 = math.min(self.parentUIFrame.AbsoluteSize.x, self.parentUIFrame.AbsoluteSize.y)
        local playerGui = players.LocalPlayer:FindFirstChildOfClass("PlayerGui")
        local isPortrait = not not (playerGui
            and playerGui.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait)
        local v27 = v24 <= 500
        local v28 = v27 and v9 or v10
        local v29 = v27 and v11 or v12
        local v30 = v27 and 8 or 10
        local v31 = v27 and 44 or 56
        local v32 = v28[1]
        local v33 = v28[2]
        local v34 = v29[1]
        local v35 = v29[2]
        local v36 = 0.5 * (v33 - v32)
        local numOverflowSlots = InputSlots.GetNumOverflowSlots()
        local v38 = numOverflowSlots * v31 + (numOverflowSlots + 1) * v30
        scrollButton.Size = UDim2.new(0, v32, 0, v33)

        if a21 ~= "previous" then
            if isPortrait then
                scrollButton.Position = UDim2.new(1, (-v34 - v33) + v36, 0, v35 - v36)
                scrollButton.Rotation = 90

                return
            end

            scrollButton.Position = UDim2.new(1, -v34 - v32, 0, v35)
            scrollButton.Rotation = 180

            return
        end

        if isPortrait then
            scrollButton.Position = UDim2.new(1, (-v34 - v33) + v36, 0, ((v35 + v32) + v38) - v36)
            scrollButton.Rotation = 270

            return
        end

        scrollButton.Position = UDim2.new(1, (-v34 - (2 * v32)) - v38, 0, v35)
        scrollButton.Rotation = 0
    end

    ResizeButton()
    local v39 = v5.new()
    v39:trackConnection("ParentResize", self.parentUIFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(ResizeButton))

    scrollButton.Activated:Connect(
        function()
            --[[
              line: 161
              upvalues:
                a21 (copy, index: 1)
                InputSlots (copy, index: 2)
            ]]
            if a21 == "previous" then
                InputSlots.setOverflowScrollIndex(InputSlots.getOverflowScrollIndex() + 1)
                return
            end

            InputSlots.setOverflowScrollIndex(InputSlots.getOverflowScrollIndex() - 1)
        end
    )

    scrollButton.Destroying:Connect(
        function()
            --[[
              line: 169
              upvalues:
                v39 (copy, index: 1)
            ]]
            v39:disconnectAll()
        end
    )
    scrollButton.Selectable = false

    if Class.IsGamepad() then
        scrollButton.Active = false
        scrollButton.AutoButtonColor = false
    end

    return scrollButton
end

function Class.SetScrollHighlight(self, scrollHighlight)
    --[[
      name: SetScrollHighlight
      line: 183
    ]]
    if self.scrollHighlightDirection == scrollHighlight then
        return
    end

    self.scrollHighlightDirection = scrollHighlight

    if self.created then
        self:CreateButtons()
    end
end

function Class.GetScrollDirectionForMove(self, a43)
    --[[
      name: GetScrollDirectionForMove
      line: 193
      upvalues:
        InputSlots (copy, index: 1)
    ]]
    if not self.selectionMode or self.activeActionSlot or a43 == "none" then
        return "none"
    end

    local v44 = a43 ~= "previous" and -1 or 1
    local v45 = math.max(0, #InputSlots.GetAbilitiesInOverflow() - InputSlots.GetNumOverflowSlots())
    local overflowScrollIndex = InputSlots.getOverflowScrollIndex()
    local v47 = self.selectedVisibleSlot + v44

    if v47 < 1 and 0 < overflowScrollIndex then
        return "next"
    end
    if self.numVisibleSlots < v47 and overflowScrollIndex < v45 then
        return "previous"
    end

    return "none"
end

function Class.IsGamepad()
    --[[
      name: IsGamepad
      line: 212
      upvalues:
        userInputService (copy, index: 1)
    ]]
    return userInputService.PreferredInput == Enum.PreferredInput.Gamepad
end

function Class.IsKeyboardMouse()
    --[[
      name: IsKeyboardMouse
      line: 216
      upvalues:
        userInputService (copy, index: 1)
    ]]
    return userInputService.PreferredInput == Enum.PreferredInput.KeyboardAndMouse
end

function Class.SupportsSelection()
    --[[
      name: SupportsSelection
      line: 220
      upvalues:
        Class (copy, index: 1)
    ]]
    return Class.IsGamepad() or Class.IsKeyboardMouse()
end

function Class.EnsureSelectionRing(self)
    --[[
      name: EnsureSelectionRing
      line: 224
    ]]
    if self.selectionRing then
        return
    end

    local selectionRing = Instance.new("Frame")
    selectionRing.Name = "SelectionRing"
    selectionRing.BackgroundTransparency = 1
    selectionRing.Size = UDim2.new(1, 8, 1, 8)
    selectionRing.Position = UDim2.new(0, -4, 0, -4)

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(1, 0)
    uiCorner.Parent = selectionRing

    local uiStroke = Instance.new("UIStroke")
    uiStroke.Thickness = 3
    uiStroke.Color = Color3.new(1, 1, 1)
    uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    uiStroke.Parent = selectionRing
    self.selectionRing = selectionRing
end

function Class.EnsureInputObjects(self)
    --[[
      name: EnsureInputObjects
      line: 248
    ]]
    if self.inputFolder then
        return
    elseif const abilitiesOverflowInput2 = script:FindFirstChild("AbilitiesOverflowInput") then
        abilitiesOverflowInput2:Destroy()
    end

    local abilitiesOverflowInput = Instance.new("Folder")
    abilitiesOverflowInput.Name = "AbilitiesOverflowInput"

    local abilitiesOverflowNavContext = Instance.new("InputContext")
    abilitiesOverflowNavContext.Name = "AbilitiesOverflowNavContext"
    abilitiesOverflowNavContext.Priority = 500
    abilitiesOverflowNavContext.Sink = true
    abilitiesOverflowNavContext.Enabled = false
    abilitiesOverflowNavContext.Parent = abilitiesOverflowInput

    local function createNavAction(name: string, a58)
        --[[
          name: createNavAction
          line: 268
          upvalues:
            abilitiesOverflowNavContext (copy, index: 1)
        ]]
        local parent = Instance.new("InputAction")
        parent.Name = name
        parent.Type = Enum.InputActionType.Bool
        parent.Parent = abilitiesOverflowNavContext

        for v60, keyCode in a58 do
            local inputBinding = Instance.new("InputBinding")
            inputBinding.Name = "Binding" .. v60
            inputBinding.KeyCode = keyCode
            inputBinding.Parent = parent
        end

        return parent
    end

    local navAction = createNavAction("NavPreviousAction", {Enum.KeyCode.ButtonL1, Enum.KeyCode.DPadLeft, Enum.KeyCode.Left})

    self.connections:trackConnection(
        "NavPrevious",
        navAction.StateChanged:Connect(
            function(value)
                --[[
                  line: 288
                  upvalues:
                    self (copy, index: 1)
                ]]
                if value then
                    self:SetScrollHighlight(self:GetScrollDirectionForMove("previous"))
                    return
                end

                self:SetScrollHighlight("none")
                self:MoveSelection("previous")
            end
        )
    )

    local navAction2 = createNavAction("NavNextAction", {Enum.KeyCode.ButtonR1, Enum.KeyCode.DPadRight, Enum.KeyCode.Right})

    self.connections:trackConnection(
        "NavNext",
        navAction2.StateChanged:Connect(
            function(value)
                --[[
                  line: 302
                  upvalues:
                    self (copy, index: 1)
                ]]
                if value then
                    self:SetScrollHighlight(self:GetScrollDirectionForMove("next"))
                    return
                end

                self:SetScrollHighlight("none")
                self:MoveSelection("next")
            end
        )
    )

    local navAction3 = createNavAction("ExitAction", {Enum.KeyCode.ButtonB})
    self.connections:trackConnection(
        "Exit",
        navAction3.Pressed:Connect(
            function()
                --[[
                  line: 315
                  upvalues:
                    self (copy, index: 1)
                ]]
                self:ExitSelectionMode()
            end
        )
    )
    local navAction4 = createNavAction("ActivateAction", {Enum.KeyCode.ButtonA, Enum.KeyCode.Return, Enum.KeyCode.KeypadEnter})

    self.connections:trackConnection(
        "Activate",
        navAction4.StateChanged:Connect(
            function(value)
                --[[
                  line: 324
                  upvalues:
                    self (copy, index: 1)
                ]]
                if value then
                    self.activeActionSlot = self.selectedVisibleSlot
                    self.activeButton = self.abilityButtonsByVisibleSlot[self.activeActionSlot]

                    if self.activeButton then
                        self.activeButton:SetSelectionPressed(true)
                    end
                elseif self.activeActionSlot then
                    self:ExitSelectionMode()
                end
            end
        )
    )

    createNavAction("AbilitySinkAction", {Enum.KeyCode.ButtonX, Enum.KeyCode.ButtonY, Enum.KeyCode.ButtonL2, Enum.KeyCode.ButtonR2, Enum.KeyCode.DPadDown})
    abilitiesOverflowInput.Parent = script
    self.inputFolder = abilitiesOverflowInput
    self.navContext = abilitiesOverflowNavContext
end

function Class.UpdateInputMode(self)
    --[[
      name: UpdateInputMode
      line: 351
      upvalues:
        Class (copy, index: 1)
    ]]
    if not self.parentUIFrame then
        return
    end

    if Class.SupportsSelection() then
        self:EnsureInputObjects()

        if not self.enabled and self.selectionMode then
            self:ExitSelectionMode()
        end
    elseif self.selectionMode then
        self:ExitSelectionMode()
    end

    self.parentUIFrame.Visible = true
end

function Class.EnterSelectionMode(self)
    --[[
      name: EnterSelectionMode
      line: 370
      upvalues:
        Class (copy, index: 1)
    ]]
    if self.selectionMode then
        return
    end
    if not Class.SupportsSelection() or not self.enabled then
        return
    end
    if self.numVisibleSlots <= 0 then
        return
    end

    self.selectionMode = true

    if self.navContext then
        self.navContext.Enabled = true
    end

    self.parentUIFrame.Visible = true
    self.selectedVisibleSlot = math.clamp(self.selectedVisibleSlot, 1, self.numVisibleSlots)
    self:RefreshSelection()
end

function Class.ExitSelectionMode(self)
    --[[
      name: ExitSelectionMode
      line: 390
    ]]
    self.selectionMode = false

    if self.navContext then
        self.navContext.Enabled = false
    end

    if self.scrollHighlightDirection ~= "none" then
        self.scrollHighlightDirection = "none"

        if self.created then
            self:CreateButtons()
        end
    end

    if self.activeButton then
        self.activeButton:SetSelectionPressed(false)
        self.activeButton = nil
    end

    self.activeActionSlot = nil

    if self.selectionRing then
        self.selectionRing.Parent = nil
    end
end

function Class.MoveSelection(self, a74)
    --[[
      name: MoveSelection
      line: 414
      upvalues:
        InputSlots (copy, index: 1)
    ]]
    if not self.selectionMode then
        return
    end
    if self.activeActionSlot then
        return
    end
    if a74 == "none" then
        return
    end

    local v75 = a74 ~= "previous" and -1 or 1
    local v76 = math.max(0, #InputSlots.GetAbilitiesInOverflow() - InputSlots.GetNumOverflowSlots())
    local overflowScrollIndex = InputSlots.getOverflowScrollIndex()
    local selectedVisibleSlot = self.selectedVisibleSlot + v75

    if not (selectedVisibleSlot < 1) then
        if self.numVisibleSlots < selectedVisibleSlot then
            if overflowScrollIndex < v76 then
                self.selectedVisibleSlot = self.numVisibleSlots
                InputSlots.setOverflowScrollIndex(overflowScrollIndex + 1)
            end
        else
            self.selectedVisibleSlot = selectedVisibleSlot
        end
    elseif 0 < overflowScrollIndex then
        self.selectedVisibleSlot = 1
        InputSlots.setOverflowScrollIndex(overflowScrollIndex - 1)
    end

    self:RefreshSelection()
end

function Class.RefreshSelection(self)
    --[[
      name: RefreshSelection
      line: 449
      upvalues:
        Class (copy, index: 1)
    ]]
    if Class.SupportsSelection() and self.selectionMode then
        if self.numVisibleSlots <= 0 then
            return
        end

        self.selectedVisibleSlot = math.clamp(self.selectedVisibleSlot, 1, self.numVisibleSlots)

        if const v80 = self.abilityButtonsByVisibleSlot[self.selectedVisibleSlot] then
            self:EnsureSelectionRing()
            self.selectionRing.Parent = v80.instance
            self.selectionRing.Visible = true
        end
    end
end

function Class.Teardown(self)
    --[[
      name: Teardown
      line: 466
    ]]
    self.connections:disconnectAll()
    self.created = false
    self:ExitSelectionMode()

    if self.inputFolder then
        self.inputFolder:Destroy()
        self.inputFolder = nil
        self.navContext = nil
    end

    if self.selectionRing then
        self.selectionRing:Destroy()
        self.selectionRing = nil
    end
end

function Class.CreateButtons(self)
    --[[
      name: CreateButtons
      line: 484
      upvalues:
        v6 (copy, index: 1)
        InputSlots (copy, index: 2)
        v9 (copy, index: 3)
        v10 (copy, index: 4)
        players (copy, index: 5)
        v11 (copy, index: 6)
        v12 (copy, index: 7)
        AbilityButton (copy, index: 8)
        Class (copy, index: 9)
    ]]
    if self.selectionRing then
        self.selectionRing.Parent = nil
    end

    for _, managedButton in self.managedButtons do
        managedButton:Destroy()
    end

    self.managedButtons = {}
    self.abilityButtonsByVisibleSlot = {}
    self.numVisibleSlots = 0

    if not v6:isEnabled() then
        return
    end

    local abilitiesInOverflow = InputSlots.GetAbilitiesInOverflow()
    local endIndex = math.min(#abilitiesInOverflow, InputSlots.GetNumOverflowSlots())
    local v87 = 0
    local v88 = 0
    local overflowScrollButton = nil
    local overflowScrollButton2 = nil
    local abilitiesInOverflowLength = #abilitiesInOverflow

    if InputSlots.GetNumOverflowSlots() < abilitiesInOverflowLength then
        local overflowScrollIndex = InputSlots.getOverflowScrollIndex()
        local v93 = #abilitiesInOverflow - InputSlots.GetNumOverflowSlots()

        if 0 < overflowScrollIndex then
            overflowScrollButton2 = self:CreateOverflowScrollButton("next")
            table.insert(self.managedButtons, overflowScrollButton2)
        end

        if overflowScrollIndex < v93 then
            overflowScrollButton = self:CreateOverflowScrollButton("previous")
            table.insert(self.managedButtons, overflowScrollButton)
        end

        v87 = v9[1] + 8
        v88 = v10[1] + 10
    end

    if self.scrollHighlightDirection == "previous" and overflowScrollButton then
        overflowScrollButton.Image = "rbxassetid://122643389561468"
    elseif self.scrollHighlightDirection == "next" and overflowScrollButton2 then
        overflowScrollButton2.Image = "rbxassetid://122643389561468"
    end

    for numVisibleSlots = 1, endIndex do
        local v95 = abilitiesInOverflow[numVisibleSlots + InputSlots.getOverflowScrollIndex()]
        local overflowAction = InputSlots.GetOverflowAction(numVisibleSlots)

        if v95 and overflowAction then
            local abilityConfig = v6:GetAbilityConfig(v95)
            local playerGui = players.LocalPlayer:FindFirstChildOfClass("PlayerGui")
            local v99 = not not (playerGui and playerGui.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait)
                and {small = {44, v11[1], v11[2] + v87 + ((numVisibleSlots - 1) * 52)}, large = {56, v12[1], v12[2] + v88 + ((numVisibleSlots - 1) * 66)}}
                or {small = {44, (v11[1] + v87) + ((numVisibleSlots - 1) * 52), v11[2]}, large = {56, (v12[1] + v88) + ((numVisibleSlots - 1) * 66), v12[2]}}
            local activeButton = AbilityButton.create(self, v95, abilityConfig, overflowAction, v99, true, true)
            table.insert(self.managedButtons, activeButton)
            self.abilityButtonsByVisibleSlot[numVisibleSlots] = activeButton
            self.numVisibleSlots = numVisibleSlots

            if numVisibleSlots == self.activeActionSlot then
                self.activeButton = activeButton
                activeButton:SetSelectionPressed(true)
            end
        end
    end

    self.parentUIFrame.Visible = true

    if self.selectionMode then
        if self.numVisibleSlots <= 0 then
            self:ExitSelectionMode()
            return
        end

        if Class.SupportsSelection() then
            self:RefreshSelection()
        end
    end
end

function Class.Create(self)
    --[[
      name: Create
      line: 586
      upvalues:
        InputSlots (copy, index: 1)
        v6 (copy, index: 2)
        userInputService (copy, index: 3)
        Class (copy, index: 4)
        guiService (copy, index: 5)
        players (copy, index: 6)
    ]]
    if not self.parentUIFrame then
        return
    end

    self:CreateButtons()

    self.connections:trackConnection(
        "SlotMapChanged",
        InputSlots.GetSlotMapChangedSignal():Connect(
            function()
                --[[
                  line: 595
                  upvalues:
                    self (copy, index: 1)
                ]]
                self:CreateButtons()
                self.selectedVisibleSlot = self.numVisibleSlots
                self:RefreshSelection()
            end
        )
    )

    self.connections:trackConnection(
        "AbilitiesEnabledChanged",
        v6:GetEnabledChangedSignal():Connect(
            function()
                --[[
                  line: 603
                  upvalues:
                    self (copy, index: 1)
                ]]
                self:CreateButtons()
            end
        )
    )
    self.connections:trackConnection(
        "ScrollIndexChanged",
        InputSlots.getScrollIndexChangedEvent():Connect(
            function()
                --[[
                  line: 609
                  upvalues:
                    self (copy, index: 1)
                ]]
                self:CreateButtons()
            end
        )
    )

    self.connections:trackConnection(
        "PreferredInput",
        userInputService:GetPropertyChangedSignal("PreferredInput"):Connect(
            function()
                --[[
                  line: 615
                  upvalues:
                    self (copy, index: 1)
                ]]
                self:UpdateInputMode()
                self:CreateButtons()
            end
        )
    )

    self.connections:trackConnection(
        "InputBegan",
        userInputService.InputBegan:Connect(
            function(input: InputObject, gameProcessedEvent: boolean)
                --[[
                  line: 623
                  upvalues:
                    self (copy, index: 1)
                    Class (copy, index: 2)
                ]]
                if gameProcessedEvent then
                    return
                end
                if not self.enabled then
                    return
                end

                local v104 = Class.IsGamepad() and input.KeyCode == Enum.KeyCode.DPadUp
                    or Class.IsKeyboardMouse() and input.KeyCode == Enum.KeyCode.M
                if not v104 then
                    return
                end

                if self.selectionMode then
                    self:ExitSelectionMode()
                    return
                end

                self:EnterSelectionMode()
            end
        )
    )

    self.connections:trackConnection(
        "MenuOpened",
        guiService.MenuOpened:Connect(
            function()
                --[[
                  line: 645
                  upvalues:
                    self (copy, index: 1)
                ]]
                if self.selectionMode then
                    self:ExitSelectionMode()
                end
            end
        )
    )

    if const playerGui = players.LocalPlayer:WaitForChild("PlayerGui", 5) then
        self.connections:trackConnection(
            "ScreenOrientation",
            playerGui:GetPropertyChangedSignal("CurrentScreenOrientation"):Connect(
                function()
                    --[[
                      line: 656
                      upvalues:
                        self (copy, index: 1)
                    ]]
                    self:CreateButtons()
                end
            )
        )
    end

    self.parentUIFrame.Destroying:Connect(
        function()
            --[[
              line: 662
              upvalues:
                self (copy, index: 1)
            ]]
            self:Teardown()
        end
    )
    self:UpdateInputMode()
end

return Class