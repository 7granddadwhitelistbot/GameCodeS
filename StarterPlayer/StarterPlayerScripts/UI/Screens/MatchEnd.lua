local players = game:GetService("Players")
local RankArt = require(script.Parent.Parent.RankArt)

return {
    Init = (function(a3)
        --[[
          name: Init
          line: 35
          upvalues:
            players (copy, index: 1)
            RankArt (copy, index: 2)
        ]]
        local ui = a3.UI
        local theme = a3.Theme
        local state = a3.State
        local portraits = a3.Portraits
        local weaponIcon = a3.WeaponIcon
        local colors = theme.Colors
        local fonts = theme.Fonts
        local localPlayer = players.LocalPlayer
        local ui2 = ui.new("TextButton", {Name = "MatchEndDim", BackgroundTransparency = 1, Visible = false, Modal = true, Selectable = false, Size = UDim2.fromScale(1, 1), BackgroundColor3 = colors.Void, Parent = a3.Canvas.Backdrop})
        local parent = ui.new("Frame", {Name = "MatchEnd", Visible = false, Size = UDim2.fromScale(1, 1), Parent = a3.Canvas.Menus})
        local parent2 = ui.new("Frame", {Name = "Content", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1200, 744), Parent = parent})
        local scaleObj = ui.GetScaleObj(parent2, "FitScale")
        local v16 = ui.CanvasSize()
        scaleObj.Scale = math.min(1, (v16.X - 24) / 1200, (v16.Y - 12) / 744)

        ui.ScaleChanged:Connect(
            function()
                --[[
                  name: applyFit
                  line: 60
                  upvalues:
                    ui (copy, index: 1)
                    scaleObj (copy, index: 2)
                ]]
                local v17 = ui.CanvasSize()
                scaleObj.Scale = math.min(1, (v17.X - 24) / 1200, (v17.Y - 12) / 744)
            end
        )

        local v18 = ui.DisplayText({Name = "Title", Text = "VICTORY", TextSize = 110, StrokeThickness = 5, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 0), Size = UDim2.fromOffset(900, 110), TextColor3 = colors.Accent, Parent = parent2})
        v16 = ui.Pill("1V1", colors.Accent, {Name = "ModeTag", Height = 26, TextSize = 17, PadX = 10, ZIndex = 3, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(0.5, -200, 0, 126), Parent = parent2})
        v16.Visible = false
        local parent3 = ui.new("TextLabel", {Name = "Score", Text = "", TextSize = 30, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 108), Size = UDim2.fromOffset(900, 36), FontFace = fonts.Title, TextColor3 = colors.Text, Parent = parent2})
        ui.TextStroke(colors.Void, 2.5, 0.1).Parent = parent3

        local function placeModeTag()
            --[[
              name: placeModeTag
              line: 105
              upvalues:
                parent3 (copy, index: 1)
                v16 (copy, index: 2)
            ]]
            local v21 = if 0 < parent3.Size.X.Offset and 0 < parent3.AbsoluteSize.X then parent3.AbsoluteSize.X / parent3.Size.X.Offset else 1
            v16.Position = UDim2.new(0.5, -math.ceil((parent3.TextBounds.X / v21) / 2) - 14, 0, 126)
        end

        parent3:GetPropertyChangedSignal("TextBounds"):Connect(placeModeTag)
        parent3:GetPropertyChangedSignal("AbsoluteSize"):Connect(placeModeTag)
        local parent4 = ui.new("Frame", {Name = "RoundPips", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 144), Size = UDim2.fromOffset(300, 10), Parent = parent2})

        local function paintPips(score, score2, clampedValue: number)
            --[[
              name: paintPips
              line: 120
              upvalues:
                parent4 (copy, index: 1)
                colors (copy, index: 2)
                ui (copy, index: 3)
            ]]
            parent4:ClearAllChildren()

            for index = 1, 2 do
                local score3 = if index == 1 then score else score2
                local v29 = if index == 1 then colors.Ally else colors.Enemy

                for index2 = 1, clampedValue do
                    local newUi = ui.new
                    local v32 = {AnchorPoint = Vector2.new(0.5, 0)}
                    local newUDim2 = UDim2.new
                    local v34 = if index == 1 then -30 - (index2 - 1) * 22 else (index2 - 1) * 22 + 30
                    v32.Position = newUDim2(0.5, v34, 0, 0)
                    v32.Size = UDim2.fromOffset(18, 10)
                    v32.BackgroundColor3 = if index2 <= score3 then v29 else Color3.fromRGB(52, 56, 68)
                    v32[1] = (ui.Corner(3))
                    v32.Parent = parent4
                    newUi("Frame", v32)
                end
            end
        end

        local parent5 = ui.Panel({Name = "Board", BackgroundTransparency = 0.1, Position = UDim2.fromOffset(0, 160), Size = UDim2.fromOffset(700, 420), Trim = colors.Accent, Parent = parent2})
        local parent6 = ui.new("Frame", {Name = "Header", Position = UDim2.fromOffset(20, 12), Size = UDim2.new(1, -40, 0, 22), Parent = parent5})
        local v37 = {{"K", 400}, {"D", 470}, {"A", 530}, {"DMG", 600}}
        ui.new("TextLabel", {Text = "FIGHTER", TextSize = 15, Size = UDim2.fromOffset(300, 22), FontFace = fonts.Heavy, TextColor3 = colors.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent6})

        for _, v39 in v37 do
            ui.new("TextLabel", {TextSize = 15, Position = UDim2.fromOffset(v39[2] - 20, 0), Size = UDim2.fromOffset(70, 22), Text = v39[1], FontFace = fonts.Heavy, TextColor3 = colors.TextMuted, Parent = parent6})
        end

        local v40 = {}

        for index = 1, 6 do
            local v42 = (index - 1) * 60 + 42
            local v43 = not (3 < index) and 0 or 10
            local v44 = v42 + v43
            local ui3 = ui.new("Frame", {Name = "Row" .. index, Position = UDim2.fromOffset(12, v44), Size = UDim2.new(1, -24, 0, 54), Parent = parent5})
            local ui4 = ui.new("Frame", {Name = "Inner", Size = UDim2.fromScale(1, 1), BackgroundColor3 = colors.Void, BackgroundTransparency = 0.45, (ui.Corner(10)), Parent = ui3})
            local stroke = ui.Stroke(colors.Accent, 2.5, 0)
            stroke.Parent = ui4
            local img = ui.new("ImageLabel", {Name = "Img", Position = UDim2.fromOffset(6, 5), Size = UDim2.fromOffset(44, 44), BackgroundColor3 = colors.Raised, ScaleType = Enum.ScaleType.Crop, (ui.Corner(theme.Radius.Pill)), Parent = ui4})
            local name = ui.new("TextLabel", {Name = "Name", AutoLocalize = false, Text = "", TextSize = 22, Position = UDim2.fromOffset(60, 0), Size = UDim2.fromOffset(250, 54), FontFace = fonts.Heavy, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = ui4})
            local star = ui.Image(ui.Assets.Icons.Star, {Name = "Mvp", Visible = false, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 318, 0.5, 0), Size = UDim2.fromOffset(26, 26), ImageColor3 = colors.Gold, Parent = ui4})
            local cells = {}

            for v52, v53 in v37 do
                cells[v52] = ui.new("TextLabel", {Text = "0", TextSize = 24, Position = UDim2.fromOffset(v53[2] - 32, 0), Size = UDim2.fromOffset(70, 54), FontFace = fonts.Display, TextColor3 = colors.Text, Parent = ui4})
            end

            v40[index] = {frame = ui3, inner = ui4, stroke = stroke, img = img, name = name, star = star, cells = cells, rankPip = RankArt.Emblem(1, 24, {ZIndex = 3, Position = UDim2.fromOffset(32, 30), Parent = ui4})}
        end

        local parent7 = ui.new("Frame", {Name = "Vs", Visible = false, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.new(1, -60, 0, 24), Parent = parent5})

        for x = 0, 1 do
            local newUi = ui.new
            local v57 = {AnchorPoint = Vector2.new(x, 0.5), Position = UDim2.fromScale(x, 0.5), Size = UDim2.new(0.5, -34, 0, 2), BackgroundColor3 = colors.Divider}
            local gradient = ui.Gradient
            local color3 = Color3.new(1, 1, 1)
            local color32 = Color3.new(1, 1, 1)
            local newNumberSequence = NumberSequence.new
            local v62 = x ~= 0 and 0.2 or 1
            local v63 = x ~= 0 and 1 or 0.2
            v57[1] = (gradient(color3, color32, 0, newNumberSequence(v62, v63)))
            v57.Parent = parent7
            newUi("Frame", v57)
        end

        ui.new("TextLabel", {Name = "Text", Text = "VS", TextSize = 22, Size = UDim2.fromScale(1, 1), FontFace = fonts.Display, TextColor3 = colors.TextMuted, Parent = parent7})

        local function layoutRows(visible: boolean)
            --[[
              name: layoutRows
              line: 246
              upvalues:
                parent5 (copy, index: 1)
                v40 (copy, index: 2)
                parent7 (copy, index: 3)
            ]]
            local v66 = visible and 84 or 54
            local v67 = visible and 66 or 44
            local v68 = math.floor((((parent5.Size.Y.Offset - 42) - 12) - 212) / 2) + 42

            for v69, v70 in v40 do
                local v71
                local v72

                if visible then
                    v71 = if v69 <= 3 then v68 else v68 + 84 + 44
                else
                    local v73 = (v69 - 1) * 60 + 42
                    local v74 = not (3 < v69) and 0 or 10
                    v71 = v73 + v74
                end

                v70.frame.Position = UDim2.fromOffset(12, v71)
                v70.frame.Size = UDim2.new(1, -24, 0, v66)
                v70.img.Size = UDim2.fromOffset(v67, v67)
                local img = v70.img
                local udim2FromOffset = UDim2.fromOffset
                local v77 = visible and 9 or 6
                img.Position = udim2FromOffset(v77, (math.floor((v66 - v67) / 2)))
                local name = v70.name
                udim2FromOffset = UDim2.fromOffset

                if visible then
                    v72 = 22
                else
                    v72 = 16
                end

                name.Position = udim2FromOffset(v67 + v72, 0)
                local name2 = v70.name
                udim2FromOffset = UDim2.fromOffset
                local v80 = visible and 226 or 250
                name2.Size = udim2FromOffset(v80, v66)
                v70.name.TextSize = visible and 27 or 22

                for _, cell in v70.cells do
                    cell.Size = UDim2.fromOffset(70, v66)
                    cell.TextSize = visible and 30 or 24
                end

                local v83 = visible and 30 or 24
                v70.rankPip.Size = UDim2.fromOffset(v83, v83)
                v70.rankPip.Position = if visible then UDim2.fromOffset(((v67 + 9) - v83) + 6, ((math.floor((v66 - v67) / 2) + v67) - v83) + 4) else UDim2.fromOffset(32, 30)
            end

            parent7.Visible = visible
            parent7.Position = UDim2.new(0.5, 0, 0, (v68 + 84) + 22)
        end

        local parent8 = ui.new("Frame", {Name = "Right", Position = UDim2.fromOffset(720, 160), Size = UDim2.fromOffset(480, 420), Parent = parent2})
        local parent9 = ui.Panel({Name = "Mvp", BackgroundTransparency = 0.1, StrokeTransparency = 0.4, Size = UDim2.fromOffset(480, 118), StrokeColor = colors.Gold, Parent = parent8})
        local ui5 = ui.new("ImageLabel", {Name = "Img", Position = UDim2.fromOffset(12, 12), Size = UDim2.fromOffset(94, 94), BackgroundColor3 = colors.Raised, ScaleType = Enum.ScaleType.Crop, ui.Corner(theme.Radius.Pill), (ui.Stroke(colors.Gold, 3, 0.1)), Parent = parent9})
        ui.Image(ui.Assets.Icons.Star, {Position = UDim2.fromOffset(122, 12), Size = UDim2.fromOffset(28, 28), ImageColor3 = colors.Gold, Parent = parent9})
        ui.DisplayText({Text = "MVP", TextSize = 30, StrokeThickness = 2, Position = UDim2.fromOffset(156, 10), Size = UDim2.fromOffset(200, 32), TextColor3 = colors.Gold, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent9})
        local parent10 = ui.new("TextLabel", {Name = "Name", AutoLocalize = false, Text = "", TextSize = 28, Position = UDim2.fromOffset(122, 44), Size = UDim2.fromOffset(340, 32), FontFace = fonts.Heavy, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = parent9})
        ui.TextStroke(colors.Void, 1.5, 0.3).Parent = parent10
        local ui6 = ui.new("TextLabel", {Name = "Stats", Text = "", TextSize = 18, Position = UDim2.fromOffset(122, 78), Size = UDim2.fromOffset(340, 24), FontFace = fonts.Bold, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent9})
        local parent11 = ui.Panel({Name = "Rewards", BackgroundTransparency = 0.1, Position = UDim2.fromOffset(0, 130), Size = UDim2.fromOffset(480, 290), Trim = colors.Accent, Parent = parent8})
        local v90, v91 = ui.LevelBadge(1, 78, {Position = UDim2.fromOffset(12, 14), Parent = parent11})
        local v92 = ui.DisplayText({Name = "LevelWord", Text = "LEVEL 1", TextSize = 28, StrokeThickness = 2, Position = UDim2.fromOffset(100, 14), Size = UDim2.fromOffset(260, 32), TextXAlignment = Enum.TextXAlignment.Left, Parent = parent11})
        local v93 = ui.DisplayText({Name = "XpGain", Text = "+0 XP", TextSize = 26, StrokeThickness = 2, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -16, 0, 16), Size = UDim2.fromOffset(160, 30), TextColor3 = colors.Xp, TextXAlignment = Enum.TextXAlignment.Right, Parent = parent11})
        local v94 = ui.Bar({Name = "XpBar", Position = UDim2.fromOffset(100, 54), Size = UDim2.new(1, -116, 0, 18), Color = colors.Xp, Parent = parent11})
        local ui7 = ui.new("TextLabel", {Name = "XpText", Text = "", TextSize = 15, Position = UDim2.fromOffset(100, 74), Size = UDim2.new(1, -116, 0, 18), FontFace = fonts.Bold, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent11})
        local v96 = ui.DisplayText({Name = "LevelUp", Text = "LEVEL UP!", TextSize = 44, StrokeThickness = 3, Visible = false, ZIndex = 5, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(240, 62), Size = UDim2.fromOffset(300, 50), TextColor3 = colors.Accent, Parent = parent11})
        local parent12 = ui.new("Frame", {Name = "Streak", Visible = false, Position = UDim2.fromOffset(16, 108), Size = UDim2.fromOffset(220, 44), Parent = parent11})
        ui.Image(ui.Assets.Icons.Fire, {Size = UDim2.fromOffset(40, 40), Parent = parent12})
        local v98 = ui.DisplayText({Text = "3 WIN STREAK", TextSize = 26, StrokeThickness = 2, Position = UDim2.fromOffset(44, 4), Size = UDim2.new(1, -44, 0, 36), TextColor3 = colors.Warning, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent12})
        local ui8 = ui.new("TextLabel", {Name = "Glory", Text = "", TextSize = 16, TextWrapped = true, Visible = false, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -16, 0, 108), Size = UDim2.fromOffset(220, 40), FontFace = fonts.Bold, TextColor3 = Color3.fromRGB(255, 196, 80), TextXAlignment = Enum.TextXAlignment.Right, Parent = parent11})
        local newUi = ui.new
        local newUi2 = ui.new
        local v102 = {Name = "Grid", CellSize = UDim2.new(0.5, -6, 0, 22), CellPadding = UDim2.fromOffset(12, 3), SortOrder = Enum.SortOrder.LayoutOrder}
        local parent13 = newUi("Frame", {Name = "Lines", Position = UDim2.fromOffset(16, 162), Size = UDim2.new(1, -32, 0, 104), (newUi2("UIGridLayout", v102)), Parent = parent11})
        local RankArt2 = require(script.Parent.Parent.RankArt)
        local ranks = RankArt2.Ranks
        local parent14 = ui.new("Frame", {Name = "Trophies", Visible = false, Position = UDim2.fromOffset(16, 102), Size = UDim2.new(1, -32, 0, 44), Parent = parent11})
        local v107 = RankArt2.Emblem(1, 44, {Parent = parent14})
        local ui9 = ui.new("TextLabel", {Name = "Rank", Position = UDim2.fromOffset(54, 0), Size = UDim2.fromOffset(230, 22), Text = "", FontFace = fonts.Display, TextSize = 20, TextColor3 = colors.Text, TextXAlignment = Enum.TextXAlignment.Left, (ui.TextStroke(colors.Void, 1.5, 0.4)), Parent = parent14})
        local v109 = ui.Bar({Name = "Bar", Position = UDim2.fromOffset(54, 24), Size = UDim2.fromOffset(220, 9), Color = colors.Gold, Parent = parent14})
        local ui10 = ui.new("TextLabel", {Name = "Next", Text = "", TextSize = 12, Position = UDim2.fromOffset(54, 33), Size = UDim2.fromOffset(220, 14), FontFace = fonts.SemiBold, TextColor3 = colors.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent14})
        local v111 = ui.DisplayText({Name = "Delta", Text = "+0", TextSize = 26, StrokeThickness = 2, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 0, 0, -3), Size = UDim2.fromOffset(120, 28), TextColor3 = colors.Success, TextXAlignment = Enum.TextXAlignment.Right, Parent = parent14})
        local flooredValue = 50

        pcall(
            function()
                --[[
                  line: 485
                  upvalues:
                    flooredValue (ref, index: 1)
                ]]
                local Config = require(game:GetService("ReplicatedStorage").Shared.Config)

                if const number = tonumber(Config.DUEL_TROPHY_MULT) then
                    flooredValue = math.floor((number * 100) + 0.5)
                end
            end
        )

        local v115 = ui.Pill(string.format("1V1  ·  %d%%", flooredValue), Color3.fromRGB(64, 48, 14), {Name = "Duel", Height = 22, TextSize = 14, PadX = 8, TextColor = colors.Gold, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -64, 0, 1), Parent = parent14})
        v115.Visible = false
        local v116 = false
        local parent15 = ui.new("Frame", {Name = "Count", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 0, 0, 24), Size = UDim2.fromOffset(150, 20), (ui.List(Enum.FillDirection.Horizontal, 4, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center)), Parent = parent14})
        RankArt2.Trophy(20, {LayoutOrder = 1, Parent = parent15})
        local ui11 = ui.new("TextLabel", {Name = "N", Text = "0", TextSize = 20, LayoutOrder = 2, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 22), FontFace = fonts.Display, TextColor3 = colors.Text, Parent = parent15})
        local v119 = ui.CountUp(
            ui11,
            function(a120)
                --[[
                  line: 524
                  upvalues:
                    ui (copy, index: 1)
                ]]
                return ui.FormatNumber(a120)
            end,
            1
        )

        local function paintRank(number: number?, a123: boolean)
            --[[
              name: paintRank
              line: 528
              upvalues:
                ranks (copy, index: 1)
                RankArt2 (copy, index: 2)
                v107 (copy, index: 3)
                ui9 (copy, index: 4)
                v109 (copy, index: 5)
                ui10 (copy, index: 6)
                ui (copy, index: 7)
            ]]
            local v124, v125, v126 = ranks.Progress(number)
            local textColor3 = RankArt2.Color(v124)
            RankArt2.SetEmblem(v107, v124)
            ui9.Text = string.upper(ranks.Get(v124).name)
            ui9.TextColor3 = textColor3
            v109.SetColor(textColor3)
            local set = v109.Set
            local v129 = not v126 and 1 or v125 / v126
            set(v129, a123, TweenInfo.new(0.9, Enum.EasingStyle.Quad))
            ui10.Text = not v126 and "TOP RANK"
                or string.format("%s / %s to %s", ui.FormatNumber(v125), ui.FormatNumber(v126), string.upper(ranks.Get(v124 + 1).name))
        end

        local economy = a3.Economy
        local parent16 = ui.new("Frame", {Name = "Economy", Position = UDim2.fromOffset(0, 592), Size = UDim2.fromOffset(1200, 58), Parent = parent2})
        local parent17 = ui.new("TextButton", {Name = "Drop", Visible = false, Size = UDim2.fromOffset(700, 58), Parent = parent16})
        ui.Panel({Name = "Bg", BackgroundTransparency = 0.1, Size = UDim2.fromScale(1, 1), Parent = parent17})
        local scaleObj2 = ui.GetScaleObj(parent17, "HoverScale")
        local v134 = ui.Image(ui.Assets.Fx.Gem, {AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 12, 0.5, 0), Size = UDim2.fromOffset(34, 34), ImageColor3 = colors.Accent, Parent = parent17})
        local ui12 = ui.new("TextLabel", {Name = "Title", Text = "DROP", TextSize = 18, Position = UDim2.fromOffset(54, 8), Size = UDim2.fromOffset(170, 22), FontFace = fonts.Heavy, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = parent17})
        local ui13 = ui.new("TextLabel", {Name = "Sub", Text = "", TextSize = 14, Position = UDim2.fromOffset(54, 30), Size = UDim2.fromOffset(170, 18), FontFace = fonts.Bold, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent17})
        local parent18 = ui.new("Frame", {Name = "Cards", Position = UDim2.fromOffset(222, 5), Size = UDim2.new(1, -230, 0, 48), (ui.List(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)), Parent = parent17})
        local v138 = {}

        local function dTile(layoutOrder: number)
            --[[
              name: dTile
              line: 578
              upvalues:
                v138 (copy, index: 1)
                ui (copy, index: 2)
                parent18 (copy, index: 3)
                colors (copy, index: 4)
                fonts (copy, index: 5)
            ]]
            if const v141 = v138[layoutOrder] then
                return v141
            end

            local ui2 = ui.new("Frame", {Name = "Card" .. layoutOrder, Size = UDim2.fromOffset(92, 48), LayoutOrder = layoutOrder, Parent = parent18})
            local parent = ui.new("Frame", {Name = "Tile", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 0, 0.5, 0), Size = UDim2.fromOffset(44, 44), BackgroundColor3 = Color3.new(1, 1, 1), (ui.Corner(9)), Parent = ui2})
            local grad = ui.Gradient(colors.Accent, colors.Panel, 115)
            grad.Parent = parent
            local icon = ui.new("Frame", {Name = "Icon", ZIndex = 2, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.94, 0.94), Parent = parent})
            local count = ui.new("TextLabel", {Name = "N", Text = "x0", TextSize = 20, Position = UDim2.fromOffset(49, 2), Size = UDim2.fromOffset(44, 24), FontFace = fonts.Display, TextXAlignment = Enum.TextXAlignment.Left, Parent = ui2})
            local v147 = {frame = ui2, grad = grad, icon = icon, count = count, tag = ui.new("TextLabel", {Name = "Tag", Text = "", TextSize = 12, Position = UDim2.fromOffset(49, 26), Size = UDim2.fromOffset(50, 16), FontFace = fonts.Heavy, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Left, Parent = ui2})}
            v138[layoutOrder] = v147

            return v147
        end

        local drop2 = nil

        local function paintDrop(drop)
            --[[
              name: paintDrop
              line: 596
              upvalues:
                drop2 (ref,  index: 1)
                a3 (copy, index: 2)
                parent17 (copy, index: 3)
                colors (copy, index: 4)
                v134 (copy, index: 5)
                ui12 (copy, index: 6)
                ui13 (copy, index: 7)
                v138 (copy, index: 8)
                weaponIcon (copy, index: 9)
                dTile (copy, index: 10)
                economy (copy, index: 11)
                theme (copy, index: 12)
            ]]
            local v151
            local v152
            drop2 = drop
            local dropReveal = a3.DropReveal
            local v154 = if dropReveal and dropReveal.Normalize then dropReveal.Normalize(drop) else nil
            parent17.Visible = (v154 ~= nil) and (0 < #v154.stacks)

            if not v154 then
                return
            end

            if v154.kind ~= "golden" then
                v151 = if v154.kind == "victory" then colors.Accent else Color3.fromRGB(150, 180, 226)
            else
                v151 = colors.Gold
            end

            v134.ImageColor3 = v151
            ui12.Text = (v154.kind ~= "golden" and (v154.kind ~= "victory" and "DROP" or "VICTORY DROP"))
                or "GOLDEN DROP"
            ui12.TextColor3 = v151:Lerp(Color3.new(1, 1, 1), 0.35)
            local v155 = 0
            v152 = v155

            for _, stack in v154.stacks do
                v152 += stack.shards
            end

            ui13.Text = string.format("+%d shards", v152)

            for stackKey = 1, math.max(#v154.stacks, #v138) do
                local stack = v154.stacks[stackKey]

                if 5 < stackKey or not stack then
                    if const v160 = v138[stackKey] then
                        v160.frame.Visible = false
                        weaponIcon.Set(v160.icon, nil)
                    end
                else
                    local v161 = dTile(stackKey)
                    local v162 = if economy and economy.CategoryColor then economy.CategoryColor(stack.item) else colors.Accent
                    v161.frame.Visible = true
                    v161.grad.Color = ColorSequence.new(v162:Lerp(colors.Panel, 0.5), colors.PanelHi:Lerp(colors.Panel, 0.6))
                    weaponIcon.Set(v161.icon, stack.item, {outline = false, glow = false})
                    v161.count.Text = "x" .. stack.shards

                    if stack.unlocked then
                        v161.tag.Text = "NEW"
                        v161.tag.TextColor3 = colors.Gold
                    elseif stack.ready then
                        v161.tag.Text = "UPGRADE"
                        v161.tag.TextColor3 = theme.Lighten(colors.Success, 0.15)
                    elseif not (stack.levelBefore <= 0) then
                        v161.tag.Text = "LV " .. stack.levelBefore
                        v161.tag.TextColor3 = colors.TextDim
                    else
                        v161.tag.Text = string.format("%d/%d", stack.total, (stack.need or 0))
                        v161.tag.TextColor3 = colors.TextMuted
                    end
                end
            end
        end

        parent17.MouseEnter:Connect(
            function()
                --[[
                  line: 644
                  upvalues:
                    ui (copy, index: 1)
                    scaleObj2 (copy, index: 2)
                    theme (copy, index: 3)
                ]]
                if not ui.Touch then
                    ui.Tween(scaleObj2, theme.Tween.PopSmall, {Scale = 1.02})
                end
            end
        )

        parent17.MouseLeave:Connect(
            function()
                --[[
                  line: 649
                  upvalues:
                    ui (copy, index: 1)
                    scaleObj2 (copy, index: 2)
                    theme (copy, index: 3)
                ]]
                ui.Tween(scaleObj2, theme.Tween.Fast, {Scale = 1})
            end
        )

        parent17.Activated:Connect(
            function()
                --[[
                  line: 652
                  upvalues:
                    a3 (copy, index: 1)
                    drop2 (ref,  index: 2)
                ]]
                local dropReveal = a3.DropReveal

                if drop2 and dropReveal and not dropReveal.IsPlaying() then
                    a3.Sounds.Play("Click")
                    dropReveal.ShowSummary(drop2, {source = "match"})
                end
            end
        )

        local parent19 = ui.Panel({Name = "StreakLost", BackgroundTransparency = 0.1, StrokeTransparency = 0.6, Visible = false, Position = UDim2.fromOffset(720, 0), Size = UDim2.fromOffset(480, 58), StrokeColor = Color3.fromRGB(255, 150, 60), Parent = parent16})
        ui.Image(ui.Assets.Icons.Fire, {AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 12, 0.5, 0), Size = UDim2.fromOffset(34, 34), Parent = parent19})
        local ui14 = ui.new("TextLabel", {Name = "Text", Text = "", RichText = true, TextSize = 17, TextWrapped = true, Position = UDim2.fromOffset(52, 0), Size = UDim2.new(1, -250, 1, 0), FontFace = fonts.Heavy, TextColor3 = colors.Text, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent19})
        local v166 = ui.Button({Name = "Restore", Text = "RESTORE", TextSize = 17, Style = "Success", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.fromOffset(186, 44), Parent = parent19})
        local streakLost = nil
        local v168 = nil

        local function paintRestore()
            --[[
              name: paintRestore
              line: 686
              upvalues:
                parent19 (copy, index: 1)
                streakLost (ref,  index: 2)
                v168 (ref,  index: 3)
                a3 (copy, index: 4)
                ui14 (copy, index: 5)
                v166 (copy, index: 6)
                economy (copy, index: 7)
            ]]
            if not parent19.Visible or not streakLost then
                return
            end

            local text

            if v168 then
                a3.Loc.Rich(ui14, string.format("<font color=\"#FFC478\">%d</font> WIN STREAK RESTORED", v168))
                v166:SetStyle("Dark")
                v166:SetEnabled(false)
                v166:SetText("✓ RESTORED")

                return
            end

            local v171 = economy.Pending(streakLost.key)
            a3.Loc.Rich(ui14, string.format("<font color=\"#FFC478\">%d</font> WIN STREAK LOST<br/><font size=\"13\" color=\"#8C93A5\">Bring it back: the offer lasts 24 hours</font>", streakLost.lost))
            v166:SetStyle("Success")
            v166:SetEnabled(not v171)

            if v171 then
                text = "RESTORING…"
            else
                text = "RESTORE  " .. economy.PriceText(streakLost.key)
            end

            v166:SetText(text)
        end

        local parent20 = ui.new("Frame", {Name = "Buttons", AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, 0), Size = UDim2.fromOffset(800, 84), (ui.List(Enum.FillDirection.Horizontal, 20, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)), Parent = parent2})
        local v173 = false
        local v174 = false
        local v175 = nil
        local v176 = ui.Button({Name = "PlayAgain", Text = "PLAY AGAIN", TextSize = 32, Style = "Primary", LayoutOrder = 1, PassInput = true, Size = UDim2.fromOffset(320, 80), Parent = parent20})
        local v177 = ui.Button({Name = "CancelAgain", Text = "CANCEL", TextSize = 24, Style = "Dark", LayoutOrder = 2, Visible = false, Size = UDim2.fromOffset(160, 80), Parent = parent20})
        local v178 = ui.Button({Name = "Lobby", Text = "LOBBY", TextSize = 28, Style = "Dark", LayoutOrder = 3, Size = UDim2.fromOffset(220, 80), Parent = parent20})

        local function padDefault()
            --[[
              name: padDefault
              line: 750
              upvalues:
                v176 (copy, index: 1)
                v177 (copy, index: 2)
                v178 (copy, index: 3)
            ]]
            for _, v181 in {v176, v177, v178} do
                if v181.Instance.Visible then
                    return v181.Instance
                end
            end

            return nil
        end

        for _, v183 in {v176, v177, v178} do
            v183.Instance:GetPropertyChangedSignal("Visible"):Connect(
                function()
                    --[[
                      line: 759
                      upvalues:
                        v174 (ref,  index: 1)
                        a3 (copy, index: 2)
                    ]]
                    if v174 then
                        task.defer(a3.MenuManager.Reselect)
                    end
                end
            )
        end

        local count = 0
        local count2 = 0
        local v186 = false

        local function stopCountdown()
            --[[
              name: stopCountdown
              line: 773
              upvalues:
                count (ref,  index: 1)
                v177 (copy, index: 2)
                v186 (ref,  index: 3)
            ]]
            count += 1
            v177.Instance.Visible = v186
        end

        local function searching()
            --[[
              name: searching
              line: 781
              upvalues:
                state (copy, index: 1)
            ]]
            return state.Get("Queued") == true
        end

        local function paintSearch()
            --[[
              name: paintSearch
              line: 784
              upvalues:
                v174 (ref,  index: 1)
                count2 (ref,  index: 2)
                state (copy, index: 3)
                v186 (ref,  index: 4)
                count (ref,  index: 5)
                v177 (copy, index: 6)
                v176 (copy, index: 7)
                localPlayer (copy, index: 8)
            ]]
            if not v174 then
                return
            end

            count2 += 1
            local v190 = count2

            if state.Get("Queued") == true then
                if not v186 then
                    count += 1
                    v186 = true
                end

                local v191 = state.Get("QueueFound") == true
                v177.Instance.Visible = not v191

                if v191 then
                    v176:SetText("MATCH FOUND")
                else
                    task.spawn(
                        function()
                            --[[
                              line: 801
                              upvalues:
                                v190 (copy, index: 1)
                                count2 (ref,  index: 2)
                                v174 (ref,  index: 3)
                                state (copy, index: 4)
                                v176 (copy, index: 5)
                            ]]
                            local v192, state2
                            local v194 = -1
                            v192, state2 = v190, state

                            while v192 == count2 and v174 do
                                if state.Get("Queued") ~= true then
                                    break
                                end

                                local v195 = tonumber(state.Get("QueuedAt"))

                                if v195 then
                                    state2 = state
                                else
                                    v195 = state.Now()
                                    state2 = state
                                end

                                local v196 = math.max(0, (math.floor(state2.Now() - v195)))

                                if v196 ~= v194 then
                                    v176:SetText(string.format("SEARCHING  %d:%02d", v196 // 60, v196 % 60))
                                    v194 = v196
                                end

                                task.wait(0.2)
                                v192, state2 = v190, state
                            end
                        end
                    )
                end
            elseif v186 then
                task.delay(
                    2,
                    function()
                        --[[
                          line: 816
                          upvalues:
                            v190 (copy, index: 1)
                            count2 (ref,  index: 2)
                            v174 (ref,  index: 3)
                            v186 (ref,  index: 4)
                            state (copy, index: 5)
                            localPlayer (copy, index: 6)
                            v176 (copy, index: 7)
                            v177 (copy, index: 8)
                        ]]
                        if v190 == count2 and v174 and v186 then
                            local v197 = state.Get("Queued") == true

                            if not v197 and localPlayer:GetAttribute("Teleporting") ~= true then
                                v186 = false
                                v176:SetText("PLAY AGAIN")
                                v177.Instance.Visible = false
                            end
                        end
                    end
                )
            end
        end

        state.AttrChanged:Connect(
            function(a198)
                --[[
                  line: 825
                  upvalues:
                    paintSearch (copy, index: 1)
                ]]
                if a198 == "Queued" or a198 == "QueueFound" then
                    paintSearch()
                end
            end
        )

        local function playAgain(a200)
            --[[
              name: playAgain
              line: 831
              upvalues:
                v173 (ref,  index: 1)
                v186 (ref,  index: 2)
                count (ref,  index: 3)
                v177 (copy, index: 4)
                v176 (copy, index: 5)
                a3 (copy, index: 6)
                ui (copy, index: 7)
                v174 (ref,  index: 8)
                state (copy, index: 9)
                localPlayer (copy, index: 10)
                v175 (ref,  index: 11)
            ]]
            if v173 or v186 then
                return
            end

            count += 1
            v177.Instance.Visible = v186
            v173 = true
            v176:SetText("JOINING…")
            local v201 = a3.QueueAction("PlayAgain", "results", ui.PressKind(a200, v176.Instance))
            v173 = false

            if v201 then
                v186 = true
                v177.Instance.Visible = true

                task.delay(
                    10,
                    function()
                        --[[
                          line: 847
                          upvalues:
                            v186 (ref,  index: 1)
                            v174 (ref,  index: 2)
                            state (copy, index: 3)
                            localPlayer (copy, index: 4)
                            v175 (ref,  index: 5)
                        ]]
                        if v186 and v174 then
                            local v202 = state.Get("Queued") == true

                            if not v202 and localPlayer:GetAttribute("Teleporting") ~= true then
                                v186 = false
                                v175()
                            end
                        end
                    end
                )

                return
            end

            v176:SetText("PLAY AGAIN")
        end

        local function startCountdown(a204: number?)
            --[[
              name: startCountdown
              line: 857
              upvalues:
                count (ref,  index: 1)
                v177 (copy, index: 2)
                v186 (ref,  index: 3)
                state (copy, index: 4)
                playAgain (copy, index: 5)
                v176 (copy, index: 6)
                ui (copy, index: 7)
            ]]
            local v205
            count += 1
            v177.Instance.Visible = v186

            if type(a204) == "number" then
                v205 = a204
            else
                v205 = state.Now() + 12
            end

            local v206 = count
            v177.Instance.Visible = true

            task.spawn(
                function()
                    --[[
                      line: 864
                      upvalues:
                        v206 (copy, index: 1)
                        count (ref,  index: 2)
                        v205 (ref,  index: 3)
                        state (copy, index: 4)
                        playAgain (copy, index: 5)
                        v176 (copy, index: 6)
                        ui (copy, index: 7)
                    ]]
                    local v207
                    local ceilingValue = -1
                    v207 = v206

                    while v207 == count do
                        local ceilingValue2 = math.ceil(v205 - state.Now())

                        if ceilingValue2 <= 0 then
                            playAgain()
                            return
                        end

                        if ceilingValue2 ~= ceilingValue then
                            ceilingValue = ceilingValue2
                            v176:SetText("PLAY AGAIN  " .. ceilingValue2)

                            if ceilingValue2 <= 3 then
                                ui.Bump(v176.Label, 0.12)
                            end
                        end

                        task.wait(0.1)
                        v207 = v206
                    end
                end
            )
        end

        v176.Activated:Connect(playAgain)

        local function onCancel()
            --[[
              name: onCancel
              line: 884
              upvalues:
                v173 (ref,  index: 1)
                v186 (ref,  index: 2)
                a3 (copy, index: 3)
                v176 (copy, index: 4)
                v177 (copy, index: 5)
                count (ref,  index: 6)
            ]]
            local v211

            if v173 then
                return
            end

            if not v186 then
                count += 1
                v177.Instance.Visible = v186
                v176:SetText("PLAY AGAIN")
                v177.Instance.Visible = false

                return
            end

            v173 = true
            local v212, v213 = a3.QueueAction("CancelPlayAgain")
            v173 = false

            if v212 then
                v186 = false
                v176:SetText("PLAY AGAIN")
                v177.Instance.Visible = false

                return
            end

            local toast = a3.Toast

            if type(v213) ~= "string" then
                v211 = "Too late: the next match is starting"
            else
                v211 = v213
            end

            toast(v211, "info")
        end

        v177.Activated:Connect(onCancel)

        v166.Activated:Connect(
            function()
                --[[
                  line: 906
                  upvalues:
                    streakLost (ref,  index: 1)
                    v168 (ref,  index: 2)
                    count (ref,  index: 3)
                    v177 (copy, index: 4)
                    v186 (ref,  index: 5)
                    v176 (copy, index: 6)
                    economy (copy, index: 7)
                    paintRestore (copy, index: 8)
                ]]
                if streakLost and not v168 then
                    count += 1
                    v177.Instance.Visible = v186
                    v176:SetText("PLAY AGAIN")
                    economy.Buy(streakLost.key)
                    paintRestore()
                end
            end
        )

        economy.Changed:Connect(paintRestore)

        economy.Event:Connect(
            function(a215, a216)
                --[[
                  line: 915
                  upvalues:
                    streakLost (ref,  index: 1)
                    v168 (ref,  index: 2)
                    paintRestore (copy, index: 3)
                    ui (copy, index: 4)
                    v166 (copy, index: 5)
                ]]
                if a215 == "StreakRestored" and streakLost then
                    v168 = tonumber(a216.streak) or streakLost.lost
                    paintRestore()
                    ui.Pop(v166.Instance, 1.1)
                end
            end
        )

        v178.Activated:Connect(
            function()
                --[[
                  line: 922
                  upvalues:
                    v173 (ref,  index: 1)
                    count (ref,  index: 2)
                    v177 (copy, index: 3)
                    v186 (ref,  index: 4)
                    state (copy, index: 5)
                    a3 (copy, index: 6)
                    v175 (ref,  index: 7)
                ]]
                if v173 then
                    return
                end

                count += 1
                v177.Instance.Visible = v186

                if state.InMatch() then
                    v173 = true
                    a3.QueueAction("LeaveMatch")
                    v173 = false
                end

                v175()
            end
        )

        local function memberRow(a218, options, a220: boolean, mvpId)
            --[[
              name: memberRow
              line: 936
              upvalues:
                portraits (copy, index: 1)
                RankArt (copy, index: 2)
                state (copy, index: 3)
                colors (copy, index: 4)
                theme (copy, index: 5)
                ui (copy, index: 6)
            ]]
            local v222
            local v223
            a218.frame.Visible = options ~= nil

            if not options then
                return
            end

            portraits.Apply(a218.img, options, 60)
            RankArt.SetEmblem(a218.rankPip, RankArt.Ranks.RankOf(tonumber(options.trophies) or 0))
            local name = a218.name

            if type(options.tribe) ~= "table" or type(options.tribe.tag) ~= "string" then
                v222 = ""
            else
                v222 = "[" .. options.tribe.tag .. "] "
            end

            name.Text = v222 .. tostring(options.name or "?")
            local enabled = options.id == state.MyId()
            local name2 = a218.name

            if enabled then
                v223 = colors.Accent
            else
                v223 = if a220 then theme.Lighten(colors.Ally, 0.2) else theme.Lighten(colors.Enemy, 0.15)
            end

            name2.TextColor3 = v223
            a218.stroke.Enabled = enabled
            a218.inner.BackgroundTransparency = enabled and 0.25 or 0.45
            local visible = mvpId ~= false and mvpId ~= nil and options.id == mvpId
            a218.star.Visible = visible
            a218.cells[1].Text = tostring((options.kills or 0))
            a218.cells[2].Text = tostring((options.deaths or 0))
            a218.cells[3].Text = tostring((options.assists or 0))
            a218.cells[4].Text = ui.FormatNumber((options.damage or 0))
        end

        local count3 = 0

        local function animateXp(a230, a231: number)
            --[[
              name: animateXp
              line: 957
              upvalues:
                state (copy, index: 1)
                v91 (copy, index: 2)
                v92 (copy, index: 3)
                v94 (copy, index: 4)
                ui7 (copy, index: 5)
                ui (copy, index: 6)
                count3 (ref,  index: 7)
                a3 (copy, index: 8)
                v90 (copy, index: 9)
                v96 (copy, index: 10)
            ]]
            local v232 = tonumber(a230.levelBefore) or state.Level()
            local v233 = tonumber(a230.levelAfter) or v232
            local number = tonumber(a230.xpBefore) or 0
            local number2 = tonumber(a230.xpAfter) or 0

            local function need(a237)
                --[[
                  name: need
                  line: 962
                  upvalues:
                    v232 (copy, index: 1)
                    a230 (copy, index: 2)
                    v233 (copy, index: 3)
                    state (copy, index: 4)
                ]]
                if a237 == v232 and tonumber(a230.xpToNextBefore) then
                    return a230.xpToNextBefore
                end
                if a237 == v233 and tonumber(a230.xpToNextAfter) then
                    return a230.xpToNextAfter
                end

                return state.XpToNext(a237)
            end

            v91.Text = tostring(v232)
            v92.Text = "LEVEL " .. v232
            v94.Set(number / math.max(1, need(v232)), true)
            ui7.Text = string.format("%s / %s XP", ui.FormatNumber(number), ui.FormatNumber(need(v232)))
            task.wait(0.4)
            local v238 = v232

            while v238 < v233 and a231 == count3 do
                v94.Set(1, false, TweenInfo.new(0.7, Enum.EasingStyle.Quad))
                ui7.Text = string.format("%s / %s XP", ui.FormatNumber(need(v238)), ui.FormatNumber(need(v238)))
                a3.Sounds.Play("XP_Tick")
                task.wait(0.72)

                if a231 ~= count3 then
                    return
                end

                v238 += 1
                v91.Text = tostring(v238)
                v92.Text = "LEVEL " .. v238
                ui7.Text = string.format("0 / %s XP", ui.FormatNumber(need(v238)))
                ui.Pop(v90, 1.7)
                v96.Visible = true
                ui.Pop(v96, 2)
                a3.Sounds.Play("LevelUp")

                task.delay(
                    1.1,
                    function()
                        --[[
                          line: 992
                          upvalues:
                            a231 (copy, index: 1)
                            count3 (ref,  index: 2)
                            v96 (copy, index: 3)
                        ]]
                        if a231 == count3 then
                            v96.Visible = false
                        end
                    end
                )

                v94.Set(0, true)
                task.wait(0.35)
            end

            if a231 ~= count3 then
                return
            end

            v94.Set(number2 / math.max(1, need(v233)), false, TweenInfo.new(0.8, Enum.EasingStyle.Quad))
            a3.Sounds.Play("XP_Tick")
            ui7.Text = string.format("%s / %s XP", ui.FormatNumber(number2), ui.FormatNumber(need(v233)))
        end

        local function animateTrophies(trophies, a241: number)
            --[[
              name: animateTrophies
              line: 1007
              upvalues:
                paintRank (copy, index: 1)
                v119 (copy, index: 2)
                v111 (copy, index: 3)
                colors (copy, index: 4)
                v115 (copy, index: 5)
                count3 (ref,  index: 6)
                ui (copy, index: 7)
                v116 (ref,  index: 8)
                ranks (copy, index: 9)
                v109 (copy, index: 10)
                v107 (copy, index: 11)
                a3 (copy, index: 12)
            ]]
            local v242
            local number = tonumber(trophies.before) or 0
            local number2 = tonumber(trophies.after) or 0
            paintRank(number, true)
            v119(number, true)
            local v245 = tonumber(trophies.delta) or number2 - number
            local unranked = trophies.unranked == true
            v111.Text = unranked and "UNRANKED"
                or trophies.floor == true and v245 == 0 and "SAFE"
                or (if 0 <= v245 then "+" .. v245 else tostring(v245))
            v111.TextSize = unranked and 18 or 26

            if not (0 < v245) then
                v242 = if v245 < 0 then colors.Danger else colors.TextDim
            else
                v242 = colors.Success
            end

            v111.TextColor3 = v242
            v111.TextTransparency = 1
            v115.Visible = false

            task.delay(
                1.15,
                function()
                    --[[
                      line: 1019
                      upvalues:
                        a241 (copy, index: 1)
                        count3 (ref,  index: 2)
                        v111 (copy, index: 3)
                        ui (copy, index: 4)
                        v116 (ref,  index: 5)
                        unranked (copy, index: 6)
                        v115 (copy, index: 7)
                        v119 (copy, index: 8)
                        number2 (copy, index: 9)
                        ranks (copy, index: 10)
                        number (copy, index: 11)
                        v109 (copy, index: 12)
                        paintRank (copy, index: 13)
                        v107 (copy, index: 14)
                        v245 (copy, index: 15)
                        a3 (copy, index: 16)
                    ]]
                    if a241 ~= count3 then
                        return
                    end

                    v111.TextTransparency = 0
                    ui.Pop(v111, 1.6)

                    if v116 and not unranked then
                        task.defer(
                            function()
                                --[[
                                  line: 1027
                                  upvalues:
                                    a241 (copy, index: 1)
                                    count3 (ref,  index: 2)
                                    v111 (copy, index: 3)
                                    v115 (copy, index: 4)
                                ]]
                                if a241 == count3 then
                                    local v247 = not (0 < v111.AbsoluteSize.X) and 1
                                        or v111.AbsoluteSize.X / v111.Size.X.Offset
                                    v115.Position = UDim2.new(1, -(math.ceil(v111.TextBounds.X / v247) + 8), 0, 2)
                                    v115.Visible = true
                                end
                            end
                        )
                    end

                    v119(number2)

                    if ranks.RankOf(number2) == ranks.RankOf(number) then
                        paintRank(number2, false)
                    else
                        local set = v109.Set
                        local v249 = not (number < number2) and 0 or 1
                        set(v249, false, TweenInfo.new(0.5, Enum.EasingStyle.Quad))

                        task.delay(
                            0.55,
                            function()
                                --[[
                                  line: 1039
                                  upvalues:
                                    a241 (copy, index: 1)
                                    count3 (ref,  index: 2)
                                    paintRank (copy, index: 3)
                                    number2 (copy, index: 4)
                                    v109 (copy, index: 5)
                                    ui (copy, index: 6)
                                    v107 (copy, index: 7)
                                ]]
                                if a241 == count3 then
                                    paintRank(number2, true)
                                    v109.Set(0, true)
                                    paintRank(number2, false)
                                    ui.Pop(v107, 1.4)
                                end
                            end
                        )
                    end

                    if 0 < v245 then
                        a3.Sounds.Play("Coin")
                    end
                end
            )
        end

        local count4 = 0

        local function show(a252)
            --[[
              name: show
              line: 1057
              upvalues:
                state (copy, index: 1)
                v18 (copy, index: 2)
                colors (copy, index: 3)
                layoutRows (copy, index: 4)
                v16 (copy, index: 5)
                v116 (ref,  index: 6)
                parent3 (copy, index: 7)
                placeModeTag (copy, index: 8)
                paintPips (copy, index: 9)
                memberRow (copy, index: 10)
                v40 (copy, index: 11)
                parent9 (copy, index: 12)
                portraits (copy, index: 13)
                ui5 (copy, index: 14)
                parent10 (copy, index: 15)
                theme (copy, index: 16)
                ui6 (copy, index: 17)
                ui (copy, index: 18)
                parent11 (copy, index: 19)
                streakLost (ref,  index: 20)
                v168 (ref,  index: 21)
                parent19 (copy, index: 22)
                a3 (copy, index: 23)
                ui14 (copy, index: 24)
                v166 (copy, index: 25)
                paintRestore (copy, index: 26)
                paintDrop (copy, index: 27)
                drop2 (ref,  index: 28)
                parent17 (copy, index: 29)
                parent16 (copy, index: 30)
                v93 (copy, index: 31)
                parent12 (copy, index: 32)
                v98 (copy, index: 33)
                parent13 (copy, index: 34)
                fonts (copy, index: 35)
                ui8 (copy, index: 36)
                v174 (ref,  index: 37)
                count3 (ref,  index: 38)
                v173 (ref,  index: 39)
                v186 (ref,  index: 40)
                v176 (copy, index: 41)
                v177 (copy, index: 42)
                paintSearch (copy, index: 43)
                v178 (copy, index: 44)
                count4 (ref,  index: 45)
                parent14 (copy, index: 46)
                v94 (copy, index: 47)
                ui7 (copy, index: 48)
                v91 (copy, index: 49)
                v92 (copy, index: 50)
                parent (copy, index: 51)
                ui2 (copy, index: 52)
                padDefault (copy, index: 53)
                startCountdown (copy, index: 54)
                parent2 (copy, index: 55)
                parent5 (copy, index: 56)
                parent20 (copy, index: 57)
                animateXp (copy, index: 58)
                animateTrophies (copy, index: 59)
                v138 (copy, index: 60)
            ]]
            local v253
            local stringFormat
            local trophies
            local v256
            local v257
            local rankDrop

            local compare = function(options, options2)
                --[[
                  line: 1093
                ]]
                if (options.kills or 0) ~= (options2.kills or 0) then
                    local kills = options.kills or 0
                    return (options2.kills or 0) < kills
                end

                local damage = options.damage or 0

                return (options2.damage or 0) < damage
            end

            local match = state.Match
            local v265 = type(a252.you) == "table" and a252.you or {}
            local custom = a252.custom == true or v265.custom == true
            local v267 = custom or a252.lobbyOnly == true
            local teamKey = state.MyTeam()
            local v269 = if v265.won ~= nil then v265.won == true else a252.winnerTeam == teamKey
            local v270 = a252.winnerTeam == 0
            v18.Text = v270 and "DRAW" or v269 and "VICTORY" or "DEFEAT"

            if v270 then
                v253 = colors.Bone
            else
                v253 = if v269 then colors.Accent else colors.Enemy
            end

            v18.TextColor3 = v253
            local visible = match ~= nil and state.TeamSize(match.teams) == 1
            local visible2 = a252.mode == "1v1" or visible and (state.IsDuel() or not custom)
            layoutRows(visible)
            v16.Visible = visible2
            v116 = visible2

            if match then
                local team = match.teams[teamKey]
                local team2 = match.teams[3 - teamKey]
                parent3.Text = if visible2 then string.format("YOU   %d  -  %d   OPPONENT", (team.score or 0), (team2.score
                    or 0)) else string.format("YOUR TEAM   %d  -  %d   ENEMY TEAM", (team.score or 0), (team2.score
                    or 0))
                placeModeTag()
                local score = team.score or 0
                local score2 = team2.score or 0
                local v277 = match.roundsToWin or state.DEFAULT_ROUNDS_TO_WIN
                paintPips(score, score2, (math.clamp(v277, 1, 9)))
            else
                parent3.Text = ""
            end

            for v278, teamKey2 in {teamKey, 3 - teamKey} do
                local v280 = {}

                if match then
                    for _, member in match.teams[teamKey2].members do
                        table.insert(v280, member)
                    end
                end

                table.sort(v280, compare)

                for index = 1, 3 do
                    memberRow(v40[((v278 - 1) * 3) + index], v280[index], v278 == 1, a252.mvpId)
                end
            end

            local member, v285 = state.FindMember(a252.mvpId)
            local v286 = member ~= nil
            parent9.Visible = v286

            if member then
                local v287
                portraits.Apply(ui5, member, 150)
                parent10.Text = tostring(member.name)

                if member.id ~= state.MyId() then
                    v287 = if state.IsAllyTeam(v285) then theme.Lighten(colors.Ally, 0.2) else theme.Lighten(colors.Enemy, 0.15)
                else
                    v287 = colors.Accent
                end

                parent10.TextColor3 = v287
                local stringFormat2 = string.format
                local kills = member.kills or 0
                ui6.Text = stringFormat2("%d ELIMS  ·  %d DEATHS  ·  %s DMG", kills, (member.deaths or 0), ui.FormatNumber(member.damage
                    or 0))
            end

            v286 = UDim2.fromOffset
            local v290 = member and 130 or 0
            parent11.Position = v286(0, v290)
            local drop = type(v265.drop) == "table" and type(v265.drop.stacks) == "table" and v265.drop
                or nil
            local streakLost2 = type(v265.streakLost) == "table" and v265.streakLost or nil

            if not streakLost2 or type(streakLost2.lost) ~= "number" or type(streakLost2.key) ~= "string" then
                streakLost = nil
            else
                streakLost = streakLost2
            end

            v168 = nil
            local v293 = streakLost ~= nil or streakLost2 ~= nil and type(streakLost2.credited) == "number"
            parent19.Visible = v293

            if not streakLost2 or type(streakLost2.credited) ~= "number" then
                v166.Instance.Visible = true
            else
                a3.Loc.Rich(ui14, string.format("<font color=\"#FFC478\">%d</font> WIN STREAK KEPT<br/><font size=\"13\" color=\"#8C93A5\">Your saved streak restore was used</font>", streakLost2.credited))
                v166.Instance.Visible = false
            end

            paintRestore()

            if drop then
                paintDrop(drop)
            else
                drop2 = nil
                parent17.Visible = false
            end

            v293 = UDim2.fromOffset
            local v294 = parent19.Visible and 700 or 1200
            parent17.Size = v293(v294, 58)
            parent16.Visible = parent17.Visible or parent19.Visible
            v93.Text = custom and "" or "+" .. ui.FormatNumber((tonumber(v265.xp) or 0)) .. " XP"
            local number = tonumber(v265.streak) or 0
            parent12.Visible = 2 <= number
            v98.Text = number .. " WIN STREAK"

            for _, child in parent13:GetChildren() do
                if child:IsA("GuiObject") then
                    child:Destroy()
                end
            end

            if type(v265.lines) == "table" then
                for layoutOrder, line in v265.lines do
                    if 8 < layoutOrder then
                        break
                    end

                    if type(line) == "table" then
                        ui.new("TextLabel", {TextSize = 15, Text = string.format("%s  +%d XP", tostring((line.label
                            or "")), (tonumber(line.xp) or 0)), FontFace = fonts.SemiBold, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, LayoutOrder = layoutOrder, Parent = parent13})
                    end
                end
            end

            local tribe = v265.tribe
            ui8.Visible = false

            if type(tribe) == "table" and type(tribe.tag) == "string" then
                local text

                if tribe.split then
                    text = string.format("[%s]  no Glory: tribemates on both teams", tribe.tag)
                else
                    local formattedText
                    stringFormat = string.format
                    local tag = tribe.tag
                    local number2 = tonumber(tribe.renown) or 0

                    if not (1 < (tonumber(tribe.mates) or 1)) then
                        formattedText = ""
                    else
                        local stringFormat3 = string.format
                        local v306 = not (3 <= tribe.mates) and "1.5" or "2"
                        formattedText = stringFormat3("  (x%s with tribemates)", v306)
                    end

                    text = stringFormat("[%s]  +%d Glory%s", tag, number2, formattedText)
                end

                ui8.Text = text
                ui8.Visible = not custom
            end

            v174 = true
            count3 += 1
            local v307 = count3
            a3.SetHudHidden("MatchEnd", true)
            a3.MenuManager.PushMouse("MatchEnd")
            v173 = false
            v186 = false
            v176:SetText("PLAY AGAIN")
            v177.Instance.Visible = false
            v176.Instance.Visible = not v267

            if state.Get("Queued") == true then
                paintSearch()
            end

            local style = v267 and "Primary" or "Dark"
            v178:SetStyle(style)
            local instance = v178.Instance
            local udim2FromOffset = UDim2.fromOffset
            local v311 = v267 and 320 or 220
            instance.Size = udim2FromOffset(v311, 80)
            v178:SetText("LOBBY")
            count4 += 1

            if custom or type(v265.trophies) ~= "table" then
                trophies = nil
            else
                trophies = v265.trophies
            end

            parent14.Visible = trophies ~= nil
            local v312 = 98

            if trophies then
                parent14.Position = UDim2.fromOffset(16, v312)
                v256 = v312 + 44
            else
                v256 = v312
            end

            parent12.Position = UDim2.fromOffset(16, v256 + 2)
            ui8.Position = UDim2.new(1, -16, 0, v256 + 4)

            if parent12.Visible or ui8.Visible then
                v256 += 46
            end

            local v313 = v256 + 4
            parent13.Position = UDim2.fromOffset(16, v313)
            local count = 0

            for _, child in parent13:GetChildren() do
                if child:IsA("TextLabel") then
                    count += 1
                end
            end

            local v317 = math.max(1, (math.ceil(count / 2)))
            local clampedValue = math.clamp(math.floor(((290 - v313) - 10 - ((v317 - 1) * 3)) / v317), 16, 22)

            if not (20 <= clampedValue) then
                v257 = 2
            else
                v257 = 3
            end

            if const grid = parent13:FindFirstChild("Grid") then
                grid.CellSize = UDim2.new(0.5, -6, 0, clampedValue)
                grid.CellPadding = UDim2.fromOffset(12, v257)
            end

            for _, child in parent13:GetChildren() do
                if child:IsA("TextLabel") then
                    child.TextSize = math.min(15, clampedValue - 3)
                end
            end

            parent13.Size = UDim2.new(1, -32, 0, v317 * (clampedValue + v257))
            local udim2FromOffset2 = UDim2.fromOffset
            local v323 = custom and 106 or 290
            parent11.Size = udim2FromOffset2(480, v323)
            v94.Frame.Visible = not custom
            local udim2FromOffset3 = UDim2.fromOffset
            local v325 = custom and 52 or 74
            ui7.Position = udim2FromOffset3(100, v325)
            ui7.TextSize = custom and 16 or 15

            if custom then
                local name
                v91.Text = tostring((tonumber(v265.levelAfter) or state.Level()))
                v92.Text = "CUSTOM MATCH"
                local v327 = a3.Custom and a3.Custom.State()
                ui7.AutoLocalize = false

                if type(v327) ~= "table" or type(v327.name) ~= "string" then
                    name = ""
                else
                    name = v327.name
                end

                ui7.Text = name
            end

            local function openResults(a329: boolean)
                --[[
                  name: openResults
                  line: 1250
                  upvalues:
                    v307 (copy, index: 1)
                    count3 (ref,  index: 2)
                    v174 (ref,  index: 3)
                    parent (copy, index: 4)
                    ui2 (copy, index: 5)
                    ui (copy, index: 6)
                    theme (copy, index: 7)
                    a3 (copy, index: 8)
                    padDefault (copy, index: 9)
                    v267 (copy, index: 10)
                    count4 (ref,  index: 11)
                    a252 (copy, index: 12)
                    state (copy, index: 13)
                    v178 (copy, index: 14)
                    v265 (copy, index: 15)
                    v186 (ref,  index: 16)
                    startCountdown (copy, index: 17)
                    parent2 (copy, index: 18)
                    v18 (copy, index: 19)
                    parent3 (copy, index: 20)
                    parent5 (copy, index: 21)
                    parent9 (copy, index: 22)
                    parent11 (copy, index: 23)
                    v40 (copy, index: 24)
                    parent20 (copy, index: 25)
                    parent12 (copy, index: 26)
                    custom (copy, index: 27)
                    animateXp (copy, index: 28)
                    trophies (copy, index: 29)
                    animateTrophies (copy, index: 30)
                    parent16 (copy, index: 31)
                    v138 (copy, index: 32)
                ]]
                if v307 ~= count3 or not v174 then
                    return
                end

                parent.Visible = true
                ui2.Visible = true
                ui2.BackgroundTransparency = 1
                ui.Tween(ui2, theme.Tween.Slow, {BackgroundTransparency = 0.25})
                a3.MenuManager.PushFocus("MatchEnd", padDefault)

                if v267 then
                    local v330 = count4

                    if const number = tonumber(a252.closesAt) then
                        task.spawn(
                            function()
                                --[[
                                  line: 1264
                                  upvalues:
                                    v330 (copy, index: 1)
                                    count4 (ref,  index: 2)
                                    v174 (ref,  index: 3)
                                    number (copy, index: 4)
                                    state (copy, index: 5)
                                    v178 (copy, index: 6)
                                ]]
                                local v332, ceilingValue
                                local ceilingValue2 = -1
                                v332 = v330

                                while v332 == count4 and v174 do
                                    ceilingValue = math.ceil(number - state.Now())

                                    if ceilingValue <= 0 then
                                        break
                                    end

                                    if ceilingValue ~= ceilingValue2 then
                                        v178:SetText("LOBBY  " .. ceilingValue)
                                        ceilingValue2 = ceilingValue
                                    end

                                    task.wait(0.1)
                                    v332 = v330
                                end
                            end
                        )
                    end
                elseif v265.inactive ~= true then
                    local v335 = tonumber(a252.autoRequeueAt)

                    if a329 then
                        v335 = math.max((v335 or 0), state.Now() + 15)

                        if type(a252.closesAt) == "number" then
                            v335 = math.min(v335, a252.closesAt - 3)
                        end
                    end

                    if not v186 then
                        startCountdown(v335)
                    end
                end

                ui.Unfade(parent2)
                v18.TextTransparency = 0
                ui.Pop(v18, 2.2, theme.Tween.Slam)
                ui.Enter(parent3, Vector2.new(0, 20), 0.25)
                ui.Enter(parent5, Vector2.new(-40, 0), 0.35)
                ui.Enter(parent9, Vector2.new(40, 0), 0.45)
                ui.Enter(parent11, Vector2.new(40, 0), 0.55)

                for v336, v337 in v40 do
                    ui.Enter(v337.inner, Vector2.new(-24, 0), (v336 * 0.05) + 0.45, UDim2.new())
                end

                ui.Enter(parent20, Vector2.new(0, 30), 0.8)

                task.delay(
                    1,
                    function()
                        --[[
                          line: 1304
                          upvalues:
                            v307 (copy, index: 1)
                            count3 (ref,  index: 2)
                            parent12 (copy, index: 3)
                            ui (copy, index: 4)
                        ]]
                        if v307 ~= count3 then
                            return
                        end

                        if parent12.Visible then
                            ui.Pop(parent12, 1.5)
                        end
                    end
                )

                task.delay(
                    0.9,
                    function()
                        --[[
                          line: 1312
                          upvalues:
                            v307 (copy, index: 1)
                            count3 (ref,  index: 2)
                            custom (copy, index: 3)
                            animateXp (copy, index: 4)
                            v265 (copy, index: 5)
                        ]]
                        if v307 == count3 and not custom then
                            animateXp(v265, v307)
                        end
                    end
                )

                if trophies then
                    animateTrophies(trophies, v307)
                end

                if parent16.Visible then
                    ui.Enter(parent16, Vector2.new(0, 20), 0.7)

                    for v338, v339 in v138 do
                        if v339.frame.Visible then
                            local scaleObj = ui.GetScaleObj(v339.frame)
                            scaleObj.Scale = 0
                            local v341 = {Scale = 1}
                            ui.Tween(scaleObj, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, (v338 * 0.06) + 0.8), v341)
                        end
                    end
                end
            end

            parent.Visible = false
            ui2.Visible = false
            local dropReveal = a3.DropReveal

            if type(v265.rankDrop) == "table" and type(v265.rankDrop.stacks) == "table" then
                rankDrop = v265.rankDrop
            else
                rankDrop = nil
            end

            local function playMatchDrop()
                --[[
                  name: playMatchDrop
                  line: 1337
                  upvalues:
                    drop (copy, index: 1)
                    dropReveal (copy, index: 2)
                    openResults (copy, index: 3)
                ]]
                return drop ~= nil
                    and dropReveal ~= nil
                    and dropReveal.Play(
                        drop,
                        {
                            source = "match",
                            onDone = (function()
                                --[[
                                  name: onDone
                                  line: 1340
                                  upvalues:
                                    openResults (copy, index: 1)
                                ]]
                                openResults(true)
                            end)
                        }
                    )
            end

            local v344 = rankDrop ~= nil
                and dropReveal ~= nil
                and dropReveal.Play(
                    rankDrop,
                    {
                        source = "match",
                        onDone = (function(a345)
                            --[[
                              name: onDone
                              line: 1347
                              upvalues:
                                playMatchDrop (copy, index: 1)
                                openResults (copy, index: 2)
                            ]]
                            if a345 ~= "interrupted" and playMatchDrop() then
                                return
                            end

                            openResults(true)
                        end)
                    }
                )

            v344 = v344 or playMatchDrop()

            if not v344 then
                openResults(false)
            end
        end

        v175 = function(a346)
            --[[
              line: 1362
              upvalues:
                v174 (ref,  index: 1)
                v186 (ref,  index: 2)
                count2 (ref,  index: 3)
                count3 (ref,  index: 4)
                count4 (ref,  index: 5)
                count (ref,  index: 6)
                v177 (copy, index: 7)
                a3 (copy, index: 8)
                parent (copy, index: 9)
                ui2 (copy, index: 10)
                ui (copy, index: 11)
                theme (copy, index: 12)
                parent2 (copy, index: 13)
            ]]
            if not v174 then
                return
            end

            v174 = false
            v186 = false
            count2 += 1
            count3 += 1
            count4 += 1
            count += 1
            v177.Instance.Visible = v186
            a3.SetHudHidden("MatchEnd", false)
            a3.MenuManager.PopMouse("MatchEnd")
            a3.MenuManager.PopFocus("MatchEnd")

            if a346 then
                parent.Visible = false
                ui2.Visible = false

                return
            end

            ui.Tween(ui2, theme.Tween.Close, {BackgroundTransparency = 1})
            ui.FadeOut(parent2, TweenInfo.new(0.2))

            task.delay(
                0.22,
                function()
                    --[[
                      line: 1382
                      upvalues:
                        v174 (ref,  index: 1)
                        parent (copy, index: 2)
                        ui2 (copy, index: 3)
                    ]]
                    if not v174 then
                        parent.Visible = false
                        ui2.Visible = false
                    end
                end
            )

            task.delay(
                0.6,
                function()
                    --[[
                      line: 1390
                      upvalues:
                        v174 (ref,  index: 1)
                        ui (copy, index: 2)
                        parent2 (copy, index: 3)
                    ]]
                    if not v174 then
                        ui.Unfade(parent2)
                    end
                end
            )
        end

        ui.Unfade(parent2)

        for _, v348 in {parent3, parent5, parent9, parent11, parent20, parent16} do
            ui.Unfade(v348)
        end

        a3.OnMatchEvent(
            function(a349, a350)
                --[[
                  line: 1403
                  upvalues:
                    localPlayer (copy, index: 1)
                    show (copy, index: 2)
                    v175 (ref,  index: 3)
                ]]
                if a349 == "MatchEnd" and type(a350) == "table" then
                    local matchId = localPlayer:GetAttribute("MatchId")

                    task.delay(
                        1.2,
                        function()
                            --[[
                              line: 1408
                              upvalues:
                                localPlayer (copy, index: 1)
                                matchId (copy, index: 2)
                                show (copy, index: 3)
                                a350 (copy, index: 4)
                            ]]
                            local total = 0

                            while localPlayer:GetAttribute("ReplayPlaying") == true and total < 40 do
                                total += task.wait(0.1)
                            end

                            if 0 < total then
                                if localPlayer:GetAttribute("State") ~= "Match" then
                                    return
                                end
                            end

                            if localPlayer:GetAttribute("MatchId") ~= matchId then
                                return
                            end

                            show(a350)
                        end
                    )

                    return
                end

                if a349 == "MatchStart" then
                    v175(true)
                end
            end
        )

        state.AttrChanged:Connect(
            function(a353)
                --[[
                  line: 1427
                  upvalues:
                    v174 (ref, index: 1)
                    v175 (ref, index: 2)
                ]]
                if v174 and a353 == "MatchId" then
                    v175(true)
                end
            end
        )

        state.PlayerStateChanged:Connect(
            function(a354)
                --[[
                  line: 1432
                  upvalues:
                    v174 (ref, index: 1)
                    v175 (ref, index: 2)
                ]]
                if v174 and a354 == "Lobby" then
                    v175()
                end
            end
        )

        a3.Debug.matchEndCancel = function()
            --[[
              line: 1439
              upvalues:
                onCancel (copy, index: 1)
                v176 (copy, index: 2)
                v177 (copy, index: 3)
                v186 (ref,  index: 4)
            ]]
            onCancel()
            return {again = v176.Label.Text, cancel = v177.Instance.Visible, joining = v186}
        end

        a3.Debug.matchEndClose = function()
            --[[
              line: 1443
              upvalues:
                v175 (ref, index: 1)
            ]]
            v175()
            return true
        end
    end)
}