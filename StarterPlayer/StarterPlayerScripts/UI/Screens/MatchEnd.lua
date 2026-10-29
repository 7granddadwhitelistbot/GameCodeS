local Players_upv_1 = game:GetService("Players")
local RankArt_upv_1 = require(script.Parent.Parent.RankArt)
local tbl_1 = {}
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 35
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
          line: 60
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
          line: 105
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
    local u22 = UI_upv_1.new("Frame", {Visible = false, Name = "Streak", Position = UDim2.fromOffset(16, 108), Size = UDim2.fromOffset(220, 44), Parent = u14})
    UI_upv_1.Image(UI_upv_1.Assets.Icons.Fire, {Size = UDim2.fromOffset(40, 40), Parent = u22})
    local u23 = UI_upv_1.DisplayText({StrokeThickness = 2, Text = "3 WIN STREAK", TextSize = 26, Position = UDim2.fromOffset(44, 4), Size = UDim2.new(1, -44, 0, 36), TextColor3 = Colors_upv_1.Warning, TextXAlignment = Enum.TextXAlignment.Left, Parent = u22})
    local u24 = UI_upv_1.new("TextLabel", {Visible = false, Text = "", Name = "Glory", TextWrapped = true, TextSize = 16, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -16, 0, 108), Size = UDim2.fromOffset(220, 40), FontFace = Fonts_upv_1.Bold, TextColor3 = Color3.fromRGB(255, 196, 80), TextXAlignment = Enum.TextXAlignment.Right, Parent = u14})
    local u25 = UI_upv_1.new("Frame", {Name = "Lines", Position = UDim2.fromOffset(16, 162), Size = UDim2.new(1, -32, 0, 104), [1] = UI_upv_1.new("UIGridLayout", {Name = "Grid", CellSize = UDim2.new(0.5, -6, 0, 22), CellPadding = UDim2.fromOffset(12, 3), SortOrder = Enum.SortOrder.LayoutOrder}), Parent = u14})
    local RankArt_upv_2 = require(script.Parent.Parent.RankArt)
    local Ranks_upv_1 = RankArt_upv_2.Ranks
    local u26 = UI_upv_1.new("Frame", {Visible = false, Name = "Trophies", Position = UDim2.fromOffset(16, 102), Size = UDim2.new(1, -32, 0, 44), Parent = u14})
    local u27 = RankArt_upv_2.Emblem(1, 44, {Parent = u26})
    local u28 = UI_upv_1.new("TextLabel", {Name = "Rank", Position = UDim2.fromOffset(54, 0), Size = UDim2.fromOffset(230, 22), Text = "", FontFace = Fonts_upv_1.Display, TextSize = 20, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Left, [1] = UI_upv_1.TextStroke(Colors_upv_1.Void, 1.5, 0.4), Parent = u26})
    local u29 = UI_upv_1.Bar({Name = "Bar", Position = UDim2.fromOffset(54, 24), Size = UDim2.fromOffset(220, 9), Color = Colors_upv_1.Gold, Parent = u26})
    local u30 = UI_upv_1.new("TextLabel", {Text = "", Name = "Next", TextSize = 12, Position = UDim2.fromOffset(54, 33), Size = UDim2.fromOffset(220, 14), FontFace = Fonts_upv_1.SemiBold, TextColor3 = Colors_upv_1.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, Parent = u26})
    local u31 = UI_upv_1.DisplayText({StrokeThickness = 2, Text = "+0", Name = "Delta", TextSize = 26, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 0, 0, -3), Size = UDim2.fromOffset(120, 28), TextColor3 = Colors_upv_1.Success, TextXAlignment = Enum.TextXAlignment.Right, Parent = u26})
    local u32 = 50
    pcall(
        function()
            --[[
              line: 485
              upvalues:
                u32 (ref, index: 1)
            ]]
            local num_1 = tonumber(require(game:GetService("ReplicatedStorage").Shared.Config).DUEL_TROPHY_MULT)
            if not num_1 then
                return
            end
            u32 = math.floor((num_1 * 100) + 0.5)
        end
    )
    local u33 = UI_upv_1.Pill(string.format("1V1  \194\183  %d%%", u32), Color3.fromRGB(64, 48, 14), {Name = "Duel", PadX = 8, Height = 22, TextSize = 14, TextColor = Colors_upv_1.Gold, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -64, 0, 1), Parent = u26})
    u33.Visible = false
    local u34 = false
    local v13 = UI_upv_1.new("Frame", {Name = "Count", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 0, 0, 24), Size = UDim2.fromOffset(150, 20), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 4, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center), Parent = u26})
    RankArt_upv_2.Trophy(20, {LayoutOrder = 1, Parent = v13})
    local u35 = UI_upv_1.CountUp(
        UI_upv_1.new("TextLabel", {LayoutOrder = 2, Text = "0", Name = "N", TextSize = 20, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 22), FontFace = Fonts_upv_1.Display, TextColor3 = Colors_upv_1.Text, Parent = v13}),
        function(a2)
            --[[
              line: 524
              upvalues:
                UI_upv_1 (copy, index: 1)
            ]]
            return UI_upv_1.FormatNumber(a2)
        end,
        1
    )
    local Economy_upv_1 = a1.Economy
    local u36 = UI_upv_1.new("Frame", {Name = "Economy", Position = UDim2.fromOffset(0, 592), Size = UDim2.fromOffset(1200, 58), Parent = u3})
    local u37 = UI_upv_1.new("TextButton", {Visible = false, Name = "Drop", Size = UDim2.fromOffset(700, 58), Parent = u36})
    UI_upv_1.Panel({BackgroundTransparency = 0.1, Name = "Bg", Size = UDim2.fromScale(1, 1), Parent = u37})
    local u38 = UI_upv_1.GetScaleObj(u37, "HoverScale")
    local u39 = UI_upv_1.Image(UI_upv_1.Assets.Fx.Gem, {AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 12, 0.5, 0), Size = UDim2.fromOffset(34, 34), ImageColor3 = Colors_upv_1.Accent, Parent = u37})
    local u40 = UI_upv_1.new("TextLabel", {Text = "DROP", Name = "Title", TextSize = 18, Position = UDim2.fromOffset(54, 8), Size = UDim2.fromOffset(170, 22), FontFace = Fonts_upv_1.Heavy, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = u37})
    local u41 = UI_upv_1.new("TextLabel", {Text = "", Name = "Sub", TextSize = 14, Position = UDim2.fromOffset(54, 30), Size = UDim2.fromOffset(170, 18), FontFace = Fonts_upv_1.Bold, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Left, Parent = u37})
    local u42 = UI_upv_1.new("Frame", {Name = "Cards", Position = UDim2.fromOffset(222, 5), Size = UDim2.new(1, -230, 0, 48), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center), Parent = u37})
    local tbl_upv_7 = {}
    local u43 = nil
    local function dTile(a3)
        --[[
          name: dTile
          line: 578
          upvalues:
            tbl_upv_7 (copy, index: 1)
            UI_upv_1 (copy, index: 2)
            u42 (copy, index: 3)
            Colors_upv_1 (copy, index: 4)
            Fonts_upv_1 (copy, index: 5)
        ]]
        local v14 = tbl_upv_7[a3]
        if v14 then
            return v14
        end
        local v15 = UI_upv_1.new("Frame", {Name = "Card" .. a3, Size = UDim2.fromOffset(92, 48), LayoutOrder = a3, Parent = u42})
        local tbl_8 = {}
        tbl_8.Name = "Tile"
        tbl_8.AnchorPoint = Vector2.new(0, 0.5)
        tbl_8.Position = UDim2.new(0, 0, 0.5, 0)
        tbl_8.Size = UDim2.fromOffset(44, 44)
        tbl_8.BackgroundColor3 = Color3.new(1, 1, 1)
        tbl_8[1] = UI_upv_1.Corner(9)
        tbl_8.Parent = v15
        local v16 = UI_upv_1.new("Frame", tbl_8)
        local v17 = UI_upv_1.Gradient(Colors_upv_1.Accent, Colors_upv_1.Panel, 115)
        v17.Parent = v16
        local tbl_9 = {
            frame = v15,
            grad = v17,
            icon = UI_upv_1.new("Frame", {Name = "Icon", ZIndex = 2, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.94, 0.94), Parent = v16}),
            count = UI_upv_1.new("TextLabel", {Name = "N", Text = "x0", TextSize = 20, Position = UDim2.fromOffset(49, 2), Size = UDim2.fromOffset(44, 24), FontFace = Fonts_upv_1.Display, TextXAlignment = Enum.TextXAlignment.Left, Parent = v15}),
            tag = UI_upv_1.new("TextLabel", {Text = "", Name = "Tag", TextSize = 12, Position = UDim2.fromOffset(49, 26), Size = UDim2.fromOffset(50, 16), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Left, Parent = v15})
        }
        tbl_upv_7[a3] = tbl_9
        return tbl_9
    end
    local function paintDrop(a4)
        --[[
          name: paintDrop
          line: 596
          upvalues:
            u43 (ref,  index: 1)
            a1 (copy, index: 2)
            u37 (copy, index: 3)
            Colors_upv_1 (copy, index: 4)
            u39 (copy, index: 5)
            u40 (copy, index: 6)
            u41 (copy, index: 7)
            tbl_upv_7 (copy, index: 8)
            WeaponIcon_upv_1 (copy, index: 9)
            dTile (copy, index: 10)
            Economy_upv_1 (copy, index: 11)
            Theme_upv_1 (copy, index: 12)
        ]]
        u43 = a4
        local v18 = a1.DropReveal
        local v19 = not (v18) or not (v18.Normalize) or v18.Normalize(a4)
        local v20 = false
        if v19 ~= nil then
            v20 = #v19.stacks > 0
        end
        u37.Visible = v20
        if not v19 then
            return
        end
        local v21
        if v19.kind == "golden" then
            v21 = Colors_upv_1.Gold
        elseif v19.kind ~= "victory" then
            v21 = Color3.fromRGB(150, 180, 226)
        else
            v21 = Colors_upv_1.Accent
        end
        u39.ImageColor3 = v21
        if v19.kind ~= "golden" then
            v20 = ((v19.kind ~= "victory") and "DROP") or "VICTORY DROP"
        else
            v20 = "GOLDEN DROP"
        end
        u40.Text = v20
        u40.TextColor3 = v21:Lerp(Color3.new(1, 1, 1), 0.35)
        v18 = 0
        for _, value_3 in v19.stacks do
            v18 = v18 + value_3.shards
        end
        u41.Text = string.format("+%d shards", v18)
        for n_3 = 1, math.max(#v19.stacks, #tbl_upv_7) do
            local v23 = v19.stacks[n_3]
            if n_3 > 5 or not (v23) then
                local v24 = tbl_upv_7[n_3]
                if v24 then
                    v24.frame.Visible = false
                    WeaponIcon_upv_1.Set(v24.icon, nil)
                end
            end
            local v25 = dTile(n_3)
            local v26 = nil
            if not (Economy_upv_1) or not (Economy_upv_1.CategoryColor) then
                v26 = Colors_upv_1.Accent
                v25.frame.Visible = true
                v25.grad.Color = ColorSequence.new(v26:Lerp(Colors_upv_1.Panel, 0.5), Colors_upv_1.PanelHi:Lerp(Colors_upv_1.Panel, 0.6))
                WeaponIcon_upv_1.Set(v25.icon, v23.item, {outline = false, glow = false})
                v25.count.Text = "x" .. v23.shards
                if v23.unlocked then
                    v25.tag.Text = "NEW"
                    v25.tag.TextColor3 = Colors_upv_1.Gold
                    continue
                end
                if v23.ready then
                    v25.tag.Text = "UPGRADE"
                    v25.tag.TextColor3 = Theme_upv_1.Lighten(Colors_upv_1.Success, 0.15)
                    continue
                end
                if v23.levelBefore <= 0 then
                    v25.tag.Text = string.format("%d/%d", v23.total, v23.need or 0)
                    v25.tag.TextColor3 = Colors_upv_1.TextMuted
                else
                    v25.tag.Text = "LV " .. v23.levelBefore
                    v25.tag.TextColor3 = Colors_upv_1.TextDim
                end
            end
            v26 = Economy_upv_1.CategoryColor(v23.item)
            v25.frame.Visible = true
            v25.grad.Color = ColorSequence.new(v26:Lerp(Colors_upv_1.Panel, 0.5), Colors_upv_1.PanelHi:Lerp(Colors_upv_1.Panel, 0.6))
            WeaponIcon_upv_1.Set(v25.icon, v23.item, {outline = false, glow = false})
            v25.count.Text = "x" .. v23.shards
            if v23.unlocked then
                v25.tag.Text = "NEW"
                v25.tag.TextColor3 = Colors_upv_1.Gold
                continue
            end
            if v23.ready then
                v25.tag.Text = "UPGRADE"
                v25.tag.TextColor3 = Theme_upv_1.Lighten(Colors_upv_1.Success, 0.15)
                continue
            end
            if v23.levelBefore <= 0 then
                v25.tag.Text = string.format("%d/%d", v23.total, v23.need or 0)
                v25.tag.TextColor3 = Colors_upv_1.TextMuted
            else
                v25.tag.Text = "LV " .. v23.levelBefore
                v25.tag.TextColor3 = Colors_upv_1.TextDim
            end
        end
    end
    u37.MouseEnter:Connect(
        function()
            --[[
              line: 644
              upvalues:
                UI_upv_1 (copy, index: 1)
                u38 (copy, index: 2)
                Theme_upv_1 (copy, index: 3)
            ]]
            if (UI_upv_1.Touch) then
                return
            end
            UI_upv_1.Tween(u38, Theme_upv_1.Tween.PopSmall, {Scale = 1.02})
        end
    )
    u37.MouseLeave:Connect(
        function()
            --[[
              line: 649
              upvalues:
                UI_upv_1 (copy, index: 1)
                u38 (copy, index: 2)
                Theme_upv_1 (copy, index: 3)
            ]]
            UI_upv_1.Tween(u38, Theme_upv_1.Tween.Fast, {Scale = 1})
        end
    )
    u37.Activated:Connect(
        function()
            --[[
              line: 652
              upvalues:
                a1 (copy, index: 1)
                u43 (ref,  index: 2)
            ]]
            local DropReveal_1 = a1.DropReveal
            if not u43 or not DropReveal_1 or (DropReveal_1.IsPlaying()) then
                return
            end
            a1.Sounds.Play("Click")
            DropReveal_1.ShowSummary(u43, {source = "match"})
        end
    )
    local u44 = UI_upv_1.Panel({Visible = false, Name = "StreakLost", StrokeTransparency = 0.6, BackgroundTransparency = 0.1, Position = UDim2.fromOffset(720, 0), Size = UDim2.fromOffset(480, 58), StrokeColor = Color3.fromRGB(255, 150, 60), Parent = u36})
    UI_upv_1.Image(UI_upv_1.Assets.Icons.Fire, {AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 12, 0.5, 0), Size = UDim2.fromOffset(34, 34), Parent = u44})
    local u45 = UI_upv_1.new("TextLabel", {RichText = true, Text = "", TextWrapped = true, Name = "Text", TextSize = 17, Position = UDim2.fromOffset(52, 0), Size = UDim2.new(1, -250, 1, 0), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Left, Parent = u44})
    local u46 = UI_upv_1.Button({Style = "Success", Name = "Restore", Text = "RESTORE", TextSize = 17, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.fromOffset(186, 44), Parent = u44})
    local u47 = nil
    local u48 = nil
    local function paintRestore()
        --[[
          name: paintRestore
          line: 686
          upvalues:
            u44 (copy, index: 1)
            u47 (ref,  index: 2)
            u48 (ref,  index: 3)
            a1 (copy, index: 4)
            u45 (copy, index: 5)
            u46 (copy, index: 6)
            Economy_upv_1 (copy, index: 7)
        ]]
        if not u44.Visible or not u47 then
            return
        end
        if u48 then
            a1.Loc.Rich(u45, string.format("<font color=\"#FFC478\">%d</font> WIN STREAK RESTORED", u48))
            u46:SetStyle("Dark")
            u46:SetEnabled(false)
            u46:SetText("\226\156\147 RESTORED")
        else
            local v27 = Economy_upv_1.Pending(u47.key)
            a1.Loc.Rich(u45, string.format("<font color=\"#FFC478\">%d</font> WIN STREAK LOST<br/><font size=\"13\" color=\"#8C93A5\">Bring it back: the offer lasts 24 hours</font>", u47.lost))
            u46:SetStyle("Success")
            u46:SetEnabled(not v27)
            local v28 = (v27 and "RESTORING\226\128\166") or ("RESTORE  " .. Economy_upv_1.PriceText(u47.key))
            u46:SetText(v28)
        end
    end
    local u49 = UI_upv_1.new("Frame", {Name = "Buttons", AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, 0), Size = UDim2.fromOffset(800, 84), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 20, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center), Parent = u3})
    local u50 = false
    local u51 = false
    local u52 = nil
    local u53 = UI_upv_1.Button({LayoutOrder = 1, Style = "Primary", Name = "PlayAgain", PassInput = true, Text = "PLAY AGAIN", TextSize = 32, Size = UDim2.fromOffset(320, 80), Parent = u49})
    local u54 = UI_upv_1.Button({LayoutOrder = 2, Style = "Dark", Name = "CancelAgain", Visible = false, Text = "CANCEL", TextSize = 24, Size = UDim2.fromOffset(160, 80), Parent = u49})
    local u55 = UI_upv_1.Button({LayoutOrder = 3, Name = "Lobby", Style = "Dark", Text = "LOBBY", TextSize = 28, Size = UDim2.fromOffset(220, 80), Parent = u49})
    for v14, searching in {u53, u54, u55} do
        searching.Instance:GetPropertyChangedSignal("Visible"):Connect(
            function()
                --[[
                  line: 759
                  upvalues:
                    u51 (ref,  index: 1)
                    a1 (copy, index: 2)
                ]]
                if not u51 then
                    return
                end
                task.defer(a1.MenuManager.Reselect)
            end
        )
    end
    local u56 = 0
    local u57 = 0
    local u58 = false
    local function v14()
        --[[
          name: stopCountdown
          line: 773
          upvalues:
            u56 (ref,  index: 1)
            u54 (copy, index: 2)
            u58 (ref,  index: 3)
        ]]
        u56 = u56 + 1
        u54.Instance.Visible = u58
    end
    local function searching()
        --[[
          name: searching
          line: 781
          upvalues:
            State_upv_1 (copy, index: 1)
        ]]
        local v29 = State_upv_1.Get("Queued") == true
        return v29
    end
    local function paintSearch()
        --[[
          name: paintSearch
          line: 784
          upvalues:
            u51 (ref,  index: 1)
            u57 (ref,  index: 2)
            State_upv_1 (copy, index: 3)
            u58 (ref,  index: 4)
            u56 (ref,  index: 5)
            u54 (copy, index: 6)
            u53 (copy, index: 7)
            LocalPlayer_upv_1 (copy, index: 8)
        ]]
        if not u51 then
            return
        end
        u57 = u57 + 1
        local u59 = u57
        local v30 = State_upv_1.Get("Queued") == true
        if v30 then
            if not (u58) then
                u56 = u56 + 1
                u58 = true
            end
            local v31 = State_upv_1.Get("QueueFound") == true
            u54.Instance.Visible = not v31
            if v31 then
                u53:SetText("MATCH FOUND")
            else
                task.spawn(
                    function()
                        --[[
                          line: 801
                          upvalues:
                            u59 (copy, index: 1)
                            u57 (ref,  index: 2)
                            u51 (ref,  index: 3)
                            State_upv_1 (copy, index: 4)
                            u53 (copy, index: 5)
                        ]]
                        local v32 = -1
                        while u59 == u57 and (u51) do
                            local v33 = State_upv_1.Get("Queued") == true
                            if not (v33) then
                                break
                            end
                            local v34 = tonumber(State_upv_1.Get("QueuedAt")) or (State_upv_1.Now())
                            local v35 = math.max(0, math.floor(State_upv_1.Now() - v34))
                            if v35 ~= v32 then
                                u53:SetText(string.format("SEARCHING  %d:%02d", v35 // 60, v35 % 60))
                                v32 = v35
                            end
                            task.wait(0.2)
                        end
                    end
                )
            end
        elseif u58 then
            task.delay(
                2,
                function()
                    --[[
                      line: 816
                      upvalues:
                        u59 (copy, index: 1)
                        u57 (ref,  index: 2)
                        u51 (ref,  index: 3)
                        u58 (ref,  index: 4)
                        State_upv_1 (copy, index: 5)
                        LocalPlayer_upv_1 (copy, index: 6)
                        u53 (copy, index: 7)
                        u54 (copy, index: 8)
                    ]]
                    if u59 ~= u57 or not u51 then
                        return
                    end
                    if u58 then
                        local v36 = State_upv_1.Get("Queued") == true
                        if (v36) or LocalPlayer_upv_1:GetAttribute("Teleporting") == true then
                            return
                        end
                        u58 = false
                        u53:SetText("PLAY AGAIN")
                        u54.Instance.Visible = false
                    end
                end
            )
        end
    end
    State_upv_1.AttrChanged:Connect(
        function(a5)
            --[[
              line: 825
              upvalues:
                paintSearch (copy, index: 1)
            ]]
            if a5 ~= "Queued" and a5 ~= "QueueFound" then
                return
            end
            paintSearch()
        end
    )
    local function playAgain(a6)
        --[[
          name: playAgain
          line: 831
          upvalues:
            u50 (ref,  index: 1)
            u58 (ref,  index: 2)
            u56 (ref,  index: 3)
            u54 (copy, index: 4)
            u53 (copy, index: 5)
            a1 (copy, index: 6)
            UI_upv_1 (copy, index: 7)
            u51 (ref,  index: 8)
            State_upv_1 (copy, index: 9)
            LocalPlayer_upv_1 (copy, index: 10)
            u52 (ref,  index: 11)
        ]]
        if (u50) then
            return
        end
        if not (u58) then
            u56 = u56 + 1
            u54.Instance.Visible = u58
            u50 = true
            u53:SetText("JOINING\226\128\166")
            local v37 = a1.QueueAction("PlayAgain", "results", UI_upv_1.PressKind(a6, u53.Instance))
            u50 = false
            if v37 then
                u58 = true
                u54.Instance.Visible = true
                task.delay(
                    10,
                    function()
                        --[[
                          line: 847
                          upvalues:
                            u58 (ref,  index: 1)
                            u51 (ref,  index: 2)
                            State_upv_1 (copy, index: 3)
                            LocalPlayer_upv_1 (copy, index: 4)
                            u52 (ref,  index: 5)
                        ]]
                        if not u58 then
                            return
                        end
                        if u51 then
                            local v38 = State_upv_1.Get("Queued") == true
                            if (v38) or LocalPlayer_upv_1:GetAttribute("Teleporting") == true then
                                return
                            end
                            u58 = false
                            u52()
                        end
                    end
                )
            else
                u53:SetText("PLAY AGAIN")
            end
        end
    end
    local function startCountdown(a7)
        --[[
          name: startCountdown
          line: 857
          upvalues:
            u56 (ref,  index: 1)
            u54 (copy, index: 2)
            u58 (ref,  index: 3)
            State_upv_1 (copy, index: 4)
            playAgain (copy, index: 5)
            u53 (copy, index: 6)
            UI_upv_1 (copy, index: 7)
        ]]
        u56 = u56 + 1
        u54.Instance.Visible = u58
        if type(a7) ~= "number" then
            a7 = State_upv_1.Now() + 12
        end
        local u60 = u56
        u54.Instance.Visible = true
        task.spawn(
            function()
                --[[
                  line: 864
                  upvalues:
                    u60 (copy, index: 1)
                    u56 (ref,  index: 2)
                    a7 (ref,  index: 3)
                    State_upv_1 (copy, index: 4)
                    playAgain (copy, index: 5)
                    u53 (copy, index: 6)
                    UI_upv_1 (copy, index: 7)
                ]]
                local v39 = -1
                v39 = nil
                while u60 == u56 do
                    local v40 = math.ceil(a7 - State_upv_1.Now())
                    if v40 <= 0 then
                        playAgain()
                        return
                    end
                    if v40 == v39 then
                        task.wait(0.1)
                        continue
                    end
                    u53:SetText("PLAY AGAIN  " .. v40)
                    if v40 <= 3 then
                        UI_upv_1.Bump(u53.Label, 0.12)
                    end
                    v39 = v40
                    task.wait(0.1)
                end
            end
        )
    end
    u53.Activated:Connect(playAgain)
    local function onCancel()
        --[[
          name: onCancel
          line: 884
          upvalues:
            u50 (ref,  index: 1)
            u58 (ref,  index: 2)
            a1 (copy, index: 3)
            u53 (copy, index: 4)
            u54 (copy, index: 5)
            u56 (ref,  index: 6)
        ]]
        if u50 then
            return
        end
        if u58 then
            u50 = true
            local v41, v42 = a1.QueueAction("CancelPlayAgain")
            u50 = false
            if v41 then
                u58 = false
                u53:SetText("PLAY AGAIN")
                u54.Instance.Visible = false
            else
                local Toast_1 = a1.Toast
                local v43
                if type(v42) ~= "string" then
                    v43 = "Too late: the next match is starting"
                else
                    v43 = v42
                end
                Toast_1(v43, "info")
            end
        else
            u56 = u56 + 1
            u54.Instance.Visible = u58
            u53:SetText("PLAY AGAIN")
            u54.Instance.Visible = false
        end
    end
    u54.Activated:Connect(onCancel)
    u46.Activated:Connect(
        function()
            --[[
              line: 906
              upvalues:
                u47 (ref,  index: 1)
                u48 (ref,  index: 2)
                u56 (ref,  index: 3)
                u54 (copy, index: 4)
                u58 (ref,  index: 5)
                u53 (copy, index: 6)
                Economy_upv_1 (copy, index: 7)
                paintRestore (copy, index: 8)
            ]]
            if not u47 or (u48) then
                return
            end
            u56 = u56 + 1
            u54.Instance.Visible = u58
            u53:SetText("PLAY AGAIN")
            Economy_upv_1.Buy(u47.key)
            paintRestore()
        end
    )
    Economy_upv_1.Changed:Connect(paintRestore)
    Economy_upv_1.Event:Connect(
        function(a8, a9)
            --[[
              line: 915
              upvalues:
                u47 (ref,  index: 1)
                u48 (ref,  index: 2)
                paintRestore (copy, index: 3)
                UI_upv_1 (copy, index: 4)
                u46 (copy, index: 5)
            ]]
            if a8 ~= "StreakRestored" then
                return
            end
            if u47 then
                local v44 = tonumber(a9.streak) or (u47.lost)
                u48 = v44
                paintRestore()
                UI_upv_1.Pop(u46.Instance, 1.1)
            end
        end
    )
    u55.Activated:Connect(
        function()
            --[[
              line: 922
              upvalues:
                u50 (ref,  index: 1)
                u56 (ref,  index: 2)
                u54 (copy, index: 3)
                u58 (ref,  index: 4)
                State_upv_1 (copy, index: 5)
                a1 (copy, index: 6)
                u52 (ref,  index: 7)
            ]]
            if u50 then
                return
            end
            u56 = u56 + 1
            u54.Instance.Visible = u58
            if State_upv_1.InMatch() then
                u50 = true
                a1.QueueAction("LeaveMatch")
                u50 = false
            end
            u52()
        end
    )
    local u61 = 0
    local function animateXp(a10, a11)
        --[[
          name: animateXp
          line: 957
          upvalues:
            State_upv_1 (copy, index: 1)
            u16 (copy, index: 2)
            u17 (copy, index: 3)
            u19 (copy, index: 4)
            u20 (copy, index: 5)
            UI_upv_1 (copy, index: 6)
            u61 (ref,  index: 7)
            a1 (copy, index: 8)
            u15 (copy, index: 9)
            u21 (copy, index: 10)
        ]]
        local u62 = tonumber(a10.levelBefore) or (State_upv_1.Level())
        local u63 = tonumber(a10.levelAfter) or u62
        local v45 = tonumber(a10.xpBefore) or 0
        local v46 = tonumber(a10.xpAfter) or 0
        u16.Text = tostring(u62)
        u17.Text = "LEVEL " .. u62
        local function need_1(a12)
            --[[
              name: need
              line: 962
              upvalues:
                u62 (copy, index: 1)
                a10 (copy, index: 2)
                u63 (copy, index: 3)
                State_upv_1 (copy, index: 4)
            ]]
            if a12 == u62 and tonumber(a10.xpToNextBefore) then
                return a10.xpToNextBefore
            elseif a12 == u63 and tonumber(a10.xpToNextAfter) then
                return a10.xpToNextAfter
            else
                return State_upv_1.XpToNext(a12)
            end
        end
        u19.Set(v45 / math.max(1, need_1(u62)), true)
        u20.Text = string.format("%s / %s XP", UI_upv_1.FormatNumber(v45), UI_upv_1.FormatNumber(need_1(u62)))
        task.wait(0.4)
        v45 = u62
        while v45 < u63 and a11 == u61 do
            u19.Set(1, false, TweenInfo.new(0.7, Enum.EasingStyle.Quad))
            u20.Text = string.format("%s / %s XP", UI_upv_1.FormatNumber(need_1(v45)), UI_upv_1.FormatNumber(need_1(v45)))
            a1.Sounds.Play("XP_Tick")
            task.wait(0.72)
            if a11 == u61 then
                v45 = v45 + 1
                u16.Text = tostring(v45)
                u17.Text = "LEVEL " .. v45
                u20.Text = string.format("0 / %s XP", UI_upv_1.FormatNumber(need_1(v45)))
                UI_upv_1.Pop(u15, 1.7)
                u21.Visible = true
                UI_upv_1.Pop(u21, 2)
                a1.Sounds.Play("LevelUp")
                task.delay(
                    1.1,
                    function()
                        --[[
                          line: 992
                          upvalues:
                            a11 (copy, index: 1)
                            u61 (ref,  index: 2)
                            u21 (copy, index: 3)
                        ]]
                        if a11 ~= u61 then
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
        if a11 ~= u61 then
            return
        end
        u19.Set(v46 / math.max(1, need_1(u63)), false, TweenInfo.new(0.8, Enum.EasingStyle.Quad))
        a1.Sounds.Play("XP_Tick")
        u20.Text = string.format("%s / %s XP", UI_upv_1.FormatNumber(v46), UI_upv_1.FormatNumber(need_1(u63)))
    end
    local function paintRank(a13, a14)
        --[[
          name: paintRank
          line: 528
          upvalues:
            Ranks_upv_1 (copy, index: 1)
            RankArt_upv_2 (copy, index: 2)
            u27 (copy, index: 3)
            u28 (copy, index: 4)
            u29 (copy, index: 5)
            u30 (copy, index: 6)
            UI_upv_1 (copy, index: 7)
        ]]
        local v47, v48, v49 = Ranks_upv_1.Progress(a13)
        local v50 = RankArt_upv_2.Color(v47)
        RankArt_upv_2.SetEmblem(u27, v47)
        u28.Text = string.upper(Ranks_upv_1.Get(v47).name)
        u28.TextColor3 = v50
        u29.SetColor(v50)
        u29.Set((v49 and (v48 / v49)) or 1, a14, TweenInfo.new(0.9, Enum.EasingStyle.Quad))
        u30.Text = not v49 and "TOP RANK" or string.format("%s / %s to %s", UI_upv_1.FormatNumber(v48), UI_upv_1.FormatNumber(v49), string.upper(Ranks_upv_1.Get(v47 + 1).name))
    end
    local function animateTrophies(a15, a16)
        --[[
          name: animateTrophies
          line: 1007
          upvalues:
            paintRank (copy, index: 1)
            u35 (copy, index: 2)
            u31 (copy, index: 3)
            Colors_upv_1 (copy, index: 4)
            u33 (copy, index: 5)
            u61 (ref,  index: 6)
            UI_upv_1 (copy, index: 7)
            u34 (ref,  index: 8)
            Ranks_upv_1 (copy, index: 9)
            u29 (copy, index: 10)
            u27 (copy, index: 11)
            a1 (copy, index: 12)
        ]]
        local u64 = tonumber(a15.before) or 0
        local u65 = tonumber(a15.after) or 0
        paintRank(u64, true)
        u35(u64, true)
        local u66 = tonumber(a15.delta) or (u65 - u64)
        local u67 = a15.unranked == true
        local v52
        if u67 then
            v52 = "UNRANKED"
        elseif a15.floor == true and u66 == 0 then
            v52 = "SAFE"
        else
            v52 = ((u66 >= 0) and ("+" .. u66)) or (tostring(u66))
        end
        u31.Text = v52
        u31.TextSize = (u67 and 18) or 26
        local v53
        if u66 > 0 then
            v53 = Colors_upv_1.Success
        elseif u66 < 0 then
            v53 = Colors_upv_1.Danger
        else
            v53 = Colors_upv_1.TextDim
        end
        u31.TextColor3 = v53
        u31.TextTransparency = 1
        u33.Visible = false
        task.delay(
            1.15,
            function()
                --[[
                  line: 1019
                  upvalues:
                    a16 (copy, index: 1)
                    u61 (ref,  index: 2)
                    u31 (copy, index: 3)
                    UI_upv_1 (copy, index: 4)
                    u34 (ref,  index: 5)
                    u67 (copy, index: 6)
                    u33 (copy, index: 7)
                    u35 (copy, index: 8)
                    u65 (copy, index: 9)
                    Ranks_upv_1 (copy, index: 10)
                    u64 (copy, index: 11)
                    u29 (copy, index: 12)
                    paintRank (copy, index: 13)
                    u27 (copy, index: 14)
                    u66 (copy, index: 15)
                    a1 (copy, index: 16)
                ]]
                if a16 ~= u61 then
                    return
                end
                u31.TextTransparency = 0
                UI_upv_1.Pop(u31, 1.6)
                if u34 and not (u67) then
                    task.defer(
                        function()
                            --[[
                              line: 1027
                              upvalues:
                                a16 (copy, index: 1)
                                u61 (ref,  index: 2)
                                u31 (copy, index: 3)
                                u33 (copy, index: 4)
                            ]]
                            if a16 ~= u61 then
                                return
                            end
                            u33.Position = UDim2.new(1, -(math.ceil(u31.TextBounds.X / (((u31.AbsoluteSize.X > 0) and (u31.AbsoluteSize.X / u31.Size.X.Offset)) or 1)) + 8), 0, 2)
                            u33.Visible = true
                        end
                    )
                end
                u35(u65)
                if Ranks_upv_1.RankOf(u65) == Ranks_upv_1.RankOf(u64) then
                    paintRank(u65, false)
                else
                    u29.Set(((u64 < u65) and 1) or 0, false, TweenInfo.new(0.5, Enum.EasingStyle.Quad))
                    task.delay(
                        0.55,
                        function()
                            --[[
                              line: 1039
                              upvalues:
                                a16 (copy, index: 1)
                                u61 (ref,  index: 2)
                                paintRank (copy, index: 3)
                                u65 (copy, index: 4)
                                u29 (copy, index: 5)
                                UI_upv_1 (copy, index: 6)
                                u27 (copy, index: 7)
                            ]]
                            if a16 ~= u61 then
                                return
                            end
                            paintRank(u65, true)
                            u29.Set(0, true)
                            paintRank(u65, false)
                            UI_upv_1.Pop(u27, 1.4)
                        end
                    )
                end
                if u66 > 0 then
                    a1.Sounds.Play("Coin")
                end
            end
        )
    end
    local u68 = 0
    local function layoutRows(a17)
        --[[
          name: layoutRows
          line: 246
          upvalues:
            u9 (copy, index: 1)
            tbl_upv_3 (copy, index: 2)
            u10 (copy, index: 3)
        ]]
        local v54 = (a17 and 84) or 54
        local v55 = (a17 and 66) or 44
        local v56 = math.floor((((u9.Size.Y.Offset - 42) - 12) - 212) / 2) + 42
        local v57 = nil
        local v58 = nil
        for key_2, value_4 in tbl_upv_3 do
            if a17 then
                if key_2 <= 3 then
                    v57 = v56
                else
                    v57 = v56 + 84 + 44
                end
            else
                v57 = ((key_2 - 1) * 60) + 42 + (((key_2 > 3) and 10) or 0)
            end
            value_4.frame.Position = UDim2.fromOffset(12, v57)
            value_4.frame.Size = UDim2.new(1, -24, 0, v54)
            value_4.img.Size = UDim2.fromOffset(v55, v55)
            local img_1 = value_4.img
            img_1.Position = UDim2.fromOffset((a17 and 9) or 6, math.floor((v54 - v55) / 2))
            local name_1 = value_4.name
            name_1.Position = UDim2.fromOffset(v55 + ((a17 and 22) or 16), 0)
            local name_2 = value_4.name
            name_2.Size = UDim2.fromOffset((a17 and 226) or 250, v54)
            value_4.name.TextSize = (a17 and 27) or 22
            for _, value_5 in value_4.cells do
                value_5.Size = UDim2.fromOffset(70, v54)
                value_5.TextSize = (a17 and 30) or 24
            end
            v57 = (a17 and 30) or 24
            value_4.rankPip.Size = UDim2.fromOffset(v57, v57)
            local rankPip_1 = value_4.rankPip
            if a17 then
                v58 = UDim2.fromOffset(((v55 + 9) - v57) + 6, ((math.floor((v54 - v55) / 2) + v55) - v57) + 4)
            else
                v58 = UDim2.fromOffset(32, 30)
            end
            rankPip_1.Position = v58
        end
        u10.Visible = a17
        u10.Position = UDim2.new(0.5, 0, 0, (v56 + 84) + 22)
    end
    local function memberRow(a18, a19, a20, a21)
        --[[
          name: memberRow
          line: 936
          upvalues:
            Portraits_upv_1 (copy, index: 1)
            RankArt_upv_1 (copy, index: 2)
            State_upv_1 (copy, index: 3)
            Colors_upv_1 (copy, index: 4)
            Theme_upv_1 (copy, index: 5)
            UI_upv_1 (copy, index: 6)
        ]]
        a18.frame.Visible = a19 ~= nil
        if not a19 then
            return
        end
        Portraits_upv_1.Apply(a18.img, a19, 60)
        RankArt_upv_1.SetEmblem(a18.rankPip, RankArt_upv_1.Ranks.RankOf(tonumber(a19.trophies) or 0))
        local name_3 = a18.name
        local v59
        if type(a19.tribe) == "table" and type(a19.tribe.tag) == "string" then
            v59 = "[" .. a19.tribe.tag .. "] "
        else
            v59 = ""
        end
        name_3.Text = v59 .. tostring(a19.name or "?")
        local v60 = a19.id == State_upv_1.MyId()
        local name_4 = a18.name
        local v61
        if v60 then
            v61 = Colors_upv_1.Accent
        elseif a20 then
            v61 = Theme_upv_1.Lighten(Colors_upv_1.Ally, 0.2)
        else
            v61 = Theme_upv_1.Lighten(Colors_upv_1.Enemy, 0.15)
        end
        name_4.TextColor3 = v61
        a18.stroke.Enabled = v60
        a18.inner.BackgroundTransparency = (v60 and 0.25) or 0.45
        a18.star.Visible = (a21 ~= false) and ((a21 ~= nil) and (a19.id == a21))
        a18.cells[1].Text = tostring(a19.kills or 0)
        a18.cells[2].Text = tostring(a19.deaths or 0)
        a18.cells[3].Text = tostring(a19.assists or 0)
        a18.cells[4].Text = UI_upv_1.FormatNumber(a19.damage or 0)
    end
    local function padDefault()
        --[[
          name: padDefault
          line: 750
          upvalues:
            u53 (copy, index: 1)
            u54 (copy, index: 2)
            u55 (copy, index: 3)
        ]]
        for _, value_6 in {u53, u54, u55} do
            if not (value_6.Instance.Visible) then
                continue
            end
            return value_6.Instance
        end
        return nil
    end
    local function paintPips(a22, a23, a24)
        --[[
          name: paintPips
          line: 120
          upvalues:
            u8 (copy, index: 1)
            Colors_upv_1 (copy, index: 2)
            UI_upv_1 (copy, index: 3)
        ]]
        u8:ClearAllChildren()
        local v62, v63 = nil, nil
        for n_4 = 1, 2 do
            if n_4 ~= 1 then
                v62 = a23
            else
                v62 = a22
            end
            local v64
            if n_4 ~= 1 then
                v64 = Colors_upv_1.Enemy
            else
                v64 = Colors_upv_1.Ally
            end
            for n_5 = 1, a24 do
                local new_2 = UI_upv_1.new
                local v65 = "Frame"
                local tbl_10 = {}
                tbl_10.AnchorPoint = Vector2.new(0.5, 0)
                tbl_10.Position = UDim2.new(0.5, ((n_4 ~= 1) and ((n_5 - 1) * 22 + 30)) or (-30 - (n_5 - 1) * 22), 0, 0)
                tbl_10.Size = UDim2.fromOffset(18, 10)
                if n_5 <= v62 then
                    v63 = v64
                else
                    v63 = Color3.fromRGB(52, 56, 68)
                end
                tbl_10.BackgroundColor3 = v63
                tbl_10[1] = UI_upv_1.Corner(3)
                tbl_10.Parent = u8
                new_2(v65, tbl_10)
            end
        end
    end
    local function show(a25)
        --[[
          name: show
          line: 1057
          upvalues:
            State_upv_1 (copy, index: 1)
            u6 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            layoutRows (copy, index: 4)
            u5 (copy, index: 5)
            u34 (ref,  index: 6)
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
            u47 (ref,  index: 20)
            u48 (ref,  index: 21)
            u44 (copy, index: 22)
            a1 (copy, index: 23)
            u45 (copy, index: 24)
            u46 (copy, index: 25)
            paintRestore (copy, index: 26)
            paintDrop (copy, index: 27)
            u43 (ref,  index: 28)
            u37 (copy, index: 29)
            u36 (copy, index: 30)
            u18 (copy, index: 31)
            u22 (copy, index: 32)
            u23 (copy, index: 33)
            u25 (copy, index: 34)
            Fonts_upv_1 (copy, index: 35)
            u24 (copy, index: 36)
            u51 (ref,  index: 37)
            u61 (ref,  index: 38)
            u50 (ref,  index: 39)
            u58 (ref,  index: 40)
            u53 (copy, index: 41)
            u54 (copy, index: 42)
            paintSearch (copy, index: 43)
            u55 (copy, index: 44)
            u68 (ref,  index: 45)
            u26 (copy, index: 46)
            u19 (copy, index: 47)
            u20 (copy, index: 48)
            u16 (copy, index: 49)
            u17 (copy, index: 50)
            u2 (copy, index: 51)
            u1 (copy, index: 52)
            padDefault (copy, index: 53)
            startCountdown (copy, index: 54)
            u3 (copy, index: 55)
            u9 (copy, index: 56)
            u49 (copy, index: 57)
            animateXp (copy, index: 58)
            animateTrophies (copy, index: 59)
            tbl_upv_7 (copy, index: 60)
        ]]
        local key_4
        local v66 = State_upv_1.Match
        local u69 = ((type(a25.you) == "table") and (a25.you)) or {}
        local u70 = true
        if a25.custom ~= true then
            u70 = u69.custom == true
        end
        local u71 = u70 or (a25.lobbyOnly == true)
        local u72 = State_upv_1.MyTeam()
        local v67
        if u69.won == nil then
            v67 = a25.winnerTeam == u72
        else
            v67 = u69.won == true
        end
        local v68 = a25.winnerTeam == 0
        local v69
        if v68 then
            v69 = "DRAW"
        else
            v69 = (v67 and "VICTORY") or "DEFEAT"
        end
        u6.Text = v69
        local v70
        if v68 then
            v70 = Colors_upv_1.Bone
        elseif v67 then
            v70 = Colors_upv_1.Accent
        else
            v70 = Colors_upv_1.Enemy
        end
        u6.TextColor3 = v70
        v68 = (v66 ~= nil) and (State_upv_1.TeamSize(v66.teams) == 1)
        v67 = true
        if a25.mode ~= "1v1" then
            v67 = v68 and (State_upv_1.IsDuel() or (not u70))
        end
        layoutRows(v68)
        u5.Visible = v67
        u34 = v67
        if v66 then
            local v71 = v66.teams[u72]
            local v72 = v66.teams[3 - u72]
            local v73
            if v67 then
                v73 = string.format("YOU   %d  -  %d   OPPONENT", v71.score or 0, v72.score or 0)
            else
                v73 = string.format("YOUR TEAM   %d  -  %d   ENEMY TEAM", v71.score or 0, v72.score or 0)
            end
            u7.Text = v73
            placeModeTag()
            paintPips(v71.score or 0, v72.score or 0, (math.clamp(v66.roundsToWin or (State_upv_1.DEFAULT_ROUNDS_TO_WIN), 1, 9)))
        else
            u7.Text = ""
        end
        for key_3, value_7 in {u72, 3 - u72} do
            local tbl_11 = {}
            if v66 then
                for _, value_8 in v66.teams[value_7].members do
                    table.insert(tbl_11, value_8)
                end
            end
            table.sort(
                tbl_11,
                function(a26, a27)
                    --[[
                      line: 1093
                    ]]
                    if (a26.kills or 0) == (a27.kills or 0) then
                        return (a27.damage or 0) < (a26.damage or 0)
                    end
                    return (a27.kills or 0) < (a26.kills or 0)
                end
            )
            for n_6 = 1, 3 do
                memberRow(tbl_upv_3[((key_3 - 1) * 3) + n_6], tbl_11[n_6], key_3 == 1, a25.mvpId)
            end
        end
        local tribe_upv_1, v74 = State_upv_1.FindMember(a25.mvpId)
        u11.Visible = tribe_upv_1 ~= nil
        if tribe_upv_1 then
            Portraits_upv_1.Apply(u12, tribe_upv_1, 150)
            u13.Text = tostring(tribe_upv_1.name)
            local v75
            if tribe_upv_1.id ~= State_upv_1.MyId() then
                State_upv_1.IsAllyTeam(v74)
            end
            v75 = Colors_upv_1.Accent
            u13.TextColor3 = v75
            tbl_upv_6.Text = string.format("%d ELIMS  \194\183  %d DEATHS  \194\183  %s DMG", tribe_upv_1.kills or 0, tribe_upv_1.deaths or 0, UI_upv_1.FormatNumber(tribe_upv_1.damage or 0))
        end
        u14.Position = UDim2.fromOffset(0, (tribe_upv_1 and 130) or 0)
        local u73 = ((type(u69.drop) == "table" and type(u69.drop.stacks) == "table") and (u69.drop)) or nil
        tribe_upv_1 = ((type(u69.streakLost) == "table") and (u69.streakLost)) or nil
        local v76
        if tribe_upv_1 and type(tribe_upv_1.lost) == "number" and type(tribe_upv_1.key) == "string" then
            v76 = tribe_upv_1
        else
            v76 = nil
        end
        u47 = v76
        u48 = nil
        local v77 = true
        if u47 == nil then
            v77 = (tribe_upv_1 ~= nil) and (type(tribe_upv_1.credited) == "number")
        end
        u44.Visible = v77
        if (tribe_upv_1) and type(tribe_upv_1.credited) == "number" then
            a1.Loc.Rich(u45, string.format("<font color=\"#FFC478\">%d</font> WIN STREAK KEPT<br/><font size=\"13\" color=\"#8C93A5\">Your saved streak restore was used</font>", tribe_upv_1.credited))
            u46.Instance.Visible = false
        else
            u46.Instance.Visible = true
        end
        paintRestore()
        if u73 then
            paintDrop(u73)
        else
            u43 = nil
            u37.Visible = false
        end
        u37.Size = UDim2.fromOffset(((u44.Visible) and 700) or 1200, 58)
        u36.Visible = u37.Visible or (u44.Visible)
        v77 = (u70 and "") or ("+" .. UI_upv_1.FormatNumber(tonumber(u69.xp) or 0) .. " XP")
        u18.Text = v77
        tribe_upv_1 = tonumber(u69.streak) or 0
        u22.Visible = tribe_upv_1 >= 2
        u23.Text = tribe_upv_1 .. " WIN STREAK"
        for key_4, value_9 in u25:GetChildren() do
            if value_9:IsA("GuiObject") then
                value_9:Destroy()
            end
        end
        if type(u69.lines) == "table" then
            for key_5, value_10 in u69.lines do
                if key_5 > 8 then
                    break
                end
                if type(value_10) == "table" then
                    UI_upv_1.new("TextLabel", {TextSize = 15, Text = string.format("%s  +%d XP", tostring(value_10.label or ""), tonumber(value_10.xp) or 0), FontFace = Fonts_upv_1.SemiBold, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, LayoutOrder = key_5, Parent = u25})
                end
            end
        end
        tribe_upv_1 = u69.tribe
        u24.Visible = false
        if type(tribe_upv_1) == "table" and type(tribe_upv_1.tag) == "string" then
            if tribe_upv_1.split then
                v67 = string.format("[%s]  no Glory: tribemates on both teams", tribe_upv_1.tag)
            else
                local format_1 = string.format
                local tag_1 = tribe_upv_1.tag
                key_4 = tonumber(tribe_upv_1.renown) or 0
                local v78
                if (tonumber(tribe_upv_1.mates) or 1) > 1 then
                    v78 = string.format("  (x%s with tribemates)", ((tribe_upv_1.mates >= 3) and "2") or "1.5")
                else
                    v78 = ""
                end
                v67 = format_1("[%s]  +%d Glory%s", tag_1, key_4, v78)
            end
            u24.Text = v67
            u24.Visible = not u70
        end
        u51 = true
        u61 = u61 + 1
        tribe_upv_1 = u61
        a1.SetHudHidden("MatchEnd", true)
        a1.MenuManager.PushMouse("MatchEnd")
        u50 = false
        u58 = false
        u53:SetText("PLAY AGAIN")
        u54.Instance.Visible = false
        u53.Instance.Visible = not u71
        local v79 = State_upv_1.Get("Queued") == true
        if v79 then
            paintSearch()
        end
        u55:SetStyle((u71 and "Primary") or "Dark")
        local Instance_1 = u55.Instance
        Instance_1.Size = UDim2.fromOffset((u71 and 320) or 220, 80)
        u55:SetText("LOBBY")
        u68 = u68 + 1
        local _ = u70 or type(u69.trophies) ~= "table" or u69.trophies
        if u72 ~= nil then
            v77 = true
        else
            v77 = false
        end
        u26.Visible = v77
        local v80 = 98
        if u72 then
            u26.Position = UDim2.fromOffset(16, v80)
            v66 = v80 + 44
        else
            v66 = v80
        end
        u22.Position = UDim2.fromOffset(16, v66 + 2)
        u24.Position = UDim2.new(1, -16, 0, v66 + 4)
        if u22.Visible or u24.Visible then
            v66 = v80 + 46
        else
            v66 = v80
        end
        local v81 = v66 + 4
        u25.Position = UDim2.fromOffset(16, v81)
        local v82 = 0
        for v87, value_11 in u25:GetChildren() do
            v82 = (value_11:IsA("TextLabel") and (v82 + 1)) or v82
        end
        v77 = math.max(1, math.ceil(v82 / 2))
        local v83 = math.clamp(math.floor((((290 - v81) - 10) - ((v77 - 1) * 3)) / v77), 16, 22)
        v66 = ((v83 >= 20) and 3) or 2
        local Grid_1 = u25:FindFirstChild("Grid")
        if Grid_1 then
            Grid_1.CellSize = UDim2.new(0.5, -6, 0, v83)
            Grid_1.CellPadding = UDim2.fromOffset(12, v66)
        end
        for v88, value_12 in u25:GetChildren() do
            if value_12:IsA("TextLabel") then
                value_12.TextSize = math.min(15, v83 - 3)
            end
        end
        u25.Size = UDim2.new(1, -32, 0, v77 * (v83 + v66))
        u14.Size = UDim2.fromOffset(480, (u70 and 106) or 290)
        u19.Frame.Visible = not u70
        u20.Position = UDim2.fromOffset(100, (u70 and 52) or 74)
        u20.TextSize = (u70 and 16) or 15
        if u70 then
            local v84 = tonumber(u69.levelAfter) or (State_upv_1.Level())
            u16.Text = tostring(v84)
            u17.Text = "CUSTOM MATCH"
            local v85 = a1.Custom and (a1.Custom.State())
            u20.AutoLocalize = false
            local v86
            if type(v85) == "table" and type(v85.name) == "string" then
                v86 = v85.name
            else
                v86 = ""
            end
            u20.Text = v86
        end
        local function openResults_upv_1(a28)
            --[[
              name: openResults
              line: 1250
              upvalues:
                tribe_upv_1 (copy, index: 1)
                u61 (ref,  index: 2)
                u51 (ref,  index: 3)
                u2 (copy, index: 4)
                u1 (copy, index: 5)
                UI_upv_1 (copy, index: 6)
                Theme_upv_1 (copy, index: 7)
                a1 (copy, index: 8)
                padDefault (copy, index: 9)
                u71 (copy, index: 10)
                u68 (ref,  index: 11)
                a25 (copy, index: 12)
                State_upv_1 (copy, index: 13)
                u55 (copy, index: 14)
                u69 (copy, index: 15)
                u58 (ref,  index: 16)
                startCountdown (copy, index: 17)
                u3 (copy, index: 18)
                u6 (copy, index: 19)
                u7 (copy, index: 20)
                u9 (copy, index: 21)
                u11 (copy, index: 22)
                u14 (copy, index: 23)
                tbl_upv_3 (copy, index: 24)
                u49 (copy, index: 25)
                u22 (copy, index: 26)
                u70 (copy, index: 27)
                animateXp (copy, index: 28)
                u72 (copy, index: 29)
                animateTrophies (copy, index: 30)
                u36 (copy, index: 31)
                tbl_upv_7 (copy, index: 32)
            ]]
            if tribe_upv_1 ~= u61 or not u51 then
                return
            end
            u2.Visible = true
            u1.Visible = true
            u1.BackgroundTransparency = 1
            UI_upv_1.Tween(u1, Theme_upv_1.Tween.Slow, {BackgroundTransparency = 0.25})
            a1.MenuManager.PushFocus("MatchEnd", padDefault)
            if u71 then
                local u74 = u68
                local num_upv_2 = tonumber(a25.closesAt)
                if num_upv_2 then
                    task.spawn(
                        function()
                            --[[
                              line: 1264
                              upvalues:
                                u74 (copy, index: 1)
                                u68 (ref,  index: 2)
                                u51 (ref,  index: 3)
                                num_upv_2 (copy, index: 4)
                                State_upv_1 (copy, index: 5)
                                u55 (copy, index: 6)
                            ]]
                            local v88 = -1
                            while u74 == u68 and (u51) do
                                local v89 = math.ceil(num_upv_2 - State_upv_1.Now())
                                if v89 <= 0 then
                                    break
                                end
                                if v89 ~= v88 then
                                    u55:SetText("LOBBY  " .. v89)
                                    v88 = v89
                                end
                                task.wait(0.1)
                            end
                        end
                    )
                end
            elseif u69.inactive ~= true then
                local num_3 = tonumber(a25.autoRequeueAt)
                if a28 then
                    num_3 = math.max(num_3 or 0, State_upv_1.Now() + 15)
                    if type(a25.closesAt) == "number" then
                        num_3 = math.min(num_3, a25.closesAt - 3)
                    end
                end
                if not (u58) then
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
            UI_upv_1.Enter(u49, Vector2.new(0, 30), 0.8)
            task.delay(
                1,
                function()
                    --[[
                      line: 1304
                      upvalues:
                        tribe_upv_1 (copy, index: 1)
                        u61 (ref,  index: 2)
                        u22 (copy, index: 3)
                        UI_upv_1 (copy, index: 4)
                    ]]
                    if tribe_upv_1 ~= u61 then
                        return
                    end
                    if u22.Visible then
                        UI_upv_1.Pop(u22, 1.5)
                    end
                end
            )
            task.delay(
                0.9,
                function()
                    --[[
                      line: 1312
                      upvalues:
                        tribe_upv_1 (copy, index: 1)
                        u61 (ref,  index: 2)
                        u70 (copy, index: 3)
                        animateXp (copy, index: 4)
                        u69 (copy, index: 5)
                    ]]
                    if tribe_upv_1 ~= u61 or (u70) then
                        return
                    end
                    animateXp(u69, tribe_upv_1)
                end
            )
            if u72 then
                animateTrophies(u72, tribe_upv_1)
            end
            if u36.Visible then
                UI_upv_1.Enter(u36, Vector2.new(0, 20), 0.7)
                for key_7, value_14 in tbl_upv_7 do
                    if value_14.frame.Visible then
                        local v90 = UI_upv_1.GetScaleObj(value_14.frame)
                        v90.Scale = 0
                        local tbl_12 = {Scale = 1}
                        UI_upv_1.Tween(v90, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, (key_7 * 0.06) + 0.8), tbl_12)
                    end
                end
            end
        end
        u2.Visible = false
        u1.Visible = false
        local DropReveal_upv_2 = a1.DropReveal
        if type(u69.rankDrop) == "table" and type(u69.rankDrop.stacks) == "table" then
            v66 = u69.rankDrop
        else
            v66 = nil
        end
        local v86 = false
        local function playMatchDrop_upv_1()
            --[[
              name: playMatchDrop
              line: 1337
              upvalues:
                u73 (copy, index: 1)
                DropReveal_upv_2 (copy, index: 2)
                openResults_upv_1 (copy, index: 3)
            ]]
            local v91 = false
            if u73 ~= nil then
                v91 = false
                if DropReveal_upv_2 ~= nil then
                    local tbl_13 = {source = "match"}
                    function tbl_13.onDone()
                        --[[
                          name: onDone
                          line: 1340
                          upvalues:
                            openResults_upv_1 (copy, index: 1)
                        ]]
                        openResults_upv_1(true)
                    end
                    v91 = DropReveal_upv_2.Play(u73, tbl_13)
                end
            end
            return v91
        end
        if v66 ~= nil then
            v86 = false
            if DropReveal_upv_2 ~= nil then
                local tbl_14 = {source = "match"}
                function tbl_14.onDone(a29)
                    --[[
                      name: onDone
                      line: 1347
                      upvalues:
                        playMatchDrop_upv_1 (copy, index: 1)
                        openResults_upv_1 (copy, index: 2)
                    ]]
                    if a29 ~= "interrupted" and playMatchDrop_upv_1() then
                        return
                    end
                    openResults_upv_1(true)
                end
                v86 = DropReveal_upv_2.Play(v66, tbl_14)
            end
        end
        if not (v86) then
            v86 = playMatchDrop_upv_1()
        end
        if (v86) then
            return
        end
        openResults_upv_1(false)
    end
    u52 = function(a30)
        --[[
          line: 1362
          upvalues:
            u51 (ref,  index: 1)
            u58 (ref,  index: 2)
            u57 (ref,  index: 3)
            u61 (ref,  index: 4)
            u68 (ref,  index: 5)
            u56 (ref,  index: 6)
            u54 (copy, index: 7)
            a1 (copy, index: 8)
            u2 (copy, index: 9)
            u1 (copy, index: 10)
            UI_upv_1 (copy, index: 11)
            Theme_upv_1 (copy, index: 12)
            u3 (copy, index: 13)
        ]]
        if not u51 then
            return
        end
        u51 = false
        u58 = false
        u57 = u57 + 1
        u61 = u61 + 1
        u68 = u68 + 1
        u56 = u56 + 1
        u54.Instance.Visible = u58
        a1.SetHudHidden("MatchEnd", false)
        a1.MenuManager.PopMouse("MatchEnd")
        a1.MenuManager.PopFocus("MatchEnd")
        if a30 then
            u2.Visible = false
            u1.Visible = false
        else
            UI_upv_1.Tween(u1, Theme_upv_1.Tween.Close, {BackgroundTransparency = 1})
            UI_upv_1.FadeOut(u3, TweenInfo.new(0.2))
            task.delay(
                0.22,
                function()
                    --[[
                      line: 1382
                      upvalues:
                        u51 (ref,  index: 1)
                        u2 (copy, index: 2)
                        u1 (copy, index: 3)
                    ]]
                    if (u51) then
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
                      line: 1390
                      upvalues:
                        u51 (ref,  index: 1)
                        UI_upv_1 (copy, index: 2)
                        u3 (copy, index: 3)
                    ]]
                    if (u51) then
                        return
                    end
                    UI_upv_1.Unfade(u3)
                end
            )
        end
    end
    UI_upv_1.Unfade(u3)
    for v15, value_15 in {u7, u9, u11, u14, u49, u36} do
        UI_upv_1.Unfade(value_15)
    end
    a1.OnMatchEvent(
        function(a31, a32)
            --[[
              line: 1403
              upvalues:
                LocalPlayer_upv_1 (copy, index: 1)
                show (copy, index: 2)
                u52 (ref,  index: 3)
            ]]
            if a31 == "MatchEnd" and type(a32) == "table" then
                local u75 = LocalPlayer_upv_1:GetAttribute("MatchId")
                task.delay(
                    1.2,
                    function()
                        --[[
                          line: 1408
                          upvalues:
                            LocalPlayer_upv_1 (copy, index: 1)
                            u75 (copy, index: 2)
                            show (copy, index: 3)
                            a32 (copy, index: 4)
                        ]]
                        local v92 = 0
                        while LocalPlayer_upv_1:GetAttribute("ReplayPlaying") == true do
                            if v92 < 40 then
                                v92 = v92 + task.wait(0.1)
                                continue
                            else
                                break
                            end
                        end
                        if (not (v92 > 0) or LocalPlayer_upv_1:GetAttribute("State") == "Match") and LocalPlayer_upv_1:GetAttribute("MatchId") == u75 then
                            show(a32)
                        end
                    end
                )
                return
            end
            if a31 ~= "MatchStart" then
                return
            end
            u52(true)
        end
    )
    State_upv_1.AttrChanged:Connect(
        function(a33)
            --[[
              line: 1427
              upvalues:
                u51 (ref, index: 1)
                u52 (ref, index: 2)
            ]]
            if not u51 or a33 ~= "MatchId" then
                return
            end
            u52(true)
        end
    )
    State_upv_1.PlayerStateChanged:Connect(
        function(a34)
            --[[
              line: 1432
              upvalues:
                u51 (ref, index: 1)
                u52 (ref, index: 2)
            ]]
            if not u51 or a34 ~= "Lobby" then
                return
            end
            u52()
        end
    )
    a1.Debug.matchEndCancel = function()
        --[[
          line: 1439
          upvalues:
            onCancel (copy, index: 1)
            u53 (copy, index: 2)
            u54 (copy, index: 3)
            u58 (ref,  index: 4)
        ]]
        onCancel()
        local tbl_15 = {}
        tbl_15.again = u53.Label.Text
        tbl_15.cancel = u54.Instance.Visible
        tbl_15.joining = u58
        return tbl_15
    end
    a1.Debug.matchEndClose = function()
        --[[
          line: 1443
          upvalues:
            u52 (ref, index: 1)
        ]]
        u52()
        return true
    end
end
return tbl_1