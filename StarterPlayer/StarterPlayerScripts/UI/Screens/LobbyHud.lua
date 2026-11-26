local guiService = game:GetService("GuiService")
local players = game:GetService("Players")
local tweenService = game:GetService("TweenService")
local userInputService = game:GetService("UserInputService")
local Signal = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Signal"))
local Keybinds = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Keybinds"))

return {
    Init = (function(a7)
        --[[
          name: Init
          line: 36
          upvalues:
            players (copy, index: 1)
            Signal (copy, index: 2)
            tweenService (copy, index: 3)
            guiService (copy, index: 4)
            Keybinds (copy, index: 5)
            userInputService (copy, index: 6)
        ]]
        local refreshRank
        local paintHover
        local v10 = false
        local ui = a7.UI
        local theme = a7.Theme
        local state = a7.State
        local colors = theme.Colors
        local fonts = theme.Fonts
        local localPlayer = players.LocalPlayer
        local ui2 = ui.new("Frame", {Name = "LobbyHud", Size = UDim2.fromScale(1, 1), Parent = a7.Canvas.HUD})
        local v18 = ui.Panel({Name = "PlayerChip", BackgroundTransparency = 0.22, Size = UDim2.fromOffset(340, 78), Trim = colors.Accent, Parent = ui2})
        local RankArt = require(script.Parent.Parent.RankArt)
        local ranks = RankArt.Ranks

        do
            local function trophiesNow()
                --[[
                  name: trophiesNow
                  line: 64
                  upvalues:
                    state (copy, index: 1)
                ]]
                local number = tonumber(state.Get("Trophies"))
                if not number then
                    if state.Profile then
                        number = tonumber(state.Profile.trophies)
                        number = number or 0
                    else
                        number = 0
                    end
                end

                return number
            end
        end

        local v23 = RankArt.Emblem
        local rankOf = ranks.RankOf
        local number = tonumber(state.Get("Trophies"))
        if not number then
            if state.Profile then
                number = tonumber(state.Profile.trophies)

                if not number then
                    v10 = true
                end
            else
                v10 = true
            end
        end

        if v10 then
            number = 0
        end

        v23 = v23(rankOf(number), 64, {Name = "RankEmblem", ZIndex = 3, Parent = v18})
        local parent = ui.new("TextLabel", {Name = "PlayerName", AutoLocalize = false, TextSize = 22, ZIndex = 3, Text = localPlayer.DisplayName, FontFace = fonts.Heavy, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v18})
        ui.TextStroke(colors.Void, 1.5, 0.4).Parent = parent
        local streakSlot = ui.new("Frame", {Name = "StreakSlot", BackgroundTransparency = 1, ZIndex = 3, AnchorPoint = Vector2.new(1, 0), Parent = v18})
        local parent2 = ui.new("Frame", {Name = "RankRow", AutomaticSize = Enum.AutomaticSize.X, BackgroundTransparency = 1, ZIndex = 3, (ui.List(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)), Parent = v18})
        local parent3 = ui.new("TextLabel", {Name = "RankName", Text = "", TextSize = 16, LayoutOrder = 1, ZIndex = 3, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromScale(0, 1), FontFace = fonts.Heavy, Parent = parent2})
        ui.TextStroke(colors.Void, 1.5, 0.35).Parent = parent3
        RankArt.Trophy(16, {LayoutOrder = 2, ZIndex = 3, Parent = parent2})
        local parent4 = ui.new("TextLabel", {Name = "Trophies", Text = "0", TextSize = 17, LayoutOrder = 3, ZIndex = 3, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromScale(0, 1), FontFace = fonts.Display, TextColor3 = colors.Text, Parent = parent2})
        ui.TextStroke(colors.Void, 1.5, 0.35).Parent = parent4
        local parent5 = ui.new("Frame", {Name = "LevelPill", AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = colors.Inset, BackgroundTransparency = 0.15, ClipsDescendants = true, ZIndex = 3, (ui.Corner(theme.Radius.Pill)), Parent = v18})
        ui.Stroke(colors.Xp, 1, 0.55).Parent = parent5
        local parent6 = ui.new("Frame", {Name = "Fill", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 3, (ui.Corner(theme.Radius.Pill)), Parent = parent5})
        local v33 = ui.Gradient(theme.Lighten(colors.Xp, 0.2), colors.Xp, 0)
        v33.Parent = parent6
        local numberValue = Instance.new("NumberValue")

        do
            local function paintLevelFill()
                --[[
                  name: paintLevelFill
                  line: 149
                  upvalues:
                    numberValue (copy, index: 1)
                    v33 (copy, index: 2)
                ]]
                local transparency
                local clampedValue = math.clamp(numberValue.Value, 0, 1)

                if not (clampedValue <= 0.002) then
                    transparency = if 0.998 <= clampedValue then NumberSequence.new(0) else NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(clampedValue, 0), NumberSequenceKeypoint.new(math.min(clampedValue + 0.002, 1), 1), NumberSequenceKeypoint.new(1, 1)})
                else
                    transparency = NumberSequence.new(1)
                end

                v33.Transparency = transparency
            end

            numberValue.Changed:Connect(paintLevelFill)
            paintLevelFill()
        end

        local parent7 = ui.new("TextLabel", {Name = "Level", Text = "LV 1", TextSize = 15, ZIndex = 4, Size = UDim2.fromScale(1, 1), FontFace = fonts.Display, TextColor3 = colors.Text, Parent = parent5})
        ui.TextStroke(colors.Void, 1.5, 0.3).Parent = parent7
        local v39 = ui.Bar({Name = "RankBar", Color = colors.Accent, Parent = v18})
        v39.Frame.ZIndex = 3
        v39.Fill.ZIndex = 3

        local function streakShown()
            --[[
              name: streakShown
              line: 180
              upvalues:
                streakSlot (copy, index: 1)
            ]]
            for _, child in streakSlot:GetChildren() do
                if child:IsA("GuiObject") and child.Visible then
                    return true
                end
            end

            return false
        end

        local textService = game:GetService("TextService")
        local v44 = {name = 16, trophies = 17}
        local v45 = 0
        local count = 0

        do
            local function fitRow()
                --[[
                  name: fitRow
                  line: 194
                  upvalues:
                    count (ref,  index: 1)
                    textService (copy, index: 2)
                    v18 (copy, index: 3)
                    v45 (ref,  index: 4)
                    v44 (copy, index: 5)
                    parent3 (copy, index: 6)
                    parent4 (copy, index: 7)
                ]]
                count += 1
                local v48 = count

                task.spawn(
                    function()
                        --[[
                          line: 197
                          upvalues:
                            textService (copy, index: 1)
                            v18 (copy, index: 2)
                            v45 (ref,  index: 3)
                            v44 (copy, index: 4)
                            parent3 (copy, index: 5)
                            parent4 (copy, index: 6)
                            v48 (copy, index: 7)
                            count (ref,  index: 8)
                        ]]
                        local function width(a50, size: number)
                            --[[
                              name: width
                              line: 198
                              upvalues:
                                textService (copy, index: 1)
                            ]]
                            local getTextBoundsParams = Instance.new("GetTextBoundsParams")
                            getTextBoundsParams.Text = a50.Text
                            getTextBoundsParams.Font = a50.FontFace
                            getTextBoundsParams.Size = size
                            getTextBoundsParams.Width = 1000
                            local success, textBoundsAsync = pcall(textService.GetTextBoundsAsync, textService, getTextBoundsParams)
                            if success then
                                return textBoundsAsync.X
                            end

                            return 0
                        end

                        local v55 = v18.Size.X.Offset - v45
                        local v56 = v44.name
                        local v57 = v44.trophies

                        while 11 < v56 do
                            local x
                            local x2
                            local getTextBoundsParams = Instance.new("GetTextBoundsParams")
                            getTextBoundsParams.Text = parent3.Text
                            getTextBoundsParams.Font = parent3.FontFace
                            getTextBoundsParams.Size = v56
                            getTextBoundsParams.Width = 1000
                            local success, textBoundsAsync = pcall(textService.GetTextBoundsAsync, textService, getTextBoundsParams)

                            if success then
                                x = textBoundsAsync.X
                            else
                                x = 0
                            end

                            local getTextBoundsParams2 = Instance.new("GetTextBoundsParams")
                            getTextBoundsParams2.Text = parent4.Text
                            getTextBoundsParams2.Font = parent4.FontFace
                            getTextBoundsParams2.Size = v57
                            getTextBoundsParams2.Width = 1000
                            local success2, textBoundsAsync2 = pcall(textService.GetTextBoundsAsync, textService, getTextBoundsParams2)

                            if success2 then
                                x2 = textBoundsAsync2.X
                            else
                                x2 = 0
                            end

                            if not (v55 < ((x + x2) + 16) + 12) then
                                break
                            end

                            v56 -= 1
                            v57 -= 1
                        end

                        if v48 == count then
                            parent3.TextSize = v56
                            parent4.TextSize = v57
                        end
                    end
                )
            end
        end

        local function layoutChip(a67: boolean)
            --[[
              name: layoutChip
              line: 218
              upvalues:
                v23 (copy, index: 1)
                parent (copy, index: 2)
                parent2 (copy, index: 3)
                v44 (copy, index: 4)
                streakShown (copy, index: 5)
                streakSlot (copy, index: 6)
                parent5 (copy, index: 7)
                parent7 (copy, index: 8)
                v45 (ref,  index: 9)
                count (ref,  index: 10)
                textService (copy, index: 11)
                v18 (copy, index: 12)
                parent3 (copy, index: 13)
                parent4 (copy, index: 14)
                v39 (copy, index: 15)
            ]]
            local streakShown2
            local v69 = 78
            local v70 = 64
            local v71 = 7
            local v72 = 80
            local v73 = 12
            local v74 = 7
            local v75 = 26
            local v76 = 35
            local v77 = 20
            local v78 = 61
            local v79 = 9
            local v80 = 66
            local v81 = 27
            local v82 = 6

            if a67 then
                v69 = 72
                v70 = 56
                v71 = 6
                v72 = 69
                v73 = 10
                v74 = 5
                v75 = 24
                v76 = 31
                v77 = 18
                v78 = 55
                v79 = 8
                v80 = 58
                v81 = 25
                v82 = 5
            end

            v23.Size = UDim2.fromOffset(v70, v70)
            v23.AnchorPoint = Vector2.new(0, 0.5)
            v23.Position = UDim2.new(0, v71, 0.5, 0)
            parent.TextSize = a67 and 20 or 22
            parent.Position = UDim2.fromOffset(v72, v74)
            parent2.Position = UDim2.fromOffset(v72, v76)
            parent2.Size = UDim2.fromOffset(0, v77)
            v44.name = a67 and 15 or 16

            if a67 then
                streakShown2 = 16
                streakShown2 = streakShown
            else
                streakShown2 = 17
                streakShown2 = streakShown
            end

            v44.trophies = streakShown2
            local visible = streakShown2()
            streakSlot.Visible = visible
            streakSlot.Size = UDim2.fromOffset(v80, v81)
            parent5.Size = UDim2.fromOffset(v80, v81)
            parent7.TextSize = a67 and 14 or 15

            if visible then
                local flooredValue = math.floor(((v69 - (v81 * 2)) - v82) / 2)
                streakSlot.Position = UDim2.new(1, -v73, 0, flooredValue)
                parent5.Position = UDim2.new(1, -v73, 0, (flooredValue + v81) + v82)
            else
                parent5.Position = UDim2.new(1, -v73, 0, (math.floor((v69 - v81) / 2)))
            end

            local v85 = v73 + v80 + 12
            v45 = v72 + v85
            count += 1
            local v86 = count

            task.spawn(
                function()
                    --[[
                      line: 197
                      upvalues:
                        textService (copy, index: 1)
                        v18 (copy, index: 2)
                        v45 (ref,  index: 3)
                        v44 (copy, index: 4)
                        parent3 (copy, index: 5)
                        parent4 (copy, index: 6)
                        v86 (copy, index: 7)
                        count (ref,  index: 8)
                    ]]
                    local function width(a88, size: number)
                        --[[
                          name: width
                          line: 198
                          upvalues:
                            textService (copy, index: 1)
                        ]]
                        local getTextBoundsParams = Instance.new("GetTextBoundsParams")
                        getTextBoundsParams.Text = a88.Text
                        getTextBoundsParams.Font = a88.FontFace
                        getTextBoundsParams.Size = size
                        getTextBoundsParams.Width = 1000
                        local success, textBoundsAsync = pcall(textService.GetTextBoundsAsync, textService, getTextBoundsParams)
                        if success then
                            return textBoundsAsync.X
                        end

                        return 0
                    end

                    local v93 = v18.Size.X.Offset - v45
                    local v94 = v44.name
                    local v95 = v44.trophies

                    while 11 < v94 do
                        local x
                        local x2
                        local getTextBoundsParams = Instance.new("GetTextBoundsParams")
                        getTextBoundsParams.Text = parent3.Text
                        getTextBoundsParams.Font = parent3.FontFace
                        getTextBoundsParams.Size = v94
                        getTextBoundsParams.Width = 1000
                        local success, textBoundsAsync = pcall(textService.GetTextBoundsAsync, textService, getTextBoundsParams)

                        if success then
                            x = textBoundsAsync.X
                        else
                            x = 0
                        end

                        local getTextBoundsParams2 = Instance.new("GetTextBoundsParams")
                        getTextBoundsParams2.Text = parent4.Text
                        getTextBoundsParams2.Font = parent4.FontFace
                        getTextBoundsParams2.Size = v95
                        getTextBoundsParams2.Width = 1000
                        local success2, textBoundsAsync2 = pcall(textService.GetTextBoundsAsync, textService, getTextBoundsParams2)

                        if success2 then
                            x2 = textBoundsAsync2.X
                        else
                            x2 = 0
                        end

                        if not (v93 < ((x + x2) + 16) + 12) then
                            break
                        end

                        v94 -= 1
                        v95 -= 1
                    end

                    if v86 == count then
                        parent3.TextSize = v94
                        parent4.TextSize = v95
                    end
                end
            )

            parent.Size = UDim2.new(1, -v72 - v85, 0, v75)
            v39.Frame.Position = UDim2.fromOffset(v72, v78)
            v39.Frame.Size = UDim2.new(1, -v72 - v85, 0, v79)
        end

        local v104 = false

        do
            local function watchStreak(a106)
                --[[
                  name: watchStreak
                  line: 259
                  upvalues:
                    layoutChip (copy, index: 1)
                    v104 (ref,  index: 2)
                ]]
                if a106:IsA("GuiObject") then
                    a106:GetPropertyChangedSignal("Visible"):Connect(
                        function()
                            --[[
                              line: 261
                              upvalues:
                                layoutChip (copy, index: 1)
                                v104 (ref,  index: 2)
                            ]]
                            layoutChip(v104)
                        end
                    )
                    layoutChip(v104)
                end
            end

            streakSlot.ChildAdded:Connect(watchStreak)

            for _, child in streakSlot:GetChildren() do
                watchStreak(child)
            end
        end

        do
            local ui3 = ui.new("TextButton", {Name = "OpenCard", BackgroundTransparency = 1, Text = "", AutoButtonColor = false, ZIndex = 6, Size = UDim2.fromScale(1, 1), Parent = v18})
            local uiStroke = v18:FindFirstChildOfClass("UIStroke")
            local v111 = not uiStroke and 0.9 or uiStroke.Transparency
            local v112 = if uiStroke then uiStroke.Color else colors.Stroke

            do
                local v113 = false

                paintHover = function(a114)
                    --[[
                      name: paintHover
                      line: 287
                      upvalues:
                        uiStroke (copy, index: 1)
                        ui (copy, index: 2)
                        theme (copy, index: 3)
                        v113 (ref,  index: 4)
                        colors (copy, index: 5)
                        v112 (copy, index: 6)
                        v111 (copy, index: 7)
                        v18 (copy, index: 8)
                    ]]
                    if uiStroke then
                        local tween = ui.Tween
                        local fast = theme.Tween.Fast
                        local v117 = {Color = if not v113 and not a114 then v112 else colors.Accent}
                        v117.Transparency = a114 and 0.1 or v113 and 0.35 or v111
                        tween(uiStroke, fast, v117)
                    end

                    local tween = ui.Tween
                    local fast = theme.Tween.Fast
                    local v120 = {}
                    v120.BackgroundTransparency = a114 and 0.3 or v113 and 0.12 or 0.22
                    tween(v18, fast, v120)
                end

                ui3.MouseEnter:Connect(
                    function()
                        --[[
                          line: 296
                          upvalues:
                            v113 (ref,  index: 1)
                            ui (copy, index: 2)
                            a7 (copy, index: 3)
                            paintHover (copy, index: 4)
                        ]]
                        v113 = true

                        if not ui.Touch then
                            a7.Sounds.Play("Hover")
                        end

                        paintHover()
                    end
                )

                ui3.MouseLeave:Connect(
                    function()
                        --[[
                          line: 303
                          upvalues:
                            v113 (ref,  index: 1)
                            paintHover (copy, index: 2)
                        ]]
                        v113 = false
                        paintHover()
                    end
                )

                ui3.MouseButton1Down:Connect(
                    function()
                        --[[
                          line: 307
                          upvalues:
                            paintHover (copy, index: 1)
                        ]]
                        paintHover(true)
                    end
                )
                ui3.MouseButton1Up:Connect(
                    function()
                        --[[
                          line: 310
                          upvalues:
                            paintHover (copy, index: 1)
                        ]]
                        paintHover()
                    end
                )

                ui3.Activated:Connect(
                    function()
                        --[[
                          line: 313
                          upvalues:
                            v113 (ref,  index: 1)
                            paintHover (copy, index: 2)
                            a7 (copy, index: 3)
                        ]]
                        v113 = false
                        paintHover()
                        a7.Sounds.Play("Click")
                        a7.MenuManager.Toggle("Ranks")
                    end
                )
            end

            do
                local v121 = -1
                local v122 = -1

                refreshRank = function()
                    --[[
                      name: refreshRank
                      line: 325
                      upvalues:
                        state (copy, index: 1)
                        v121 (ref,  index: 2)
                        ranks (copy, index: 3)
                        RankArt (copy, index: 4)
                        v23 (copy, index: 5)
                        parent3 (copy, index: 6)
                        parent4 (copy, index: 7)
                        ui (copy, index: 8)
                        count (ref,  index: 9)
                        textService (copy, index: 10)
                        v18 (copy, index: 11)
                        v45 (ref,  index: 12)
                        v44 (copy, index: 13)
                        v39 (copy, index: 14)
                        theme (copy, index: 15)
                        v122 (ref,  index: 16)
                    ]]
                    local v123 = false
                    local number = tonumber(state.Get("Trophies"))
                    if not number then
                        if state.Profile then
                            number = tonumber(state.Profile.trophies)

                            if not number then
                                v123 = true
                            end
                        else
                            v123 = true
                        end
                    end

                    if v123 then
                        number = 0
                    end

                    local v125 = math.max(0, (math.floor(number)))

                    if v125 == v121 then
                        return
                    end

                    local v126, v127, v128 = ranks.Progress(v125)
                    local textColor3 = RankArt.Color(v126)
                    RankArt.SetEmblem(v23, v126)
                    parent3.Text = string.upper(ranks.Get(v126).name)
                    parent3.TextColor3 = textColor3
                    parent4.Text = ui.FormatNumber(v125)
                    count += 1
                    local v130 = count

                    task.spawn(
                        function()
                            --[[
                              line: 197
                              upvalues:
                                textService (copy, index: 1)
                                v18 (copy, index: 2)
                                v45 (ref,  index: 3)
                                v44 (copy, index: 4)
                                parent3 (copy, index: 5)
                                parent4 (copy, index: 6)
                                v130 (copy, index: 7)
                                count (ref,  index: 8)
                            ]]
                            local function width(a132, size: number)
                                --[[
                                  name: width
                                  line: 198
                                  upvalues:
                                    textService (copy, index: 1)
                                ]]
                                local getTextBoundsParams = Instance.new("GetTextBoundsParams")
                                getTextBoundsParams.Text = a132.Text
                                getTextBoundsParams.Font = a132.FontFace
                                getTextBoundsParams.Size = size
                                getTextBoundsParams.Width = 1000
                                local success, textBoundsAsync = pcall(textService.GetTextBoundsAsync, textService, getTextBoundsParams)
                                if success then
                                    return textBoundsAsync.X
                                end

                                return 0
                            end

                            local v137 = v18.Size.X.Offset - v45
                            local v138 = v44.name
                            local v139 = v44.trophies

                            while 11 < v138 do
                                local x
                                local x2
                                local getTextBoundsParams = Instance.new("GetTextBoundsParams")
                                getTextBoundsParams.Text = parent3.Text
                                getTextBoundsParams.Font = parent3.FontFace
                                getTextBoundsParams.Size = v138
                                getTextBoundsParams.Width = 1000
                                local success, textBoundsAsync = pcall(textService.GetTextBoundsAsync, textService, getTextBoundsParams)

                                if success then
                                    x = textBoundsAsync.X
                                else
                                    x = 0
                                end

                                local getTextBoundsParams2 = Instance.new("GetTextBoundsParams")
                                getTextBoundsParams2.Text = parent4.Text
                                getTextBoundsParams2.Font = parent4.FontFace
                                getTextBoundsParams2.Size = v139
                                getTextBoundsParams2.Width = 1000
                                local success2, textBoundsAsync2 = pcall(textService.GetTextBoundsAsync, textService, getTextBoundsParams2)

                                if success2 then
                                    x2 = textBoundsAsync2.X
                                else
                                    x2 = 0
                                end

                                if not (v137 < ((x + x2) + 16) + 12) then
                                    break
                                end

                                v138 -= 1
                                v139 -= 1
                            end

                            if v130 == count then
                                parent3.TextSize = v138
                                parent4.TextSize = v139
                            end
                        end
                    )

                    if const uiGradient = v39.Fill:FindFirstChildOfClass("UIGradient") then
                        uiGradient.Color = ColorSequence.new(theme.Lighten(textColor3, 0.2), textColor3)
                    end

                    local set = v39.Set
                    local v150 = if v128 and 0 < v128 then v127 / v128 else 1
                    set(v150, v121 < 0)

                    if 0 <= v121 then
                        if v122 < v126 then
                            ui.Pop(v23, 1.4)
                        else
                            ui.Bump(parent4, 0.12)
                        end
                    end

                    v121 = v125
                    v122 = v126
                end
            end

            refreshRank()

            state.AttrChanged:Connect(
                function(a151)
                    --[[
                      line: 352
                      upvalues:
                        refreshRank (copy, index: 1)
                    ]]
                    if a151 == "Trophies" then
                        refreshRank()
                    end
                end
            )

            state.ProfileChanged:Connect(refreshRank)
        end

        local playButton = ui.Button({Name = "Play", Text = "PLAY", TextSize = 46, Style = "Primary", Radius = 16, Size = UDim2.fromOffset(300, 96), AnchorPoint = Vector2.new(1, 1), Icon = ui.Image(ui.Assets.Icons.CrossedArrows, {Size = UDim2.fromOffset(36, 34), ImageColor3 = colors.Text}), Parent = ui2})
        local parent8 = ui.new("TextLabel", {Name = "Sub", Text = "3V3  ·  BEST OF 5", TextSize = 15, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 1, 2), Size = UDim2.new(1, 0, 0, 18), FontFace = fonts.Heavy, TextColor3 = colors.TextDim, Parent = playButton.Instance})
        ui.TextStroke(colors.Void, 1.5, 0.3).Parent = parent8
        local number2 = 2

        pcall(
            function()
                --[[
                  line: 386
                  upvalues:
                    number2 (ref, index: 1)
                ]]
                local Config = require(game:GetService("ReplicatedStorage").Shared.Config)
                number2 = tonumber(Config.FIRST_MATCH_ROUNDS_TO_WIN) or number2
            end
        )

        local parent9 = ui.new("Frame", {Name = "Pad", ZIndex = 4, Size = UDim2.fromScale(1, 1), Parent = playButton.Face})
        ui.PadActionCap("Play", {Height = 28, ZIndex = 4, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -8, 0, 8), Parent = parent9})

        do
            local function refreshPlaySub()
                --[[
                  name: refreshPlaySub
                  line: 399
                  upvalues:
                    state (copy, index: 1)
                    number2 (ref,  index: 2)
                    parent8 (copy, index: 3)
                ]]
                local v158
                local profile = state.Profile
                local v160 = state.HasProfile
                    and type(profile) == "table"
                    and type(profile.stats) == "table"
                    and profile.stats.matches == 0

                if v160 then
                    v158 = number2
                else
                    v158 = state.DEFAULT_ROUNDS_TO_WIN
                end

                parent8.Text = state.Get("Duel") == true and "3V3  ·  1V1"
                    or string.format("3V3  ·  BEST OF %d", (v158 * 2) - 1)
            end

            refreshPlaySub()
            state.ProfileChanged:Connect(refreshPlaySub)

            state.AttrChanged:Connect(
                function(a161)
                    --[[
                      line: 407
                      upvalues:
                        refreshPlaySub (copy, index: 1)
                    ]]
                    if a161 == "Duel" then
                        refreshPlaySub()
                    end
                end
            )
        end

        local v162 = ui.Button
        local v163 = {
            Name = "Loadout",
            Text = "LOADOUT",
            TextSize = 26,
            Style = "Dark",
            Gap = 6,
            Size = UDim2.fromOffset(200, 66),
            Icon = ui.Image((ui.Assets.Icons.LoadoutSword or ui.Assets.Icons.Sword), {Name = "Icon", Size = UDim2.fromOffset(40, 40), ScaleType = Enum.ScaleType.Fit}),
            Parent = ui2,
            OnClick = (function()
                --[[
                  name: OnClick
                  line: 423
                  upvalues:
                    a7 (copy, index: 1)
                ]]
                a7.MenuManager.Toggle("Loadout")
            end)
        }
        v162 = v162(v163)
        ui.PadCap(Enum.KeyCode.DPadLeft, {Height = 24, ZIndex = 4, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Parent = v162.Face})

        do
            local label = v162.Label
            label.RichText = true
            label.LineHeight = 0.92
            label.AutoLocalize = false
            local loc = a7.Loc

            local function refreshLoadoutLabel()
                --[[
                  name: refreshLoadoutLabel
                  line: 435
                  upvalues:
                    state (copy, index: 1)
                    loc (copy, index: 2)
                    label (copy, index: 3)
                ]]
                if not state.HasLoadoutSlots() or not (1 < state.LoadoutSlotCount()) then
                    label.Text = loc.T("LOADOUT")
                    return
                end

                local text = loc.T(string.upper(state.LoadoutName(state.ActiveLoadout())))
                local text2 = string.gsub(string.gsub(string.gsub(text, "&", "&amp;"), "<", "&lt;"), ">", "&gt;")
                label.Text = string.format("%s\n<font size=\"14\" color=\"#BAC0CE\">%s</font>", loc.T("LOADOUT"), text2)
            end

            refreshLoadoutLabel()
            state.ProfileChanged:Connect(refreshLoadoutLabel)
            loc.Changed:Connect(refreshLoadoutLabel)
        end

        local guiService2 = game:GetService("GuiService")
        local trTopbarSettings = Instance.new("ScreenGui")
        trTopbarSettings.Name = "TR_TopbarSettings"
        trTopbarSettings.ResetOnSpawn = false
        trTopbarSettings.IgnoreGuiInset = true
        trTopbarSettings.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
        trTopbarSettings.DisplayOrder = 8
        trTopbarSettings.Parent = a7.PlayerGui

        local settings = Instance.new("TextButton")
        settings.Name = "Settings"
        settings.Text = ""
        settings.AutoButtonColor = false
        settings.BackgroundColor3 = Color3.fromRGB(18, 18, 21)
        settings.BackgroundTransparency = 0.08
        settings.Size = UDim2.fromOffset(44, 44)
        settings.Parent = trTopbarSettings
        ui.Corner(theme.Radius.Pill).Parent = settings
        local ui4 = ui.new("Frame", {Name = "State", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, (ui.Corner(theme.Radius.Pill)), Parent = settings})

        do
            local ui5 = ui.new("TextLabel", {Name = "Icon", Text = "gear", AutoLocalize = false, TextSize = 24, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(24, 24), FontFace = Font.new("rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json", Enum.FontWeight.Regular), TextColor3 = Color3.fromRGB(247, 247, 248), Parent = settings})

            task.delay(
                3,
                function()
                    --[[
                      line: 499
                      upvalues:
                        ui5 (copy, index: 1)
                        ui (copy, index: 2)
                        settings (copy, index: 3)
                    ]]
                    local x = ui5.TextBounds.X

                    if x < 1 or 32 < x then
                        ui5.Visible = false
                        ui.Icon("gear", 24, Color3.fromRGB(247, 247, 248), {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), HoleColor = Color3.fromRGB(18, 18, 21), Parent = settings})
                    end
                end
            )
        end

        ui.KeyCap("M", {Height = 17, TextSize = 11, Transparency = 0.05, ZIndex = 3, Gamepad = Enum.KeyCode.ButtonSelect, Color = Color3.fromRGB(18, 18, 21), AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, 5, 1, 1), Parent = settings})
        local news = Instance.new("TextButton")
        news.Name = "News"
        news.Text = ""
        news.AutoButtonColor = false
        news.BackgroundColor3 = Color3.fromRGB(18, 18, 21)
        news.BackgroundTransparency = 0.08
        news.Size = UDim2.fromOffset(44, 44)
        news.Parent = trTopbarSettings
        ui.Corner(theme.Radius.Pill).Parent = news
        local ui6 = ui.new("Frame", {Name = "State", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, (ui.Corner(theme.Radius.Pill)), Parent = news})
        ui.Glyph("megaphone", 24, Color3.fromRGB(247, 247, 248), {Name = "Icon", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = news})
        local v177 = false
        local v178 = false
        local customHost = Instance.new("TextButton")
        customHost.Name = "CustomHost"
        customHost.Text = ""
        customHost.AutoButtonColor = false
        customHost.BackgroundColor3 = Color3.fromRGB(18, 18, 21)
        customHost.BackgroundTransparency = 0.08
        customHost.Size = UDim2.fromOffset(44, 44)
        customHost.Visible = false
        customHost.Parent = trTopbarSettings
        ui.Corner(theme.Radius.Pill).Parent = customHost
        local ui7 = ui.new("Frame", {Name = "State", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, (ui.Corner(theme.Radius.Pill)), Parent = customHost})
        ui.Glyph("crown", 24, Color3.fromRGB(247, 247, 248), {Name = "Icon", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = customHost})
        ui.ActionCap("CustomMenu", {Height = 17, TextSize = 11, Transparency = 0.05, ZIndex = 3, Gamepad = Enum.KeyCode.DPadDown, Color = Color3.fromRGB(18, 18, 21), AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, 5, 1, 1), Parent = customHost})
        local hostActivated = Signal.new()
        local v182 = false
        local v183 = false
        local v184 = false
        local v185 = false
        local v186 = {}
        local userInputService2 = game:GetService("UserInputService")

        local function paint()
            --[[
              name: paint
              line: 574
              upvalues:
                userInputService2 (copy, index: 1)
                v182 (ref,  index: 2)
                v183 (ref,  index: 3)
                v184 (ref,  index: 4)
                v185 (ref,  index: 5)
                v177 (ref,  index: 6)
                v178 (ref,  index: 7)
                a7 (copy, index: 8)
                ui4 (copy, index: 9)
                ui7 (copy, index: 10)
                ui6 (copy, index: 11)
            ]]
            if userInputService2.MouseBehavior ~= Enum.MouseBehavior.Default then
                v182 = false
                v183 = false
                v184 = false
                v185 = false
                v177 = false
                v178 = false
            end

            local isOpen = a7.MenuManager.IsOpen("Settings")
            ui4.BackgroundTransparency = v183 and 0.8 or v182 and 0.9 or isOpen and 0.9 or 1
            local isOpen2 = a7.MenuManager.IsOpen("CustomHost")
            ui7.BackgroundTransparency = v185 and 0.8 or v184 and 0.9 or isOpen2 and 0.9 or 1
            ui6.BackgroundTransparency = v178 and 0.8 or v177 and 0.9 or 1
        end

        userInputService2:GetPropertyChangedSignal("MouseBehavior"):Connect(paint)

        local function place()
            --[[
              name: place
              line: 588
              upvalues:
                guiService2 (copy, index: 1)
                settings (copy, index: 2)
                news (copy, index: 3)
                customHost (copy, index: 4)
                ui (copy, index: 5)
            ]]
            local v192
            local topbarInset = guiService2.TopbarInset
            local height = topbarInset.Height
            local clampedValue = math.clamp(height - 14, 28, 44)
            settings.Size = UDim2.fromOffset(clampedValue, clampedValue)
            settings.Position = UDim2.fromOffset(topbarInset.Min.X + 8, (math.max(0, (height - 2) - clampedValue)))
            local v196 = (topbarInset.Min.X + 8) + clampedValue + 12
            news.Size = UDim2.fromOffset(clampedValue, clampedValue)
            news.Position = UDim2.fromOffset(v196, (math.max(0, (height - 2) - clampedValue)))

            if news.Visible then
                v196 += clampedValue + 12
            end

            customHost.Size = UDim2.fromOffset(clampedValue, clampedValue)
            customHost.Position = UDim2.fromOffset(v196, (math.max(0, (height - 2) - clampedValue)))
            local v197 = clampedValue + 8

            if news.Visible then
                v192 = clampedValue + 12
            else
                v192 = 0
            end

            local v198 = v197 + v192
            local v199 = not customHost.Visible and 0 or clampedValue + 12
            local topbarReserved = v198 + v199

            if ui.TopbarReserved ~= topbarReserved then
                ui.TopbarReserved = topbarReserved
                ui.TopInsetChanged:Fire()
            end
        end

        place()
        guiService2:GetPropertyChangedSignal("TopbarInset"):Connect(place)
        local instance = ui.new("TextLabel", {Name = "Text", TextSize = 14, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromScale(0, 1), FontFace = fonts.SemiBold, TextColor3 = Color3.fromRGB(247, 247, 248)})
        local v202 = ui.new
        local v203 = ui.Corner(theme.Radius.Pill)
        local v204 = ui.new

        do
            local v205 = {PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12)}
            v202 = v202("Frame", {Name = "Tooltip", AnchorPoint = Vector2.new(0.5, 0), AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 30), BackgroundColor3 = Color3.fromRGB(18, 18, 21), BackgroundTransparency = 0.08, Visible = false, ZIndex = 10, v203, v204("UIPadding", v205), instance, Parent = trTopbarSettings})
        end

        instance.ZIndex = 11

        do
            local v206 = {}
            local v207 = nil
            local v208 = false
            v204 = 0

            do
                local function hideTip(a210)
                    --[[
                      name: hideTip
                      line: 644
                      upvalues:
                        v207 (ref,  index: 1)
                        v204 (ref,  index: 2)
                        v208 (ref,  index: 3)
                        v202 (copy, index: 4)
                    ]]
                    if a210 and v207 ~= a210 then
                        return
                    end

                    v204 += 1
                    v207 = nil
                    v208 = false
                    v202.Visible = false
                end
            end

            do
                local function showTip(key, a213: number, a214)
                    --[[
                      name: showTip
                      line: 652
                      upvalues:
                        v204 (ref,  index: 1)
                        v207 (ref,  index: 2)
                        v208 (ref,  index: 3)
                        trTopbarSettings (copy, index: 4)
                        instance (copy, index: 5)
                        v206 (copy, index: 6)
                        v202 (copy, index: 7)
                        tweenService (copy, index: 8)
                    ]]
                    v204 += 1
                    local v215 = v204
                    local v216 = a214 == true
                    v207 = key
                    v208 = v216

                    task.delay(
                        a213,
                        function()
                            --[[
                              line: 656
                              upvalues:
                                v215 (copy, index: 1)
                                v204 (ref,  index: 2)
                                key (copy, index: 3)
                                trTopbarSettings (copy, index: 4)
                                instance (copy, index: 5)
                                v206 (copy, index: 6)
                                v202 (copy, index: 7)
                                tweenService (copy, index: 8)
                            ]]
                            if v215 ~= v204 or not key.Visible or not trTopbarSettings.Enabled then
                                return
                            end

                            instance.Text = v206[key]
                            local v217 = key.Position.X.Offset + key.Size.X.Offset / 2
                            local v218 = key.Position.Y.Offset + key.Size.Y.Offset + 8
                            v202.Position = UDim2.fromOffset(v217, v218 - 4)
                            v202.BackgroundTransparency = 1
                            instance.TextTransparency = 1
                            v202.Visible = true
                            local tweenInfo = TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                            local propertyTable = {BackgroundTransparency = 0.08, Position = UDim2.fromOffset(v217, v218)}
                            tweenService:Create(v202, tweenInfo, propertyTable):Play()
                            tweenService:Create(instance, tweenInfo, {TextTransparency = 0}):Play()
                        end
                    )
                end
            end

            do
                local function tooltip(textButton: TextButton, value: string)
                    --[[
                      name: tooltip
                      line: 671
                      upvalues:
                        v206 (copy, index: 1)
                        ui (copy, index: 2)
                        userInputService2 (copy, index: 3)
                        v204 (ref,  index: 4)
                        v207 (ref,  index: 5)
                        v208 (ref,  index: 6)
                        trTopbarSettings (copy, index: 7)
                        instance (copy, index: 8)
                        v202 (copy, index: 9)
                        tweenService (copy, index: 10)
                    ]]
                    v206[textButton] = value

                    textButton.MouseEnter:Connect(
                        function()
                            --[[
                              line: 673
                              upvalues:
                                ui (copy, index: 1)
                                userInputService2 (copy, index: 2)
                                textButton (copy, index: 3)
                                v204 (ref,  index: 4)
                                v207 (ref,  index: 5)
                                v208 (ref,  index: 6)
                                trTopbarSettings (copy, index: 7)
                                instance (copy, index: 8)
                                v206 (copy, index: 9)
                                v202 (copy, index: 10)
                                tweenService (copy, index: 11)
                            ]]
                            if ui.Touch or userInputService2.MouseBehavior ~= Enum.MouseBehavior.Default then
                                return
                            end

                            local textButton2 = textButton
                            v204 += 1
                            local v225 = v204
                            v207 = textButton2
                            v208 = false

                            task.delay(
                                0.3,
                                function()
                                    --[[
                                      line: 656
                                      upvalues:
                                        v225 (copy, index: 1)
                                        v204 (ref,  index: 2)
                                        textButton2 (copy, index: 3)
                                        trTopbarSettings (copy, index: 4)
                                        instance (copy, index: 5)
                                        v206 (copy, index: 6)
                                        v202 (copy, index: 7)
                                        tweenService (copy, index: 8)
                                    ]]
                                    if v225 ~= v204 or not textButton2.Visible or not trTopbarSettings.Enabled then
                                        return
                                    end

                                    instance.Text = v206[textButton2]
                                    local v226 = textButton2.Position.X.Offset + textButton2.Size.X.Offset / 2
                                    local v227 = textButton2.Position.Y.Offset + textButton2.Size.Y.Offset + 8
                                    v202.Position = UDim2.fromOffset(v226, v227 - 4)
                                    v202.BackgroundTransparency = 1
                                    instance.TextTransparency = 1
                                    v202.Visible = true
                                    local tweenInfo = TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                                    local propertyTable = {BackgroundTransparency = 0.08, Position = UDim2.fromOffset(v226, v227)}
                                    tweenService:Create(v202, tweenInfo, propertyTable):Play()
                                    tweenService:Create(instance, tweenInfo, {TextTransparency = 0}):Play()
                                end
                            )
                        end
                    )

                    textButton.MouseLeave:Connect(
                        function()
                            --[[
                              line: 679
                              upvalues:
                                textButton (copy, index: 1)
                                v207 (ref,  index: 2)
                                v204 (ref,  index: 3)
                                v208 (ref,  index: 4)
                                v202 (copy, index: 5)
                            ]]
                            local textButton2 = textButton

                            if textButton2 and v207 ~= textButton2 then
                                return
                            end

                            v204 += 1
                            v207 = nil
                            v208 = false
                            v202.Visible = false
                        end
                    )

                    textButton.MouseButton1Down:Connect(
                        function()
                            --[[
                              line: 682
                              upvalues:
                                v204 (ref,  index: 1)
                                v207 (ref,  index: 2)
                                v208 (ref,  index: 3)
                                v202 (copy, index: 4)
                            ]]
                            v204 += 1
                            v207 = nil
                            v208 = false
                            v202.Visible = false
                        end
                    )

                    textButton.Activated:Connect(
                        function()
                            --[[
                              line: 685
                              upvalues:
                                v204 (ref,  index: 1)
                                v207 (ref,  index: 2)
                                v208 (ref,  index: 3)
                                v202 (copy, index: 4)
                            ]]
                            v204 += 1
                            v207 = nil
                            v208 = false
                            v202.Visible = false
                        end
                    )

                    textButton:GetPropertyChangedSignal("Visible"):Connect(
                        function()
                            --[[
                              line: 688
                              upvalues:
                                textButton (copy, index: 1)
                                v207 (ref,  index: 2)
                                v204 (ref,  index: 3)
                                v208 (ref,  index: 4)
                                v202 (copy, index: 5)
                            ]]
                            if not textButton.Visible then
                                local textButton2 = textButton

                                if textButton2 and v207 ~= textButton2 then
                                    return
                                end

                                v204 += 1
                                v207 = nil
                                v208 = false
                                v202.Visible = false
                            end
                        end
                    )
                end

                tooltip(settings, "Settings")
                tooltip(news, "What's New")
                tooltip(customHost, "Host Menu")
            end

            guiService2:GetPropertyChangedSignal("SelectedObject"):Connect(
                function()
                    --[[
                      line: 697
                      upvalues:
                        guiService2 (copy, index: 1)
                        v206 (copy, index: 2)
                        v204 (ref,  index: 3)
                        v207 (ref,  index: 4)
                        v208 (ref,  index: 5)
                        trTopbarSettings (copy, index: 6)
                        instance (copy, index: 7)
                        v202 (copy, index: 8)
                        tweenService (copy, index: 9)
                    ]]
                    local selectedObject = guiService2.SelectedObject

                    if selectedObject and v206[selectedObject] then
                        v204 += 1
                        local v233 = v204
                        v207 = selectedObject
                        v208 = true

                        task.delay(
                            0.1,
                            function()
                                --[[
                                  line: 656
                                  upvalues:
                                    v233 (copy, index: 1)
                                    v204 (ref,  index: 2)
                                    selectedObject (copy, index: 3)
                                    trTopbarSettings (copy, index: 4)
                                    instance (copy, index: 5)
                                    v206 (copy, index: 6)
                                    v202 (copy, index: 7)
                                    tweenService (copy, index: 8)
                                ]]
                                if v233 ~= v204 or not selectedObject.Visible or not trTopbarSettings.Enabled then
                                    return
                                end

                                instance.Text = v206[selectedObject]
                                local v234 = selectedObject.Position.X.Offset + selectedObject.Size.X.Offset / 2
                                local v235 = selectedObject.Position.Y.Offset + selectedObject.Size.Y.Offset + 8
                                v202.Position = UDim2.fromOffset(v234, v235 - 4)
                                v202.BackgroundTransparency = 1
                                instance.TextTransparency = 1
                                v202.Visible = true
                                local tweenInfo = TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                                local propertyTable = {BackgroundTransparency = 0.08, Position = UDim2.fromOffset(v234, v235)}
                                tweenService:Create(v202, tweenInfo, propertyTable):Play()
                                tweenService:Create(instance, tweenInfo, {TextTransparency = 0}):Play()
                            end
                        )

                        return
                    end

                    if v208 then
                        v204 += 1
                        v207 = nil
                        v208 = false
                        v202.Visible = false
                    end
                end
            )

            userInputService2:GetPropertyChangedSignal("MouseBehavior"):Connect(
                function()
                    --[[
                      line: 705
                      upvalues:
                        userInputService2 (copy, index: 1)
                        v204 (ref,  index: 2)
                        v207 (ref,  index: 3)
                        v208 (ref,  index: 4)
                        v202 (copy, index: 5)
                    ]]
                    if userInputService2.MouseBehavior ~= Enum.MouseBehavior.Default then
                        v204 += 1
                        v207 = nil
                        v208 = false
                        v202.Visible = false
                    end
                end
            )

            a7.MenuManager.Changed:Connect(
                function()
                    --[[
                      line: 710
                      upvalues:
                        v204 (ref,  index: 1)
                        v207 (ref,  index: 2)
                        v208 (ref,  index: 3)
                        v202 (copy, index: 4)
                    ]]
                    v204 += 1
                    v207 = nil
                    v208 = false
                    v202.Visible = false
                end
            )
        end

        settings.MouseEnter:Connect(
            function()
                --[[
                  line: 714
                  upvalues:
                    v182 (ref,  index: 1)
                    paint (copy, index: 2)
                ]]
                v182 = true
                paint()
            end
        )

        settings.MouseLeave:Connect(
            function()
                --[[
                  line: 718
                  upvalues:
                    v182 (ref,  index: 1)
                    v183 (ref,  index: 2)
                    paint (copy, index: 3)
                ]]
                v182 = false
                v183 = false
                paint()
            end
        )

        settings.MouseButton1Down:Connect(
            function()
                --[[
                  line: 722
                  upvalues:
                    v183 (ref,  index: 1)
                    paint (copy, index: 2)
                ]]
                v183 = true
                paint()
            end
        )

        settings.MouseButton1Up:Connect(
            function()
                --[[
                  line: 726
                  upvalues:
                    v183 (ref,  index: 1)
                    paint (copy, index: 2)
                ]]
                v183 = false
                paint()
            end
        )

        settings.Activated:Connect(
            function()
                --[[
                  line: 730
                  upvalues:
                    a7 (copy, index: 1)
                ]]
                a7.Sounds.Play("Click")
                a7.MenuManager.Toggle("Settings")
            end
        )

        news.MouseEnter:Connect(
            function()
                --[[
                  line: 734
                  upvalues:
                    v177 (ref,  index: 1)
                    paint (copy, index: 2)
                ]]
                v177 = true
                paint()
            end
        )

        news.MouseLeave:Connect(
            function()
                --[[
                  line: 738
                  upvalues:
                    v177 (ref,  index: 1)
                    v178 (ref,  index: 2)
                    paint (copy, index: 3)
                ]]
                v177 = false
                v178 = false
                paint()
            end
        )

        news.MouseButton1Down:Connect(
            function()
                --[[
                  line: 742
                  upvalues:
                    v178 (ref,  index: 1)
                    paint (copy, index: 2)
                ]]
                v178 = true
                paint()
            end
        )

        news.MouseButton1Up:Connect(
            function()
                --[[
                  line: 746
                  upvalues:
                    v178 (ref,  index: 1)
                    paint (copy, index: 2)
                ]]
                v178 = false
                paint()
            end
        )

        news.Activated:Connect(
            function()
                --[[
                  line: 750
                  upvalues:
                    a7 (copy, index: 1)
                ]]
                a7.Sounds.Play("Click")
                a7.MenuManager.Open("News")
            end
        )

        customHost.MouseEnter:Connect(
            function()
                --[[
                  line: 754
                  upvalues:
                    v184 (ref,  index: 1)
                    paint (copy, index: 2)
                ]]
                v184 = true
                paint()
            end
        )

        customHost.MouseLeave:Connect(
            function()
                --[[
                  line: 758
                  upvalues:
                    v184 (ref,  index: 1)
                    v185 (ref,  index: 2)
                    paint (copy, index: 3)
                ]]
                v184 = false
                v185 = false
                paint()
            end
        )

        customHost.MouseButton1Down:Connect(
            function()
                --[[
                  line: 762
                  upvalues:
                    v185 (ref,  index: 1)
                    paint (copy, index: 2)
                ]]
                v185 = true
                paint()
            end
        )

        customHost.MouseButton1Up:Connect(
            function()
                --[[
                  line: 766
                  upvalues:
                    v185 (ref,  index: 1)
                    paint (copy, index: 2)
                ]]
                v185 = false
                paint()
            end
        )

        customHost.Activated:Connect(
            function()
                --[[
                  line: 770
                  upvalues:
                    a7 (copy, index: 1)
                    hostActivated (copy, index: 2)
                ]]
                a7.Sounds.Play("Click")
                hostActivated:Fire()
            end
        )

        a7.MenuManager.Changed:Connect(paint)
        local topbarSettings = {
            Button = settings,
            HostButton = customHost,
            HostActivated = hostActivated,
            SetHostVisible = (function(hostVisible: boolean)
                --[[
                  name: SetHostVisible
                  line: 780
                  upvalues:
                    customHost (copy, index: 1)
                    place (copy, index: 2)
                    ui (copy, index: 3)
                ]]
                if customHost.Visible ~= hostVisible then
                    customHost.Visible = hostVisible
                    place()

                    if hostVisible then
                        ui.Pop(customHost, 0.6)
                    end
                end
            end),
            NewsButton = news,
            SetNewsVisible = (function(newsVisible: boolean)
                --[[
                  name: SetNewsVisible
                  line: 791
                  upvalues:
                    news (copy, index: 1)
                    place (copy, index: 2)
                ]]
                if news.Visible ~= newsVisible then
                    news.Visible = newsVisible
                    place()
                end
            end),
            Last = (function()
                --[[
                  name: Last
                  line: 798
                  upvalues:
                    customHost (copy, index: 1)
                    news (copy, index: 2)
                    settings (copy, index: 3)
                ]]
                if customHost.Visible then
                    return customHost
                end
                if news.Visible then
                    return news
                end

                return settings
            end),
            SetHidden = (function(key, a242)
                --[[
                  name: SetHidden
                  line: 802
                  upvalues:
                    v186 (copy, index: 1)
                    trTopbarSettings (copy, index: 2)
                ]]
                v186[key] = a242 and true or nil
                local enabled = next(v186) == nil
                trTopbarSettings.Enabled = enabled
            end)
        }
        a7.TopbarSettings = topbarSettings
        local parent10 = ui.Panel({Name = "TrainingBanner", BackgroundTransparency = 0.15, Visible = false, AnchorPoint = Vector2.new(0.5, 0), Size = UDim2.fromOffset(440, 64), Trim = colors.Accent, Parent = ui2})
        local v245 = ui.Image(ui.Assets.Icons.Sword, {Name = "Icon", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 18, 0.5, 2), Size = UDim2.fromOffset(34, 34), ImageColor3 = colors.Accent, Parent = parent10})
        local parent11 = ui.new("TextLabel", {Name = "Title", Text = "TRAINING", TextSize = 28, Position = UDim2.fromOffset(66, 8), Size = UDim2.new(1, -82, 0, 30), FontFace = fonts.Display, TextColor3 = colors.Accent, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent10})
        ui.TextStroke(colors.Void, 2, 0.2).Parent = parent11
        local ui8 = ui.new("TextLabel", {Name = "Sub", Text = "", TextSize = 15, Position = UDim2.fromOffset(66, 38), Size = UDim2.new(1, -82, 0, 18), FontFace = fonts.Bold, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent10})
        local parent12 = ui.Panel({Name = "Matchmaking", BackgroundTransparency = 0.06, StrokeTransparency = 0.3, StrokeThickness = 2, Visible = false, Size = UDim2.fromOffset(300, 96), Radius = UDim.new(0, 16), StrokeColor = colors.Accent, Parent = ui2})
        local uiGradient = parent12:FindFirstChildOfClass("UIGradient")
        local uiStroke = parent12:FindFirstChildOfClass("UIStroke")
        local ui9 = ui.new("TextLabel", {Name = "Title", Text = "FINDING MATCH", TextSize = 24, Position = UDim2.fromOffset(18, 12), Size = UDim2.new(1, -120, 0, 28), FontFace = fonts.Heavy, TextColor3 = colors.Text, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = parent12})
        local ui10 = ui.new("TextLabel", {Name = "Timer", Text = "0:00", TextSize = 30, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -18, 0, 9), Size = UDim2.fromOffset(96, 34), FontFace = fonts.Display, TextColor3 = colors.Accent, TextXAlignment = Enum.TextXAlignment.Right, Parent = parent12})
        local ui11 = ui.new("TextLabel", {Name = "Found", Text = "MATCH FOUND", TextSize = 36, Visible = false, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 8), Size = UDim2.new(1, -24, 0, 40), FontFace = fonts.Display, TextColor3 = colors.Text, Parent = parent12})
        local parent13 = ui.new("Frame", {Name = "Seats", AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 18, 1, -20), Size = UDim2.fromOffset(0, 16), AutomaticSize = Enum.AutomaticSize.X, (ui.List(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)), Parent = parent12})
        local backgroundColor3 = Color3.fromRGB(58, 63, 78)
        local v256 = {}

        for layoutOrder = 1, 6 do
            v256[layoutOrder] = ui.new("Frame", {Name = "Seat" .. layoutOrder, Size = UDim2.fromOffset(16, 16), BackgroundColor3 = backgroundColor3, LayoutOrder = layoutOrder, (ui.Corner(theme.Radius.Pill)), Parent = parent13})
        end

        local v258 = ui.Pill("1V1", colors.Accent, {Name = "Mode", Height = 22, TextSize = 15, LayoutOrder = 7, PadX = 9, Parent = parent13})
        v258.Visible = false
        local ui12 = ui.new("TextLabel", {Name = "Count", Text = "1/6 PLAYERS", TextSize = 18, AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -18, 1, -16), Size = UDim2.fromOffset(140, 24), FontFace = fonts.Bold, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Right, Parent = parent12})
        local parent14 = ui.new("Frame", {Name = "Scan", ClipsDescendants = true, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -5), Size = UDim2.new(1, -32, 0, 3), Parent = parent12})
        local instance2 = ui.new("Frame", {Name = "Bar", BackgroundColor3 = colors.Accent, Size = UDim2.fromScale(0.3, 1), Position = UDim2.fromScale(-0.3, 0), (ui.Corner(theme.Radius.Pill)), Parent = parent14})
        local v262 = ui.Button({Name = "Cancel", Text = "CANCEL", TextSize = 22, Style = "Dark", Visible = false, Sound = false, Size = UDim2.fromOffset(300, 54), Icon = ui.Icon("cross", 18, colors.TextDim), Parent = ui2})
        local parent15 = ui.new("Frame", {Name = "Pad", ZIndex = 4, Size = UDim2.fromScale(1, 1), Parent = v262.Face})
        ui.PadActionCap("Play", {Height = 24, ZIndex = 4, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Parent = parent15})
        local v264 = {}
        local v265 = {}
        local vector2 = Vector2.zero
        local tweenInfo = TweenInfo.new(0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

        local function homeRect(a269, a270, a271: number, a272)
            --[[
              name: homeRect
              line: 991
            ]]
            local v273 = a269.AbsoluteSize / a271
            local v274 = (a270.X.Scale * a272.X) + a270.X.Offset - a269.AnchorPoint.X * v273.X
            local v275 = (a270.Y.Scale * a272.Y) + a270.Y.Offset - a269.AnchorPoint.Y * v273.Y

            return Rect.new(v274, v275, v274 + v273.X, v275 + v273.Y)
        end

        local function computeShift()
            --[[
              name: computeShift
              line: 998
              upvalues:
                ui (copy, index: 1)
                ui2 (copy, index: 2)
                v264 (copy, index: 3)
                homeRect (copy, index: 4)
                playButton (copy, index: 5)
                parent12 (copy, index: 6)
                v262 (copy, index: 7)
            ]]
            local v277 = ui.ChatRectIn(ui2)

            if not v277 or not ui2.Visible or ui.Compact then
                return Vector2.zero
            end

            local v278
            local v279 = math.max(ui.Scale, 0.01)
            local v280 = ui2.AbsoluteSize / v279
            local v281

            for v282, v283 in v264 do
                if v282.Visible then
                    if not v282.Parent then
                        continue
                    end

                    v281 = homeRect(v282, v283, v279, v280)

                    if v278 then
                        v278 = Rect.new(math.min(v278.Min.X, v281.Min.X), math.min(v278.Min.Y, v281.Min.Y), math.max(v278.Max.X, v281.Max.X), (math.max(v278.Max.Y, v281.Max.Y)))
                    else
                        v278 = v281
                    end
                end
            end

            if not v278 then
                return Vector2.zero
            end

            if not (v277.Max.X + 12 <= v278.Min.X) then
                local x = v277.Min.X

                if not (v278.Max.X + 12 <= x) and not (v277.Max.Y + 12 <= v278.Min.Y) then
                    local y = v277.Min.Y

                    if not (v278.Max.Y + 12 <= y) then
                        local v286
                        local v287 = v280.X - 16
                        v286 = v287

                        for _, v289 in {playButton.Instance, parent12, v262.Instance} do
                            if v289.Visible then
                                v286 = math.min(v286, ((v289.AbsolutePosition.X - ui2.AbsolutePosition.X) / v279) - 12)
                            end
                        end

                        local x2 = v277.Max.X + 12 - v278.Min.X

                        if v278.Max.X + x2 <= v286 then
                            return Vector2.new(x2, 0)
                        end

                        local v291 = if ui.Touch then v280.Y * 0.62 else v280.Y - 16
                        local y2 = v277.Max.Y + 12 - v278.Min.Y

                        if v278.Max.Y + y2 <= v291 then
                            return Vector2.new(0, y2)
                        end

                        return Vector2.new(math.max(0, v286 - v278.Max.X), 0)
                    end
                end
            end

            return Vector2.zero
        end

        v204 = function(a293)
            --[[
              name: applyShift
              line: 1041
              upvalues:
                v264 (copy, index: 1)
                vector2 (ref,  index: 2)
                v265 (copy, index: 3)
                ui2 (copy, index: 4)
                tweenService (copy, index: 5)
                tweenInfo (copy, index: 6)
            ]]
            for instance, v295 in v264 do
                local position = v295 + UDim2.fromOffset(vector2.X, vector2.Y)

                if const v297 = v265[instance] then
                    v297:Cancel()
                    v265[instance] = nil
                end

                if not a293 or not instance.Visible or not ui2.Visible then
                    instance.Position = position
                else
                    local tween = tweenService:Create(instance, tweenInfo, {Position = position})
                    v265[instance] = tween
                    tween:Play()
                end
            end
        end

        do
            local function redodge(a300)
                --[[
                  name: redodge
                  line: 1059
                  upvalues:
                    computeShift (copy, index: 1)
                    vector2 (ref,  index: 2)
                    v204 (copy, index: 3)
                ]]
                local vector22 = computeShift()

                if 1 < (vector22 - vector2).Magnitude then
                    vector2 = vector22
                    v204(a300)
                end
            end
        end

        local isBusy = false

        local function queueRedodge()
            --[[
              name: queueRedodge
              line: 1068
              upvalues:
                isBusy (ref,  index: 1)
                computeShift (copy, index: 2)
                vector2 (ref,  index: 3)
                v204 (copy, index: 4)
            ]]
            if isBusy then
                return
            end

            isBusy = true

            task.defer(
                function()
                    --[[
                      line: 1073
                      upvalues:
                        isBusy (ref,  index: 1)
                        computeShift (copy, index: 2)
                        vector2 (ref,  index: 3)
                        v204 (copy, index: 4)
                    ]]
                    isBusy = false
                    local vector22 = computeShift()

                    if 1 < (vector22 - vector2).Magnitude then
                        vector2 = vector22
                        v204(true)
                    end
                end
            )
        end

        local function place2(key, value)
            --[[
              name: place
              line: 1080
              upvalues:
                v264 (copy, index: 1)
                v265 (copy, index: 2)
                vector2 (ref,  index: 3)
                isBusy (ref,  index: 4)
                computeShift (copy, index: 5)
                v204 (copy, index: 6)
            ]]
            v264[key] = value

            if const v308 = v265[key] then
                v308:Cancel()
                v265[key] = nil
            end

            key.Position = value + UDim2.fromOffset(vector2.X, vector2.Y)

            if isBusy then
                return
            end

            isBusy = true

            task.defer(
                function()
                    --[[
                      line: 1073
                      upvalues:
                        isBusy (ref,  index: 1)
                        computeShift (copy, index: 2)
                        vector2 (ref,  index: 3)
                        v204 (copy, index: 4)
                    ]]
                    isBusy = false
                    local vector22 = computeShift()

                    if 1 < (vector22 - vector2).Magnitude then
                        vector2 = vector22
                        v204(true)
                    end
                end
            )
        end

        local v310 = nil
        local rowChanged = Signal.new()

        local function phoneRow()
            --[[
              name: phoneRow
              line: 1102
              upvalues:
                ui (copy, index: 1)
                ui2 (copy, index: 2)
                topbarSettings (copy, index: 3)
                guiService (copy, index: 4)
            ]]
            local v313, v314, v315
            local v316 = math.max(ui.Scale, 0.01)
            local v317 = ui2.AbsoluteSize / v316
            local absolutePosition = ui2.AbsolutePosition
            local v319 = topbarSettings.Last()
            local firstAncestorOfClass = v319:FindFirstAncestorOfClass("ScreenGui")

            if ui.DebugDevice or not firstAncestorOfClass or v319.AbsoluteSize.X < 1 then
                local v321 = ui.TopInset() - 4
                local button = topbarSettings.Button
                local v323 = if v319 ~= button and 0 < v319.AbsoluteSize.X and 0 < button.AbsoluteSize.X then math.max(0, v319.AbsolutePosition.X + v319.AbsoluteSize.X - (button.AbsolutePosition.X + button.AbsoluteSize.X)) / v316 else 0
                v313 = math.floor((v321 * 6) + v323)
                v314 = math.floor(v321 / 2)
                v315 = v317.X - 16
            else
                v313 = (v319.AbsolutePosition.X + v319.AbsoluteSize.X - absolutePosition.X) / v316 + 10
                v314 = (v319.AbsolutePosition.Y + (v319.AbsoluteSize.Y / 2) - absolutePosition.Y) / v316
                local topbarInset = guiService.TopbarInset
                v315 = if 0 < topbarInset.Width then (firstAncestorOfClass.AbsolutePosition.X + topbarInset.Max.X - absolutePosition.X) / v316 - 8 else v317.X - 16
            end

            local x = math.floor(v313)
            local y = math.floor((math.max(v314, 38)))
            local clampedValue = math.clamp((((math.min(v315, v317.X - 16) - x) - 280) - 20) / 440, 0.7, 1)
            local loadoutX = x + 280 + 10
            local loadoutW = math.floor(clampedValue * 196)
            local cardW = math.floor(clampedValue * 244)
            local restoreX = math.max(x, (math.min(loadoutX, ((((v317.X - 16) - 272) - 44) - 10) - 254)))

            return {h = 72, chipW = 280, restoreW = 254, x = x, y = y, loadoutX = loadoutX, loadoutW = loadoutW, cardX = (loadoutX + loadoutW) + 10, cardW = cardW, restoreX = restoreX, restoreY = (y + 36) + 8}
        end

        a7.LobbyColumn = {
            Place = place2,
            Shift = (function()
                --[[
                  name: Shift
                  line: 1152
                  upvalues:
                    vector2 (ref, index: 1)
                ]]
                return vector2
            end),
            Row = (function()
                --[[
                  name: Row
                  line: 1155
                  upvalues:
                    v310 (ref, index: 1)
                ]]
                return v310
            end),
            RowChanged = rowChanged
        }
        ui.ChatChanged:Connect(queueRedodge)

        ui2:GetPropertyChangedSignal("Visible"):Connect(
            function()
                --[[
                  line: 1161
                  upvalues:
                    computeShift (copy, index: 1)
                    vector2 (ref,  index: 2)
                    v264 (copy, index: 3)
                    v265 (copy, index: 4)
                ]]
                local vector22 = computeShift()

                if 1 < (vector22 - vector2).Magnitude then
                    vector2 = vector22

                    for v333, v334 in v264 do
                        local position = v334 + UDim2.fromOffset(vector2.X, vector2.Y)

                        if const v336 = v265[v333] then
                            v336:Cancel()
                            v265[v333] = nil
                        end

                        v333.Position = position
                    end
                end
            end
        )

        local mode = "idle"

        local function layout()
            --[[
              name: layout
              line: 1167
              upvalues:
                ui (copy, index: 1)
                phoneRow (copy, index: 2)
                v310 (ref,  index: 3)
                v18 (copy, index: 4)
                v104 (ref,  index: 5)
                layoutChip (copy, index: 6)
                v264 (copy, index: 7)
                v265 (copy, index: 8)
                vector2 (ref,  index: 9)
                isBusy (ref,  index: 10)
                computeShift (copy, index: 11)
                v204 (copy, index: 12)
                v162 (copy, index: 13)
                playButton (copy, index: 14)
                parent10 (copy, index: 15)
                parent12 (copy, index: 16)
                v262 (copy, index: 17)
                ui9 (copy, index: 18)
                ui10 (copy, index: 19)
                ui11 (copy, index: 20)
                ui12 (copy, index: 21)
                parent13 (copy, index: 22)
                v256 (copy, index: 23)
                mode (ref,  index: 24)
            ]]
            local v339 = ui.TopInset()

            if ui.Compact then
                local v340 = phoneRow()
                v310 = v340
                v18.AnchorPoint = Vector2.new(0, 0.5)
                v18.Size = UDim2.fromOffset(v340.chipW, v340.h)
                v104 = true
                layoutChip(true)
                local v341 = v18
                local udim2 = UDim2.fromOffset(v340.x, v340.y)
                v264[v341] = udim2

                if const v343 = v265[v341] then
                    v343:Cancel()
                    v265[v341] = nil
                end

                v341.Position = udim2 + UDim2.fromOffset(vector2.X, vector2.Y)

                if not isBusy then
                    isBusy = true

                    task.defer(
                        function()
                            --[[
                              line: 1073
                              upvalues:
                                isBusy (ref,  index: 1)
                                computeShift (copy, index: 2)
                                vector2 (ref,  index: 3)
                                v204 (copy, index: 4)
                            ]]
                            isBusy = false
                            local vector22 = computeShift()

                            if 1 < (vector22 - vector2).Magnitude then
                                vector2 = vector22
                                v204(true)
                            end
                        end
                    )
                end

                v162.Instance.AnchorPoint = Vector2.new(0, 0.5)
                v162.Instance.Size = UDim2.fromOffset(v340.loadoutW, v340.h)
                local instance = v162.Instance
                local udim22 = UDim2.fromOffset(v340.loadoutX, v340.y)
                v264[instance] = udim22

                if const v347 = v265[instance] then
                    v347:Cancel()
                    v265[instance] = nil
                end

                instance.Position = udim22 + UDim2.fromOffset(vector2.X, vector2.Y)

                if not isBusy then
                    isBusy = true

                    task.defer(
                        function()
                            --[[
                              line: 1073
                              upvalues:
                                isBusy (ref,  index: 1)
                                computeShift (copy, index: 2)
                                vector2 (ref,  index: 3)
                                v204 (copy, index: 4)
                            ]]
                            isBusy = false
                            local vector22 = computeShift()

                            if 1 < (vector22 - vector2).Magnitude then
                                vector2 = vector22
                                v204(true)
                            end
                        end
                    )
                end

                local v349 = math.max(v339, (v340.y + (v340.h / 2)) + 8)
                playButton.Instance.AnchorPoint = Vector2.new(1, 0)
                playButton.Instance.Position = UDim2.new(1, -16, 0, v349)
                playButton.Instance.Size = UDim2.fromOffset(240, 84)
                parent10.Position = UDim2.new(0.5, 0, 0, v339)
                parent12.AnchorPoint = Vector2.new(1, 0)
                parent12.Position = UDim2.new(1, -16, 0, v349)
                parent12.Size = UDim2.fromOffset(272, 84)
                v262.Instance.AnchorPoint = Vector2.new(1, 0)
                v262.Instance.Position = UDim2.new(1, -16, 0, v349 + 94)
                v262.Instance.Size = UDim2.fromOffset(272, 52)
                ui9.TextSize = 20
                ui10.TextSize = 26
                ui11.TextSize = 30
                ui12.TextSize = 17
                ui9.Position = UDim2.fromOffset(16, 11)
                ui9.Size = UDim2.new(1, -96, 0, 28)
                ui10.Position = UDim2.new(1, -16, 0, 7)
                ui10.Size = UDim2.fromOffset(76, 34)
                parent13.Position = UDim2.new(0, 16, 1, -18)
                ui12.Position = UDim2.new(1, -16, 1, -14)

                for _, v351 in v256 do
                    v351.Size = UDim2.fromOffset(14, 14)
                end

                parent13:FindFirstChildOfClass("UIListLayout").Padding = UDim.new(0, 5)

                return
            end

            local v352
            v310 = nil
            v18.AnchorPoint = Vector2.new(0, 1)
            v18.Size = UDim2.fromOffset(340, 78)
            v104 = false
            layoutChip(false)
            local v353 = v18
            local udim2 = UDim2.new(0, 24, 1, -24)
            v264[v353] = udim2

            if const v355 = v265[v353] then
                v355:Cancel()
                v265[v353] = nil
            end

            v353.Position = udim2 + UDim2.fromOffset(vector2.X, vector2.Y)

            if not isBusy then
                isBusy = true

                task.defer(
                    function()
                        --[[
                          line: 1073
                          upvalues:
                            isBusy (ref,  index: 1)
                            computeShift (copy, index: 2)
                            vector2 (ref,  index: 3)
                            v204 (copy, index: 4)
                        ]]
                        isBusy = false
                        local vector22 = computeShift()

                        if 1 < (vector22 - vector2).Magnitude then
                            vector2 = vector22
                            v204(true)
                        end
                    end
                )
            end

            v162.Instance.AnchorPoint = Vector2.new(0, 1)
            v162.Instance.Size = UDim2.fromOffset(340, 66)
            local instance = v162.Instance
            local v358 = UDim2.new(0, 24, 1, -114)
            v264[instance] = v358

            if const v359 = v265[instance] then
                v359:Cancel()
                v265[instance] = nil
            end

            instance.Position = v358 + UDim2.fromOffset(vector2.X, vector2.Y)

            if not isBusy then
                isBusy = true

                task.defer(
                    function()
                        --[[
                          line: 1073
                          upvalues:
                            isBusy (ref,  index: 1)
                            computeShift (copy, index: 2)
                            vector2 (ref,  index: 3)
                            v204 (copy, index: 4)
                        ]]
                        isBusy = false
                        local vector22 = computeShift()

                        if 1 < (vector22 - vector2).Magnitude then
                            vector2 = vector22
                            v204(true)
                        end
                    end
                )
            end

            playButton.Instance.AnchorPoint = Vector2.new(1, 1)
            playButton.Instance.Position = UDim2.new(1, -28, 1, -44)
            playButton.Instance.Size = UDim2.fromOffset(300, 96)
            parent10.Position = UDim2.new(0.5, 0, 0, v339)
            parent12.AnchorPoint = Vector2.new(1, 1)
            v358 = UDim2.new

            if mode ~= "search" then
                v352 = -44
                v352 = v256
            else
                v352 = -104
                v352 = v256
            end

            parent12.Position = v358(1, -28, 1, v352)
            parent12.Size = UDim2.fromOffset(300, 96)
            v262.Instance.AnchorPoint = Vector2.new(1, 1)
            v262.Instance.Position = UDim2.new(1, -28, 1, -40)
            v262.Instance.Size = UDim2.fromOffset(300, 54)
            ui9.TextSize = 24
            ui10.TextSize = 30
            ui11.TextSize = 36
            ui12.TextSize = 18
            ui9.Position = UDim2.fromOffset(18, 12)
            ui9.Size = UDim2.new(1, -120, 0, 28)
            ui10.Position = UDim2.new(1, -18, 0, 9)
            ui10.Size = UDim2.fromOffset(96, 34)
            parent13.Position = UDim2.new(0, 18, 1, -20)
            ui12.Position = UDim2.new(1, -18, 1, -16)

            for _, v362 in v352 do
                v362.Size = UDim2.fromOffset(16, 16)
            end

            parent13:FindFirstChildOfClass("UIListLayout").Padding = UDim.new(0, 6)
        end

        do
            local isBusy2 = false

            local function relayout()
                --[[
                  name: relayout
                  line: 1238
                  upvalues:
                    layout (copy, index: 1)
                    rowChanged (copy, index: 2)
                    v310 (ref,  index: 3)
                ]]
                layout()
                rowChanged:Fire(v310)
            end

            local function queueLayout()
                --[[
                  name: queueLayout
                  line: 1242
                  upvalues:
                    isBusy2 (ref,  index: 1)
                    layout (copy, index: 2)
                    rowChanged (copy, index: 3)
                    v310 (ref,  index: 4)
                ]]
                if isBusy2 then
                    return
                end

                isBusy2 = true

                task.defer(
                    function()
                        --[[
                          line: 1247
                          upvalues:
                            isBusy2 (ref,  index: 1)
                            layout (copy, index: 2)
                            rowChanged (copy, index: 3)
                            v310 (ref,  index: 4)
                        ]]
                        isBusy2 = false
                        layout()
                        rowChanged:Fire(v310)
                    end
                )
            end

            layout()
            rowChanged:Fire(v310)
            ui.LayoutChanged:Connect(relayout)
            ui.TopInsetChanged:Connect(relayout)
            ui.ScaleChanged:Connect(queueLayout)
            topbarSettings.Button:GetPropertyChangedSignal("AbsolutePosition"):Connect(queueLayout)
            topbarSettings.Button:GetPropertyChangedSignal("AbsoluteSize"):Connect(queueLayout)
            topbarSettings.HostButton:GetPropertyChangedSignal("Visible"):Connect(queueLayout)
            topbarSettings.NewsButton:GetPropertyChangedSignal("Visible"):Connect(queueLayout)
            topbarSettings.HostButton:GetPropertyChangedSignal("AbsolutePosition"):Connect(queueLayout)
            ui2:GetPropertyChangedSignal("AbsoluteSize"):Connect(queueLayout)
        end

        if a7.ToastAvoid then
            a7.ToastAvoid("TrainingBanner", parent10)
        end

        do
            local v366 = state.Level()

            local function refreshProfile()
                --[[
                  name: refreshProfile
                  line: 1269
                  upvalues:
                    state (copy, index: 1)
                    parent7 (copy, index: 2)
                    v366 (ref,  index: 3)
                    ui (copy, index: 4)
                    parent5 (copy, index: 5)
                    a7 (copy, index: 6)
                    numberValue (copy, index: 7)
                    theme (copy, index: 8)
                ]]
                local v368 = state.Level()
                local v369 = state.Xp()
                local v370 = state.XpToNext()
                parent7.Text = "LV " .. tostring(v368)

                if v366 < v368 then
                    ui.Pop(parent5, 1.5)
                    a7.Sounds.Play("LevelUp")
                end

                v366 = v368
                local tween = ui.Tween
                local slow = theme.Tween.Slow
                local v373 = {Value = if 0 < v370 then math.clamp(v369 / v370, 0, 1) else 0}
                tween(numberValue, slow, v373)
            end

            refreshProfile()
            state.ProfileChanged:Connect(refreshProfile)

            state.AttrChanged:Connect(
                function(a374)
                    --[[
                      line: 1283
                      upvalues:
                        refreshProfile (copy, index: 1)
                    ]]
                    if a374 == "Level" or a374 == "XP" then
                        refreshProfile()
                    end
                end
            )
        end

        local v375 = {}
        local localQueued = false
        local v377 = "3v3"
        local v378 = 0
        local timestamp = 0
        local cancelling = false
        local timestamp2 = 0
        local v382 = false

        do
            local function attrQueued()
                --[[
                  name: attrQueued
                  line: 1302
                  upvalues:
                    state (copy, index: 1)
                ]]
                return state.Get("Queued") == true
            end
        end

        do
            local function wantMode()
                --[[
                  name: wantMode
                  line: 1305
                  upvalues:
                    state (copy, index: 1)
                    cancelling (ref,  index: 2)
                    localQueued (ref,  index: 3)
                ]]
                if state.InMatch() then
                    return "idle"
                end
                if cancelling then
                    return "idle"
                end

                if state.Get("QueueFound") == true then
                    if state.Get("Queued") == true or localQueued then
                        return "found"
                    end
                end

                local v385 = state.Get("Queued") == true

                if not v385 and not localQueued then
                    return "idle"
                end

                return "search"
            end
        end

        do
            local function searchMode()
                --[[
                  name: searchMode
                  line: 1321
                  upvalues:
                    state (copy, index: 1)
                    v377 (ref,  index: 2)
                ]]
                local v387 = state.Get("QueueMode")

                if state.Get("Queued") == true and (v387 == "1v1" or v387 == "3v3") then
                    return v387
                end

                return v377
            end
        end

        do
            local function seatCount()
                --[[
                  name: seatCount
                  line: 1328
                  upvalues:
                    state (copy, index: 1)
                    v377 (ref,  index: 2)
                ]]
                local v389
                local v390 = state.Get("QueueMode")

                if state.Get("Queued") ~= true or v390 ~= "1v1" and v390 ~= "3v3" then
                    v389 = v377
                else
                    v389 = v390
                end

                if v389 == "1v1" then
                    return 2
                end

                return 6
            end
        end

        do
            local function queuedAt()
                --[[
                  name: queuedAt
                  line: 1331
                  upvalues:
                    state (copy, index: 1)
                    v378 (ref,  index: 2)
                ]]
                local v392 = state.Get("QueuedAt")
                local v393 = state.Get("Queued") == true

                if v393 and type(v392) == "number" and 0 < v392 then
                    return v392
                end

                return v378
            end
        end

        local function seatsFilled(a395: number, a396: number)
            --[[
              name: seatsFilled
              line: 1343
              upvalues:
                state (copy, index: 1)
                v377 (ref,  index: 2)
            ]]
            local v397
            local maxValue
            local v399 = state.Get("QueueFilled")
            local v400 = state.Get("QueueMode")

            if state.Get("Queued") ~= true or v400 ~= "1v1" and v400 ~= "3v3" then
                v397 = v377
            else
                v397 = v400
            end

            if v397 ~= "1v1" then
                maxValue = 6
            else
                maxValue = 2
            end

            if state.Get("Queued") == true and type(v399) == "number" and 1 <= v399 then
                return (math.clamp(math.floor(v399), 1, maxValue))
            end

            local random = Random.new(a396)
            local total = 0
            local v403 = 1

            while v403 < maxValue - 1 do
                total += random:NextNumber(0.35, 0.95) * (((v403 - 1) * 0.45) + 1)

                if a395 < total then
                    break
                end

                v403 += 1
            end

            return v403
        end

        local seats = 0

        local function paintSeats(a406, a407: boolean)
            --[[
              name: paintSeats
              line: 1362
              upvalues:
                state (copy, index: 1)
                v377 (ref,  index: 2)
                v258 (copy, index: 3)
                v256 (copy, index: 4)
                mode (ref,  index: 5)
                colors (copy, index: 6)
                backgroundColor3 (copy, index: 7)
                seats (ref,  index: 8)
                ui (copy, index: 9)
                theme (copy, index: 10)
                a7 (copy, index: 11)
                ui12 (copy, index: 12)
            ]]
            local v408
            local v409 = state.Get("QueueMode")

            if state.Get("Queued") ~= true or v409 ~= "1v1" and v409 ~= "3v3" then
                v408 = v377
            else
                v408 = v409
            end

            local v410 = v408 ~= "1v1" and 6 or 2
            v258.Visible = v410 == 2

            for v411, v412 in v256 do
                local v413
                v412.Visible = v411 <= v410
                local v414 = v411 <= a406

                if mode == "found" then
                    v413 = colors.Text
                else
                    v413 = if v414 then colors.Accent else backgroundColor3
                end

                if not a407 or not v414 or not (seats < v411) then
                    v412.BackgroundColor3 = v413
                else
                    v412.BackgroundColor3 = colors.Text
                    ui.Tween(v412, theme.Tween.Smooth, {BackgroundColor3 = v413})
                    ui.Pop(v412, 1.8)
                end
            end

            if a407 and seats < a406 and mode == "search" then
                a7.Sounds.Play("Tick", {pitch = (a406 * 0.06) + 0.9})
            end

            seats = a406
            ui12.Text = if ui.Compact then string.format("%d/%d", a406, v410) else string.format("%d/%d PLAYERS", a406, v410)
        end

        local tween = nil

        local function setScan(scan: boolean)
            --[[
              name: setScan
              line: 1385
              upvalues:
                tween (ref,  index: 1)
                instance2 (copy, index: 2)
                parent14 (copy, index: 3)
            ]]
            if scan and not tween then
                instance2.Position = UDim2.fromScale(-0.3, 0)
                local tween2 = game:GetService("TweenService"):Create(instance2, TweenInfo.new(1.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, false, 0.15), {Position = UDim2.fromScale(1, 0)})
                tween2:Play()
                tween = tween2
            elseif not scan and tween then
                tween:Cancel()
                tween = nil
            end

            parent14.Visible = scan
        end

        local function paintCard()
            --[[
              name: paintCard
              line: 1402
              upvalues:
                mode (ref,  index: 1)
                uiGradient (copy, index: 2)
                colors (copy, index: 3)
                uiStroke (copy, index: 4)
                ui9 (copy, index: 5)
                ui10 (copy, index: 6)
                ui11 (copy, index: 7)
                ui12 (copy, index: 8)
            ]]
            local visible = mode == "found"
            uiGradient.Color = if visible then ColorSequence.new(Color3.fromRGB(64, 168, 255), Color3.fromRGB(28, 132, 246)) else ColorSequence.new(colors.Panel, colors.PanelLo)
            uiStroke.Color = if visible then Color3.fromRGB(150, 210, 255) else colors.Accent
            uiStroke.Transparency = visible and 0.4 or 0.3
            ui9.Visible = not visible
            ui10.Visible = not visible
            ui11.Visible = visible
            ui12.TextColor3 = if visible then colors.Text else colors.TextDim
        end

        local function tick()
            --[[
              name: tick
              line: 1415
              upvalues:
                mode (ref,  index: 1)
                state (copy, index: 2)
                v378 (ref,  index: 3)
                ui10 (copy, index: 4)
                seatsFilled (copy, index: 5)
                seats (ref,  index: 6)
                paintSeats (copy, index: 7)
            ]]
            if mode == "idle" then
                return
            end

            local v422 = state.Get("QueuedAt")
            local v423 = if state.Get("Queued") == true and type(v422) == "number" and 0 < v422 then v422 else v378
            local v424 = math.max(0, state.Now() - v423)
            ui10.Text = string.format("%d:%02d", v424 // 60, math.floor(v424) % 60)

            if mode == "search" then
                local v425 = seatsFilled(v424, math.floor(v423 * 1000) % 2147483647)

                if v425 ~= seats then
                    paintSeats(v425, true)
                end
            end
        end

        local function applyMode(a427: boolean)
            --[[
              name: applyMode
              line: 1430
              upvalues:
                state (copy, index: 1)
                cancelling (ref,  index: 2)
                localQueued (ref,  index: 3)
                mode (ref,  index: 4)
                layout (copy, index: 5)
                playButton (copy, index: 6)
                v375 (copy, index: 7)
                parent12 (copy, index: 8)
                v262 (copy, index: 9)
                setScan (copy, index: 10)
                paintCard (copy, index: 11)
                seats (ref,  index: 12)
                paintSeats (copy, index: 13)
                ui (copy, index: 14)
                theme (copy, index: 15)
                tick (copy, index: 16)
                v377 (ref,  index: 17)
                v258 (copy, index: 18)
                v256 (copy, index: 19)
                backgroundColor3 (copy, index: 20)
                colors (copy, index: 21)
                ui12 (copy, index: 22)
                ui11 (copy, index: 23)
                a7 (copy, index: 24)
            ]]
            local v428

            if state.InMatch() then
                v428 = "idle"
            elseif cancelling then
                v428 = "idle"
            elseif state.Get("QueueFound") ~= true then
                v428 = state.Get("Queued") ~= true and not localQueued and "idle" or "search"
            elseif state.Get("Queued") == true or localQueued then
                v428 = "found"
            else
                v428 = state.Get("Queued") ~= true and not localQueued and "idle" or "search"
            end

            if v428 == mode then
                return
            end

            local v429 = mode
            mode = v428
            layout()
            local instance = playButton.Instance
            instance.Visible = mode == "idle" and next(v375) == nil
            parent12.Visible = mode ~= "idle"
            local instance2 = v262.Instance
            instance2.Visible = mode == "search"
            setScan(mode == "search")
            paintCard()

            if mode == "search" then
                if v429 == "idle" then
                    seats = 0
                    paintSeats(1, false)

                    if a427 then
                        local position = parent12.Position

                        if not ui.Compact then
                            parent12.Position = playButton.Instance.Position
                        end

                        ui.Pop(parent12, 0.92)
                        ui.Tween(parent12, theme.Tween.Smooth, {Position = position})
                        ui.Enter(v262.Instance, Vector2.new(0, 16), 0.08, v262.Instance.Position)
                    end
                end

                tick()

                return
            end

            if mode ~= "found" then
                if v429 ~= "idle" and a427 and not state.InMatch() then
                    ui.Pop(playButton.Instance, 0.92)
                end

                return
            end

            local v433
            tick()

            if not ui.Compact and v429 == "search" then
                local position = parent12.Position
                parent12.Position = UDim2.new(1, -28, 1, -104)
                ui.Tween(parent12, theme.Tween.Smooth, {Position = position})
            end

            local v435 = seats
            local v436 = state.Get("QueueMode")

            if state.Get("Queued") ~= true or v436 ~= "1v1" and v436 ~= "3v3" then
                v433 = v377
            else
                v433 = v436
            end

            local v437 = v433 ~= "1v1" and 6 or 2
            seats = v437
            v258.Visible = v437 == 2

            for v438, v439 in v256 do
                v439.Visible = v438 <= v437

                if v435 < v438 then
                    v439.BackgroundColor3 = backgroundColor3

                    task.delay(
                        (v438 - v435) * 0.06,
                        function()
                            --[[
                              line: 1475
                              upvalues:
                                mode (ref,  index: 1)
                                v439 (copy, index: 2)
                                colors (copy, index: 3)
                                ui (copy, index: 4)
                            ]]
                            if mode == "found" then
                                v439.BackgroundColor3 = colors.Text
                                ui.Pop(v439, 1.8)
                            end
                        end
                    )
                else
                    v439.BackgroundColor3 = colors.Text
                end
            end

            ui12.Text = if ui.Compact then string.format("%d/%d", v437, v437) else string.format("%d/%d PLAYERS", v437, v437)
            ui.Pop(parent12, 1.12)
            ui.Pop(ui11, 1.3)
            a7.Sounds.Play("Match_Found")

            if a7.MenuManager.IsOpen() then
                a7.MenuManager.CloseAll()
            end

            a7.MenuManager.EndHudFocus()
        end

        local function queue(a441)
            --[[
              name: queue
              line: 1501
              upvalues:
                v382 (ref,  index: 1)
                mode (ref,  index: 2)
                v375 (copy, index: 3)
                v377 (ref,  index: 4)
                localQueued (ref,  index: 5)
                v378 (ref,  index: 6)
                timestamp (ref,  index: 7)
                state (copy, index: 8)
                cancelling (ref,  index: 9)
                a7 (copy, index: 10)
                applyMode (copy, index: 11)
            ]]
            if v382 or mode ~= "idle" or next(v375) ~= nil then
                return
            end

            v382 = true
            v377 = a441 ~= "1v1" and "3v3" or "1v1"
            local v442 = state.Now()
            local timestamp2 = os.clock()
            localQueued = true
            v378 = v442
            timestamp = timestamp2
            cancelling = false
            a7.Sounds.Play("Queue_Join")
            applyMode(true)
            local v444 = a7.QueueAction("Queue", nil, nil, v377)
            v382 = false

            if not v444 then
                localQueued = false
                applyMode(true)
            end
        end

        local function cancel()
            --[[
              name: cancel
              line: 1518
              upvalues:
                mode (ref,  index: 1)
                cancelling (ref,  index: 2)
                timestamp2 (ref,  index: 3)
                localQueued (ref,  index: 4)
                a7 (copy, index: 5)
                applyMode (copy, index: 6)
            ]]
            if mode ~= "search" then
                return
            end

            local timestamp = os.clock()
            cancelling = true
            timestamp2 = timestamp
            localQueued = false
            a7.Sounds.Play("Queue_Leave")
            applyMode(true)

            if not a7.QueueAction("Cancel") then
                cancelling = false
                applyMode(true)
            end
        end

        do
            local function onPlay()
                --[[
                  name: onPlay
                  line: 1534
                  upvalues:
                    mode (ref,  index: 1)
                    v375 (copy, index: 2)
                    state (copy, index: 3)
                    a7 (copy, index: 4)
                    queue (copy, index: 5)
                ]]
                if mode ~= "idle" or next(v375) ~= nil then
                    return
                end

                if state.Get("Duel") == true then
                    a7.MenuManager.Open("Mode")
                    return
                end

                task.spawn(queue, "3v3")
            end

            playButton.Activated:Connect(onPlay)
        end

        v262.Activated:Connect(cancel)

        do
            local function padY()
                --[[
                  name: padY
                  line: 1548
                  upvalues:
                    state (copy, index: 1)
                ]]
                return state.Get("CombatMode") ~= true
            end
        end

        Keybinds.OnInput(
            "Began",
            function(a449)
                --[[
                  line: 1551
                  upvalues:
                    Keybinds (copy, index: 1)
                    a7 (copy, index: 2)
                    ui2 (copy, index: 3)
                    userInputService (copy, index: 4)
                    state (copy, index: 5)
                    mode (ref,  index: 6)
                    cancel (copy, index: 7)
                    playButton (copy, index: 8)
                    v375 (copy, index: 9)
                    queue (copy, index: 10)
                    v262 (copy, index: 11)
                    v162 (copy, index: 12)
                ]]
                local keyCode = a449.KeyCode
                local isPad = Keybinds.IsPad(a449, "Play")

                if not isPad and keyCode ~= Enum.KeyCode.DPadLeft and keyCode ~= Enum.KeyCode.DPadRight then
                    return
                end

                local menuManager = a7.MenuManager

                if not ui2.Visible
                    or menuManager.IsOpen()
                    or menuManager.HasFocus()
                    or userInputService:GetFocusedTextBox()
                then
                    return
                end

                local instance

                if isPad and state.Get("CombatMode") ~= true then
                    if menuManager.HudFocused()
                        and (keyCode == Enum.KeyCode.ButtonA
                            or keyCode == Enum.KeyCode.ButtonB
                            or string.sub(keyCode.Name, 1, 4) == "DPad")
                    then
                        return
                    end

                    if mode == "search" then
                        task.spawn(cancel)
                        return
                    end

                    if mode == "idle" and playButton.Instance.Visible and mode == "idle" then
                        if next(v375) ~= nil then
                            return
                        end

                        if state.Get("Duel") == true then
                            a7.MenuManager.Open("Mode")
                            return
                        end

                        task.spawn(queue, "3v3")
                    end

                    return
                end

                if keyCode ~= Enum.KeyCode.DPadLeft and keyCode ~= Enum.KeyCode.DPadRight then
                    return
                end
                if menuManager.HudFocused() then
                    return
                end

                local padUsedIn = Keybinds.PadUsedIn
                local v455 = state.Get("CombatMode") ~= true and "lobby" or "training"

                if padUsedIn(a449, v455) then
                    return
                end

                if v262.Instance.Visible then
                    instance = v262.Instance
                else
                    instance = if playButton.Instance.Visible then playButton.Instance else v162.Instance
                end

                local v456 = a7.Party and a7.Party.PadTarget and a7.Party.PadTarget()
                local hudFocus = menuManager.HudFocus
                local v458 = if keyCode == Enum.KeyCode.DPadLeft then v162.Instance else v456 or instance
                hudFocus(v458)
            end
        )

        do
            local function refreshPadY()
                --[[
                  name: refreshPadY
                  line: 1588
                  upvalues:
                    state (copy, index: 1)
                    parent9 (copy, index: 2)
                    parent15 (copy, index: 3)
                ]]
                local visible = state.Get("CombatMode") ~= true
                parent9.Visible = visible
                parent15.Visible = visible
            end
        end

        do
            local visible = state.Get("CombatMode") ~= true
            parent9.Visible = visible
            parent15.Visible = visible

            state.AttrChanged:Connect(
                function(a462)
                    --[[
                      line: 1594
                      upvalues:
                        state (copy, index: 1)
                        localQueued (ref,  index: 2)
                        cancelling (ref,  index: 3)
                        applyMode (copy, index: 4)
                        tick (copy, index: 5)
                    ]]
                    if a462 == "Queued" then
                        if state.Get("Queued") == true then
                            localQueued = false
                        else
                            cancelling = false
                        end
                    elseif a462 ~= "QueueFound" and a462 ~= "QueuedAt" and a462 ~= "QueueFilled" then
                        if a462 ~= "State" then
                            return
                        end
                    end

                    applyMode(true)
                    tick()
                end
            )

            ui.LayoutChanged:Connect(
                function()
                    --[[
                      line: 1607
                      upvalues:
                        paintSeats (copy, index: 1)
                        seats (ref,  index: 2)
                    ]]
                    paintSeats(seats, false)
                end
            )

            ui.Every(
                ui2,
                0.1,
                function()
                    --[[
                      line: 1610
                      upvalues:
                        localQueued (ref,  index: 1)
                        state (copy, index: 2)
                        v382 (ref,  index: 3)
                        timestamp (ref,  index: 4)
                        cancelling (ref,  index: 5)
                        timestamp2 (ref,  index: 6)
                        applyMode (copy, index: 7)
                        tick (copy, index: 8)
                    ]]
                    if localQueued and state.Get("Queued") ~= true and not v382 and 3 < os.clock() - timestamp then
                        localQueued = false
                    end

                    if cancelling and 2 < os.clock() - timestamp2 then
                        cancelling = false
                    end

                    applyMode(true)
                    tick()
                end
            )

            a7.Debug.queue = function(a463, a464)
                --[[
                  line: 1622
                  upvalues:
                    queue (copy, index: 1)
                    mode (ref,  index: 2)
                    v375 (copy, index: 3)
                    state (copy, index: 4)
                    a7 (copy, index: 5)
                    cancel (copy, index: 6)
                    seats (ref,  index: 7)
                    v377 (ref,  index: 8)
                    localQueued (ref,  index: 9)
                    cancelling (ref,  index: 10)
                ]]
                local v465
                local searchMode

                if a463 == "play" then
                    if a464 == "1v1" or a464 == "3v3" then
                        task.spawn(queue, a464)
                    elseif mode == "idle" and next(v375) == nil then
                        if state.Get("Duel") == true then
                            a7.MenuManager.Open("Mode")
                        else
                            task.spawn(queue, "3v3")
                        end
                    end
                elseif a463 == "cancel" then
                    task.spawn(cancel)
                end

                local v467 = {mode = mode, queued = state.Get("Queued"), queuedAt = state.Get("QueuedAt"), found = state.Get("QueueFound"), seats = seats}
                local v468 = state.Get("QueueMode")

                if state.Get("Queued") ~= true or v468 ~= "1v1" and v468 ~= "3v3" then
                    v465 = v377
                else
                    v465 = v468
                end

                v467.seatCount = v465 ~= "1v1" and 6 or 2
                local v469 = state.Get("QueueMode")

                if state.Get("Queued") ~= true or v469 ~= "1v1" and v469 ~= "3v3" then
                    searchMode = v377
                else
                    searchMode = v469
                end

                v467.searchMode = searchMode
                v467.localQueued = localQueued
                v467.cancelling = cancelling

                return v467
            end
        end

        do
            local function inTraining()
                --[[
                  name: inTraining
                  line: 1639
                  upvalues:
                    state (copy, index: 1)
                ]]
                return state.Get("CombatMode") == true and not state.InMatch()
            end
        end

        do
            local v471 = state.Get("CombatMode") == true and not state.InMatch()

            do
                local count2 = 0

                local function showZoneBanner(a474: boolean)
                    --[[
                      name: showZoneBanner
                      line: 1644
                      upvalues:
                        count2 (ref,  index: 1)
                        parent11 (copy, index: 2)
                        colors (copy, index: 3)
                        ui8 (copy, index: 4)
                        v245 (copy, index: 5)
                        ui (copy, index: 6)
                        parent10 (copy, index: 7)
                        a7 (copy, index: 8)
                    ]]
                    local v475
                    count2 += 1
                    local v476 = count2
                    parent11.Text = a474 and "TRAINING" or "LEFT TRAINING"
                    parent11.TextColor3 = if a474 then colors.Accent else colors.Text
                    ui8.Text = a474 and "COMBAT MODE  ·  WEAPONS OUT" or "WEAPONS STOWED"

                    if a474 then
                        v475 = colors.Accent
                        v475 = a7
                    else
                        v475 = colors.TextDim
                        v475 = a7
                    end

                    v245.ImageColor3 = v475
                    ui.Unfade(parent10)
                    parent10.Visible = true
                    ui.Enter(parent10, Vector2.new(0, -16))
                    ui.Pop(v245, 0.5)
                    local play = v475.Sounds.Play
                    local v478 = a474 and "Select" or "Close"
                    play(v478)
                    local taskDelay = task.delay
                    local v480 = a474 and 2.6 or 1.8

                    taskDelay(
                        v480,
                        function()
                            --[[
                              line: 1656
                              upvalues:
                                v476 (copy, index: 1)
                                count2 (ref,  index: 2)
                                ui (copy, index: 3)
                                parent10 (copy, index: 4)
                            ]]
                            if v476 ~= count2 then
                                return
                            end

                            ui.FadeOut(parent10)

                            task.delay(
                                0.3,
                                function()
                                    --[[
                                      line: 1661
                                      upvalues:
                                        v476 (copy, index: 1)
                                        count2 (ref,  index: 2)
                                        parent10 (copy, index: 3)
                                        ui (copy, index: 4)
                                    ]]
                                    if v476 == count2 then
                                        parent10.Visible = false
                                        ui.Unfade(parent10)
                                    end
                                end
                            )
                        end
                    )
                end

                a7.Debug.trainingBanner = function(a481)
                    --[[
                      line: 1669
                      upvalues:
                        showZoneBanner (copy, index: 1)
                    ]]
                    showZoneBanner(a481 ~= false)
                    return true
                end

                state.AttrChanged:Connect(
                    function(a482)
                        --[[
                          line: 1673
                          upvalues:
                            state (copy, index: 1)
                            parent9 (copy, index: 2)
                            parent15 (copy, index: 3)
                            v471 (ref,  index: 4)
                            showZoneBanner (copy, index: 5)
                        ]]
                        if a482 ~= "CombatMode" and a482 ~= "State" then
                            return
                        end

                        local visible = state.Get("CombatMode") ~= true
                        parent9.Visible = visible
                        parent15.Visible = visible
                        local v484 = state.Get("CombatMode") == true and not state.InMatch()

                        if v484 ~= v471 then
                            v471 = v484

                            if not state.InMatch() then
                                showZoneBanner(v484)
                            end
                        end
                    end
                )
            end
        end

        do
            local function refreshVisible()
                --[[
                  name: refreshVisible
                  line: 1688
                  upvalues:
                    ui2 (copy, index: 1)
                    state (copy, index: 2)
                    a7 (copy, index: 3)
                    topbarSettings (copy, index: 4)
                ]]
                local visible = not state.SeesMatch() and not a7.HudHidden
                ui2.Visible = visible
                topbarSettings.SetNewsVisible(not state.SeesMatch())

                if not ui2.Visible then
                    a7.MenuManager.EndHudFocus()
                end
            end

            local visible = not state.SeesMatch() and not a7.HudHidden
            ui2.Visible = visible
            topbarSettings.SetNewsVisible(not state.SeesMatch())

            if not ui2.Visible then
                a7.MenuManager.EndHudFocus()
            end

            state.PlayerStateChanged:Connect(refreshVisible)
            state.WatchChanged:Connect(refreshVisible)
            a7.HudHiddenChanged:Connect(refreshVisible)
            a7.LobbyHud = {
                Root = ui2,
                PlayButton = playButton,
                Chip = v18,
                StreakSlot = streakSlot,
                SetPlayHidden = (function(key, a489)
                    --[[
                      name: SetPlayHidden
                      line: 1709
                      upvalues:
                        v375 (copy, index: 1)
                        playButton (copy, index: 2)
                        mode (ref,  index: 3)
                    ]]
                    v375[key] = a489 and true or nil
                    local instance = playButton.Instance
                    local visible = mode == "idle" and next(v375) == nil
                    instance.Visible = visible
                end),
                Queue = (function(a492)
                    --[[
                      name: Queue
                      line: 1715
                      upvalues:
                        queue (copy, index: 1)
                    ]]
                    task.spawn(queue, a492)
                end),
                DuelOn = (function()
                    --[[
                      name: duelOn
                      line: 396
                      upvalues:
                        state (copy, index: 1)
                    ]]
                    return state.Get("Duel") == true
                end),
                CanPlay = (function()
                    --[[
                      name: CanPlay
                      line: 1719
                      upvalues:
                        mode (ref,  index: 1)
                        v375 (copy, index: 2)
                    ]]
                    return mode == "idle" and next(v375) == nil
                end)
            }
        end
    end)
}