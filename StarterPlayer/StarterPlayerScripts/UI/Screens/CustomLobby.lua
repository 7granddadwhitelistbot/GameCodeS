local proximityPromptService = game:GetService("ProximityPromptService")
game:GetService("UserInputService")
game:GetService("GuiService")
local CustomMatch = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("CustomMatch"))

return {
    Init = (function(a3)
        --[[
          name: Init
          line: 34
          upvalues:
            CustomMatch (copy, index: 1)
            proximityPromptService (copy, index: 2)
        ]]
        local ui = a3.UI
        local theme = a3.Theme
        local state = a3.State
        local colors = theme.Colors
        local fonts = theme.Fonts
        local custom = a3.Custom
        local udim2FromOffset = UDim2.fromOffset
        local hasRun = false
        local parent = nil
        local ui2 = nil
        local ui3 = nil
        local parent2 = nil
        local ui4 = nil
        local ui5 = nil
        local v18 = nil
        local v19 = nil
        local v20 = nil
        local ui6 = nil
        local parent3 = nil
        local ui7 = nil

        local function placeLock()
            --[[
              name: placeLock
              line: 46
              upvalues:
                v18 (ref, index: 1)
                ui3 (ref, index: 2)
                v19 (ref, index: 3)
            ]]
            if v18 and ui3 and v19 then
                local v25 = ui3.Position.Y.Offset + ui3.Size.Y.Offset / 2
                v19.Position = UDim2.new(1, ui3.Position.X.Offset, 0, v25)
                local v26 = if v19.Visible then v19.Size.X.Offset else ui3.TextBounds.X
                v18.Position = UDim2.new(1, (ui3.Position.X.Offset - v26) - 7, 0, v25)
            end
        end

        local v27 = nil
        local v28 = nil
        local v29 = nil
        local isBusy = false
        local ui8 = nil

        local function closeConfirm()
            --[[
              name: closeConfirm
              line: 59
              upvalues:
                ui8 (ref,  index: 1)
                a3 (copy, index: 2)
            ]]
            if ui8 then
                ui8.Visible = false
            end

            a3.MenuManager.PopMouse("CustomLeave")
            a3.MenuManager.PopFocus("CustomLeave")
        end

        local function leave()
            --[[
              name: leave
              line: 66
              upvalues:
                ui8 (ref,  index: 1)
                a3 (copy, index: 2)
                custom (copy, index: 3)
            ]]
            if ui8 then
                ui8.Visible = false
            end

            a3.MenuManager.PopMouse("CustomLeave")
            a3.MenuManager.PopFocus("CustomLeave")

            task.spawn(
                function()
                    --[[
                      line: 68
                      upvalues:
                        custom (copy, index: 1)
                        a3 (copy, index: 2)
                    ]]
                    local v34, v35 = custom.Action("Leave")
                    if not v34 then
                        a3.Toast(tostring(v35), "error")
                    end
                end
            )
        end

        local function openConfirm()
            --[[
              name: openConfirm
              line: 75
              upvalues:
                ui8 (ref,  index: 1)
                ui (copy, index: 2)
                colors (copy, index: 3)
                a3 (copy, index: 4)
                closeConfirm (copy, index: 5)
                udim2FromOffset (copy, index: 6)
                fonts (copy, index: 7)
                leave (copy, index: 8)
            ]]
            if not ui8 then
                local parent = ui.new("TextButton", {Name = "CustomLeaveConfirm", BackgroundTransparency = 0.45, Text = "", AutoButtonColor = false, Selectable = false, ZIndex = 50, Visible = false, Size = UDim2.fromScale(1, 1), BackgroundColor3 = colors.Void, Parent = a3.Canvas.Overlay})
                parent.Activated:Connect(closeConfirm)
                local parent2 = ui.Panel({Name = "Card", BackgroundTransparency = 0.02, ZIndex = 51, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = udim2FromOffset(480, 256), Radius = UDim.new(0, 16), Parent = parent})
                ui.DropShadow(parent2, 16, 8, 0.5)
                ui.new("TextButton", {Name = "Sink", BackgroundTransparency = 1, Text = "", Selectable = false, ZIndex = 52, Size = UDim2.fromScale(1, 1), Parent = parent2})
                ui.DisplayText({Name = "Title", Text = "LEAVE CUSTOM MATCH?", TextSize = 32, ZIndex = 53, Position = udim2FromOffset(0, 24), Size = UDim2.new(1, 0, 0, 40), TextColor3 = colors.Text, Parent = parent2})
                ui.new("TextLabel", {Name = "Body", Text = "You'll go back to a public lobby. You can come back with the code while there's room.", TextSize = 19, TextWrapped = true, ZIndex = 53, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 74), Size = UDim2.new(1, -56, 0, 74), FontFace = fonts.Bold, TextColor3 = colors.TextDim, Parent = parent2})
                local v39 = ui.Button({Name = "Stay", Text = "STAY", TextSize = 21, Style = "Dark", ZIndex = 54, AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 28, 1, -24), Size = udim2FromOffset(200, 58), Parent = parent2})
                local v40 = ui.Button({Name = "Leave", Text = "LEAVE", TextSize = 21, Style = "Danger", ZIndex = 54, AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -28, 1, -24), Size = udim2FromOffset(200, 58), Parent = parent2})
                v39.Activated:Connect(closeConfirm)
                v40.Activated:Connect(leave)
                ui8 = parent
            end

            local ui2 = ui8
            ui2.Visible = true
            ui.Enter(ui2:FindFirstChild("Card"), Vector2.new(0, 16), 0, UDim2.fromScale(0.5, 0.5))
            a3.Sounds.Play("Open")
            a3.MenuManager.PushMouse("CustomLeave")

            a3.MenuManager.PushFocus(
                "CustomLeave",
                function()
                    --[[
                      line: 129
                      upvalues:
                        ui2 (copy, index: 1)
                    ]]
                    local v42 = ui2:FindFirstChild("Card")
                    v42 = v42 and v42:FindFirstChild("Stay")

                    return v42 or nil
                end,
                function()
                    --[[
                      line: 133
                      upvalues:
                        ui8 (ref,  index: 1)
                        a3 (copy, index: 2)
                    ]]
                    if ui8 then
                        ui8.Visible = false
                    end

                    a3.MenuManager.PopMouse("CustomLeave")
                    a3.MenuManager.PopFocus("CustomLeave")

                    return true
                end
            )
        end

        local function build()
            --[[
              name: build
              line: 140
              upvalues:
                hasRun (ref,  index: 1)
                a3 (copy, index: 2)
                parent (ref,  index: 3)
                ui (copy, index: 4)
                ui2 (ref,  index: 5)
                fonts (copy, index: 6)
                colors (copy, index: 7)
                ui3 (ref,  index: 8)
                v19 (ref,  index: 9)
                custom (copy, index: 10)
                v18 (ref,  index: 11)
                placeLock (copy, index: 12)
                v20 (ref,  index: 13)
                parent3 (ref,  index: 14)
                udim2FromOffset (copy, index: 15)
                theme (copy, index: 16)
                ui7 (ref,  index: 17)
                parent2 (ref,  index: 18)
                ui4 (ref,  index: 19)
                ui5 (ref,  index: 20)
                ui6 (ref,  index: 21)
                v27 (ref,  index: 22)
                v28 (ref,  index: 23)
                v29 (ref,  index: 24)
                isBusy (ref,  index: 25)
                openConfirm (copy, index: 26)
            ]]
            if hasRun then
                return
            end

            hasRun = true
            local v44 = if a3.LobbyHud then a3.LobbyHud.Root else a3.Canvas.HUD
            parent = ui.Panel({Name = "CustomMatchCard", BackgroundTransparency = 0.12, StrokeTransparency = 0.82, Visible = false, Radius = UDim.new(0, 16), Parent = v44})
            ui2 = ui.new("TextLabel", {Name = "Cap", Text = "CUSTOM MATCH", FontFace = fonts.Heavy, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent})
            ui3 = ui.new("TextLabel", {Name = "Code", Text = "", AnchorPoint = Vector2.new(1, 0), FontFace = fonts.Display, TextColor3 = colors.Accent, TextXAlignment = Enum.TextXAlignment.Right, Parent = parent})
            v19 = custom.MaskDots({Name = "Mask", Dot = 7, Gap = 4, GroupGap = 9, Color = colors.TextDim, AnchorPoint = Vector2.new(1, 0.5), Parent = parent})
            v19.Visible = false
            v18 = ui.Glyph("lock-closed", 15, colors.TextDim, {Name = "Lock", AnchorPoint = Vector2.new(1, 0.5), Parent = parent})
            v18.Visible = false
            ui3:GetPropertyChangedSignal("TextBounds"):Connect(
                function()
                    --[[
                      line: 176
                      upvalues:
                        placeLock (copy, index: 1)
                    ]]
                    placeLock()
                end
            )
            v20 = ui.Icon("chevRight", 18, colors.TextDim, {Name = "Open", AnchorPoint = Vector2.new(1, 0.5), Parent = parent})
            parent3 = ui.new("Frame", {Name = "Mode", AnchorPoint = Vector2.new(1, 0.5), Size = udim2FromOffset(50, 22), BackgroundColor3 = colors.Raised, (ui.Corner(theme.Radius.Pill)), Parent = parent})
            ui7 = ui.new("TextLabel", {Name = "Text", Text = "3V3", TextSize = 15, Size = UDim2.fromScale(1, 1), FontFace = fonts.Heavy, TextColor3 = colors.TextDim, Parent = parent3})
            a3.Loc.Fit(ui7, 11, 0.1)
            parent2 = ui.new("TextLabel", {Name = "ServerName", Text = "", FontFace = fonts.Heavy, TextColor3 = colors.Text, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = parent})
            ui.TextStroke(colors.Void, 1.5, 0.4).Parent = parent2
            ui4 = ui.new("Frame", {Name = "Dot", AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = colors.Success, (ui.Corner(theme.Radius.Pill)), Parent = parent})
            ui5 = ui.new("TextLabel", {Name = "Status", Text = "", FontFace = fonts.SemiBold, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = parent})
            ui6 = ui.new("TextButton", {Name = "Open", BackgroundTransparency = 1, Text = "", AutoButtonColor = false, ZIndex = 6, Size = UDim2.fromScale(1, 1), Parent = parent})
            local uiStroke = parent:FindFirstChildOfClass("UIStroke")
            local transparency = uiStroke.Transparency
            local color = uiStroke.Color
            local v48 = false

            local function paintHover(a50: boolean?)
                --[[
                  name: paintHover
                  line: 233
                  upvalues:
                    ui (copy, index: 1)
                    uiStroke (copy, index: 2)
                    theme (copy, index: 3)
                    v48 (ref,  index: 4)
                    colors (copy, index: 5)
                    color (copy, index: 6)
                    transparency (copy, index: 7)
                    parent (ref,  index: 8)
                ]]
                local tween = ui.Tween
                local fast = theme.Tween.Fast
                local v53 = {Color = if not v48 and not a50 then color else colors.Accent}
                v53.Transparency = a50 and 0.1 or v48 and 0.35 or transparency
                tween(uiStroke, fast, v53)
                local tween2 = ui.Tween
                local v55 = parent
                local fast2 = theme.Tween.Fast
                local v57 = {}
                v57.BackgroundTransparency = a50 and 0.2 or v48 and 0.04 or 0.12
                tween2(v55, fast2, v57)
            end

            ui6.MouseEnter:Connect(
                function()
                    --[[
                      line: 240
                      upvalues:
                        v48 (ref,  index: 1)
                        ui (copy, index: 2)
                        a3 (copy, index: 3)
                        paintHover (copy, index: 4)
                    ]]
                    v48 = true

                    if not ui.Touch then
                        a3.Sounds.Play("Hover")
                    end

                    paintHover()
                end
            )

            ui6.MouseLeave:Connect(
                function()
                    --[[
                      line: 247
                      upvalues:
                        v48 (ref,  index: 1)
                        paintHover (copy, index: 2)
                    ]]
                    v48 = false
                    paintHover()
                end
            )

            ui6.MouseButton1Down:Connect(
                function()
                    --[[
                      line: 251
                      upvalues:
                        paintHover (copy, index: 1)
                    ]]
                    paintHover(true)
                end
            )
            ui6.MouseButton1Up:Connect(
                function()
                    --[[
                      line: 254
                      upvalues:
                        paintHover (copy, index: 1)
                    ]]
                    paintHover()
                end
            )

            ui6.Activated:Connect(
                function()
                    --[[
                      line: 257
                      upvalues:
                        v48 (ref,  index: 1)
                        paintHover (copy, index: 2)
                        a3 (copy, index: 3)
                    ]]
                    v48 = false
                    paintHover()
                    a3.Sounds.Play("Click")
                    a3.MenuManager.Toggle("CustomHost")
                end
            )

            v27 = ui.Button(
                {
                    Name = "CustomStart",
                    Text = "START MATCH",
                    Style = "Primary",
                    Visible = false,
                    Icon = ui.Glyph("play-large", 22, colors.Text),
                    Parent = v44,
                    OnDisabledClick = (function()
                        --[[
                          name: OnDisabledClick
                          line: 272
                          upvalues:
                            custom (copy, index: 1)
                            a3 (copy, index: 2)
                        ]]
                        local v58 = custom.State()
                        local toast = a3.Toast
                        local startHint = v58 and v58.startHint ~= "" and v58.startHint or "Can't start yet"
                        toast(tostring(startHint), "info")
                    end)
                }
            )

            v28 = ui.Button({Name = "CustomLeave", Text = "LEAVE", Style = "Dark", Visible = false, Sound = false, Icon = ui.Glyph("door-open-arrow-to-bottom-right", 20, colors.TextDim), Parent = v44})
            v29 = ui.Button({Name = "CustomWatch", Text = "WATCH MATCH", Style = "Primary", Visible = false, Icon = ui.Glyph("eye", 22, colors.Text), Parent = v44})

            v29.Activated:Connect(
                function()
                    --[[
                      line: 294
                      upvalues:
                        isBusy (ref,  index: 1)
                        v29 (ref,  index: 2)
                        custom (copy, index: 3)
                        a3 (copy, index: 4)
                    ]]
                    if isBusy then
                        return
                    end

                    isBusy = true
                    v29:SetText("LOADING...")
                    local v61, v62 = custom.Action("Watch", true)
                    isBusy = false
                    v29:SetText("WATCH MATCH")

                    if v61 then
                        a3.Sounds.Play("Click")
                        return
                    end

                    a3.Toast(tostring(v62), "error")
                end
            )

            v27.Activated:Connect(
                function()
                    --[[
                      line: 309
                      upvalues:
                        isBusy (ref,  index: 1)
                        custom (copy, index: 2)
                        a3 (copy, index: 3)
                        ui (copy, index: 4)
                        v27 (ref,  index: 5)
                    ]]
                    if isBusy then
                        return
                    end

                    local v63 = custom.State()

                    if v63 and v63.canStart then
                        isBusy = true
                        v27:SetText("STARTING...")
                        local v64, v65 = custom.Host("Start")
                        isBusy = false
                        v27:SetText("START MATCH")

                        if v64 then
                            a3.Sounds.Play("Match_Found")
                            return
                        end

                        a3.Toast(tostring(v65), "error")

                        return
                    end

                    local toast = a3.Toast
                    local startHint = v63 and v63.startHint or "Can't start yet"
                    toast(tostring(startHint), "info")
                    ui.Shake(v27.Instance, 5)
                end
            )

            v28.Activated:Connect(
                function()
                    --[[
                      line: 330
                      upvalues:
                        a3 (copy, index: 1)
                        openConfirm (copy, index: 2)
                    ]]
                    a3.Sounds.Play("Click")
                    openConfirm()
                end
            )
        end

        local function layout()
            --[[
              name: layout
              line: 336
              upvalues:
                hasRun (ref,  index: 1)
                a3 (copy, index: 2)
                ui (copy, index: 3)
                parent (ref,  index: 4)
                udim2FromOffset (copy, index: 5)
                ui2 (ref,  index: 6)
                ui3 (ref,  index: 7)
                parent2 (ref,  index: 8)
                v20 (ref,  index: 9)
                parent3 (ref,  index: 10)
                ui4 (ref,  index: 11)
                ui5 (ref,  index: 12)
                v27 (ref,  index: 13)
                v28 (ref,  index: 14)
                v29 (ref,  index: 15)
                placeLock (copy, index: 16)
            ]]
            if not hasRun then
                return
            end

            local playButton = a3.LobbyHud and a3.LobbyHud.PlayButton

            if ui.Compact then
                local v70

                if playButton then
                    v70 = playButton.Instance.Position.Y.Offset
                    v70 = udim2FromOffset
                else
                    v70 = ui.TopInset()
                    v70 = udim2FromOffset
                end

                parent.AnchorPoint = Vector2.new(1, 0)
                parent.Position = UDim2.new(1, -16, 0, v70)
                parent.Size = v70(272, 88)
                local ui6 = ui2
                ui2.Position, ui2.Size = v70(16, 10), v70(150, 16)
                ui6.TextSize = 13
                local ui7 = ui3
                ui3.Position, ui3.Size = UDim2.new(1, -16, 0, 7), v70(110, 22)
                ui7.TextSize = 20
                local ui8 = parent2
                parent2.Position, parent2.Size = v70(16, 29), v70(162, 26)
                ui8.TextSize = 21
                v20.Position = UDim2.new(1, -12, 0, 43)
                parent3.Position = UDim2.new(1, -36, 0, 43)
                ui4.Position, ui4.Size = v70(17, 69), v70(8, 8)
                local ui9 = ui5
                ui5.Position, ui5.Size = v70(31, 60), v70(228, 18)
                ui9.TextSize = 14

                for _, v76 in {v27, v28, v29} do
                    v76.Instance.AnchorPoint = Vector2.new(1, 0)
                    v76.Instance.Position = UDim2.new(1, -16, 0, v70 + 96)
                    v76.Instance.Size = v70(272, 52)
                    v76.Label.TextSize = 20
                end
            else
                parent.AnchorPoint = Vector2.new(1, 1)
                parent.Position = UDim2.new(1, -28, 1, -104)
                parent.Size = udim2FromOffset(300, 98)
                local ui10 = ui2
                ui2.Position, ui2.Size = udim2FromOffset(18, 12), udim2FromOffset(160, 16)
                ui10.TextSize = 13
                local ui11 = ui3
                ui3.Position, ui3.Size = UDim2.new(1, -18, 0, 9), udim2FromOffset(120, 22)
                ui11.TextSize = 21
                local ui12 = parent2
                parent2.Position, parent2.Size = udim2FromOffset(18, 32), udim2FromOffset(186, 28)
                ui12.TextSize = 23
                v20.Position = UDim2.new(1, -14, 0, 47)
                parent3.Position = UDim2.new(1, -38, 0, 47)
                ui4.Position, ui4.Size = udim2FromOffset(19, 76), udim2FromOffset(8, 8)
                local ui13 = ui5
                ui5.Position, ui5.Size = udim2FromOffset(33, 67), udim2FromOffset(252, 18)
                ui13.TextSize = 15

                for _, v82 in {v27, v28, v29} do
                    v82.Instance.AnchorPoint = Vector2.new(1, 1)
                    v82.Instance.Position = UDim2.new(1, -28, 1, -40)
                    v82.Instance.Size = udim2FromOffset(300, 54)
                    v82.Label.TextSize = 22
                end
            end

            placeLock()
        end

        local isHost = false
        local status = ""
        local v85 = false
        local v86 = false

        local function paint()
            --[[
              name: paint
              line: 385
              upvalues:
                custom (copy, index: 1)
                a3 (copy, index: 2)
                hasRun (ref,  index: 3)
                parent (ref,  index: 4)
                v27 (ref,  index: 5)
                v28 (ref,  index: 6)
                v29 (ref,  index: 7)
                isHost (ref,  index: 8)
                build (copy, index: 9)
                layout (copy, index: 10)
                v85 (ref,  index: 11)
                ui (copy, index: 12)
                v86 (ref,  index: 13)
                ui3 (ref,  index: 14)
                CustomMatch (copy, index: 15)
                v19 (ref,  index: 16)
                v18 (ref,  index: 17)
                placeLock (copy, index: 18)
                parent2 (ref,  index: 19)
                ui7 (ref,  index: 20)
                status (ref,  index: 21)
                parent3 (ref,  index: 22)
                theme (copy, index: 23)
                colors (copy, index: 24)
                ui5 (ref,  index: 25)
                ui4 (ref,  index: 26)
                isBusy (ref,  index: 27)
            ]]
            local isServer = custom.IsServer()

            if a3.LobbyHud and a3.LobbyHud.SetPlayHidden then
                a3.LobbyHud.SetPlayHidden("Custom", isServer)
            end

            local isHost2 = isServer and custom.IsHost()

            if a3.TopbarSettings and a3.TopbarSettings.SetHostVisible then
                a3.TopbarSettings.SetHostVisible(isHost2)
            end

            if not isServer then
                if hasRun then
                    parent.Visible = false
                    v27.Instance.Visible = false
                    v28.Instance.Visible = false
                    v29.Instance.Visible = false
                end

                isHost = false

                return
            end

            local v90
            local v91
            local v92, v93
            build()
            layout()
            local v94 = custom.State() or {}
            parent.Visible = true
            local playing = false
            local v96 = 0

            if type(v94.players) ~= "table" then
                v90 = {}
            else
                v90 = v94.players
            end

            for _, v98 in v90 do
                if type(v98) == "table" and v98.userId == a3.Player.UserId then
                    playing = v98.playing == true
                    v96 = v98.team ~= 1 and v98.team ~= 2 and 0 or v98.team
                end
            end

            local visible = v94.status == "Match" and not playing
            local instance = v27.Instance
            instance.Visible = isHost2 and not visible
            local instance2 = v28.Instance
            instance2.Visible = not isHost2 and not visible
            v29.Instance.Visible = visible

            if visible and not v85 then
                ui.Enter(v29.Instance, Vector2.new(0, 12), 0.05, v29.Instance.Position)
            end

            if not v86 and type(v94.status) == "string" then
                v86 = true

                if visible then
                    a3.Toast("A match is in progress. Watch it while you wait for the next one.", "info")
                end
            end

            v85 = visible
            local visible2 = custom.IsPrivate() and not custom.IsRevealed()
            ui3.Text = CustomMatch.FormatCode(custom.Code())
            ui3.Visible = not visible2
            v19.Visible = visible2
            v18.Visible = custom.IsPrivate()
            placeLock()
            parent2.AutoLocalize = false
            parent2.Text = tostring((v94.name or "Custom match"))
            local v103 = CustomMatch.Mode(v94.mode) == "1v1"
            local text = CustomMatch.ModeLabel(v94.mode)

            if ui7.Text ~= text then
                ui7.Text = text

                if status ~= "" then
                    ui.Pop(parent3, 0.8, theme.Tween.PopSmall)
                end
            end

            parent3.BackgroundColor3 = if v103 then colors.Accent else colors.Raised
            ui7.TextColor3 = if v103 then colors.Text else colors.TextDim

            if type(v94.players) ~= "table" then
                v91 = 0
            else
                v91 = #v94.players
            end

            local v105 = tonumber(v94.max) or CustomMatch.MAX_PLAYERS
            local status2 = v94.status or "Lobby"

            if status2 == "Match" then
                v92 = string.format("Match in progress  ·  %d/%d", v91, v105)
                v93 = colors.Warning
            elseif status2 == "Results" then
                v92 = "Showing the results"
                v93 = colors.Accent
            elseif isHost2 and v94.canStart ~= true and type(v94.startHint) == "string" and v94.startHint ~= "" then
                v92 = v94.startHint
                v93 = colors.Warning
            elseif isHost2 then
                v92 = string.format("You're the host  ·  %s", (tostring(v94.mapName or "Random")))
                v93 = colors.Success
            elseif v96 == 0 then
                v92 = string.format("Waiting for the host  ·  %d/%d", v91, v105)
                v93 = colors.Success
            else
                v92 = string.format("Team %d  ·  Waiting for the host", v96)
                v93 = colors.Success
            end

            ui5.Text = v92
            ui4.BackgroundColor3 = v93
            v27:SetEnabled(v94.canStart == true and not isBusy)

            if isHost2 and not isHost then
                ui.Enter(v27.Instance, Vector2.new(0, 12), 0.05, v27.Instance.Position)
            end

            if status2 ~= status then
                status = status2
                ui.Pop(ui4, 1.8)
            end

            isHost = isHost2
        end

        custom.Changed:Connect(paint)
        custom.RevealChanged:Connect(paint)
        ui.LayoutChanged:Connect(
            function()
                --[[
                  line: 480
                  upvalues:
                    layout (copy, index: 1)
                ]]
                layout()
            end
        )

        if a3.LobbyHud and a3.LobbyHud.PlayButton then
            a3.LobbyHud.PlayButton.Instance:GetPropertyChangedSignal("Position"):Connect(layout)
        end

        if a3.TopbarSettings and a3.TopbarSettings.HostActivated then
            a3.TopbarSettings.HostActivated:Connect(
                function()
                    --[[
                      line: 487
                      upvalues:
                        a3 (copy, index: 1)
                    ]]
                    a3.MenuManager.Toggle("CustomHost")
                end
            )
        end

        local userInputService = game:GetService("UserInputService")
        local Keybinds = require(game:GetService("ReplicatedStorage").Shared:WaitForChild("Keybinds"))

        Keybinds.OnInput(
            "Began",
            function(a109, a110)
                --[[
                  line: 497
                  upvalues:
                    userInputService (copy, index: 1)
                    custom (copy, index: 2)
                    Keybinds (copy, index: 3)
                    state (copy, index: 4)
                    a3 (copy, index: 5)
                ]]
                if a110 or userInputService:GetFocusedTextBox() or not custom.IsServer() then
                    return
                end

                local v111 = Keybinds.IsPad(a109, "CustomMenu")
                    and state.Get("State") ~= "Match"
                    and state.Get("CombatMode") ~= true
                    and (not Keybinds.PadBlocked() or a3.MenuManager.IsOpen("CustomHost"))

                if v111 or Keybinds.ActionOf(a109) == "CustomMenu" then
                    a3.MenuManager.Toggle("CustomHost")
                end
            end
        )

        task.spawn(
            function()
                --[[
                  line: 509
                  upvalues:
                    hasRun (ref,  index: 1)
                    parent (ref,  index: 2)
                    ui (copy, index: 3)
                    ui4 (ref,  index: 4)
                ]]
                while true do
                    task.wait(1.2)

                    if hasRun then
                        local backgroundTransparency

                        if not parent.Visible then
                            continue
                        end

                        local tween = ui.Tween
                        local ui2 = ui4
                        local tweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Sine)
                        local v116 = {}

                        if not (ui4.BackgroundTransparency < 0.3) then
                            backgroundTransparency = 0
                        else
                            backgroundTransparency = 0.55
                        end

                        v116.BackgroundTransparency = backgroundTransparency
                        tween(ui2, tweenInfo, v116)
                    end
                end
            end
        )

        paint()

        proximityPromptService.PromptShown:Connect(
            function(prompt: ProximityPrompt)
                --[[
                  line: 520
                  upvalues:
                    custom (copy, index: 1)
                ]]
                if prompt.Name == "CustomMatchesPrompt" and custom.IsServer() then
                    prompt.Enabled = false

                    task.spawn(
                        function()
                            --[[
                              line: 523
                              upvalues:
                                prompt (copy, index: 1)
                                custom (copy, index: 2)
                            ]]
                            while prompt.Parent do
                                if not custom.IsServer() then
                                    break
                                end

                                task.wait(2)
                            end

                            if prompt.Parent then
                                prompt.Enabled = true
                            end
                        end
                    )
                end
            end
        )

        a3.Debug.customLobby = function(a118)
            --[[
              line: 535
              upvalues:
                openConfirm (copy, index: 1)
                ui8 (ref,  index: 2)
                a3 (copy, index: 3)
                v27 (ref,  index: 4)
                v29 (ref,  index: 5)
                custom (copy, index: 6)
                hasRun (ref,  index: 7)
                parent (ref,  index: 8)
                ui5 (ref,  index: 9)
                v19 (ref,  index: 10)
                ui3 (ref,  index: 11)
                v18 (ref,  index: 12)
                ui7 (ref,  index: 13)
                v28 (ref,  index: 14)
            ]]
            if a118 == "leave" then
                openConfirm()
            elseif a118 == "closeConfirm" then
                if ui8 then
                    ui8.Visible = false
                end

                a3.MenuManager.PopMouse("CustomLeave")
                a3.MenuManager.PopFocus("CustomLeave")
            elseif a118 == "start" then
                v27.Activated:Fire()
            elseif a118 == "watch" then
                v29.Activated:Fire()
            elseif a118 == "leaveYes" then
                if ui8 then
                    ui8.Visible = false
                end

                a3.MenuManager.PopMouse("CustomLeave")
                a3.MenuManager.PopFocus("CustomLeave")

                task.spawn(
                    function()
                        --[[
                          line: 68
                          upvalues:
                            custom (copy, index: 1)
                            a3 (copy, index: 2)
                        ]]
                        local v119, v120 = custom.Action("Leave")
                        if not v119 then
                            a3.Toast(tostring(v120), "error")
                        end
                    end
                )
            end

            local v121 = {custom = custom.IsServer(), host = custom.IsHost()}
            v121.card = hasRun and parent.Visible
            v121.status = not hasRun and "" or ui5.Text
            v121.code = not hasRun and "" or (if v19.Visible then custom.MASK else ui3.Text)
            v121.lock = hasRun and v18.Visible
            v121.mode = if hasRun then ui7.Text else false
            v121.start = hasRun and v27.Instance.Visible
            v121.leave = hasRun and v28.Instance.Visible
            v121.watch = hasRun and v29.Instance.Visible
            v121.crown = a3.TopbarSettings and a3.TopbarSettings.HostButton.Visible or false
            return v121
        end

        a3.Debug.custom = function(a122, a123)
            --[[
              line: 561
              upvalues:
                custom (copy, index: 1)
            ]]
            local status

            if a122 == "mock" then
                custom.SetMock(a123)
            end

            local v125 = custom.State()
            local v126 = {server = custom.IsServer(), host = custom.IsHost(), code = custom.Code()}

            if v125 then
                status = v125.status
                status = status or false
            else
                status = false
            end

            v126.status = status

            return v126
        end
    end)
}