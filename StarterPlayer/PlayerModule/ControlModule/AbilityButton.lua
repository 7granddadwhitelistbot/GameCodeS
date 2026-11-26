local players = game:GetService("Players")
local CommonUtils = require(script.Parent.Parent:WaitForChild("CommonUtils"))
local v3 = CommonUtils.get("FlagUtil")
local userFlag = v3.getUserFlag("UserAbilitiesUserInterfaceD")
local AvatarAbilitiesInterface = require(script.Parent:WaitForChild("AvatarAbilitiesInterface"))
local v6 = AvatarAbilitiesInterface.get(players.LocalPlayer)

return {
    create = (function(a7, a8, a9, parent: Instance?, a11, a12, a13)
        --[[
          name: create
          line: 30
          upvalues:
            userFlag (copy, index: 1)
            v6 (copy, index: 2)
        ]]
        local UpdateButtonState
        local buttonInvalidAssetId
        local buttonAssetId = "rbxassetid://136780077406114"
        local buttonPressedAssetId = "rbxassetid://76895455502876"
        local v18 = false
        local v19 = false

        if a9.ButtonAssetId then
            buttonAssetId = a9.ButtonAssetId
        end

        if a9.ButtonPressedAssetId then
            buttonPressedAssetId = a9.ButtonPressedAssetId
        end

        if a9.ButtonInvalidAssetId then
            buttonInvalidAssetId = a9.ButtonInvalidAssetId
        else
            buttonInvalidAssetId = nil
        end

        local uiButton = Instance.new("ImageButton")
        uiButton.Name = a8 .. "Button"
        uiButton.Visible = false
        uiButton.BackgroundTransparency = 1
        uiButton.Image = buttonAssetId
        uiButton.Parent = a7.parentUIFrame

        for _, child in parent:GetChildren() do
            if string.find(child.Name, "Touch") and child:IsA("InputBinding") then
                child.UIButton = uiButton
                break
            end
        end

        local function ResizeButton()
            --[[
              name: ResizeButton
              line: 60
              upvalues:
                a7 (copy, index: 1)
                a11 (copy, index: 2)
                uiButton (copy, index: 3)
                a12 (copy, index: 4)
            ]]
            local v24 = math.min(a7.parentUIFrame.AbsoluteSize.x, a7.parentUIFrame.AbsoluteSize.y) <= 500
                and a11.small
                or a11.large
            local v25 = v24[1]
            local v26 = v24[2]
            local v27 = v24[3]
            local v28 = -v26 - v25
            uiButton.Size = UDim2.new(0, v25, 0, v25)

            if a12 then
                uiButton.Position = UDim2.new(1, v28, 0, v27)
                return
            end

            local v29 = -v27 - v25
            uiButton.Position = UDim2.new(1, v28, 1, v29)
        end

        ResizeButton()
        local v30 = {}
        table.insert(v30, a7.parentUIFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(ResizeButton))

        UpdateButtonState = function()
            --[[
              name: UpdateButtonState
              line: 87
              upvalues:
                uiButton (copy, index: 1)
                userFlag (copy, index: 2)
                v6 (copy, index: 3)
                a8 (copy, index: 4)
                v18 (ref,  index: 5)
                v19 (ref,  index: 6)
                a7 (copy, index: 7)
                parent (copy, index: 8)
                a13 (copy, index: 9)
                buttonInvalidAssetId (ref,  index: 10)
                buttonAssetId (ref,  index: 11)
                buttonPressedAssetId (ref,  index: 12)
            ]]
            if uiButton.Parent == nil then
                return
            end

            if userFlag then
                local abilityUiState = v6:GetAbilityUIState(a8)
                local v32 = v18 or v19
                local v33 = abilityUiState == 0
                uiButton.Visible = a7.enabled and parent.Enabled and (a13 or not v33)

                if uiButton.Visible then
                    if abilityUiState ~= 1 and not v33 then
                        if abilityUiState ~= 3 and not v32 then
                            uiButton.Image = buttonAssetId
                            uiButton.ImageTransparency = 0

                            return
                        end

                        uiButton.Image = buttonPressedAssetId
                        uiButton.ImageTransparency = 0

                        return
                    end

                    if buttonInvalidAssetId then
                        uiButton.Image = buttonInvalidAssetId
                        uiButton.ImageTransparency = 0

                        return
                    end

                    uiButton.Image = buttonAssetId
                    uiButton.ImageTransparency = 0.6
                end
            else
                local abilityValid = v6:GetAbilityValid(a8)
                local abilityActive = v6:GetAbilityActive(a8)
                local v36 = v18 or v19
                uiButton.Visible = a7.enabled and parent.Enabled

                if uiButton.Visible then
                    if abilityActive or v36 and abilityValid then
                        uiButton.Image = buttonPressedAssetId
                        uiButton.ImageTransparency = 0

                        return
                    end

                    if abilityValid then
                        uiButton.Image = buttonAssetId
                        uiButton.ImageTransparency = 0

                        return
                    end

                    if buttonInvalidAssetId then
                        uiButton.Image = buttonInvalidAssetId
                        uiButton.ImageTransparency = 0

                        return
                    end

                    uiButton.Image = buttonAssetId
                    uiButton.ImageTransparency = 0.6
                end
            end
        end

        UpdateButtonState()

        local function FireSelectionActivation(a38)
            --[[
              name: FireSelectionActivation
              line: 141
              upvalues:
                parent (copy, index: 1)
            ]]
            local selectionActivateBinding = parent:FindFirstChild("SelectionActivateBinding")
            if not selectionActivateBinding then
                selectionActivateBinding = Instance.new("InputBinding")
                selectionActivateBinding.Name = "SelectionActivateBinding"
                selectionActivateBinding.Type = Enum.InputBindingType.Scriptable
                selectionActivateBinding.Parent = parent
            end

            selectionActivateBinding:Fire(a38)
        end

        uiButton.MouseButton1Down:Connect(
            function()
                --[[
                  line: 152
                  upvalues:
                    v18 (ref,  index: 1)
                    UpdateButtonState (copy, index: 2)
                ]]
                v18 = true
                UpdateButtonState()
            end
        )

        uiButton.MouseButton1Up:Connect(
            function()
                --[[
                  line: 157
                  upvalues:
                    v18 (ref,  index: 1)
                    UpdateButtonState (copy, index: 2)
                ]]
                v18 = false
                UpdateButtonState()
            end
        )

        uiButton.MouseLeave:Connect(
            function()
                --[[
                  line: 162
                  upvalues:
                    v18 (ref,  index: 1)
                    UpdateButtonState (copy, index: 2)
                ]]
                v18 = false
                UpdateButtonState()
            end
        )

        if userFlag then
            table.insert(v30, v6:GetAbilityUIStateChangedSignal(a8):Connect(UpdateButtonState))
        else
            table.insert(v30, v6:GetAbilityActiveChangedSignal(a8):Connect(UpdateButtonState))
            table.insert(v30, v6:GetAbilityValidChangedSignal(a8):Connect(UpdateButtonState))
        end

        table.insert(v30, a7.enabledChangedEvent.Event:Connect(UpdateButtonState))
        table.insert(v30, parent:GetPropertyChangedSignal("Enabled"):Connect(UpdateButtonState))

        uiButton.Destroying:Connect(
            function()
                --[[
                  line: 185
                  upvalues:
                    v30 (copy, index: 1)
                ]]
                for _, v41 in v30 do
                    v41:Disconnect()
                end

                table.clear(v30)
            end
        )

        return {
            instance = uiButton,
            Destroy = (function(a42)
                --[[
                  name: Destroy
                  line: 196
                  upvalues:
                    uiButton (copy, index: 1)
                ]]
                uiButton:Destroy()
            end),
            SetSelectionPressed = (function(a43, a44)
                --[[
                  name: SetSelectionPressed
                  line: 200
                  upvalues:
                    v19 (ref,  index: 1)
                    parent (copy, index: 2)
                    UpdateButtonState (copy, index: 3)
                ]]
                if v19 == a44 then
                    return
                end

                v19 = a44
                local selectionActivateBinding = parent:FindFirstChild("SelectionActivateBinding")
                if not selectionActivateBinding then
                    selectionActivateBinding = Instance.new("InputBinding")
                    selectionActivateBinding.Name = "SelectionActivateBinding"
                    selectionActivateBinding.Type = Enum.InputBindingType.Scriptable
                    selectionActivateBinding.Parent = parent
                end

                selectionActivateBinding:Fire(a44)
                UpdateButtonState()
            end)
        }
    end)
}