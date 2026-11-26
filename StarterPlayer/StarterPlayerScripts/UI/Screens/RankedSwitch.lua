return {
    Init = (function(a1)
        --[[
          name: Init
          line: 10
        ]]
        local ui = a1.UI
        local theme = a1.Theme
        local state = a1.State
        local colors = theme.Colors
        local fonts = theme.Fonts
        local udim2FromOffset = UDim2.fromOffset
        local SettingsStore = require(script.Parent.Parent:WaitForChild("SettingsStore"))
        local lobbyHud = a1.LobbyHud

        if not lobbyHud or not lobbyHud.PlayButton then
            return
        end

        local instance = lobbyHud.PlayButton.Instance
        local parent = ui.new("TextButton", {Name = "RankedSwitch", Size = udim2FromOffset(300, 50), AutoButtonColor = false, Text = "", BackgroundColor3 = colors.Panel, BackgroundTransparency = 0.18, Visible = false, (ui.Corner(14)), Parent = lobbyHud.Root})
        local v12 = ui.Stroke(colors.Stroke, 1, 0.86)
        v12.Parent = parent
        local RankArt = require(script.Parent.Parent:WaitForChild("RankArt"))
        local v14 = RankArt.Trophy(26, {AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 12, 0.5, 0), Parent = parent})
        local ui2 = ui.new("TextLabel", {Name = "Title", Text = "RANKED", TextSize = 18, Position = udim2FromOffset(48, 7), Size = UDim2.new(1, -128, 0, 20), FontFace = fonts.Heavy, TextColor3 = colors.Text, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent})
        local ui3 = ui.new("TextLabel", {Name = "Desc", Text = "", TextSize = 13, Position = udim2FromOffset(48, 27), Size = UDim2.new(1, -128, 0, 16), FontFace = fonts.SemiBold, TextColor3 = colors.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = parent})
        local v17 = ui.Switch({Width = 56, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -14, 0.5, 0), Parent = parent})

        local function ranked()
            --[[
              name: ranked
              line: 64
              upvalues:
                SettingsStore (copy, index: 1)
            ]]
            return 0.5 < SettingsStore.Get("mmRanked")
        end

        local function paint(a20: boolean?)
            --[[
              name: paint
              line: 67
              upvalues:
                SettingsStore (copy, index: 1)
                ui2 (copy, index: 2)
                colors (copy, index: 3)
                ui3 (copy, index: 4)
                v12 (copy, index: 5)
                v14 (copy, index: 6)
                v17 (copy, index: 7)
            ]]
            local v21 = 0.5 < SettingsStore.Get("mmRanked")
            ui2.Text = v21 and "RANKED" or "UNRANKED"
            ui2.TextColor3 = if v21 then colors.Text else colors.TextDim
            ui3.Text = v21 and "Win or lose trophies" or "No trophies at stake"
            v12.Color = if v21 then colors.Accent else colors.Stroke
            v12.Transparency = v21 and 0.55 or 0.86
            local v22 = {v14, unpack(v14:GetDescendants())}

            for _, v24 in v22 do
                if v24:IsA("ImageLabel") then
                    v24.ImageTransparency = v21 and 0 or 0.6
                elseif v24:IsA("TextLabel") then
                    v24.TextTransparency = v21 and 0 or 0.6
                end
            end

            v17:Set(v21, a20)
        end

        parent.Activated:Connect(
            function()
                --[[
                  line: 83
                  upvalues:
                    a1 (copy, index: 1)
                    SettingsStore (copy, index: 2)
                    paint (copy, index: 3)
                    ui (copy, index: 4)
                    parent (copy, index: 5)
                ]]
                a1.Sounds.Play("Click")
                local set = SettingsStore.Set
                local v26 = 0.5 < SettingsStore.Get("mmRanked") and 0 or 1
                set("mmRanked", v26, "now")
                paint()
                ui.Pop(parent, 0.96)
            end
        )

        SettingsStore.Changed:Connect(
            function(a27)
                --[[
                  line: 89
                  upvalues:
                    paint (copy, index: 1)
                ]]
                if a27 == "mmRanked" then
                    paint()
                end
            end
        )

        paint(true)

        local function played()
            --[[
              name: played
              line: 96
              upvalues:
                state (copy, index: 1)
            ]]
            local stats = state.Profile and state.Profile.stats
            return type(stats) == "table" and type(stats.matches) == "number" and 1 <= stats.matches
        end

        local function place()
            --[[
              name: place
              line: 100
              upvalues:
                lobbyHud (copy, index: 1)
                instance (copy, index: 2)
                parent (copy, index: 3)
                udim2FromOffset (copy, index: 4)
                ui (copy, index: 5)
                state (copy, index: 6)
            ]]
            local v31 = 1
            local v32 = lobbyHud.Root

            while v32 and not v32:IsA("ScreenGui") do
                if const uiScale = v32:FindFirstChildOfClass("UIScale") then
                    v31 *= uiScale.Scale
                end

                v32 = v32.Parent
            end

            if v31 <= 0.01 then
                v31 = 1
            end

            local absolutePosition = lobbyHud.Root.AbsolutePosition
            local absolutePosition2 = instance.AbsolutePosition
            local absoluteSize = instance.AbsoluteSize
            local offset = instance.Size.X.Offset
            local offset2 = instance.Size.Y.Offset
            local v39 = (absolutePosition2.X + (absoluteSize.X / 2) - absolutePosition.X) / v31 - offset / 2
            local v40 = (absolutePosition2.Y + (absoluteSize.Y / 2) - absolutePosition.Y) / v31 - offset2 / 2
            parent.Size = udim2FromOffset(offset, 50)
            parent.Position = if ui.Compact == true then udim2FromOffset(v39, (v40 + offset2) + 26) else udim2FromOffset(v39, (v40 - 12) - 50)
            local v41 = instance.Visible
            if v41 then
                local stats = state.Profile and state.Profile.stats
                v41 = type(stats) == "table" and type(stats.matches) == "number" and 1 <= stats.matches
            end

            parent.Visible = v41
        end

        for _, v44 in {"AbsolutePosition", "AbsoluteSize", "Visible"} do
            instance:GetPropertyChangedSignal(v44):Connect(place)
        end

        lobbyHud.Root:GetPropertyChangedSignal("AbsoluteSize"):Connect(place)
        ui.LayoutChanged:Connect(place)
        state.ProfileChanged:Connect(place)
        place()
    end)
}