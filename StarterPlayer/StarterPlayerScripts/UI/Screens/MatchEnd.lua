local Players_upv_1 = game:GetService("Players")
local RankArt_upv_1 = require(script.Parent.Parent.RankArt)
local tbl_1 = {}
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 36
      upvalues:
        Players_upv_1 (copy, index: 1)
        RankArt_upv_1 (copy, index: 2)
    ]]
    local UI_upv_1 = a1.UI
    local Theme_upv_1 = a1.Theme
    local State_upv_1 = a1.State
    local Portraits_upv_1 = a1.Portraits
    local WeaponIcon_upv_1 = a1.WeaponIcon
    local Colors_upv_1 = Theme_upv_1.Colors
    local Fonts_upv_1 = Theme_upv_1.Fonts
    local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
    local u1 = UI_upv_1.new("TextButton", {Visible = false, Name = "MatchEndDim", Modal = true, Selectable = false, BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), BackgroundColor3 = Colors_upv_1.Void, Parent = a1.Canvas.Backdrop})
    local u2 = UI_upv_1.new("Frame", {Visible = false, Name = "MatchEnd", Size = UDim2.fromScale(1, 1), Parent = a1.Canvas.Menus})
    local u3 = UI_upv_1.new("Frame", {Name = "Content", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1200, 744), Parent = u2})
    local u4 = UI_upv_1.GetScaleObj(u3, "FitScale")
    local u5 = UI_upv_1.CanvasSize()
    u4.Scale = math.min(1, (u5.X - 24) / 1200, (u5.Y - 12) / 744)
    local function applyFit()
        --[[
          name: applyFit
          line: 61
          upvalues:
            UI_upv_1 (copy, index: 1)
            u4 (copy, index: 2)
        ]]
        local v1 = UI_upv_1.CanvasSize()
        u4.Scale = math.min(1, (v1.X - 24) / 1200, (v1.Y - 12) / 744)
    end
    UI_upv_1.ScaleChanged:Connect(applyFit)
    local u6 = UI_upv_1.DisplayText({StrokeThickness = 5, Text = "VICTORY", Name = "Title", TextSize = 110, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 0), Size = UDim2.fromOffset(900, 110), TextColor3 = Colors_upv_1.Accent, Parent = u3})
    u5 = UI_upv_1.Pill("1V1", Colors_upv_1.Accent, {Name = "ModeTag", PadX = 10, Height = 26, ZIndex = 3, TextSize = 17, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(0.5, -200, 0, 126), Parent = u3})
    u5.Visible = false
    local u7 = UI_upv_1.new("TextLabel", {Text = "", Name = "Score", TextSize = 30, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 108), Size = UDim2.fromOffset(900, 36), FontFace = Fonts_upv_1.Title, TextColor3 = Colors_upv_1.Text, Parent = u3})
    UI_upv_1.TextStroke(Colors_upv_1.Void, 2.5, 0.1).Parent = u7
    local function placeModeTag()
        --[[
          name: placeModeTag
          line: 106
          upvalues:
            u7 (copy, index: 1)
            u5 (copy, index: 2)
        ]]
        local v2
        if (u7.Size.X.Offset > 0) and (u7.AbsoluteSize.X > 0) then
            v2 = u7.AbsoluteSize.X / u7.Size.X.Offset
        else
            v2 = 1
        end
        u5.Position = UDim2.new(0.5, -math.ceil((u7.TextBounds.X / v2) / 2) - 14, 0, 126)
    end
    u7:GetPropertyChangedSignal("TextBounds"):Connect(placeModeTag)
    u7:GetPropertyChangedSignal("AbsoluteSize"):Connect(placeModeTag)
    local u8 = UI_upv_1.new("Frame", {Name = "RoundPips", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 144), Size = UDim2.fromOffset(300, 10), Parent = u3})
    local u9 = UI_upv_1.Panel({Name = "Board", BackgroundTransparency = 0.1, Position = UDim2.fromOffset(0, 160), Size = UDim2.fromOffset(700, 420), Trim = Colors_upv_1.Accent, Parent = u3})
    local v3 = UI_upv_1.new("Frame", {Name = "Header", Position = UDim2.fromOffset(20, 12), Size = UDim2.new(1, -40, 0, 22), Parent = u9})
    local tbl_2 = {{"K", 400}, {"D", 470}, {"A", 530}, {"DMG", 600}}
    UI_upv_1.new("TextLabel", {Text = "FIGHTER", TextSize = 15, Size = UDim2.fromOffset(300, 22), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, Parent = v3})
    for _, value_1 in tbl_2 do
        UI_upv_1.new("TextLabel", {TextSize = 15, Position = UDim2.fromOffset(value_1[2] - 20, 0), Size = UDim2.fromOffset(70, 22), Text = value_1[1], FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextMuted, Parent = v3})
    end
    local tbl_upv_3 = {}
    for n_1 = 1, 6 do
        local v4 = UI_upv_1.new("Frame", {Name = "Row" .. n_1, Position = UDim2.fromOffset(12, ((n_1 - 1) * 60) + 42 + (((n_1 > 3) and 10) or 0)), Size = UDim2.new(1, -24, 0, 54), Parent = u9})
        local v5 = UI_upv_1.new("Frame", {Name = "Inner", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Colors_upv_1.Void, BackgroundTransparency = 0.45, [1] = UI_upv_1.Corner(10), Parent = v4})
        local v6 = UI_upv_1.Stroke(Colors_upv_1.Accent, 2.5, 0)
        v6.Parent = v5
        local v7 = UI_upv_1.new("ImageLabel", {Name = "Img", Position = UDim2.fromOffset(6, 5), Size = UDim2.fromOffset(44, 44), BackgroundColor3 = Colors_upv_1.Raised, ScaleType = Enum.ScaleType.Crop, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v5})
        local v8 = UI_upv_1.new("TextLabel", {AutoLocalize = false, Text = "", Name = "Name", TextSize = 22, Position = UDim2.fromOffset(60, 0), Size = UDim2.fromOffset(250, 54), FontFace = Fonts_upv_1.Heavy, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v5})
        local v9 = UI_upv_1.Image(UI_upv_1.Assets.Icons.Star, {Name = "Mvp", Visible = false, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 318, 0.5, 0), Size = UDim2.fromOffset(26, 26), ImageColor3 = Colors_upv_1.Gold, Parent = v5})
        local tbl_4 = {}
        for key_1, value_2 in tbl_2 do
            tbl_4[key_1] = UI_upv_1.new("TextLabel", {Text = "0", TextSize = 24, Position = UDim2.fromOffset(value_2[2] - 32, 0), Size = UDim2.fromOffset(70, 54), FontFace = Fonts_upv_1.Display, TextColor3 = Colors_upv_1.Text, Parent = v5})
        end
        tbl_upv_3[n_1] = {frame = v4, inner = v5, stroke = v6, img = v7, name = v8, star = v9, cells = tbl_4, rankPip = RankArt_upv_1.Emblem(1, 24, {ZIndex = 3, Position = UDim2.fromOffset(32, 30), Parent = v5})}
    end
    local u10 = UI_upv_1.new("Frame", {Name = "Vs", Visible = false, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.new(1, -60, 0, 24), Parent = u9})
    for n_2 = 0, 1 do
        local new_1 = UI_upv_1.new
        local tbl_5 = {}
        tbl_5.AnchorPoint = Vector2.new(n_2, 0.5)
        tbl_5.Position = UDim2.fromScale(n_2, 0.5)
        tbl_5.Size = UDim2.new(0.5, -34, 0, 2)
        tbl_5.BackgroundColor3 = Colors_upv_1.Divider
        local Gradient_1 = UI_upv_1.Gradient
        local v10 = Color3.new(1, 1, 1)
        local v11 = Color3.new(1, 1, 1)
        tbl_5[1] = Gradient_1(v10, v11, 0, NumberSequence.new(((n_2 ~= 0) and 0.2) or 1, ((n_2 ~= 0) and 1) or 0.2))
        tbl_5.Parent = u10
        new_1("Frame", tbl_5)
    end
    UI_upv_1.new("TextLabel", {Name = "Text", Text = "VS", TextSize = 22, Size = UDim2.fromScale(1, 1), FontFace = Fonts_upv_1.Display, TextColor3 = Colors_upv_1.TextMuted, Parent = u10})
    local v12 = UI_upv_1.new("Frame", {Name = "Right", Position = UDim2.fromOffset(720, 160), Size = UDim2.fromOffset(480, 420), Parent = u3})
    local u11 = UI_upv_1.Panel({Name = "Mvp", StrokeTransparency = 0.4, BackgroundTransparency = 0.1, Size = UDim2.fromOffset(480, 118), StrokeColor = Colors_upv_1.Gold, Parent = v12})
    local tbl_upv_6 = {}
    tbl_upv_6.Name = "Img"
    tbl_upv_6.Position = UDim2.fromOffset(12, 12)
    tbl_upv_6.Size = UDim2.fromOffset(94, 94)
    tbl_upv_6.BackgroundColor3 = Colors_upv_1.Raised
    tbl_upv_6.ScaleType = Enum.ScaleType.Crop
    tbl_upv_6[1], tbl_upv_6[2] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Stroke(Colors_upv_1.Gold, 3, 0.1)
    tbl_upv_6.Parent = u11
    local u12 = UI_upv_1.new("ImageLabel", tbl_upv_6)
    local _ = UI_upv_1.Image(UI_upv_1.Assets.Icons.Star, {Position = UDim2.fromOffset(122, 12), Size = UDim2.fromOffset(28, 28), ImageColor3 = Colors_upv_1.Gold, Parent = u11})
    UI_upv_1.DisplayText({StrokeThickness = 2, Text = "MVP", TextSize = 30, Position = UDim2.fromOffset(156, 10), Size = UDim2.fromOffset(200, 32), TextColor3 = Colors_upv_1.Gold, TextXAlignment = Enum.TextXAlignment.Left, Parent = u11})
    local u13 = UI_upv_1.new("TextLabel", {AutoLocalize = false, Text = "", Name = "Name", TextSize = 28, Position = UDim2.fromOffset(122, 44), Size = UDim2.fromOffset(340, 32), FontFace = Fonts_upv_1.Heavy, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = u11})
    UI_upv_1.TextStroke(Colors_upv_1.Void, 1.5, 0.3).Parent = u13
    tbl_upv_6 = UI_upv_1.new("TextLabel", {Text = "", Name = "Stats", TextSize = 18, Position = UDim2.fromOffset(122, 78), Size = UDim2.fromOffset(340, 24), FontFace = Fonts_upv_1.Bold, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Left, Parent = u11})
    local u14 = UI_upv_1.Panel({Name = "Rewards", BackgroundTransparency = 0.1, Position = UDim2.fromOffset(0, 130), Size = UDim2.fromOffset(480, 290), Trim = Colors_upv_1.Accent, Parent = v12})
    local u15, u16 = UI_upv_1.LevelBadge(1, 78, {Position = UDim2.fromOffset(12, 14), Parent = u14})
    local u17 = UI_upv_1.DisplayText({StrokeThickness = 2, Name = "LevelWord", Text = "LEVEL 1", TextSize = 28, Position = UDim2.fromOffset(100, 14), Size = UDim2.fromOffset(260, 32), TextXAlignment = Enum.TextXAlignment.Left, Parent = u14})
    local u18 = UI_upv_1.DisplayText({StrokeThickness = 2, Text = "+0 XP", Name = "XpGain", TextSize = 26, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -16, 0, 16), Size = UDim2.fromOffset(160, 30), TextColor3 = Colors_upv_1.Xp, TextXAlignment = Enum.TextXAlignment.Right, Parent = u14})
    local u19 = UI_upv_1.Bar({Name = "XpBar", Position = UDim2.fromOffset(100, 54), Size = UDim2.new(1, -116, 0, 18), Color = Colors_upv_1.Xp, Parent = u14})
    local u20 = UI_upv_1.new("TextLabel", {Text = "", Name = "XpText", TextSize = 15, Position = UDim2.fromOffset(100, 74), Size = UDim2.new(1, -116, 0, 18), FontFace = Fonts_upv_1.Bold, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Left, Parent = u14})
    local u21 = UI_upv_1.DisplayText({StrokeThickness = 3, Text = "LEVEL UP!", Name = "LevelUp", Visible = false, ZIndex = 5, TextSize = 44, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(240, 62), Size = UDim2.fromOffset(300, 50), TextColor3 = Colors_upv_1.Accent, Parent = u14})
    local u22, v13 = UI_upv_1.ShellAmount(0, {TextSize = 34, Position = UDim2.fromOffset(16, 110), Parent = u14})
    u22.Visible = Theme_upv_1.ShowCurrency
    local u23 = UI_upv_1.CountUp(
        v13,
        function(a2)
            --[[
              line: 397
              upvalues:
                UI_upv_1 (copy, index: 1)
            ]]
            return "+" .. UI_upv_1.FormatNumber(a2)
        end,
        1.1
    )
    local new_2 = UI_upv_1.new
    local tbl_7 = {AnchorPoint = 0, Name = "Streak", Position = 0, Parent = 0, Visible = false, Size = 0}
    tbl_7.AnchorPoint = Vector2.new(((Theme_upv_1.ShowCurrency) and 1) or 0, 0)
    local v14
    if Theme_upv_1.ShowCurrency then
        v14 = UDim2.new(1, -16, 0, 108)
    else
        v14 = UDim2.fromOffset(16, 108)
    end
    tbl_7.Position = v14
    tbl_7.Size = UDim2.fromOffset(220, 44)
    tbl_7.Parent = u14
    local u24 = new_2("Frame", tbl_7)
    UI_upv_1.Image(UI_upv_1.Assets.Icons.Fire, {Size = UDim2.fromOffset(40, 40), Parent = u24})
    local u25 = UI_upv_1.DisplayText({StrokeThickness = 2, Text = "3 WIN STREAK", TextSize = 26, Position = UDim2.fromOffset(44, 4), Size = UDim2.new(1, -44, 0, 36), TextColor3 = Colors_upv_1.Warning, TextXAlignment = Enum.TextXAlignment.Left, Parent = u24})
    local u26 = UI_upv_1.new("TextLabel", {Visible = false, Text = "", Name = "Glory", TextWrapped = true, TextSize = 16, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -16, 0, 108), Size = UDim2.fromOffset(220, 40), FontFace = Fonts_upv_1.Bold, TextColor3 = Color3.fromRGB(255, 196, 80), TextXAlignment = Enum.TextXAlignment.Right, Parent = u14})
    local u27 = UI_upv_1.new("Frame", {Name = "Lines", Position = UDim2.fromOffset(16, 162), Size = UDim2.new(1, -32, 0, 104), [1] = UI_upv_1.new("UIGridLayout", {Name = "Grid", CellSize = UDim2.new(0.5, -6, 0, 22), CellPadding = UDim2.fromOffset(12, 3), SortOrder = Enum.SortOrder.LayoutOrder}), Parent = u14})
    local RankArt_upv_2 = require(script.Parent.Parent.RankArt)
    local Ranks_upv_1 = RankArt_upv_2.Ranks
    local u28 = UI_upv_1.new("Frame", {Visible = false, Name = "Trophies", Position = UDim2.fromOffset(16, 102), Size = UDim2.new(1, -32, 0, 44), Parent = u14})
    local u29 = RankArt_upv_2.Emblem(1, 44, {Parent = u28})
    local u30 = UI_upv_1.new("TextLabel", {Name = "Rank", Position = UDim2.fromOffset(54, 0), Size = UDim2.fromOffset(230, 22), Text = "", FontFace = Fonts_upv_1.Display, TextSize = 20, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Left, [1] = UI_upv_1.TextStroke(Colors_upv_1.Void, 1.5, 0.4), Parent = u28})
    local u31 = UI_upv_1.Bar({Name = "Bar", Position = UDim2.fromOffset(54, 24), Size = UDim2.fromOffset(220, 9), Color = Colors_upv_1.Gold, Parent = u28})
    local u32 = UI_upv_1.new("TextLabel", {Text = "", Name = "Next", TextSize = 12, Position = UDim2.fromOffset(54, 33), Size = UDim2.fromOffset(220, 14), FontFace = Fonts_upv_1.SemiBold, TextColor3 = Colors_upv_1.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, Parent = u28})
    local u33 = UI_upv_1.DisplayText({StrokeThickness = 2, Text = "+0", Name = "Delta", TextSize = 26, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 0, 0, -3), Size = UDim2.fromOffset(120, 28), TextColor3 = Colors_upv_1.Success, TextXAlignment = Enum.TextXAlignment.Right, Parent = u28})
    local u34 = 50
    pcall(
        function()
            --[[
              line: 493
              upvalues:
                u34 (ref, index: 1)
            ]]
            local num_1 = tonumber(require(game:GetService("ReplicatedStorage").Shared.Config).DUEL_TROPHY_MULT)
            if not num_1 then
                return
            end
            u34 = math.floor((num_1 * 100) + 0.5)
        end
    )
    local u35 = UI_upv_1.Pill(string.format("1V1  \194\183  %d%%", u34), Color3.fromRGB(64, 48, 14), {Name = "Duel", PadX = 8, Height = 22, TextSize = 14, TextColor = Colors_upv_1.Gold, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -64, 0, 1), Parent = u28})
    u35.Visible = false
    local u36 = false
    local v15 = UI_upv_1.new("Frame", {Name = "Count", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 0, 0, 24), Size = UDim2.fromOffset(150, 20), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 4, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center), Parent = u28})
    RankArt_upv_2.Trophy(20, {LayoutOrder = 1, Parent = v15})
    local u37 = UI_upv_1.CountUp(
        UI_upv_1.new("TextLabel", {LayoutOrder = 2, Text = "0", Name = "N", TextSize = 20, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 22), FontFace = Fonts_upv_1.Display, TextColor3 = Colors_upv_1.Text, Parent = v15}),
        function(a3)
            --[[
              line: 532
              upvalues:
                UI_upv_1 (copy, index: 1)
            ]]
            return UI_upv_1.FormatNumber(a3)
        end,
        1
    )
    local Economy_upv_1 = a1.Economy
    local u38 = UI_upv_1.new("Frame", {Name = "Economy", Position = UDim2.fromOffset(0, 592), Size = UDim2.fromOffset(1200, 58), Parent = u3})
    local u39 = UI_upv_1.new("TextButton", {Visible = false, Name = "Drop", Size = UDim2.fromOffset(700, 58), Parent = u38})
    UI_upv_1.Panel({BackgroundTransparency = 0.1, Name = "Bg", Size = UDim2.fromScale(1, 1), Parent = u39})
    local u40 = UI_upv_1.GetScaleObj(u39, "HoverScale")
    local u41 = UI_upv_1.Image(UI_upv_1.Assets.Fx.Gem, {AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 12, 0.5, 0), Size = UDim2.fromOffset(34, 34), ImageColor3 = Colors_upv_1.Accent, Parent = u39})
    local u42 = UI_upv_1.new("TextLabel", {Text = "DROP", Name = "Title", TextSize = 18, Position = UDim2.fromOffset(54, 8), Size = UDim2.fromOffset(170, 22), FontFace = Fonts_upv_1.Heavy, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = u39})
    local u43 = UI_upv_1.new("TextLabel", {Text = "", Name = "Sub", TextSize = 14, Position = UDim2.fromOffset(54, 30), Size = UDim2.fromOffset(170, 18), FontFace = Fonts_upv_1.Bold, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Left, Parent = u39})
    local u44 = UI_upv_1.new("Frame", {Name = "Cards", Position = UDim2.fromOffset(222, 5), Size = UDim2.new(1, -230, 0, 48), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center), Parent = u39})
    local tbl_upv_8 = {}
    local u45 = nil
    local function dTile(a4)
        --[[
          name: dTile
          line: 586
          upvalues:
            tbl_upv_8 (copy, index: 1)
            UI_upv_1 (copy, index: 2)
            u44 (copy, index: 3)
            Colors_upv_1 (copy, index: 4)
            Fonts_upv_1 (copy, index: 5)
        ]]
        local v16 = tbl_upv_8[a4]
        if v16 then
            return v16
        end
        local v17 = UI_upv_1.new("Frame", {Name = "Card" .. a4, Size = UDim2.fromOffset(92, 48), LayoutOrder = a4, Parent = u44})
        local tbl_9 = {}
        tbl_9.Name = "Tile"
        tbl_9.AnchorPoint = Vector2.new(0, 0.5)
        tbl_9.Position = UDim2.new(0, 0, 0.5, 0)
        tbl_9.Size = UDim2.fromOffset(44, 44)
        tbl_9.BackgroundColor3 = Color3.new(1, 1, 1)
        tbl_9[1] = UI_upv_1.Corner(9)
        tbl_9.Parent = v17
        local v18 = UI_upv_1.new("Frame", tbl_9)
        local v19 = UI_upv_1.Gradient(Colors_upv_1.Accent, Colors_upv_1.Panel, 115)
        v19.Parent = v18
        local tbl_10 = {
            frame = v17,
            grad = v19,
            icon = UI_upv_1.new("Frame", {Name = "Icon", ZIndex = 2, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.94, 0.94), Parent = v18}),
            count = UI_upv_1.new("TextLabel", {Name = "N", Text = "x0", TextSize = 20, Position = UDim2.fromOffset(49, 2), Size = UDim2.fromOffset(44, 24), FontFace = Fonts_upv_1.Display, TextXAlignment = Enum.TextXAlignment.Left, Parent = v17}),
            tag = UI_upv_1.new("TextLabel", {Text = "", Name = "Tag", TextSize = 12, Position = UDim2.fromOffset(49, 26), Size = UDim2.fromOffset(50, 16), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Left, Parent = v17})
        }
        tbl_upv_8[a4] = tbl_10
        return tbl_10
    end
    local function paintDrop(a5)
        --[[
          name: paintDrop
          line: 604
          upvalues:
            u45 (ref,  index: 1)
            a1 (copy, index: 2)
            u39 (copy, index: 3)
            Colors_upv_1 (copy, index: 4)
            u41 (copy, index: 5)
            u42 (copy, index: 6)
            u43 (copy, index: 7)
            tbl_upv_8 (copy, index: 8)
            WeaponIcon_upv_1 (copy, index: 9)
            dTile (copy, index: 10)
            Economy_upv_1 (copy, index: 11)
            Theme_upv_1 (copy, index: 12)
        ]]
        u45 = a5
        local v20 = a1.DropReveal
        local v21 = not (v20) or not (v20.Normalize) or v20.Normalize(a5)
        local v22 = false
        if v21 ~= nil then
            v22 = #v21.stacks > 0
        end
        u39.Visible = v22
        if not v21 then
            return
        end
        local v23
        if v21.kind == "golden" then
            v23 = Colors_upv_1.Gold
        elseif v21.kind ~= "victory" then
            v23 = Color3.fromRGB(150, 180, 226)
        else
            v23 = Colors_upv_1.Accent
        end
        u41.ImageColor3 = v23
        if v21.kind ~= "golden" then
            v22 = ((v21.kind ~= "victory") and "DROP") or "VICTORY DROP"
        else
            v22 = "GOLDEN DROP"
        end
        u42.Text = v22
        u42.TextColor3 = v23:Lerp(Color3.new(1, 1, 1), 0.35)
        v20 = 0
        for _, value_3 in v21.stacks do
            v20 = v20 + value_3.shards
        end
        u43.Text = string.format("+%d shards", v20)
        for n_3 = 1, math.max(#v21.stacks, #tbl_upv_8) do
            local v25 = v21.stacks[n_3]
            if n_3 > 5 or not (v25) then
                local v26 = tbl_upv_8[n_3]
                if v26 then
                    v26.frame.Visible = false
                    WeaponIcon_upv_1.Set(v26.icon, nil)
                end
            end
            local v27 = dTile(n_3)
            local v28 = nil
            if not (Economy_upv_1) or not (Economy_upv_1.CategoryColor) then
                v28 = Colors_upv_1.Accent
                v27.frame.Visible = true
                v27.grad.Color = ColorSequence.new(v28:Lerp(Colors_upv_1.Panel, 0.5), Colors_upv_1.PanelHi:Lerp(Colors_upv_1.Panel, 0.6))
                WeaponIcon_upv_1.Set(v27.icon, v25.item, {outline = false, glow = false})
                v27.count.Text = "x" .. v25.shards
                if v25.unlocked then
                    v27.tag.Text = "NEW"
                    v27.tag.TextColor3 = Colors_upv_1.Gold
                    continue
                end
                if v25.ready then
                    v27.tag.Text = "UPGRADE"
                    v27.tag.TextColor3 = Theme_upv_1.Lighten(Colors_upv_1.Success, 0.15)
                    continue
                end
                if v25.levelBefore <= 0 then
                    v27.tag.Text = string.format("%d/%d", v25.total, v25.need or 0)
                    v27.tag.TextColor3 = Colors_upv_1.TextMuted
                else
                    v27.tag.Text = "LV " .. v25.levelBefore
                    v27.tag.TextColor3 = Colors_upv_1.TextDim
                end
            end
            v28 = Economy_upv_1.CategoryColor(v25.item)
            v27.frame.Visible = true
            v27.grad.Color = ColorSequence.new(v28:Lerp(Colors_upv_1.Panel, 0.5), Colors_upv_1.PanelHi:Lerp(Colors_upv_1.Panel, 0.6))
            WeaponIcon_upv_1.Set(v27.icon, v25.item, {outline = false, glow = false})
            v27.count.Text = "x" .. v25.shards
            if v25.unlocked then
                v27.tag.Text = "NEW"
                v27.tag.TextColor3 = Colors_upv_1.Gold
                continue
            end
            if v25.ready then
                v27.tag.Text = "UPGRADE"
                v27.tag.TextColor3 = Theme_upv_1.Lighten(Colors_upv_1.Success, 0.15)
                continue
            end
            if v25.levelBefore <= 0 then
                v27.tag.Text = string.format("%d/%d", v25.total, v25.need or 0)
                v27.tag.TextColor3 = Colors_upv_1.TextMuted
            else
                v27.tag.Text = "LV " .. v25.levelBefore
                v27.tag.TextColor3 = Colors_upv_1.TextDim
            end
        end
    end
    u39.MouseEnter:Connect(
        function()
            --[[
              line: 652
              upvalues:
                UI_upv_1 (copy, index: 1)
                u40 (copy, index: 2)
                Theme_upv_1 (copy, index: 3)
            ]]
            if (UI_upv_1.Touch) then
                return
            end
            UI_upv_1.Tween(u40, Theme_upv_1.Tween.PopSmall, {Scale = 1.02})
        end
    )
    u39.MouseLeave:Connect(
        function()
            --[[
              line: 657
              upvalues:
                UI_upv_1 (copy, index: 1)
                u40 (copy, index: 2)
                Theme_upv_1 (copy, index: 3)
            ]]
            UI_upv_1.Tween(u40, Theme_upv_1.Tween.Fast, {Scale = 1})
        end
    )
    u39.Activated:Connect(
        function()
            --[[
              line: 660
              upvalues:
                a1 (copy, index: 1)
                u45 (ref,  index: 2)
            ]]
            local DropReveal_1 = a1.DropReveal
            if not u45 or not DropReveal_1 or (DropReveal_1.IsPlaying()) then
                return
            end
            a1.Sounds.Play("Click")
            DropReveal_1.ShowSummary(u45, {source = "match"})
        end
    )
    local u46 = UI_upv_1.Panel({Visible = false, Name = "StreakLost", StrokeTransparency = 0.6, BackgroundTransparency = 0.1, Position = UDim2.fromOffset(720, 0), Size = UDim2.fromOffset(480, 58), StrokeColor = Color3.fromRGB(255, 150, 60), Parent = u38})
    UI_upv_1.Image(UI_upv_1.Assets.Icons.Fire, {AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 12, 0.5, 0), Size = UDim2.fromOffset(34, 34), Parent = u46})
    local u47 = UI_upv_1.new("TextLabel", {RichText = true, Text = "", TextWrapped = true, Name = "Text", TextSize = 17, Position = UDim2.fromOffset(52, 0), Size = UDim2.new(1, -250, 1, 0), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Left, Parent = u46})
    local u48 = UI_upv_1.Button({Style = "Success", Name = "Restore", Text = "RESTORE", TextSize = 17, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.fromOffset(186, 44), Parent = u46})
    local u49 = nil
    local u50 = nil
    local function paintRestore()
        --[[
          name: paintRestore
          line: 694
          upvalues:
            u46 (copy, index: 1)
            u49 (ref,  index: 2)
            u50 (ref,  index: 3)
            a1 (copy, index: 4)
            u47 (copy, index: 5)
            u48 (copy, index: 6)
            Economy_upv_1 (copy, index: 7)
        ]]
        if not u46.Visible or not u49 then
            return
        end
        if u50 then
            a1.Loc.Rich(u47, string.format("<font color=\"#FFC478\">%d</font> WIN STREAK RESTORED", u50))
            u48:SetStyle("Dark")
            u48:SetEnabled(false)
            u48:SetText("\226\156\147 RESTORED")
        else
            local v29 = Economy_upv_1.Pending(u49.key)
            a1.Loc.Rich(u47, string.format("<font color=\"#FFC478\">%d</font> WIN STREAK LOST<br/><font size=\"13\" color=\"#8C93A5\">Bring it back: the offer lasts 24 hours</font>", u49.lost))
            u48:SetStyle("Success")
            u48:SetEnabled(not v29)
            local v30 = (v29 and "RESTORING\226\128\166") or ("RESTORE  " .. Economy_upv_1.PriceText(u49.key))
            u48:SetText(v30)
        end
    end
    local u51 = UI_upv_1.new("Frame", {Name = "Buttons", AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, 0), Size = UDim2.fromOffset(800, 84), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 20, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center), Parent = u3})
    local u52 = false
    local u53 = false
    local u54 = nil
    local u55 = UI_upv_1.Button({LayoutOrder = 1, Style = "Primary", Name = "PlayAgain", PassInput = true, Text = "PLAY AGAIN", TextSize = 32, Size = UDim2.fromOffset(320, 80), Parent = u51})
    local u56 = UI_upv_1.Button({LayoutOrder = 2, Style = "Dark", Name = "CancelAgain", Visible = false, Text = "CANCEL", TextSize = 24, Size = UDim2.fromOffset(160, 80), Parent = u51})
    local u57 = UI_upv_1.Button({LayoutOrder = 3, Name = "Lobby", Style = "Dark", Text = "LOBBY", TextSize = 28, Size = UDim2.fromOffset(220, 80), Parent = u51})
    for v16, searching in {u55, u56, u57} do
        searching.Instance:GetPropertyChangedSignal("Visible"):Connect(
            function()
                --[[
                  line: 767
                  upvalues:
                    u53 (ref,  index: 1)
                    a1 (copy, index: 2)
                ]]
                if not u53 then
                    return
                end
                task.defer(a1.MenuManager.Reselect)
            end
        )
    end
    local u58 = 0
    local u59 = 0
    local u60 = false
    local function v16()
        --[[
          name: stopCountdown
          line: 781
          upvalues:
            u58 (ref,  index: 1)
            u56 (copy, index: 2)
            u60 (ref,  index: 3)
        ]]
        u58 = u58 + 1
        u56.Instance.Visible = u60
    end
    local function searching()
        --[[
          name: searching
          line: 789
          upvalues:
            State_upv_1 (copy, index: 1)
        ]]
        local v31 = State_upv_1.Get("Queued") == true
        return v31
    end
    local function paintSearch()
        --[[
          name: paintSearch
          line: 792
          upvalues:
            u53 (ref,  index: 1)
            u59 (ref,  index: 2)
            State_upv_1 (copy, index: 3)
            u60 (ref,  index: 4)
            u58 (ref,  index: 5)
            u56 (copy, index: 6)
            u55 (copy, index: 7)
            LocalPlayer_upv_1 (copy, index: 8)
        ]]
        if not u53 then
            return
        end
        u59 = u59 + 1
        local u61 = u59
        local v32 = State_upv_1.Get("Queued") == true
        if v32 then
            if not (u60) then
                u58 = u58 + 1
                u60 = true
            end
            local v33 = State_upv_1.Get("QueueFound") == true
            u56.Instance.Visible = not v33
            if v33 then
                u55:SetText("MATCH FOUND")
            else
                task.spawn(
                    function()
                        --[[
                          line: 809
                          upvalues:
                            u61 (copy, index: 1)
                            u59 (ref,  index: 2)
                            u53 (ref,  index: 3)
                            State_upv_1 (copy, index: 4)
                            u55 (copy, index: 5)
                        ]]
                        local v34 = -1
                        while u61 == u59 and (u53) do
                            local v35 = State_upv_1.Get("Queued") == true
                            if not (v35) then
                                break
                            end
                            local v36 = tonumber(State_upv_1.Get("QueuedAt")) or (State_upv_1.Now())
                            local v37 = math.max(0, math.floor(State_upv_1.Now() - v36))
                            if v37 ~= v34 then
                                u55:SetText(string.format("SEARCHING  %d:%02d", v37 // 60, v37 % 60))
                                v34 = v37
                            end
                            task.wait(0.2)
                        end
                    end
                )
            end
        elseif u60 then
            task.delay(
                2,
                function()
                    --[[
                      line: 824
                      upvalues:
                        u61 (copy, index: 1)
                        u59 (ref,  index: 2)
                        u53 (ref,  index: 3)
                        u60 (ref,  index: 4)
                        State_upv_1 (copy, index: 5)
                        LocalPlayer_upv_1 (copy, index: 6)
                        u55 (copy, index: 7)
                        u56 (copy, index: 8)
                    ]]
                    if u61 ~= u59 or not u53 then
                        return
                    end
                    if u60 then
                        local v38 = State_upv_1.Get("Queued") == true
                        if (v38) or LocalPlayer_upv_1:GetAttribute("Teleporting") == true then
                            return
                        end
                        u60 = false
                        u55:SetText("PLAY AGAIN")
                        u56.Instance.Visible = false
                    end
                end
            )
        end
    end
    State_upv_1.AttrChanged:Connect(
        function(a6)
            --[[
              line: 833
              upvalues:
                paintSearch (copy, index: 1)
            ]]
            if a6 ~= "Queued" and a6 ~= "QueueFound" then
                return
            end
            paintSearch()
        end
    )
    local function playAgain(a7)
        --[[
          name: playAgain
          line: 839
          upvalues:
            u52 (ref,  index: 1)
            u60 (ref,  index: 2)
            u58 (ref,  index: 3)
            u56 (copy, index: 4)
            u55 (copy, index: 5)
            a1 (copy, index: 6)
            UI_upv_1 (copy, index: 7)
            u53 (ref,  index: 8)
            State_upv_1 (copy, index: 9)
            LocalPlayer_upv_1 (copy, index: 10)
            u54 (ref,  index: 11)
        ]]
        if (u52) then
            return
        end
        if not (u60) then
            u58 = u58 + 1
            u56.Instance.Visible = u60
            u52 = true
            u55:SetText("JOINING\226\128\166")
            local v39 = a1.QueueAction("PlayAgain", "results", UI_upv_1.PressKind(a7, u55.Instance))
            u52 = false
            if v39 then
                u60 = true
                u56.Instance.Visible = true
                task.delay(
                    10,
                    function()
                        --[[
                          line: 855
                          upvalues:
                            u60 (ref,  index: 1)
                            u53 (ref,  index: 2)
                            State_upv_1 (copy, index: 3)
                            LocalPlayer_upv_1 (copy, index: 4)
                            u54 (ref,  index: 5)
                        ]]
                        if not u60 then
                            return
                        end
                        if u53 then
                            local v40 = State_upv_1.Get("Queued") == true
                            if (v40) or LocalPlayer_upv_1:GetAttribute("Teleporting") == true then
                                return
                            end
                            u60 = false
                            u54()
                        end
                    end
                )
            else
                u55:SetText("PLAY AGAIN")
            end
        end
    end
    local function startCountdown(a8)
        --[[
          name: startCountdown
          line: 865
          upvalues:
            u58 (ref,  index: 1)
            u56 (copy, index: 2)
            u60 (ref,  index: 3)
            State_upv_1 (copy, index: 4)
            playAgain (copy, index: 5)
            u55 (copy, index: 6)
            UI_upv_1 (copy, index: 7)
        ]]
        u58 = u58 + 1
        u56.Instance.Visible = u60
        if type(a8) ~= "number" then
            a8 = State_upv_1.Now() + 12
        end
        local u62 = u58
        u56.Instance.Visible = true
        task.spawn(
            function()
                --[[
                  line: 872
                  upvalues:
                    u62 (copy, index: 1)
                    u58 (ref,  index: 2)
                    a8 (ref,  index: 3)
                    State_upv_1 (copy, index: 4)
                    playAgain (copy, index: 5)
                    u55 (copy, index: 6)
                    UI_upv_1 (copy, index: 7)
                ]]
                local v41 = -1
                v41 = nil
                while u62 == u58 do
                    local v42 = math.ceil(a8 - State_upv_1.Now())
                    if v42 <= 0 then
                        playAgain()
                        return
                    end
                    if v42 == v41 then
                        task.wait(0.1)
                        continue
                    end
                    u55:SetText("PLAY AGAIN  " .. v42)
                    if v42 <= 3 then
                        UI_upv_1.Bump(u55.Label, 0.12)
                    end
                    v41 = v42
                    task.wait(0.1)
                end
            end
        )
    end
    u55.Activated:Connect(playAgain)
    local function onCancel()
        --[[
          name: onCancel
          line: 892
          upvalues:
            u52 (ref,  index: 1)
            u60 (ref,  index: 2)
            a1 (copy, index: 3)
            u55 (copy, index: 4)
            u56 (copy, index: 5)
            u58 (ref,  index: 6)
        ]]
        if u52 then
            return
        end
        if u60 then
            u52 = true
            local v43, v44 = a1.QueueAction("CancelPlayAgain")
            u52 = false
            if v43 then
                u60 = false
                u55:SetText("PLAY AGAIN")
                u56.Instance.Visible = false
            else
                local Toast_1 = a1.Toast
                local v45
                if type(v44) ~= "string" then
                    v45 = "Too late: the next match is starting"
                else
                    v45 = v44
                end
                Toast_1(v45, "info")
            end
        else
            u58 = u58 + 1
            u56.Instance.Visible = u60
            u55:SetText("PLAY AGAIN")
            u56.Instance.Visible = false
        end
    end
    u56.Activated:Connect(onCancel)
    u48.Activated:Connect(
        function()
            --[[
              line: 914
              upvalues:
                u49 (ref,  index: 1)
                u50 (ref,  index: 2)
                u58 (ref,  index: 3)
                u56 (copy, index: 4)
                u60 (ref,  index: 5)
                u55 (copy, index: 6)
                Economy_upv_1 (copy, index: 7)
                paintRestore (copy, index: 8)
            ]]
            if not u49 or (u50) then
                return
            end
            u58 = u58 + 1
            u56.Instance.Visible = u60
            u55:SetText("PLAY AGAIN")
            Economy_upv_1.Buy(u49.key)
            paintRestore()
        end
    )
    Economy_upv_1.Changed:Connect(paintRestore)
    Economy_upv_1.Event:Connect(
        function(a9, a10)
            --[[
              line: 923
              upvalues:
                u49 (ref,  index: 1)
                u50 (ref,  index: 2)
                paintRestore (copy, index: 3)
                UI_upv_1 (copy, index: 4)
                u48 (copy, index: 5)
            ]]
            if a9 ~= "StreakRestored" then
                return
            end
            if u49 then
                local v46 = tonumber(a10.streak) or (u49.lost)
                u50 = v46
                paintRestore()
                UI_upv_1.Pop(u48.Instance, 1.1)
            end
        end
    )
    u57.Activated:Connect(
        function()
            --[[
              line: 930
              upvalues:
                u52 (ref,  index: 1)
                u58 (ref,  index: 2)
                u56 (copy, index: 3)
                u60 (ref,  index: 4)
                State_upv_1 (copy, index: 5)
                a1 (copy, index: 6)
                u54 (ref,  index: 7)
            ]]
            if u52 then
                return
            end
            u58 = u58 + 1
            u56.Instance.Visible = u60
            if State_upv_1.InMatch() then
                u52 = true
                a1.QueueAction("LeaveMatch")
                u52 = false
            end
            u54()
        end
    )
    local u63 = 0
    local function animateXp(a11, a12)
        --[[
          name: animateXp
          line: 965
          upvalues:
            State_upv_1 (copy, index: 1)
            u16 (copy, index: 2)
            u17 (copy, index: 3)
            u19 (copy, index: 4)
            u20 (copy, index: 5)
            UI_upv_1 (copy, index: 6)
            u63 (ref,  index: 7)
            a1 (copy, index: 8)
            u15 (copy, index: 9)
            u21 (copy, index: 10)
        ]]
        local u64 = tonumber(a11.levelBefore) or (State_upv_1.Level())
        local u65 = tonumber(a11.levelAfter) or u64
        local v47 = tonumber(a11.xpBefore) or 0
        local v48 = tonumber(a11.xpAfter) or 0
        u16.Text = tostring(u64)
        u17.Text = "LEVEL " .. u64
        local function need_1(a13)
            --[[
              name: need
              line: 970
              upvalues:
                u64 (copy, index: 1)
                a11 (copy, index: 2)
                u65 (copy, index: 3)
                State_upv_1 (copy, index: 4)
            ]]
            if a13 == u64 and tonumber(a11.xpToNextBefore) then
                return a11.xpToNextBefore
            elseif a13 == u65 and tonumber(a11.xpToNextAfter) then
                return a11.xpToNextAfter
            else
                return State_upv_1.XpToNext(a13)
            end
        end
        u19.Set(v47 / math.max(1, need_1(u64)), true)
        u20.Text = string.format("%s / %s XP", UI_upv_1.FormatNumber(v47), UI_upv_1.FormatNumber(need_1(u64)))
        task.wait(0.4)
        v47 = u64
        while v47 < u65 and a12 == u63 do
            u19.Set(1, false, TweenInfo.new(0.7, Enum.EasingStyle.Quad))
            u20.Text = string.format("%s / %s XP", UI_upv_1.FormatNumber(need_1(v47)), UI_upv_1.FormatNumber(need_1(v47)))
            a1.Sounds.Play("XP_Tick")
            task.wait(0.72)
            if a12 == u63 then
                v47 = v47 + 1
                u16.Text = tostring(v47)
                u17.Text = "LEVEL " .. v47
                u20.Text = string.format("0 / %s XP", UI_upv_1.FormatNumber(need_1(v47)))
                UI_upv_1.Pop(u15, 1.7)
                u21.Visible = true
                UI_upv_1.Pop(u21, 2)
                a1.Sounds.Play("LevelUp")
                task.delay(
                    1.1,
                    function()
                        --[[
                          line: 1000
                          upvalues:
                            a12 (copy, index: 1)
                            u63 (ref,  index: 2)
                            u21 (copy, index: 3)
                        ]]
                        if a12 ~= u63 then
                            return
                        end
                        u21.Visible = false
                    end
                )
                u19.Set(0, true)
                task.wait(0.35)
                continue
            end
            return
        end
        if a12 ~= u63 then
            return
        end
        u19.Set(v48 / math.max(1, need_1(u65)), false, TweenInfo.new(0.8, Enum.EasingStyle.Quad))
        a1.Sounds.Play("XP_Tick")
        u20.Text = string.format("%s / %s XP", UI_upv_1.FormatNumber(v48), UI_upv_1.FormatNumber(need_1(u65)))
    end
    local function paintRank(a14, a15)
        --[[
          name: paintRank
          line: 536
          upvalues:
            Ranks_upv_1 (copy, index: 1)
            RankArt_upv_2 (copy, index: 2)
            u29 (copy, index: 3)
            u30 (copy, index: 4)
            u31 (copy, index: 5)
            u32 (copy, index: 6)
            UI_upv_1 (copy, index: 7)
        ]]
        local v49, v50, v51 = Ranks_upv_1.Progress(a14)
        local v52 = RankArt_upv_2.Color(v49)
        RankArt_upv_2.SetEmblem(u29, v49)
        u30.Text = string.upper(Ranks_upv_1.Get(v49).name)
        u30.TextColor3 = v52
        u31.SetColor(v52)
        u31.Set((v51 and (v50 / v51)) or 1, a15, TweenInfo.new(0.9, Enum.EasingStyle.Quad))
        u32.Text = not v51 and "TOP RANK" or string.format("%s / %s to %s", UI_upv_1.FormatNumber(v50), UI_upv_1.FormatNumber(v51), string.upper(Ranks_upv_1.Get(v49 + 1).name))
    end
    local function animateTrophies(a16, a17)
        --[[
          name: animateTrophies
          line: 1015
          upvalues:
            paintRank (copy, index: 1)
            u37 (copy, index: 2)
            u33 (copy, index: 3)
            Colors_upv_1 (copy, index: 4)
            u35 (copy, index: 5)
            u63 (ref,  index: 6)
            UI_upv_1 (copy, index: 7)
            u36 (ref,  index: 8)
            Ranks_upv_1 (copy, index: 9)
            u31 (copy, index: 10)
            u29 (copy, index: 11)
            a1 (copy, index: 12)
        ]]
        local u66 = tonumber(a16.before) or 0
        local u67 = tonumber(a16.after) or 0
        paintRank(u66, true)
        u37(u66, true)
        local u68 = tonumber(a16.delta) or (u67 - u66)
        local u69 = a16.unranked == true
        local v54
        if u69 then
            v54 = "UNRANKED"
        elseif a16.floor == true and u68 == 0 then
            v54 = "SAFE"
        else
            v54 = ((u68 >= 0) and ("+" .. u68)) or (tostring(u68))
        end
        u33.Text = v54
        u33.TextSize = (u69 and 18) or 26
        local v55
        if u68 > 0 then
            v55 = Colors_upv_1.Success
        elseif u68 < 0 then
            v55 = Colors_upv_1.Danger
        else
            v55 = Colors_upv_1.TextDim
        end
        u33.TextColor3 = v55
        u33.TextTransparency = 1
        u35.Visible = false
        task.delay(
            1.15,
            function()
                --[[
                  line: 1027
                  upvalues:
                    a17 (copy, index: 1)
                    u63 (ref,  index: 2)
                    u33 (copy, index: 3)
                    UI_upv_1 (copy, index: 4)
                    u36 (ref,  index: 5)
                    u69 (copy, index: 6)
                    u35 (copy, index: 7)
                    u37 (copy, index: 8)
                    u67 (copy, index: 9)
                    Ranks_upv_1 (copy, index: 10)
                    u66 (copy, index: 11)
                    u31 (copy, index: 12)
                    paintRank (copy, index: 13)
                    u29 (copy, index: 14)
                    u68 (copy, index: 15)
                    a1 (copy, index: 16)
                ]]
                if a17 ~= u63 then
                    return
                end
                u33.TextTransparency = 0
                UI_upv_1.Pop(u33, 1.6)
                if u36 and not (u69) then
                    task.defer(
                        function()
                            --[[
                              line: 1035
                              upvalues:
                                a17 (copy, index: 1)
                                u63 (ref,  index: 2)
                                u33 (copy, index: 3)
                                u35 (copy, index: 4)
                            ]]
                            if a17 ~= u63 then
                                return
                            end
                            u35.Position = UDim2.new(1, -(math.ceil(u33.TextBounds.X / (((u33.AbsoluteSize.X > 0) and (u33.AbsoluteSize.X / u33.Size.X.Offset)) or 1)) + 8), 0, 2)
                            u35.Visible = true
                        end
                    )
                end
                u37(u67)
                if Ranks_upv_1.RankOf(u67) == Ranks_upv_1.RankOf(u66) then
                    paintRank(u67, false)
                else
                    u31.Set(((u66 < u67) and 1) or 0, false, TweenInfo.new(0.5, Enum.EasingStyle.Quad))
                    task.delay(
                        0.55,
                        function()
                            --[[
                              line: 1047
                              upvalues:
                                a17 (copy, index: 1)
                                u63 (ref,  index: 2)
                                paintRank (copy, index: 3)
                                u67 (copy, index: 4)
                                u31 (copy, index: 5)
                                UI_upv_1 (copy, index: 6)
                                u29 (copy, index: 7)
                            ]]
                            if a17 ~= u63 then
                                return
                            end
                            paintRank(u67, true)
                            u31.Set(0, true)
                            paintRank(u67, false)
                            UI_upv_1.Pop(u29, 1.4)
                        end
                    )
                end
                if u68 > 0 then
                    a1.Sounds.Play("Coin")
                end
            end
        )
    end
    local u70 = 0
    local function layoutRows(a18)
        --[[
          name: layoutRows
          line: 247
          upvalues:
            u9 (copy, index: 1)
            tbl_upv_3 (copy, index: 2)
            u10 (copy, index: 3)
        ]]
        local v56 = (a18 and 84) or 54
        local v57 = (a18 and 66) or 44
        local v58 = math.floor((((u9.Size.Y.Offset - 42) - 12) - 212) / 2) + 42
        local v59 = nil
        local v60 = nil
        for key_2, value_4 in tbl_upv_3 do
            if a18 then
                if key_2 <= 3 then
                    v59 = v58
                else
                    v59 = v58 + 84 + 44
                end
            else
                v59 = ((key_2 - 1) * 60) + 42 + (((key_2 > 3) and 10) or 0)
            end
            value_4.frame.Position = UDim2.fromOffset(12, v59)
            value_4.frame.Size = UDim2.new(1, -24, 0, v56)
            value_4.img.Size = UDim2.fromOffset(v57, v57)
            local img_1 = value_4.img
            img_1.Position = UDim2.fromOffset((a18 and 9) or 6, math.floor((v56 - v57) / 2))
            local name_1 = value_4.name
            name_1.Position = UDim2.fromOffset(v57 + ((a18 and 22) or 16), 0)
            local name_2 = value_4.name
            name_2.Size = UDim2.fromOffset((a18 and 226) or 250, v56)
            value_4.name.TextSize = (a18 and 27) or 22
            for _, value_5 in value_4.cells do
                value_5.Size = UDim2.fromOffset(70, v56)
                value_5.TextSize = (a18 and 30) or 24
            end
            v59 = (a18 and 30) or 24
            value_4.rankPip.Size = UDim2.fromOffset(v59, v59)
            local rankPip_1 = value_4.rankPip
            if a18 then
                v60 = UDim2.fromOffset(((v57 + 9) - v59) + 6, ((math.floor((v56 - v57) / 2) + v57) - v59) + 4)
            else
                v60 = UDim2.fromOffset(32, 30)
            end
            rankPip_1.Position = v60
        end
        u10.Visible = a18
        u10.Position = UDim2.new(0.5, 0, 0, (v58 + 84) + 22)
    end
    local function memberRow(a19, a20, a21, a22)
        --[[
          name: memberRow
          line: 944
          upvalues:
            Portraits_upv_1 (copy, index: 1)
            RankArt_upv_1 (copy, index: 2)
            State_upv_1 (copy, index: 3)
            Colors_upv_1 (copy, index: 4)
            Theme_upv_1 (copy, index: 5)
            UI_upv_1 (copy, index: 6)
        ]]
        a19.frame.Visible = a20 ~= nil
        if not a20 then
            return
        end
        Portraits_upv_1.Apply(a19.img, a20, 60)
        RankArt_upv_1.SetEmblem(a19.rankPip, RankArt_upv_1.Ranks.RankOf(tonumber(a20.trophies) or 0))
        local name_3 = a19.name
        local v61
        if type(a20.tribe) == "table" and type(a20.tribe.tag) == "string" then
            v61 = "[" .. a20.tribe.tag .. "] "
        else
            v61 = ""
        end
        name_3.Text = v61 .. tostring(a20.name or "?")
        local v62 = a20.id == State_upv_1.MyId()
        local name_4 = a19.name
        local v63
        if v62 then
            v63 = Colors_upv_1.Accent
        elseif a21 then
            v63 = Theme_upv_1.Lighten(Colors_upv_1.Ally, 0.2)
        else
            v63 = Theme_upv_1.Lighten(Colors_upv_1.Enemy, 0.15)
        end
        name_4.TextColor3 = v63
        a19.stroke.Enabled = v62
        a19.inner.BackgroundTransparency = (v62 and 0.25) or 0.45
        a19.star.Visible = (a22 ~= false) and ((a22 ~= nil) and (a20.id == a22))
        a19.cells[1].Text = tostring(a20.kills or 0)
        a19.cells[2].Text = tostring(a20.deaths or 0)
        a19.cells[3].Text = tostring(a20.assists or 0)
        a19.cells[4].Text = UI_upv_1.FormatNumber(a20.damage or 0)
    end
    local function padDefault()
        --[[
          name: padDefault
          line: 758
          upvalues:
            u55 (copy, index: 1)
            u56 (copy, index: 2)
            u57 (copy, index: 3)
        ]]
        for _, value_6 in {u55, u56, u57} do
            if not (value_6.Instance.Visible) then
                continue
            end
            return value_6.Instance
        end
        return nil
    end
    local function paintPips(a23, a24, a25)
        --[[
          name: paintPips
          line: 121
          upvalues:
            u8 (copy, index: 1)
            Colors_upv_1 (copy, index: 2)
            UI_upv_1 (copy, index: 3)
        ]]
        u8:ClearAllChildren()
        local v64, v65 = nil, nil
        for n_4 = 1, 2 do
            if n_4 ~= 1 then
                v64 = a24
            else
                v64 = a23
            end
            local v66
            if n_4 ~= 1 then
                v66 = Colors_upv_1.Enemy
            else
                v66 = Colors_upv_1.Ally
            end
            for n_5 = 1, a25 do
                local new_3 = UI_upv_1.new
                local v67 = "Frame"
                local tbl_11 = {}
                tbl_11.AnchorPoint = Vector2.new(0.5, 0)
                tbl_11.Position = UDim2.new(0.5, ((n_4 ~= 1) and ((n_5 - 1) * 22 + 30)) or (-30 - (n_5 - 1) * 22), 0, 0)
                tbl_11.Size = UDim2.fromOffset(18, 10)
                if n_5 <= v64 then
                    v65 = v66
                else
                    v65 = Color3.fromRGB(52, 56, 68)
                end
                tbl_11.BackgroundColor3 = v65
                tbl_11[1] = UI_upv_1.Corner(3)
                tbl_11.Parent = u8
                new_3(v67, tbl_11)
            end
        end
    end
    local function show(a26)
        --[[
          name: show
          line: 1065
          upvalues:
            State_upv_1 (copy, index: 1)
            u6 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            layoutRows (copy, index: 4)
            u5 (copy, index: 5)
            u36 (ref,  index: 6)
            u7 (copy, index: 7)
            placeModeTag (copy, index: 8)
            paintPips (copy, index: 9)
            memberRow (copy, index: 10)
            tbl_upv_3 (copy, index: 11)
            u11 (copy, index: 12)
            Portraits_upv_1 (copy, index: 13)
            u12 (copy, index: 14)
            u13 (copy, index: 15)
            Theme_upv_1 (copy, index: 16)
            tbl_upv_6 (copy, index: 17)
            UI_upv_1 (copy, index: 18)
            u14 (copy, index: 19)
            u49 (ref,  index: 20)
            u50 (ref,  index: 21)
            u46 (copy, index: 22)
            a1 (copy, index: 23)
            u47 (copy, index: 24)
            u48 (copy, index: 25)
            paintRestore (copy, index: 26)
            paintDrop (copy, index: 27)
            u45 (ref,  index: 28)
            u39 (copy, index: 29)
            u38 (copy, index: 30)
            u18 (copy, index: 31)
            u23 (copy, index: 32)
            u24 (copy, index: 33)
            u25 (copy, index: 34)
            u27 (copy, index: 35)
            Fonts_upv_1 (copy, index: 36)
            u26 (copy, index: 37)
            u53 (ref,  index: 38)
            u63 (ref,  index: 39)
            u52 (ref,  index: 40)
            u60 (ref,  index: 41)
            u55 (copy, index: 42)
            u56 (copy, index: 43)
            paintSearch (copy, index: 44)
            u57 (copy, index: 45)
            u70 (ref,  index: 46)
            u28 (copy, index: 47)
            u22 (copy, index: 48)
            u19 (copy, index: 49)
            u20 (copy, index: 50)
            u16 (copy, index: 51)
            u17 (copy, index: 52)
            u2 (copy, index: 53)
            u1 (copy, index: 54)
            padDefault (copy, index: 55)
            startCountdown (copy, index: 56)
            u3 (copy, index: 57)
            u9 (copy, index: 58)
            u51 (copy, index: 59)
            animateXp (copy, index: 60)
            animateTrophies (copy, index: 61)
            tbl_upv_8 (copy, index: 62)
        ]]
        local key_4
        local v68 = State_upv_1.Match
        local u71 = ((type(a26.you) == "table") and (a26.you)) or {}
        local u72 = true
        if a26.custom ~= true then
            u72 = u71.custom == true
        end
        local u73 = u72 or (a26.lobbyOnly == true)
        local u74 = State_upv_1.MyTeam()
        local v69
        if u71.won == nil then
            v69 = a26.winnerTeam == u74
        else
            v69 = u71.won == true
        end
        local v70 = a26.winnerTeam == 0
        local v71
        if v70 then
            v71 = "DRAW"
        else
            v71 = (v69 and "VICTORY") or "DEFEAT"
        end
        u6.Text = v71
        local v72
        if v70 then
            v72 = Colors_upv_1.Bone
        elseif v69 then
            v72 = Colors_upv_1.Accent
        else
            v72 = Colors_upv_1.Enemy
        end
        u6.TextColor3 = v72
        v70 = (v68 ~= nil) and (State_upv_1.TeamSize(v68.teams) == 1)
        v69 = true
        if a26.mode ~= "1v1" then
            v69 = v70 and (State_upv_1.IsDuel() or (not u72))
        end
        layoutRows(v70)
        u5.Visible = v69
        u36 = v69
        if v68 then
            local v73 = v68.teams[u74]
            local v74 = v68.teams[3 - u74]
            local v75
            if v69 then
                v75 = string.format("YOU   %d  -  %d   OPPONENT", v73.score or 0, v74.score or 0)
            else
                v75 = string.format("YOUR TEAM   %d  -  %d   ENEMY TEAM", v73.score or 0, v74.score or 0)
            end
            u7.Text = v75
            placeModeTag()
            paintPips(v73.score or 0, v74.score or 0, (math.clamp(v68.roundsToWin or (State_upv_1.DEFAULT_ROUNDS_TO_WIN), 1, 9)))
        else
            u7.Text = ""
        end
        for key_3, value_7 in {u74, 3 - u74} do
            local tbl_12 = {}
            if v68 then
                for _, value_8 in v68.teams[value_7].members do
                    table.insert(tbl_12, value_8)
                end
            end
            table.sort(
                tbl_12,
                function(a27, a28)
                    --[[
                      line: 1101
                    ]]
                    if (a27.kills or 0) == (a28.kills or 0) then
                        return (a28.damage or 0) < (a27.damage or 0)
                    end
                    return (a28.kills or 0) < (a27.kills or 0)
                end
            )
            for n_6 = 1, 3 do
                memberRow(tbl_upv_3[((key_3 - 1) * 3) + n_6], tbl_12[n_6], key_3 == 1, a26.mvpId)
            end
        end
        local tribe_upv_1, v76 = State_upv_1.FindMember(a26.mvpId)
        u11.Visible = tribe_upv_1 ~= nil
        if tribe_upv_1 then
            Portraits_upv_1.Apply(u12, tribe_upv_1, 150)
            u13.Text = tostring(tribe_upv_1.name)
            local v77
            if tribe_upv_1.id ~= State_upv_1.MyId() then
                State_upv_1.IsAllyTeam(v76)
            end
            v77 = Colors_upv_1.Accent
            u13.TextColor3 = v77
            tbl_upv_6.Text = string.format("%d ELIMS  \194\183  %d DEATHS  \194\183  %s DMG", tribe_upv_1.kills or 0, tribe_upv_1.deaths or 0, UI_upv_1.FormatNumber(tribe_upv_1.damage or 0))
        end
        u14.Position = UDim2.fromOffset(0, (tribe_upv_1 and 130) or 0)
        local u75 = ((type(u71.drop) == "table" and type(u71.drop.stacks) == "table") and (u71.drop)) or nil
        tribe_upv_1 = ((type(u71.streakLost) == "table") and (u71.streakLost)) or nil
        local v78
        if tribe_upv_1 and type(tribe_upv_1.lost) == "number" and type(tribe_upv_1.key) == "string" then
            v78 = tribe_upv_1
        else
            v78 = nil
        end
        u49 = v78
        u50 = nil
        local v79 = true
        if u49 == nil then
            v79 = (tribe_upv_1 ~= nil) and (type(tribe_upv_1.credited) == "number")
        end
        u46.Visible = v79
        if (tribe_upv_1) and type(tribe_upv_1.credited) == "number" then
            a1.Loc.Rich(u47, string.format("<font color=\"#FFC478\">%d</font> WIN STREAK KEPT<br/><font size=\"13\" color=\"#8C93A5\">Your saved streak restore was used</font>", tribe_upv_1.credited))
            u48.Instance.Visible = false
        else
            u48.Instance.Visible = true
        end
        paintRestore()
        if u75 then
            paintDrop(u75)
        else
            u45 = nil
            u39.Visible = false
        end
        u39.Size = UDim2.fromOffset(((u46.Visible) and 700) or 1200, 58)
        u38.Visible = u39.Visible or (u46.Visible)
        v79 = (u72 and "") or ("+" .. UI_upv_1.FormatNumber(tonumber(u71.xp) or 0) .. " XP")
        u18.Text = v79
        u23(0, true)
        tribe_upv_1 = tonumber(u71.streak) or 0
        u24.Visible = tribe_upv_1 >= 2
        u25.Text = tribe_upv_1 .. " WIN STREAK"
        for key_4, value_9 in u27:GetChildren() do
            if value_9:IsA("GuiObject") then
                value_9:Destroy()
            end
        end
        if type(u71.lines) == "table" then
            local v80 = nil
            for key_5, value_10 in u71.lines do
                if key_5 > 8 then
                    break
                end
                if type(value_10) ~= "table" then
                    continue
                end
                local new_4 = UI_upv_1.new
                local tbl_13 = {LayoutOrder = 0, FontFace = 0, TextTruncate = 0, TextColor3 = 0, Parent = 0, Text = 0, TextSize = 15, TextXAlignment = 0}
                local format_1 = string.format
                local str_1 = tostring(value_10.label or "")
                local v81 = tonumber(value_10.xp) or 0
                if not (Theme_upv_1.ShowCurrency) then
                    v80 = ""
                    tbl_13.Text = format_1("%s  +%d XP%s", str_1, v81, v80)
                    tbl_13.FontFace = Fonts_upv_1.SemiBold
                    tbl_13.TextColor3 = Colors_upv_1.TextDim
                    tbl_13.TextXAlignment = Enum.TextXAlignment.Left
                    tbl_13.TextTruncate = Enum.TextTruncate.AtEnd
                    tbl_13.LayoutOrder = nil
                    tbl_13.Parent = u27
                    new_4("TextLabel", tbl_13)
                    continue
                end
                if (tonumber(value_10.shells) or 0) > 0 then
                    v80 = "  +" .. value_10.shells
                else
                    v80 = ""
                end
                tbl_13.Text = format_1("%s  +%d XP%s", str_1, v81, v80)
                tbl_13.FontFace = Fonts_upv_1.SemiBold
                tbl_13.TextColor3 = Colors_upv_1.TextDim
                tbl_13.TextXAlignment = Enum.TextXAlignment.Left
                tbl_13.TextTruncate = Enum.TextTruncate.AtEnd
                tbl_13.LayoutOrder = nil
                tbl_13.Parent = u27
                new_4("TextLabel", tbl_13)
            end
        end
        tribe_upv_1 = u71.tribe
        u26.Visible = false
        if type(tribe_upv_1) == "table" and type(tribe_upv_1.tag) == "string" then
            if tribe_upv_1.split then
                v69 = string.format("[%s]  no Glory: tribemates on both teams", tribe_upv_1.tag)
            else
                local format_2 = string.format
                local tag_1 = tribe_upv_1.tag
                key_4 = tonumber(tribe_upv_1.renown) or 0
                local v82
                if (tonumber(tribe_upv_1.mates) or 1) > 1 then
                    v82 = string.format("  (x%s with tribemates)", ((tribe_upv_1.mates >= 3) and "2") or "1.5")
                else
                    v82 = ""
                end
                v69 = format_2("[%s]  +%d Glory%s", tag_1, key_4, v82)
            end
            if Theme_upv_1.ShowCurrency then
                UI_upv_1.new("TextLabel", {LayoutOrder = 98, TextSize = 15, Text = v69, FontFace = Fonts_upv_1.Bold, TextColor3 = Color3.fromRGB(255, 196, 80), TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = u27})
            else
                u26.Text = v69
                u26.Visible = not u72
            end
        end
        if Theme_upv_1.ShowCurrency and tonumber(u71.levelShells) and u71.levelShells > 0 then
            UI_upv_1.new("TextLabel", {LayoutOrder = 99, TextSize = 15, Text = string.format("Level up  +%d", u71.levelShells), FontFace = Fonts_upv_1.SemiBold, TextColor3 = Colors_upv_1.Shell, TextXAlignment = Enum.TextXAlignment.Left, Parent = u27})
        end
        u53 = true
        u63 = u63 + 1
        tribe_upv_1 = u63
        a1.SetHudHidden("MatchEnd", true)
        a1.MenuManager.PushMouse("MatchEnd")
        u52 = false
        u60 = false
        u55:SetText("PLAY AGAIN")
        u56.Instance.Visible = false
        u55.Instance.Visible = not u73
        local v83 = State_upv_1.Get("Queued") == true
        if v83 then
            paintSearch()
        end
        u57:SetStyle((u73 and "Primary") or "Dark")
        local Instance_1 = u57.Instance
        Instance_1.Size = UDim2.fromOffset((u73 and 320) or 220, 80)
        u57:SetText("LOBBY")
        u70 = u70 + 1
        local _ = u72 or type(u71.trophies) ~= "table" or u71.trophies
        if u74 ~= nil then
            v79 = true
        else
            v79 = false
        end
        u28.Visible = v79
        local v84 = 98
        if u74 then
            u28.Position = UDim2.fromOffset(16, v84)
            v68 = v84 + 44
        else
            v68 = v84
        end
        u22.Position = UDim2.fromOffset(16, v68 + 6)
        if Theme_upv_1.ShowCurrency then
            v79 = UDim2.new(1, -16, 0, v68 + 2)
        else
            v79 = UDim2.fromOffset(16, v68 + 2)
        end
        u24.Position = v79
        u26.Position = UDim2.new(1, -16, 0, v84 + 4)
        if u24.Visible or u26.Visible or Theme_upv_1.ShowCurrency and u22.Visible then
            v68 = v84 + 46
        else
            v68 = v84
        end
        local v85 = v68 + 4
        u27.Position = UDim2.fromOffset(16, v85)
        local v86 = 0
        for v91, value_11 in u27:GetChildren() do
            v86 = (value_11:IsA("TextLabel") and (v86 + 1)) or v86
        end
        v79 = math.max(1, math.ceil(v86 / 2))
        local v87 = math.clamp(math.floor((((290 - v85) - 10) - ((v79 - 1) * 3)) / v79), 16, 22)
        v68 = ((v87 >= 20) and 3) or 2
        local Grid_1 = u27:FindFirstChild("Grid")
        if Grid_1 then
            Grid_1.CellSize = UDim2.new(0.5, -6, 0, v87)
            Grid_1.CellPadding = UDim2.fromOffset(12, v68)
        end
        for v92, value_12 in u27:GetChildren() do
            if value_12:IsA("TextLabel") then
                value_12.TextSize = math.min(15, v87 - 3)
            end
        end
        u27.Size = UDim2.new(1, -32, 0, v79 * (v87 + v68))
        u14.Size = UDim2.fromOffset(480, (u72 and 106) or 290)
        u19.Frame.Visible = not u72
        u20.Position = UDim2.fromOffset(100, (u72 and 52) or 74)
        u20.TextSize = (u72 and 16) or 15
        if u72 then
            local v88 = tonumber(u71.levelAfter) or (State_upv_1.Level())
            u16.Text = tostring(v88)
            u17.Text = "CUSTOM MATCH"
            local v89 = a1.Custom and (a1.Custom.State())
            u20.AutoLocalize = false
            local v90
            if type(v89) == "table" and type(v89.name) == "string" then
                v90 = v89.name
            else
                v90 = ""
            end
            u20.Text = v90
        end
        local function openResults_upv_1(a29)
            --[[
              name: openResults
              line: 1284
              upvalues:
                tribe_upv_1 (copy, index: 1)
                u63 (ref,  index: 2)
                u53 (ref,  index: 3)
                u2 (copy, index: 4)
                u1 (copy, index: 5)
                UI_upv_1 (copy, index: 6)
                Theme_upv_1 (copy, index: 7)
                a1 (copy, index: 8)
                padDefault (copy, index: 9)
                u73 (copy, index: 10)
                u70 (ref,  index: 11)
                a26 (copy, index: 12)
                State_upv_1 (copy, index: 13)
                u57 (copy, index: 14)
                u71 (copy, index: 15)
                u60 (ref,  index: 16)
                startCountdown (copy, index: 17)
                u3 (copy, index: 18)
                u6 (copy, index: 19)
                u7 (copy, index: 20)
                u9 (copy, index: 21)
                u11 (copy, index: 22)
                u14 (copy, index: 23)
                tbl_upv_3 (copy, index: 24)
                u51 (copy, index: 25)
                u23 (copy, index: 26)
                u22 (copy, index: 27)
                u24 (copy, index: 28)
                u72 (copy, index: 29)
                animateXp (copy, index: 30)
                u74 (copy, index: 31)
                animateTrophies (copy, index: 32)
                u38 (copy, index: 33)
                tbl_upv_8 (copy, index: 34)
            ]]
            if tribe_upv_1 ~= u63 or not u53 then
                return
            end
            u2.Visible = true
            u1.Visible = true
            u1.BackgroundTransparency = 1
            UI_upv_1.Tween(u1, Theme_upv_1.Tween.Slow, {BackgroundTransparency = 0.25})
            a1.MenuManager.PushFocus("MatchEnd", padDefault)
            if u73 then
                local u76 = u70
                local num_upv_2 = tonumber(a26.closesAt)
                if num_upv_2 then
                    task.spawn(
                        function()
                            --[[
                              line: 1298
                              upvalues:
                                u76 (copy, index: 1)
                                u70 (ref,  index: 2)
                                u53 (ref,  index: 3)
                                num_upv_2 (copy, index: 4)
                                State_upv_1 (copy, index: 5)
                                u57 (copy, index: 6)
                            ]]
                            local v92 = -1
                            while u76 == u70 and (u53) do
                                local v93 = math.ceil(num_upv_2 - State_upv_1.Now())
                                if v93 <= 0 then
                                    break
                                end
                                if v93 ~= v92 then
                                    u57:SetText("LOBBY  " .. v93)
                                    v92 = v93
                                end
                                task.wait(0.1)
                            end
                        end
                    )
                end
            elseif u71.inactive ~= true then
                local num_3 = tonumber(a26.autoRequeueAt)
                if a29 then
                    num_3 = math.max(num_3 or 0, State_upv_1.Now() + 15)
                    if type(a26.closesAt) == "number" then
                        num_3 = math.min(num_3, a26.closesAt - 3)
                    end
                end
                if not (u60) then
                    startCountdown(num_3)
                end
            end
            UI_upv_1.Unfade(u3)
            u6.TextTransparency = 0
            UI_upv_1.Pop(u6, 2.2, Theme_upv_1.Tween.Slam)
            UI_upv_1.Enter(u7, Vector2.new(0, 20), 0.25)
            UI_upv_1.Enter(u9, Vector2.new(-40, 0), 0.35)
            UI_upv_1.Enter(u11, Vector2.new(40, 0), 0.45)
            UI_upv_1.Enter(u14, Vector2.new(40, 0), 0.55)
            for key_6, value_13 in tbl_upv_3 do
                UI_upv_1.Enter(value_13.inner, Vector2.new(-24, 0), (key_6 * 0.05) + 0.45, UDim2.new())
            end
            UI_upv_1.Enter(u51, Vector2.new(0, 30), 0.8)
            task.delay(
                1,
                function()
                    --[[
                      line: 1338
                      upvalues:
                        tribe_upv_1 (copy, index: 1)
                        u63 (ref,  index: 2)
                        u23 (copy, index: 3)
                        u71 (copy, index: 4)
                        Theme_upv_1 (copy, index: 5)
                        a1 (copy, index: 6)
                        UI_upv_1 (copy, index: 7)
                        u22 (copy, index: 8)
                        u24 (copy, index: 9)
                    ]]
                    if tribe_upv_1 ~= u63 then
                        return
                    end
                    u23(tonumber(u71.shells) or 0)
                    if Theme_upv_1.ShowCurrency and (tonumber(u71.shells) or 0) > 0 then
                        a1.Sounds.Play("Reward")
                        UI_upv_1.Bump(u22, 0.2)
                    end
                    if u24.Visible then
                        UI_upv_1.Pop(u24, 1.5)
                    end
                end
            )
            task.delay(
                0.9,
                function()
                    --[[
                      line: 1351
                      upvalues:
                        tribe_upv_1 (copy, index: 1)
                        u63 (ref,  index: 2)
                        u72 (copy, index: 3)
                        animateXp (copy, index: 4)
                        u71 (copy, index: 5)
                    ]]
                    if tribe_upv_1 ~= u63 or (u72) then
                        return
                    end
                    animateXp(u71, tribe_upv_1)
                end
            )
            if u74 then
                animateTrophies(u74, tribe_upv_1)
            end
            if u38.Visible then
                UI_upv_1.Enter(u38, Vector2.new(0, 20), 0.7)
                for key_7, value_14 in tbl_upv_8 do
                    if value_14.frame.Visible then
                        local v94 = UI_upv_1.GetScaleObj(value_14.frame)
                        v94.Scale = 0
                        local tbl_14 = {Scale = 1}
                        UI_upv_1.Tween(v94, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, (key_7 * 0.06) + 0.8), tbl_14)
                    end
                end
            end
        end
        u2.Visible = false
        u1.Visible = false
        local DropReveal_upv_2 = a1.DropReveal
        if type(u71.rankDrop) == "table" and type(u71.rankDrop.stacks) == "table" then
            v68 = u71.rankDrop
        else
            v68 = nil
        end
        local v90 = false
        local function playMatchDrop_upv_1()
            --[[
              name: playMatchDrop
              line: 1376
              upvalues:
                u75 (copy, index: 1)
                DropReveal_upv_2 (copy, index: 2)
                openResults_upv_1 (copy, index: 3)
            ]]
            local v95 = false
            if u75 ~= nil then
                v95 = false
                if DropReveal_upv_2 ~= nil then
                    local tbl_15 = {source = "match"}
                    function tbl_15.onDone()
                        --[[
                          name: onDone
                          line: 1379
                          upvalues:
                            openResults_upv_1 (copy, index: 1)
                        ]]
                        openResults_upv_1(true)
                    end
                    v95 = DropReveal_upv_2.Play(u75, tbl_15)
                end
            end
            return v95
        end
        if v68 ~= nil then
            v90 = false
            if DropReveal_upv_2 ~= nil then
                local tbl_16 = {source = "match"}
                function tbl_16.onDone(a30)
                    --[[
                      name: onDone
                      line: 1386
                      upvalues:
                        playMatchDrop_upv_1 (copy, index: 1)
                        openResults_upv_1 (copy, index: 2)
                    ]]
                    if a30 ~= "interrupted" and playMatchDrop_upv_1() then
                        return
                    end
                    openResults_upv_1(true)
                end
                v90 = DropReveal_upv_2.Play(v68, tbl_16)
            end
        end
        if not (v90) then
            v90 = playMatchDrop_upv_1()
        end
        if (v90) then
            return
        end
        openResults_upv_1(false)
    end
    u54 = function(a31)
        --[[
          line: 1401
          upvalues:
            u53 (ref,  index: 1)
            u60 (ref,  index: 2)
            u59 (ref,  index: 3)
            u63 (ref,  index: 4)
            u70 (ref,  index: 5)
            u58 (ref,  index: 6)
            u56 (copy, index: 7)
            a1 (copy, index: 8)
            u2 (copy, index: 9)
            u1 (copy, index: 10)
            UI_upv_1 (copy, index: 11)
            Theme_upv_1 (copy, index: 12)
            u3 (copy, index: 13)
        ]]
        if not u53 then
            return
        end
        u53 = false
        u60 = false
        u59 = u59 + 1
        u63 = u63 + 1
        u70 = u70 + 1
        u58 = u58 + 1
        u56.Instance.Visible = u60
        a1.SetHudHidden("MatchEnd", false)
        a1.MenuManager.PopMouse("MatchEnd")
        a1.MenuManager.PopFocus("MatchEnd")
        if a31 then
            u2.Visible = false
            u1.Visible = false
        else
            UI_upv_1.Tween(u1, Theme_upv_1.Tween.Close, {BackgroundTransparency = 1})
            UI_upv_1.FadeOut(u3, TweenInfo.new(0.2))
            task.delay(
                0.22,
                function()
                    --[[
                      line: 1421
                      upvalues:
                        u53 (ref,  index: 1)
                        u2 (copy, index: 2)
                        u1 (copy, index: 3)
                    ]]
                    if (u53) then
                        return
                    end
                    u2.Visible = false
                    u1.Visible = false
                end
            )
            task.delay(
                0.6,
                function()
                    --[[
                      line: 1429
                      upvalues:
                        u53 (ref,  index: 1)
                        UI_upv_1 (copy, index: 2)
                        u3 (copy, index: 3)
                    ]]
                    if (u53) then
                        return
                    end
                    UI_upv_1.Unfade(u3)
                end
            )
        end
    end
    UI_upv_1.Unfade(u3)
    for v17, value_15 in {u7, u9, u11, u14, u51, u38} do
        UI_upv_1.Unfade(value_15)
    end
    a1.OnMatchEvent(
        function(a32, a33)
            --[[
              line: 1442
              upvalues:
                LocalPlayer_upv_1 (copy, index: 1)
                show (copy, index: 2)
                u54 (ref,  index: 3)
            ]]
            if a32 == "MatchEnd" and type(a33) == "table" then
                local u77 = LocalPlayer_upv_1:GetAttribute("MatchId")
                task.delay(
                    1.2,
                    function()
                        --[[
                          line: 1447
                          upvalues:
                            LocalPlayer_upv_1 (copy, index: 1)
                            u77 (copy, index: 2)
                            show (copy, index: 3)
                            a33 (copy, index: 4)
                        ]]
                        local v96 = 0
                        while LocalPlayer_upv_1:GetAttribute("ReplayPlaying") == true do
                            if v96 < 40 then
                                v96 = v96 + task.wait(0.1)
                                continue
                            else
                                break
                            end
                        end
                        if (not (v96 > 0) or LocalPlayer_upv_1:GetAttribute("State") == "Match") and LocalPlayer_upv_1:GetAttribute("MatchId") == u77 then
                            show(a33)
                        end
                    end
                )
                return
            end
            if a32 ~= "MatchStart" then
                return
            end
            u54(true)
        end
    )
    State_upv_1.AttrChanged:Connect(
        function(a34)
            --[[
              line: 1466
              upvalues:
                u53 (ref, index: 1)
                u54 (ref, index: 2)
            ]]
            if not u53 or a34 ~= "MatchId" then
                return
            end
            u54(true)
        end
    )
    State_upv_1.PlayerStateChanged:Connect(
        function(a35)
            --[[
              line: 1471
              upvalues:
                u53 (ref, index: 1)
                u54 (ref, index: 2)
            ]]
            if not u53 or a35 ~= "Lobby" then
                return
            end
            u54()
        end
    )
    a1.Debug.matchEndCancel = function()
        --[[
          line: 1478
          upvalues:
            onCancel (copy, index: 1)
            u55 (copy, index: 2)
            u56 (copy, index: 3)
            u60 (ref,  index: 4)
        ]]
        onCancel()
        local tbl_17 = {}
        tbl_17.again = u55.Label.Text
        tbl_17.cancel = u56.Instance.Visible
        tbl_17.joining = u60
        return tbl_17
    end
    a1.Debug.matchEndClose = function()
        --[[
          line: 1482
          upvalues:
            u54 (ref, index: 1)
        ]]
        u54()
        return true
    end
end
return tbl_1